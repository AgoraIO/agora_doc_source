# Release notes (Android)

## v4.5.0

This version was released on November x, 2024.

### Compatibility changes

This version includes optimizations to some features, including changes to SDK behavior, API renaming and deletion. To ensure normal operation of the project, update the code in the app after upgrading to this release.

**Attention:**
As of v4.5.0, both RTC SDK and RTM SDK (v2.2.0 and above) include the libaosl.so library. If you manually integrate RTC SDK via CDN and also use RTM SDK, delete the lower version of the libaosl.so library to avoid conflicts. The libaosl.so library version in RTC SDK v4.5.0 is 1.2.13.

#### 1. Changes in strong video denoising implementation

This version adjusts the implementation of strong video denoising.

The `VIDEO_DENOISER_LEVEL_STRENGTH` enumeration is removed.

Instead, after enabling video denoising by calling `setVideoDenoiserOptions [1/2]`, you can call the `setBeautyEffectOptions [1/2]` method to enable the beauty skin smoothing feature. Using both together will achieve better video denoising effects. For strong denoising, it is recommended to set the skin smoothing parameters as detailed in `setVideoDenoiserOptions [1/2]`.

Additionally, due to this adjustment, to achieve the best low-light enhancement effect with a focus on image quality, you need to enable video denoising first and use specific settings as detailed in `setLowlightEnhanceOptions [1/2]`.

#### 2. Changes in video encoding preferences

To enhance the user’s video interaction experience, this version optimizes the default preferences for video encoding:

- In the `COMPRESSION_PREFERENCE` enumeration class, a new `PREFER_COMPRESSION_AUTO` (-1) enumeration is added, replacing the original `PREFER_QUALITY` (1) as the default value. In this mode, the SDK will automatically choose between `PREFER_LOW_LATENCY` or `PREFER_QUALITY` based on your video scene settings to achieve the best user experience.
- In the `DEGRADATION_PREFERENCE` enumeration class, a new `MAINTAIN_AUTO` (-1) enumeration is added, replacing the original `MAINTAIN_QUALITY` (1) as the default value. In this mode, the SDK will automatically choose between `MAINTAIN_FRAMERATE`, `MAINTAIN_BALANCED`, or `MAINTAIN_RESOLUTION` based on your video scene settings to achieve the optimal overall quality experience (QoE).

#### 3. 16 KB memory page size

Starting from Android 15, the system adds support for 16 KB memory page size, as detailed in [Support 16 KB page sizes](https://developer.android.com/guide/practices/page-sizes). To ensure the stability and performance of the app, starting from this version, the SDK supports 16 KB memory page size, ensuring seamless operation on devices with both 4 KB and 16 KB memory page sizes, enhancing compatibility and preventing crashes.

### New features

#### 1. Live show scenario

This version adds the `APPLICATION_SCENARIO_LIVESHOW(3)` (Live Show) enumeration to the `VideoScenario`. You can call `setVideoScenario` to set the video business scenario to show room. To meet the high requirements for first frame rendering time and image quality in this scenario, the SDK has optimized strategies to significantly improve the first frame rendering experience and image quality, while enhancing the image quality in weak network environments and on low-end devices.

#### 2. Maximum frame rate for video rendering

This version adds the `setLocalRenderTargetFps` and `setRemoteRenderTargetFps` methods, which support setting the maximum frame rate for video rendering locally and remotely. The actual frame rate for video rendering by the SDK will be as close to this value as possible.

In scenarios where the frame rate requirement for video rendering is not high (e.g., screen sharing, online education) or when the remote end uses mid-to-low-end devices, you can use this set of methods to limit the video rendering frame rate, thereby reducing CPU consumption and improving system performance.

#### 3. Watching live streaming through URLs

As of this version, audience members can directly open a specific URL to play the real-time media stream through openWithUrl, instead of joining a channel and subscribing to the streams of hosts, which greatly simplifies the API calls for the audience end to watch a live stream.

#### 4. Filter effects

This version introduces the `setFilterEffectOptions [1/2]` method. You can pass a cube map file (.cube) in the **config** parameter to achieve custom filter effects such as whitening, vivid, cool, black and white, etc. Additionally, the SDK provides a built-in `built_in_whiten_filter.cube` file for quickly achieving a whitening filter effect.

#### 5. Local audio mixing

This version introduces the local audio mixing feature. You can call the `startLocalAudioMixer` method to mix the audio streams from the local microphone, media player, sound card, and remote audio streams into a single audio stream, which can then be published to the channel. When you no longer need audio mixing, you can call the stopLocalAudioMixer method to stop local audio mixing. During the mixing process, you can call the `updateLocalAudioMixerConfiguration` method to update the configuration of the audio streams being mixed.

Example use cases for this feature include:
- By utilizing the local video mixing feature, the associated audio streams of the mixed video streams can be simultaneously captured and published.
- In live streaming scenarios, users can receive audio streams within the channel, mix multiple audio streams locally, and then forward the mixed audio stream to other channels.
- In educational scenarios, teachers can mix the audio from interactions with students locally and then forward the mixed audio stream to other channels.

#### 6. External MediaProjection

This version introduces the `setExternalMediaProjection` method, which allows you to set an external `MediaProjection` and replace the MediaProjection applied by the SDK.

If you have the capability to apply for `MediaProjection` on your own, you can use this feature to achieve more flexible screen capture.

#### 7. EGL context

This version introduces the `setExternalRemoteEglContext` method, which is used to set the EGL context for rendering remote video streams. When using Texture format video data for remote video self-rendering, you can use this method to replace the SDK's default remote EGL context, achieving unified EGL context management.

#### 8. Color space settings

This version adds `getColorSpace` and `setColorSpace` to `VideoFrame`. You can use `getColorSpace` to obtain the color space properties of the video frame and use `setColorSpace` to customize the settings. By default, the color space uses Full Range and BT.709 standard configuration. Developers can flexibly adjust according to their own capture or rendering needs, further enhancing the customization capabilities of video processing.


### Improvements

#### 1. Virtual background algorithm optimization

This version upgrades the virtual background algorithm, making the segmentation between the portrait and the background more accurate. There is no background exposure, the body contour of the portrait is complete, and the detail recognition of fingers is significantly improved. Additionally, the edges between the portrait and the background are more stable, reducing edge jumping and flickering in continuous video frames.

#### 2. Snapshot at specified video observation points

This version introduces the `takeSnapshot [2/2]` and `takeSnapshotEx [2/2]` methods. You can use the **config** parameter when calling these methods to take snapshots at specified video observation points, such as before encoding, after encoding, or before rendering, to achieve more flexible snapshot effects.

#### 3. Custom audio capture improvements

This version adds the `enableAudioProcessing` member parameter to `AudioTrackConfig`, which is used to control whether to enable 3A audio processing for custom audio capture tracks of the `AUDIO_TRACK_DIRECT` type. The default value of this parameter is false, meaning that audio processing is not enabled. Users can enable it as needed, enhancing the flexibility of custom audio processing.

#### 4. Other Improvements

- In scenarios where Alpha transparency effects are achieved by stitching video frames and Alpha data, the rendering performance on the receiving end has been improved, effectively reducing stuttering and latency.
- Optimizes the logic for calling queryDeviceScore to obtain device score levels, improving the accuracy of the score results.
- When calling `switchSrc` to switch between live streams or on-demand streams of different resolutions, smooth and seamless switching can be achieved. An automatic retry mechanism has been added in case of switching failures. The SDK will automatically retry 3 times after a failure. If it still fails, the onPlayerEvent callback will report the `PLAYER_EVENT_SWITCH_ERROR` event, indicating an error occurred during media resource switching.
- When calling `setPlaybackSpeed` to set the playback speed of an audio file, the minimum supported speed is 0.3x.

### Bug fixes

This version fixes the following issues:

- When the video source type of the sender is in JPEG format, the frame rate on the receiving end occasionally falls below expectations.
- Occasional noise and stuttering when playing music resources from the music content center.
- During audio and video interaction, after being interrupted by a system call, the user volume reported by the `onAudioVolumeIndication` callback was incorrect.
- When the receiving end subscribes to the video small stream by default and does not automatically subscribe to any video stream when joining the channel, calling `muteRemoteVideoStream(uid, false)` after joining the channel to resume receiving the video stream results in receiving the video large stream, which is not as expected.
- Calling `startAudioMixing [1/2]` and then immediately calling `pauseAudioMixing` to pause the music file playback does not take effect.
- Occasional crashes during audio and video interaction.
