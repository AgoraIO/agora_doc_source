~b2982480-d208-11ed-8efe-b91caddc8ecb~


## 技术原理

根据实际业务场景的不同，你可以选择以下任一方式调用 API 实现屏幕共享：

- 在加入频道前调用 `startScreenCapture`，然后调用 `joinChannel` [2/2] 加入频道并设置 `publishScreenCaptureVideo` 为 `true`，即可开始屏幕共享。
- 在加入频道后调用 `startScreenCapture`，然后调用 `updateChannelMediaOptions` 更新频道媒体选项并设置 `publishScreenCaptureVideo` 为 `true`，即可开始屏幕共享。


## 注意事项

- 在开启屏幕共享后，声网以屏幕共享视频流的分辨率作为计费标准，详见[计费说明](./billing_rtc_ng)。默认分辨率为 1280 × 720，你也可以根据你的业务需求进行调整。
- 受系统限制，采集屏幕仅适用于 Android API 级别为 21 及以上，即 Android 5 及以上，否则在调用 `startScreenCapture` 时，SDK 会报告错误码 `ERR_SCREEN_CAPTURE_PERMISSION_DENIED`(16) 和 `ERR_SCREEN_CAPTURE_SYSTEM_NOT_SUPPORTED`(2)。 
- 受系统限制，采集系统音频仅适用于 Android API 级别为 29 及以上，即 Android 10 及以上，否则在调用 `startScreenCapture` 时，SDK 会报告错误码 `ERR_SCREEN_CAPTURE_SYSTEM_AUDIO_NOT_SUPPORTED`(3)。
- 因 Android 性能限制，屏幕共享不支持 Android TV。
- 因 Android 系统限制，使用华为手机进行屏幕共享时，为避免崩溃，请不要在共享过程中调节屏幕共享流的视频编码分辨率。
- 因 Android 系统限制，部分小米手机不支持屏幕共享时采集系统音频。
- 为提高屏幕共享时采集系统音频的成功率，声网推荐你在加入频道前通过 `setAudioScenario` 方法设置音频场景为  `AUDIO_SCENARIO_GAME_STREAMING`。


## 前提条件

- 在 Android 平台上，请确保用户已授予 app 屏幕采集权限。
- 在实现屏幕共享前，请确保已在你的项目中实现基本的实时音视频功能。详见[实现视频通话](./start_call_android_ng?platform=Android)或[实现视频直播](./start_live_android_ng?platform=Android)。


## 实现屏幕共享

本节介绍如何使用 Android SDK 实现屏幕共享。



### 1. 集成屏幕共享插件

声网 SDK 的屏幕共享通过插件实现，你需要集成 `AgoraScreenShareExtension` 动态库。
你可以根据你的集成方式，选择手动导入 aar 文件集成屏幕共享插件，或者通过 Maven Central 自动集成。

#### 手动集成插件

1. 拷贝 SDK 中的 `AgoraScreenShareExtension.aar` 文件到 `/app/libs/` 目录下。

2. 在 `/app/build.gradle` 文件的 `dependencies` 节点中添加如下行，以支持导入 aar 格式的文件。

   ```java
   implementation fileTree(dir: "libs", include: ["*.jar","*.aar"])
   ```



#### 自动集成插件

通过 Maven Central 集成 SDK 时，你可以修改 `/Gradle Scripts/build.gradle(Module: <projectname>.app)` 文件中 `dependencies` 的 `implementation` 字段添加依赖。

```
dependencies {
// 请使用具体的 SDK 版本号替换下面代码中的 x.y.z，可通过发版说明获取最新版本号      
def agora_sdk_version = "x.y.z"
// 下述代码中包含 $，因此你必须使用 ""，不能使用 ''

// 集成方案 1
implementation "io.agora.rtc:full-rtc-basic:${agora_sdk_version}"
implementation "io.agora.rtc:full-screen-sharing:${agora_sdk_version}"
implementation "io.agora.rtc:screen-capture:${agora_sdk_version}"

// 集成方案 2
implementation "io.agora.rtc:full-sdk:${agora_sdk_version}"
implementation "io.agora.rtc:full-screen-sharing:${agora_sdk_version}"
...
}
```
### 2. （可选）添加前台服务权限
如果你的 Android 版本为 Android 9 及以上，需要在 `/app/Manifests/AndroidManifest.xml` 文件中添加如下前台服务权限，以避免应用退后台后被系统杀死。

```java
android.permission.FOREGROUND_SERVICE
```


### 3. 调用 API
在需要将多路视频流同时发布到频道的场景下，你需要先加入一个频道，在该频道中发布一路视频流（比如屏幕共享流）；然后加入第二个频道，在该频道中发布另一路视频流（比如摄像头采集的视频流），示例代码如下：

  ```java
  public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
      if (compoundButton.getId() == R.id.screenShare) {
          if (Build.VERSION.SDK_INT > Build.VERSION_CODES.LOLLIPOP) {
              if(b){
                  if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                      getActivity().startForegroundService(fgServiceIntent);
                  }
                  DisplayMetrics metrics = new DisplayMetrics();
                  getActivity().getWindowManager().getDefaultDisplay().getRealMetrics(metrics);
                  ScreenCaptureParameters parameters = new ScreenCaptureParameters();
                  parameters.videoCaptureParameters.width = 720;
                  parameters.videoCaptureParameters.height = (int) (720 * 1.0f / metrics.widthPixels * metrics.heightPixels);
                  parameters.videoCaptureParameters.framerate = DEFAULT_SHARE_FRAME_RATE;
                  parameters.captureAudio = true;
                  // 开始屏幕共享
                  engine.startScreenCapture(parameters);
                  // 更新频道媒体选项，发布屏幕采集的音频和视频
                  options.publishScreenCaptureVideo = true;
                  options.publishScreenCaptureAudio = true;
                  // 不发布摄像头采集的视频
                  options.publishCameraTrack = false;
                  engine.updateChannelMediaOptions(options);
                  addScreenSharePreview();
              }
              else{
                  // 停止屏幕共享
                  engine.stopScreenCapture();
                  if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                      getActivity().stopService(fgServiceIntent);
                  }
                  // 更新频道媒体选项，停止发布屏幕采集的视频和音频
                  options.publishScreenCaptureVideo = false;
                  options.publishScreenCaptureAudio = false;
                  engine.updateChannelMediaOptions(options);
              }
              screenSharePreview.setEnabled(b);
              screenSharePreview.setChecked(b);
          } else {
              showAlert(getString(R.string.lowversiontip));
          }
      } else if (compoundButton.getId() == R.id.camera) {
              if(b){
                  ChannelMediaOptions mediaOptions = new ChannelMediaOptions();
                  mediaOptions.autoSubscribeAudio = false;
                  mediaOptions.autoSubscribeVideo = false;
                  mediaOptions.publishScreenCaptureVideo = false;
                  // 在多频道中发布摄像头采集的视频
                  mediaOptions.publishCameraTrack = true;
                  mediaOptions.clientRoleType = Constants.CLIENT_ROLE_BROADCASTER;
                  mediaOptions.channelProfile = Constants.CHANNEL_PROFILE_LIVE_BROADCASTING;
                  rtcConnection2.channelId = et_channel.getText().toString();
                  rtcConnection2.localUid = new Random().nextInt(512)+512;
                  // 加入多频道
                  engine.joinChannelEx(null,rtcConnection2,mediaOptions,iRtcEngineEventHandler);
              }
              else{
                  engine.leaveChannelEx(rtcConnection2);
                  engine.startPreview(Constants.VideoSourceType.VIDEO_SOURCE_CAMERA_PRIMARY);
              }
      }else if (compoundButton.getId() == R.id.screenSharePreview) {
          if(b){
              addScreenSharePreview();
          }else{
              fl_screen.removeAllViews();
              engine.stopPreview(Constants.VideoSourceType.VIDEO_SOURCE_SCREEN_PRIMARY);
          }
      }
  }
  ```



## 参考信息

### 示例项目

我们在 GitHub 上提供开源[示例项目](https://github.com/AgoraIO/API-Examples/blob/main/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/SwitchCameraScreenShare.java)供你参考。



### API 参考

- [`startScreenCapture`](./API%20Reference/java_ng/API/toc_screen_share.html#api_irtcengine_startscreencapture)
- [`updateScreenCaptureParameters`](./API%20Reference/java_ng/API/toc_screen_share.html#api_irtcengine_updatescreencaptureparameters)
- [`stopScreenCapture`](./API%20Reference/java_ng/API/toc_screen_share.html#api_irtcengine_stopscreencapture)