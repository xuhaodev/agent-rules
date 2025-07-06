<!--
通过 https://llm.codes 下载，由 @steipete 于2025年6月17日上午08:41下载
源URL: https://developer.apple.com/documentation/appkit
处理的总页面数：1847
过滤的URL：是
内容去重：是
可用性字符串过滤：是
仅代码块：否
-->

# https://developer.apple.com/documentation/appkit

框架

# AppKit

为您的 macOS 应用程序构建和管理图形化、事件驱动的用户界面。

## 概述

AppKit 包含构建 macOS 应用程序用户界面所需的对象。除了绘制窗口、按钮、面板和文本字段外，它还处理应用程序、用户和 macOS 之间的所有事件管理和交互。

除了绘制和管理交互外，AppKit 还处理打印、动画以及高效创建包含大量数据的文档。该框架还内置了本地化和辅助功能支持，以确保您的应用程序能够惠及尽可能多的用户。

AppKit 还与 SwiftUI 协同工作，因此您可以在 SwiftUI 中实现 AppKit 应用程序的部分功能，或在两个框架之间混合界面元素。例如，您可以将 AppKit 视图和视图控制器放在 SwiftUI 视图中，反之亦然。

## 主题

### 基础要点

采用液态玻璃

了解如何将新材质引入您的应用程序。

AppKit 更新

了解 AppKit 的重要变化。

保护用户隐私

保护个人数据，并尊重用户对数据使用的偏好。

将 macOS 应用程序移植到 Apple Silicon

创建一个在 Apple Silicon 和基于 Intel 的 Mac 计算机上都能运行的 macOS 应用程序版本。

### 应用结构

了解用于与系统交互的对象。

组织应用程序的数据和偏好设置，并在剪贴板或 iCloud 中共享这些数据。

使用 Cocoa 绑定自动同步数据模型与应用程序界面。

管理包含应用程序用户界面的故事板和 nib 文件，并学习如何加载存储在资源文件中的数据。

将应用程序的基本功能扩展到系统的其他部分。

### 用户界面

您应用程序的用户界面提供视觉、听觉和触觉反馈

使用连续性相机将来自用户 iPhone、iPad 或 iPod touch 的扫描文档和图片整合到您的 Mac 应用程序中。

### 用户交互

处理与鼠标、键盘和触控板输入相关的事件。

实现菜单和光标以促进与应用程序的交互，并使用应用程序的 Dock 磁贴传达更新信息。

将应用程序的事件处理逻辑封装在手势识别器中，以便在整个应用程序中重用该代码。

在 Touch Bar 中显示交互式内容和控件。

使用拖放功能支持对应用程序内容的直接操作。

让您的 AppKit 应用程序对所有使用 macOS 的用户都可访问。

### 图形、绘制、颜色和打印

创建和管理位图、PDF 和其他格式的图像。

在屏幕上绘制形状、图像和其他内容。

使用内置或自定义格式表示颜色，并为用户提供选择和应用颜色的选项。

显示系统打印面板并管理打印过程。

### 文本

显示文本并检查拼写。

管理文本存储并在应用程序视图中执行基于文本内容的自定义布局。

管理用于显示文本的字体。

为应用程序的文本视图添加写作工具支持。

### 已弃用

避免在应用程序中使用已弃用的类和协议。

查看不再支持的符号，并找到要使用的替代品。

### 参考

供多个类使用的枚举。

供多个类使用的常量。

供多个类使用的数据类型。

供多个类使用的宏。

---

# https://developer.apple.com/documentation/appkit/app-and-environment

集合

- AppKit
- 应用程序和环境

API 集合

# 应用程序和环境

了解用于与系统交互的对象。

## 主题

### 生命周期

`class NSApplication`

管理应用程序主事件循环和该应用程序所有对象使用的资源的对象。

`class NSRunningApplication`

可以操作单个应用程序实例并为其提供信息的对象。

`protocol NSApplicationDelegate`

管理应用程序生命周期及其与常见系统服务交互的一组方法。

由 main 函数调用以创建和运行应用程序。

### 环境

`class NSWorkspace`

可以启动其他应用程序并执行各种文件处理服务的工作空间。

`class OpenConfiguration`

用于打开 URL 或启动应用程序的配置选项。

`struct NSAppKitVersion`

用于确定可用 AppKit 版本的常量。

`LSMinimumSystemVersion`

应用程序在 macOS 中运行所需的操作系统最低版本。

### 接力

`class NSUserActivity`

应用程序在某一时刻状态的表示。

`protocol NSUserActivityRestoring`

标记类以恢复应用程序状态以继续用户活动的协议。

### 应用服务

`class NSSharingService`

促进与社交媒体服务或与 Mail 或 Safari 等应用程序共享内容的对象。

`class NSSharingServicePicker`

用户可以从中选择的共享服务列表。

`protocol NSPreviewRepresentableActivityItem`

您在希望使用 macOS 共享表共享的自定义对象中采用的接口。

`class NSSharingServicePickerToolbarItem`

显示 macOS 共享表的工具栏项。

`protocol NSServicesMenuRequestor`

支持与用户可通过共享服务共享的项目交互的一组方法。

`protocol NSCloudSharingServiceDelegate`

用于响应云共享服务生命周期事件的一组方法。

配置应用程序服务菜单的内容。

### 应用帮助

`class NSHelpManager`

用于显示应用程序在线帮助的对象。

`protocol NSUserInterfaceItemSearching`

应用程序可以实现的一组方法，为其自己的自定义帮助数据提供 Spotlight 帮助搜索。

### 错误

这些常量表示 AppKit 生成的错误。

## 另请参阅

### 应用结构

组织应用程序的数据和偏好设置，并在剪贴板或 iCloud 中共享这些数据。

使用 Cocoa 绑定自动同步数据模型与应用程序界面。

管理包含应用程序用户界面的故事板和 nib 文件，并学习如何加载存储在资源文件中的数据。

将应用程序的基本功能扩展到系统的其他部分。

---

# https://developer.apple.com/documentation/appkit/documents-data-and-pasteboard

集合

- AppKit
- 文档、数据和剪贴板

API 集合

# 文档、数据和剪贴板

组织应用程序的数据和偏好设置，并在剪贴板或 iCloud 中共享这些数据。

## 主题

### 文档

开发基于文档的应用程序

编写创建、管理、编辑和保存文本文档的应用程序。

`class NSDocument`

定义 macOS 文档接口的抽象类。

`class NSDocumentController`

管理应用程序文档的对象。

`class NSPersistentDocument`

可以与 Core Data 集成的文档对象。

### 用户偏好

`class NSUserDefaultsController`

从用户默认数据库访问应用程序用户偏好信息的控制器。

`class NSUbiquitousKeyValueStore`

基于 iCloud 的键值对容器，用于在用户连接设备上运行的应用程序实例之间共享数据。

### 剪贴板

`class NSPasteboard`

在剪贴板服务器之间传输数据的对象。

`class NSPasteboardItem`

剪贴板上的项目。

`protocol NSPasteboardReading`

定义从剪贴板初始化对象接口的一组方法。

`protocol NSPasteboardWriting`

定义检索可写入剪贴板的对象表示的接口的一组方法。

`protocol NSPasteboardItemDataProvider`

剪贴板项目的数据提供者实现的一组方法，为特定 UTI 类型提供数据。

`struct ContentsOptions`

用于准备剪贴板的选项。

`protocol NSPasteboardTypeOwner`

作为数据提供者的对象，为来自剪贴板请求的使用延迟数据履行的数据类型提供服务。

### 文件承诺

文件承诺支持基于 UTI 的拖放功能，包括拖拽群集。在可能的情况下，它们与剪贴板兼容并进行文件协调。

通过文件承诺支持拖放

接收和提供文件承诺以支持拖拽的应用程序文件和剪贴板操作。

通过文件承诺支持表格视图拖放

使用项目提供者在拖放期间在 macOS 应用程序之间共享数据。

支持通过文件承诺的集合视图拖放

`class NSFilePromiseProvider`

为剪贴板提供承诺的对象。

`protocol NSFilePromiseProviderDelegate`

提供承诺文件名称并在文件承诺履行时将文件写入目标目录的一组方法。

`class NSFilePromiseReceiver`

从剪贴板接收文件承诺的对象。

### 对象编辑

`protocol NSEditor`

`protocol NSEditorRegistration`

控制器可以实现的一组方法，使编辑器视图能够在有未提交更改时通知控制器。

## 另请参阅

### 应用结构

了解用于与系统交互的对象。

使用 Cocoa 绑定自动同步数据模型与应用程序界面。

管理包含应用程序用户界面的故事板和 nib 文件，并学习如何加载存储在资源文件中的数据。

将应用程序的基本功能扩展到系统的其他部分。

---

# https://developer.apple.com/documentation/appkit/cocoa-bindings

集合

- AppKit
- Cocoa 绑定

API 集合

# Cocoa 绑定

使用 Cocoa 绑定自动同步数据模型与应用程序界面。

## 主题

### 核心控制器

`class NSObjectController`

可以管理由键值路径引用的对象属性的控制器。

`class NSController`

实现控制器类所需的 `NSEditor` 和 `NSEditorRegistration` 非正式协议的抽象类。

### 基于树的数据

使用大纲和分割视图导航分层数据

构建简化应用程序导航的结构化用户界面。

`class NSTreeController`

管理对象树的绑定兼容控制器。

`class NSTreeNode`

节点树中的节点。

### 基于数组的数据

`class NSArrayController`

管理对象集合的绑定兼容控制器。

### 键值数据

`class NSDictionaryController`

管理键值对字典显示和编辑的绑定兼容控制器。

`class NSDictionaryControllerKeyValuePair`

排列对象实现的一组方法，用于访问有关这些对象的信息。

`struct NSBindingName`

为某些方法指定绑定的值。

`struct NSBindingOption`

`struct NSBindingInfoKey`

测试给定对象是否为用于指示选择相对于键的状态的特殊标记对象。

NSKeyValueBindingCreation

您可以使用一组方法在视图对象和控制器之间或控制器和模型对象之间创建和删除绑定。

这些常量定义绑定信息字典中的键。

### 数据占位符

`class NSBindingSelectionMarker`

对象可以实现的一组方法，用于注册在未指定其他占位符时为绑定显示的默认占位符。

## 另请参阅

### 应用结构

了解用于与系统交互的对象。

组织应用程序的数据和偏好设置，并在剪贴板或 iCloud 中共享这些数据。

管理包含应用程序用户界面的故事板和 nib 文件，并学习如何加载存储在资源文件中的数据。

将应用程序的基本功能扩展到系统的其他部分。

---

# https://developer.apple.com/documentation/appkit/resource-management

集合

- AppKit
- 资源管理

API 集合

# 资源管理

管理包含应用程序用户界面的故事板和 nib 文件，并学习如何加载存储在资源文件中的数据。

## 主题

### 故事板

`class NSStoryboard`

Interface Builder 故事板资源文件中表示的设计时视图控制器和窗口控制器图的封装。

`class NSStoryboardSegue`

故事板中两个场景之间的转换或包含关系。

`protocol NSSeguePerforming`

支持自定义 segue 调解的一组方法。

### 资产

`class NSDataAsset`

存储在资产目录中的数据集类型的对象。

### Nib 文件

`class NSNib`

Interface Builder nib 文件的对象包装器或容器。

## 另请参阅

### 应用结构

了解用于与系统交互的对象。

组织应用程序的数据和偏好设置，并在剪贴板或 iCloud 中共享这些数据。

使用 Cocoa 绑定自动同步数据模型与应用程序界面。

将应用程序的基本功能扩展到系统的其他部分。

---

# https://developer.apple.com/documentation/appkit/app-extensions

集合

- AppKit
- 应用扩展

API 集合

# 应用扩展

将应用程序的基本功能扩展到系统的其他部分。

## 主题

### 扩展支持

`class NSExtensionContext`

调用应用扩展的主机应用上下文。

`protocol NSExtensionRequestHandling : NSObjectProtocol`

应用扩展用于响应主机应用请求的接口。

### 快速操作

快速操作允许您的应用扩展出现在 Finder 预览面板、快速操作菜单和 Touch Bar 中。

使用操作扩展为 Finder 添加功能

实现操作扩展以快速访问应用程序的常用功能。

`NSExtensionServiceAllowsFinderPreviewItem`

指示扩展是否出现在 Finder 预览面板和快速操作菜单中的布尔值。

`NSExtensionServiceFinderPreviewLabel`

当扩展出现在 Finder 预览面板和快速操作菜单中时用于显示的名称。

`NSExtensionServiceFinderPreviewIconName`

当扩展出现在 Finder 预览面板和快速操作菜单中时用于显示的图标名称。

`NSExtensionServiceAllowsTouchBarItem`

指示扩展是否在 Touch Bar 中显示为快速操作的布尔值。

`NSExtensionServiceTouchBarLabel`

当扩展在 Touch Bar 中显示为快速操作时用于显示的名称。

`NSExtensionServiceTouchBarIconName`

当扩展在 Touch Bar 中显示为快速操作时用于显示的图标名称

`NSExtensionServiceTouchBarBezelColorName`

当扩展在 Touch Bar 中显示为快速操作时，用于边框的颜色。

### 邮件扩展

构建邮件应用扩展

创建阻止内容、执行消息和撰写操作以及帮助消息安全的应用扩展。

### 数据检测器类型的 UTI 子类型

`let NSTypeIdentifierAddressText: String`

`let NSTypeIdentifierDateText: String`

`let NSTypeIdentifierPhoneNumberText: String`

`let NSTypeIdentifierTransitInformationText: String`

## 另请参阅

### 应用结构

了解用于与系统交互的对象。

组织应用程序的数据和偏好设置，并在剪贴板或 iCloud 中共享这些数据。

使用 Cocoa 绑定自动同步数据模型与应用程序界面。

管理包含应用程序用户界面的故事板和 nib 文件，并学习如何加载存储在资源文件中的数据。

---

# https://developer.apple.com/documentation/appkit/views-and-controls

集合

- AppKit
- 视图和控件

API 集合

# 视图和控件

在屏幕上呈现内容并处理用户输入和事件。

## 概述

视图和控件是应用程序用户界面的构建块。

视图可以承载其他视图。将一个视图嵌入另一个视图中会在主机视图（称为_父视图_）和嵌入视图（称为_子视图_）之间创建包含关系。视图层次结构使管理视图变得更容易。

您还可以使用视图执行以下任一操作：

- 响应触摸和其他事件（直接响应或与手势识别器协调）。

- 使用 Core Graphics 绘制自定义内容。

- 响应焦点变化。

- 使用 Core Animation 动画化视图的大小、位置和外观属性。

尽可能优先使用 AppKit 视图和控件。这些组件会自动适应系统变化，许多支持外观自定义以支持您在应用程序中想要的外观和感觉。当 AppKit 不提供您需要的确切视图或控件时，您可以创建自定义视图。

`NSView` 是所有视图的根类，定义了它们的共同行为。`NSControl` 定义了特定于按钮、开关和其他专为用户交互设计的视图的附加行为。

有关如何使用视图和控件的更多信息，请参阅《人机界面指南》。

## 主题

### 视图基础

`class NSView`

在应用程序中绘制、打印和处理事件的基础设施。

`class NSControl`

专门的视图，如按钮或文本字段，使用目标-动作设计模式通知应用程序相关事件。

`class NSCell`

在视图对象中显示文本或图像的机制，没有完整 `NSView` 子类的开销。

`class NSActionCell`

控件内的活动区域。

### 容器视图

使用容器视图排列界面视图并促进这些视图之间的导航。

macOS 中的本地化友好布局

该项目演示了本地化友好的自动布局约束。它使用 `NSGridView` 作为容器视图来实现本地化布局。

在灵活的网格中排列视图，并处理与这些视图关联的布局。

`class NSSplitView`

水平或垂直线性堆叠排列两个或多个视图的视图。

使用堆栈视图组织用户界面

将应用程序用户界面中的各个视图分组到可滚动的堆栈视图中。

`class NSStackView`

水平或垂直排列视图数组的视图，并在窗口大小更改时更新其位置和大小。

`class NSTabView`

一次显示一页的多页界面。

为导航太大而无法适应可用空间的内容提供界面。

### 内容视图

使用内容视图组织和显示应用程序数据。

为查看和导航分层信息提供基于列的界面。

在高度可配置的排列中显示一个或多个子视图。

为分层数据显示基于列表的界面，其中每个层次级别都从前一个级别缩进。

在行和列中显示自定义数据。

`class NSTextView`

绘制文本并处理与该文本的用户交互的视图。

### 控件

使用控件处理特定类型的用户交互。控件是使用目标-动作设计模式通知应用程序与其内容交互的专门视图。

使用目标-动作响应基于控件的事件

通过使用目标-动作设计模式将按钮、滑块和其他控件连接到应用程序代码来处理用户输入。

`class NSButton`

定义屏幕上用户点击以触发操作的区域的控件。

`class NSColorWell`

显示颜色值并让用户更改该颜色值的控件。

在弹出菜单中显示值列表，让用户选择值或输入自定义值。

`class NSComboButton`

带有下拉菜单和默认操作的按钮。

显示日历日期并提供编辑日期值的控件。

`class NSImageView`

框架中图像数据的显示。

`class NSLevelIndicator`

使用离散值的级别或数量的视觉表示。

文件系统路径或虚拟路径信息的显示。

`class NSPopUpButton`

从列表中选择项目的控件。

`class NSProgressIndicator`

提供视觉反馈的界面

为配置基于规则的选项列表提供界面。

`class NSPredicateEditor`

允许编辑谓词对象的定义规则集。

提供针对基于文本的搜索界面优化的文本字段。

`class NSSegmentedControl`

在单个水平组中显示一个或多个按钮。

显示用户从中选择单个值的值范围。

`class NSStepper`

具有用于递增或递减值的向上和向下箭头按钮的界面。

提供用于显示和编辑文本的简单界面，包括对密码字段和安全文本输入形式的支持。

提供文本字段，其文本可以以视觉上独特的方式呈现，以便用户可以更轻松地识别部分。

在窗口标题栏下方和自定义内容上方为控件提供空间。

`class NSSwitch`

提供二进制选择的控件。

`class NSMatrix`

将单选按钮或其他类型的单元格组合在一起的传统界面。

### 液态玻璃效果

`class NSGlassEffectView`

NSGlassView 将其内容视图嵌入动态玻璃效果中。

测试版

`class NSGlassEffectContainerView`

NSGlassContainerView 允许彼此适当接近的类似 NSGlassViews 合并在一起。此外，NSGlassContainerView 可以减少渲染类似玻璃视图所需的通道数。

### 与相邻视图交互

`class NSBackgroundExtensionView`

扩展内容以填充其自身边界的视图。

### 视觉装饰

向用户界面添加纯装饰元素。

`class NSVisualEffectView`

为界面中的视图添加半透明和活力效果的视图。

`class NSBox`

带有可选标题的风格化矩形框。

### UI 验证

`protocol NSUserInterfaceValidations`

自定义类可以采用的协议，用于管理 UI 元素的启用状态。

`protocol NSValidatedUserInterfaceItem`

自定义类可以采用的协议，用于管理 UI 控件的自动启用。

### 工具提示

`protocol NSViewToolTipOwner`

用于动态将工具提示与视图关联的一组方法。

### 相关类型

`enum NSRectAlignment`

根据用户界面布局方向指定与边缘或一组边缘对齐的常量。

`struct NSDirectionalEdgeInsets`

考虑用户界面布局方向的视图插入距离。

`struct NSDirectionalRectEdge`

## 另请参阅

### 用户界面

管理用户界面，包括窗口中视图的大小和位置。

使用堆栈视图或自动布局约束定位和调整视图大小。

为应用程序添加深色模式支持，并使用外观代理修改 UI。

为视图和其他内容添加动画，为用户创造更吸引人的体验。

组织视图层次结构并促进它们在屏幕上的显示。

播放声音和触觉反馈，并将语音识别和合成整合到界面中。

在 Mac 应用程序中支持连续性相机

使用连续性相机将来自用户 iPhone、iPad 或 iPod touch 的扫描文档和图片整合到您的 Mac 应用程序中。

---

# https://developer.apple.com/documentation/appkit/view-management

集合

- AppKit
- 视图管理

API 集合

# 视图管理

管理用户界面，包括窗口中视图的大小和位置。

## 主题

### 内容控制器

`class NSWindowController`

管理窗口的控制器，通常是存储在 nib 文件中的窗口。

`class NSViewController`

管理视图的控制器，通常从 nib 文件加载。

`class NSTitlebarAccessoryViewController`

管理标题栏-工具栏区域中自定义视图（称为附件视图）的对象。

### 分割视图界面

`class NSSplitViewController`

管理相邻子视图数组的对象，具有用于管理这些视图之间分隔符的分割视图对象。

`class NSSplitView`

水平或垂直线性堆叠排列两个或多个视图的视图。

`class NSSplitViewItem`

分割视图控制器中的项目。

### 堆栈视图界面

`class NSStackView`

水平或垂直排列视图数组的视图，并在窗口大小更改时更新其位置和大小。

### 标签视图界面

`class NSTabViewController`

管理标签视图界面的容器视图控制器，该界面组织多个内容页面但一次只显示一个页面。

`class NSTabView`

一次显示一页的多页界面。

`class NSTabViewItem`

标签视图中的项目。

### 分页界面

`class NSPageController`

控制视图或视图内容之间滑动导航和动画的对象。

### 媒体库界面

`class NSMediaLibraryBrowserController`

配置和显示媒体库浏览器面板的对象。

## 另请参阅

### 用户界面

在屏幕上呈现内容并处理用户输入和事件。

使用堆栈视图或自动布局约束定位和调整视图大小。

为应用程序添加深色模式支持，并使用外观代理修改 UI。

为视图和其他内容添加动画，为用户创造更吸引人的体验。

组织视图层次结构并促进它们在屏幕上的显示。

播放声音和触觉反馈，并将语音识别和合成整合到界面中。

在 Mac 应用程序中支持连续性相机

使用连续性相机将来自用户 iPhone、iPad 或 iPod touch 的扫描文档和图片整合到您的 Mac 应用程序中。

---

# https://developer.apple.com/documentation/appkit/view-layout

集合

- AppKit
- 视图布局

API 集合

# 视图布局

使用堆栈视图或自动布局约束定位和调整视图大小。

## 概述

当您设计应用程序界面时，会在应用程序窗口中定位视图和其他界面元素并适当调整其大小。但是，这些视图的大小和位置可能需要在运行时因几个原因而改变：

- 用户调整包含您视图的窗口大小。

- 用户的语言选择需要对标签和基于文本的视图进行大小更改。

`NSStackView` 对象在界面尺寸改变时自动调整其包含视图的位置。或者，自动布局约束让您指定规则，这些规则确定界面中视图的精确大小和位置

## 主题

### 堆栈视图

`class NSStackView`

水平或垂直排列视图数组的视图，并在窗口大小更改时更新其位置和大小。

### 自动布局约束

`class NSLayoutConstraint`

两个用户界面对象之间的关系，必须由基于约束的布局系统满足。

### 布局指南

`class NSLayoutGuide`

可以与自动布局交互的矩形区域。

`class NSLayoutDimension`

使用流畅 API 创建基于大小的布局约束对象的工厂类。

### 锚点

`class NSLayoutAnchor`

使用流畅 API 创建布局约束对象的工厂类。

`class NSLayoutXAxisAnchor`

使用流畅 API 创建水平布局约束对象的工厂类。

`class NSLayoutYAxisAnchor`

使用流畅 API 创建垂直布局约束对象的工厂类。

### 视图压缩

`protocol NSUserInterfaceCompression`

描述 UI 控件在空间受限时应如何重新显示的协议。

## 另请参阅

### 用户界面

在屏幕上呈现内容并处理用户输入和事件。

管理用户界面，包括窗口中视图的大小和位置。

为应用程序添加深色模式支持，并使用外观代理修改 UI。

为视图和其他内容添加动画，为用户创造更吸引人的体验。

组织视图层次结构并促进它们在屏幕上的显示。

播放声音和触觉反馈，并将语音识别和合成整合到界面中。

在 Mac 应用程序中支持连续性相机

使用连续性相机将来自用户 iPhone、iPad 或 iPod touch 的扫描文档和图片整合到您的 Mac 应用程序中。

---

# https://developer.apple.com/documentation/appkit/appearance-customization

集合

- AppKit
- 外观自定义

API 集合

# 外观自定义

为应用程序添加深色模式支持，并使用外观代理修改 UI。

## 主题

### 深色模式

在界面中支持深色模式

更新颜色、图像和行为，以便应用程序在深色模式激活时自动适应。

### 外观系统

为界面中的视图应用标准主题。

`class NSAppearance`

管理应用程序中 UI 元素标准外观属性的对象。

`protocol NSAppearanceCustomization`

用于获取和设置视图外观属性的一组方法。

## 另请参阅

### 用户界面

在屏幕上呈现内容并处理用户输入和事件。

管理用户界面，包括窗口中视图的大小和位置。

使用堆栈视图或自动布局约束定位和调整视图大小。

为视图和其他内容添加动画，为用户创造更吸引人的体验。

组织视图层次结构并促进它们在屏幕上的显示。

播放声音和触觉反馈，并将语音识别和合成整合到界面中。

在 Mac 应用程序中支持连续性相机

使用连续性相机将来自用户 iPhone、iPad 或 iPod touch 的扫描文档和图片整合到您的 Mac 应用程序中。

---

# https://developer.apple.com/documentation/appkit/animation

集合

- AppKit
- 动画

API 集合

# 动画

为视图和其他内容添加动画，为用户创造更吸引人的体验。

## 主题

### 基于视图的动画

`class NSViewAnimation`

应用程序视图的动画，仅限于框架位置和大小的更改，以及淡入淡出效果。

`protocol NSAnimatablePropertyContainer`

定义在最少 API 影响下向现有类添加动画的方法的一组方法。

`class NSAnimationContext`

动画上下文，包含有关环境和状态的信息。

`typealias Progress`

动画进度，作为 `0.0` 和 `1.0` 之间的浮点数。

`enum NSAnimationEffect`

标准系统动画效果的类型，包括显示和声音。

已弃用

### 演示

`protocol NSViewControllerPresentationAnimator`

一组方法，让您定义在两个视图控制器之间转换时播放的动画。

### 自定义动画

`class NSAnimation`

管理用户界面中动画计时和进度的对象。

`protocol NSAnimationDelegate`

`NSAnimation` 对象委托实现的一组可选方法。

## 另请参阅

### 用户界面

在屏幕上呈现内容并处理用户输入和事件。

管理用户界面，包括窗口中视图的大小和位置。

使用堆栈视图或自动布局约束定位和调整视图大小。

为应用程序添加深色模式支持，并使用外观代理修改 UI。

组织视图层次结构并促进它们在屏幕上的显示。

播放声音和触觉反馈，并将语音识别和合成整合到界面中。

在 Mac 应用程序中支持连续性相机

使用连续性相机将来自用户 iPhone、iPad 或 iPod touch 的扫描文档和图片整合到您的 Mac 应用程序中。

---

# https://developer.apple.com/documentation/appkit/windows-panels-and-screens

集合

- AppKit
- 窗口、面板和屏幕

API 集合

# 窗口、面板和屏幕

组织视图层次结构并促进它们在屏幕上的显示。

## 主题

### 窗口

`class NSWindow`

应用程序在屏幕上显示的窗口。

`class NSPanel`

通常执行对主窗口辅助功能的特殊窗口。

`protocol NSWindowDelegate`

窗口委托可以实现的一组可选方法，用于响应事件，如窗口调整大小、移动、暴露和最小化。

`class NSWindowTab`

与作为标签组一部分的窗口关联的标签。

`class NSWindowTabGroup`

作为单个标签窗口一起显示的一组窗口。

### 窗口恢复

`protocol NSWindowRestoration`

恢复类必须实现的一组方法，用于处理窗口的重新创建。

`protocol NSUserInterfaceItemIdentification`

用于将唯一标识符与用户界面中的对象关联的一组方法。

### 屏幕

`class NSScreen`

描述计算机监视器或屏幕属性的对象。

### 弹出框

`class NSPopover`

显示与屏幕上现有内容相关的附加内容的方式。

`protocol NSPopoverDelegate`

弹出框委托可以实现的一组可选方法，用于提供附加或自定义功能。

### 警告

`class NSAlert`

附加到文档窗口的模态对话框或表单。

`protocol NSAlertDelegate`

`NSAlert` 对象的委托实现的一组可选方法，用于响应用户对帮助的请求。

### 打开和保存面板

`class NSOpenPanel`

提示用户选择要打开的文件的面板。

`class NSSavePanel`

提示用户提供有关文件保存位置信息的面板。

`protocol NSOpenSavePanelDelegate`

用于管理与打开或保存面板交互的一组方法。

### 共享面板

`class NSSharingServicePicker`

用户可以从中选择的共享服务列表。

`protocol NSPreviewRepresentableActivityItem`

您在希望使用 macOS 共享表共享的自定义对象中采用的接口。

`class NSPreviewRepresentingActivityItem`

为使用 macOS 共享表共享的项目添加元数据的类型。

### 打印和 PDF 面板

`class NSPDFPanel`

与 macOS 用户界面一致的保存或导出为 PDF 面板。

`protocol NSPrintPanelAccessorizing`

打印面板对象可以用来从打印附件控制器获取信息的一组方法。

### 颜色面板

`class NSColorPanel`

应用程序中选择颜色的标准用户界面。

`protocol NSColorPickingCustom`

提供一种将颜色选择器（用于颜色选择的自定义用户界面）添加到应用程序颜色面板的方法的一组方法。

`protocol NSColorPickingDefault`

为颜色选择器提供基本行为的一组方法。

`class NSColorPicker`

实现默认颜色选择协议的抽象超类。

### 字体面板

`class NSFontPanel`

字体面板——显示可用字体列表的用户界面对象，让用户预览它们并更改用于显示文本的字体。

`struct ModeMask`

您用来告诉字体面板显示其某些或所有元素的一组方法。

`protocol NSFontChanging`

## 另请参阅

### 用户界面

在屏幕上呈现内容并处理用户输入和事件。

管理用户界面，包括窗口中视图的大小和位置。

使用堆栈视图或自动布局约束定位和调整视图大小。

为应用程序添加深色模式支持，并使用外观代理修改 UI。

为视图和其他内容添加动画，为用户创造更吸引人的体验。

播放声音和触觉反馈，并将语音识别和合成整合到界面中。

在 Mac 应用程序中支持连续性相机

使用连续性相机将来自用户 iPhone、iPad 或 iPod touch 的扫描文档和图片整合到您的 Mac 应用程序中。

---

# https://developer.apple.com/documentation/appkit/sound-speech-and-haptics

集合

- AppKit
- 声音、语音和触觉

API 集合

# 声音、语音和触觉

播放声音和触觉反馈，并将语音识别和合成整合到界面中。

## 主题

### 声音

`class NSSound`

加载和播放音频文件的简单界面。

### 语音

`class NSSpeechRecognizer`

macOS 中语音识别的 Cocoa 接口。

`class NSSpeechSynthesizer`

macOS 中语音合成的 Cocoa 接口。

已弃用

### 触觉

`class NSHapticFeedbackManager`

在具有 Force Touch 触控板的系统上提供对触觉反馈管理属性访问的对象。

`protocol NSHapticFeedbackPerformer`

触觉反馈执行器实现的一组方法和常量。

`protocol NSAlignmentFeedbackToken`

`class NSAlignmentFeedbackFilter`

可以过滤对象移动并在发生对齐时提供触觉反馈的对象。

## 另请参阅

### 用户界面

在屏幕上呈现内容并处理用户输入和事件。

管理用户界面，包括窗口中视图的大小和位置。

使用堆栈视图或自动布局约束定位和调整视图大小。

为应用程序添加深色模式支持，并使用外观代理修改 UI。

为视图和其他内容添加动画，为用户创造更吸引人的体验。

组织视图层次结构并促进它们在屏幕上的显示。

在 Mac 应用程序中支持连续性相机

使用连续性相机将来自用户 iPhone、iPad 或 iPod touch 的扫描文档和图片整合到您的 Mac 应用程序中。

---

# https://developer.apple.com/documentation/appkit/supporting-continuity-camera-in-your-mac-app

- AppKit
- 在 Mac 应用程序中支持连续性相机

文章

# 在 Mac 应用程序中支持连续性相机

使用连续性相机将来自用户 iPhone、iPad 或 iPod touch 的扫描文档和图片整合到您的 Mac 应用程序中。

## 概述

通过 macOS 10.14 及更高版本和 iOS 12 及更高版本中的连续性相机，您可以使用 iPhone、iPad 或 iPod touch 扫描文档或拍摄附近物品的照片，然后从应用程序中即时访问这些文档或照片。

如果您的应用程序处理图像，此功能可以是将图像导入应用程序的便捷方式。例如，文本编辑应用程序可以使用此功能轻松将图像合并到文档中。这也可以是将图像引入社交媒体应用程序的便捷方式。

使用 `NSTextView` 的应用程序会自动获得连续性相机支持。当用户在应用程序的文本视图中控制点击时，会出现连续性相机菜单项。然后用户可以在 iPhone 或 iPad 上拍摄照片或扫描文档，它会自动出现在文本视图中。然后可以在 `NSTextView` 文本存储对象中作为附件访问图像。

如果您没有使用 `NSTextView`，您需要为 macOS 界面添加支持以启用连续性相机，并合并从用户 iOS 设备拍摄的照片。

### 在响应器对象中启用支持

您必须告诉 AppKit 您的应用程序可以利用来自连续性相机的任何图像数据。您在响应器对象（如视图控制器）中执行此操作。

当连续性相机菜单项出现时，AppKit 调用当前响应器链中响应器对象的 `validRequestor(forSendType:returnType:)` 方法，以找到可以处理来自连续性相机的图像数据的对象。覆盖此方法以让 AppKit 知道您的响应器对象支持连续性相机生成的图像数据。当用户使用连续性相机拍摄照片或扫描文档时，AppKit 将图像数据放在剪贴板上并调用指定的响应器对象来处理数据。

您的响应器的 `validRequestor(forSendType:returnType:)` 实现必须验证它可以接收指定类型的剪贴板图像数据，然后返回在 AppKit 将图像数据放在剪贴板上时接收图像数据的对象。您的 `validRequestor(forSendType:returnType:)` 方法可以指定相同的接收器对象来处理图像数据。

以下是示例实现：

if let pasteboardType = returnType,
// 服务与图像相关。
NSImage.imageTypes.contains(pasteboardType.rawValue) {
return self // 此对象可以接收图像数据。
} else {
// 让响应器链中的对象处理消息。
return super.validRequestor(forSendType: sendType, returnType: returnType)
}
}

请注意，您的 `validRequestor(forSendType:returnType:)` 方法可以返回不同的对象来接收图像数据。例如，在视图控制器中实现 `validRequestor(forSendType:returnType:)` 方法并执行检查，但返回视图对象来合并数据。您也可以返回父对象或管理对象。例如，以下代码在窗口控制器中实现 `validRequestor(forSendType:returnType:)`，但返回活动视图控制器来定位粘贴的图像：

if let pasteboardType = returnType,
// 服务与图像相关。
NSImage.imageTypes.contains(pasteboardType.rawValue) {
// 指定活动视图控制器接收图像数据。
return self.contentViewController
} else {
// 让响应器链中的对象处理消息。
return super.validRequestor(forSendType: sendType, returnType: returnType)
}
}

在实现 `validRequestor(forSendType:returnType:)` 并指定对象接收图像数据后，AppKit 为应用程序中的指定菜单启用连续性相机菜单项，包括与视图关联的上下文菜单。

### 添加连续性相机菜单项

用户通过使用应用程序菜单栏菜单或上下文菜单中的菜单项来启动连续性相机。您可以将连续性相机菜单项添加到应用程序的任何菜单栏菜单中，或让 AppKit 自动将连续性相机菜单项添加到应用程序的上下文菜单之一。包含连续性相机菜单项的好地方是包含执行编辑相关活动选项的菜单，如文件和插入菜单。

要将连续性相机菜单项添加到应用程序的菜单栏菜单之一，请找到定义菜单栏的故事板文件，并在 Interface Builder 中执行以下步骤：

1. 向应用程序菜单添加项目。

2. 设置项目的名称，如"拍照"。AppKit 稍后提供名称。

3. 在身份检查器中，将菜单项的标识符属性设置为 `NSMenuItemImportFromDeviceIdentifier`（在 `NSMenuItem.h` 中定义）。

如下所示：

如果您的应用程序不使用故事板，您可以通过以下步骤以编程方式添加菜单项：

1. 获取应用程序的主菜单栏。

2. 从菜单栏获取所需的菜单项进行插入。

3. 获取菜单项的子菜单。

4. 创建相机菜单项并指定名称，如"拍照"。

5. 将相机菜单项的标识符属性设置为 `NSMenuItem.importFromDeviceIdentifier`。

6. 将相机菜单项添加到子菜单。

执行此操作的好地方是在应用程序委托的 `applicationWillFinishLaunching(_:)` 方法中，如以下示例所示：

func applicationWillFinishLaunching(_ aNotification: Notification) {
let mainMenu = NSApplication.shared.mainMenu
// 获取文件菜单项。
guard let fileMenu = mainMenu?.item(at: 1) else { return }
// 获取文件菜单项子菜单。
guard let subMenu = fileMenu.submenu else { return }
// 创建相机菜单项。
let cameraMenuItem =
NSMenuItem(title: "拍照", action: nil, keyEquivalent: "")
// 指定连续性相机菜单项标识符。
cameraMenuItem.identifier = NSMenuItem.importFromDeviceIdentifier
// 将相机菜单项添加到文件菜单。
subMenu.addItem(cameraMenuItem)
}

您不会直接将连续性相机菜单项添加到应用程序的上下文菜单。相反，您在应用程序的响应器对象中启用适当的支持，如前一节所述，AppKit 为您添加菜单项。

例如，以下代码演示了如何响应鼠标按下事件显示上下文菜单，并让 AppKit 插入菜单项。此代码覆盖 `mouseDown(with:)` 方法并创建菜单。然后调用 `NSMenu` 类方法 `popUpContextMenu(_:with:for:)`，传递与鼠标按下事件相关的事件对象和拥有上下文菜单的视图。AppKit 自动在上下文菜单中为您插入连续性相机菜单项。

override func mouseDown(with event: NSEvent) {
let theMenu = NSMenu(title: "上下文菜单")
/*
在视图上为鼠标按下事件显示上下文菜单。
AppKit 自动插入连续性相机菜单项。
*/
NSMenu.popUpContextMenu(theMenu, with: event, for: self.view)
}

当用户选择连续性相机菜单项时，系统自动在用户设备上启动连续性相机界面。用户拍摄图像后，AppKit 将该图像放在应用程序的剪贴板上。

### 从剪贴板合并图像数据

在 AppKit 将捕获的图像放在剪贴板上后，您需要将这些图像合并到应用程序中。然后 AppKit 调用活动响应器对象的 `readSelection(from:)` 方法来读取图像数据。`readSelection(from:)` 方法支持连续性相机图像数据和应用程序中的其他类型数据。使用该方法确定图像是否为应用程序支持的格式，并将该图像数据合并到应用程序中。

以下是 `readSelection(from:)` 方法的示例实现：

// 验证剪贴板包含图像数据。
guard pasteboard.canReadItem(withDataConformingToTypes: NSImage.imageTypes) else {
return false
}
// 加载图像。
guard let image = NSImage(pasteboard: pasteboard) else {
return false
}
// 将图像合并到应用程序中。
self.myImageView.image = image
// 此方法已成功读取剪贴板数据。
return true
}

## 另请参阅

### 用户界面

在屏幕上呈现内容并处理用户输入和事件。

管理用户界面，包括窗口中视图的大小和位置。

使用堆栈视图或自动布局约束定位和调整视图大小。

为应用程序添加深色模式支持，并使用外观代理修改 UI。

为视图和其他内容添加动画，为用户创造更吸引人的体验。

组织视图层次结构并促进它们在屏幕上的显示。

播放声音和触觉反馈，并将语音识别和合成整合到界面中。

---

# https://developer.apple.com/documentation/appkit/mouse-keyboard-and-trackpad

集合

- AppKit
- 鼠标、键盘和触控板

API 集合

# 鼠标、键盘和触控板

处理与鼠标、键盘和触控板输入相关的事件。

## 概述

`NSResponder` 类定义响应器链，这是响应用户事件的对象的有序列表。当用户点击鼠标按钮、在触控板上轻点或按下键时，会生成事件并向上传递响应器链以寻找可以响应它的对象。任何处理事件的对象都必须继承自 `NSResponder` 类。核心 AppKit 类 `NSApplication`、`NSWindow` 和 `NSView` 都继承自 `NSResponder`。

`NSApplication` 对象维护 `NSWindow` 对象列表——应用程序每个窗口一个——每个 `NSWindow` 对象维护 `NSView` 对象的层次结构。此视图层次结构用于绘制用户界面和处理事件。

`NSWindow` 对象处理窗口级事件并将其他事件分发给其视图。`NSWindow` 对象还有一个委托，允许您自定义其行为。

## 主题

### 响应器对象

`class NSResponder`

构成 AppKit 中事件和命令处理基础的抽象类。

### 鼠标、键盘和触摸事件

`class NSEvent`

包含有关输入操作（如鼠标点击或按键）信息的对象。

`class NSTouch`

特定触摸在瞬间的快照。

### 触控板

`class NSPressureConfiguration`

封装 Force Touch 触控板在响应特定事件时的行为和进展。

`class NSHapticFeedbackManager`

在具有 Force Touch 触控板的系统上提供对触觉反馈管理属性访问的对象。

### 常量

`struct EventTypeMask`

您用来从传入事件流中过滤特定事件类型的常量。

`struct ButtonMask`

您用来识别事件中激活的数位板按钮的常量。

`struct ModifierFlags`

表示事件对象中键状态的标志。

`struct Phase`

表示事件阶段期间可能阶段的常量。

`struct SwipeTrackingOptions`

指定滑动跟踪选项的常量。

`init(type: NSEvent.EventType)`

返回指定类型的事件掩码。

## 另请参阅

### 用户交互

实现菜单和光标以促进与应用程序的交互，并使用应用程序的 Dock 磁贴传达更新信息。

将应用程序的事件处理逻辑封装在手势识别器中，以便在整个应用程序中重用该代码。

在 Touch Bar 中显示交互式内容和控件。

使用拖放功能支持对应用程序内容的直接操作。

让您的 AppKit 应用程序对所有使用 macOS 的用户都可访问。

---

# https://developer.apple.com/documentation/appkit/menus-cursors-and-the-dock

集合

- AppKit
- 菜单、光标和 Dock

API 集合

# 菜单、光标和 Dock

实现菜单和光标以促进与应用程序的交互，并使用应用程序的 Dock 磁贴传达更新信息。

## 主题

### 菜单

`class NSMenu`

管理应用程序菜单的对象。

`class NSMenuItem`

应用程序菜单中的命令项。

`class NSMenuItemBadge`

为菜单项提供特定附加定量信息的控件，如可用更新的数量。

`protocol NSMenuDelegate`

`NSMenu` 对象的委托实现的可选方法，用于管理菜单显示和处理某些事件。

### 菜单验证

`protocol NSMenuItemValidation`

### 菜单栏项

`class NSStatusBar`

管理在系统范围菜单栏中显示的状态项集合的对象。

`class NSStatusItem`

在系统菜单栏中显示的单个元素。

`class NSStatusBarButton`

系统范围菜单栏中项目的外观和行为。

### 光标

`class NSCursor`

指针（也称为光标）。

`class NSTrackingArea`

视图的区域，当指针在该区域上时生成鼠标跟踪和光标更新事件。

### Dock

`class NSDockTile`

应用程序最小化窗口和应用程序图标在 Dock 中显示时的视觉表示。

`protocol NSDockTilePlugIn`

插件实现的一组方法，允许在应用程序未运行时自定义应用程序的 Dock 磁贴。

## 另请参阅

### 用户交互

处理与鼠标、键盘和触控板输入相关的事件。

将应用程序的事件处理逻辑封装在手势识别器中，以便在整个应用程序中重用该代码。

在 Touch Bar 中显示交互式内容和控件。

使用拖放功能支持对应用程序内容的直接操作。

让您的 AppKit 应用程序对所有使用 macOS 的用户都可访问。

---

# https://developer.apple.com/documentation/appkit/gestures

集合

- AppKit
- 手势

API 集合

# 手势

将应用程序的事件处理逻辑封装在手势识别器中，以便在整个应用程序中重用该代码。

## 主题

### 标准手势

`class NSClickGestureRecognizer`

跟踪指定鼠标点击次数的离散手势识别器。

`class NSPressGestureRecognizer`

跟踪用户在释放之前按住鼠标按钮最短时间的离散手势识别器。

`class NSPanGestureRecognizer`

用于平移手势的连续手势识别器。

`class NSRotationGestureRecognizer`

跟踪两个触控板触摸以圆周运动相反移动的连续手势识别器。

`class NSMagnificationGestureRecognizer`

跟踪放大内容的捏合手势的连续手势识别器。

### 自定义手势

`class NSGestureRecognizer`

监视事件并在预定义事件序列发生时调用其操作方法的对象。

`protocol NSGestureRecognizerDelegate`

用于微调手势识别器行为的一组方法。

## 另请参阅

### 用户交互

处理与鼠标、键盘和触控板输入相关的事件。

实现菜单和光标以促进与应用程序的交互，并使用应用程序的 Dock 磁贴传达更新信息。

在 Touch Bar 中显示交互式内容和控件。

使用拖放功能支持对应用程序内容的直接操作。

让您的 AppKit 应用程序对所有使用 macOS 的用户都可访问。

---

# https://developer.apple.com/documentation/appkit/touch-bar

集合

- AppKit
- Touch Bar

API 集合

# Touch Bar

在 Touch Bar 中显示交互式内容和控件。

## 主题

### 基础要点

将工具栏和 Touch Bar 集成到应用程序中

通过工具栏和相应的 Touch Bar 为用户提供快速访问应用程序功能的途径。

创建和自定义 Touch Bar

通过为 macOS 应用程序显示交互式内容和控件来采用 Touch Bar 支持。

`class NSTouchBar`

在支持的 MacBook Pro 型号的 Touch Bar 中提供动态上下文控件的对象。

`protocol NSTouchBarDelegate`

允许您为栏动态提供项目的协议。

`protocol NSTouchBarProvider`

对象采用的协议，用于在应用程序中创建栏对象。

### Touch Bar 项

`class NSTouchBarItem`

在支持的 MacBook Pro 型号的 Touch Bar 中显示的 UI 控件。

`class NSCandidateListTouchBarItem`

与其委托一起为当前文本视图提供文本建议列表的栏项。

`class NSColorPickerTouchBarItem`

提供系统定义的颜色选择器的栏项。

`class NSCustomTouchBarItem`

包含您选择的响应器（如视图、按钮或擦除器）的栏项。

`class NSGroupTouchBarItem`

提供栏以包含其他项目的栏项。

`class NSPopoverTouchBarItem`

提供可扩展到第二状态的双状态控件的栏项，显示其拥有的栏的内容。

`class NSSharingServicePickerTouchBarItem`

与其委托一起提供符合共享条件的对象列表的栏项。

`class NSSliderTouchBarItem`

提供滑块控件用于在范围内选择值的栏项。

`class NSStepperTouchBarItem`

提供步进器控件用于递增或递减值的栏项。

`class NSUserInterfaceCompressionOptions`

指定用户界面元素在空间受限时如何调整大小的对象。

`class NSButtonTouchBarItem`

提供按钮的栏项。

`class NSPickerTouchBarItem`

提供具有多个选项的选择器控件的栏项。

`enum ControlRepresentation`

指定选择器栏项显示样式的常量。

`enum SelectionMode`

指定选择器栏项选择模式的常量。

### 擦除器

`class NSScrubber`

Touch Bar 的可自定义项目选择器控件。

`protocol NSScrubberDataSource`

擦除器数据源对象实现的一组方法，用于从应用程序中的相关数据集合向擦除器提供项目。

`protocol NSScrubberDelegate`

擦除器委托实现的一组方法，用于响应用户交互。

### 擦除器项

`class NSScrubberItemView`

擦除器中特定索引位置的项目。

`class NSScrubberArrangedView`

其布局由擦除器管理的视图的抽象基类。

`class NSScrubberImageItemView`

用于在擦除器项目中显示图像的具体视图子类。

`class NSScrubberSelectionStyle`

为擦除器控件内选定和突出显示的项目提供装饰附件视图的抽象类。

`class NSScrubberSelectionView`

用于指定擦除器中突出显示或选定项目外观的抽象基类。

`class NSScrubberTextItemView`

用于在擦除器中显示项目文本的具体视图子类。

### 擦除器布局

`class NSScrubberFlowLayout`

在线性条带中端到端排列项目的具体布局对象。

`protocol NSScrubberFlowLayoutDelegate`

擦除器委托可以采用的协议，用于提供项目的大小。

`class NSScrubberProportionalLayout`

将每个项目的大小调整为擦除器可见大小的某个分数的具体布局对象。

`class NSScrubberLayoutAttributes`

擦除器项目的布局。

`class NSScrubberLayout`

描述擦除器控件内项目布局的抽象类。

## 另请参阅

### 用户交互

处理与鼠标、键盘和触控板输入相关的事件。

实现菜单和光标以促进与应用程序的交互，并使用应用程序的 Dock 磁贴传达更新信息。

将应用程序的事件处理逻辑封装在手势识别器中，以便在整个应用程序中重用该代码。

使用拖放功能支持对应用程序内容的直接操作。

让您的 AppKit 应用程序对所有使用 macOS 的用户都可访问。

---

# https://developer.apple.com/documentation/appkit/drag-and-drop

集合

- AppKit
- 拖放

API 集合

# 拖放

使用拖放功能支持对应用程序内容的直接操作。

## 概述

通过您这边的很少编程，自定义视图对象就可以被拖放到任何地方。对象通过符合拖拽协议成为此拖拽机制的一部分：可拖拽对象符合 `NSDraggingSource` 协议，目标对象（即放置的接收者）符合 `NSDraggingDestination` 协议。AppKit 隐藏了跟踪光标和显示拖拽图像的所有细节。

要了解如何为图像视图使用拖放功能，请参阅通过文件承诺支持拖放。要在表格视图中使用拖放功能，请参阅通过文件承诺支持表格视图拖放。有关集合视图中拖放功能的示例，请参阅通过文件承诺支持集合视图拖放，以及大纲视图：使用大纲和分割视图导航分层数据。

## 主题

### 拖拽源

通过创建项目来表示内容，从拖拽源发起内容。

`protocol NSDraggingSource`

拖拽会话中源对象实现的一组方法。

`class NSDraggingItem`

拖拽会话中的单个拖拽项目。

`class NSDraggingSession`

支持在进行中修改拖拽的拖放操作的封装。

`class NSDraggingImageComponent`

拖拽项目中的单个对象。

### 放置目标

在应用程序对象中接收拖拽的内容。

`protocol NSDraggingDestination`

拖拽图像的目标对象（或接收者）必须实现的一组方法。

`protocol NSDraggingInfo`

提供有关拖拽会话信息的一组方法。

`protocol NSSpringLoadingDestination`

拖拽对象的目标对象（或接收者）可以实现的一组方法，用于支持弹簧加载。

## 另请参阅

### 用户交互

处理与鼠标、键盘和触控板输入相关的事件。

实现菜单和光标以促进与应用程序的交互，并使用应用程序的 Dock 磁贴传达更新信息。

将应用程序的事件处理逻辑封装在手势识别器中，以便在整个应用程序中重用该代码。

在 Touch Bar 中显示交互式内容和控件。

让您的 AppKit 应用程序对所有使用 macOS 的用户都可访问。

---

# https://developer.apple.com/documentation/appkit/accessibility-for-appkit

集合

- AppKit
- AppKit 辅助功能

API 集合

# AppKit 辅助功能

让您的 AppKit 应用程序对所有使用 macOS 的用户都可访问。

## 概述

让您的应用程序可访问意味着让每个人都能使用它。通过在设计应用程序时考虑辅助功能，您可以让每个人都享受您的应用程序。有关更多信息，请参阅辅助功能。

AppKit 控件和视图具有内置辅助功能，默认提供可访问的用户体验。通常，您无需执行额外工作来启用标准辅助功能功能。

在某些情况下，您可能希望修改默认值以更好地表示您的应用程序、提供额外上下文或修改用户在应用程序中的流程。AppKit 使这些自定义变得简单，涉及几行代码或在定义用户界面时进行 Interface Builder 调整。有关为 AppKit 元素自定义辅助功能的更多信息，请参阅 `NSAccessibilityProtocol`。

如果您的应用程序包含子类化 `NSView` 的自定义用户界面元素，请使用自定义控件中基于角色的协议增强这些元素的辅助功能。如果您的应用程序包含不继承自 `NSView` 或其他具有内置辅助功能的 AppKit 类的自定义用户界面元素，请通过子类化 `NSAccessibilityElement` 使这些元素可访问。

如果您使用 SwiftUI 构建应用程序，请参阅辅助功能修饰符。

## 主题

### 基础要点

将辅助功能集成到应用程序中

通过添加辅助功能功能，让残障用户更容易访问您的应用程序。

Mac Catalyst 的辅助功能设计

通过使用键盘快捷键和辅助功能容器改善应用程序中的导航。

### AppKit 元素

如果您使用标准 AppKit 用户界面元素，可以覆盖其现有辅助功能属性或按原样使用。

`protocol NSAccessibilityProtocol`

可访问元素的属性和方法的完整列表。

`struct NSAccessibility`

AppKit 应用程序辅助功能符号的命名空间。

### 自定义视图子类

如果您正在子类化 AppKit 视图以创建自定义用户界面元素，可以采用一个或多个特定角色协议来增强该元素的辅助功能。

通过采用特定角色协议并实现其方法，为自定义用户界面元素支持辅助功能。

自定义视图和控件的全局辅助功能函数。

### 自定义元素

如果您正在设计不子类化 AppKit 视图的完全自定义用户界面元素，必须子类化辅助功能元素类。

`class NSAccessibilityElement`

与辅助应用程序交互的基本基础设施。

### 辅助功能类型

`struct Action`

描述操作类型的常量。

`struct AnnotationAttributeKey`

注释属性的键。

`enum NSAccessibilityAnnotationPosition`

指定注释应用位置的常量。

`struct Attribute`

描述属性的常量。

`struct FontAttributeKey`

字体属性的键。

`enum NSAccessibilityOrientation`

指示辅助功能元素方向的值，如滚动条和分割视图。

`struct OrientationValue`

指示用户界面元素方向的值，如滚动条和分割视图。

`struct ParameterizedAttribute`

描述参数化属性的值。

`struct Role`

描述辅助功能元素表示的对象类型的值。

`enum NSAccessibilityRulerMarkerType`

指示辅助功能元素标记类型的值。

`struct RulerMarkerTypeValue`

描述标尺标记类型的值。

`struct RulerUnitValue`

指示标尺或布局区域单位值的值。

`struct SortDirectionValue`

指示列排序方向的值。

`enum NSAccessibilitySortDirection`

`struct Subrole`

描述辅助功能元素表示的专门对象子类型的值。

`enum NSAccessibilityUnits`

## 另请参阅

### 用户交互

处理与鼠标、键盘和触控板输入相关的事件。

实现菜单和光标以促进与应用程序的交互，并使用应用程序的 Dock 磁贴传达更新信息。

将应用程序的事件处理逻辑封装在手势识别器中，以便在整个应用程序中重用该代码。

在 Touch Bar 中显示交互式内容和控件。

使用拖放功能支持对应用程序内容的直接操作。
