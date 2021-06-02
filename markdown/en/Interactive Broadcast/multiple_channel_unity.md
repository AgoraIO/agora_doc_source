---
title: Join Multiple Channels
platform: Unity
updatedAt: 2021-02-17 03:01:32
---
## Introduction

As of v3.0.1, the Agora Unity SDK enables users to join an unlimited number of channels at a time and to receive the audio and video streams of all the channels.

This feature can be applied to a multiplayer game scenario: All players are in one channel, and they can interact with each other in real time. When players are on separate teams, members on the same team can communicate with each other in real time.

## Implementation

The Agora Unity SDK uses the `AgoraChannel` class to support the multi-channel function. To implement this function in your project, choose either of the following approaches:

**Approach 1: Use the** **AgoraChannel** **class only**

Follow these steps to implement the multi-channel function in your project:

1. Call `CreateChannel` of the `IRtcEngine` class to create an `AgoraChannel` object with `channelId`.
2. Call `JoinChannel` of the `AgoraChannel` class to join the created channel.
3. Repeat steps 1 and 2 to create multiple `AgoraChannel` objects, and call the `JoinChannel` method of each object to join these channels.

This approach applies to scenarios where you need to frequently switch between channels and publish audio or video streams.

<div class="alert note"><li>To receive and render multi-channel videos, call <tt>SetMultiChannelWant</tt> before joining a channel, and call <tt>SetForMultiChannelUser</tt> before binding <tt>VideoSurface.cs</tt> to set up the local or remote video view.Once you have joined multiple channels, call the <tt>Publish</tt> method of a specific <tt>AgoraChannel</tt> object to publish the stream to the corresponding channel. Note that you can publish one stream in only one channel at a time.After calling the <tt>Publish</tt> method in Channel 1, you need to call the <tt>Unpublish</tt> method in Channel 1 before calling the <tt>Publish</tt> method in Channel 2.</div>

**API call sequence**

Refer to the following API sequence to implement the multi-channel function in your project with the `AgoraChannel` class.

![](https://web-cdn.agora.io/docs-files/1600078407324)

**Sample code**

You can also refer to the following sample code.

```c#
void Start () 
{
    // 1. Initializes the IRtcEngine instance.
    mRtcEngine = IRtcEngine.GetEngine(APP_ID);

    // To receive and render multi-channel videos, calls SetMultiChannelWant before joining a channel
    mRtcEngine.SetMultiChannelWant(true);

    // 2. Creates an AgoraChannel object.
    mRtcchannel = mRtcEngine.CreateChannel(channelName);

    // 3. Listens for callbacks which report a user joins or leaves a channel successfully.
    mRtcchannel.ChannelOnJoinChannelSuccess = ChannelOnJoinChannelSuccessHandler;
    mRtcchannel.ChannelOnLeaveChannel = ChannelOnLeaveChannelHandler;

    // 4. Joins a channel.
    mRtcchannel.JoinChannel("", "", 0, new ChannelMediaOptions(true, true));
    // Publish audio or video streams.
    mRtcchannel.Publish();	
}

void OnApplicationQuit()
{
    if (mRtcEngine != null)
    {
        // 5. Leaves a channel.
        mRtcchannel.LeaveChannel();
        // 6. Releases all AgoraChannel objects.
        mRtcchannel.ReleaseChannel();
        // 7. Destroys the IRtcEngine instance.
        IRtcEngine.Destroy();
    }
}

// Occurs when a user joins a channel.
void ChannelOnJoinChannelSuccessHandler(string channelId, uint uid, int elapsed)
{
    makeVideoView(channelId ,0);
}

// Occurs when a user leaves a channel.
void ChannelOnLeaveChannelHandler(string channelId, RtcStats rtcStats)
{
}

void makeVideoView(string channelId, uint uid)
{
    GameObject go = GameObject.Find(uid.ToString());
    if (!ReferenceEquals(go, null))
    {
        return; 
    }

    // Creates a GameObject and binds the object to the VideoSurface.
    VideoSurface videoSurface = makeImageSurface(uid.ToString());
    if (!ReferenceEquals(videoSurface, null))
    {
        // Sets up the local or remote video view.
        videoSurface.SetForMultiChannelUser(channelId, uid);
    }
}

VideoSurface makeImageSurface(string goName)
{
    GameObject go = new GameObject();

    go.name = goName;
    go.AddComponent<RawImage>();

    GameObject canvas = GameObject.Find("VideoCanvas");
    if (canvas != null)
    {
        go.transform.parent = canvas.transform;
    }
    
    go.transform.Rotate(0f, 0.0f, 180.0f);
    float xPos = Random.Range(Offset - Screen.width / 2f, Screen.width / 2f - Offset);
    float yPos = Random.Range(Offset, Screen.height / 2f - Offset);
    go.transform.localPosition = new Vector3(xPos, yPos, 0f);
    go.transform.localScale = new Vector3(3f, 4f, 1f);

    VideoSurface videoSurface = go.AddComponent<VideoSurface>();
    return videoSurface;
}
```

### Approach 2: Use both the AgoraChannel and IRtcEngine classes

Follow these steps to implement the multi-channel function in your project:

1. Call `JoinChannelByKey` of the `IRtcEngine` class to join the first channel.
2. Call `CreateChannel` of the `IRtcEngine` class to create an `AgoraChannel` object with `channelId`.
3. Call `JoinChannel` of the `AgoraChannel` class to join the second channel.
4. Repeat steps 2 and 3 to create multiple `AgoraChannel` objects, and call the `JoinChannel` method of each object to join these channels.

This approach applies to scenarios where you publish streams only to the `IRtcEngine` channel. If you have implemented RTC functions with an earlier version of our SDK, this approach does not require any change to your existing code.

<div class="alert note"><li>To set the local or remote video view in the <tt>IRtcEngine</tt> channel, call <tt>SetForUser</tt> before binding <tt>VideoSurface.cs</tt>.</li><li>To receive and render multi-channel videos, call <tt>SetMultiChannelWant</tt> before joining the channel.</li></div>

**API call sequence**

Refer to the following API sequence to implement the multi-channel function in your project with the `IRtcEngine` and `AgoraChannel` classes.

![](https://web-cdn.agora.io/docs-files/1600078418070)

### API reference

- [`CreateChannel`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html)
- [`AgoraChannel`](./API%20Reference/unity/classagora__gaming__rtc_1_1_agora_channel.html) class

## Considerations

### Subscription limits

When joining a channel by calling `JoinChannel` in the `AgoraChannel` class, if you set `autoSubscribeAudio` or `autoSubscribeVideo` as false, you cannot resume receiving the audio or video stream of a specified user by calling `MuteRemoteAudioStream(false)` or `MuteRemoteVideoStream(false)`.

To resume receiving a specified stream, take the following steps:

1. Call `SetDefaultMuteAllRemoteAudioStreams(true)` or `SetDefaultMuteAllRemoteVideoStreams(true)` before joining the channel.
2. Join the channel.
3. Call `MuteRemoteAudioStream(false)` or `MuteRemoteVideoStream(false)`, and specify the user whose stream you want to resume receiving.

### Setting the remote video

In video scenarios, to receive multi-channel video streams, you need to call `SetMultiChannelWant` before joining the channel. To render the remote video view, you need to call `SetForMultiChannelUser` before binding `VideoSurface.cs`, and specify the remote user’s `uid` and the `channelId` of their channel.

### Limits on publishing the stream

v3.0.1 supports publishing one stream to only one channel at a time. In other words, if you are already publishing a stream to a channel, you cannot publish that stream to a different channel.

You must meet the following requirements to implementing the multi-channel function. Otherwise, the SDK returns `ERR_REFUSED(-5)`:

- When joining multiple channels using the method in the `AgoraChannel` class:
  - After calling the `Publish` method in Channel 1, you need to call the `Unpublish` method in Channel 1 before calling the `Publish` method in Channel 2.
- When joining multiple channels using both the `IRtcEngine` and `AgoraChannel` classes:
  - In the `COMMUNICATION` or `LIVE_BROADCASTING` profile, if you join Channel 1 using the `IRtcEngine` class, and Channel 2 using the `AgoraChannel` class, you cannot call `Publish` in the `AgoraChannel` class.
  - In the `LIVE_BROADCASTING` profile, after joining multiple channels, you cannot call the `Publish` method in the `AgoraChannel` class as an AUDIENCE.
  - After calling `Publish` in the `AgoraChannel` class, you need to call `Unpublish` in the `AgoraChannel` class. Otherwise, you cannot call `JoinChannelByKey` in the `IRtcEngine` class.