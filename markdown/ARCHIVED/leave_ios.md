---
title: 离开频道
platform: iOS
updatedAt: 2019-10-29 12:00:32
---
通话或直播结束时，调用 `leaveChannel` 方法离开频道。

不论当前是否还在直播频道中，调用该方法会把直播相关的所有资源释放掉。真正退出频道后，SDK 会触发 `didLeaveChannelWithStats` 回调。

> 如果在调用 `leaveChannel` 方法后立即使用 `destroy` ，则退出频道会被打断，SDK 也不会触发 `didLeaveChannelWithStats` 回调。

```objective-c
//Objective-C
-(void)leaveChannel {
  [self.agoraKit leaveChannel:nil];
```

```swift
//Swift
func leaveChannel() {
    agoraKit.leaveChannel(nil)
}
```