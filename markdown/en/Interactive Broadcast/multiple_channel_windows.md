---
title: Join Multiple Channels
platform: Windows
updatedAt: 2020-11-16 07:07:36
---
## Introduction

As of v3.0.0, the Agora RTC SDK enables users to join an unlimited number of channels at a time and to receive the audio and video streams of all the channels.

## Implementation

The RTC SDK uses the `IChannel` and `IChannelEventHandler` classes to support the multi-channel function. To implement this function in your project, choose either of the following approaches:

### Approach 1: Use the IChannel class only

Follow these steps to implement the multi-channel function in your project:

1. Cast the `IRtcEngine` class to `IRtcEngine2`.
2. Call `createChannel` of the `IRtcEngine2` class to create an `IChannel` object with a channel ID.
3. Call `joinChannel` of the `IChannel` class to join the created channel.
4. Repeat steps 2 and 3 to create multiple `IChannel` objects, and call the `joinChannel` method of each object to join these channels.

<div class="alert note">
	<li>Once you have joined multiple channels, call the <code>publish</code> method of a specific <code>IChannel</code> object to publish the stream to the corresponding channel. Note that you can publish one stream in only one channel at a time.
	<li>After calling the <code>publish</code> method in Channel 1, you need to call the <code>unpublish</code> method in Channel 1 before calling the <code>publish</code> method in Channel 2.
</div>

This approach applies to scenarios where you need to frequently switch between channels and publish audio or video streams.

**API call sequence**

Refer to the following API sequence to implement the multi-channel function in your project with the `IChannel` class.

![](https://web-cdn.agora.io/docs-files/1575868007208)

**Sample code**

You can alse refer to the following sample code.

```C++
bool JoinChannelWithIChannel(const char *channelId, const char *token, const char *info, uid_t uid)
{
    if (NULL == channelId) return false;
    
    // 1. Create agoraRtcEngine
    agora::rtc::IRtcEngine *engine = createAgoraRtcEngine();
    
    // 2. Create IChannel
    agora::rtc::IChannel *channel = static_cast<agora::rtc::IRtcEngine2 *>(engine)->createChannel(channelId);
    if (NULL == channel) return false;
    
    // 3. Set channelEventHandler
    // Replace with your own IChannelEventHandler implementation
    agora::rtc::IChannelEventHandler *channelEH = new agora::rtc::IChannelEventHandler();
    channel->setChannelEventHandler(channelEH);
  
    // 4. Configurate mediaOptions
    agora::rtc::ChannelMediaOptions options;
    options.autoSubscribeAudio = true;
    options.autoSubscribeVideo = true;
    
    // 5. Join channel
    int ret = channel->joinChannel(token, info, uid, options);
    
    return (ret == 0);
}
```

### Approach 2: Use both the IRtcEngine and IChannel classes

Follow these steps to implement the multi-channel function in your project:

1. Call `joinChannel` of the `IRtcEngine` class to join the first channel.
2. Cast the `IRtcEngine` class to `IRtcEngine2`.
3. Call `createChannel` of the `IRtcEngine2` class to create an `IChannel` object with a channel ID.
4. Call `joinChannel` of the `IChannel` class to join the second channel.
5. Repeat steps 3 and 4 to create multiple `IChannel` objects, and call the `joinChannel` method of each object to join these channels.

This approach applies to scenarios where you publish streams only to the RtcEngine channel. If you have implemented RTC functions with an earlier version of our SDK, this approach does not require any change to your existing code.

**API call sequence**

Refer to the followng API sequence to implement the multi-channel function in your project with the `IRtcEngine` and `IChannel` classes.

![](https://web-cdn.agora.io/docs-files/1575868024031)

We also provide an open-source sample project [Breakout Class](https://github.com/AgoraIO-Usecase/Breakout-Class/tree/master/breakout-windows) on GitHub that implements the multi-channel function. You can download it to better understand the code logic.

### API reference

- [`createChannel`](./API%20Reference/cpp/v3.0.0/classagora_1_1rtc_1_1_i_rtc_engine2.html#a9cabefe84d3a52400f941f1bd8c0f486)
- [`IChannel`](./API%20Reference/cpp/v3.0.0/classagora_1_1rtc_1_1_i_channel.html)
- [`IChannelEventHandler`](./API%20Reference/cpp/v3.0.0/classagora_1_1rtc_1_1_i_channel_event_handler.html)

## Considerations

### Subscription limits

When joining a channel by calling `joinChannel` in the `RtcChannel` class, if you set `autoSubscribeAudio` or `autoSubscribeVideo` as false, you cannot resume receiving the audio or video stream of a specified user by calling `muteRemoteAudioStream`(false) or `muteRemoteVideoStream`(false).

To resume receiving a specified stream, take the following steps:

1. Call `setDefaultMuteAllRemoteAudioStreams`(true) or `setDefaultMuteAllRemoteVideoStreams`(true) before joining the channel.
2. Join the channel.
3. Call `muteRemoteAudioStream`(false) or `muteRemoteVideoStream`(false), and specify the user whose stream you want to resume receiving.

### Setting the remote video

In video scenarios, if the remote user joins the channel using `AgoraRtcChannel`, ensure that you specify the channel ID of the remote user in  [AgoraRtcVideoCanvas](./API%20Reference/cpp/v3.0.0/structagora_1_1rtc_1_1_video_canvas.html) when setting the remote video view. 

### Limits on publishing the stream

v3.0 supports publishing one stream to only one channel at a time. In other words, if you are already publishing a stream to a channel, you cannot publish that stream to a different channel.

You must meet the following requirements to implementing the multi-channel function. Otherwise, the  SDK returns `ERR_REFUSED(-5)`:

- When joining multiple channels using the `joinChannel` method in the `IChannel` class:
  - After calling the `publish` method in Channel 1, you need to call the `unpublish` method in Channel 1 before calling the publish method in Channel 2.
- When joining multiple channels using both the `IRtcEngine` and `IChannel` classes:
  - In the `COMMUNICATION` profile, if you join Channel 1 using the `IRtcEngine` class, and Channel 2 using the `IChannel` class, you cannot call `publish` in the `IChannel` class.
  - In the `LIVE_BROADCASTING` profile, if you join Channel 1 using the `IRtcEgine` class, and Channel 2 through the `IChannel` class, you cannot call `publish` in the `IChannel` class.
  - In the `LIVE_BROADCASTING` profile, after joining multiple channels, you cannot call the `publish` method in the `IChannel` class as an AUDIENCE.
  - After calling `publish` in the IChannel class, you need to call `unpublish` in the `IChannel` class. Otherwise, you cannot call `joinChannel` in the `IRtcEngine` class.