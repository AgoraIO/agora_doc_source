---
title: Demo 使用指南 (Deprecated)
platform: All Platforms
updatedAt: 2019-12-17 18:38:31
---
本文介绍如何通过命令行运行 C++ demo 进行录制。 你也可以通过调用 API 实现录制，详见[云端录制快速开始](./cloud_recording_quickstart)。无论是使用命令行，还是调用 API，实现的都是相同的功能，你可以根据个人习惯选择其中一种方式。

## 前提条件

请确保满足以下要求：

- 打开 TCP 端口：4447、8913、9700。
- 打开 UDP 端口：53、4444。
- 运行环境（物理或虚拟）：
  - Ubuntu Linux 14.04+ LTS 64 位
  - CentOS 6.5+（推荐 7.0）64 位
- 安装编译器 g++ 4.8 或以上版本。
- 联系 [sales@agora.io](mailto:sales@agora.io) 开通云端录制服务，获取 **cloud_recording_demo.bin** 文件。
- 开通第三方云存储服务，目前支持七牛云，阿里云和 Amazon S3。

## 运行 Demo

打开命令行工具，进入 **cloud_recording_demo.bin** 所在目录，执行 `./cloud_recording_demo.bin` 命令，即可看到录制相关的参数和选项，如下所示：

```bash
Usage: 
  ./cloud_recording_demo.bin --appId STRING --channelName STRING --uid UINTEGER32 --token STRING --recordingStreamType UINTEGER32 --videoStreamType UINTEGER32 --decryption_mode UINTEGER32 --secret STRING --channelType UINTEGER32 --audioProfile UINTEGER32 --mixWidth UINTEGER32 --mixHeight UINTEGER32 --fps UINTEGER32 --bitrate UINTEGER32 --maxResolutionUid UINTEGER32 --mixedVideoLayoutType UINTEGER32 --maxIdleTime UINTEGER32 --vendor UINTEGER32 --region UINTEGER32 --bucket STRING --accessKey STRING --secretKey STRING 
                             --appId     (app id)
                             --channelName     (channel name)
                             --uid     (User id)
                             --token     (channel token/Optional)
                             --recordingStreamType     (stream types (Optional: 0 for audio only,  1 for video only, 2 for audio and video, default 2))
                             --videoStreamType     (video stream type(Optional: 0 for high video, 1 for low video, default 0. Only works when recordingStreamType is not 0.))
                             --decryption_mode     (decryption mode(Optional, 0 for none, 1 for aes-128-xts,2 for aes-128-ecb, 3 for aes-256-xts, no decryption by default.))
                             --secret     (secret(Optional, emptry by default))
                             --channelType     (channel type (Optional 0 for communication, 1 for live, default 0))
                             —audioProfile     (audio profile, (Optional 0 for single channel mono, 1 for single channel music, 2 for multi channel music. default 0))
                             —mixWidth     (transcoding mixing width (Optional, defualt 640))
                             —mixHeight     (transcoding mixing height (Optional, default 360))
                             —fps     (transcoding fps(Optional, default 15))
                             —bitrate     (transcoding bitrate(Optional, 500 by default))
                             —maxResolutionUid     (transcoding max resolution uid(Optional))
                             —mixedVideoLayoutType     (mixed video layout mode(Optional, 0 for float, 1 for BestFit, 2 for vertical, 0 by defualt))
                             —maxIdleTime     (max idle time(Optional, 30 by default))
                             —vendor     (cloud storage vendor(0 for Qiniu, 1 for AWS, 2 for Aliyun))
                             —region     (cloud storage region)
                             —bucket     (cloud storage bucket)
                             —accessKey     (cloud storage access key)
                             —secretKey     (cloud storage secret key)
```

## 设置云端录制选项

按照你的需要在命令行中输入以下参数的设置并执行，即可开始使用云端录制服务。

> `appId`，`uid`，`channelName` ，`vendor`， `region`，`bucket`，`accessKey` 和 `secretKey` 这几个参数必须设置，若不设置则无法录制，其他参数可根据需要自行选择是否设置，若不设置则使用默认值。

| **参数**             | 描述                                                         |
| -------------------- | ------------------------------------------------------------ |
| appId                | 待录制频道的 App ID，必须和 Agora Native/Web SDK 的 App ID 一致，详见<a href="./token#-App-ID">获取 App ID</a>。 |
| channelName          | 待录制频道的频道名。                                         |
| uid                  | 录制使用的用户 ID，32 位无符号整数，取值范围 1 到 (2<sup>32</sup>-1)，需保证唯一性。 |
| token                | 待录制的频道中使用的 token，详见<a href="./token#Token">校验用户权限</a>。 |
| recordingStreamType  | 录制的媒体流类型：<li>0：仅录制音频。<li>1：仅录制视频。<li>2：录制音频和视频（默认）。 |
| videoStreamType      | 视频流类型。<li>0：视频大流（默认），即高分辨率高码率的视频流。<li>1：视频小流，即低分辨率低码率的视频流。 |
| decryption_mode      | 解密方案。云端录制 SDK 可以启用内置的解密功能。解密方式必须与频道设置的加密方式一致。<li>0：无（默认）。<li>1：设置 AES128XTS 解密方案。<li>2：设置 AES128ECB 解密方案。<li>3：设置 AES256XTS 解密方案。 |
| secret               | 解密密码，默认为空。仅当 decryption_mode 不为 0 时有效。     |
| channelType          | 频道模式。<li>0：通信模式（默认），即常见的 1 对 1 单聊或群聊，频道内任何用户可以自由说话。 <li>1：直播模式，有两种用户角色，主播和观众，只有主播可以自由发言。 <p>**频道模式必须与 Agora Native/Web SDK 一致，否则可能导致问题。** |
| audioProfile         | 设置音频采样率，码率，编码模式和声道数。<li>0：指定 48 KHz采样率，音乐编码, 单声道，编码码率约 48 Kbps（默认）。 <li>1：指定 48 KHz 采样率，音乐编码, 单声道，编码码率约 128 Kbps。<li>2：指定 48 KHz 采样率，音乐编码, 双声道，编码码率约 192 Kbps。 |
| mixWidth             | 合流宽度，单位 pixels，默认值为 360。详细设置请参考<a href="./cloud_recording_api#resolution_table">分辨率、帧率、码率对照表</a>。                        |
| mixHeight            | 合流高度，单位 pixels，默认值为 640。详细设置请参考<a href="./cloud_recording_api#resolution_table">分辨率、帧率、码率对照表</a>。                      |
| fps                  | 视频帧率，单位 fps，默认值为 15。详细设置请参考<a href="./cloud_recording_api#resolution_table">分辨率、帧率、码率对照表</a>。                            |
| bitrate              | 视频码率，单位 Kbps，默认值为 500。详细设置请参考<a href="./cloud_recording_api#resolution_table">分辨率、帧率、码率对照表</a>。                          |
| maxResolutionUid     | 如果 `mixedVideoLayoutType` 设为垂直布局，用该参数设置显示大流画面的用户 ID。 |
| mixedVideoLayoutType | 视频合流布局。<li>0：默认布局。指定一个 uid 在屏幕上方显示大流画面，其他用户的小流画面在下方水平排列，最多两行，一行 8 个画面，最多支持共 17 个录制画面。![](https://web-cdn.agora.io/docs-files/1550657688025)<li>1：自适应布局。根据录制画面的数量自动调整每个画面的大小，每个画面大小一致，最多支持 17 个录制画面。![](https://web-cdn.agora.io/docs-files/1547544528138)<li>2：垂直布局。指定一个 uid 在屏幕左侧显示大流画面，其他用户的小流画面在右侧垂直排列，最多两列，一列 8 个画面，最多支持共 17 个录制画面。 ![](https://web-cdn.agora.io/docs-files/1547544539933) |
| maxIdleTime          | 最长空闲频道时间。默认值为 30 秒，如果频道内无用户的状态持续超过该时间，录制程序会自动退出。若设置为 0，则使用默认值。 |
| vendor               | 第三方云存储：<li>0：七牛云（默认）。<li>1：Amazon S3。<li>2：阿里云。|
| `region`     | 第三方云存储指定的地区信息。<br>当 `vendor` = 0，即第三方云存储为七牛云时：<li>0：Huadong <li>1：Huabei <li>2：Huanan <li>3：Beimei  <br>当 `vendor` = 1，即第三方云存储为 Amazon S3 时：<li>0：US_EAST_1 <li>1：US_EAST_2 <li>2：US_WEST_1 <li>3：US_WEST_2  <li>4：EU_WEST_1 <li> 5：EU_WEST_2  <li>6：EU_WEST_3 <li>7：EU_CENTRAL_1 <li>8：AP_SOUTHEAST_1 <li>9：AP_SOUTHEAST_2 <li>10：AP_NORTHEAST_1 <li>11：AP_NORTHEAST_2 <li>12：SA_EAST_1 <li>13：CA_CENTRAL_1 <li>14：AP_SOUTH_1 <li>15：CN_NORTH_1 <li>16：CN_NORTHWEST_1 <li>17：US_GOV_WEST_1 <br>当 `vendor` = 2，即第三方云存储为阿里云时：<li>0：CN_Hangzhou <li>1：CN_Shanghai <li>2：CN_Qingdao <li>3：CN_Beijin  <li>4：CN_Zhangjiakou <li> 5：CN_Huhehaote  <li>6：CN_Shenzhen <li>7：CN_Hongkong <li>8：US_West_1 <li>9：US_East_1 <li>10：AP_Southeast_1 <li>11：AP_Southeast_2 <li>12：AP_Southeast_3 <li>13：AP_Southeast_5 <li>14：AP_Northeast_1 <li>15：AP_South_1 <li>16：EU_Central_1 <li>17：EU_West_1 <li>18：EU_East_1|
| bucket               | 第三方云存储 bucket。                                        |
| accessKey            | 第三方云存储 access key。                                    |
| secretKey            | 第三方云存储 secret key。                                    |

运行 demo 进行云端录制后，在 **$(pwd)/cloud_recording_log** 文件夹中生成以录制 ID 命名 .log 日志文件，该文件可以帮助查找问题原因。

## 状态信息反馈

在运行 demo 进行云端录制的过程中，命令行会出现如下信息提示当前运行状态。

| 正常状态信息                 | 描述                                                         |
| ---------------------------- | ------------------------------------------------------------ |
| OnRecordingConnecting        | 应用程序正在连接云端录制服务器。                         |
| OnRecordingStarted           | 应用程序已成功开始云端录制。                                 |
| OnRecordingStopped           | 应用程序已成功结束云端录制。                                 |
| OnRecordingUploaded          | 录制文件已成功上传到预设的第三方云存储。                     |
| OnRecordingBackedup          | 录制文件成功上传到 Agora 云备份。当录制文件上传至预设的第三方云存储失败时，Agora 云端录制服务器会自动备份录制文件，避免文件丢失。 |
| OnRecordingUploadingProgress | 录制文件的上传进度，包括录制 ID，上传进度和录制产生的 M3U8 文件名等信息。 |
| Recorder exit.Wait uploading | 频道录制结束，录制数据等待上传。                             |
| Stopped                      | 本次录制会话结束。                                           |

<p>	
	
| 异常状态信息                                        | 描述                         |
| --------------------------------------------------- | ---------------------------- |
| Cloud recording recorder init fail.                 | 录制组件初始化失败。         |
| Cloud recording recorder failed.                    | 录制组件异常。               |
| Cloud recording uploader init fail.                 | 上传组件初始化异常。         |
| Cloud recording uploader failed.                    | 上传组件异常。               |
| Cloud recording connection lost.                    | 与云端录制服务器的连接中断。 |
| Recording parameter not right, please have a check. | 参数不合法。                 |
| Current operation is not supported.                 | 不支持当前操作。             |
| Can't connect to cloud recording.                   | 连接至云端录制服务器失败。   |
| No recorded data.                                   | 未生成录制数据。             |
| Cloud recording backup failed.                      | 云备份异常。                 |
| No users in channel.                                | 频道内无用户                 |
| Error occur.                                        | 其他错误。                   |
