---
description: 将 SwiftUI 应用从 ObservableObject 迁移到 @Observable 宏的迁移指南
globs: "**/*.swift"
alwaysApply: false
---

以下内容来自 Apple Developer 文档页面“从 Observable Object 协议迁移到 Observable 宏”，已转换为 Markdown 格式。

# 从 Observable Object 协议迁移到 Observable 宏

更新现有应用以利用 Swift 中 Observation 的优势。

***

## 概述

自 iOS 17、iPadOS 17、macOS 14、tvOS 17 和 watchOS 10 起，SwiftUI 提供了对 Observation 的支持，这是一种 Swift 特有的观察者设计模式实现。采用 Observation 能为你的应用带来如下好处：

> *   跟踪可选类型和对象集合，这在使用 `ObservableObject` 时无法实现。
> *   使用现有的数据流原语如 `State` 和 `Environment`，而不是基于对象的等价物如 `StateObject` 和 `EnvironmentObject`。
> *   仅在视图的 body 读取到可观察属性发生变化时更新视图，而不是在可观察对象的任意属性变化时都更新，这有助于提升应用性能。

要在你的应用中获得这些好处，你将学习如何用 `@Observable()` 宏替换依赖 `ObservableObject` 的现有源码。

***

## 使用 Observable 宏

要在现有应用中采用 Observation，首先将数据模型类型中的 `ObservableObject` 替换为 `@Observable()` 宏。`@Observable()` 宏会在编译时生成支持观察的源码。

**迁移前**
```swift
// 迁移前
import SwiftUI

class Library: ObservableObject {
    // ...
}
```

**迁移后**
```swift
// 迁移后
import SwiftUI

@Observable
class Library {
    // ...
}
```

然后移除可观察属性上的 `@Published` 属性包装器。Observation 不需要属性包装器来使属性可观察。属性是否可观察取决于它对观察者（如视图）的可访问性。

**迁移前**
```swift
// 迁移前
@Observable
class Library {
    @Published var books: [Book] = [Book(), Book(), Book()]
}
```

**迁移后**
```swift
// 迁移后
@Observable
class Library {
    var books: [Book] = [Book(), Book(), Book()]
}
```

如果有不希望被跟踪的可访问属性，可为其添加 `@ObservationIgnored()` 宏。

***

## 渐进式迁移

你无需在整个应用中一次性替换所有 `ObservableObject` 协议。可以逐步迁移。先将一个数据模型类型改为使用 `@Observable()` 宏。你的应用可以混合使用不同观察系统的数据模型类型。但 SwiftUI 会根据数据模型类型所用的观察系统（`Observable` 或 `ObservableObject`）以不同方式跟踪变化。

你可能会注意到应用在跟踪方式不同下有细微的行为差异。例如，使用 `@Observable()` 跟踪时，只有当可观察属性发生变化且视图的 body 直接读取该属性时，SwiftUI 才会更新视图。若 body 未读取变化的属性，则视图不会更新。而使用 `ObservableObject` 跟踪时，只要 `ObservableObject` 实例的任意已发布属性变化，视图都会更新，即使视图未读取变化的属性。

> **注意：** 想了解更多关于 SwiftUI 在可观察属性变化时何时更新视图的信息，请参见 [在应用中管理模型数据](https://developer.apple.com/documentation/swiftui/managing-model-data)。

***

## 迁移其他源码

应用 `@Observable()` 宏后，可以更新你的数据流原语。虽然 `StateObject` 和 `EnvironmentObject` 支持使用 `@Observable()` 宏的类型以便渐进式迁移，但要完全采用 Observation，建议用 `State` 和 `Environment` 替换它们。

**迁移前**
```swift
// 迁移前
@main
struct BookReaderApp: App {
    @StateObject private var library = Library()

    var body: some Scene {…}
}
```

**迁移后**
```swift
// 迁移后
@main
struct BookReaderApp: App {
    @State private var library = Library()

    var body: some Scene {…}
}
```

同样，将 `@EnvironmentObject` 替换为 `@Environment` 属性包装器。

**迁移前**
```swift
// 迁移前
struct LibraryView: View {
    @EnvironmentObject var library: Library

    var body: some View {…}
}
```

**迁移后**
```swift
// 迁移后
struct LibraryView: View {
    @Environment(Library.self) private var library

    var body: some View {…}
}
```

***

## 移除 ObservedObject 属性包装器

为完成迁移，将其他数据模型类型也改为支持 Observation：用 `@Observable()` 宏替换 `ObservableObject`，并移除 `@Published`。

**迁移前**
```swift
// 迁移前
class Book: ObservableObject, Identifiable {…}
```

**迁移后**
```swift
// 迁移后
@Observable
class Book: Identifiable {…}
```

接下来，移除 `@ObservedObject` 属性包装器。SwiftUI 会自动跟踪视图 body 直接读取的任何可观察属性。

**迁移前**
```swift
// 迁移前
struct BookView: View {…}
```

**迁移后**
```swift
// 迁移后
struct BookView: View {…}
```

如果视图需要对可观察类型进行绑定，将 `@ObservedObject` 替换为 `@Bindable` 属性包装器。

**迁移前**
```swift
// 迁移前
struct BookEditView: View {…}
```

**迁移后**
```swift
// 迁移后
struct BookEditView: View {…}
```
