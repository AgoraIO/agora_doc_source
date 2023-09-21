声网针对多人连麦直播场景研发云端转码服务，支持在服务端将单个或多个主播的音视频流转码合流并输入到声网 RTC 频道。频道内观众仅需订阅转码合流后的音视频流即可观看直播。

使用云端转码服务后，观众无需订阅多个主播的音视频流，可大幅节省下行带宽压力和客户端设备性能消耗。

本文介绍如何通过 RESTful API 实现云端转码，以及如何保障 REST 服务高可用。

## 前提条件

- 声网 RESTful API 要求 Basic HTTP 认证，请确保完成 [HTTP 基本认证](https://docs.agora.io/cn/cloud-recording/faq/restful_authentication)。
- 请确保已[联系声网技术支持](https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms)开通云端转码服务。

## 技术原理

声网服务端将多路流转码合流的过程相当于创建一个 cloud transcoder。转码前的多路流是 cloud transcoder 的输入，转码后的流是 cloud transcoder 的输出。

你可以通过云端转码 RESTful API 控制 cloud transcoder：

- `Acquire`：在开始云端转码前，必须先获取云端转码资源，用于云端转码任务。
- `Create`：创建 cloud transcoder。声网服务器会开始将你指定的多路流转码合流并输入到声网 RTC 频道。
- `Delete`：销毁 cloud transcoder。声网服务器会停止转码合流。
- `Query`：查询 cloud transcoder 信息。声网服务器会查询你指定的 cloud transcoder 的状态信息。

## Acquire：获取云端转码资源

在开始录制前，必须先调用 `Acquire` 方法获取一个云端转码资源。

调用该方法成功后，你可以在响应包体中得到一个 builderToken。builderToken 的时效为 5 分钟，你需要在 5 分钟内使用该 builderToken 开始云端转码。一个 builderToken 仅可用于一次云端转码任务。

### HTTP 请求

```http
POST https://api.sd-rtn.com/v1/projects/{appId}/rtsc/cloud-transcoder/builderTokens
```

`appId`: String 型必填参数。声网为每个开发者提供的 App ID。在声网控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。

#### 请求头

- `Content-Type`: `application/json`
- `Authorization`: 该字段的值需参考[认证说明](https://docs.agora.io/cn/faq/restful_authentication)

#### 请求包体

需要在请求包体中传入以下参数：

| 字段         | 类型         | 描述                                                         |
| :----------- | :----------- | :----------------------------------------------------------- |
| `instanceId` | String，必填 | 用户指定的实例 ID。长度必须在 64 个字符以内，支持的字符集范围为：<li>所有小写英文字母（a-z）<li>所有大写英文字母（A-Z）<li>数字 0-9<li>"-", "_"<br>一个 `instanceId` 可以生成多个 builderToken，但在一个任务中只能使用一个 builderToken 发起请求。 |

请求包体示例：

```json
{
  "instanceId" : "abc13328"
}
```

### HTTP 响应

#### 响应头

`X-Request-ID`: UUID（通用唯一识别码），用于标识本次请求。
  <div class="alert note"><ul><li>如果请求出错，请在日志中打印出该值，排查问题。</li><li>如果本次请求的响应状态码不是 2XX，那么响应 header 中可能无该字段。</li></ul></div>

#### 响应包体

如果状态码为 2XX，则请求成功。响应包体包含以下字段：

| 字段         | 类型   | 描述                                                  |
| :----------- | :----- | :---------------------------------------------------- |
| `tokenName`  | String | builderToken 的值，在后续调用其他方法时需要传入该值。 |
| `createTs`   | Number | 生成 builderToken 时的 Unix 时间戳（秒）。            |
| `instanceId` | Number | 请求时设置的 `instanceId`。                           |

响应包体示例：

```json
{
    "createTs": 1661324606,
    "instanceId": "abc13328",
    "tokenName": "nUwUbQf9Zg6tsgtLslGnDg0lk8RYaUE0***"
}
```

## Create：创建 cloud transcoder

### HTTP 请求

```
POST https://api.sd-rtn.com/v1/projects/{appId}/rtsc/cloud-transcoder/tasks?builderToken={tokenName}
```

#### 路径参数

`appId`: String 型必填字段。声网为每个开发者提供的 App ID。在声网控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。

#### 查询参数

`builderToken`: String 型必填字段。通过 `Acquire` 方法获取 builderToken 的参数值 `tokenName`。

#### 请求头

- `Content-Type`: `application/json`
- `Authorization`: 该字段的值需参考[认证说明](https://docs.agora.io/cn/faq/restful_authentication)

<a name="create"></a>
#### 请求包体

请求包体为 JSON Object 类型的 `services` 字段。字段结构如图所示：

![](https://web-cdn.agora.io/docs-files/1664351637544)

- `services` 包含如下字段：

  | 字段                                | 类型              | 描述                                                         |
  | :---------------------------------- | :---------------- | :----------------------------------------------------------- |
  | cloudTranscoder                   | JSON Object，必填 | 服务名称，开发者自行设置。需要保证一个 cloud transcoder 中使用的服务名称唯一。 |
  | cloudTranscoder.serviceType      | String，必填      | 服务类型。云端转码：`cloudTranscoderV2`。                    |
  | cloudTranscoder.config           | JSON Object，必填 | 云端转码参数设置。用于设置 cloud transcoder 的业务参数。     |
  | cloudTranscoder.config.transcoder | String，必填      | Cloud transcoder 的对象。                                    |

- `transcoder` 包含如下字段：

  | 字段                               | 类型              | 描述                                                         |
  | :--------------------------------- | :---------------- | :----------------------------------------------------------- |
  | idleTimeout                        | Number，可选      | Cloud transcoder 处于空闲状态的最大时长（秒）。空闲指 cloud transcoder 处理的音视频流所对应的所有主播均已离开频道。空闲状态超过设置的 `idleTimeOut` 后， cloud transcoder 会自动销毁。取值范围为 [1,86400]，默认值为 300。 |
  | audioInputs []                     | JSON Object，可选 | Cloud transcoder 的音频输入源配置。<li>如果你不传值，声网会将 `videoInputs[].rtc.rtcUid` 对应的输入源作为 cloud transcoder 的音频输入源。这种取值方式适用于对主播的音频和视频都转码的场景。<li>如果你传值，声网会将你指定的音频输入源进行转码混音。这种取值方式适用于 `audioInputs[].rtc.rtcUid` 和 `videoInputs[].rtc.rtcUid` 不完全一致的场景，即部分主播的视频转码但音频不转码。 |
  | audioInputs[].rtc                  | JSON Array，必填  | Cloud transcoder 的 RTC 音频输入源。支持多个 RTC 输入源。    |
  | audioInputs[].rtc.rtcChannel       | String，必填      | 输入源所属的 RTC 频道名。目前仅支持订阅单个频道的音视频源，音频源和视频源所属频道必须相同。 |
  | audioInputs[].rtc.rtcUid           | Number，必填      | 音频输入源所对应的 UID。RTC 频道内不允许存在相同的 UID。         |
  | audioInputs[].rtc.rtcToken         | String，必填      | Cloud transcoder 在进入待转码音频源所属 RTC 频道时所需设置的 Token。该值可用于确保频道安全，避免异常用户扰乱频道内其他用户。详见[使用 Token 鉴权](https://docs.agora.io/cn/live-streaming-premium-4.x/token_server_android_ng?platform=Android)。Cloud transcoder 在待转码音视频源所属 RTC 频道内的 UID 为声网随机分配，因此，生成 Token 时，你使用的 `uid` 必须为 0。 |
  | videoInputs []                     | JSON Array，必填  | Cloud transcoder 的视频输入配置。                            |
  | videoInputs[].rtc                  | JSON Array，必填  | Cloud transcoder 的 RTC 视频输入源。支持多个 RTC 输入源。    |
  | videoInputs[].rtc.rtcChannel       | String，必填      | 视频输入源所属的 RTC 频道名。目前仅支持订阅单个频道的音视频源，音频源和视频源所属频道必须相同。 |
  | videoInputs[].rtc.rtcUid           | Number，必填      | 视频输入源所对应的 UID。RTC 频道内不允许存在相同的 UID。 |
  | videoInputs[].rtc.rtcToken         | String，必填      | Cloud transcoder 在进入待转码视频源所属 RTC 频道时所需设置的 Token。该值可用于确保频道安全，避免异常用户扰乱频道内其他用户。详见[使用 Token 鉴权](https://docs.agora.io/cn/live-streaming-premium-4.x/token_server_android_ng?platform=Android)。Cloud transcoder 在待转码音视频源所属 RTC 频道内的 UID 为声网随机分配，因此，生成 Token 时，你使用的 `uid` 必须为 0。 |
  | videoInputs[].region               | JSON Object，必填 | 视频输入源画面在画布上的位置。                               |
  | videoInputs[].region.x             | Number，必填      | 画面在画布上的 x 坐标 (px)。以画布左上角为原点，x 坐标为画面左上角相对于原点的横向位移。取值范围为 [0,3840]。 |
  | videoInputs[].region.y             | Number，必填      | 画面在画布上的 y 坐标 (px)。以画布左上角为原点，y 坐标为画面左上角相对于原点的纵向位移。取值范围为 [0,3840]。 |
  | videoInputs[].region.width         | Number，必填      | 画面的宽度 (px)。取值范围为 [120,3840]。                     |
  | videoInputs[].region.height        | Number，必填      | 画面的高度 (px)。取值范围为 [120,3840]。                     |
  | videoInputs[].region.zOrder        | Number，必填      | 画面的图层编号。取值范围为 [0,100]。0 代表最下层的图层。100 代表最上层的图层。 |
  | videoInputs [].placeholderImageUrl | String，必填      | 用户离线时占位图片的 URL。必须为合法 URL，且包含 `jpg` 或 `png` 后缀。 |
  | canvas                             | JSON Object，必填 | 承载 cloud transcoder 合图的画布。                           |
  | canvas.height                      | Number，必填      | 画布的高度 (px)。取值范围为 [120,3840]。                     |
  | canvas.width                       | Number，必填      | 画布的宽度 (px)。取值范围为 [120,3840]。                     |
  | canvas.color                       | String，必填      | 画布的背景色。RGB 颜色值，以十进制数表示。如 0 代表黑色，255 代表蓝色。取值范围为 [0,16777215]。 |
  | canvas.backgroundImage             | String，可选      | 画布背景图。必须为合法 URL，且包含 `jpg` 或 `png` 后缀。     |
  | canvas.fillMode                    | String，可选      | 画布背景图的填充模式。<li>（默认）`FILL`：在保持长宽比的前提下，缩放画面，并居中剪裁。<br>![img](https://web-cdn.agora.io/docs-files/1628837665989)<li>`FIT`：在保持长宽比的前提下，缩放画面，使其完整显示。<br>![img](https://web-cdn.agora.io/docs-files/1628837708782) |
  | waterMarks []                      | JSON Array，可选  | Cloud transcoder 的水印输入配置。                            |
  | waterMarks [].imageUrl             | String，必填      | 水印图片的 URL。必须为合法 URL，且包含 `jpg` 或 `png` 后缀。 |
  | waterMarks [].fillMode             | String，可选      | 水印的填充模式。<li>（默认）`FILL`：在保持长宽比的前提下，缩放画面，并居中剪裁。 <br>![img](https://web-cdn.agora.io/docs-files/1628837665989)<li>`FIT`：在保持长宽比的前提下，缩放画面，使其完整显示。 <br> ![img](https://web-cdn.agora.io/docs-files/1628837708782) |
  | waterMarks [].region               | JSON Object，必填 | 水印在画布上的位置。                                         |
  | waterMarks [].region.x             | Number，必填      | 水印在画布上的 x 坐标 (px)。以画布左上角为原点，x 坐标为画面左上角相对于原点的横向位移。取值范围为 [0,3840]。 |
  | waterMarks [].region.y             | Number，必填      | 水印在画布上的 y 坐标 (px)。以画布左上角为原点，y 坐标为画面左上角相对于原点的纵向位移。取值范围为 [0,3840]。 |
  | waterMarks [].region.width         | Number，必填      | 水印的宽度 (px)。取值范围为 [120,3840]。                     |
  | waterMarks [].region.height        | Number，必填      | 水印的高度 (px)。取值范围为 [120,3840]。                     |
  | waterMarks [].region.zOrder        | Number，必填      | 水印的图层编号。取值范围为 [0,100]。0 代表最下层的图层。100 代表最上层的图层。 |
  | outputs.rtc                        | JSON Object，必填 | cloud transcoder 的输出配置。                                |
  | outputs.rtc.rtcChannel             | String，必填      | 转码输出的音视频流所属的 RTC 频道名。                                  |
  | outputs.rtc.rtcToken               | String，必填      | Cloud transcoder 在进入输出音视频流所属 RTC 频道时所需设置的 Token。该值可用于确保频道安全，避免异常用户扰乱频道内其他用户。详见[使用 Token 鉴权](https://docs.agora.io/cn/live-streaming-premium-4.x/token_server_android_ng?platform=Android)。Cloud transcoder 在转码输出音视频流所属 RTC 频道内的 UID 为你指定的 `outputs.rtc.rtcUid`，因此，生成 Token 时，你使用的 `uid` 必须和 `outputs.rtc.rtcUid` 一致。 |
  | outputs.rtc.rtcUid                 | Number，必填      | Cloud transcoder 在转码输出音视频流所属 RTC 频道内的 UID。RTC 频道内不允许存在相同的 UID，因此，请确保该值与频道内其他用户 UID 不同。       |
  | outputs.audioOption                | JSON Object，可选 | 音频流的转码混音配置。如果你不传值，声网转码输出的音频属性为 `AUDIO_PROFILE_DEFAULT`，即 48 kHz 采样率，音乐编码，单声道，编码码率最大值为 64 Kbps。 |
  | outputs.audioOption.profileType    | String，可选      | 转码输出的音频属性。支持取值：<li>`AUDIO_PROFILE_DEFAULT`：默认值，48 kHz 采样率，音乐编码，单声道，编码码率最大值为 64 Kbps。<li>`AUDIO_PROFILE_SPEECH_STANDARD`：32 kHz 采样率，语音编码，单声道，编码码率最大值为 18 Kbps。<li>`AUDIO_PROFILE_MUSIC_STANDARD`: 48 KHz 采样率，音乐编码，单声道，编码码率最大值为 64 Kbps。<li>`AUDIO_PROFILE_MUSIC_STANDARD_STEREO`：48 KHz 采样率，音乐编码，双声道，编码码率最大值为 80 Kbps。<li>`AUDIO_PROFILE_MUSIC_HIGH_QUALITY`：48 KHz 采样率，音 乐编码，单声道，编码码率最大值为 96 Kbps。<li>`AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO`：48 KHz 采样率，音乐编码，双声道，编码码率最大值为 128 Kbps。 |
  | outputs.videoOption                | JSON Object，必填 | 视频流的转码合图配置。                                       |
  | outputs.videoOption.fps            | Number，可选      | 转码输出视频的帧率 (fps)。取值范围为 [1,30]。默认值为 15。   |
  | outputs.videoOption.codec          | String，必填      | 转码输出视频的 codec。取值包括：<li>`H264`：标准 H.264 编码<li>`VP8`：标准 VP8 编码                |
  | outputs.videoOption.bitrate        | Number，可选      | 转码输出视频的码率。取值范围为 [1,10000]。如果你不传值，声网会根据网络情况和其他视频属性自动设置视频码率。 |
  | outputs.videoOption.width          | Number，必填      | 转码输出视频的宽度 (px)。取值范围为 [120,3840]。             |
  | outputs.videoOption.height         | Number，必填      | 转码输出视频的高度 (px)。取值范围为 [120,3840]。             |

#### 请求包体示例

**场景一：音视频 + 水印 + 画布**

将 UID 为 `123`、`456` 两个主播的音视频流转码合流并输入到 test 频道中。

```json
{
    "services":{
        "cloudTranscoder":{
            "serviceType":"cloudTranscoderV2",
            "config":{
                "transcoder":{
                    "idleTimeout":300,
                    "audioInputs":[
                        {
                            "rtc":{
                                "rtcChannel":"test01",
                                "rtcUid": 123,
                                "rtcToken":"aab8b8f5a8cd4469a63042fcfafe7***"
                            }
                        },
                        {
                            "rtc":{
                                "rtcChannel":"test01",
                                "rtcUid": 456,
                                "rtcToken":"aab8b8f5a8cd4469a63042fcfafe7***"
                            }
                        }
                    ],
                    "canvas":{
                        "width":960,
                        "height":480,
                        "color":0,
                        "backgroundImage":"https://XXXX.jpg",
                        "fillMode": "FIT"
                    },
                    "waterMarks":[
                        {
                            "imageUrl":"https://XXXX.png",
                            "region":{
                                "x":0,
                                "y":0,
                                "width":100,
                                "height":100,
                                "zOrder":50
                            }
                        }
                    ],
                    "videoInputs":[
                        {
                            "rtc":{
                                "rtcChannel":"test01",
                                "rtcUid": 123,
                                "rtcToken":"aab8b8f5a8cd4469a63042fcfafe7***"
                            },
                            "placeholderImageUrl":"https://XXXX.jpg",
                            "region":{
                                "x":0,
                                "y":0,
                                "width":320,
                                "height":360,
                                "zOrder":1
                            }
                        },
                        {
                            "rtc":{
                                "rtcChannel":"test01",
                                "rtcUid": 456,
                                "rtcToken":"aab8b8f5a8cd4469a63042fcfafe7***"
                            },
                            "placeholderImageUrl":"https://XXXX.jpg",
                            "region":{
                                "x":320,
                                "y":0,
                                "width":320,
                                "height":320,
                                "zOrder":1
                            }
                        }
                    ],
                    "outputs":[
                        {
                            "rtc":{
                                "rtcChannel":"test",
                                "rtcUid":1000,
                                "rtcToken":"aab8b8f5a8cd4469a63042fcfafe7***"
                            },
                            "audioOption":{
                                "profileType":"AUDIO_PROFILE_MUSIC_STANDARD"
                            },
                            "videoOption":{
                                "fps":30,
                                "codec":"H264",
                                "bitrate":800,
                                "width":960,
                                "height":480,
                                "lowBitrateHighQuality":false
                            }
                        }
                    ]
                }
            }
        }
    }
}
```

**场景二：纯音频 + 画布**

```json
{
    "services":{
        "cloudTranscoder":{
            "serviceType":"cloudTranscoderV2",
            "config":{
                "transcoder":{
                    "idleTimeout":180,
                    "audioInputs":[
                        {
                            "rtc":{
                                "rtcChannel":"test01",
                                "rtcUid": 123,
                                "rtcToken":"aab8b8f5a8cd4469a63042fcfafe7***"
                            }
                        },
                        {
                            "rtc":{
                                "rtcChannel":"test01",
                                "rtcUid": 456,
                                "rtcToken":"aab8b8f5a8cd4469a63042fcfafe7***"
                            }
                        }
                    ],
                    "canvas":{
                        "width":960,
                        "height":480,
                        "color":0,
                        "backgroundImage":"https://XXXX.jpg"
                    },
                    "outputs":[
                        {
                            "rtc":{
                                "rtcChannel":"test02",
                                "rtcUid":1000,
                                "rtcToken":"aab8b8f5a8cd4469a63042fcfafe7***"
                            },
                            "audioOption":{
                                "profileType":"AUDIO_PROFILE_MUSIC_STANDARD"
                            }
                        }
                    ]
                }
            }
        }
    }
}
```

**场景三：全频道混音 + 画布**

```json
{
    "services":{
        "cloudTranscoder":{
            "serviceType":"cloudTranscoderV2",
            "config":{
                "transcoder":{
                    "idleTimeout":180,
                    "audioInputs":[
                        {
                            "rtc":{
                                "rtcChannel":"test01",
                                "rtcUid": 0,
                                "rtcToken":"aab8b8f5a8cd4469a63042fcfafe7***"
                            }
                        }
                    ],
                    "canvas":{
                        "width":960,
                        "height":480,
                        "color":0,
                        "backgroundImage":"https://XXXX.jpg"
                    },
                    "outputs":[
                        {
                            "rtc":{
                                "rtcChannel":"test02",
                                "rtcUid":1000,
                                "rtcToken":"aab8b8f5a8cd4469a63042fcfafe7***"
                            },
                            "audioOption":{
                                "profileType":"AUDIO_PROFILE_MUSIC_STANDARD"
                            }
                        }
                    ]
                }
            }
        }
    }
}
```

### HTTP 响应

#### 响应头

`X-Request-ID`: UUID（通用唯一识别码），用于标识本次请求。
  <div class="alert note"><ul><li>如果请求出错，请在日志中打印出该值，排查问题。</li><li>如果本次请求的响应状态码不是 2XX，那么响应 header 中可能无该字段。</li></ul></div>

#### 响应包体

如果状态码为 2XX，则请求成功。响应包体包含的字段结构如下图所示：

![](https://web-cdn.agora.io/docs-files/1664351656358)

字段含义详见下表：

| 字段                                         | 类型         | 描述                                                         |
| :------------------------------------------- | :----------- | :----------------------------------------------------------- |
| taskId                                   | JSON Object  | 任务 ID，为 UUID，用于标识本次请求创建的 cloud transcoder。  |
| createTs                                   | Number       | 创建云端转码任务时的 Unix 时间戳（秒）。                             |
| status                                     | String       | 创建任务的运行状态：<li>`"IDLE"`: 任务未开始<li>`"PREPARED"`: 任务已收到开启请求<li>`"STARTING"`: 任务正在开启<li>`"CREATED"`: 任务初始化完成<li>`"STARTED"`: 任务已经启动<li>`"IN_PROGRESS"`: 任务正在进行<li>`"STOPPING"`: 任务正在停止<li>`"STOPPED"`: 任务已经停止<li>`"EXIT"`: 任务正常退出<li>`"FAILURE_STOP"`: 任务异常退出 |
| services                                   | JSON Object  | 任务中包含的服务信息。                                       |
| services.cloudTranscoder                   | JSON Object  | 服务名称。                                                   |
| services.cloudTranscoder.serviceType    | String       | 服务类型。云端转码：`"cloudTranscoderV2"`。                    |
| services.cloudTranscoder.config           | JSON Object  | 服务参数。                                                   |
| services.cloudTranscoder.config.transcoder | String，必填 | Cloud transcoder 对象。包含的字段及含义请参考请求包体字段及含义。 |
| services.cloudTranscoder.createTs            | Number       | 创建 cloud transcoder 时的 Unix 时间戳（秒）。               |
| services.cloudTranscoder.status           | String       | 服务的运行状态：<li>`"serviceIdle"`: 服务未开始<li>`"serviceReady"`: 服务已经就绪<li>`"serviceStarted"`: 服务已经开始<li>`"serviceInProgress"`: 服务正在进行<li>`"serviceCompleted"`: 服务已经停止，任务全部完成<li>`"servicePartialCompleted"`: 服务已经停止，任务部分完成<li>`"serviceValidationFailed"`: 服务参数验证失败<li>`"serviceAbnormal"`: 服务异常退出<li>`"serviceUnknown"`: 服务未知状态 |
| services.cloudTranscoder.message           | String       | 服务的执行信息，描述服务异常的具体原因。                     |
| services.cloudTranscoder.details          | JSON Object  | 服务的执行细节。                                             |
| eventHandlers                              | String       | 预留字段。                                                   |
| execution                                 | JSON Object  | 预留字段。                                                   |
| execution.workflows                     | String       | 预留字段。                                                   |
| properties                               | String       | 预留字段。                                                   |
| sequenceId                                | String       | 预留字段。                                                   |
| variables                                    | JSON Object  | 预留字段。                                                   |
| workflows                                    | JSON Object  | 预留字段。                                                   |

响应包体示例：

```json
{
    "createTs": 1661324613,
    "eventHandlers": {},
    "execution": {
        "workflows": {}
    },
    "properties": {},
    "sequenceId": "0",
    "services": {
        "cloudTranscoder": {
            "config": {},
            "createTs": 1661324614,
            "details": {},
            "message": "",
            "serviceType": "cloudTranscoderV2",
            "status": "serviceReady"
        }
    },
    "status": "STARTED",
    "taskId": "609f28f2644f1ae1ceb041b7047e3***",
    "variables": {},
    "workflows": {}
}
```

## Delete：销毁 cloud transcoder

### HTTP 请求

```
DELETE https://api.sd-rtn.com/v1/projects/{appId}/rtsc/cloud-transcoder/tasks/{taskId}?builderToken={tokenName}
```

#### 路径参数

- `appId`: String 型必填字段。声网为每个开发者提供的 App ID。在声网控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。
- `taskId`: cloud transcoder 的任务 ID，为 UUID，用于标识本次请求创建的 cloud transcoder。

#### 查询参数

`builderToken`: String 型必填字段。通过 `Acquire` 方法获取 builderToken 的参数值 `tokenName`。

#### 请求头

- `Content-Type`: `application/json`
- `Authorization`: 该字段的值需参考[认证说明](https://docs.agora.io/cn/faq/restful_authentication)

### HTTP 响应

#### 响应头

`X-Request-ID`: UUID（通用唯一识别码），用于标识本次请求。
  <div class="alert note"><ul><li>如果请求出错，请在日志中打印出该值，排查问题。</li><li>如果本次请求的响应状态码不是 2XX，那么响应 header 中可能无该字段。</li></ul></div>

#### 响应包体

如果状态码为 2XX，则请求成功。响应包体包含以下字段：

![](https://web-cdn.agora.io/docs-files/1664351673569)

字段含义详见下表：

| 字段                                         | 类型         | 描述                                                         |
| :------------------------------------------- | :----------- | :----------------------------------------------------------- |
| taskId                                    | JSON Object  | 任务 ID，为 UUID，用于标识本次请求创建的 cloud transcoder。  |
| createTs                                   | Number       | 创建任务时的 Unix 时间戳（秒）。                             |
| status                                     | String       | 创建任务的运行状态：<li>`IDLE`: 任务未开始<li>`PREPARED`: 任务已收到开启请求<li>`STARTING`: 任务正在开启<li>`CREATED`: 任务初始化完成<li>`STARTED`: 任务已经启动<li>`IN_PROGRESS`: 任务正在进行<li>`STOPPING`: 任务正在停止<li>`STOPPED`: 任务已经停止<li>`EXIT`: 任务正常退出<li>`FAILURE_STOP`: 任务异常退出 |
| services                                  | JSON Object  | 任务中包含的服务信息。                                       |
| services.cloudTranscoder                   | JSON Object  | 服务名称。                                                   |
| services.cloudTranscoder.serviceType       | String       | 服务类型。云端转码：`cloudTranscoderV2`。                    |
| services.cloudTranscoder.config            | JSON Object  | 服务参数。                                                   |
| services.cloudTranscoder.config.transcoder | String，必填 | Cloud transcoder 对象。包含的字段及含义请参考请求包体字段及含义。 |
| services.cloudTranscoder.createTs            | Number       | 创建 cloud transcoder 时的 Unix 时间戳（秒）。               |
| services.cloudTranscoder.status            | String       | 服务的运行状态：<li>`serviceIdle`: 服务未开始<li>`serviceReady`: 服务已经就绪<li>`serviceStarted`: 服务已经开始<li>`serviceInProgress`: 服务正在进行<li>`serviceCompleted`: 服务已经停止，任务全部完成<li>`servicePartialCompleted`: 服务已经停止，任务部分完成<li>`serviceValidationFailed`: 服务参数验证失败<li>`serviceAbnormal`: 服务异常退出<li>`serviceUnknown`: 服务未知状态 |
| services.cloudTranscoder.message           | String       | 服务的执行信息，描述服务异常的具体原因。                     |
| services.cloudTranscoder.details          | JSON Object  | 服务的执行细节。                                             |
| eventHandlers                              | String       | 预留字段。                                                   |
| execution                                  | JSON Object  | 预留字段。                                                   |
| execution.workflows                        | String       | 预留字段。                                                   |
| properties                                 | String       | 预留字段。                                                   |
| sequenceId                                 | String       | 预留字段。                                                   |
| variables                                    | JSON Object  | 预留字段。                                                   |
| workflows                                    | JSON Object  | 预留字段。                                                   |

响应包体示例：

```json
{
    "createTs": 1661324613,
    "eventHandlers": {},
    "execution": {
        "workflows": {}
    },
    "properties": {},
    "sequenceId": "0",
    "services": {
        "cloudTranscoder": {
            "config": {},
            "createTs": 1661324614,
            "details": {},
            "message": "OnSlaveServiceStopped",
            "serviceType": "cloudTranscoderV2",
            "status": "serviceCompleted"
        }
    },
    "status": "STOPPED",
    "taskId": "609f28f2644f1ae1ceb041b7047e3***",
    "variables": {},
    "workflows": {}
}
```

## Update：更新指定的 cloud transcoder

### HTTP 请求

```http
PATCH https://api.sd-rtn.com/v1/projects/{appId}/rtsc/cloud-transcoder/tasks/{taskId}?builderToken={tokenName}&sequenceId={sequenceId}&updateMask=services.cloudTranscoder.config
```

#### 路径参数

- `appId`: String 型必填字段。声网为每个开发者提供的 App ID。在声网控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。
- `taskId`: cloud transcoder 的任务 ID，为 UUID，用于标识本次请求创建的 cloud transcoder。

#### 查询参数

- `builderToken`: String 型必填字段。通过 `Acquire` 方法获取 `builderToken` 的参数值 `tokenName`。
- `sequenceId`：Number 型必填字段。`Update` 请求的序列号。取值需要大于或等于 0。请确保后一次 `Update` 请求的序列号大于前一次 `Update` 请求的序列号。序列号可以确保声网服务器按照你指定的最新配置来更新 cloud transcoder。

>声网推荐你在第一次调用 `Update` 时，将 `sequence` 设置为 `0`。在第二次调用 `Update` 时，将 `sequence` 填 `1`。在第三次调用 `Update` 时，将 `sequence` 填 `2`。依次类推。声网服务器会按照最新 `Update` 请求（即最大的序列号）更新 cloud transcoder。

```http
PATCH https://api.sd-rtn.com/v1/projects/{appId}/rtsc/cloud-transcoder/tasks/{taskId}?builderToken={tokenName}&sequenceId={sequenceId}&updateMask=services.cloudTranscoder.config
```

#### 请求头

- `Content-Type`: `application/json`
- `Authorization`: 该字段的值需参考[认证说明](https://docs.agora.io/cn/faq/restful_authentication)

#### 请求包体

请求包体包含字段及含义详见 [Create 请求包体](#create)。

### HTTP 响应

#### 响应头

`X-Request-ID`: UUID（通用唯一识别码），用于标识本次请求。
  <div class="alert note"><ul><li>如果请求出错，请在日志中打印出该值，排查问题。</li><li>如果本次请求的响应状态码不是 2XX，那么响应 header 中可能无该字段。</li></ul></div>

#### 响应包体

- 如果状态码为 2XX，则请求成功。包体为空。

- 如果状态码不为 2XX，请求失败。包体中包含 String 类型的 `message` 字段，描述失败的具体原因。


### 请求示例

`Update` 仅支持在以下场景中更新 cloud transcoder：

- 订阅或取消订阅频道内的主播的音视频流
新增或删除 `audioInputs[]`、`videoInputs[]` 中的 `rtc` 成员。
- 更新合图布局中各主播的位置
修改 `videoInputs[]` 中的 `region` 字段
- 更新输出音视频的音频配置项、视频配置项
更新 `outputs[]` 中的 `audioOption`、`videoOption` 字段

<div class="alert note"> <li>你需要全量设置包体中的字段，对于不想要更新的字段，请维持原设置。<li>除以上列举字段，其余字段均不支持更新。<li>请按照调用 <code>Create</code> 时设置的场景更新 cloud transcoder，否则会发生未知异常。</div>

音视频场景下更新 cloud transcoder 示例代码如下：

 ```json
{
    "services":{
        "cloudTranscoder":{
            "serviceType":"cloudTranscoderV2",
            "config":{
                "transcoder":{
                    "idleTimeout":300,
                    "audioInputs":[
                        {
                            "rtc":{
                                "rtcChannel":"test",
                                "rtcUid": 123,
                                "rtcToken":"aab8b8f5a8cd4469a63042fcfafe7***"
                            }
                        },
                        {
                            "rtc":{
                                "rtcChannel":"test01",
                                "rtcUid":456,
                                "rtcToken":"aab8b8f5a8cd4469a63042fcfafe7***"
                            }
                        }
                    ],
                    "canvas":{
                        "width":960,
                        "height":480,
                        "color":0,
                        "backgroundImage":"https://XXXX.jpg",
                        "fillMode": "FIT"
                    },
                    "waterMarks":[
                        {
                            "imageUrl":"https://XXXX.png",
                            "region":{
                                "x":0,
                                "y":0,
                                "width":100,
                                "height":100,
                                "zOrder":50
                            }
                        }
                    ],
                    "videoInputs":[
                        {
                            "rtc":{
                                "rtcChannel":"test01",
                                "rtcUid":123,
                                "rtcToken":"aab8b8f5a8cd4469a63042fcfafe7***"
                            },
                            "placeholderImageUrl":"https://XXXX.jpg",
                            "region":{
                                "x":0,
                                "y":0,
                                "width":320,
                                "height":360,
                                "zOrder":1
                            }
                        },
                        {
                            "rtc":{
                                "rtcChannel":"test01",
                                "rtcUid":456,
                                "rtcToken":"aab8b8f5a8cd4469a63042fcfafe7***"
                            },
                            "placeholderImageUrl":"https://XXXX.jpg",
                            "region":{
                                "x":320,
                                "y":0,
                                "width":320,
                                "height":320,
                                "zOrder":1
                            }
                        }
                    ],
                    "outputs":[
                        {
                            "rtc":{
                                "rtcChannel":"test02",
                                "rtcUid":1000,
                                "rtcToken":"aab8b8f5a8cd4469a63042fcfafe7***"
                            },
                            "audioOption":{
                                "profileType":"AUDIO_PROFILE_MUSIC_STANDARD"
                            },
                            "videoOption":{
                                "fps":30,
                                "codec":"H264",
                                "bitrate":800,
                                "width":960,
                                "height":480,
                                "lowBitrateHighQuality":false
                            }
                        }
                    ]
                }
            }
        }
    }
}
```


## Query：查询 cloud transcoder 状态信息

### HTTP 请求

```
GET https://api.sd-rtn.com/v1/projects/{appid}/rtsc/cloud-transcoder/tasks/{taskId}?builderToken={tokenName>
```

### 路径参数

- `appId`: String 型必填字段。声网为每个开发者提供的 App ID。在声网控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。
- `taskId`: cloud transcoder 的任务 ID，为 UUID，用于标识本次请求创建的 cloud transcoder。

### 查询参数

`builderToken`: String 型必填字段。通过 `Acquire` 方法获取 `builderToken` 的参数值 `tokenName`。

#### 请求头

- `Content-Type`: `application/json`
- `Authorization`: 该字段的值需参考[认证说明](https://docs.agora.io/cn/faq/restful_authentication)

### HTTP 响应

#### 响应头

`X-Request-ID`: UUID（通用唯一识别码），用于标识本次请求。
 <div class="alert note"><ul><li>如果请求出错，请在日志中打印出该值，排查问题。</li><li>如果本次请求的响应状态码不是 2XX，那么响应 header 中可能无该字段。</li></ul></div>

#### 响应包体

响应包体包含以下字段：

![](https://web-cdn.agora.io/docs-files/1664351715856)

字段含义详见下表：

| 字段                                         | 类型         | 描述                                                         |
| :------------------------------------------- | :----------- | :----------------------------------------------------------- |
| taskId                                     | JSON Object  | 任务 ID，为 UUID，用于标识本次请求创建的 cloud transcoder。  |
| createTs                                   | Number       | 创建任务时的 Unix 时间戳（秒）。                             |
| status                                     | String       | 创建任务的运行状态：<li>`IDLE`: 任务未开始<li>`PREPARED`: 任务已收到开启请求<li>`STARTING`: 任务正在开启<li>`CREATED`: 任务初始化完成<li>`STARTED`: 任务已经启动<li>`IN_PROGRESS`: 任务正在进行<li>`STOPPING`: 任务正在停止<li>`STOPPED`: 任务已经停止<li>`EXIT`: 任务正常退出<li>`FAILURE_STOP`: 任务异常退出 |
| services                                   | JSON Object  | 任务中包含的服务信息。                                       |
| services.cloudTranscoder                   | JSON Object  | 服务名称。                                                   |
| services.cloudTranscoder.serviceType       | String       | 服务类型。云端转码：`cloudTranscoderV2`。                    |
| services.cloudTranscoder.config           | JSON Object  | 服务参数。                                                   |
| services.cloudTranscoder.config.transcoder | String，必填 | Cloud transcoder 对象。包含的字段及含义请参考请求包体字段及含义。 |
| services.cloudTranscoder.createTs            | Number       | 创建 cloud transcoder 时的 Unix 时间戳（秒）。               |
| services.cloudTranscoder.status            | String       | 服务的运行状态：<li>`serviceIdle`: 服务未开始<li>`serviceReady`: 服务已经就绪<li>`serviceStarted`: 服务已经开始<li>`serviceInProgress`: 服务正在进行<li>`serviceCompleted`: 服务已经停止，任务全部完成<li>`servicePartialCompleted`: 服务已经停止，任务部分完成<li>`serviceValidationFailed`: 服务参数验证失败<li>`serviceAbnormal`: 服务异常退出<li>`serviceUnknown`: 服务未知状态 |
| services.cloudTranscoder.message           | String       | 服务的执行信息，描述服务异常的具体原因。                     |
| services.cloudTranscoder.details           | JSON Object  | 服务的执行细节。                                             |
| eventHandlers                              | String       | 预留字段。                                                   |
| execution                                  | JSON Object  | 预留字段。                                                   |
| execution.workflows                        | String       | 预留字段。                                                   |
| properties                                 | String       | 预留字段。                                                   |
| sequenceId                                 | String       | 预留字段。                                                   |
| variables                                    | JSON Object  | 预留字段。                                                   |
| workflows                                    | JSON Object  | 预留字段。                                                   |

响应包体示例：

```json
{
    "createTs": 1661420011,
    "eventHandlers": {},
    "execution": {
        "workflows": {}
    },
    "properties": {},
    "sequenceId": "0",
    "services": {
        "cloudTranscoder": {
            "config": {},
            "createTs": 1661420011,
            "message": "OnSlaveServiceQueryUpdated",
            "serviceType": "cloudTranscoderV2",
            "status": "serviceInProgress"
        }
    },
    "status": "IN_PROGRESS",
    "taskId": "c0077139e34d0949c719189a393aa7c0",
    "variables": {},
    "workflows": {}
}
```

<a name="code"></a>
## 状态码汇总表

- 如果状态码为 `2XX`，则请求成功。
- 如果状态码不为 `2XX`，则请求失败。请根据对应的响应包体中的 `message` 字段内容排查问题。

| 状态码                  | 含义                                                         |
| :---------------------- | :----------------------------------------------------------- |
| 200 OK                  | 请求成功。                                                   |
| **废弃** 201 Created             | 任务已经在进行中，请勿用同一个 builderToken 重复开启任务。  |
| 202 Accepted            | 服务端已经收到任务请求，但未执行完成。请通过 `Query` 方法查询执行状态。 |
| 400 Bad Request         | 请求的语法错误（如参数错误）。如果你填入的 `appid` 没有开通云端录制权限，也会返回 `400`，请结合响应报文的 `message` 字段进行处理。 |
| 401 Unauthorized        | Authorization 无效。                                         |
| 403 Forbidden           | 你的 App ID 尚未开通 cloud transcoder，请联系我们。          |
| 404 Not Found           | 找不到 cloud transcoder。                                    |
| 409 Conflict            | 已经存在使用相同 `instanceId` 的 cloud transcoder 任务。如果你想创建新的 cloud transcoder，请先将旧的 cloud transcoder 删除。 |
| 429 Too Many Requests   | 请求速率超过上限。                                           |
| 500 Unknown             |声网服务器内部错误，请联系我们。                           |
| 501 Not Implemented     | 该方法未实现。                                               |
| 503 Service Unavailable |声网服务器暂时超载或在临时维护中。请使用重试机制或联系我们。 |
| 504 Gateway Timeout     |声网服务器内部错误，充当网关或代理的服务器未从上游服务器获取请求，上游服务器已关闭。请联系我们。 |

## 注意事项

本节总结使用云端转码 RESTful API 的重要注意事项。

- 请不要对响应报文包体里的 `message` 字段的内容做任何逻辑，处理如果请求失败请结合状态码排查问题。
- `202` 的状态码仅表示服务端已经收到任务请求，但不代表执行完成，需要继续通过 `Query` 方法查询执行状态来判断任务是否执行完成。
- 收到 `404` 的状态码后，如果 `Create` 请求已返回成功且没有主动调用 `Delete` 方法，或者 cloud transcoder 的空闲状态超过请求参数中的 `idleTimeout` 字段，建议采取退避算法（例如间隔 5 秒、10 秒、15 秒）调用 `Query` 方法进行确认。
- 收到 `5xx` 的响应状态码后，一般是服务端在响应的过程中出现了问题，建议采取退避算法（例如间隔 5 秒、10 秒、15 秒）调用 `Query` 请求进行确认。