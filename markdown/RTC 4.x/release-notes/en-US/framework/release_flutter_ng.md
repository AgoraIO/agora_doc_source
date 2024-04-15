## Known issues and limitations

**Android 14 screen sharing issue (Android)**

On Android 14 devices (such as OnePlus 11), screen sharing may not be available when `targetSdkVersion` is set to 34. For example, half of the shared screen may be black. To avoid this issue, Agora recommends setting `targetSdkVersion` to 34 or below. However, this may cause the screen sharing process to be interrupted when switching between portrait and landscape mode. In this case, a window will pop up on the device asking if you want to start recording the screen. After confirming, you can resume screen sharing.

**AirPods Pro Bluetooth connection issue (iOS)**

AirPods Pro does not support A2DP protocol in communication audio mode, which may lead to connection failure in that mode.


## v6.3.0

v6.3.0 was released on xx xx, 2024.

#### Compatibility changes

This release has optimized the implementation of some functions, involving renaming or deletion of some APIs. To ensure the normal operation of the project, you need to update the code in the app after upgrading to this release.

1. **Renaming parameters in callbacks**

   In order to make the parameters in some callbacks and the naming of enumerations in enumeration classes easier to understand, the following modifications have been made in this release. Please modify the parameter settings in the callbacks after upgrading to this release.

   | Callback                                                     | Original parameter name | Existing parameter name |
   | ------------------------------------------------------------ | ----------------------- | ----------------------- |
   | `onLocalAudioStateChanged`                                   | `error`                 | `reason`                |
   | `onLocalVideoStateChanged`                                   | `error`                 | `reason`                |
   | `onDirectCdnStreamingStateChanged`                           | `error`                 | `reason`                |
   | `onRtmpStreamingStateChanged`                                | `errCode`               | `reason`                |

   | Original enumeration class | Current enumeration class  |
   | -------------------------- | -------------------------- |
   | `LocalAudioStreamError`   | `localAudioStreamReason`      |
   | `LocalVideoStreamError`   | `LocalVideoStreamReason`      |
   | `DirectCdnStreamingError` | `DirectCdnStreamingReason`    |
   | `MediaPlayerError`        | `MediaPlayerReason`           |
   | `RtmpStreamPublishErrorType`  | `RtmpStreamPublishReason`     |

   **Note:** For specific renaming of enumerations, please refer to [API changes](#apichange).

2. **Channel media relay**

   To improve interface usability, this release removes some methods and callbacks for channel media relay. Use the alternative options listed in the table below:

   | Deleted methods and callbacks                         | Alternative methods and callbacks  |
   | ----------------------------------------------------- | ---------------------------------- |
   | <ul><li>`startChannelMediaRelay`</li><li>`updateChannelMediaRelay`</li></ul>     | `startOrUpdateChannelMediaRelay`   |
   | <ul><li>`startChannelMediaRelayEx`</li><li>`updateChannelMediaRelayEx`</li></ul> | `startOrUpdateChannelMediaRelayEx` |
   | `onChannelMediaRelayEvent`                            | `onChannelMediaRelayStateChanged`  |

3. **Audio route**

   Starting with this release, `routeBluetooth` in [`AudioRoute`](API/enum_audioroute.html) is renamed to `routeHeadsetbluetooth`, representing a Bluetooth device using the HFP protocol. `routeBluetoothSpeaker`(10) is added to represent a Bluetooth device using the A2DP protocol.

4. **Reasons for local video state changes**

   This release makes the following modifications to the enumerations in the [`LocalVideoStreamReason`](API/enum_localvideostreamreason.html) class:

   - The value of `localVideoStreamReasonScreenCapturePaused` (formerly `localVideoStreamReasonScreenCapturePaused`) has been changed from 23 to 28. (Windows)
   - The value of `localVideoStreamReasonScreenCaptureResumed` (formerly `localVideoStreamReasonScreenCaptureResumed`) has been changed from 24 to 29. (Windows)
   - The `localVideoStreamErrorEncodeFailure` enumeration has been changed to `localVideoStreamReasonCodecNotSupport`.

5. **Log encryption behavior changes**
   
   For security and performance reasons, as of this release, the SDK encrypts logs and no longer supports printing plaintext logs via the console. 
   
   Refer to the following solutions for different needs:
   - If you need to know the API call status, please check the API logs and print the SDK callback logs yourself.
   - For any other special requirements, please contact [technical support](mailto:support@agora.io) and provide the corresponding encrypted logs.

6. **Audio loopback capturing (Windows, macOS)**

   - Before v6.3.0, if you call the [`disableAudio`](API/api_irtcengine_disableaudio.html) method to disable the audio module, audio loopback capturing will not be disabled.
   - As of v6.3.0, if you call the [`disableAudio`](API/api_irtcengine_disableaudio.html) method to disable the audio module, audio loopback capturing will be disabled as well. If you need to enable audio loopback capturing, you need to enable the audio module by calling the [`enableAudio`](API/api_irtcengine_enableaudio.html) method and then call [`enableLoopbackRecording`](API/api_irtcengine_enableloopbackrecording.html).

#### New features

1. **Custom mixed video layout on receiving end (Android, iOS)**

   To facilitate customized layout of mixed video stream at the receiver end, this release introduces the [`onTranscodedStreamLayoutInfo`](API/callback_irtcengineeventhandler_ontranscodedstreamlayoutinfo.html) callback. When the receiver receives the channel's mixed video stream sent by the video mixing server, this callback is triggered, reporting the layout information of the mixed video stream and the layout information of each sub-video stream in the mixed stream. The receiver can set a separate `view` for rendering the sub-video stream (distinguished by `subviewUid`) in the mixed video stream when calling the [`setupRemoteVideo`](API/api_irtcengine_setupremotevideo.html) method, achieving a custom video layout effect.

   When the layout of the sub-video streams in the mixed video stream changes, this callback will also be triggered to report the latest layout information in real time.

   Through this feature, the receiver end can flexibly adjust the local view layout. When applied in a multi-person video scenario, the receiving end only needs to receive and decode a mixed video stream, which can effectively reduce the CPU usage and network bandwidth when decoding multiple video streams on the receiving end.

2. **Local preview with multiple views**

   This release supports local preview with simultaneous display of multiple frames, where the videos shown in the frames are positioned at different observation positions along the video link. Examples of usage are as follows:

   1. Call [`setupLocalVideo`](API/api_irtcengine_setuplocalvideo.html) to set the first view: Set the `position` parameter to `positionPostCapturerOrigin` (introduced in this release) in `VideoCanvas`. This corresponds to the position after local video capture and before preprocessing. The video observed here does not have preprocessing effects.
   2. Call [`setupLocalVideo`](API/api_irtcengine_setuplocalvideo.html) to set the second view: Set the `position` parameter to `positionPostCapturer` in `VideoCanvas`, the video observed here has the effect of video preprocessing.
   3. Observe the local preview effect: The first view is the original video of a real person; the second view is the virtual portrait after video preprocessing (including image enhancement, virtual background, and local preview of watermarks) effects.

3. **Query device score**

   This release adds the [`queryDeviceScore`](API/api_irtcengine_querydevicescore.html) method to query the device's score level to ensure that the user-set parameters do not exceed the device's capabilities. For example, in HD or UHD video scenarios, you can first call this method to query the device's score. If the returned score is low (for example, below 60), you need to lower the video resolution to avoid affecting the video experience. The minimum device score required for different business scenarios is varied. For specific score recommendations, please contact [technical support](mailto:support@agora.io).

4. **Select different audio tracks for local playback and streaming**

   This release introduces the [`selectMultiAudioTrack`](API/api_imediaplayer_selectmultiaudiotrack.html) method that allows you to select different audio tracks for local playback and streaming to remote users. For example, in scenarios like online karaoke, the host can choose to play the original sound locally and publish the accompaniment in the channel. Before using this function, you need to open the media file through the [`openWithMediaSource`](API/api_imediaplayer_openwithmediasource.html) method and enable this function by setting the `enableMultiAudioTrack` parameter in [`MediaSource`](API/class_mediasource.html).

5. **Others**

   This release has passed the test verification of the following APIs and can be applied to the entire series of RTC 4.x SDK.

   - [`setRemoteSubscribeFallbackOption`](API/api_irtcengine_setremotesubscribefallbackoption.html): Sets fallback option for the subscribed video stream in weak network conditions.
   - [`onRemoteSubscribeFallbackToAudioOnly`](API/callback_irtcengineeventhandler_onremotesubscribefallbacktoaudioonly.html): Occurs when the subscribed video stream falls back to audio-only stream due to weak network conditions or switches back to the video stream after the network conditions improve.
   - [`setPlaybackDeviceVolume`](API/api_iaudiodevicemanager_setplaybackdevicevolume.html)(Windows): Sets the volume of the audio playback device.
   - [`getRecordingDeviceVolume`](API/api_iaudiodevicemanager_getrecordingdevicevolume.html)(Windows): Sets the volume of the audio capturing device.
   - [`setPlayerOptionInInt`](API/api_imediaplayer_setplayeroption.html) and [`setPlayerOptionInString`](API/api_imediaplayer_setplayeroption2.html): Sets media player options for providing technical previews or special customization features.
   - [`enableCustomAudioLocalPlayback`](API/api_irtcengine_enablecustomaudiolocalplayback.html): Sets whether to enable the local playback of external audio source.

#### Improvements

1. **SDK task processing scheduling optimization**

   This release optimizes the scheduling mechanism for internal tasks within the SDK, with improvements in the following aspects:

   - The speed of video rendering and audio playback for both remote and local first frames improves by 10% to 20%.
   - The API call duration and response time are reduced by 5% to 50%.
   - The SDK's parallel processing capability significantly improves, delivering higher video quality (720P, 24 fps) even on lower-end devices. Additionally, image processing remains more stable in scenarios involving high resolutions and frame rates.
   - The stability of the SDK is further enhanced, leading to a noticeable decrease in the crash rate across various specific scenarios.

2. **In-ear monitoring volume boost**

   This release provides users with more flexible in-ear monitoring audio adjustment options, supporting the ability to set the in-ear monitoring volume to four times the original volume by calling [`setInEarMonitoringVolume`](API/api_irtcengine_setinearmonitoringvolume.html).

3. **Spatial audio effects usability improvement**

   - This release optimizes the design of the [`setZones`](API/api_ibasespatialaudioengine_setzones.html) method, supporting the ability to set the `zones` parameter to `NULL`, indicating the clearing of all echo cancellation zones.
   - As of this release, it is no longer necessary to unsubscribe from the audio streams of all remote users within the channel before calling the [`LocalSpatialAudioEngine`](API/class_ilocalspatialaudioengine.html) method.

4. **Other Improvements**

   This release also includes the following improvements:

   - The [`onLocalVideoStateChanged`](API/callback_irtcengineeventhandler_onlocalvideostatechanged.html) callback is improved with the inclusion of the `localVideoStreamReasonScreenCaptureAutoFallback` enumeration, signaling unexpected errors during the screen sharing process (potentially due to window blocking failure), resulting in performance degradation without impacting the screen sharing process itself. (Windows)
   - The [`onPlayerCacheStats`](API/callback_imediaplayersourceobserver_onplayercachestats.html) callback is added to reports the statistics of the media file being cached. This callback is triggered once per second after file caching is started.
   - The [`onPlayerPlaybackStats`](API/callback_imediaplayersourceobserver_onplayerplaybackstats.html) callback is added to reports the statistics of the media file being played. This callback is triggered once per second after the media file starts playing. You can obtain information like the audio and video bitrate of the media file through [`PlayerPlaybackStats`](API/class_playerplaybackstats.html).
   - This release optimizes the SDK's domain name resolution strategy, improving the stability of calling `setLocalAccessPoint` to resolve domain names in complex network environments.
   - When passing in an image with transparent background as the virtual background image, the transparent background can be filled with customized color.
   - This release adds the `earMonitorDelay` and `aecEstimatedDelay` members in [`LocalAudioStats`](API/class_localaudiostats.html) to report ear monitor delay and acoustic echo cancellation (AEC) delay, respectively.

#### Issues fixed

This release fixed the following issues:

- When sharing two screen sharing video streams simultaneously, the reported `captureFrameRate` in the [`onLocalVideoStats`](API/callback_irtcengineeventhandler_onlocalvideostats.html) callback is 0, which is not as expected.
- When sharing in a specified screen area, the mouse coordinates within the shared area are inaccurate. When the mouse is near the border of the shared area, the mouse may not be visible in the shared screen. (Windows)
- The SDK failed to detect any changes in the audio routing after plugging in and out 3.5mm earphones. (Windows)

#### API changes

<a name="apichange"></a>

**Added**

- [`onTranscodedStreamLayoutInfo`](API/callback_irtcengineeventhandler_ontranscodedstreamlayoutinfo.html)(Android, iOS)
- [`VideoLayout`](API/class_videolayout.html)(Android, iOS)
- The `subviewUid` member in [`VideoCanvas`](API/class_videocanvas.html)
- [`enableCustomAudioLocalPlayback`](API/api_irtcengine_enablecustomaudiolocalplayback.html)
- [`selectMultiAudioTrack`](API/api_imediaplayer_selectmultiaudiotrack.html)
- [`onPlayerCacheStats`](API/callback_imediaplayersourceobserver_onplayercachestats.html)
- [`onPlayerPlaybackStats`](API/callback_imediaplayersourceobserver_onplayerplaybackstats.html)
- [`PlayerPlaybackStats`](API/class_playerplaybackstats.html)
- The `earMonitorDelay` and `aecEstimatedDelay` members in [`LocalAudioStats`](API/class_localaudiostats.html)
- [`queryDeviceScore`](API/api_irtcengine_querydevicescore.html)
- The `customVideoSource` enumeration in [`MediaSourceType`](API/enum_mediasourcetype.html)
- The `routeBluetoothSpeaker` enumeration in [`AudioRoute`](API/enum_audioroute.html)

**Modified**

- `routeBluetooth` is renamed as `routeHeadsetbluetooth`
- All `Error` fields in the following enumerations are changed to `Reason`:
  - `localAudioStreamErrorOk`
  - `localAudioStreamErrorFailure`
  - `localAudioStreamErrorDeviceNoPermission`
  - `localAudioStreamErrorDeviceBusy`
  - `localAudioStreamErrorRecordFailure`
  - `localAudioStreamErrorEncodeFailure`
  - `localAudioStreamErrorRecordInvalidId` (Windows)
  - `localAudioStreamErrorPlayoutInvalidId` (Windows)
  - `localVideoStreamErrorOk`
  - `localVideoStreamErrorFailure`
  - `localVideoStreamErrorDeviceNoPermission`
  - `localVideoStreamErrorDeviceBusy`
  - `localVideoStreamErrorCaptureFailure`
  - `localVideoStreamErrorCodecNotSupport`
  - `localVideoStreamErrorCaptureInbackground` (iOS)
  - `localVideoStreamErrorCaptureMultipleForegroundApps` (iOS)
  - `localVideoStreamErrorDeviceNotFound`
  - `localVideoStreamErrorDeviceDisconnected`
  - `localVideoStreamErrorDeviceInvalidId`
  - `localVideoStreamErrorScreenCaptureWindowMinimized`
  - `localVideoStreamErrorScreenCaptureWindowClosed`
  - `localVideoStreamErrorScreenCaptureWindowOccluded`
  - `localVideoStreamErrorScreenCaptureNoPermission` (Windows)
  - `localVideoStreamErrorScreenCapturePaused` (Windows)
  - `localVideoStreamErrorScreenCaptureResumed` (Windows)
  - `localVideoStreamErrorScreenCaptureWindowHidden` (Windows)
  - `localVideoStreamErrorScreenCaptureWindowRecoverFromHidden` (Windows)
  - `localVideoStreamErrorScreenCaptureWindowRecoverFromMinimized` (Windows)
  - `localVideoStreamErrorScreenCaptureFailure` (Windows)
  - `localVideoStreamErrorDeviceSystemPressure` (Windows)
  - `directCdnStreamingErrorOk`
  - `directCdnStreamingErrorFailed`
  - `directCdnStreamingErrorAudioPublication`
  - `directCdnStreamingErrorVideoPublication`
  - `directCdnStreamingErrorNetConnect`
  - `directCdnStreamingErrorBadName`
  - `playerErrorNone`
  - `playerErrorInvalidArguments`
  - `playerErrorInternal`
  - `playerErrorNoResource`
  - `playerErrorInvalidMediaSource`
  - `playerErrorUnknownStreamType`
  - `playerErrorObjNotInitialized`
  - `playerErrorCodecNotSupported`
  - `playerErrorVideoRenderFailed`
  - `playerErrorInvalidState`
  - `playerErrorUrlNotFound`
  - `playerErrorInvalidConnectionState`
  - `playerErrorSrcBufferUnderflow`
  - `playerErrorInterrupted`
  - `playerErrorNotSupported`
  - `playerErrorTokenExpired`
  - `playerErrorUnknown`
  - `rtmpStreamPublishErrorOk`
  - `rtmpStreamPublishErrorInvalidArgument`
  - `rtmpStreamPublishErrorEncryptedStreamNotAllowed`
  - `rtmpStreamPublishErrorConnectionTimeout`
  - `rtmpStreamPublishErrorInternalServerError`
  - `rtmpStreamPublishErrorRtmpServerError`
  - `rtmpStreamPublishErrorTooOften`
  - `rtmpStreamPublishErrorReachLimit`
  - `rtmpStreamPublishErrorNotAuthorized`
  - `rtmpStreamPublishErrorStreamNotFound`
  - `rtmpStreamPublishErrorFormatNotSupported`
  - `rtmpStreamPublishErrorNotBroadcaster`
  - `rtmpStreamPublishErrorTranscodingNoMixStream`
  - `rtmpStreamPublishErrorNetDown`
  - `rtmpStreamPublishErrorInvalidPrivilege`
  - `rtmpStreamUnpublishErrorOk`

**Deleted**

- `startChannelMediaRelay`
- `updateChannelMediaRelay`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelayEx`
- `onChannelMediaRelayEvent`
- `ChannelMediaRelayEvent`



## v6.2.6

v6.2.6 was released on November xx, 2023.

#### Issues fixed

This version fixed the following issues that may occur when using Android 14:

- When switching between portrait and landscape modes during screen sharing, the screen sharing process was interrupted. To restart screen sharing, users need to confirm recording the screen in the pop-up window. (Android)
- When integrating the SDK, setting the Android `targetSdkVersion` to 34 may cause screen sharing to be unavailable or even cause the app to crash. (Android)
- Calling `startScreenCapture` without sharing video (setting `captureVideo` to `false`) and then calling `updateScreenCaptureParameters` to share video (setting `captureVideo` to `true`) resulted in a frozen shared screen at the receiving end. (Android)
- When screen sharing in landscape mode, the shared screen seen by the audience was divided into two parts: one side of the screen was compressed; the other side was black. (Android)

This version also fixed the following issues:

- When using an iOS 16 or later device with Bluetooth headphones connected before joining the channel, the audio routing after joining the channel was not as expected: audio was played from the speaker, not the Bluetooth headphones. (iOS)
- In live streaming scenarios, the video on the audience end occasionally distorted. (Android)
- In specific scenarios (such as when the network packet loss rate was high or when the broadcaster left the channel without destroying the engine and then re-joined the channel), the video on the receiving end stuttered or froze.

## v6.2.4

v6.2.4 was released on October xx, 2023.

This version fixes the incorrect `CFBundleShortVersionString` version number in `AgoraRtcWrapper` which caused the app to be unable to be submitted to the App Store. (iOS, macOS)

## v6.2.3

v6.2.3 was released on September xx, 2023.

#### New features

1. **Update video screenshot and upload**

   To facilitate the integration of third-party video moderation services from Agora Extensions Marketplace, this version has the following changes:

   - The `contentInspectImageModeration` enumeration is added in `ContentInspectType` which means using video moderation extensions from Agora Extensions Marketplace to take video screenshots and upload them.
   - An optional parameter `serverConfig` is added in `ContentInspectConfig`, which is for server-side configuration related to video screenshot and upload via extensions from Agora Extensions Marketplace. By configuring this parameter, you can integrate multiple third-party moderation extensions and achieve flexible control over extension switches and other features. For more details, please contact [technical support](mailto:support@agora.io).

   In addition, this version also introduces the `enableContentInspectEx` method, which supports taking screenshots for multiple video streams and uploading them.

2. **ID3D11Texture2D Rendering (Windows)**

   As of this release, the SDK supports video formats of type ID3D11Texture2D, improving the rendering effect of video frames in game scenarios. You can set `format` to `VIDEO_TEXTURE_ID3D11TEXTURE2D` when pushing external raw video frames to the SDK by calling `pushVideoFrame`. By setting the `textureSliceIndex` property, you can determine the ID3D11Texture2D texture object to use.

3. **Local video status error code update (Windows, macOS)**

   In order to help users understand the exact reasons for local video errors in screen sharing scenarios, the following sets of enumerations have been added to the `onLocalVideoStateChanged` callback:

   - `localVideoStreamErrorScreenCapturePaused`(23): Screen capture has been paused. Common scenarios for reporting this error code: The current screen may have been switched to a secure desktop, such as a UAC dialog box or Winlogon desktop.
   - `localVideoStreamErrorScreenCaptureResumed`(24): Screen capture has resumed from the paused state.
   - `localVideoStreamErrorScreenCaptureWindowHidden`(25): The window being captured on the current screen is in a hidden state and is not visible on the current screen.
   - `localVideoStreamErrorScreenCaptureWindowRecoverFromHidden`(26): The window for screen capture has been restored from the hidden state.
   - `localVideoStreamErrorScreenCaptureWindowRecoverFromMinimized`(27): The window for screen capture has been restored from the minimized state.

4. **Check device support for advanced features**

   This version adds the `isFeatureAvailableOnDevice` method to check whether the capability of the current device meets the requirements of the specified advanced feature, such as virtual background and image enhancement.

   Before using advanced features, you can check whether the current device supports these features based on the call result. This helps to avoid performance degradation or unavailable features when enabling advanced features on low-end devices. Based on the return value of this method, you can decide whether to display or enable the corresponding feature button, or notify the user when the device's capabilities are insufficient.

   In addition, since this version, calling `enableVirtualBackground` and `setBeautyEffectOptions` automatically triggers a test on the capability of the current device. When the device is considered underperformed, the error code `-4:errNotSupported` is returned, indicating the device does not support the feature.

#### Improvements

1. **Optimize virtual background memory usage**

   This version has upgraded the virtual background algorithm, reducing the memory usage of the virtual background feature. Compared to the previous version, the memory consumption of the app during the use of the virtual background feature on low-end devices has been reduced by approximately 4% to 10% (specific values may vary depending on the device model and platform).

2. **Screen sharing scenario optimization**

   This release optimizes the performance and encoding efficiency in ultra-high-definition (4K, 60 fps) game sharing scenarios, effectively reducing the system resource usage during screen sharing. (Windows)

**Other Improvements**

This release optimizes the logic of Token parsing, in order to prevent an app from crash when an invalid token is passed in.

#### Issues fixed

This release fixed the following issues:

- Occasional crashes and dropped frames occurred in screen sharing scenarios. (Windows)
- Occasional crashes when joining a channel. (macOS)
- Occasional failure of joining a channel when the local system time was not set correctly.
- When calling the `playEffect` method to play two audio files using the same `soundId`, the first audio file was sometimes played repeatedly.
- When the host called the `startAudioMixing` method to play music, sometimes the host couldn't hear the music while the remote users could hear it. (Android)
- Occasional crashes occurred on certain Android devices. (Android)
- Calling `takeSnapshotEx` once receives the `onSnapshotTaken` callback for multiple times.
- In channels joined by calling `joinChannelEx` exclusively, calling `setEnableSpeakerphone` is unable to switch audio route from the speaker to the headphone. (Android)

#### API changes

**Added**

- The following enumerations in `onLocalVideoStateChanged` (Windows, macOS):
  - `localVideoStreamErrorScreenCapturePaused`
  - `localVideoStreamErrorScreenCaptureResumed`
  - `localVideoStreamErrorScreenCaptureWindowHidden`
  - `localVideoStreamErrorScreenCaptureWindowRecoverFromHidden`
  - `localVideoStreamErrorScreenCaptureWindowRecoverFromMinimized`
- ``textureSliceIndex` members in `ExternalVideoFrame`. (Windows)
- `videoTextureId3d11texture2d` in `VideoPixelFormat`. (Windows)
- `enableContentInspectEx`
- `contentInspectImageModeration` in `ContentInspectType`.
- `serverConfig` in `ContentInspectConfig`
- `isFeatureAvailableOnDevice`
- `FeatureType`


## v6.2.2

v6.2.2 was released on July xx, 2023.

#### New features

1. **Wildcard token**

   This release introduces wildcard tokens. Agora supports setting the channel name used for generating a token as a wildcard character. The token generated can be used to join any channel if you use the same user id. In scenarios involving multiple channels, such as switching between different channels, using a wildcard token can avoid repeated application of tokens every time users joining a new channel, which reduces the pressure on your token server. See [Wildcard tokens](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms).

   <div class="alert note">All 4.x SDKs support using wildcard tokens.</div>

2. **Preloading channels**

   This release adds `preloadChannel` and `preloadChannelWithUserAccount` methods, which allows a user whose role is set as audience to preload channels before joining one. Calling the method can help shortening the time of joining a channel, thus reducing the time it takes for audience members to hear and see the host.

   When preloading more than one channels, Agora recommends that you use a wildcard token for preloading to avoid repeated application of tokens every time you joining a new channel, thus saving the time for switching between channels. See [Wildcard tokens](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms).

3. **Customized background color of video canvas**

   In this release, the `backgroundColor` member has been added to `VideoCanvas`, which allows you to customize the background color of the video canvas when setting the properties of local or remote video display.

4. **Publishing video streams from different sources** (Windows, macOS)

   This release adds the following members in `ChannelMediaOptions` to allow you publish video streams captured from the third and fourth camera or screen:

   - `publishThirdCameraTrack`: Publishing the video stream captured from the third camera.
   - `publishFourthCameraTrack`: Publishing the video stream captured from the fourth camera.
   - `publishThirdScreenTrack`: Publishing the video stream captured from the third screen.
   - `publishFourthScreenTrack`: Publishing the video stream captured from the fourth screen.

   <div class="alert note">For one <code>RtcConnection</code>, Agora supports publishing multiple audio streams and one video stream at the same time.</div>

#### Improvements

1. **Improved camera capture effect** (Android, iOS)

   This release has improved camera capture effect in the following aspects:

   1. Support for camera exposure adjustment

      This release adds `isCameraExposureSupported` to query whether the device supports exposure adjustment and `setCameraExposureFactor` to set the exposure ratio of the camera.

   2. Optimization of default camera selection (iOS)

      Since this release, the default camera selection behavior of the SDK is aligned with that of the iOS system camera. If the device has multiple rear cameras, better shooting perspectives, zooming capabilities, low-light performance, and depth sensing can be achieved during video capture, thereby improving the quality of video capture.

2. **Virtual Background Algorithm Upgrade**

   This version has upgraded the portrait segmentation algorithm of the virtual background, which comprehensively improves the accuracy of portrait segmentation, the smoothness of the portrait edge with the virtual background, and the fit of the edge when the person moves. In addition, it optimizes the precision of the person's edge in scenarios such as meetings, offices, homes, and under backlight or weak light conditions.

3. **Channel media relay**

   The number of target channels for media relay has been increased to 6. When calling `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx`, you can specify up to 6 target channels.

4. **Enhancement in video codec query capability**

   To improve the video codec query capability, this release adds the `codecLevels` member in `CodecCapInfo`. After successfully calling `queryCodecCapability`, you can obtain the hardware and software decoding capability levels of the device for H.264 and H.265 video formats through `codecLevels`.

This release includes the following additional improvements:

1. To improve the switching experience between multiple audio routes, this release adds the `setRouteInCommunicationMode` method. This method can switch the audio route from a Bluetooth headphone to the earpiece, wired headphone or speaker in communication volume mode ([`MODE_IN_COMMUNICATION`](https://developer.android.google.cn/reference/kotlin/android/media/AudioManager?hl=en#mode_in_communication)). (Android)
2. The SDK automatically adjusts the frame rate of the sending end based on the screen sharing scenario. Especially in document sharing scenarios, this feature avoids exceeding the expected video bitrate on the sending end to improve transmission efficiency and reduce network burden.
3. To help users understand the reasons for more types of remote video state changes, the `remoteVideoStateReasonCodecNotSupport` enumeration has been added to the `onRemoteVideoStateChanged` callback, indicating that the local video decoder does not support decoding the received remote video stream.

#### Issues fixed

This release fixed the following issues:

- Occasionally, noise occurred when the local user listened to their own and remote audio after joining the channel. (macOS)
- Slow channel reconnection after the connection was interrupted due to network reasons.
- In screen sharing scenarios, the delay of seeing the shared screen was occasionally higher than expected on some devices.
- In custom video capturing scenarios, `setBeautyEffectOptions`, `setLowlightEnhanceOptions`, `setVideoDenoiserOptions`, and `setColorEnhanceOptions` could not load extensions automatically.
- In multi-device audio recording scenarios, after repeatedly plugging and unplugging or enabling/disabling the audio recording device, no sound could be heard occasionally when calling the `startRecordingDeviceTest` to start an audio capturing device test. (Windows)

#### API changes

**Added**

- `setCameraExposureFactor` (Android, iOS)
- `isCameraExposureSupported` (Android, iOS)
- `preloadChannel`
- `preloadChannelWithUserAccount`
- `updatePreloadChannelToken`
- `setRouteInCommunicationMode` (Android)
- The following members in `ChannelMediaOptions`:
  - `publishThirdCameraTrack` (Windows, macOS)
  - `publishFourthCameraTrack` (Windows, macOS)
  - `publishThirdScreenTrack` (Windows, macOS)
  - `publishFourthScreenTrack` (Windows, macOS)
- `CodecCapLevels`
- `VideoCodecCapabilityLevel`
- `backgroundColor` in `VideoCanvas`
- `codecLevels` in `CodecCapInfo`
- `remoteVideoStateReasonCodecNotSupport` in `RemoteVideoStateReason`

## v6.2.1

This version was released on June 21, 2023.

#### Improvements

This version improves the network transmission strategy, enhancing the smoothness of audio and video interactions.

#### Issues fixed

This version fixed the following issues:
- Inability to join channels caused by SDK's incompatibility with some older versions of AccessToken.
- After the sending end called `setAINSMode` to activate AI noise reduction, occasional echo was observed by the receiving end.
- Brief noise occurred while playing media files using the media player.
- After enabling the screen sharing feature on the sending end, there was high delay until the receiving end could see the shared screen. (macOS)
- Occasional crash after calling the `destroyMediaPlayer` method. (iOS)
- When the sending end mixed and published two streams of video captured by two cameras locally, the video from the second camera was occasionally missing on the receiving end. (Windows)
- In screen sharing scenarios, some Android devices experienced choppy video on the receiving end. (Android)

## v6.2.0

v6.2.0 was released on May 23, 2023.

#### Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

**1. Video capture (Windows, iOS)**

This release optimizes the APIs for camera and screen capture function. As of v6.2.0, ensure you use the alternative methods listed in the table below and specify the video source by setting the `sourceType` parameter.

| Deleted methods | Alternative methods ｜
|:---------|:--------|
| <li>`startPrimaryCameraCapture` (Windows)</li><li>`startSecondaryCameraCapture` (Windows, iOS)</li> | `startCameraCapture` |
| <li>`stopPrimaryCameraCapture` (Windows)</li><li>`stopSecondaryCameraCapture` (Windows, iOS)</li> | `stopCameraCapture` |
| <li>`startPrimaryScreenCapture` (Windows)</li><li>`startSecondaryScreenCapture` (Windows)</li> | `startScreenCaptureBySourceType` (Windows) |
| <li>`stopPrimaryScreenCapture` (Windows)</li><li>`stopSecondaryScreenCapture` (Windows)</li> | `stopScreenCaptureBySourceType` (Windows) |

**2. Video data acquisition**

- The `onCaptureVideoFrame` and `onPreEncodeVideoFrame` callbacks are added with a new parameter called `sourceType`, which is used to indicate the specific video source type.
- The following callbacks are deleted. Get the video source type through the `sourceType` parameter in the `onPreEncodeVideoFrame` and `onCaptureVideoFrame` callbacks. 
    - `onSecondaryPreEncodeCameraVideoFrame` (Windows)
    - `onScreenCaptureVideoFrame`
    - `onPreEncodeScreenVideoFrame`
    - `onSecondaryPreEncodeScreenVideoFrame` (Windows)

**3. Channel media options**

- `publishCustomAudioTrackEnableAec` in `ChannelMediaOptions` is deleted. Use `publishCustomAudioTrack` instead.
- `publishTrancodedVideoTrack` in `ChannelMediaOptions` is renamed to `publishTranscodedVideoTrack`.
- `publishCustomAudioSourceId` in `ChannelMediaOptions` is renamed to `publishCustomAudioTrackId`.

**4. Local video mixing (Windows)**

- The `VideoInputStreams` in `LocalTranscoderConfiguration` is changed to `videoInputStreams`.
- The `MediaSourceType` in `TranscodingVideoStream` is changed to `VideoSourceType`.

**5. Video encoder algorithm**

As of this release, the SDK optimizes the video encoder algorithm and upgrades the default video encoding resolution from 640 × 360 to 960 × 540 to accommodate improvements in device performance and network bandwidth, providing users with a full-link HD experience in various audio and video interaction scenarios.

Call the `setVideoEncoderConfiguration` method to set the expected video encoding resolution in the video encoding parameters configuration.

The increase in the default resolution affects the aggregate resolution and thus the billing rate. See [Pricing](https://docs.agora.io/en/video-calling/reference/pricing).

**6. Miscellaneous**

- `onApiCallExecuted` is deleted. Agora recommends getting the results of the API implementation through relevant channels and media callbacks.
- The `IAudioFrameObserver` class is renamed to `IAudioPcmFrameSink`, thus the prototype of the following methods are updated accordingly:
    - `onFrame`
    - `registerAudioFrameObserver` and `unregisterAudioFrameObserver` in `MediaPlayer`
- `startChannelMediaRelay`, `updateChannelMediaRelay`, `startChannelMediaRelayEx` and `updateChannelMediaRelayEx` are deprecated. Use `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx` instead.


#### New features

**1. AI noise reduction**

This release introduces the AI noise reduction function. Once enabled, the SDK automatically detects and reduces background noises. Whether in bustling public venues or real-time competitive arenas that demand lightning-fast responsiveness, this function guarantees optimal audio clarity, providing users with an elevated audio experience. You can enable this function through the newly-introduced `setAINSMode` method and set the noise reduction mode as balance, aggressive or low latency according to your scenarios.

**2. Enhanced virtual background**

To increase the fun of real-time video calls and protect user privacy, this version has enhanced the virtual background feature. You can now set custom backgrounds of various types by calling the `enableVirtualBackground` method, including:

- Process the background as alpha information without replacement, only separating the portrait and the background. This can be combined with the local video mixing feature to achieve a portrait-in-picture effect.
- Replace the background with various formats of local videos.

**3. Video scenario settings**

This release introduces `setVideoScenario` for setting the video application scene. The SDK will automatically enable the best practice strategy based on different scenes, adjusting key performance indicators to optimize video quality and improve user experience. Whether it is a formal business meeting or a casual online gathering, this feature ensures that the video quality meets the requirements.

Currently, this feature provides targeted optimizations for real-time video conferencing scenarios, including:

- Automatically activate multiple anti-weak network technologies to enhance the capability and performance of low-quality video streams in meeting scenarios where high bitrate are required, ensuring smoothness when multiple streams are subscribed by the receiving end.
- Monitor the number of subscribers for the high-quality and low-quality video streams in real time, dynamically adjusting the configuration of the high-quality stream and dynamically enabling or disabling the low-quality stream, to save uplink bandwidth and consumption.

**4. Local video mixing (macOS, iOS, Android)**

This release adds the local video mixing feature. You can use the `startLocalVideoTranscoder` method to mix and render multiple video streams locally, such as camera-captured video, screen sharing streams, video files, images, etc. This allows you to achieve custom layouts and effects, making it easy to create personalized video display effects to meet various scenario requirements, such as remote meetings, live streaming, online education, while also supporting features like portrait-in-picture effect.

Additionally, the SDK provides the `updateLocalTranscoderConfiguration` method and the `onLocalVideoTranscoderError` callback. After enabling local video mixing, you can use the `updateLocalTranscoderConfiguration` method to update the video mixing configuration. Where an error occurs in starting the local video mixing or updating the configuration, you can get the reason for the failure through the `onLocalVideoTranscoderError` callback.

<div class="alert note">Local video mixing requires more CPU resources. Therefore, Agora recommends enabling this function on devices with higher performance.</div>

**5. Local video mixing (Windows)**

This release adds the `onLocalVideoTranscoderError` callback. When there is an error in starting or updating the local video mixing, the SDK triggers this callback to report the reason for the failure.

**6. Cross-device synchronization**

In real-time collaborative singing scenarios, network issues can cause inconsistencies in the downlinks of different client devices. To address this, this release introduces `getNtpWallTimeInMs` for obtaining the current Network Time Protocol (NTP) time. By using this method to synchronize lyrics and music across multiple client devices, users can achieve synchronized singing and lyrics progression, resulting in a better collaborative experience.

**7. Instant frame rendering**

This release adds the `enableInstantMediaRendering` method to enable instant rendering mode for audio and video frames, which can speed up the first video or audio frame rendering after the user joins the channel.

**8. Video rendering tracing**

This release adds the `startMediaRenderingTracing` and `startMediaRenderingTracingEx` methods. The SDK starts tracing the rendering status of the video frames in the channel from the moment this method is called and reports information about the event through the `onVideoRenderingTracingResult` callback.

Agora recommends that you use this method in conjunction with the UI settings, such as buttons and sliders, in your app. For example, call this method when the user clicks **Join Channel** button and then get the indicators in the video frame rendering process through the `onVideoRenderingTracingResult` callback. This enables developers to optimize the indicators and improve the user experience.


#### Improvements

**1. Voice changer**

This release introduces the `setLocalVoiceFormant` method that allows you to adjust the formant ratio to change the timbre of the voice. This method can be used together with the `setLocalVoicePitch` method to adjust the pitch and timbre of voice at the same time, enabling a wider range of voice transformation effects.

**2. Enhanced screen share (Android, iOS)**

This release adds the `queryScreenCaptureCapability` method, which is used to query the screen capture capabilities of the current device. To ensure optimal screen sharing performance, particularly in enabling high frame rates like 60 fps, Agora recommends you to query the device's maximum supported frame rate using this method beforehand.

This release also adds the `setScreenCaptureScenario` method, which is used to set the scenario type for screen sharing. The SDK automatically adjusts the smoothness and clarity of the shared screen based on the scenario type you set.

**3. Improved compatibility with audio file types (Android)**

As of this release, you can use the following methods to open files with a URI starting with `content://` : `startAudioMixing`, `playEffect`, and `openWithMediaSource`.

**4. Enhanced rendering compatibility (Windows)**

This release enhances the rendering compatibility of the SDK. Issues like black screens caused by rendering failures on certain devices are fixed.

**5. Audio and video synchronization**

For custom video and audio capture scenarios, this release introduces `getCurrentMonotonicTimeInMs` for obtaining the current Monotonic Time. By passing this value into the timestamps of audio and video frames, developers can accurately control the timing of their audio and video streams, ensuring proper synchronization.

**6. Multi-camera capture and multi-screen capture**

This release introduces `startScreenCaptureBySourceType` (PC only) and `startCameraCapture`. By calling these methods multiple times and specifying the `sourceType` parameter, developers can start capturing video streams from multiple cameras and screens for local video mixing or multi-channel publishing. This is particularly useful for scenarios such as remote medical care and online education, where multiple cameras and displays need to be connected.

**7. Channel media relay**

This release introduces `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx`, allowing for a simpler and smoother way to start and update media relay across channels. With these methods, developers can easily start the media relay across channels and update the target channels for media relay with a single method. Additionally, the internal interaction frequency has been optimized, effectively reducing latency in function calls.

**8. Custom audio tracks**

To better meet the needs of custom audio capture scenarios, this release adds `createCustomAudioTrack` and `destroyCustomAudioTrack` for creating and destroying custom audio tracks. Two types of audio tracks are also provided for users to choose from, further improving the flexibility of capturing external audio source:

- Mixable audio track: Supports mixing multiple external audio sources and publishing them to the same channel, suitable for multi-channel audio capture scenarios.
- Direct audio track: Only supports publishing one external audio source to a single channel, suitable for low-latency audio capture scenarios.

**9. Video frame observer**

As of this release, the SDK optimizes the `onRenderVideoFrame` callback, and the meaning of the return value is different depending on the video processing mode:

- When the video processing mode is `processModeReadOnly`, the return value is reserved for future use.
- When the video processing mode is `processModeReadWrite`, the SDK receives the video frame when the return value is `true`. The video frame is discarded when the return value is `false`.

#### Issues fixed

This release fixed the following issues:

- Occasional crashes occur on Android devices when users joining or leaving a channel. (Android)
- When the host frequently switching the user role between broadcaster and audience in a short period of time, the audience members cannot hear the audio of the host.
- Occasional failure when enabling in-ear monitoring. (Android)
- Occasional loss of the `onFirstRemoteVideoFrame` callback during channel media relay. (iOS)
- The receiver actively subscribed to the high-quality stream but unexpectedly received a low-quality stream. (iOS)
- The receiver was receiving the low-quality stream originally, and automatically switched to high-quality stream after a few seconds. (macOS)
- Occasional echo. (Android)
- Occasional screen jittering during screen sharing. (macOS)
- Abnormal client status cased by an exception in the `onRemoteAudioStateChanged` callback. (Android, iOS)
- When using Agora Media Player to play RTSP video streams, the video images sometimes appeared pixelated. (Windows)
- Playing audio files with a sample rate of 48 kHz failed.
- Crashes occurred after users set the video resolution as 3840 × 2160 and started CDN streaming on Xiaomi Redmi 9A devices. (Android)
- If the rendering view of the player was set as a `UIViewController`'s view, the video was zoomed from the bottom-left corner to the middle of the screen when entering full-screen mode. (macOS)
- Adding an alpha channel to an image in PNG or GIF format failed when the local client mixed video streams. (Windows)
- In real-time chorus scenarios, remote users heard noises and echoes when an OPPO R11 device joined the channel in loudspeaker mode. (Android)
- When the playback of the local music finished, the `onAudioMixingFinished` callback was not properly triggered. (Android)
- After joining the channel, remotes users saw a watermark even though the watermark was deleted. (Windows)
- If a watermark was added after starting screen sharing, the watermark did not display the screen. (Windows)
- When joining a channel and accessing an external camera, calling `setDevice` to specify the video capture device as the external camera did not take effect. (macOS, Windows)
- When using a video frame observer, the first video frame was occasionally missed on the receiver's end. (Android)
- When sharing screens in scenarios involving multiple channels, remote users occasionally saw black screens. (Android)
- When trying to outline the shared window and put it on top, the shared window did not stay on top of other windows. (Windows)
- Switching to the rear camera with the virtual background enabled occasionally caused the background to be inverted. (Android)
- When there were multiple video streams in a channel, calling some video enhancement APIs occasionally failed.
- At the moment when a user left a channel, a request for leaving was not sent to the server and the leaving behavior was incorrectly determined by the server as timed out.


#### API changes

**Added**

- `startCameraCapture`
- `stopCameraCapture`
- `startScreenCaptureBySourceType` (Windows, macOS)
- `stopScreenCaptureBySourceType` (Windows, macOS)
- `startOrUpdateChannelMediaRelay`
- `startOrUpdateChannelMediaRelayEx`
- `getNtpWallTimeInMs`
- `setVideoScenario`
- `getCurrentMonotonicTimeInMs`
- `onLocalVideoTranscoderError`
- `startLocalVideoTranscoder` (macOS, iOS, Android)
- `updateLocalTranscoderConfiguration` (macOS, iOS, Android)
- `queryScreenCaptureCapability` (iOS, Android)
- `setScreenCaptureScenario` (iOS, Android)
- `setAINSMode`
- `createCustomAudioTrack`
- `destroyCustomAudioTrack`
- `AudioTrackConfig`
- `AudioAinsMode`
- `AudioTrackType`
- `VideoApplicationScenarioType`
- `ScreenCaptureFramerateCapability`
- The `domainLimit` and `autoRegisterAgoraExtensions` members in `RtcEngineContext`
- The `sourceType` parameter in `onCaptureVideoFrame` and `onPreEncodeVideoFrame` callbacks
- The `backgroundNone` and `backgroundVideo` enumerators in `backgroundSourceType`

**Deprecated**

- `startChannelMediaRelay`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelay`
- `updateChannelMediaRelayEx`
- `onChannelMediaRelayEvent`
- `ChannelMediaRelayEvent`
- `enableInstantMediaRendering`
- `startMediaRenderingTracing`
- `startMediaRenderingTracingEx`
- `onVideoRenderingTracingResult`
- `MediaTraceEvent`
- `VideoRenderingTracingInfo`

**Deleted**

- `startPrimaryScreenCapture` (Windows)
- `startSecondaryScreenCapture` (Windows)
- `stopPrimaryScreenCapture` (Windows)
- `stopSecondaryScreenCapture` (Window)
- `startPrimaryCameraCapture` (Windows)
- `startSecondaryCameraCapture` (Windows, iOS)
- `stopPrimaryCameraCapture` (Windows)
- `stopSecondaryCameraCapture` (Windows, iOS)
- `onSecondaryPreEncodeCameraVideoFrame` (Windows)
- `onScreenCaptureVideoFrame`
- `onPreEncodeScreenVideoFrame`
- `onSecondaryPreEncodeScreenVideoFrame` (Windows)
- `onApiCallExecuted`
- `publishCustomAudioTrackEnableAec` in `ChannelMediaOptions` in `ChannelMediaOptions`
- `enableRemoteSuperResolution`
- `superResolutionType` in `RemoteVideoStats`

## v6.1.0

v6.1.0 was released on November xx, 2022.


#### Compatibility changes

This release deletes the `sourceType` parameter in `enableDualStreamMode`, because the SDK supports enabling dual-stream mode for various video sources captured by custom capture or SDK; you no longer need to specify the video source type.



#### New features

**1. In-ear monitoring**

This release adds support for in-ear monitoring. You can call `enableInEarMonitoring` to enable the in-ear monitoring function.

After successfully enabling the in-ear monitoring function, you can call `registerAudioFrameObserver` to register the audio observer, and the SDK triggers the `onEarMonitoringAudioFrame` callback to report the audio frame data. You can use your own audio effect processing module to preprocess the audio frame data of the in-ear monitoring to implement custom audio effects. Agora recommends that you call the `setEarMonitoringAudioFrameParameters` method to set the audio data format of in-ear monitoring. The SDK calculates the sampling interval based on the parameters in this method and triggers the `onEarMonitoringAudioFrame` callback based on the sampling interval.

To adjust the in-ear monitoring volume, you can call `setInEarMonitoringVolume`.


**2. Audio capture device test (Android)**

This release adds support for testing local audio capture devices before joining a channel. You can call `startRecordingDeviceTest` to start the audio capture device test. After the test is complete, call the `stopPlaybackDeviceTest` method to stop the audio capture device test.


**3. Local network connection types**

To make it easier for users to know the connection type of the local network at any stage, this release adds the `getNetworkType` method. You can use this method to get the type of network connection in use. The available values are UNKNOWN, DISCONNECTED, LAN, WIFI, 2G, 3G, 4G, and 5G. When the local network connection type changes, the SDK triggers the `onNetworkTypeChanged` callback to report the current network connection type.


**4. Audio stream filter**

This release introduces filtering audio streams based on volume. Once this function is enabled, the Agora server ranks all audio streams by volume and transports the three audio streams with the highest volumes to the receivers by default. The number of audio streams to be transported can be adjusted; contact [support@agora.io](mailto:support@agora.io) to adjust this number according to your scenarios.

Agora also supports publishers in choosing whether the audio streams being published are to be filtered based on volume. Streams that are not filtered bypass this filter mechanism and are transported directly to the receivers. In scenarios with a number of publishers, enabling this function helps reduce the bandwidth and device system pressure for the receivers.

<div class="alert info">To enable this function, contact <a href="mailto:support@agora.io/">support@agora.io</a>.</div>


**5. Dual-stream mode**

This release optimizes the dual-stream mode. You can call `enableDualStreamMode` and `enableDualStreamModeEx` before and after joining a channel.

The implementation of subscribing to a low-quality video stream is expanded. The SDK enables the low-quality video stream auto mode on the sender by default (the SDK does not send low-quality video streams). Follow these steps to enable sending low-quality video streams:

1. The host at the receiving end calls `setRemoteVideoStreamType` or `setRemoteDefaultVideoStreamType` to initiate a low-quality video stream request.
2. After receiving the application, the sender automatically switches to sending low-quality video stream mode.

If you want to modify this default behavior, you can call `setDualStreamMode` and set the `mode` parameter to `disableSimulcastStream` (never send low-quality video streams) or `enableSimulcastStream` (always send low-quality video streams).


**6. Loopback device (Windows)**

The SDK uses the playback device as the loopback device by default. As of 6.1.0, you can specify a loopback device separately and publish the captured audio to the remote end.

- `setLoopbackDevice`: Specifies the loopback device. If you do not want the current playback device to be the loopback device, you can call this method to specify another device as the loopback device.
- `getLoopbackDevice`: Gets the current loopback device.
- `followSystemLoopbackDevice`: Whether the loopback device follows the default playback device of the system.


**7. Spatial audio effect**

This release adds the following features applicable to spatial audio effect scenarios, which can effectively enhance the user's sense-of-presence experience in virtual interactive scenarios.

- Sound insulation area: You can set a sound insulation area and sound attenuation parameter by calling `setZones`. When the sound source (which can be a user or the media player) and the listener belong to the inside and outside of the sound insulation area, the listener experiences an attenuation effect similar to that of the sound in the real environment when it encounters a building partition. You can also set the sound attenuation parameter for the media player and the user by calling `setPlayerAttenuation` and `setRemoteAudioAttenuation` respectively, and specify whether to use that setting to force an override of the sound attenuation parameter in `setZones`.
- Doppler sound: You can enable Doppler sound by setting the `enableDoppler` parameter in `SpatialAudioParams`. The receiver experiences noticeable tonal changes in the event of a high-speed relative displacement between the source source and receiver (such as in a racing game scenario).
- Headphone equalizer: You can use a preset headphone equalization effect by calling the `setHeadphoneEQPreset` method to improve the audio experience for users with headphones. If you cannot achieve the expected headphone EQ effect after calling `setHeadphoneEQPreset`, you can call `setHeadphoneEQParameters` to adjust the EQ.


**8. Multiple cameras for video capture (iOS)**

This release supports multi-camera video capture. You can call `enableMultiCamera` to enable multi-camera capture mode, call `startSecondaryCameraCapture` to start capturing video from the second camera, and then publish the captured video to the second channel.

To stop using multi-camera capture, you need to call `stopSecondaryCameraCapture` to stop the second camera capture, then call `enableMultiCamera` and set `enabled` to `false`.


**9. Encoded video frame observer**

This release adds the `setRemoteVideoSubscriptionOptions` and `setRemoteVideoSubscriptionOptionsEx` methods. When you call the `registerVideoEncodedFrameObserver` method to register a video frame observer for the encoded video frames, the SDK subscribes to the encoded video frames by default. If you want to change the subscription options, you can call these new methods to set them.

For more information about registering video observers and subscription options, see the [API reference](./API%20Reference/flutter_ng/API/toc_video_observer.html#api_imediaengine_registervideoencodedframeobserver).


**10. MPUDP (MultiPath UDP) (Beta)**

As of this release, the SDK supports MPUDP protocol, which enables you to connect and use multiple paths to maximize the use of channel resources based on the UDP protocol. You can use different physical NICs on both mobile and desktop and aggregate them to effectively combat network jitter and improve transmission quality.

<div class="alert info">To enable this feature, contact <a href="mailto:sales@agora.io">sales@agora.io</a>.</div>


**11. Register extensions (Windows)**

This release adds the `registerExtension` method for registering extensions. When using a third-party extension, you need to call the extension-related APIs in the following order:

`loadExtensionProvider` -> `registerExtension` -> `setExtensionProviderProperty` -> `enableExtension`


**12. Device management (Windows, macOS)**

This release adds a series of callbacks to help you better understand the status of your audio and video devices:

- `onVideoDeviceStateChanged`: Occurs when the status of the video device changes.
- `onAudioDeviceStateChanged`: Occurs when the status of the audio device changes.
- `onAudioDeviceVolumeChanged`: Occurs when the volume of an audio device or app changes.


**13. Camera capture options**

This release adds the `followEncodeDimensionRatio` member in `CameraCapturerConfiguration`, which enables you to set whether to follow the video aspect ratio already set in `setVideoEncoderConfiguration` when capturing video with the camera.


**14. Multi-channel management**

This release adds a series of multi-channel related methods that you can call to manage audio and video streams in multi-channel scenarios.

- The `muteLocalAudioStreamEx` and `muteLocalVideoStreamEx` methods are used to cancel or resume publishing a local audio or video stream, respectively.
- The `muteAllRemoteAudioStreamsEx` and `muteAllRemoteVideoStreamsEx` are used to cancel or resume the subscription of all remote users to audio or video streams, respectively.
- The `startRtmpStreamWithoutTranscodingEx`, `startRtmpStreamWithTranscodingEx`, `updateRtmpTranscodingEx`, and `stopRtmpStreamEx` methods are used to implement Media Push in multi-channel scenarios.
- The `startChannelMediaRelayEx`, `updateChannelMediaRelayEx`, `pauseAllChannelMediaRelayEx`, `resumeAllChannelMediaRelayEx`, and `stopChannelMediaRelayEx` methods are used to relay media streams across channels in multi-channel scenarios.
- The `options` parameter in the `leaveChannelEx` method, which is used to choose whether to stop recording with the microphone when leaving a channel in a multi-channel scenario.


**15. Video encoding preferences**

In general scenarios, the default video encoding configuration meets most requirements. For certain specific scenarios, this release adds the `advanceOptions` member in `VideoEncoderConfiguration` for advanced settings of video encoding properties:

- `CompressionPreference`: The compression preferences for video encoding, which is used to select low-latency or high-quality video preferences.
- `EncodingPreference`: The video encoder preference, which is used to select adaptive preference, software encoder preference, or hardware encoder video preferences.


**16. Client role switching**

In order to enable users to know whether the switched user role is low-latency or ultra-low-latency, this release adds the `newRoleOptions` parameter to the `onClientRoleChanged` callback. The value of this parameter is as follows:

- `audienceLatencyLevelLowLatency (1)`: Low latency.
- `audienceLatencyLevelUltraLowLatency (2)`: Ultra-low latency.



#### Improvements

**1. Video information change callback**

This release optimizes the trigger logic of `onVideoSizeChanged`, which can also be triggered and report the local video size change when `startPreview` is called separately.


**2. First video frame rendering (Windows)**

This release speeds up the first video frame rendering time to improve the video experience.


**3. Screen sharing**

In addition to the usability enhancements detailed in the [fixed issued](#issue-fixed) section, this release includes a number of functional improvements to screen sharing, as follows:

**Windows**
- New `minimizeWindow` member in `ScreenCaptureSourceInfo` to indicate whether the target window is minimized.
- New `enableHighLight`, `highLightColor`, and `highLightWidth` members in `ScreenCaptureParameters` so that you can place a border around the target window or screen when screen sharing.
- Compatibility with a greater number of mainstream apps, including WPS Office, Microsoft Office PowerPoint, Visual Studio Code, Adobe Photoshop, Windows Media Player, and Scratch.
- Compatibility with additional devices and operating systems, including: Window 8 systems, devices without discrete graphics cards, and dual graphics devices.
- Support for Ultra HD video (4K, 60 fps) on devices that meet the requirements. Agora recommends a device with an Intel Core i7-9750H CPU @ 2.60 GHz or better.

**macOS**
- Compatibility with additional devices and scenarios, including: dual graphics devices and screen sharing using external screens.
- Support for Ultra HD video (4K, 60 fps) on devices that meet the requirements. Agora recommends a 2021 16" M1 Macbook Pro or better.


**4. Bluetooth permissions (Android)**

To simplify integration, as of this release, you can use the SDK to enable Android users to use Bluetooth normally without adding the `BLUETOOTH_CONNECT` permission.


**5. Relaying media streams across channels**

This release optimizes the `updateChannelMediaRelay` method as follows:

- Before v6.1.0: If the target channel update fails due to internal reasons in the server, the SDK returns the error code `relayEventPacketUpdateDestChannelRefused (8)`, and you need to call the `updateChannelMediaRelay` method again.
- v6.1.0 and later: If the target channel update fails due to internal server reasons, the SDK retries the update until the target channel update is successful.


**5. Reconstructed AIAEC algorithm**

This release reconstructs the AEC algorithm based on the AI method. Compared with the traditional AEC algorithm, the new algorithm can preserve the complete, clear, and smooth near-end vocals under poor echo-to-signal conditions, significantly improving the system's echo cancellation and dual-talk performance. This gives users a more comfortable call and live-broadcast experience. AIAEC is suitable for conference calls, chats, karaoke, and other scenarios.


**6. Virtual background**

This release optimizes the virtual background algorithm. Improvements include the following:

- The boundaries of virtual backgrounds are handled in a more nuanced way and image matting is is now extremely thin.
- The stability of the virtual background is improved whether the portrait is still or moving, effectively eliminating the problem of background flickering and exceeding the range of the picture.
- More application scenarios are now supported, and a user obtains a good virtual background effect day or night, indoors or out.
- A larger variety of postures are now recognized, when half the body is motionless, the body is shaking, the hands are swinging, or there is fine finger movement. This helps to achieve a good virtual background effect in conjunction with many different gestures.


**Other improvements**

This release includes the following additional improvements:

- Reduces the latency when pushing external audio sources.
- Improves the performance of echo cancellation when using the `audioScenarioMeeting` scenario.
- Improves the smoothness of SDK video rendering.
- Reduces the CPU usage and power consumption of the local device when the host calls the `muteLocalVideoStream` method. (Windows, macOS)
- Enhances the ability to identify different network protocol stacks and improves the SDK's access capabilities in multiple-operator network scenarios.


#### Issue fixed

This release fixed the following issues:

**All**
- When calling `setVideoEncoderConfigurationEx` in the channel to increase the resolution of the video, it occasionally failed.
- When using the Agora media player to play videos, after you played and paused the video, and then called the `seek` method to specify a new position for playback, the video image occasionally remained unchanged; if you called the `resume` method to resume playback, the video was sometimes played at a speed faster than the original one.
- When entering a live streaming room that has been played for a long time as an audience, the time for the first frame to be rendered was shortened.
- The call `getExtensionProperty` failed and returned an empty string.
- Audience members heard buzzing noises when the host switched between speakers and earphones during live streaming.


**Android**
- In online meeting scenarios, the local user and the remote user occasionally could not hear each other after the local user was interrupted by a call.
- After calling `setCloudProxy` to set the cloud proxy, calling `joinChannelEx` to join multiple channels failed.


**iOS**
- Calling `startAudioMixing` to play music files in the ipod-library://item path failed.
- Different timestamps for audio and video data were obtained simultaneously and separately via `onRecordAudioFrame` and `onCaptureVideoFrame` callbacks.


**Windows**
- When `stopPreview` was called to disable the local video preview, the virtual background that had been set up was occasionally invalidated.
- Crashes occasionally occurred when exiting a channel and joining it multiple times with virtual background enabled and set to blur effect.
- If the local client used a camera with a resolution set to 1920 × 1080 as the video capture source, the resolution of the remote video was occasionally inconsistent with the local client.
- When capturing video through the camera, if the video aspect ratio set in `CameraCapturerConfiguration` was inconsistent with that set in `setVideoEncoderConfiguration`, the aspect ratio of the local video preview was not rendered according to the latter setting.
- In screen sharing scenarios, when the user minimized and then restored the shared window, the remote video occasionally switched to the low-quality stream.
- When the host started screen sharing during live streaming, the audience members sometimes heard echoes.
- In screen sharing scenarios, the system volume of the local user occasionally decreased.
- In screen sharing scenarios, a black screen appeared when sharing a screen between a landscape monitor and a portrait monitor.
- In screen sharing scenarios with a window excluded, the application crashed when the specified shared area exceeded the screen resolution.
- The application failed to exclude a window using the `startScreenCaptureByDisplayId` method for screen sharing.
- In screen sharing scenarios, the screen seen by the remote user occasionally crashed, lagged, or displayed a black screen.
- The uplink network quality reported by the `onNetworkQuality` callback was inaccurate for the user who was sharing a screen.
- In screen sharing scenarios, when the user shared the screen by window, the mouse in the shared screen was not in its actual position.
- When switching from a non-screen sharing scenario to a screen sharing one, the application occasionally crashed if the user did not switch the resolution accordingly.


**macOS**
- When capturing video through the camera, if the video aspect ratio set in `CameraCapturerConfiguration` was inconsistent with that set in `setVideoEncoderConfiguration`, the aspect ratio of the local video preview was not rendered according to the latter setting.
- In screen sharing scenarios on Mac devices, when the user minimized or closed a shared application window, another window of the same application was automatically shared.
- In screen sharing scenarios, the system volume of the local user occasionally decreased.
- In screen sharing scenarios, the shared window of a split screen was not highlighted correctly.
- In screen sharing scenarios, the screen seen by the remote user occasionally crashed, lagged, or displayed a black screen.
- The uplink network quality reported by the `onNetworkQuality` callback was inaccurate for the user who was sharing a screen.
- After starting and stopping the audio capture device test, there was no sound when the audio playback device was subsequently started.
- The `onVideoPublishStateChanged` callback reported an inaccurate video source type.



#### API changes

**Added**

- `getNativeHandle`
- `getPlaybackDefaultDevice`
- `getRecordingDefaultDevice`
- `enableDualStreamModeEx`
- `setDualStreamMode`
- `setDualStreamModeEx`
- `SimulcastStreamMode`
- `getNetworkType`
- `setLoopbackDevice` (Windows)
- `getLoopbackDevice` (Windows)
- `followSystemLoopbackDevice` (Windows)
- `setZones`
- `setPlayerAttenuation`
- `setRemoteAudioAttenuation`
- `setHeadphoneEQPreset`
- `setHeadphoneEQParameters`
- `HeadphoneEqualizerPreset`
- `enableMultiCamera` (iOS)
- `setRemoteVideoSubscriptionOptions`
- `setRemoteVideoSubscriptionOptionsEx`
- `VideoSubscriptionOptions`
- `AdvanceOptions`
- `EncodingPreference`
- `CompressionPreference`
- `adjustUserPlaybackSignalVolumeEx`
- `onRhythmPlayerStateChanged` (Android, iOS)
- `RhythmPlayerStateType`
- `RhythmPlayerErrorType`
- `enableAudioVolumeIndicationEx`
- `onVideoDeviceStateChanged` (Windows, macOS)
- `onAudioDeviceStateChanged` (Windows, macOS)
- `onAudioDeviceVolumeChanged` (Windows, macOS)
- `registerExtension` (Windows)
- `muteLocalAudioStreamEx`
- `muteLocalVideoStreamEx`
- `muteAllRemoteAudioStreamsEx`
- `muteAllRemoteVideoStreamsEx`
- `startRtmpStreamWithoutTranscodingEx`
- `startRtmpStreamWithTranscodingEx`
- `updateRtmpTranscodingEx`
- `stopRtmpStreamEx`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelayEx`
- `pauseAllChannelMediaRelayEx`
- `resumeAllChannelMediaRelayEx`
- `stopChannelMediaRelayEx`


**Modified**

- Adds `isAudioFilterable` in `ChannelMediaOptions`
- Adds `enableDoppler` in `SpatialAudioParams`
- Adds `minimizeWindow` in `ScreenCaptureSourceInfo`
- Adds `followEncodeDimensionRatio` in `CameraCapturerConfiguration`
- Adds `options` in `leaveChannelEx`
- Adds `advanceOptions` in `VideoEncoderConfiguration`
- Adds `newRoleOptions` in `onClientRoleChanged`
- Adds `setupMode`, `mediaPlayerId`, and `cropArea` in `VideoCanvas`
- Adds `hwEncoderAccelerating` in `LocalVideoStats`
- Removes `sourceType` in `enableDualStreamMode`
- `enableInEarMonitoring`: Supports Windows and macOS
- `setEarMonitoringAudioFrameParameters`: Supports Windows and macOS
- `setInEarMonitoringVolume`: Supports Windows and macOS
- `onEarMonitoringAudioFrame`: Supports Windows and macOS
- `ScreenCaptureParameters`: Supports Windows


**Deprecated**

- `onApiCallExecuted`: Use the callbacks triggered by specific methods instead.
- `relayEventPacketUpdateDestChannelRefused (8)` in `ChannelMediaRelayEvent`


## v6.0.0

v6.0.0 was released on September 15, 2022.

#### New features

**2. Ultra HD resolution (Beta) (Windows, macOS)**

In order to improve the interactive video experience, the SDK optimizes the whole process of video capture, encoding, decoding and rendering, and now supports 4K resolution. The improved FEC (Forward Error Correction) algorithm enables adaptive switches according to the frame rate and number of video frame packets, which further reduces the video stuttering rate in 4K scenes.

Additionally, you can set the encoding resolution to 4K (3840 × 2160) and the frame rate to 60 fps when calling `setVideoEncoderConfiguration`. The SDK supports automatic fallback to the appropriate resolution and frame rate if your device does not support 4K.

<div class="alert info"><li>This feature has certain requirements with regards to device performance and network bandwidth, and the supported upstream and downstream frame rates vary on different platforms. To experience this feature, contact [support@agora.io](mailto:support@agora.io).
<li>The increase in the default resolution affects the aggregate resolution and thus the billing rate. See <a href="./billing_rtc_ng">Pricing</a>.</div>


**3. Full HD and Ultra HD resolution (Android, iOS)**

In order to improve the interactive video experience, the SDK optimizes the whole process of video capturing, encoding, decoding and rendering. Starting from this version, it supports Full HD (FHD) and Ultra HD (UHD) video resolutions. You can set the `dimensions` parameter to 1920 × 1080 or higher resolution when calling the `setVideoEncoderConfiguration` method. If your device does not support high resolutions, the SDK will automatically fall back to an appropriate resolution.

<div class="alert info"><li>The UHD resolution (4K, 60 fps) is currently in beta and requires certain device performance and network bandwidth. If you want to experience this feature, contact <a href="mailto:support@agora.io">technical support</a>.
<li>High resolution typically means higher performance consumption. To avoid a decrease in experience due to insufficient device performance, Agora recommends that you enable FHD and UHD video resolutions on devices with better performance.
<li>The increase in the default resolution affects the aggregate resolution and thus the billing rate. See <a href="./billing_rtc_ng">Pricing</a>.</div>
