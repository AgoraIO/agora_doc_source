---
title: 实现媒体流传输
platform: Linux
updatedAt: 2021-02-08 07:44:14
---

## 概览

本文介绍在你自己的应用程序中通过集成 Agora RTSA Pro SDK 来实现发送和接收 PCM 格式的音频流和 H.264 格式的视频流的基本流程，以及集成过程中的一些注意事项。

阅读本文前，我们建议你先根据以下两篇文档编译并运行 RTSA 示例项目，体验媒体流的发送和接收：

- [RTSA 2.1.0 跑通示例项目（Linux C++）](./rtsa_run_demo_linux_cpp)
- [RTSA 2.1.0 跑通示例项目（Android C++）](./rtsa_run_demo_android_cpp)

## 集成基本流程

### 1. 进行认证

RTSA 通过 License 对设备鉴权。License 与设备绑定，一个 License 在同一时间只能绑定一个设备。

在体验阶段，你可以[申请免费的 License](./rtsa_run_demo_linux_cpp#apply-license)。申请成功后，你可以得到 10 个免费的体验 License，时效为 6 个月。

获取到免费 License 后，你需要[激活 License](./rtsa_run_demo_linux_cpp#activate-license)，得到一个许可证 Certificate 和一个凭证 Credential。

调用 RTSA 的其他 API 前，你需要调用 `setAgoraLicenseCallback` 方法设置 License 相关回调，再调用 getAgoraCertificateVerifyResult 方法传入许可证 Certificate 和相应长度以及凭证 Credential 和相应长度。

示例代码请参考 SDK 包 `example/common/sample_common.cpp` 文件。

### 2. 全局初始化

首先，你需要在你的应用程序里调用 `createAgoraService` 和 `initialize` 进行全局初始化，创建并初始化 `AgoraService` 对象。

这个操作只需要进行一次，`AgoraService` 对象的生命期和应用程序的生命期保持一致，只要应用程序没有退出，`AgoraService` 可以一直存在。

**示例代码**

```
// Create an AgoraService object
auto service = createAgoraService();

agora::base::AgoraServiceConfiguration scfg;
scfg.enableAudioProcessor = true;
scfg.enableAudioDevice = false;
scfg.enableVideo = true;
scfg.useStringUid = false;

// Initialize the AgoraService object
service->initialize(scfg);
```

<div class="alert note">如果你需要使用 String 型用户名，则将 <code>useStringUid</code> 设为 <code>true</code>。请确保发送端和接收端行为一致。</div>

### 3. 建立连接

初始化后，根据以下步骤让本地 `AgoraService` 对象与声网服务器建立连接。

1. 调用 `createRtcConnection` 创建 `IRtcConnection` 对象，用于与声网服务器建立连接。
2. 创建 `IRtcConnectionObserver` 对象（即示例代码中的 `SampleConnectionObserver` 对象），用于监测连接事件。然后通过 `registerObserver` 方法将 `IRtcConnectionObserver` 对象和 `IRtcConnection` 对象关联起来。
3. 调用 `connect` 与声网服务器建立连接。

**示例代码**

```
// Create an IRtcConnection object
agora::rtc::RtcConnectionConfiguration ccfg;
ccfg.autoSubscribeAudio = false;
ccfg.autoSubscribeVideo = false;
ccfg.clientRoleType = agora::rtc::CLIENT_ROLE_BROADCASTER;
agora::agora_refptr<agora::rtc::IRtcConnection> connection = service->createRtcConnection(ccfg);
if (!connection) {
  AG_LOG(ERROR, "Failed to create Agora connection!");
  return -1;
}

// Register a connection observer to monitor connection events and link the connection observer with the IRtcConnection object
auto connObserver = std::make_shared<SampleConnectionObserver>();
connection->registerObserver(connObserver.get());

// Connect to Agora servers
if (connection->connect(options.appId.c_str(), options.channelId.c_str(),
                        options.userId.c_str())) {
  AG_LOG(ERROR, "Failed to connect to Agora server!");
  return -1;
}
```

### 4. 媒体流传输准备

与声网服务器建立连接后，根据你是发送还是接收媒体流，再分别进行以下操作。

#### **媒体流发送准备**

1. 创建 `IAudioPcmDataSender` 对象和 `IVideoEncodedImageSender` 对象，分别用于发送 PCM 格式的音频流和 H.264 格式的视频流。
2. 创建 `ILocalAudioTrack` 对象和 `ILocalVideoTrack` 对象，分别对应即将发布至频道内的本地音频轨道和本地视频轨道。
3. 通过 `ILocalUser` 对象的 `publish` 相关方法发布上一步创建的本地音频轨道和视频轨道。

**示例代码**

```
// Create an audio frame sender
agora::agora_refptr<agora::rtc::IAudioPcmDataSender> audioFrameSender =
    factory->createAudioPcmDataSender();
if (!audioFrameSender) {
  AG_LOG(ERROR, "Failed to create audio data sender!");
  return -1;
}

// Create an audio track
agora::agora_refptr<agora::rtc::ILocalAudioTrack> customAudioTrack =
    service->createCustomAudioTrack(audioFrameSender);
if (!customAudioTrack) {
  AG_LOG(ERROR, "Failed to create audio track!");
  return -1;
}

// Create a video frame sender
agora::agora_refptr<agora::rtc::IVideoEncodedImageSender> videoFrameSender =
    factory->createVideoEncodedImageSender();
if (!videoFrameSender) {
  AG_LOG(ERROR, "Failed to create video frame sender!");
  return -1;
}

agora::base::SenderOptions option;
option.ccMode = agora::base::CC_ENABLED;

// Create a video track
agora::agora_refptr<agora::rtc::ILocalVideoTrack> customVideoTrack =
    service->createCustomVideoTrack(videoFrameSender, option);
if (!customVideoTrack) {
  AG_LOG(ERROR, "Failed to create video track!");
  return -1;
}

// Publish the audio and video tracks
connection->getLocalUser()->publishAudio(customAudioTrack);
connection->getLocalUser()->publishVideo(customVideoTrack);
```

#### **媒体流接收准备**

1. 创建 `ILocalUserObserver` 对象（即示例代码中的 `SampleLocalUserObserver` 对象）。
2. 注册音频帧观测器和视频帧观测器，分别对应 PCM 帧和 H.264 帧的回调。在收到远端的媒体帧时，SDK 会触发 `onPlaybackAudioFrameBeforeMixing` 和 `OnEncodedVideoImageReceived` 回调。具体请参考 `sample_receive_h264_pcm.cpp` 中关于 `SampleLocalUserObserver` 的使用以及 `PcmFrameObserver` 和 `H264FrameReceiver` 的实现。

**示例代码**

```
// Create a local user observer
auto localUserObserver = std::make_shared<SampleLocalUserObserver>(connection->getLocalUser());

// Register a PCM audio frame observer to receive the audio stream
auto pcmFrameObserver = std::make_shared<PcmFrameObserver>(options.audioFile);
localUserObserver->setAudioFrameObserver(pcmFrameObserver.get());

// Register an H.264 video frame observer to receive the video stream
auto h264FrameReceiver = std::make_shared<H264FrameReceiver>(options.videoFile);
localUserObserver->setVideoEncodedImageReceiver(h264FrameReceiver.get());
```

### 5. 发送媒体流

一般情况下，当音频编码器和视频编码器完成一帧数据的编码后，会以回调的方式通知应用程序。你需要在提示编码完成的回调函数中添加发送媒体流的逻辑。每次收到提示编码完成的回调，都需要触发 `sendAudioPcmData` 和 `sendEncodedVideoImage` 方法的调用，分别用于发送音频帧和视频帧。换言之，你不需要单独创建一个线程用于发流，直接在编码器的输出回调里进行发流即可。

- 对于音频帧，调用 `sendAudioPcmData` 方法时，你需要传入 `samplesPer10ms`（每 10 毫秒的 sample 个数）、`sampleSize`（每个 sample 的大小）、`numOfChannels` 和 `sampleRate` 这四个参数。目前 RTSA 每次只能发送 10 毫秒的 PCM 数据。
- 对于视频帧，你需要通过 `sendEncodedVideoImage` 方法的 `imageBuffer` 和 `length` 参数，传入相应编码帧的起始地址和字节长度。

**示例代码**

```
// Send one PCM frame
int sampleSize = sizeof(int16_t) * numOfChannels;
int samplesPer10ms = sampleRate / 100;
if (audioFrameSender->sendAudioPcmData(pcmDataBuf, 0, samplesPer10ms, sampleSize,
                                       numOfChannels,
                                       sampleRate) < 0) {
  AG_LOG(ERROR, "Failed to send audio frame!");
}

// Send one H264 frame
agora::rtc::EncodedVideoFrameInfo videoEncodedFrameInfo;
videoEncodedFrameInfo.rotation = agora::rtc::VIDEO_ORIENTATION_0;
videoEncodedFrameInfo.codecType = agora::rtc::VIDEO_CODEC_H264;
videoEncodedFrameInfo.framesPerSecond = frameRate;
videoEncodedFrameInfo.frameType = isKeyFrame ? agora::rtc::VIDEO_FRAME_TYPE::VIDEO_FRAME_TYPE_KEY_FRAME
                                 : agora::rtc::VIDEO_FRAME_TYPE::VIDEO_FRAME_TYPE_DELTA_FRAME);

videoH264FrameSender->sendEncodedVideoImage(h264DataBuffer, h264DataLen, videoEncodedFrameInfo);
```

### 6. 接收媒体流

在步骤 2 中，如果你已经创建了 `ILocalUserObserver` 对象并注册了音频帧观测器和视频帧观测器，那么当 SDK 触发 `onPlaybackAudioFrameBeforeMixing` 或 `OnEncodedVideoImageReceived` 回调时，意味着收到了一个音频帧或视频帧。你需要在这两个回调函数中添加接收媒体流的逻辑，比如将视频帧推送到视频解码器进行解码。

**示例代码**

```
// Callback to receive a PCM frame
bool PcmFrameObserver::onPlaybackAudioFrameBeforeMixing(unsigned int uid, AudioFrame& audioFrame) {
  int audioSize = audioFrame.samplesPerChannel * audioFrame.channels * sizeof(int16_t);
  // Send PCM samples of audioSize to the audio renderer
  return true;
}

// Callback to receive an H.264 frame
bool H264FrameReceiver::OnEncodedVideoImageReceived(
    const uint8_t* imageBuffer, size_t length,
    const agora::rtc::EncodedVideoFrameInfo& videoEncodedFrameInfo) {
  // Send imageBuffer to the video decoder
  return true;
}
```

### 7. 断开连接

媒体流传输完成后，你可以通过以下步骤取消发布并断开与声网服务器的连接：

1. 调用 `unpublish` 相关方法取消发布音频流和视频流。
2. 调用 `disconnect` 断开与声网服务器的连接。
3. 注销 `IRtcConnection` 对象相关的资源。

<div class="alert note">建议按照示例代码中的顺序释放资源，否则可能报错。</div>

**示例代码**

```
// Unpublish the audio and video tracks
connection->getLocalUser()->unpublishAudio(customAudioTrack);
connection->getLocalUser()->unpublishVideo(customVideoTrack);

// Disconnect from Agora servers
if (connection->disconnect()) {
  AG_LOG(ERROR, "Failed to disconnect from Agora channel!");
  return -1;
}
AG_LOG(INFO, "Disconnected from Agora channel successfully");

// Destroy the IRtcConnection object and release related resources
connObserver.reset();
audioFrameSender = nullptr;
videoFrameSender = nullptr;
customAudioTrack = nullptr;
customVideoTrack = nullptr;
factory = nullptr;
connection = nullptr;
```

### 8. 全局注销

当你的应用程序退出时，可以调用如下逻辑，注销整个 `AgoraService`。

**示例代码**

```
service->release();
service = nullptr;
```

## 进阶功能

### 自适应码率

在 `sample_send_h264_pcm.cpp` 示例项目中，`IRtcConnectionObserver` 对象同时也用于网络事件监测。该对象中的
`onBandwidthEstimationUpdated` 回调会给出目标码率值 `video_encoder_target_bitrate_bps`。你需要根据该参数的值及时调整视频编码器的输出码率，以避免码率超发带来的网络拥塞和视频卡顿。

**示例代码**

```
void SampleConnectionObserver::onBandwidthEstimationUpdated(const agora::rtc::NetworkInfo& info) {
  AG_LOG(INFO, "onBandwidthEstimationUpdated: video_encoder_target_bitrate_bps %d\n",
         info.video_encoder_target_bitrate_bps);
  // Adjust the sending bitrate of your encoder according to the value of the target bitrate
}
```

### 响应关键帧请求

在 `sample_send_h264_pcm.cpp` 示例项目的 `SampleLocalUserObserver` 类中实现了 `onIntraRequestReceived` 回调。当 RTSA 作为发送端时，如果出现以下两种情况之一：1. 接收端比发送端后加入频道，2. 网络状况不佳导致丢帧，发送端会触发 `onIntraRequestReceived` 回调。一般情况下，你需要在该回调函数中发送命令给编码器，让编码器立即产生一个关键帧。如果不这样做，接收端可能因为缺少可以解码的帧而陷入长时间的黑屏。

**示例代码**

```
void SampleLocalUserObserver::onIntraRequestReceived() {
  AG_LOG(INFO, "onIntraRequestReceived");
  // Notify the encoder to generate an intra frame immediately
}
```

## 其他注意事项

以上所有接口函数，如无特殊说明，都是异步调用，无需担心阻塞用户线程。
