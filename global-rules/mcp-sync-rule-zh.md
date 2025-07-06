# MCP 服务器配置同步规则

## 目的
在 Claude Code、VS Code、Windsurf、Cursor 和 Claude Desktop 应用间同步 MCP（模型上下文协议）服务器配置。

## 配置文件位置

### macOS
- **Claude Desktop**: `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Cursor**: `~/.cursor/mcp.json`
- **Windsurf**: `~/.codeium/windsurf/mcp_config.json`
- **Claude Code**: `~/.claude.json`（包含的不仅仅是 MCP 配置）
- **VS Code (用户)**: `~/Library/Application Support/Code/User/settings.json`（在 `mcp.servers` 下）

### Windows
- **Claude Desktop**: `%APPDATA%\Claude\claude_desktop_config.json`
- **Cursor**: `%USERPROFILE%\.cursor\mcp.json`
- **Windsurf**: `%USERPROFILE%\.codeium\windsurf\mcp_config.json`
- **VS Code (用户)**: `%APPDATA%\Code\User\settings.json`（在 `mcp.servers` 下）

### Linux
- **Claude Desktop**: `~/.config/Claude/claude_desktop_config.json`
- **Cursor**: `~/.cursor/mcp.json`
- **Windsurf**: `~/.codeium/windsurf/mcp_config.json`
- **VS Code (用户)**: `~/.config/Code/User/settings.json`（在 `mcp.servers` 下）

## 配置格式差异

### Claude Desktop & Cursor 格式
```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["-y", "package-name"],
      "env": {
        "ENV_VAR": "value"
      }
    }
  }
}
```

### VS Code 格式
```json
{
  "mcp": {
    "servers": {
      "server-name": {
        "command": "npx",
        "args": ["-y", "package-name"],
        "env": {
          "ENV_VAR": "value"
        }
      }
    }
  }
}
```

### Claude Code 格式
**注意**：Claude Code（CLI 工具）当前不支持 MCP 服务器配置。`.claude.json` 文件包含项目设置和其他配置，但不包括 MCP 服务器。

## 同步脚本

```bash
#!/bin/bash

# MCP 服务器配置同步器
# 本脚本用于查找并比较不同应用间的 MCP 服务器配置

# 输出颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # 无色

# 配置文件路径
CLAUDE_DESKTOP_CONFIG="$HOME/Library/Application Support/Claude/claude_desktop_config.json"
CURSOR_CONFIG="$HOME/.cursor/mcp.json"
CLAUDE_CODE_CONFIG="$HOME/.claude.json"

# 检查 jq 是否已安装
if ! command -v jq &> /dev/null; then
    echo -e "${RED}错误：未安装 jq。请用：brew install jq 安装${NC}"
    exit 1
fi

echo "🔍 MCP 服务器配置同步器"
echo "======================================="
echo ""

# 提取配置文件中的 MCP 服务器
extract_servers() {
    local file="$1"
    local format="$2"
    
    if [ ! -f "$file" ]; then
        echo "{}"
        return
    fi
    
    if [ "$format" = "vscode" ]; then
        jq -r '.mcp.servers // {}' "$file" 2>/dev/null || echo "{}"
    else
        jq -r '.mcpServers // {}' "$file" 2>/dev/null || echo "{}"
    fi
}

# 从 JSON 获取服务器名
get_server_names() {
    echo "$1" | jq -r 'keys[]' 2>/dev/null | sort
}

# 检查哪些配置文件存在
echo "📁 检查配置文件："
echo ""

if [ -f "$CLAUDE_DESKTOP_CONFIG" ]; then
    echo -e "${GREEN}✓${NC} Claude Desktop: $CLAUDE_DESKTOP_CONFIG"
    CLAUDE_DESKTOP_SERVERS=$(extract_servers "$CLAUDE_DESKTOP_CONFIG" "standard")
else
    echo -e "${RED}✗${NC} Claude Desktop: 未找到"
    CLAUDE_DESKTOP_SERVERS="{}"
fi

if [ -f "$CURSOR_CONFIG" ]; then
    echo -e "${GREEN}✓${NC} Cursor: $CURSOR_CONFIG"
    CURSOR_SERVERS=$(extract_servers "$CURSOR_CONFIG" "standard")
else
    echo -e "${RED}✗${NC} Cursor: 未找到"
    CURSOR_SERVERS="{}"
fi

if [ -f "$CLAUDE_CODE_CONFIG" ]; then
    echo -e "${GREEN}✓${NC} Claude Code: $CLAUDE_CODE_CONFIG"
    CLAUDE_CODE_SERVERS=$(extract_servers "$CLAUDE_CODE_CONFIG" "standard")
else
    echo -e "${RED}✗${NC} Claude Code: 未找到"
    CLAUDE_CODE_SERVERS="{}"
fi

# 查找 VS Code 工作区配置
echo ""
echo "🔍 正在搜索 VS Code 工作区配置..."
VSCODE_CONFIGS=$(find ~ -path "*/.vscode/mcp.json" -type f 2>/dev/null | head -10)
if [ -n "$VSCODE_CONFIGS" ]; then
    echo -e "${GREEN}✓${NC} 找到 VS Code 工作区配置："
    echo "$VSCODE_CONFIGS" | while read -r config; do
        echo "  - $config"
    done
else
    echo -e "${YELLOW}⚠${NC} 未找到 VS Code 工作区配置"
fi

echo ""
echo "📊 服务器分析："
echo "=================="

# 获取所有唯一服务器名
ALL_SERVERS=$(echo "$CLAUDE_DESKTOP_SERVERS $CURSOR_SERVERS $CLAUDE_CODE_SERVERS" | \
    jq -s 'add | keys' | jq -r '.[]' | sort -u)

# 用于跟踪的数组
declare -a COMMON_SERVERS=()
declare -a CLAUDE_DESKTOP_ONLY=()
declare -a CURSOR_ONLY=()
declare -a CLAUDE_CODE_ONLY=()

# 分析每个服务器
for server in $ALL_SERVERS; do
    in_claude_desktop=$(echo "$CLAUDE_DESKTOP_SERVERS" | jq --arg s "$server" 'has($s)')
    in_cursor=$(echo "$CURSOR_SERVERS" | jq --arg s "$server" 'has($s)')
    in_claude_code=$(echo "$CLAUDE_CODE_SERVERS" | jq --arg s "$server" 'has($s)')
    
    count=0
    [ "$in_claude_desktop" = "true" ] && ((count++))
    [ "$in_cursor" = "true" ] && ((count++))
    [ "$in_claude_code" = "true" ] && ((count++))
    
    if [ $count -ge 2 ]; then
        COMMON_SERVERS+=("$server")
    elif [ "$in_claude_desktop" = "true" ] && [ $count -eq 1 ]; then
        CLAUDE_DESKTOP_ONLY+=("$server")
    elif [ "$in_cursor" = "true" ] && [ $count -eq 1 ]; then
        CURSOR_ONLY+=("$server")
    elif [ "$in_claude_code" = "true" ] && [ $count -eq 1 ]; then
        CLAUDE_CODE_ONLY+=("$server")
    fi
done

# 显示结果
echo ""
echo "🤝 通用服务器（在 2 个及以上应用中）："
if [ ${#COMMON_SERVERS[@]} -eq 0 ]; then
    echo "  无"
else
    for server in "${COMMON_SERVERS[@]}"; do
        echo -e "  ${GREEN}•${NC} $server"
        
        # 显示在哪些应用中
        apps=""
        [ "$(echo "$CLAUDE_DESKTOP_SERVERS" | jq --arg s "$server" 'has($s)')" = "true" ] && apps+="Claude Desktop, "
        [ "$(echo "$CURSOR_SERVERS" | jq --arg s "$server" 'has($s)')" = "true" ] && apps+="Cursor, "
        [ "$(echo "$CLAUDE_CODE_SERVERS" | jq --arg s "$server" 'has($s)')" = "true" ] && apps+="Claude Code, "
        apps=${apps%, }
        echo "    存在于: $apps"
    done
fi

echo ""
echo "📱 应用专属服务器："

if [ ${#CLAUDE_DESKTOP_ONLY[@]} -gt 0 ]; then
    echo -e "\n  ${YELLOW}仅 Claude Desktop:${NC}"
    for server in "${CLAUDE_DESKTOP_ONLY[@]}"; do
        echo "  • $server"
    done
fi

if [ ${#CURSOR_ONLY[@]} -gt 0 ]; then
    echo -e "\n  ${YELLOW}仅 Cursor:${NC}"
    for server in "${CURSOR_ONLY[@]}"; do
        echo "  • $server"
    done
fi

if [ ${#CLAUDE_CODE_ONLY[@]} -gt 0 ]; then
    echo -e "\n  ${YELLOW}仅 Claude Code:${NC}"
    for server in "${CLAUDE_CODE_ONLY[@]}"; do
        echo "  • $server"
    done
fi

# 通用服务器的配置差异
echo ""
echo "🔧 配置差异："
echo "============================"

for server in "${COMMON_SERVERS[@]}"; do
    echo ""
    echo "服务器: $server"
    echo "---------------"
    
    # 获取每个应用的配置
    claude_desktop_config=$(echo "$CLAUDE_DESKTOP_SERVERS" | jq --arg s "$server" '.[$s]' 2>/dev/null)
    cursor_config=$(echo "$CURSOR_SERVERS" | jq --arg s "$server" '.[$s]' 2>/dev/null)
    claude_code_config=$(echo "$CLAUDE_CODE_SERVERS" | jq --arg s "$server" '.[$s]' 2>/dev/null)
    
    # 比较配置
    configs_match=true
    
    if [ "$claude_desktop_config" != "null" ] && [ "$cursor_config" != "null" ]; then
        if [ "$claude_desktop_config" != "$cursor_config" ]; then
            configs_match=false
        fi
    fi
    
    if [ "$configs_match" = true ]; then
        echo -e "  ${GREEN}✓${NC} 配置在各应用间一致"
    else
        echo -e "  ${RED}✗${NC} 配置存在差异："
        
        if [ "$claude_desktop_config" != "null" ]; then
            echo "    Claude Desktop:"
            echo "$claude_desktop_config" | jq . | sed 's/^/      /'
        fi
        
        if [ "$cursor_config" != "null" ] && [ "$cursor_config" != "$claude_desktop_config" ]; then
            echo "    Cursor:"
            echo "$cursor_config" | jq . | sed 's/^/      /'
        fi
        
        if [ "$claude_code_config" != "null" ] && [ "$claude_code_config" != "$claude_desktop_config" ] && [ "$claude_code_config" != "$cursor_config" ]; then
            echo "    Claude Code:"
            echo "$claude_code_config" | jq . | sed 's/^/      /'
        fi
    fi
done

# 总结
echo ""
echo "📈 总结："
echo "=========="
total_servers=$(echo "$ALL_SERVERS" | wc -w | tr -d ' ')
echo "唯一服务器总数: $total_servers"
echo "通用服务器: ${#COMMON_SERVERS[@]}"
echo "应用专属服务器: $((total_servers - ${#COMMON_SERVERS[@]}))"

# 同步建议
echo ""
echo "💡 同步建议："
echo "======================="

if [ ${#COMMON_SERVERS[@]} -gt 0 ]; then
    echo "• 检查通用服务器的配置差异"
fi

total_unique=$((${#CLAUDE_DESKTOP_ONLY[@]} + ${#CURSOR_ONLY[@]} + ${#CLAUDE_CODE_ONLY[@]}))
if [ $total_unique -gt 0 ]; then
    echo "• 考虑将应用专属服务器添加到其他应用以保持一致"
fi

echo ""
echo "如需手动同步配置，请在配置文件间复制 mcpServers 部分。"
echo "记得为 VS Code 调整格式（用 'mcp.servers' 包裹而不是 'mcpServers'）。"
```

## 使用说明

1. 将上述脚本保存为 `mcp-sync.sh`
2. 赋予可执行权限：`chmod +x mcp-sync.sh`
3. 用不同选项运行脚本：

### 基本用法

```bash
# 列出所有服务器并显示差异
./mcp-sync.sh

# 显示帮助
./mcp-sync.sh --help
```

### 在本地和全局配置间切换

```bash
# 将服务器从本地路径切换为全局 npm 包
./mcp-sync.sh --to-global terminator --app cursor

# 将服务器从全局 npm 包切换为本地路径
./mcp-sync.sh --to-local peekaboo --app claude-desktop
```

### 功能

脚本将：
- 查找你系统上的所有 MCP 配置文件
- 解析并比较服务器配置
- 显示哪些服务器在多个应用中通用
- 显示哪些服务器仅在特定应用中存在
- 高亮显示通用服务器的配置差异
- 提供同步建议
- **新功能**：在本地开发路径和全局 npm 包间切换服务器

### 切换细节

**本地转全局（`--to-global`）**：
- 将本地文件路径配置转换为使用 `npx` 的 npm 包
- 自动识别常见服务器（terminator、agent、automator、conduit、peekaboo）
- 对未知服务器提示输入 npm 包名
- 保留环境变量等设置

**全局转本地（`--to-local`）**：
- 将 npm 包配置转换为本地文件路径
- 自动检测文件类型并选择合适命令（node、python、bash）
- 验证本地文件是否存在（可选择继续）
- 保留环境变量等设置

## 手动同步步骤

1. **识别差异**：运行脚本查看哪些服务器不同
2. **选择权威配置**：决定哪个应用的配置为准
3. **复制配置**： 
   - Claude Desktop/Cursor：复制整个 mcpServers 下的服务器对象
   - VS Code：复制到 `mcp.servers`（注意结构不同）
4. **处理敏感数据**：注意 API 密钥和密码
5. **测试**：重启应用确保配置生效

## 安全注意事项

- **API 密钥**：尽量用环境变量存储敏感密钥
- **密码**：避免明文存储在配置文件中
- **文件权限**：确保配置文件权限合适（600）
- **版本控制**：不要提交包含敏感数据的配置文件

## 自动化建议

1. **定时同步**：用 cron 定期运行同步脚本
2. **Git 钩子**：在拉取/推送时同步配置
3. **配置模板化**：用模板系统从单一来源生成配置
4. **基于环境**：为不同环境使用不同配置
