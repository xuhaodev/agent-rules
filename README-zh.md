[![中文](https://img.shields.io/badge/语言-中文-blue.svg)](README-zh.md) [![English](https://img.shields.io/badge/Language-English-red.svg)](README.md)

# AI助手规则集

为Claude Code和Cursor等AI编程助手收集的可重用规则和知识文档。

## 仓库结构

### 📁 project-rules/
AI助手在开发过程中遵循的可操作规则：

**开发工作流程** (致谢: [@vincenthopf](https://github.com/vincenthopf/claude-code))
- **[commit.mdc](./project-rules/commit.mdc)** - 使用规范格式和表情符号的标准提交
- **[commit-fast.mdc](./project-rules/commit-fast.mdc)** - 自动选择第一条消息的快速提交工作流程
- **[add-to-changelog.mdc](./project-rules/add-to-changelog.mdc)** - 遵循Keep a Changelog格式的结构化更新日志
- **[pr-review.mdc](./project-rules/pr-review.mdc)** - 多角色拉取请求审查清单

**代码质量与分析**
- **[check.mdc](./project-rules/check.mdc)** - 跨不同语言的全面代码质量检查
- **[clean.mdc](./project-rules/clean.mdc)** - 修复所有格式和代码检查问题
- **[code-analysis.mdc](./project-rules/code-analysis.mdc)** - 高级多方面代码分析选项

**问题解决与实现**
- **[analyze-issue.mdc](./project-rules/analyze-issue.mdc)** - GitHub问题分析和实现规范
- **[bug-fix.mdc](./project-rules/bug-fix.mdc)** - 从问题到PR的完整错误修复工作流程
- **[implement-task.mdc](./project-rules/implement-task.mdc)** - 系统化任务实现方法
- **[five.mdc](./project-rules/five.mdc)** - 五个为什么根本原因分析技术

**文档与可视化**
- **[create-docs.mdc](./project-rules/create-docs.mdc)** - 全面的文档生成
- **[mermaid.mdc](./project-rules/mermaid.mdc)** - 用于各种可视化的Mermaid图表生成

**项目设置与元数据**
- **[context-prime.mdc](./project-rules/context-prime.mdc)** - 全面加载项目上下文
- **[create-command.mdc](./project-rules/create-command.mdc)** - 创建新自定义命令的指南
- **[continuous-improvement.mdc](./project-rules/continuous-improvement.mdc)** - 改进AI助手规则的系统化方法
- **[cursor-rules-meta-guide.mdc](./project-rules/cursor-rules-meta-guide.mdc)** - 创建和维护Cursor规则的指南

**自动化与集成**
- **[mcp-inspector-debugging.mdc](./project-rules/mcp-inspector-debugging.mdc)** - 使用Inspector UI调试MCP服务器
- **[safari-automation.mdc](./project-rules/safari-automation.mdc)** - 高级Safari浏览器自动化技术
- **[screenshot-automation.mdc](./project-rules/screenshot-automation.mdc)** - 自动截图的AppleScript模式

**特定语言**
- **[modern-swift.mdc](./project-rules/modern-swift.mdc)** - 遵循Apple最新最佳实践的现代SwiftUI架构 (灵感来自 [Dimillian的"忘记MVVM"](https://dimillian.medium.com/swiftui-in-2025-forget-mvvm-262ff2bbd2ed))

### 📁 docs/
参考文档和知识库：
- **Swift开发**
  - [swift-observable.mdc](./docs/swift-observable.mdc) - 从ObservableObject迁移到@Observable宏的指南
  - [swift-observation.mdc](./docs/swift-observation.mdc) - Swift Observation框架文档
  - [swift-testing-api.mdc](./docs/swift-testing-api.mdc) - Swift Testing框架API参考
  - [swift-testing-playbook.mdc](./docs/swift-testing-playbook.mdc) - 迁移到Swift Testing的全面指南
  - [swift-argument-parser.mdc](./docs/swift-argument-parser.mdc) - Swift Argument Parser框架文档
  - [swift6-migration.mdc](./docs/swift6-migration.mdc) - 使用并发迁移到Swift 6的指南

- **MCP开发**
  - [mcp-best-practices.mdc](./docs/mcp-best-practices.mdc) - 构建模型上下文协议服务器的最佳实践
  - [mcp-releasing.mdc](./docs/mcp-releasing.mdc) - 将MCP服务器发布为NPM包的指南

### 📁 global-rules/
全局Claude Code配置和自动化脚本 (放置在 `~/.claude/CLAUDE.md`):
- **[github-issue-creation.mdc](./global-rules/github-issue-creation.mdc)** - 创建结构良好的GitHub问题 (致谢: [@nityeshaga](https://x.com/nityeshaga/status/1933113428379574367))
- **[mcp-peekaboo-setup.mdc](./global-rules/mcp-peekaboo-setup.mdc)** - Peekaboo视觉MCP服务器的设置指南
- **[terminal-title-wrapper.zsh](./global-rules/terminal-title-wrapper.zsh)** - 动态终端标题的ZSH包装器
- **[mcp-sync.sh](./global-rules/mcp-sync.sh)** - 在Claude安装之间同步MCP服务器的脚本
- **[mcp-sync-rule.md](./global-rules/mcp-sync-rule.md)** - MCP同步功能的文档

## 使用方法

### 针对 VSCode GitHub Copilot 用户：

1. 在 `./.github/instructions/`（项目本地）目录下创建或更新各自的 .instructions.md 文件。
2. 使用带有 `applyTo` 字段的 YAML 前置元数据来指定文件目标。
3. 规则名称和描述写在 markdown 正文内容中，而不是前置元数据中。
4. 注意：由于 VSCode 在 applyTo 字段中不支持多个 glob 的限制，所有规则均统一使用 `applyTo: "**"`，以实现通用适用和更高的

### 对于Cursor用户
1. 将任何`.mdc`文件从`project-rules/`复制到项目的`.cursor/rules/`目录
2. Cursor会根据前置元数据中的glob模式自动应用规则
3. 带有`alwaysApply: true`的规则将对所有文件生效
4. `docs/`中的文档可以根据需要引用或导入

### 对于Claude Code用户
1. 将任何`.mdc`文件的内容(不包括前置元数据)复制到您的`CLAUDE.md`文件中
2. 或在`CLAUDE.md`中使用`@import`语法引用整个文件
3. 放在项目根目录或`~/.claude/CLAUDE.md`中作为全局规则
4. 项目规则和文档都可以包含在内

## 全局Claude Code规则

这些是可以放置在`~/.claude/CLAUDE.md`中的强大全局规则，用于增强Claude Code在所有项目中的能力。基于["指挥您的Claude Code军团"](https://steipete.me/posts/2025/commanding-your-claude-code-army)的策略。

### 可用的全局规则

#### 1. GitHub问题创建
将功能描述转换为遵循最佳实践的结构良好的GitHub问题。
- **致谢:** [@nityeshaga](https://x.com/nityeshaga/status/1933113428379574367)
- **功能:** 仓库研究、约定分析、自动`gh issue create`集成
- **用法:** 提供功能描述和仓库URL

#### 2. MCP服务器设置 - Peekaboo
Peekaboo视觉MCP服务器的自动化设置。
- **功能:** 带AI分析的截图捕获、双提供商支持(OpenAI/Ollama)
- **安全性:** 从`~/.zshrc`安全提取API密钥
- **要求:** Node.js 20.0+、macOS 14.0+

#### 3. 终端标题管理
用于更好地组织多实例的动态终端标题。
- **功能:** 显示`~/path/to/project — Claude`格式
- **实现:** 带后台标题持久化的ZSH包装函数(`cly`)
- **好处:** 轻松识别多个Claude实例

### 安装

1. **创建Claude配置目录:**
   ```bash
   mkdir -p ~/.claude
   ```

2. **设置全局规则:**
   ```bash
   # 创建或编辑全局CLAUDE.md
   nano ~/.claude/CLAUDE.md
   # 从此仓库添加所需规则
   ```

3. **对于终端标题管理:**
   ```bash
   # 复制包装脚本
   cp global-rules/terminal-title-wrapper.zsh ~/.config/zsh/claude-wrapper.zsh
   mkdir -p ~/.config/zsh
   # 添加claude-wrapper.zsh内容
   
   # 在~/.zshrc中源文件
   echo '[[ -f ~/.config/zsh/claude-wrapper.zsh ]] && source ~/.config/zsh/claude-wrapper.zsh' >> ~/.zshrc
   ```

## 贡献

欢迎贡献您自己的规则！请确保它们：
1. 使用`.mdc`扩展名
2. 包含带有`description`、`globs`和`alwaysApply`字段的正确YAML前置元数据
3. 包含清晰、可操作的说明
4. 足够通用以便在项目之间重用
5. 放置在适当的目录中：
   - `project-rules/` 用于可操作的AI助手规则
   - `docs/` 用于参考文档

## 为什么使用这种格式？

此仓库使用`.mdc`(带配置的Markdown)格式，它提供了一种与Claude Code和Cursor无缝协作的统一方法：

- **Cursor** 原生支持带有YAML前置元数据的`.mdc`文件进行规则配置
- **Claude Code** 读取markdown内容，忽略前置元数据
- YAML前置元数据提供了Cursor用于智能规则应用的可选元数据(描述、文件glob、alwaysApply)
- 标准markdown内容确保跨不同AI助手的兼容性

这种统一格式意味着您可以在两种工具中使用相同的规则文件而无需修改。

## 许可证

MIT许可证 - 详情见[LICENSE](./LICENSE)
