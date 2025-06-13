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
        echo "  Plugin available in Obsidian Community Plugins"
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