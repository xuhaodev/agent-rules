---
description: 将 MCP (Model Context Protocol) 服务器作为 NPM 包发布的步骤和流程
globs: "package.json, **/package.json"
alwaysApply: false
---

# 发布 MCP 服务器

本文档概述了将 MCP (Model Context Protocol) 服务器的新版本作为 NPM 包发布的步骤。

## 自动化发布准备

许多 MCP 项目包含自动化的发布准备脚本，在发布前执行全面检查。运行命令：

```bash
npm run prepare-release
```

此脚本通常执行以下检查：
- **Git 状态**：确保您在主分支上且没有未提交的更改
- **必需字段**：验证 package.json 中的所有必需字段
- **依赖项**：检查缺失或过时的依赖项
- **安全审计**：运行 npm audit 检查漏洞
- **版本可用性**：确认版本尚未发布
- **版本一致性**：确保 package.json 和 package-lock.json 版本匹配
- **更新日志条目**：验证 CHANGELOG.md 是否有当前版本的条目
- **TypeScript**：编译并运行测试
- **TypeScript 声明**：验证是否生成了 .d.ts 文件
- **原生代码**（如适用）：为 Swift/其他语言运行格式化、检查和测试
- **构建验证**：构建所有内容并验证包
- **包大小**：如果包超过合理大小限制则发出警告
- **MCP 服务器冒烟测试**：使用简单的 JSON-RPC 请求测试服务器

如果所有检查都通过，请按照下面的手动步骤操作。

## 手动发布前步骤

1.  **更新版本号：**
    - 决定新的语义版本号（例如，`1.0.0-beta.3`、`1.0.0`、`1.1.0`）。
    - 更新 `package.json` 中的 `version` 字段。

2.  **更新文档：**
    - **`README.md`**：确保它准确反映最新功能、安装说明和任何破坏性更改。
    - **API 文档**：如果工具模式或服务器行为有更改，请更新详细规范。
    - 任何其他相关文档。

3.  **更新 `CHANGELOG.md`：**
    - 为即将发布的版本添加新部分（例如，`## [1.0.0-beta.3] - YYYY-MM-DD`）。
    - 在此版本下列出所有重要更改（添加、更改、修复、删除、弃用、安全）。
    - 将 `YYYY-MM-DD` 替换为当前日期。

4.  **运行发布准备：**
    - 运行 `npm run prepare-release` 以确保一切准备就绪。
    - 修复脚本识别的任何问题。

5.  **测试本地编译：**
    - **必需**：编译并运行本地测试以确保它们正确构建。
    - **CI 限制**：许多测试可能需要系统权限（Apple Events、文件系统访问等），CI 无法授予这些权限。因此，全面的本地测试至关重要。
    - 在本地运行所有测试套件以验证它们在适当权限下通过。
    - **重要**：首次运行可能会提示系统权限。授予必要的访问权限以使测试正常工作。
    - 此步骤至关重要，因为依赖权限的测试无法在 CI 环境中完全验证。

6.  **提交更改：**
    - 提交与版本升级、文档和更新日志相关的所有更改。
    - `git add .`
    - `git commit -m "Prepare release vX.Y.Z"`

## 发布到 NPM

1.  **NPM 发布演练：**
    - 此步骤对于验证包中将包含哪些文件而不实际发布至关重要。
    - `npm publish --access public --tag <your_tag> --dry-run`
        - 将 `<your_tag>` 替换为适当的标签（例如，`beta`、`latest`）。对于预发布版本，始终使用特定标签如 `beta` 或 `rc`。
        - 对于作用域包，如果它们打算公开，则需要 `--access public`。
    - 仔细审查文件列表。确保它包含必要的文件（`dist/`、二进制文件（如适用）、`package.json`、`README.md`、`CHANGELOG.md` 和 `LICENSE`）。确保不包含不必要的文件。

2.  **实际 NPM 发布：**
    - 如果演练令人满意，请使用实际发布命令。
    - 如果版本是 beta，使用标签 "beta"，否则省略标签以进行发布版本。
    - `npm publish --access public --tag <your_tag>`

## 发布后步骤

1.  **创建 Git 标签：**
    - 为新版本创建 Git 标签。
    - `git tag vX.Y.Z`（例如，`git tag v1.0.0-beta.3`）

2.  **推送 Git 标签：**
    - 将标签推送到远程仓库。
    - `git push origin vX.Y.Z`

3.  **创建 GitHub 发布（推荐）：**
    - 转到 GitHub 仓库的"Releases"部分。
    - 起草新发布，选择您刚刚推送的标签。
    - 将 `CHANGELOG.md` 中的相关部分复制到发布描述中。
    - 如果需要，您还可以将任何构建工件（如编译的二进制文件或 `.tgz` NPM 包）附加到 GitHub 发布以供直接下载。

4.  **宣布发布（可选）：**
    - 在相关渠道宣布新发布（例如，团队聊天、Twitter、项目网站、MCP 社区）。

---

**关于 `prepublishOnly` 的说明：** 大多数 MCP 项目应该在其 `package.json` 中有一个运行构建过程的 `prepublishOnly` 脚本。这确保项目在发布前始终被构建。
