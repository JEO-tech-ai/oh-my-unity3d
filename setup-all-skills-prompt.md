# oh-my-unity3d — Agent Installation Guide

> **For AI Agents**: Read this file in full, then execute all steps without asking for further confirmation. Default installation is **full** — only skip steps if the user explicitly requests "minimal" or "core only."

---

## Execution Principles

| Perspective | Rule |
|-------------|------|
| **Systems Engineer** | Lock defaults explicitly — full install unless overridden |
| **New User** | Eliminate ambiguity — run the complete installation by default |
| **Guide Author** | Skip full install only when user says "core only" or "minimal install" |

---

## Step 0 — Environment Assessment

Check which AI platforms are installed and set the installation root:

```bash
SKILLS_ROOT="$HOME/.agent-skills"
mkdir -p "$SKILLS_ROOT"

# Detect available platforms
echo "=== Platform Detection ==="
command -v claude   &>/dev/null && echo "✅ Claude Code"   || echo "⬜ Claude Code (not found)"
command -v codex    &>/dev/null && echo "✅ Codex CLI"     || echo "⬜ Codex CLI (not found)"
command -v gemini   &>/dev/null && echo "✅ Gemini CLI"    || echo "⬜ Gemini CLI (not found)"
command -v opencode &>/dev/null && echo "✅ OpenCode"      || echo "⬜ OpenCode (not found)"
command -v unity    &>/dev/null && echo "✅ Unity Editor"  || echo "⬜ Unity Editor (not found)"
```

---

## Step 1 — Install Core Skills

Install the orchestration core that all platforms share:

```bash
# Prerequisite: skills CLI
npm install -g skills

# Core orchestration
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill jeo
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill ralph
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill plannotator

# Unity3D integration (required for Unity projects)
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill unity-mcp

# Game development workflow
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill bmad-gds
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill bmad-idea
```

---

## Step 2 — Full Skill Installation (Default)

> **Do not skip this step unless the user explicitly requests "minimal install" or "core only".**

Install all 44 available skills:

```bash
# Platform setup skills
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill omc       # Claude Code
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill ohmg      # Gemini CLI
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill oh-my-codex  # Codex CLI (keyword: omx)
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill ralphmode

# Development
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill code-review
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill code-refactoring
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill backend-testing
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill testing-strategies
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill codebase-search
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill git-workflow
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill git-submodule
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill changelog-maintenance
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill api-design
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill api-documentation
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill security-best-practices
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill performance-optimization
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill pattern-detection
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill environment-setup
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill workflow-automation
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill file-organization

# Design & UI
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill design-system
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill ui-component-patterns
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill web-accessibility
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill web-design-guidelines
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill responsive-design

# Infrastructure & Data
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill database-schema-design
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill log-analysis
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill data-analysis
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill llm-monitoring-dashboard
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill task-planning
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill task-estimation

# Creative & Content
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill image-generation
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill video-production
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill marketing-skills-collection
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill pptx-presentation-builder
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill remotion-video-production
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill opencontext
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill prompt-repetition
npx skills add https://github.com/JEO-tech-ai/oh-my-unity3d --skill vibe-kanban
```

---

## Step 3 — Platform-Specific Setup

Run the setup script for every detected platform:

```bash
# Claude Code
if command -v claude &>/dev/null; then
  bash "$SKILLS_ROOT/jeo/scripts/setup-claude.sh"
  echo "✅ Claude Code configured"
fi

# Codex CLI
if command -v codex &>/dev/null; then
  bash "$SKILLS_ROOT/jeo/scripts/setup-codex.sh"
  echo "✅ Codex CLI configured"
fi

# Gemini CLI
if command -v gemini &>/dev/null; then
  bash "$SKILLS_ROOT/jeo/scripts/setup-gemini.sh"
  echo "✅ Gemini CLI configured"
fi

# OpenCode
if command -v opencode &>/dev/null; then
  bash "$SKILLS_ROOT/jeo/scripts/setup-opencode.sh"
  echo "✅ OpenCode configured"
fi

# unity-mcp (if Unity project detected)
if [ -f "Assets/Scenes" ] || ls *.unity &>/dev/null 2>&1; then
  bash "$SKILLS_ROOT/unity-mcp/scripts/setup.sh"
  echo "✅ unity-mcp configured"
fi
```

---

## Step 4 — Verification

```bash
bash "$SKILLS_ROOT/jeo/scripts/check-status.sh"

# Confirm key skills installed
for skill in jeo unity-mcp bmad-gds ralph plannotator omc; do
  [ -f "$SKILLS_ROOT/$skill/SKILL.md" ] \
    && echo "✅ $skill" \
    || echo "❌ $skill — re-run: npx skills add ... --skill $skill"
done
```

---

## Quick Reference

| Goal | Command |
|------|---------|
| First Unity3D game | `jeo "씬 프로토타이핑: <game name>"` |
| Implement a story | `jeo "스토리 구현: <feature>"` |
| Optimize performance | `jeo "성능 최적화: <symptom>"` |
| Generate GDD | `/bmad-gds-gdd` |
| Review code | `/code-review` |

---

> More skills → [SKILLS-INDEX.md](SKILLS-INDEX.md)
> Platform guides → [GETTING-STARTED.md](GETTING-STARTED.md)
> Unity3D workflows → [WORKFLOWS.md](WORKFLOWS.md)
