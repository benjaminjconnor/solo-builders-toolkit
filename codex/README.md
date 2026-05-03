# Solo Builder's Toolkit for Codex

This folder contains Codex-optimized copies of the Claude-oriented skills in the root `skills/` folder and the staged future-week skills.

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

