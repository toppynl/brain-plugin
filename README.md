# brain-plugin

Claude Code plugin for [Brain](https://brain.oftomorrow.eu), a hosted
shared markdown knowledge base: a `vault-reader` subagent (haiku,
read-only MCP tools) for cheap lookups, a `vault-writer` subagent
(sonnet, full MCP tool set) for disciplined writes/suggestions, and a
`brain` skill that routes between them and states write etiquette.

This plugin (and its skill/subagents) only activate when you explicitly
name Brain, a Brain vault, or otherwise ask for something that needs the
`brain` MCP tools. It does not claim generic "knowledge base" or "notes"
requests — a local wiki, Obsidian vault, or any other note-taking system
is unaffected and out of scope for this plugin.

## Install

```
/plugin marketplace add toppynl/brain-plugin
/plugin install brain@brain-plugin
```

(Or, from a local clone: `/plugin marketplace add /path/to/brain-plugin`.)

The plugin's `.mcp.json` points at the production Brain server
(`https://brain.oftomorrow.eu/mcp`, HTTP transport). On first use, run
`/mcp` and complete the OAuth flow to connect.

## Skill-only upload for claude.ai

claude.ai skill uploads don't support Claude Code subagents or MCP model
routing — only the skill itself. To get a skill-only zip of `brain` (no
`vault-reader`/`vault-writer` routing, since claude.ai always uses one
model), run the zip script directly (no package manager or workspace
required):

```
bash plugins/brain/scripts/zip-skill.sh
```

Writes `plugins/brain/dist/brain-skill.zip`. Upload that file as a skill
in claude.ai.

## License

Not yet chosen by the owner — no license file is included here. Treat
this repo as "all rights reserved" until one is added.
