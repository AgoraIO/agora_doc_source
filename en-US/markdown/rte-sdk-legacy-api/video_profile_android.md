This page shows how to call the API provided by Agora to set video profiles.

## Understand the tech

User experience in real-time engagement scenarios involving video is closely related to the quality of the video, such as its sharpness and smoothness.

Video profiles are preset configurations of resolution, frame rate, and bitrate. Developers can implement video profiles to control how video streams will appear to users under ideal network conditions.

The Agora SDK provides the [`setVideoEncoderConfiguration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af5f4de754e2c1f493096641c5c5c1d8f) method to set the video profile. After you initialize the `RtcEngine` object, you can call `setVideoEncoderConfiguration` either before or after joining a channel.

If you do not intend to update the video profile after joining a channel, Agora recommends calling `setVideoEncoderConfiguration` before `enableVideo`, which reduces the time to render the first local video frame.

### Resolution, frame rate and bitrate

You can set the video resolution, frame rate, and bitrate with the following parameters:

- `dimensions`: The video encoding resolution (px). The default value is 640 × 360. Generally speaking, the higher the resolution, the sharper the video. The value of this parameter does not indicate the orientation mode of the output video. For how to set the orientation mode of the output video, see [Orientation mode](#orientation).
- `frameRate`: The video encoding frame rate (fps), that is, the number of frames that the SDK encodes per second. The default value is 15. Generally speaking, the higher the frame rate, the smoother the video. For scenarios with high requirements on video smoothness, You can set this parameter as 20 or 25. Agora recommends not setting `frameRate` as any value beyond 30.
- `bitrate`: The video encoding bitrate (Kbps). The default value is `STANDARD_BITRATE`, that is, the standard bitrate mode. Under the standard bitrate mode, the SDK assigns a bitrate value according to the channel profile, video dimensions, and frame rate that you set.

 To achieve high video quality, you need to strike a balance between video dimensions, bitrate, and frame rate. Higher video dimensions require higher bitrate. With a fixed bitrate, excessive frame rate reduces video dimensions.

 The parameters specified are the maximum values under ideal network conditions. If the SDK cannot render the video using the specified parameters due to poor network conditions, lower quality settings are used.


### Recommended video settings

The recommended video settings vary by scenario. For example, in a one-to-one online class, the video windows of the teacher and student are both large, which calls for higher resolutions, frame rates, and bitrates. In a one-to-four online class, however, the video windows of the teacher and students are smaller, so lower resolutions, frame rates, and bitrates are used to accommodate bandwidth limitations.

The following settings for different scenarios are recommended:

- One-to-one video call:
  - Resolution: 320 × 240; frame rate: 15 fps; bitrate: 200 Kbps.
  - Resolution: 640 × 360; frame rate: 15 fps; bitrate: 400 Kbps.
- One-to-many video call:
  - Resolution: 160 × 120; frame rate: 15 fps; bitrate: 65 Kbps.
  - Resolution: 320 × 180; frame rate: 15 fps; bitrate: 140 Kbps.
  - Resolution: 320 × 240; frame rate: 15 fps; bitrate: 200 Kbps.

### <a name="orientation"></a>Orientation mode

Video rotation involves the video capturer and the video player, where:

- The video capturer captures the video and outputs the relevant video information. That is, the relative position of the video and the status bar.
- The video player renders the received video and rotates the video according to the rotation information.

To avoid issues such as video scaling and cropping caused by video rotation, the Agora SDK provides the `orientationMode` parameter in the `setVideoEncoderConfiguration` method. You can use this parameter to set the video orientation mode according to your scenario to get the video you want.

The `orientationMode` parameter provides three modes to suit different user needs: `ORIENTATION_MODE_ADAPTIVE`, `ORIENTATION_MODE_FIXED_LANDSCAPE`, and `ORIENTATION_MODE_FIXED_PORTRAIT`.

Regardless of the mode, the relative position of the video and the status bar on both the video capturer and the player remain the same.

#### ORIENTATION_MODE_ADAPTIVE

In the `ORIENTATION_MODE_ADAPTIVE` mode, the output video always follows the orientation of the captured video, and the receiver takes the rotation information passed on from the video encoder. This mode applies to scenarios where video orientation can be adjusted on the receiver and is usually used between Agora SDKs.

The following figures show the video orientations at the video capturer and player when a rear camera is used as the video capturer. Note that the video orientation differs depending on whether or not the UI is locked.

#### UI locked (or UI unlocked with the app disabling the screen auto-rotation)

The relative position of the status bar remains the same as the screen and not according to the phone tilt (for example, in WeChat). Therefore, the relative positions of the video and the screen remain the same for the video capturer and the player.

- For a landscape capturer:

  <img alt="../_images/rotation_adaptive_uilock_landscape.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_adaptive_uilock_landscape.jpg" />

- For a portrait capturer:

  <img alt="../_images/rotation_adaptive_uilock_portrait.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_adaptive_uilock_portrait.jpg" />

#### UI unlocked with the app enabling the screen auto-rotation

The status bar of the app remains horizontal, regardless of the orientation of the screen (for example, in Facetime). Therefore, the relative positions of the video and the phone tilt remain the same for the video capturer and the player.

- For a landscape capturer:

  <img alt="../_images/rotation_adaptive_uiunlock_landscape.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_adaptive_uiunlock_landscape.jpg" />

- For a portrait capturer:

  <img alt="../_images/rotation_adaptive_uiunlock_portrait.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_adaptive_uiunlock_portrait.jpg" />

#### ORIENTATION_MODE_FIXED_LANDSCAPE

In the `ORIENTATION_MODE_FIXED_LANDSCAPE` mode, the video capturer sends the video in the landscape orientation relative to the status bar. If the captured video is in portrait mode, the video encoder crops it to fit the output. This mode applies to situations where the receiving end cannot process the rotation information.

The following figures show the video orientations at the video capturer and the player when a rear camera is used as the video capturer.

- The captured video in the landscape mode (video cropping is not needed):

  <img alt="../_images/rotation_fixed_landscape.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_fixed_landscape.jpg" />

- The captured video in the portrait mode (video cropping is needed):

  <img alt="../_images/rotation_fixed_landscape_cut.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_fixed_landscape_cut.jpg" />

#### ORIENTATION_MODE_FIXED_PORTRAIT

In the `ORIENTATION_MODE_FIXED_PORTRAIT` mode, the video capturer sends out the video in the portrait orientation relative to the status bar. If the captured video is in landscape mode, the video encoder crops it to fit the output. This mode applies to situations where the receiving end cannot process the rotation information.

The following figures show the video orientations at the video capturer and the player when a rear camera is used as the video capturer.

- The captured video in the portrait mode (video cropping is not needed):

  <img alt="../_images/rotation_fixed_portrait.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_fixed_portrait.jpg" />

- The captured video in the landscape mode (video cropping is needed):

  <img alt="../_images/rotation_fixed_portrait_cut.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_fixed_portrait_cut.jpg" />

### Degradation preference

To optimize user experience in poor network conditions, Agora provides the `degradationPrefer` parameter to set how you wish to degrade the video under limited network bandwidth.

### Mirror mode

By default, the SDK does not mirror the video during encoding. You can use the `mirrorMode` parameter to decide whether to mirror the video that remote users see.

### Minimum frame rate and bitrate

If your scenario has special requirements for video sharpness or smoothness, you can use the following parameters to alter the minimum frame rate or bitrate:

- `minFrameRate`: The minimum video frame rate (fps). You can use `minFrameRate` and `MAINTAIN_QUALITY` to balance the video sharpness and video smoothness under unreliable connections. When `minFrameRate` is relatively low, the frame rate degrades significantly, so the poor network conditions have limited impact on video sharpness. When `minFrameRate` is relatively high, the frame rate degrades within a limited range, so the poor network conditions can have high impact on video sharpness.
- `minBitrate`: The minimum video bitrate (Kbps). The Agora SDK automatically adjusts the encoding bitrate to adapt to the network conditions. Setting this parameter to a value greater than the default value forces the video encoder to output high-quality video images but may cause more packet loss and sacrifice video smoothness.

<div class="alert note">
	The default values of <code>minFrameRate</code> and <code>minBitrate</code> can meet the requirements of most real-time scenarios. Unless you have special requirements, Agora recommends not changing these default values.</div>

## Prerequisites

Before adjusting the audio volume, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_android) or [Start Interactive Live Streaming](start_live_android).

## Implementation

To set the video profile in your project, refer to the following sample code.

```java
// Set the video encoding resolution, frame rate, bitrate and orientation mode according to the settings of the user
VideoEncoderConfiguration.VideoDimensions value = VD_640x360;
try {
    Field tmp = VideoEncoderConfiguration.class.getDeclaredField(dimension.getSelectedItem(toString());
    tmp.setAccessible(true);
    value = (VideoEncoderConfiguration.VideoDimensions) tmp.get(null);
} catch (NoSuchFieldException e) {
    Log.e("Field", "Can not find field " + dimension.getSelectedItem().toString());
} catch (IllegalAccessException e) {
    Log.e("Field", "Could not access field " + dimension.getSelectedItem().toString());


engine.setVideoEncoderConfiguration(new VideoEncoderConfiguration(
        value,
        VideoEncoderConfiguration.FRAME_RATE.valueOf(framerate.getSelectedItem().toString()),
        Integer.valueOf(et_bitrate.getText().toString()),
        VideoEncoderConfiguration.ORIENTATION_MODE.valueOf(orientation.getSelectedItem().toStri())
));
```

## Reference

This section includes in depth information about the methods you used in this page, and links to related pages.

### Sample project

Agora provides an open-source sample project on GitHub that implements [setting the video profile](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/SetVideoProfile.java). You can download the sample project to try it out or view the source code.

### Considerations

- The parameters specified in `setVideoEncoderConfiguration` are the maximum values under ideal network conditions. The SDK adapts (most often downwards) these parameters according to the network conditions in real-time.
- Setting parameters in `setVideoEncoderConfiguration` affects your bill. If network adaptation occurs, the unit price is calculated based on the actual video dimensions. For more information, see [Billing for Real-time Communication](./billing_rtc).

The Agora SDK provides selections of video dimensions, frame rate, and bitrate for you to choose from. You can also customize the values according to the table below.

### Video profile table

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

If the device cannot support 720p, the frame rate is lower than the one listed in the table.