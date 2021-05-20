---
title: 实现码流传输
platform: iOS
updatedAt: 2020-11-24 07:15:27
---
## 初始化和监听事件
在加入频道开始数据传输之前，你需要先调用 `+initWithAppId:uid:events:logDirectory:` 方法初始化 RTD 服务。

在该方法中，你需要：
* 填入获取到的 App ID 和用户 ID。只有 App ID 相同的应用程序才能进入同一个频道进行互通。
* 设置事件回调 AgoraRtcServiceEvents，用以通知 SDK 在运行过程中发生的事件。
* 设置用于存放 SDK 日志的目录（填写 nil 表示使用默认目录）。

~~~objective-c
[AgoraRtcService initWithAppId:[KeyCenter appId] uid:0 events:self logDirectory:nil];

[AgoraRtcService setLogLevel:6];

[AgoraRtcService configLogWithPerFileSize:100000 rollCount:10];
~~~

## 加入频道
调用 `+joinChannel:tokenBytes:` 方法加入频道。

在该方法中，你需要：

* 传入能标识频道的频道 ID。输入相同频道 ID 的用户会进入同一个频道。
* 传入能标识用户角色和权限的 token。如果安全要求不高，使用的是 App ID，可以将该值设为 nil。

用户与频道的关系如下：
一个频道内的用户可以互相传输数据流。
一个用户可以同时加入多个频道。该用户加入的所有频道都能接收到他发送的音视频数据流。

成功加入频道后，SDK 会触发 `-rtcServiceDidJoinChannel:elapsed:` 回调。

~~~objective-c
[AgoraRtcService joinChannel:@"my_first_channel" tokenBytes:nil];
~~~

## 发送/获取数据流
成功加入频道后，你可以：
* 监听`-rtcServiceDidReceiveAudioDataInChannel:uid:timestamp:codec:audioData:` 回调接收所有你已加入的频道内的音频数据流。
* 监听 `-rtcServiceDidReceiveVideoDataInChannel:uid:timestamp:codec:streamId:isKeyFrame:videoData:` 回调接收所有你已加入的频道内的视频数据流。
* 调用 `+sendAudioDataToChannel:codec:audioData:` 方法向指定或所有你已加入的频道发送音频数据流。
* 调用 `+sendVideoDataToChannel:codec:streamId:isKeyFrame:videoData:` 方法向指定或所有你已加入的频道发送视频数据流。

~~~objective-c
[AgoraRtcService sendAudioDataToChannel:CHANNEL_NAME codec:AUDIO_CODEC audioData:data];

[AgoraRtcService sendVideoDataToChannel:CHANNEL_NAME codec:VIDEO_CODEC  streamId:VIDEO_STREAM_ID isKeyFrame:shouldBeKey videoData:data];

- (void)rtcServiceDidReceiveAudioDataInChannel:(NSString *)channelName uid:(uint32_t)uid timestamp:(uint16_t)timestamp codec:(uint8_t)codec audioData:(NSData *)audioData {
    NSLog(@"didReceiveAudioData");
}

- (void)rtcServiceDidReceiveVideoDataInChannel:(NSString *)channelName uid:(uint32_t)uid timestamp:(uint16_t)timestamp codec:(uint8_t)codec streamId:(uint8_t)streamId isKeyFrame:(BOOL)isKeyFrame videoData:(NSData *)videoData {
    NSLog(@"didReceiveVideoData");
}

~~~

## 离开频道
调用 `+leaveChannel:`  方法离开指定频道，结束在该频道的数据传输。

~~~objective-c
[AgoraRtcService leaveChannel:@"my_first_channel"];
~~~



