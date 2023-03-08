# 屏幕共享

在视频通话或互动直播中进行屏幕共享，可以将说话人或主播的屏幕内容，以视频的方式分享给其他说话人或观众观看，以提高沟通效率。

屏幕共享在如下场景中应用广泛：

- 视频会议场景中，屏幕共享可以将讲话者本地的文件、数据、网页、PPT 等画面分享给其他与会人；
- 在线课堂场景中，屏幕共享可以将老师的课件、笔记、讲课内容等画面展示给学生观看。

本文介绍如何使用声网 Flutter SDK 6.x 在 Android，iOS，macOS 和 Windows 平台实现屏幕共享。


## 前提条件

在实现屏幕共享前，请确保已在你的项目中实现基本的实时音视频功能。详见[开始音视频通话](./start_call_flutter_ng)或[开始视频直播](./start_live_flutter_ng)。


## Android 平台

在 Android 平台实现屏幕共享时，只需要调用 [`startScreenCapture`](./API%20Reference/flutter_ng/API/toc_screen_share.html?platform=Flutter#api_irtcengine_startscreencapture) 开启屏幕共享。你可以参考声网视频 SDK 中的 [screen_sharing.dart](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/blob/main/example/lib/examples/advanced/screen_sharing/screen_sharing.dart) 文件实现屏幕共享。

## iOS 平台

<div class="alert note"><ul><li>受系统限制，屏幕共享只支持 iOS 12.0 或之后的系统。</li><li>该功能对设备性能要求较高，声网推荐你在 iPhone X 及之后机型上使用。</li></ul></div>

### 技术原理

由于 Apple 不支持在 app 主进程采集屏幕，因此你需要为屏幕共享流单独创建一个 Extension，并在 Extension 中使用 iOS 原生的 ReplayKit 框架实现录制屏幕，然后将屏幕共享流发送给主进程、实现屏幕共享。详见下图：

<img src="https://web-cdn.agora.io/docs-files/1675750878809"/>

### 实现步骤
#### 1. 打开项目

  前往你的项目文件夹，用 Xcode 打开 `ios/.xcodeproj`。

#### 2. 创建 Broadcast Upload Extension

  a. 在 Xcode 菜单栏，点击 **File > New > Target...**, 在弹出的窗口中选择 **Broadcast Upload Extension**, 点击 **Next**。
  <img src="https://web-cdn.agora.io/docs-files/1669197671714" width="80%">

  b. 在弹出的窗口中填写 **Product Name** 等信息，取消勾选 **Include UI Extension**，点击 **Finish**。Xcode 会自动创建该 Extension 的文件夹，其中包含 `SampleHandler.h` 文件。
  <img src="https://web-cdn.agora.io/docs-files/1669197908653" width="80%">

  c. 在 **Target** 下选中刚创建的 Extension，点击 **General**，在 **Deployment Info** 下将 iOS 的版本设置为 12.0 或以上。
  <img src="https://web-cdn.agora.io/docs-files/1669199079385" width="80%">

  <div class="alert note">Broadcast Upload Extension 的内存使用限制为 50 MB，请确保屏幕共享的 Extension 内存使用不超过 50 MB。</div>

#### 3. 修改 Podfile

如果你使用 Cocoapods，则需要在 `Podfile` 文件中添加如下内容，为你的屏幕共享 Extension 添加依赖。

  ```
  target 'Your Extension Name' do
        pod 'AgoraRtcEngine_iOS', 'x.x.x.x'
  end
  ```

  <div class="alert note"><ul><li>将 <code>Your Extension Name</code> 替换为你的 Extension 名。</li><li>pod 依赖版本需要与 <a href="https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/blob/main/ios/agora_rtc_engine.podspec">agora_rtc_engine/ios/agora_rtc_engine.podspec</a> 文件中的 SDK 依赖版本保持一致。</li></ul></div>

打开终端，进入 `./ios` 目录，运行 `pod install`。

#### 4. 修改 SampleHandler

修改 `SampleHandler.h` 文件，以修改实现屏幕共享的代码逻辑：

  - 如果你只需使用声网提供的 `AgoraReplayKitExtension.xcframework` 中的功能，选中 `Target` 为刚刚创建的 Extension，在 **Info** 中将 **NSExtension > NSExtensionPrincipalClass** 所对应的 **Value** 从 **SampleHandler** 改为 **AgoraReplayKitHandler**。

    ![](https://web-cdn.agora.io/docs-files/1669346575589)

  - 如果你还需要自定义一些业务逻辑，将如下代码替换到 `SampleHandler.h` 文件中：

    ```objectivec
      // Objective-C
      #import "SampleHandler.h"
      #import "AgoraReplayKitExt.h"
      #import <sys/time.h>
    
      @interface SampleHandler ()<AgoraReplayKitExtDelegate>
    
      @end
    
      @implementation SampleHandler
    
      - (void)broadcastStartedWithSetupInfo:(NSDictionary<NSString *,NSObject *> *)setupInfo {
          // User has requested to start the broadcast. Setup info from the UI extension can be supplied but optional.
          [[AgoraReplayKitExt shareInstance] start:self];
    
      }
    
      - (void)broadcastPaused {
          // User has requested to pause the broadcast. Samples will stop being delivered.
          NSLog(@"broadcastPaused");
          [[AgoraReplayKitExt shareInstance] pause];
      }
    
      - (void)broadcastResumed {
          // User has requested to resume the broadcast. Samples delivery will resume.
          NSLog(@"broadcastResumed");
          [[AgoraReplayKitExt shareInstance] resume];
    
      }
    
      - (void)broadcastFinished {
          // User has requested to finish the broadcast.
          NSLog(@"broadcastFinished");
          [[AgoraReplayKitExt shareInstance] stop];
    
      }
    
      - (void)processSampleBuffer:(CMSampleBufferRef)sampleBuffer withType:(RPSampleBufferType)sampleBufferType {
          [[AgoraReplayKitExt shareInstance] pushSampleBuffer:sampleBuffer withType:sampleBufferType];
      }
    
      #pragma mark - AgoraReplayKitExtDelegate
    
      - (void)broadcastFinished:(AgoraReplayKitExt *_Nonnull)broadcast reason:(AgoraReplayKitExtReason)reason {
          switch (reason) {
              case AgoraReplayKitExtReasonInitiativeStop:
                  {
                    // NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"Host app stop screen capture"};
                    // NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo];
                    // [self finishBroadcastWithError:error];
                      NSLog(@"AgoraReplayKitExtReasonInitiativeStop");
                  }
                  break;
              case AgoraReplayKitExtReasonConnectFail:
                  {
                    // NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"Connect host app fail need startScreenCapture in host app"};
                    // NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo];
                    // [self finishBroadcastWithError:error];
                      NSLog(@"AgoraReplayKitExReasonConnectFail");
                  }
                  break;
    
              case AgoraReplayKitExtReasonDisconnect:
                  {
                    // NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"disconnect with host app"};
                    // NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo];
                    // [self finishBroadcastWithError:error];
                      NSLog(@"AgoraReplayKitExReasonDisconnect");
                  }
                  break;
              default:
                  break;
          }
      }
    
      @end
    ```

#### 4. 开始屏幕共享

调用 [`startScreenCapture`](./API%20Reference/flutter_ng/API/toc_screen_share.html?platform=Flutter#api_irtcengine_startscreencapture)，并结合用户的手动操作，使 app 开启屏幕共享。有两种方式供你参考：

   - 方式一：提示用户在 iOS 系统的控制中心长按**屏幕录制**按钮，并选择用你创建的 Extension 开启录制。
   - 方式二：使用 Apple 在 iOS 12.0 中新增的 [RPSystemBroadcastPickerView](https://developer.apple.com/documentation/replaykit/rpsystembroadcastpickerview)，使 app 界面弹出“开启屏幕共享”的按钮。提示用户通过点击该按钮开启录制。


## macOS/Windows 平台
### 技术原理

声网目前在 macOS/Windows 平台上支持以下两种屏幕共享方案：

- 通过 `displayId` 共享指定屏幕，或指定屏幕的部分区域。
- 通过 `windowId` 共享指定窗口，或指定窗口的部分区域。

API 的调用时序如下图所示：

![](https://web-cdn.agora.io/docs-files/1675750920612)

### 实现步骤
#### 1. 获取屏幕 ID 或窗口 ID

你可以直接通过 agora_rtc_engine 提供的 [`getScreenCaptureSources`](./API%20Reference/flutter_ng/API/toc_screen_share.html?platform=Flutter#api_irtcengine_getscreencapturesources) 来获取 Display ID 或 Window ID，示例代码如下：

  ```dart
  await rtcEngine.getScreenCaptureSources(
          thumbSize: thumbSize, iconSize: iconSize, includeScreen: true);
  ```

#### 2. 共享指定的屏幕或窗口

以下示例代码演示如何在 macOS/Windows 上通过 Display ID 共享指定屏幕：

  ```dart
  await rtcEngine.startScreenCaptureByDisplayId(
      displayId: sourceId!,
      regionRect: const Rectangle(x: 0, y: 0, width: 0, height: 0),
      captureParams: const ScreenCaptureParameters(
        captureMouseCursor: true,
        frameRate: 30,
      ));
  ```

以下示例代码演示如何在 macOS/Windows上 通过 Window ID 共享指定窗口：

  ```dart
  await rtcEngine.startScreenCaptureByWindowId(
    windowId: sourceId!,
    regionRect: const Rectangle(x: 0, y: 0, width: 0, height: 0),
    captureParams: const ScreenCaptureParameters(
      captureMouseCursor: true,
      frameRate: 30,
    ),
  );
  ```

#### 3. 加入频道并发布屏幕共享流

如果仅需发布屏幕共享流，参考如下代码：

  ```dart
  await _engine.joinChannelEx(
      token: '',
      connection: RtcConnection(
          channelId: _controller.text, localUid: shareShareUid),
      options: const ChannelMediaOptions(
        autoSubscribeVideo: true,
        autoSubscribeAudio: true,
        publishScreenTrack: true,
        publishSecondaryScreenTrack: true,
        publishCameraTrack: false,
        publishMicrophoneTrack: false,
        publishScreenCaptureAudio: true,
        publishScreenCaptureVideo: true,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ));
  ```

如需发布屏幕共享流和本地摄像头采集的视频流，在你的项目中添加如下代码：

  ```dart
  await _engine.joinChannelEx(
      token: '',
      connection:
          RtcConnection(channelId: _controller.text, localUid: localUid),
      options: const ChannelMediaOptions(
        publishCameraTrack: true,
        publishMicrophoneTrack: true,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ));


  await _engine.joinChannelEx(
      token: '',
      connection: RtcConnection(
          channelId: _controller.text, localUid: shareShareUid),
      options: const ChannelMediaOptions(
        autoSubscribeVideo: true,
        autoSubscribeAudio: true,
        publishScreenTrack: true,
        publishSecondaryScreenTrack: true,
        publishCameraTrack: false,
        publishMicrophoneTrack: false,
        publishScreenCaptureAudio: true,
        publishScreenCaptureVideo: true,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ));
  ```


## 相关参考
### 注意事项

屏幕共享流的视频单价以你在 [`ScreenCaptureParameters`](./API%20Reference/flutter_ng/API/class_screencaptureparameters.html?platform=Flutter) 中设置的视频分辨率为准，`dimensions` 参数的默认值为 1920 × 1080 进行计费。详见 [屏幕共享流的分辨率](https://docs.agora.io/cn/video-call-4.x/billing_rtc_ng?platform=Flutter#屏幕共享流的分辨率)。

### 示例项目

声网在 [Flutter SDK](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK) 中提供屏幕共享的代码示例，你可以参考以下文件实现屏幕共享：

- [`screen_sharing.dart`](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/blob/main/example/lib/examples/advanced/screen_sharing/screen_sharing.dart)
- [`info.plist`](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/blob/main/example/ios/ScreenSharing/Info.plist)
- [`SampleHandler.h`](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/blob/main/example/ios/ScreenSharing/SampleHandler.h)
- [`SampleHandler.m`](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/blob/main/example/ios/ScreenSharing/SampleHandler.m)


### API 参考

- Android, iOS

  - [`startScreenCapture`](./API%20Reference/flutter_ng/API/class_irtcengine.html#api_irtcengine_startscreencapture)
  - [`stopScreenCapture`](./API%20Reference/flutter_ng/API/class_irtcengine.html#api_irtcengine_stopscreencapture)
  - [`updateScreenCapture`](./API%20Reference/flutter_ng/API/class_irtcengine.html#api_irtcengine_updatescreencapture)

- Windows, macOS

  - [`getScreenCaptureSources`](./API%20Reference/flutter_ng/API/toc_screen_share.html?platform=Flutter#api_irtcengine_getscreencapturesources)
  - [`startScreenCaptureByDisplayId`](./API%20Reference/flutter_ng/API/toc_screen_share.html?platform=Flutter#api_irtcengine_startscreencapturebydisplayid)
  - [`startScreenCaptureByWindowId`](./API%20Reference/flutter_ng/API/toc_screen_share.html?platform=Flutter#api_irtcengine_startscreencapturebywindowid) 
  - [`updateScreenCaptureParameters`](./API%20Reference/flutter_ng/API/toc_screen_share.html?platform=Flutter#api_irtcengine_updatescreencaptureparameters)
  - [`updateScreenCaptureRegion`](./API%20Reference/flutter_ng/API/toc_screen_share.html?platform=Flutter#api_irtcengine_updatescreencaptureregion)
  - [`setScreenCaptureContentHint`](./API%20Reference/flutter_ng/API/toc_screen_share.html?platform=Flutter#api_irtcengine_setscreencapturecontenthint)
  - [`setScreenCaptureScenario`](./API%20Reference/flutter_ng/API/toc_screen_share.html?platform=Flutter#api_irtcengine_setscreencapturescenario)
  - [`stopScreenCapture`](./API%20Reference/flutter_ng/API/toc_screen_share.html?platform=Flutter#api_irtcengine_stopscreencapture)