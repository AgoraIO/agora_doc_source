---
title: Web SDK 3.x 版本文档
platform: Web
updatedAt: 2021-01-07 10:07:11
---
本页提供 **Agora Web SDK 3.x 及之前版本**的文档链接。

## 快速开始

| 文档 | 详情 | 
| ---------------- | ---------------- | 
| [跑通视频通话示例项目](https://docs.agora.io/cn/Video/run_demo_video_call_web?platform=Web)      | 快速跑通一对一视频通话示例项目，体验 Agora 视频通话效果。      | 
| [跑通视频直播示例项目](https://docs.agora.io/cn/Interactive%20Broadcast/run_demo_live_web?platform=Web)      | 快速跑通视频互动直播示例项目，体验 Agora 视频互动直播效果。      | 
| [实现语音通话](https://docs.agora.io/cn/Voice/start_call_audio_web?platform=Web)      | 快速集成 Agora Web SDK 并实现实时语音通话。      | 
| [实现视频通话](https://docs.agora.io/cn/Video/start_call_web?platform=Web)      | 快速集成 Agora Web SDK 并实现实时音视频通话。      | 
| [实现音频直播](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_audio_web?platform=Web)      | 快速集成 Agora Web SDK 并实现音频互动直播。      | 
| [实现视频直播](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_web?platform=Web)      | 快速集成 Agora Web SDK 并实现音视频互动直播。      | 

## 基础功能

| 文档 | 详情 | 
| ---------------- | ---------------- | 
| [使用云代理服务](./cloud_proxy_web?platform=Web)      | 通过 Agora 云代理实现内网访问 Agora 服务。     | 
| [通话前检测网络质量](./lastmile_quality_web?platform=Web)     | 在加入频道前进行网络质量检测确保通信顺畅。      | 
| [测试音视频设备](./test_switch_device_web?platform=Web)      | 在加入频道前检测麦克风、摄像头等音视频设备能否正常工作。     | 
| [频道连接状态管理](./channel_connection_web?platform=Web)      | 介绍 Agora 频道如何判断用户的连接状态以及各状态的转变过程。      | 
| [调整通话音量](./volume_web?platform=Web)      | 对 SDK 采集到的声音及 SDK 播放到声卡的声音进行音量调整。      | 
| [设置音频属性](./audio_profile_web?platform=Web)      | 根据场景需求灵活配置音频属性，如采样率、码率和编码模式。      | 
| [设置视频属性](./video_profile_web?platform=Web)      | 根据终端用户喜好灵活配置视频属性，如分辨率、帧率、码率、方向。     | 
| [屏幕共享](./screensharing_web?platform=Web)      | 将主播的屏幕内容分享给观众观看。      | 

## 进阶功能

| 文档 | 详情 | 
| ---------------- | ---------------- | 
| [通话中质量监测](./in-call_quality_web?platform=Web)      | 获取通话质量相关的统计数据。      | 
| [媒体流加密](./channel_encryption_web?platform=Web)      | 使用 SDK 内置的加密方案对媒体流进行加密，从而保障用户的数据安全。      | 
| [播放音效与混音文件](./audio_effect_mixing_web?platform=Web)      | 播放自定义的音效或音乐文件。      | 
| [自定义音频采集](./custom_audio_web?platform=Web)      | 当 SDK 默认的音频模块无法满足需求时，实现自定义音频采集。     | 
| [自定义视频采集](./custom_video_web?platform=Web)      | 当 SDK 默认的视频模块无法满足需求时，实现自定义的视频采集。      | 
| [跨直播间连麦](./media_relay_web?platform=Web)      | 将主播的媒体流同时转发进多个直播频道。     | 
| [推流到 CDN](./cdn_streaming_web?platform=Web)      | 将主播的媒体流发布到 CDN (Content Delivery Network)。      | 
| [输入在线媒体流](./inject_stream_web?platform=Web)      | 将正在播放的音视频作为一个发送端输入正在进行的直播房间。     | 
| [媒体流回退](./fallback_web?platform=Web)      | 网络条件差时，SDK 自动将视频流从大流切换为小流，或将媒体流回退为音频流。      | 
| [H5 实时直播](./web_in_app?platform=Web)      | H5 实时直播组件，支持在移动端网页播放音视频流。      | 
| [限定访问区域](./region_web_rtc?platform=Web)      | 将音视频和消息数据传输限定在某一区域范围内。      | 

## 最佳实践

| 文档 | 详情 | 
| ---------------- | ---------------- | 
| [多人视频场景](./multi_user_web_video?platform=Web)      | 多人视频通话或直播的 SDK 集成方式以及集成注意事项。      | 
| [处理浏览器的自动播放策略](./autoplay_policy_web?platform=Web)      | 解除浏览器的 Autoplay 限制。     | 

## 参考文档
| 文档 | 详情 | 
| ---------------- | ---------------- | 
| [API 参考](./API%20Reference/web/index.html)      | Web SDK API 的详细信息。      | 
| [错误码](./API%20Reference/web/index.html#error-codes)      | SDK 可能抛出的错误及相应的处理方式。      | 
| [警告码](./API%20Reference/web/index.html#warning-codes)      | SDK 可能抛出的警告信息。      | 