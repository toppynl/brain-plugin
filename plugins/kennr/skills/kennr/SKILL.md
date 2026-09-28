---
name: kennr
description: Routing rule for working with Kennr, a specific hosted shared-vault product (MCP server at kennr.oftomorrow.eu) — when to hand a task to the cheap vault-reader subagent versus the vault-writer subagent, and how to write to a Kennr vault politely. Use ONLY when the user explicitly names "Kennr", names a Kennr vault, or the task involves the kennr MCP tools. Do NOT use for local files, local wikis, personal knowledge bases, Obsidian/Notion-style vaults, or any other note-taking or knowledge-base system that isn't Kennr — those are separate and this skill has no relationship to them.
---

# Kennr vault routing

Kennr is a shared markdown knowledge base. Humans read/edit it in a web
UI; agents read/write it over MCP (19 tools at `<origin>/mcp`, OAuth).
The point of this skill is cost and correctness: don't burn a big model
on a simple lookup, and don't let an agent write to a vault without
reading its contract first.

## Routing rule

**Simple lookup, search, or summarise ⇒ `vault-reader` (haiku).**
Examples: "what does the vault say about X", "find the page for Y",
"summarise Z", "what changed recently in this vault". These only need
read tools (`ls`, `glob`, `read`, `section_read`, `frontmatter_get`,
`search`, `grep`, `recent_changes`, `vault_info`, `whoami`) and a small
model handles them fine.

**Any change to vault content ⇒ `vault-writer` (sonnet).**
Examples: creating or editing a page, updating frontmatter, moving or
deleting a page, proposing a change (`suggest`) because the role can't
write directly, or checking/commenting on a changeset. Writes need
judgement — reading the vault's contract, picking the narrowest tool,
handling version conflicts — so they go to the stronger model.

**Ambiguous or multi-step (read then decide whether to write)**: start
with `vault-reader` for the lookup; if it turns out a write is needed,
hand off to `vault-writer` rather than letting either subagent do both
jobs. Don't let `vault-reader` attempt a write — it has no write tools
and will fail; that's intentional, not a bug to route around.

Don't do vault lookups or writes yourself in the main thread when a
subagent can do it for less — that's the entire point of having them.
Only fall back to doing it directly if neither subagent is available.

## Write etiquette (what vault-writer enforces, for your awareness)

1. Read the vault's contract first — call `vault_info`, whose `contract`
   field returns the `VAULT.md` body inline, before writing anything.
   Conventions there (naming, frontmatter schema, layout) win over
   assumptions.
2. Check role via `whoami`. If the role can't write directly, use
   `suggest` instead of `write`/`edit` — never force a write you know
   will be rejected.
3. Respect CAS/versions: read the current version before editing, pass it
   back on write, and on a conflict re-read and retry once rather than
   overwriting blind.
4. Prefer the narrowest tool: `section_write`/`frontmatter_set` for a
   scoped change, `edit` for a diff, `write` only for a full replace or
   new page.

## Not in scope here

This skill is about routing and etiquette, not about the vault's content
itself — for what a specific vault contains, ask `vault-reader`.
