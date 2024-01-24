## Known issues and limitations

**Android 14 screen sharing issue (Android)**

On Android 14 devices (such as OnePlus 11), screen sharing may not be available when `targetSdkVersion` is set to 34. For example, half of the shared screen may be black. To avoid this issue, Agora recommends setting `targetSdkVersion` to 34 or below. However, this may cause the screen sharing process to be interrupted when switching between portrait and landscape mode. In this case, a window will pop up on the device asking if you want to start recording the screen. After confirming, you can resume screen sharing.

**AirPods Pro Bluetooth connection issue (iOS)**

AirPods Pro does not support A2DP protocol in communication audio mode, which may lead to connection failure in that mode.

## v4.3.0

v4.3.0 was released on xx xx, 2024.

#### Compatibility changes

This release has optimized the implementation of some functions, involving renaming or deletion of some APIs. To ensure the normal operation of the project, you need to update the code in the app after upgrading to this release.

1. **Renaming parameters in callbacks**

   In order to make the parameters in some callbacks and the naming of enumerations in enumeration classes easier to understand, the following modifications have been made in this release. Please modify the parameter settings in the callbacks after upgrading to this release.

   | Callback                           | Original parameter name | Existing parameter name |
   | ---------------------------------- | ----------------------- | ----------------------- |
   | `OnLocalAudioStateChanged`         | `error`                 | `reason`                |
   | `onLocalVideoStateChanged`         | `error`                 | `reason`                |
   | `OnDirectCdnStreamingStateChanged` | `error`                 | `reason`                |
   | `OnRtmpStreamingStateChanged`      | `errCode`               | `reason`                |

   | Original enumeration class   | Current enumeration class    |
   | ---------------------------- | ---------------------------- |
   | `LOCAL_AUDIO_STREAM_ERROR`   | `LOCAL_AUDIO_STREAM_ERROR`   |
   | `LOCAL_VIDEO_STREAM_ERROR`   | `LOCAL_VIDEO_STREAM_ERROR`   |
   | `DIRECT_CDN_STREAMING_ERROR` | `DIRECT_CDN_STREAMING_ERROR` |
   | `MEDIA_PLAYER_ERROR`         | `MEDIA_PLAYER_ERROR`         |
   | `RTMP_STREAM_PUBLISH_ERROR`  | `RTMP_STREAM_PUBLISH_ERROR`  |

   **Note:** For specific renaming of enumerations, please refer to [API changes](#change).

2. **Channel media relay**

   To improve interface usability, this release removes some methods and callbacks for channel media relay. Use the alternative options listed in the table below:

   | Deleted methods and callbacks                                | Alternative methods and callbacks                            |
   | ------------------------------------------------------------ | ------------------------------------------------------------ |
   | <li>`startChannelMediaRelay`</li><li>`updateChannelMediaRelay`</li> | `startOrUpdateChannelMediaRelay`                             |
   | <li>`startChannelMediaRelayEx`</li><li>`updateChannelMediaRelayEx`</li> | `startOrUpdateChannelMediaRelayEx`                           |
   | <li>`onChannelMediaRelayEvent`</li><li>`CHANNEL_MEDIA_RELAY_EVENT`</li> | <li>`onChannelMediaRelayStateChanged`</li><li>`CHANNEL_MEDIA_RELAY_STATE`</li><li>`CHANNEL_MEDIA_RELAY_ERROR`</li> |

3. **Reasons for local video state changes**

   This release makes the following modifications to the enumerations in the [LOCAL_VIDEO_STREAM_REASON](API/enum_localvideostreamreason.html) class:

   - The value of `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_PAUSED` (formerly `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_PAUSED`) has been changed from 23 to 28. 
   - The value of `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_RESUMED` (formerly `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_RESUMED`) has been changed from 24 to 29. 
   - The `LOCAL_VIDEO_STREAM_ERROR_CODEC_NOT_SUPPORT` enumeration has been changed to `LOCAL_VIDEO_STREAM_ERROR_CODEC_NOT_SUPPORT`.

#### New features

1. **Local preview with multiple views**

   This release supports local preview with simultaneous display of multiple frames, where the videos shown in the frames are positioned at different observation positions along the video link. Examples of usage are as follows:

   1. Call [SetupLocalVideo](API/api_irtcengine_setuplocalvideo.html) to set the first view: Set the `position` parameter to `POSITION_POST_CAPTURER_ORIGIN` (introduced in this release) in `VideoCanvas`. This corresponds to the position after local video capture and before preprocessing. The video observed here does not have preprocessing effects.
   2. Call [SetupLocalVideo](API/api_irtcengine_setuplocalvideo.html) to set the second view: Set the `position` parameter to `POSITION_POST_CAPTURER` in `VideoCanvas`, the video observed here has the effect of video preprocessing.
   3. Observe the local preview effect: The first view is the original video of a real person; the second view is the virtual portrait after video preprocessing (including image enhancement, virtual background, and local preview of watermarks) effects.

2. **Query Device Score**

   This release adds the [QueryDeviceScore](API/api_irtcengine_querydevicescore.html) method to query the device's score level to ensure that the user-set parameters do not exceed the device's capabilities. For example, in HD or UHD video scenarios, you can first call this method to query the device's score. If the returned score is low (for example, below 60), you need to lower the video resolution to avoid affecting the video experience. The minimum device score required for different business scenarios is varied. For specific score recommendations, please contact [technical support](mailto:support@agora.io).

3. **Select different audio tracks for local playback and streaming**

   This release introduces the [SelectMultiAudioTrack](API/api_imediaplayer_selectmultiaudiotrack.html) method that allows you to select different audio tracks for local playback and streaming to remote users. For example, in scenarios like online karaoke, the host can choose to play the original sound locally and publish the accompaniment in the channel. Before using this function, you need to open the media file through the [OpenWithMediaSource](API/api_imediaplayer_openwithmediasource.html) method and enable this function by setting the `enableMultiAudioTrack` parameter in [MediaSource](API/class_mediasource.html).

4. **Others**

   This release has passed the test verification of the following APIs and can be applied to the entire series of RTC 4.x SDK.

   - [SetRemoteSubscribeFallbackOption](API/api_irtcengine_setremotesubscribefallbackoption.html): Sets fallback option for the subscribed video stream in weak network conditions.
   - [OnRemoteSubscribeFallbackToAudioOnly](API/callback_irtcengineeventhandler_onremotesubscribefallbacktoaudioonly.html): Occurs when the subscribed video stream falls back to audio-only stream due to weak network conditions or switches back to the video stream after the network conditions improve.
   - [GetRecordingDeviceVolume](API/api_iaudiodevicemanager_getrecordingdevicevolume.html)(Windows): Sets the volume of the audio capturing device.
   - [SetPlayerOption [1/2]](API/api_imediaplayer_setplayeroption.html) and [setPlayerOption [2/2]](API/api_imediaplayer_setplayeroption2.html): Sets media player options for providing technical previews or special customization features.
   - [EnableCustomAudioLocalPlayback](API/api_irtcengine_enablecustomaudiolocalplayback.html): Sets whether to enable the local playback of external audio source.

#### Improvements

1. **SDK task processing scheduling optimization**

   This release optimizes the scheduling mechanism for internal tasks within the SDK, with improvements in the following aspects:

   - There is a noticeable increase in the speed of video rendering and audio playback for both remote and local first frames.
   - The time taken for API calls and response is reduced by more than 50%.
   - The SDK's parallel processing capability significantly improves, delivering higher video quality (720P, 24 fps) even on lower-end devices. Additionally, image processing remains more stable in scenarios involving high resolutions and frame rates.
   - The stability of the SDK is further enhanced, leading to a noticeable decrease in the crash rate across various specific scenarios.

2. **In-ear monitoring volume boost**

   This release provides users with more flexible in-ear monitoring audio adjustment options, supporting the ability to set the in-ear monitoring volume to four times the original volume by calling [SetInEarMonitoringVolume](API/api_irtcengine_setinearmonitoringvolume.html).

3. **Dual-stream mode optimization**

   This release optimizes the video dual-stream mode. In the low-quality video stream adaptive mode (`AUTO_SIMULCAST_STREAM`), when the receiver requests a low-quality video stream by calling [SetRemoteVideoStreamType](API/api_irtcengine_setremotevideostreamtype.html) or [SetRemoteVideoStreamTypeEx](API/api_irtcengineex_setremotevideostreamtypeex.html), the sender now processes requests from all users, expanding beyond the previous restriction to broadcasters only. This change ensures that the audience requests for low-quality video streams are implemented, thus improving the flexibility and adaptability of the dual-stream mode.

4. **Spatial audio effects usability improvement**

   - This release optimizes the design of the [SetZones](API/api_ibasespatialaudioengine_setzones.html) method, supporting the ability to set the `zones` parameter to `NULL`, indicating the clearing of all echo cancellation zones.
   - As of this release, it is no longer necessary to unsubscribe from the audio streams of all remote users within the channel before calling the methods in [ILocalSpatialAudioEngine](API/class_ilocalspatialaudioengine.html).

5. **Other Improvements**

   This release also includes the following improvements:

   - This release optimizes the SDK's domain name resolution strategy, improving the stability of calling to resolve domain names in complex network environments.
   - When passing in an image with transparent background as the virtual background image, the transparent background can be filled with customized color. 
   - This release adds the `earMonitorDelay` and `aecEstimatedDelay` members in [LocalAudioStats](API/class_localaudiostats.html) to report ear monitor delay and acoustic echo cancellation (AEC) delay, respectively.
   - The [OnPlayerCacheStats](API/callback_imediaplayersourceobserver_onplayercachestats.html) callback is added to reports the statistics of the media file being cached. This callback is triggered once per second after file caching is started.
   - The [OnPlayerPlaybackStats](API/callback_imediaplayersourceobserver_onplayerplaybackstats.html) callback is added to reports the statistics of the media file being played. This callback is triggered once per second after the media file starts playing. You can obtain information like the audio and video bitrate of the media file through [PlayerPlaybackStats](API/class_playerplaybackstats.html).

#### Issues fixed

This release fixed the following issues:

- When sharing two screen sharing video streams simultaneously, the reported `captureFrameRate` in the [OnLocalVideoStats](API/callback_irtcengineeventhandler_onlocalvideostats.html) callback is 0, which is not as expected.

#### API changes

<a name="change"></a>

**Added**

- The ` subviewUid` member in [VideoCanvas](API/class_videocanvas.html)
- [EnableCustomAudioLocalPlayback](API/api_irtcengine_enablecustomaudiolocalplayback.html)
- [QueryDeviceScore](API/api_irtcengine_querydevicescore.html)
- The `CUSTOM_VIDEO_SOURCE` enumeration in [MEDIA_SOURCE_TYPE](API/enum_mediasourcetype.html)
- The `ROUTE_BLUETOOTH_DEVICE_A2DP` enumeration in [AudioRoute](API/enum_audioroute.html)
- [SelectMultiAudioTrack](API/api_imediaplayer_selectmultiaudiotrack.html)
- [OnPlayerCacheStats](API/callback_imediaplayersourceobserver_onplayercachestats.html)
- [OnPlayerPlaybackStats](API/callback_imediaplayersourceobserver_onplayerplaybackstats.html)
- [PlayerPlaybackStats](API/class_playerplaybackstats.html)

**Modified**

- All `ERROR` fields in the following enumerations are changed to `REASON`:

- - `LOCAL_AUDIO_STREAM_ERROR_OK`
  - `LOCAL_AUDIO_STREAM_ERROR_FAILURE`
  - `LOCAL_AUDIO_STREAM_ERROR_DEVICE_NO_PERMISSION`
  - `LOCAL_AUDIO_STREAM_ERROR_DEVICE_BUSY`
  - `LOCAL_AUDIO_STREAM_ERROR_RECORD_FAILURE`
  - `LOCAL_AUDIO_STREAM_ERROR_ENCODE_FAILURE`
  - `LOCAL_AUDIO_STREAM_ERROR_RECORD_INVALID_ID` 
  - `LOCAL_AUDIO_STREAM_ERROR_PLAYOUT_INVALID_ID` 
  - `LOCAL_VIDEO_STREAM_ERROR_OK`
  - `LOCAL_VIDEO_STREAM_ERROR_FAILURE`
  - `LOCAL_VIDEO_STREAM_ERROR_DEVICE_NO_PERMISSION`
  - `LOCAL_VIDEO_STREAM_ERROR_DEVICE_BUSY`
  - `LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE`
  - `LOCAL_VIDEO_STREAM_ERROR_CODEC_NOT_SUPPORT`
  - `LOCAL_VIDEO_STREAM_ERROR_DEVICE_NOT_FOUND`
  - `LOCAL_VIDEO_STREAM_ERROR_DEVICE_DISCONNECTED`
  - `LOCAL_VIDEO_STREAM_ERROR_DEVICE_INVALID_ID`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_MINIMIZED`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_CLOSED`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_OCCLUDED`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_NO_PERMISSION` 
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_PAUSED` 
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_RESUMED` 
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_HIDDEN` 
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_HIDDEN` 
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_MINIMIZED` 
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_FAILURE` 
  - `LOCAL_VIDEO_STREAM_ERROR_DEVICE_SYSTEM_PRESSURE` 
  - `DIRECT_CDN_STREAMING_ERROR_OK`
  - `DIRECT_CDN_STREAMING_ERROR_FAILED`
  - `DIRECT_CDN_STREAMING_ERROR_AUDIO_PUBLICATION`
  - `DIRECT_CDN_STREAMING_ERROR_VIDEO_PUBLICATION`
  - `DIRECT_CDN_STREAMING_ERROR_NET_CONNECT`
  - `DIRECT_CDN_STREAMING_ERROR_BAD_NAME`
  - `PLAYER_ERROR_NONE`
  - `PLAYER_ERROR_INVALID_ARGUMENTS`
  - `PLAYER_ERROR_INTERNAL`
  - `PLAYER_ERROR_NO_RESOURCE`
  - `PLAYER_ERROR_INVALID_MEDIA_SOURCE`
  - `PLAYER_ERROR_UNKNOWN_STREAM_TYPE`
  - `PLAYER_ERROR_OBJ_NOT_INITIALIZED`
  - `PLAYER_ERROR_CODEC_NOT_SUPPORTED`
  - `PLAYER_ERROR_VIDEO_RENDER_FAILED`
  - `PLAYER_ERROR_INVALID_STATE`
  - `PLAYER_ERROR_URL_NOT_FOUND`
  - `PLAYER_ERROR_INVALID_CONNECTION_STATE`
  - `PLAYER_ERROR_SRC_BUFFER_UNDERFLOW`
  - `PLAYER_ERROR_INTERRUPTED`
  - `PLAYER_ERROR_NOT_SUPPORTED`
  - `PLAYER_ERROR_TOKEN_EXPIRED`
  - `PLAYER_ERROR_UNKNOWN`
  - `RTMP_STREAM_PUBLISH_ERROR_OK`
  - `RTMP_STREAM_PUBLISH_ERROR_INVALID_ARGUMENT`
  - `RTMP_STREAM_PUBLISH_ERROR_ENCRYPTED_STREAM_NOT_ALLOWED`
  - `RTMP_STREAM_PUBLISH_ERROR_CONNECTION_TIMEOUT`
  - `RTMP_STREAM_PUBLISH_ERROR_INTERNAL_SERVER_ERROR`
  - `RTMP_STREAM_PUBLISH_ERROR_RTMP_SERVER_ERROR`
  - `RTMP_STREAM_PUBLISH_ERROR_TOO_OFTEN`
  - `RTMP_STREAM_PUBLISH_ERROR_REACH_LIMIT`
  - `RTMP_STREAM_PUBLISH_ERROR_NOT_AUTHORIZED`
  - `RTMP_STREAM_PUBLISH_ERROR_STREAM_NOT_FOUND`
  - `RTMP_STREAM_PUBLISH_ERROR_FORMAT_NOT_SUPPORTED`
  - `RTMP_STREAM_PUBLISH_ERROR_NOT_BROADCASTER`
  - `RTMP_STREAM_PUBLISH_ERROR_TRANSCODING_NO_MIX_STREAM`
  - `RTMP_STREAM_PUBLISH_ERROR_NET_DOWN`
  - `RTMP_STREAM_PUBLISH_ERROR_INVALID_PRIVILEGE`
  - `RTMP_STREAM_UNPUBLISH_ERROR_OK`

**Deleted**

- `StartChannelMediaRelay`
- `UpdateChannelMediaRelay`
- `StartChannelMediaRelayEx`
- `UpdateChannelMediaRelayEx`
- `OnChannelMediaRelayEvent`
- `CHANNEL_MEDIA_RELAY_EVENT`

## v4.2.6

v4.2.6 was released on November xx, 2023.

#### Issues fixed

This version fixed the following issues that may occur when using Android 14:

- When switching between portrait and landscape modes during screen sharing, the screen sharing process was interrupted. To restart screen sharing, users need to confirm recording the screen in the pop-up window. (Android)
- When integrating the SDK, setting the Android `targetSdkVersion` to 34 may cause screen sharing to be unavailable or even cause the app to crash. (Android)
- Calling `StartScreenCapture`[1/2] without sharing video (setting `captureVideo` to `false`) and then calling `UpdateScreenCaptureParameters` to share video (setting `captureVideo`to `true`) resulted in a frozen shared screen at the receiving end. (Android)
- When screen sharing in landscape mode, the shared screen seen by the audience was divided into two parts: one side of the screen was compressed; the other side was black. (Android)

This version also fixed the following issues:

- When using an iOS 16 or later device with Bluetooth headphones connected before joining the channel, the audio routing after joining the channel was not as expected: audio was played from the speaker, not the Bluetooth headphones. (iOS)
- In live streaming scenarios, the video on the audience end occasionally distorted. (Android)
- In specific scenarios (such as when the network packet loss rate was high or when the broadcaster left the channel without destroying the engine and then re-joined the channel), the video on the receiving end stuttered or froze.

## v4.2.4

v4.2.4 was released on October xx, 2023.

This version fixes the incorrect `CFBundleShortVersionString` version number in `AgoraRtcWrapper` which caused the app to be unable to be submitted to the App Store. (iOS, macOS)

## v4.2.3

v4.2.3 was released on October xx, 2023.

#### New features

1. **Update video screenshot and upload**

   To facilitate the integration of third-party video moderation services from Agora Extensions Marketplace, this version has the following changes:

   - The `CONTENT_INSPECT_IMAGE_MODERATION` enumeration is added in `CONTENT_INSPECT_TYPE` which means using video moderation extensions from Agora Extensions Marketplace to take video screenshots and upload them.
   - An optional parameter `serverConfig` is added in `ContentInspectConfig`, which is for server-side configuration related to video screenshot and upload via extensions from Agora Extensions Marketplace. By configuring this parameter, you can integrate multiple third-party moderation extensions and achieve flexible control over extension switches and other features. For more details, please contact [technical support](mailto:support@agora.io).

   In addition, this version also introduces the `EnableContentInspectEx` method, which supports taking screenshots for multiple video streams and uploading them.

2. **ID3D11Texture2D Rendering** (Windows)

   As of this release, the SDK supports video formats of type ID3D11Texture2D, improving the rendering effect of video frames in game scenarios. You can set `format` to `VIDEO_TEXTURE_ID3D11TEXTURE2D` when pushing external raw video frames to the SDK by calling `PushVideoFrame`. By setting the `d3d11_texture_2d` and `texture_slice_index` properties, you can determine the ID3D11Texture2D texture object to use.

3. **Local video status error code update** (Windows, macOS)

   In order to help users understand the exact reasons for local video errors in screen sharing scenarios, the following sets of enumerations have been added to the `OnLocalVideoStateChanged` callback:

   - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_PAUSED`(23): Screen capture has been paused. Common scenarios for reporting this error code: The current screen may have been switched to a secure desktop, such as a UAC dialog box or Winlogon desktop.
   - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_RESUMED`(24): Screen capture has resumed from the paused state.
   - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_HIDDEN`(25): The window being captured on the current screen is in a hidden state and is not visible on the current screen.
   - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_HIDDEN`(26): The window for screen capture has been restored from the hidden state.
   - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_MINIMIZED`(27): The window for screen capture has been restored from the minimized state.

4. **Check device support for advanced features**

   This version adds the `IsFeatureAvailableOnDevice` method to check whether the capability of the current device meets the requirements of the specified advanced feature, such as virtual background and image enhancement.

   Before using advanced features, you can check whether the current device supports these features based on the call result. This helps to avoid performance degradation or unavailable features when enabling advanced features on low-end devices. Based on the return value of this method, you can decide whether to display or enable the corresponding feature button, or notify the user when the device's capabilities are insufficient.

   In addition, since this version, calling `EnableVirtualBackground` and `SetBeautyEffectOptions` automatically triggers a test on the capability of the current device. When the device is considered underperformed, the error code `-4:ERR_NOT_SUPPORTED` is returned, indicating the device does not support the feature.

#### Improvements

1. **Optimize virtual background memory usage**

   This version has upgraded the virtual background algorithm, reducing the memory usage of the virtual background feature. Compared to the previous version, the memory consumption of the app during the use of the virtual background feature on low-end devices has been reduced by approximately 4% to 10% (specific values may vary depending on the device model and platform).

2. **Screen sharing scenario optimization**

   This release optimizes the performance and encoding efficiency in ultra-high-definition (4K, 60 fps) game sharing scenarios, effectively reducing the system resource usage during screen sharing.

**Other Improvements**

This release includes the following additional improvements:

- Optimizes the logic of handling invalid parameters. When you call the `SetPlaybackSpeed` method to set the playback speed of audio files, if you pass an invalid parameter, the SDK returns the error code -2, which means that you need to reset the parameter.
- Optimizes the logic of Token parsing, in order to prevent an app from crash when an invalid token is passed in.

#### Issues fixed

This release fixed the following issues:

- Occasional crashes and dropped frames occurred in screen sharing scenarios. (Windows)
- Occasional crashes when joining a channel. (macOS)
- Occasional failure of joining a channel when the local system time was not set correctly.
- When calling the `PlayEffect` method to play two audio files using the same `soundId`, the first audio file was sometimes played repeatedly.
- When the host called the `StartAudioMixing` [2/2] method to play music, sometimes the host couldn't hear the music while the remote users could hear it. (Android)
- Occasional crashes occurred on certain Android devices. (Android)
- Calling `TakeSnapshotEx` once receives the `OnSnapshotTaken` callback for multiple times.
- In channels joined by calling `JoinChannelEx` exclusively, calling `SetEnableSpeakerphone` is unable to switch audio route from the speaker to the headphone. (Android)

#### API changes

**Added**

- The following enumerations in `OnLocalVideoStateChanged`: (Windows, macOS)
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_PAUSED`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_RESUMED`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_HIDDEN`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_HIDDEN`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_MINIMIZED`
- `d3d11_texture_2d` and `texture_slice_index` members in `ExternalVideoFrame` (Windows)
- `VIDEO_TEXTURE_ID3D11TEXTURE2D` in `VIDEO_PIXEL_FORMAT` (Windows)
- `EnableContentInspectEx`
- `CONTENT_INSPECT_IMAGE_MODERATION` in `CONTENT_INSPECT_TYPE`
- `serverConfig` in `ContentInspectConfig`
- `IsFeatureAvailableOnDevice`
- `FeatureType`

## v4.2.2

This version was released on July, xx, 2023.

#### Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

1. **Audio frame observer**

The following methods in the `IAudioFrameObserver` class are deleted:

- `GetObservedAudioFramePosition`: Use the newly-added `position` parameter in  `RegisterAudioFrameObserver` instead.
- `GetPlaybackAudioParams`: Use `SetPlaybackAudioFrameParameters` instead.
- `GetRecordAudioParams`: Use `SetRecordingAudioFrameParameters` instead.
- `GetMixedAudioParams`: Use `SetMixedAudioFrameParameters` instead.
- `GetEarMonitoringAudioParams`: Use `SetEarMonitoringAudioFrameParameters` instead.

2. **Video frame observer**

The following methods in the `IVideoFrameObserver` class are deleted:

- `GetVideoFormatPreference`: Use the newly-added `formatPreference` parameter in  `RegisterVideoFrameObserver`.
- `GetObservedFramePosition`: Use the newly-added `position` parameter in  `RegisterVideoFrameObserver`.

3. **Metadata**

This release deletes `GetMaxMetadataSize` and `OnReadyToSendMetadata` in the `IMetadataObserver` class. You can use the newly-added `SetMaxMetadataSize` and `SendMetadata` methods instead.

#### New features

1. **Wildcard token**

   This release introduces wildcard tokens. Agora supports setting the channel name used for generating a token as a wildcard character. The token generated can be used to join any channel if you use the same user id. In scenarios involving multiple channels, such as switching between different channels, using a wildcard token can avoid repeated application of tokens every time users joining a new channel, which reduces the pressure on your token server. See [Wildcard Tokens](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms).

   <div class="alert info">All 4.x SDKs support using wildcard tokens.</div>

2. **Preloading channels**

   This release adds `PreloadChannel[1/2]` and `PreloadChannel[2/2]` methods, which allows a user whose role is set as audience to preload channels before joining one. Calling the method can help shortening the time of joining a channel, thus reducing the time it takes for audience members to hear and see the host.

   When preloading more than one channels, Agora recommends that you use a wildcard token for preloading to avoid repeated application of tokens every time you joining a new channel, thus saving the time for switching between channels. See [Wildcard Tokens](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms).

3. **Customized background color of video canvas**

   In this release, the `backgroundColor` member has been added to `VideoCanvas`, which allows you to customize the background color of the video canvas when setting the properties of local or remote video display.

4. **Publishing video streams from different sources** (Windows, macOS)

   This release adds the following members in `ChannelMediaOptions` to allow you publish video streams captured from the third and fourth camera or screen:

   - `publishThirdCameraTrack`: Publishing the video stream captured from the third camera.
   - `publishFourthCameraTrack`: Publishing the video stream captured from the fourth camera.
   - `publishThirdScreenTrack`: Publishing the video stream captured from the third screen.
   - `publishFourthScreenTrack`: Publishing the video stream captured from the fourth screen.

   <div class="alert info">For one <code>RtcConnection</code>, Agora supports publishing multiple audio streams and one video stream at the same time.</div>

#### Improvements

1. **Improved camera capture effect** (Android, iOS)

   This release has improved camera capture effect in the following aspects:

   1. Support for camera exposure adjustment

      This release adds `IsCameraExposureSupported` to query whether the device supports exposure adjustment and `SetCameraExposureFactor` to set the exposure ratio of the camera.

   2. Optimization of default camera selection (iOS)

      Since this release, the default camera selection behavior of the SDK is aligned with that of the iOS system camera. If the device has multiple rear cameras, better shooting perspectives, zooming capabilities, low-light performance, and depth sensing can be achieved during video capture, thereby improving the quality of video capture.

2. **Virtual Background Algorithm Upgrade**

   This version has upgraded the portrait segmentation algorithm of the virtual background, which comprehensively improves the accuracy of portrait segmentation, the smoothness of the portrait edge with the virtual background, and the fit of the edge when the person moves. In addition, it optimizes the precision of the person's edge in scenarios such as meetings, offices, homes, and under backlight or weak light conditions.

3. **Channel media relay**

   The number of target channels for media relay has been increased to 6. When calling `StartOrUpdateChannelMediaRelay` and `StartOrUpdateChannelMediaRelayEx`, you can specify up to 6 target channels.

4. **Enhancement in video codec query capability**

   To improve the video codec query capability, this release adds the `codecLevels` member in `CodecCapInfo`. After successfully calling `QueryCodecCapability`, you can obtain the hardware and software decoding capability levels of the device for H.264 and H.265 video formats through `codecLevels`.

This release includes the following additional improvements:

1. To improve the switching experience between multiple audio routes, this release adds the `SetRouteInCommunicationMode` method. This method can switch the audio route from a Bluetooth headphone to the earpiece, wired headphone or speaker in communication volume mode ([`MODE_IN_COMMUNICATION`](https://developer.android.google.cn/reference/kotlin/android/media/AudioManager?hl=en#mode_in_communication)). (Android)
2. The SDK automacially adjusts the frame rate of the sending end based on the screen sharing scenario. Especially in document sharing scenarios, this feature avoids exceeding the expected video bitrate on the sending end to improve transmission efficiency and reduce network burden.
3. To help users understand the reasons for more types of remote video state changes, the `REMOTE_VIDEO_STATE_REASON_CODEC_NOT_SUPPORT` enumeration has been added to the `OnRemoteVideoStateChanged` callback, indicating that the local video decoder does not support decoding the received remote video stream.

#### Issues fixed

This release fixed the following issues:

- Occasionally, noise occurred when the local user listened to their own and remote audio after joining the channel. (macOS)
- Slow channel reconnection after the connection was interrupted due to network reasons.
- In screen sharing scenarios, the delay of seeing the shared screen was occasionally higher than expected on some devices.
- In custom video capturing scenarios, `SetBeautyEffectOptions`, `SetLowlightEnhanceOptions`, `SetVideoDenoiserOptions`, and `SetColorEnhanceOptions` could not load extensions automatically.
- In multi-device audio recording scenarios, after repeatedly plugging and unplugging or enabling/disabling the audio recording device, no sound could be heard occasionally when calling the `StartRecordingDeviceTest` to start an audio capturing device test. (Windows)

#### API changes

**Added**

- `SetCameraExposureFactor` (Android, iOS)
- `IsCameraExposureSupported` (Android, iOS)
- `PreloadChannel[1/2]`
- `PreloadChannel[2/2]`
- `UpdatePreloadChannelToken`
- `SetRouteInCommunicationMode` (Android)
- The following members in `ChannelMediaOptions` (Windows, macOS):
  - `publishThirdCameraTrack`
  - `publishFourthCameraTrack`
  - `publishThirdScreenTrack`
  - `publishFourthScreenTrack`
- `CodecCapLevels`
- `VIDEO_CODEC_CAPABILITY_LEVEL`
- `backgroundColor` in `VideoCanvas`
- `codecLevels` in `CodecCapInfo`
- `REMOTE_VIDEO_STATE_REASON_CODEC_NOT_SUPPORT` in `REMOTE_VIDEO_STATE_REASON`
- `SetMaxMetadataSize`
- `SendMetadata`
- `position` parameter in `RegisterAudioFrameObserver`
- `formatPreference` and `position`  parameters in `RegisterVideoFrameObserver`

**Deleted**

- `GetObservedAudioFramePosition`
- `GetPlaybackAudioParams`
- `GetRecordAudioParams`
- `GetMixedAudioParams`
- `GetEarMonitoringAudioParams`
- `GetVideoFormatPreference`
- `GetObservedFramePosition`
- `GetMaxMetadataSize`
- `OnReadyToSendMetadata`

## v4.2.1

This version was released on June 21, 2023.

#### Improvements

This version improves the network transmission strategy, enhancing the smoothness of audio and video interactions.

#### Fixed Issues

This version fixed the following issues:

- Inability to join channels caused by SDK's incompatibility with some older versions of AccessToken.
- After the sending end called `SetAINSMode` to activate AI noise reduction, occasional echo was observed by the receiving end.
- Brief noise occurred while playing media files using the media player.
- After enabling the screen sharing function on the sending end, there was high delay until the receiving end could see the shared screen. (macOS)
- Occasional crash after calling the `DestroyMediaPlayer` method. (iOS)
- When the sending end mixed and published two streams of video captured by two cameras locally, the video from the second camera was occasionally missing on the receiving end. (Windows)
- In screen sharing scenarios, some Android devices experienced choppy video on the receiving end. (Android)

## v4.2.0

v4.2.0 was released on May xx, 2023.

#### Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

**1. Video capture (Windows, iOS)**

This release optimizes the APIs for camera and screen capture function. As of v4.2.0, ensure you use the alternative methods listed in the table below and specify the video source by setting the `sourceType` parameter.

| Deleted Methods                                              | Alternative Methods       |
| :----------------------------------------------------------- | :------------------------ |
| <li>`StartPrimaryCameraCapture`（Windows）</li><li>`StartSecondaryCameraCapture`（Windows，iOS）<li> | `StartCameraCapture`      |
| <li>`StopPrimaryCameraCapture`（Windows）</li><li>`StopSecondaryCameraCapture`（Windows，iOS）</li> | `StopCameraCapture`       |
| <li>`StartPrimaryScreenCapture `（Windows）</li>`StartSecondaryScreenCapture`（Windows，iOS）</li> | `StartScreenCapture`[2/2] |
| <li>`StopPrimaryScreenCapture`（Windows）</li><li>`StopSecondaryScreenCapture`（Windows，iOS）</li> | `StopScreenCapture`[2/2]  |

**2. Video rendering**

As of v4.2.0, Agora Unity SDK does not support using `VideoSurface` and `VideoSurfaceYUV` at the same time for video rendering. After one `IRtcEngine` is created, if the first view is rendered through `VideoSurfaceYUV`, all views need to be rendered using `VideoSurfaceYUV` throughout the lifecycle of the `IRtcEngine`.

**3. Video data acquisition**

The `OnCaptureVideoFrame` and `OnPreEncodeVideoFrame` callbacks are added with a new parameter called `sourceType`, which is used to indicate the specific video source type.

**4. Channel media options**

- `PublishCustomAudioTrackEnableAec` in `ChannelMediaOptions` is deleted. Use `PublishCustomAudioTrack` instead.
- `PublishTrancodedVideoTrack` in `ChannelMediaOptions` is renamed to `PublishTranscodedVideoTrack`.
- `PublishCustomAudioSourceId` in `ChannelMediaOptions` is renamed to `PublishCustomAudioTrackId`.


**5. Local video mixing (Windows)**

- The `VideoInputStreams` in `LocalTranscoderConfiguration` is changed to `VideoInputStreams.`
- The `MEDIA_SOURCE_TYPE` in `TranscodingVideoStream` is changed to `VIDEO_SOURCE_TYPE.`

**6. Virtual sound card (macOS)**

As of v4.2.0, Agora supports third-party virtual sound cards. You can use a third-party virtual sound card as the audio input or output device for the SDK. You can use the `stateChanged` callback to see whether the current input or output device selected by the SDK is a virtual sound card.

<div class="alert info">If you set AgoraALD or Soundflower as the default input or output device when joining a channel, you will not hear audio.</div>

**7. Default video encoding resolution**

As of this release, the SDK optimizes the video encoder algorithm and upgrades the default video encoding resolution from 640 × 360 to 960 × 540 to accommodate improvements in device performance and network bandwidth, providing users with a full-link HD experience in various audio and video interaction scenarios.

You can call the `SetVideoEncoderConfiguration` method to set the expected video encoding resolution in the video encoding parameters configuration.

<div class="alert info">In scenarios such as 1-on-1 video calls and video group chats, the increase in the default resolution affects the aggregate resolution and thus the billing rate. For example, before this release, in a 1-on-1 video call scenario, the default aggregate resolution of subscribed video was 460,800 (640 × 360 × 2) and was billed as HD type; as of this release, the default aggregate resolution in the same scenario is 1,036,800 (960 × 540 × 2) and is billed as Full HD type.</div>

**8. Miscellaneous**

- `OnApiCallExecuted` is deleted. Agora recommends getting the results of the API implementation through relevant channels and media callbacks.

  The `IAudioFrameObserver` class is renamed to `IAudioPcmFrameSink`,thus the prototype of the following methods are updated accordingly:

  - `OnFrame`
  - `RegisterAudioFrameObserver` [1/2] and `RegisterAudioFrameObserver`[2/2] in `IMediaPlayer`

- `EnableDualStreamMode`[1/2] and `EnableDualStreamMode`[2/2] are depredated. Use `SetDualStreamMode`[1/2] and `SetDualStreamMode`[2/2] instead.

- `StartChannelMediaRelay`, `UpdateChannelMediaRelay`, `StartChannelMediaRelayEx` and `UpdateChannelMediaRelayEx` are deprecated. Use `StartOrUpdateChannelMediaRelay`And `StartOrUpdateChannelMediaRelayEx` instead.

#### New features

**1. AI noise reduction**

This release introduces the AI noise reduction function. Once enabled, the SDK automatically detects and reduces background noises. Whether in bustling public venues or real-time competitive arenas that demand lightning-fast responsiveness, this function guarantees optimal audio clarity, providing users with an elevated audio experience. You can enable this function through the newly-introduced `SetAINSMode` method and set the noise reduction mode as balance, aggressive or low latency according to your scenarios.

**2. Enhanced Virtual Background**

To increase the fun of real-time video calls and protect user privacy, this version has enhanced the virtual background feature. You can now set custom backgrounds of various types by calling the `EnableVirtualBackground` method, including:

- Process the background as alpha information without replacement, only separating the portrait and the background. This can be combined with the local video mixing feature to achieve a portrait-in-picture effect.
- Replace the background with various formats of local videos.

**3. Video scenario settings**

This release introduces `SetVideoScenario` for setting the video application scene. The SDK will automatically enable the best practice strategy based on different scenes, adjusting key performance indicators to optimize video quality and improve user experience. Whether it is a formal business meeting or a casual online gathering, this feature ensures that the video quality meets the requirements.

Currently, this feature provides targeted optimizations for real-time video conferencing scenarios, including:

- Automatically activate multiple anti-weak network technologies to enhance the capability and performance of low-quality video streams in meeting scenarios where high bitrates are required, ensuring smoothness when multiple streams are subscribed by the receiving end.
- Monitor the number of subscribers for the high-quality and low-quality video streams in real time, dynamically adjusting the configuration of the high-quality stream and dynamically enabling or disabling the low-quality stream, to save uplink bandwidth and consumption.

**4. Local video mixing**

On Windows, this release adds the `OnLocalVideoTranscoderError` callback. When there is an error in starting or updating the local video mixing, the SDK triggers this callback to report the reason for the failure.

On Android, iOS, and macOS, this release adds the local video mixing feature. You can use the `StartLocalVideoTranscoder` method to mix and render multiple video streams locally, such as camera-captured video, screen sharing streams, video files, images, etc. This allows you to achieve custom layouts and effects, making it easy to create personalized video display effects to meet various scenario requirements, such as remote meetings, live streaming, online education, while also supporting features like portrait-in-picture effect.

Additionally, the SDK provides the `UpdateLocalTranscoderConfiguration` method and the `OnLocalVideoTranscoderError` callback. After enabling local video mixing, you can use the `UpdateLocalTranscoderConfiguration` method to update the video mixing configuration. Where an error occurs in starting the local video mixing or updating the configuration, you can get the reason for the failure through the `OnLocalVideoTranscoderError` callback.

<div class="alert info">Local video mixing requires more CPU resources. Therefore, Agora recommends enabling this function on devices with higher performance.</div>


**5. Cross-device synchronization**

In real-time collaborative singing scenarios, network issues can cause inconsistencies in the downlinks of different client devices. To address this, this release introduces `GetNtpWallTimeInMs`For obtaining the current Network Time Protocol (NTP) time. By using this method to synchronize lyrics and music across multiple client devices, users can achieve synchronized singing and lyricsprogression, resulting in a better collaborative experience.

**6. Instant frame rendering**

This release adds the `EnableInstantMediaRendering` method to enable instant rendering mode for audio and video frames, which can speed up the first video or audio frame rendering after the user joins the channel.

**7. Video rendering tracing**

This release adds the `StartMediaRenderingTracing` and `StartMediaRenderingTracingEx` methods. The SDK starts tracing the rendering status of the video frames in the channel from the moment this method is called and reports information about the event through the `OnVideoRenderingTracingResult` callback.

Agora recommends that you use this method in conjunction with the UI settings (such as buttons and sliders) in your app. For example, call this method at the moment when the user clicks the "Join Channel" button, and then get the indicators in the video frame rendering process through the `OnVideoRenderingTracingResult` callback. This enables developers to facilitate developers to optimize the indicators to improve the user experience.


#### Improvements

**1. Voice changer**

This release introduces the `SetLocalVoiceFormant` method that allows you to adjust the formant ratio to change the timbre of the voice. This method can be used together with the `SetLocalVoicePitch` method to adjust the pitch and timbre of voice at the same time, enabling a wider range of voice transformation effects.


**2. Enhanced screen share (Android, iOS)**

This release adds the `QueryScreenCaptureCapability` method, which is used to query the screen capture capabilities of the current device. To ensure optimal screen sharing performance, particularly in enabling high frame rates like 60 fps, Agora recommends you to query the device's maximum supported frame rate using this method beforehand.

This release also adds the `SetScreenCaptureScenario` method, which is used to set the scenario type for screen sharing. The SDK automatically adjusts the smoothness and clarity of the shared screen based on the scenario type you set.


 **3. Improved compatibility with audio file types (Android)**

As of v4.2.0, you can use the following methods to open files with a URI starting with `Content://` : `StartAudioMixing` [2/2], `PlayEffect` [3/3], `Open`, and `OpenWithMediaSource`.


 **4. Enhanced rendering compatibility (Windows)**

This release enhances the rendering compatibility of the SDK. Issues like black screens caused by rendering failures on certain devices are fixed.

**5. Audio and video synchronization**

For custom video and audio capture scenarios, this release introduces `GetCurrentMonotonicTimeInMs` for obtaining the current Monotonic Time. By passing this value into the timestamps of audio and video frames, developers can accurately control the timing of their audio and video streams, ensuring proper synchronization.


**6. Multi-camera capture and multi-screen capture**

This release introduces `StartScreenCapture` [2/2] (PC only) and `StartCameraCapture`. By calling these methods multiple times and specifying the `sourceType` parameter, developers can start capturing video streams from multiple cameras and screens for local video mixing or multi-channel publishing. This is particularly useful for scenarios such as remote medical care and online education, where multiple cameras and displays need to be connected.

**7. Channel media relay**

This release introduces `StartOrUpdateChannelMediaRelay` and `StartOrUpdateChannelMediaRelayEx`, allowing for a simpler and smoother way to start and update media relay across channels. With these methods, developers can easily start the media relay across channels and update the target channels for media relay with a single method. Additionally, the internal interaction frequency has been optimized, effectively reducing latency in function calls.

**8. Custom audio tracks**

To better meet the needs of custom audio capture scenarios, this release adds `CreateCustomAudioTrack` and `DestroyCustomAudioTrack` for creating and destroying custom audio tracks. Two types of audio tracks are also provided for users to choose from, further improving the flexibility of capturing external audio source:

- Mixable audio track: Supports mixing multiple external audio sources and publishing them to the same channel, suitable for multi-channel audio capture scenarios.
- Direct audio track: Only supports publishing one external audio source to a single channel, suitable for low-latency audio capture scenarios.

**9. Super resolution (Android, iOS)**

This release improves the performance of super resolution. To optimize the usability of super resolution, this release removes `EnableRemoteSuperResolution`; super resolution no longer needs to be enabled manually. The SDK now automatically optimizes the resolution of the remote video based on the performance of the user's device.

#### Issues fixed

This release fixed the following issues:

**Windows**

- When using Agora Media Player to play RTSP video streams, the video images sometimes appeared pixelated.
- Adding an alpha channel to an image in PNG or GIF format failed when the local client mixed video streams.
- After joining the channel, remote users saw a watermark even though the watermark was deleted.
- If a watermark was added after starting screen sharing, the watermark did not display the screen.
- When joining a channel and accessing an external camera, calling `SetDevice` to specify the video capture device as the external camera did not take effect.
- When trying to outline the shared window and put it on top, the shared window did not stay on top of other windows.

**Android**

- Occasional crashes occur on Android devices when users joining or leaving a channel.
- Occational failure when enabling in-ear monitoring.
- Occational echo.
- Crashes occurred after users set the video resolution as 3840 × 2160 and started CDN streaming on Xiaomi Redmi 9A devices.
- In real-time chorus scenarios, remote users heard noises and echoes when an OPPO R11 device joined the channel in loudspeaker mode.
- When the playback of the local music finished, the `OnAudioMixingFinished` callback was not properly triggered.
- When using a video frame observer, the first video frame was occasionally missed on the receiver's end.
- When sharing screens in scenarios involving multiple channels, remote users occasionally saw black screens.
- Switching to the rear camera with the virtual background enabled occasionally caused the background to be inverted.
- Abnormal client status caused by an exception in the `OnRemoteAudioStateChanged` callback.

**iOS**

- Occasional loss of the `OnFirstRemoteVideoFrame` callback during channel media relay.
- The receiver actively subscribed to the high-quality stream but unexpectedly received a low-quality stream.
- Abnormal client status cased by an exception in the `OnRemoteAudioStateChanged` callback.

**macOS**

- The receiver was receiving the low-quality stream originally, and automatically switched to high-quality stream after a few seconds.
- Occasional screen jittering during screen sharing.
- The receiver was receiving the low-quality stream originally, and automatically switched to high-quality stream after a few seconds.
- Occasional screen jittering during screen sharing.
- If the rendering view of the player was set as a UIViewController's view, the video was zoomed from the bottom-left corner to the middle of the screen when entering full-screen mode.
- When joining a channel and accessing an external camera, calling `SetDevice` to specify the video capture device as the external camera did not take effect.

**All platforms**

- When the host frequently switching the user role between broadcaster and audience in a short period of time, the audience members cannot hear the audio of the host.
- Playing audio files with a sample rate of 48 kHz failed.
- When there were multiple video streams in a channel, calling some video enhancement APIs occasionally failed.

#### API changes

**Added**

- `StartCameraCapture`
- `StopCameraCapture`
- `StartScreenCapture`[2/2]  (Windows,macOS)
- `StopScreenCapture`[2/2]  (Windows,macOS)
- `StartOrUpdateChannelMediaRelay`
- `StartOrUpdateChannelMediaRelayEx`
- `GetNtpWallTimeInMs`
- `SetVideoScenario`
- `GetCurrentMonotonicTimeInMs`
- `OnLocalVideoTranscoderError`
- `startLocalVideoTranscoder`（macOS, iOS, Android）
- `updateLocalTranscoderConfiguration`（macOS, iOS, Android）
- `QueryScreenCaptureCapability`  (iOS, Android)
- `SetScreenCaptureScenario`  (iOS, Android)
- `CreateAudioCustomTrack`
- `DestroyAudioCustomTrack`
- `AudioTrackConfig`
- `AUDIO_TRACK_TYPE`
- `VIDEO_APPLICATION_SCENARIO_TYPE`
- `SCREEN_CAPTURE_FRAMERATE_CAPABILITY`
- The `domainLimit` and `autoRegisterAgoraExtensions` members in `RtcEngineContext`
- The `sourceType` parameter in `OnCaptureVideoFrame` and `OnPreEncodeVideoFrame` callbacks
- The `BACKGROUND_NONE` and `BACKGROUND_VIDEO` enumerators in `BACKGROUND_SOURCE_TYPE`
- `EnableInstantMediaRendering`
- `StartMediaRenderingTracing`
- `StartMediaRenderingTracingEx`
- `OnVideoRenderingTracingResult`
- `MEDIA_TRACE_EVENT`
- `VideoRenderingTracingInfo`

**Deprecated**

- `EnableDualStreamMode`[1/2]
- `EnableDualStreamMode`[2/2]
- `StartChannelMediaRelay`
- `StartChannelMediaRelayEx`
- `UpdateChannelMediaRelay`
- `UpdateChannelMediaRelayEx`
- `OnChannelMediaRelayEvent`
- `CHANNEL_MEDIA_RELAY_EVENT`

**Deleted**

- `StartPrimaryScreenCapture`  (Windows)
- `StartSecondaryScreenCapture`  (Windows)
- `StopPrimaryScreenCapture ` (Windows)
- `StopSecondaryScreenCapture ` (Windows)
- `StartPrimaryCameraCapture`  (Windows)
- `StartSecondaryCameraCapture` (Windows/iOS)
- `StopPrimaryCameraCapture`  (Windows)
- `StopSecondaryCameraCapture ` (Windows/iOS)
- `OnApiCallExecuted`
- `PublishCustomAudioTrackEnableAec ` in` ChannelMediaOptions`
- `EnableRemoteSuperResolution`
- `superResolutionType` in `RemoteVideoStats`