# v4.2.0

v4.2.0 was released on May xx, 2023.

## Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

**1. Video capture (Windows/iOS)**

This release optimizes the APIs for camera and screen capture function. As of v4.2.0, ensure you use the alternative methods listed in the table below and specify the video source by setting the `sourceType` parameter.

| Deleted Methods                                              | Alternative Methods       |
| :----------------------------------------------------------- | :------------------------ |
| <li>`StartPrimaryCameraCapture`（Windows）</li><li>`StartSecondaryCameraCapture`（Windows，iOS）<li> | `StartCameraCapture`      |
| <li>`StopPrimaryCameraCapture`（Windows）</li><li>`StopSecondaryCameraCapture`（Windows，iOS）</li> | `StopCameraCapture`       |
| <li>`StartPrimaryScreenCapture `（Windows）</li>`StartSecondaryScreenCapture`（Windows，iOS）</li> | `StartScreenCapture`[2/2] |
| <li>`StopPrimaryScreenCapture`（Windows）</li><li>`StopSecondaryScreenCapture`（Windows，iOS）</li> | `StopScreenCapture`[2/2]  |

**2. Video rendering**

自该版本起，声网 Unity SDK 不支持同时使用 `VideoSurface` 和 `VideoSurfaceYUV` 来渲染不同的视频源。在成功创建 `IRtcEngine` 后，如果第一个视图是通过 `VideoSurfaceYUV` 渲染，则在整个 `IRtcEngine` 生命周期中，`VideoSurfaceYUV` 渲染。

**2. Video data acquisition**

- The `onCaptureVideoFrame` and `onPreEncodeVideoFrame` callbacks are added with a new parameter called `sourceType`, which is used to indicate the specific video source type.
- The following callbacks are deleted. Get the video source type through the `sourceType` parameter in the `onPreEncodeVideoFrame` and `onCaptureVideoFrame` callbacks.
  - `onSecondaryPreEncodeCameraVideoFrame`
  - `onScreenCaptureVideoFrame`
  - `onPreEncodeScreenVideoFrame`
  - `onSecondaryPreEncodeScreenVideoFrame`

**3. Channel media options**

- `publishCustomAudioTrackEnableAec` in `ChannelMediaOptions` is deleted. Use `publishCustomAudioTrack` instead.
- `publishTrancodedVideoTrack` in `ChannelMediaOptions` is renamed to `publishTranscodedVideoTrack`.
- `publishCustomAudioSourceId` in `ChannelMediaOptions` is renamed to `publishCustomAudioTrackId`.

**
**

**4. Audio and video recording**

- `AGORA_IID_MEDIA_RECORDER` in `INTERFACE_ID_TYPE` is deleted. As of v4.2.0, before creating a recording object, you don't need to obtain the `AGORA_IID_MEDIA_RECORDER` interface class pointer. You can directly create a recording object through the `createMediaRecorder` method released in this version. (Win)
- `getMediaRecorder` is deleted. You can create a recording object through the `createMediaRecorder` method released in this version. (Android,iOS,macOS)
- The `connection` parameter in the `startRecording`, `stopRecording`, and `setMediaRecorderObserver` methods is deleted.
- The `release` method in the `IMediaRecorder` class is deleted. You can use the `destroyMediaRecorder `method released in this version to destroy a recording object and release resources. (exclude unity)

**
**

**5. Local video mixing (Windows)**

- The `VideoInputStreams` in `LocalTranscoderConfiguration` is changed to `videoInputStreams.`
- The `MEDIA_SOURCE_TYPE` in `TranscodingVideoStream` is changed to `VIDEO_SOURCE_TYPE.`

**
**

**6. Virtual sound card (macOS)**

As of v4.2.0, Agora supports third-party virtual sound cards. You can use a third-party virtual sound card as the audio input or output device for the SDK. You can use the `stateChanged` callback to see whether the current input or output device selected by the SDK is a virtual sound card.



If you set AgoraALD or Soundflower as the default input or output device when joining a channel, you will not hear audio.

**7. Miscellaneous**

- `onApiCallExecuted` is deleted. Agora recommends getting the results of the API implementation through relevant channels and media callbacks.

- ```
  The IAudioFrameObserver
  ```

   class is renamed to

  ```
  IAudioPcmFrameSink
  ```

  ,



  thus the prototype of the following methods are updated accordingly

  : (Windows/unity)

  - `onFrame`
  - `registerAudioFrameObserver` [1/2] and `registerAudioFrameObserver`[2/2] in `IMediaPlayer`

  Flutter/rn/elec:

  - `onFrame`
  - `registerAudioFrameObserver` and `unregisterAudioFrameObserver `in `IMediaPlayer`

- `enableDualStreamMode`[1/2] and `enableDualStreamMode`[2/2] are depredated. Use `setDualStreamMode`[1/2] and `setDualStreamMode`[2/2] instead.

- `startChannelMediaRelay`, `updateChannelMediaRelay`, `startChannelMediaRelayEx` and `updateChannelMediaRelayEx` are deprecated. Use `startOrUpdateChannelMediaRelay`and `startOrUpdateChannelMediaRelayEx` instead.

## New features

**1. AI noise reduction**

This release introduces the AI noise reduction function. Once enabled, the SDK automatically detects and reduces background noises. Whether in bustling public venues or real-time competitive arenas that demand lightning-fast responsiveness, this function guarantees optimal audio clarity, providing users with an elevated audio experience. You can enable this function through the newly-introduced `setAINSMode` method and set the noise reduction mode as balance, aggressive or low latency according to your scenarios.



**2.** **Enhanced Virtual Background**

To increase the fun of real-time video calls and protect user privacy, this version has enhanced the virtual background feature. You can now set custom backgrounds of various types by calling the `enableVirtualBackground` method, including:

- Process the background as alpha information without replacement, only separating the portrait and the background. This can be combined with the local video mixing feature to achieve a portrait-in-picture effect.
- Replace the background with various formats of local videos.



**3. Video scenario settings**

This release introduces `setVideoScenario` for setting the video application scene. The SDK will automatically enable the best practice strategy based on different scenes, adjusting key performance indicators to optimize video quality and improve user experience. Whether it is a formal business meeting or a casual online gathering, this feature ensures that the video quality meets the requirements.

Currently, this feature provides targeted optimizations for real-time video conferencing scenarios, including:

- Automatically activate multiple anti-weak network technologies to enhance the capability and performance of low-quality video streams in meeting scenarios where high bitrates are required, ensuring smoothness when multiple streams are subscribed by the receiving end.
- Monitor the number of subscribers for the high-quality and low-quality video streams in real time, dynamically adjusting the configuration of the high-quality stream and dynamically enabling or disabling the low-quality stream, to save uplink bandwidth and consumption.

**4. Recording audio and video of remote users  (Hide this feature in the EN release notes)**

This release supports local users recording the audio and video streams published by remote users. This function can be used in various scenarios such as online education, training and meeting. To provide more accurate reporting of the recording status, this version introduces the `channelId` and `uid` parameters in the `onRecorderStateChanged` and `onRecorderInfoUpdated`callbacks. These parameters indicate specific information about the recorded audio and video streams. Additionally, a new `createMediaRecorder` method is released to create a local or remote recording object.

You can experience this function through the following APIs:

- `createMediaRecorder`: Creates a recording object. If you need to recording the audio and video of both local and remote users at the same time, you can call this method as necessary to create recording objects.
- `setMediaRecorderObserver`: Registers a recording observer.
-  `startRecording`: Starts a recording.
- `stopRecording`: Stops a recording.
- `destroyMediaRecorder`: Destroys a recording object.

**
**

**4. Local video mixing (Mac\iOS\Android)**

This release adds the local video mixing feature. You can use the `startLocalVideoTranscoder` method to mix and render multiple video streams locally, such as camera-captured video, screen sharing streams, video files, images, etc. This allows you to achieve custom layouts and effects, making it easy to create personalized video display effects to meet various scenario requirements, such as remote meetings, live streaming, online education, while also supporting features like portrait-in-picture effect.

Additionally, the SDK provides the `updateLocalTranscoderConfiguration` method and the `onLocalVideoTranscoderError` callback. After enabling local video mixing, you can use the `updateLocalTranscoderConfiguration` method to update the video mixing configuration. Where an error occurs in starting the local video mixing or updating the configuration, you can get the reason for the failure through the `onLocalVideoTranscoderError` callback.



Local video mixing requires more CPU resources. Therefore, Agora recommends enabling this function on devices with higher performance.



**5. Local video mixing (Windows)**

This release adds the `onLocalVideoTranscoderError` callback. When there is an error in starting or updating the local video mixing, the SDK triggers this callback to report the reason for the failure.



**6. Cross-device synchronization**

In real-time collaborative singing scenarios, network issues can cause inconsistencies in the downlinks of different client devices. To address this, this release introduces `getNtpWallTimeInMs`for obtaining the current Network Time Protocol (NTP) time. By using this method to synchronize lyrics and music across multiple client devices, users can achieve synchronized singing and lyrics progression, resulting in a better collaborative experience.



## Improvements

**1. Voice changer**

This release introduces the `setLocalVoiceFormant` method that allows you to adjust the formant ratio to change the timbre of the voice. This method can be used together with the `setLocalVoicePitch` method to adjust the pitch and timbre of voice at the same time, enabling a wider range of voice transformation effects.



**2. Enhanced screen share (Android, iOS)**

This release adds the `queryScreenCaptureCapability` method, which is used to query the screen capture capabilities of the current device. To ensure optimal screen sharing performance, particularly in enabling high frame rates like 60 fps, Agora recommends you to query the device's maximum supported frame rate using this method beforehand.

This release also adds the `setScreenCaptureScenario` method, which is used to set the scenario type for screen sharing. The SDK automatically adjusts the smoothness and clarity of the shared screen based on the scenario type you set.



 **3. Improved compatibility with audio file types (Android)**

As of v4.2.0, you can use the following methods to open files with a URI starting with `content://` : `startAudioMixing` [2/2], `playEffect` [3/3], `open` [2/2], and `openWithMediaSource`.



 **4. Enhanced rendering compatibility (Windows)**

This release enhances the rendering compatibility of the SDK. Issues like black screens caused by rendering failures on certain devices are fixed.



**5. Audio and video synchronization**

For custom video and audio capture scenarios, this release introduces `getCurrentMonotonicTimeInMs` for obtaining the current Monotonic Time. By passing this value into the timestamps of audio and video frames, developers can accurately control the timing of their audio and video streams, ensuring proper synchronization.



**6. Multi-camera capture and multi-screen capture**

 Android & iOS & RN 点这里



 Windows & macOS & Elec & CS 点这里

 Flutter & Unity 看过来嗷



**7. Channel media relay**

This release introduces `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx`, allowing for a simpler and smoother way to start and update media relay across channels. With these methods, developers can easily start the media relay across channels and update the target channels for media relay with a single method. Additionally, the internal interaction frequency has been optimized, effectively reducing latency in function calls.



**8. Custom audio tracks**

To better meet the needs of custom audio capture scenarios, this release adds `createCustomAudioTrack` and `destroyCustomAudioTrack` for creating and destroying custom audio tracks. Two types of audio tracks are also provided for users to choose from, further improving the flexibility of capturing external audio source:

- Mixable audio track: Supports mixing multiple external audio sources and publishing them to the same channel, suitable for multi-channel audio capture scenarios.
- Direct audio track: Only supports publishing one external audio source to a single channel, suitable for low-latency audio capture scenarios.





## Issues fixed

This release fixed the following issues:

- Occasional crashes occur on Android devices when users joining or leaving a channel. (Android)
- When the host frequently switching the user role between broadcaster and audience in a short period of time, the audience members cannot hear the audio of the host.
- Occational failure when enabling in-ear monitoring.(Android)
- Occasional loss of the `firstRemoteVideoFrameOfUid` callback during channel media relay. (iOS)
- The receiver actively subscribed to the high-quality stream but unexpectedly received a low-quality stream. (iOS)
- The receiver was receiving the low-quality stream originally, and automatically switched to high-quality stream after a few seconds. (macOS)
- Incorrect information in the `type` field of the return value after calling `getDefaultAudioDevice`. (Mac)
- Occational echo. (Android)
- Occasional screen jittering during screen sharing. (macOS)
- Abnormal client status cased by an exception in the onRemoteAudioStateChanged callback. (Android, iOS)



## API changes

**Added**

- `startCameraCapture`
- `stopCameraCapture`
- `startScreenCapture[2/2]`(Windows,macOS)
- `stopScreenCapture[2/2]`(Windows,macOS)
- `startOrUpdateChannelMediaRelay`
- `startOrUpdateChannelMediaRelayEx`
- `getNtpWallTimeInMs`
- `setVideoScenario`
- `getCurrentMonotonicTimeInMs`
- `onLocalVideoTranscoderError`
- `startLocalVideoTranscoder`（Mac\iOS\Android）
- `updateLocalTranscoderConfiguration`（Mac\iOS\Android）
- `queryScreenCaptureCapability` (iOS,Android)
- `setScreenCaptureScenario` (iOS,Android)
- `setAINSMode`
- `createAudioCustomTrack`
- `destroyAudioCustomTrack`
- `createMediaRecorder`
- `destroyMediaRecorder`
- `AudioTrackConfig`
- `RecorderStreamInfo`
- `AUDIO_TRACK_TYPE`
- `VIDEO_APPLICATION_SCENARIO_TYPE`
- `SCREEN_CAPTURE_CAPABILITY_LEVEL`
- The `domainLimit` and `autoRegisterAgoraExtensions` members in `RtcEngineContext`
- The `channelId` and `uid` parameters in `onRecorderStateChanged` and `onRecorderInfoUpdated` callbacks
- The `sourceType` parameter in `onCaptureVideoFrame` and `onPreEncodeVideoFrame` callbacks
- The `BACKGROUND_NONE` and `BACKGROUND_VIDEO` enumerators in `BACKGROUND_SOURCE_TYPE`

**Deprecated**

- `enableDualStreamMode`[1/2]
- `enableDualStreamMode`[2/2]
- `startChannelMediaRelay`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelay`
- `updateChannelMediaRelayEx`
- `onChannelMediaRelayEvent`
- `CHANNEL_MEDIA_RELAY_EVENT`

**Deleted**

- `startPrimaryScreenCapture `(Windows/macOS)
- `startSecondaryScreenCapture `(Windows/macOS)
- `stopPrimaryScreenCapture `(Windows/macOS)
- `stopSecondaryScreenCapture `(Windows/macOS)
- `startPrimaryCameraCapture `(Windows/macOS)
- `startSecondaryCameraCapture `(Windows/macOS)
- `stopPrimaryCameraCapture `(Windows/macOS)
- `stopSecondaryCameraCapture `(Windows/macOS)``
- `onSecondaryPreEncodeCameraVideoFrame `（Windows）
- `onScreenCaptureVideoFrame`（Windows）
- `onPreEncodeScreenVideoFrame `（Windows）
- `onSecondaryPreEncodeScreenVideoFrame `（Windows）
- `onApiCallExecuted`
- `publishCustomAudioTrackEnableAec `in` ChannelMediaOptions`
- `getMediaRecorder`
- `release` in `IMediaRecorder`
- `AGORA_IID_MEDIA_RECORDER` （Windows）
- The `connection` parameter in `startRecording`, `stopRecording`, and `setMediaRecorderObserver`