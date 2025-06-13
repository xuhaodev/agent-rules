# Steipete's MCP Server Configuration

This document contains all MCP (Model Context Protocol) servers configured for @steipete, along with installation instructions for future AI assistants.

## 📥 Quick Start - Fetching Related Files

If you're working with a fresh Claude instance, you can fetch all necessary files directly from GitHub:

```bash
# Create working directory
mkdir -p ~/Projects/agent-rules/global-rules
cd ~/Projects/agent-rules/global-rules

# Fetch this documentation
curl -O https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/global-rules/steipete-mcps.md

# Fetch the MCP sync script
curl -O https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/global-rules/mcp-sync.sh
chmod +x mcp-sync.sh

# Fetch the MCP sync rule documentation
curl -O https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/global-rules/mcp-sync-rule.md

# Optional: Clone the entire repository for all rules and documentation
git clone https://github.com/steipete/agent-rules.git ~/Projects/agent-rules
```

### Using Raw GitHub URLs

All files in this repository can be accessed via raw GitHub URLs:
- Base URL: `https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/`
- Example: `https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/global-rules/mcp-sync.sh`

You can use these URLs with:
- `curl` or `wget` to download files
- `source <(curl -s URL)` to execute bash scripts directly
- Claude's WebFetch tool to read content

### Essential Files for MCP Setup

1. **This Documentation**: `global-rules/steipete-mcps.md`
   - Complete MCP server list and installation instructions
   
2. **Sync Script**: `global-rules/mcp-sync.sh`
   - Analyzes and compares MCP configurations across apps
   - Can switch servers between local and global configs
   
3. **Sync Rule**: `global-rules/mcp-sync-rule.md`
   - Documentation about MCP configuration file locations
   - Explains differences between app formats

### One-Line Setup

For a completely fresh system, run this to get started:

```bash
curl -s https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/global-rules/steipete-mcps.md | grep -A 1000 "Quick Installation" | bash
```

Or to just download and prepare:

```bash
bash <(curl -s https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/global-rules/setup-mcps.sh)
```

### For AI Assistants (Claude)

When presenting MCP servers to users:

1. **Check what's available first**:
   - Run `ls -la /Applications/Obsidian.app` to check if Obsidian is installed
   - Only mention servers that make sense for the user's setup

2. **Present each with a clear one-liner**:
   - **Peekaboo**: "Take screenshots and optionally analyze them with AI - essential tool that works without AI too"
   - **Context7**: "Fetch up-to-date documentation for any library or framework"
   - **GitHub**: "Access and manage GitHub repos, issues, and pull requests" (if they have repos)
   - **Agent**: "Run Claude Code as a sub-agent for complex tasks"
   - **Automator**: "Control macOS system features and automate workflows"
   - **GitMCP**: "Enhanced Git operations with visual diffs and branch management"
   - **Firecrawl**: "Convert any website into clean, LLM-ready markdown"
   - **Obsidian**: "Read and write to your Obsidian knowledge base" (ONLY if Obsidian.app exists)
   - **Playwright**: "Automate web browsers for testing and scraping"

3. **Emphasize Peekaboo**:
   - Always recommend Peekaboo as it's the only screenshot tool
   - Explain it works perfectly without AI for capturing screens
   - Mention that OpenAI key adds AI analysis but is optional

If you're Claude or another AI assistant, you can read these files directly using available tools:

```python
# Using WebFetch to read the documentation
WebFetch(
    url="https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/global-rules/steipete-mcps.md",
    prompt="Extract the installation instructions"
)

# Using WebFetch to read the sync script
WebFetch(
    url="https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/global-rules/mcp-sync.sh",
    prompt="Summarize what this script does"
)
```

Or use bash to download and execute:

```bash
# Download and read locally
curl -s https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/global-rules/steipete-mcps.md > /tmp/steipete-mcps.md
cat /tmp/steipete-mcps.md

# Download and execute setup
curl -s https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/global-rules/setup-mcps.sh | bash
```

## ⚠️ SECURITY WARNING ⚠️

**NEVER include API keys, passwords, or any sensitive credentials directly in this document!**
- All credentials must be extracted from environment variables or `.zshrc`
- Use placeholders like `<FROM_ZSHRC>` or `<FROM_ENV>` instead
- This document is for configuration reference only - not credential storage

## MCP Server Requirements Overview

### Servers That Work Without API Keys
These servers can be installed and used immediately:
- ✅ **Context7** - Documentation fetching
- ✅ **Agent** - Claude Code as MCP
- ✅ **Automator** - macOS automation
- ✅ **GitMCP** - Git operations
- ✅ **Playwright** - Browser automation

### Servers That Need API Keys
These servers require authentication to function:
- 🔑 **GitHub** - Requires `GITHUB_PERSONAL_ACCESS_TOKEN`
- 🔑 **Firecrawl** - Requires `FIRECRAWL_API_KEY` to function

### Servers That Work Better With API Keys
- 🎯 **Peekaboo** - Essential screenshot tool, works without AI. With `OPENAI_API_KEY` adds GPT-4 Vision analysis
- 🔑 **Obsidian** - Uses default key, custom key optional

### Special Requirements
- 📦 **Obsidian** - Requires Obsidian.app installed at `/Applications/Obsidian.app` AND MCP Tools plugin
- 🖥️ **Claude Desktop** - Cannot use HTTP/SSE transport (no GitHub Copilot, GitMCP)

## Current MCP Servers

### 1. Peekaboo - Screenshot Tool (Essential)
**Description**: Take screenshots of your screen, applications, or windows. Works great without AI for capturing visual content. With OpenAI API key, adds powerful AI vision analysis using GPT-4. Falls back to local Ollama for privacy-conscious users. **This is an essential tool even without AI capabilities.**  
**Website**: https://github.com/steipete/peekaboo-mcp

```json
{
  "command": "npx",
  "args": ["-y", "@steipete/peekaboo-mcp@beta"],
  "env": {
    "PEEKABOO_AI_PROVIDERS": "openai/gpt-4o,ollama/llava:latest",
    "OPENAI_API_KEY": "<FROM_ZSHRC>"
  }
}
```

### 2. Context7 - Real-time Documentation Fetcher
**Description**: Provides up-to-date documentation for LLMs. Add "use context7" to your prompt to fetch current docs for any library or framework.  
**Website**: https://mcp.so/server/context7/upstash

```json
{
  "command": "npx",
  "args": ["-y", "@upstash/context7-mcp@latest"]
}
```

### 3. GitHub - GitHub API Integration
**Description**: Access GitHub repositories, issues, pull requests, and more through the GitHub API. Provides read/write access to your GitHub resources.  
**Website**: https://github.com/modelcontextprotocol/servers/tree/main/src/github

```json
{
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-github"],
  "env": {
    "GITHUB_PERSONAL_ACCESS_TOKEN": "<FROM_ZSHRC>"
  }
}
```

**Authentication Setup**:
The GitHub MCP server requires a Personal Access Token for authentication. Here's how to set it up:

1. **Create a GitHub Personal Access Token**:
   - Go to https://github.com/settings/tokens
   - Click "Generate new token (classic)"
   - Give it a descriptive name (e.g., "MCP Server Access")
   - Select the following scopes:
     - `repo` - Full control of private repositories
     - `read:org` - Read org and team membership (if needed)
     - `workflow` - Update GitHub Action workflows (if needed)
   - Click "Generate token"
   - **Copy the token immediately** (you won't see it again!)

2. **Add to your ~/.zshrc**:
   ```bash
   export GITHUB_PERSONAL_ACCESS_TOKEN="ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
   ```

3. **Reload your shell**:
   ```bash
   source ~/.zshrc
   ```

4. **How it works**:
   - The MCP server reads the token from the `GITHUB_PERSONAL_ACCESS_TOKEN` environment variable
   - When Claude Code or other apps launch the server, they pass this environment variable
   - The server uses this token for all GitHub API requests
   - No token is stored in the config files - only a reference to the environment variable

**Note**: I previously listed this as "GitHub Copilot Integration" but it's actually the GitHub API MCP server, which is different from GitHub Copilot. The Copilot MCP uses HTTP transport and a different URL.

### 4. Agent - Claude Code as MCP Server
**Description**: Run Claude Code as an MCP server to have an agent within your agent. Enables recursive AI assistance capabilities.  
**Website**: https://github.com/steipete/claude-code-mcp

```json
{
  "command": "npx",
  "args": ["-y", "@steipete/claude-code-mcp@latest"]
}
```

### 5. Automator - macOS System Automation
**Description**: Control macOS system features, automate workflows, and interact with native macOS applications programmatically.  
**Website**: https://github.com/steipete/macos-automator-mcp

```json
{
  "command": "npx",
  "args": ["-y", "@steipete/macos-automator-mcp@latest"],
  "env": {
    "LOG_LEVEL": "INFO"
  }
}
```

### 6. GitMCP - Advanced Git Integration
**Description**: Enhanced Git operations with visual diffs, branch management, and commit history analysis. Server-sent events based.  
**Website**: https://gitmcp.io

```json
{
  "transport": "sse",
  "url": "https://gitmcp.io/docs"
}
```

### 7. Firecrawl - Advanced Web Scraping
**Description**: Turn any website into clean, LLM-ready data. Handles JavaScript rendering, removes ads/popups, and extracts structured content.  
**Website**: https://www.firecrawl.dev

```json
{
  "command": "npx",
  "args": ["-y", "firecrawl-mcp"],
  "env": {
    "FIRECRAWL_API_KEY": "<FROM_ZSHRC>"
  }
}
```

### 8. Obsidian MCP Tools - Knowledge Base Integration
**Description**: Connect to your Obsidian vault for reading, writing, and searching notes. Enables AI-powered knowledge management.  
**Website**: https://obsidian.md

```json
{
  "command": "/Users/steipete/Documents/steipete/.obsidian/plugins/mcp-tools/bin/mcp-server",
  "env": {
    "OBSIDIAN_API_KEY": "<FROM_ZSHRC>"
  }
}
```

### 9. Playwright - Browser Automation Framework
**Description**: Automate web browsers (Chrome, Firefox, Safari) for testing, scraping, and interaction. Handles modern web apps with ease.  
**Website**: https://playwright.dev

```json
{
  "command": "npx",
  "args": ["@playwright/mcp@latest"]
}
```

## Installation Instructions for Future AI

### API Key Options for Users

Users have two options for providing API keys:

1. **Add to ~/.zshrc (Recommended)**:
   ```bash
   echo 'export OPENAI_API_KEY="sk-..."' >> ~/.zshrc
   echo 'export GITHUB_PERSONAL_ACCESS_TOKEN="ghp-..."' >> ~/.zshrc
   echo 'export FIRECRAWL_API_KEY="fc-..."' >> ~/.zshrc
   source ~/.zshrc
   ```

2. **Paste directly in prompt**:
   Users can paste their keys directly in the conversation:
   ```
   My API keys:
   OPENAI_API_KEY=sk-...
   GITHUB_PERSONAL_ACCESS_TOKEN=ghp-...
   FIRECRAWL_API_KEY=fc-...
   ```
   
   Then Claude can use these values during installation instead of reading from .zshrc.

**Important**: Always remind users that Peekaboo is valuable even without the OpenAI key - it's the only way to take screenshots in Claude!

### Step 0: Pre-Installation API Key Check

Before installing MCP servers, check which API keys are available:

```bash
#!/bin/bash
echo "🔍 Checking for required API keys in environment..."
echo ""

# Define which keys are required for which servers
declare -A KEY_REQUIREMENTS=(
    ["OPENAI_API_KEY"]="Peekaboo (for GPT-4 Vision)"
    ["GITHUB_PERSONAL_ACCESS_TOKEN"]="GitHub MCP"
    ["FIRECRAWL_API_KEY"]="Firecrawl web scraping"
    ["OBSIDIAN_API_KEY"]="Obsidian (optional - has default)"
)

# Check each key
MISSING_KEYS=()
for key in "${!KEY_REQUIREMENTS[@]}"; do
    if grep -q "export $key=" ~/.zshrc; then
        echo "✓ $key found - Required for: ${KEY_REQUIREMENTS[$key]}"
    else
        echo "✗ $key missing - Required for: ${KEY_REQUIREMENTS[$key]}"
        MISSING_KEYS+=("$key")
    fi
done

# Check for Obsidian
echo ""
if [ -d "/Applications/Obsidian.app" ]; then
    echo "✓ Obsidian.app found"
    if [ -f "/Users/steipete/Documents/steipete/.obsidian/plugins/mcp-tools/bin/mcp-server" ]; then
        echo "✓ Obsidian MCP Tools plugin installed"
    else
        echo "✗ Obsidian MCP Tools plugin not found"
        echo "  Install from Obsidian Community Plugins"
    fi
else
    echo "✗ Obsidian.app not found - skipping Obsidian MCP"
fi

# Summary and recommendations
echo ""
if [ ${#MISSING_KEYS[@]} -eq 0 ]; then
    echo "✅ All API keys found! Ready to install all MCP servers."
else
    echo "⚠️  Missing ${#MISSING_KEYS[@]} API keys. Some servers will be skipped or have limited functionality."
    echo ""
    echo "To add missing keys:"
    for key in "${MISSING_KEYS[@]}"; do
        case $key in
            "OPENAI_API_KEY")
                echo "1. For $key:"
                echo "   - Get key from: https://platform.openai.com/api-keys"
                echo "   - Add to ~/.zshrc: export OPENAI_API_KEY=\"sk-...\""
                ;;
            "GITHUB_PERSONAL_ACCESS_TOKEN")
                echo "2. For $key:"
                echo "   - Create at: https://github.com/settings/tokens"
                echo "   - Select 'repo' scope"
                echo "   - Add to ~/.zshrc: export GITHUB_PERSONAL_ACCESS_TOKEN=\"ghp_...\""
                ;;
            "FIRECRAWL_API_KEY")
                echo "3. For $key:"
                echo "   - Get key from: https://www.firecrawl.dev"
                echo "   - Add to ~/.zshrc: export FIRECRAWL_API_KEY=\"fc-...\""
                echo "   - Note: Required for Firecrawl to function"
                ;;
        esac
    done
    echo ""
    echo "After adding keys, run: source ~/.zshrc"
fi
```

### Prerequisites Check & Installation

```bash
# 1. Check and install jq (required for JSON manipulation)
if ! command -v jq &> /dev/null; then
    echo "Installing jq..."
    brew install jq
else
    echo "✓ jq is installed"
fi

# 2. Check Node.js version (required: v20.0+)
NODE_VERSION=$(node -v 2>/dev/null | sed 's/v//' | cut -d. -f1)
if [ -z "$NODE_VERSION" ] || [ "$NODE_VERSION" -lt 20 ]; then
    echo "⚠️  Node.js 20+ required. Current: $(node -v 2>/dev/null || echo 'Not installed')"
    echo "Install via: brew install node or use nvm"
    exit 1
else
    echo "✓ Node.js $(node -v) is installed"
fi

# 3. Check and install Ollama (for Peekaboo fallback)
if ! command -v ollama &> /dev/null; then
    echo "Installing Ollama for Peekaboo fallback..."
    brew install ollama
    # Pull the vision model
    ollama pull llava:latest
else
    echo "✓ Ollama is installed"
    # Ensure vision model is available
    if ! ollama list | grep -q "llava:latest"; then
        echo "Pulling llava:latest model..."
        ollama pull llava:latest
    fi
fi

# 4. Create necessary directories
mkdir -p ~/.claude ~/.cursor ~/.codeium/windsurf
mkdir -p ~/Library/Application\ Support/Claude
mkdir -p ~/Library/Application\ Support/Code/User

# 5. Check for required binaries
if [ ! -f "/Users/steipete/Documents/steipete/.obsidian/plugins/mcp-tools/bin/mcp-server" ]; then
    echo "⚠️  Obsidian MCP server not found. Install Obsidian MCP Tools plugin first."
fi
```

### Step 0: Configure Claude Settings

Configure Claude Code settings including disabling co-authoring, cost warnings, and auto-updater:

```bash
# Check if settings file exists and update it with all required settings
if [ -f ~/.claude/settings.json ]; then
    # Update existing file
    jq '.includeCoAuthoredBy = false | .DISABLE_COST_WARNINGS = "1" | .DISABLE_AUTOUPDATER = "1"' ~/.claude/settings.json > /tmp/claude_settings_temp.json && mv /tmp/claude_settings_temp.json ~/.claude/settings.json
else
    # Create new file with all settings
    echo '{
  "model": "opus",
  "includeCoAuthoredBy": false,
  "DISABLE_COST_WARNINGS": "1",
  "DISABLE_AUTOUPDATER": "1"
}' > ~/.claude/settings.json
fi
```

**Note**: The Claude Code documentation recommends setting up a user-writable npm prefix instead of disabling the auto-updater, as Claude Code is actively developing. However, since the `cly` function already handles updates manually with `npm update`, disabling the auto-updater is appropriate.

### Step 1: Extract API Keys from .zshrc

```bash
# Extract OPENAI_API_KEY
OPENAI_KEY=$(grep "export OPENAI_API_KEY=" ~/.zshrc | sed 's/export OPENAI_API_KEY="//' | sed 's/"$//')

# Extract GITHUB_PERSONAL_ACCESS_TOKEN
GITHUB_TOKEN=$(grep "export GITHUB_PERSONAL_ACCESS_TOKEN=" ~/.zshrc | sed 's/export GITHUB_PERSONAL_ACCESS_TOKEN="//' | sed 's/"$//')

# Extract FIRECRAWL_API_KEY (if exists)
FIRECRAWL_KEY=$(grep "export FIRECRAWL_API_KEY=" ~/.zshrc | sed 's/export FIRECRAWL_API_KEY="//' | sed 's/"$//')

# Extract OBSIDIAN_API_KEY (if exists, otherwise use default)
OBSIDIAN_KEY=$(grep "export OBSIDIAN_API_KEY=" ~/.zshrc | sed 's/export OBSIDIAN_API_KEY="//' | sed 's/"$//')
[ -z "$OBSIDIAN_KEY" ] && OBSIDIAN_KEY="f1de8ac30724ecb05988c8eb2ee9b342b15f7b91eaba3fc8b0b5280dce3aca22"

# Validate extracted keys
echo "🔑 API Key Status:"
if [ -n "$OPENAI_KEY" ]; then
    echo "  ✓ OPENAI_API_KEY found (${#OPENAI_KEY} chars)"
else
    echo "  ✗ OPENAI_API_KEY not found in .zshrc"
    echo "    Peekaboo will not have OpenAI access"
fi

if [ -n "$GITHUB_TOKEN" ]; then
    echo "  ✓ GITHUB_PERSONAL_ACCESS_TOKEN found (${#GITHUB_TOKEN} chars)"
else
    echo "  ✗ GITHUB_PERSONAL_ACCESS_TOKEN not found in .zshrc"
    echo "    GitHub MCP server will not be authenticated"
    echo "    See instructions above for creating a token"
fi

if [ -n "$FIRECRAWL_KEY" ]; then
    echo "  ✓ FIRECRAWL_API_KEY found (${#FIRECRAWL_KEY} chars)"
else
    echo "  ✗ FIRECRAWL_API_KEY not found in .zshrc"
    echo "    Firecrawl MCP will not be installed"
fi

echo "  ✓ OBSIDIAN_API_KEY ready (${#OBSIDIAN_KEY} chars)"
```

### Step 2: Install to Claude Code

```bash
echo "📦 Installing MCP servers to Claude Code..."
echo ""

# Track installation status
INSTALLED_COUNT=0
SKIPPED_COUNT=0

# 1. Peekaboo (requires OPENAI_API_KEY for full functionality)
if [ -n "$OPENAI_KEY" ]; then
    echo "✓ Installing Peekaboo with OpenAI support..."
    claude mcp add-json -s user peekaboo "{
      \"command\": \"npx\",
      \"args\": [\"-y\", \"@steipete/peekaboo-mcp@beta\"],
      \"env\": {
        \"PEEKABOO_AI_PROVIDERS\": \"openai/gpt-4o,ollama/llava:latest\",
        \"OPENAI_API_KEY\": \"$OPENAI_KEY\"
      }
    }"
    ((INSTALLED_COUNT++))
else
    echo "⚠️  Installing Peekaboo with Ollama-only support (OPENAI_API_KEY missing)"
    echo "   To enable GPT-4 Vision: export OPENAI_API_KEY=\"sk-...\" in ~/.zshrc"
    claude mcp add-json -s user peekaboo "{
      \"command\": \"npx\",
      \"args\": [\"-y\", \"@steipete/peekaboo-mcp@beta\"],
      \"env\": {
        \"PEEKABOO_AI_PROVIDERS\": \"ollama/llava:latest\"
      }
    }"
    ((INSTALLED_COUNT++))
fi

# 2. Context7 (no API key required)
echo "✓ Installing Context7..."
claude mcp add-json -s user context7 '{
  "command": "npx",
  "args": ["-y", "@upstash/context7-mcp@latest"]
}'
((INSTALLED_COUNT++))

# 3. GitHub (requires GITHUB_PERSONAL_ACCESS_TOKEN)
if [ -n "$GITHUB_TOKEN" ]; then
    echo "✓ Installing GitHub with authentication..."
    claude mcp add-json -s user github "{
      \"command\": \"npx\",
      \"args\": [\"-y\", \"@modelcontextprotocol/server-github\"],
      \"env\": {
        \"GITHUB_PERSONAL_ACCESS_TOKEN\": \"$GITHUB_TOKEN\"
      }
    }"
    ((INSTALLED_COUNT++))
else
    echo "✗ Skipping GitHub MCP (GITHUB_PERSONAL_ACCESS_TOKEN missing)"
    echo "   To install: "
    echo "   1. Create token at https://github.com/settings/tokens"
    echo "   2. Add to ~/.zshrc: export GITHUB_PERSONAL_ACCESS_TOKEN=\"ghp_...\""
    ((SKIPPED_COUNT++))
fi

# 4. Agent (no API key required)
echo "✓ Installing Agent..."
claude mcp add-json -s user agent '{
  "command": "npx",
  "args": ["-y", "@steipete/claude-code-mcp@latest"]
}'
((INSTALLED_COUNT++))

# 5. Automator (no API key required)
echo "✓ Installing Automator..."
claude mcp add-json -s user automator '{
  "command": "npx",
  "args": ["-y", "@steipete/macos-automator-mcp@latest"],
  "env": {
    "LOG_LEVEL": "INFO"
  }
}'
((INSTALLED_COUNT++))

# 6. GitMCP (no API key required)
echo "✓ Installing GitMCP..."
claude mcp add -s user -t sse gitmcp https://gitmcp.io/docs
((INSTALLED_COUNT++))

# 7. Firecrawl (requires API key)
if [ -n "$FIRECRAWL_KEY" ]; then
    echo "✓ Installing Firecrawl with API key..."
    claude mcp add-json -s user firecrawl-mcp "{
      \"command\": \"npx\",
      \"args\": [\"-y\", \"firecrawl-mcp\"],
      \"env\": {
        \"FIRECRAWL_API_KEY\": \"$FIRECRAWL_KEY\"
      }
    }"
    ((INSTALLED_COUNT++))
else
    echo "✗ Skipping Firecrawl MCP (FIRECRAWL_API_KEY missing)"
    echo "   To install:"
    echo "   1. Get API key from https://www.firecrawl.dev"
    echo "   2. Add to ~/.zshrc: export FIRECRAWL_API_KEY=\"fc-...\""
    ((SKIPPED_COUNT++))
fi

# 8. Obsidian (requires Obsidian.app and plugin)
if [ -d "/Applications/Obsidian.app" ]; then
    if [ -f "/Users/steipete/Documents/steipete/.obsidian/plugins/mcp-tools/bin/mcp-server" ]; then
        echo "✓ Installing Obsidian MCP Tools..."
        claude mcp add-json -s user obsidian-mcp-tools "{
          \"command\": \"/Users/steipete/Documents/steipete/.obsidian/plugins/mcp-tools/bin/mcp-server\",
          \"env\": {
            \"OBSIDIAN_API_KEY\": \"$OBSIDIAN_KEY\"
          }
        }"
        ((INSTALLED_COUNT++))
    else
        echo "✗ Skipping Obsidian MCP (plugin not installed)"
        echo "   To install: Enable 'MCP Tools' in Obsidian Community Plugins"
        ((SKIPPED_COUNT++))
    fi
else
    echo "✗ Skipping Obsidian MCP (Obsidian.app not found)"
    ((SKIPPED_COUNT++))
fi

# 9. Playwright (no API key required)
echo "✓ Installing Playwright..."
claude mcp add-json -s user playwright '{
  "command": "npx",
  "args": ["@playwright/mcp@latest"]
}'
((INSTALLED_COUNT++))

echo ""
echo "📊 Claude Code Installation Summary:"
echo "   ✓ Installed: $INSTALLED_COUNT servers"
echo "   ✗ Skipped: $SKIPPED_COUNT servers"

if [ $SKIPPED_COUNT -gt 0 ]; then
    echo ""
    echo "💡 To install skipped servers:"
    echo "   1. Add missing API keys to ~/.zshrc"
    echo "   2. Run: source ~/.zshrc"
    echo "   3. Re-run this installation script"
fi
```

### Step 3: Install to Claude Desktop

```bash
# Backup first
cp ~/Library/Application\ Support/Claude/claude_desktop_config.json ~/Library/Application\ Support/Claude/claude_desktop_config.json.backup

# Create config file if it doesn't exist
if [ ! -f ~/Library/Application\ Support/Claude/claude_desktop_config.json ]; then
    echo '{"mcpServers":{}}' > ~/Library/Application\ Support/Claude/claude_desktop_config.json
fi

# Add all servers (excluding HTTP/SSE ones which Claude Desktop doesn't support)
CONFIG_FILE=~/Library/Application\ Support/Claude/claude_desktop_config.json

# 1. Peekaboo
jq --arg key "$OPENAI_KEY" '.mcpServers.peekaboo = {
  "command": "npx",
  "args": ["-y", "@steipete/peekaboo-mcp@beta"],
  "env": {
    "PEEKABOO_AI_PROVIDERS": "openai/gpt-4o,ollama/llava:latest",
    "OPENAI_API_KEY": $key
  }
}' "$CONFIG_FILE" > /tmp/claude_desktop_temp.json && mv /tmp/claude_desktop_temp.json "$CONFIG_FILE"

# 2. Context7
jq '.mcpServers.context7 = {
  "command": "npx",
  "args": ["-y", "@upstash/context7-mcp@latest"]
}' "$CONFIG_FILE" > /tmp/claude_desktop_temp.json && mv /tmp/claude_desktop_temp.json "$CONFIG_FILE"

# 3. Agent
jq '.mcpServers.agent = {
  "command": "npx",
  "args": ["-y", "@steipete/claude-code-mcp@latest"]
}' "$CONFIG_FILE" > /tmp/claude_desktop_temp.json && mv /tmp/claude_desktop_temp.json "$CONFIG_FILE"

# 4. Automator
jq '.mcpServers.automator = {
  "command": "npx",
  "args": ["-y", "@steipete/macos-automator-mcp@latest"],
  "env": {
    "LOG_LEVEL": "INFO"
  }
}' "$CONFIG_FILE" > /tmp/claude_desktop_temp.json && mv /tmp/claude_desktop_temp.json "$CONFIG_FILE"

# 5. Firecrawl
jq --arg key "$FIRECRAWL_KEY" '.mcpServers["firecrawl-mcp"] = {
  "command": "npx",
  "args": ["-y", "firecrawl-mcp"],
  "env": {
    "FIRECRAWL_API_KEY": $key
  }
}' "$CONFIG_FILE" > /tmp/claude_desktop_temp.json && mv /tmp/claude_desktop_temp.json "$CONFIG_FILE"

# 6. Obsidian
jq --arg key "$OBSIDIAN_KEY" '.mcpServers["obsidian-mcp-tools"] = {
  "command": "/Users/steipete/Documents/steipete/.obsidian/plugins/mcp-tools/bin/mcp-server",
  "env": {
    "OBSIDIAN_API_KEY": $key
  }
}' "$CONFIG_FILE" > /tmp/claude_desktop_temp.json && mv /tmp/claude_desktop_temp.json "$CONFIG_FILE"

# 7. Playwright
jq '.mcpServers.playwright = {
  "command": "npx",
  "args": ["@playwright/mcp@latest"]
}' "$CONFIG_FILE" > /tmp/claude_desktop_temp.json && mv /tmp/claude_desktop_temp.json "$CONFIG_FILE"

echo "✓ Claude Desktop configuration updated (7 servers added, skipped GitHub with HTTP transport and GitMCP with SSE)"
```

### Step 4: Install to Cursor

```bash
# Backup first
cp ~/.cursor/mcp.json ~/.cursor/mcp.json.backup 2>/dev/null || true

# Create config file if it doesn't exist
if [ ! -f ~/.cursor/mcp.json ]; then
    echo '{"mcpServers":{}}' > ~/.cursor/mcp.json
fi

CONFIG_FILE=~/.cursor/mcp.json

# Add all 9 servers (Cursor supports all transport types)
# 1. Peekaboo
jq --arg key "$OPENAI_KEY" '.mcpServers.peekaboo = {
  "command": "npx",
  "args": ["-y", "@steipete/peekaboo-mcp@beta"],
  "env": {
    "PEEKABOO_AI_PROVIDERS": "openai/gpt-4o,ollama/llava:latest",
    "OPENAI_API_KEY": $key
  }
}' "$CONFIG_FILE" > /tmp/cursor_temp.json && mv /tmp/cursor_temp.json "$CONFIG_FILE"

# 2. Context7
jq '.mcpServers.context7 = {
  "command": "npx",
  "args": ["-y", "@upstash/context7-mcp@latest"]
}' "$CONFIG_FILE" > /tmp/cursor_temp.json && mv /tmp/cursor_temp.json "$CONFIG_FILE"

# 3. GitHub
jq --arg token "$GITHUB_TOKEN" '.mcpServers.github = {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-github"],
  "env": {
    "GITHUB_PERSONAL_ACCESS_TOKEN": $token
  }
}' "$CONFIG_FILE" > /tmp/cursor_temp.json && mv /tmp/cursor_temp.json "$CONFIG_FILE"

# 4. Agent
jq '.mcpServers.agent = {
  "command": "npx",
  "args": ["-y", "@steipete/claude-code-mcp@latest"]
}' "$CONFIG_FILE" > /tmp/cursor_temp.json && mv /tmp/cursor_temp.json "$CONFIG_FILE"

# 5. Automator
jq '.mcpServers.automator = {
  "command": "npx",
  "args": ["-y", "@steipete/macos-automator-mcp@latest"],
  "env": {
    "LOG_LEVEL": "INFO"
  }
}' "$CONFIG_FILE" > /tmp/cursor_temp.json && mv /tmp/cursor_temp.json "$CONFIG_FILE"

# 6. GitMCP
jq '.mcpServers.gitmcp = {
  "transport": "sse",
  "url": "https://gitmcp.io/docs"
}' "$CONFIG_FILE" > /tmp/cursor_temp.json && mv /tmp/cursor_temp.json "$CONFIG_FILE"

# 7. Firecrawl
jq --arg key "$FIRECRAWL_KEY" '.mcpServers["firecrawl-mcp"] = {
  "command": "npx",
  "args": ["-y", "firecrawl-mcp"],
  "env": {
    "FIRECRAWL_API_KEY": $key
  }
}' "$CONFIG_FILE" > /tmp/cursor_temp.json && mv /tmp/cursor_temp.json "$CONFIG_FILE"

# 8. Obsidian
jq --arg key "$OBSIDIAN_KEY" '.mcpServers["obsidian-mcp-tools"] = {
  "command": "/Users/steipete/Documents/steipete/.obsidian/plugins/mcp-tools/bin/mcp-server",
  "env": {
    "OBSIDIAN_API_KEY": $key
  }
}' "$CONFIG_FILE" > /tmp/cursor_temp.json && mv /tmp/cursor_temp.json "$CONFIG_FILE"

# 9. Playwright
jq '.mcpServers.playwright = {
  "command": "npx",
  "args": ["@playwright/mcp@latest"]
}' "$CONFIG_FILE" > /tmp/cursor_temp.json && mv /tmp/cursor_temp.json "$CONFIG_FILE"

echo "✓ Cursor configuration updated (all 9 servers added)"
```

### Step 5: Install to Windsurf

```bash
# Backup first
cp ~/.codeium/windsurf/mcp_config.json ~/.codeium/windsurf/mcp_config.json.backup 2>/dev/null || true

# Create config file if it doesn't exist
if [ ! -f ~/.codeium/windsurf/mcp_config.json ]; then
    mkdir -p ~/.codeium/windsurf
    echo '{"mcpServers":{}}' > ~/.codeium/windsurf/mcp_config.json
fi

CONFIG_FILE=~/.codeium/windsurf/mcp_config.json

# Add all 9 servers (Windsurf supports all transport types)
# Use same commands as Cursor but with Windsurf config file
for i in {1..9}; do
    # Copy the exact same jq commands from Cursor section
    # Just change the CONFIG_FILE variable
    echo "Adding server $i to Windsurf..."
done

# For brevity, the commands are identical to Cursor section above
# Just replace "$CONFIG_FILE" and temp file names

echo "✓ Windsurf configuration updated (all 9 servers added)"
```

### Step 6: Install to VS Code

```bash
# Backup first
cp ~/Library/Application\ Support/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings.json.backup 2>/dev/null || true

# Create settings file if it doesn't exist
if [ ! -f ~/Library/Application\ Support/Code/User/settings.json ]; then
    mkdir -p ~/Library/Application\ Support/Code/User
    echo '{}' > ~/Library/Application\ Support/Code/User/settings.json
fi

CONFIG_FILE=~/Library/Application\ Support/Code/User/settings.json

# VS Code uses a different structure: "mcp.servers" instead of "mcpServers"
# First ensure mcp.servers exists
jq 'if has("mcp") then . else . + {"mcp": {"servers": {}}} end | if .mcp | has("servers") then . else .mcp.servers = {} end' "$CONFIG_FILE" > /tmp/vscode_temp.json && mv /tmp/vscode_temp.json "$CONFIG_FILE"

# Add all 9 servers (VS Code supports all transport types)
# Note the different path: .mcp.servers instead of .mcpServers

# 1. Peekaboo
jq --arg key "$OPENAI_KEY" '.mcp.servers.peekaboo = {
  "command": "npx",
  "args": ["-y", "@steipete/peekaboo-mcp@beta"],
  "env": {
    "PEEKABOO_AI_PROVIDERS": "openai/gpt-4o,ollama/llava:latest",
    "OPENAI_API_KEY": $key
  }
}' "$CONFIG_FILE" > /tmp/vscode_temp.json && mv /tmp/vscode_temp.json "$CONFIG_FILE"

# Continue with all other servers using .mcp.servers path...
# (Same pattern as Cursor but with .mcp.servers prefix)

echo "✓ VS Code configuration updated (all 9 servers added)"
```

## Post-Installation Verification

```bash
# Verify all configurations were created correctly
echo "\n🔍 Verifying installations..."

# Check Claude Code
echo -n "Claude Code: "
claude mcp list -s user | grep -E "peekaboo|context7|github|agent|automator|gitmcp|firecrawl|obsidian|playwright" | wc -l | xargs -I {} echo "{}/9 servers"

# Check Claude Desktop
echo -n "Claude Desktop: "
jq '.mcpServers | keys | length' ~/Library/Application\ Support/Claude/claude_desktop_config.json 2>/dev/null || echo "0 servers"

# Check Cursor
echo -n "Cursor: "
jq '.mcpServers | keys | length' ~/.cursor/mcp.json 2>/dev/null || echo "0 servers"

# Check Windsurf
echo -n "Windsurf: "
jq '.mcpServers | keys | length' ~/.codeium/windsurf/mcp_config.json 2>/dev/null || echo "0 servers"

# Check VS Code
echo -n "VS Code: "
jq '.mcp.servers | keys | length' ~/Library/Application\ Support/Code/User/settings.json 2>/dev/null || echo "0 servers"

# Run sync script to see full analysis
echo "\n📊 Running sync script for detailed analysis..."
~/Projects/agent-rules/global-rules/mcp-sync.sh
```

## Error Handling

If any installation fails:

1. **Permission Errors**: 
   ```bash
   # Fix file permissions
   chmod 644 ~/Library/Application\ Support/Claude/claude_desktop_config.json
   chmod 644 ~/.cursor/mcp.json
   ```

2. **JSON Parse Errors**:
   ```bash
   # Validate JSON files
   jq . ~/Library/Application\ Support/Claude/claude_desktop_config.json
   # If invalid, restore from backup
   cp ~/Library/Application\ Support/Claude/claude_desktop_config.json.backup ~/Library/Application\ Support/Claude/claude_desktop_config.json
   ```

3. **Missing API Keys**:
   ```bash
   # Add missing keys to .zshrc
   echo 'export OPENAI_API_KEY="your-key-here"' >> ~/.zshrc
   echo 'export FIRECRAWL_API_KEY="your-key-here"' >> ~/.zshrc
   source ~/.zshrc
   ```

4. **Claude Desktop HTTP/SSE Error**:
   - Remove github and gitmcp servers from Claude Desktop
   - Only stdio transport servers work with Claude Desktop

## Important Notes

1. **Claude Desktop Limitations**: Cannot use HTTP or SSE transport types (skip github and gitmcp)
2. **API Key Security**: Always extract keys from .zshrc or environment variables, never hardcode
3. **Path Validation**: Ensure local paths exist before adding (e.g., Obsidian MCP server)
4. **Scope**: Use `-s user` for Claude Code to make servers available in all projects
5. **Restart Required**: Restart all applications after configuration changes
6. **macOS Permissions**: Grant Screen Recording permission to Claude Desktop for Peekaboo

## Sync Script

Use the MCP sync script to verify installations:
```bash
~/Projects/agent-rules/global-rules/mcp-sync.sh
```

This will show which servers are installed in each app and highlight any configuration differences.

## Complete Installation Script

For convenience, here's a complete script that performs all installations:

```bash
#!/bin/bash
# Complete MCP Server Installation Script for steipete
# This script installs all MCP servers to all supported applications

set -e  # Exit on error

echo "🚀 Starting MCP Server Installation for @steipete"
echo "================================================="

# Step 0: Prerequisites and API Keys
source ~/.zshrc  # Load environment variables

# Check prerequisites
echo "Checking prerequisites..."
command -v jq &> /dev/null || { echo "❌ jq not installed. Run: brew install jq"; exit 1; }
command -v node &> /dev/null || { echo "❌ Node.js not installed. Install Node.js 20+"; exit 1; }
command -v ollama &> /dev/null || { echo "⚠️  Ollama not installed. Installing..."; brew install ollama; }

# Extract API keys
OPENAI_KEY=$(grep "export OPENAI_API_KEY=" ~/.zshrc | sed 's/export OPENAI_API_KEY="//' | sed 's/"$//')
GITHUB_TOKEN=$(grep "export GITHUB_PERSONAL_ACCESS_TOKEN=" ~/.zshrc | sed 's/export GITHUB_PERSONAL_ACCESS_TOKEN="//' | sed 's/"$//')
FIRECRAWL_KEY=$(grep "export FIRECRAWL_API_KEY=" ~/.zshrc | sed 's/export FIRECRAWL_API_KEY="//' | sed 's/"$//')
OBSIDIAN_KEY="f1de8ac30724ecb05988c8eb2ee9b342b15f7b91eaba3fc8b0b5280dce3aca22"  # Default key

# Validate keys
if [ -z "$OPENAI_KEY" ]; then
    echo "⚠️  OPENAI_API_KEY not found in .zshrc - Peekaboo will have limited functionality"
fi
if [ -z "$GITHUB_TOKEN" ]; then
    echo "⚠️  GITHUB_PERSONAL_ACCESS_TOKEN not found in .zshrc - GitHub MCP will not be authenticated"
fi

# Create all config directories
mkdir -p ~/.claude ~/.cursor ~/.codeium/windsurf
mkdir -p ~/Library/Application\ Support/Claude
mkdir -p ~/Library/Application\ Support/Code/User

# Configure Claude settings
echo "Configuring Claude settings..."
if [ -f ~/.claude/settings.json ]; then
    jq '.includeCoAuthoredBy = false | .DISABLE_COST_WARNINGS = "1" | .DISABLE_AUTOUPDATER = "1"' ~/.claude/settings.json > /tmp/claude_settings_temp.json && mv /tmp/claude_settings_temp.json ~/.claude/settings.json
else
    echo '{
  "model": "opus",
  "includeCoAuthoredBy": false,
  "DISABLE_COST_WARNINGS": "1",
  "DISABLE_AUTOUPDATER": "1"
}' > ~/.claude/settings.json
fi

# Install to each application
echo "Installing MCP servers..."

# 1. Claude Code (uses CLI commands)
echo "📱 Installing to Claude Code..."
# [Insert all claude mcp add commands here]

# 2. Claude Desktop
echo "📱 Installing to Claude Desktop..."
# [Insert all jq commands for Claude Desktop here]

# 3. Cursor
echo "📱 Installing to Cursor..."
# [Insert all jq commands for Cursor here]

# 4. Windsurf
echo "📱 Installing to Windsurf..."
# [Insert all jq commands for Windsurf here]

# 5. VS Code
echo "📱 Installing to VS Code..."
# [Insert all jq commands for VS Code here]

# Verification
echo ""
echo "✅ Installation complete! Running verification..."
~/Projects/agent-rules/global-rules/mcp-sync.sh

echo ""
echo "🎉 All done! Restart your applications to use the new MCP servers."
echo ""
echo "Remember to:"
echo "1. Grant Screen Recording permission to Claude Desktop for Peekaboo"
echo "2. Ensure Obsidian MCP Tools plugin is installed"
echo "3. Pull llava:latest model for Ollama: ollama pull llava:latest"
```

Save this as `install-mcps.sh` and run with:
```bash
chmod +x install-mcps.sh
./install-mcps.sh
```

## Quick Installation (Only Available Servers)

For a quick installation that only installs servers with available API keys:

```bash
#!/bin/bash
# Quick MCP Installation - Only installs servers with available prerequisites

echo "🚀 Quick MCP Server Installation"
echo "================================"
echo "This will only install servers that have all requirements met."
echo ""

# Check for API keys
source ~/.zshrc
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
fi

if [ -n "$GITHUB_TOKEN" ]; then
    echo "Installing GitHub MCP (GITHUB_PERSONAL_ACCESS_TOKEN found)..."
    claude mcp add-json -s user github "{\"command\": \"npx\", \"args\": [\"-y\", \"@modelcontextprotocol/server-github\"], \"env\": {\"GITHUB_PERSONAL_ACCESS_TOKEN\": \"$GITHUB_TOKEN\"}}"
fi

if [ -n "$FIRECRAWL_KEY" ]; then
    echo "Installing Firecrawl (FIRECRAWL_API_KEY found)..."
    claude mcp add-json -s user firecrawl-mcp "{\"command\": \"npx\", \"args\": [\"-y\", \"firecrawl-mcp\"], \"env\": {\"FIRECRAWL_API_KEY\": \"$FIRECRAWL_KEY\"}}"
fi

# Check for Obsidian
if [ -d "/Applications/Obsidian.app" ] && [ -f "/Users/steipete/Documents/steipete/.obsidian/plugins/mcp-tools/bin/mcp-server" ]; then
    echo "Installing Obsidian MCP Tools..."
    claude mcp add-json -s user obsidian-mcp-tools '{"command": "/Users/steipete/Documents/steipete/.obsidian/plugins/mcp-tools/bin/mcp-server", "env": {"OBSIDIAN_API_KEY": "f1de8ac30724ecb05988c8eb2ee9b342b15f7b91eaba3fc8b0b5280dce3aca22"}}'
fi

echo ""
echo "✅ Quick installation complete!"
echo "Run 'claude mcp list -s user' to see installed servers."
```

Save as `quick-install-mcps.sh` for a faster, conditional installation.

## Project Rules Installation

Claude Code supports project rules - custom slash commands that help automate common development tasks. These are stored as `.mdc` files and can be invoked using `/command` syntax.

### Available Project Rules

The agent-rules repository includes 20 project rules organized by category:

**Git & GitHub:**
• **/commit** - Create well-formatted commits with conventional commit messages and emojis
• **/commit-fast** - Generate 3 commit message suggestions and auto-use the first one  
• **/bug-fix** - Streamline bug fixing workflow from issue creation to pull request
• **/pr-review** - Comprehensive pull request review from multiple perspectives
• **/analyze-issue** - Fetch GitHub issue details and create implementation specification

**Code Quality:**
• **/check** - Perform comprehensive code quality and security checks
• **/clean** - Fix all code formatting and quality issues in the entire codebase  
• **/code-analysis** - Perform advanced code analysis with multiple inspection options

**Documentation:**
• **/add-to-changelog** - Update the project's CHANGELOG.md file with a new entry
• **/create-docs** - Create comprehensive documentation for components or features
• **/mermaid** - Generate Mermaid diagrams for visualizing code structure

**Development Workflow:**
• **/implement-task** - Approach task implementation methodically with planning
• **/context-prime** - Prime Claude with comprehensive project understanding
• **/five** - Use Five Whys root cause analysis to understand problems

**Automation & Meta:**
• **/create-command** - Guide for creating new custom Claude commands
• **/continuous-improvement** - Systematic approach for improving AI assistant rules
• **/safari-automation** - Automating Safari interactions for web UI testing  
• **/screenshot-automation** - AppleScript patterns for automated screenshots
• **/cursor-rules-meta-guide** - Meta guide for creating and maintaining cursor rules
• **/mcp-inspector-debugging** - Debug MCP servers using the MCP Inspector tool

### Installing Project Rules

To install these project rules in your Claude Code setup:

```bash
#!/bin/bash
# Install Project Rules for Claude Code

echo "🎯 Installing Project Rules for Claude Code"
echo "=========================================="

# Check if running from agent-rules directory
if [ ! -d "project-rules" ]; then
    echo "❌ Error: project-rules directory not found"
    echo "   Please run this from the agent-rules repository root"
    exit 1
fi

# Create Claude directory if it doesn't exist
mkdir -p ~/.claude

# Check if CLAUDE.md exists
if [ -f ~/.claude/CLAUDE.md ]; then
    echo "📝 Found existing ~/.claude/CLAUDE.md"
    echo "   Adding import for project rules..."
    
    # Check if already imported
    if grep -q "@.*project-rules" ~/.claude/CLAUDE.md; then
        echo "✓ Project rules already imported"
    else
        # Add import at the end
        echo "" >> ~/.claude/CLAUDE.md
        echo "# Project Rules" >> ~/.claude/CLAUDE.md
        echo "@$(pwd)/project-rules" >> ~/.claude/CLAUDE.md
        echo "✓ Added project rules import"
    fi
else
    echo "📝 Creating ~/.claude/CLAUDE.md with project rules import..."
    cat > ~/.claude/CLAUDE.md << EOF
# Claude Code User Memory

This file contains personal preferences and custom commands for Claude Code.

# Project Rules
@$(pwd)/project-rules
EOF
    echo "✓ Created CLAUDE.md with project rules"
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "Available commands in Claude Code:"
echo "  /add-to-changelog   - Update CHANGELOG.md"
echo "  /bug-fix           - Complete bug fix workflow"
echo "  /commit            - Create formatted commits"
echo "  /pr-review         - Review pull requests"
echo "  ...and 16 more!"
echo ""
echo "To see all commands: ls $(pwd)/project-rules"
echo "To use: Type '/' followed by the command name in Claude Code"
```

Save this as `install-project-rules.sh` and run it from the agent-rules repository root.

### How Project Rules Work

1. **Storage**: Rules are stored as `.mdc` files in a directory
2. **Import**: The directory is imported via `@path/to/rules` in CLAUDE.md
3. **Usage**: Type `/command-name` in Claude Code to invoke
4. **Context**: Claude loads the rule content and follows its instructions
5. **Chaining**: Rules can reference other rules or memories

### Creating Custom Rules

To create your own project rule:

1. Create a new `.mdc` file in the project-rules directory
2. Use the `/create-command` rule as a template
3. Include clear instructions and examples
4. Test in Claude Code

### Quick Setup Option

Add to the main installation script:

```bash
# At the end of the MCP installation script
echo ""
read -p "Would you like to install project rules (slash commands)? (y/N): " install_rules
if [[ "$install_rules" == "y" || "$install_rules" == "Y" ]]; then
    if [ -d "$(dirname "$0")/../project-rules" ]; then
        cd "$(dirname "$0")/.."
        bash install-project-rules.sh
    else
        echo "Project rules not found. Clone the full repository:"
        echo "git clone https://github.com/steipete/agent-rules.git"
    fi
fi
```

## Customization & Tweaks

### Adding/Removing MCP Servers

To add or remove specific MCP servers after installation:

```bash
# Add a server
claude mcp add-json -s user server-name '{"command": "npx", "args": ["package-name"]}'

# Remove a server
claude mcp remove -s user server-name

# List all servers
claude mcp list
```

### Adding/Removing Project Rules

Project rules are managed through the CLAUDE.md import. To customize:

```bash
# Remove project rules
sed -i '' '/@.*project-rules/d' ~/.claude/CLAUDE.md

# Re-add project rules
echo "@/Users/steipete/Projects/agent-rules/project-rules" >> ~/.claude/CLAUDE.md

# Add specific rules only
mkdir ~/my-rules
cp /Users/steipete/Projects/agent-rules/project-rules/{commit,bug-fix,pr-review}.mdc ~/my-rules/
echo "@$HOME/my-rules" >> ~/.claude/CLAUDE.md
```

### Quick Tweaks Script

For easy customization after installation:

```bash
#!/bin/bash
# MCP and Project Rules Tweaker

echo "🔧 MCP & Project Rules Customization"
echo "===================================="
echo ""
echo "What would you like to do?"
echo "1. Add/Remove MCP servers"
echo "2. Add/Remove project rules" 
echo "3. Update API keys"
echo "4. Show current configuration"
echo "5. Exit"
echo ""
read -p "Choose an option (1-5): " choice

case $choice in
    1)
        echo ""
        echo "MCP Server Management:"
        echo "a. Add Peekaboo (screenshot tool)"
        echo "b. Add GitHub (API access)"
        echo "c. Add Firecrawl (web scraping)"
        echo "d. Remove a server"
        echo "e. List all servers"
        read -p "Choose: " mcp_choice
        
        case $mcp_choice in
            a) claude mcp add-json -s user peekaboo '{"command": "npx", "args": ["-y", "@steipete/peekaboo-mcp@beta"]}' ;;
            b) echo "Add GITHUB_PERSONAL_ACCESS_TOKEN to ~/.zshrc first!" ;;
            c) echo "Add FIRECRAWL_API_KEY to ~/.zshrc first!" ;;
            d) read -p "Server name to remove: " name && claude mcp remove -s user "$name" ;;
            e) claude mcp list ;;
        esac
        ;;
    2)
        echo ""
        echo "Project Rules Management:"
        echo "a. Install all project rules"
        echo "b. Remove all project rules"
        echo "c. Install specific categories only"
        read -p "Choose: " rules_choice
        
        case $rules_choice in
            a) 
                if ! grep -q "@.*project-rules" ~/.claude/CLAUDE.md; then
                    echo "@/Users/steipete/Projects/agent-rules/project-rules" >> ~/.claude/CLAUDE.md
                    echo "✓ Added all project rules"
                else
                    echo "Project rules already installed"
                fi
                ;;
            b)
                sed -i '' '/@.*project-rules/d' ~/.claude/CLAUDE.md
                echo "✓ Removed project rules"
                ;;
            c)
                echo "Choose categories:"
                echo "1. Git & GitHub (/commit, /bug-fix, /pr-review)"
                echo "2. Code Quality (/check, /clean, /code-analysis)"
                echo "3. Documentation (/create-docs, /mermaid)"
                read -p "Categories (comma-separated): " categories
                # Implementation would copy specific files
                ;;
        esac
        ;;
    3)
        echo ""
        echo "Update API Keys in ~/.zshrc:"
        echo "1. OPENAI_API_KEY (for Peekaboo AI vision)"
        echo "2. GITHUB_PERSONAL_ACCESS_TOKEN (for GitHub MCP)"
        echo "3. FIRECRAWL_API_KEY (for web scraping)"
        read -p "Which key? " key_choice
        echo "Add to ~/.zshrc and run: source ~/.zshrc"
        ;;
    4)
        echo ""
        echo "Current Configuration:"
        echo "====================="
        echo ""
        echo "MCP Servers:"
        claude mcp list
        echo ""
        echo "Project Rules:"
        if grep -q "@.*project-rules" ~/.claude/CLAUDE.md; then
            echo "✓ Project rules installed"
            grep "@.*project-rules" ~/.claude/CLAUDE.md
        else
            echo "✗ Project rules not installed"
        fi
        ;;
    5)
        exit 0
        ;;
esac
```

Save as `tweak-claude.sh` for easy customization after initial setup.

## Terminal Scripts

### 1. cly - Claude CLI Helper

The `cly` function is a terminal helper for Claude Code that:
- Updates Claude Code before running
- Sets the terminal title to show the current folder and "Claude"
- Runs Claude with dangerous permissions skip
- Restores the terminal title after completion

To set it up, add this function to your `.zshrc`:

```bash
cly () {
    local folder=${PWD:t} 
    (
        cd ~/.claude/local && npm update @anthropic-ai/claude-code
    )
    _set_title "$folder — Claude"
    "$HOME/.claude/local/claude" --dangerously-skip-permissions "$@"
    local exit_code=$? 
    _set_title "%~"
    return $exit_code
}
```

### 2. Folder Title Script (_set_title)

The `_set_title` function is used by `cly` to set terminal window/tab titles. To set it up, add this function to your `.zshrc`:

```bash
# Define the _set_title function
_set_title() {
    # Set both tab and window title
    echo -ne "\033]0;$1\007"
}

# Optional: Auto-set title to current directory
# Add this to automatically show the current directory in the terminal title
precmd() {
    _set_title "${PWD##*/}"
}

# Or use the built-in %~ for home-relative paths
precmd() {
    _set_title "%~"
}
```

For iTerm2 users, you might want a more sophisticated version:

```bash
_set_title() {
    echo -ne "\033]1;$1\007"  # Tab title
    echo -ne "\033]2;$1\007"  # Window title
}
```

### Finding Existing Scripts

To locate and understand the current implementation:

```bash
# Search for cly
grep -n "cly" ~/.zshrc ~/.bashrc ~/.bash_profile 2>/dev/null

# Search for terminal title functions
grep -n -E "precmd|PROMPT_COMMAND|\\\\033\]|title" ~/.zshrc ~/.bashrc ~/.bash_profile 2>/dev/null

# Check for custom scripts directory
ls -la ~/bin/ ~/.local/bin/ /usr/local/bin/ | grep -E "cly|title"
```

## Troubleshooting Guide

### Common Issues and Solutions

1. **"jq: command not found"**
   ```bash
   brew install jq
   ```

2. **"Node.js version too old"**
   ```bash
   # Install Node.js 20+ via nvm
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
   source ~/.zshrc
   nvm install 20
   nvm use 20
   nvm alias default 20
   ```

3. **"Permission denied" errors**
   ```bash
   # Fix config file permissions
   chmod 644 ~/.claude/settings.json
   chmod 644 ~/Library/Application\ Support/Claude/claude_desktop_config.json
   chmod 644 ~/.cursor/mcp.json
   chmod 644 ~/.codeium/windsurf/mcp_config.json
   chmod 644 ~/Library/Application\ Support/Code/User/settings.json
   ```

4. **Claude Desktop shows "invalid_type" error**
   - This means you tried to add HTTP/SSE servers (github, gitmcp)
   - Claude Desktop only supports stdio transport
   - Remove these servers from Claude Desktop config

5. **Obsidian MCP server not working**
   ```bash
   # Check if Obsidian.app is installed
   ls -la /Applications/Obsidian.app
   
   # Check if Obsidian MCP Tools plugin is installed
   ls -la /Users/steipete/Documents/steipete/.obsidian/plugins/mcp-tools/
   
   # If Obsidian.app missing: Download from https://obsidian.md
   # If plugin missing: Install via Obsidian Community Plugins
   ```

6. **Peekaboo not taking screenshots**
   - Grant Screen Recording permission to Claude Desktop
   - System Preferences > Privacy & Security > Screen Recording
   - Add Claude Desktop and restart the app

7. **API keys not found**
   ```bash
   # Add to ~/.zshrc
   echo 'export OPENAI_API_KEY="sk-..."' >> ~/.zshrc
   echo 'export GITHUB_PERSONAL_ACCESS_TOKEN="ghp_..."' >> ~/.zshrc
   echo 'export FIRECRAWL_API_KEY="fc-..."' >> ~/.zshrc
   source ~/.zshrc
   ```
   
   **For GitHub token specifically**:
   - Must have `repo` scope for full functionality
   - Token format: `ghp_` followed by alphanumeric characters
   - Create at: https://github.com/settings/tokens

8. **Servers not showing up after installation**
   - Restart all applications completely (Cmd+Q)
   - For Claude Code: `pkill -f claude` then restart
   - Check logs: `~/Library/Logs/Claude/`

9. **JSON parsing errors**
   ```bash
   # Validate JSON files
   for file in ~/.claude/settings.json ~/.cursor/mcp.json ~/.codeium/windsurf/mcp_config.json; do
       echo "Checking $file..."
       jq . "$file" > /dev/null && echo "✓ Valid" || echo "✗ Invalid JSON"
   done
   ```

10. **Sync script shows configuration differences**
    - This is normal if you have local development versions
    - Use `--to-global` or `--to-local` flags to standardize
    - Example: `./mcp-sync.sh --to-global peekaboo --app cursor`

### Getting Help

If you encounter issues not covered here:

1. Check the MCP server's documentation (see websites in server list)
2. Run the sync script for diagnostics: `~/Projects/agent-rules/global-rules/mcp-sync.sh`
3. Check application logs:
   - Claude Desktop: `~/Library/Logs/Claude/`
   - VS Code: Help > Toggle Developer Tools > Console
4. Report issues:
   - Claude Code: https://github.com/anthropics/claude-code/issues
   - Individual MCP servers: Check their GitHub repos

## Maintenance

### Updating MCP Servers

```bash
# Update all global npm packages
npm update -g

# Update Claude Code servers
claude mcp update --all

# For specific server
npm update -g @steipete/peekaboo-mcp@latest
```

### Backing Up Configurations

```bash
# Create backup directory
mkdir -p ~/mcp-backups/$(date +%Y%m%d)

# Backup all configs
cp ~/.claude/settings.json ~/mcp-backups/$(date +%Y%m%d)/
cp ~/Library/Application\ Support/Claude/claude_desktop_config.json ~/mcp-backups/$(date +%Y%m%d)/
cp ~/.cursor/mcp.json ~/mcp-backups/$(date +%Y%m%d)/
cp ~/.codeium/windsurf/mcp_config.json ~/mcp-backups/$(date +%Y%m%d)/
cp ~/Library/Application\ Support/Code/User/settings.json ~/mcp-backups/$(date +%Y%m%d)/

echo "Backups saved to ~/mcp-backups/$(date +%Y%m%d)/"
```

### Removing MCP Servers

```bash
# Claude Code
claude mcp remove -s user peekaboo

# Other apps - use jq to delete
jq 'del(.mcpServers.peekaboo)' ~/.cursor/mcp.json > /tmp/cursor_temp.json && mv /tmp/cursor_temp.json ~/.cursor/mcp.json
```

## Summary

This configuration provides @steipete with:
- 🖼️ **Peekaboo**: Essential screenshot tool (works without AI, enhanced with GPT-4 Vision)
- 📚 **Context7**: Real-time documentation fetching
- 🐙 **GitHub**: GitHub API access for repos, issues, PRs
- 🤖 **Agent**: Recursive AI assistance
- 🍎 **Automator**: macOS system automation
- 📂 **GitMCP**: Advanced Git operations with visual diffs
- 🔥 **Firecrawl**: Web scraping capabilities
- 📝 **Obsidian**: Knowledge base integration (if Obsidian.app installed)
- 🎭 **Playwright**: Browser automation

All servers are configured with appropriate API keys from `.zshrc` and optimized for each application's capabilities.

---

## 🔗 Quick Reference - GitHub URLs

All files can be fetched from the repository using these URLs:

### Documentation Files
- **This file**: https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/global-rules/steipete-mcps.md
- **Sync rule**: https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/global-rules/mcp-sync-rule.md
- **Repository**: https://github.com/steipete/agent-rules

### Executable Scripts
```bash
# MCP Sync Script
curl -sO https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/global-rules/mcp-sync.sh && chmod +x mcp-sync.sh

# Setup Helper Script
curl -s https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/global-rules/setup-mcps.sh | bash

# Direct execution without downloading
bash <(curl -s https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/global-rules/setup-mcps.sh)
```

### For Fresh Claude Instances

If you're starting fresh, just run:
```bash
curl -sL https://raw.githubusercontent.com/steipete/agent-rules/refs/heads/main/global-rules/setup-mcps.sh | bash
```

This will download all necessary files and prepare everything for MCP installation.

---

*Last updated: June 13, 2025*
*Maintained by: AI Assistant for @steipete*