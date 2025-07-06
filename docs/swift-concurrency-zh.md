# Swift 6 并发：数据竞争安全和严格并发完整指南

## 目录

1. [简介](#简介)
2. [核心概念](#核心概念)
3. [Swift Evolution 提案](#swift-evolution-提案)
4. [数据竞争安全](#数据竞争安全)
5. [Actor 系统](#actor-系统)
6. [Sendable 协议](#sendable-协议)
7. [迁移指南](#迁移指南)
8. [代码示例](#代码示例)
9. [最佳实践](#最佳实践)
10. [测试和调试](#测试和调试)
11. [常见编译器错误](#常见编译器错误)
12. [性能调优](#性能调优)
13. [Swift 6.1+ 路线图](#swift-61-路线图)
14. [资源](#资源)

## 简介

Swift 6 代表了并发编程的革命性飞跃，引入了编译时数据竞争安全，消除了整个类别的 bug。本综合指南涵盖了所有 Swift Evolution 提案、实际示例和采用 Swift 6 严格并发模型的迁移策略。

### 快速开始：启用严格并发

**Xcode:**
```
Build Settings → Swift Compiler - Language → Strict Concurrency Checking → Complete
```

**命令行:**
```bash
swiftc -strict-concurrency=complete -swift-version 6 MyFile.swift
```

**Package.swift:**
```swift
.target(
    name: "MyTarget",
    swiftSettings: [
        .enableUpcomingFeature("StrictConcurrency"),
        .swiftLanguageMode(.v6)  // 或保持 .v5 模式并显示警告
    ]
)
```

### 什么是 Swift 6 并发？

Swift 6 的并发模型建立在 Swift 5.5 的 async/await 基础之上，具有：
- 编译时的**完整数据竞争安全**
- **Actor 隔离**强制执行
- **Sendable 协议**要求
- 更智能类型检查的**基于区域的隔离**
- **改进的人机工程学**减少误报

### 主要优势

1. **编译时安全**：在运行时之前捕获数据竞争
2. **渐进式迁移**：首先以警告方式增量采用
3. **更好的性能**：隔离保证启用的编译器优化
4. **更清晰的意图**：代码中的显式并发边界

## 核心概念

### 1. 隔离域

Swift 6 定义了可以安全访问数据的清晰隔离域：

```swift
// MainActor 隔离域 - UI 代码
@MainActor
class ViewController: UIViewController {
    var label = UILabel() // 在 MainActor 内安全
    
    func updateUI() {
        label.text = "Updated" // 不需要 await - 相同隔离
    }
}

// 自定义 actor 隔离域
actor DataManager {
    private var cache: [String: Data] = [:] // 受 actor 保护
    
    func store(key: String, data: Data) {
        cache[key] = data // 在 actor 内安全
    }
}

// 无隔离 - 必须是 Sendable
struct Point: Sendable {
    let x: Double
    let y: Double
}
```

### 2. 并发边界

跨越并发边界的数据必须是 Sendable：

```swift
// ❌ Swift 5: 潜在数据竞争
class Model {
    var items: [Item] = []
}

func process(model: Model) async {
    await Task.detached {
        model.items.append(Item()) // 数据竞争！
    }.value
}

// ✅ Swift 6: 编译时错误防止数据竞争
@MainActor
final class Model: Sendable {
    private(set) var items: [Item] = []
    
    func addItem(_ item: Item) {
        items.append(item) // 安全 - MainActor 同步
    }
}
```

### 3. 基于区域的隔离

Swift 6 引入了跟踪数据流的"隔离区域"：

```swift
// 基于区域的隔离允许在不需要 Sendable 的情况下安全传输
func processImage(_ image: UIImage) async -> ProcessedImage {
    // Swift 6 证明图像在传输后不会被访问
    let processed = await withTaskGroup(of: ProcessedTile.self) { group in
        for tile in image.tiles {
            group.addTask {
                // 安全传输 - 编译器跟踪区域
                await processTile(tile)
            }
        }
        // 收集结果...
    }
    return processed
}
```

## Swift Evolution 提案

### 基础提案 (Swift 5.5-5.10)

#### SE-0302: Sendable 和 @Sendable
引入基础的 `Sendable` 协议：

```swift
// 跨并发域安全共享的类型
protocol Sendable {}

// Sendable 闭包
let operation: @Sendable () -> Void = {
    print("此闭包只捕获 Sendable 值")
}

// 条件 Sendable
struct Container<T>: Sendable where T: Sendable {
    let value: T
}
```

#### SE-0306: Actors
保护可变状态的 actor 模型：

```swift
actor BankAccount {
    private var balance: Decimal = 0
    
    func deposit(amount: Decimal) {
        balance += amount
    }
    
    func withdraw(amount: Decimal) -> Bool {
        guard balance >= amount else { return false }
        balance -= amount
        return true
    }
    
    // 无需 await 即可访问的计算属性
    nonisolated var accountDescription: String {
        "Bank Account" // 无状态访问
    }
}
```

#### SE-0316: Global Actors
系统范围的隔离域：

```swift
@globalActor
actor DataActor {
    static let shared = DataActor()
}

// 应用于整个类型
@DataActor
class DataStore {
    var items: [Item] = []
    
    func add(_ item: Item) {
        items.append(item)
    }
}

// 应用于特定成员
class MixedClass {
    @DataActor var data: [String] = []
    @MainActor var uiState = UIState()
    
    @DataActor
    func processData() async {
        // 在 DataActor 上运行
    }
    
    @MainActor
    func updateUI() {
        // 在 MainActor 上运行
    }
}
```

### Swift 6 核心提案

#### SE-0337: 并发检查的增量迁移
启用渐进式采用：

```swift
// Package.swift
.target(
    name: "MyTarget",
    swiftSettings: [
        .enableUpcomingFeature("StrictConcurrency"),
        .enableUpcomingFeature("CompleteAsync"),
        .enableExperimentalFeature("StrictConcurrency=minimal")
    ]
)

// 或通过编译器标志
// swiftc -strict-concurrency=complete
```

#### SE-0401: 从属性包装器移除 Actor 隔离推断
消除意外隔离：

```swift
// SE-0401 之前
struct ContentView: View {
    @StateObject private var model = Model() // 使 View 成为 MainActor-isolated！
    
    func doWork() { // 隐式 @MainActor
        // ...
    }
}

// SE-0401 之后
struct ContentView: View {
    @StateObject private var model = Model() // 无隔离推断
    
    nonisolated func doWork() { // 显式非隔离
        // ...
    }
}
```

#### SE-0412: 全局变量的严格并发
使用 `nonisolated(unsafe)` 的全局变量安全：

```swift
// ❌ Swift 6 错误：全局变量不是并发安全的
var sharedCache: [String: Data] = [:]

// ✅ 选项 1：使其成为 let 常量
let sharedConstants = Constants()

// ✅ 选项 2：使用全局 actor
@MainActor
var sharedUICache: [String: UIImage] = [:]

// ✅ 选项 3：Actor 隔离
actor CacheActor {
    static let shared = CacheActor()
    private var cache: [String: Data] = [:]
}

// ✅ 选项 4：显式不安全选择退出
struct LegacyAPI {
    nonisolated(unsafe) static var shared: LegacyAPI?
}
```

#### SE-0414: 基于区域的隔离
隔离检查的革命性改进：

```swift
// 非 Sendable 类型可以安全传输
class MutableData {
    var value: Int = 0
}

func process() async {
    let data = MutableData() // 非 Sendable
    
    // ✅ 安全：传输后不使用 data
    await withTaskGroup(of: Void.self) { group in
        group.addTask {
            data.value = 42 // 区域分析证明安全性
        }
    }
    
    // ❌ 错误：传输后使用 data
    // print(data.value)
}
```

#### SE-0420: Actor 隔离的继承
动态隔离继承：

```swift
// 函数继承调用者的隔离
func log(
    _ message: String,
    isolation: isolated (any Actor)? = #isolation
) async {
    print("[\(isolation)] \(message)")
}

@MainActor
func updateUI() async {
    await log("Updating UI") // 继承 MainActor 隔离
}

actor DataProcessor {
    func process() async {
        await log("Processing") // 继承 DataProcessor 隔离
    }
}
```

#### SE-0430: 发送参数和结果值
无需完整 Sendable 的安全传输：

```swift
// 'sending' 允许所有权转移
func processData(_ data: sending MutableData) async -> sending ProcessedData {
    // data 被消费 - 原始引用无效
    return ProcessedData(from: data)
}

// 更新的 Task API
extension Task where Failure == Never {
    init(
        priority: TaskPriority? = nil,
        operation: sending @escaping () async -> Success
    )
}
```

#### SE-0431: @isolated(any) 函数类型
隔离无关的函数类型：

```swift
// 保留任何隔离的函数类型
typealias IsolatedOperation = @isolated(any) () async -> Void

struct Executor {
    func run(_ operation: IsolatedOperation) async {
        await operation() // 维护调用者的隔离
    }
}
```

#### SE-0434: 全局 Actor 隔离类型的可用性
全局 actor 使用的改进：

```swift
// Sendable 属性可以是 nonisolated
@MainActor
final class ViewModel: Sendable {
    // ✅ 隐式 nonisolated（Sendable 存储属性）
    let id = UUID()
    
    // ❌ 必须是隔离的（非 Sendable）
    var items: [Item] = []
    
    // ✅ 可以显式 nonisolated
    nonisolated let configuration: Configuration
}

// 闭包的改进推断
@MainActor
class Controller {
    func setup() {
        // ✅ 闭包推断为 @MainActor @Sendable
        Task {
            await updateData()
        }
    }
}
```

## 数据竞争安全

### 完整并发检查

Swift 6 默认强制执行完整检查：

```swift
// 在 Swift 5 模式中启用以进行迁移
// swift -strict-concurrency=complete

// 检查级别：
// 1. minimal - 仅显式 Sendable 一致性
// 2. targeted - 为某些类型推断 Sendable
// 3. complete - 完整数据竞争检查
```

### 常见数据竞争模式和修复

#### 模式 1：共享可变状态

```swift
// ❌ 数据竞争
class Counter {
    var value = 0
    
    func increment() {
        value += 1 // 竞争条件！
    }
}

// ✅ 修复 1：使用 actor
actor Counter {
    private var value = 0
    
    func increment() {
        value += 1 // Actor 隔离
    }
    
    var currentValue: Int {
        value
    }
}

// ✅ 修复 2：使用原子操作
import Atomics

final class Counter: Sendable {
    private let value = ManagedAtomic<Int>(0)
    
    func increment() {
        value.wrappingIncrement(ordering: .relaxed)
    }
    
    var currentValue: Int {
        value.load(ordering: .relaxed)
    }
}
```

#### 模式 2：回调隔离

```swift
// ❌ 不清楚的隔离
class NetworkManager {
    func fetch(completion: @escaping (Data) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            completion(data!) // 什么线程？
        }
    }
}

// ✅ 使用 async/await 的清晰隔离
class NetworkManager {
    func fetch() async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

// ✅ 或显式 MainActor 隔离
class NetworkManager {
    func fetch(completion: @MainActor @escaping (Data) -> Void) {
        Task {
            let data = try await URLSession.shared.data(from: url).0
            await completion(data)
        }
    }
}
```

## Actor 系统

### 基本 Actor 使用

```swift
actor DatabaseConnection {
    private var isConnected = false
    private var activeQueries = 0
    
    func connect() async throws {
        guard !isConnected else { return }
        // 连接逻辑...
        isConnected = true
    }
    
    func query(_ sql: String) async throws -> [Row] {
        activeQueries += 1
        defer { activeQueries -= 1 }
        
        // 查询执行...
        return rows
    }
    
    // 不可变数据的同步访问
    nonisolated let connectionString: String
    
    // 不访问状态的计算属性
    nonisolated var description: String {
        "Database connection to \(connectionString)"
    }
}
```

### UI 代码的 MainActor

```swift
// 整个类在 MainActor 上
@MainActor
final class LoginViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    func login(username: String, password: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            // 这会切换到后台进行网络调用
            let user = try await AuthService.shared.login(
                username: username,
                password: password
            )
            // 自动回到 MainActor
            navigateToHome(user: user)
        } catch {
            self.error = error
        }
    }
    
    // 可以在任何线程上运行
    nonisolated func validateEmail(_ email: String) -> Bool {
        // 邮箱验证逻辑...
    }
}
```

### 自定义全局 Actors

```swift
// 为数据库操作定义全局 actor
@globalActor
actor DatabaseActor {
    static let shared = DatabaseActor()
    
    // 用于集成的自定义执行器
    nonisolated var unownedExecutor: UnownedSerialExecutor {
        DatabaseQueue.shared.unownedExecutor
    }
}

// 应用于处理数据库操作的类型
@DatabaseActor
class UserRepository {
    private var cache: [UUID: User] = [:]
    
    func findUser(id: UUID) async throws -> User {
        if let cached = cache[id] {
            return cached
        }
        
        let user = try await database.fetch(User.self, id: id)
        cache[id] = user
        return user
    }
    
    func saveUser(_ user: User) async throws {
        try await database.save(user)
        cache[user.id] = user
    }
}

// 在一个类型中混合不同的 actors
class DataCoordinator {
    @DatabaseActor
    private var userRepo = UserRepository()
    
    @MainActor
    private var viewModel = UserListViewModel()
    
    func refreshUsers() async {
        // 在 DatabaseActor 上获取
        let users = await userRepo.fetchAllUsers()
        
        // 在 MainActor 上更新
        await viewModel.update(users: users)
    }
}
```

## Sendable 协议

### 理解 Sendable

```swift
// Sendable 表示线程安全类型
public protocol Sendable {}

// 自动一致性：
// 1. Actors（处理同步）
// 2. 不可变结构体/枚举
// 3. 具有不可变存储的 final 类
// 4. @unchecked Sendable 用于手动安全

// 自动 Sendable 的示例
struct Point: Sendable { // 隐式
    let x: Double
    let y: Double
}

enum Status: Sendable { // 隐式
    case pending
    case completed(at: Date)
}

actor DataManager {} // 隐式 Sendable

final class User: Sendable {
    let id: UUID
    let name: String
    // 所有存储属性都是不可变的
}
```

### 条件 Sendable

```swift
// 泛型类型可以有条件地是 Sendable
struct Container<T> {
    let value: T
}

// 自动条件一致性
extension Container: Sendable where T: Sendable {}

// 自定义条件一致性
struct Cache<Key: Hashable, Value> {
    private var storage: [Key: Value] = [:]
    private let lock = NSLock()
}

extension Cache: @unchecked Sendable where Key: Sendable, Value: Sendable {
    // 我们通过锁确保线程安全
}
```

### @unchecked Sendable

```swift
// 对于线程安全但编译器无法证明的类型
final class ThreadSafeCache: @unchecked Sendable {
    private var cache: [String: Data] = [:]
    private let queue = DispatchQueue(label: "cache.queue")
    
    func get(_ key: String) -> Data? {
        queue.sync { cache[key] }
    }
    
    func set(_ key: String, value: Data) {
        queue.async { self.cache[key] = value }
    }
}

// 具有不可变数据的引用类型
final class ImageWrapper: @unchecked Sendable {
    let cgImage: CGImage
    
    init(cgImage: CGImage) {
        self.cgImage = cgImage
    }
}
```

### Sendable 函数和闭包

```swift
// Sendable 函数类型
typealias AsyncOperation = @Sendable () async -> Void
typealias CompletionHandler = @Sendable (Result<Data, Error>) -> Void

// 使用 Sendable 闭包
func performAsync(operation: @Sendable @escaping () async -> Void) {
    Task {
        await operation()
    }
}

// Sendable 捕获
func createTimer(interval: TimeInterval) -> AsyncStream<Date> {
    AsyncStream { continuation in
        let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            continuation.yield(Date())
        }
        
        continuation.onTermination = { @Sendable _ in
            timer.invalidate() // 必须是 Sendable
        }
    }
}
```

## 迁移指南

### 步骤 1：在 Swift 5 模式中启用警告

```swift
// 在 Package.swift 中
.target(
    name: "MyApp",
    swiftSettings: [
        .enableUpcomingFeature("StrictConcurrency"),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("ConciseMagicFile")
    ]
)

// 或在 Xcode 构建设置中
// Strict Concurrency Checking: Complete
// SWIFT_STRICT_CONCURRENCY = complete
```

### 步骤 2：修复全局变量

```swift
// 之前
var sharedFormatter = DateFormatter()

// 之后 - 选项 1：使其不可变
let sharedFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()

// 之后 - 选项 2：添加 actor 隔离
extension DateFormatter {
    @MainActor
    static let shared: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}

// 之后 - 选项 3：对遗留代码使用 nonisolated(unsafe)
nonisolated(unsafe) var legacyGlobal: LegacyType?
```

### 步骤 3：添加 Sendable 一致性

```swift
// 使您的模型类型 Sendable
struct User: Codable, Sendable {
    let id: UUID
    let name: String
    let email: String
}

// 对于引用类型，确保不可变性
final class Configuration: Sendable {
    let apiKey: String
    let baseURL: URL
    
    init(apiKey: String, baseURL: URL) {
        self.apiKey = apiKey
        self.baseURL = baseURL
    }
}
```

### 步骤 4：隔离 UI 代码

```swift
// 之前
class ViewModel: ObservableObject {
    @Published var items: [Item] = []
    
    func loadItems() {
        Task {
            items = await fetchItems() // 潜在竞争
        }
    }
}

// 之后
@MainActor
final class ViewModel: ObservableObject {
    @Published private(set) var items: [Item] = []
    
    func loadItems() async {
        items = await fetchItems() // 在 MainActor 上安全
    }
}
```

### 步骤 5：处理回调和委托

```swift
// 之前 - 不清楚的隔离
protocol DataDelegate: AnyObject {
    func dataDidUpdate(_ data: Data)
}

// 之后 - 显式隔离
@MainActor
protocol DataDelegate: AnyObject {
    func dataDidUpdate(_ data: Data)
}

// 或使用异步替代方案
protocol DataProvider {
    func fetchData() async throws -> Data
}
```

### 渐进式迁移策略

1. **从叶子模块开始**：从依赖较少的模块开始
2. **首先修复简单问题**：不可变全局变量、缺失的 Sendable 一致性
3. **隔离 UI 层**：为视图控制器和视图模型添加 @MainActor
4. **解决共享状态**：转换为 actors 或使用同步
5. **启用 Swift 6 模式**：解决警告后

## 代码示例

### 示例 1：图像处理管道

```swift
// 使用 actors 和 Sendable 的图像处理器
actor ImageProcessor {
    private let cache = ImageCache()
    
    func process(_ image: UIImage, filters: [Filter]) async throws -> UIImage {
        // 检查缓存
        let cacheKey = CacheKey(image: image, filters: filters)
        if let cached = await cache.get(cacheKey) {
            return cached
        }
        
        // 处理图像
        var result = image
        for filter in filters {
            result = try await filter.apply(to: result)
        }
        
        // 缓存结果
        await cache.set(cacheKey, image: result)
        return result
    }
}

// Sendable 过滤器协议
protocol Filter: Sendable {
    func apply(to image: UIImage) async throws -> UIImage
}

// 具体过滤器实现
struct BlurFilter: Filter {
    let radius: Double
    
    func apply(to image: UIImage) async throws -> UIImage {
        // 使用 Core Image 的实现
        let ciImage = CIImage(image: image)!
        let filter = CIFilter.gaussianBlur()
        filter.inputImage = ciImage
        filter.radius = Float(radius)
        
        let context = CIContext()
        let output = filter.outputImage!
        let cgImage = context.createCGImage(output, from: output.extent)!
        
        return UIImage(cgImage: cgImage)
    }
}
```

### 示例 2：具有适当隔离的网络层

```swift
// 具有清晰隔离边界的网络服务
actor NetworkService {
    private let session: URLSession
    private let decoder = JSONDecoder()
    private var activeTasks: [UUID: URLSessionTask] = [:]
    
    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }
    
    func fetch<T: Decodable & Sendable>(
        _ type: T.Type,
        from url: URL
    ) async throws -> T {
        let taskID = UUID()
        
        let task = session.dataTask(with: url)
        activeTasks[taskID] = task
        
        defer { activeTasks.removeValue(forKey: taskID) }
        
        let (data, response) = try await withTaskCancellationHandler {
            try await session.data(from: url)
        } onCancel: {
            task.cancel()
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        return try decoder.decode(type, from: data)
    }
    
    func cancelAll() {
        activeTasks.values.forEach { $0.cancel() }
        activeTasks.removeAll()
    }
    
    nonisolated var activeTaskCount: Int {
        get async { await activeTasks.count }
    }
}

// 具有适当错误处理的使用
@MainActor
class UserListViewModel: ObservableObject {
    @Published private(set) var users: [User] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    private let networkService = NetworkService()
    
    func loadUsers() async {
        isLoading = true
        error = nil
        
        do {
            let url = URL(string: "https://api.example.com/users")!
            users = try await networkService.fetch([User].self, from: url)
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}
```

### 示例 3：并发数据处理

```swift
// 具有适当隔离的并行处理
struct DataProcessor {
    func processFiles(_ urls: [URL]) async throws -> [ProcessedData] {
        try await withThrowingTaskGroup(of: ProcessedData.self) { group in
            // 为每个文件添加任务
            for url in urls {
                group.addTask {
                    try await processFile(url)
                }
            }
            
            // 收集结果
            var results: [ProcessedData] = []
            for try await result in group {
                results.append(result)
            }
            
            return results
        }
    }
    
    private func processFile(_ url: URL) async throws -> ProcessedData {
        let data = try await readFile(url)
        let processed = try await transform(data)
        return ProcessedData(
            originalURL: url,
            processedData: processed,
            timestamp: Date()
        )
    }
}

// Sendable 的结果类型
struct ProcessedData: Sendable {
    let originalURL: URL
    let processedData: Data
    let timestamp: Date
}
```

## 最佳实践

### 1. 为 Sendability 设计

```swift
// ❌ 避免可变引用类型
class Settings {
    var theme: Theme
    var notifications: Bool
}

// ✅ 偏爱值类型或不可变引用类型
struct Settings: Sendable {
    let theme: Theme
    let notifications: Bool
}

// ✅ 或为可变状态使用 actors
actor SettingsManager {
    private var settings: Settings
    
    func update(theme: Theme) {
        settings = Settings(
            theme: theme,
            notifications: settings.notifications
        )
    }
}
```

### 2. 最小化 Actor 跳跃

```swift
// ❌ 过度的 actor 跳跃
@MainActor
class ViewModel {
    func processData() async {
        let data = await dataActor.getData()
        let processed = await processorActor.process(data)
        let formatted = await formatterActor.format(processed)
        updateUI(formatted)
    }
}

// ✅ 批量操作
@MainActor
class ViewModel {
    func processData() async {
        let result = await dataActor.getProcessedAndFormattedData()
        updateUI(result)
    }
}
```

### 3. 为纯函数使用 nonisolated

```swift
actor Calculator {
    private var history: [Calculation] = []
    
    // ✅ 纯函数不需要隔离
    nonisolated func add(_ a: Double, _ b: Double) -> Double {
        a + b
    }
    
    nonisolated func multiply(_ a: Double, _ b: Double) -> Double {
        a * b
    }
    
    // 修改状态的函数需要隔离
    func recordCalculation(_ calc: Calculation) {
        history.append(calc)
    }
}
```

### 4. 利用结构化并发

```swift
// ✅ 为并行工作使用任务组
func downloadImages(urls: [URL]) async throws -> [UIImage] {
    try await withThrowingTaskGroup(of: (Int, UIImage).self) { group in
        for (index, url) in urls.enumerated() {
            group.addTask {
                let image = try await downloadImage(from: url)
                return (index, image)
            }
        }
        
        var images = Array<UIImage?>(repeating: nil, count: urls.count)
        for try await (index, image) in group {
            images[index] = image
        }
        
        return images.compactMap { $0 }
    }
}
```

### 5. 正确处理取消

```swift
func longRunningOperation() async throws -> Result {
    try await withTaskCancellationHandler {
        var progress = 0.0
        
        while progress < 1.0 {
            try Task.checkCancellation()
            
            // 执行工作...
            progress += 0.1
            
            try await Task.sleep(for: .seconds(1))
        }
        
        return result
    } onCancel: {
        // 清理资源
        cleanupOperation()
    }
}
```

## 测试和调试

### 线程消毒器 (TSan)

线程消毒器对于捕获逃脱编译时检查的运行时数据竞争仍然至关重要：

```bash
# 在 Xcode 中启用
Product → Scheme → Edit Scheme → Diagnostics → Thread Sanitizer

# 或通过命令行
swift test -Xswiftc -sanitize=thread
```

**何时使用 TSan：**
- 测试带有 @preconcurrency 导入的遗留代码
- 验证 @unchecked Sendable 实现
- 捕获 C/Objective-C 互操作中的竞争

### Swift 并发调试器 (Xcode 16+)

并发代码的新调试工具：

1. **任务树视图**：可视化父子任务关系
2. **Actor 内存图**：查看 actor 隔离边界
3. **跳跃跟踪**：跟踪跨隔离域的执行

```swift
// 调试助手
extension Task {
    static func currentPriority() -> TaskPriority {
        Task.currentPriority
    }
    
    static func printTaskTree() {
        // 在调试构建中可用
        #if DEBUG
        print("Task: \(Task<Never, Never>.currentPriority)")
        #endif
    }
}
```

### 单元测试并发代码

```swift
// 带超时的异步代码测试助手
func withTimeout<T>(
    _ duration: Duration = .seconds(5),
    operation: @escaping () async throws -> T
) async throws -> T {
    try await withThrowingTaskGroup(of: T.self) { group in
        group.addTask {
            try await operation()
        }
        
        group.addTask {
            try await Task.sleep(for: duration)
            throw TimeoutError()
        }
        
        let result = try await group.next()!
        group.cancelAll()
        return result
    }
}

// 测试 actor 隔离
final class ActorTests: XCTestCase {
    func testActorIsolation() async throws {
        let actor = TestActor()
        
        // 使用多个并发操作验证隔离
        try await withThrowingTaskGroup(of: Int.self) { group in
            for i in 0..<100 {
                group.addTask {
                    await actor.increment()
                    return await actor.value
                }
            }
            
            var results: Set<Int> = []
            for try await result in group {
                results.insert(result)
            }
            
            // 如果正确隔离，所有结果应该是唯一的
            XCTAssertEqual(results.count, 100)
        }
    }
}
```

### 调试常见问题

```swift
// 1. 调试意外的挂起点
actor DataManager {
    func debugSuspension() async {
        print("Before suspension: \(Thread.current)")
        await someAsyncOperation()
        print("After suspension: \(Thread.current)") // 可能是不同的线程
    }
}

// 2. 跟踪隔离上下文
func debugIsolation(
    isolation: isolated (any Actor)? = #isolation
) async {
    if let isolation {
        print("Running on: \(type(of: isolation))")
    } else {
        print("Running on non-isolated context")
    }
}

// 3. 检测优先级反转
Task(priority: .low) {
    await debugPriority() // 可能由于升级而在更高优先级运行
}

func debugPriority() async {
    print("Current priority: \(Task.currentPriority)")
}
```

## 常见编译器错误

### 错误参考表

| 诊断 | 示例 | 修复 |
|------------|---------|-----|
| **非 Sendable 类型跨越 actor 边界** | `Capture of 'nonSendable' with non-sendable type 'MyClass'` | 1. 使类型 Sendable<br>2. 使用 `sending` 参数<br>3. 复制/转换为 Sendable 类型 |
| **从非隔离上下文引用 Actor 隔离属性** | `Actor-isolated property 'items' can not be referenced from a non-isolated context` | 1. 添加 `await`<br>2. 将代码移至 actor<br>3. 使属性 `nonisolated` |
| **从非隔离上下文调用主 actor 隔离的方法** | `Call to main actor-isolated instance method 'updateUI()' in a synchronous nonisolated context` | 1. 为调用者添加 `@MainActor`<br>2. 使用 `await MainActor.run { }`<br>3. 使方法 `nonisolated` |
| **捕获变量的突变** | `Mutation of captured var 'counter' in concurrently-executing code` | 1. 为状态使用 actor<br>2. 使其不可变<br>3. 使用 `Mutex`（Swift 6.1+） |
| **Sendable 闭包捕获非 Sendable** | `Capture of 'self' with non-sendable type 'ViewController?' in a `@Sendable` closure` | 1. 使用 `[weak self]`<br>2. 使类型 Sendable<br>3. 在闭包前提取所需值 |

### 详细错误解决方案

#### 1. 非 Sendable 类型错误

```swift
// ❌ 错误：非 Sendable 类型 'UIImage' 跨越 actor 边界
class ImageProcessor {
    func process(image: UIImage) async {
        Task.detached {
            // 错误：捕获具有非 sendable 类型的 'image'
            manipulate(image)
        }
    }
}

// ✅ 解决方案 1：使用 sending 参数
class ImageProcessor {
    func process(image: sending UIImage) async {
        Task.detached {
            manipulate(image) // 所有权转移
        }
    }
}

// ✅ 解决方案 2：转换为 Sendable 表示
class ImageProcessor {
    func process(image: UIImage) async {
        let imageData = image.pngData()! // Data 是 Sendable
        Task.detached {
            let recreated = UIImage(data: imageData)!
            manipulate(recreated)
        }
    }
}
```

#### 2. Actor 隔离错误

```swift
// ❌ 错误：不带 await 访问 Actor 隔离属性
actor DataStore {
    var items: [Item] = []
    
    nonisolated func getItemCount() -> Int {
        items.count // 错误：actor 隔离属性
    }
}

// ✅ 解决方案 1：使方法 async
actor DataStore {
    var items: [Item] = []
    
    func getItemCount() async -> Int {
        items.count // OK：隐式隔离到 actor
    }
}

// ✅ 解决方案 2：使用计算属性
actor DataStore {
    private var items: [Item] = []
    
    var itemCount: Int {
        items.count // OK：计算属性是隔离的
    }
}
```

#### 3. MainActor 隔离错误

```swift
// ❌ 错误：从后台调用 MainActor 隔离的方法
func backgroundWork() {
    updateUI() // 错误：MainActor 隔离
}

@MainActor
func updateUI() { }

// ✅ 解决方案 1：使调用者成为 MainActor
@MainActor
func backgroundWork() async {
    await fetchData()
    updateUI() // OK：都在 MainActor 上
}

// ✅ 解决方案 2：显式 MainActor.run
func backgroundWork() async {
    let data = await fetchData()
    await MainActor.run {
        updateUI()
    }
}
```

## 性能调优

### 任务创建开销

```swift
// ❌ 过度任务创建
for item in items {
    Task {
        await process(item) // 创建 N 个非结构化任务
    }
}

// ✅ 为批量操作使用 TaskGroup
await withTaskGroup(of: Void.self) { group in
    for item in items {
        group.addTask {
            await process(item) // 结构化，有限并发
        }
    }
}

// ✅ 或使用并发 forEach
await items.concurrentForEach { item in
    await process(item)
}
```

### 用于高效计时的 Clock API

```swift
// ❌ 老式睡眠
Task {
    Thread.sleep(forTimeInterval: 1.0) // 阻塞线程
}

// ❌ 使用纳秒的 Task.sleep
Task {
    try await Task.sleep(nanoseconds: 1_000_000_000)
}

// ✅ 现代基于 Clock 的方法
let clock = ContinuousClock()
try await clock.sleep(for: .seconds(1))

// ✅ 测量经过的时间
let elapsed = await clock.measure {
    await expensiveOperation()
}
print("Operation took: \(elapsed)")

// ✅ 用于测试的自定义时钟
struct TestClock: Clock {
    var now: Instant { .init() }
    func sleep(until deadline: Instant) async throws {
        // 测试的即时返回
    }
}
```

### 结构化 vs 非结构化任务

```swift
// ❌ 非结构化任务失去上下文
class Service {
    func startBackgroundWork() {
        Task {
            await longRunningWork() // 无取消传播
        }
    }
}

// ✅ 具有适当生命周期的结构化任务
class Service {
    private var workTask: Task<Void, Never>?
    
    func startBackgroundWork() {
        workTask = Task {
            try await withTaskCancellationHandler {
                await longRunningWork()
            } onCancel: {
                cleanup()
            }
        }
    }
    
    func stopWork() {
        workTask?.cancel()
    }
}

// ✅ 仅对真正的守护进程使用分离任务
Task.detached(priority: .background) {
    // 长期后台监控
    while !Task.isCancelled {
        await checkSystemHealth()
        try await Task.sleep(for: .minutes(5))
    }
}
```

### Actor 争用优化

```swift
// ❌ 单个 actor 上的高争用
actor Counter {
    private var value = 0
    
    func increment() {
        value += 1
    }
}

// ✅ 通过批处理减少争用
actor Counter {
    private var value = 0
    
    func increment(by amount: Int = 1) {
        value += amount
    }
    
    func batchIncrement(_ operations: [Int]) {
        value += operations.reduce(0, +)
    }
}

// ✅ 或为高吞吐量使用分片
actor ShardedCounter {
    private var shards: [Int]
    
    init(shardCount: Int = ProcessInfo.processInfo.activeProcessorCount) {
        self.shards = Array(repeating: 0, count: shardCount)
    }
    
    func increment() {
        let shard = Int.random(in: 0..<shards.count)
        shards[shard] += 1
    }
    
    var total: Int {
        shards.reduce(0, +)
    }
}
```

## Swift 6.1+ 路线图

### Swift 6.1 (已发布)

#### SE-0431: @isolated(any) 函数类型
```swift
// 保留隔离的函数类型
typealias IsolatedHandler = @isolated(any) () async -> Void

func withIsolation(_ handler: IsolatedHandler) async {
    await handler() // 维护调用者的隔离
}

// 与 actors 一起使用
actor MyActor {
    func doWork() async {
        await withIsolation {
            // 在 MyActor 上运行
            print("Isolated to: \(self)")
        }
    }
}
```

#### SE-0433: 同步互斥锁 (Mutex)
```swift
import Synchronization

// 为保护关键段而无需 async
final class Statistics: Sendable {
    private let mutex = Mutex<Stats>(.init())
    
    func record(value: Double) {
        mutex.withLock { stats in
            stats.count += 1
            stats.sum += value
        }
    }
    
    var average: Double {
        mutex.withLock { stats in
            stats.count > 0 ? stats.sum / Double(stats.count) : 0
        }
    }
}

private struct Stats {
    var count = 0
    var sum = 0.0
}
```

### Swift 6.2 (开发中)

#### SE-0461: 隔离默认参数
```swift
// 默认值可以使用隔离上下文
@MainActor
class ViewModel {
    // ✅ 默认值可以访问 MainActor 状态
    func configure(
        title: String = defaultTitle // 在 6.2 中推出
    ) { }
    
    @MainActor
    static var defaultTitle: String { "Default" }
}
```

### 审查中的未来提案

1. **SE-0449**: 允许 nonisolated 防止全局 actor 推断
2. **SE-0450**: 限制 actor 隔离推断
3. **SE-0451**: 隔离同步 deinit
4. **并发中的类型化抛出**: 更好的错误传播
5. **自定义执行器 v2**: 对任务执行的更多控制

### 迁移时间线

| 版本 | 主要功能 | 迁移影响 |
|---------|--------------|------------------|
| Swift 6.0 | 默认严格并发 | 主要 - 需要代码更新 |
| Swift 6.1 | Mutex, @isolated(any) | 次要 - 附加功能 |
| Swift 6.2 | 隔离默认值, deinit | 次要 - 生活质量 |
| Swift 7.0 | 自定义执行器 v2 | 待定 - 专注性能 |

保持更新：[Swift Evolution Dashboard](https://www.swift.org/swift-evolution/)

## 资源

### 官方文档
- [Swift.org - 并发](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/)
- [迁移到 Swift 6](https://www.swift.org/migration/documentation/migrationguide/)
- [数据竞争安全](https://www.swift.org/migration/documentation/swift-6-concurrency-migration-guide/dataracesafety/)

### Swift Evolution 提案
- [SE-0401: 移除 Actor 隔离推断](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0401-remove-property-wrapper-isolation.md)
- [SE-0414: 基于区域的隔离](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0414-region-based-isolation.md)
- [SE-0420: Actor 隔离的继承](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0420-inheritance-of-actor-isolation.md)
- [SE-0430: 发送参数值](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0430-transferring-parameters-and-results.md)

### WWDC 会议
- **WWDC 2024**: "将您的应用迁移到 Swift 6" - 实用迁移指南
- **WWDC 2022**: "使用 Swift 并发消除数据竞争" - 基础概念
- **WWDC 2021**: "在 Swift 中认识 async/await" - Swift 并发介绍

### 社区资源
- [Swift 论坛 - 并发](https://forums.swift.org/c/swift-evolution/concurrency/23)
- [并发索引主题](https://developer.apple.com/forums/thread/768776)
- [Swift Package Index](https://swiftpackageindex.com) - 显示"数据竞争安全"徽章

## 结论

Swift 6 的严格并发代表了我们编写并发代码方式的范式转变。通过拥抱：
- 编译时的完整数据竞争安全
- 使用 actors 的清晰隔离边界
- 显式 Sendable 要求
- 渐进式迁移策略

我们可以编写更安全、更可维护的并发代码。编译器成为我们预防整个类别 bug 的伙伴，从而产生更可靠的应用程序。

记住：目标不仅仅是消除编译器警告，而是设计具有清晰并发边界的系统，这些系统更容易推理和长期维护。
