# 清理

修复整个代码库中的所有代码格式和质量问题。

## Python项目:
修复所有`black`、`isort`、`flake8`和`mypy`问题

### 步骤:
1. **使用Black格式化**: `black .`
2. **使用isort排序导入**: `isort .`
3. **修复flake8问题**: `flake8 . --extend-ignore=E203`
4. **解决mypy类型错误**: `mypy .`

## JavaScript/TypeScript项目:
修复所有ESLint、Prettier和TypeScript问题

### 步骤:
1. **使用Prettier格式化**: `npx prettier --write .`
2. **修复ESLint问题**: `npx eslint . --fix`
3. **检查TypeScript**: `npx tsc --noEmit`

## 通用流程:
1. 首先运行自动格式化工具
2. 手动修复剩余的代码检查问题
3. 解决类型检查错误
4. 验证所有工具都无错误通过
5. 提交前审查变更

## 常见问题:
- 工具之间的导入顺序冲突
- 行长度违规
- 未使用的导入/变量
- 类型注解要求
- 缺失的返回类型
- 不一致的引号/分号
