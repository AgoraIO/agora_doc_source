---
title: Join Multiple Channels
platform: Android
updatedAt: 2020-11-16 07:09:47
---
## Introduction

As of v3.0.0, the Agora RTC SDK enables users to join an unlimited number of channels at a time and to receive the audio and video streams of all the channels.

## Implementation

The RTC SDK uses the `RtcChannel` and `RtcChannelEventHandler` classes to support the multi-channel function. To implement this function in your project, choose either of the following approaches:

### Approach 1: Use the RtcChannel class only

Follow these steps to implement the multi-channel function in your project:

1. Call `createRtcChannel` of the `RtcEngine` class to create an `RtcChannel` object with a channel ID.
2. Call `joinChannel` of the `RtcChannel` class to join the created channel.
3. Repeat steps 1 and 2 to create multiple `RtcChannel` objects, and call the `joinChannel` method of each object to join these channels.

<div class="alert note">
	<li>Once you have joined multiple channels, call the <code>publish</code> method of a specific <code>RtcChannel</code> object to publish the stream to the corresponding channel. Note that you can publish one stream in only one channel at a time.
	<li>After calling the <code>publish</code> method in Channel 1, you need to call the <code>unpublish</code> method in Channel 1 before calling the <code>publish</code> method in Channel 2.
</div>

This approach applies to scenarios where you need to frequently switch between channels and publish audio or video streams.

**API call sequence**

Refer to the following API sequence to implement the multi-channel function in your project with the `RtcChannel` class.

![](https://web-cdn.agora.io/docs-files/1575876020101)

**Sample code**

You can alse refer to the following sample code.

```Java
    public  boolean joinChannelWithRtcChannel(String channelId, String token, String info, int uid)
    {

        // 1. Create rtcEngine
        RtcEngine rtcEngine = RtcEngine.create(mContext, SConstants.MEDIA_APP_ID, new IRtcEngineEventHandler() {
            // Override events

            @Override
            public void onJoinChannelSuccess(String channel, int uid, int elapsed) {
                super.onJoinChannelSuccess(channel, uid, elapsed);
            }
        });

        // 2. Create rtcChannel
        RtcChannel rtcChannel = rtcEngine.createRtcChannel(channelId);
        if (null == rtcChannel) return false;

        // 3. Set rtcChannelEventHandler
        rtcChannel.setRtcChannelEventHandler(new IRtcChannelEventHandler() {
            // Override events

            @Override
            public void onJoinChannelSuccess(RtcChannel rtcChannel, int uid, int elapsed) {
                super.onJoinChannelSuccess(rtcChannel, uid, elapsed);
            }
        });

        // 4. Configurate mediaOptions
        ChannelMediaOptions mediaOptions = new ChannelMediaOptions();
        mediaOptions.autoSubscribeAudio = true;
        mediaOptions.autoSubscribeVideo = true;

        // 5. Join channel
        int ret = rtcChannel.joinChannel(token, info, uid, mediaOptions);

        return (ret == 0);
    }
```

### Approach 2: Use both the RtcEngine and RtcChannel classes

Follow these steps to implement the multi-channel function in your project:

1. Call `joinChannel` of the `RtcEngine` class to join the first channel.
2. Call `createRtcChannel` of the `RtcEngine` class to create an `RtcChannel` object with a channel ID.
3. Call `joinChannel` of the `RtcChannel` class to join the second channel.
4. Repeat steps 2 and 3 to create multiple `RtcChannel` objects, and call the `joinChannel` method of each object to join these channels.

This approach applies to scenarios where you publish streams only to the RtcEngine channel. If you have implemented RTC functions with an earlier version of our SDK, this approach does not require any change to your existing code.

**API call sequence**

Refer to the followng API sequence to implement the multi-channel function in your project with the `RtcEngine` and `RtcChannel` classes.

![](https://web-cdn.agora.io/docs-files/1575876078992)

We also provide an open-source sample project [Breakout Class](https://github.com/AgoraIO-Usecase/Breakout-Class/tree/master/breakout-windows) on GitHub that implements the multi-channel function. You can download it to better understand the code logic.

### API reference

- [`createRtcChannel`](./API%20Reference/java/v3.0.0/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a9eb0770851a8ba489564f72f9b280bca)
- [`RtcChannel`](./API%20Reference/java/v3.0.0/classio_1_1agora_1_1rtc_1_1_rtc_channel.html) 
- [`IRtcChannelEventHandler`](./API%20Reference/java/v3.0.0/classio_1_1agora_1_1rtc_1_1_i_rtc_channel_event_handler.html) 

## Considerations

### Subscription limits

When joining a channel by calling `joinChannel` in the `RtcChannel` class, if you set `autoSubscribeAudio` or `autoSubscribeVideo` as false, you cannot resume receiving the audio or video stream of a specified user by calling `muteRemoteAudioStream`(false) or `muteRemoteVideoStream`(false).

To resume receiving a specified stream, take the following steps:

1. Call `setDefaultMuteAllRemoteAudioStreams`(true) or `setDefaultMuteAllRemoteVideoStreams`(true) before joining the channel.
2. Join the channel.
3. Call `muteRemoteAudioStream`(false) or `muteRemoteVideoStream`(false), and specify the user whose stream you want to resume receiving.

### Setting the remote video

In video scenarios, if the remote user joins the channel using `RtcChannel`, ensure that you specify the channel ID of the remote user in  [VideoCanvas](./API%20Reference/java/v3.0.0/classio_1_1agora_1_1rtc_1_1video_1_1_video_canvas.html) when setting the remote video view. 

### Limits on publishing the stream

v3.0 supports publishing one stream to only one channel at a time. In other words, if you are already publishing a stream to a channel, you cannot publish that stream to a different channel.

You must meet the following requirements to implementing the multi-channel function. Otherwise, the  SDK returns `ERR_REFUSED(-5)`:

- When joining multiple channels using the `joinChannel` method in the `RtcChannel` class:
  - After calling the `publish` method in Channel 1, you need to call the `unpublish` method in Channel 1 before calling the publish method in Channel 2.
- When joining multiple channels using both the `RtcEngine` and `RtcChannel` classes:
  - In the Communication profile, if you join Channel 1 using the `RtcEngine` class, and Channel 2 using the `RtcChannel` class, you cannot call `publish` in the `RtcChannel` class.
  - In the Live-Broadcast profile, if you join Channel 1 using the `RtcEgine` class, and Channel 2 through the `RtcChannel` class, you cannot call `publish` in the `RtcChannel` class.
  - In the Live-Broadcast profile, after joining multiple channels, you cannot call the `publish` method in the `RtcChannel` class as an AUDIENCE.
  - After calling `publish` in the `RtcChannel` class, you need to call `unpublish` in the `RtcChannel` class. Otherwise, you cannot call `joinChannel` in the `RtcEngine` class.