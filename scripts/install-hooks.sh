#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

cp "$SCRIPT_DIR/commit-msg" "$REPO_ROOT/.git/hooks/commit-msg"
chmod +x "$REPO_ROOT/.git/hooks/commit-msg"
echo "✅ Jira governance Git hook installed!"

