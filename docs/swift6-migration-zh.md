---
description: Swift 6 代码迁移指南，包含并发性和严格检查的迁移说明
globs: "**/*.swift"
alwaysApply: false
---

# Swift 并发迁移指南

本仓库包含 [Swift 并发迁移指南][scmg] 的源代码，该指南使用 [Swift-DocC][docc] 构建。

## 贡献

有关如何为 Swift 迁移指南做出贡献的说明，请参阅 [贡献指南][contributing]。

## 构建

在此仓库的根目录下运行 `docc preview Guide.docc`。

运行 DocC 后，打开 `docc` 输出的链接，在浏览器中显示本地预览。

> 注意：
>
> 如果您通过从 Swift.org 下载工具链安装了 DocC，
> `docc` 位于 `usr/bin/` 目录中，
> 相对于工具链的安装路径。
> 确保您的 shell 的 `PATH` 环境变量
> 包含该目录。
>
> 如果您通过下载 Xcode 安装了 DocC，
> 请使用 `xcrun docc` 代替。

## Swift 6 迁移要点

### 并发安全
- 使用 `@Sendable` 协议确保类型可以安全地跨并发边界传递
- 采用 `actor` 类型来保护可变状态
- 使用 `@MainActor` 确保 UI 更新在主线程执行

### 严格并发检查
- 启用严格并发检查以捕获潜在的数据竞争
- 解决编译器警告和错误
- 重构代码以符合并发安全要求

### 数据隔离
- 理解 actor 隔离的概念
- 正确使用 `isolated` 参数
- 管理跨 actor 的数据访问

### 异步操作
- 将回调基础的 API 迁移到 async/await
- 使用 `AsyncSequence` 处理异步数据流
- 实现正确的错误处理模式

[contributing]: https://github.com/apple/swift-migration-guide/blob/main/CONTRIBUTING.md
[docc]: https://github.com/apple/swift-docc
[conduct]: https://www.swift.org/code-of-conduct
[scmg]: https://www.swift.org/migration/documentation/migrationguide
