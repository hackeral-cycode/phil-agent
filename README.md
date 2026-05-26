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
| `uvx` | Runs the Atlassian MCP server | `brew install uv` |
| Cycode MCP | Live platform data (findings, inventory, reports) | OAuth via `mcp.cycode.com` — no install, auth on first use |
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

### 3. Authenticate the Cycode MCP

The Cycode MCP connects to `https://mcp.cycode.com` using OAuth — no CLI install needed. On the first `/phil` session, Claude Code will open a browser window to approve the Cycode connection. After that it's automatic.

### 4. Install the `/phil` slash command

```bash
mkdir -p ~/.claude/skills/phil
cp skill/SKILL.md ~/.claude/skills/phil/SKILL.md
```

Phil reads from a shared crawled snapshot of docs.cycode.com at [`hackeral-cycode/cycode-docs-crawler`](https://github.com/hackeral-cycode/cycode-docs-crawler). Make sure you have access to that repo and `gh` is authenticated (step 4 below).

Restart Claude Code, then type `/phil` in any session.

### 5. (Optional) Run as a standalone session

```bash
./phil.sh
```

This opens a dedicated Claude Code session as Phil with all tools pre-loaded.

### 4. Authenticate gh CLI

Phil searches the shared docs snapshot at [`hackeral-cycode/cycode-docs-crawler`](https://github.com/hackeral-cycode/cycode-docs-crawler). Make sure you have access to that repo and are logged in:

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
