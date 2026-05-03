param(
    [string]$PublishedSource = "claude/skills",
    [string]$FutureSource = "..\solo-builders-toolkit-future-weeks\skills",
    [string]$OutputRoot = "codex",
    [switch]$Force
)

$ErrorActionPreference = "Stop"

function Resolve-RepoPath([string]$Path) {
    return [System.IO.Path]::GetFullPath((Join-Path (Get-Location) $Path))
}

function Convert-ToTitle([string]$Name) {
    return (($Name -split "-") | ForEach-Object {
        if ($_.Length -eq 0) { $_ } else { $_.Substring(0, 1).ToUpperInvariant() + $_.Substring(1) }
    }) -join " "
}

function Escape-YamlDoubleQuoted([string]$Value) {
    return ($Value -replace "\\", "\\" -replace '"', '\"')
}

function Get-SkillFrontmatter([string]$SkillMd) {
    $content = Get-Content -Raw $SkillMd
    if ($content -notmatch '(?ms)^---\s*(.*?)\s*---') {
        throw "Missing YAML frontmatter: $SkillMd"
    }

    $frontmatter = $Matches[1]
    $name = [regex]::Match($frontmatter, '(?m)^name:\s*(.+?)\s*$').Groups[1].Value.Trim().Trim('"')
    $description = [regex]::Match($frontmatter, '(?ms)^description:\s*(.+?)(?:\r?\n\w[\w-]*:|\z)').Groups[1].Value.Trim().Trim('"')

    return @{
        Name = $name
        Description = ($description -replace '\s+', ' ')
    }
}

function Convert-MarkdownForCodex([string]$Text, [string]$SkillName) {
    $converted = $Text

    # Codex convention: use references/ for progressive disclosure resources.
    $converted = $converted -replace 'reference/', 'references/'
    $converted = $converted -replace '`reference/`', '`references/`'

    # Replace Claude-specific invocation framing with skill/workflow framing.
    $converted = $converted -replace 'Claude Code slash command', 'Codex skill'
    $converted = $converted -replace 'Claude Code skills', 'Codex skills'
    $converted = $converted -replace 'slash-command arguments', 'details from the user request'
    $converted = $converted -replace 'slash command arguments', 'details from the user request'
    $converted = $converted -replace 'slash-command syntax', 'skill-reference syntax'
    $converted = $converted -replace 'slash commands', 'skills'
    $converted = $converted -replace 'slash-command', 'skill trigger'
    $converted = $converted -replace 'slash command', 'skill trigger'
    $converted = $converted -replace 'Invoke via', 'Use via'

    # Turn `/skill-name` references into Codex-friendly skill references.
    $converted = [regex]::Replace($converted, '`/([a-z][a-z0-9-]+)(\s+[^`]*)`', '`${1}${2}` skill input')
    $converted = [regex]::Replace($converted, '`/([a-z][a-z0-9-]+)`', '`${1}` skill')
    $converted = [regex]::Replace($converted, '"/([a-z][a-z0-9-]+)([^"]*)"', '"${1}${2}"')
    $converted = [regex]::Replace($converted, '(^|\s)/([a-z][a-z0-9-]+)\b', '$1$2 skill', 'Multiline')
    $converted = $converted -replace '# /pm', '# PM'

    # Map Claude tool names to portable Codex/tool-available wording.
    $converted = $converted -replace 'Chrome MCP tools?: `mcp__Claude_in_Chrome__navigate` to the URL, then `mcp__Claude_in_Chrome__get_page_text` or `mcp__Claude_in_Chrome__read_page` to extract content', 'available browser automation tools to open the URL and extract page content'
    $converted = $converted -replace 'Chrome \(`mcp__Claude_in_Chrome__navigate`\)', 'available browser automation'
    $converted = $converted -replace '`mcp__Claude_in_Chrome__navigate`', 'available browser navigation tool'
    $converted = $converted -replace '`mcp__Claude_in_Chrome__get_page_text`', 'available browser page-text tool'
    $converted = $converted -replace '`mcp__Claude_in_Chrome__read_page`', 'available browser page-read tool'
    $converted = $converted -replace 'Chrome MCP', 'available browser automation'
    $converted = $converted -replace 'WebFetch/WebSearch', 'web fetch/search tools'
    $converted = $converted -replace 'WebFetch', 'web fetch tool'
    $converted = $converted -replace 'WebSearch', 'web search tool'
    $converted = $converted -replace '`Grep`', '`rg` or `Select-String`'
    $converted = $converted -replace '\bGrep\b', 'rg or Select-String'
    $converted = $converted -replace 'perplexity_(search|ask|research|reason)', 'available research/search tools'
    $converted = $converted -replace 'Claude paraphrasing', 'LLM paraphrasing'
    $converted = $converted -replace "Claude's judgment", "the model's judgment"
    $converted = $converted -replace 'Claude synthesis', 'model synthesis'
    $converted = $converted -replace 'The protocol Claude uses', 'The protocol Codex or the active agent uses'
    $converted = $converted -replace 'CLAUDE\.md equivalent', 'project-instructions equivalent'
    $converted = $converted -replace '\(Claude in available browser automation\)', '(available browser automation)'

    # Codex cannot assume background agents unless the user explicitly authorizes delegation.
    $converted = $converted -replace '\bsubagents\b', 'optional delegated passes'
    $converted = $converted -replace '\bsubagent\b', 'optional delegated pass'
    $converted = $converted -replace 'parallel agents', 'parallel research passes'
    $converted = $converted -replace 'parallel agent', 'parallel research pass'
    $converted = $converted -replace 'parallel passes \+', 'parallel research passes +'
    $converted = $converted -replace 'parallel research passes \+', 'parallel research passes +'

    $note = @'

## Codex Usage Notes

- Use this as a Codex skill, not a slash command. Trigger from the user request, then follow the workflow in this file.
- Load files from `references/` only when needed. Do not load the entire reference set by default.
- Use available Codex tools for the environment: local filesystem/search tools for repo work, web or browser tools when research or page inspection is required, and exact source capture when evidence is cited.
- Do not spawn delegated agents unless the user explicitly asks for parallel agent work. If delegation is not available or not authorized, perform the passes sequentially in the main context and preserve the same evidence gates.
- When another skill is named, apply that skill's workflow if it is installed in the Codex environment. If it is not installed, continue with the local instructions and state the gap.

'@

    if ($converted -notmatch '## Codex Usage Notes') {
        $converted = [regex]::Replace($converted, '(?s)\A(---\s*.*?\s*---\s*)', "`$1$note")
    }

    return $converted
}

function Add-OpenAiMetadata([string]$SkillDir) {
    $skillMd = Join-Path $SkillDir "SKILL.md"
    $meta = Get-SkillFrontmatter $skillMd
    $agentsDir = Join-Path $SkillDir "agents"
    New-Item -ItemType Directory -Force -Path $agentsDir | Out-Null

    $displayName = Convert-ToTitle $meta.Name
    $short = $meta.Description
    if ($short.Length -gt 180) {
        $short = $short.Substring(0, 177).TrimEnd() + "..."
    }
    $prompt = "Use the $($meta.Name) skill to help with this task. Follow its Codex usage notes, load references only as needed, and preserve evidence gates."

    $yaml = @(
        "display_name: ""$(Escape-YamlDoubleQuoted $displayName)"""
        "short_description: ""$(Escape-YamlDoubleQuoted $short)"""
        "default_prompt: ""$(Escape-YamlDoubleQuoted $prompt)"""
    ) -join [Environment]::NewLine

    Set-Content -Path (Join-Path $agentsDir "openai.yaml") -Value ($yaml + [Environment]::NewLine) -Encoding utf8
}

function Move-SectionToReference(
    [string]$SkillDir,
    [string]$StartHeadingPattern,
    [string]$EndHeadingPattern,
    [string]$ReferenceFileName,
    [string]$ReferenceTitle,
    [string]$MainSummary
) {
    $skillMd = Join-Path $SkillDir "SKILL.md"
    $content = Get-Content -Raw $skillMd
    $pattern = "(?ms)^$StartHeadingPattern\r?\n.*?(?=^$EndHeadingPattern)"
    $match = [regex]::Match($content, $pattern)
    if (-not $match.Success) {
        return
    }

    $referencesDir = Join-Path $SkillDir "references"
    New-Item -ItemType Directory -Force -Path $referencesDir | Out-Null
    $referencePath = Join-Path $referencesDir $ReferenceFileName
    $referenceContent = "# $ReferenceTitle`n`nThis Codex reference holds detailed workflow material moved out of SKILL.md to keep the trigger-time instructions lean.`n`n$($match.Value.Trim())`n"
    Set-Content -Path $referencePath -Value $referenceContent -Encoding utf8

    $relativeReference = "references/$ReferenceFileName"
    $replacement = "## Detailed Workflow Reference`n`n$MainSummary`n`nRead ``$relativeReference`` before executing this part of the workflow. Keep its gates and output requirements authoritative.`n`n"
    $updated = $content.Remove($match.Index, $match.Length).Insert($match.Index, $replacement)
    Set-Content -Path $skillMd -Value $updated -Encoding utf8
}

function Slim-CodexSkill([string]$SkillDir) {
    $skillName = Split-Path $SkillDir -Leaf

    switch ($skillName) {
        "market-pain" {
            Move-SectionToReference `
                -SkillDir $SkillDir `
                -StartHeadingPattern "## Phase 0: Evidence Setup \(ALWAYS run first\)" `
                -EndHeadingPattern "## Final Output" `
                -ReferenceFileName "phase-protocol.md" `
                -ReferenceTitle "Market Pain Phase Protocol" `
                -MainSummary "The phase-by-phase research protocol is intentionally stored as a reference because it is long and operational. Use SKILL.md for routing, source discipline, and output expectations; load the protocol when beginning the actual research run."
        }
        "validate-opportunity" {
            Move-SectionToReference `
                -SkillDir $SkillDir `
                -StartHeadingPattern "## Consolidated report template" `
                -EndHeadingPattern "## Hard rules" `
                -ReferenceFileName "consolidated-report-template.md" `
                -ReferenceTitle "Validate Opportunity Consolidated Report Template" `
                -MainSummary "The consolidated report template is stored separately so the orchestrator stays readable. Load it before drafting the final GO / KILL / CONDITIONAL report."
        }
        "linkedin-optimizer" {
            Move-SectionToReference `
                -SkillDir $SkillDir `
                -StartHeadingPattern "## [^\r\n]*Profile optimisation" `
                -EndHeadingPattern "## Delegation map" `
                -ReferenceFileName "linkedin-playbook.md" `
                -ReferenceTitle "LinkedIn Optimizer Playbook" `
                -MainSummary "The detailed LinkedIn profile, content, outreach, conversion, and capacity playbook is stored separately. Load it after selecting the task route."
        }
        "plan-to-ship" {
            Move-SectionToReference `
                -SkillDir $SkillDir `
                -StartHeadingPattern "## Consolidated report template" `
                -EndHeadingPattern "## Hard rules" `
                -ReferenceFileName "consolidated-report-template.md" `
                -ReferenceTitle "Plan to Ship Consolidated Report Template" `
                -MainSummary "The final ship-plan report template is stored separately. Load it before drafting the GO / CONDITIONAL / DELAY report."
        }
    }
}

function Copy-SkillTree([string]$Source, [string]$Destination) {
    if (-not (Test-Path $Source)) {
        throw "Source skills folder not found: $Source"
    }
    New-Item -ItemType Directory -Force -Path $Destination | Out-Null

    Get-ChildItem -Path $Source -Directory | ForEach-Object {
        $target = Join-Path $Destination $_.Name
        Copy-Item -Path $_.FullName -Destination $target -Recurse

        $oldReference = Join-Path $target "reference"
        $newReferences = Join-Path $target "references"
        if ((Test-Path $oldReference) -and -not (Test-Path $newReferences)) {
            Rename-Item -Path $oldReference -NewName "references"
        }

        Get-ChildItem -Path $target -Recurse -File -Include *.md | ForEach-Object {
            $text = Get-Content -Raw $_.FullName
            $converted = Convert-MarkdownForCodex $text $_.Directory.Parent.Name
            Set-Content -Path $_.FullName -Value $converted -Encoding utf8
        }

        Add-OpenAiMetadata $target
        Slim-CodexSkill $target
    }
}

$repoRoot = Get-Location
$publishedPath = Resolve-RepoPath $PublishedSource
$futurePath = Resolve-RepoPath $FutureSource
$outputPath = Resolve-RepoPath $OutputRoot

if ((Test-Path $outputPath) -and -not $Force) {
    throw "Output already exists: $outputPath. Re-run with -Force to regenerate it."
}

if (Test-Path $outputPath) {
    $expectedOutput = Resolve-RepoPath $OutputRoot
    if ($outputPath -ne $expectedOutput) {
        throw "Refusing to remove unexpected output path: $outputPath"
    }
    Remove-Item -LiteralPath $outputPath -Recurse -Force
}

New-Item -ItemType Directory -Force -Path $outputPath | Out-Null
Copy-SkillTree $publishedPath (Join-Path $outputPath "skills")
Copy-SkillTree $futurePath (Join-Path $outputPath "future-weeks\skills")

$readme = @'
# Solo Builder's Toolkit for Codex

This folder contains Codex-optimized copies of the Claude-oriented skills in the `claude/skills/` folder and the staged future-week skills.

## Layout

- `skills/` contains currently published Codex skills.
- `future-weeks/skills/` contains unreleased Codex skills staged from the future-weeks workspace.

## Install

Copy or symlink the skill folders you want into your Codex skills directory, usually `~/.codex/skills`.

## Adaptation Notes

- Claude slash-command references were converted to Codex skill references.
- `reference/` folders were renamed to `references/`.
- Each skill has `agents/openai.yaml` metadata for Codex skill listings.
- Claude-specific tool names were replaced with portable Codex wording.
- Delegated/parallel agent work is optional and must only be used when the user explicitly asks for it.

Regenerate this folder with:

```powershell
.\scripts\build-codex-skills.ps1 -Force
```

Validate it with:

```powershell
.\scripts\validate-codex-skills.ps1
```
'@

Set-Content -Path (Join-Path $outputPath "README.md") -Value ($readme + [Environment]::NewLine) -Encoding utf8

Write-Output "Built Codex skills at $outputPath"
