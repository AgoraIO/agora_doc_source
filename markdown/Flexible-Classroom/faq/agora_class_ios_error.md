Agora Classroom SDK for iOS 很大部分是使用 Swift 来编写的，支持 Swift 5.0 及以上版本。Swift 自 5.0 起支持 ABI 稳定，5.1 起支持 Module Stability。Agora Classroom SDK for iOS 开启了 Module Stability，这会导致你在修改 Agora Classroom SDK for iOS 源码时遇到一些报错。

本页列出了一些常见报错以及对应的解决方法。

## Module compiled with Swift 5.3.2 cannot be imported by the Swift 5.4 compiler

### 错误现象

你在运行灵动课堂 iOS 项目 1.1.0 版本时可能会遇到以下报错：

![](https://web-cdn.agora.io/docs-files/1620822526000)

### 错误原因

Agora Classroom SDK v1.1.0 支持的是 Swift 5.3.2，如果你使用的是 Swift 5.4，就会出现上述报错。

### 解决方法

如果你在项目中直接集成完整的 Agora Classroom SDK，建议你将 Agora Classroom SDK 升级至 v1.1.2 或以上版本。Agora Classroom SDK 自 v1.1.2 起支持 Swift 5.0 及以上版本。

## '@objc' instance method in extension of subclass of 'XXX' requires iOS 13.0.0

### 错误现象

在修改 Agora Classroom SDK 源码时，如果 A.framework 开启了 BUILD_LIBRARY_FOR_DISTRIBUTION，B 继承 A 中的类， 那么 B 使用 `extension` 且在 `extension` 里使用 `@objc` 时就会出现以下报错：

![](https://web-cdn.agora.io/docs-files/1624525158077)

### 解决方法

将 `@objc` 代码放在主类中。

## Explicit '@objc' on subclass of 'XXX' requires iOS 13.0.0

### 错误现象

在修改 Agora Classroom SDK 源码时，如果 A.framework 开启了 BUILD_LIBRARY_FOR_DISTRIBUTION，B 继承 A 中的类，B 中的类使用 `@objc` 可能出现以下报错：

![](https://web-cdn.agora.io/docs-files/1624525178299)

### 解决方法

去除 `@objc`，或者使用 `@objcMembers` 修饰。

## Non-'@objc' method 'tableView(_:numberOfRowsInSection:)' does not satisfy requirement of '@objc' protocol 'UITableViewDataSource'

### 错误现象

在修改 Agora Classroom SDK 源码时，如果 A.framework 开启了 BUILD_LIBRARY_FOR_DISTRIBUTION，B 继承 A 中的类，那么 B 使用 `extension` 且在 `extension` 里实现 `UITableViewDataSource` 或 `UITableViewDelegate`，可能会出现以下报错：

![](https://web-cdn.agora.io/docs-files/1624525202089)

实现自定义的 `@objc` 协议 `AgoraApaasReportorEventTube` 时也会出现以下报错：

![](https://web-cdn.agora.io/docs-files/1624525211463)

### 解决方法

将 Delegate 相关代码放在主类中。

## Undefined symbol: _OBJC_CLASS_$__TtC5OC_XXXXXXX

### 错误现象

你在修改 Agora Classroom SDK 源码时，A.framework 有 `AgoraAcceptedInfo` 这个 struct，B.framework 里的 Swift 类 `AgoraHandsUpVM` 包含 `AgoraAcceptedInfo` 类的成员变量，同时 B.framework 中有一个 OC 文件调用了 `AgoraHandsUpVM`。这种情况下，可能会出现以下报错：

![](https://web-cdn.agora.io/docs-files/1624525235312)

### 错误原因

B.framework 是静态编译，Swift 文件生成不了其他库非 OC 的类型。

### 解决方法

将 `AgoraAcceptedInfo` 修改成继承于 NSObject，并使用 `@objc` 或 `@objcMembers` 修饰。

## Unknown type name 'XXX'; did you mean 'ZZZ'?

### 错误现象

你在修改 Agora Classroom SDK 源码时，如果 A.framework 有 Swift 类 `AgoraReportor`，B.framework 的 Swift 类 `AgoraApaasReportor `继承于 `AgoraReportor`，同时 B.framework 有 OC 文件引用 `AgoraApaasReportor`，可能会碰到以下报错：

![](https://web-cdn.agora.io/docs-files/1624525251577)

### 解决方法

创建一个 Wrapper 类封装 `AgoraApaasReportor`，OC 文件引用 Wrapper 类。