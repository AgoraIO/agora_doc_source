---
title: 云端录制 C++ API (Deprecated)
platform: All Platforms
updatedAt: 2019-12-17 18:38:30
---

| **接口类**                                                      | **描述**                   |
| --------------------------------------------------------------- | -------------------------- |
| <a href="#ICloudRecorder">ICloudRecorder</a> 类                 | 应用程序调用的主要方法。   |
| <a href="#ICloudRecorderObserver">ICloudRecorderObserver</a> 类 | 向应用程序发送的回调通知。 |

<a name = "ICloudRecorder"></a>

## ICloudRecorder 接口类

该接口类包含应用程序调用的主要方法：

- [创建云端录制实例 (CreateCloudRecorderInstance)](#CreateCloudRecorderInstance)
- [开始云端录制 (StartCloudRecording)](#StartCloudRecording)
- [结束云端录制 (StopCloudRecording)](#StopCloudRecording)
- [释放资源 (Release)](#Release)

<a name = "CreateCloudRecorderInstance"></a>

### 创建云端录制实例 (CreateCloudRecorderInstance)

```c++
ICloudRecorder* CreateCloudRecorderInstance(ICloudRecorderObserver *observer);
```

该方法创建云端录制实例。

| 参数       | 描述                                                                                                      |
| ---------- | --------------------------------------------------------------------------------------------------------- |
| `observer` | 云端录制 SDK 所触发的事件通过 <a href="#ICloudRecorderObserver">ICloudRecorderObserver</a> 通知应用程序。 |

<a name = "StartCloudRecording"></a>

### 开始云端录制 (StartCloudRecording)

```c++
virtual int StartCloudRecording(
   const char* appId,
   const char* channel_name,
   const char* token,
   const uid_t uid,
   const RecordingConfig& recording_config,
   const CloudStorageConfig &storage_config) = 0;
```

该方法创建录制资源并让 Cloud Recording SDK 加入频道，随后开始录制。

| 参数               | 描述                                                                                    |
| ------------------ | --------------------------------------------------------------------------------------- |
| `appId`            | 待录制频道的 App ID，详见<a href="/cn/Recording/token#-App-ID">获取 App ID</a>。        |
| `channel_name`     | 待录制频道的频道名。                                                                    |
| `token`            | 待录制的频道中使用的 token，详见<a href="/cn/Recording/token#Token">校验用户权限</a>。  |
| `uid`              | 录制使用的用户 ID，保证唯一性。                                                         |
| `recording_config` | 录制的详细设置，详见下表 <a href="#RecordingConfig">RecordingConfig</a>。               |
| `storage_config`   | 第三方云存储的详细设置，详见下表 <a href="#CloudStorageConfig">CloudStorageConfig</a>。 |

<br>
返回值：   
<li> 0：方法调用成功。</li>
<li> ≠ 0：方法调用失败。</li>

<a name = "RecordingConfig"></a>

<br>
`RecordingConfig` 结构如下：

```c++
  RecordingConfig() :
    recording_stream_types(kStreamTypeAudioVideo),
    decryption_mode(kModeNone),
    secret(0),
    channel_type(kChannelTypeCommunication),
    audio_profile(kAudioProfileMusicStandard),
    video_stream_type(kVideoStreamTypeHigh),
    max_idle_time(30) {
   }
```

| 参数                     | 描述                                                                                                                                                                                                                                                                                                                                                |
| ------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `recording_stream_types` | 录制的媒体流类型：<li>`kStreamTypeAudioVideo`：录制音频和视频（默认）。<li>`kStreamTypeAudioOnly`：仅录制音频。<li>`kStreamTypeVideoOnly`：仅录制视频。                                                                                                                                                                                             |
| `decryption_mode`        | 解密方案。云端录制 SDK 可以启用内置的解密功能。解密方式必须与频道设置的加密方式一致。<li>`kModeNone`：无（默认）。<li>`kModeAes128Xts`：设置 AES128XTS 解密方案。<li>`kModeAes128Ecb`：设置 AES128ECB 解密方案。<li>`kModeAes256Xts`：设置 AES256XTS 解密方案。                                                                                     |
| `secret`                 | 启用解密模式后，设置的解密密码。                                                                                                                                                                                                                                                                                                                    |
| `channel_type`           | 频道模式。<li>`kChannelTypeCommunication`：通信模式（默认），即常见的 1 对 1 单聊或群聊，频道内任何用户可以自由说话。 <li>`kChannelTypeLive`：直播模式，有两种用户角色，主播和观众，只有主播可以自由发言。 <p>**频道模式必须与 Agora Native/Web SDK 一致，否则可能导致问题。**                                                                      |
| `audio_profile`          | 设置音频采样率，码率，编码模式和声道数。<li>`kAudioProfileMusicStandard`：指定 48 KHz 采样率，音乐编码, 双声道，编码码率约 56 Kbps（默认）。 <li>`kAudioProfileMusicHighQuality`：指定 48 KHz 采样率，音乐编码, 单声道，编码码率约 128 Kbps。<li>`kAudioProfileMusicHighQualityStereo`：指定 48 KHz 采样率，音乐编码, 双声道，编码码率约 192 Kbps。 |
| `video_stream_type`      | 视频流类型。<li>`kVideoStreamTypeHigh`：视频大流（默认），即高分辨率高码率的视频流。<li>`kVideoStreamTypeLow`：视频小流，即低分辨率低码率的视频流。                                                                                                                                                                                                 |
| `max_idle_time`          | 最长空闲频道时间。默认值为 30 秒，如果频道内无用户的状态持续超过该时间，录制程序会自动退出。若设置为 0，则使用默认值。                                                                                                                                                                                                                              |
| `transcoding_config`     | 视频转码的详细设置，详见 <a href="#TranscodingConfig">TranscodingConfig</a>。                                                                                                                                                                                                                                                                       |

<a name = "TranscodingConfig"></a>
<br>
`TranscodingConfig` 结构如下：

```c++
TranscodingConfig() :
width(360),
height(640),
fps(15),
bitrate(500),
max_resolution_uid(0),
layout(kMixedVideoLayoutTypeFloat) {
}
```

| 参数                 | 描述                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `width`              | 合图宽度，默认值为 360。                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `height`             | 合图高度，默认值为 640。                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `fps`                | 视频帧率，默认值为 15。                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `bitrate`            | 视频码率，默认值为 500。                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `max_resolution_uid` | 如果 `layout` 设为垂直布局，用该参数设置显示大流画面的用户 ID。                                                                                                                                                                                                                                                                                                                                                                                                                      |
| `layout`             | 视频合图布局。<li>`kMixedVideoLayoutTypeFloat`：默认布局。<li>`kMixedVideoLayoutTypeBestFit`：自适应布局。根据录制画面的数量自动调整每个画面的大小，每个画面大小一致，最多支持 17 个录制画面。![](https://web-cdn.agora.io/docs-files/1547544528138)<li>`kMixedVideolayoutTypeVertical`：垂直布局。指定一个 uid 在屏幕左侧显示大流画面，其他用户的小流画面在右侧垂直排列，最多两列，一列 8 个画面，最多支持共 17 个录制画面。 ![](https://web-cdn.agora.io/docs-files/1547544539933) |

<a name = "CloudStorageConfig"></a>
<br>

`CloudStorageConfig` 结构如下：

```
struct CloudStorageConfig {
  CloudStorageVender vender;
  unsigned int region;
  char* bucket;
  char* access_key;
  char* secret_key;
};
```

| 参数         | 描述                                   |
| ------------ | -------------------------------------- |
| `vender`     | 第三方云存储，目前仅支持七牛云和 AWS。 |
| `region`     | 第三方云存储指定的地区信息。           |
| `bucket`     | 第三方云存储 bucket。                  |
| `access_key` | 第三方云存储 access key。              |
| `secret_key` | 第三方云存储 secret key。              |

<a name = "StopCloudRecording"></a>

### 结束云端录制 (StopCloudRecording)

```c++
virtual int StopCloudRecording() = 0;
```

该方法手动结束云端录制。若未调用该方法，当频道空闲（无用户）超过预设时间（默认为 30 秒） 后，Cloud Recording SDK 会自动退出频道停止录制。

<br>
返回值：   
<li> 0：方法调用成功。</li>
<li> ≠ 0：方法调用失败。</li>

<a name = "Release"></a>

### 释放资源(Release)

```c++
virtual void Release(bool keepRecordingInBackground = false) = 0;
```

该方法销毁 ICloudRecorder 实例，释放 Agora Cloud Recording SDK 使用的资源，用户将无法再次使用和回调该 SDK 内的其它方法。如需再次使用云端录制，必须重新创建 ICloudRecorder 实例。

| 参数                        | 描述                                                                                                     |
| --------------------------- | -------------------------------------------------------------------------------------------------------- |
| `keepRecordingInBackground` | 是否在服务器后台进行录制：<li>True：在服务器后台继续进行录制并上传。<li>False：停止录制与上传 （默认）。 |

<a name = "ICloudRecorderObserver"></a>

## ICloudRecorderObserver 回调接口类

该接口类用于向应用程序发送回调通知。该类包含如下回调：

- [连接到云端录制服务器回调 (OnRecordingConnecting)](#OnRecordingConnecting)
- [开始云端录制回调 (OnRecordingStarted)](#OnRecordingStarted)
- [云端录制已停止回调 (OnRecordingStopped)](#OnRecordingStopped)
- [录制异常回调 (OnRecorderFailure)](#OnRecorderFailure)
- [成功上传至第三方云存储回调 (OnRecordingUploaded)](#OnRecordingUploaded)
- [成功上传至云备份回调 (OnRecordingBackuped)](#OnRecordingBackuped)
- [上传进度回调 (OnRecordingUploadingProgress)](#OnRecordingUploadingProgress)
- [上传组件异常回调 (OnUploaderFailure)](#OnUploaderFailure)
- [录制失败回调 (OnRecordingFatalError)](#OnRecordingFatalError)

<a name = "OnRecordingConnecting"></a>

### 连接到云端录制服务器回调 (OnRecordingConnecting)

```c++
virtual void OnRecordingConnecting(RecordingId recording_id) = 0;
```

该回调方法表示应用程序已成功连接到云端录制服务器。

| 参数           | 描述                        |
| -------------- | --------------------------- |
| `recording_id` | 录制 ID，唯一标识当前录制。 |

<a name = "OnRecordingStarted"></a>

### 开始云端录制回调 (OnRecordingStarted)

```c++
virtual void OnRecordingStarted(RecordingId recording_id) = 0;
```

该回调方法表示应用程序已成功连接到云端录制服务器。

| 参数           | 描述                        |
| -------------- | --------------------------- |
| `recording_id` | 录制 ID，唯一标识当前录制。 |

<a name = "OnRecordingStopped"></a>

### 结束云端录制回调 (OnRecordingStopped)

```c++
virtual void OnRecordingStopped(RecordingId recording_id) = 0;
```

该回调方法表示应用程序已成功连接到云端录制服务器。

| 参数           | 描述                        |
| -------------- | --------------------------- |
| `recording_id` | 录制 ID，唯一标识当前录制。 |

<a name = "OnRecorderFailure"></a>

### 录制异常回调 (OnRecorderFailure)

```c++
virtual void OnRecorderFailure(RecordingId recording_id, RecordingErrorCode code, const char* msg) = 0;
```

该回调方法表示录制进程异常。

| 参数           | 描述                        |
| -------------- | --------------------------- |
| `recording_id` | 录制 ID，唯一标识当前录制。 |
| `code`         | 错误代码。                  |
| `msg`          | 错误消息。                  |

<a name = "OnRecordingUploaded"></a>

### 成功上传至第三方云存储回调 (OnRecordingUploaded)

```c++
virtual void OnRecordingUploaded(RecordingId recording_id, const char* file_name) = 0;
```

该回调方法表示录制文件已成功上传到预设的第三方云存储，用户可根据需求下载使用。

| 参数           | 描述                        |
| -------------- | --------------------------- |
| `recording_id` | 录制 ID，唯一标识当前录制。 |
| `file_name`    | 上传的录制文件的文件名。    |

<a name = "OnRecordingBackuped"></a>

### 成功上传至云备份回调 (OnRecordingBackuped)

```c++
virtual void OnRecordingBackuped(RecordingId recording_id, const char* file_name) = 0;
```

该回调方法表示录制文件成功上传到 Agora 云备份。当录制文件上传至预设的第三方云存储失败时，Agora 云端录制服务器会自动备份录制文件，避免文件丢失。

| 参数           | 描述                        |
| -------------- | --------------------------- |
| `recording_id` | 录制 ID，唯一标识当前录制。 |
| `file_name`    | 备份的录制文件的文件名。    |

<a name = "OnRecordingUploadingProgress"></a>

### 上传进度回调 (OnRecordingUploadingProgress)

```c++
virtual void OnRecordingUploadingProgress(RecordingId recording_id, unsigned int progress) = 0;
```

该回调方法表示录制文件上传进度。当录制文件向第三方云存储上传时，会触发还回调通知用户上传进度。

| 参数           | 描述                        |
| -------------- | --------------------------- |
| `recording_id` | 录制 ID，唯一标识当前录制。 |
| `progress`     | 上传进度。                  |

<a name = "OnUploaderFailure"></a>

### 上传组件异常回调 (OnUploaderFailure)

```c++
virtual void OnUploaderFailure(RecordingId recording_id, RecordingErrorCode code, const char* msg) = 0;
```

该回调方法表示上传组件署异常。

| 参数           | 描述                        |
| -------------- | --------------------------- |
| `recording_id` | 录制 ID，唯一标识当前录制。 |
| `code`         | 错误代码。                  |
| `msg`          | 错误消息。                  |

<a name = "OnRecordingFatalError"></a>

### 录制失败回调 (OnRecordingFatalError)

```c++
virtual void OnRecordingFatalError(RecordingId recording_id, RecordingErrorCode code) = 0;
```

该回调方法表示录制失败。用户需要调用 `Release` 方法释放录制资源，重新开始录制。

| 参数           | 描述                        |
| -------------- | --------------------------- |
| `recording_id` | 录制 ID，唯一标识当前录制。 |
| `code`         | 错误代码。                  |

<a name = "ErrorCode"></a>

## 错误代码

Agora Cloud Recording SDK 在调用 API 或运行时，可能会返回如下错误代码:

| 错误代码                            | 描述                       |
| ----------------------------------- | -------------------------- |
| `kRecordingErrorOk`                 | 没有错误。                 |
| `kRecordingErrorConnectError`       | 连接至云端录制服务器失败。 |
| `kRecordingErrorDisconnected`       | 连接至云端录制服务器中断。 |
| `kRecordingErrorInvalidParameter`   | 参数不合法。               |
| `kRecordingErrorInvalidOperation`   | 当前操作不支持。           |
| `kRecordingErrorNoUsers`            | 频道内无用户。             |
| `kRecordingErrorNoRecordedData`     | 未生成录制数据。           |
| `kRecordingErrorRecorderInitFailed` | 初始化异常。               |
| `kRecordingErrorRecorderFailed`     | 录制异常。                 |
| `kRecordingErrorUploaderInitFailed` | 初始化上传组件异常。       |
| `kRecordingErrorUploaderFailed`     | 上传组件异常。             |
| `kRecordingErrorBackupFailed`       | 云备份异常。               |
| `kRecordingErrorRecorderExpireExit` | 退出异常。                 |
| `kRecordingErrorGeneralError`       | 其他错误。                 |

> 上述错误代码若出现在 `OnRecordingFatalError` 回调下，则会影响录制进程，用户需要调用 `Release` 方法释放录制资源，重新开始录制。
