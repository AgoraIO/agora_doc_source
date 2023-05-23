# v4.2.0

v4.2.0 was released on May xx, 2023.

## Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

**1. Video capture**

This release optimizes the APIs for camera and screen capture function. As of v4.2.0, ensure you use the alternative methods listed in the table below and specify the video source by setting the `sourceType` parameter.

| Deleted Methods                                              | Alternative Methods       |
| :----------------------------------------------------------- | :------------------------ |
| <li>`startPrimaryCameraCapture`</li><li>`startSecondaryCameraCapture`</li> | `startCameraCapture`      |
| <li>`stopPrimaryCameraCapture`</li><li>`stopSecondaryCameraCapture`</li> | `stopCameraCapture`       |
| <li>`startPrimaryScreenCapture`</li><li>`startSecondaryScreenCapture`</li> | `startScreenCapture`[2/2] |
| <li>`stopPrimaryScreenCapture`</li><li>`stopSecondaryScreenCapture`</li> | `stopScreenCapture`[2/2]  |

**2. Video data acquisition**

- The `onCaptureVideoFrame` and `onPreEncodeVideoFrame` callbacks are added with a new parameter called `sourceType`, which is used to indicate the specific video source type.
- The following callbacks are deleted. Get the video source type through the `sourceType` parameter in the `onPreEncodeVideoFrame` and `onCaptureVideoFrame` callbacks.
  - `onSecondaryPreEncodeCameraVideoFrame`
  - `onScreenCaptureVideoFrame`
  - `onPreEncodeScreenVideoFrame`
  - `onSecondaryPreEncodeScreenVideoFrame`

**3. Channel media options**

- `publishCustomAudioTrackEnableAec` is deleted. Use `publishCustomAudioTrack` instead.
- `publishTrancodedVideoTrack` is renamed to `publishTranscodedVideoTrack`.
- `publishCustomAudioSourceId` is renamed to `publishCustomAudioTrackId`.

**4. Audio and video recording**

- `AGORA_IID_MEDIA_RECORDER` in `INTERFACE_ID_TYPE` is deleted. As of v4.2.0, before creating a recording object, you don't need to obtain the `AGORA_IID_MEDIA_RECORDER` interface class pointer. You can directly create a recording object through the `createMediaRecorder` method released in this version. 
- The `connection` parameter in the `startRecording`, `stopRecording`, and `setMediaRecorderObserver` methods is deleted.
- The `release` method in the `IMediaRecorder` class is deleted. You can use the `destroyMediaRecorder `method released in this version to destroy a recording object and release resources. 

**5. Local video mixing** 

- The `VideoInputStreams` in `LocalTranscoderConfiguration` is changed to `videoInputStreams`.
- The `MEDIA_SOURCE_TYPE` in `TranscodingVideoStream` is changed to `VIDEO_SOURCE_TYPE`.

**6. Miscellaneous**

- `onApiCallExecuted` is deleted. Agora recommends getting the results of the API implementation through relevant channels and media callbacks.
- The `IAudioFrameObserver` class is renamed to `IAudioPcmFrameSink`, thus the prototype of the following methods are updated accordingly: 
  - `onFrame`
  - `registerAudioFrameObserver` [1/2] and `registerAudioFrameObserver`[2/2] in `IMediaPlayer`
- `enableDualStreamMode`[1/2] and `enableDualStreamMode`[2/2] are depredated. Use `setDualStreamMode`[1/2] and `setDualStreamMode`[2/2] instead.
- `startChannelMediaRelay`, `updateChannelMediaRelay`, `startChannelMediaRelayEx` and `updateChannelMediaRelayEx` are deprecated. Use `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx` instead.

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

**4. Local video mixing** 

This release adds the `onLocalVideoTranscoderError` callback. When there is an error in starting or updating the local video mixing, the SDK triggers this callback to report the reason for the failure.

**5. Cross-device synchronization**

In real-time collaborative singing scenarios, network issues can cause inconsistencies in the downlinks of different client devices. To address this, this release introduces `getNtpWallTimeInMs` for obtaining the current Network Time Protocol (NTP) time. By using this method to synchronize lyrics and music across multiple client devices, users can achieve synchronized singing and lyricsprogression, resulting in a better collaborative experience.

## Improvements 

**1. Voice changer**

This release introduces the `setLocalVoiceFormant` method that allows you to adjust the formant ratio to change the timbre of the voice. This method can be used together with the `setLocalVoicePitch` method to adjust the pitch and timbre of voice at the same time, enabling a wider range of voice transformation effects.

 **2. Enhanced rendering compatibility**

This release enhances the rendering compatibility of the SDK. Issues like black screens caused by rendering failures on certain devices are fixed.

**3. Audio and video synchronization**

For custom video and audio capture scenarios, this release introduces `getCurrentMonotonicTimeInMs` for obtaining the current Monotonic Time. By passing this value into the timestamps of audio and video frames, developers can accurately control the timing of their audio and video streams, ensuring proper synchronization.

**4. Multi-camera capture and multi-screen capture** 

This release introduces `startCameraCapture` and `startScreenCapture`[2/2]. By calling these methods multiple times and specifying the `sourceType` parameter, developers can start capturing video streams from multiple cameras and screens for local video mixing or multi-channel publishing. This is particularly useful for scenarios such as remote medical care and online education, where multiple cameras and displays need to be connected.

**5. Channel media relay**

This release introduces `startOrUpdateChannleMediaRelay` and `startOrUpdateChannleMediaRelayEx`, allowing for a simpler and smoother way to start and update media relay across channels. With these methods, developers can easily start the media relay across channels and update the target channels for media relay with a single method. Additionally, the internal interaction frequency has been optimized, effectively reducing latency in function calls.

**6. Custom audio tracks**

To better meet the needs of custom audio capture scenarios, this release adds `createCustomAudioTrack` and `destroyCustomAudioTrack` for creating and destroying custom audio tracks. Two types of audio tracks are also provided for users to choose from, further improving the flexibility of capturing external audio source:

- Mixable audio track: Supports mixing multiple external audio sources and publishing them to the same channel, suitable for multi-channel audio capture scenarios.
- Direct audio track: Only supports publishing one external audio source to a single channel, suitable for low-latency audio capture scenarios.

## Issues fixed

This release fixed the issue that when the host frequently switching the user role between broadcaster and audience in a short period of time, the audience members cannot hear the audio of the host.

## API changes

**Added**

- `startCameraCapture`
- `stopCameraCapture`
- `startScreenCapture`[2/2]
- `stopScreenCapture`[2/2]
- `startOrUpdateChannelMediaRelay`
- `startOrUpdateChannelMediaRelayEx`
- `getNtpWallTimeInMs`
- `setVideoScenario`
- `getCurrentMonotonicTimeInMs`
- `onLocalVideoTranscoderError`
- `setAINSMode`
- `createAudioCustomTrack`
- `destroyAudioCustomTrack`
- `createMediaRecorder`
- `destroyMediaRecorder`
- `AudioTrackConfig`
- `RecorderStreamInfo`
- `AUDIO_TRACK_TYPE`
- `VIDEO_APPLICATION_SCENARIO_TYPE`
- `SCREEN_CAPTURE_FRAMERATE_CAPABILITY`
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

- `startPrimaryScreenCapture`
- `startSecondaryScreenCapture`
- `stopPrimaryScreenCapture`
- `stopSecondaryScreenCapture`
- `startPrimaryCameraCapture`
- `startSecondaryCameraCapture`
- `stopPrimaryCameraCapture`
- `stopSecondaryCameraCapture`
- `onSecondaryPreEncodeCameraVideoFrame`
- `onScreenCaptureVideoFrame`
- `onPreEncodeScreenVideoFrame`
- `onSecondaryPreEncodeScreenVideoFrame`
- `onApiCallExecuted`
- `publishCustomAudioTrackEnableAec ` in ` ChannelMediaOptions`
- `getMediaRecorder`
- `release` in `IMediaRecorder`
- `AGORA_IID_MEDIA_RECORDER` 
- The `connection` parameter in `startRecording`, `stopRecording`, and `setMediaRecorderObserver`