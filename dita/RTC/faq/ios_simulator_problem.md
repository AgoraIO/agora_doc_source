# 为什么在 Xcode 12.3 及之后版本中使用 iOS 模拟器构建项目会失败？


在 Xcode 12.3 及之后版本中，集成 Agora SDK 并使用 iOS 模拟器构建项目，你可能会收到如下错误信息：

```swift
Building for iOS Simulator, but the linked and embedded framework 'xxx.framework' was built for iOS + iOS Simulator.
```

## 问题原因

自 Xcode 11.0 起，Apple 允许但不推荐把用于多平台的二进制框架或库捆绑到一个 `.framework` 文件中。自 Xcode 12.3 起，Apple 不允许在一个 `.framework` 文件中绑定多平台的库，你必须使用 `.xcframework` 文件替代。为支持在 iOS 模拟器上运行项目，3.3.0 之前版本的 Agora SDK 在 `.framework` 文件中捆绑了多平台的库，所以 `.framework` 文件会在使用模拟器构建项目时被 Xcode 识别为错误配置。

