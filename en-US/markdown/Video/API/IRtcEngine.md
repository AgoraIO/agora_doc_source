# [IRtcEngine](class_irtcengine.html#class_irtcengine)

The basic interface of the Agora SDK that implements the core functions of real-time communication.

IRtcEngine provides the main methods that your app can call.

Before calling other APIs, you must call [createAgoraRtcEngine](class_irtcengine.html#api_createagorartcengine) to create an IRtcEngine object.

## [addPublishStreamUrl](class_irtcengine.html#api_addpublishstreamurl)

Publishes the local stream to a specified CDN live streaming URL.

```cpp
virtual int addPublishStreamUrl(const char* url, bool transcodingEnabled) = 0;
```

After calling this method, you can push media streams in RTMP or RTMPS protocol to the CDN. The SDK triggers the [onRtmpStreamingStateChanged](class_irtcengineeventhandler.html#callback_onrtmpstreamingstatechanged) callback on the local client to report the state of adding a local stream to the CDN.

**Note**

- Call this method after joining a channel.
- Ensure that the media push function is enabled.
- This method takes effect only when you are a host in live interactive streaming.
- This method adds only one streaming URL to the CDN each time it is called. To push multiple URLs, call this method multiple times.
- Agora only supports pushing media streams to the CDN in RTMPS protocol when you enable transcoding.

### Parameters

- url

  The CDN streaming URL in the RTMP or RTMPS format. The maximum length of this parameter is 1024 bytes. The URL address must not contain special characters, such as Chinese language characters.

- transcodingEnabled

  Whether to enable transcoding. [Transcoding](https://docs.agora.io/en/Agora Platform/transcoding) in a CDN live streaming converts the audio and video streams before pushing them to the CDN server. It applies to scenarios where a channel has multiple broadcasters and composite layout is needed.`true`: Enable transcoding.`false`: Disable transcoding.**Note** If you set this parameter as `true`, ensure that you call the [setLiveTranscoding](class_irtcengine.html#api_setlivetranscoding) method before calling this method.

### Returns

- 0: Success.
- < 0: Failure.
  - `ERR_INVALID_ARGUMENT` (-2): Invalid argument, usually because the URL address is null or the string length is 0.
  - `ERR_NOT_INITIALIZED` (-7): You have not initialized the RTC Engine when publishing the stream.

**See also**

- [onRtmpStreamingStateChanged](../API/class_irtcengineeventhandler.html#callback_onrtmpstreamingstatechanged)

## [addVideoWatermark [1/2\]](class_irtcengine.html#api_addvideowatermark)

Adds a watermark image to the local video.

```cpp
virtual int addVideoWatermark(const RtcImage& watermark) = 0;
```

- Deprecated:

  This method is deprecated. Use [addVideoWatermark [2/2\]](class_irtcengine.html#api_addvideowatermark2) instead.

This method adds a PNG watermark image to the local video stream in a live streaming session. Once the watermark image is added, all the users in the channel (CDN audience included) and the video capturing device can see and capture it. If you only want to add a watermark to the CDN live streaming, see descriptions in [setLiveTranscoding](class_irtcengine.html#api_setlivetranscoding).

**Note**

- The URL descriptions are different for the local video and CDN live streaming: In a local video stream, URL refers to the absolute path of the added watermark image file in the local video stream. In a CDN live stream, URL refers to the URL address of the added watermark image in the CDN live streaming.
- The source file of the watermark image must be in the PNG file format. If the width and height of the PNG file differ from your settings in this method, the PNG file will be cropped to conform to your settings.
- The Agora SDK supports adding only one watermark image onto a local video or CDN live stream. The newly added watermark image replaces the previous one.

### Parameters

- watermark

  The watermark image to be added to the local live streaming: [RtcImage](rtc_api_data_type.html#class_rtcimage).

### Returns

- 0: Success.
- < 0: Failure.

## [addVideoWatermark [2/2\]](class_irtcengine.html#api_addvideowatermark2)

Adds a watermark image to the local video.

```cpp
virtual int addVideoWatermark(const char* watermarkUrl, const WatermarkOptions& options) = 0;
```

This method adds a PNG watermark image to the local video in the live streaming. Once the watermark image is added, all the audience in the channel (CDN audience included), and the capturing device can see and capture it. Agora supports adding only one watermark image onto the local video, and the newly watermark image replaces the previous one.

The watermark coordinates are dependent on the settings in the [setVideoEncoderConfiguration](class_irtcengine.html#api_setvideoencoderconfiguration) method:

- If the orientation mode of the encoding video ([ORIENTATION_MODE](rtc_api_data_type.html#enum_orientationmode)) is FIXED_LANDSCAPE, or the landscape mode in ADAPTIVE, the watermark uses the landscape orientation.
- If the orientation mode of the encoding video (ORIENTATION_MODE) is FIXED_PORTRAIT, or the portrait mode in ADAPTIVE, the watermark uses the portrait orientation.
- When setting the watermark position, the region must be less than the dimensions set in the setVideoEncoderConfiguration method. Otherwise, the watermark image will be cropped.

**Note**

- Ensure that you have called [enableVideo](class_irtcengine.html#api_enablevideo) before calling this method.
- If you only want to add a watermark to the CDN live streaming, you can call this method or the [setLiveTranscoding](class_irtcengine.html#api_setlivetranscoding) method.
- This method supports adding a watermark image in the PNG file format only. Supported pixel formats of the PNG image are RGBA, RGB, Palette, Gray, and Alpha_gray.
- If the dimensions of the PNG image differ from your settings in this method, the image will be cropped or zoomed to conform to your settings.
- If you have enabled the local video preview by calling the [startPreview](class_irtcengine.html#api_startpreview) method, you can use the `visibleInPreview` member to set whether or not the watermark is visible in the preview.
- If you have enabled the mirror mode for the local video, the watermark on the local video is also mirrored. To avoid mirroring the watermark, Agora recommends that you do not use the mirror and watermark functions for the local video at the same time. You can implement the watermark function in your application layer.

### Parameters

- watermarkUrl

  The local file path of the watermark image to be added. This method supports adding a watermark image from the local absolute or relative file path.

- options

  The options of the watermark image to be added. For details, see [WatermarkOptions](rtc_api_data_type.html#class_watermarkoptions).

### Returns

- 0: Success.
- < 0: Failure.

## [adjustAudioMixingPlayoutVolume](class_irtcengine.html#api_adjustaudiomixingplayoutvolume)

Adjusts the volume of audio mixing for local playback.

```cpp
virtual int adjustAudioMixingPlayoutVolume(int volume) = 0;
```

- Since

  v2.3.2

**Note** You need to call this method after calling [startAudioMixing [2/2\]](class_irtcengine.html#api_startaudiomixing2) and receiving the onAudioMixingStateChanged(`PLAY`) callback.

### Parameters

- volume

  Audio mixing volume for local playback. The value range is [0,100]. The default value is 100, the original volume.

### Returns

- 0: Success.
- < 0: Failure.

## [adjustAudioMixingPublishVolume](class_irtcengine.html#api_adjustaudiomixingpublishvolume)

Adjusts the volume of audio mixing for publishing.

```cpp
virtual int adjustAudioMixingPublishVolume(int volume) = 0;
```

- Since

  v2.3.2

This method adjusts the volume of audio mixing for publishing (sending to other users).

**Note** You need to call this method after calling [startAudioMixing [2/2\]](class_irtcengine.html#api_startaudiomixing2) and receiving the onAudioMixingStateChanged(`PLAY`) callback.

### Parameters

- volume

  Audio mixing volume. The value range is [0,100]. The default value is 100, the original volume.

### Returns

- 0: Success.
- < 0: Failure.

## [adjustAudioMixingVolume](class_irtcengine.html#api_adjustaudiomixingvolume)

Adjusts the volume during audio mixing.

```cpp
virtual int adjustAudioMixingVolume(int volume) = 0;
```

This method adjusts the audio mixing volume on both the local client and remote clients.

**Note**

- Call this method after [startAudioMixing [2/2\]](class_irtcengine.html#api_startaudiomixing2).
- Calling this method does not affect the volume of audio effect file playback invoked by the [playEffect](class_irtcengine.html#api_playeffect3) method.

### Parameters

- volume

  Audio mixing volume. The value ranges between 0 and 100. The default value is 100, the original volume.

### Returns

- 0: Success.
- < 0: Failure.

## [adjustLoopbackRecordingVolume](class_irtcengine.html#api_adjustloopbackrecordingvolume)

Adjusts the volume of the signal captured by the sound card.

```cpp
virtual int adjustLoopbackRecordingVolume(int volume) = 0;
```

After calling [enableLoopbackRecording](class_irtcengine.html#api_enableloopbackrecording_ng) to enable loopback audio capturing, you can call this method to adjust the volume of the signal captured by the sound card.

### Parameters

- volume

  Audio mixing volume. The value ranges between 0 and 100. The default value is 100, the original volume.

### Returns

- 0: Success.
- < 0: Failure.

## [adjustPlaybackSignalVolume](class_irtcengine.html#api_adjustplaybacksignalvolume)

Adjusts the playback signal volume of all remote users.

```cpp
virtual int adjustPlaybackSignalVolume(int volume) = 0;
```

**Note**

- This method adjusts the playback volume that is the mixed volume of all remote users.
- You can call this method either before or after joining a channel.

### Parameters

- volume

  Integer only. The value range is [0,400].0: Mute.100: (Default) The original volume.400: Four times the original volume (amplifying the audio signals by four times).

### Returns

- 0: Success.
- < 0: Failure.

## [adjustRecordingSignalVolume](class_irtcengine.html#api_adjustrecordingsignalvolume)

Adjusts the capturing signal volume.

```cpp
virtual int adjustRecordingSignalVolume(int volume) = 0;
```

**Note**

You can call this method either before or after joining a channel.

### Parameters

- volume

  Integer only. The value range is [0,400].0: Mute.100: (Default) The original volume.400: Four times the original volume (amplifying the audio signals by four times).

### Returns

- 0: Success.
- < 0: Failure.

## [adjustUserPlaybackSignalVolume](class_irtcengine.html#api_adjustuserplaybacksignalvolume)

Adjusts the playback signal volume of a specified remote user.

```cpp
virtual int adjustUserPlaybackSignalVolume(unsigned int uid, int volume) = 0;
```

You can call this method to adjust the playback volume of a specified remote user. To adjust the playback volume of different remote users, call the method as many times, once for each remote user.

**Note**

- Call this method after joining a channel.
- The playback volume here refers to the mixed volume of a specified remote user.

### Parameters

- uid

  The ID of the remote user.

- volume

  Audio mixing volume. The value ranges between 0 and 100. The default value is 100, the original volume.

### Returns

- 0: Success.
- < 0: Failure.

## [clearVideoWatermarks](class_irtcengine.html#api_clearvideowatermarks)

Removes the watermark image from the video stream.

```cpp
virtual int clearVideoWatermarks() = 0;
```

### Returns

- 0: Success.
- < 0: Failure.

## [complain](class_irtcengine.html#api_complain)

Allows a user to complain about the call quality after a call ends.

```cpp
virtual int complain(const char* callId, const char* description) = 0;
```

This method allows users to complain about the quality of the call. Call this method after the user leaves the channel.

### Parameters

- callId

  The current call ID. You can get the call ID by calling [getCallId](class_irtcengine.html#api_getcallid).

- description

  (Optional) A description of the call. The string length should be less than 800 bytes.

### Returns

- 0: Success.
- < 0: Failure.
  - -2 (`ERR_INVALID_ARGUMENT`).
  - -3 (`ERR_NOT_READY`)。

## [configRhythmPlayer](class_irtcengine.html#api_configrhythmplayer)

Configures the virtual metronome.

```cpp
virtual int configRhythmPlayer(const AgoraRhythmPlayerConfig& config) = 0;
```

After calling [startRhythmPlayer](class_irtcengine.html#api_startrhythmplayer), you can call this method to reconfigure the virtual metronome.

**Note**

- This method is for Android and iOS only.
- After enabling the virtual metronome, the SDK plays the specified audio effect file from the beginning, and controls the playback duration of each file according to **beatsPerMinute** you set in [AgoraRhythmPlayerConfig](rtc_api_data_type.html#class_agorarhythmplayerconfig). For example, if you set **beatsPerMinute** as `60`, the SDK plays one beat every second. If the file duration exceeds the beat duration, the SDK only plays the audio within the beat duration.

### Parameters

- config

  The metronome configuration. See [AgoraRhythmPlayerConfig](rtc_api_data_type.html#class_agorarhythmplayerconfig).

### Returns

- 0: Success.
- < 0: Failure.

## [initialize](class_irtcengine.html#api_create2)

Initializes IRtcEngine.

```cpp
virtual int initialize(const RtcEngineContext& context) = 0;
```

All called methods provided by the IRtcEngine class are executed asynchronously. Agora recommends calling these methods in the same thread.

**Note**

- Before calling other APIs, you must call [createAgoraRtcEngine](class_irtcengine.html#api_createagorartcengine) and initialize to create and initialize the IRtcEngine object.
- The SDK supports creating only one IRtcEngine instance for an app.

### Parameters

- context

  Configurations for the [IRtcEngine](class_irtcengine.html#class_irtcengine) instance. See [RtcEngineContext](rtc_api_data_type.html#class_rtcengineconfig_ng) for details.

### Returns

- 0(ERR_OK): Success.
- < 0: Failure.
  - -1(ERR_FAILED): A general error occurs (no specified reason).
  - -2(ERR_INVALID_ARGUMENT): An invalid parameter is used.
  - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.
  - -22(ERR_RESOURCE_LIMITED): The resource is limited. The SDK fails to allocate resources because your app consumes too much system resource or the system resources are insufficient.
  - -101(ERR_INVALID_APP_ID): The App ID is invalid.

## [createAgoraRtcEngine](class_irtcengine.html#api_createagorartcengine)

Creates the IRtcEngine object.

```cpp
AGORA_API agora::rtc::IRtcEngine *AGORA_CALL createAgoraRtcEngine ()
```

- Deprecated:

  This method is deprecated. Use [initialize](class_irtcengine.html#api_create2) instead.

### Parameters

- appId

  The Agora App ID of your Agora project.

### Returns

- The IRtcEngine instance, if the method call succeeds.
- An error code, if the call fails.

## [createDataStream [1/2\]](class_irtcengine.html#api_createdatastream)

Creates a data stream.

```cpp
virtual int createDataStream(int* streamId, bool reliable, bool ordered) = 0;
```

Each user can create up to five data streams during the lifecycle of [IRtcEngine](class_irtcengine.html#class_irtcengine).

**Note**

- Call this method after joining a channel.
- Agora does not support setting **reliable** as `true` and **ordered** as `true`.

### Parameters

- streamId

  Output parameter. Pointer to the ID of the created data stream.

- reliable

  Whether or not the data stream is reliable:`true`: The recipients receive the data from the sender within five seconds. If the recipient does not receive the data within five seconds, the SDK triggers the [onStreamMessageError](class_irtcengineeventhandler.html#callback_onstreammessageerror) callback and returns an error code.`false`: There is no guarantee that the recipients receive the data stream within five seconds and no error message is reported for any delay or missing data stream.

- ordered

  Whether or not the recipients receive the data stream in the sent order:`true`: The recipients receive the data in the sent order.`false`: The recipients do not receive the data in the sent order.

### Returns

- 0: The data stream is successfully created.
- < 0: Failure.

## [createDataStream [2/2\]](class_irtcengine.html#api_createdatastream2)

Creates a data stream.

```cpp
virtual int createDataStream(int* streamId, DataStreamConfig& config) = 0;
```

Creates a data stream. Each user can create up to five data streams in a single channel.

Compared with [createDataStream [1/2\]](class_irtcengine.html#api_createdatastream)[1/2], this method does not support data reliability. If a data packet is not received five seconds after it was sent, the SDK directly discards the data.

### Parameters

- streamId

  Output parameter. Pointer to the ID of the created data stream.

- config

  The configurations for the data stream. For details, see [DataStreamConfig](rtc_api_data_type.html#class_datastreamconfig).

### Returns

- 0: The data stream is successfully created.
- < 0: Failure.

## [createMediaPlayer](class_irtcengine.html#api_createmediaplayer)

Creates a media player instance.

```cpp
virtual agora_refptr <IMediaPlayer> createMediaPlayer() = 0;
```

### Returns

- The [IMediaPlayer](class_imediaplayer.html#class_imediaplayer) instance, if the method call succeeds.
- An empty pointer , if the method call fails.

## [destroyMediaPlayer](class_irtcengine.html#api_destroymediaplayer)

Destroys the media player instance.

```cpp
virtual int destroyMediaPlayer(agora_refptr<IMediaPlayer> media_player) = 0;
```

### Parameters

- media_player

  [IMediaPlayer](class_imediaplayer.html#class_imediaplayer) object.

### Returns

- ≥ 0: Success. Returns the ID of media player source instance.
- < 0: Failure.

## [disableAudio](class_irtcengine.html#api_disableaudio)

Disables the audio module.

```cpp
virtual int disableAudio() = 0;
```

**Note**

- This method disables the internal engine and can be called anytime after initialization. It is still valid after one leaves channel.
- This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the audio modules separately:
  - [enableLocalAudio](class_irtcengine.html#api_enablelocalaudio): Whether to enable the microphone to create the local audio stream.
  - [muteLocalAudioStream](class_irtcengine.html#api_mutelocalaudiostream): Whether to publish the local audio stream.
  - [muteRemoteAudioStream](class_irtcengine.html#api_muteremoteaudiostream): Whether to subscribe and play the remote audio stream.
  - [muteAllRemoteAudioStreams](class_irtcengine.html#api_muteallremoteaudiostreams): Whether to subscribe to and play all remote audio streams.

### Returns

- 0: Success.
- < 0: Failure.

## [disableAudioSpectrumMonitor](class_irtcengine.html#api_disableaudiospectrummonitor)

Disables audio spectrum monitoring.

```cpp
virtual int disableAudioSpectrumMonitor() = 0;
```

After calling [enableAudioSpectrumMonitor](class_irtcengine.html#api_enableaudiospectrummonitor), if you want to disable audio spectrum monitoring, you can call this method.

**Note**

You can call this method either before or after joining a channel.

### Returns

- 0: Success.
- < 0: Failure.

## [disableVideo](class_irtcengine.html#api_disablevideo)

Disables the video module.

```cpp
virtual int disableVideo() = 0;
```

This method disables video. You can call this method either before or after joining a channel. If you call it before joining a channel, an audio call starts when you join the channel. If you call it after joining a channel, a video call switches to an audio call. Call [enableVideo](class_irtcengine.html#api_enablevideo) to enable video.

A successful call of this method triggers the [onUserEnableVideo](class_irtcengineeventhandler.html#callback_onuserenablevideo)(`false`) callback on the remote client.

**Note**

- This method affects the internal engine and can be called after leaving the channel.
- This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the video engine modules separately:
  - [enableLocalVideo](class_irtcengine.html#api_enablelocalvideo): Whether to enable the camera to create the local video stream.
  - [muteLocalVideoStream](class_irtcengine.html#api_mutelocalvideostream): Whether to publish the local video stream.
  - [muteRemoteVideoStream](class_irtcengine.html#api_muteremotevideostream): Whether to subscribe to and play the remote video stream.
  - [muteAllRemoteVideoStreams](class_irtcengine.html#api_muteallremotevideostreams): Whether to subscribe to and play all remote video streams.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onRemoteVideoStateChanged](../API/class_irtcengineeventhandler.html#callback_onremotevideostatechanged)
- [onUserEnableVideo](../API/class_irtcengineeventhandler.html#callback_onuserenablevideo)

## [enableAudio](class_irtcengine.html#api_enableaudio)

Enables the audio module.

```cpp
virtual int enableAudio() = 0;
```

The audio mode is enabled by default.

**Note**

- This method enables the internal engine and can be called anytime after initialization. It is still valid after one leaves channel.
- This method enables the audio module and takes some time to take effect. Agora recommends using the following API methods to control the audio module separately:
  - [enableLocalAudio](class_irtcengine.html#api_enablelocalaudio): Whether to enable the microphone to create the local audio stream.
  - [muteLocalAudioStream](class_irtcengine.html#api_mutelocalaudiostream): Whether to publish the local audio stream.
  - [muteRemoteAudioStream](class_irtcengine.html#api_muteremoteaudiostream): Whether to subscribe and play the remote audio stream.
  - [muteAllRemoteAudioStreams](class_irtcengine.html#api_muteallremoteaudiostreams): Whether to subscribe to and play all remote audio streams.

### Returns

- 0: Success.
- < 0: Failure.

## [enableAudioSpectrumMonitor](class_irtcengine.html#api_enableaudiospectrummonitor)

Turn on audio spectrum monitoring.

```cpp
virtual int enableAudioSpectrumMonitor(int intervalInMS = 100) = 0;
```

If you want to obtain the audio spectrum data of local or remote users, please register the audio spectrum observer and enable audio spectrum monitoring.

**Note**

You can call this method either before or after joining a channel.

### Parameters

- **intervalInMS**

  The interval (in milliseconds) at which the SDK triggers the [onLocalAudioSpectrum](class_iaudiospectrumobserver.html#callback_iaudiospectrumobserver_onlocalaudiospectrum) and [onRemoteAudioSpectrum](class_iaudiospectrumobserver.html#callback_iaudiospectrumobserver_onremoteaudiospectrum) callbacks. The default value is 100. Do not set this parameter to less than 10 milliseconds, otherwise the callback will not be triggered.

### Returns

- 0: Success.
- < 0: Failure.
  - `-2 (ERR_INVALID_ARGUMENT)`: The parameter is invalid.

**See also**

- [onLocalAudioSpectrum](../API/class_iaudiospectrumobserver.html#callback_iaudiospectrumobserver_onlocalaudiospectrum)
- [onRemoteAudioSpectrum](../API/class_iaudiospectrumobserver.html#callback_iaudiospectrumobserver_onremoteaudiospectrum)

## [enableAudioVolumeIndication](class_irtcengine.html#api_enableaudiovolumeindication)

Enables the reporting of users' volume indication.

```cpp
virtual int enableAudioVolumeIndication(int interval, int smooth, bool reportVad) = 0;
```

This method enables the SDK to regularly report the volume information of the local user who sends a stream and remote users (up to three) whose instantaneous volumes are the highest to the app. Once you call this method and users send streams in the channel, the SDK triggers the [onAudioVolumeIndication](class_irtcengineeventhandler.html#callback_onaudiovolumeindication) callback at the time interval set in this method.

**Note** You can call this method either before or after joining a channel.

### Parameters

- interval

  Sets the time interval between two consecutive volume indications:≤ 0: Disables the volume indication.> 0: Time interval (ms) between two consecutive volume indications. We recommend a setting greater than 200 ms. Do not set this parameter to less than 10 milliseconds, otherwise the onAudioVolumeIndication callback will not be triggered.

- smooth

  The smoothing factor sets the sensitivity of the audio volume indicator. The value ranges between 0 and 10. The recommended value is 3. The greater the value, the more sensitive the indicator.

- reportVad

  `true`: Enable the voice activity detection of the local user. Once it is enabled, the **vad** parameter of the onAudioVolumeIndication callback reports the voice activity status of the local user.`false`: (Default) Disable the voice activity detection of the local user. Once it is disabled, the **vad** parameter of the onAudioVolumeIndication callback does not report the voice activity status of the local user, except for the scenario where the engine automatically detects the voice activity of the local user.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onAudioVolumeIndication](../API/class_irtcengineeventhandler.html#callback_onaudiovolumeindication)

## [enableDualStreamMode [1/3\]](class_irtcengine.html#api_enabledualstreammode)

Enables/Disables dual-stream mode.

```cpp
virtual int enableDualStreamMode(bool enabled) = 0;
```

You can call this method to enable or disable the dual-stream mode on the publisher side. Dual streams are a hybrid of a high-quality video stream and a low-quality video stream:

- High-quality video stream: High bitrate, high resolution.
- Low-quality video stream: Low bitrate, low resolution.

After you enable the dual-stream mode, you can call [setRemoteVideoStreamType](class_irtcengine.html#api_setremotevideostreamtype) to choose to receive the high-quality video stream or low-quality video stream on the subscriber side.

**Note**

You can call this method either before or after joining a channel.

### Parameters

- enabled

  Enables dual-stream mode.`true`: Enables dual-stream mode.`false`: Disables dual-stream mode.

### Returns

- 0: Success.
- < 0: Failure.

## [enableDualStreamMode [2/3\]](class_irtcengine.html#api_enabledualstreammode2)

Enables/Disables dual-stream mode.

```cpp
virtual int enableDualStreamMode(VIDEO_SOURCE_TYPE sourceType, bool enabled) = 0;
```

You can call this method to enable or disable the dual-stream mode on the publisher side. Dual streams are a hybrid of a high-quality video stream and a low-quality video stream:

- High-quality video stream: High bitrate, high resolution.
- Low-quality video stream: Low bitrate, low resolution.

After you enable the dual-stream mode, you can call [setRemoteVideoStreamType](class_irtcengine.html#api_setremotevideostreamtype) to choose to receive the high-quality video stream or low-quality video stream on the subscriber side.

**Note**

You can call this method either before or after joining a channel.

### Parameters

- sourceType

  The capture type of the custom video source. For details, see [VIDEO_SOURCE_TYPE](rtc_api_data_type.html#enum_videosourcetype).

- enabled

  Enables dual-stream mode.`true`: Enables dual-stream mode.`false`: Disables dual-stream mode.

### Returns

- 0: Success.
- < 0: Failure.

## [enableDualStreamMode [3/3\]](class_irtcengine.html#api_enabledualstreammode3)

Enables/Disables dual-stream mode.

```cpp
virtual int enableDualStreamMode(
      VIDEO_SOURCE_TYPE sourceType, bool enabled, const SimulcastStreamConfig& streamConfig) = 0;
```

You can call this method to enable or disable the dual-stream mode on the publisher side. Dual streams are a hybrid of a high-quality video stream and a low-quality video stream:

- High-quality video stream: High bitrate, high resolution.
- Low-quality video stream: Low bitrate, low resolution.

After you enable the dual-stream mode, you can call [setRemoteVideoStreamType](class_irtcengine.html#api_setremotevideostreamtype) to choose to receive the high-quality video stream or low-quality video stream on the subscriber side.

**Note**

You can call this method either before or after joining a channel.

### Parameters

- sourceType

  The capture type of the custom video source. For details, see [VIDEO_SOURCE_TYPE](rtc_api_data_type.html#enum_videosourcetype).

- enabled

  Enables dual-stream mode.`true`: Enables dual-stream mode.`false`: Disables dual-stream mode.

- streamConfig

  The configuration of the low-quality video stream. See [SimulcastStreamConfig](rtc_api_data_type.html#class_simulcaststreamconfig).

### Returns

- 0: Success.
- < 0: Failure.

## [enableEncryption](class_irtcengine.html#api_enableencryption)

Enables/Disables the built-in encryption.

```cpp
virtual int enableEncryption(bool enabled, const EncryptionConfig& config) = 0;
```

In scenarios requiring high security, Agora recommends calling this method to enable the built-in encryption before joining a channel.

All users in the same channel must use the same encryption mode and encryption key. After the user leaves the channel, the SDK automatically disables the built-in encryption. To enable the built-in encryption, call this method before the user joins the channel again.

**Note** If you enable the built-in encryption, you cannot use the RTMP or RTMPS streaming function.

### Parameters

- enabled

  Whether to enable built-in encryption:true: Enable the built-in encryption.false: Disable the built-in encryption.

- config

  Configurations of built-in encryption. For details, see [EncryptionConfig](rtc_api_data_type.html#class_encryptionconfig).

### Returns

- 0: Success.
- < 0: Failure.
  - -2(ERR_INVALID_ARGUMENT): An invalid parameter is used. Set the parameter with a valid value.
  - -4(ERR_NOT_SUPPORTED): The encryption mode is incorrect or the SDK fails to load the external encryption library. Check the enumeration or reload the external encryption library.
  - -7(ERR_NOT_INITIALIZED): The SDK is not initialized. Initialize the [IRtcEngine](class_irtcengine.html#class_irtcengine) instance before calling this method.

## [enableExtension](class_irtcengine.html#api_enableextension)

Enables/Disables extensions.

```cpp
virtual int enableExtension(
      const char* provider, const char* extension, bool enable=true, agora::media::MEDIA_SOURCE_TYPE type = agora::media::UNKNOWN_MEDIA_SOURCE) = 0;
```

Ensure that you call this method before joining a channel.

**Note**

- If you want to enable multiple extensions, you need to call this method multiple times.
- The data processing order of different extensions in the SDK is determined by the order in which the extensions are enabled. That is, the extension that is enabled first will process the data first.

### Parameters

- provider

  The name of the extension provider.

- extension

  The name of the extension.

- enable

  Whether to enable the extension:`true`: Enable the extension.`false`: Disable the extension.

- type

  The type of media source. See [MEDIA_SOURCE_TYPE](rtc_api_data_type.html#enum_mediasourcetype).**Note** This parameter in this method only supports two values:The default value is UNKNOWN_MEDIA_SOURCE.If you want to use a secondary camera to capture video, set this parameter to SECONDARY_CAMERA_SOURCE.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onExtensionStarted](../API/class_irtcengineeventhandler.html#callback_onextensionstarted)
- [onExtensionStopped](../API/class_irtcengineeventhandler.html#callback_onextensionstoped)
- [onExtensionError](../API/class_irtcengineeventhandler.html#callback_onextensionerror)

## [enableFaceDetection](class_irtcengine.html#api_enablefacedetection)

Enables/Disables face detection for the local user.

```cpp
virtual int enableFaceDetection(bool enabled) = 0;
```



You can call this method either before or after joining a channel.

**Note** This method is for Android and iOS only.

Once face detection is enabled, the SDK triggers the [onFacePositionChanged](class_irtcengineeventhandler.html#callback_onfacepositionchanged) callback to report the face information of the local user:

- The width and height of the local video.
- The position of the human face in the local video.
- The distance between the human face and the screen.

This method needs to be called after the camera is started (for example, by calling startPreview or joinChannel [2/2]).

### Parameters

- enabled

  Whether to enable face detection:`true`: Enable face detection.`false`: (Default) Disable face detection.

### Returns

- 0: Success.
- < 0: Failure.

## [enableInEarMonitoring](class_irtcengine.html#api_enableinearmonitoring2)

Enables in-ear monitoring.

```cpp
virtual int enableInEarMonitoring(bool enabled, int includeAudioFilters) = 0;
```

This method enables or disables in-ear monitoring.

### Parameters

- enabled

  Enables in-ear monitoring.`true`: Enables in-ear monitoring.`false`: (Default) Disables in-ear monitoring.

- includeAudioFilters

  The audio filter of in-ear monitoring: For details, see [EAR_MONITORING_FILTER_TYPE](rtc_api_data_type.html#enum_earmonitoringfiltertype).

### Returns

- 0: Success.
- < 0: Failure.

## [enableLocalAudio](class_irtcengine.html#api_enablelocalaudio)

Enables/Disables the local audio capture.

```cpp
virtual int enableLocalAudio(bool enabled) = 0;
```

The audio function is enabled by default. This method disables or re-enables the local audio function to stop or restart local audio capturing.

This method does not affect receiving or playing the remote audio streams, and [enableLocalAudio](class_irtcengine.html#api_enablelocalaudio)(`false`) applies to scenarios where the user wants to receive remote audio streams without sending any audio stream to other users in the channel.

Once the local audio function is disabled or re-enabled, the SDK triggers the [onLocalAudioStateChanged](class_irtcengineeventhandler.html#callback_onlocalaudiostatechanged) callback, which reports LOCAL_AUDIO_STREAM_STATE_STOPPED(0) or LOCAL_AUDIO_STREAM_STATE_RECORDING(1).

**Note**

- This method is different from the

   

  muteLocalAudioStream

   

  method:

  - enableLocalVideo: Disables/Re-enables the local audio capturing and processing. If you disable or re-enable local audio capturing using the `enableLocalAudio` method, the local user might hear a pause in the remote audio playback.
  - muteLocalAudioStream: Sends/Stops sending the local audio streams.

- You can call this method either before or after joining a channel.

### Parameters

- enabled

  `true`: (Default) Re-enable the local audio function, that is, to start the local audio capturing device (for example, the microphone).`false`: Disable the local audio function, that is, to stop local audio capturing.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onLocalAudioStateChanged](../API/class_irtcengineeventhandler.html#callback_onlocalaudiostatechanged)

## [enableLocalVideo](class_irtcengine.html#api_enablelocalvideo)

Enables/Disables the local video capture.

```cpp
virtual int enableLocalVideo(bool enabled) = 0;
```

This method disables or re-enables the local video capturer, and does not affect receiving the remote video stream.

After calling [enableVideo](class_irtcengine.html#api_enablevideo), the local video capturer is enabled by default. You can call [enableLocalVideo](class_irtcengine.html#api_enablelocalvideo)(`false`) to disable the local video capturer. If you want to re-enable the local video, call enableLocalVideo(`true`).

After the local video capturer is successfully disabled or re-enabled, the SDK triggers the callback on the remote client[onRemoteVideoStateChanged](class_irtcengineeventhandler.html#callback_onremotevideostatechanged).

**Note**

- You can call this method either before or after joining a channel.
- This method enables the internal engine and is valid after .

### Parameters

- enabled

  Whether to enable the local video capture.`true`: (Default) Enable the local video capture.`false`: Disables the local video capture. Once the local video is disabled, the remote users can no longer receive the video stream of this user, while this user can still receive the video streams of the other remote users. When set to `false`, this method does not require a local camera.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onUserEnableLocalVideo](../API/class_irtcengineeventhandler.html#callback_onuserenablelocalvideo)

## [enableLoopbackRecording](class_irtcengine.html#api_enableloopbackrecording_ng)

Enables loopback audio capturing.

```cpp
virtual int enableLoopbackRecording(bool enabled) = 0;
```

If you enable loopback audio capturing, the output of the sound card is mixed into the audio stream sent to the other end.

**Note**

This method applies to Windows only.

### Parameters

- enabled

  Sets whether to enable loopback capturing.`true`: Enable loopback audio capturing.`false`: (Default) Disable loopback capturing.

### Returns

- 0: Success.
- < 0: Failure.

## [enableSoundPositionIndication](class_irtcengine.html#api_enablesoundpositionindication)

Enables/Disables stereo panning for remote users.

```cpp
virtual int enableSoundPositionIndication(bool enabled) = 0;
```

Ensure that you call this method before joining a channel to enable stereo panning for remote users so that the local user can track the position of a remote user by calling setRemoteVoicePosition.

### Parameters

- enabled

  Whether to enable stereo panning for remote users:`true`: Enable stereo panning.`false`: Disable stereo panning.

### Returns

- 0: Success.
- < 0: Failure.

## [enableVideo](class_irtcengine.html#api_enablevideo)

Enables the video module.

```cpp
virtual int enableVideo() = 0;
```

Call this method either before joining a channel or during a call. If this method is called before joining a channel, the call starts in the video mode. Call [disableVideo](class_irtcengine.html#api_disablevideo) to disable the video mode.

A successful call of this method triggers the [onRemoteVideoStateChanged](class_irtcengineeventhandler.html#callback_onremotevideostatechanged) callback on the remote client.

**Note**

- This method enables the internal engine and is valid after leaving the channel.
- This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the video engine modules separately:
  - [enableLocalVideo](class_irtcengine.html#api_enablelocalvideo): Whether to enable the camera to create the local video stream.
  - [muteLocalVideoStream](class_irtcengine.html#api_mutelocalvideostream): Whether to publish the local video stream.
  - [muteRemoteVideoStream](class_irtcengine.html#api_muteremotevideostream): Whether to subscribe to and play the remote video stream.
  - [muteAllRemoteVideoStreams](class_irtcengine.html#api_muteallremotevideostreams): Whether to subscribe to and play all remote video streams.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onRemoteVideoStateChanged](../API/class_irtcengineeventhandler.html#callback_onremotevideostatechanged)
- [onUserEnableVideo](../API/class_irtcengineeventhandler.html#callback_onuserenablevideo)

## [enableVirtualBackground](class_irtcengine.html#api_enablevirtualbackground)

Enables/Disables the virtual background. (beta feature)

```
virtual int enableVirtualBackground(bool enabled, VirtualBackgroundSource backgroundSource) = 0;
```

The virtual background function allows you to replace the original background image of the local user or to blur the background. After successfully enabling the virtual background function, all users in the channel can see the customized background.

Enabling the virtual background function involves a series of method calls. The calling sequence is as follows:

1. Call `loadExtensionProvider(libagora_segmentation_extension.dll)` during [IRtcEngine](class_irtcengine.html#class_irtcengine) initialization to specify the extension's library path.
2. Call `enableExtension(agora_segmentation, PortraitSegmentation, true)` to enable the extension.
3. Call [enableVideo](class_irtcengine.html#api_enablevideo) to enable the video module.
4. Call this method to enable the virtual background function.

**Note**

- This function requires a high-performance device. Agora recommends that you use this function on devices with the following chips:
  - Snapdragon 700 series 750G and later
  - Snapdragon 800 series 835 and later
  - Dimensity 700 series 720 and later
  - Kirin 800 series 810 and later
  - Kirin 900 series 980 and later
  - Devices with an i5 CPU and better
  - Devices with an A9 chip and better, as follows:
    - iPhone 6S and later
    - iPad Air 3rd generation and later
    - iPad 5th generation and later
    - iPad Pro 2nd generation and later
    - iPad mini 5th generation and later
- Agora recommends that you use this function in scenarios that meet the following conditions:
  - A high-definition camera device is used, and the environment is uniformly lit.
  - There are few objects in the captured video. Portraits are half-length and unobstructed. Ensure that the background is a solid color that is different from the color of the user's clothing.

### Parameters

- enabled

  Whether to enable virtual background:`true`: Enable virtual background.`false`: Disable virtual background.

- backgroundSource

  The custom background image. See [VirtualBackgroundSource](rtc_api_data_type.html#class_virtualbackgroundsource) for details. To adapt the resolution of the custom background image to that of the video captured by the SDK, the SDK scales and crops the custom background image while ensuring that the content of the custom background image is not distorted.

### Returns

- 0: Success.
- < 0: Failure.
  - -1: The custom background image does not exist. Please check the value of **source** in [VirtualBackgroundSource](rtc_api_data_type.html#class_virtualbackgroundsource).
  - -2: The color format of the custom background image is invalid. Please check the value of **color** in [VirtualBackgroundSource](rtc_api_data_type.html#class_virtualbackgroundsource).
  - -3: The device does not support using the virtual background.

## [enableWebSdkInteroperability](class_irtcengine.html#api_enablewebsdkinteroperability)

Enables interoperability with the Agora Web SDK (applicable only in the live streaming scenarios).

```cpp
virtual int enableWebSdkInteroperability(bool enabled) = 0;
```

- Deprecated:

  The SDK automatically enables interoperability with the Web SDK, so you no longer need to call this method.

This method enables or disables interoperability with the Agora Web SDK. If the channel has Web SDK users, ensure that you call this method, or the video of the Native user will be a black screen for the Web user.

This method is only applicable in live streaming scenarios, and interoperability is enabled by default in communication scenarios.

### Parameters

- enabled

  Whether to enable interoperability with the Agora Web SDK.`true`: Enable interoperability.`false`: (Default) Disable interoperability.

### Returns

- 0: Success.
- < 0: Failure.

## [getAudioDeviceInfo](class_irtcengine.html#api_getaudiodeviceinfo)

Gets the audio device information.

```cpp
virtual int getAudioDeviceInfo(DeviceInfo& deviceInfo) = 0;
```

After calling this method, you can get whether the audio device supports ultra-low-latency capture and playback.

**Note**

- This method is for Android only.
- You can call this method either before or after joining a channel.

### Parameters

- deviceInfo

  Input and output parameter. A [DeviceInfo](rtc_api_data_type.html#class_deviceinfo) object that identifies the audio device information.Input value: A DeviceInfo object.Output value: A DeviceInfo object containing audio device information.

### Returns

- 0: Success.
- < 0: Failure.

## [getAudioMixingCurrentPosition](class_irtcengine.html#api_getaudiomixingcurrentposition)

Retrieves the playback position (ms) of the music file.

```cpp
virtual int getAudioMixingCurrentPosition() = 0;
```

Retrieves the playback position (ms) of the audio.

**Note** You need to call this method after calling startAudioMixing [2/2] and receiving the onAudioMixingStateChanged(`PLAY`) callback.

### Returns

- ≥ 0: The current playback position of the audio mixing, if this method call succeeds.
- < 0: Failure.

## [getAudioMixingDuration](class_irtcengine.html#api_getaudiomixingduration)

Retrieves the duration (ms) of the music file.

```cpp
virtual int getAudioMixingDuration() = 0;
```

Retrieves the total duration (ms) of the audio.

**Note** You need to call this method after calling [startAudioMixing [2/2\]](class_irtcengine.html#api_startaudiomixing2) and receiving the [onAudioMixingStateChanged](class_irtcengineeventhandler.html#callback_onaudiomixingstatechanged_ng)(AUDIO_MIXING_STATE_PLAYING) callback.

### Returns

- ≥ 0: The audio mixing duration, if this method call succeeds.
- < 0: Failure.

## [getAudioMixingPlayoutVolume](class_irtcengine.html#api_getaudiomixingplayoutvolume)

Retrieves the audio mixing volume for local playback.

```cpp
virtual int getAudioMixingPlayoutVolume() = 0;
```

This method helps troubleshoot audio volume‑related issues.

**Note** You need to call this method after calling startAudioMixing [2/2] and receiving the onAudioMixingStateChanged(`PLAY`) callback.

### Returns

- ≥ 0: The audio mixing volume, if this method call succeeds. The value range is [0,100].
- < 0: Failure.

## [getAudioMixingPublishVolume](class_irtcengine.html#api_getaudiomixingpublishvolume)

Retrieves the audio mixing volume for publishing.

```cpp
virtual int getAudioMixingPublishVolume() = 0;
```

- Since

  v2.4.1

This method helps troubleshoot audio volume‑related issues.

**Note** You need to call this method after calling startAudioMixing [2/2] and receiving the onAudioMixingStateChanged(`PLAY`) callback.

### Returns

- ≥ 0: The audio mixing volume, if this method call succeeds. The value range is [0,100].
- < 0: Failure.

## [getCallId](class_irtcengine.html#api_getcallid)

Retrieves the call ID.

```cpp
virtual int getCallId(agora::util::AString& callId) = 0;
```

When a user joins a channel on a client, a **callId** is generated to identify the call from the client. Some methods, such as [rate](class_irtcengine.html#api_rate) and [complain](class_irtcengine.html#api_complain), must be called after the call ends to submit feedback to the SDK. These methods require the **callId** parameter.

**Note** Call this method after joining a channel.

### Parameters

- callId

  Output parameter, the current call ID.

### Returns

- 0: Success.
- < 0: Failure.

## [getCameraMaxZoomFactor](class_irtcengine.html#api_getcameramaxzoomfactor)

Gets the maximum zoom ratio supported by the camera.

```cpp
virtual float getCameraMaxZoomFactor() = 0;
```

**Note**

- This method is for Android and iOS only.
- Call this method before calling [joinChannel [2/2\]](class_irtcengine.html#api_joinchannel2_ng), [enableVideo](class_irtcengine.html#api_enablevideo), or [enableLocalVideo](class_irtcengine.html#api_enablelocalvideo), depending on which method you use to turn on your local camera.

### Returns

The maximum zoom factor.

## [getConnectionState](class_irtcengine.html#api_getconnectionstate)

Gets the current connection state of the SDK.

```cpp
virtual CONNECTION_STATE_TYPE getConnectionState() = 0;
```

You can call this method either before or after joining a channel.

### Returns

The current connection state. For details, see [CONNECTION_STATE_TYPE](rtc_api_data_type.html#enum_connectionstatetype).

## [getEffectsVolume](class_irtcengine.html#api_geteffectsvolume)

Retrieves the volume of the audio effects.

```cpp
virtual int getEffectsVolume() = 0;
```

The volume is an integer ranging from 0 to 100. The default value is 100, the original volume.

### Returns

- Volume of the audio effects, if this method call succeeds.
- < 0: Failure.

## [getErrorDescription](class_irtcengine.html#api_geterrordescription)

Gets the warning or error description.

```cpp
virtual const char* getErrorDescription(int code) = 0;
```

### Parameters

- code

  The error code or warning code reported by the SDK.

### Returns

The specific error or warning description.

## [getVolumeOfEffect](class_irtcengine.html#api_getvolumeofeffect)

Gets the volume of a specified audio effect.

```cpp
virtual int getVolumeOfEffect(int soundId) = 0;
```

### Parameters

- soundId

  The ID of the audio effect.

### Returns

- ≥ 0: Returns the volume of the specified audio effect, if the method call is successful. The value ranges between 0 and 100. 100 represents the original volume.
- < 0: Failure.

## [getVersion](class_irtcengine.html#api_getversion)

Gets the SDK version.

```cpp
virtual const char* getVersion(int* build) = 0;
```

### Returns

The SDK version number. The format is a string.

## [getUserInfoByUid](class_irtcengine.html#api_getuserinfobyuid)

Gets the user information by passing in the user ID.

```cpp
virtual int getUserInfoByUid(uid_t uid, rtc::UserInfo* userInfo, const char* channelId = NULL, const char* localUserAccount = NULL) = 0;
```

After a remote user joins the channel, the SDK gets the UID and user account of the remote user, caches them in a mapping table object, and triggers the [onUserInfoUpdated](class_irtcengineeventhandler.html#callback_onuserinfoupdated) callback on the local client. After receiving the callback, you can call this method to get the user account of the remote user from the [UserInfo](rtc_api_data_type.html#class_userinfo) object by passing in the user ID.

### Parameters

- uid

  User ID.

- userInfo

  Input and output parameter. The [UserInfo](rtc_api_data_type.html#class_userinfo) object that identifies the user information.Input: A UserInfo object.Output: A UserInfo object that contains the user account and user ID of the user.

- channelId

  The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported character scopes are:All lowercase English letters: a to z.All uppercase English letters: A to Z.All numeric characters: 0 to 9.Space"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "= ", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","

- localUserAccount

  The user account of the local user.

### Returns

- 0: Success.
- < 0: Failure.

## [getUserInfoByUserAccount](class_irtcengine.html#api_getuserinfobyuseraccount)

Gets the user information by passing in the user account.

```cpp
virtual int getUserInfoByUserAccount(const char* userAccount, rtc::UserInfo* userInfo, const char* channelId = NULL, const char* localUserAccount = NULL) = 0;
```

After a remote user joins the channel, the SDK gets the UID and user account of the remote user, caches them in a mapping table object, and triggers the [onUserInfoUpdated](class_irtcengineeventhandler.html#callback_onuserinfoupdated) callback on the local client. After receiving the callback, you can call this method to get the user account of the remote user from the [UserInfo](rtc_api_data_type.html#class_userinfo) object by passing in the user ID.

### Parameters

- userAccount

  The user account.

- userInfo

  Input and output parameter. The [UserInfo](rtc_api_data_type.html#class_userinfo) object that identifies the user information.Input: A UserInfo object.Output: A UserInfo object that contains the user account and user ID of the user.

- channelId

  The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported character scopes are:All lowercase English letters: a to z.All uppercase English letters: A to Z.All numeric characters: 0 to 9.Space"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "= ", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","

- localUserAccount

  The user account of the local user.

### Returns

- 0: Success.
- < 0: Failure.

## [isCameraAutoFocusFaceModeSupported](class_irtcengine.html#api_iscameraautofocusfacemodesupported)

Checks whether the device supports the face auto-focus function.

This method needs to be called after the camera is started (for example, by calling [startPreview](class_irtcengine.html#api_startpreview) or [joinChannel [2/2\]](class_irtcengine.html#api_joinchannel2_ng)).

### Returns

- `true`: The device supports the face auto-focus function.
- `false`: The device does not support the face auto-focus function.

## [isCameraExposurePositionSupported](class_irtcengine.html#api_iscameraexposurepositionsupported)

Checks whether the device supports manual exposure.

```cpp
virtual bool isCameraExposurePositionSupported() = 0;
```

**Note**

- This method is for Android and iOS only.
- Call this method before calling [joinChannel [2/2\]](class_irtcengine.html#api_joinchannel2_ng), [enableVideo](class_irtcengine.html#api_enablevideo), or [enableLocalVideo](class_irtcengine.html#api_enablelocalvideo), depending on which method you use to turn on your local camera.

### Returns

- `true`: The device supports manual exposure.
- `false`: The device does not support manual exposure.

## [isCameraFaceDetectSupported](class_irtcengine.html#api_iscamerafacedetectsupported)

Checks whether the device camera supports face detection.

```cpp
virtual bool isCameraFaceDetectSupported() = 0;
```

**Note** This method is for Android and iOS only.

### Returns

- `true`: The device camera supports face detection.
- `false`: The device camera does not support face detection.

## [isCameraFocusSupported](class_irtcengine.html#api_iscamerafocussupported)

Check whether the device supports the manual focus function.

```cpp
virtual bool isCameraFocusSupported() = 0;
```

**Note**

- This method is for Android and iOS only.
- Call this method before calling [joinChannel [2/2\]](class_irtcengine.html#api_joinchannel2_ng), [enableVideo](class_irtcengine.html#api_enablevideo), or [enableLocalVideo](class_irtcengine.html#api_enablelocalvideo), depending on which method you use to turn on your local camera.

### Returns

- `true`: The device supports the manual focus function.
- `false`: The device does not support the manual focus function.

## [isCameraTorchSupported](class_irtcengine.html#api_iscameratorchsupported)

Checks whether the device supports camera flash.

```cpp
virtual bool isCameraTorchSupported() = 0;
```

This method needs to be called after the camera is started (for example, by calling [startPreview](class_irtcengine.html#api_startpreview) or [joinChannel [2/2\]](class_irtcengine.html#api_joinchannel2_ng)).

**Note**

- This method is for Android and iOS only.
- The app enables the front camera by default. If your front camera does not support flash, this method returns false. If you want to check whether the rear camera supports flash, call [switchCamera](class_irtcengine.html#api_switchcamera) before this method.

### Returns

- `true`: The device supports camera flash.
- `false`: The device does not support camera flash.

## [isCameraZoomSupported](class_irtcengine.html#api_iscamerazoomsupported)

Checks whether the device supports camera zoom.

```cpp
virtual bool isCameraZoomSupported() = 0;
```

**Note**

- This method is for Android and iOS only.
- Call this method before calling [joinChannel [2/2\]](class_irtcengine.html#api_joinchannel2_ng), [enableVideo](class_irtcengine.html#api_enablevideo), or [enableLocalVideo](class_irtcengine.html#api_enablelocalvideo), depending on which method you use to turn on your local camera.

### Returns

- `true`: The device supports camera zoom.
- `false`: The device does not support camera zoom.

## [isSpeakerphoneEnabled](class_irtcengine.html#api_isspeakerphoneenabled)

Checks whether the speakerphone is enabled.

```cpp
virtual bool isSpeakerphoneEnabled() = 0;
```

**Note** This method is for Android and iOS only.

### Returns

- `true`: The speakerphone is enabled, and the audio plays from the speakerphone.
- `false`: The speakerphone is not enabled, and the audio plays from devices other than the speakerphone. For example, the headset or earpiece.

## [joinChannel [1/2\]](class_irtcengine.html#api_joinchannel)

Joins a channel.

```cpp
virtual int joinChannel(const char* token, const char* channelId, const char* info,
                        uid_t uid) = 0;
```



This method enables users to join a channel. Users in the same channel can talk to each other, and multiple users in the same channel can start a group chat. Users with different App IDs cannot call each other.

A successful call of this method triggers the following callbacks:

- The local client: The [onJoinChannelSuccess](class_irtcengineeventhandler.html#callback_onjoinchannelsuccess) and [onConnectionStateChanged](class_irtcengineeventhandler.html#callback_onconnectionstatechanged) callbacks.
- The remote client: [onUserJoined](class_irtcengineeventhandler.html#callback_onuserjoined), if the user joining the channel is in the Communication profile or is a host in the Live-broadcasting profile.

When the connection between the client and Agora's server is interrupted due to poor network conditions, the SDK tries reconnecting to the server. When the local client successfully rejoins the channel, the SDK triggers the [onRejoinChannelSuccess](class_irtcengineeventhandler.html#callback_onrejoinchannelsuccess) callback on the local client.

**Note** Once a user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. To stop subscribing to a specified stream or all remote streams, call the corresponding mute methods.

### Parameters

- token

  The token generated on your server for authentication. See [Authenticate Your Users with Token](https://docs.agora.io/en/live-streaming-4.x-preview/token_server_android_ng?platform=Windows).

- channelId

  The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported character scopes are:All lowercase English letters: a to z.All uppercase English letters: A to Z.All numeric characters: 0 to 9.Space"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "= ", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","

- info

  (Optional) Reserved for future use.

- uid

  User ID. This parameter is used to identify the user in the channel for real-time audio and video interaction. You need to set and manage user IDs yourself, and ensure that each user ID in the same channel is unique. This parameter is a 32-bit unsigned integer. The value range is 1 to 232-1. If the user ID is not assigned (or set to 0), the SDK assigns a random user ID and returns it in the onJoinChannelSuccess callback. Your app must maintain the returned user ID, because the SDK does not do so.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onJoinChannelSuccess](../API/class_irtcengineeventhandler.html#callback_onjoinchannelsuccess)
- [onUserJoined](../API/class_irtcengineeventhandler.html#callback_onuserjoined)
- [onRejoinChannelSuccess](../API/class_irtcengineeventhandler.html#callback_onrejoinchannelsuccess)

## [joinChannel [2/2\]](class_irtcengine.html#api_joinchannel2_ng)

Joins a channel with media options.

```cpp
virtual int joinChannel(const char* token, const char* channelId, uid_t uid,
                          const ChannelMediaOptions& options) = 0;
```

This method enables users to join a channel. Users in the same channel can talk to each other, and multiple users in the same channel can start a group chat. Users with different App IDs cannot call each other.

A successful call of this method triggers the following callbacks:

- The local client: The [onJoinChannelSuccess](class_irtcengineeventhandler.html#callback_onjoinchannelsuccess) and [onConnectionStateChanged](class_irtcengineeventhandler.html#callback_onconnectionstatechanged) callbacks.
- The remote client: [onUserJoined](class_irtcengineeventhandler.html#callback_onuserjoined), if the user joining the channel is in the Communication profile or is a host in the Live-broadcasting profile.

When the connection between the client and Agora's server is interrupted due to poor network conditions, the SDK tries reconnecting to the server. When the local client successfully rejoins the channel, the SDK triggers the [onRejoinChannelSuccess](class_irtcengineeventhandler.html#callback_onrejoinchannelsuccess) callback on the local client.

Compared to [joinChannel [1/2\]](class_irtcengine.html#api_joinchannel), this method adds the **options** parameter to configure whether to automatically subscribe to all remote audio and video streams in the channel when the user joins the channel. By default, the user subscribes to the audio and video streams of all the other users in the channel, giving rise to usage and billings. To unsubscribe, set the **options** parameter or call the mute methods accordingly.

**Note**

- This method allows users to join only one channel at a time.
- Ensure that the app ID you use to generate the token is the same app ID that you pass in the [initialize](class_irtcengine.html#api_create2) method; otherwise, you may fail to join the channel by token.

### Parameters

- token

  The token generated on your server for authentication. See [Authenticate Your Users with Token](https://docs.agora.io/en/live-streaming-4.x-preview/token_server_android_ng?platform=Windows).

- channelId

  The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported character scopes are:All lowercase English letters: a to z.All uppercase English letters: A to Z.All numeric characters: 0 to 9.Space"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "= ", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","

- uid

  The user ID. This parameter is used to identify the user in the channel for real-time audio and video interaction. You need to set and manage user IDs yourself, and ensure that each user ID in the same channel is unique. This parameter is a 32-bit unsigned integer. The value range is 1 to 232-1. If the user ID is not assigned (or set to 0), the SDK assigns a random user ID and returns it in the onJoinChannelSuccess callback. Your application must record and maintain the returned user ID, because the SDK does not do so.

- options

  The channel media options. See [ChannelMediaOptions](rtc_api_data_type.html#class_channelmediaoptions_ng) for details.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onJoinChannelSuccess](../API/class_irtcengineeventhandler.html#callback_onjoinchannelsuccess)
- [onUserJoined](../API/class_irtcengineeventhandler.html#callback_onuserjoined)
- [onRejoinChannelSuccess](../API/class_irtcengineeventhandler.html#callback_onrejoinchannelsuccess)

## [joinChannelWithUserAccount [1/2\]](class_irtcengine.html#api_joinchannelwithuseraccount)

Joins the channel with a user account.



```cpp
virtual int joinChannelWithUserAccount(const char* token,
    const char* channelId,
    const char* userAccount) = 0;
```

This method allows a user to join the channel with the user account. After the user successfully joins the channel, the SDK triggers the following callbacks:

- The local client: [onLocalUserRegistered](class_irtcengineeventhandler.html#callback_onlocaluserregistered), [onJoinChannelSuccess](class_irtcengineeventhandler.html#callback_onjoinchannelsuccess) and [onConnectionStateChanged](class_irtcengineeventhandler.html#callback_onconnectionstatechanged) callbacks.
- The remote client: [onUserJoined](class_irtcengineeventhandler.html#callback_onuserjoined) and [onUserInfoUpdated](class_irtcengineeventhandler.html#callback_onuserinfoupdated), if the user joining the channel is in the communication profile or is a host in the live streaming profile.

Once a user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. To stop subscribing to a specified stream or all remote streams, call the corresponding mute methods.

**Note** To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the ID of the user is set to the same parameter type.

### Parameters

- token

  The token generated on your server for authentication. See [Authenticate Your Users with Token](https://docs.agora.io/en/live-streaming-4.x-preview/token_server_android_ng?platform=Windows).

- channelId

  The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported character scopes are:All lowercase English letters: a to z.All uppercase English letters: A to Z.All numeric characters: 0 to 9.Space"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "= ", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","

- userAccount

  The user account. This parameter is used to identify the user in the channel for real-time audio and video engagement. You need to set and manage user accounts yourself and ensure that each user account in the same channel is unique. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as NULL. Supported characters are (89 in total):The 26 lowercase English letters: a to z.The 26 uppercase English letters: A to Z.All numeric characters: 0 to 9.Space"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","

### Returns

- 0: Success.
- < 0: Failure.
  - -2 (ERR_INVALID_ARGUMENT): The parameter is invalid.
  - -3(ERR_NOT_READY): The SDK fails to be initialized. You can try re-initializing the SDK.
  - -5(ERR_REFUSED): The request is rejected.

**See also**

- [onLocalUserRegistered](../API/class_irtcengineeventhandler.html#callback_onlocaluserregistered)
- [onJoinChannelSuccess](../API/class_irtcengineeventhandler.html#callback_onjoinchannelsuccess)
- [onUserJoined](../API/class_irtcengineeventhandler.html#callback_onuserjoined)
- [onUserInfoUpdated](../API/class_irtcengineeventhandler.html#callback_onuserinfoupdated)

## [joinChannelWithUserAccount [2/2\]](class_irtcengine.html#api_joinchannelwithuseraccount2)

Joins the channel with a user account, and configures whether to automatically subscribe to audio or video streams after joining the channel.



```cpp
virtual int joinChannelWithUserAccount(const char* token,
    const char* channelId,
    const char* userAccount,
    const ChannelMediaOptions& options) = 0; 
```

This method allows a user to join the channel with the user account. After the user successfully joins the channel, the SDK triggers the following callbacks:

- The local client: [onLocalUserRegistered](class_irtcengineeventhandler.html#callback_onlocaluserregistered), [onJoinChannelSuccess](class_irtcengineeventhandler.html#callback_onjoinchannelsuccess) and [onConnectionStateChanged](class_irtcengineeventhandler.html#callback_onconnectionstatechanged) callbacks.
- The remote client: The [onUserJoined](class_irtcengineeventhandler.html#callback_onuserjoined) callback if the user is in the COMMUNICATION profile, and the [onUserInfoUpdated](class_irtcengineeventhandler.html#callback_onuserinfoupdated) callback if the user is a host in the LIVE_BROADCASTING profile.

Once a user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. To stop subscribing to a specified stream or all remote streams, call the corresponding mute methods.

Compared to [joinChannelWithUserAccount [1/2\]](class_irtcengine.html#api_joinchannelwithuseraccount), this method adds the **options** parameter to configure whether to automatically subscribe to all remote audio and video streams in the channel when the user joins the channel. By default, the user subscribes to the audio and video streams of all the other users in the channel, giving rise to usage and billings. To unsubscribe, set the **options** parameter or call the mute methods accordingly.

**Note** To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the ID of the user is set to the same parameter type.

### Parameters

- token

  The token generated on your server for authentication. See [Authenticate Your Users with Token](https://docs.agora.io/en/live-streaming-4.x-preview/token_server_android_ng?platform=Windows).

- channelId

  The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported character scopes are:All lowercase English letters: a to z.All uppercase English letters: A to Z.All numeric characters: 0 to 9.Space"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "= ", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","

- userAccount

  The user account. This parameter is used to identify the user in the channel for real-time audio and video engagement. You need to set and manage user accounts yourself and ensure that each user account in the same channel is unique. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as NULL. Supported characters are (89 in total):The 26 lowercase English letters: a to z.The 26 uppercase English letters: A to Z.All numeric characters: 0 to 9.Space"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","

- options

  The channel media options. See [ChannelMediaOptions](rtc_api_data_type.html#class_channelmediaoptions_ng) for details.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onLocalUserRegistered](../API/class_irtcengineeventhandler.html#callback_onlocaluserregistered)
- [onJoinChannelSuccess](../API/class_irtcengineeventhandler.html#callback_onjoinchannelsuccess)
- [onUserJoined](../API/class_irtcengineeventhandler.html#callback_onuserjoined)
- [onUserInfoUpdated](../API/class_irtcengineeventhandler.html#callback_onuserinfoupdated)

## [leaveChannel [1/2\]](class_irtcengine.html#api_leavechannel)

Leaves a channel.

```cpp
virtual int leaveChannel() = 0;
```

This method releases all resources related to the session. This method call is asynchronous. When this method returns, it does not necessarily mean that the user has left the channel.

After joining the channel, you must call this method or leaveChannel [2/2] to end the call; otherwise, you cannot join the next call.

A successful call of this method triggers the following callbacks:

- The local client: [onLeaveChannel](class_irtcengineeventhandler.html#callback_onleavechannel).
- The remote client: [onUserOffline](class_irtcengineeventhandler.html#callback_onuseroffline), if the user joining the channel is in the Communication profile, or is a host in the Live-broadcasting profile.

**Note**

- If you call [release](class_irtcengine.html#api_release) immediately after calling this method, the SDK does not trigger the onLeaveChannel callback.
- If you call this method during a CDN live streaming, the SDK automatically calls the [removePublishStreamUrl](class_irtcengine.html#api_removepublishstreamurl) method.

### Returns

- 0(ERR_OK): Success.
- < 0: Failure.
  - -1(ERR_FAILED): A general error occurs (no specified reason).
  - -2 (ERR_INVALID_ARGUMENT): The parameter is invalid.
  - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.

**See also**

- [onLeaveChannel](../API/class_irtcengineeventhandler.html#callback_onleavechannel)
- [onUserOffline](../API/class_irtcengineeventhandler.html#callback_onuseroffline)

## [leaveChannel [2/2\]](class_irtcengine.html#api_leavechannel2)

Leaves a channel.

```cpp
virtual int leaveChannel(const LeaveChannelOptions& options) = 0;
```

This method lets the user leave the channel, for example, by hanging up or exiting the call.

After joining the channel, you must call this method or [leaveChannel [1/2\]](class_irtcengine.html#api_leavechannel) to end the call, otherwise, the next call cannot be started.

No matter whether you are currently in a call or not, you can call this method without side effects. This method releases all resources related to the session.

This method call is asynchronous, and the user has not left the channel when the method call returns. After you leave the channel, the SDK triggers the [onLeaveChannel](class_irtcengineeventhandler.html#callback_onleavechannel) callback. A successful call of this method triggers the following callbacks: The local client: onLeaveChannel.The remote client: [onUserOffline](class_irtcengineeventhandler.html#callback_onuseroffline), if the user joining the channel is in the COMMUNICATION profile, or is a host in the LIVE_BROADCASTING profile.

**Note**

- If you call [release](class_irtcengine.html#api_release) immediately after calling this method, the SDK does not trigger the onLeaveChannel callback.
- If you call this method during a CDN live streaming, the SDK automatically calls the [removePublishStreamUrl](class_irtcengine.html#api_removepublishstreamurl) method.

### Parameters

- options

  The options for leaving the channel. See [LeaveChannelOptions](rtc_api_data_type.html#class_leavechanneloptions).

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onLeaveChannel](../API/class_irtcengineeventhandler.html#callback_onleavechannel)
- [onUserOffline](../API/class_irtcengineeventhandler.html#callback_onuseroffline)

## [loadExtensionProvider](class_irtcengine.html#api_loadextensionprovider)

Adds an extension to the SDK.

```cpp
virtual int loadExtensionProvider(const char* extension_lib_path) = 0;
```

### Parameters

- extension_lib_path

  The extension library path and name. For example: `/library/libagora_segmentation_extension.dll`.

### Returns

- 0: Success.
- < 0: Failure.

## [muteAllRemoteAudioStreams](class_irtcengine.html#api_muteallremoteaudiostreams)

Stops or resumes subscribing to the audio streams of all remote users.

```cpp
virtual int muteAllRemoteAudioStreams(bool mute) = 0;
```

As of v3.3.0, after successfully calling this method, the local user stops or resumes subscribing to the audio streams of all remote users, including all subsequent users.

**Note**

- Call this method after joining a channel.
- See recommended settings in[ Set the Subscribing State](https://docs.agora.io/en/live-streaming-4.x-preview/set_subscribing_state?platform=Windows).

### Parameters

- mute

  Whether to subscribe to the audio streams of all remote users:`true`: Do not subscribe to the audio streams of all remote users.`false`: (Default) Subscribe to the audio streams of all remote users by default.

### Returns

- 0: Success.
- < 0: Failure.

## [muteAllRemoteVideoStreams](class_irtcengine.html#api_muteallremotevideostreams)

Stops or resumes subscribing to the video streams of all remote users.

```cpp
virtual int muteAllRemoteVideoStreams(bool mute) = 0;
```

As of v3.3.0, after successfully calling this method, the local user stops or resumes subscribing to the video streams of all remote users, including all subsequent users.

**Note**

- Call this method after joining a channel.

### Parameters

- mute

  Whether to stop subscribing to the video streams of all remote users.`true`: Stop subscribing to the video streams of all remote users.`false`: (Default) Subscribe to the audio streams of all remote users by default.

### Returns

- 0: Success.
- < 0: Failure.

## [muteLocalAudioStream](class_irtcengine.html#api_mutelocalaudiostream)

Stops or resumes publishing the local audio stream.

```cpp
virtual int muteLocalAudioStream(bool mute) = 0;
```

**Note**

- This method does not affect any ongoing audio recording, because it does not disable the microphone.

### Parameters

- mute

  Whether to stop publishing the local audio stream.`true`: Stop publishing the local audio stream.`false`: (Default) Resumes publishing the local audio stream.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onUserMuteAudio](../API/class_irtcengineeventhandler.html#callback_onusermuteaudio)

## [muteLocalVideoStream](class_irtcengine.html#api_mutelocalvideostream)

Stops or resumes publishing the local video stream.

```cpp
virtual int muteLocalVideoStream(bool mute) = 0;
```

A successful call of this method triggers the [onUserMuteVideo](class_irtcengineeventhandler.html#callback_onusermutevideo) callback on the remote client.

**Note**

- This method executes faster than the [enableLocalVideo](class_irtcengine.html#api_enablelocalvideo)(`false`) method, which controls the sending of the local video stream.
- This method does not affect any ongoing video recording, because it does not disable the camera.

### Parameters

- mute

  Whether to stop publishing the local video stream.`true`: Stop publishing the local video stream.`false`: (Default) Publish the local video stream.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onUserMuteVideo](../API/class_irtcengineeventhandler.html#callback_onusermutevideo)

## [muteRecordingSignal](class_irtcengine.html#api_muterecordingsignal)

Whether to mute the recording signal.

```cpp
virtual int muteRecordingSignal(bool mute) = 0;
```

### Parameters

- mute

  `true`: Mute the recording signal.`false`: (Default) Unmute the recording signal.

### Returns

- 0: Success.
- < 0: Failure.

## [muteRemoteAudioStream](class_irtcengine.html#api_muteremoteaudiostream)

Stops or resumes subscribing to the audio stream of a specified user.

```cpp
virtual int muteRemoteAudioStream(uid_t uid, bool mute) = 0;
```

**Note**

- Call this method after joining a channel.
- See recommended settings in Set the Subscribing State.

### Parameters

- uid

  The user ID of the specified user.

- mute

  Whether to stop subscribing to the audio stream of the specified user.`true`: Stop subscribing to the audio stream of the specified user.`false`: (Default) Subscribe to the audio stream of the specified user.

### Returns

- 0: Success.
- < 0: Failure.

## [muteRemoteVideoStream](class_irtcengine.html#api_muteremotevideostream)

Stops or resumes subscribing to the video stream of a specified user.

```cpp
virtual int muteRemoteVideoStream(uid_t userId, bool mute) = 0;
```

**Note**

- Call this method after joining a channel.
- See recommended settings in Set the Subscribing State.

### Parameters

- mute

  Whether to stop subscribing to the video stream of the specified user.`true`: Stop subscribing to the video streams of the specified user.`false`: (Default) Subscribe to the video stream of the specified user.

### Returns

- 0: Success.
- < 0: Failure.

## [pauseAllChannelMediaRelay](class_irtcengine.html#api_pauseallchannelmediarelay)

Pauses the media stream relay to all destination channels.

```cpp
virtual int pauseAllChannelMediaRelay() = 0;
```

After the cross-channel media stream relay starts, you can call this method to pause relaying media streams to all destination channels; after the pause, if you want to resume the relay, call [resumeAllChannelMediaRelay](class_irtcengine.html#api_resumeallchannelmediarelay).

After a successful method call, the SDK triggers the [onChannelMediaRelayEvent](class_irtcengineeventhandler.html#callback_onchannelmediarelayevent) callback to report whether the media stream relay is successfully paused.

**Note** Call this method after [startChannelMediaRelay](class_irtcengine.html#api_startchannelmediarelay).

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onChannelMediaRelayEvent](../API/class_irtcengineeventhandler.html#callback_onchannelmediarelayevent)

## [pauseAllEffects](class_irtcengine.html#api_pausealleffects)

Pauses all audio effects.

```cpp
virtual int pauseAllEffects() = 0;
```

### Returns

- 0: Success.
- < 0: Failure.

## [pauseAudioMixing](class_irtcengine.html#api_pauseaudiomixing)

Pauses playing and mixing the music file.

```cpp
virtual int pauseAudioMixing() = 0;
```

Call this method when you are in a channel.

### Returns

- 0: Success.
- < 0: Failure.

## [pauseEffect](class_irtcengine.html#api_pauseeffect)

Pauses a specified audio effect.

```cpp
virtual int pauseEffect(int soundId) = 0;
```

### Parameters

- soundId

  The audio effect ID. The ID of each audio effect file is unique.

### Returns

- 0: Success.
- < 0: Failure.

## [playAllEffects](class_irtcengine.html#api_playalleffects)

Plays all audio effects.

```cpp
virtual int playAllEffects(int loopCount, double pitch, double pan, int gain, bool publish = false) = 0;
```

After calling [preloadEffect](class_irtcengine.html#api_preloadeffect) multiple times to preload multiple audio effects into the memory, you can call this method to play all the specified audio effects for all users in the channel.

### Parameters

- loopCount

  The number of times the audio effect loops:-1: Play the audio effect in an indefinite loop until you call [stopEffect](class_irtcengine.html#api_stopeffect) or [stopAllEffects](class_irtcengine.html#api_stopalleffects).0: Play the audio effect once.1: Play the audio effect twice.

- pitch

  The pitch of the audio effect. The value ranges between 0.5 and 2.0. The default value is 1.0 (original pitch). The lower the value, the lower the pitch.

- pan

  The spatial position of the audio effect. The value ranges between -1.0 and 1.0:-1.0: The audio effect shows on the left.0: The audio effect shows ahead.1.0: The audio effect shows on the right.

- gain

  The volume of the audio effect. The value ranges from 0 to 100. The default value is 100 (original volume). The smaller the value, the less the gain.

- publish

  Whether to publish the audio effect to the remote users:`true`: Publish the audio effect to the remote users. Both the local user and remote users can hear the audio effect.`false`: Do not publish the audio effect to the remote users. Only the local user can hear the audio effect.

### Returns

- 0: Success.
- < 0: Failure.

## [playEffect](class_irtcengine.html#api_playeffect3)

Plays the specified local or online audio effect file.

```cpp
virtual int playEffect(int soundId,
    const char* filePath,
    int loopCount,
    double pitch,
    double pan,
    int gain,
    bool publish,
    int startPos) = 0;
```

To play multiple audio effect files at the same time, call this method multiple times with different **soundId** and **filePath**. For the best user experience, Agora recommends playing no more than three audio effect files at the same time. After the playback of an audio effect file completes, the SDK triggers the onAudioEffectFinished callback.

**Note** Call this method after joining a channel.

### Parameters

- soundId

  The audio effect ID. The ID of each audio effect file is unique.**Note** If you have preloaded an audio effect into memory by calling [preloadEffect](class_irtcengine.html#api_preloadeffect), ensure that this parameter is set to the same value as **soundId** in preloadEffect.

- filePath

  The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: `C:\music\audio.mp4`. Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. See [supported audio formats](https://docs.microsoft.com/en-us/windows/win32/medfound/supported-media-formats-in-media-foundation).**Note** If you have preloaded an audio effect into memory by calling [preloadEffect](class_irtcengine.html#api_preloadeffect), ensure that this parameter is set to the same value as **filePath** in preloadEffect.

- loopCount

  The number of times the audio effect loops:≥ 0: The number of playback times. For example, 1 means loop one time, which means play the audio effect two times in total.-1: Play the music effect in an infinite loop.

- pitch

  The pitch of the audio effect. The value range is 0.5 to 2.0. The default value is 1.0, which means the original pitch. The lower the value, the lower the pitch.

- pan

  The spatial position of the audio effect. The value range is 1 to10000.-1.0: The audio effect displays to the left.0.0: The audio effect displays ahead.1.0: The audio effect displays to the right.

- gain

  The volume of the audio effect. The value range is 1 to10000. The default value is 100.0, which means the original volume. The smaller the value, the lower the volume.

- publish

  Whether to publish the audio effect to the remote users.`true`: Publish the audio effect to the remote users. Both the local user and remote users can hear the audio effect.`false`: Do not publish the audio effect to the remote users. Only the local user can hear the audio effect.

- startPos

  The playback position (ms) of the audio effect file.

### Returns

- 0: Success.
- < 0: Failure.

## [preloadEffect](class_irtcengine.html#api_preloadeffect)

Preloads a specified audio effect file into the memory.

```cpp
virtual int preloadEffect(int soundId, const char* filePath) = 0;
```

To ensure smooth communication, limit the size of the audio effect file. We recommend using this method to preload the audio effect before calling joinChannel [2/2].

**Note**

- This method does not support online audio effect files.
- For the audio file formats supported by this method, see [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).

### Parameters

- soundId

  The audio effect ID. The ID of each audio effect file is unique.

- filePath

  File path:Android: The file path, which needs to be accurate to the file name and suffix. Agora supports using a URI address, an absolute path, or a path that starts with /assets/. You might encounter permission issues if you use an absolute path to access a local file, so Agora recommends using a URI address instead. For example: content://com.android.providers.media.documents/document/audio%203A14441Windows: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: C:\music\audio.mp4.

### Returns

- 0: Success.
- < 0: Failure.

## [queryInterface](class_irtcengine.html#api_queryinterface)

Gets the pointer to the specified interface.

```cpp
virtual int queryInterface(INTERFACE_ID_TYPE iid, void** inter) = 0;
```

### Parameters

- iid

  The ID of the interface. See [INTERFACE_ID_TYPE](rtc_api_data_type.html#enum_interfaceidtype) for details.

- inter

  Output parameter. The pointer to the specified interface.

### Returns

- 0: Success.
- < 0: Failure.

## [rate](class_irtcengine.html#api_rate)

Allows a user to rate a call after the call ends.

```cpp
virtual int rate(const char* callId, 
     int rating, 
     const char* description) = 0;
```

**Note** Ensure that you call this method after leaving a channel.

### Parameters

- callId

  The current call ID. You can get the call ID by calling [getCallId](class_irtcengine.html#api_getcallid).

- rating

  The rating of the call. The value is between 1 (lowest score) and 5 (highest score). If you set a value out of this range, the SDK returns the -2 (`ERR_INVALID_ARGUMENT`) error.

- description

  (Optional) A description of the call. The string length should be less than 800 bytes.

### Returns

- 0: Success.
- < 0: Failure.
  - -2 (`ERR_INVALID_ARGUMENT`).
  - -3 (`ERR_NOT_READY`)。

## [registerAudioEncodedFrameObserver](class_irtcengine.html#api_registeraudioencodedframeobserver)

Registers an encoded audio observer.

```cpp
virtual int registerAudioEncodedFrameObserver(const AudioEncodedFrameObserverConfig& config,  IAudioEncodedFrameObserver *observer) = 0;
```

**Note**

- Call this method after joining a channel.
- This method and [startAudioRecording](class_irtcengine.html#api_startaudiorecording3_ng) both set the audio content and audio quality. Agora recommends not using this method and startAudioRecording together; otherwise, only the method called later will take effect.

### Parameters

- config

  Observer settings for the encoded audio. For details, see [AudioEncodedFrameObserverConfig](rtc_api_data_type.html#class_audioencodedframeobserverconfig).

- observer

  The encoded audio observer. For details, see [IAudioEncodedFrameObserver](class_iaudioencodedframeobserver.html#class_iaudioencodedframeobserver).

### Returns

- 0: Success.
- < 0: Failure.

## [registerAudioSpectrumObserver](class_irtcengine.html#api_registeraudiospectrumobserver)

Register an audio spectrum observer.

```cpp
virtual int registerAudioSpectrumObserver(agora::media::IAudioSpectrumObserver * observer) = 0;
```

After successfully registering the audio spectrum observer and calling [enableAudioSpectrumMonitor](class_irtcengine.html#api_enableaudiospectrummonitor) to enable the audio spectrum monitoring, the SDK reports the callback that you implement in the [IAudioSpectrumObserver](class_iaudiospectrumobserver.html#class_iaudiospectrumobserver) class at the time interval you set.

**Note** You can call this method either before or after joining a channel.

### Parameters

- observer

  The Audio spectrum observer. For details, see [IAudioSpectrumObserver](class_iaudiospectrumobserver.html#class_iaudiospectrumobserver).

### Returns

- 0: Success.
- < 0: Failure.

## [registerLocalUserAccount](class_irtcengine.html#api_registerlocaluseraccount)

Registers a user account.



```cpp
virtual int registerLocalUserAccount(const char* appId, const char* userAccount) = 0;
```

Once registered, the user account can be used to identify the local user when the user joins the channel. After the registration is successful, the user account can identify the identity of the local user, and the user can use it to join the channel.

After the user successfully registers a user account, the SDK triggers the [onLocalUserRegistered](class_irtcengineeventhandler.html#callback_onlocaluserregistered) callback on the local client, reporting the user ID and user account of the local user.

This method is optional. To join a channel with a user account, you can choose either of the following ways:

- Call registerLocalUserAccount to to create a user account, and then call [joinChannelWithUserAccount [2/2\]](class_irtcengine.html#api_joinchannelwithuseraccount2) to join the channel.
- Call the joinChannelWithUserAccount [2/2] method to join the channel.

The difference between the two ways is that the time elapsed between calling the registerLocalUserAccount method and joining the channel is shorter than directly calling joinChannelWithUserAccount [2/2].

**Note**

- Ensure that you set the **userAccount** parameter; otherwise, this method does not take effect.
- Ensure that the **userAccount** is unique in the channel.
- To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the ID of the user is set to the same parameter type.

### Parameters

- appId

  The App ID of your project on Agora Console.

- userAccount

  The user account. This parameter is used to identify the user in the channel for real-time audio and video engagement. You need to set and manage user accounts yourself and ensure that each user account in the same channel is unique. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as NULL. Supported characters are (89 in total):The 26 lowercase English letters: a to z.The 26 uppercase English letters: A to Z.All numeric characters: 0 to 9.Space"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onLocalUserRegistered](../API/class_irtcengineeventhandler.html#callback_onlocaluserregistered)

## [registerMediaMetadataObserver](class_irtcengine.html#api_registermediametadataobserver)

Registers the metadata observer.

```cpp
virtual int registerMediaMetadataObserver(IMetadataObserver *observer, IMetadataObserver::METADATA_TYPE type) = 0;
```

You need to implement the [IMetadataObserver](class_imetadataobserver.html#class_imetadataobserver) class and specify the metadata type in this method. This method enables you to add synchronized metadata in the video stream for more diversified live interactive streaming, such as sending shopping links, digital coupons, and online quizzes.

A successful call of this method triggers the [getMaxMetadataSize](class_imetadataobserver.html#callback_imetadataobserver_getmaxmetadatasize) callback.

**Note**

- Call this method before joinChannel [2/2].
- This method applies only to interactive live streaming.

### Parameters

- observer

  The metadata observer. See [IMetadataObserver](class_imetadataobserver.html#class_imetadataobserver).

- type

  The metadata type. The SDK currently only supports VIDEO_METADATA. See [METADATA_TYPE](class_imetadataobserver.html#enum_metadatatype).

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [getMaxMetadataSize](../API/class_imetadataobserver.html#callback_imetadataobserver_getmaxmetadatasize)

## [registerPacketObserver](class_irtcengine.html#api_registerpacketobserver)

Registers a packet observer.

```cpp
virtual int registerPacketObserver(IPacketObserver* observer) = 0;
```

Call this method registers a packet observer. When the Agora SDK triggers callbacks registered by [IPacketObserver](class_ipacketobserver.html#class_ipacketobserver) for voice or video packet transmission, you can call this method to process the packets, such as encryption and decryption.

**Note**

- The size of the packet sent to the network after processing should not exceed 1200 bytes, otherwise, the SDK may fail to send the packet.
- Ensure that both receivers and senders call this method, otherwise, you may meet undefined behaviors such as no voice and black screen.
- When you use CDN live streaming, recording, or storage functions, Agora doesn't recommend calling this method.
- Call this method before joining a channel.

### Parameters

- observer

  [IPacketObserver](class_ipacketobserver.html#class_ipacketobserver) .

### Returns

- 0: Success.
- < 0: Failure.

## [release](class_irtcengine.html#api_release)

Releases the IRtcEngine instance.

```cpp
virtual void release(bool sync = false) = 0;
```



This method releases all resources used by the Agora SDK. Use this method for apps in which users occasionally make voice or video calls. When users do not make calls, you can free up resources for other operations.

After a successful method call, you can no longer use any method or callback in the SDK anymore. If you want to use the real-time communication functions again, you must call [createAgoraRtcEngine](class_irtcengine.html#api_createagorartcengine) and [initialize](class_irtcengine.html#api_create2) to create a new IRtcEngine instance.

**Note** If you want to create a new IRtcEngine instance after destroying the current one, ensure that you wait till the release method execution to complete.

### Parameters

- sync

  `true`: Synchronous call. Agora suggests calling this method in a sub-thread to avoid congestion in the main thread because the synchronous call and the app cannot move on to another task until the resources used by IRtcEngine are released. Besides, you cannot call release in any method or callback of the SDK. Otherwise, the SDK cannot release the resources until the callbacks return results, which may result in a deadlock. The SDK automatically detects the deadlock and converts this method into an asynchronous call, causing the test to take additional time.`false`: Asynchronous call. The app can move on to another task, no matter the resources used by IRtcEngine are released or not. Do not immediately uninstall the SDK's dynamic library after the call; otherwise, it may cause a crash due to the SDK clean-up thread not quitting.

## [removePublishStreamUrl](class_irtcengine.html#api_removepublishstreamurl)

Removes an RTMP or RTMPS stream from the CDN.

```cpp
virtual int removePublishStreamUrl(const char *url) = 0;
```

After a successful method call, the SDK triggers [onRtmpStreamingStateChanged](class_irtcengineeventhandler.html#callback_onrtmpstreamingstatechanged) on the local client to report the result of deleting the address.

**Note**

- Ensure that you enable the RTMP Converter service before using this function.
- This method takes effect only when you are a host in live interactive streaming.
- Call this method after joining a channel.
- This method removes only one CDN streaming URL each time it is called. To remove multiple URLs, call this method multiple times.

### Parameters

- url

  The CDN streaming URL to be removed. The maximum length of this parameter is 1024 bytes. The CDN streaming URL must not contain special characters, such as Chinese characters.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onRtmpStreamingStateChanged](../API/class_irtcengineeventhandler.html#callback_onrtmpstreamingstatechanged)

## [renewToken](class_irtcengine.html#api_renewtoken)

Gets a new token when the current token expires after a period of time.

```cpp
virtual int renewToken(const char* token) = 0;
```

Passes a new token to the SDK. A token expires after a certain period of time. In the following two cases, the app should call this method to pass in a new token. Failure to do so will result in the SDK disconnecting from the server.

- The SDK triggers the [onTokenPrivilegeWillExpire](class_irtcengineeventhandler.html#callback_ontokenprivilegewillexpire) callback.
- The [onConnectionStateChanged](class_irtcengineeventhandler.html#callback_onconnectionstatechanged) callback reports CONNECTION_CHANGED_TOKEN_EXPIRED(9).

### Parameters

- token

  The new token.

### Returns

- 0(ERR_OK): Success.
- < 0: Failure.
  - -1(ERR_FAILED): A general error occurs (no specified reason).
  - -2 (ERR_INVALID_ARGUMENT): The parameter is invalid.
  - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.

**See also**

- [onTokenPrivilegeWillExpire](../API/class_irtcengineeventhandler.html#callback_ontokenprivilegewillexpire)
- [onConnectionStateChanged](../API/class_irtcengineeventhandler.html#callback_onconnectionstatechanged)

## [resumeAllChannelMediaRelay](class_irtcengine.html#api_resumeallchannelmediarelay)

Resumes the media stream relay to all destination channels.

```cpp
virtual int resumeAllChannelMediaRelay() = 0;
```

After calling the [pauseAllChannelMediaRelay](class_irtcengine.html#api_pauseallchannelmediarelay) method, you can call this method to resume relaying media streams to all destination channels.

After a successful method call, the SDK triggers the [onChannelMediaRelayEvent](class_irtcengineeventhandler.html#callback_onchannelmediarelayevent) callback to report whether the media stream relay is successfully resumed.

**Note** Call this method after the [pauseAllChannelMediaRelay](class_irtcengine.html#api_pauseallchannelmediarelay) method.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onChannelMediaRelayEvent](../API/class_irtcengineeventhandler.html#callback_onchannelmediarelayevent)

## [resumeAllEffects](class_irtcengine.html#api_resumealleffects)

Resumes playing all audio effects.

```cpp
virtual int resumeAllEffects() = 0;
```

### Returns

- 0: Success.
- < 0: Failure.

## [resumeAudioMixing](class_irtcengine.html#api_resumeaudiomixing)

Resumes playing and mixing the music file.

```cpp
virtual int resumeAudioMixing() = 0;
```

This method resumes playing and mixing the music file. Call this method when you are in a channel.

### Returns

- 0: Success.
- < 0: Failure.

## [resumeEffect](class_irtcengine.html#api_resumeeffect)

Resumes playing a specified audio effect.

```cpp
virtual int resumeEffect(int soundId) = 0;
```

### Parameters

- soundId

  The audio effect ID. The ID of each audio effect file is unique.

### Returns

- 0: Success.
- < 0: Failure.

## [sendCustomReportMessage](class_irtcengine.html#api_sendcustomreportmessage)

Reports customized messages.

```cpp
virtual int sendCustomReportMessage(const char *id,
    const char* category,
    const char* event,
    const char* label,
    int value) = 0;
```

Agora supports reporting and analyzing customized messages. This function is in the beta stage with a free trial. The ability provided in its beta test version is reporting a maximum of 10 message pieces within 6 seconds, with each message piece not exceeding 256 bytes and each string not exceeding 100 bytes. To try out this function, contact [support@agora.io](mailto:support@agora.io) and discuss the format of customized messages with us.

## [sendStreamMessage](class_irtcengine.html#api_sendstreammessage)

Sends data stream messages.

```cpp
virtual int sendStreamMessage(int streamId, 
     const char* data, 
     size_t length) = 0;
```

Sends data stream messages to all users in a channel. The SDK has the following restrictions on this method:

- Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 KB.
- Each client can send up to 6 KB of data per second.
- Each user can have up to five data streams simultaneously.

A successful method call triggers the [onStreamMessage](class_irtcengineeventhandler.html#callback_onstreammessage) callback on the remote client, from which the remote user gets the stream message. A failed method call triggers the [onStreamMessageError](class_irtcengineeventhandler.html#callback_onstreammessageerror) callback on the remote client.

**Note**

- Ensure that you call [createDataStream [2/2\]](class_irtcengine.html#api_createdatastream2) to create a data channel before calling this method.
- In live streaming scenarios, this method only applies to hosts.

### Parameters

- streamId

  The data stream ID. You can get the data stream ID by calling createDataStream [2/2].

- data

  The message to be sent.

- length

  The length of the data.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onStreamMessage](../API/class_irtcengineeventhandler.html#callback_onstreammessage)
- [onStreamMessageError](../API/class_irtcengineeventhandler.html#callback_onstreammessageerror)

## [setAudioEffectParameters](class_irtcengine.html#api_setaudioeffectparameters)

Sets parameters for SDK preset audio effects.

```cpp
virtual int setAudioEffectParameters(AUDIO_EFFECT_PRESET preset, int param1, int param2) = 0;
```

### Detailed Description

Call this method to set the following parameters for the local user who sends an audio stream:

- 3D voice effect: Sets the cycle period of the 3D voice effect.
- Pitch correction effect: Sets the basic mode and tonic pitch of the pitch correction effect. Different songs have different modes and tonic pitches. Agora recommends bounding this method with interface elements to enable users to adjust the pitch correction interactively.

After setting the audio parameters, all users in the channel can hear the effect.

**Note**

- You can call this method either before or after joining a channel.

- To get better audio effect quality, Agora recommends calling and setting **scenario** in [setAudioProfile [1/2\]](class_irtcengine.html#api_setaudioprofile) as AUDIO_SCENARIO_GAME_STREAMING(3) before calling this method.

- Do not set the **profile** parameter in setAudioProfile [1/2] to AUDIO_PROFILE_SPEECH_STANDARD (1) or AUDIO_PROFILE_IOT(6), or the method does not take effect.

- This method works best with the human voice. Agora does not recommend using this method for audio containing music.

- After calling

   

  setAudioEffectParameters

  , Agora recommends not calling the following methods, or the settings in

   

  setAudioEffectParameters

   

  are overridden :

  - [setAudioEffectPreset](class_irtcengine.html#api_setaudioeffectpreset)
  - [setVoiceBeautifierPreset](class_irtcengine.html#api_setvoicebeautifierpreset)
  - [setLocalVoiceReverbPreset](class_irtcengine.html#api_setlocalvoicereverbpreset)
  - [setLocalVoiceChanger](class_irtcengine.html#api_setlocalvoicechanger)
  - [setLocalVoicePitch](class_irtcengine.html#api_setlocalvoicepitch)
  - [setLocalVoiceEqualization](class_irtcengine.html#api_setlocalvoiceequalization)
  - [setLocalVoiceReverb](class_irtcengine.html#api_setlocalvoicereverb)
  - [setVoiceBeautifierParameters](class_irtcengine.html#api_setvoicebeautifierparameters)
  - [setVoiceConversionPreset](class_irtcengine.html#api_setvoiceconversionpreset)

### Parameters

- preset

  The options for SDK preset audio effects:ROOM_ACOUSTICS_3D_VOICE, 3D voice effect:Call and set the **profile** parameter in setAudioProfile [1/2] to AUDIO_PROFILE_MUSIC_STANDARD_STEREO (3) or AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5) before setting this enumerator; otherwise, the enumerator setting does not take effect.If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear the anticipated voice effect.PITCH_CORRECTION, Pitch correction effect: To achieve better audio effect quality, Agora recommends calling setAudioProfile [1/2] and setting the **profile** parameter to AUDIO_PROFILE_MUSIC_HIGH_QUALITY (4) or AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5) before setting this enumerator.

- param1

  If you set **preset** to ROOM_ACOUSTICS_3D_VOICE , **param1** sets the cycle period of the 3D voice effect. The value range is [1,60] and the unit is seconds. The default value is 10, indicating that the voice moves around you every 10 seconds.If you set **preset** to PITCH_CORRECTION , **param1** sets the basic mode of the pitch correction effect:`1`: (Default) Natural major scale.`2`: Natural minor scale.`3`: Japanese pentatonic scale.

- param2

  If you set **preset** to ROOM_ACOUSTICS_3D_VOICE, you need to set **param2** to `0`.If you set **preset** to PITCH_CORRECTION, **param2** sets the tonic pitch of the pitch correction effect:`1`: A`2`: A#`3`: B`4`: (Default) C`5`: C#`6`: D`7`: D#`8`: E`9`: F`10`: F#`11`: G`12`: G#

### Returns

- 0: Success.
- < 0: Failure.

## [setAudioEffectPreset](class_irtcengine.html#api_setaudioeffectpreset)

Sets an SDK preset audio effect.

```cpp
virtual int setAudioEffectPreset(AUDIO_EFFECT_PRESET preset) = 0;
```

### Detailed Description

Call this method to set an SDK preset audio effect for the local user who sends an audio stream. This audio effect does not change the gender characteristics of the original voice. After setting an audio effect, all users in the channel can hear the effect.

To get better audio effect quality, Agora recommends calling [setAudioProfile [1/2\]](class_irtcengine.html#api_setaudioprofile) and setting the **scenario** parameter as AUDIO_SCENARIO_GAME_STREAMING (3) before calling this method.

**Note**

- You can call this method either before or after joining a channel.

- Do not set the **profile** parameter in setAudioProfile [1/2] to AUDIO_PROFILE_SPEECH_STANDARD (1) or AUDIO_PROFILE_IOT(6), or the method does not take effect.

- Do not set the **profile** parameter in setAudioProfile [1/2] to AUDIO_PROFILE_SPEECH_STANDARD (1), or the method does not take effect.

- This method works best with the human voice. Agora does not recommend using this method for audio containing music.

- If you call setAudioEffectPreset and set enumerators except for ROOM_ACOUSTICS_3D_VOICE or PITCH_CORRECTION, do not call [setAudioEffectParameters](class_irtcengine.html#api_setaudioeffectparameters); otherwise, setAudioEffectPreset is overridden.

- After calling

   

  setAudioEffectPreset

  , Agora recommends not calling the following methods, because they can override

   

  setAudioEffectPreset

  :

  - [setVoiceBeautifierPreset](class_irtcengine.html#api_setvoicebeautifierpreset)
  - [setLocalVoiceReverbPreset](class_irtcengine.html#api_setlocalvoicereverbpreset)
  - [setLocalVoiceChanger](class_irtcengine.html#api_setlocalvoicechanger)
  - [setLocalVoicePitch](class_irtcengine.html#api_setlocalvoicepitch)
  - [setLocalVoiceEqualization](class_irtcengine.html#api_setlocalvoiceequalization)
  - [setLocalVoiceReverb](class_irtcengine.html#api_setlocalvoicereverb)
  - [setVoiceBeautifierParameters](class_irtcengine.html#api_setvoicebeautifierparameters)
  - [setVoiceConversionPreset](class_irtcengine.html#api_setvoiceconversionpreset)

### Parameters

- preset

  The options for SDK preset audio effects. See [AUDIO_EFFECT_PRESET](rtc_api_data_type.html#enum_audioeffectpreset).

### Returns

- 0: Success.
- < 0: Failure.

## [setAudioMixingPosition](class_irtcengine.html#api_setaudiomixingposition)

Sets the audio mixing position.

```cpp
virtual int setAudioMixingPosition(int pos /*in ms*/) = 0;
```

Call this method to set the playback position of the music file to a different starting position (the default plays from the beginning).

**Note** You need to call this method after calling startAudioMixing [2/2] and receiving the onAudioMixingStateChanged(`PLAY`) callback.

### Parameters

- pos

  Integer. The playback position (ms).

### Returns

- 0: Success.
- < 0: Failure.

## [setAudioProfile [1/2\]](class_irtcengine.html#api_setaudioprofile)

Sets the audio profile and audio scenario.

```cpp
virtual int setAudioProfile(AUDIO_PROFILE_TYPE profile, AUDIO_SCENARIO_TYPE scenario) = 0;
```

**Note**

- You can call this method either before or after joining a channel.
- In scenarios requiring high-quality audio, such as online music tutoring, Agora recommends you set **profile** as AUDIO_PROFILE_MUSIC_HIGH_QUALITY (4), and **scenario** as AUDIO_SCENARIO_GAME_STREAMING (3) or AUDIO_SCENARIO_HIGH_DEFINITION(6).

### Parameters

- profile

  The audio profile, including the sampling rate, bitrate, encoding mode, and the number of channels. See [AUDIO_PROFILE_TYPE](rtc_api_data_type.html#enum_audioprofiletype).

- scenario

  The audio scenario. See [AUDIO_SCENARIO_TYPE](rtc_api_data_type.html#enum_audioscenariotype_ng). Under different audio scenarios, the device uses different volume types.

### Returns

- 0: Success.
- < 0: Failure.

## [setAudioProfile [2/2\]](class_irtcengine.html#api_setaudioprofile2)

Sets the audio parameters and application scenarios.

```cpp
virtual int setAudioProfile(AUDIO_PROFILE_TYPE profile) = 0;
```

**Note**

- You can call this method either before or after joining a channel.
- In scenarios requiring high-quality audio, such as online music tutoring, Agora recommends you set `profile` as `AUDIO_PROFILE_MUSIC_HIGH_QUALITY (4)`.
- If you want to set the audio scenario, call [initialize](class_irtcengine.html#api_create2) and set **audioScenario** in the [RtcEngineContext](rtc_api_data_type.html#class_rtcengineconfig_ng) struct.

### Parameters

- profile

  The audio profile, including the sampling rate, bitrate, encoding mode, and the number of channels. See [AUDIO_PROFILE_TYPE](rtc_api_data_type.html#enum_audioprofiletype).

### Returns

- 0: Success.
- < 0: Failure.

## [setBeautyEffectOptions](class_irtcengine.html#api_setbeautyeffectoptions)

Sets the image enhancement options.

```cpp
virtual int setBeautyEffectOptions(bool enabled, BeautyOptions options) = 0;
```

Enables or disables image enhancement, and sets the options.

Enabling the image enhancement function involves a series of method calls. The calling sequence is as follows:

1. Call `loadExtensionProvider(libagora_video_process_extension.dll)` during [IRtcEngine](class_irtcengine.html#class_irtcengine) initialization to specify the extension's library path.
2. Call `enableExtension(agora, beauty, true)` to enable the extension.
3. Call [enableVideo](class_irtcengine.html#api_enablevideo) to enable the video module.
4. Call this method to enable the image enhancement function.

### Parameters

- enabled

  Whether to enable the image enhancement function:`true`: Enable the image enhancement function.`false`: (Default) Disable the image enhancement function.

- options

  The image enhancement options. See [BeautyOptions](rtc_api_data_type.html#class_beautyoptions).

### Returns

- 0: Success.
- < 0: Failure.

## [setCameraAutoFocusFaceModeEnabled](class_irtcengine.html#api_setcameraautofocusfacemodeenabled)

Enables the camera auto-face focus function.

```cpp
virtual int setCameraAutoFocusFaceModeEnabled(bool enabled) = 0;
```

**Note**

- This method is for Android and iOS only.
- Call this method before calling [joinChannel [2/2\]](class_irtcengine.html#api_joinchannel2_ng), [enableVideo](class_irtcengine.html#api_enablevideo), or [enableLocalVideo](class_irtcengine.html#api_enablelocalvideo), depending on which method you use to turn on your local camera.

### Parameters

- enabled

  Whether to enable the camera auto-face focus function:`true`: Enable the camera auto-face focus function.`false`: (Default) Disable the camera auto-face focus function.

### Returns

- 0: Success.
- < 0: Failure.

## [setCameraCapturerConfiguration](class_irtcengine.html#api_setcameracapturerconfiguration)

Sets the camera capture configuration.

```cpp
virtual int setCameraCapturerConfiguration(const CameraCapturerConfiguration& config) = 0;
```

**Note**

- This method is for Android and iOS only.
- Call this method before calling [joinChannel [2/2\]](class_irtcengine.html#api_joinchannel2_ng), [enableVideo](class_irtcengine.html#api_enablevideo), or [enableLocalVideo](class_irtcengine.html#api_enablelocalvideo), depending on which method you use to turn on your local camera.

### Parameters

- config

  The camera capturer configuration. See [CameraCapturerConfiguration](rtc_api_data_type.html#class_cameracapturerconfiguration_ng).

### Returns

- 0: Success.
- < 0: Failure.

## [setCameraDeviceOrientation](class_irtcengine.html#api_setcameradeviceorientation)

Sets the rotation angle of the captured video.

```cpp
virtual int setCameraDeviceOrientation(VIDEO_SOURCE_TYPE type, VIDEO_ORIENTATION orientation) = 0;
```

When the video capture device does not have the gravity sensing function, you can call this method to manually adjust the rotation angle of the captured video.

### Parameters

- type

  The video source type. See [VIDEO_SOURCE_TYPE](rtc_api_data_type.html#enum_videosourcetype).

- orientation

  The clockwise rotation angle. See [VIDEO_ORIENTATION](rtc_api_data_type.html#enum_videoorientation).

### Returns

- 0: Success.
- < 0: Failure.

## [setCameraExposurePosition](class_irtcengine.html#api_setcameraexposureposition)

Sets the camera exposure position.

```cpp
virtual int setCameraExposurePosition(float positionXinView, float positionYinView) = 0;
```

This method needs to be called after the camera is started (for example, by calling [startPreview](class_irtcengine.html#api_startpreview) or [joinChannel [2/2\]](class_irtcengine.html#api_joinchannel2_ng)).

After a successful method call, the SDK triggers the [onCameraExposureAreaChanged](class_irtcengineeventhandler.html#callback_oncameraexposureareachanged) callback.

**Note** This method is for Android and iOS only.

### Parameters

- positionXinView

  The horizontal coordinate of the touchpoint in the view.

- positionYinView

  The vertical coordinate of the touchpoint in the view.

### Returns

- 0: Success.
- < 0: Failure.

## [setCameraFocusPositionInPreview](class_irtcengine.html#api_setcamerafocuspositioninpreview)

Sets the camera manual focus position.

```cpp
virtual int setCameraFocusPositionInPreview(float positionX, float positionY) = 0;
```

This method needs to be called after the camera is started (for example, by calling [startPreview](class_irtcengine.html#api_startpreview) or [joinChannel [2/2\]](class_irtcengine.html#api_joinchannel2_ng)). After a successful method call, the SDK triggers the [onCameraFocusAreaChanged](class_irtcengineeventhandler.html#callback_oncamerafocusareachanged) callback.

**Note** This method is for Android and iOS only.

### Parameters

- positionX

  The horizontal coordinate of the touchpoint in the view.

- positionY

  The vertical coordinate of the touchpoint in the view.

### Returns

- 0: Success.
- < 0: Failure.

## [setCameraTorchOn](class_irtcengine.html#api_setcameratorchon)

Enables the camera flash.

```cpp
virtual int setCameraTorchOn(bool isOn) = 0;
```

**Note**

- This method is for Android and iOS only.
- Call this method before calling [joinChannel [2/2\]](class_irtcengine.html#api_joinchannel2_ng), [enableVideo](class_irtcengine.html#api_enablevideo), or [enableLocalVideo](class_irtcengine.html#api_enablelocalvideo), depending on which method you use to turn on your local camera.

### Parameters

- isOn

  Whether to turn on the camera flash:`true`: Turn on the flash.`false`: (Default) Turn off the flash.

### Returns

- 0: Success.
- < 0: Failure.

## [setCameraZoomFactor](class_irtcengine.html#api_setcamerazoomfactor)

Sets the camera zoom ratio.

```cpp
virtual int setCameraZoomFactor(float factor) = 0;
```

**Note**

- This method is for Android and iOS only.
- Call this method before calling [joinChannel [2/2\]](class_irtcengine.html#api_joinchannel2_ng), [enableVideo](class_irtcengine.html#api_enablevideo), or [enableLocalVideo](class_irtcengine.html#api_enablelocalvideo), depending on which method you use to turn on your local camera.

### Parameters



### Returns

- The camera zoom **factor** value, if successful.
- < 0: if the method if failed.

## [setChannelProfile](class_irtcengine.html#api_setchannelprofile)

Sets the channel profile.

```cpp
virtual int setChannelProfile(CHANNEL_PROFILE_TYPE profile) = 0;
```

Sets the profile of the Agora channel. The Agora SDK differentiates channel profiles and applies optimization algorithms accordingly. For example, it prioritizes smoothness and low latency for a video call and prioritizes video quality for interactive live video streaming.

**Note**

- To ensure the quality of real-time communication, Agora recommends that all users in a channel use the same channel profile.
- This method must be called and set before joinChannel [2/2], and cannot be set again after entering the channel.
- The default audio route and video encoding bitrate are different in different channel profiles. For details, see [setDefaultAudioRouteToSpeakerphone](class_irtcengine.html#api_setdefaultaudioroutetospeakerphone_ng) and [setVideoEncoderConfiguration](class_irtcengine.html#api_setvideoencoderconfiguration).

### Parameters

- profile

  The channel profile. For details, see [CHANNEL_PROFILE_TYPE](rtc_api_data_type.html#enum_channelprofiletype_ng).

### Returns

- 0(ERR_OK): Success.
- < 0: Failure.
  - -2(ERR_INVALID_ARGUMENT): The parameter is invalid.
  - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.

## [setClientRole [1/2\]](class_irtcengine.html#api_setclientrole)

Sets the client role.

```cpp
virtual int setClientRole(CLIENT_ROLE_TYPE role) = 0;
```

You can call this method either before or after joining the channel to set the user role as audience or host.

If you call this method to switch the user role after joining the channel, the SDK triggers the following callbacks:

- The local client: [onClientRoleChanged](class_irtcengineeventhandler.html#callback_onclientrolechanged).
- The remote client: [onUserJoined](class_irtcengineeventhandler.html#callback_onuserjoined) or [onUserOffline](class_irtcengineeventhandler.html#callback_onuseroffline) (USER_OFFLINE_BECOME_AUDIENCE).

### Parameters

- role

  The user role. For details, see [CLIENT_ROLE_TYPE](rtc_api_data_type.html#enum_clientroletype).

### Returns

- 0(ERR_OK): Success.
- < 0: Failure.
  - -1(ERR_FAILED): A general error occurs (no specified reason).
  - -2(ERR_INALID_ARGUMENT): The parameter is invalid.
  - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.

**See also**

- [onClientRoleChanged](../API/class_irtcengineeventhandler.html#callback_onclientrolechanged)
- [onUserJoined](../API/class_irtcengineeventhandler.html#callback_onuserjoined)
- [onUserOffline](../API/class_irtcengineeventhandler.html#callback_onuseroffline)

## [setClientRole [2/2\]](class_irtcengine.html#api_setclientrole2)

Sets the user role and level in an interactive live streaming channel.

```cpp
virtual int setClientRole(CLIENT_ROLE_TYPE role, const ClientRoleOptions& options) = 0;
```

In the interactive live streaming profile, the SDK sets the user role as audience by default. You can call this method to set the user role as host.

You can call this method either before or after joining a channel. If you call this method to switch the user role after joining a channel, the SDK automatically does the following:

- Calls [muteLocalAudioStream](class_irtcengine.html#api_mutelocalaudiostream) and [muteLocalVideoStream](class_irtcengine.html#api_mutelocalvideostream) to change the publishing state.
- Triggers [onClientRoleChanged](class_irtcengineeventhandler.html#callback_onclientrolechanged) on the local client.
- Triggers [onUserJoined](class_irtcengineeventhandler.html#callback_onuserjoined) or [onUserOffline](class_irtcengineeventhandler.html#callback_onuseroffline) on the remote client.

The difference between this method and [setClientRole [1/2\]](class_irtcengine.html#api_setclientrole) is that this method can set the user level in addition to the user role.

- The user role (**role**) determines the permissions that the SDK grants to a user, such as permission to send local streams, receive remote streams, and push streams to a CDN address.
- The user (**level**) determines the level of services that a user can enjoy within the permissions of the user's role. For example, an audience member can choose to receive remote streams with low latency or ultra-low latency. **User level affects the pricing of services.**

**Note** This method applies to the interactive live streaming profile (the **profile** parameter of [setChannelProfile](class_irtcengine.html#api_setchannelprofile) is CHANNEL_PROFILE_LIVE_BROADCASTING) only.

### Parameters

- role

  The user role in the interactive live streaming. See [CLIENT_ROLE_TYPE](rtc_api_data_type.html#enum_clientroletype).

- options

  The detailed options of a user, including the user level. See [ClientRoleOptions](rtc_api_data_type.html#class_clientroleoptions).

### Returns

- 0: Success.
- < 0: Failure.
  - -1: A general error occurs (no specified reason).
  - -2: The parameter is invalid.
  - -5: The request is rejected.
  - -7: The SDK is not initialized.

**See also**

- [onClientRoleChanged](../API/class_irtcengineeventhandler.html#callback_onclientrolechanged)
- [onUserJoined](../API/class_irtcengineeventhandler.html#callback_onuserjoined)
- [onUserOffline](../API/class_irtcengineeventhandler.html#callback_onuseroffline)

## [setDefaultAudioRouteToSpeakerphone](class_irtcengine.html#api_setdefaultaudioroutetospeakerphone_ng)

Sets the default audio playback route.

```cpp
virtual int setDefaultAudioRouteToSpeakerphone(bool defaultToSpeaker) = 0;
```

**Note**

This method applies to Android and iOS only.

Most mobile phones have two audio routes: an earpiece at the top, and a speakerphone at the bottom. The earpiece plays at a lower volume, and the speakerphone at a higher volume. When setting the default audio route, you determine whether audio playback comes through the earpiece or speakerphone when no external audio device is connected.

Depending on the scenario, Agora uses different default audio routes:

- Voice call: Earpiece
- Audio broadcast: Speakerphone.
- Video call: Speakerphone.
- Video broadcast: Speakerphone

You can call this method to change the default audio route. This method can be called before, during, or after a call. After a successful method call, the SDK triggers the [onAudioRoutingChanged](class_irtcengineeventhandler.html#callback_onaudioroutechanged) callback.

**Note**

The system audio route changes when an external audio device, such as a headphone or a Bluetooth audio device, is connected. See [Principles for Changing the Audio Route](https://docs.agora.io/en/live-streaming-4.x-preview/audio_route_ng?platform=Android).

### Parameters

- defaultToSpeaker

  Whether to set the speakerphone as the default audio route:`true`: Set the speakerphone as the default audio route.`false`: Do not set the speakerphone as the default audio route.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onAudioRoutingChanged](../API/class_irtcengineeventhandler.html#callback_onaudioroutechanged)

## [setDefaultMuteAllRemoteAudioStreams](class_irtcengine.html#api_setdefaultmuteallremoteaudiostreams)

Stops or resumes subscribing to the audio streams of all remote users by default.

```cpp
virtual int setDefaultMuteAllRemoteAudioStreams(bool mute) = 0;
```

Call this method after joining a channel. After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all subsequent users.

**Note**

If you need to resume subscribing to the audio streams of remote users in the channel after calling this method, do the following:

- To resume subscribing to the audio stream of a specified user, call [muteRemoteAudioStream](class_irtcengine.html#api_muteremoteaudiostream)(`false`), and specify the user ID.
- To resume subscribing to the audio streams of multiple remote users, call muteRemoteAudioStream (`false`)multiple times.

### Parameters

- mute

  Whether to stop subscribing to the audio streams of all remote users by default.`true`: Stop subscribing to the audio streams of all remote users by default.`false`: (Default) Subscribe to the audio streams of all remote users by default.

### Returns

- 0: Success.
- < 0: Failure.

## [setDefaultMuteAllRemoteVideoStreams](class_irtcengine.html#api_setdefaultmuteallremotevideostreams)

Stops or resumes subscribing to the video streams of all remote users by default.

```cpp
virtual int setDefaultMuteAllRemoteVideoStreams(bool mute) = 0;
```

Call this method after joining a channel. After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all subsequent users.

**Note**

If you need to resume subscribing to the audio streams of remote users in the channel after calling this method, do the following:

- To resume subscribing to the audio stream of a specified user, call [muteRemoteVideoStream](class_irtcengine.html#api_muteremotevideostream)(`false`), and specify the user ID.
- To resume subscribing to the audio streams of multiple remote users, call muteRemoteVideoStream(`false`)multiple times.

### Parameters

- mute

  Whether to stop subscribing to the audio streams of all remote users by default.`true`: Stop subscribing to the audio streams of all remote users by default.`false`: (Default) Resume subscribing to the audio streams of all remote users by default.

### Returns

- 0: Success.
- < 0: Failure.

## [setEffectsVolume](class_irtcengine.html#api_seteffectsvolume)

Sets the volume of the audio effects.

```cpp
virtual int setEffectsVolume(int volume) = 0;
```



### Parameters

- volume

  The playback volume. The value ranges from 0 to 100. The default value is 100, which represents the original volume.

### Returns

- 0: Success.
- < 0: Failure.

## [setEnableSpeakerphone](class_irtcengine.html#api_setenablespeakerphone_ng)

Enables/Disables the speakerphone temporarily.

```cpp
virtual int setEnableSpeakerphone(bool speakerOn) = 0;
```

**Note**

This method is for Android and iOS only.

After a successful method call, the SDK triggers the [onAudioRoutingChanged](class_irtcengineeventhandler.html#callback_onaudioroutechanged) callback.

You can call this method before, during, or after a call. However, Agora recommends calling this method only when you are in a channel to change the audio route temporarily.

**Note**

This method sets the audio route temporarily. Connecting in or disconnecting a headphone, or the SDK re-enabling the audio device module (ADM) to adjust the media volume in some scenarios relating to audio, leads to a change in the audio route. See [Principles for Changing the Audio Route](https://docs.agora.io/en/live-streaming-4.x-preview/audio_route_ng?platform=Android).

Due to system limitations, if the user uses an external audio playback device such as a Bluetooth or wired headset on an iOS device, this method does not take effect.

### Parameters

- speakerOn

  Whether to set the speakerphone as the default audio route:`true`: Set the speakerphone as the audio route temporarily.`false`: Do not set the speakerphone as the audio route.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onAudioRoutingChanged](../API/class_irtcengineeventhandler.html#callback_onaudioroutechanged)

## [setEncryptionMode](class_irtcengine.html#api_setencryptionmode)

Sets the built-in encryption mode.

```cpp
virtual int setEncryptionMode(const char* encryptionMode) = 0;
```

- Deprecated:

  Use [enableEncryption](class_irtcengine.html#api_enableencryption) instead.

The Agora SDK supports built-in encryption, which is set to the AES-128-GCM mode by default. Call this method to use other encryption modes. All users in the same channel must use the same encryption mode and **secret**. Refer to the information related to the AES encryption algorithm on the differences between the encryption modes.

**Note** Before calling this method, please call [setEncryptionSecret](class_irtcengine.html#api_setencryptionsecret) to enable the built-in encryption function.

### Parameters

- encryptionMode

  Encryption mode."`aes-128-xts`": 128-bit AES encryption, XTS mode."`aes-128-ecb`": 128-bit AES encryption, ECB mode."`aes-256-xts`": 256-bit AES encryption, XTS mode."`sm4-128-ecb`": 128-bit SM4 encryption, ECB mode."`aes-128-gcm`": 128-bit AES encryption, GCM mode."`aes-256-gcm`": 256-bit AES encryption, GCM mode."": When this parameter is set as null, the encryption mode is set as "`aes-128-gcm`" by default.

### Returns

- 0: Success.
- < 0: Failure.

## [setEncryptionSecret](class_irtcengine.html#api_setencryptionsecret)

Enables built-in encryption with an encryption password before users join a channel.

```cpp
virtual int setEncryptionSecret(const char* secret) = 0;
```

- Deprecated:

  This method is deprecated from v3.2.0. Please use [enableEncryption](class_irtcengine.html#api_enableencryption) instead.

Before joining the channel, you need to call this method to set the **secret** parameter to enable the built-in encryption. All users in the same channel should use the same **secret**. The **secret** is automatically cleared once a user leaves the channel. If you do not specify the **secret** or **secret** is set as null, the built-in encryption is disabled.

**Note**

- Do not use this method for CDN live streaming.
- For optimal transmission, ensure that the encrypted data size does not exceed the original data size + 16 bytes. 16 bytes is the maximum padding size for AES encryption.

### Parameters

- secret

  The encryption password.

### Returns

- 0: Success.
- < 0: Failure.

## [setExtensionProperty](class_irtcengine.html#api_setextensionproperty)

Sets the properties of the extension.

```cpp
virtual int setExtensionProperty(
      const char* provider, const char* extension,
      const char* key, const char* value, agora::media::MEDIA_SOURCE_TYPE type = agora::media::UNKNOWN_MEDIA_SOURCE) = 0;
```

After enabling the extension, you can call this method to set the properties of the extension.

### Parameters

- provider

  The name of the extension provider.

- extension

  The name of the extension.

- key

  The key of the extension.

- value

  The value of the extension key.

- type

  The type of media source. See [MEDIA_SOURCE_TYPE](rtc_api_data_type.html#enum_mediasourcetype).**Note** This parameter in this method only supports two values:The default value is UNKNOWN_MEDIA_SOURCE.If you want to use a secondary camera to capture video, set this parameter to SECONDARY_CAMERA_SOURCE.

### Returns

- 0: Success.
- < 0: Failure.

## [setExtensionProviderProperty](class_irtcengine.html#api_setextensionproviderproperty)

Sets the properties of the extension provider.

```cpp
virtual int setExtensionProviderProperty(
      const char* provider, const char* key, const char* value) = 0;
```

You can call this method to set the attributes of the extension provider and initialize the relevant parameters according to the type of the provider.

**Note**

Call this method after [enableExtension](class_irtcengine.html#api_enableextension), and before enabling the audio ([enableAudio](class_irtcengine.html#api_enableaudio)/[enableLocalAudio](class_irtcengine.html#api_enablelocalaudio)) or the video ([enableVideo](class_irtcengine.html#api_enablevideo)/[enableLocalVideo](class_irtcengine.html#api_enablelocalvideo)).

### Parameters

- provider

  The name of the extension provider.

- key

  The key of the extension.

- value

  The value of the extension key.

### Returns

- 0: Success.
- < 0: Failure.

## [setExternalAudioSink](class_irtcengine.html#api_setexternalaudiosink_ng)

Sets the external audio sink.

```cpp
virtual int setExternalAudioSink(int sampleRate, int channels) = 0;
```

This method applies to scenarios where you want to use external audio data for playback. After setting `enableAudioDevice` to `false` in [initialize](class_irtcengine.html#api_create2), you can call [setExternalAudioSink](class_irtcengine.html#api_setexternalaudiosink_ng) to set the external audio sink. After the setting is successful, you can call [pullAudioFrame](class_imediaengine.html#api_imediaengine_pullaudioframe) to pull the remote audio data. The app can process the remote audio and play it with the audio effects that you want.

**Note**

- Ensure that you call this method before joining a channel.
- Once you enable the external audio sink, the app does not retrieve any audio data from the [onPlaybackAudioFrame](class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onplaybackaudioframe) callback.

### Parameters

- sampleRate

  The sample rate (Hz) of the external audio sink, which can be set as 16000, 32000, 44100, or 48000.

- channels

  The number of audio channels of the external audio sink:1: Mono.2: Stereo.

### Returns

- 0: Success.
- < 0: Failure.

## [setExternalAudioSource](class_imediaengine.html#api_setexternalaudiosource2)

Sets the external audio source parameters.

```cpp
virtual int setExternalAudioSource(bool enabled,
                                   int sampleRate, 
                                   int channels, 
                                   int sourceNumber, 
                                   bool localPlayback = false, 
                                   bool publish = true) = 0;
```

**Note** Call this method before joining a channel.

### Parameters

- enabled

  Whether to enable the external audio source:`true`: Enable the external audio source.`false`: (Default) Disable the external audio source.

- sampleRate

  The sample rate (Hz) of the external audio source, which can be set as `8000`, `16000`, `32000`, `44100`, or `48000`.

- channels

  The number of channels of the external audio source, which can be set as `1` (Mono) or `2` (Stereo).

- sourceNumber

  The number of external audio sources. The value of this parameter should be larger than 0. The SDK creates a corresponding number of custom audio tracks based on this parameter value and names the audio tracks starting from 0. In [ChannelMediaOptions](rtc_api_data_type.html#class_channelmediaoptions_ng), you can set **publishCustomAudioSourceId** to the ID of the audio track you want to publish.

- localPlayback

  Whether to play the external audio source:`true`: Play the external audio source.`false`: (Default) Do not play the external source.

- publish

  Whether to publish audio to the remote users:`true`: (Default) Publish audio to the remote users.`false`: Do not publish audio to the remote users

### Returns

- 0: Success.
- < 0: Failure.

## [setInEarMonitoringVolume](class_irtcengine.html#api_setinearmonitoringvolume)

Sets the volume of the in-ear monitor.

```cpp
virtual int setInEarMonitoringVolume(int volume) = 0;
```

**Note**

- This method is for Android and iOS only.
- Users must use wired earphones to hear their own voices.
- You can call this method either before or after joining a channel.

### Parameters

- volume

  The volume of the in-ear monitor. The value ranges between 0 and 100. The default value is 100.

### Returns

- 0: Success.
- < 0: Failure.

## [setLiveTranscoding](class_irtcengine.html#api_setlivetranscoding)

Sets the transcoding configurations for CDN live streaming.

```cpp
virtual int setLiveTranscoding(const LiveTranscoding &transcoding) = 0;
```

This method sets the video layout and audio settings for CDN live streaming. The SDK triggers the [onTranscodingUpdated](class_irtcengineeventhandler.html#callback_ontranscodingupdated) callback when you call this method to update the transcoding settings.

**Note**

- This method takes effect only when you are a host in live interactive streaming.
- Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in the advanced guide Push Streams to CDN.
- If you call this method to set the transcoding configuration for the first time, the SDK does not trigger the onTranscodingUpdated callback.
- Call this method after joining a channel.
- Agora supports pushing media streams in RTMPS protocol to the CDN only when you enable transcoding.

### Parameters

- transcoding

  The transcoding configurations for CDN live streaming. For details, see [LiveTranscoding](rtc_api_data_type.html#class_livetranscoding).

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onTranscodingUpdated](../API/class_irtcengineeventhandler.html#callback_ontranscodingupdated)

## [setLocalRenderMode [1/2\]](class_irtcengine.html#api_setlocalrendermode)

Sets the local video display mode.

```cpp
virtual int setLocalRenderMode(media::base::RENDER_MODE_TYPE renderMode) = 0;
```



- Deprecated:

  This method is deprecated. Use [setLocalRenderMode [2/2\]](class_irtcengine.html#api_setlocalrendermode2) instead.

Call this method to set the local video display mode. This method can be called multiple times during a call to change the display mode.

### Parameters

- renderMode

  The local video display mode. For details, see [RENDER_MODE_TYPE](rtc_api_data_type.html#enum_rendermodetype).

### Returns

- 0: Success.
- < 0: Failure.

## [setLocalRenderMode [2/2\]](class_irtcengine.html#api_setlocalrendermode2)

Updates the display mode of the local video view.

```cpp
virtual int setLocalRenderMode(media::base::RENDER_MODE_TYPE renderMode, VIDEO_MIRROR_MODE_TYPE mirrorMode) = 0;
```



After initializing the local video view, you can call this method to update its rendering and mirror modes. It affects only the video view that the local user sees, not the published local video stream.

**Note**

- Ensure that you have called the [setupLocalVideo](class_irtcengine.html#api_setuplocalvideo) method to initialize the local video view before calling this method.
- During a call, you can call this method as many times as necessary to update the display mode of the local video view.

### Parameters

- renderMode

  The local video display mode. For details, see [RENDER_MODE_TYPE](rtc_api_data_type.html#enum_rendermodetype).

- mirrorMode

  The rendering mode of the local video view. See [VIDEO_MIRROR_MODE_TYPE](rtc_api_data_type.html#enum_videomirrormodetype).**Note** If you use a front camera, the SDK enables the mirror mode by default; if you use a rear camera, the SDK disables the mirror mode by default.

### Returns

- 0: Success.
- < 0: Failure.

## [setLocalVideoMirrorMode](class_irtcengine.html#api_setlocalvideomirrormode)

Sets the local video mirror mode.

```cpp
virtual int setLocalVideoMirrorMode(VIDEO_MIRROR_MODE_TYPE mirrorMode) = 0;
```

- Deprecated:

  Deprecated as of v3.0.0.

  Use [setupLocalVideo](class_irtcengine.html#api_setuplocalvideo) or [setLocalRenderMode [2/2\]](class_irtcengine.html#api_setlocalrendermode2) instead.

### Parameters

- mirrorMode

  The local video mirror mode. For details, see [VIDEO_MIRROR_MODE_TYPE](rtc_api_data_type.html#enum_videomirrormodetype).

### Returns

- 0: Success.
- < 0: Failure.

## [setLocalVoiceChanger](class_irtcengine.html#api_setlocalvoicechanger)

Sets the local voice changer option.

```cpp
virtual int setLocalVoiceChanger(VOICE_CHANGER_PRESET voiceChanger) = 0;
```

- Deprecated:

  Deprecated from v3.2.0. Use the following methods instead:[setAudioEffectPreset](class_irtcengine.html#api_setaudioeffectpreset) : Audio effects.[setVoiceBeautifierPreset](class_irtcengine.html#api_setvoicebeautifierpreset) : Voice beautifier effects.[setVoiceConversionPreset](class_irtcengine.html#api_setvoiceconversionpreset) : Voice conversion effects.

This method can be used to set the local voice effect for users in a COMMUNICATION channel or hosts in a LIVE_BROADCASTING channel. After successfully calling this method, all users in the channel can hear the voice with reverberation.

- `VOICE_CHANGER_XXX`: Changes the local voice to an old man, a little boy, or the Hulk. Applies to the voice talk scenario.
- `VOICE_BEAUTY_XXX`: Beautifies the local voice by making it sound more vigorous, resounding, or adding spacial resonance. Applies to the voice talk and singing scenario.
- `GENERAL_VOICE_BEAUTY_XXX`: Adds gender-based beautification effect to the local voice. Applies to the voice talk scenario. For a male voice: Adds magnetism to the voice. For a male voice: Adds magnetism to the voice. For a female voice: Adds freshness or vitality to the voice.

**Note**

- To achieve better voice effect quality, Agora recommends setting the [setAudioProfile [1/2\]](class_irtcengine.html#api_setaudioprofile)**profile** parameter in asAUDIO_PROFILE_MUSIC_HIGH_QUALITY (4) orAUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO (5).
- This method works best with the human voice, and Agora does not recommend using it for audio containing music and a human voice.
- Do not use this method with [setLocalVoiceReverbPreset](class_irtcengine.html#api_setlocalvoicereverbpreset), because the method called later overrides the one called earlier. For detailed considerations, see the advanced guide Set the Voice Effect.
- You can call this method either before or after joining a channel.

### Parameters

- voiceChanger

  The local voice changer option. The default value is VOICE_CHANGER_OFF , which means the original voice. For more details, see [VOICE_CHANGER_PRESET](rtc_api_data_type.html#enum_voicechangerpreset). The gender-based beatification effect works best only when assigned a proper gender. Use GENERAL_BEAUTY_VOICE_MALE_MAGNETIC for male and use GENERAL_BEAUTY_VOICE_FEMALE_FRESH and GENERAL_BEAUTY_VOICE_FEMALE_VITALITY for female. Failure to do so can lead to voice distortion.

### Returns

- 0: Success.
- < 0: Failure.

## [setLocalVoiceEqualization](class_irtcengine.html#api_setlocalvoiceequalization)

Sets the local voice equalization effect.

```cpp
virtual int setLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_FREQUENCY bandFrequency, int bandGain) = 0;
```

**Note** You can call this method either before or after joining a channel.

### Parameters

- bandFrequency

  The band frequency. The value ranges between 0 and 9; representing the respective 10-band center frequencies of the voice effects, including 31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, and 16k Hz. For more details, see [AUDIO_EQUALIZATION_BAND_FREQUENCY](rtc_api_data_type.html#enum_audioequalizationbandfrequency).

- bandGain

  The gain of each band in dB. The value ranges between -15 and 15. The default value is 0.

### Returns

- 0: Success.
- < 0: Failure.

## [setLocalVoicePitch](class_irtcengine.html#api_setlocalvoicepitch)

Changes the voice pitch of the local speaker.

```cpp
virtual int setLocalVoicePitch(double pitch) = 0;
```

**Note** You can call this method either before or after joining a channel.

### Parameters

- pitch

  The local voice pitch. The value range is [0.5,2.0]. The lower the value, the lower the pitch. The default value is 1 (no change to the pitch).

### Returns

- 0: Success.
- < 0: Failure.

## [setLocalVoiceReverb](class_irtcengine.html#api_setlocalvoicereverb)

Sets the local voice reverberation.

```cpp
virtual int setLocalVoiceReverb(AUDIO_REVERB_TYPE reverbKey, int value) = 0;
```

You can call this method either before or after joining a channel.

### Parameters

- reverbKey

  The reverberation key. Agora provides 5 reverberation keys: [AUDIO_REVERB_TYPE](rtc_api_data_type.html#enum_audioreverbtype).

- value

  The value of the reverberation key.

### Returns

- 0: Success.
- < 0: Failure.

## [setLocalVoiceReverbPreset](class_irtcengine.html#api_setlocalvoicereverbpreset)

Sets the local voice reverberation option, including the virtual stereo.

```cpp
virtual int setLocalVoiceReverbPreset(AUDIO_REVERB_PRESET reverbPreset) = 0;
```

This method sets the local voice reverberation for users in a COMMUNICATION channel or hosts in a LIVE_BROADCASTING channel. After successfully calling this method, all users in the channel can hear the voice with reverberation.

**Note**

- When using the enumeration value prefixed with `AUDIO_REVERB_FX`, ensure that you set the **profile** parameter in [setAudioProfile [1/2\]](class_irtcengine.html#api_setaudioprofile) toAUDIO_PROFILE_MUSIC_HIGH_QUALITY(4) or AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5) before calling this method. Otherwise, the method setting is invalid.
- When calling the AUDIO_VIRTUAL_STEREO method, Agora recommends setting the **profile** parameter in setAudioProfile [1/2] as AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5).
- This method works best with the human voice, and Agora does not recommend using it for audio containing music and a human voice.
- Do not use this method with [setLocalVoiceChanger](class_irtcengine.html#api_setlocalvoicechanger), because the method called later overrides the one called earlier. For detailed considerations, see the advanced guide Set the Voice Effect.
- You can call this method either before or after joining a channel.

### Parameters

- reverbPreset

  The local voice reverberation option. The default value is AUDIO_REVERB_OFF, which means the original voice. For more details, see [AUDIO_REVERB_PRESET](rtc_api_data_type.html#enum_audioreverbpreset). To achieve better voice effects, Agora recommends the enumeration whose name begins with `AUDIO_REVERB_FX`.

  

### Returns

- 0: Success.
- < 0: Failure.

## [setLogFile](class_irtcengine.html#api_setlogfile_ng)

Set the log file

```cpp
virtual int setLogFile(const char* filePath) = 0;
```

- Deprecated:

  Use the `mLogConfig` parameter in [initialize](class_irtcengine.html#api_create2) method instead.

Specifies an SDK output log file. The log file records all log data for the SDK’s operation. Ensure that the directory for the log file exists and is writable.

**Note**

Ensure that you call this method immediately after calling the initialize[IRtcEngine](class_irtcengine.html#class_irtcengine) method, or the output log may not be complete.

### Parameters

- filePath

  The absolute path of the log files. These log files are encoded in UTF-8.

### Returns

- 0: Success.
- < 0: Failure.

## [setLogFileSize](class_irtcengine.html#api_setlogfilesize_ng)

Sets the log file size.

```cpp
virtual int setLogFileSize(unsigned int fileSizeInKBytes) = 0;
```

- Deprecated:

  Use the `logConfig` parameter in [initialize](class_irtcengine.html#api_create2) instead.

By default, the SDK outputs four log files: `agorasdk.log`, `agorasdk1.log`, `agoraapi.log`, and `agoraapi1.log`. The `agorasdk.log` and `agorasdk1.log` files each have a default size of 1024 KB, and the `agoraapi.log` and `agoraapi1.log` files each have a default size of 2,048 KB. These log files are encoded in UTF-8.

The SDK writes the latest logs in `agorasdk.log` or `agoraapi.log`.

When `agorasdk.log` or `agoraapi.log` is full, the SDK deletes `agorasdk1.log` or `agoraapi1.log`, renames `agorasdk.log` to `agorasdk1.log` and `agoraapi.log` to `agoraapi1.log`, and creates a new `agorasdk.log` or `agoraapi.log` to record the latest logs.

**Note**

This method applies to the `agorasdk.log` file only and does not take effect for the `agoraapi.log` file.

### Parameters

- **fileSizeInKBytes**

  The size (KB) of an `agorasdk.log` file. The value range is [128,1024]. The default value is 1,024 KB. If you set `fileSizeInKByte` smaller than 128 KB, the SDK automatically adjusts it to 128 KB; if you set `fileSizeInKByte` greater than 1,024 KB, the SDK automatically adjusts it to 1,024 KB.

### Returns

- 0: Success.
- < 0: Failure.

## [setLogFilter](class_irtcengine.html#api_setlogfilter)

Sets the log output level of the SDK.

```cpp
virtual int setLogFilter(unsigned int filter) = 0;
```

This method sets the output log level of the SDK. You can use one or a combination of the log filter levels. The log level follows the sequence of OFF, CRITICAL, ERROR, WARNING, INFO, and DEBUG. Choose a level to see the logs preceding that level.

If, for example, you set the log level to WARNING, you see the logs within levels CRITICAL, ERROR, and WARNING.

### Parameters

- filter

  The output log level of the SDK. For details, see [LOG_FILTER_TYPE](rtc_api_data_type.html#enum_logfiltertype).

### Returns

- 0: Success.
- < 0: Failure.

## [setLogLevel](class_irtcengine.html#api_setloglevel)

Sets the output log level of the SDK.

```cpp
virtual int setLogLevel(commons::LOG_LEVEL level) = 0;
```

- Deprecated:

  This method is deprecated. Use [RtcEngineContext](rtc_api_data_type.html#class_rtcengineconfig_ng) instead to set the log output level.

Choose a level to see the logs preceding that level.

### Parameters

- level

  The log level: [LOG_LEVEL](rtc_api_data_type.html#enum_loglevel).

### Returns

- 0: Success.
- < 0: Failure.

## [setMixedAudioFrameParameters](class_irtcengine.html#api_setmixedaudioframeparameters_ng)

Sets the audio data format reported by [onMixedAudioFrame](class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onmixedaudioframe).

```cpp
virtual int setMixedAudioFrameParameters(int sampleRate, int channel, int samplesPerCall) = 0;
```

### Parameters

- sampleRate

  The sample rate returned in the callback, which can be set as `8000`, `16000`, `32000`, `44100`, or `48000` Hz.

- channel

  The number of channels of the external audio source, which can be set as `1`(Mono) or `2`(Stereo).

- samplesPerCall

  Sets the number of samples the onMixedAudioFrame callback returns. In RTMP streaming scenarios, set it as `1024`.

**Note**

The SDK triggers the onMixedAudioFrame callback according to the sample interval. Sample interval (sec) = `samplePerCall`/(`sampleRate` × `channel`). Ensure that the value of sample interval ≥ 0.01.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onMixedAudioFrame](../API/class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onmixedaudioframe)

## [setPlaybackAudioFrameBeforeMixingParameters](class_irtcengine.html#api_setplaybackaudioframebeforemixingparameters)

Sets the audio data format reported by [onPlaybackAudioFrameBeforeMixing](class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onplaybackaudioframebeforemixing).

```cpp
virtual int setPlaybackAudioFrameBeforeMixingParameters(int sampleRate, int channel) = 0;
```

Sets the audio data format reported by [onPlaybackAudioFrameBeforeMixing](class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onplaybackaudioframebeforemixing).

### Parameters

- **sampleRate**

  The sample rate returned in the callback, which can be set as `8000`, `16000`, `32000`, `44100`, or `48000` Hz.

- **channel**

  The number of channels of the external audio source, which can be set as `1`(Mono) or `2`(Stereo).

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onPlaybackAudioFrameBeforeMixing](../API/class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onplaybackaudioframebeforemixing)

## [setPlaybackAudioFrameParameters](class_irtcengine.html#api_setplaybackaudioframeparameters)

Sets the audio data format for playback.

```cpp
virtual int setPlaybackAudioFrameParameters(int sampleRate,
    int channel,
    RAW_AUDIO_FRAME_OP_MODE_TYPE mode,
    int samplesPerCall) = 0;
```

Sets the audio format for the [onPlaybackAudioFrame](class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onplaybackaudioframe) callback.

**Note**

- Ensure that you call this method before joining a channel.
- The SDK calculates the sampling interval based on the **samplesPerCall**, **sampleRate** and **channel** parameters set in this method.Sample interval (sec) = **samplePerCall**/(**sampleRate** × **channel**). Ensure that the sample interval ≥ 0.01 (s). The SDK triggers the onPlaybackAudioFrame callback according to the sampling interval.

### Parameters

- sampleRate

  The sample rate returned in the onPlaybackAudioFrame callback, which can be set as 8000, 16000, 32000, 44100, or 48000 Hz.

- channel

  The number of channels (channels) returned in the onPlaybackAudioFrame callback:1: Mono.2: Stereo.

- mode

  The use mode of the audio frame. See [RAW_AUDIO_FRAME_OP_MODE_TYPE](rtc_api_data_type.html#enum_rawaudioframeopmodetype).

- samplesPerCall

  The number of samples returned in the onPlaybackAudioFrame callback. Usually set as 1024 for RTMP or RTMPS streaming.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onPlaybackAudioFrame](../API/class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onplaybackaudioframe)

## [setRecordingAudioFrameParameters](class_irtcengine.html#api_setrecordingaudioframeparameters)

Set the format of the captured raw audio data.

```cpp
virtual int setRecordingAudioFrameParameters(int sampleRate,
    int channel,
    RAW_AUDIO_FRAME_OP_MODE_TYPE mode,
    int samplesPerCall) = 0;
```

Sets the audio format for the [onRecordAudioFrame](class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onrecordaudioframe) callback.

**Note**

- Ensure that you call this method before joining a channel.
- The SDK calculates the sampling interval based on the **samplesPerCall**, **sampleRate** and **channel** parameters set in this method.Sample interval (sec) = **samplePerCall**/(**sampleRate** × **channel**). Ensure that the sample interval ≥ 0.01 (s). The SDK triggers the callback according to the sampling intervalonRecordAudioFrame.

### Parameters

- sampleRate

  The sample rate returned in the onRecordAudioFrame callback, which can be set as 8000, 16000, 32000, 44100, or 48000 Hz.

- channel

  The number of channels (channels) returned in the onRecordAudioFrame callback:1: Mono.2: Stereo.

- mode

  The use mode of the audio frame. See [RAW_AUDIO_FRAME_OP_MODE_TYPE](rtc_api_data_type.html#enum_rawaudioframeopmodetype).

- samplesPerCall

  The number of samples returned in the onRecordAudioFrame callback. Usually set as 1024 for RTMP or RTMPS streaming.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onRecordAudioFrame](../API/class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onrecordaudioframe)

## [setRemoteDefaultVideoStreamType](class_irtcengine.html#api_setremotedefaultvideostreamtype)

Sets the default stream type of remote video streams.

```cpp
virtual int setRemoteVideoStreamType(uid_t uid, VIDEO_STREAM_TYPE streamType) = 0;
```



Under limited network conditions, if the publisher has not disabled the dual-stream mode using (),the receiver can choose to receive either the high-quality video stream or the low-quality video stream. The high-quality video stream has a higher resolution and bitrate, and the low-quality video stream has a lower resolution and bitrate.[enableDualStreamMode [1/3\]](class_irtcengine.html#api_enabledualstreammode)`false`

By default, users receive the high-quality video stream. Call this method if you want to switch to the low-quality video stream. This method allows the app to adjust the corresponding video stream type based on the size of the video window to reduce the bandwidth and resources. The aspect ratio of the low-quality video stream is the same as the high-quality video stream. Once the resolution of the high-quality video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-quality video stream.

The result of this method returns in the [onApiCallExecuted](class_irtcengineeventhandler.html#callback_onapicallexecuted) callback.

**Note** You can call this method either before or after joining a channel. If you call both setRemoteVideoStreamType and [setRemoteDefaultVideoStreamType](class_irtcengine.html#api_setremotedefaultvideostreamtype), the settings in setRemoteVideoStreamType take effect.

### Parameters

- streamType

  The default stream type of the remote video, see [REMOTE_VIDEO_STREAM_TYPE](rtc_api_data_type.html#enum_remotevideostreamtype).

### Returns

- 0: Success.
- < 0: Failure.

## [setupRemoteVideo](class_irtcengine.html#api_setupremotevideo)

Initializes the video view of a remote user.

```cpp
virtual int setupRemoteVideo(const VideoCanvas& canvas) = 0;
```

This method initializes the video view of a remote stream on the local device. It affects only the video view that the local user sees. Call this method to bind the remote video stream to a video view and to set the rendering and mirror modes of the video view.

You need to specify the ID of the remote user in this method. If the remote user ID is unknown to the application, set it after the app receives the [onUserJoined](class_irtcengineeventhandler.html#callback_onuserjoined) callback.

To unbind the remote user from the view, set the **view** parameter to NULL.

Once the remote user leaves the channel, the SDK unbinds the remote user.

**Note**

- To update the rendering or mirror mode of the remote video view during a call, use the [setRemoteRenderMode](class_irtcengine.html#api_setremoterendermode2) method.
- If you use the Agora recording feature, the recording client joins the channel as a dummy client, triggering the [onUserJoined](class_irtcengineeventhandler.html#callback_onuserjoined) callback. Do not bind the dummy client to the app view because the dummy client does not send any video streams. If your app does not recognize the dummy client, bind the remote user to the view when the SDK triggers the [onFirstRemoteVideoDecoded](class_irtcengineeventhandler.html#callback_onfirstremotevideodecoded) callback.

### Parameters

- canvas

  The remote video view and settings. For details, see [VideoCanvas](rtc_api_data_type.html#class_videocanvas_ng).

### Returns

- 0: Success.
- < 0: Failure.

## [setRemoteRenderMode](class_irtcengine.html#api_setremoterendermode2)

Updates the display mode of the video view of a remote user.

```cpp
virtual int setRemoteRenderMode(uid_t userId, RENDER_MODE_TYPE renderMode, VIDEO_MIRROR_MODE_TYPE mirrorMode) = 0;
```

After initializing the video view of a remote user, you can call this method to update its rendering and mirror modes. This method affects only the video view that the local user sees.

**Note**

- Please call this method after initializing the remote view by calling the [setupRemoteVideo](class_irtcengine.html#api_setupremotevideo) method.
- During a call, you can call this method as many times as necessary to update the display mode of the video view of a remote user.

### Parameters

- userId

  The ID of the remote user.

- renderMode

  The rendering mode of the remote user view. For details, see [RENDER_MODE_TYPE](rtc_api_data_type.html#enum_rendermodetype).

- mirrorMode

  The mirror mode of the remote user view. For details, see [VIDEO_MIRROR_MODE_TYPE](rtc_api_data_type.html#enum_videomirrormodetype).

### Returns

- 0: Success.
- < 0: Failure.

## [setRemoteVideoStreamType](class_irtcengine.html#api_setremotevideostreamtype)

Sets the stream type of the remote video.

```cpp
virtual int setRemoteVideoStreamType(uid_t uid, VIDEO_STREAM_TYPE streamType) = 0;
```



Under limited network conditions, if the publisher has not disabled the dual-stream mode using [enableDualStreamMode [1/3\]](class_irtcengine.html#api_enabledualstreammode)(false), the receiver can choose to receive either the high-quality video stream (the high resolution, and high bitrate video stream) or the low-quality video stream (the low resolution, and low bitrate video stream). The high-quality video stream has a higher resolution and bitrate, and the low-quality video stream has a lower resolution and bitrate.

By default, users receive the high-quality video stream. Call this method if you want to switch to the low-quality video stream. This method allows the app to adjust the corresponding video stream type based on the size of the video window to reduce the bandwidth and resources. The aspect ratio of the low-quality video stream is the same as the high-quality video stream. Once the resolution of the high-quality video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-quality video stream.

The method result returns in the [onApiCallExecuted](class_irtcengineeventhandler.html#callback_onapicallexecuted) callback.

**Note** You can call this method either before or after joining a channel. If you call both setRemoteVideoStreamType and [setRemoteDefaultVideoStreamType](class_irtcengine.html#api_setremotedefaultvideostreamtype), the setting of setRemoteVideoStreamType takes effect.

### Parameters

- uid

  User ID.

- streamType

  The video stream type: [REMOTE_VIDEO_STREAM_TYPE](rtc_api_data_type.html#enum_remotevideostreamtype).

### Returns

- 0: Success.
- < 0: Failure.

## [setRemoteVoicePosition](class_irtcengine.html#api_setremotevoiceposition)

Sets the 2D position (the position on the horizontal plane) of the remote user's voice.

```cpp
virtual int setRemoteVoicePosition(uid_t uid, double pan, double gain) = 0;
```

This method sets the 2D position and volume of a remote user, so that the local user can easily hear and identify the remote user's position.

When the local user calls this method to set the voice position of a remote user, the voice difference between the left and right channels allows the local user to track the real-time position of the remote user, creating a sense of space. This method applies to massive multiplayer online games, such as Battle Royale games.

**Note**

- For this method to work, enable stereo panning for remote users by calling the [enableSoundPositionIndication](class_irtcengine.html#api_enablesoundpositionindication) method before joining a channel.
- For the best voice positioning, Agora recommends using a wired headset.
- Call this method after joining a channel.

### Parameters

- uid

  The user ID of the remote user.

- pan

  The voice position of the remote user. The value ranges from -1.0 to 1.0:0.0: (Default) The remote voice comes from the front.-1.0: The remote voice comes from the left.1.0: The remote voice comes from the right.

- gain

  The volume of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original volume of the remote user). The smaller the value, the lower the volume.

### Returns

- 0: Success.
- < 0: Failure.

## [setScreenCaptureContentHint](class_irtcengine.html#api_setscreencapturecontenthint)

Sets the content hint for screen sharing.

```cpp
virtual int setScreenCaptureContentHint(VIDEO_CONTENT_HINT contentHint) = 0;
            
```

A content hint suggests the type of the content being shared, so that the SDK applies different optimization algorithms to different types of content. If you don't call this method, the default content hint is CONTENT_HINT_NONE.

**Note** You can call this method either before or after you start screen sharing.

### Parameters

- contentHint

  The content hint for screen sharing. For details, see [VideoContentHint](rtc_api_data_type.html#enum_videocontenthint).

### Returns

- 0: Success.
- < 0: Failure.

## [setVideoEncoderConfiguration](class_irtcengine.html#api_setvideoencoderconfiguration)

Sets the video encoder configuration.

```cpp
virtual int setVideoEncoderConfiguration(const VideoEncoderConfiguration& config) = 0;
```

Sets the encoder configuration for the local video.

**Note** You can call this method either before or after joining a channel. If you don't need to set the video encoder configuration after joining a channel, Agora recommends you calling this method before the [enableVideo](class_irtcengine.html#api_enablevideo) method to reduce the rendering time of the first video frame.

### Parameters

- config

  Video profile. See [VideoEncoderConfiguration](rtc_api_data_type.html#class_videoencoderconfiguration).

### Returns

- 0: Success.
- < 0: Failure.

## [setupLocalVideo](class_irtcengine.html#api_setuplocalvideo)

Initializes the local video view.

```cpp
virtual int setupLocalVideo(const VideoCanvas& canvas) = 0;
```

This method initializes the video view of a local stream on the local device. It affects only the video view that the local user sees, not the published local video stream. Call this method to bind the local video stream to a video **view** and to set the rendering and mirror modes of the video view.

After initialization, call this method to set the local video and then join the channel. The local video still binds to the view after you leave the channel. To unbind the local video from the view, set the **view** parameter as NULL.

**Note**

- You can call this method either before or after joining a channel.
- To update the rendering or mirror mode of the local video view during a call, use the [setLocalRenderMode [2/2\]](class_irtcengine.html#api_setlocalrendermode2) method.

### Parameters

- canvas

  The local video view and settings. For details, see [VideoCanvas](rtc_api_data_type.html#class_videocanvas_ng).

### Returns

- 0: Success.
- < 0: Failure.

## [setVoiceBeautifierParameters](class_irtcengine.html#api_setvoicebeautifierparameters)

Sets parameters for the preset voice beautifier effects.

```cpp
virtual int setVoiceBeautifierParameters(VOICE_BEAUTIFIER_PRESET preset, int param1, int param2) = 0;
```

Call this method to set a gender characteristic and a reverberation effect for the singing beautifier effect. This method sets parameters for the local user who sends an audio stream. After setting the audio parameters, all users in the channel can hear the effect.

For better voice effects, Agora recommends that you call [setAudioProfile [1/2\]](class_irtcengine.html#api_setaudioprofile) and set**scenario** to AUDIO_SCENARIO_GAME_STREAMING(3) and **profile** to AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4) or AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5) before calling this method.

**Note**

- You can call this method either before or after joining a channel.

- Do not set the **profile** parameter of setAudioProfile [1/2] to AUDIO_PROFILE_SPEECH_STANDARD(1) or AUDIO_PROFILE_IOT(6). Otherwise, the method does not take effect.

- This method works best with the human voice. Agora does not recommend using this method for audio containing music.

- After calling

   

  setVoiceBeautifierParameters

  , Agora recommends not calling the following methods, because they can override settings in

   

  setVoiceBeautifierParameters

  :

  - [setAudioEffectPreset](class_irtcengine.html#api_setaudioeffectpreset)
  - [setAudioEffectParameters](class_irtcengine.html#api_setaudioeffectparameters)
  - [setVoiceBeautifierPreset](class_irtcengine.html#api_setvoicebeautifierpreset)
  - [setLocalVoiceReverbPreset](class_irtcengine.html#api_setlocalvoicereverbpreset)
  - [setLocalVoiceChanger](class_irtcengine.html#api_setlocalvoicechanger)
  - [setLocalVoicePitch](class_irtcengine.html#api_setlocalvoicepitch)
  - [setLocalVoiceEqualization](class_irtcengine.html#api_setlocalvoiceequalization)
  - [setLocalVoiceReverb](class_irtcengine.html#api_setlocalvoicereverb)
  - [setVoiceConversionPreset](class_irtcengine.html#api_setvoiceconversionpreset)

### Parameters

- preset

  The option for the preset audio effect:`SINGING_BEAUTIFIER`: The singing beautifier effect.

- param1

  The gender characteristics options for the singing voice:`1`: A male-sounding voice.`2`: A female-sounding voice.

- param2

  The reverberation effect options for the singing voice:`1`: The reverberation effect sounds like singing in a small room.`2`: The reverberation effect sounds like singing in a large room.`3`: The reverberation effect sounds like singing in a hall.

### Returns

- 0: Success.
- < 0: Failure.

## [setVoiceBeautifierPreset](class_irtcengine.html#api_setvoicebeautifierpreset)

Sets a preset voice beautifier effect.

```cpp
virtual int setVoiceBeautifierPreset(VOICE_BEAUTIFIER_PRESET preset) = 0;
```

Call this method to set a preset voice beautifier effect for the local user who sends an audio stream. After setting a voice beautifier effect, all users in the channel can hear the effect. You can set different voice beautifier effects for different scenarios.

For better voice effects, Agora recommends that you call [setAudioProfile [1/2\]](class_irtcengine.html#api_setaudioprofile) and set **scenario** to AUDIO_SCENARIO_GAME_STREAMING (3) and **profile** to AUDIO_PROFILE_MUSIC_HIGH_QUALITY (4) or AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO (5) before calling this method.

**Note**

- You can call this method either before or after joining a channel.

- Do not set the **profile** parameter in setAudioProfile [1/2] to AUDIO_PROFILE_SPEECH_STANDARD(1) or AUDIO_PROFILE_IOT(6), or the method does not take effect.

- This method works best with the human voice. Agora does not recommend using this method for audio containing music.

- After calling

   

  setVoiceBeautifierPreset

  , Agora recommends not calling the following methods, because they can override

   

  setVoiceBeautifierPreset

  :

  - [setAudioEffectPreset](class_irtcengine.html#api_setaudioeffectpreset)
  - [setAudioEffectParameters](class_irtcengine.html#api_setaudioeffectparameters)
  - [setLocalVoiceReverbPreset](class_irtcengine.html#api_setlocalvoicereverbpreset)
  - [setLocalVoiceChanger](class_irtcengine.html#api_setlocalvoicechanger)
  - [setLocalVoicePitch](class_irtcengine.html#api_setlocalvoicepitch)
  - [setLocalVoiceEqualization](class_irtcengine.html#api_setlocalvoiceequalization)
  - [setLocalVoiceReverb](class_irtcengine.html#api_setlocalvoicereverb)
  - [setVoiceBeautifierParameters](class_irtcengine.html#api_setvoicebeautifierparameters)
  - [setVoiceConversionPreset](class_irtcengine.html#api_setvoiceconversionpreset)

### Parameters

- preset

  The preset voice beautifier effect options: [VOICE_BEAUTIFIER_PRESET](rtc_api_data_type.html#enum_voicebeautifierpreset).

### Returns

- 0: Success.
- < 0: Failure.

## [setVoiceConversionPreset](class_irtcengine.html#api_setvoiceconversionpreset)

Sets a preset voice beautifier effect.

```cpp
virtual int setVoiceConversionPreset(VOICE_CONVERSION_PRESET preset) = 0;
```

Call this method to set a preset voice beautifier effect for the local user who sends an audio stream. After setting an audio effect, all users in the channel can hear the effect. You can set different audio effects for different scenarios. See Set the Voice Beautifier and Audio Effects.

To achieve better audio effect quality, Agora recommends that you call [setAudioProfile [1/2\]](class_irtcengine.html#api_setaudioprofile) and set the **profile** to AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4) or AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5) and **scenario** to AUDIO_SCENARIO_GAME_STREAMING(3) before calling this method.

**Note**

- You can call this method either before or after joining a channel.

- Do not setsetAudioProfile [1/2] the **profile** parameter in to AUDIO_PROFILE_SPEECH_STANDARD(1) or AUDIO_PROFILE_IOT(6), or the method does not take effect.

- This method works best with the human voice. Agora does not recommend using this method for audio containing music.

- After calling

   

  setVoiceConversionPreset

  , Agora recommends not calling the following methods, or the settings in

   

  setVoiceConversionPreset

   

  are overridden :

  - [setAudioEffectPreset](class_irtcengine.html#api_setaudioeffectpreset)
  - [setAudioEffectParameters](class_irtcengine.html#api_setaudioeffectparameters)
  - [setVoiceBeautifierPreset](class_irtcengine.html#api_setvoicebeautifierpreset)
  - [setVoiceBeautifierParameters](class_irtcengine.html#api_setvoicebeautifierparameters)
  - [setLocalVoiceReverbPreset](class_irtcengine.html#api_setlocalvoicereverbpreset)
  - [setLocalVoiceChanger](class_irtcengine.html#api_setlocalvoicechanger)
  - [setLocalVoicePitch](class_irtcengine.html#api_setlocalvoicepitch)
  - [setLocalVoiceEqualization](class_irtcengine.html#api_setlocalvoiceequalization)
  - [setLocalVoiceReverb](class_irtcengine.html#api_setlocalvoicereverb)

### Parameters

- preset

  The options for the preset voice beautifier effects: [VOICE_CONVERSION_PRESET](rtc_api_data_type.html#enum_voiceconversionpreset).

### Returns

- 0: Success.
- < 0: Failure.

## [setVolumeOfEffect](class_irtcengine.html#api_setvolumeofeffect)

Sets the volume of a specified audio effect.

```cpp
virtual int setVolumeOfEffect(int soundId, int volume) = 0;
```



### Parameters

- soundId

  The audio effect ID. The ID of each audio effect file is unique.

- volume

  The playback volume. The value ranges from 0 to 100. The default value is 100, which represents the original volume.

### Returns

- 0: Success.
- < 0: Failure.

## [startAudioMixing [1/2\]](class_irtcengine.html#api_startaudiomixing)

Starts playing the music file.

```cpp
virtual int startAudioMixing(const char* filePath,
    bool loopback,
    bool replace,
    int cycle) = 0;
```

- Deprecated:

  Please use [startAudioMixing [2/2\]](class_irtcengine.html#api_startaudiomixing2) instead.

This method mixes the specified local or online audio file with the audio from the microphone, or replaces the microphone's audio with the specified local or remote audio file. A successful method call triggers the [onAudioMixingStateChanged](class_irtcengineeventhandler.html#callback_onaudiomixingstatechanged_ng) (AUDIO_MIXING_STATE_PLAYING) callback. When the audio mixing file playback finishes, the SDK triggers the onAudioMixingStateChanged (AUDIO_MIXING_STATE_STOPPED) callback on the local client.

**Note**

- Call this method after joining a channel. If you need to call startAudioMixing [1/2] multiple times, ensure that the time interval between calling this method is more than 500 ms.
- If the local audio mixing file does not exist, or if the SDK does not support the file format or cannot access the music file URL, the SDK returns `WARN_AUDIO_MIXING_OPEN_ERROR` (701).

### Parameters

- filePath

  The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: `C:\music\audio.mp4`. Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. See [supported audio formats](https://docs.microsoft.com/en-us/windows/win32/medfound/supported-media-formats-in-media-foundation).

- loopback

  Whether to only play music files on the local client:`true`: Only play music files on the local client so that only the local user can hear the music.`false`: Publish music files to remote clients so that both the local user and remote users can hear the music.

- replace

  Whether to replace the audio captured by the microphone with a music file:`true`: Replace the audio captured by the microphone with a music file. Users can only hear the music.`false`: Do not replace the audio captured by the microphone with a music file. Users can hear both music and audio captured by the microphone.

- cycle

  The number of times the music file plays.≥ 0: The number of playback times. For example, 0 means that the SDK does not play the music file while 1 means that the SDK plays once.-1: Play the audio effect in an infinite loop.

### Returns

- 0: Success.
- < 0: Failure.

## [startAudioMixing [2/2\]](class_irtcengine.html#api_startaudiomixing2)

Starts playing the music file.

```cpp
virtual int startAudioMixing(const char* filePath, bool loopback, bool replace, int cycle, int startPos) = 0;
```

This method mixes the specified local or online audio file with the audio from the microphone, or replaces the microphone's audio with the specified local or remote audio file. A successful method call triggers the [onAudioMixingStateChanged](class_irtcengineeventhandler.html#callback_onaudiomixingstatechanged_ng) (`PLAY`) callback. When the audio mixing file playback finishes, the SDK triggers the onAudioMixingStateChanged (`STOPPED`) callback on the local client.

**Note**

- Call this method after joining a channel. If you need to call startAudioMixing [2/2] multiple times, ensure that the time interval between calling this method is more than 500 ms.
- If the local audio mixing file does not exist, or if the SDK does not support the file format or cannot access the music file URL, the SDK returns `WARN_AUDIO_MIXING_OPEN_ERROR` (701).

### Parameters

- filePath

  The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: `C:\music\audio.mp4`. Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. See [supported audio formats](https://docs.microsoft.com/en-us/windows/win32/medfound/supported-media-formats-in-media-foundation).

- loopcount

  Whether to only play music files on the local client:`true`: Only play music files on the local client so that only the local user can hear the music.`false`: Publish music files to remote clients so that both the local user and remote users can hear the music.

- replace

  Whether to replace the audio captured by the microphone with a music file:`true`: Replace the audio captured by the microphone with a music file. Users can only hear the music.`false`: Do not replace the audio captured by the microphone with a music file. Users can hear both music and audio captured by the microphone.

- cycle

  The number of times the music file plays.≥ 0: The number of playback times. For example, 0 means that the SDK does not play the music file while 1 means that the SDK plays once.-1: Play the music effect in an infinite loop.

- startPos

  The playback position (ms) of the music file.

### Returns

- 0: Success.
- < 0: Failure.

## [startAudioRecording](class_irtcengine.html#api_startaudiorecording3_ng)

Starts audio recording on the client.

```cpp
virtual int startAudioRecording(const AudioFileRecordingConfig& config) = 0;
```

The Agora SDK allows recording audio on the client during a call. After successfully calling this method, you can record the audio of users in the channel and get an audio recording file. Supported formats of the recording file are as follows:

- WAV: High-fidelity files with typically larger file sizes. For example, if the sample rate is 32,000 Hz, the file size for 10-minute recording is approximately 73 MB.
- AAC: Low-fidelity files with typically smaller file sizes. For example, if the sample rate is 32,000 Hz and the recording quality is AUDIO_RECORDING_QUALITY_MEDIUM, the file size for 10-minute recording is approximately 2 MB.

Once the user leaves the channel, the recording automatically stops.

**Note** Call this method after joining a channel.

### Parameters

- config

  Recording configuration. See [AudioRecordingConfiguration](rtc_api_data_type.html#class_audiorecordingconfiguration_ng).

### Returns

- 0: Success.
- < 0: Failure.

## [startChannelMediaRelay](class_irtcengine.html#api_startchannelmediarelay)

Starts relaying media streams across channels. This method can be used to implement scenarios such as co-host across channels.

```cpp
virtual int startChannelMediaRelay(const ChannelMediaRelayConfiguration &configuration) = 0;
```

After a successful method call, the SDK triggers the [onChannelMediaRelayStateChanged](class_irtcengineeventhandler.html#callback_onchannelmediarelaystatechanged) and [onChannelMediaRelayEvent](class_irtcengineeventhandler.html#callback_onchannelmediarelayevent) callbacks, and these callbacks return the state and events of the media stream relay.

- If the onChannelMediaRelayStateChanged callback returns RELAY_STATE_RUNNING (2) and RELAY_OK (0), and the onChannelMediaRelayEvent callback returns RELAY_EVENT_PACKET_SENT_TO_DEST_CHANNEL (4), it means that the SDK starts relaying media streams between the source channel and the destination channel.
- If the onChannelMediaRelayStateChanged callback returns RELAY_STATE_FAILURE (3), an exception occurs during the media stream relay.

**Note**

- Call this method after joining the channel.
- This method takes effect only when you are a host in a live streaming channel.
- After a successful method call, if you want to call this method again, ensure that you call the [stopChannelMediaRelay](class_irtcengine.html#api_stopchannelmediarelay) method to quit the current relay.
- Contact [support@agora.io](https://agora-ticket.agora.io/) before implementing this function.
- We do not support string user accounts in this API.

### Parameters

- configuration

  The configuration of the media stream relay. For details, see [ChannelMediaRelayConfiguration](rtc_api_data_type.html#class_channelmediarelayconfiguration).

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onChannelMediaRelayStateChanged](../API/class_irtcengineeventhandler.html#callback_onchannelmediarelaystatechanged)
- [onChannelMediaRelayEvent](../API/class_irtcengineeventhandler.html#callback_onchannelmediarelayevent)

## [startEchoTest [1/2\]](class_irtcengine.html#api_startechotest)

Starts an audio call test.

```cpp
virtual int startEchoTest() = 0;
```

- Deprecated:

  This method is deprecated as of v2.4.0. Use [startEchoTest [2/2\]](class_irtcengine.html#api_startechotest2) instead.

This method starts an audio call test to determine whether the audio devices (for example, headset and speaker) and the network connection are working properly. To conduct the test, the user speaks, and the recording is played back within 10 seconds. If the user can hear the recording within the interval, the audio devices and network connection are working properly.

**Note**

- Call this method before joining a channel.
- After calling [stopEchoTest](class_irtcengine.html#api_stopechotest), you must call startEchoTest [1/2] to end the test. Otherwise, the app cannot perform the next echo test, and you cannot join the channel.
- In the live streaming channels, only a host can call this method.

### Returns

- 0: Success.
- < 0: Failure.

## [startEchoTest [2/2\]](class_irtcengine.html#api_startechotest2)

Starts an audio call test.

```cpp
virtual int startEchoTest(int intervalInSeconds) = 0;
```

This method starts an audio call test to determine whether the audio devices (for example, headset and speaker) and the network connection are working properly. To conduct the test, let the user speak for a while, and the recording is played back within the set interval. If the user can hear the recording within the interval, the audio devices and network connection are working properly.

**Note**

- Call this method before joining a channel.
- After calling [stopEchoTest](class_irtcengine.html#api_stopechotest), you must call startEchoTest [2/2] to end the test. Otherwise, the app cannot perform the next echo test, and you cannot join the channel.
- In the live streaming channels, only a host can call this method.

### Parameters

- intervalInSeconds

  The time interval (s) between when you speak and when the recording plays back.

### Returns

- 0: Success.
- < 0: Failure.

## [startLastmileProbeTest](class_irtcengine.html#api_startlastmileprobetest)

Starts the last mile network probe test.

```cpp
virtual int startLastmileProbeTest(const LastmileProbeConfig& config) = 0;
```

This method starts the last-mile network probe test before joining a channel to get the uplink and downlink last mile network statistics, including the bandwidth, packet loss, jitter, and round-trip time (RTT).

Once this method is enabled, the SDK returns the following callbacks:

- [onLastmileQuality](class_irtcengineeventhandler.html#callback_onlastmilequality): The SDK triggers this callback within two seconds depending on the network conditions. This callback rates the network conditions and is more closely linked to the user experience.
- [onLastmileProbeResult](class_irtcengineeventhandler.html#callback_onlastmileproberesult): The SDK triggers this callback within 30 seconds depending on the network conditions. This callback returns the real-time statistics of the network conditions and is more objective.

This method applies to the following scenarios:

- Before a user joins a channel, call this method to check the uplink network quality.
- In a live streaming channel, call this method to check the uplink network quality before an audience member switches to a host.

**Note**

- Do not call other methods before receiving the onLastmileQuality and onLastmileProbeResult callbacks. Otherwise, the callbacks may be interrupted.
- A host should not call this method after joining a channel (when in a call).

### Parameters

- config

  The configurations of the last-mile network probe test. See [LastmileProbeConfig](rtc_api_data_type.html#class_lastmileprobeconfig).

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onLastmileQuality](../API/class_irtcengineeventhandler.html#callback_onlastmilequality)
- [onLastmileProbeResult](../API/class_irtcengineeventhandler.html#callback_onlastmileproberesult)

## [startPreview](class_irtcengine.html#api_startpreview)

Enables the local video preview.

```cpp
virtual int startPreview() = 0;
```

This method starts the local video preview before joining the channel. Before calling this method, ensure that you do the following:

- Call [setupLocalVideo](class_irtcengine.html#api_setuplocalvideo) to set the local preview window.
- Call [enableVideo](class_irtcengine.html#api_enablevideo) to enable the video.

**Note**

- The local preview enables the mirror mode by default.
- After the local video preview is enabled, if you call [leaveChannel [1/2\]](class_irtcengine.html#api_leavechannel) to exit the channel, the local preview remains until you call [stopPreview](class_irtcengine.html#api_stoppreview) to disable it.

### Returns

- 0: Success.
- < 0: Failure.

## [startPrimaryCameraCapture](class_irtcengine.html#api_startprimarycameracapture)

Starts video capture with a primary camera.

```cpp
virtual int startPrimaryCameraCapture(const CameraCapturerConfiguration& config) = 0;
```

### Parameters

- config

  The configuration of the video capture with a primary camera. For details, see [CameraCapturerConfiguration](rtc_api_data_type.html#class_cameracapturerconfiguration_ng).

### Returns

- 0: Success.
- < 0: Failure.

## [startPrimaryScreenCapture](class_irtcengine.html#api_startprimaryscreencapture)

Starts video capture with a primary camera.

```cpp
virtual int startPrimaryScreenCapture(const ScreenCaptureConfiguration& config) = 0;
```

### Parameters

- config

  The configuration of the video capture with a primary camera. For details, see [ScreenCaptureConfiguration](rtc_api_data_type.html#class_screencaptureconfiguration).

### Returns

- 0: Success.
- < 0: Failure.

## [startRhythmPlayer](class_irtcengine.html#api_startrhythmplayer)

Enables the virtual metronome.

```cpp
virtual int startRhythmPlayer(const char* sound1, const char* sound2, const AgoraRhythmPlayerConfig& config) = 0;
```

In music education, physical education and other scenarios, teachers usually need to use a metronome so that students can practice with the correct beat. The meter is composed of a downbeat and upbeats. The first beat of each measure is called a downbeat, and the rest are called upbeats.

In this method, you need to set the paths of the upbeat and downbeat files, the number of beats per measure, the tempo, and whether to send the sound of the metronome to remote users.

**Note**

- This method is for Android and iOS only.
- After enabling the virtual metronome, the SDK plays the specified audio effect file from the beginning, and controls the playback duration of each file according to **beatsPerMinute** you set in [AgoraRhythmPlayerConfig](rtc_api_data_type.html#class_agorarhythmplayerconfig). For example, if you set **beatsPerMinute** as `60`, the SDK plays one beat every second. If the file duration exceeds the beat duration, the SDK only plays the audio within the beat duration.

### Parameters

- sound1

  The absolute path or URL address (including the filename extensions) of the file for the downbeat. For example: `C:\music\audio.mp4`. For the audio file formats supported by this method, see [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).

- sound2

  The absolute path or URL address (including the filename extensions) of the file for the upbeats. For example: `C:\music\audio.mp4`. For the audio file formats supported by this method, see [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).

- config

  The metronome configuration. See [AgoraRhythmPlayerConfig](rtc_api_data_type.html#class_agorarhythmplayerconfig).

### Returns

- 0: Success.
- < 0: Failure.
  - -22: Cannot find audio effect files. Please set the correct paths for **sound1** and **sound2**.

## [startScreenCapture](class_irtcengine.html#api_startscreencapture_ng)

Starts screen sharing.

```cpp
virtual int startScreenCapture(void* mediaProjectionPermissionResultData,
                               const ScreenCaptureParameters& captureParams) = 0;
```

After successfully calling this method, you can share the entire screen through [MediaProjection](https://developer.android.google.en/reference/android/media/projection/MediaProjection).

**Note**

- This method is for Android only.
- Call this method after joining a channel.
- Before calling this method, you need to implement [onActivityResult](https://developer.android.google.en/reference/android/preference/PreferenceManager.OnActivityResultListener?hl=en#onActivityResult(int, int, android.content.Intent)), an Android native callback, and obtain the value of the **data** parameter in this callback.
- When sharing the screen on Android 10 or later, to avoid the Android system from triggering [SecurityException](https://developer.android.google.en/reference/java/lang/SecurityException), you need to call [startForeground](https://developer.android.google.en/guide/components/foreground-services?hl=en#start) (the Android native method) before calling [MediaProjection](https://developer.android.google.en/reference/android/media/projection/MediaProjection) to notify the user that the current device starts screen sharing.

### Parameters

- mediaProjectionPermissionResultData

  Pass in the **data** parameter of the onActivity callback.

- captureParams

  The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. For details, see [ScreenCaptureParameters](rtc_api_data_type.html#class_screencaptureparameters).

### Returns

- 0: Success.
- < 0: Failure.
  - -2(`ERR_INVALID_ARGUMENT`): The **mediaProjectionPermissionResultData** parameter is null.

## [startScreenCaptureByDisplayId](class_irtcengine.html#api_startscreencapturebydisplayid)

Shares the screen by specifying the display ID.



```cpp
virtual int startScreenCaptureByDisplayId(unsigned int displayId, const Rectangle& regionRect,
                const ScreenCaptureParameters& captureParams) = 0;
            
```

This method shares a screen or part of the screen. You need to specify the ID of the screen to be shared in this method.

**Note**

- This method applies to macOS only.
- Call this method after joining a channel.

### Parameters

- displayId

  The display ID of the screen to be shared. This parameter specifies which screen you want to share.

- regionRect

  (Optional) Sets the relative location of the region to the screen. If you do not set this parameter, the SDK shares the whole screen. For details, see [Rectangle](rtc_api_data_type.html#class_rectangle). If the specified region overruns the screen, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen.

- captureParams

  Screen sharing configurations. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. For details, see [ScreenCaptureParameters](rtc_api_data_type.html#class_screencaptureparameters).

### Returns

- 0: Success.
- < 0: Failure.

## [startScreenCaptureByScreenRect](class_irtcengine.html#api_startscreencapturebyscreenrect)

Shares the whole or part of a screen by specifying the screen rect.

```cpp
virtual int startScreenCaptureByScreenRect(const Rectangle& screenRect, 
     const Rectangle& regionRect, 
     const ScreenCaptureParameters& captureParams) = 0;
```

This method shares a screen or part of the screen. You need to specify the area of the screen to be shared.

**Note** Call this method after joining a channel.

### Parameters

- screenRect

  Sets the relative location of the screen to the virtual screen.

- regionRect

  (Optional) Sets the relative location of the region to the screen. If you do not set this parameter, the SDK shares the whole screen. See [Rectangle](rtc_api_data_type.html#class_rectangle). If the specified region overruns the screen, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen.

- captureParams

  The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See [ScreenCaptureParameters](rtc_api_data_type.html#class_screencaptureparameters).

### Returns

- 0: Success.
- < 0: Failure.

## [startScreenCaptureByWindowId](class_irtcengine.html#api_startscreencapturebywindowid)

Shares the whole or part of a window by specifying the window ID.



```cpp
virtual int startScreenCaptureByWindowId(view_t windowId,
                const Rectangle& regionRect,
                const ScreenCaptureParameters& captureParams) = 0;
```

This method shares a window or part of the window. You need to specify the ID of the window to be shared.

**Note**

- Call this method after joining a channel.
- This method applies to macOS and Windows only.

Since v3.0.0, this method supports window sharing of UWP (Universal Windows Platform) applications. Agora tests the mainstream UWP applications by using the lastest SDK, see details as follows:

| **System version**                  | **Software**   | **Compatible versions** | **Support** |
| ----------------------------------- | -------------- | ----------------------- | ----------- |
| win10                               | Chrome         | 76.0.3809.100           | No          |
| Office Word                         | 18.1903.1152.0 | Yes                     |             |
| Office Excel                        | No             |                         |             |
| Office PPT                          | Yes            |                         |             |
| WPS Word                            | 11.1.0.9145    | Yes                     |             |
| WPS Excel                           |                |                         |             |
| WPS PPT                             |                |                         |             |
| Media Player (come with the system) | All            | Yes                     |             |
| win8                                | Chrome         | All                     | Yes         |
| Office Word                         | All            | Yes                     |             |
| Office Excel                        |                |                         |             |
| Office PPT                          |                |                         |             |
| WPS Word                            | 11.1.0.9098    | Yes                     |             |
| WPS Excel                           |                |                         |             |
| WPS PPT                             |                |                         |             |
| Media Player (come with the system) | All            | Yes                     |             |
| win7                                | Chrome         | 73.0.3683.103           | No          |
| Office Word                         | All            | Yes                     |             |
| Office Excel                        |                |                         |             |
| Office PPT                          |                |                         |             |
| WPS Word                            | 11.1.0.9098    | No                      |             |
| WPS Excel                           |                |                         |             |
| WPS PPT                             | 11.1.0.9098    | Yes                     |             |
| Media Player (come with the system) | All            | No                      |             |

### Parameters

- windowId

  The ID of the window to be shared.

- regionRect

  (Optional) Sets the relative location of the region to the screen. If you do not set this parameter, the SDK shares the whole screen. For details, see [Rectangle](rtc_api_data_type.html#class_rectangle). If the specified region overruns the window, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole window.

- captureParams

  Screen sharing configurations. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. For details, see [ScreenCaptureParameters](rtc_api_data_type.html#class_screencaptureparameters).

### Returns

- 0: Success.
- < 0: Failure.

## [startSecondaryCameraCapture](class_irtcengine.html#api_startsecondarycameracapture)

Starts video capture with a secondary camera.

```cpp
virtual int startSecondaryCameraCapture(const CameraCapturerConfiguration& config) = 0;
```

### Parameters

- config

  The configuration of the video capture with a primary camera. For details, see [CameraCapturerConfiguration](rtc_api_data_type.html#class_cameracapturerconfiguration_ng).

### Returns

- 0: Success.
- < 0: Failure.

## [startSecondaryScreenCapture](class_irtcengine.html#api_startsecondaryscreencapture)

Starts sharing a secondary screen.

```cpp
virtual int startSecondaryScreenCapture(const ScreenCaptureConfiguration& config) = 0;
```

### Parameters

- config

  The configuration of the captured screen. For details, see [ScreenCaptureConfiguration](rtc_api_data_type.html#class_screencaptureconfiguration).

### Returns

- 0: Success.
- < 0: Failure.

## [stopAllEffects](class_irtcengine.html#api_stopalleffects)

Stops playing all audio effects.

```cpp
virtual int stopAllEffects() = 0;
```

### Returns

- 0: Success.
- < 0: Failure.

## [stopAudioMixing](class_irtcengine.html#api_stopaudiomixing)

Stops playing and mixing the music file.

```cpp
virtual int stopAudioMixing() = 0;
```

This method stops the audio mixing. Call this method when you are in a channel.

### Returns

- 0: Success.
- < 0: Failure.

## [stopAudioRecording](class_irtcengine.html#api_stopaudiorecording)

Stops the audio recording on the client.

```cpp
virtual int stopAudioRecording() = 0;
```

If you call [startAudioRecording](class_irtcengine.html#api_startaudiorecording3_ng) to start recording, you can call this method to stop the recording.

**Note** Once the user leaves the channel, the recording automatically stops.

### Returns

- 0: Success.
- < 0: Failure.

## [stopChannelMediaRelay](class_irtcengine.html#api_stopchannelmediarelay)

Stops the media stream relay. Once the relay stops, the host quits all the destination channels.

```cpp
virtual int stopChannelMediaRelay() = 0;
```

After a successful method call, the SDK triggers the [onChannelMediaRelayStateChanged](class_irtcengineeventhandler.html#callback_onchannelmediarelaystatechanged) callback. If the callback reports RELAY_STATE_IDLE (0) and RELAY_OK (0), the host successfully stops the relay.

**Note** If the method call fails, the SDK triggers the onChannelMediaRelayStateChanged callback with the RELAY_ERROR_SERVER_NO_RESPONSE (2) or RELAY_ERROR_SERVER_CONNECTION_LOST (8) status code. You can call the [leaveChannel [1/2\]](class_irtcengine.html#api_leavechannel) method to leave the channel, and the media stream relay automatically stops.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onChannelMediaRelayStateChanged](../API/class_irtcengineeventhandler.html#callback_onchannelmediarelaystatechanged)

## [stopEchoTest](class_irtcengine.html#api_stopechotest)

Stops the audio call test.

```cpp
virtual int stopEchoTest() = 0;
```

### Returns

- 0: Success.
- < 0: Failure.
  - -5(ERR_REFUSED): Failed to stop the echo test. The echo test may not be running.

## [stopEffect](class_irtcengine.html#api_stopeffect)

Stops playing a specified audio effect.

```cpp
virtual int stopEffect(int soundId) = 0;
```

### Parameters

- soundId

  The audio effect ID. The ID of each audio effect file is unique.

### Returns

- 0: Success.
- < 0: Failure.

## [stopLastmileProbeTest](class_irtcengine.html#api_stoplastmileprobetest)

Stops the last mile network probe test.

```cpp
virtual int stopLastmileProbeTest() = 0;
```



### Returns

- 0: Success.
- < 0: Failure.

## [stopPreview](class_irtcengine.html#api_stoppreview)

Stops the local video preview.

```cpp
virtual int stopPreview() = 0;
```

### Returns

- 0: Success.
- < 0: Failure.

## [stopPrimaryCameraCapture](class_irtcengine.html#api_stopprimarycameracapture)

Stops capturing video through the first camera.

```cpp
virtual int stopPrimaryCameraCapture() = 0;
```

You can call this method to stop capturing video through the first camera after calling the [startPrimaryCameraCapture](class_irtcengine.html#api_startprimarycameracapture).

### Returns

- 0: Success.
- < 0: Failure.

## [stopPrimaryScreenCapture](class_irtcengine.html#api_stopprimaryscreencapture)

Stop sharing the first screen.

```cpp
virtual int stopPrimaryScreenCapture() = 0;
```

After calling [startPrimaryScreenCapture](class_irtcengine.html#api_startprimaryscreencapture), you can call this method to stop sharing the first screen.

### Returns

- 0: Success.
- < 0: Failure.

## [stopRhythmPlayer](class_irtcengine.html#api_stoprhythmplayer)

Disables the virtual metronome.



```cpp
virtual int stopRhythmPlayer() = 0;
```

After calling [startRhythmPlayer](class_irtcengine.html#api_startrhythmplayer), you can call this method to disable the virtual metronome.

**Note** This method is for Android and iOS only.

### Returns

- 0: Success.
- < 0: Failure.

## [stopScreenCapture](class_irtcengine.html#api_stopscreencapture)

Stops screen sharing.

```cpp
virtual int stopScreenCapture() = 0;
```

### Returns

- 0: Success.
- < 0: Failure.

## [stopSecondaryCameraCapture](class_irtcengine.html#api_stopsecondarycameracapture)

Stops capturing video through the second camera.

```cpp
virtual int stopSecondaryCameraCapture() = 0;
```

You can call this method to stop capturing video through the second camera after calling the [startSecondaryCameraCapture](class_irtcengine.html#api_startsecondarycameracapture).

### Returns

- 0: Success.
- < 0: Failure.

## [stopSecondaryScreenCapture](class_irtcengine.html#api_stopsecondaryscreencapture)

Stop sharing the second screen.

```cpp
virtual int stopSecondaryScreenCapture() = 0;
```

After calling [startSecondaryScreenCapture](class_irtcengine.html#api_startsecondaryscreencapture), you can call this method to stop sharing the second screen.

### Returns

- 0: Success.
- < 0: Failure.

## [switchCamera](class_irtcengine.html#api_switchcamera)

Switches between front and rear cameras.

```cpp
virtual int switchCamera() = 0;
```

This method needs to be called after the camera is started (for example, by calling [startPreview](class_irtcengine.html#api_startpreview) or [joinChannel [2/2\]](class_irtcengine.html#api_joinchannel2_ng)).

**Note** This method is for Android and iOS only.

### Returns

- 0: Success.
- < 0: Failure.

## [takeSnapshot](class_irtcengine.html#api_takesnapshot)

Takes a snapshot of a video stream.



```cpp
virtual int takeSnapshot(const char* channel, uid_t uid, const char* filePath) = 0;
```

This method takes a snapshot of a video stream from the specified user, generates a JPG image, and saves it to the specified path.

The method is asynchronous, and the SDK has not taken the snapshot when the method call returns. After a successful method call, the SDK triggers [onSnapshotTaken](class_irtcengineeventhandler.html#callback_onsnapshottaken) callback to report whether the snapshot is successfully taken as well as the details for the snapshot taken.

**Note**

- Call this method after joining a channel.
- If the video of the specified user is pre-processed, for example, added with watermarks or image enhancement effects, the generated snapshot also includes the pre-processing effects.

### Parameters

- channel

  The channel name.

- uid

  The user ID. Set **uid** as 0 if you want to take a snapshot of the local user's video.

- filePath

  The local path (including the filename extensions) of the snapshot. For example,Windows: C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.jpgiOS: /App Sandbox/Library/Caches/example.jpgmacOS: ～/Library/Logs/example.jpgAndroid: /storage/emulated/0/Android/data/<package name>/files/example.jpgEnsure that the path you specify exists and is writable.

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onSnapshotTaken](../API/class_irtcengineeventhandler.html#callback_onsnapshottaken)

## [unloadAllEffects](class_irtcengine.html#api_unloadalleffects)

releases a specified preloaded audio effect from the memory.

```cpp
virtual int unloadAllEffects() = 0;
```

### Returns

- 0: Success.
- < 0: Failure.

## [unloadEffect](class_irtcengine.html#api_unloadeffect)

Releases a specified preloaded audio effect from the memory.

```cpp
virtual int unloadEffect(int soundId) = 0;
```

### Parameters

- soundId

  The audio effect ID. The ID of each audio effect file is unique.

### Returns

- 0: Success.
- < 0: Failure.

## [unregisterAudioSpectrumObserver](class_irtcengine.html#api_unregisteraudiospectrumobserver)

Unregisters the audio spectrum observer.

```cpp
virtual int unregisterAudioSpectrumObserver(agora::media::IAudioSpectrumObserver * observer) = 0;
```

After calling [registerAudioSpectrumObserver](class_irtcengine.html#api_registeraudiospectrumobserver), if you want to disable audio spectrum monitoring, you can call this method.

**Note** You can call this method either before or after joining a channel.

### Parameters

- observer

  The Audio spectrum observer. For details, see [IAudioSpectrumObserver](class_iaudiospectrumobserver.html#class_iaudiospectrumobserver).

### Returns

- 0: Success.
- < 0: Failure.

## [unregisterMediaMetadataObserver](class_irtcengine.html#api_unregistermediametadataobserver)

Unregisters the specified metadata observer.

```cpp
virtual int unregisterMediaMetadataObserver(IMetadataObserver* observer, IMetadataObserver::METADATA_TYPE type) = 0;
```

### Parameters

- observer

  The metadata observer. See [IMetadataObserver](class_imetadataobserver.html#class_imetadataobserver).

- type

  The metadata type. The SDK currently only supports VIDEO_METADATA. For details, see [METADATA_TYPE](class_imetadataobserver.html#enum_metadatatype).

### Returns

- 0: Success.
- < 0: Failure.

## [updateChannelMediaOptions](class_irtcengine.html#api_updatechannelmediaoptions)

Updates the channel media options after joining the channel.

### Parameters

- options

  The channel media options. See [ChannelMediaOptions](rtc_api_data_type.html#class_channelmediaoptions_ng).

### Returns

- 0: Success.
- < 0: Failure.

## [updateChannelMediaRelay](class_irtcengine.html#api_updatechannelmediarelay)

Updates the channels for media stream relay.

```cpp
virtual int updateChannelMediaRelay(const ChannelMediaRelayConfiguration &configuration) = 0;
```

After the media relay starts, if you want to relay the media stream to more channels, or leave the current relay channel, you can call the updateChannelMediaRelay method.

After a successful method call, the SDK triggers the [onChannelMediaRelayEvent](class_irtcengineeventhandler.html#callback_onchannelmediarelayevent) callback with the RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL (7) state code.

**Note** Call this method after the [startChannelMediaRelay](class_irtcengine.html#api_startchannelmediarelay) method to update the destination channel.

### Parameters

- configuration

  The configuration of the media stream relay. For more details, see [ChannelMediaRelayConfiguration](rtc_api_data_type.html#class_channelmediarelayconfiguration).

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onChannelMediaRelayEvent](../API/class_irtcengineeventhandler.html#callback_onchannelmediarelayevent)

## [updateScreenCaptureParameters](class_irtcengine.html#api_updatescreencaptureparameters)

Updates the screen sharing parameters.

```cpp
virtual int updateScreenCaptureParameters(const ScreenCaptureParameters& captureParams) = 0;
```



### Parameters

- captureParams

  The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. For details, see [ScreenCaptureParameters](rtc_api_data_type.html#class_screencaptureparameters).

### Returns

- 0: Success.
- < 0: Failure.

## [updateScreenCaptureRegion](class_irtcengine.html#api_updatescreencaptureregion)

Updates the screen sharing region.

```cpp
virtual int updateScreenCaptureRegion(const Rectangle& regionRect) = 0;
```



### Parameters

- regionRect

  The relative location of the screen-shared area to the screen or window. If you do not set this parameter, the SDK shares the whole screen or window. See [Rectangle](rtc_api_data_type.html#class_rectangle). If the specified region overruns the screen or window, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen or window.

### Returns

- 0: Success.
- < 0: Failure.
  - -3(ERR_NOT_READY): No screen or window is being shared.