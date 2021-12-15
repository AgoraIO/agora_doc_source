---
title: 调用 API 录制
platform: Linux
updatedAt: 2020-04-29 16:42:58
---

本文介绍如何调用 API 进行通话或直播录制。

开始前请确保你已经完成[集成录制 SDK](/cn/Recording/recording_integrate_cpp)。

## 创建实例

```c++
IRecordingEngineEventHandler *handler = <prepare>
	IRecordingEngine* engine = createAgoraRecordingEngine(<APPID>, handler)
```

在加入频道进行录制之前，需要调用 [`createAgoraRecordingEngine`](./API%20Reference/recording_cpp/classagora_1_1recording_1_1_i_recording_engine.html#a683b055963f285fa0ca63aaab7af27d6) 方法创建一个录制实例，并将其与应用程序相关联。可根据需要创建多个实例同时录制。在该方法中你需要传入与 Agora Native/Web SDK 相同的 App ID。

## 开始录制

```c++
RecordingConfig config = {<prepare>}
engine->joinChannel(<channelKey>, <channelId>, <uid>, config)
```

创建实例后，调用 [`joinChannel`](./API%20Reference/recording_cpp/classagora_1_1recording_1_1_i_recording_engine.html#a011ff5c4a47816050be60b26ba0fb431) 方法加入频道开始录制，在该方法中需要填写如下参数：

- `channelKey`：如果待录制的频道使用了 token，你需要在该参数中传入 token。详见[校验用户权限](./token#Token)。

- `channelId`：待录制频道的频道名，必填。

- `uid`：录制使用的用户 ID，32 位无符号整数，取值范围 1 到 (2<sup>32</sup>-1)，需保证唯一性，必填。

- `config`：配置录制参数，选填，如不填则使用默认配置。详见[`RecordingConfig`](./API%20Reference/recording_cpp/structagora_1_1recording_1_1_recording_config.html#a511201f4e63f0fae5ef416fb98cb49af)。

在默认情况下，录制实例加入频道后，监测到频道内有用户即开始录制。

如果你在 `RecordingConfig` 中将 [`triggerMode`](./API%20Reference/recording_cpp/namespaceagora_1_1linuxsdk.html#a652d8aefc1931391ff65ae7a088b932f) 设为了 `MANUALLY_MODE`（手动模式），需要调用 [startService](./API%20Reference/recording_cpp/classagora_1_1recording_1_1_i_recording_engine.html#a2d4e78e4164993e64fb0286b9108d478) 开始录制，开始录制后可以调用 [`stopService`](./API%20Reference/recording_cpp/classagora_1_1recording_1_1_i_recording_engine.html#a302a83737a67b2693ede181484af862a) 暂停录制。

```c++
engine->startService()
engine->stopService()
```

> `startService` 和`stopService` 必须在加入频道之后调用。

## 获取录制文件路径

```c++
RecordingEngineProperites ps = engine->getProperties()
```

加入频道后可以调用 [`getProperties`](./API%20Reference/recording_cpp/classagora_1_1recording_1_1_i_recording_engine.html#abf1bcd2dd5a38262ca26e50b3b182f4b) 方法获取录制文件的存放路径。

## 结束录制

```c++
engine->leaveChannel()
```

录制完成后，调用 [`leaveChannel`](./API%20Reference/recording_cpp/classagora_1_1recording_1_1_i_recording_engine.html#adafb45815ad0f02dc1c8b3cadb7cd2e3) 方法离开频道，停止录制。

> 录制结束后如果需要再次开始录制，必须重新创建实例。

在默认情况下，当频道空闲（无用户）超过 300 秒（在 `RecordingConfig` 中的 [`idleLimitSec`](https://docs.agora.io/cn/Recording/API%20Reference/recording_cpp/structagora_1_1recording_1_1_recording_config.html#aca9710dfdb0596c88f26e3c1c3daf48b) 可以设置该时间）后，录制实例也会自动退出频道停止录制。

## 释放资源

```c++
engine->release()
```

待录制完成后，你需要调用 [`release`](./API%20Reference/recording_cpp/classagora_1_1recording_1_1_i_recording_engine.html#af4d33159ed8ed249991470e6833d0fd5) 方法销毁录制实例，释放 SDK 使用的资源，释放资源后将无法再次使用和回调 SDK 内的其它方法。如需再次使用本地服务端录制，必须重新创建实例。

> `release` 方法不能在回调线程中调用。

## 相关文档

本文仅介绍了实现录制最基本的方法，你可以参考下面的文档实现更多的功能和设置：

- 选择录制模式：你可以选择分别录制每个用户的音频和视频或者将所有用户的音视频混合录制。
- 自定义合流布局：在合流模式录制视频时，你需要设置合流布局。
- 视频截图：录制时对每个用户的画面进行截图。
- 管理录制文件：查看和管理录制生成的文件。
- 使用转码脚本：使用我们提供的脚本将录制得到的多个音视频文件合成为一个文件。
