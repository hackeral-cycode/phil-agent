# Phil Agent

A Claude Code agent that responds as **Phil Biegler, VP of Customer Success at Cycode** — in his voice, his cadence, his style. Phil has access to Confluence, Jira, Cycode's scanners, and optionally a crawled docs repo.

Use it two ways:
- **`/phil`** — invoke Phil as a slash command inside any Claude Code session
- **`phil.sh`** — launch a dedicated Phil session from the terminal

---

## Prerequisites

| Tool | Purpose | Install |
|------|---------|---------|
| [Claude Code](https://claude.ai/code) | The CLI that runs Phil | `npm install -g @anthropic-ai/claude-code` |
| [Cycode CLI](https://github.com/cycodehq/cycode-cli) | Cycode scanner MCP | `brew install cycode` |
| `uvx` | Runs the Atlassian MCP server | `brew install uv` |
| [gh CLI](https://cli.github.com) | Reads docs from GitHub (optional) | `brew install gh` |

---

## Setup

### 1. Clone the repo

```bash
git clone https://github.com/hackeral-cycode/phil-agent.git
cd phil-agent
```

### 2. Configure Atlassian credentials

```bash
cp atlassian_mcp.json.example atlassian_mcp.json
```

Edit `atlassian_mcp.json` and fill in your values:

- `YOUR_ORG` → your Atlassian org (e.g. `mycompany`)
- `your.email@yourcompany.com` → your Atlassian account email
- `YOUR_ATLASSIAN_API_TOKEN` → generate one at [id.atlassian.com/manage-profile/security/api-tokens](https://id.atlassian.com/manage-profile/security/api-tokens)

### 3. Authenticate the Cycode CLI

```bash
cycode auth login
```

### 4. Install the `/phil` slash command

```bash
mkdir -p ~/.claude/skills/phil
cp skill/SKILL.md ~/.claude/skills/phil/SKILL.md
```

If you have a [crawled docs repo](#optional-docs-repo-integration), open `~/.claude/skills/phil/SKILL.md` and replace `YOUR_GITHUB_ORG/YOUR_DOCS_REPO` with your repo (e.g. `myorg/cycode-docs`). If you don't, leave the placeholders — Phil will skip the docs check gracefully.

Restart Claude Code, then type `/phil` in any session.

### 5. (Optional) Run as a standalone session

```bash
./phil.sh
```

This opens a dedicated Claude Code session as Phil with all tools pre-loaded.

---

## Optional: Docs Repo Integration

Phil can search a GitHub repo of crawled product docs and prompt you to refresh them if they're more than 30 days old.

To set this up, you need a repo where each page of your docs site is stored as a markdown file under a `docs/` folder. The [cycode-docs-crawler](https://github.com/hackeral-cycode/cycode-docs-crawler) project can generate this automatically using Playwright.

Once you have a docs repo, update the `YOUR_GITHUB_ORG/YOUR_DOCS_REPO` placeholder in `~/.claude/skills/phil/SKILL.md`.

Make sure `gh` is authenticated:
```bash
gh auth login
```

---

## How It Works

| Capability | How Phil uses it |
|-----------|-----------------|
| Confluence | Searches for feature/integration answers before responding |
| Jira | Looks up tickets when referenced in conversation |
| Cycode scanners | Runs actual scans to validate customer claims or demo coverage |
| Docs repo | Searches markdown snapshots of the docs site via `gh` CLI |

---

## Customization

The persona and tool instructions live in `phil_system_prompt.txt` (used by `phil.sh`) and `skill/SKILL.md` (used by `/phil`). Edit either to adjust Phil's behavior, add context about your team, or tune the product knowledge sections.
