Agora 提供消息通知服务，你可以配置一个接收回调的 HTTP/HTTPS 服务器地址来接收云端录制的事件通知。当事件发生时，Agora 云端录制服务会将事件消息发送给 Agora 消息通知服务器，然后 Agroa 消息通知服务器会通过 HTTP/HTTPS 请求将事件投递给你的服务器。

<div class="alert note">消息通知服务只能作为辅助手段来监控录制状态。不建议你的核心业务逻辑依赖消息通知服务。如果你的业务对该服务强依赖，建议联系 <a href="mailto:sales@agora.io">sales@agora.io</a> 开通冗余消息功能，即接收双路消息通知，降低消息丢失的概率。冗余消息功能仍然不能保证 100% 的消息到达率。</div>

## Agora 消息通知服务

使用 Agora 消息通知服务前需要申请开通并进行配置，关于如何开通服务以及消息通知回调的数据格式详见[消息通知服务](https://docs-preprod.agora.io/cn/Agora%20Platform/ncs)。

## 回调内容

开通消息通知服务后，当你指定要接收通知的事件发生时，Agora 消息通知服务器会以 HTTP 请求形式向你发送回调。回调的具体内容在请求包体中以 JSON 对象形式返回，根据事件不同，请求包体中 JSON 对象所包含的字段也不一样。

下面以一个示例说明请求包体中的字段：
![](https://web-cdn.agora.io/docs-files/1567589432439)
- 红色框内字段为消息通知服务请求包体的公共字段，所有回调中都包含这些字段，公共字段的含义详见[消息通知回调格式](https://docs-preprod.agora.io/cn/Agora%20Platform/ncs?platform=All%20Platforms#消息通知回调格式)。
- 蓝色框内字段为云端录制 `payload` 中的[公共字段](#payload)，所有的云端录制事件的回调中 `payload` 都包含这些字段。
- `eventType`，`serviceType` 和 `details` 的内容取决于发生的事件，详见[回调事件](#event)。

### <a name="payload"></a>payload 字段

 `payload` 字段是一个 JSON 对象，包含事件的具体内容。云端录制每种类型的事件通知中 `payload` 都会包含以下字段：
  - `cname`：String 类型，录制的频道名称。
  - `uid`：String 类型，录制使用的 UID。
  - `sid`：String 类型，录制 ID，一次云端录制的唯一标识。
  - `sequence`：Number 类型，消息序列号，从 0 开始计数。消息可能乱序到达或者丢失重发，可以通过该参数标识消息。
  - `serviceScene`：String 类型，当前运行的录制场景或录制阶段：
    - `"rtc_record"`: 实时录制。
    - `"rtc_snapshot"`: 截图。
    - `"rtc_vod"`: 录制并上传至阿里视频点播服务。
    - `"web_record"`: 页面录制。
    - `"postpone_transcode::rtc_record"`: 延时转码场景下的第一阶段，即录制阶段。
    - `"postpone_transcode::transcode"`: 延时转码场景下的第二阶段，即转码阶段。
    - `"postpone_transcode::transcode_failover"`: 转码失败。
  - `sendts`：Number 类型， 事件发生的时间 （UTC 时间）。Unix 时间戳，精确到毫秒。
  - `serviceType`：Number 类型，回调事件服务的类型。
    - 0：云端录制服务。
    - 1：录制模块。
    - 2：上传模块。
    - 4：扩展服务。
  - `details`：JSON 类型，具体的消息内容，详见下面每个事件的描述。

## <a name="event"></a>回调事件

本节详细介绍云端录制每种回调事件对应的 `serviceType` 以及 `details` 包含的具体字段。

| eventType     | serviceType       | 事件描述                                                     |
| ------------- | ----------------- | ------------------------------------------------------------ |
| [1](#1)       | 0（云端录制服务） | 云端录制服务发生错误                                         |
| [2](#2)       | 0（云端录制服务） | 云端录制服务发生警告                                         |
| [3](#3)       | 0（云端录制服务） | 云端录制服务状态发生变化                                     |
| [4](#4)       | 0（云端录制服务） | 生成录制索引文件                                             |
| [11](#11)     | 0（云端录制服务） | 云端录制服务结束任务并退出                                   |
| [12](#12)     | 0（云端录制服务） | 云端录制[启用高可用机制](https://docs.agora.io/cn/faq/high-availability) |
| [30](#30)     | 2（上传模块）     | 上传服务已启动                                               |
| [31](#31)     | 2（上传模块）     | 所有录制文件已上传至指定的第三方云存储                       |
| [32](#32)     | 2（上传模块）     | 所有录制文件已经全部上传完成，但至少有一片上传到 Agora 备份云 |
| [33](#33)     | 2（上传模块）     | 录制文件上传到第三方云存储的进度                             |
| [40](#40)     | 1（录制模块）     | 录制服务已启动                                               |
| [41](#41)     | 1（录制模块）     | 录制服务已退出                                               |
| [42](#42)     | 1（录制模块）     | 同步录制文件信息                                             |
| [43](#43)     | 1（录制模块）     | 音频流状态变化                                               |
| [44](#44)     | 1（录制模块）     | 视频流状态变化                                               |
| [60](#60)     | 4（扩展服务）     | 阿里视频点播服务上传模块启动，并成功获取上传凭证。           |
| [61](#61)     | 4（扩展服务）     | 所有录制文件已上传至阿里视频点播服务。                       |
| [70](#70)     | 6 (页面录制）     | 页面录制已启动                                               |
| [71](#71)     | 6 (页面录制）     | 页面录制已停止                                               |
| [72](#72)     | 6 (页面录制）     | 待录制页面使用了不受支持的功能，录制即将停止                 |
| [80](#80)     | 7 (延时转码模块） | 转码已启动                                                   |
| [81](#81)     | 7 (延时转码模块） | 转码已完成                                                   |
| [90](#90)     | 8 (下载模块）     | 下载录制文件失败                                             |
| [1001](#1001) | 0 (云端录制服务） | 转码最终结果                                                 |

### <a name="1"></a>1 cloud_recording_error

`eventType` 为 1 表示云端录制服务发生错误， `details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `"cloud_recording_error"`。
- `module`：Number 类型，发生错误的模块。
  - `0`：录制模块
  - `1`：上传模块
  - `2`：云端录制服务
- `errorLevel`：Number 类型，错误级别。
  - `1`：debug
  - `2`：minor
  - `3`：medium
  - `4`：major
  - `5`：fatal。fatal 级别的错误很可能导致录制退出，如果收到该级别的消息请及时调用 [query](https://docs.agora.io/cn/cloud-recording/restfulapi/#/%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6/query) API 查询当前状态，并结合错误消息的内容进行处理。
- `errorCode`：Number 类型，错误码。如果错误发生在录制模块，请参考[错误码](https://docs.agora.io/cn/Recording/API%20Reference/recording_cpp/namespaceagora_1_1linuxsdk.html#a5f37e3fa14fad2982f248d247d76996b)；如果错误发生在上传模块，请参考[上传错误码](#uploaderr)；如果错误发生在云端录制平台模块，请参考[云端录制平台错误码](#clouderr)；如果错误码未列出，请联系 Agora 技术支持。
- `stat`：Number 类型，事件状态，0 表示正常，其他值表示异常。
- `errorMsg`：String 类型，具体的错误信息。

### <a name="2"></a>2 cloud_recording_warning

`eventType` 为 2 表示云端录制服务发生警告， `details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `cloud_recording_warning`。
- `module`：Number 类型，发生警告的模块名。
  - `0`：录制模块
  - `1`：上传模块
- `warnCode`：Number 类型，警告码。如果警告发生在录制模块，请参考[警告码](https://docs.agora.io/cn/Recording/API%20Reference/recording_cpp/namespaceagora_1_1linuxsdk.html#a11cab69078db26c1f166c68e469dcfcf)；如果警告发生在上传模块，请参考[上传警告码](#uploadwarn)。

### <a name="3"></a>3 cloud_recording_status_update

`eventType` 为 3 表示云端录制服务状态与你调用的方法不匹配，导致调用失败。例如，云端录制服务已开始，导致再次调用 `start` 失败。`details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `cloud_recording_status_update`。
- `status`：Number 类型，云端录制当前的状态，请参考[云端录制服务状态码](#state)。
- `recordingMode`：Number 类型，录制模式。
  - `0`：合流模式
  - `1`：单流模式
- `fileList`：String 类型，录制生成的 M3U8 索引文件名。

### <a name="4"></a>4 cloud_recording_file_infos

`eventType` 为 4 表示生成 M3U8 文件并上传。录制过程中，录制服务会反复上传和覆盖 M3U8 文件，以更新索引信息，但只有第一次生成并上传 M3U8 文件时会触发该回调。

 `details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `cloud_recording_file_infos`。
- `fileList`：String 类型，生成的 M3U8 文件名。

### <a name="11"></a>11 session_exit

`eventType` 为 11 表示云端录制服务结束任务并退出，`details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `session_exit`。
- `exitStatus`：Number 类型，退出状态。
  - `0`：正常退出，即录制结束、录制文件成功上传后，录制服务退出。
  - `1`：异常退出，例如参数设置错误，导致录制停止。

### <a name="12"></a>12 session_failover

`eventType` 为 12 表示云端录制启用高可用机制，`details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `session_failover`。
- `newUid`：Number 类型，启用高可用机制后，云端录制随机指定的录制 UID。云端录制将使用该录制 UID 加入频道，不再使用原有的录制 UID。

### <a name="30"></a>30 uploader_started

`eventType` 为 30 表示上传服务已启动， `details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `uploader_started`。
- `status`：Number 类型，事件状态，0 表示正常，其他值表示异常。

### <a name="31"></a>31 uploaded

`eventType` 为 31 表示所有录制文件已上传至指定的第三方云存储， `details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `uploaded`。
- `status`：Number 类型，事件状态，0 表示正常，其他值表示异常。
- `fileList`：JSONArray 类型，由每个录制文件的具体信息组成的数组。
  - `filename`：String 类型，录制产生的 M3U8 文件和 MP4 文件的文件名。
  - `trackType`：String 类型，录制文件的类型。
    - `"audio"`：纯音频文件。
    - `"video"`：纯视频文件。
    - `"audio_and_video"`：音视频文件。
  - `uid`：String 类型，用户 UID，表示录制的是哪个用户的音频流或视频流。合流录制模式下，`uid` 为 `"0"`。
  - `mixedAllUser`：Boolean 类型，用户是否是分开录制的。
    - `true`：所有用户合并在一个录制文件中。
    - `false`：每个用户分开录制。
  - `isPlayable`：Boolean 类型，是否可以在线播放。
    - `true`：可以在线播放。
    - `false`：无法在线播放。
  - `sliceStartTime`：Number 类型，该文件的录制开始时间，Unix 时间戳，单位为毫秒。

#### 回调示例

<details>
	<summary><font color="#3ab7f8">单流录制</font></summary>
<pre><code>{
  <span class="hljs-attr">"msgName"</span>: <span class="hljs-string">"uploaded"</span>,
  <span class="hljs-attr">"fileList"</span>: [
    {
      <span class="hljs-attr">"fileName"</span>: <span class="hljs-string">"xxx.m3u8"</span>,
      <span class="hljs-attr">"trackType"</span>: <span class="hljs-string">"audio"</span>,
      <span class="hljs-attr">"uid"</span>: <span class="hljs-string">"57297"</span>,
      <span class="hljs-attr">"mixedAllUser"</span>: <span class="hljs-literal">false</span>,
      <span class="hljs-attr">"isPlayable"</span>: <span class="hljs-literal">true</span>,
      <span class="hljs-attr">"sliceStartTime"</span>: <span class="hljs-number">1619172871089</span>
    },
    {
      <span class="hljs-attr">"fileName"</span>: <span class="hljs-string">"xxx.m3u8"</span>,
      <span class="hljs-attr">"trackType"</span>: <span class="hljs-string">"audio"</span>,
      <span class="hljs-attr">"uid"</span>: <span class="hljs-string">"10230"</span>,
      <span class="hljs-attr">"mixedAllUser"</span>: <span class="hljs-literal">false</span>,
      <span class="hljs-attr">"isPlayable"</span>: <span class="hljs-literal">true</span>,
      <span class="hljs-attr">"sliceStartTime"</span>: <span class="hljs-number">1619172871099</span>
    }
  ],
  <span class="hljs-attr">"status"</span>: <span class="hljs-number">0</span>
}
</code></pre>
</details>


<details>
	<summary><font color="#3ab7f8">合流录制且不生成 MP4</font></summary>
<pre><code>{
  <span class="hljs-attr">"msgName"</span>: <span class="hljs-string">"uploaded"</span>,
  <span class="hljs-attr">"fileList"</span>: [
    {
      <span class="hljs-attr">"fileName"</span>: <span class="hljs-string">"xxx.m3u8"</span>,
      <span class="hljs-attr">"trackType"</span>: <span class="hljs-string">"audio_and_video"</span>,
      <span class="hljs-attr">"uid"</span>: <span class="hljs-string">"0"</span>,
      <span class="hljs-attr">"mixedAllUser"</span>: <span class="hljs-literal">true</span>,
      <span class="hljs-attr">"isPlayable"</span>: <span class="hljs-literal">true</span>,
      <span class="hljs-attr">"sliceStartTime"</span>: <span class="hljs-number">1619170461821</span>
    }
  ],
  <span class="hljs-attr">"status"</span>: <span class="hljs-number">0</span>
}
</code></pre>
</details>
<details>
	<summary><font color="#3ab7f8">合流录制并生成 MP4</font></summary>
<pre><code>{
  <span class="hljs-attr">"msgName"</span>: <span class="hljs-string">"uploaded"</span>,
  <span class="hljs-attr">"fileList"</span>: [
    {
      <span class="hljs-attr">"fileName"</span>: <span class="hljs-string">"xxx.mp4"</span>,
      <span class="hljs-attr">"trackType"</span>: <span class="hljs-string">"audio_and_video"</span>,
      <span class="hljs-attr">"uid"</span>: <span class="hljs-string">"0"</span>,
      <span class="hljs-attr">"mixedAllUser"</span>: <span class="hljs-literal">true</span>,
      <span class="hljs-attr">"isPlayable"</span>: <span class="hljs-literal">true</span>,
      <span class="hljs-attr">"sliceStartTime"</span>: <span class="hljs-number">1619172632080</span>
    },
    {
      <span class="hljs-attr">"fileName"</span>: <span class="hljs-string">"xxx.m3u8"</span>,
      <span class="hljs-attr">"trackType"</span>: <span class="hljs-string">"audio_and_video"</span>,
      <span class="hljs-attr">"uid"</span>: <span class="hljs-string">"0"</span>,
      <span class="hljs-attr">"mixedAllUser"</span>: <span class="hljs-literal">true</span>,
      <span class="hljs-attr">"isPlayable"</span>: <span class="hljs-literal">true</span>,
      <span class="hljs-attr">"sliceStartTime"</span>: <span class="hljs-number">1619172632080</span>
    }
  ],
  <span class="hljs-attr">"status"</span>: <span class="hljs-number">0</span>
}
</code></pre>
</details>


<details>
	<summary><font color="#3ab7f8">页面录制并生成 MP4</font></summary>
<pre><code>{
<span class="hljs-attr">"msgName"</span>:<span class="hljs-string">"uploaded"</span>,
<span class="hljs-attr">"status"</span>:<span class="hljs-string">"0"</span>,
<span class="hljs-attr">"fileList"</span>:[{
  <span class="hljs-attr">"uid"</span>:<span class="hljs-string">"0"</span>,
  <span class="hljs-attr">"fileName"</span>:<span class="hljs-string">"xxx.m3u8"</span>,
  <span class="hljs-attr">"sliceStartTime"</span>:<span class="hljs-number">1562724971626</span>},
  {
  <span class="hljs-attr">"uid"</span>:<span class="hljs-string">"0"</span>,
  <span class="hljs-attr">"fileName"</span>:<span class="hljs-string">"xxx.mp4"</span>,
  <span class="hljs-attr">"sliceStartTime"</span>:<span class="hljs-number">1562724971626</span>},
  {
  <span class="hljs-attr">"uid"</span>:<span class="hljs-string">"0"</span>,
  <span class="hljs-attr">"fileName"</span>:<span class="hljs-string">"xxx.mp4"</span>,
  <span class="hljs-attr">"sliceStartTime"</span>:<span class="hljs-number">1562732171000</span>}]
}
</code></pre>
</details>

### <a name="32"></a>32 backuped

`eventType` 为 32 表示所有录制文件已经全部上传完成，但至少有一片上传到 Agora 备份云， Agora 备份云会自动将这部分文件上传到指定的第三方云存储。 `details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `backuped`。
- `status`：Number 类型，事件状态，0 表示正常，其他值表示异常。
- `fileList`：JSONArray 类型，由每个录制文件的具体信息组成的数组。
  - `filename`：String 类型，录制产生的 M3U8 文件和 MP4 文件的文件名。
  - `trackType`：String 类型，录制文件的类型。
    - `"audio"`：纯音频文件。
    - `"video"`：纯视频文件。
    - `"audio_and_video"`：音视频文件。
  - `uid`：String 类型，用户 UID，表示录制的是哪个用户的音频流或视频流。合流录制模式下，`uid` 为 `"0"`。
  - `mixedAllUser`：Boolean 类型，用户是否是分开录制的。
    - `true`：所有用户合并在一个录制文件中。
    - `false`：每个用户分开录制。
  - `isPlayable`：Boolean 类型，是否可以在线播放。
    - `true`：可以在线播放。
    - `false`：无法在线播放。
  - `sliceStartTime`：Number 类型，该文件的录制开始时间，Unix 时间戳，单位为毫秒。

#### 回调示例

<details>
	<summary><font color="#3ab7f8">单流录制</font></summary>
<pre><code>{
<span class="hljs-attr">"msgName"</span>:<span class="hljs-string">"backuped"</span>,
<span class="hljs-attr">"status"</span>:<span class="hljs-string">"0"</span>,
<span class="hljs-attr">"fileList"</span>:[{
  <span class="hljs-attr">"uid"</span>:<span class="hljs-string">"123"</span>,
  <span class="hljs-attr">"fileName"</span>:<span class="hljs-string">"xxx.m3u8"</span>,
  <span class="hljs-attr">"sliceStartTime"</span>:<span class="hljs-number">1562724971626</span>},
  {
  <span class="hljs-attr">"uid"</span>:<span class="hljs-string">"456"</span>,
  <span class="hljs-attr">"fileName"</span>:<span class="hljs-string">"xxx.m3u8"</span>,
  <span class="hljs-attr">"sliceStartTime"</span>:<span class="hljs-number">1562724971626</span>}]
}
</code></pre>
</details>

<details>
	<summary><font color="#3ab7f8">合流录制且不生成 MP4</font></summary>
<pre><code>{
<span class="hljs-attr">"msgName"</span>:<span class="hljs-string">"backuped"</span>,
<span class="hljs-attr">"status"</span>:<span class="hljs-string">"0"</span>,
<span class="hljs-attr">"fileList"</span>:[{
  <span class="hljs-attr">"uid"</span>:<span class="hljs-string">"0"</span>,
  <span class="hljs-attr">"fileName"</span>:<span class="hljs-string">"xxx.m3u8"</span>,
  <span class="hljs-attr">"sliceStartTime"</span>:<span class="hljs-number">1562724971626</span>}]
}
</code></pre>
</details>

<details>
	<summary><font color="#3ab7f8">合流录制并生成 MP4</font></summary>
<pre><code>
{
<span class="hljs-attr">"msgName"</span>:<span class="hljs-string">"backuped"</span>,
<span class="hljs-attr">"status"</span>:<span class="hljs-string">"0"</span>,
<span class="hljs-attr">"fileList"</span>:[{
  <span class="hljs-attr">"uid"</span>:<span class="hljs-string">"0"</span>,
  <span class="hljs-attr">"fileName"</span>:<span class="hljs-string">"xxx.m3u8"</span>,
  <span class="hljs-attr">"sliceStartTime"</span>:<span class="hljs-number">1562724971626</span>},
  {
  <span class="hljs-attr">"uid"</span>:<span class="hljs-string">"0"</span>,
  <span class="hljs-attr">"fileName"</span>:<span class="hljs-string">"xxx.mp4"</span>,
  <span class="hljs-attr">"sliceStartTime"</span>:<span class="hljs-number">1562724971626</span>},
  {
  <span class="hljs-attr">"uid"</span>:<span class="hljs-string">"0"</span>,
  <span class="hljs-attr">"fileName"</span>:<span class="hljs-string">"xxx.mp4"</span>,
  <span class="hljs-attr">"sliceStartTime"</span>:<span class="hljs-number">1562732171000</span>}]
}
</code></pre>
</details>

<details>
	<summary><font color="#3ab7f8">页面录制并生成 MP4</font></summary>
<pre><code>{
<span class="hljs-attr">"msgName"</span>:<span class="hljs-string">"backuped"</span>,
<span class="hljs-attr">"status"</span>:<span class="hljs-string">"0"</span>,
<span class="hljs-attr">"fileList"</span>:[{
  <span class="hljs-attr">"uid"</span>:<span class="hljs-string">"0"</span>,
  <span class="hljs-attr">"fileName"</span>:<span class="hljs-string">"xxx.m3u8"</span>,
  <span class="hljs-attr">"sliceStartTime"</span>:<span class="hljs-number">1562724971626</span>},
  {
  <span class="hljs-attr">"uid"</span>:<span class="hljs-string">"0"</span>,
  <span class="hljs-attr">"fileName"</span>:<span class="hljs-string">"xxx.mp4"</span>,
  <span class="hljs-attr">"sliceStartTime"</span>:<span class="hljs-number">1562724971626</span>},
  {
  <span class="hljs-attr">"uid"</span>:<span class="hljs-string">"0"</span>,
  <span class="hljs-attr">"fileName"</span>:<span class="hljs-string">"xxx.mp4"</span>,
  <span class="hljs-attr">"sliceStartTime"</span>:<span class="hljs-number">1562732171000</span>}]
}
</code></pre>
</details>

### <a name="33"></a>33 uploading_progress

`eventType` 为 33 表示当前上传的进度，录制开始后每分钟会通知一次。 `details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `uploading_progress`。
- `progress`：Number 类型，0 到 10000 之间的数字，当前已上传文件与已录制的文件的比例乘以 10000。这个数字是不断变动的，录制退出后，到达 10000 表示上传完成。

### <a name="40"></a>40 recorder_started

`eventType` 为 40 表示录制服务已启动， `details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `recorder_started`。
- `status`：Number 类型，事件状态，0 表示正常，其他值表示异常。

### <a name="41"></a>41 recorder_leave

`eventType` 为 41 表示录制组件已退出， `details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `recorder_leave`。
- `leaveCode`：Number 类型，退出码。将该退出码与各枚举值逐一进行按位与运算，计算结果非零的，即为退出原因。例如，code 为 6（二进制 110）时，将其与各枚举值逐一进行按位与计算，LEAVE_CODE_SIG (二进制 10）与 LEAVE_CODE_NO_USERS (二进制 100）的结果非零，则退出原因包括收到 SIGINT 信号以及录制超时。

  | 枚举值                  |                                                              |
  | :---------------------- | ------------------------------------------------------------ |
  | LEAVE_CODE_INIT         | 0：初始化失败。                                              |
  | LEAVE_CODE_SIG          | 2（二进制 10）：AgoraCoreService 收到 SIGINT 信号而触发的退出。 |
  | LEAVE_CODE_NO_USERS     | 4（二进制 100）：频道内除录制端外没有其他用户，录制端自动离开频道。 |
  | LEAVE_CODE_TIMER_CATCH  | 8（二进制 1000）：可忽略。                                   |
  | LEAVE_CODE_CLIENT_LEAVE | 16（二进制 10000）：录制端调用 `leaveChannel` 方法退出频道。 |


### <a name="42"></a>42 recorder_slice_start

`eventType` 为 42 表示同步录制文件信息， `details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `recorder_slice_start`。
- `startUtcMs`：Number 类型，录制开始时间（即第一个录制切片的开始时间），UTC 时间，精确到毫秒。
- `discontinueUtcMs`：Number 类型，UTC 时间，精确到毫秒，正常情况下该字段值与 `startUtcMs` 一致。当录制发生异常中断时， Agora 云端录制会自动恢复录制，此时也会收到该事件通知，且该字段表示上一个正常的录制切片结束的时间。
- `mixedAllUser`：Boolean 类型，是否将每个用户分开录制。
  - `true`：所有用户合并在一个录制文件中。
  - `false`：每个用户分开录制。
- `streamUid`：String 类型，用户 UID，表示录制的是哪个用户的音频流或视频流。在合流模式下，`streamUid` 为 `"0"`。
- `trackType`：String 类型，录制文件的类型。
  - `"audio"`：纯音频文件。
  - `"video"`：纯视频文件。
  - `"audio_and_video"`：音视频文件。

举例来说，某次录制生成第一个切片文件时，会收到回调通知该事件，其中`startUtcMS` 为第一个切片文件开始的时间。假设第 2 个 到第 N 个切片文件都是正常的，不会收到该事件通知，到第 N + 1 个切片时发生故障，导致该切片文件丢失且录制中断，此时重新开始录制后生成第 N + 2 个切片，会再次收到回调通知该事件，其中 `startUtcMs` 为第 N + 2 个切片开始的时间， `discontinueUtcMs` 为第 N 个切片结束的时间。

### <a name="43"></a>43 recorder_audio_stream_state_changed

`eventType` 为 43 表示录制的音频流状态变化，`details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `recorder_audio_stream_state_changed`。
- `streamUid`: String 类型，用户 UID，表示录制的是哪个用户的音频流。合流录制模式下，会收到 `streamUid` 为 `0` 的回调，代表合流后的音频流。
- `state`：Number 类型，云端录制服务是否正在接收音频流。
  - `0`：云端录制服务正在接收音频流
  - `1`：云端录制服务未在接收音频流
- `UtcMs`：Number 类型，音频流状态变化时的时间，UTC 时间，精确到毫秒。

### <a name="44"></a>44 recorder_video_stream_state_changed

`eventType` 为 44 表示录制的视频流状态变化，`details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `recorder_video_stream_state_changed`。
- `streamUid`: String 类型，用户 UID，表示录制的是哪个用户的视频流。合流录制模式下，会收到 `streamUid` 为 `0` 的回调，代表合流后的视频流。
- `state`：Number 类型，云端录制服务是否正在接收视频流。
  - `0`：云端录制服务正在接收视频流
  - `1`：云端录制服务未在接收视频流
- `UtcMs`：Number 类型，视频流状态变化时的时间，UTC 时间，精确到毫秒。

### <a name="60"></a>60 vod_started

`eventType` 为 60 表示阿里视频点播服务上传模块启动成功，并成功获取阿里视频点播服务的上传凭证， `details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `"vod_started"`。
- `aliVodInfo`：JSON 类型，待上传视频的相关信息。
  - `videoId`：String 类型，待上传视频的视频 ID。

### <a name="61"></a>61 vod_triggered

`eventType` 为 61 表示所有录制文件均已上传至阿里视频点播服务， `details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `"vod_triggered"`。

### <a name="70"></a>70 web_recorder_started

`eventType` 为 70 表示页面录制已启动， `details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `"web_recorder_started"`。

### <a name="71"></a>71 web_recorder_stopped

`eventType` 为 71 表示页面录制已停止， `details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `"web_recorder_stopped"`。
- `fileList`：JSONArray 类型。由每个录制文件的具体信息组成的数组。
  - `fileName`：String 类型，录制产生的 M3U8 或 MP4 文件的文件名。
  - `sliceStartTime`：Number 类型，该文件的录制开始时间，Unix 时间戳，单位为毫秒。

### <a name="72"></a>72 web_recorder_capability_limit

`eventType` 为 72 表示待录制页面使用了不受支持的功能，录制即将停止。`details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `"web_recorder_capability_limit"`。
- `limitType`：String 类型，限制类型名称，包含如下几种
  - `"resolution"`:  待录制页面中包含超过 1280 x 720 分辨率的视频源。
  - `"WebGL"`：待录制页面使用了 WebGL 功能。
  
### <a name="80"></a>80 transcoder_started

`eventType` 为 80 表示转码已启动。`details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `"transcoder_started"`。

### <a name="81"></a>81 transcoder_completed

`eventType` 为 81 表示转码已完成。`details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `"transcoder_completed"`。
- `result`: String 类型，转码结果。
  - `"all_success"`：全部文件转码成功。
  - `"partial_success"`：部分文件转码失败。
  - `"fail"`：转码失败。
- `uids`：JSONArray 类型。数组内容为每个 UID 对应的录制文件的转码结果以及 MP4 文件的文件名。
  - `uid`：String 类型，录制文件对应的 UID。
  - `result`：String 类型，转码结果。
    - `"success"`：转码成功。
    - `"fail"`：转码失败。
  - `fileList`：JSONArray 类型，数组内容为 MP4 文件的相关信息。
    - `filename`：String 类型，MP4 文件的文件名。

### <a name="90"></a>90 download_failed

`eventType` 为 90 表示下载任务失败。整个录制进程仅触发一次该回调。`details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `"download_failed"`。
- `vendor`: Number 类型，第三方云存储供应商，和你在 [`start` ](/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#start)请求中设置的 `vendor` 一致。
- `region`：Number 类型，第三方云存储指定的地区信息，和你在 [`start` ](/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#start)请求中设置的 `region` 一致。
- `bucket`：String 类型，第三方云存储的 bucket，和你在 [`start` ](/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#start)请求中设置的 bucket 一致。
- `filename`：String 类型，下载失败的 M3U8 或 TS/WebM 文件的文件名列表，文件名以 “`;`” 分隔 。



### <a name="1001"></a>1001 postpone_transcode_final_result

`eventType` 为 1001 表示转码的最终结果。`details` 中包含以下字段：

- `msgName`：String 类型，消息名称，即 `"postpone_transcode_final_result"`。
- `result`: String 类型，转码结果。
  - `"total_success"`：全部文件转码成功。
  - `"partial_success"`：部分文件转码失败。
  - `"failed"`：转码失败。
- `fileList`：JSONArray 类型，数组内容为 MP4 文件的相关信息。
  - `filename`：String 类型，MP4 文件的文件名。



## 参考

### <a name="uploaderr"></a>上传错误码

| 错误码 | 描述                   |
| :----- | :--------------------- |
| 32     | 第三方云存储信息错误   |
| 47     | 文件上传失败           |
| 51     | 上传时文件操作发生错误 |

### <a name="uploadwarn"></a>上传警告码

| 警告码 | 描述                |
| :----- | :------------------ |
| 31     | 重传到指定的云存储  |
| 32     | 重传到 Agora 备份云 |

### <a name="clouderr"></a>云端录制平台错误码

| 错误码 | 描述                 |
| :----- | :------------------- |
| 50     | 上传超时             |
| 52     | 云端录制服务启动超时 |

### <a name="state"></a>云端录制服务状态码

| 状态码 | 描述                 |
| :----- | :------------------- |
| 0      | 没有开始云端录制     |
| 1      | 云端录制初始化完成   |
| 2      | 录制组件开始启动     |
| 3      | 上传组件已启动       |
| 4      | 录制组件启动完成     |
| 5      | 已成功上传第一个文件 |
| 6      | 已经停止录制         |
| 7      | 云端录制服务全部停止 |
| 8      | 云端录制准备退出     |
| 20     | 云端录制异常退出     |

**单流录制**