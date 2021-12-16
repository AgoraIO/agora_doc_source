---
title: 发布和订阅音视频流
platform: Android
updatedAt: 2018-12-12 15:09:30
---
# 发布和订阅音视频流
## 打开视频模式
调用 `enableVideo` 方法打开视频模式。在 Agora SDK 中，音频功能是默认打开的，因此在加入频道前，或加入频道后，你都可以调用该方法开启视频。

-   如果在加入频道前打开，则进入频道后直接加入视频通话或直播。
-   如果在通话或直播过程中打开，则由纯音频切换为视频通话或直播。


```
mRtcEngine.enableVideo();
```

## 设置视频编码属性
打开视频模式后，调用 `setVideoEncoderConfiguration` 方法设置视频的编码属性。

在该方法中，指定你想要的视频编码的分辨率、帧率、码率以及视频编码的方向模式。详细的视频编码参数定义，参考 `setVideoEncoderConfiguration` 中的描述。

> -   该方法设置的参数为理想情况下的最大值。当视频引擎因网络等原因无法达到设置的分辨率、帧率或码率值时，会取最接近设置值的最大值。
> -   如果设备的摄像头无法支持定义的视频属性，SDK 会为摄像头自动选择一个合理的分辨率。该行为对视频编码没有影响，编码时 SDK 仍沿用该方法中定义的分辨率。


```
VideoEncoderConfiguration.ORIENTATION_MODE
orientationMode =
VideoEncoderConfiguration.ORIENTATION_MODE.ORIENTATION_MODE_FIXED_PORTRAIT;

    VideoEncoderConfiguration.VideoDimensions dimensions = new VideoEncoderConfiguration.VideoDimensions(360, 640);

    VideoEncoderConfiguration videoEncoderConfiguration = new VideoEncoderConfiguration(dimensions, frameRate, bitrate, orientationMode);

mRtcEngine.setVideoEncoderConfiguration(videoEncoderConfiguration);
```

## 设置本地视频视图
本地视频视图，是指用户在本地设备上看到的本地视频流的视图。

在加入频道前，调用 `setupLocalVideo` 方法使应用程序绑定本地视频流的显示视窗，并设置本地看到的本地视频视图。`setupLocalVideo` 为视频流创建 SurfaceView 对象，并初始化:

-   将 setZOrderMediaOverlay 设置为 true，用以覆盖父视图;
-   将 View 添加到 local_video_view_container 布局中;

调用 `setupLocalVideo` 将新的 VideoCanvas 对象传递给引擎，该引擎绑定本地视频流的视频窗口\(视图\) 并配置视频的显示设置;


```
 private void setupLocalVideo() {
    FrameLayout container = (FrameLayout) findViewById(R.id.local_video_view_container);
    SurfaceView surfaceView = RtcEngine.CreateRendererView(getBaseContext());
    surfaceView.setZOrderMediaOverlay(true);
    container.addView(surfaceView);
    mRtcEngine.setupLocalVideo(new VideoCanvas(surfaceView, VideoCanvas.RENDER_MODE_ADAPTIVE, 0));
}
```

## 设置远端视频视图
远端视频视图，是指用户在本地设备上看到的远端视频流的视图。

调用 `setupRemoteVideo` 方法设置本地看到的远端用户的视频视图。该方法：

-   在布局里面创建并添加 View (视图)对象;
-   创建 VideoCanvas 并与视图进行绑定;
-   将 View 添加到 local_video_view_container 布局中;
-   调用 `setupLocalVideo` 将新的 VideoCanvas 对象传递给引擎，该引擎绑定本地视频流的视频窗口 (视图) 并配置视频的显示设置;
-   使用频道名对 View 进行标记;

用户需要在该方法中指定想要看到的远端视图的用户 UID。 如果不知道想要指定的远端用户 UID，也可以在收到其他用户加入频道的回调事件 `onUserJoined` 中获取该 UID。

```
private void setupRemoteVideo(int uid) {
   FrameLayout container = (FrameLayout) findViewById(R.id.remote_video_view_container);

   if (container.getChildCount() >= 1) {
       return;
   }

   SurfaceView surfaceView = RtcEngine.CreateRendererView(getBaseContext());
   container.addView(surfaceView);
   mRtcEngine.setupRemoteVideo(new VideoCanvas(surfaceView, VideoCanvas.RENDER_MODE_ADAPTIVE, uid));

   surfaceView.setTag(uid);
   View tipMsg = findViewById(R.id.quick_tips_when_use_agora_sdk);
   tipMsg.setVisibility(View.GONE);
  }
```
