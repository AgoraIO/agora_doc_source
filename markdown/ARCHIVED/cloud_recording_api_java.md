---
title: 云端录制 Java API (Deprecated)
platform: All Platforms
updatedAt: 2019-12-17 18:38:33
---

| **接口类**                                                                | **描述**                   |
| ------------------------------------------------------------------------- | -------------------------- |
| <a href="#CloudRecorder">CloudRecorder</a> 类                             | 应用程序调用的主要方法。   |
| <a href="#ICloudRecordingEventHandler">ICloudRecordingEventHandler</a> 类 | 向应用程序发送的回调通知。 |

<a name = "CloudRecorder"></a>

## CloudRecorder 接口类

该接口类包含应用程序调用的主要方法：

- [创建云端录制实例 (createCloudRecorderInstance)](#createCloudRecorderInstance)
- [获取云端录制 ID (getRecordingId)](#getRecordingId)
- [开始云端录制 (startCloudRecording)](#startCloudRecording)
- [结束云端录制 (stopCloudRecording)](#stopCloudRecording)
- [释放资源 (release)](#release)

<a name = "createCloudRecorderInstance"></a>

### 创建云端录制实例 (createCloudRecorderInstance)

```java
public static CloudRecorder createCloudRecorderInstance(ICloudRecordingEventHandler handler)
```

该方法创建云端录制实例（不支持直接实例化）。

| 参数      | 描述                                                                                                           |
| --------- | -------------------------------------------------------------------------------------------------------------- |
| `handler` | 云端录制 SDK 所触发的事件通过 <a href="#ICloudRecorderObserver">ICloudRecordingEventHandler</a> 通知应用程序。 |

#### 返回值

- `CloudRecorder`: 返回一个云端录制的实例。

<a name = "getRecordingId"></a>

### 获取云端录制 ID (getRecordingId)

```java
public String getRecordingId()
```

该方法获取云端录制 ID。一个录制实例对应一个唯一的录制 ID。

#### 返回值

- `String`: 返回云端录制 ID，是当前录制的唯一标识。

<a name = "startCloudRecording"></a>

### 开始云端录制 (startCloudRecording)

```java
public RecordingErrorCode startCloudRecording(
    String appId,
    String channelName,
    String token,
    int uid,
    RecordingConfig config,
    CloudStorageConfig storageConfig)
```

该方法创建录制资源并让 Cloud Recording SDK 加入频道，随后开始录制。

| 参数            | 描述                                                                                                   |
| --------------- | ------------------------------------------------------------------------------------------------------ |
| `appId`         | 待录制频道的 App ID，详见<a href="./token#-App-ID">获取 App ID</a>。                                   |
| `channelName`   | 待录制频道的频道名。                                                                                   |
| `token`         | 待录制的频道中使用的 token，详见<a href="./token#Token">校验用户权限</a>。                             |
| `uid`           | 云端录制使用的用户 ID，32 位无符号整数，取值范围 1 到 (2<sup>32</sup>-1)，不可设置为 0，需保证唯一性。 |
| `config`        | 录制的详细设置，详见 <a href="#RecordingConfig">RecordingConfig</a>。                                  |
| `storageConfig` | 第三方云存储的详细设置，详见 <a href="#CloudStorageConfig">CloudStorageConfig</a>。                    |

#### 返回值

- `RecordingErrorCode.RecordingErrorOk`：方法调用成功。
- ≠ `RecordingErrorCode.RecordingErrorOk`：错误原因参考 <a href="#RecordingErrorCode">RecordingErrorCode</a>。

<a name = "RecordingConfig"></a>

#### RecordingConfig

```java
RecordingConfig:
public attributes:
  RecordingStreamType recordingStreamType
  DecryptionMode decryptionMode
  String secret
  ChannelType channelType
  AudioProfile audioProfile
  VideoStreamType videoStreamType
  int maxIdleTime
  TranscodingConfig transcodingConfig

public member functions:
  void setTranscodingWidth(int width)
  void setTranscodingHeight(int height)
  void setTranscodingFps(int fps)
  void setTrancodingBitrate(int bitrate)
  void setTranscodingMixedVideoLayout(MixedVideoLayoutType layout, int maxResolutionUid)
```

| 参数                  | 描述                                                                                                                                                                                                                                                                                                                                                                                    |
| --------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `recordingStreamType` | 录制的媒体流类型：<li>`RecordingStreamType.StreamTypeAudioVideo`：录制音频和视频（默认）。<li>`RecordingStreamType.StreamTypeAudioOnly`：仅录制音频。<li>`RecordingStreamType.StreamTypeVideoOnly`：仅录制视频。                                                                                                                                                                        |
| `decryptionMode`      | 解密方案。云端录制 SDK 可以启用内置的解密功能。解密方式必须与频道设置的加密方式一致。<li>`DecryptionMode.DecryptionModeNone`：无（默认）。<li>`DecryptionMode.DecryptionModeAes128Xts`：设置 AES128XTS 解密方案。<li>`DecryptionMode.DecryptionModeAes128Ecb`：设置 AES128ECB 解密方案。<li>`DecryptionMode.DecryptionModeAes256Xts`：设置 AES256XTS 解密方案。                         |
| `secret`              | 启用解密模式后，设置的解密密码。                                                                                                                                                                                                                                                                                                                                                        |
| `channelType`         | 频道模式。<li>`ChannelType.ChannelTypeCommunication`：通信模式（默认），即常见的 1 对 1 单聊或群聊，频道内任何用户可以自由说话。 <li>`ChannelType.ChannelTypeLive`：直播模式，有两种用户角色，主播和观众，只有主播可以自由发言。 <p>**频道模式必须与 Agora Native/Web SDK 一致，否则可能导致问题。**                                                                                    |
| `audioProfile`        | 设置音频采样率，码率，编码模式和声道数。<li>`AudioProfile.AudioProfileMusicStandard`：指定 48 KHz 采样率，音乐编码, 单声道，编码码率约 48 Kbps（默认）。 <li>`AudioProfile.AudioProfileMusicHighQuality`：指定 48 KHz 采样率，音乐编码, 单声道，编码码率约 128 Kbps。<li>`AudioProfile.AudioProfileMusicHighQualityStereo`：指定 48 KHz 采样率，音乐编码, 双声道，编码码率约 192 Kbps。 |
| `videoStreamType`     | 视频流类型。<li>`VideoStreamType.VideoStreamTypeHigh`：视频大流（默认），即高分辨率高码率的视频流。<li>`VideoStreamType.VideoStreamTypeLow`：视频小流，即低分辨率低码率的视频流。                                                                                                                                                                                                       |
| `maxIdleTime`         | 最长空闲频道时间。默认值为 30 秒，该值需大于等于 5。如果频道内无用户的状态持续超过该时间，录制程序会自动退出。                                                                                                                                                                                                                                                                          |
| `transcodingConfig`   | 视频转码的详细设置，详见 <a href="#TranscodingConfig">TranscodingConfig</a>。                                                                                                                                                                                                                                                                                                           |

<a name = "TranscodingConfig"></a>

#### TranscodingConfig

```java
TranscodingConfig:
public attributes:
  int width
  int height
  int fps
  int bitrate
  int maxResolutionUid
  MixedVideoLayoutType layout
```

| 参数               | 描述                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `width`            | 合流宽度，单位 pixels，默认值为 360。最大分辨率为 1080p，超过最大分辨率会报错。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `height`           | 合流高度，单位 pixels，默认值为 640。最大分辨率为 1080p，超过最大分辨率会报错。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `fps`              | 视频帧率，单位 fps，默认值为 15。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `bitrate`          | 视频码率，单位 Kbps，默认值为 500。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `maxResolutionUid` | 如果 `layout` 设为垂直布局，用该参数设置显示大流画面的用户 ID。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `layout`           | 视频合流布局，详见[设置合流布局](/cn/cloud-recording/cloud_layout_guide)。<li>`MixedVideoLayoutType.MixedVideoLayoutTypeFloat`：（默认）悬浮布局。第一个加入频道的用户在屏幕上会显示为大视窗，铺满整个画布，其他用户的视频画面会显示为小视窗，从下到上水平排列，最多 4 行，每行 4 个画面，最多支持共 17 个录制画面。</li><li>`MixedVideoLayoutType.MixedVideoLayoutTypeBestFit`：自适应布局。根据用户的数量自动调整每个画面的大小，每个用户的画面大小一致，最多支持 17 个录制画面。</li><li>`MixedVideoLayoutType.MixedVideoLayoutTypeVertical`：垂直布局。指定一个用户在屏幕左侧显示大视窗画面，其他用户的小视窗画面在右侧垂直排列，最多两列，一列 8 个画面，最多支持共 17 个录制画面。</li> |

<a name = "resolution_table"></a>

关于设置合流的推荐码率，详见**视频分辨率、帧率、码率对照表**。

| 分辨率     | 帧率（fps） | 基准码率（通信场景）（Kbps） | 直播码率（直播场景）（Kbps） |
| ---------- | ----------- | ---------------------------- | ---------------------------- |
| 160 × 120  | 15          | 65                           | 130                          |
| 120 × 120  | 15          | 50                           | 100                          |
| 320 × 180  | 15          | 140                          | 280                          |
| 180 × 180  | 15          | 100                          | 200                          |
| 240 × 180  | 15          | 120                          | 240                          |
| 320 × 240  | 15          | 200                          | 400                          |
| 240 × 240  | 15          | 140                          | 280                          |
| 424 × 240  | 15          | 220                          | 440                          |
| 640 × 360  | 15          | 400                          | 800                          |
| 360 × 360  | 15          | 260                          | 520                          |
| 640 × 360  | 30          | 600                          | 1200                         |
| 360 × 360  | 30          | 400                          | 800                          |
| 480 × 360  | 15          | 320                          | 640                          |
| 480 × 360  | 30          | 490                          | 980                          |
| 640 × 480  | 15          | 500                          | 1000                         |
| 480 × 480  | 15          | 400                          | 800                          |
| 640 × 480  | 30          | 750                          | 1500                         |
| 480 × 480  | 30          | 600                          | 1200                         |
| 848 × 480  | 15          | 610                          | 1220                         |
| 848 × 480  | 30          | 930                          | 1860                         |
| 640 × 480  | 10          | 400                          | 800                          |
| 1280 × 720 | 15          | 1130                         | 2260                         |
| 1280 × 720 | 30          | 1710                         | 3420                         |
| 960 × 720  | 15          | 910                          | 1820                         |
| 960 × 720  | 30          | 1380                         | 2760                         |

<a name = "CloudStorageConfig"></a>

#### CloudStorageConfig

```java
CloudStorageConfig:
public attributes:
  CloudStorageVendor vendor
  int region
  String bucket
  String accessKey
  String secretKey
```

| 参数        | 描述                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `vendor`    | 第三方云存储：<li>CloudStorageVendor.CloudStorageVendorQiniu：[七牛云](https://www.qiniu.com/products/kodo)。<li>CloudStorageVendor.CloudStorageVendorAws：Amazon S3。<li>CloudStorageVendor.CloudStorageVendorAliyun：[阿里云](https://aws.amazon.com/cn/s3/?nc2=h_m1)。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `region`    | 第三方云存储指定的地区信息。<br>当 `vendor` = CloudStorageVendor.CloudStorageVendorQiniu，即第三方云存储为[七牛云](https://www.qiniu.com/products/kodo)时：<li>0：Huadong <li>1：Huabei <li>2：Huanan <li>3：Beimei <br>当 `vendor` = CloudStorageVendor.CloudStorageVendorAws，即第三方云存储为 Amazon S3 时：<li>0：US_EAST_1 <li>1：US_EAST_2 <li>2：US_WEST_1 <li>3：US_WEST_2 <li>4：EU_WEST_1 <li> 5：EU_WEST_2 <li>6：EU_WEST_3 <li>7：EU_CENTRAL_1 <li>8：AP_SOUTHEAST_1 <li>9：AP_SOUTHEAST_2 <li>10：AP_NORTHEAST_1 <li>11：AP_NORTHEAST_2 <li>12：SA_EAST_1 <li>13：CA_CENTRAL_1 <li>14：AP_SOUTH_1 <li>15：CN_NORTH_1 <li>16：CN_NORTHWEST_1 <li>17：US_GOV_WEST_1 <br>当 `vendor` = CloudStorageVendor.CloudStorageVendorAliyun，即第三方云存储为[阿里云](https://aws.amazon.com/cn/s3/?nc2=h_m1)时：<li>0：CN_Hangzhou <li>1：CN_Shanghai <li>2：CN_Qingdao <li>3：CN_Beijin <li>4：CN_Zhangjiakou <li> 5：CN_Huhehaote <li>6：CN_Shenzhen <li>7：CN_Hongkong <li>8：US_West_1 <li>9：US_East_1 <li>10：AP_Southeast_1 <li>11：AP_Southeast_2 <li>12：AP_Southeast_3 <li>13：AP_Southeast_5 <li>14：AP_Northeast_1 <li>15：AP_South_1 <li>16：EU_Central_1 <li>17：EU_West_1 <li>18：EU_East_1 |
| `bucket`    | 第三方云存储 bucket。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `accessKey` | 第三方云存储 access key。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `secretKey` | 第三方云存储 secret key。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |

<a name = "stopCloudRecording"></a>

### 结束云端录制 (stopCloudRecording)

```java
public RecordingErrorCode stopCloudRecording()
```

该方法手动结束云端录制。若未调用该方法，当频道空闲（无用户）超过预设时间（默认为 30 秒）后，Cloud Recording SDK 会自动退出频道停止录制。

调用该方法结束录制后必须调用 `release` 释放资源，无法再调用其他方法。

#### 返回值：

- `RecordingErrorCode.RecordingErrorOk`：方法调用成功。
- ≠ `RecordingErrorCode.RecordingErrorOk`：错误原因参考 <a href="#RecordingErrorCode">RecordingErrorCode</a>。

<a name = "release"></a>

### 释放资源(release)

```java
public RecordingErrorCode release(boolean cancelCloudRecording)
```

该方法销毁 `CloudRecorder` 实例，释放 Agora Cloud Recording SDK 使用的资源，将无法再次使用和回调该 SDK 内的其它方法。如需再次使用云端录制，必须重新创建 `CloudRecorder` 实例。

| 参数                   | 描述                                                                                                        |
| ---------------------- | ----------------------------------------------------------------------------------------------------------- |
| `cancelCloudRecording` | 是否在服务器后台进行录制：<li>`true`：停止录制与上传。<li>`false`：（默认）在服务器后台继续进行录制并上传。 |

<a name = "ICloudRecordingEventHandler"></a>

## ICloudRecordingEventHandler 回调接口类

该接口类用于向应用程序发送回调通知。该类包含如下回调：

- [正在连接云端录制服务器回调 (onRecordingConnecting)](#onRecordingConnecting)
- [开始云端录制回调 (onRecordingStarted)](#onRecordingStarted)
- [云端录制已停止回调 (onRecordingStopped)](#onRecordingStopped)
- [成功上传至第三方云存储回调 (onRecordingUploaded)](#onRecordingUploaded)
- [成功上传至云备份回调 (onRecordingBackedUp)](#onRecordingBackedUp)
- [上传进度回调 (onRecordingUploadingProgress)](#onRecordingUploadingProgress)
- [录制异常回调 (onRecorderFailure)](#onRecorderFailure)
- [上传组件异常回调 (onUploaderFailure)](#onUploaderFailure)
- [录制失败回调 (onRecordingFatalError)](#onRecordingFatalError)

<a name = "onRecordingConnecting"></a>

### 正在连接云端录制服务器回调 (onRecordingConnecting)

```java
public void onRecordingConnecting(String recording_id)
```

该回调方法表示应用程序正在连接云端录制服务器。

| 参数           | 描述                            |
| -------------- | ------------------------------- |
| `recording_id` | 录制 ID，是当前录制的唯一标识。 |

<a name = "onRecordingStarted"></a>

### 开始云端录制回调 (onRecordingStarted)

```java
public void onRecordingStarted(String recording_id)
```

该回调方法表示应用程序已成功开始云端录制。

| 参数           | 描述                            |
| -------------- | ------------------------------- |
| `recording_id` | 录制 ID，是当前录制的唯一标识。 |

<a name = "onRecordingStopped"></a>

### 结束云端录制回调 (onRecordingStopped)

```java
public void onRecordingStopped(String recording_id)
```

该回调方法表示应用程序已成功结束云端录制。

| 参数           | 描述                            |
| -------------- | ------------------------------- |
| `recording_id` | 录制 ID，是当前录制的唯一标识。 |

<a name = "onRecordingUploaded"></a>

### 成功上传至第三方云存储回调 (onRecordingUploaded)

```java
public void onRecordingUploaded(String recording_id, String file_name)
```

该回调方法表示所有录制文件已成功上传到预设的第三方云存储，可根据需求播放或下载使用。

| 参数           | 描述                                                                                               |
| -------------- | -------------------------------------------------------------------------------------------------- |
| `recording_id` | 录制 ID，是当前录制的唯一标识。                                                                    |
| `file_name`    | 录制产生的 M3U8 文件的文件名。每个录制实例均会生成一个 M3U8 文件，用于索引所有的录制切片 TS 文件。 |

<a name = "onRecordingBackedUp"></a>

### 成功上传至云备份回调 (onRecordingBackedUp)

```java
public void onRecordingBackedUp(String recording_id, String file_name)
```

该回调方法表示录制文件成功上传到 Agora 云备份。
如果在录制过程中有录制文件未能成功上传至第三方云存储，Agora 服务器会自动将这部分录制文件上传至 Agora 云备份，在录制结束后触发该回调。Agora 云备份会继续尝试将这部分文件上传至设定的第三方云存储。如果等待五分钟后仍然不能正常[播放录制文件](./cloud_recording_onlineplay)，请联系 Agora 技术支持。

| 参数           | 描述                                                                                               |
| -------------- | -------------------------------------------------------------------------------------------------- |
| `recording_id` | 录制 ID，是当前录制的唯一标识。                                                                    |
| `file_name`    | 录制产生的 M3U8 文件的文件名。每个录制实例均会生成一个 M3U8 文件，用于索引所有的录制切片 TS 文件。 |

<a name = "onRecordingUploadingProgress"></a>

### 上传进度回调 (onRecordingUploadingProgress)

```java
public void onRecordingUploadingProgress(
    String recording_id,
    int progress,
    String recording_playlist_filename)
```

该回调方法表示录制文件上传进度。录制开始后，Agora 服务器会不断向第三方云存储上传录制文件，SDK 会每分钟触发一次该回调通知应用程序上传进度。

| 参数                          | 描述                                                                                               |
| ----------------------------- | -------------------------------------------------------------------------------------------------- |
| `recording_id`                | 录制 ID，是当前录制的唯一标识。                                                                    |
| `progress`                    | 上传进度。显示当前上传占当前录制的百分比。                                                         |
| `recording_playlist_filename` | 录制产生的 M3U8 文件的文件名。每个录制实例均会生成一个 M3U8 文件，用于索引所有的录制切片 TS 文件。 |

<a name = "onRecorderFailure"></a>

### 录制组件异常回调 (onRecorderFailure)

```java
public void onRecorderFailure(
    String recording_id,
    RecordingErrorCode code,
    String msg)
```

该回调方法仅用来通知录制组件异常，无需对此进行任何操作。

| 参数           | 描述                            |
| -------------- | ------------------------------- |
| `recording_id` | 录制 ID，是当前录制的唯一标识。 |
| `code`         | 错误代码。                      |
| `msg`          | 错误消息。                      |

<a name = "onUploaderFailure"></a>

### 上传组件异常回调 (onUploaderFailure)

```java
public void onUploaderFaliure(
    String recording_id,
    RecordingErrorCode code,
    String msg)
```

该回调方法仅用来通知上传组件异常，无需对此进行任何操作。

| 参数           | 描述                            |
| -------------- | ------------------------------- |
| `recording_id` | 录制 ID，是当前录制的唯一标识。 |
| `code`         | 错误代码。                      |
| `msg`          | 错误消息。                      |

<a name = "onRecordingFatalError"></a>

### 录制 SDK 异常回调 (onRecordingFatalError)

```java
public void onRecordingFatalError(
    String recording_id,
    RecordingErrorCode code)
```

该回调方法表示云端录制 SDK 发生了不可恢复的错误，可根据具体的错误代码判断录制后台的状态。

| 参数           | 描述                            |
| -------------- | ------------------------------- |
| `recording_id` | 录制 ID，是当前录制的唯一标识。 |
| `code`         | 错误代码。                      |

<a name = "RecordingErrorCode"></a>

## 错误代码

Agora Cloud Recording SDK 在调用 API 或运行时，可能会返回如下错误代码:

| 错误代码                         | 描述                         | 解决方法                              |
| -------------------------------- | ---------------------------- | ------------------------------------- |
| `RecordingErrorOk`               | 没有错误。                   | 无。                                  |
| `RecordingErrorConenctError`     | 连接至云端录制服务器失败。   | 检查网络和 appid 的权限。             |
| `RecordingErrorDisconnected`     | 与云端录制服务器的连接中断。 | 检查网络。                            |
| `RecordingErrorInvalidParameter` | 参数不合法。                 | 检查参数。                            |
| `RecordingErrorInvalidOperation` | 不支持当前操作。             | 检查调用顺序。                        |
| `RecordingErrorNoUsers`          | 频道内无用户。               | 调用 release (false) 来释放本地资源。 |
| `RecordingErrorNoRecordedData`   | 未生成录制数据。             | 调用 release (false) 来释放本地资源。 |
| `RecordingErrorRecorderInit`     | 初始化异常。                 | 调用 release (true) 并重新开始录制。  |
| `RecordingErrorRecorderFailed`   | 录制异常。                   | 调用 release (true) 并重新开始录制。  |
| `RecordingErrorUploaderInit`     | 初始化上传组件异常。         | 调用 release (true) 并重新开始录制。  |
| `RecordingErrorUploaderFailed`   | 上传组件异常。               | 调用 release (true) 并重新开始录制。  |
| `RecordingErrorBackupFailed`     | 云备份异常。                 | 调用 release (false) 来释放本地资源。 |
| `RecordingErrorRecorderExit`     | 退出异常。                   | 调用 release (true) 并重新开始录制。  |
