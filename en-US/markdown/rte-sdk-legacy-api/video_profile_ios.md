This article shows how to call the API provided by Agora to set video profiles.

## Understand the tech

User experience in real-time engagement scenarios involving video is closely related to the quality of the video, such as its sharpness and smoothness.

Video profiles are preset configurations of resolution, frame rate, and bitrate. Developers can implement video profiles to control how video streams will appear to users under ideal network conditions.

### Resolution, frame rate and bitrate

You can set the video resolution, frame rate, and bitrate with the following parameters:

- [`dimensions`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html#//api/name/dimensions): The video encoding resolution (px). The default value is 640 × 360. Generally speaking, the higher the resolution, the sharper the video. The value of this parameter does not indicate the orientation mode of the output video. For how to set the orientation mode of the output video, see [Orientation mode](#orientationmode).

- [`frameRate`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html#//api/name/frameRate): The video encoding frame rate (fps), that is, the number of frames that the SDK encodes per second. The default value is 15. Generally speaking, the higher the frame rate, the smoother the video. For scenarios with high requirements on video smoothness, You can set this parameter as 20 or 25. Agora recommends not setting `frameRate` as any value beyond 30.

- [`bitrate`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html#//api/name/bitrate): The video encoding bitrate (Kbps). The default value is `AgoraVideoBitrateStandard`, that is, the standard bitrate mode. Under the standard bitrate mode, the SDK assigns a bitrate value according to the channel profile, video dimensions, and frame rate that you set.

<div class="alert note">
	<ul>
		<li>To achieve high video quality, you need to strike a balance between video dimensions, bitrate, and frame rate. Higher video dimensions require higher bitrate. With a fixed bitrate, excessive frame rate reduces video dimensions.</li>
		<li>The parameters specified are the maximum values under ideal network conditions. If the SDK cannot render the video using the specified parameters due to poor network conditions, lower quality settings are used.</li>
	</ul>
</div>

The Agora SDK provides selections of video dimensions, frame rate, and bitrate for you to choose from. You can also customize the values according to the table below.

#### Video profile table

<div class="alert note">Whether 720 × 960 or higher can be supported depends on the terminal device.</div>

| Resolution (width × height) | Frame rate (fps) | Live bitrate (Kbps) |
| :-------------------------- | :--------------- | :---------------------------------------- |
| 160 × 120                   | 15               | 130                                       |
| 120 × 120                   | 15               | 100                                       |
| 320 × 180                   | 15               | 280                                       |
| 180 × 180                   | 15               | 200                                       |
| 240 × 180                   | 15               | 240                                       |
| 320 × 240                   | 15               | 400                                       |
| 240 × 240                   | 15               | 280                                       |
| 424 × 240                   | 15               | 440                                       |
| 640 × 360                   | 15               | 800                                       |
| 360 × 360                   | 15               | 520                                       |
| 640 × 360                   | 30               | 1200                                      |
| 360 × 360                   | 30               | 800                                       |
| 480 × 360                   | 15               | 640                                       |
| 480 × 360                   | 30               | 980                                       |
| 640 × 480                   | 15               | 1000                                      |
| 480 × 480                   | 15               | 800                                       |
| 640 × 480                   | 30               | 1500                                      |
| 480 × 480                   | 30               | 1200                                      |
| 848 × 480                   | 15               | 1220                                      |
| 848 × 480                   | 30               | 1860                                      |
| 640 × 480                   | 10               | 800                                       |
| 1280 × 720                  | 15               | 2260                                      |
| 1280 × 720                  | 30               | 3420                                      |
| 960 × 720                   | 15               | 1820                                      |
| 960 × 720                   | 30               | 2760                                      |


#### Recommended video profiles

The recommended video profiles vary by scenario. For example, in a one-to-one online class, the video windows of the teacher and student are both large, which calls for higher resolutions, frame rates, and bitrates. In a one-to-four online class, however, the video windows of the teacher and students are smaller, so lower resolutions, frame rates, and bitrates are used to accommodate bandwidth limitations.

The following profiles for different scenarios are recommended:

- One-to-one video call:
  - Resolution: 320 × 240; frame rate: 15 fps; bitrate: 200 Kbps.
  - Resolution: 640 × 360; frame rate: 15 fps; bitrate: 400 Kbps.
- One-to-many video call:
  - Resolution: 160 × 120; frame rate: 15 fps; bitrate: 65 Kbps.
  - Resolution: 320 × 180; frame rate: 15 fps; bitrate: 140 Kbps.
  - Resolution: 320 × 240; frame rate: 15 fps; bitrate: 200 Kbps.

<a name="orientationmode"></a>

### Orientation mode

Video rotation involves the video capturer and the video player, where:

- The video capturer captures the video and outputs the relevant video information, namely, the relative position of the video and the status bar.
- The video player renders the received video and rotates the video according to the rotation information.

To avoid issues such as video scaling and cropping caused by video rotation, the Agora SDK provides the [`orientationMode`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html#//api/name/orientationMode) parameter in the `setVideoEncoderConfiguration` method. You can use this parameter to set the video orientation mode according to your scenario to get the video you want.

The orientationMode parameter provides three modes to suit different user needs: `Adaptive`, `FixedLandscape`, and `FixedPortrait`.

<div class="alert note">Regardless of the mode, the relative position of the video and the status bar on both the video capturer and the player remain the same.</div>

#### Adaptive

In the Adaptive mode, the output video always follows the orientation of the captured video, and the receiver takes the rotation information passed on from the video encoder. This mode applies to scenarios where video orientation can be adjusted on the receiver and is usually used between Agora SDKs.

The following figures show the video orientations at the video capturer and player when a rear camera is used as the video capturer. Note that the video orientation differs depending on whether or not the UI is locked.

<div class="alert note">On macOS, the status bar of the app remains horizontal regardless of the orientation of the screen. UI locked applies to iOS only.</div>

**UI locked (or UI unlocked with the app disabling the screen auto-rotation)**

The relative position of the status bar remains the same as the screen and not according to the phone tilt (for example, in WeChat). Therefore, the relative positions of the video and the screen remain the same for the video capturer and the player.

- For a landscape capturer:

	<img alt="../_images/rotation_adaptive_uilock_landscape.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_adaptive_uilock_landscape.jpg" />

- For a portrait capturer:

	<img alt="../_images/rotation_adaptive_uilock_portrait.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_adaptive_uilock_portrait.jpg" />

**UI unlocked with the app enabling the screen auto-rotation**

The status bar of the app remains horizontal, regardless of the orientation of the screen (for example, in Facetime). Therefore, the relative positions of the video and the phone tilt remain the same for the video capturer and the player.

- For a landscape capturer:

	<img alt="../_images/rotation_adaptive_uiunlock_landscape.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_adaptive_uiunlock_landscape.jpg" />

- For a portrait capturer:

   <img alt="../_images/rotation_adaptive_uiunlock_portrait.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_adaptive_uiunlock_portrait.jpg" />


#### FixedLandscape

In the `FixedLandscape` mode, the video capturer sends the video in the landscape orientation relative to the status bar. If the captured video is in portrait mode, the video encoder crops it to fit the output. This mode applies to situations where the receiving end cannot process the rotation information.

The following figures show the video orientations at the video capturer and the player when a rear camera is used as the video capturer.

- The captured video in the landscape mode (video cropping is not needed):

	<img alt="../_images/rotation_fixed_landscape.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_fixed_landscape.jpg" />

- The captured video in the portrait mode (video cropping is needed):

	<img alt="../_images/rotation_fixed_landscape_cut.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_fixed_landscape_cut.jpg" />


#### FixedPortrait

In the `FixedPortrait` mode, the video capturer sends out the video in the portrait orientation relative to the status bar. If the captured video is in landscape mode, the video encoder crops it to fit the output. This mode applies to situations where the receiving end cannot process the rotation information.

The following figures show the video orientations at the video capturer and the player when a rear camera is used as the video capturer.

- The captured video in the portrait mode (video cropping is not needed):

  <img alt="../_images/rotation_fixed_portrait.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_fixed_portrait.jpg" />

- The captured video in the landscape mode (video cropping is needed):

	<img alt="../_images/rotation_fixed_portrait_cut.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_fixed_portrait_cut.jpg" />


### Degradation preference

To optimize user experience in weak network conditions, Agora provides the [`degradationPreference`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html#//api/name/degradationPreference) parameter to set how you wish to degrade the video under limited network bandwidth.

### Mirror mode

By default, the SDK does not mirror the video during encoding. You can use the [`mirrorMode`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html#//api/name/mirrorMode) parameter to decide whether to mirror the video that remote users see.

### Minimum frame rate and bitrate

If your scenario has special requirements on video sharpness or smoothness, you can also use the following parameters to set the minimum frame rate or bitrate:

- [`minFrameRate`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html#//api/name/minFrameRate): The minimum video frame rate (fps). You can use `minFrameRate` and `AgoraDegradationMaintainQuality` to balance the video sharpness and video smoothness under unreliable connections. When minFrameRate is relatively low, the frame rate degrades significantly, fo the poor network conditions have limited impact on video sharpness. When `minFrameRate` is relatively high, the frame rate degrades within a limited range, so the poor network conditions can have high impact on video sharpness.
- [`minBitrate`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html#//api/name/minBitrate): The minimum video bitrate (Kbps). The Agora SDK automatically adjusts the encoding bitrate to adapt to the network conditions. Setting this parameter to a value greater than the default value forces the video encoder to output high-quality video images but may cause more packet loss and sacrifice video smoothness.

<div class="alert note">The default values of <code>minFrameRate</code> and <code>minBitrate</code> can meet the requirements of most real-time scenarios. Unless you have special requirements , Agora recommends not changing these default values.</div>



## Implementation

### Prerequisites

Before adjusting the audio volume, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_ios) or [Start Interactive Live Streaming](start_live_ios).

### Implement the workflow

The Agora SDK provides the [`setVideoEncoderConfiguration`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoEncoderConfiguration:) method to set the video profile. After you initialize the `AgoraRtcEngineKit` object, you can call `setVideoEncoderConfiguration` either before or after joining a channel.

If you do not intend to update the video profile after joining a channel, Agora recommends calling `setVideoEncoderConfiguration` before `enableVideo`, which reduces the time to render the first local video frame.


You can refer to the following code sample when setting the parameters of `setVideoEncoderConfiguration`:

```swift
// Swift
// Set the video encoding resolution, frame rate and orientation mode according to the settings of the user
let resolution = configs["resolution"] as? CGSize,
let fps = configs["fps"] as? Int,
let orientation = config["orientation"] as? AgoraVideoOutputOrientationMode else {return}

agoraKit.setVideoEncoderConfiguration(AgoraVideoEncoderConfiguration(size: resolution,
        frameRate: AgoraVideoFrameRate(rawValue: fps) ?? .fps15,
        bitrate: AgoraVideoBitrateStandard,
        orientationMode: orientation))
```

## Reference

### Sample project

Agora provides an open-source sample project on GitHub that implements setting the video profile. You can download the sample project to try it out or view the source code:

[JoinChannelVideo.swift](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/iOS/APIExample/Examples/Basic/JoinChannelVideo/JoinChannelVideo.swift)

### Considerations

- The parameters specified in `setVideoEncoderConfiguration` are the maximum values under ideal network conditions. The SDK adapts (most often downwards) these parameters according to the network conditions in real-time.
- Setting parameters in `setVideoEncoderConfiguration` affects your bill. In case network adaptation occurs, the unit price is calculated based on the actual video dimensions. For more information, see [Billing for Real-time Communication](billing_rtc).
