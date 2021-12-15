---
title: 加入频道
platform: iOS
updatedAt: 2020-04-20 11:21:29
---

在加入频道前，请确保你已完成环境准备、安装包获取等步骤，详见[客户端集成](/cn/Voice/ios_audio)。

## 实现方法

App 在加入频道前，需要先设置频道模式，再加入频道。

### 设置频道模式为通信

创建实例后，调用 `setChannelProfile` 方法设置频道场景。SDK 会根据所设置的频道场景使用不同的优化手段。

在该方法中，将频道场景设置为通信场景。通信场景适用于语音或视频通话场景，如一对一聊天或群聊。频道中的任何用户都可以自由发言。该模式为默认模式。

> - 该方法必须在加入频道前调用才能生效。
> - 同一频道只能设置一种频道场景。如果需要切换频道场景，请先调用 `destroy` 方法销毁后重新创建一个 Engine 实例，再调用该方法将频道设置为其他模式。

```objective-c
//Objective-C
- (void)setChannelProfile() {
  [self.agoraKit setChannelProfile:AgoraChannelProfileCommunication]
}
```

```swift
//Swift
func setChannelProfile() {
  agoraKit.setChannelProfile(.channelProfile_Communication)
}
```

### 加入通信频道

调用 `joinChannelByToken` 方法加入频道。

在该方法中：

- 传入能标识用户角色和权限的 Token。
  - 测试环境下，你可以使用临时 Token，详见[获取临时 Token](token#get-a-temporary-token)。
  - 生产环境下，我们推荐你使用在自己的服务端生成的正式 Token。关于如何生成正式 Token，详见[服务端生成 Token](./token_server)。
- 传入能标识频道的频道 ID。输入相同频道 ID 的用户会进入同一个频道。
- 传入能标识用户身份的用户 UID。请确保频道内每个用户的 UID 必须是独一无二的。如果想要从不同的设备同时接入同一个频道，请确保每个设备上使用的 UID 是不同的。

> 如果已在通话中，则必须调用 `leaveChannel` 方法退出当前通话，才能进入下一个频道。

```objective-c
//Objective-C
- (void)joinChannel {
  [self.agoraKit joinChannelByToken:"token" channelId:@"channel1" info:nil uid:0 joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
    // Join channel "demoChannel1"
  }];
}
```

```swift
//Swift
func joinChannel() {
  agoraKit.joinChannel(by Token: "token", channelId: "demoChannel1", info:nil, uid:0){[weak self] (sid, uid, elapsed) -> Void in
      // Join channel "demoChannel1"
  }
}
```

## 相关文档

成功加入频道后，你可以使用 Agora SDK，实现如下功能进行语音通话：

- [发布和订阅音频流](/cn/Voice/publish_ios_audio)

如果在通话过程中，对音量、音效、音调等有特殊需求，你还可以：

- [调整通话音量](/cn/Voice/volume_ios_audio)
- [播放音效/音乐混音](/cn/Voice/effect_mixing_ios_audio)
- [使用耳返](/cn/Voice/in-ear_ios_audio)
- [调整音调、音色](/cn/Voice/voice_effect_ios_audio)
