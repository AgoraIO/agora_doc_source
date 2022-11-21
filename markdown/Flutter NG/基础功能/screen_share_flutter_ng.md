# 屏幕共享

在视频通话或互动直播中进行屏幕共享，可以将说话人或主播的屏幕内容，以视频的方式分享给其他说话人或观众观看，以提高沟通效率。

屏幕共享在如下场景中应用广泛：

- 视频会议场景中，屏幕共享可以将讲话者本地的文件、数据、网页、PPT 等画面分享给其他与会人；
- 在线课堂场景中，屏幕共享可以将老师的课件、笔记、讲课内容等画面展示给学生观看。

自 5.3.0 起，Agora 提供 Flutter API 进行移动端（Android 和 iOS 平台）屏幕共享。本文介绍如何使用 Flutter SDK 在 Android， iOS，macOS 和 WIndows 平台实现屏幕共享。

## 前提条件

在实现屏幕共享前，请确保已在你的项目中实现基本的实时音视频功能。详见[开始音视频通话](./start_call_flutter?platform=Flutter)或[开始视频直播](./start_live_flutter?platform=Flutter)。

## Android 平台

在 Android 平台实现屏幕共享时，只需要调用 [`startScreenCaptureMobile` ](./API%20Reference/flutter/v5.3.0/API/class_irtcengine.html#api_startscreencapturemobile) 开启屏幕共享。你可以参考 Agora-Flutter-SDK 中的 [screen_sharing.dart](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/example/lib/examples/advanced/screen_sharing/screen_sharing.dart) 文件实现屏幕共享。

## iOS 平台

<div class="alert note"><ul><li>受系统限制，屏幕共享只支持 iOS 12.0 或之后的系统。</li><li>该功能对设备性能要求较高，Agora 推荐你在 iPhone X 及之后机型上使用。</li></ul></div>


### 技术原理

iOS 端的屏幕共享是通过在 Extension 中使用 iOS 原生的 ReplayKit 框架实现录制屏幕，然后将屏幕共享流作为一个用户加入频道实现的。由于 Apple 不支持在主 app 进程采集屏幕，因此你需要为屏幕共享流单独创建一个 Extension。

![img](https://web-cdn.agora.io/docs-files/1606368135907)

### 实现步骤

1. 前往你的项目文件夹，用 Xcode 打开 `ios/.xcodeproj` 文件夹。

2. 创建一个 Broadcast Upload Extension 用于开启屏幕共享的进程：

   a. 在 Xcode 点击 **File > New > Target...**, 在弹出的窗口中选择 **Broadcast Upload Extension**, 点击 **Next**。

      ![img](https://web-cdn.agora.io/docs-files/1606368184836)

   b. 在弹出的窗口中填写 **Product Name** 等信息，取消勾选 **Include UI Extension**，点击 **Finish**。Xcode 会自动创建该 Extension 的文件夹，其中包含 `SampleHandler.h` 文件。

   c. 在 **Target** 下选中刚创建的 Extension，点 **General**，在 **Deployment Info** 下将 iOS 的版本设置为 12.0 或之后。
	 
      ![img](https://web-cdn.agora.io/docs-files/1652254668249)

   d. 修改 `SampleHandler.h` 文件，以修改实现屏幕共享的代码逻辑：

      - 如果你只需使用 Agora 提供的 `AgoraReplayKitExtension.xcframework` 中的功能，修改方式为：选中 `Target` 为刚刚创建的 Extension，在 **Info** 中将 **NSExtension > NSExtensionPrincipalClass** 所对应的 **Value** 从 **SampleHandler** 改为 **AgoraReplayKitHandler**。

        ![](https://web-cdn.agora.io/docs-files/1660719905345)

      - 如果你还需要自定义一些业务逻辑，修改方式为：将如下代码替换到 `SampleHandler.h` 文件中：

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
          //                NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"Host app stop srceen capture"};
          //                NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo];
          //                [self finishBroadcastWithError:error];
                          NSLog(@"AgoraReplayKitExtReasonInitiativeStop");
                      }
                      break;
                  case AgoraReplayKitExtReasonConnectFail:
                      {
          //                NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"Connect host app fail need startScreenCapture in host app"};
          //                NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo];
          //                [self finishBroadcastWithError:error];
                          NSLog(@"AgoraReplayKitExReasonConnectFail");
                      }
                      break;
        
                  case AgoraReplayKitExtReasonDisconnect:
                      {
          //                NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"disconnect with host app"};
          //                NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo];
          //               [self finishBroadcastWithError:error];
                          NSLog(@"AgoraReplayKitExReasonDisconnect");
                      }
                      break;
                  default:
                      break;
              }
          }
        
          @end
        ```

3. 调用 [`startScreenCaptureMobile` ](./API%20Reference/flutter/v5.3.0/API/class_irtcengine.html#api_startscreencapturemobile)，并结合用户的手动操作，使 app 开启屏幕共享。有两种方式供你参考：

   - 方式一：提示用户在 iOS 系统的控制中心长按**屏幕录制**按钮，并选择用你创建的 Extension 开启录制。
   - 方式二：使用 Apple 在 iOS 12.0 中新增的 [RPSystemBroadcastPickerView](https://developer.apple.com/documentation/replaykit/rpsystembroadcastpickerview)，使 app 界面弹出“开启屏幕共享”的按钮。提示用户通过点击该按钮开启录制。
    
   <div class="alert note">在 Flutter 中您需要自行实现与 <code>RPSystemBroadcastPickerView</code> 交互逻辑。<code>RPSystemBroadcastPickerView</code> 存在一些使用限制并可能在之后版本的 iOS 系统中失效。因此，请酌情使用方式二。</div>

     
### 示例项目

Agora 在 [Agora-Flutter-SDK](https://github.com/AgoraIO/Agora-Flutter-SDK) 中提供屏幕共享的示例，你可以参考其中的如下文件实现屏幕共享：

- `example/ios/ScreenSharing/SampleHandler.h`
- `example/ios/ScreenSharing/SampleHandler.m`
- `example/lib/src/examples/advanced/screen_sharing/screen_sharing.dart`

### 开发注意事项

- 如果你使用 Cocoapods，则需要在 `Podfile` 文件中添加如下内容，为你的屏幕共享 Extension 添加依赖。注意将 `ScreenSharing` 替换为你的屏幕共享 Extension 的 Target 名称。

```
    target 'ScreenSharing' do
         pod 'AgoraRtcEngine_iOS', '3.7.0.3'
    end
```

   <div class="alert note">pod 依赖版本需要与  <code>agora_rtc_engine/ios/agora_rtc_engine.podspec</code> 文件中的 SDK 依赖版本保持一致。</div>

- Broadcast Upload Extension 的内存使用限制为 50 MB，请确保屏幕共享的 Extension 内存使用不超过 50 MB。

- 屏幕共享的进程中，需要调用 `muteAllRemoteVideoStreams` 和 `muteAllRemoteAudioStreams` 方法取消接收远端用户的流，避免重复订阅。


### API 参考

屏幕共享功能目前存在一些使用限制和注意事项，同时会产生费用，Agora 推荐你在调用 API 前先阅读如下 API 参考：

- [`startScreenCaptureMobile` ](./API%20Reference/flutter/v5.3.0/API/class_irtcengine.html#api_startscreencapturemobile)
- [`stopScreenCapture`](./API%20Reference/flutter/v5.3.0/API/class_irtcengine.html#api_stopscreencapture)
- [`updateScreenCaptureParametersMobile`](./API%20Reference/flutter/v5.3.0/API/class_irtcengine.html#api_updatescreencaptureparametersmobile)


## macOS 平台/Windows 平台


### 实现步骤

Agora 目前在 macOS/Windows 平台上支持：
- 通过 `displayId` 共享指定屏幕，或指定屏幕的部分区域。
- 通过 `windowId` 共享指定窗口，或指定窗口的部分区域。

#### 共享指定屏幕

你可以直接通过 agora_rtc_engine 提供的 [`enumerateDisplays`](./API%20Reference/flutter/v5.3.0/API/api_enumeratedisplays.html) 来获取 Display ID。

<div class="alert info"><ul>
	<li>在 macOS 中，<code>enumerateDisplays</code> 方法通过 <code>NSScreen</code> 获取 Display ID，详情请参考 <a href="https://developer.apple.com/documentation/appkit/nsscreen/1388360-devicedescription">Apple deviceDescription 说明</a>。</li>
<li>在 Windows 中，<code>enumerateDisplays</code> 方法通过 <code>EnumDisplayDevices</code> 获取 Display ID，详情请参考 <a href="https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-enumdisplaydevicesa">EnumDisplayDevicesA function (winuser.h)</a>。</li>
	</ul></div>


以下示例代码演示如何在 macOS/Windows 上通过 Display ID 进行屏幕共享：

```dart
  Future<void> startScreenCaptureByDisplayId() async {
    final List<Display> displays = _engine.enumerateDisplays();
    final displayId = displays[0].id;
    await _engine.startScreenCaptureByDisplayId(
      displayId,
    );
  }
```
	
#### 共享指定窗口

你可以直接通过 agora_rtc_engine 提供的 `enumerateWindows` 来获取 Window ID。

<div class="alert info"><ul>
	<li>在 macOS 中，<code>enumerateWindows</code> 方法通过 <code>CGWindowListCopyWindowInfo</code> 获取 Window ID 的详情请参考 <a href="https://developer.apple.com/documentation/coregraphics/1455137-cgwindowlistcopywindowinfo">Apple CGWindowListCopyWindowInfo 说明</a>。</li>
	<li>在 Windows 中，<code>enumerateWindows</code> 方法通过 <code>EnumerateWindows</code> 获取 Window ID，详情请参考 <a href="https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-enumwindows">EnumWindows function (winuser.h)</a>。</li>
	</ul></div>


以下示例代码演示如何在 macOS/Windows上 通过 Window ID 进行屏幕共享：

```dart
  Future<void> startScreenCaptureByWindowId() async {
    final List<Window> windows = _engine.enumerateWindows();
    final windowId = windows[0].id;
    await _engine.startScreenCaptureByWindowId(windowId);
  }
```

### 示例项目

Agora 在 [Agora-Flutter-SDK](https://github.com/AgoraIO/Agora-Flutter-SDK) 中提供屏幕共享的示例，你可以参考其中的 [`example/lib/examples/advanced/screen_sharing/screen_sharing.dart`](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/example/lib/examples/advanced/screen_sharing/screen_sharing.dart) 文件实现屏幕共享。

### API 参考

- [`enumerateDisplays`](./API%20Reference/flutter/v5.3.0/API/api_enumeratedisplays.html)
- [`enumerateWindows`](./API%20Reference/flutter/v5.3.0/API/api_enumeratewindows.html)
- [`startScreenCaptureByDisplayId`](./API%20Reference/flutter/v5.3.0/API/class_irtcengine.html#api_startscreencapturebydisplayid)
- [`startScreenCaptureByWindowId`](./API%20Reference/flutter/v5.3.0/API/class_irtcengine.html#api_startscreencapturebywindowid) 
- [`updateScreenCaptureParameters`](./API%20Reference/flutter/v5.3.0/API/class_irtcengine.html#api_updatescreencaptureparameters)
- [`setScreenCaptureContentHint`](./API%20Reference/flutter/v5.3.0/API/class_irtcengine.html#api_setscreencapturecontenthint)
- [`updateScreenCaptureRegion`](./API%20Reference/flutter/v5.3.0/API/class_irtcengine.html#api_updatescreencaptureregion)
- [`stopScreenCapture`](./API%20Reference/flutter/v5.3.0/API/class_irtcengine.html#api_stopscreencapture)


### 同时共享屏幕和开启视频

如需要在桌面端（macOS/Windows）支持通过子进程进行屏幕共享，可参考我们提供的示例文件 [screen_sharing_with_subprocess](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/example/lib/examples/advanced/screen_sharing_with_subprocess/screen_sharing_with_subprocess.dart) 。

<div class="alert note">对于 macOS 平台，在调用 <a href="./API%20Reference/flutter/v5.3.0/API/class_irtcengine.html#api_getscreensharehelper"><code>getScreenShareHelper</code></a> 前，请设置 <code>AppGroup</code> 并将其设为 <code>getScreenShareHelper</code>  中的 <code>appGroup</code> 参数的值。详见<a href="https://developer.apple.com/library/archive/documentation/Security/Conceptual/AppSandboxDesignGuide/AppSandboxInDepth/AppSandboxInDepth.html#//apple_ref/doc/uid/TP40011183-CH3-SW21">相关苹果开发者文档</a>。</div>