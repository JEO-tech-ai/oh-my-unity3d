# JEO for Unity3D

Release-ready distribution for the `JEO` orchestration skill package shipped in `.unity-skills/jeo`.

`JEO` standardizes a single workflow across Claude Code, Codex CLI, Gemini CLI, and OpenCode:

`Plan -> Execute -> Verify -> Cleanup`

This release is built around:

- `ralph` + `plannotator` for mandatory plan review
- `omc` team mode or `bmad` fallback for execution
- `agent-browser` for browser verification
- `worktree-cleanup.sh` for post-task cleanup

`v2.0.0` removes `agentation` support entirely. There is no `annotate` or `agentui` path in this package.

## What Ships

Repository layout:

```text
.unity-skills/jeo/
  SKILL.md
  SKILL.toon
  references/FLOW.md
  scripts/
    install.sh
    check-status.sh
    ensure-plannotator.sh
    plannotator-plan-loop.sh
    setup-claude.sh
    setup-codex.sh
    setup-gemini.sh
    setup-opencode.sh
    worktree-cleanup.sh
```

## Supported Platforms

| Platform | Planning | Execution | Verification |
|----------|----------|-----------|--------------|
| Claude Code | `ralph` + `plannotator` hook | `omc` team mode | `agent-browser` |
| Codex CLI | `plan.md` + `plannotator` loop | `bmad` fallback | `agent-browser` |
| Gemini CLI | `plan.md` + AfterAgent helper | `bmad` or `ohmg` | `agent-browser` |
| OpenCode | slash-command workflow | `omx` or `bmad` | `agent-browser` |

## Quick Start

Clone the repository and enter the skill directory:

```bash
git clone https://github.com/JEO-tech-ai/oh-my-unity3d.git
cd oh-my-unity3d/.unity-skills/jeo
```

Install the full package:

```bash
bash scripts/install.sh --all
```

Check environment status:

```bash
bash scripts/check-status.sh
```

Configure the tools you actually use:

```bash
bash scripts/setup-claude.sh
bash scripts/setup-codex.sh
bash scripts/setup-gemini.sh
bash scripts/setup-opencode.sh
```

## Workflow Contract

### 1. Plan

Create `plan.md` and run the blocking plan gate:

```bash
bash scripts/plannotator-plan-loop.sh plan.md /tmp/plannotator_feedback.txt 3
```

Do not execute until the plan is approved.

### 2. Execute

- Claude Code: `/omc:team 3:executor "<task>"`
- Codex, Gemini CLI, OpenCode: `/workflow-init`

### 3. Verify

Use `agent-browser` when the task affects UI or browser behavior:

```bash
agent-browser snapshot http://localhost:3000
agent-browser screenshot http://localhost:3000 -o verify.png
```

### 4. Cleanup

```bash
bash scripts/worktree-cleanup.sh || git worktree prune
```

## Version Notes

### `v2.0.0`

- removed `agentation` integration and related keywords
- reduced the skill to the supported release surface
- aligned setup scripts with the new platform contract
- rewrote the release docs around the actual package contents

## License

This repository is distributed under the license configured for `JEO-tech-ai/oh-my-unity3d`.
