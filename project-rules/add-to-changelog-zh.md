# 添加到更新日志

为项目的CHANGELOG.md文件添加新条目。

## 用法:
`/add-to-changelog <版本> <变更类型> <消息>`

## 参数:
- `<版本>`: 版本号 (例如, "1.1.0")
- `<变更类型>`: 以下之一: "added", "changed", "deprecated", "removed", "fixed", "security"
- `<消息>`: 变更描述

## 示例:
- `/add-to-changelog 1.1.0 added "新增Markdown到BlockDoc转换功能"`
- `/add-to-changelog 1.0.2 fixed "修复HTML渲染器导致输出错误的错误"`

## 步骤:
1. 检查现有CHANGELOG.md或在缺失时创建
2. 查找或创建指定版本的部分
3. 在适当的变更类型下添加新条目
4. 根据Keep a Changelog约定格式化
5. 将更新的更新日志写回文件
6. 可选择使用适当消息提交变更

## 格式:
遵循[Keep a Changelog](https://keepachangelog.com)格式:
- 按类型分组变更
- 将变更列为要点
- 为版本部分包含日期
- 保持条目简洁但描述性强
