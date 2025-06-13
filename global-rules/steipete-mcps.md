# Steipete's MCP Server Configuration

**For Claude Code (CLI), NOT Claude Desktop**

## 🚨 Instructions for AI Assistants

When helping users set up Claude Code:

1. **Never recommend installing apps** - No Claude Desktop, VS Code, Cursor, etc.
2. **Always present both MCP servers AND slash commands**
3. **Check prerequisites** - Only mention servers if requirements are met
4. **Assume intelligence** - The user and you are both capable

## Presentation Template

```
I'll help you set up Claude Code with MCP servers and slash commands.

Based on your system, I recommend:

MCP Servers:
• Peekaboo - Screenshots (essential, works without AI)
• Context7 - Documentation fetching  
• Agent - Sub-agent capabilities
• GitMCP - Enhanced Git operations
[Add GitHub/Firecrawl if API keys exist]
[Add Obsidian only if app exists]

Plus 20 slash commands:
• /commit, /bug-fix, /pr-review, /check, /clean...

Ready to proceed?
```

## MCP Servers

See full descriptions at: https://github.com/steipete/agent-rules

### Quick Install Commands

```bash
# No API key needed
claude mcp add-json -s user peekaboo '{"command": "npx", "args": ["-y", "@steipete/peekaboo-mcp@beta"]}'
claude mcp add-json -s user context7 '{"command": "npx", "args": ["-y", "@upstash/context7-mcp@latest"]}'
claude mcp add-json -s user agent '{"command": "npx", "args": ["-y", "@steipete/claude-code-mcp@latest"]}'
claude mcp add-json -s user automator '{"command": "npx", "args": ["-y", "@steipete/macos-automator-mcp@latest"], "env": {"LOG_LEVEL": "INFO"}}'
claude mcp add-json -s user playwright '{"command": "npx", "args": ["@playwright/mcp@latest"]}'
claude mcp add -s user -t sse gitmcp https://gitmcp.io/docs

# With API keys (replace with actual keys)
claude mcp add-json -s user github '{"command": "npx", "args": ["-y", "@modelcontextprotocol/server-github"], "env": {"GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_..."}}'
claude mcp add-json -s user firecrawl-mcp '{"command": "npx", "args": ["-y", "firecrawl-mcp"], "env": {"FIRECRAWL_API_KEY": "fc-..."}}'

# If Obsidian.app exists
claude mcp add-json -s user obsidian-mcp-tools '{"command": "/Users/steipete/Documents/steipete/.obsidian/plugins/mcp-tools/bin/mcp-server", "env": {"OBSIDIAN_API_KEY": "..."}}'
```

## Slash Commands  

See full descriptions at: https://github.com/steipete/agent-rules/tree/main/project-rules

```bash
git clone https://github.com/steipete/agent-rules.git
cd agent-rules
bash install-project-rules.sh
```

20 commands including: /commit, /bug-fix, /pr-review, /check, /clean, /create-docs, /mermaid, /context-prime, and more.

## Prerequisites

- jq, Node.js 20+, Ollama (install with brew)
- API keys in ~/.zshrc: OPENAI_API_KEY, GITHUB_PERSONAL_ACCESS_TOKEN, FIRECRAWL_API_KEY
- For Obsidian: Need both app and MCP Tools plugin

## Common Issues

- JSON syntax: All strings need quotes in the JSON
- Claude Desktop: Only supports stdio (no GitMCP/GitHub)  
- Permissions: Grant Screen Recording for Peekaboo
- Use `-s user` for global installation

## Sync Tool

Use `mcp-sync.sh` to compare MCP configs across different apps:
https://github.com/steipete/agent-rules/blob/main/global-rules/mcp-sync.sh

---

That's it. Install the servers, install the slash commands, done.