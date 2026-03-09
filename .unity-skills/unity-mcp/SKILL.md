---
name: unity-mcp
description: |
  Unity Editor와 AI 에이전트를 연결하는 MCP 브리지 스킬. Unity3D 게임 개발 작업을 AI로 자동화할 때 사용.
  씬 제어, C# 스크립트 생성·검증, 에셋 파이프라인, UI/비주얼, 테스트·디버깅을 지원.
  PM·디자이너·게임개발자 역할별 최적 도구 매핑 제공.
license: MIT
compatibility: |
  Unity 2021.3 LTS 이상 (2022+ 권장). Python 3.10+, uv 패키지 매니저 필요.
  Claude Code, Codex CLI, Gemini CLI, OpenCode에서 사용 가능.
allowed-tools: Read Write Bash Grep Glob Task WebFetch
metadata:
  version: 1.0.0
  author: supercent-io
  keyword: unity-mcp
  tags: unity, unity3d, mcp, game-development, editor-automation, ai-agent
  platforms: Claude Code | Codex CLI | Gemini CLI | OpenCode
  source: CoplayDev/unity-mcp
---

# unity-mcp — Unity Editor MCP 연동 스킬

## When to use this skill

- Unity3D 프로젝트에서 AI 에이전트로 씬·스크립트·에셋 작업을 자동화할 때
- jeo, bmad-gds 워크플로우에서 Unity Editor를 직접 제어할 때
- C# 스크립트 생성·검증·적용을 AI에게 위임할 때
- Unity Test Runner 자동 실행 및 콘솔 로그 분석이 필요할 때

---

## 설치 및 초기 설정

```bash
# 스킬 설치
npx skills add https://github.com/supercent-io/skills-template --skill unity-mcp

# unity-mcp 서버 설치 (Unity Package Manager 경유)
# Unity Editor → Window → Package Manager → "+" → Add from git URL:
# https://github.com/CoplayDev/unity-mcp.git

# AI 클라이언트 자동 설정
bash scripts/setup.sh
```

### 플랫폼별 수동 설정

**Claude Code** (`~/.claude/settings.json`):
```json
{
  "mcpServers": {
    "unity": {
      "command": "python",
      "args": ["-m", "mcp_unity"],
      "env": { "UNITY_PORT": "8080" }
    }
  }
}
```

**Codex CLI** (`~/.codex/config.toml`):
```toml
[[mcp_servers]]
name = "unity"
command = "python"
args = ["-m", "mcp_unity"]
env = { UNITY_PORT = "8080" }
```

**Gemini CLI** (`~/.gemini/settings.json`):
```json
{
  "mcpServers": {
    "unity": {
      "command": "python",
      "args": ["-m", "mcp_unity"]
    }
  }
}
```

---

## 역할별 도구 매핑

### PM 맥락 (기획·스프린트 관리)
| 도구 | 활용 시나리오 | 연동 스킬 |
|------|-------------|---------|
| `project_info` (resource) | 프로젝트 현황 → 스프린트 계획 | bmad-gds (bmad-gds-sprint-planning) |
| `get_tests` | 테스트 커버리지 → 릴리즈 체크리스트 | bmad-gds (bmad-gds-sprint-status) |
| `editor_state` | 씬/빌드 상태 → 데모 준비 확인 | task-planning |
| `read_console` | 버그 리포트 수집 → 스토리 생성 | log-analysis, bmad-gds |

### 디자이너 맥락 (UI/UX·비주얼)
| 도구 | 활용 시나리오 | 연동 스킬 |
|------|-------------|---------|
| `manage_ui` | UI 컴포넌트 계층 생성/수정 | design-system, ui-component-patterns |
| `manage_material`, `manage_shader` | 시각 스타일 프로토타이핑 | design-system |
| `manage_vfx`, `manage_animation` | 모션/이펙트 빠른 이터레이션 | bmad-gds (bmad-gds-quick-prototype) |
| `manage_probuilder` | 레벨 레이아웃 그레이박싱 | bmad-gds (bmad-gds-gdd) |
| `manage_texture` | 에셋 임포트 설정 | file-organization |

### 게임개발자 맥락 (구현·테스트·최적화)
| 도구 | 활용 시나리오 | 연동 스킬 |
|------|-------------|---------|
| `create_script`, `validate_script` | C# 생성 + Roslyn 검증 | bmad-gds (bmad-gds-dev-story) |
| `script_apply_edits`, `manage_script` | 코드 수정·리팩터링 | code-refactoring |
| `manage_gameobject`, `manage_components` | 씬 오브젝트 조작 | bmad-gds (bmad-gds-quick-dev) |
| `run_tests`, `get_test_job` | Unity Test Runner 자동 실행 | testing-strategies |
| `read_console` | 런타임 에러 수집 | log-analysis |
| `find_gameobjects`, `find_in_file` | 디버깅 중 대상 탐색 | codebase-search |
| `batch_execute` | 반복 작업 10~100x 가속 | workflow-automation |
| `manage_prefabs`, `manage_asset` | 에셋 파이프라인 자동화 | file-organization |

---

## 전체 도구 목록 (37개)

### 씬·오브젝트
`manage_scene` · `manage_gameobject` · `find_gameobjects` · `manage_prefabs` · `manage_components`

### 스크립트
`create_script` · `delete_script` · `manage_script` · `script_apply_edits` · `validate_script` · `manage_script_capabilities`

### 에셋·비주얼
`manage_asset` · `manage_material` · `manage_texture` · `manage_shader` · `manage_ui` · `manage_vfx` · `manage_animation` · `manage_probuilder` · `manage_scriptable_object`

### 편집기 제어
`manage_editor` · `execute_menu_item` · `manage_tools` · `refresh_unity` · `set_active_instance`

### 워크플로우
`batch_execute` · `apply_text_edits` · `find_in_file` · `execute_custom_tool`

### 테스트·디버깅
`run_tests` · `read_console` · `get_test_job` · `debug_request_context` · `get_sha`

---

## 빠른 시작 (Quick Start)

```bash
# 1. Unity Editor에서 unity-mcp 서버 시작 (Unity MCP 창에서 Start 버튼)

# 2. 연결 확인
curl http://localhost:8080/health

# 3. jeo 워크플로우에서 사용
jeo "씬 프로토타이핑: 플랫포머 게임"
# → unity-mcp 도구가 자동으로 호출됨
```

---

## 관련 스킬

- **jeo**: 전체 오케스트레이션 (PLAN → EXECUTE → VERIFY → CLEANUP)
- **bmad-gds**: 게임 개발 워크플로우 (기획 → 구현 → 리뷰)
- **design-system**: UI 디자인 토큰 및 Unity3D Design Guide
- **log-analysis**: read_console 출력 분석
- **performance-optimization**: 게임 최적화 전략
- **testing-strategies**: Unity Test Runner 전략

---

## 문제 해결

| 문제 | 해결 방법 |
|------|---------|
| localhost:8080 연결 안 됨 | Unity Editor → MCP 창 → Start 버튼 클릭 |
| 스크립트 검증 실패 | `validate_script` 에러 메시지 확인 후 `manage_script`로 수정 |
| batch_execute 타임아웃 | 작업을 소규모 배치로 분할 |
| 씬 로드 에러 | `read_console`로 에러 확인 → `manage_scene` 재시도 |

---

## 참고

- [unity-mcp GitHub](https://github.com/CoplayDev/unity-mcp) — 37개 도구, 32개 리소스
- Unity 2021.3 LTS+ 필요
- MIT 라이선스 (오픈소스)
