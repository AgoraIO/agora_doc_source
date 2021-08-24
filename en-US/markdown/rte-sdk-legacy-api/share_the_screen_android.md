# Share the Screen

Screen sharing enables a host of an interactive live streaming broadcast or a user in a video call to display what is on their screen to other users in the channel. This technology has many obvious advantages for communicating information, particularly in the following scenarios:

- During video conferencing, the speaker can share a local image, web page, or full presentation with other participants.
- For online instruction, the teacher can share slides or notes with students.

## Understand the tech

To share the screen in your project, implement the following steps in your app:

1. Get the screen data: Listen for `onActivityResult` (Android native callback) and get the value of the `data` parameter.
2. Start the screen sharing: Call `startScreenCapture` and pass in the screen data to share the entire screen through [`MediaProjection`](https://developer.android.google.cn/reference/android/media/projection/MediaProjection) (Android native class).
3. Join a channel and publish video streams:
 - If you only need to send the video stream from the screen sharing, call `joinChannel` with the `options` parameter and set `publishCameraTrack = false` and `publishScreenTrack = true`.
 - If you need to send video streams from both the screen sharing and the local camera, call `joinChannel` with the `options` parameter and use the default setting (`publishCameraTrack = true` and `publishScreenTrack = false`), and then call `joinChannelEx` to join the same channel and set `publishCameraTrack = false` and `publishScreenTrack = true`.
4. Stop the screen sharing: Call `stopScreenCapture`.

<div class="alert note">If the user shares the screen on Android 10 or later, to avoid the Android system from triggering <a href="https://developer.android.google.cn/reference/java/lang/SecurityException?hl=en"><code>SecurityException</code></a > (Android native callback), you need to call <a href="https://developer.android.google.cn/guide/components/foreground-services?hl=en#start"><code>startForeground</code></a > (Android native method) before calling <code>MediaProjection</code> (Android native class) to notify the user that the current device starts screen sharing.</div>

## Prerequisites

Before proceeding, ensure that you have a project that has implemented the basic real-time engagement functionality.

## Implementation

To send the video stream from the screen sharing, see the following sample code:

```java
@Override
// Listen for onActivityResult.
public void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    if (requestCode == PROJECTION_REQ_CODE && resultCode == RESULT_OK) {
        DisplayMetrics metrics = new DisplayMetrics();
        getActivity().getWindowManager().getDefaultDisplay().getMetrics(metrics);
        ScreenCaptureParameters parameters = new ScreenCaptureParameters();
        parameters.setFrameRate(DEFAULT_SHARE_FRAME_RATE);
        // Start the screen sharing.
        engine.startScreenCapture(data, parameters);
    }
}

// Join a channel and publish the video stream from the screen sharing.
options.publishCameraTrack = false;
options.publishScreenTrack = true;
engine.joinChannel(accessToken, channelId, 0, options);

// Stop the screen sharing.
engine.stopScreenCapture();
```

To send video streams from both the screen sharing and the local camera, see the following sample code:

```java
@Override
// Listen for onActivityResult.
public void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    if (requestCode == PROJECTION_REQ_CODE && resultCode == RESULT_OK) {
        DisplayMetrics metrics = new DisplayMetrics();
        getActivity().getWindowManager().getDefaultDisplay().getMetrics(metrics);
        ScreenCaptureParameters parameters = new ScreenCaptureParameters();
        parameters.setFrameRate(DEFAULT_SHARE_FRAME_RATE);
        // Start the screen sharing.
        engine.startScreenCapture(data, parameters);
    }
}

// Join a channel and publish the video stream from the screen sharing.
options.publishCameraTrack = true;
options.publishScreenTrack = false;
engine.joinChannel(accessToken, channelId, 0, options);

// Join the same channel and publish the video stream from the local camera.
ChannelMediaOptions mediaOptions = new ChannelMediaOptions();
mediaOptions.publishCameraTrack = false;
mediaOptions.publishScreenTrack = true;
String channelId = et_channel.getText().toString();
engine.joinChannelEx(null, channelId, 0, mediaOptions, iRtcEngineEventHandler, rtcConnection2);

// Stop the screen sharing.
engine.stopScreenCapture();
```

## Reference

### Sample project

Agora provides an open-source sample project that implements [sharing the screen](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/SwitchCameraScreenShare.java) on GitHub. You can try the sample project and view the source code.

### API reference

- [startScreenCapture](https://docs-preview.agoralab.co/cn/trinity/API%20Reference/java_high_level/classio_1_1agora_1_1rtc2_1_1_rtc_engine.html#a16a83b985493c445408da46ab7f01258)
- [stopScreenCapture](https://docs-preview.agoralab.co/cn/trinity/API%20Reference/java_high_level/classio_1_1agora_1_1rtc2_1_1_rtc_engine.html#aaa8a6ef8909cebd023c5c229d35fb472)