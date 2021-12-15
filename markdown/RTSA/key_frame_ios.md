---
title: 关键帧
platform: iOS
updatedAt: 2019-08-15 11:55:37
---

## 功能描述

关键帧是自带全部解码信息的独立视频帧，解码时无需参考其他图像，只需要本帧数据就可以完成。关键帧的设置会影响视频编解码效率和数据空间占用。

## 实现方法

### 发送端

发送端在调用 `sendVideoDataToChannel` 方法发送视频帧时通过 `isKeyFrame` 参数告知 SDK 该视频帧是否为关键帧。

示例代码如下，仅供参考：

```objective-c
uint8_t videoCodec = 97;
uint8_t videoStreamId = 0;
BOOL shouldBeKey = YES;
[AgoraRtcService sendVideoDataToChannel:@"my_first_channel" codec:videoCodec streamId:videoStreamId isKeyFrame:shouldBeKey videoData:videoData];
```

发送端长时间没有发送关键帧、关键帧丢失或损坏时，SDK 会通过 `rtcServiceRemoteUserDidRequestKeyFrameInChannel` 回调告知发送端为指定的视频流编码一个新的关键帧。

示例代码如下，仅供参考：

```objective-c
- (void)rtcServiceRemoteUserDidRequestKeyFrameInChannel:(NSString *)channelName uid:(uint32_t)uid streamId:(uint8_t)streamId {
    // Ask the encoder to do an IDR on specified stream
}
```

### 接收端

接收端解码出错时，可主动调用 `requestVideoKeyFrameOfChannel` 方法请求关键帧。

示例代码如下，仅供参考：

```objective-c
[AgoraRtcService requestVideoKeyFrameOfChannel:@"my_first_channel" uid:remoteUid streamId:0];
```

## API 参考

- [`sendVideoDataToChannel`](./API%20Reference/rtsa_oc/Classes/AgoraRtcService.html#//api/name/sendVideoDataToChannel:codec:streamId:isKeyFrame:videoData:)
- [`requestVideoKeyFrameOfChannel`](./API%20Reference/rtsa_oc/Classes/AgoraRtcService.html#//api/name/requestVideoKeyFrameOfChannel:uid:streamId:)
- [`rtcServiceRemoteUserDidRequestKeyFrameInChannel`](./API%20Reference/rtsa_oc/Protocols/AgoraRtcServiceEvents.html#//api/name/rtcServiceRemoteUserDidRequestKeyFrameInChannel:uid:streamId:)

## 开发注意事项

为了提升用户体验，我们建议视频编码器定期主动编码关键帧。
