---
title: 更改音视频流传输状态
platform: iOS
updatedAt: 2019-08-15 11:55:23
---

## 功能描述

用户成功加入频道并开始音视频流传输后，可以暂停向指定频道或所有频道发送流，也可以暂停接收指定频道或所有频道的流，从而灵活调整音视频流传输状态。

## 实现方法

### 发送端

**暂停/恢复发送本地音视频流**

可调用以下方法暂停或恢复发送本地音视频流：

- `muteLocalAudioOfChannel`：暂停发送本地**音频**流。
- `muteLocalVideoOfChannel`：暂停发送本地**视频**流。

> 你既可以通过传入频道名暂停或恢复向指定频道发送数据，也可以将 `channelName` 设置为 nil 暂停或恢复向所有频道发送数据。

示例代码如下，仅供参考：

```objective-c
[AgoraRtcService muteLocalAudioOfChannel:@"my_first_channel" mute:YES]; // Stop sending audio
[AgoraRtcService muteLocalVideoOfChannel:@"my_first_channel" mute:YES]; // Stop sending video
[AgoraRtcService muteLocalAudioOfChannel:@"my_first_channel" mute:NO]; // Start sending audio
[AgoraRtcService muteLocalVideoOfChannel:@"my_first_channel" mute:NO]; // Start sending video
```

### 接收端

**提示频道内远端用户音视频流发送状态**

发送端调用 `muteLocalAudioOfChannel` 或 `muteLocalVideoOfChannel` 方法更改本地音视频流传输状态后， SDK 会相应地触发以下回调，提示接收端频道内远端用户是否暂停发送音视频流：

- `rtcServiceRemoteUserDidMuteAudioInChannel`：提示本地用户频道内远端用户是否暂停发送**音频**流。
- `rtcServiceRemoteUserDidMuteVideoInChannel`：提示本地用户频道内远端用户是否暂停发送**视频**流。

示例代码如下，仅供参考：

```objective-c
- (void)rtcServiceRemoteUserDidMuteAudioInChannel:(NSString *)channelName uid:(uint32_t)uid muted:(BOOL)muted {
    NSLog(@"remoteUserDidMuteAudio");
}

- (void)rtcServiceRemoteUserDidMuteVideoInChannel:(NSString *)channelName uid:(uint32_t)uid muted:(BOOL)muted {
    NSLog(@"remoteUserDidMuteVideo");
}
```

**暂停/恢复接收远端音视频流**
可调用以下方法暂停或恢复接收指定频道内指定用户的音视频流：

- `muteRemoteAudioOfChannel`：暂停接收远端**音频**流。
- `muteRemoteVideoOfChannel`：暂停接收远端**视频**流。

> 你既可以通过填写频道名暂停接收指定频道的数据，也可以将 `channelName` 设置为 nil 暂停接收所有频道的数据。

```objective-c
[AgoraRtcService muteRemoteAudioOfChannel:@"my_first_channel" uid:remoteUid mute:YES]; // Stop receiving audio from a remote user
[AgoraRtcService muteRemoteVideoOfChannel:@"my_first_channel" uid:remoteUid mute:YES]; // Stop receiving video from a remote user
[AgoraRtcService muteRemoteAudioOfChannel:@"my_first_channel" uid:remoteUid mute:NO]; // Start receiving audio from a remote user
[AgoraRtcService muteRemoteVideoOfChannel:@"my_first_channel" uid:remoteUid mute:NO]; // Start receiving video from a remote user
```

## API 参考

- [`muteLocalAudioOfChannel`](./API%20Reference/rtsa_oc/Classes/AgoraRtcService.html#//api/name/muteLocalAudioOfChannel:mute:)
- [`muteLocalVideoOfChannel`](./API%20Reference/rtsa_oc/Classes/AgoraRtcService.html#//api/name/muteLocalVideoOfChannel:mute:)
- [`muteRemoteAudioOfChannel`](./API%20Reference/rtsa_oc/Classes/AgoraRtcService.html#//api/name/muteRemoteAudioOfChannel:uid:mute:)
- [`muteRemoteVideoOfChannel`](./API%20Reference/rtsa_oc/Classes/AgoraRtcService.html#//api/name/muteRemoteVideoOfChannel:uid:mute:)
- [`rtcServiceRemoteUserDidMuteAudioInChannel`](./API%20Reference/rtsa_oc/Protocols/AgoraRtcServiceEvents.html#//api/name/rtcServiceRemoteUserDidMuteAudioInChannel:uid:muted:)
- [`rtcServiceRemoteUserDidMuteVideoInChannel`](./API%20Reference/rtsa_oc/Protocols/AgoraRtcServiceEvents.html#//api/name/rtcServiceDidReceiveVideoDataInChannel:uid:timestamp:codec:streamId:isKeyFrame:videoData:)
