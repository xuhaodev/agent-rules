# Mermaid 图表生成

生成 Mermaid 图表以可视化代码结构和关系。

## 常见图表类型：

### 1. 实体关系图
用于数据库模式和数据模型：
```
erDiagram
    CUSTOMER ||--o{ ORDER : places
    ORDER ||--|{ LINE-ITEM : contains
```

### 2. 流程图
用于流程和逻辑流：
```
flowchart TD
    A[开始] --> B{决策}
    B -->|是| C[处理]
    B -->|否| D[结束]
```

### 3. 序列图
用于交互流程：
```
sequenceDiagram
    客户端->>服务器: 请求
    服务器->>数据库: 查询
    数据库-->>服务器: 结果
    服务器-->>客户端: 响应
```

### 4. 类图
用于面向对象设计：
```
classDiagram
    class Animal {
        +name: string
        +age: int
        +makeSound()
    }
```

## 过程：
1. 分析源文件（SQL、代码、文档）
2. 提取实体和关系
3. 生成适当的图表类型
4. 包含相关属性/方法
5. 使用 mermaid 编译器验证语法
6. 保存到指定位置

## 验证：
运行 `npx -p @mermaid-js/mermaid-cli mmdc -i <input>.md -o test.md`

## 最佳实践：
- 保持图表专注和可读
- 使用一致的命名约定
- 分组相关实体
- 为关系添加标签
- 在相关位置包含基数
- 使用子图进行组织
- 添加样式以提高清晰度
