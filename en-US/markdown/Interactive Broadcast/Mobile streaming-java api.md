
<div class="alert note">To quickly find and navigate to an API method, you can scroll the navigation bar on the right side of the page or search keywords in the page.</div>

<div class="alert note">If you need to refer to RtcEngine APIs doc, see <a href="https://docs-preview.agoralab.co/en/trinity/API%20Reference/java_high_level/v3.5.201/index.html">Java API Reference</a>.</div>

## RtcEngine class

This class is defined in `io.agora.rtc2`.

### createMediaPlayer

```java
public abstract IMediaPlayer createMediaPlayer();
```

Creates an `IMediaPlayer` instance.

**Returns**

The `IMediaPlayer` instance

### destroy
```java
int destroy();
```

Destroy an `IMediaPlayer` instance.

**Returns**

- 0: Success.
- < 0: Failure.


### setDirectCdnStreamingAudioConfiguration

```java
public abstract int setDirectCdnStreamingAudioConfiguration(int profile);
```

Sets the audio profile of the media stream directly pushed to the CDN by the host.

You can call this method to set the profile of the audio captured by the microphone or from a custom source.

**Parameters**

- `profile`: The audio profile. See `AudioProfile` for details.

**Returns**

- 0: Success.
- < 0: Failure.


### setDirectCdnStreamingVideoConfiguration

```java
public abstract int setDirectCdnStreamingVideoConfiguration(VideoEncoderConfiguration config);
```

Sets the video profile of the media stream directly pushed to the CDN by the host.

You can call this method to set the profile of the video captured by the camera or from a custom source.

**Parameters**

- `config`: The video profile. See the `VideoEncoderConfiguration` for details.

**Returns**

- 0: Success.
- < 0: Failure.

### startDirectCdnStreaming

```java
public abstract int startDirectCdnStreaming(IDirectCdnStreamingEventHandler eventHandler,
    String publishUrl, DirectCdnStreamingMediaOptions options);
```

Starts pushing media streams to the CDN directly.

**Note**

Aogra does not support pushing streams to one URL repeatedly.

**Parameters**

- `eventHandler`: See `IDirectCdnStreamingEventHandler` for details.
- `publishUrl`: The CDN streaming URL.
- `options`: Media setting options for the host. See `DirectCdnStreamingMediaOptions` for details.

**Media options**

Agora does not support setting the value of `publishCameraTrack` and `publishCustomVideoTrack` as `true`, or the value of `publishMicrophoneTrack` and `publishCustomAudioTrack` as `true` at the same time. You can refer to the following examples when choosing media setting options:

- If you want to push audio and video streams captured by the host to the CDN, the media setting options should be set as follows:
  - `publishCameraTrack` is set as `true`
  - `publishMicrophoneTrack` is set as `true`
  - `publishCustomAudioTrack` is set as `false` (Default)
  - `publishCustomVideoTrack` is set as `false` (Default)
- If you want to push external audio and video streams, ensure that:
  - `publishCustomAudioTrack` is set as `true` and call the `pushExternalAudioFrame` method
  - `publishCustomVideoTrack` is set as `true` and call the `pushDirectCdnStreamingCustomVideoFrame` method
  - `publishCameraTrack` is set as `false` (Default)
  - `publishMicrophoneTrack` is set as `false` (Default)

**Returns**

- 0: Success.
- < 0: Failure.

### stopDirectCdnStreaming

```java
public abstract int stopDirectCdnStreaming();
```

Stops pushing media streams to the CDN directly.

**Returns**

- 0:Success.
- < 0: Failure.

### pushExternalAudioFrame

```java
public abstract int pushExternalAudioFrame(byte[] data, long timestamp);
```

Pushes the external audio frame to the Agora SDK.

**Note**

Ensure you set `publishCustomAudioTrack` as `true` when calling this method.

**Parameters**

- `data`: External audio data to be pushed.
- `timestamp`: Timestamp (ms) of the external audio frame. Note that the value of this parameter must be filled in and is used for audio sink. You can also use this parameter for the following purposes:
  - Restore the order of the captured audio frame.
  - Synchronize audio and video frames.

**Returns**

- 0: Success.
- < 0: Failure.

### pushDirectCdnStreamingCustomVideoFrame

```java
public abstract int pushDirectCdnStreamingCustomVideoFrame(VideoFrame frame);
```

Pushes the external video frame to the Agora SDK.

**Parameters**

- `frame`: External video data to be pushed. See [WebRTC VideoFrame](https://developer.mozilla.org/en-US/docs/Web/API/VideoFrame) for details.

**Returns**

- 0: Success.
- < 0: Failure.

## IMediaPlayer interface

### open
```java
int open(String url, long startPos);
```
Opens the media resource.

If you want to choose the CDN route for playing the media resource, you can call the `openWithAgoraCDNSrc` method and Agora will change the CDN route for playing the media files to improve the viewing experience.

**Parameters**

- `url`: The path of the media resource.
- `startPos`: The starting position (ms) for playback. Default value is 0.

**Returns**

- 0: Success.
- < 0: Failure.

### openWithAgoraCDNSrc
```java
int openWithAgoraCDNSrc(String src, long startPos);
```

Opens the media resource.

After you call this method, Agora tries to obtain all the CDN routes for playing the media resource. By default, Agora uses the first CDN route for playing, and you can call the `switchAgoraCDNLineByIndex` method to change routes.

**API comparison**

If you want to open the media resource, call the `open` method. If you want to open the media resource and choose the CDN route for playing to improve viewing experience, call the `openWithAgoraCDNSrc` method. 

**Authentication**

If you need to ensure the security of the media files to be played, contact support@agora.io to determine the `sign` and the `ts` field. To obtain the  of the media resource, you need to use these two fields as the query parameters. The following is an example:
- The URL of the media file to be opened: `rtmp://$domain/$appName/$streamName`
- The authenticated URL of the media file to be opened: `rtmp://$domain/$appName/$streamName?ts=$ts&sign=$sign`

Authentication information：
- `sign`: An encrypted string calculated according to md5 algorithm based on`authKey`,`appName`,`streamName` and `ts`. You need to contact support@agora.io for your `authKey`.
- `ts`: The timestamp when the token for authentication expires. You can set the validity period of your token according to your scenarios, for example, 24 hours or 1h30m20s.

**Parameters**

- `src`: The URL of the media resource.
- `startPos`: The starting position (ms) for playback. Default value is 0. This value can be empty if the media resource to be played is live streams.

**Returns**

- 0: Success.
- < 0: Failure.

### getAgoraCDNLineCount
```java
int getAgoraCDNLineCount();
```

Gets the number of the CDN routes for the media resource.

**Returns**

- &gt; 0: The number of the CDN routes for the media resource.
- &le; 0: Failure.

### getCurrentAgoraCDNIndex
```java
int getCurrentAgoraCDNIndex();
```

Gets the CDN routes index of the current media resource. 

**Returns**

- &ge; 0: The index of the CDN routes. The value ranges from [0, `getAgoraCDNLineCount()`).
- &lt; 0: Failure.

### switchAgoraCDNLineByIndex
```java
int switchAgoraCDNLineByIndex(int index);
```

Changes the CDN route for playing the media resource.

After calling `openWithAgoraCDNSrc` to open the media resource, you can call this method if you want to change the CDN route for playing the media resource.

**Note**

- Ensure you have called the `openWithAgoraCDNSrc` to open the media resource before calling this method.
- If you call this method before `play`, the CDN route will not be changed until the playing is completed.

**Parameters**

- `index`: The index of the CDN routes.

**Returns**

- 0: Success.
- < 0: Failure.

### enableAutoSwitchAgoraCDN
```java
int enableAutoSwitchAgoraCDN(boolean enable);
```
Enables/disables the automatic switch of the CDN routes for playing the media resource.

You can call this method if you want the CDN routes to be switched automatically according to your network conditions.

**Note**

Ensure you have called the `openWithAgoraCDNSrc` to open the media resource before calling this method.

**Parameters**

- `enable`: Enables/disables the automatic switch of the CDN routes for playing the media resource:
  - `true`: Enables the automatic switch of the CDN routes.
  - `false`: (Default) Disables the automatic switch of the CDN routes.

**Returns**

- 0: Success.
- < 0: Failure.

### switchAgoraCDNSrc
```java
int switchAgoraCDNSrc(String src, boolean syncPts);
```

Switches the CDN routes for playing the media resource.

**API comparison**

If you want to switch the CDN route for playing the media resource, call the `switchSrc` method. `If you want to choose the CDN route for playing the media resource to improve the viewing experience, you can call the `switchAgoraCDNSrc` method, and Agora will change the CDN route for playing accordingly.

**Note**

- Ensure you have called the `openWithAgoraCDNSrc` to open the media resource before calling this method.
- If you call this method before `play`, the CDN route will not be changed until the playing is completed.

**Authentication**

If you need to ensure the security of the media files to be played, contact support@agora.io to determine the `sign` and the `ts` field. To obtain the  of the media resource, you need to use these two fields as the query parameters. The following is an example:
- The URL of the media file to be opened: `rtmp://$domain/$appName/$streamName`
- The authenticated URL of the media file to be opened: `rtmp://$domain/$appName/$streamName?ts=$ts&sign=$sign`

Authentication information：
- `sign`: An encrypted string calculated according to md5 algorithm based on`authKey`,`appName`,`streamName` and `ts`. You need to contact support@agora.io for your `authKey`.
- `ts`: The timestamp when the token for authentication expires. You can set the validity period of your token according to your scenarios, for example, 24 hours or 1h30m20s.

**Parameters**

- `src`: The URL of the media resource.
- `syncPts`: Whether to synchronize the playback position(millionseconds) before and after the switch:
  - `true`: Synchronize the playback position before and after the switch.
  - `false`: (Default) Do not synchronize the playback position before and after the media resource switch.

Make sure to set `syncPts` as `false` if you need to play live streams, or the switch fails. If you need to play on-demand streams, you can set the value of `syncPts` according to your scenarios.

**Returns**

- 0: Success.
- < 0: Failure.

### renewAgoraCDNSrcToken

```java
int renewAgoraCDNSrcToken(String token, long ts);
```
Renew the authentication information for the URL of the media resource to be played.

When the authentication information expires, you can call the `openWithAgoraCDNSrc` to re-open the midia resource or the `switchAgoraCDNSrc` method to switch the media resource, and pass in the authenticated URL (with authentication information updated) of the media resource.

If your authentication information expires when you call the `switchAgoraCDNLineByIndex` to switch the CDN route for playing the media resource, you need to call the `renewAgoraCDNSrcToken` method to pass in the updated authenetication information and call the `switchAgoraCDNLineByIndex` to switch the route.

**Note**

Set the value of `ts` properly according to your scenarios, or you can also contact support@agora.io for advice. 

**Parameters**

- `token`: The authentication field. See the `sign` field in `Authentication information`.
- `ts`: Timestamp when the authentication information expires. See the `ts` field in `Authentication information`.

**Returns**

- 0: Success.
- < 0: Failure.

### play
```java
int play();
```

Plays the media resource.

**Note**

After `open` or `pause` or `seek`, you can call this method to play the media resource.

**Returns**

- 0: Success.
- < 0: Failure.

### pause
```java
int pause();
```

Pauses the playback.

**Returns**

- 0: Success.
- < 0: Failure.

### stop
```java
int stop();
```

Stops the playback.

**Returns**

- 0: Success.
- < 0: Failure.

### resume
```java
int resume();
```

Resumes the playback.

**Returns**

- 0: Success.
- < 0: Failure.

### seek

```java
int seek(long newPos);
```

Seeks to a new playback position.

To play the media file from a specific position, do the following:

- Call the `seek` method to seek to the position you want to begin playback.
- Call the `play` method to play the media file.

**Parameters**

- `newPos`: The new playback position (ms).

**Returns**

- 0: Success.
- < 0: Failure.

### getDuration
```java
long getDuration();
```

Gets the duration of the media resource.

**Returns**

- &gt; 0: The call succeeds and returns the total duration (ms) of the media resource.
- &le; 0: Failure.

### getPlayPosition

```java
long getPlayPosition();
```

Gets the current playback progress.

**Returns**

- &ge; 0: The call succeeds and returns the current playback progress (ms).
- < 0: Failure.

### getStreamCount
```java
int getStreamCount();
```

Gets the number of the media streams in the media resource.

**Returns**

- &gt; 0: The call succeeds and returns the number of the media streams in the media resource.
- &le; 0: Failure.

### getStreamInfo
```java
MediaStreamInfo getStreamInfo(int index);
```

Gets the detailed information of the media stream.

**Parameters**

- `index`: The index of the media stream.

**Returns**

- If the call succeeds, returns the detailed information of the media stream. See `MediaStreamInfo` for details.
- If the call fails, returns `null`.

### setPlaybackSpeed

```java
int setPlaybackSpeed(int speed);
```

Sets the playback speed.

**Note**

Before you call this method, ensure the media file is opened.

**Parameters**

- `speed`: The playback speed. The value ranges between 50 to 400. The default value is 100, meaning the orginal playback speed. 50 means the playback speed is set as 0.50 times the original speed and 400 means 4.00 times the original speed.

**Returns**

- 0: Success.
- < 0: Failure.

### selectAudioTrack

```java
int selectAudioTrack(int index);
```

Selects the audio track used during playback.

**Note**

After opening the media file, you can call this method to select the audio track used during playback.

**Parameters**

- `index`: The index of the audio track.

**Returns**

- 0: Success.
- < 0: Failure.

### takeScreenshot

```java
int takeScreenshot(String filename);
```

Takes screenshots when the video file is being played.

**Parameters**

- `filename`: The file name of the screenshot.

**Returns**

- 0: Success.
- < 0: Failure.

### selectInternalSubtitle (beta)

```java
int selectInternalSubtitle(int index);
```

Selects the subtitles added in the video.

**Note**

This method can be called after you open the video file. 

**Parameters**

- `index`: The index of the added subtitles.

**Returns**

- 0: Success.
- < 0: Failure.

### setExternalSubtitle (beta)

```java
int setExternalSubtitle(String url);
```

Sets the external subtitles.

**Note**

- After opening the media file, you can call this method to display the external subtitles.
- Before calling this method, ensure the SDK is set for software decoding. To enable software decoding, call the `setPlayerOption` method and set the `key` parameter as `"video_decoder_type"` and `value` as `1`.

**Parameters**

- `index`: The URL of external subtitles.

**Returns**

- 0: Success.
- < 0: Failure.

### getState

```java
Constants.MediaPlayerState getState();
```

Gets current playback state.

**Returns**

- If the call succeeds, returns current playback state. See `MediaPlayerState` for details.
- If the call fails, returns `null`.

### mute

```java
int mute(boolean mute);
```

Sets whether to mute the media resource.

**Parameters**

- `mute`: Sets whether to mute the media resource:
  - `true`: Mute the media resource.
  - `false`: Unmute the media resource (Default).

**Returns**

- 0: Success.
- < 0: Failure.

### isMuted

```java
boolean isMuted();
```

Confirms whether the media resource is muted.

**Returns**

- `true`: The media resource is muted.
- `false`:  The media resource is not muted.

### adjustPlayoutVolume

```java
int adjustPlayoutVolume(int volume);
```

Adjusts the volume of the playback.

**Parameters**

- `volume`: The volume of the playback, wihch ranges from 0 to 100. If the `volume` is set as 100, it means the original volume.

**Returns**

- 0: Success.
- < 0: Failure.

### getPlayoutVolume
```java
int getPlayoutVolume();
```

Gets the current volume of the playback.

**Returns**

The current volume of the playback.

### setPlayerOption

```java
int setPlayerOption(String key, int value);
```

Customizes private options for the media player.

Agora recommends the default options of the SDK. If you need to customize options, please contact support@agora.io. 

**Note**

Calling this method before the `open` method.

**Parameters**

- `key`: Key.
- `value`: Value.

**Returns**

- 0: Success.
- < 0: Failure.

### setView

```java
int setView(View videoView);
```

Sets the render view of the player.

**Parameters**

- `videoView`: The render view of the player.

**Returns**

- 0: Success.
- < 0: Failure.

### setRenderMode

```java
int setRenderMode(int mode);
```

Sets render mode of the player.

**Parameters**

- `mode`: The render mode of the player. See `PLAYER_RENDER_MODE_` for details.

**Returns**

- 0: Success.
- < 0: Failure.

### setLoopCount

```java
int setLoopCount(int loopCount);
```

Sets the loop playback.

When the loop playback ends, the SDK returns `PLAYER_STATE_PLAYBACK_ALL_LOOPS_COMPLETED(6)`.

**Parameters**

- `loopCount`: Number of times for loop playback.

**Returns**

- 0: Success.
- < 0: Failure.

### getPlaySrc

```java
String getPlaySrc();
```

Gets the file path of the media resource being played.

**Returns**

The file path of the media resource being played.

### switchSrc

```java
int switchSrc(String src, boolean syncPts);
```

Switches the media resource being played.

You can call this method to switch the media resource to be played according to the current network status. For example, when the network is poor, the media resource to be played is switched to a media resource address with a lower bitrate. when the network is good, the media resource to be played is switched to a media resource address with a higher bitrate.

After calling `switchSrc`, if you receive the `onPlayerEvent` callback event `PLAYER_EVENT_SWITCH_COMPLETE(11)`, the switch is successful. If you receive the `onPlayerEvent` callback event `PLAYER_EVENT_SWITCH_ERROR(12)`, the switch fails.

**API comparison**

If you want to switch the CDN route for playing the media resource, call the `switchSrc` method. `If you want to choose the CDN route for playing the media resource to improve the viewing experience, you can call the `switchAgoraCDNSrc` method, and Agora will change the CDN route for playing accordingly.

**Note**

- Make sure to call this method after `open`.
- To ensure normal playback, pay attention to the following wheen calling `switchSrc(src, true)`：
  - Do not call this method when playback is paused.
  - Do not call the `seek` method during switching.
  - Before switching the media resource, ensure that the playback position does not exceed the total duration of the media resource to be switched.

**Parameters**

- `src`: The URL of the media resource to be switched.
- `syncPts`: Whether to synchronize the playback position(millionseconds) before and after the switch:
  - `true`: (Default) Synchronize the playback position before and after the switch.
  - `false`: Do not synchronize the playback position before and after the switch. 

Make sure to set `syncPts` as `false` if you need to play live streams, or the switch fails. If you need to play on-demand streams, you can set the value of `syncPts` according to your scenarios.

**Returns**

- 0: Success.
- < 0: Failure.

### preloadSrc
```java
int preloadSrc(String src, long startPos);
```

Preloads media resources.

You can call this method to preload a media resource into the playlist. If you need to preload multiple media resources, you can call this method multiple times.

After calling `preloadSrc`, if you receive the `onPreloadEvent` callback event `PLAYER_PRELOAD_EVENT_COMPLETE(1)`, the preload is successful. If you receive the `onPreloadEvent` callback event `PLAYER_PRELOAD_EVENT_ERROR(2)`, the preload fails.

After the preload is successful, if you want to play the media resource, call `playPreloadedSrc`. if you want to clear the playlist, call the `stop` method.

**Note**

Agora does not support preloading duplicate media resources to the playlist. However, you can preload the media resources that are being played to the playlist again.

**Parameters**

- `src`: The URL of the preloaded media resource. 
- `startPos`: The starting position (milliseconds) for playing after the media resource is preloaded to the playlist. When preloading a live stream, set `startPos` to 0.

**Returns**

- 0: Success.
- < 0: Failure.

### unloadSrc
```java
int unloadSrc(String src);
```

Unloads media resources that are preloaded.

**Note**

The media resource being played cannot be unloaded.

**Parameters**

- `src`: The URL of the media resource to be unloaded. 

**Returns**

- 0: Success.
- < 0: Failure.

### playPreloadedSrc

```java
int playPreloadedSrc(String src);
```

Plays preloaded media resources.

This method only supports playing media resources that have been preloaded into the playlist. After calling this method, if you receive the `onPlayerStateChanged` callback to report the state `PLAYER_STATE_PLAYING`, the playback is successful.

If you want to change the preloaded media resource to be played, you can call this method again and specify a new media resource path. If you want to replay the media resource, you need to call `preloadSrc` to preload the media resource to the playlist again before playing. If you want to clear the playlist, call the `stop` method.

**Note**

If you call this method when playback is paused, this method does not take effect until playback is resumed.

**Parameters**

- `src`: The URL of the media resource in the playlist. This address must be consistent with the `src` set by the `preloadSrc` method, or the media resource cannot be played.

**Returns**

- 0: Success.
- < 0: Failure.

### registerPlayerObserver

```java
int registerPlayerObserver(IMediaPlayerObserver playerObserver);
```

Registers a player observer.

**Parameters**

- `playerObserver`: The player observer, listening for events during the playback. See `IMediaPlayerObserver` for details.

**Returns**

- 0: Success.
- < 0: Failure.

### unRegisterPlayerObserver

```java
int unRegisterPlayerObserver(IMediaPlayerObserver playerObserver);
```

Unregisters a player observer.

**Parameters**

- `playerObserver`: The player observer, listening for events during the playback. See `IMediaPlayerObserver` for details.

**Returns**

- 0: Success.
- < 0: Failure.


### registerAudioFrameObserver

```java
int registerAudioFrameObserver(IMediaPlayerAudioFrameObserver audioFrameObserver, int mode);
```

Registers an audio observer.

**Parameters**

- `audioFrameObserver`: The audio observer, reporting the reception of each audio frame. See `IMediaPlayerAudioFrameObserver` for details.
- `mode`: The mode for handling audio data. Agora supports the following modes：
  - `0(RAW_AUDIO_FRAME_OP_MODE_READ_ONLY)`: Read-only mode. You can only read the Agora Audio Frame data. For example, For example, select this mode when you acquire audio data with the Agora SDK.
  - `1(RAW_AUDIO_FRAME_OP_MODE_WRITE_ONLY)`: Write-only mode. You can replace the Agora Audio Frame data with your own data and pass it to the SDK for encoding.For example, select this mode when you acquire data by yourself.
  - `2(RAW_AUDIO_FRAME_OP_MODE_READ_WRITE)`: Read and write mode. You can read the data from the Agora Audio Frame, modify it, and play the audio data. For example, select this mode when you need to do voice pre-processing.


**Returns**

- 0: Success.
- < 0: Failure.

### registerVideoFrameObserver

```java
int registerVideoFrameObserver(IMediaPlayerVideoFrameObserver videoFrameObserver);
```

Registers a video observer.

**Parameters**

- `videoFrameObserver`: The video observer, reporting the reception of each video frame. See `IMediaPlayerVideoFrameObserver` for details.

**Returns**

- 0: Success.
- < 0: Failure.

## IMediaPlayerObserver interface

This interface is defined in `io.agora.mediaplayer`.

### onPlayerStateChanged

```java
@CalledByNative
void onPlayerStateChanged(Constants.MediaPlayerState state, Constants.MediaPlayerError error);
```

Reports the change in playback state.

**Parameters**

- `state`: The new playback state after change. See `MediaPlayerState` for details.
- `error`: The error code of the player. See `MediaPlayerError` for details.

### onPositionChanged
```java
@CalledByNative void onPositionChanged(long position);
```

Reports current playback progress.

The callback occurs once every one second during the playback and reports current playback progress.

**Parameters**

- `position`: Current playback progress (ms).

### onPlayerEvent

```java
@CalledByNative
void onPlayerEvent(Constants.MediaPlayerEvent eventCode, long elapsedTime, String message);
```

Reports playback events.

This callback reports playback events, such as seeking to a new position，selecting the audio track，or changing the bitrate of media resources.

**Parameters**

- `eventCode`: The playback event. See `MediaPlayerEvent` for details.
- `elapsedTime`: The time when the event occurs (ms).
- `message`: Information about the event.

### onMetaData

```java
@CalledByNative void onMetaData(Constants.MediaPlayerMetadataType type, byte[] data);
```

Reports the reception of the media metadata.

**Parameters**

- `type`: The type of the media metadata. 
- `data`: The detailed data about the media metadata.

### onPlayBufferUpdated

```java
@CalledByNative void onPlayBufferUpdated(long playCachedBuffer);
```

Reports the playback duration that the buffered data can support.

In the process of playing online media resources, the mediaplayer kit triggers this callback every one second to report the playback duration that the currently buffered data can support.

- When the playback duration supported by the buffered data is less than the threshold (0 by default), the mediaplayer kit returns `PLAYER_EVENT_BUFFER_LOW(6)`.
- When the playback duration supported by the buffered data is greater than the threshold (0 by default), the mediaplayer kit returns `PLAYER_EVENT_BUFFER_RECOVER(7)`.

**Parameters**

- `playCachedBuffer`: The playback duration (ms) that the buffered data can support.

### onPreloadEvent

```java
@CalledByNative void onPreloadEvent(String src, Constants.MediaPlayerPreloadEvent event);
```

Reports the events of preloading media resources.

**Parameters**
- `src`: The URL of the preloaded media resource.
- `event`: Events that occur when media resources are preloaded. See `MediaPlayerPreloadEvent` for details.

### onAgoraCDNTokenWillExpire

```java
@CalledByNative void onAgoraCDNTokenWillExpire();
```

Occurs when the token is to expire in 30 seconds.

This callback is triggered 30 seconds before the token expires to remind you to get a new token.

You can call the `openWithAgoraCDNSrc` to re-open the midia resource or the `switchAgoraCDNSrc` method to switch the media resource, and pass in the authenticated URL (with authentication information updated) of the media resource.

If your authentication information expires when you call the `switchAgoraCDNLineByIndex` to switch the CDN route for playing the media resource, you need to call the `renewAgoraCDNSrcToken` method to pass in the updated authenetication information and call the `switchAgoraCDNLineByIndex` to switch the route.

### onPlayerSrcInfoChanged

```java
@CalledByNative void onPlayerSrcInfoChanged(SrcInfo from, SrcInfo to);
```

Occurs when there is a change in the video bitrate of the media resource.

**Parameters**

- `from`: Information about the video bitrate of the media resource being played. See the `SrcInfo` for details. 
- `to`: Information about the changed video birate of media resource being played. See the `SrcInfo` for details.

### onPlayerInfoUpdated

```java
@CalledByNative void onPlayerInfoUpdated(PlayerUpdatedInfo info);
```

Occurs when information related to the media player changes. You can use this callback for troubleshooting.

**Parameters**

- `info`: information related to the media player. See `PlayerUpdatedInfo` for details.

## IMediaPlayerAudioFrameObserver interface

This interface is defined in `io.agora.mediaplayer`.

### onFrame

```java
@CalledByNative
AudioFrame onFrame(AudioFrame audioFrame);
```

Occurs when each time the player receives an audio frame.

After registering the audio frame observer, the callback occurs every time the player receives an audio frame, reporting the detailed information of the audio frame.

**Parameters**

- `audioFrame`: Audio frame information. See `AudioFrame`.

**Returns**

Passes in the audio data after setting the `mode` for handling audio data.

## IMediaPlayerVideoFrameObserver interface

This interface is defined in `io.agora.mediaplayer`.

### onFrame

```java
@CalledByNative void onFrame(VideoFrame frame)
```

Occurs when each time the player receives a video frame.

After registering the video frame observer, the callback occurs every time the player receives a video frame, reporting the detailed information of the video frame.

**Parameters**

- `videoFrame`: Video frame information. See [WebRTC VideoFrame](https://developer.mozilla.org/en-US/docs/Web/API/VideoFrame) for details.

## IDirectCdnStreamingEventHandler interface

This interface is defined in `io.agora.rtc2`.

### onDirectCdnStreamingStateChanged

```java
@CalledByNative
void onDirectCdnStreamingStateChanged(
    DirectCdnStreamingState state, DirectCdnStreamingError err, String msg);
```

Occurs when the CDN streaming state changes.

When the host pushes streams to the CDN, if the streaming state changes, the SDK triggers this callback to report the changed streaming state, error codes, and other streaming-related information. You can troubleshoot issues by referring to this callback.

**Parameters**

- `state`: The current streaming state. See `DirectCdnStreamingState` for details.
- `err`: Error codes. See `DirectCdnStreamingError` for details.
- `msg`: Information about the changed streaming state.

### onDirectCdnStreamingStats

```java
@CalledByNative void onDirectCdnStreamingStats(DirectCdnStreamingStats stats);
```

Reports the CDN streaming statistics.

This callback is triggered in every second during the CDN streaming.

**Parameters**

- `stats`: The statistics of the CDN streaming. See `DirectCdnStreamingStats` for details.

## io.agora.mediaplayer.Constants

### PLAYER_RENDER_MODE_
#### PLAYER_RENDER_MODE_HIDDEN
```java
PLAYER_RENDER_MODE_HIDDEN = 1
```
Uniformly scales the video until it fills the visible boundaries (cropped). One dimension of the video may have clipped contents.
#### PLAYER_RENDER_MODE_FIT
```java
PLAYER_RENDER_MODE_FIT = 2
```
Uniformly scales the video until one of its dimension fits the boundary (zoomed to fit). Areas that are not filled due to the disparity in the aspect ratio are filled with black.

### MediaPlayerState
#### PLAYER_STATE_UNKNOWN
```java
PLAYER_STATE_UNKNOWN(-1)
```
The player state is unkown.
#### PLAYER_STATE_IDLE
```java
PLAYER_STATE_IDLE(0)
```
 Default state. The player returns this state code before you open the media resource or after you stop the playback.
#### PLAYER_STATE_OPENING
```java
PLAYER_STATE_OPENING(1)
```
Opening the media resource.
#### PLAYER_STATE_OPEN_COMPLETED
```java
PLAYER_STATE_OPEN_COMPLETED(2)
```
Opened the media resource successfully.
#### PLAYER_STATE_PLAYING
```java
PLAYER_STATE_PLAYING(3)
```
Playing the media resource.
#### PLAYER_STATE_PAUSED
```java
PLAYER_STATE_PAUSED(4)
```
Pauses the playback.
#### PLAYER_STATE_PLAYBACK_COMPLETED
```java
PLAYER_STATE_PLAYBACK_COMPLETED(5)
```
The playback is completed.
#### PLAYER_STATE_PLAYBACK_ALL_LOOPS_COMPLETED
```java
PLAYER_STATE_PLAYBACK_ALL_LOOPS_COMPLETED(6)
```
The loop playback is completed.
#### PLAYER_STATE_STOPPED
```java
PLAYER_STATE_STOPPED(7)
```
The playback finishes.

#### PLAYER_STATE_FAILED
```java
PLAYER_STATE_FAILED(100)
```
Fails to play the media resource.
### MediaPlayerError

#### PLAYER_ERROR_NONE
```java
PLAYER_ERROR_NONE(0)
```
No error.
#### PLAYER_ERROR_INVALID_ARGUMENTS
```java
PLAYER_ERROR_INVALID_ARGUMENTS(-1)
```
Invalid arguments.
#### PLAYER_ERROR_INTERNAL
```java
PLAYER_ERROR_INTERNAL(-2)
```
Internal error.
#### PLAYER_ERROR_NO_RESOURCE
```java
PLAYER_ERROR_NO_RESOURCE(-3)
```
No resource.
#### PLAYER_ERROR_INVALID_MEDIA_SOURCE
```java
PLAYER_ERROR_INVALID_MEDIA_SOURCE(-4)
```
Invalid media resource.
#### PLAYER_ERROR_UNKNOWN_STREAM_TYPE
```java
PLAYER_ERROR_UNKNOWN_STREAM_TYPE(-5)
```
The type of the media stream is unknown.
#### PLAYER_ERROR_OBJ_NOT_INITIALIZED
```java
PLAYER_ERROR_OBJ_NOT_INITIALIZED(-6)
```
The object is not initialized.
#### PLAYER_ERROR_CODEC_NOT_SUPPORTED
```java
PLAYER_ERROR_CODEC_NOT_SUPPORTED(-7)
```
The codec is not supported.
#### PLAYER_ERROR_VIDEO_RENDER_FAILED
```java
PLAYER_ERROR_VIDEO_RENDER_FAILED(-8)
```
Invalid renderer.
#### PLAYER_ERROR_INVALID_STATE
```java
PLAYER_ERROR_INVALID_STATE(-9)
```
Errors occur in the internal state of the player.
#### PLAYER_ERROR_URL_NOT_FOUND
```java
PLAYER_ERROR_URL_NOT_FOUND(-10)
```
The URL of the media resource can not be found.
#### PLAYER_ERROR_INVALID_CONNECTION_STATE
```java
PLAYER_ERROR_INVALID_CONNECTION_STATE(-11)
```
Invalid connection between the player and the Agora Server.
#### PLAY_ERROR_SRC_BUFFER_UNDERFLOW
```java
PLAY_ERROR_SRC_BUFFER_UNDERFLOW(-12)
```
The playback buffer is insufficient.

#### PLAYER_ERROR_INTERRUPTED
```java
PLAYER_ERROR_INTERRUPTED(-13)
```
The playback is interrupted.

#### PLAYER_ERROR_NOT_SUPPORTED
```java
PLAYER_ERROR_NOT_SUPPORTED(-14)
```
The SDK does supports the method being called.

#### PLAYER_ERROR_TOKEN_EXPIRED
```java
PLAYER_ERROR_TOKEN_EXPIRED(-15)
```
The authentication information of the media resource is expired. To update the authentication information, see `renewAgoraCDNSrcToken` for details. 

#### PLAYER_ERROR_UNKNOWN
```java
PLAYER_ERROR_UNKNOWN(-100)
```
An unknown error.
### MediaPlayerEvent

#### PLAYER_EVENT_UNKNOWN
```java
PLAYER_EVENT_UNKNOWN(-1)
```
An unknown event.
#### PLAYER_EVENT_SEEK_BEGIN
```java
PLAYER_EVENT_SEEK_BEGIN(0)
```
Begins to seek to a new playback position.
#### PLAYER_EVENT_SEEK_COMPLETE
```java
PLAYER_EVENT_SEEK_COMPLETE(1)
```
Finishes seeking to a new playback position.
#### PLAYER_EVENT_SEEK_ERROR
```java
PLAYER_EVENT_SEEK_ERROR(2)
```
An error occurs when seeking to a new playback position.
#### PLAYER_EVENT_AUDIO_TRACK_CHANGED
```java
PLAYER_EVENT_AUDIO_TRACK_CHANGED(5)
```
The audio track used by the player has been changed.
#### PLAYER_EVENT_BUFFER_LOW
```java
PLAYER_EVENT_BUFFER_LOW(6)
```
The currently buffered data is not enough to support playback.
#### PLAYER_EVENT_BUFFER_RECOVER
```java
PLAYER_EVENT_BUFFER_RECOVER(7)
```
The currently buffered data is just enough to support playback.
#### PLAYER_EVENT_FREEZE_START
```java
PLAYER_EVENT_FREEZE_START(8)
```
The Audio or video playback freezes.
#### PLAYER_EVENT_FREEZE_STOP
```java
PLAYER_EVENT_FREEZE_STOP(9)
```
The audio or video playback resumes without freezing.
#### PLAYER_EVENT_SWITCH_BEGIN
```java
PLAYER_EVENT_SWITCH_BEGIN(10)
```
Starts switching the media resource.
#### PLAYER_EVENT_SWITCH_COMPLETE
```java
PLAYER_EVENT_SWITCH_COMPLETE(11)
```
Media resource switching is complete.
#### PLAYER_EVENT_SWITCH_ERROR
```java
PLAYER_EVENT_SWITCH_ERROR(12)
```
Media resource switching error.
#### PLAYER_EVENT_FIRST_DISPLAYED
```java
PLAYER_EVENT_FIRST_DISPLAYED(13)
```
The first video frame is rendered.
### MediaPlayerPreloadEvent

#### PLAYER_PRELOAD_EVENT_BEGIN
```java
PLAYER_PRELOAD_EVENT_BEGIN(0)
```
Starts preloading media resources.
#### PLAYER_PRELOAD_EVENT_COMPLETE
```java
PLAYER_PRELOAD_EVENT_COMPLETE(1)
```
Preloading media resources is complete.
#### PLAYER_PRELOAD_EVENT_ERROR
```java
PLAYER_PRELOAD_EVENT_ERROR(2)
```
An error occurs when preloading media resources.

### MediaStreamType

#### STREAM_TYPE_UNKNOWN
```java
STREAM_TYPE_UNKNOWN(0)
```
The type is unknown.
#### STREAM_TYPE_VIDEO
```java
STREAM_TYPE_VIDEO(1)
```
The video stream.
#### STREAM_TYPE_AUDIO
```java
STREAM_TYPE_AUDIO(2)
```
The audio stream.
#### STREAM_TYPE_SUBTITLE
```java
STREAM_TYPE_SUBTITLE(3)
```
The subtitle stream. 
### MediaPlayerMetadataType

#### PLAYER_METADATA_TYPE_UNKNOWN
```java
PLAYER_METADATA_TYPE_UNKNOWN(0)
```
The type is unknown.

#### PLAYER_METADATA_TYPE_SEI
```java
PLAYER_METADATA_TYPE_SEI(1)
```
The type is SEI.

## io.agora.rtc2.Constants

### AudioProfile 枚举

#### DEFAULT
```java
DEFAULT(Constants.AUDIO_PROFILE_DEFAULT)
```
0: Default audio profile,representing a sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.

#### SPEECH_STANDARD

```java
SPEECH_STANDARD(Constants.AUDIO_PROFILE_SPEECH_STANDARD)
```
1: A sample rate of 32 kHz, audio encoding, mono, and a bitrate of up to 18 Kbps.

#### MUSIC_STANDARD

```java
MUSIC_STANDARD(Constants.AUDIO_PROFILE_MUSIC_STANDARD)
```
2: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.

#### MUSIC_STANDARD_STEREO

```java
MUSIC_STANDARD_STEREO(Constants.AUDIO_PROFILE_MUSIC_STANDARD_STEREO)
```
3: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 80 Kbps.

#### MUSIC_HIGH_QUALITY

```java
MUSIC_HIGH_QUALITY(Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY)
```
4: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 96 Kbps.

#### MUSIC_HIGH_QUALITY_STEREO

```java
MUSIC_HIGH_QUALITY_STEREO(Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO)
```

5: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 128 Kbps.

## DirectCdnStreamingState

`DirectCdnStreamingState` is defined in `io.agora.rtc2`.

### IDLE
```java
IDLE(0)
```
The initial state before the CDN streaming starts.
### RUNNING
```java
RUNNING(1)
```
Streams are being pushed to the CDN. The SDK returns this value when you call the `startDirectCdnStreaming` method to push streams to the CDN.
### STOPPED
```java
STOPPED(2)
```
Stops pushing streams to the CDN. The SDK returns this value when you call the `stopDirectCdnStreaming` method to stop pushing streams to the CDN.
### FAILED
```java
FAILED(3)
```
Fails to push streams to the CDN. See `onDirectCdnStreamingStateChanged` for detailed error information. You can also call the `startDirectCdnStreaming` method to push streams to the CDN again. 

### RECOVERING
```java
RECOVERING(4)
```
Tries to reconnect Agora server and the CDN. The SDK makes such attempt for 10 times at most, and if the connection is still not restored, the streaming state becomes `FAILED`.
## DirectCdnStreamingError

`DirectCdnStreamingError` is defined in `io.agora.rtc2`.

### OK
```java
OK(0)
```
No error.
### FAILED
```java
FAILED(1)
```
Unknown errors. You can try to restart the CDN streaming.
### AUDIO_PUBLICATION
```java
AUDIO_PUBLICATION(2)
```
An error occurs when pushing audio streams to the CDN. For example, the local audio recording device is not available or granted with a permission for recording, or does not work at all.
### VIDEO_PUBLICATION
```java
VIDEO_PUBLICATION(3)
```
An error occurs when pushing video streams to the CDN, For example, the local video-capture device is not available or granted with a permission for capturing, or does not work at all.
### NET_CONNECT
```java
NET_CONNECT(4)
```
Fails to connect to the CDN.
### BAD_NAME
```java
BAD_NAME(5)
```
The URL is already being used for streaming. If you want to start new streaming, use a new streaming URL.

## PlayerUpdatedInfo

`PlayerUpdatedInfo` is defined in `io.agora.mediaplayer.data`.

### player_id

```java
public String player_id;
```
The ID of a media player.

### device_id

```java
 public String device_id;
 ```
The ID of a deivce.

## SrcInfo

`SrcInfo` is defined in `io.agora.mediaplayer.data`.

### bitrateInKbps

```java
private int bitrateInKbps;
```
The video bitrate (Kbps) of the media resource being played.

### name

```java
private String name;
```
The name of the media resource.

## DirectCdnStreamingStats

`DirectCdnStreamingStats` is defined in `io.agora.rtc2`.

### videoWidth
``` java
public int videoWidth;
```
The width of the video (px).

### videoHeight
``` java
public int videoHeight;
```
The height of the video (px).

### fps
``` java
public int fps;
```
The current video frame rate (fps).

### videoBitrate
``` java 
public int videoBitrate;
```
The current video bitrate (bps).

### audioBitrate
``` java
public int audioBitrate;
```
The current audio bitrate (bps).

## MediaStreamInfo

`MediaStreamInfo` is defined in `io.agora.mediaplayer.data`.

### streamIndex
```java
private int streamIndex
```
The index of the media stream.

### mediaStreamType

```java
private int mediaStreamType
```
The type of the media stream. See `MediaStreamType` for details.

### codecName

```java
private String codecName
```
The codec of the media stream.

### language

```java
private String language
```
The language of the media stream.

### videoFrameRate

```java
private int videoFrameRate
```
For a video stream, gets the frame rate (fps).

### videoBitRate

```java
private int videoBitRate
```
For a video stream, gets the bitrate (bps).

### videoWidth

```java
private int videoWidth
```
For a video stream, gets the width (px) of the video.

### videoHeight

```java
private int videoHeight
```
For a video stream, gets the height (px) of the video.

### audioSampleRate

```java
private int audioSampleRate
```
For an audio stream, gets the sample rate (Hz).

### audioChannels

```java
private int audioChannels
```
For an audio stream, gets the channel number.

### duration

```java
private long duration
```
The total duration (second) of the media stream.

### videoRotation

```java
private int videoRotation
```

For a video stream, gets the rotation angle of the video.

## DirectCdnStreamingMediaOptions

`DirectCdnStreamingMediaOptions` is defined in `io.agora.rtc2`.

### publishCameraTrack
```java
public Boolean publishCameraTrack
```
Whether to publish the video captured by the camera:

- `true`: Publish the video captured by the camera.
- `false`: (Default) Do not publish the video captured by the camera.

### publishMicrophoneTrack
```java
public Boolean publishMicrophoneTrack
```
设置是否发布麦克风采集的音频。Whether to publish the audio captured by the microphone:

- `true`: Publish the audio captured by the microphone.
- `false`: (Default) Do not publish the audio captured by the microphone.

### publishCustomAudioTrack
```java
public Boolean publishCustomAudioTrack
```
Whether to publish the captured audio from a custom source:

- `true`: Publish the captured audio from a custom source.
- `false`: (Default) Do not publish the captured audio from the custom source. 

### publishCustomVideoTrack
```java
public Boolean publishCustomVideoTrack
```
Whether to publish the captured video from a custom source: 

- `true`: Publish the captured video from a custom source.
- `false`: (Default) Do not publish the captured video from the custom source.

## AudioFrame

`AudioFrame` is defined in `io.agora.mediaplayer.data`.

### timestamp
```java
public long timestamp
```
The timestamp (ms) of current audio frame.
### samplesPerChannel
```java
public int samplesPerChannel
```
The number of samples per channel.
### sampleRateHz
```java
public int sampleRataHz
```
The sample rate (Hz) of the audio data.
### channelNums
```java
public int channelNums
```
The channel number of an audio stream.
### bytesPerSample
```java
public int bytesPerSample
```
The number of bytes per sample.
### bytes
```java
public byte[] bytes
```
The number of bytes of the audio data.

## VideoEncoderConfiguration

`VideoEncoderConfiguration` is defined in `io.agora.rtc2.video`.

### dimensions
```java
public VideoDimensions dimensions
```
The video frame dimensions (px), which is used to specify the video quality and measured by the total number of pixels along the width and height of a frame. The default value is 640 × 360. Users can either set the resolution manually or choose from the options provided by Agora.

**Note**

- The value of the dimension does not indicate the orientation mode of the output video. For more information about how to set the video orientation, see `orientationMode`.
- Whether 720p+ can be supported depends on the device. If the device cannot support 720p, the frame rate will be lower than 720p.

### VideoDimensions

#### width

```java
public int width
```
The video resolution on the horizontal axis.

#### height

```java
public int height
```
The video resolution on the vertical axis.

### Static attributes about video dimensions

#### VD_120x120
```java
public final static VideoDimensions VD_120x120 = new VideoDimensions(120, 120)
```
The video resolution is 120 × 120.

#### VD_160x120

```java
public final static VideoDimensions VD_160x120 = new VideoDimensions(160, 120)
```
The video resolution is 160 × 120.

#### VD_180x180

```java
public final static VideoDimensions VD_180x180 = new VideoDimensions(180, 180)
```
The video resolution is 180 × 180.

#### VD_240x180

```java
public final static VideoDimensions VD_240x180 = new VideoDimensions(240, 180)
```
The video resolution is 240 × 180.

#### VD_320x180

```java
public final static VideoDimensions VD_320x180 = new VideoDimensions(320, 180)
```
The video resolution is 320 × 180.

#### VD_240x240

```java
public final static VideoDimensions VD_240x240 = new VideoDimensions(240, 240)
```
The video resolution is 240 × 240.

#### VD_320x240

```java
public final static VideoDimensions VD_320x240 = new VideoDimensions(320, 240)
```
The video resolution is 320 × 240.

#### VD_424x240

```java
public final static VideoDimensions VD_424x240 = new VideoDimensions(424, 240)
```
The video resolution is 424 × 240.

#### VD_360x360

```java
public final static VideoDimensions VD_360x360 = new VideoDimensions(360, 360)
```
The video resolution is 360 × 360.

#### VD_480x360

```java
public final static VideoDimensions VD_480x360 = new VideoDimensions(480, 360)
```
The video resolution is 480 × 360.

#### VD_640x360

```java
public final static VideoDimensions VD_640x360 = new VideoDimensions(640, 360)
```
The video resolution is 640 × 360.

#### VD_480x480

```java
public final static VideoDimensions VD_480x480 = new VideoDimensions(480, 480)
```
The video resolution is 480 × 480.

#### VD_640x480

```java
public final static VideoDimensions VD_640x480 = new VideoDimensions(640, 480)
```
The video resolution is 640 × 480.

#### VD_840x480

```java
public final static VideoDimensions VD_840x480 = new VideoDimensions(840, 480)
```
The video resolution is 840 × 480.

#### VD_960x720

```java
public final static VideoDimensions VD_960x720 = new VideoDimensions(960, 720)
```
The video resolution is 960 × 720.

#### VD_1280x720

```java
public final static VideoDimensions VD_1280x720 = new VideoDimensions(1280, 720)
```
The video resolution is 1280 × 720.

#### VD_1920x1080

```java
public final static VideoDimensions VD_1920x1080 = new VideoDimensions(1920, 1080)
```
The video resolution is 1920 × 1080.

### frameRate
```java
public int frameRate
```
The video frame rate (fps). The default value is 15. Users can either set the frame rate manually or choose from the following options. Agora does not recommend setting this to a value greater than 30.

### FRAME_RATE 枚举

#### FRAME_RATE_FPS_1
```java
FRAME_RATE_FPS_1(1)
```
1 fps

#### FRAME_RATE_FPS_7

```java
FRAME_RATE_FPS_7(7)
```
7 fps

#### FRAME_RATE_FPS_10

```java
FRAME_RATE_FPS_10(10)
```
10 fps

#### FRAME_RATE_FPS_15

```java
FRAME_RATE_FPS_15(15)
```
15 fps

#### FRAME_RATE_FPS_24

```java
FRAME_RATE_FPS_24(24)
```
24 fps

#### FRAME_RATE_FPS_30

```java
FRAME_RATE_FPS_30(30)
```
30 fps

#### FRAME_RATE_FPS_60

```java
FRAME_RATE_FPS_60(60)
```

60 fps

### bitrate

```java
public int bitrate
```

Bitrate of the video (Kbps).

You can set your video bitrate through the following options:

- Setting to the `STANDARD_BITRATE (0)` mode (Recommended). 
- Setting your video bitrate manually according to your scenarios. The following table is for your reference. Note that if the video bitrate you set is beyond the limit, the SDK will adjust your video bitrate to an appropriate value. 

**Video Bitrate Table**

| Resolution   | Frame rate (fps) | Bitrate (Kbps) |
| :------- | :--------- | :---------- |
| 160 * 120  | 15         | 130         |
| 120 * 120  | 15         | 100         |
| 320 * 180  | 15         | 280         |
| 180 * 180  | 15         | 200         |
| 240 * 180  | 15         | 240         |
| 320 * 240  | 15         | 400         |
| 240 * 240  | 15         | 280         |
| 424 * 240  | 15         | 440         |
| 640 * 360  | 15         | 800         |
| 360 * 360  | 15         | 520         |
| 640 * 360  | 30         | 1200        |
| 360 * 360  | 30         | 800         |
| 480 * 360  | 15         | 640         |
| 480 * 360  | 30         | 980         |
| 640 * 480  | 15         | 1000        |
| 480 * 480  | 15         | 800         |
| 640 * 480  | 30         | 1500        |
| 480 * 480  | 30         | 1200        |
| 848 * 480  | 15         | 1220        |
| 848 * 480  | 30         | 1860        |
| 640 * 480  | 10         | 800         |
| 1280 * 720 | 15         | 2260        |
| 1280 * 720 | 30         | 3420        |
| 960 * 720  | 15         | 1820        |
| 960 * 720  | 30         | 2760        |

### Static attributes about video bitrates

#### STANDARD_BITRATE
```java
public static final int STANDARD_BITRATE = 0
```

The standard bitrate mode.

#### COMPATIBLE_BITRATE

```java
public static final int COMPATIBLE_BITRATE = -1
```

The compatible bitrate mode. 

### orientationMode

```java
public ORIENTATION_MODE orientationMode
```

The orientation mode. See `ORIENTATION_MODE` for details. For more information about video rotation,see [Orientation mode](https://docs.agora.io/en/Interactive%20Broadcast/video_profile_android?platform=Android#a-nameorientationaorientation-mode).

### ORIENTATION_MODE

#### ORIENTATION_MODE_ADAPTIVE
```java
ORIENTATION_MODE_ADAPTIVE(0)
```
(Default) The output video always follows the orientation of the captured video, because the receiver takes the rotational information passed on from the video encoder. This mode is mainly used between Agora’s SDKs.
- If the captured video is in landscape mode, so is the output video.
- If the captured video is in portrait mode, so is the output video.

#### ORIENTATION_MODE_FIXED_LANDSCAPE
```java
ORIENTATION_MODE_FIXED_LANDSCAPE(1)
```
The output video is always in landscape mode. If the captured video is in portrait mode, the video encoder crops it to fit the output. This mode applies to situations where the receiving end cannot process the rotational information.
#### ORIENTATION_MODE_FIXED_PORTRAIT
```java
ORIENTATION_MODE_FIXED_PORTRAIT(2)
```
The output video is always in portrait mode. If the captured video is in landscape mode, the video encoder crops it to fit the output. Applies to situations where the receiving end cannot process the rotational information. 

### mirrorMode
```java
public MIRROR_MODE_TYPE mirrorMode
```
Sets the mirror mode of the published local video stream. See `MIRROR_MODE_TYPE` for details.
### MIRROR_MODE_TYPE
#### MIRROR_MODE_AUTO
```java
MIRROR_MODE_AUTO(0)
```
(Default) The mirror mode determined by the SDK.
#### MIRROR_MODE_ENABLED
```java
MIRROR_MODE_ENABLED(1)
```
Enable the mirror mode.
#### MIRROR_MODE_DISABLED
```java
MIRROR_MODE_DISABLED(2)
```
Disable the mirror mode.
### degradationPrefer
```java
public DEGRADATION_PREFERENCE degradationPrefer
```
The video encoding degradation preference under limited bandwidth. See `DEGRADATION_PREFERENCE` for details.

### DEGRADATION_PREFERENCE

#### MAINTAIN_QUALITY
```java
MAINTAIN_QUALITY(0)
```
Reduces the video frame rate while maintaining video quality during video encoding under limited bandwidth. This degradation preference is suitable for scenarios where video quality is prioritized.
#### MAINTAIN_FRAMERATE
```java
MAINTAIN_FRAMERATE(1)
```
Reduces the video quality while maintaining the video frame rate during encoding under limited bandwidth. This degradation preference is suitable for scenarios where video smoothness is prioritized and video quality is allowed to be reduced.
#### MAINTAIN_BALANCED
```java
MAINTAIN_BALANCED(2)
```
Reduces the video frame rate and video quality simultaneously during encoding under limited bandwidth. `MAINTAIN_BALANCED` has a lower reduction than `MAINTAIN_QUALITY` and `MAINTAIN_FRAMERATE`, and this preference is suitable for scenarios where both video smoothness and quality are a priority.
#### MAINTAIN_RESOLUTION
```java
MAINTAIN_RESOLUTION(3)
```
Reduces the video frame rate while maintaining the video resolution during encoding under limited bandwidth.
