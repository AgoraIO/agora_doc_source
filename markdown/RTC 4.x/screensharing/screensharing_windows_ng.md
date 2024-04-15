~b2982480-d208-11ed-8efe-b91caddc8ecb~

## 注意事项

如果要在屏幕共享时共享 4K 分辨率的超高清视频，你的设备需要满足一定要求，声网推荐的最低设备规格为：intel(R) Core(TM) i7-9750H CPU @ 2.60GHZ。

## 前提条件

在实现屏幕共享前，请确保已在你的项目中实现基本的实时音视频功能。详见[开始视频通话](./start_call_windows_ng?platform=Windows)或[开始互动直播](./start_live_windows_ng?platform=Windows)。



## 实现屏幕共享

本节介绍如何在你的项目中实现屏幕共享，API 调用时序如下图所示。

![](https://web-cdn.agora.io/docs-files/1680777036823)




开启屏幕共享有如下两种方案，你可以根据实际场景进行选择：

- 在加入频道前调用 `startScreenCaptureByDisplayId` 或 `startScreenCaptureByWindowId`，然后调用 `joinChannel`[2/2] 加入频道并设置 `publishScreenTrack` 或 `publishSecondaryScreenTrack` 为 `true`，即可开始屏幕共享。
- 在加入频道后调用该 `startScreenCaptureByDisplayId` 或 `startScreenCaptureByWindowId`，然后调用 `updateChannelMediaOptions` 设置 `publishScreenTrack` 或 `publishSecondaryScreenTrack` 为 `true`，即可开始屏幕共享。 

本文中的流程图和步骤均以第一种方案为例。



参考如下具体步骤，实现屏幕共享。

### 获取资源列表

调用 `getScreenCaptureSources`，获取可共享的屏幕和窗口的对象列表，列表中包含窗口 ID 和屏幕 ID 等重要信息。方便用户通过列表中的缩略图选择共享某个显示器的屏幕或某个窗口。示例代码如下：

```cpp
{
    // 获取指定的可共享窗口或屏幕的信息。
    agora::rtc::IScreenCaptureSourceList* listCapture = m_rtcEngine->getScreenCaptureSources(sz, sz, true);
    for (int i = 0; i < listCapture->getCount(); i++)
    {
        // 返回可共享窗口或屏幕的信息
        agora::rtc::ScreenCaptureSourceInfo info = listCapture->getSourceInfo(i);
    }
 
    // 获取可共享的窗口和屏幕的个数。
    return static_cast<int>(m_listWnd.GetCount());
}
```

### 开启屏幕共享

根据实际应用场景，在以下 3 种屏幕共享方式中任选一种。

#### 共享整个屏幕

调用 `startScreenCaptureByDisplayId` 开始共享整个屏幕，参数设置如下：

- 将 `displayId` 设置为上一步获取到的 `sourceId` (屏幕 ID)。

- 在 `captureParams` 中设置你预期的视频编码属性。

  - 在文档场景或远程控制场景下，推荐将 `dimensions` 设置为 1920 × 1080；`frameRate` 设置为 10 fps。
  - 在游戏场景或视频场景下，推荐将 `dimensions` 设置为 960 × 720；`frameRate` 设置为 15 fps。

```cpp
// 开始共享指定的屏幕
m_rtcEngine->startScreenCaptureByDisplayId(id, regionRect, capParam);
```

#### 共享 app 窗口

调用 `startScreenCaptureByWindowId `开始共享整个 app 窗口，参数设置如下：

- 将 `windowId` 设置为上一步获取到的 `sourceId`（窗口 ID）。
- 在 `captureParams` 中设置你预期的视频编码属性。
  - 在文档场景或远程控制场景下，推荐将 `dimensions` 设置为 1920 × 1080；`frameRate` 设置为 10 fps。
  - 在游戏场景或视频场景下，推荐将 `dimensions` 设置为 960 × 720；`frameRate` 设置为 15 fps。

```cpp
// 开始共享指定的 app 窗口
ret = m_rtcEngine->startScreenCaptureByWindowId(hWnd, rcCapWnd, capParam);
```

#### 共享指定区域

调用 `startScreenCaptureByDisplayId` 或 `startScreenCaptureByWindowId` 方法开始共享，并将 `regionRect` 设置为你想要共享的区域相对于整个屏幕或窗口的位置。示例代码如下：

```cpp
// 设置你想要共享的区域参数。
// 如果设置的共享区域超出了屏幕的边界，则只共享屏幕内的内容；如果宽或高设为 0，则共享整个屏幕。
m_screenRegion = { 0,0,heightX,heightY };
agora::rtc::Rectangle rcCapWnd = { m_screenRegion.x, m_screenRegion.y, (int)(m_screenRegion.width * scale), (int)(m_screenRegion.height * scale) };
...
m_rtcEngine->startScreenCaptureByDisplayId(id, rcCapWnd, m_screenParam);
```




### (可选) 设置屏幕共享场景

调用 `setScreenCaptureScenario` 方法设置屏幕共享场景，按照实际使用场景，将 `screenScenario` 设置为以下任意一种：
- `SCREEN_SCENARIO_DOCUMENT(1)`：文档场景
- `SCREEN_SCENARIO_GAMING(2)`：游戏场景
- `SCREEN_SCENARIO_VIDEO(3)`：视频场景
- `SCREEN_SCENARIO_RDC(4)`：远程控制场景

示例代码如下：
```cpp
m_rtcEngine->setScreenCaptureScenario(type);
```



### 加入频道并发布屏幕共享视频流

调用 `joinChannel`[2/2] 加入频道并设置频道媒体选项。示例代码如下：

```cpp
// 设置频道媒体选项
ChannelMediaOptions option;
option.channelProfile = CHANNEL_PROFILE_LIVE_BROADCASTING;
option.clientRoleType = CLIENT_ROLE_BROADCASTER;
option.publishMicrophoneTrack  = true;
// 在频道中发布屏幕采集的视频
// 如果要在频道中发布第二个屏幕采集的视频，则将下一行代码替换为 option.publishSecondaryScreenTrack = true；
option.publishScreenTrack = true;
// 加入频道
m_rtcEngine->joinChannel("Your Token", "Your ChannelId", 0, option)
```



<div class="alert info">本文以直接在频道中发布屏幕共享流、不发布摄像头采集的流为例，实际应用场景中的发流方式可能跟本文的描述不同，请结合实际应用场景调整你的代码逻辑。例如：

1. 调用 `joinChannel`[2/2] 加入第一个频道，在该频道中发布摄像头采集的视频流。
2. 调用 `joinChannelEx `加入第二个频道，在该频道中发布屏幕共享流。</div>





### (可选) 更新屏幕共享区域或参数

在频道中，你可以调用如下方法动态更新屏幕共享区域或参数：

- 如果你要更新屏幕共享的区域，调用 `updateScreenCaptureRegion` 方法，重新设置 `regionRect` 参数、划定新的共享区域。
- 如果你要更新屏幕共享的参数（例如：视频编码分辨率、帧率、码率；对屏幕或 app 窗口描边；是否屏蔽指定窗口等），调用 `updateScreenCaptureParameters` 方法，更新 `captureParams` 参数的配置。

示例代码如下：

```cpp
// 更新屏幕共享区域
int ret = m_rtcEngine->updateScreenCaptureRegion(rect);

// 更新屏幕共享参数
int ret = m_rtcEngine->updateScreenCaptureParameters(m_screenParam);
```

### (可选) 对屏幕描边

根据实际使用场景，你可以通过以下两种方式对屏幕或窗口进行描边。

- 在开启屏幕共享时描边：调用 `startScreenCaptureByDisplayId`、`startScreenCaptureByWindowId`，将 `captureParams` 中的 `enableHighLight` 设置为 `true`，并同时设置 `highLightColor` 和 `highLightWidth` 来指定描边的颜色和宽度。
- 在开启屏幕共享后描边：调用 `updateScreenCaptureParameters`，将 `captureParams` 中的 `enableHighLight` 设置为 `true`，并同时设置 `highLightColor` 和 `highLightWidth` 来指定描边的颜色和宽度。

```c++
bool highLigne = m_chkHighLight.GetCheck();
m_screenParam.enableHighLight = highLigne;
// 设置屏幕的描边颜色
m_screenParam.highLightColor = 0xFFFF0000;
// 设置屏幕的描边宽度
m_screenParam.highLightWidth = 5;
// 开启屏幕描边
int ret = m_rtcEngine->updateScreenCaptureParameters(m_screenParam);
```



### (可选) 屏蔽窗口

根据实际使用场景，你可以通过以下两种方式屏蔽指定的窗口。

- 在开启屏幕共享时屏蔽窗口：调用 `startScreenCaptureByDisplayId`，将 `captureParams` 中的 `excludeWindowList` 设置为你想要屏蔽的窗口列表。
- `在开启屏幕共享后屏蔽窗口：调用 updateScreenCaptureParameters`，将 `captureParams` 中的 `excludeWindowList` 设置为你想要屏蔽的窗口列表。

```c++
m_screenParam.excludeWindowList = excludeViews;
m_screenParam.excludeWindowCount = count;

int ret = m_rtcEngine->updateScreenCaptureParameters(m_screenParam);
```


<div class="alert info">在 Windows 平台上，你最多可以屏蔽 24 个窗口。</div>

### 停止屏幕共享

调用 `stopScreenCapture`，在频道内停止屏幕共享。示例代码如下：

```c++
// 停止屏幕共享
ret = m_rtcEngine->stopScreenCapture();
```



## 参考信息

介绍关于屏幕共享的更多参考信息。



### 示例项目

我们在 GitHub 提供了一个开源的[示例项目](https://github.com/AgoraIO/API-Examples/blob/main/windows/APIExample/APIExample/Advanced/ScreenShare/AgoraScreenCapture.cpp)，你可以前往下载体验。

### API 参考

- [getScreenCaptureSources](./API%20Reference/windows_ng/API/toc_screen_share.html#api_irtcengine_getscreencapturesources)
- [startScreenCaptureByDisplayId](./API%20Reference/windows_ng/API/toc_screen_share.html#api_irtcengine_startscreencapturebydisplayid)
- [startScreenCaptureByWindowId](./API%20Reference/windows_ng/API/toc_screen_share.html#api_irtcengine_startscreencapturebywindowid)
- [setScreenCaptureScenario](./API%20Reference/windows_ng/API/toc_screen_share.html#api_irtcengine_setscreencapturescenario)
- [updateScreenCaptureParameters](./API%20Reference/windows_ng/API/toc_screen_share.html#api_irtcengine_updatescreencaptureparameters)
- [updateScreenCaptureRegion](./API%20Reference/windows_ng/API/toc_screen_share.html#api_irtcengine_updatescreencaptureregion)
- [stopScreenCapture](./API%20Reference/windows_ng/API/toc_screen_share.html#api_irtcengine_stopscreencapture)