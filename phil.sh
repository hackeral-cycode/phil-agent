#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
exec claude \
  --system-prompt "$(cat "$DIR/phil_system_prompt.txt")" \
  --mcp-config "$DIR/atlassian_mcp.json" \
  --allowedTools "mcp__atlassian__*,mcp__cycode__*,Bash" \
  --model claude-sonnet-4-6 \
  --name "Phil Biegler"
