# brain-plugin

Two ways to connect [Brain](https://brain.oftomorrow.eu), a hosted shared
markdown knowledge base, to Claude: as a custom connector in Claude chat
(claude.ai, Claude Desktop, Cowork), or as this plugin in Claude Code.

For the full, always-up-to-date walkthrough (with screenshots-equivalent
step-by-step and troubleshooting), see the in-app guide at
[brain.oftomorrow.eu/?view=help](https://brain.oftomorrow.eu/?view=help).
This README is the short version.

## Track 1 — Claude chat / Cowork (custom connector)

Works the same way in the claude.ai web app, the Claude Desktop app, and
inside a Cowork session.

1. Open **Settings → Customize → Connectors**. (In a Team or Enterprise
   organization, an owner adds it first under **Organization settings →
   Connectors**; members then connect from Customize → Connectors
   themselves.)
2. Click **+**, then **Add custom connector**.
3. Paste the server URL into the connector's URL field. Leave **Advanced
   settings** (client ID / secret) blank — Brain registers itself
   automatically.

   ```
   https://brain.oftomorrow.eu/mcp
   ```

4. Click **Add**, then finish signing in in the browser window that opens.
5. On the scope screen, pick a single vault (recommended) or **All my
   vaults**, turn on **Read-only** if this connection should never write,
   and give it a **label** (e.g. `brain-toppy`) so you can tell
   connections apart later. Confirm.
6. In a conversation, click the **+** button in the lower-left of the chat
   box, choose **Connectors**, and toggle **Brain** on for that
   conversation.
7. Optional — for richer instructions than the connector alone gives
   Claude, upload the `brain` skill zip too: download it from

   ```
   https://github.com/toppynl/brain-plugin/releases/latest/download/brain-skill.zip
   ```

   then go to **Settings → Customize → Skills → + → Create skill →
   Upload a skill** and upload the file. No build step needed.
8. Test it — send this in the conversation where you enabled Brain:

   ```
   Using Brain, list my vaults
   ```

Custom connectors need a Free (limited to one), Pro, Max, Team or
Enterprise plan.

## Track 2 — Claude Code

### Option A — the brain plugin (recommended)

Adds two subagents on top of the MCP connection: `vault-reader` (Haiku,
read-only tools, for cheap lookups) and `vault-writer` (Sonnet, full tool
set, for writes and suggestions).

```
/plugin marketplace add toppynl/brain-plugin
/plugin install brain@brain-plugin
```

Review what it adds, then pick a scope (you / this repo / this repo, just
for you). Most installs activate immediately; if Claude Code says "Run
`/reload-plugins` to activate", run `/reload-plugins`. Then run `/mcp` and
finish sign-in in the browser to authenticate Brain.

(Or, from a local clone: `/plugin marketplace add /path/to/brain-plugin`.)

### Option B — add the MCP server directly, no plugin

```
claude mcp add --transport http brain https://brain.oftomorrow.eu/mcp
```

Run `/mcp` and finish sign-in in the browser (or `claude mcp login
brain`).

### Test it

Send this in a Claude Code session:

```
Using Brain, list my vaults
```

## Troubleshooting

- **`/mcp` shows "Needs authentication"**: run `/mcp` again and complete
  the browser sign-in.
- **`claude mcp list` doesn't show brain as Connected**: re-run the
  `claude mcp add` command from Option B, then `/mcp`.
- **Plugin install can't find brain-plugin**: run the `/plugin
  marketplace add` command first — installing skips straight to it only
  once the marketplace is added.
- **Chat connector sign-in loops or fails**: close the popup and retry
  from Customize → Connectors → Brain → Connect.

This plugin (and its skill/subagents) only activate when you explicitly
name Brain, a Brain vault, or otherwise ask for something that needs the
`brain` MCP tools. It does not claim generic "knowledge base" or "notes"
requests — a local wiki, Obsidian vault, or any other note-taking system
is unaffected and out of scope for this plugin.

## Skill-only zip (for the chat track)

claude.ai/Desktop/Cowork skill uploads don't support Claude Code
subagents or MCP model routing — only the skill itself. The download
link in Track 1 above (a stable URL pointing at the latest GitHub
release) always has this skill-only zip of `brain` (no
`vault-reader`/`vault-writer` routing, since chat always uses one
model) — no build step required.

Dev note: that release asset is built by `.github/workflows/release.yml`
on every `v*` tag push, by running `plugins/brain/scripts/zip-skill.sh`.
To build it locally instead, run the script directly (no package
manager or workspace required):

```
bash plugins/brain/scripts/zip-skill.sh
```

Writes `plugins/brain/dist/brain-skill.zip`.

## License

Not yet chosen by the owner — no license file is included here. Treat
this repo as "all rights reserved" until one is added.
