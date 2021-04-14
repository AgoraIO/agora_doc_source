---
title: 原始视频数据
platform: Unity
updatedAt: 2019-12-26 18:59:04
---
## 功能描述

视频传输过程中，我们可以对采集到的视频数据进行前处理和后处理，获取想要的播放效果。

对于有自行处理视频数据需求的场景，Agora 提供原始数据功能，你可以在将数据发送给编码器前进行前处理，对捕捉到的视频帧进行修改；也可以在将数据发送给解码器后进行后处理，对接收到的视频帧进行修改。

Agora Unity SDK 通过提供 `VideoRawDataManager` 类，实现采集、修改原始视频数据功能。

## 实现方法

在使用原始视频数据功能前，请确保你已在项目中完成基本的实时视频功能，详见[实现视频通话](https://docs.agora.io/cn/Video/start_call_unity?platform=Unity)或[实现视频直播](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_unity?platform=Unity)。

参考如下步骤，在你的项目中实现原始视频数据功能：

1. 选择如下任意一种方式注册视频观测器：
   - 在加入频道前，调用 `EnableVideoObserver` 注册视频观测器。此方法通常用于 SDK 采集和渲染。选择此方法后，若需注销视频观测器，确保在离开频道后调用 `DisableVideoObserver`。
   - 调用 `RegisterVideoRawDataObserver` 注册视频观测器。此方法通常用于自采集和渲染。选择此方法后，若需注销视频观测器，调用 `UnRegisterVideoRawDataObserver`。

2. 成功注册后，根据需求调用以下方法：
   - 调用 `SetOnCaptureVideoFrameCallback` 监听 `OnCaptureVideoFrameHandler` 回调。SDK 会在捕捉到每个本地视频帧时通过 `OnCaptureVideoFrameHandler` 回调向用户发送采集到的原始视频数据。
   - 调用 `SetOnRenderVideoFrameCallback` 监听 `OnRenderVideoFrameHandler` 回调。SDK 会在捕捉到每个远端视频帧时通过 `OnRenderVideoFrameHandler` 回调向用户发送接收到的原始视频数据。

3. 用户拿到原始视频数据后，根据场景需要自行处理。
4. 选择如下任意一种方式注销视频观测器：
   - 在离开频道后，调用 `DisableVideoObserver` 注销视频观测器。
   - 调用 `UnRegisterVideoRawDataObserver` 注销视频观测器。
   <div class="alert note">请确保 EnableVideoObserver 和 DisableVideoObserver 配套调用，RegisterVideoRawDataObserver 和 UnRegisterVideoRawDataObserver 配套调用。请勿混合调用，否则会出现未定义行为。</div>

### API 调用时序

下图展示使用原始视频数据的 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1576236749828)

### 示例代码

你可以对照 API 时序图，参考下面的示例代码片段，在项目中实现原始视频数据功能：

```C#
void Start()
{
    // 初始化 IRtcEngine 对象。
    mRtcEngine = IRtcEngine.GetEngine(mVendorKey);
    // 获取 VideoRawDataManager 对象。
    videoRawDataManager = VideoRawDataManager.GetInstance(mRtcEngine);
    // 启用视频模块。
    mRtcEngine.EnableVideo();
    // 启用视频观测器。
    mRtcEngine.EnableVideoObserver();
    // 监听 OnCaptureVideoFrameHandler delegate。
    videoRawDataManager.SetOnCaptureVideoFrameCallback(OnCaptureVideoFrameHandler);
    // 监听 OnRenderVideoFrameHandler delegate。
    videoRawDataManager.SetOnRenderVideoFrameCallback(OnRenderVideoFrameHandler);
}

// 获取远端发送的视频数据。
void OnRenderVideoFrameHandler(uint uid, VideoFrame videoFrame)
{
    Debug.Log("OnRenderVideoFrameHandler");
}

// 获取本地摄像头采集到的视频数据。
void OnCaptureVideoFrameHandler(VideoFrame videoFrame)
{
    Debug.Log("OnCaptureVideoFrameHandler");
}

public enum VIDEO_FRAME_TYPE {
    FRAME_TYPE_YUV420 = 0, 
    FRAME_TYPE_RGBA = 1,
};

public struct VideoFrame {
    // 视频帧类型。仅支持 FRAME_TYPE_RGBA。
    public VIDEO_FRAME_TYPE type;
    // 视频像素宽度。
    public int width; 
    // 视频像素高度。
    public int height; 
    // YUV 数据中的 Y 缓冲区的行跨度。
    public int yStride; 
    // RGBA 数据缓冲区。
    public byte[] buffer; 
    // 在渲染视频前设置该帧的顺时针旋转角度，目前支持 0 度、90 度、180 度，和 270 度。
    public int rotation;
    // 外部音频帧的时间戳。
    public long renderTimeMs;
    // 预留参数。
    public int avsync_type;
};
```



### API 参考

- [EnableVideoObserver](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ace979cd59611a0cc39e13f8ea33c0f7c)
- [DisableVideoObserver](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ace613c4deed4548ee30a80a18a7007df)
- [RegisterVideoRawDataObserver](./API%20Reference/unity/classagora__gaming__rtc_1_1_video_raw_data_manager.html#ad2fddfb037739fdcb5cdd245caeb12f0)
- [UnRegisterVideoRawDataObserver](./API%20Reference/unity/classagora__gaming__rtc_1_1_video_raw_data_manager.html#ad485000862fc71f39889f826f1353ba3)
- [SetOnCaptureVideoFrameCallback](./API%20Reference/unity/classagora__gaming__rtc_1_1_video_raw_data_manager.html#a86b6c82c97dbe94f7a11839506a09109)
- [SetOnRenderVideoFrameCallback](./API%20Reference/unity/classagora__gaming__rtc_1_1_video_raw_data_manager.html#ad7516aa3de9f25b208fe2aa9baf56097)
- [OnCaptureVideoFrameHandler](./API%20Reference/unity/classagora__gaming__rtc_1_1_video_raw_data_manager.html#a7173eb3a85e986f50696732076c811b9)
- [OnRenderVideoFrameHandler](./API%20Reference/unity/classagora__gaming__rtc_1_1_video_raw_data_manager.html#a2ad89cb34bf7ca354ee71a35985bb5c7)

## 开发注意事项

- 调用 `EnableVideoObserver`/`DisableVideoObserver` 后，SDK 会自动调用 `RegisterVideoRawDataObserver`/`UnRegisterVideoRawDataObserver`，无需再次调用。