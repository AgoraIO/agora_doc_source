## 功能描述

云端录制生成的录制文件包括 M3U8 索引文件、TS/WebM 切片文件和 MP4 文件。如果要对录制文件进行进一步处理，如音视频文件合并，或与其他数据流文件同步回放，你需要了解录制文件的命名规则、文件格式以及切片规则。


## 录制文件命名规则

### 单流录制模式

单流模式下，云端录制生成的录制文件的命名规则如下：

- M3U8 文件名：`<sid>_<cname>__uid_s_<uid>__uid_e_<type>.m3u8`
- TS 文件名：`<sid>_<cname>__uid_s_<uid>__uid_e_<type>_utc.ts`
- WebM 文件名：`<sid>_<cname>__uid_s_<uid>__uid_e_<type>_utc.webm`
- MP4 文件名：`<sid>_<cname>__uid_s_<uid>__uid_e_<index>.mp4`

<div class="alert note">只有开启延时转码，才会生成 MP4 文件。</div>


上述文件名中各字段含义如下：

- `<sid>`：录制 ID
- `<cname>`：频道名
- `<uid>`：用户 ID
- `<type>`: 文件类型，`audio` 或 `video`
- `<utc>`：该切片文件开始录制时的 UTC 时间，时区为 UTC+0，由年、月、日、小时、分钟、秒和毫秒组成。例如，`utc` 等于 `20190611073246073`，表示该切片文件的开始时间为 UTC 2019 年 6 月 11 日 7 点 32 分 46 秒 73 毫秒。
- `<index>`：MP4 文件的索引数，`0` 表示生成的第一个 MP4 文件。录制服务会在当前 MP4 文件时长超过约 2 小时或大小超过 2 GB 左右时创建一个新的 MP4 文件。

示例文件名 `sid713476478245_cnameagora__uid_s_123__uid_e_video_20190920125142485.ts` 中，`sid713476478245` 为录制 ID，`cnameagora` 为频道名，`123` 为用户 ID，录制时间为 2019 年 9 月 20 日 12 点 51 分 42 秒 485 毫秒。

### 合流录制模式

合流模式下，云端录制生成的录制文件的命名规则如下：

- M3U8 文件名：`<sid>_<cname>.m3u8`
- TS 文件名：`<sid>_<cname>_<utc>.ts`
- MP4 文件名：`<sid>_<cname>_<index>.mp4`

<div class="alert note">只有当你将 <code>avFileType</code> 设置为 <code>["hls","mp4"]</code> 时，才会生成 MP4 文件。</div>

上述文件名中各字段含义如下：

- `<sid>`：录制 ID
- `<cname>`：频道名
- `<utc>`：该切片文件开始录制时的 UTC 时间，时区为 UTC+0，由年、月、日、小时、分钟、秒和毫秒组成。例如 `20190611073246073` 表示该切片文件的开始时间为 UTC 2019 年 6 月 11 日 7 点 32 分 46 秒 73 毫秒。
- `<index>`: 该 MP4 文件的索引数，`0` 表示录制生成的第一个 MP4 文件。录制服务会在当前 MP4 文件时长超过 2 小时或大小超过 2 GB 时创建一个新的 MP4 文件。

### 页面录制模式

页面录制模式下，云端录制生成的录制文件的命名规则如下：

- M3U8 文件名：`<sid>_<cname>.m3u8`
- TS 文件名：`<sid>_<cname>_<utc>.ts`
- MP4 文件：`<sid>_<cname>_<index>.mp4`

<div class="alert note">只有当你在 <code>avFileType</code>中设置了 <code>"mp4"</code> 时，才会生成 MP4 文件。</div>

上述文件名中各字段含义如下：

- `<sid>`：录制 ID。
- `<cname>`: 你在 `acquire` 方法中填入的 `cname` 值。
- `<utc>`：该切片文件开始录制时的 UTC 时间，时区为 UTC+0，由年、月、日、小时、分钟、秒和毫秒组成。例如 `20190611073246073` 表示该切片文件的开始时间为 UTC 2019 年 6 月 11 日 7 点 32 分 46 秒 73 毫秒。
- `<index>`: 该 MP4 文件的索引数，`0` 表示页面生成的第一个 MP4 文件。录制服务会在当前 MP4 文件时长超过约 2 小时或大小超过 2 GB 左右时创建一个新的 MP4 文件。

<div class="alert note">由于文件名不支持特殊字符，<code>cname</code>中的特殊字符在生成文件时会被替换成 "-"。特殊字符包括："!"、 "@"、 "#"、 "$"、 "%"、 "^"、 "&"、 "*"、 "("、 ")"、 "+"、 "_"、 "."、 "="、 "["、 "]"、 "{"、 "}"、 "~"、 "|"、 "、"、 ";"、 ":"、 "?"、 "<"、 ">"。</div>

## 异常状况下的录制文件名

### 上传云存储失败

如果录制文件上传到你指定的云存储失败，云端录制会将文件通过备份云转存至你指定的云存储。为确保不覆盖最新版本，M3U8 文件名会附上后缀 `_<tick>_<index>`。

- `tick`：与该 M3U8 文件生成时的时间相关。
- `index`：该 M3U8 文件的索引数。`0` 表示第一次更新。`index` 越大，M3U8 文件的版本越新。

以文件名 `sid713476478245_cnameagora__uid_s_123__uid_e_video_22194679897_3.m3u8` 为例，`3` 为该 M3U8 文件的索引数，表示该文件为第四次更新后的 M3U8 文件。

> 当云存储中存在带有  `_<tick>_<index>` 后缀的 M3U8 文件，你需要将 `index` 最大的 M3U8 文件与无后缀的 M3U8 文件对比，选择内容较多的一个，作为最终使用的 M3U8 文件。

通过备份云转存的 TS/WebM 文件以及 MP4 文件的文件名不会附上该后缀。

### 服务器断网或进程被杀

当出现[服务器断网、进程被杀](/cn/faq/high-availability)时，云端录制会自动启用高可用机制，在 90 秒内切换到新的服务器，自动恢复录制服务。启用高可用机制后，会生成新的 M3U8 文件，包含录制服务恢复之后的切片文件索引信息。文件名增加 ` bak<n>` 前缀，`n` 为高可用机制在该次录制中被启用的 index, `0` 表示第一次启用。

以文件名 `bak0_sid713476478245_cnameagora.m3u8` 为例，`bak0` 表示该文件为本次录制中第一次启用高可用机制后生成的 M3U8 文件。

启用高可用机制后，录制生成的 TS/WebM 文件以及 MP4 文件的文件名也会增加 `bak<n>` 前缀。


## 录制文件大小

单流模式下，录制文件大小主要与音视频源的码率和录制时长相关。例如，当音频码率为 48 Kbps，视频码率为 500 Kbps，录制文件时长为 30 分钟时，该录制文件的大小约为 (48 Kbps + 500 Kbps) * 60 s/min * 30 min = 986.4 Mbit，即 123.3 MB。

合流模式下，录制文件大小主要与转码设置中的码率和录制时长相关，如果你未进行转码设置，则使用默认值。例如，当你在 `start` 方法中设置 `audioProfile` 为 `1` (音频码率 128 Kbps)，设置 `bitrate` （视频码率）为 `800`，录制文件时长为 30 分钟时，该文件的大小约为 (128 Kbps + 800 Kbps) * 60 s/min * 30 min = 1670.4 Mbit，即 208.8 MB。



## M3U8 文件

M3U8 文件包含多个切片文件的文件名及其描述符。Agora 云端录制产生的 M3U8 文件中用到的描述符有三种：

- `#EXT-X-AGORA-TRACK-EVENT:EVENT=<event>,TRACK_TYPE=<type>,TIME=<utc>`：音视频流开始或者中断后重新开始的第一个切片文件会附带这一描述符，描述流状态的变化。
  - `EVENT`: 事件名称，目前只能为 `START`，表示音视频开始或中断后重新开始
  - `TRACK_TYPE`：切片文件内容，`AUDIO` 或 `VIDEO`
  - `TIME`: 流状态变化的时间。UTC 时间，时区为 UTC+0

- `#EXT-X-AGORA-ROTATE:WIDTH=<width>,HEIGHT=<height>,ROTATE=<rotate>,TIME=<utc>`：视频旋转后第一个切片文件会附带这一描述符，描述视频旋转的信息。一个切片文件可能附带多个视频旋转的描述符。
  - `WIDTH`：视频宽度
  - `HEIGHT`：视频高度
  - `ROTATE`：视频逆时针旋转的角度，只能为 `0`、`90`、`180` 或 `270`
  - `TIME`：视频发生旋转的时间。UTC 时间，时区为 UTC+0。
- `#EXTINF:<length>`：描述切片文件的时长，单位为秒。

例如：

```m3u8
#EXT-X-AGORA-ROTATE:WIDTH=640,HEIGHT=480,ROTATE=90,TIME=20190920125142485
#EXT-X-AGORA-TRACK-EVENT:EVENT=START,TRACK_TYPE=VIDEO,TIME=20190920125142485
#EXTINF:6.332000
sid713476478245_cnameagora__uid_s_123__uid_e_video_20190920125142485.ts
```

<div class="alert note">如果某些播放器因 <code>#EXTINF:&#60;length&#62;</code> 后没有逗号而出现兼容性问题，你可以在 <a href="https://docs.agora.io/cn/cloud-recording/restfulapi/#/%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6/start">start</a> 请求中的 <code>recordingConfig</code> 参数中配置参数 <code>privateParams</code>，即 <code>"recordingConfig": {"privateParams":"{"correctEXTINF":true}", ...}</code> </div>


## 切片规则

### 视频文件切片

当满足以下任一条件时，云端录制即会对视频文件进行切片：

- 切片时长达到 15 秒，并遇到视频关键帧
- 编码器发生变化
- 视频宽高发生变化
- 视频流发生中断
- 当使用 H.264 编码，单片视频时长超过 5.5 分钟，或单个文件大小超过 50M，云端录制会强制切片。强制切片后，新切片的首帧可能非 I 帧，导致该切片文件不能直接解码播放。例如在通信模式下，数小时内可能仅出现一个 I 帧，容易出现新切片的首帧非 I 帧。

当在 Web 端使用 VP8 编码时，云端录制不会强制切片。

### 音频文件切片

当切片时长达到 15 秒，并遇到音频关键帧时，云端录制即会对音频文件进行切片。

## 音频 M3U8 文件示例

```
#EXTM3U
#EXT-X-VERSION:3
#EXT-X-MEDIA-SEQUENCE:0
#EXT-X-ALLOW-CACHE:YES
#EXT-X-TARGETDURATION:18
#EXT-X-DISCONTINUITY
#EXT-X-AGORA-TRACK-EVENT:EVENT=START,TRACK_TYPE=AUDIO,TIME=20190920125142289
#EXTINF:15.019000
sid713476478245_cnameagora__uid_s_123__uid_e_audio_20190920125142289.ts
#EXTINF:15.019000
sid713476478245_cnameagora__uid_s_123__uid_e_audio_20190920125157307.ts
#EXTINF:15.019000
sid713476478245_cnameagora__uid_s_123__uid_e_audio_20190920125212326.ts
#EXTINF:15.019000
sid713476478245_cnameagora__uid_s_123__uid_e_audio_20190920125227345.ts
#EXTINF:12.523000
sid713476478245_cnameagora__uid_s_123__uid_e_audio_20190920125242363.ts
#EXT-X-ENDLIST
```

## 视频 M3U8 文件示例

```
#EXTM3U
#EXT-X-VERSION:3
#EXT-X-MEDIA-SEQUENCE:0
#EXT-X-ALLOW-CACHE:YES
#EXT-X-TARGETDURATION:34
#EXT-X-DISCONTINUITY
#EXT-X-AGORA-ROTATE:WIDTH=640,HEIGHT=480,ROTATE=0,TIME=20190920125142485
#EXT-X-AGORA-TRACK-EVENT:EVENT=START,TRACK_TYPE=VIDEO,TIME=20190920125142485
#EXTINF:6.332000
sid713476478245_cnameagora__uid_s_123__uid_e_video_20190920125142485.ts
#EXT-X-AGORA-ROTATE:WIDTH=1280,HEIGHT=720,ROTATE=0,TIME=20190920125149174
#EXT-X-DISCONTINUITY
#EXTINF:17.442000
sid713476478245_cnameagora__uid_s_123__uid_e_video_20190920125149174.ts
#EXT-X-DISCONTINUITY
#EXT-X-AGORA-ROTATE:WIDTH=640,HEIGHT=480,ROTATE=0,TIME=20190920125206616
#EXTINF:33.326000
sid713476478245_cnameagora__uid_s_123__uid_e_video_20190920125206616.ts
#EXT-X-DISCONTINUITY
#EXT-X-AGORA-ROTATE:WIDTH=1280,HEIGHT=720,ROTATE=0,TIME=20190920125239942
#EXTINF:14.815000
sid713476478245_cnameagora__uid_s_123__uid_e_video_20190920125239942.ts
#EXT-X-ENDLIST
```