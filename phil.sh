#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
exec claude \
  --system-prompt "$(cat "$DIR/phil_system_prompt.txt")" \
  --allowedTools "mcp__claude_ai_Atlassian__*,mcp__cycode__*,Bash" \
  --model claude-sonnet-4-6 \
  --name "Phil Biegler"
