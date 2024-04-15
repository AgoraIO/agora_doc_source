~b2982480-d208-11ed-8efe-b91caddc8ecb~


## 技术原理

由于 Apple 不支持在 app 主进程采集屏幕，因此你需要为屏幕共享流单独创建一个 Extension，并在 Extension 中使用 iOS 原生的 ReplayKit 框架实现录制屏幕，然后将屏幕共享流发送给主进程、实现屏幕共享。

<img src="https://web-cdn.agora.io/docs-files/1681380361810" width="70%">

根据实际业务场景的不同，你可以选择以下任一方式调用 API 实现屏幕共享：

- 在加入频道前调用 `startScreenCapture`，然后调用 `joinChannelByToken` [2/4] 加入频道并设置 `publishScreenCaptureVideo` 为 `true`，即可开始屏幕共享。
- 在加入频道后调用 `startScreenCapture`，然后调用 `updateChannelWithMediaOptions` 更新频道媒体选项并设置 `publishScreenCaptureVideo` 为 `true`，即可开始屏幕共享。

## 注意事项
- 在开启屏幕共享后，声网以屏幕共享视频流的分辨率作为计费标准，详见[计费说明](./billing_rtc_ng)。默认分辨率为 1280 × 720，你也可以根据你的业务需求进行调整。
- 为提高屏幕共享时采集系统音频的成功率，声网推荐你在加入频道前通过 `setAudioScenario` 方法设置音频场景为  `AgoraAudioScenarioGameStreaming`。
- 受系统限制，屏幕共享只支持 iOS 12.0 及以上版本。</li>
- 该功能对设备性能要求较高，声网推荐你使用 iPhone X 及以上设备。</li>
- 用户在 iOS 设备上开启屏幕共享后，因系统限制，音频路由会自动切换为听筒。如果当前使用通话音量，则你可以手动切换音频路由，例如，你可以根据实际需求将音频路由切换成扬声器。如果当前使用媒体音量，由于系统限制，你在这种场景下无法手动切换音频路由。如果你不了解使用的是通话还是媒体音量，请参考[如何区分媒体音量和通话音量](https://docs.agora.io/cn/live-streaming-premium-legacy/faq/system_volume)。

## 前提条件

在实现屏幕共享前，请确保已在你的项目中实现基本的实时音视频功能。详见[实现视频通话](./start_call_ios_ng?platform=iOS)或[实现视频直播](./start_live_ios_ng?platform=iOS)。

## 修改项目文件

1. 前往你的项目文件夹，用 Xcode 打开 `ios/.xcodeproj`。
1. 点击 **File > New > Target...**, 在弹出的窗口中选择 **Broadcast Upload Extension**, 点击 **Next**。

    ![](https://web-cdn.agora.io/docs-files/1606368184836)

2. 在弹出的窗口中填写 **Product Name** 等信息，取消勾选 **Include UI Extension**，点击 **Finish**。Xcode 会自动创建该 Extension 的文件夹，其中包含 `SampleHandler.h` 文件。
3. 在 **Target** 下选中刚创建的 Extension，点击 **General**，在 **Deployment Info** 下将 iOS 的版本设置为 12.0 或之后。
    <img src="https://web-cdn.agora.io/docs-files/1670580188367" width="35%">

4. 修改 `SampleHandler.h` 文件，以实现屏幕共享的代码逻辑：

   - 如果你只需使用声网提供的 `AgoraReplayKitExtension.xcframework` 中的功能，修改方式为：选中 **Target** 为刚刚创建的 Extension，在 **Info** 中将 **NSExtension > NSExtensionPrincipalClass** 所对应的 **Value** 从 **SampleHandler** 改为 **AgoraReplayKitHandler**。
  
    ![](https://web-cdn.agora.io/docs-files/1648112619203)
   - 如果你还需要自定义一些业务逻辑，可将如下代码替换到 `SampleHandler.h` 文件中。
  
        ```objective-c
        // Objective-C
        #import "SampleHandler.h"
        #import "AgoraReplayKitExt.h"
        #import <sys/time.h
        @interface SampleHandler ()<AgoraReplayKitExtDelegate
        @en
        @implementation SampleHandle
        - (void)broadcastStartedWithSetupInfo:(NSDictionary<NSString *,NSObject *> *)setupInfo {
            // User has requested to start the broadcast. Setup info from the UI extension can be supplied but optional.
            [[AgoraReplayKitExt shareInstance] start:self]

        - (void)broadcastPaused {
            // User has requested to pause the broadcast. Samples will stop being delivered.
            NSLog(@"broadcastPaused");
            [[AgoraReplayKitExt shareInstance] pause];

        - (void)broadcastResumed {
            // User has requested to resume the broadcast. Samples delivery will resume.
            NSLog(@"broadcastResumed");
            [[AgoraReplayKitExt shareInstance] resume]

        - (void)broadcastFinished {
            // User has requested to finish the broadcast.
            NSLog(@"broadcastFinished");
            [[AgoraReplayKitExt shareInstance] stop]

        - (void)processSampleBuffer:(CMSampleBufferRef)sampleBuffer withType:(RPSampleBufferType)sampleBufferType {
            [[AgoraReplayKitExt shareInstance] pushSampleBuffer:sampleBuffer withType:sampleBufferType];

        #pragma mark - AgoraReplayKitExtDelegat
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
                    break
                case AgoraReplayKitExtReasonDisconnect:
                    {
        //                NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"disconnect with host app"};
        //                NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo];
        //                [self finishBroadcastWithError:error];
                        NSLog(@"AgoraReplayKitExReasonDisconnect");
                    }
                    break;
                default:
                    break;
            }

        @end
        ```

## 实现屏幕共享

本节介绍如何在你的项目中实现屏幕共享，API 调用时序如下图所示。


### 自动集成插件

通过 Cocoapods 集成 SDK 时，你需要在 `Podfile` 文件中添加如下内容，指定集成屏幕共享动态库 `AgoraReplayKitExtension.xcframework`，示例代码如下：

```
platform :ios, '9.0'
target 'Your App' do
// 只集成基础库和屏幕共享动态库
// 请使用具体的 SDK 版本号替换下面代码中的 x.y.z，可通过发版说明获取最新版本号      
pod 'AgoraRtcEngine_iOS', 'x.y.z', :subspecs => ['RtcBasic', 'ReplayKit']
end
```
<div class="alert info">屏幕共享动态库封装了如下功能：
<li>使用 Apple ReplayKit 进行屏幕录制。
<li>使用 SDK 采集功能获取系统录屏数据，并发送给频道中其他用户。
</div>


### 调用 API
调用 `startScreenCapture`，并结合用户的手动操作，使 app 开启屏幕共享。有两种方式供你参考：

- 方式一：提示用户在 iOS 系统的控制中心长按**屏幕录制**按钮，并选择用你创建的 Extension 开启录制。
- 方式二：使用 Apple 在 iOS 12.0 中新增的 [RPSystemBroadcastPickerView](https://developer.apple.com/documentation/replaykit/rpsystembroadcastpickerview)，使 app 界面弹出 “开启屏幕共享” 的按钮，提示用户通过点击该按钮开启录制。

<div class="alert info"><code>RPSystemBroadcastPickerView</code> 存在一些使用限制并可能在后续版本的 iOS 系统中失效。因此，请酌情使用方式二。</div>


## 参考信息

### 示例项目

声网在 GitHub 提供了开源的示例项目供你参考。
* [Agora-ScreenShare-Extension](https://github.com/AgoraIO/API-Examples/tree/main/iOS/APIExample/Agora-ScreenShare-Extension)：实现 Extension 进程
* [ScreenShare](https://github.com/AgoraIO/API-Examples/tree/main/iOS/APIExample/APIExample/Examples/Advanced/ScreenShare)：在 `AgoraRtcEngineKit` 中实现屏幕共享

### API 参考

- [`startScreenCapture`](./API%20Reference/ios_ng/API/toc_screen_share.html.html#api_irtcengine_startscreencapture)
- [`updateScreenCapture`](./API%20Reference/ios_ng/API/toc_screen_share.html.html#api_irtcengine_updatescreencapture)
- [`stopScreenCapture`](./API%20Reference/ios_ng/API/toc_screen_share.html.html#api_irtcengine_stopscreencapture)


