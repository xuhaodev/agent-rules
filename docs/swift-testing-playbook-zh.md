---
description: 从 XCTest 迁移到 Swift Testing 的综合指南，包含 WWDC 2024 最佳实践
globs: "**/*Tests.swift, **/*Test.swift"
alwaysApply: false
---

# Swift Testing 终极指南（2024 WWDC 版本）
https://developer.apple.com/xcode/swift-testing/

一个全面的实用指南，用于从 XCTest 迁移到 Swift Testing 并掌握新框架。本指南整合了来自 WWDC 2024 和官方 Apple 文档的最新模式和最佳实践，让您的测试更强大、更具表现力和更易维护。

---

## **1. 迁移和工具基线**

确保您的环境已设置好，以实现平滑的渐进式迁移。

| 内容 | 原因 |
|---|---|
| **Xcode 16 和 Swift 6** | Swift Testing 与最新工具链捆绑。它利用现代 Swift 功能，如宏、结构化并发和强大的类型系统检查。 |
| **保留 XCTest 目标** | **渐进式迁移是关键。** 您可以在同一目标中同时拥有 XCTest 和 Swift Testing 测试，允许您逐文件迁移而不会破坏 CI。两个框架可以共存。 |
| **启用并行执行**| 在您的测试计划中，确保启用"使用并行执行"。Swift Testing 默认并行运行测试，这大大加快了测试运行速度，并有助于发现串行执行可能错过的隐藏状态依赖关系。 |

### 迁移行动项目
- [ ] 确保所有开发者机器和 CI 运行器都在 macOS 15+ 和 Xcode 16+ 上。
- [ ] 对于支持 Linux/Windows 的项目，将 `swift-testing` SPM 包添加到您的 `Package.swift`。它在 Xcode 中是捆绑的，Apple 平台不需要。
- [ ] 对于**现有测试目标**，您必须明确启用框架。在目标的**构建设置**中，找到**启用测试框架**并将其值设置为**是**。没有这个，`import Testing` 将失败。
- [ ] 在您的主要测试计划中，确认已启用**"使用并行执行"**。这是默认和推荐的设置。

---

## **2. 表达性断言：`#expect` 和 `#require`**

用两个强大、富有表现力的宏替换整个 `XCTAssert` 系列。它们接受常规 Swift 表达式，无需数十个专门的 `XCTAssert` 函数。

| 宏 | 用例和行为 |
|---|---|
| **`#expect(expression)`** | **软检查。** 用于大多数验证。如果表达式为 `false`，会记录问题，但测试函数继续执行。这允许您在单次运行中发现多个失败。 |
| **`#require(expression)`**| **硬检查。** 用于关键前提条件（例如，解包可选值）。如果表达式为 `false` 或抛出异常，测试立即中止。这防止了无效状态导致的级联失败。 |

### 强大功能：可视化失败诊断
与 `XCTAssert` 不同，后者通常只报告比较失败，`#expect` 直接在 IDE 和日志中显示导致失败的确切值。这种可视化反馈是巨大的生产力提升。

**代码：**
```swift
@Test("用户数量满足最低要求")
func testUserCount() {
    let userCount = 5
    // 这个检查将失败
    #expect(userCount > 10)
}
```

**Xcode 中的失败输出：**
```
▽ 期望表达式为真
#expect(userCount > 10)
      |         | |
      5         | 10
                false
```

### 强大功能：可选值安全解包
`#require` 是 `XCTUnwrap` 的新的、更安全的替代品。它不仅检查 `nil`，还解包值供后续使用。

**之前：XCTest 方式**
```swift
// 在 XCTestCase 子类中...
func testFetchUser_XCTest() async throws {
    let user = try XCTUnwrap(await fetchUser(id: "123"), "获取用户不应返回 nil")
    XCTAssertEqual(user.id, "123")
}
```

**之后：Swift Testing 方式**
```swift
@Test("获取有效用户成功")
func testFetchUser() async throws {
    // #require 既检查 nil 又在一步中解包 `user`。
    // 如果 fetchUser 返回 nil，测试在此处停止并失败。
    let user = try #require(await fetchUser(id: "123"))

    // `user` 现在是非可选的 User，准备进行进一步断言。
    #expect(user.id == "123")
    #expect(user.age == 37)
}
```

### 常见断言转换快速参考

在迁移 `XCTest` 断言时，将此表用作备忘单。

| XCTest 断言 | Swift Testing 等效 | 注释 |
|---|---|---|
| `XCTAssert(expr)` | `#expect(expr)` | 布尔表达式的直接替换。 |
| `XCTAssertEqual(a, b)` | `#expect(a == b)` | 使用标准 `==` 运算符。 |
| `XCTAssertNotEqual(a, b)`| `#expect(a != b)` | 使用标准 `!=` 运算符。 |
| `XCTAssertNil(a)` | `#expect(a == nil)` | 直接与 `nil` 比较。 |
| `XCTAssertNotNil(a)` | `#expect(a != nil)` | 直接与 `nil` 比较。 |
| `XCTAssertTrue(a)` | `#expect(a)` | 如果 `a` 已经是 Bool，则无需更改。 |
| `XCTAssertFalse(a)` | `#expect(!a)` | 使用 `!` 运算符否定表达式。 |
| `XCTAssertGreaterThan(a, b)` | `#expect(a > b)` | 使用任何标准比较运算符：`>`、`<`、`>=`、`<=` |
| `XCTUnwrap(a)` | `try #require(a)` | 解包可选值的首选、更安全的方式。 |
| `XCTAssertThrowsError(expr)` | `#expect(throws: Error.self) { expr }` | 检查任何错误的基本形式。 |
| `XCTAssertNoThrow(expr)` | `#expect(throws: Never.self) { expr }` | 明确断言不抛出错误的方式。 |

### 行动项目
- [ ] 运行 `grep -R "XCTAssert" .` 查找所有遗留断言。
- [ ] 将 `XCTUnwrap` 调用转换为 `try #require()`。这是直接且优越的替代品。
- [ ] 将大多数 `XCTAssert` 调用转换为 `#expect()`。仅在继续测试没有意义的前提条件中使用 `#require()`。
- [ ] 对于同一对象上的多个相关检查，使用单独的 `#expect()` 语句。每个都将独立评估，所有失败都将被报告。

---

## **3. 设置、拆卸和状态生命周期**

Swift Testing 用更自然、类型安全的生命周期替换了 `setUpWithError` 和 `tearDownWithError`，使用 `init()` 和 `deinit`。

**核心概念：** 为其包含的**每个**测试函数创建测试套件（`struct` 或 `class`）的全新实例。这是测试隔离的基石，保证一个测试的状态不会泄漏到另一个测试中。

| 方法 | 替换... | 行为 |
|---|---|---|
| `init()` | `setUpWithError()` | 套件的初始化器。将所有设置代码放在这里。它可以是 `async` 和 `throws`。 |
| `deinit` | `tearDownWithError()` | 反初始化器。将清理代码放在这里。它在每个测试后自动运行。**注意：** `deinit` 仅在 `class` 或 `actor` 套件类型上可用，而不是 `struct`。这是选择类作为套件的常见原因。 |

### 实际示例：迁移数据库测试套件

**之前：XCTest 方式**
```swift
final class DatabaseServiceXCTests: XCTestCase {
    var sut: DatabaseService!
    var tempDirectory: URL!

    override func setUpWithError() throws {
        try super.setUpWithError()
        tempDirectory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: tempDirectory, withIntermediateDirectories: true)
        
        let testDatabase = TestDatabase(storageURL: tempDirectory)
        sut = DatabaseService(database: testDatabase)
    }

    override func tearDownWithError() throws {
        try FileManager.default.removeItem(at: tempDirectory)
        sut = nil
        tempDirectory = nil
        try super.tearDownWithError()
    }

    func testSavingUser() throws {
        let user = User(id: "user-1", name: "Alex")
        try sut.save(user)
        let loadedUser = try sut.loadUser(id: "user-1")
        XCTAssertNotNil(loadedUser)
    }
}
```

**之后：Swift Testing 方式（使用 `class` 进行 `deinit`）**
```swift
@Suite final class DatabaseServiceTests {
    // 在这里使用类来演示 `deinit` 进行清理。
    let sut: DatabaseService
    let tempDirectory: URL

    init() throws {
        // 排列：在此套件中的每个测试之前运行。
        self.tempDirectory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: tempDirectory, withIntermediateDirectories: true)
        
        let testDatabase = TestDatabase(storageURL: tempDirectory)
        self.sut = DatabaseService(database: testDatabase)
    }
    
    deinit {
        // 拆卸：在每个测试后运行。
        try? FileManager.default.removeItem(at: tempDirectory)
    }

    @Test func testSavingUser() throws {
        let user = User(id: "user-1", name: "Alex")
        try sut.save(user)
        #expect(try sut.loadUser(id: "user-1") != nil)
    }
}
```

### 行动项目
- [ ] 将测试类从 `XCTestCase` 转换为 `struct`（首选，用于自动状态隔离）或 `final class`。
- [ ] 将 `setUpWithError` 逻辑移动到套件的 `init()` 中。
- [ ] 将 `tearDownWithError` 逻辑移动到套件的 `deinit` 中（如果需要，使用 `class` 或 `actor`）。
- [ ] 将 SUT 及其依赖项定义为 `let` 属性，在 `init()` 中初始化。

---

## **4. 掌握错误处理**

超越 `do/catch`，使用专用的、富有表现力的 API 来验证抛出的错误。

| 重载 | 替换... | 示例和用例 |
|---|---|---|
| **`#expect(throws: Error.self)`**| 基本 `XCTAssertThrowsError` | 验证抛出了*任何*错误。 |
| **`#expect(throws: BrewingError.self)`** | 类型化 `XCTAssertThrowsError` | 确保抛出特定*类型*的错误。 |
| **`#expect(throws: BrewingError.outOfBeans)`**| 特定错误 `XCTAssertThrowsError`| 验证抛出特定错误*值*。 |
| **`#expect(throws: ... ) catch: { ... }`** | 带有 `switch` 的 `do/catch` | **负载内省。** 检查有关联值的错误的终极工具。它为您提供一个闭包来检查抛出的错误。 |
| **`#expect(throws: Never.self)`** | `XCTAssertNoThrow` | 明确断言函数*不*抛出错误。适用于正常路径测试。 |

---

## **5. 参数化测试：大幅减少样板代码**

使用多个参数集运行单个测试函数，以最少的代码最大化覆盖率。这优于 `for-in` 循环，因为每个参数集作为独立测试运行，可以并行运行，失败会单独报告。

| 模式 | 如何使用及何时使用 |
|---|---|
| **单个集合** | `@Test(arguments: [0, 100, -40])` <br> 最简单的形式。传递输入集合。 |
| **压缩集合** | `@Test(arguments: zip(inputs, expectedOutputs))` <br> 最常见和最强大的模式。使用 `zip` 配对输入和预期输出，确保一对一对应。 |
| **多个集合** | `@Test(arguments: ["USD", "EUR"], [1, 10, 100])` <br> **⚠️ 注意：笛卡尔积。** 这为参数的*每个可能组合*创建测试用例。当您需要测试所有组合时，请有意使用它。 |

### 示例：将重复测试迁移到参数化测试

**之前：XCTest 方式**
```swift
func testFlavorVanillaContainsNoNuts() {
    let flavor = Flavor.vanilla
    XCTAssertFalse(flavor.containsNuts)
}
func testFlavorPistachioContainsNuts() {
    let flavor = Flavor.pistachio
    XCTAssertTrue(flavor.containsNuts)
}
func testFlavorChocolateContainsNoNuts() {
    let flavor = Flavor.chocolate
    XCTAssertFalse(flavor.containsNuts)
}
```

**之后：使用 `zip` 的 Swift Testing 方式**
```swift
@Test("口味坚果含量正确", arguments: zip(
    [Flavor.vanilla, .pistachio, .chocolate],
    [false, true, false]
))
func testFlavorContainsNuts(flavor: Flavor, expected: Bool) {
    #expect(flavor.containsNuts == expected)
}
```

---

## **6. 条件执行和跳过**

基于功能标志、环境或已知问题动态控制哪些测试运行。

| 特征 | 作用及如何使用 |
|---|---|
| **`.disabled("原因")`** | **无条件跳过测试。** 测试不运行，但仍然编译。始终为 CI 可见性提供描述性原因（例如，`"在 CI 上不稳定，参见 FB12345"`）。 |
| **`.enabled(if: condition)`** | **有条件地运行测试。** 只有当布尔 `condition` 为 `true` 时测试才运行。这非常适合绑定到功能标志或特定环境的测试。 |
| **`@available(...)`** | **OS 版本特定测试。** 直接将此属性应用于测试函数。它比运行时 `#available` 检查更好，因为它允许测试运行器知道测试因平台原因被跳过，这在测试报告中更清洁。 |

---

## **7. 更清晰失败的专门断言**

虽然 `#expect(a == b)` 有效，但专门构建的模式通过解释*为什么*某些东西失败，而不仅仅是*失败了*，提供更锐利、更可操作的失败消息。

| 断言类型 | 为什么它比通用检查更好 |
| :--- | :--- |
| **比较集合（无序）**<br>对顺序无关的相等性使用 Set 比较 | 如果元素相同但顺序不同，数组上的简单 `==` 检查会失败。转换为 Sets 忽略顺序，防止顺序无关测试的误报。 |
| **浮点精度**<br>使用手动容差检查或 Swift Numerics | 浮点数学是不精确的。`#expect(0.1 + 0.2 == 0.3)` 会失败。对于健壮的浮点比较，使用手动容差检查或 Swift Numerics。 |

---

## **8. 大规模结构和组织**

使用套件和标签管理大型和复杂的测试库。

### 套件和嵌套套件
`@Suite` 将相关测试分组，可以嵌套以形成清晰的层次结构。应用于套件的特征由其中的所有测试和嵌套套件继承。

### 跨切面关注的标签
标签将测试与共同特征（例如，`.network`、`.ui`、`.regression`）关联，无论其套件如何。这对过滤非常有价值。

### 行动项目
- [ ] 运行 `grep -R "XCTAssert" .` 查找所有遗留断言。
- [ ] 将 `XCTUnwrap` 调用转换为 `try #require()`。
- [ ] 定义项目特定的标签并始终使用它们。
- [ ] 在 Xcode 测试计划中使用标签过滤。

---

## **9. 并发和异步测试**

### Async/Await 和确认
- **异步测试**：只需将测试函数标记为 `async` 并使用 `await`。
- **确认**：要测试带有完成处理程序或多次触发的 API（如委托或通知），请使用 `confirmation`。

### 高级异步模式

#### 断言事件永不发生
使用 `expectedCount: 0` 的确认来验证在操作期间*永远不会*调用回调或委托方法。

#### 桥接遗留完成处理程序
对于使用完成处理程序的较旧异步代码，使用 `withCheckedThrowingContinuation` 将其包装在 Swift Testing 可以处理的现代 `async/await` 调用中。

### 控制并行性
- **`.serialized`**：将此特征应用于 `@Test` 或 `@Suite` 以强制其内容串行运行（一次一个）。
- **`.timeLimit`**：防止挂起测试停滞 CI 的安全网。

---

## **10. 高级 API 手册**

| 功能 | 作用及如何使用 |
|---|---|
| **`withKnownIssue`** | 将测试标记为**预期失败**。它比 `.disabled` 更适合已知错误。 |
| **`CustomTestStringConvertible`** | 为测试失败日志中的类型提供自定义、可读的描述。 |
| **`.bug("JIRA-123")` 特征** | 将测试直接与问题跟踪器中的票据关联。 |
| **`Test.current`** | 给您运行时访问当前测试元数据的静态属性。 |

---

## **11. 常见陷阱及如何避免**

1.  **过度使用 `#require()`**
    -   **陷阱：** 对每个检查使用 `#require()`。
    -   **解决方案：** 对大多数检查使用 `#expect()`。

2.  **忘记状态是隔离的**
    -   **陷阱：** 假设在一个测试中修改的属性将为同一套件中的下一个测试保留其值。
    -   **解决方案：** 记住为每个测试创建套件的**新实例**。

3.  **意外使用笛卡尔积**
    -   **陷阱：** 将多个集合传递给参数化测试而不使用 `zip`。
    -   **解决方案：** 要有意为之。如果您想要一对一配对，**始终使用 `zip`**。

---

## **12. 从 XCTest 迁移**

Swift Testing 和 XCTest 可以在同一目标中共存，实现渐进式迁移。

### 关键差异一览

| 功能 | XCTest | Swift Testing |
|---|---|---|
| **测试发现** | 方法名必须以 `test...` 开头 | 任何函数或方法上的 `@Test` 属性。 |
| **套件类型** | `class MyTests: XCTestCase` | `struct MyTests`（首选）、`class` 或 `actor`。 |
| **断言** | `XCTAssert...()` 函数系列 | 带有 Swift 表达式的 `#expect()` 和 `#require()` 宏。 |
| **错误解包** | `try XCTUnwrap(...)` | `try #require(...)` |
| **设置/拆卸**| `setUpWithError()`、`tearDownWithError()` | `init()`、`deinit`（在类/actor 上） |
| **异步等待**| `XCTestExpectation` | `confirmation()` 和 `await fulfillment(of:timeout:)` |
| **并行性** | 选择性，多进程 | 选择性退出，通过 Swift 并发进行进程内。 |

### 暂时不要迁移的内容
对于以下内容继续使用 XCTest，因为 Swift Testing 目前不支持它们：
- **UI 自动化测试**（使用 `XCUIApplication`）
- **性能测试**（使用 `XCTMetric` 和 `measure { ... }`）
- **用 Objective-C 编写的测试**
