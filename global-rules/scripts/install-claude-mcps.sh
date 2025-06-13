#!/bin/bash
echo "📦 Installing MCP servers to Claude Code..."
echo ""

# Source environment
source ~/.zshrc

# Extract API keys
OPENAI_KEY=$(grep "export OPENAI_API_KEY=" ~/.zshrc | sed 's/export OPENAI_API_KEY="//' | sed 's/"$//')
GITHUB_TOKEN=$(grep "export GITHUB_PERSONAL_ACCESS_TOKEN=" ~/.zshrc | sed 's/export GITHUB_PERSONAL_ACCESS_TOKEN="//' | sed 's/"$//')
FIRECRAWL_KEY=$(grep "export FIRECRAWL_API_KEY=" ~/.zshrc | sed 's/export FIRECRAWL_API_KEY="//' | sed 's/"$//')
OBSIDIAN_KEY=$(grep "export OBSIDIAN_API_KEY=" ~/.zshrc | sed 's/export OBSIDIAN_API_KEY="//' | sed 's/"$//')
[ -z "$OBSIDIAN_KEY" ] && OBSIDIAN_KEY="f1de8ac30724ecb05988c8eb2ee9b342b15f7b91eaba3fc8b0b5280dce3aca22"

# Track installation status
INSTALLED_COUNT=0
SKIPPED_COUNT=0

# 1. Peekaboo
if [ -n "$OPENAI_KEY" ]; then
    echo "✓ Installing Peekaboo with OpenAI support..."
    claude mcp add-json -s user peekaboo "{\"command\": \"npx\", \"args\": [\"-y\", \"@steipete/peekaboo-mcp@beta\"], \"env\": {\"PEEKABOO_AI_PROVIDERS\": \"openai/gpt-4o,ollama/llava:latest\", \"OPENAI_API_KEY\": \"$OPENAI_KEY\"}}"
else
    echo "✓ Installing Peekaboo (Ollama only)..."
    claude mcp add-json -s user peekaboo '{"command": "npx", "args": ["-y", "@steipete/peekaboo-mcp@beta"], "env": {"PEEKABOO_AI_PROVIDERS": "ollama/llava:latest"}}'
fi
((INSTALLED_COUNT++))

# 2. Context7
echo "✓ Installing Context7..."
claude mcp add-json -s user context7 '{"command": "npx", "args": ["-y", "@upstash/context7-mcp@latest"]}'
((INSTALLED_COUNT++))

# 3. GitHub
if [ -n "$GITHUB_TOKEN" ]; then
    echo "✓ Installing GitHub with authentication..."
    claude mcp add-json -s user github "{\"command\": \"npx\", \"args\": [\"-y\", \"@modelcontextprotocol/server-github\"], \"env\": {\"GITHUB_PERSONAL_ACCESS_TOKEN\": \"$GITHUB_TOKEN\"}}"
    ((INSTALLED_COUNT++))
else
    echo "✗ Skipping GitHub MCP (no token)"
    ((SKIPPED_COUNT++))
fi

# 4. Agent
echo "✓ Installing Agent..."
claude mcp add-json -s user agent '{"command": "npx", "args": ["-y", "@steipete/claude-code-mcp@latest"]}'
((INSTALLED_COUNT++))

# 5. Automator
echo "✓ Installing Automator..."
claude mcp add-json -s user automator '{"command": "npx", "args": ["-y", "@steipete/macos-automator-mcp@latest"], "env": {"LOG_LEVEL": "INFO"}}'
((INSTALLED_COUNT++))

# 6. GitMCP
echo "✓ Installing GitMCP..."
claude mcp add -s user -t sse gitmcp https://gitmcp.io/docs
((INSTALLED_COUNT++))

# 7. Firecrawl
if [ -n "$FIRECRAWL_KEY" ]; then
    echo "✓ Installing Firecrawl with API key..."
    claude mcp add-json -s user firecrawl-mcp "{\"command\": \"npx\", \"args\": [\"-y\", \"firecrawl-mcp\"], \"env\": {\"FIRECRAWL_API_KEY\": \"$FIRECRAWL_KEY\"}}"
    ((INSTALLED_COUNT++))
else
    echo "✗ Skipping Firecrawl MCP (no API key)"
    ((SKIPPED_COUNT++))
fi

# 8. Obsidian
if [ -d "/Applications/Obsidian.app" ] && [ -f "/Users/steipete/Documents/steipete/.obsidian/plugins/mcp-tools/bin/mcp-server" ]; then
    echo "✓ Installing Obsidian MCP Tools..."
    claude mcp add-json -s user obsidian-mcp-tools "{\"command\": \"/Users/steipete/Documents/steipete/.obsidian/plugins/mcp-tools/bin/mcp-server\", \"env\": {\"OBSIDIAN_API_KEY\": \"$OBSIDIAN_KEY\"}}"
    ((INSTALLED_COUNT++))
else
    echo "✗ Skipping Obsidian MCP (app/plugin not found)"
    ((SKIPPED_COUNT++))
fi

# 9. Playwright
echo "✓ Installing Playwright..."
claude mcp add-json -s user playwright '{"command": "npx", "args": ["@playwright/mcp@latest"]}'
((INSTALLED_COUNT++))

echo ""
echo "📊 Summary: Installed $INSTALLED_COUNT servers, Skipped $SKIPPED_COUNT"

if [ $SKIPPED_COUNT -gt 0 ]; then
    echo ""
    echo "💡 To install skipped servers, add missing API keys to ~/.zshrc"
fi