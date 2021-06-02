---
title: MediaPlayer Kit
platform: iOS
updatedAt: 2021-03-18 04:05:32
---
## Function description

The MediaPlayer Kit is a powerful player that supports playing local and online media resources. With this player, you can either locally play media resources or synchronously share currently playing media resources with remote users in the Agora channel. 

## Usage notice

- Currently supported media formats: Local files in AVI, MP4, MKV, and FLV formats; Online media streams using RTMP and RTSP protocols.
- When locally playing media resources, you only need the separate MediaPlayer Kit. When synchronously sharing media resources with remote users, you need to use the MediaPlayer Kit, Agora Native SDK, and RtcChannelPublishPlugin at the same time. The MediaPlayer Kit supports the local user to use the player function, the Native SDK supports real-time live broadcast scenarios, and the RtcChannelPublishPlugin supports publishing media streams to remote users in Agora channel.
- When sharing media resources with remote users, the playeback window occupies the local user's video as captured by the camera. Therefore, if you want remote users to see both the local user's and the player's window, you need to start another process to capture the local user's video.

## Set up the development environment

### Prerequisites

- Xcode 9.0 or later
- An iOS device running iOS 8.0 or later

> Open the specified ports in [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms) if your network has a firewall.
>
> A valid Agora account ([Sign up](https://dashboard.agora.io/) for free) is necessary when sharing media resources to remote users.

### Create an iOS project

Now, let's build an iOS project from scratch. 

<details>
	<summary><font color="#3ab7f8">Create an iOS project</font></summary>

1. Open **Xcode** and click **Create a new Xcode project**.
2. Choose **Single View App** as the template and click **Next**.
3. Input the project information, such as the project name, team, organization name, and language, and click **Next**.
	
  **Note**: If you haven't added any team information, you will see an **Add account...** button. Click it, input your Apple ID, and click **Next** to add your team.
4. Choose the storage path of the project and click **Create**.
5. Connect your iOS device to your computer.
6. Go to the **TARGETS > Project Name > General > Signing** menu, choose **Automatically manage signing**, and then click **Enable Automatic** on the pop-up window.
</details>

### Integrate the MediaPlayer Kit

1. Go to [Downloads](https://docs.agora.io/en/Agora%20Platform/downloads), download the latest version of the MediaPlayer Kit, and unzip the download package.

2. Add the AgoraMediaPlayer.framework file in the **libs** folder to the project folder.
3. In **Xcode**, click **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** to change the status of AgoraMediaPlayer.framework to **Embed & Sign**. 
4.  Go to the **TARGETS > Project Name > Build Phases > Link Binary with Libraries** menu, and click `+` to add the following frameworks and libraries. To add the AgoraMediaPlayer.framework file, remember to click **Add Other...** after clicking `+`.
	- AgoraMediaPlayer.framework
	- Accelerate.framework
	- AudioToolbox.framework
	- AVFoundation.framework
	- CoreMedia.framework
	- CoreML.framework
	- CoreTelephony.framework
	- libc++.tbd
	- libresolv.tbd
	- SystemConfiguration.framework
	- VideoToolbox.framework

	![](https://web-cdn.agora.io/docs-files/1583119068826)
   <div class="alert note">If your device runs <b>iOS 11</b> or earlier, set the dependency of <b>CoreML.framework</b> as <b>Optional</b> in <b>Xcode</b>.</div>

5. Add the following permissions in the **info.plist** file for device access according to your needs:

| Key | Type | Value |
| ---------------- | ---------------- | ---------------- |
| Privacy - Microphone Usage Description      | String      | To access the microphone, such as for a video call.      |
| Privacy - Camera Usage Description      | String      | To access the camera, such as for a video call.      |

### Integrate the Native SDK 

Version requirements: 2.4.0 or later 

Integration steps: See [Integrate the Native SDK](https://docs.agora.io/en/Interactive%20Broadcast/start_live_ios?platform=iOS#a-nameintegratesdkaintegrate-the-sdk).

### Integrate the RtcChannelPublishHelper


1. [Download](https://github.com/AgoraIO/Agora-Extensions/tree/master/MediaPlayer/helper/apple) the RtcChannelPublishPlugin folder.
2. Add the RtcChannelPublishPlugin folder to the project folder.


## Implementation

<a name="local"></a>
### Play media resources locally

After integrating the MediaPlayer Kit, follow these steps to implement the local playback function.

**Create a player instance**

Create an instance of ` AgoraMediaPlayer`.

> To play different media resources simultaneously, you should create multiple instances.

**Receive event callbacks**
Override the `AgoraMediaPlayerDelegate` delegate method to receive the following event callbacks:
- `didChangedToPosition`, which reports the current playback progress.
- `didChangedToState`, which reports the playback state change.
- `didOccurEvent`, which reports the result of a seek operation to a new playback position.
- `didReceiveData`, which occurs each time the player receives the media metadata.
- `didReceiveAudioFrame`, which occurs each time the player receives an audio frame.
- `didReceiveVideoFrame`, which occurs each time the player receives a video frame.

By listening for these events, you can have more control over the playback process and enable your app to support data in custom formats (media metadata). If an exception occurs, you can use these event callbacks for troubleshooting.

**Preparations for playback**

1. Call the `setView` method in the ` AgoraMediaPlayer` interface to set the render view of the player.

2. Call the `setRenderMode` method in the ` AgoraMediaPlayer` interface to set the rendering mode of the player's view.

3. Call the `open` method in the ` AgoraMediaPlayer` interface to open the media resource. The media resource path can be a network path or a local path. Both absolute and relative paths are supported.

   > Do not proceed until you receive the `didChangedToState` callback reporting `AgoraMediaPlayerStateOpenCompleted(2)`.

4. Call the `play` method in the ` AgoraMediaPlayer` interface to play the media resource locally.

**Adjust playback settings** 

You can call several other methods in the ` AgoraMediaPlayer` interface to implement various playback settings:

- Pause/resume playback, adjust playback progress, adjust local playback volume, and so on.
- Get the total duration of the media resource, get the current playback progress, get the current playback state, get the number of media streams in the media resource and detailed information about each media stream.

**Stop playback**

1. Call the `stop` method in the ` AgoraMediaPlayer` interface to stop playback.
2. Set `view` in the `setView` method to NULL to release the view.
3. Use the iOS ARC memory management mechanism to release the `AgoraMediaPlayer` instance.

**Sample code**

```objective-c
_mediaPlayerKit = [[AgoraMediaPlayer alloc] initWithDelegate:self];
[_mediaPlayerKit setView:self.containerView];
[_mediaPlayerKit open:url startPos:0];
[_mediaPlayerKit play];
[_mediaPlayerKit stop];
[_mediaPlayerKit seekToPosition:value];
[_mediaPlayerKitadjustVolume:volume];
  
 // Receives event callbacks.
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
       didChangedToState:(AgoraMediaPlayerState)state
                   error:(AgoraMediaPlayerError)error;
{
     //todo
}
 
 
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
    didChangedToPosition:(NSInteger)position;
{
}
 
 
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
          didOccurEvent:(AgoraMediaPlayerEvent)event;
{
     //todo
}
 
 
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
          didReceiveData:(NSString *)data
                  length:(NSInteger)length;
{
     //todo
}
 
 
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
    didReceiveVideoFrame:(CVPixelBufferRef
{
    //todo
}
 
 
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
    didReceiveAudioFrame:(CMSampleBufferRef)
{
    //todo
};
```

### Share media resources to remote

After integrating the MediaPlayer Kit, the Agora Native SDK, and the RtcChannelPublishPlugin, follow these steps to synchronously share media resources played by the local user to all the remote users in the Agora channel.

**Instantiate required objects**

1. [Instantiate an AgoraRtcEngineKit object](https://docs.agora.io/en/Interactive%20Broadcast/start_live_ios?platform=iOS#3-initialize-agorartcenginekit).
2. Instantiate the ` AgoraMediaPlayer` and `RtcChannelPublishHelper` objects.

**Enable the player to complete playback preparations**

Register the player, audio, and video observer objects, and complete the preparations for playback. See [Play media resources locally](#local) for details.

> Do not proceed until you receive the `didChangedToState` callback reporting `AgoraMediaPlayerStatePlaying(3)`.

**Enable the local user to join the channel by using the SDK** 

Refer to [the RTC quickstart guide](https://docs.agora.io/en/Interactive%20Broadcast/start_live_ios?platform=iOS#4-set-the-channel-profile) for details about how to enable the local user to join the live broadcast channel in the role of `BROADCASTER`:

1. Call the `setChannelProfile` method to set the channel mode to live broadcast.

2. Call the `setClientRole` method to set the local user role as the broadcaster.

3. Call the `enableVideo` method to enable the video module.

4. Call the `joinChannel` method to enable the local user to join the channel.

   > Do not proceed until you receive the `joinSuccessBlock` or `didJoinChannel` callback.

**Start sharing by using the helper**

1. Call the `attachPlayerToRtc` method to bundle the player with the Agora channel. And the playback window fully occupies the local user's view.

2. Call the `publishVideo`/`publishAudio` method to share (publish) the video/audio stream in the media resource to remote users in the Agora channel.

3. Call the `adjustPublishSignalVolume` method to adjust the the playback volume heard by the remote user.

**Cancel sharing by using the helper**

1. Call the `unpublishVideo`/`unpublishAudio` method to unshare or unpublish the video/audio stream in the media resource.

2. Call the `detachPlayerFromRtc` method to unbind the player from the Agora channel. 

3. Call the `release` method to release `RtcChannelPublishHelper`.

> The shared video/audio stream will not be interrupted after the local user leaves the channel (`leaveChannel`). Only by calling the `unpublishVideo`/`unpublishAudio` method, can you unshare the video/audio stream.

**Sample code**

```objective-c
_rtcEnginekit = [AgoraRtcEngineKit sharedEngineWithAppId:@"YOUR_APPID" delegate:self];
[_rtcEnginekit setChannelProfile:AgoraChannelProfileLiveBroadcasting];
[_rtcEnginekit setClientRole:AgoraClientRoleBroadcaster];
[_rtcEnginekit enableVideo];
[_rtcEnginekit joinChannelByToken:token channelId:channelid info:""  uid:"" joinSuccess:NULL];
[[AgoraRtcChannelPublishHelper shareInstance] attachPlayerToRtc:_mediaPlayerKit RtcEngine:_rtcEnginekit];
[[AgoraRtcChannelPublishHelper shareInstance] publishAudio];
[[AgoraRtcChannelPublishHelper shareInstance] publishVideo];
[[AgoraRtcChannelPublishHelper shareInstance] detachPlayerFromRtc];
```

## Get the log file
The log file contains all the log events generated by the mediaplayer kit during runtime. The path of the log file is `App Sandbox/Library/caches/agoraplayer.log`.

## API documentation
See the [API documentation](https://docs-preview.agoralab.co/en/Video/API%20Reference/mediaplayer_oc/1.1.0/docs/headers/MediaPlayer-Kit-Objective-C-API-Overview.html?transId=1.1.0).
