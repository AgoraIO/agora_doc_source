---
title: 耳返
platform: iOS
updatedAt: 2019-09-25 18:09:18
---

耳返主要实现监听的功能，在低延时的情况下可以给主播一个比较真实的反馈，在演唱会等专业场景里比较常用。
Agora SDK 支持耳返功能，同时支持调节耳返的音量。

## 实现方法

### 开启耳返功能

```swift
// swift
agoraKit.enable(inEarMonitoring: true) // 设置开启耳返功能，默认为 false
```

```objective-c
//objective-c
[agoraKit enableInEarMonitoring:YES]; // 设置开启耳返功能，默认为 NO
```

## 开发注意事项

以上方法都有返回值，返回值为 0 表示方法调用成功；返回值小于 0 表示方法调用失败。
