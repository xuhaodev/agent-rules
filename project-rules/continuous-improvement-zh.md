---
description: 基于新兴模式和最佳实践持续改进AI助手规则的系统化方法
globs: ""
alwaysApply: false
---

# AI开发规则持续改进指南

本指南提供了基于新兴模式、最佳实践和开发过程中经验教训持续改进AI助手规则的系统化方法。

## 规则改进触发器

### 何时创建或更新规则

**创建新规则的情况:**
- 新技术/模式在3+文件中使用
- 常见错误可以通过规则预防
- 代码审查反复提到相同反馈
- 出现新的安全或性能模式
- 复杂任务需要一致的方法

**更新现有规则的情况:**
- 代码库中存在更好的示例
- 发现额外的边缘情况
- 相关规则已更新
- 实现细节发生变化
- 用户反馈表明困惑

## 分析过程

### 1. 模式识别

监控代码库中的重复模式:

```typescript
// 示例: 如果您反复看到这种模式:
const data = await prisma.user.findMany({
  select: { id: true, email: true },
  where: { status: 'ACTIVE' }
});

// 考虑记录:
// - 标准选择字段
// - 常见where条件  
// - 性能优化模式
```

### 2. 错误模式分析

跟踪常见错误及其解决方案:

```yaml
常见错误: "连接超时"
根本原因: 服务启动后缺少策略性延迟
解决方案: 启动服务后添加5-10秒延迟
规则更新: 向自动化规则添加时序指南
```

### 3. 最佳实践演进

记录新兴最佳实践:

```markdown
## 之前 (旧模式)
- 直接DOM操作
- 无错误处理
- 同步操作

## 之后 (新模式)  
- 使用框架方法
- 全面错误处理
- 带适当错误边界的async/await
```

## 规则质量框架

### 结构指南

每个规则应遵循此结构:

```markdown
# 规则名称

## 目的
此规则实现目标的简要描述

## 何时应用
- 具体场景
- 触发条件
- 先决条件

## 实现
### 基本模式
```code
// 最小工作示例
```

### 高级模式
```code
// 带错误处理的复杂场景
```

## 常见陷阱
- 已知问题
- 如何避免

## 参考资料
- 相关规则: [rule-name.md]
- 外部文档: [链接]
```

### 质量检查表

发布规则前，确保:

- [ ] **可操作**: 提供清晰、可实现的指导
- [ ] **具体**: 避免模糊建议
- [ ] **已测试**: 示例来自工作代码
- [ ] **完整**: 涵盖常见边缘情况
- [ ] **最新**: 参考资料是最新的
- [ ] **关联**: 交叉引用相关规则

## 持续改进工作流程

### 1. 收集阶段

**日常开发**
- 注意重复的代码模式
- 记录已解决的问题
- 跟踪工具使用模式

**周度审查**
- 分析git提交的模式
- 审查调试会话
- 检查错误日志

### 2. 分析阶段

**模式提取**
```python
# 模式分析的伪代码
patterns = analyze_codebase()
for pattern in patterns:
    if pattern.frequency >= 3 and not documented(pattern):
        create_rule_draft(pattern)
```

**影响评估**
- 多少文件会受益?
- 会预防哪些错误?
- 会节省多少时间?

### 3. 文档化阶段

**规则创建过程**
1. 起草带示例的初始规则
2. 在现有代码上测试规则
3. 获取团队反馈
4. 完善并发布
5. 监控效果

### 4. 维护阶段

**定期更新**
- 月度: 审查规则使用情况
- 季度: 主要更新
- 年度: 废弃审查

## 规则管理的元规则

### 规则版本控制

```yaml
rule_version: 1.2.0
last_updated: 2024-01-15
breaking_changes:
  - v1.0.0: 初始版本
  - v1.1.0: 添加错误处理模式
  - v1.2.0: 为新框架版本更新
```

### 废弃流程

```markdown
## 已废弃: 旧模式
**状态**: 自v2.0.0起废弃
**迁移**: 参见 [new-pattern.md]
**移除日期**: 2024-06-01

[保留原始内容供参考]
```

### 规则指标

跟踪规则效果:

```yaml
metrics:
  usage_count: 45
  error_prevention: 避免了12个错误
  time_saved: 约3小时/周
  user_feedback: 4.2/5
```

## 示例: 自我改进的规则系统

### 自动规则建议

```typescript
// 监控代码模式
interface RuleSuggestion {
  pattern: string;
  frequency: number;
  files: string[];
  suggestedRule: string;
}

// 生成建议
function analyzeForRules(codebase: Codebase): RuleSuggestion[] {
  // 实现
}
```

### 反馈循环集成

```yaml
# 在项目的.cursor/rules/feedback.yaml中
feedback_enabled: true
feedback_channel: "#ai-rules"
suggestion_threshold: 3
auto_create_draft: true
```

## 规则演进的最佳实践

### 1. 从简单开始
- 从最小可行规则开始
- 基于实际需求增加复杂性
- 避免过度工程化

### 2. 从失败中学习
- 记录什么不起作用
- 理解失败原因
- 分享经验教训

### 3. 鼓励贡献
- 使建议改进变得容易
- 为新规则提供模板
- 认可贡献者

### 4. 衡量影响
- 跟踪前后指标
- 收集用户推荐
- 量化时间节省

## 与开发工作流程的集成

### Git钩子
```bash
#!/bin/bash
# 检查规则合规性的pre-commit钩子
./scripts/check-rules.sh
```

### CI/CD管道
```yaml
# .github/workflows/rules.yml
name: 规则合规性检查
on: [push, pull_request]
jobs:
  check-rules:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: npm run check:rules
```

### IDE集成
```json
// .vscode/settings.json
{
  "cursor.rules.autoSuggest": true,
  "cursor.rules.path": ".cursor/rules",
  "cursor.rules.checkOnSave": true
}
```

## 结论

AI开发规则的持续改进是一个迭代过程，需要:
- 积极监控开发模式
- 定期分析和记录
- 社区反馈和协作
- 系统化维护和更新

通过遵循本指南，团队可以构建一个与代码库一起演进并持续提高开发者生产力的活跃知识库。
