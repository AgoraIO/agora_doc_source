---
title: MediaPlayer Kit
platform: Android
updatedAt: 2020-11-16 04:30:35
---
## Function description

The MediaPlayer Kit is a powerful player that supports playing local and online media resources. With this player, you can either locally play media resources or synchronously share currently playing media resources with remote users in the Agora channel. 

## Usage notice

- Currently supported media formats: Local files in AVI, MP4, MP3, MKV, and FLV formats; Online media streams using RTMP and RTSP protocols.
- When locally playing media resources, you only need the separate MediaPlayer Kit. When synchronously sharing media resources with remote users, you need to use the MediaPlayer Kit, Agora Native SDK, and RtcChannelPublishHelper at the same time. The MediaPlayer Kit supports the local user to use the player function, the Native SDK supports real-time live broadcast scenarios, and the RtcChannelPublishHelper supports publishing media streams to remote users in Agora channel.
- When sharing media resources with remote users, the playback window occupies the local user's video as captured by the camera. Therefore, if you want remote users to see both the local user's and the player's window, you need to start another process to capture the local user's video.

## Set up the development environment

### Prerequisites

- Android Studio 3.0 or later
- Android SDK API Level 16 or higher
- A mobile device running Android 4.1 or later

> Open the specified ports in [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms) if your network has a firewall.
>
> A valid Agora account ([Sign up](https://dashboard.agora.io/) for free) is necessary when sharing media resources to remote users.

### Create an Android project

Follow these steps to create an Android project:

<details>
	<summary><font color="#3ab7f8">Create an Android project</font></summary>
	
1. Open <b>Android Studio</b> and click <b>Start a new Android Studio project</b>. 
2. On the <b>Choose your project</b> panel, choose <b>Phone and Tablet</b> > <b>Empty Activity</b>, and click <b>Next</b>. 
3. On the <b>Configure your project</b> panel, fill in the following contents:

	* <b>Name</b>: The name of your project, for example, MediaPlayer
	* <b>Package name</b>: The name of the project package, for example, io.agora.mediaplayer
	* <b>Project location</b>: The path to save the project
	* <b>Language</b>: The programming language of the project, for example, Java
	* <b>Minimum API level</b>: The minimum API level of the project

Click <b>Finish</b>. Follow the on-screen instructions, if any, to install the plug-ins. 
</details>

### Integrate the MediaPlayer Kit

1. Go to [Downloads](https://docs.agora.io/en/Agora%20Platform/downloads), download the latest version of the MediaPlayer Kit, and unzip the download package.

2. Add the following files or subfolders from the **libs** folder of the download package to the paths of your project.

   | File or subfolder         | Path of your project   |
   | :------------------------ | :--------------------- |
   | AgoraMediaPlayer.jar file | /app/libs/             |
   | arm-v8a folder            | /app/src/main/jniLibs/ |
   | armeabi-v7a folder        | /app/src/main/jniLibs/ |
   | x86 folder                | /app/src/main/jniLibs/ |
   | x86_64 folder             | /app/src/main/jniLibs/ |

3. In the **/app/src/main/AndroidManifest.xml** file, add the following permissions for device access according to your needs:

   ```java
   <uses-permission android:name="android.permission.INTERNET" /> 
     <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
   ```

   If your `targetSdkVersion` >= 29, add the following line in the `<application>` module in the **AndroidManifest.xml** file:

   ```java
   <application
        android:requestLegacyExternalStorage="true">
        ...
   </application>
   ```

### Integrate the Native SDK 

Version requirements: 2.4.0 or later 

Integration steps: See [Integrate the Native SDK](https://docs.agora.io/en/Interactive%20Broadcast/start_live_android?platform=Android#integrate-the-sdk)

### Integrate the RtcChannelPublishHelper

Version requirements: The same as the Native SDK version series you are using.

Integration steps:

1. [Download](https://github.com/AgoraIO/Agora-Extensions/releases) and unzip the `MediaPlayerExtensions.zip`.

2. Add the **./MediaPlayerExtensions/android/{version}/RtcChannelPublishHelper.aar** file to the **/app/libs** path of your project.

3. In the **/app/build.gradle** file, add the following lines:

   - Add the following lines in the `android` node, specifying the file storage path of the **aar** file.

     ```java
     repositories {
        flatDir {
            dirs 'libs'
      }
     }
     ```

   - Add the following line in the `dependencies` node, specifying the name of the **aar** file to be imported.

     ```java
     implementation(name:'RtcChannelPublishHelper',ext:'aar')
     ```

## Implementation

### Play media resources locally

After integrating the MediaPlayer Kit, follow these steps to implement the local playback function.

**Create a player instance**

Create an instance of `AgoraMediaPlayerKit`.

> To play different media resources simultaneously, you should create multiple instances.

**Register a player observer object**

1. Implement the `MediaPlayerObserver` interface and instantiate a `MediaPlayerObserver` object.
2. Call the `registerPlayerObserver` method in the `AgoraMediaPlayerKit` interface to register a player observer object (`playerObserver`), and listen for the following playback events:
   - `onPositionChanged`, which reports the current playback progress.
   - `onPlayerStateChanged`, which reports the playback state change.
   - `onPlayerEvent`, which reports the result of a seek operation to a new playback position.
   - `onMetaData`, which occurs each time the player receives the media metadata.

By listening for these events, you can have more control over the playback process and enable your app to support data in custom formats (media metadata). If an exception occurs, you can use these event callbacks for troubleshooting.

**Register an audio observer object**

1. Implement the `AudioFrameObserver` interface and instantiate an `AudioFrameObserver` object.
2. Call the `registerAudioFrameObserver` method in the `AgoraMediaPlayerKit` interface to register an audio observer object (`observer`) and listen for the event that confirms the reception of each audio frame. After handling the `AudioFrame `class, you can record the audio.

**Register a video observer object**

1. Implement the `VideoFrameObserver` interface and instantiate a `VideoFrameObserver` object.
2. Call the `registerVideoFrameObserver` method in the `AgoraMediaPlayerKit` interface to register a video observer object (`observer`) and listen for the event that confirms the reception of each video frame. After handling the `VideoFrame` class, you can record the video or take screenshots of the video.

**Preparations for playback**

1. Call the `setView` method in the `AgoraMediaPlayerKit` interface to set the render view of the player.

2. Call the `setRenderMode` method in the `AgoraMediaPlayerKit` interface to set the rendering mode of the player's view.

3. Call the `open` method in the `AgoraMediaPlayerKit` interface to open the media resource. The media resource path can be a network path or a local path. Both absolute and relative paths are supported.

   > Do not proceed until you receive the `onPlayerStateChanged` callback reporting `PLAYER_STATE_OPEN_COMPLETED(2)`.

4. Call the `play` method in the `AgoraMediaPlayerKit` interface to play the media resource locally.

**Adjust playback settings** 

You can call several other methods in the `AgoraMediaPlayerKit` interface to implement various playback settings:

- Pause/resume playback, adjust playback progress, adjust local playback volume, and so on.
- Get the total duration of the media resource, get the current playback progress, get the current playback state, get the number of media streams in the media resource and detailed information about each media stream.

**Stop playback**

1. Call the `stop` method in the `AgoraMediaPlayerKit` interface to stop playback.
2. (Optional) Call the `unregisterPlayerObserver` method in the `AgoraMediaPlayerKit` interface to unregister the player observer object.
3. Call the `destroy` method in the `AgoraMediaPlayerKit` interface to destroy the `AgoraMediaPlayerKit` instance.

**Sample code**

```java
AgoraMediaPlayerKit agoraMediaPlayerKit1 = new AgoraMediaPlayerKit(this.getActivity());
 
agoraMediaPlayerKit1.registerPlayerObserver(new MediaPlayerObserver() {
    @Override
 public void onPlayerStateChanged(MediaPlayerState state, MediaPlayerError error) {
        LogUtil.i("agoraMediaPlayerKit1 onPlayerStateChanged:"+state+" "+error);
 }
 
    @Override
 public void onPositionChanged(final long position) {
        LogUtil.i("agoraMediaPlayerKit1 onPositionChanged:"+position+" duration:"+player1Duration);
   }
 
    @Override
 public void onPlayerEvent(MediaPlayerEvent eventCode) {
        LogUtil.i("agoraMediaPlayerKit1 onEvent:"+eventCode);
 }
 
    @Override
 public void onMetaData(final byte[] data) {
        LogUtil.i("agoraMediaPlayerKit1 onMetaData "+ new String(data));
 }
});
 
 agoraMediaPlayerKit1.registerVideoFrameObserver(new VideoFrameObserver() {
     @Override
 public void onFrame(VideoFrame videoFrame) {
        LogUtil.i("agoraMediaPlayerKit1 video onFrame :"+videoFrame);
 }
});
 
 agoraMediaPlayerKit1.registerAudioFrameObserver(new AudioFrameObserver() {
     @Override
 public void onFrame(AudioFrame audioFrame) {
        LogUtil.i("agoraMediaPlayerKit1 audio onFrame :"+audioFrame);
 }
 });
 
agoraMediaPlayerKit1.open("/sdcard/test.mp4",0);
agoraMediaPlayerKit1.play();
agoraMediaPlayerKit1.stop();
```

### Share media resources to remote

After integrating the MediaPlayer Kit, the Agora Native SDK, and the RtcChannelPublishHelper, follow these steps to synchronously share media resources played by the local user to all the remote users in the Agora channel.

**Instantiate required objects**

1. [Instantiate an RtcEngine object](https://docs.agora.io/en/Interactive%20Broadcast/start_live_android?platform=Android#4-initialize-rtcengine).
2. Instantiate the `AgoraMediaPlayerKit` and `RtcChannelPublishHelper` objects.

**Enable the player to complete playback preparations**

Register the player, audio, and video observer objects, and complete the preparations for playback. See [Play media resources locally](#local) for details.

> Do not proceed until you receive the `onPlayerStateChanged` callback reporting `PLAYER_STATE_PLAYING (3)`.

**Enable the local user to join the channel by using the SDK** 

Refer to [the RTC quickstart guide](https://docs.agora.io/en/Interactive%20Broadcast/start_live_android?platform=Android#5-set-the-channel-profile) for details about how to enable the local user to join the live broadcast channel in the role of `BROADCASTER`:

1. Call the `setChannelProfile` method to set the channel mode to live broadcast.

2. Call the `setClientRole` method to set the local user role as the broadcaster.

3. Call the `enableVideo` method to enable the video module.

4. Call the `joinChannel` method to enable the local user to join the channel.

   > Do not proceed until you receive the `onJoinChannelSuccess` callback.

**Start sharing by using the helper**

1. Call the `attachPlayerToRtc` method to bundle the player with the Agora channel. And the playback window fully occupies the local user's view.

2. Call the `publishVideo`/`publishAudio` method to share (publish) the video/audio stream in the media resource to remote users in the Agora channel.

3. Call the `adjustPublishSignalVolume` method to adjust the voice volume of the local user (`microphoneVolume`) and the playback volume (`movieVolume`) heard by the remote user.

   > The volume ranges from 0 to 400, where 100 indicates the original volume and 400 represents that the maximum volume can be 4 times the original volume (with built-in overflow protection).

**Cancel sharing by using the helper**

1. Call the `unpublishVideo`/`unpublishAudio` method to unshare/unpublish the video/audio stream in the media resource.
2. Call the `detachPlayerFromRtc` method to unbind the player from the Agora channel. The player's screen no longer occupies the local user's view.
3. (Optional) Call `setVideoSource( new AgoraDefaultSource() )` in the `RtcEngine` interface to switch the player's window back to the local user' view and enable remote users to see the local user again.
4. Call the `release` method to release `RtcChannelPublishHelper`.

<div class="alert note">Do not skip this section and directly call the <code>leaveChannel</code> method to cancel the media stream being shared, otherwise abnormal behaviors occur when the local user rejoins the channel:
	<li>The previously unshared media stream automatically sends to the remote users.</li>
	<li>The audio and video streams are not synchronized during playback.</li></div>

**Sample code**

```java
RtcEngine mRtcEngine = RtcEngine.create（context,appid,null);
RtcEngine agoraMediaPlayerKit = new AgoraMediaPlayerKit(context)；
RtcChannelPublishHelper rtcChannelPublishHelper = RtcChannelPublishHelper.getInstance();
 
rtcChannelPublishHelper.attachPlayerToRtc(agoraMediaPlayerKit,mRtcEngine);
 
 
rtcChannelPublishHelper.publishVideo()
rtcChannelPublishHelper.publishAudio()
rtcChannelPublishHelper.unpublishVideo()
rtcChannelPublishHelper.unpublishAudio()
   
rtcChannelPublishHelper.detachPlayerFromRtc();
rtcChannelPublishHelper.release(); 
```

## Get the log file
The log file contains all the log events generated by the mediaplayer kit during runtime. The path of the log file is `/sdcard/{Package name of the app}/agorasdk.log`.

## API documentation
See the [API documentation](./API%20Reference/mediaplayer_java/index.html).

