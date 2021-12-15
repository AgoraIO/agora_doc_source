---
title: 自定义视频采集和渲染
platform: Unity
updatedAt: 2020-07-20 11:57:54
---

## 功能简介

实时视频传输过程中，Agora Unity SDK 通常会启动默认的视频模块进行采集和渲染。在以下场景中，你可能会发现默认的视频模块无法满足开发需求：

- app 中已有自己的视频模块
- 希望使用非 Camera 采集的视频源，如录屏数据
- 需要使用自定义的美颜库有或前处理库
- 某些视频采集设备被系统独占。为避免与其它业务产生冲突，需要灵活的设备管理策略

基于此，Agora Unity SDK 支持使用自定义的视频源或渲染器，实现相关场景。本文介绍如何实现自定义视频采集和渲染。

## 实现方法

在实现自定义视频采集和渲染前，请确保已在你的项目中实现基本的实时视频功能。详见[实现视频通话](https://docs.agora.io/cn/Video/start_call_unity?platform=Unity)或[实现视频直播](https://docs.agora.io/en/Interactive%20Broadcast/start_live_unity?platform=Unity)。

参考如下步骤，在你的项目中实现自定义视频采集和渲染功能：

1. 在 `JoinChannelByKey` 前通过调用 `SetExternalVideoSource` 指定外部视频采集。
2. 指定外部视频源后，开发者自行管理视频数据采集和处理。
3. 完成视频数据处理后，再通过 `PushVideoFrame` 发送给 SDK 进行后续操作。

以通过自定义视频采集和渲染实现屏幕共享为例，需要以下操作：

1. 在 `JoinChannelByKey` 前通过调用 `SetExternalVideoSource` 指定外部视频采集。

   ```C#
   mRtcEngine.SetExternalVideoSource(true, false);
   ```

2. 定义 Texture2D，用 Texture2D 读取屏幕像素，作为外部视频源。

   ```C#
    mRect = new Rect(0, 0, Screen.width, Screen.height);
   mTexture = new Texture2D((int)mRect.width, (int)mRect.height, TextureFormat.RGBA32, false);
   mTexture.ReadPixels(mRect, 0, 0);
   mTexture.Apply();
   ```

3. 通过 `PushVideoFrame` 发送给 SDK，实现屏幕共享。

   ```C#
    int a = rtc.PushVideoFrame(externalVideoFrame);
   ```

### API 调用时序

下图展示使用自定义视频采集和渲染的 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1576236080075)

### 示例代码

参考下文代码在你的项目中自定义视频采集，例如实现屏幕共享。

````C#
```C#
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using agora_gaming_rtc;
using UnityEngine.UI;
using System.Globalization;
using System.Runtime.InteropServices;
using System;

public class ShareScreen : MonoBehaviour
{
Texture2D mTexture;
Rect mRect;
[SerializeField]
private string appId = "Your_AppID";
[SerializeField]
private string channelName = "agora";
public IRtcEngine mRtcEngine;
int i = 100;
void Start()
{
Debug.Log("ScreenShare Activated");
mRtcEngine = IRtcEngine.GetEngine(appId);
// 设置日志输出等级。
mRtcEngine.SetLogFilter(LOG_FILTER.DEBUG | LOG_FILTER.INFO | LOG_FILTER.WARNING | LOG_FILTER.ERROR | LOG_FILTER.CRITICAL);
// 启用视频模块。
mRtcEngine.EnableVideo();
// 启用视频观测器。
mRtcEngine.EnableVideoObserver();
// 配置外部视频源。
mRtcEngine.SetExternalVideoSource(true, false);
// 加入频道。
mRtcEngine.JoinChannel(channelName, null, 0);
// 创建需共享的屏幕区域。
mRect = new Rect(0, 0, Screen.width, Screen.height);
// 创建 Texture。
mTexture = new Texture2D((int)mRect.width, (int)mRect.height, TextureFormat.RGBA32, false);
}

void Update()
{
 shareScreen();
}

// 开始屏幕共享。
void shareScreen()
{
// 读取屏幕像素。
mTexture.ReadPixels(mRect, 0, 0);
// 应用像素。
mTexture.Apply();
// 获取 Raw Texture 并将其应用到字节数组中。
byte[] bytes = mTexture.GetRawTextureData();
// 为字节数组提供足够的空间。
int size = Marshal.SizeOf(bytes[0]) * bytes.Length;
// 查询是否存在 IRtcEngine 实例。
IRtcEngine rtc = IRtcEngine.QueryEngine();

if (rtc != null)
{
// 创建外部视频帧。
ExternalVideoFrame externalVideoFrame = new ExternalVideoFrame();
// 设置视频帧 buffer 类型。
externalVideoFrame.type = ExternalVideoFrame.VIDEO_BUFFER_TYPE.VIDEO_BUFFER_RAW_DATA;
// 设置像素格式。
externalVideoFrame.format = ExternalVideoFrame.VIDEO_PIXEL_FORMAT.VIDEO_PIXEL_UNKNOWN;
// 应用原始数据。
externalVideoFrame.buffer = bytes;
// 设置视频帧宽度（pixel）。
externalVideoFrame.stride = (int)mRect.width;
// 设置视频帧高度（pixel）。
externalVideoFrame.height = (int)mRect.height;
// 设置从哪侧移除视频帧的像素。
externalVideoFrame.cropLeft = 10;
externalVideoFrame.cropTop = 10;
externalVideoFrame.cropRight = 10;
externalVideoFrame.cropBottom = 10;
// 设置视频帧旋转角度： 0、90、180 或 270。
externalVideoFrame.rotation = 180;
// 使用视频时间戳增加 i。
externalVideoFrame.timestamp = i++;
// 推送外部视频帧。
int a = rtc.PushVideoFrame(externalVideoFrame);
}
}
}
````

### API 参考

- SetExternalVideoSource
- PushVideoFrame
