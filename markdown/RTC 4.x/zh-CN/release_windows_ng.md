##  v4.1.1 版

 该版本于 2023 年 1 月 xx 日发布。


 #### 升级必看

 自该版本起，SDK 对视频编码的算法进行了优化，将默认的视频编码分辨率从 640 × 360 提升为 960 × 540，以适应设备性能和网络带宽的提升，在各种音视频互动场景下，为用户提供全链路的高清体验。

 如果你想自定义视频编码分辨率，可调用 `setVideoEncoderConfiguration` 方法，重新设置视频编码参数配置中的视频编码分辨率。

<div class="note">由于默认分辨率的提升，会影响集合分辨率从而导致费用变更。详见<a href="./billing_rtc_ng">计费说明</a>。</div>

 #### 新增特性

 **1. 快速出图出声**

 该版本新增 `enableInstantMediaRendering` 方法，用于开启音视频帧的加速渲染模式，可加快用户加入频道后的首帧出图与出声速度。

 **2. 视频渲染数据打点**

 该版本新增 `startMediaRenderingTracing` 和 `startMediaRenderingTracingEx` 方法，SDK 以调用该方法的时刻作为起点，开始跟踪频道内视频帧的渲染状态，并通过 `onVideoRenderingTracingResult` 回调报告相关事件的信息。

 声网推荐你将该方法和 app 中的 UI 设置（按钮、滑动条等）结合使用。例如：在终端用户点击“加入频道”按钮的时刻调用该方法进行打点，然后通过 `onVideoRenderingTracingResult` 回调获取视频帧渲染过程中的指标，从而方便开发者针对指标进行专项优化，以提高出图效率。



 #### 改进

 **视频观测器**

 自该版本起，SDK 对 `onRenderVideoFrame` 回调进行了优化，在不同的视频处理模式下返回值的意义不同：

 - 当视频处理模式为 `PROCESS_MODE_READ_ONLY` 时，返回值无实际含义。
 - 当视频处理模式为 `PROCESS_MODE_READ_WRITE` 时，返回 `true` 代表设置 SDK 接收视频帧；返回 `false` 代表设置 SDK 丢弃视频帧。

 #### 问题修复

 该版本修复了以下问题：

 - 使用媒体播放器播放网络摄像头的 RTSP 码流时，偶现花屏。
 - 使用媒体播放器播放采样率超过 48 kHz 的音频时，播放失败。
 - 在本地合图场景下，不支持对 PNG 和 GIF 图片的 Alpha 通道渲染，导致透明底色的图片显示为非透明底色。
 - 加入频道后添加水印然后删除，远端仍能看到水印。
 - 开始屏幕共享后添加水印，远端接收的屏幕共享画面没有水印。
 - 加入频道后接入外接摄像头，调用 `setDevice` 指定视频采集设备为该外接摄像头，方法未生效。
 - 在屏幕共享场景下，如果将一个窗口设置为前置和描边，则必现窗口前置失败。
 - 当频道内有多路视频流时，调用部分视频增强插件相关 API 偶现失败。

 #### API 变更

 **新增**

 - `enableInstantMediaRendering`
 - `startMediaRenderingTracing`
 - `startMediaRenderingTracingEx`
 - `onVideoRenderingTracingResult`
 - `MEDIA_RENDER_TRACE_EVENT`
 - `VideoRenderingTracingInfo`

 **删除**

 - `enableRemoteSuperResolution`
 - `RemoteVideoStats` 中删除 `superResolutionType`