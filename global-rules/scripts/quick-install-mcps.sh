#!/bin/bash
echo "🚀 Quick MCP Server Installation"
echo "================================"
echo "Installing only servers with available prerequisites..."
echo ""

source ~/.zshrc

# Extract API keys
OPENAI_KEY=$(grep "export OPENAI_API_KEY=" ~/.zshrc | sed 's/export OPENAI_API_KEY="//' | sed 's/"$//')
GITHUB_TOKEN=$(grep "export GITHUB_PERSONAL_ACCESS_TOKEN=" ~/.zshrc | sed 's/export GITHUB_PERSONAL_ACCESS_TOKEN="//' | sed 's/"$//')
FIRECRAWL_KEY=$(grep "export FIRECRAWL_API_KEY=" ~/.zshrc | sed 's/export FIRECRAWL_API_KEY="//' | sed 's/"$//')

# Always install these (no API keys required)
echo "Installing servers that don't require API keys..."
claude mcp add-json -s user context7 '{"command": "npx", "args": ["-y", "@upstash/context7-mcp@latest"]}'
claude mcp add-json -s user agent '{"command": "npx", "args": ["-y", "@steipete/claude-code-mcp@latest"]}'
claude mcp add-json -s user automator '{"command": "npx", "args": ["-y", "@steipete/macos-automator-mcp@latest"], "env": {"LOG_LEVEL": "INFO"}}'
claude mcp add -s user -t sse gitmcp https://gitmcp.io/docs
claude mcp add-json -s user playwright '{"command": "npx", "args": ["@playwright/mcp@latest"]}'

# Conditionally install based on available keys
if [ -n "$OPENAI_KEY" ]; then
    echo "Installing Peekaboo (OPENAI_API_KEY found)..."
    claude mcp add-json -s user peekaboo "{\"command\": \"npx\", \"args\": [\"-y\", \"@steipete/peekaboo-mcp@beta\"], \"env\": {\"PEEKABOO_AI_PROVIDERS\": \"openai/gpt-4o,ollama/llava:latest\", \"OPENAI_API_KEY\": \"$OPENAI_KEY\"}}"
else
    echo "Installing Peekaboo (Ollama only)..."
    claude mcp add-json -s user peekaboo '{"command": "npx", "args": ["-y", "@steipete/peekaboo-mcp@beta"], "env": {"PEEKABOO_AI_PROVIDERS": "ollama/llava:latest"}}'
fi

if [ -n "$GITHUB_TOKEN" ]; then
    echo "Installing GitHub MCP..."
    claude mcp add-json -s user github "{\"command\": \"npx\", \"args\": [\"-y\", \"@modelcontextprotocol/server-github\"], \"env\": {\"GITHUB_PERSONAL_ACCESS_TOKEN\": \"$GITHUB_TOKEN\"}}"
fi

if [ -n "$FIRECRAWL_KEY" ]; then
    echo "Installing Firecrawl..."
    claude mcp add-json -s user firecrawl-mcp "{\"command\": \"npx\", \"args\": [\"-y\", \"firecrawl-mcp\"], \"env\": {\"FIRECRAWL_API_KEY\": \"$FIRECRAWL_KEY\"}}"
fi

# Check for Obsidian
if [ -d "/Applications/Obsidian.app" ] && [ -f "/Users/steipete/Documents/steipete/.obsidian/plugins/mcp-tools/bin/mcp-server" ]; then
    echo "Installing Obsidian MCP Tools..."
    claude mcp add-json -s user obsidian-mcp-tools '{"command": "/Users/steipete/Documents/steipete/.obsidian/plugins/mcp-tools/bin/mcp-server", "env": {"OBSIDIAN_API_KEY": "f1de8ac30724ecb05988c8eb2ee9b342b15f7b91eaba3fc8b0b5280dce3aca22"}}'
fi

echo ""
echo "✅ Quick installation complete!"
echo ""
echo "💡 Don't forget slash commands! Install with:"
echo "   bash <(curl -s https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/install-project-rules.sh)"