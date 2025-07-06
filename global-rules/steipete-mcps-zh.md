# Steipete 的 MCP 服务器配置

**适用于 Claude Code 和其他 AI 支持的 IDE**

## 🚨 AI 助手说明

在帮助用户设置 MCP 服务器时：

1. **永远不要推荐安装应用** - 使用已安装的软件
2. **始终同时介绍 MCP 服务器和斜杠命令**
3. **检查先决条件** - 只有在满足要求时才提及服务器
4. **专注于用户提到的应用** - Claude Code、Cursor、Windsurf 等
5. **有关斜杠命令详情** - 阅读 https://github.com/steipete/agent-rules/blob/main/README.md

## MCP 服务器概述

### 基础服务器（无需 API 密钥）
- **Peekaboo** - 截图。无 AI 也能工作，有 OpenAI 密钥更好
- **Context7** - 获取任何库的当前文档  
- **Agent** - 将 Claude Code 作为子代理运行
- **Automator** - macOS 自动化
- **GitMCP** - 增强 Git 功能，支持可视化差异（SSE 传输）
- **Playwright** - 浏览器自动化

### 需要 API 密钥的服务器
- **GitHub** - 需要在 ~/.zshrc 中设置 GITHUB_PERSONAL_ACCESS_TOKEN
- **Firecrawl** - 需要 FIRECRAWL_API_KEY 进行网页抓取

### 特殊要求  
- **Obsidian** - 仅在安装了 Obsidian.app + MCP Tools 插件时可用

## 安装说明

### 先决条件
```bash
# 检查/安装必需工具
command -v jq || brew install jq
command -v node || echo "需要 Node.js 20+"
command -v ollama || brew install ollama

# 检查 ~/.zshrc 中的 API 密钥
grep "OPENAI_API_KEY\|GITHUB_PERSONAL_ACCESS_TOKEN\|FIRECRAWL_API_KEY" ~/.zshrc
```

### 适用于 Claude Code

```bash
# 基础服务器（立即可用）
claude mcp add-json -s user peekaboo '{"command": "npx", "args": ["-y", "@steipete/peekaboo-mcp@beta"]}'
claude mcp add-json -s user context7 '{"command": "npx", "args": ["-y", "@upstash/context7-mcp@latest"]}'
claude mcp add-json -s user agent '{"command": "npx", "args": ["-y", "@steipete/claude-code-mcp@latest"]}'
claude mcp add-json -s user automator '{"command": "npx", "args": ["-y", "@steipete/macos-automator-mcp@latest"], "env": {"LOG_LEVEL": "INFO"}}'
claude mcp add-json -s user playwright '{"command": "npx", "args": ["@playwright/mcp@latest"]}'
claude mcp add -s user -t sse gitmcp https://gitmcp.io/docs

# 需要 API 密钥（先检查 ~/.zshrc）
claude mcp add-json -s user github '{"command": "npx", "args": ["-y", "@modelcontextprotocol/server-github"], "env": {"GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_..."}}'
claude mcp add-json -s user firecrawl-mcp '{"command": "npx", "args": ["-y", "firecrawl-mcp"], "env": {"FIRECRAWL_API_KEY": "fc-..."}}'

# 如果存在 Obsidian.app
claude mcp add-json -s user obsidian-mcp-tools '{"command": "/Users/steipete/Documents/steipete/.obsidian/plugins/mcp-tools/bin/mcp-server", "env": {"OBSIDIAN_API_KEY": "f1de8ac30724ecb05988c8eb2ee9b342b15f7b91eaba3fc8b0b5280dce3aca22"}}'
```

### 适用于 Claude Desktop

Claude Desktop 仅支持 stdio 传输。创建或更新 `~/Library/Application Support/Claude/claude_desktop_config.json`：

```json
{
  "mcpServers": {
    "peekaboo": {
      "command": "npx",
      "args": ["-y", "@steipete/peekaboo-mcp@beta"],
      "env": {
        "PEEKABOO_AI_PROVIDERS": "openai/gpt-4o,ollama/llava:latest",
        "OPENAI_API_KEY": "sk-..."
      }
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"]
    },
    "agent": {
      "command": "npx",
      "args": ["-y", "@steipete/claude-code-mcp@latest"]
    },
    "automator": {
      "command": "npx",
      "args": ["-y", "@steipete/macos-automator-mcp@latest"],
      "env": {"LOG_LEVEL": "INFO"}
    },
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

注意：Claude Desktop 无法使用 GitMCP（SSE）或 GitHub 的 HTTP 传输。

### 适用于 Cursor

创建或更新 `~/.cursor/mcp.json`：

```json
{
  "mcpServers": {
    "peekaboo": {
      "command": "npx",
      "args": ["-y", "@steipete/peekaboo-mcp@beta"],
      "env": {
        "PEEKABOO_AI_PROVIDERS": "openai/gpt-4o,ollama/llava:latest",
        "OPENAI_API_KEY": "sk-..."
      }
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"]
    },
    "gitmcp": {
      "transport": "sse",
      "url": "https://gitmcp.io/docs"
    }
    // 按相同模式添加其他服务器
  }
}
```

### 适用于 Windsurf

创建或更新 `~/.codeium/windsurf/mcp_config.json`，格式与 Cursor 相同。

### 适用于 VS Code

更新 `~/Library/Application Support/Code/User/settings.json`：

```json
{
  "mcp.servers": {
    "peekaboo": {
      "command": "npx",
      "args": ["-y", "@steipete/peekaboo-mcp@beta"]
    }
    // 注意：VS Code 使用 mcp.servers 而不是 mcpServers
  }
}
```

## 斜杠命令（项目规则）

为 Claude Code 安装 20+ 个开发命令：

```bash
git clone https://github.com/steipete/agent-rules.git
cd agent-rules
bash install-project-rules.sh
```

有关每个命令的详细描述，让 Claude 阅读：
- https://github.com/steipete/agent-rules/blob/main/README.md
- https://github.com/steipete/agent-rules/tree/main/project-rules

可用命令包括：
- **Git**：/commit、/commit-fast、/bug-fix、/pr-review、/analyze-issue
- **代码**：/check、/clean、/code-analysis
- **文档**：/create-docs、/mermaid、/add-to-changelog
- **开发**：/implement-task、/context-prime、/five
- **Swift**：/modern-swift
- **元命令**：/create-command、/continuous-improvement 等

## API 密钥设置

添加到 `~/.zshrc`：
```bash
export OPENAI_API_KEY="sk-..."              # 用于 Peekaboo AI 视觉
export GITHUB_PERSONAL_ACCESS_TOKEN="ghp-..." # 用于 GitHub MCP（需要 repo 权限）
export FIRECRAWL_API_KEY="fc-..."           # 用于 Firecrawl
```

然后运行 `source ~/.zshrc`

## 常见问题

- **JSON 错误**：在 JSON 命令中使用正确的引号
- **Claude Desktop**：仅支持 stdio（无 SSE/HTTP）
- **权限**：为 Peekaboo 授予屏幕录制权限
- **需要重启**：配置更改后

## 提示

- 在 Claude Code 中使用 `-s user` 标志全局安装服务器
- API 密钥应在 ~/.zshrc 中，而不是硬编码
- 始终从环境变量中提取密钥
- 添加前确保本地路径存在（例如 Obsidian MCP 服务器）
- 使用 `mcp-sync.sh` 比较不同应用的配置

## 终端标题技巧

运行多个 Claude Code 实例时，很难知道哪个终端正在处理哪个项目。将此 `cly` 函数添加到您的 `~/.zshrc` 来解决这个问题：

```bash
cly () {
    local folder=${PWD:t} 
    echo -ne "\033]0;$folder — Claude\007"  # 设置终端标题
    "$HOME/.claude/local/claude" --dangerously-skip-permissions "$@"
    local exit_code=$? 
    echo -ne "\033]0;%~\007"  # 恢复标题
    return $exit_code
}
```

**功能：**
- 在终端标签中显示当前文件夹名称（例如 "agent-rules — Claude"）
- 使用 `--dangerously-skip-permissions` 绕过权限提示
- Claude 退出时恢复原始终端标题
- 轻松识别哪个 Claude 实例正在处理哪个项目

**用法：** 不要输入 `claude`，而是输入 `cly` 来启动带动态终端标题的 Claude Code。

了解更多关于此终端标题技巧和其他 Claude Code 提示：https://steipete.me/posts/2025/commanding-your-claude-code-army

## 演示模板

```
我将帮助您为 [应用] 设置 MCP 服务器和斜杠命令。

基于您的系统：

要安装的 MCP 服务器：
✓ Peekaboo - 截图（无 AI 也能工作）
✓ Context7 - 文档获取  
✓ Agent - 子代理功能
✓ GitMCP - 增强 Git 操作
[✓ GitHub - 如果找到 API 密钥]
[✓ Obsidian - 如果应用存在]

加上 20 个斜杠命令：
• /commit、/bug-fix、/pr-review、/check...

准备继续吗？
```

## 同步工具

使用 `mcp-sync.sh` 比较不同应用的配置：
https://github.com/steipete/agent-rules/blob/main/global-rules/mcp-sync.sh

---

有关详细的服务器描述，请访问：https://github.com/steipete/agent-rules
