#!/usr/bin/env bash
# Zips the kennr skill folder (skill only, no subagent/model routing —
# claude.ai skill uploads don't support Claude Code subagents) for upload
# to claude.ai. Run from anywhere; output goes to plugins/kennr/dist/.
set -euo pipefail

repo_root="$(git -C "$(dirname "${BASH_SOURCE[0]}")" rev-parse --show-toplevel)"
skill_dir="$repo_root/plugins/kennr/skills/kennr"
out_dir="$repo_root/plugins/kennr/dist"
out_file="$out_dir/kennr-skill.zip"

mkdir -p "$out_dir"
rm -f "$out_file"
(cd "$skill_dir/.." && zip -r "$out_file" "kennr" -x '*.DS_Store')

echo "Wrote $out_file"
