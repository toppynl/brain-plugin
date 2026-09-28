#!/usr/bin/env bash
# Zips the brain skill folder (skill only, no subagent/model routing —
# claude.ai skill uploads don't support Claude Code subagents) for upload
# to claude.ai. Run from anywhere; output goes to plugins/brain/dist/.
set -euo pipefail

repo_root="$(git -C "$(dirname "${BASH_SOURCE[0]}")" rev-parse --show-toplevel)"
skill_dir="$repo_root/plugins/brain/skills/brain"
out_dir="$repo_root/plugins/brain/dist"
out_file="$out_dir/brain-skill.zip"

mkdir -p "$out_dir"
rm -f "$out_file"
(cd "$skill_dir/.." && zip -r "$out_file" "brain" -x '*.DS_Store')

echo "Wrote $out_file"
