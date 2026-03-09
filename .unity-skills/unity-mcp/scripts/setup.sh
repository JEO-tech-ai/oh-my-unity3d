#!/usr/bin/env bash
# unity-mcp 플랫폼별 MCP 자동 설정
set -e

UNITY_MCP_COMMAND="python"
UNITY_MCP_ARGS='["-m", "mcp_unity"]'

echo "🎮 unity-mcp 설정을 시작합니다..."

# Claude Code 설정
CLAUDE_SETTINGS="$HOME/.claude/settings.json"
if [ -f "$CLAUDE_SETTINGS" ]; then
  echo "✅ Claude Code 설정 업데이트: $CLAUDE_SETTINGS"
  python3 -c "
import json, sys
try:
    with open('$CLAUDE_SETTINGS', 'r') as f:
        s = json.load(f)
    s.setdefault('mcpServers', {})
    s['mcpServers']['unity'] = {
        'command': '$UNITY_MCP_COMMAND',
        'args': ['-m', 'mcp_unity'],
        'env': {'UNITY_PORT': '8080'}
    }
    with open('$CLAUDE_SETTINGS', 'w') as f:
        json.dump(s, f, indent=2, ensure_ascii=False)
    print('  Claude Code: unity-mcp 추가 완료')
except Exception as e:
    print(f'  Claude Code 설정 실패: {e}', file=sys.stderr)
"
fi

# Codex CLI 설정
CODEX_CONFIG="$HOME/.codex/config.toml"
if [ -f "$CODEX_CONFIG" ]; then
  echo "✅ Codex CLI 설정 확인: $CODEX_CONFIG"
  if ! grep -q 'name = "unity"' "$CODEX_CONFIG" 2>/dev/null; then
    cat >> "$CODEX_CONFIG" << 'TOML'

[[mcp_servers]]
name = "unity"
command = "python"
args = ["-m", "mcp_unity"]
TOML
    echo "  Codex CLI: unity-mcp 추가 완료"
  else
    echo "  Codex CLI: 이미 설정됨"
  fi
fi

# Gemini CLI 설정
GEMINI_SETTINGS="$HOME/.gemini/settings.json"
if [ -f "$GEMINI_SETTINGS" ]; then
  echo "✅ Gemini CLI 설정 업데이트: $GEMINI_SETTINGS"
  python3 -c "
import json, sys
try:
    with open('$GEMINI_SETTINGS', 'r') as f:
        s = json.load(f)
    s.setdefault('mcpServers', {})
    s['mcpServers']['unity'] = {
        'command': 'python',
        'args': ['-m', 'mcp_unity']
    }
    with open('$GEMINI_SETTINGS', 'w') as f:
        json.dump(s, f, indent=2, ensure_ascii=False)
    print('  Gemini CLI: unity-mcp 추가 완료')
except Exception as e:
    print(f'  Gemini CLI 설정 실패: {e}', file=sys.stderr)
"
fi

echo ""
echo "🚀 설정 완료! Unity Editor에서 MCP 서버를 시작하세요:"
echo "   Unity Editor → Window → MCP → Start"
echo "   연결 확인: curl http://localhost:8080/health"
