---
title: Set the Subscribing State
platform: Android
updatedAt: 2021-03-12 04:56:25
---
## Overview

In real-time engagement, you may need to set the [subscribing](https://docs.agora.io/en/Agora%20Platform/subscribe) state of audio and video streams according to your business scenarios. For example, after joining a channel, a user needs to unsubscribe from a remote user.

This article describes how to set the subscribing state in common scenarios. 

<div class="alert note"><li>This article applies to the SDK v3.3.0 and later.</li><li>If you have upgraded the SDK from an earlier version to v3.3.0 or later, Agora recommends that you adjust your subscribing settings by referring to <a href="#api_changes">API changes</a > in order to avoid any impact on your business functions.</li><li>Subscribing to audio and video streams results in all associated usage costs.</li></div>

## API introduction

By default, users subscribe to all remote users' audio and video streams when joining a channel or switching to a channel. You can call the following APIs to set the subscribing state:

| API                                                          | Target                  | Requirements for calling the API                             |
| :----------------------------------------------------------- | :---------------------- | :----------------------------------------------------------- |
| `autoSubscribeAudio` or `autoSubscribeVideo` of `channelMediaOptions` | All remote users        | Set this API when calling `joinChannel`[2/2] or `switchChannel`[2/2] |
| `muteAllRemoteAudioStreams` or `muteAllRemoteVideoStreams`   | All remote users        | Call at any time in the channel                              |
| `muteRemoteAudioStream` or `muteRemoteVideoStream`           | A specified remote user | Call at any time in the channel                              |

<div class="alert note"><li>In the channel, the methods with prefixes <code>muteAll</code> or <code>muteRemote</code> can override the subscribing settings when joining a channel or switching to a channel.</li><li>The methods with prefixes <code>muteAll</code> 和 <code>muteRemote</code> are independent of each other. When the two methods are called together, the method that is called later takes effect.</li></div>

## Recommended settings

### Scenario One: Unsubscribe from specified users in a channel

If the user subscribes to all remote users when joining a channel or switching to a channel, the user may need to unsubscribe from one or more remote users in the channel. Agora recommends the following steps:

1. Use the default settings of the SDK when joining a channel or switching to a channel.
2. In the channel, call `muteRemoteAudioStream` (`uid`, `true`) or `muteRemoteVideoStream` (`uid`, `true`) to unsubscribe from specified remote users.

### <a name="scenario2"></a>Scenario Two: Subscribe to specified users when joining a channel

The user may need to subscribe to one or more remote users when joining a channel or switching to a channel. Agora recommends the following steps:

1. Call `joinChannel`[2/2] or `switchChannel`[2/2] and set `autoSubscribeAudio(false)` or `autoSubscribeVideo(false)` to unsubscribe from all remote users.
2. In the channel, call `muteRemoteAudioStream` (`uid`,` false`) or `muteRemoteVideoStream` (`uid`,` false)` to subscribe to specified remote users.

### Scenario Three: Subscribe to different remote users in a channel

The user may need to subscribe to one or more remote users when joining a channel or switching to a channel, and then subsequently subscribe to different remote users. Agora recommends the following steps:

1. Refer to [Scenario Two](#scenario2) to subscribe to specified remote users when joining a channel or switching to a channel.
2. When the user needs to subscribe to different remote users, first call `muteAllRemoteAudioStreams` (`true`) and `muteAllRemoteVideoStreams` (`true`) to unsubscribe from all remote users. 
3. Call `muteRemoteAudioStream` (`uid`,` false`) or `muteRemoteVideoStream(uid`,` false)` to subscribe to other remote users.

### Scenario Four: Set the subscribing state when interrupted by a system or third-party application event

In real-time engagement, the user may be interrupted by a system or third-party application event, such as receiving a system phone call. You typically need to set the subscribing state in two circumstances: 

1. When the user starts using a system or third-party application and this application occupies the audio or video modules of the device, Agora recommends unsubscribing from all users. 
2. When the user stops using a system or third-party application, Agora recommends resuming the original subscribing state. 

The logic of subscribing settings varies according to the original subscribing state.

- If the user subscribes to **all** remote users in real-time engagement, Agora recommends setting the subscribing state as follows:

  a. When the user starts using a system or third-party application, call `muteAllRemoteAudioStreams(true)` or `muteAllRemoteVideoStreams(true)` to unsubscribe from all remote users.
  b. When the user stops using a system or third-party application, call `muteAllRemoteAudioStreams(false)` or `muteAllRemoteVideoStreams(false)` to resume subscribing to all remote users.

- If the user subscribes to **some** remote users in real-time engagement, Agora recommends setting the subscribing state as follows:

  a. Record the original subscribing state. For example, the user only subscribes to remote users A and B.
  b. When the user starts using a system or third-party application, call `muteAllRemoteAudioStreams(true)` or `muteAllRemoteVideoStreams(true)` to unsubscribe from all remote users. 
  c. When the user stops using system or third-party applications, resume the original subscribing state according to the records in step one. For example, call the following methods to resume subscribing to remote users A and B:

     - Call `muteRemoteAudioStream(A, false)` and `muteRemoteVideoStream(A, false)` to resume subscribing to remote user A.
     - Call `muteRemoteAudioStream(B, false)` and `muteRemoteVideoStream(B, false)` to resume subscribing to remote user B. 

## <a name="api_changes"></a>API changes

As of v3.3.0, Agora adds `joinChannel[2/2]` and `switchChannel[2/2]`, and modifies the logic for using `muteRemote` related methods. If you need to upgrade to v3.3.0 or later, Agora recommends that you adjust your subscribing settings as follows to avoid any impact on your business functions:

Earlier than v3.3.0:

- You cannot set the subscribing state when you join a channel or switch channels. By default, you subscribe to the audio or video streams in the current channel.

- `muteRemote`-related methods can be called **both before and after** joining a channel or switching to a channel.

- The methods with the prefix `muteAll` (hereinafter referred to as `muteAll`) serve as a master switch, and the methods with the prefix `muteRemote` or `setDefaultMute` (hereinafter referred to as`muteRemote` and `setDefaultMute`) serve as sub-switches.

 ![](https://web-cdn.agora.io/docs-files/1611154569739)

  - Call `muteAll(true)` to disconnect the master switch, and the user unsubscribes from all audio and video streams. `muteRemote` or `setDefaultMute` does not take effect.

  - Call `muteAll(false)` to connect the master switch. `muteRemote` or `setDefaultMute` controls the user subscribing state.

    - Set `true` to disconnect the sub-switches, and the user unsubscribes from streams.
    - Set `false` to connect the sub-switches, and the user subscribes to streams.

- `muteAll` only sets whether to subscribe to the audio or video streams in the current channel.

- `muteAll(false)`does not resume subscribing to all audio or video streams, but only the original subscribing state. 

As of v3.3.0:

- Deprecate `setDefaultMuteAllRemoteAudioStreams` and `setDefaultMuteAllRemoteVideoStreams`.
- When joining a channel or switching to a channel, call `joinChannel`[2/2] or `switchChannel`[2/2] to set the subscribing state.
- `muteRemote`-related methods must be called **after** joining a channel or switching to a channel; otherwise these methods do not take effect.
- `muteAll` methods do not serve as a master switch. Each `mute`-related method can independently control the user's subscribing state. When `muteAll` and `muteRemote` methods are called together, the method that is called later takes effect. 
- `muteAll` sets whether to subscribe to all audio or video streams, including all subsequent users. In other words, `muteAll` contains the function of `setDefaultMute`. Agora does not recommend calling `muteAll` and `setDefaultMute` together; otherwise the settings may not take effect.
- `muteAll(false)` resumes subscribing to all audio or video streams. 

## Corresponding methods in different programming languages

| Java/C++                    | Objective-C                 |
| :-------------------------- | :-------------------------- |
| `joinChannel`[2/2]          | `joinChannelByToken`[2/2]   |
| `switchChannel`[2/2]        | `switchChannelByToken`[2/2] |
| `muteAllRemoteAudioStreams` | `muteAllRemoteAudioStreams` |
| `muteAllRemoteVideoStreams` | `muteAllRemoteVideoStreams` |
| `muteRemoteAudioStream`     | `muteRemoteAudioStream`     |
| `muteRemoteVideoStream`     | `muteRemoteVideoStream`     |