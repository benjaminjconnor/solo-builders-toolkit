param(
    [string]$Root = "codex"
)

$ErrorActionPreference = "Stop"

$rootPath = [System.IO.Path]::GetFullPath((Join-Path (Get-Location) $Root))
if (-not (Test-Path $rootPath)) {
    throw "Codex root not found: $rootPath"
}

$skillDirs = @()
$published = Join-Path $rootPath "skills"
$future = Join-Path $rootPath "future-weeks\skills"
if (Test-Path $published) {
    $skillDirs += Get-ChildItem -Path $published -Directory
}
if (Test-Path $future) {
    $skillDirs += Get-ChildItem -Path $future -Directory
}

$skillNames = @{}
$skillDirs | ForEach-Object { $skillNames[$_.Name] = $true }

$errors = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]

foreach ($dir in $skillDirs) {
    $skillMd = Join-Path $dir.FullName "SKILL.md"
    if (-not (Test-Path $skillMd)) {
        $errors.Add("Missing SKILL.md: $($dir.FullName)")
        continue
    }

    $content = Get-Content -Raw $skillMd
    if ($content -notmatch '(?ms)^---\s*.*?^name:\s*.+?^description:\s*.+?\s*---') {
        $errors.Add("Invalid or incomplete frontmatter: $skillMd")
    }

    $lineCount = ($content -split "`n").Count
    if ($lineCount -gt 500) {
        $warnings.Add("Long SKILL.md ($lineCount lines): $skillMd")
    }

    if (-not (Test-Path (Join-Path $dir.FullName "agents\openai.yaml"))) {
        $errors.Add("Missing agents/openai.yaml: $($dir.FullName)")
    }

    if (Test-Path (Join-Path $dir.FullName "reference")) {
        $errors.Add("Uses reference/ instead of references/: $($dir.FullName)")
    }

    if ($content -match 'WebFetch|WebSearch|Chrome MCP|mcp__Claude|Task tool|Anthropic') {
        $errors.Add("Claude/tool-specific wording remains in: $skillMd")
    }

    if ($content -match '\bsubagent\b|\bsubagents\b') {
        $errors.Add("Subagent wording remains in: $skillMd")
    }

    $slashRefs = [regex]::Matches($content, '`/([a-z][a-z0-9-]+)(?:\s|`)')
    foreach ($ref in $slashRefs) {
        if ($skillNames.ContainsKey($ref.Groups[1].Value)) {
            $errors.Add("Backtick slash-command reference remains in: $skillMd")
            break
        }
    }
}

Write-Output "Checked $($skillDirs.Count) Codex skill(s)."

if ($warnings.Count -gt 0) {
    Write-Output ""
    Write-Output "Warnings:"
    $warnings | ForEach-Object { Write-Output "  - $_" }
}

if ($errors.Count -gt 0) {
    Write-Output ""
    Write-Output "Errors:"
    $errors | ForEach-Object { Write-Output "  - $_" }
    exit 1
}

Write-Output "PASS: Codex skill tree is structurally valid."
