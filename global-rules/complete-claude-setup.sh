#!/bin/bash
# Complete Claude Code Setup Script
# Installs both MCP servers and project rules (slash commands)

echo "🚀 Complete Claude Code Setup"
echo "============================="
echo "This will install:"
echo "  • MCP servers (Peekaboo, Context7, Agent, etc.)"
echo "  • 20 slash commands (/commit, /bug-fix, /pr-review, etc.)"
echo ""

# Check prerequisites
if ! command -v claude &> /dev/null; then
    echo "❌ Error: Claude Code not found. Please install it first."
    echo "   Visit: https://claude.ai/code"
    exit 1
fi

if ! command -v jq &> /dev/null; then
    echo "Installing jq..."
    brew install jq
fi

# Part 1: Install essential MCP servers
echo ""
echo "📦 PART 1: Installing MCP Servers..."
echo "===================================="

# Servers that don't need API keys
echo "Installing essential servers (no API keys required)..."

# Peekaboo
echo "• Installing Peekaboo (screenshot tool)..."
claude mcp add-json -s user peekaboo '{"command": "npx", "args": ["-y", "@steipete/peekaboo-mcp@beta"]}'

# Context7
echo "• Installing Context7 (documentation fetcher)..."
claude mcp add-json -s user context7 '{"command": "npx", "args": ["-y", "@upstash/context7-mcp@latest"]}'

# Agent
echo "• Installing Agent (Claude Code as MCP)..."
claude mcp add-json -s user agent '{"command": "npx", "args": ["-y", "@steipete/claude-code-mcp@latest"]}'

# Automator
echo "• Installing Automator (macOS automation)..."
claude mcp add-json -s user automator '{"command": "npx", "args": ["-y", "@steipete/macos-automator-mcp@latest"], "env": {"LOG_LEVEL": "INFO"}}'

# GitMCP
echo "• Installing GitMCP (enhanced Git operations)..."
claude mcp add -s user -t sse gitmcp https://gitmcp.io/docs

# Playwright
echo "• Installing Playwright (browser automation)..."
claude mcp add-json -s user playwright '{"command": "npx", "args": ["@playwright/mcp@latest"]}'

# Check for API keys
echo ""
echo "Checking for API keys to install additional servers..."

# GitHub
if grep -q "export GITHUB_PERSONAL_ACCESS_TOKEN=" ~/.zshrc 2>/dev/null; then
    GITHUB_TOKEN=$(grep "export GITHUB_PERSONAL_ACCESS_TOKEN=" ~/.zshrc | sed 's/export GITHUB_PERSONAL_ACCESS_TOKEN="//' | sed 's/"$//')
    echo "• Installing GitHub MCP (API token found)..."
    claude mcp add-json -s user github "{\"command\": \"npx\", \"args\": [\"-y\", \"@modelcontextprotocol/server-github\"], \"env\": {\"GITHUB_PERSONAL_ACCESS_TOKEN\": \"$GITHUB_TOKEN\"}}"
else
    echo "⚠️  Skipping GitHub MCP (no GITHUB_PERSONAL_ACCESS_TOKEN in ~/.zshrc)"
fi

# Firecrawl
if grep -q "export FIRECRAWL_API_KEY=" ~/.zshrc 2>/dev/null; then
    FIRECRAWL_KEY=$(grep "export FIRECRAWL_API_KEY=" ~/.zshrc | sed 's/export FIRECRAWL_API_KEY="//' | sed 's/"$//')
    echo "• Installing Firecrawl (API key found)..."
    claude mcp add-json -s user firecrawl-mcp "{\"command\": \"npx\", \"args\": [\"-y\", \"firecrawl-mcp\"], \"env\": {\"FIRECRAWL_API_KEY\": \"$FIRECRAWL_KEY\"}}"
else
    echo "⚠️  Skipping Firecrawl (no FIRECRAWL_API_KEY in ~/.zshrc)"
fi

# Part 2: Install project rules (slash commands)
echo ""
echo "📋 PART 2: Installing Slash Commands..."
echo "======================================"

# Check if we're in the agent-rules directory
if [ -d "project-rules" ]; then
    # We're already in the right place
    bash install-project-rules.sh
elif [ -d "$HOME/Projects/agent-rules/project-rules" ]; then
    # Found it in the expected location
    cd "$HOME/Projects/agent-rules"
    bash install-project-rules.sh
else
    # Need to clone the repository
    echo "Cloning agent-rules repository to get slash commands..."
    git clone https://github.com/steipete/agent-rules.git ~/Projects/agent-rules
    cd ~/Projects/agent-rules
    bash install-project-rules.sh
fi

# Summary
echo ""
echo "✅ Setup Complete!"
echo "=================="
echo ""
echo "MCP Servers installed:"
claude mcp list -s user | grep -E "peekaboo|context7|github|agent|automator|gitmcp|firecrawl|obsidian|playwright" | wc -l | xargs -I {} echo "  • {} servers active"
echo ""
echo "Slash commands available:"
echo "  • /commit - Create well-formatted commits"
echo "  • /bug-fix - Complete bug fix workflow"
echo "  • /pr-review - Review pull requests"
echo "  • /check - Code quality checks"
echo "  • ...and 16 more!"
echo ""
echo "To see all MCP servers: claude mcp list"
echo "To use slash commands: Type / in Claude Code"
echo ""
echo "Need API keys? Add to ~/.zshrc:"
echo "  export GITHUB_PERSONAL_ACCESS_TOKEN=\"ghp_...\""
echo "  export FIRECRAWL_API_KEY=\"fc-...\""
echo "  export OPENAI_API_KEY=\"sk-...\"  # For Peekaboo AI features"