## Introduction

Agora 针对多人连麦直播场景研发云端合流服务，支持在 Agora 服务端将多个主播的音视频流转码合流并输入到 Agora RTC 频道。 频道内观众仅需订阅转码合流后的音视频流即可观看直播。

使用云端合流服务后，观众无需订阅多个主播的音视频流，可大幅节省下行带宽压力和客户端设备性能消耗。

### Working principles

Agora 服务端将多路流转码合流的过程相当于创建一个 cloud transcoder。 转码前的多路流是 cloud transcoder 的输入，转码后的流是 cloud transcoder 的输出。

你可以通过云端合流 RESTful API 控制 cloud transcoder：

- 创建 cloud transcoder。 Agora 服务器会开始将你指定的多路流转码合流并输入到 Agora RTC 频道。
- 销毁 cloud transcoder 任务。 Agora 服务器会停止转码合流。
- 查询 cloud transcoder 状态信息。 Agora 服务器会查询你指定的 cloud transcoder。
- 更新 cloud transcoder。 Agora 服务器会根据你指定的配置更新转码合流。

After using these RESTful APIs, Agora's notification server sends the callback notification to your server through HTTP or HTTPS request.For details, see Message Notification Service.

## Generate a Token

builderToken 也称动态密钥。 builderToken 可保障你发起请求控制 cloud transcoder 的安全性。 请在创建 cloud transcoder 前调用该方法生成一个 builderToken。

### HTTP request

```http
POST https://api.agora.io/v1/projects/<appId>/rtmp-converters
```
`appId`: (Required) String type parameter. The App ID provided by Agora for each developer. You can get an App ID after creating a project in the Agora console. An App ID is the unique identification of a project.

#### Header field of the request message

- `Content-Type`: `application/json`
- `Authorization`: The value of this field needs to refer to the [authentication instructions.](https://docs.agora.io/cn/faq/restful_authentication)

#### Body of the request message

The URL requires the following query string parameters:

| Field Name | Category | Description |
|---|----|---|
| `instanceId` | (Required)String  | 用户指定的实例 ID。 The length must be within 64 characters. The supported character set range is:<li>All lowercase English letters (a-z)</li><li>All uppercase English letters (A-Z)</li><li>Numbers 0-9</li><li>"-", "_"</li><div class="alert note"><li>一个 `instanceId` 可以生成多个 builderToken，但在一个任务中只能使用一个 builderToken 发起请求。</li></div> |

### HTTP response

#### Header field of the response message.

`X-Request-ID`: UUID (Universal Unique Identifier), which identifies this request.
<div class="alert note"><ul><li>If there is an error in the request, please print out the value in the log to troubleshoot the problem.</li><li>If the response status code of this request is not 2XX, there may not be this field in the response header.</li></ul></div>

#### Body of the response message

响应包体包含以下字段：

| Field Name | Category | Description |
|---|----|---|
| `tokenName` | String | builderToken 的值，在后续调用其他方法时需要传入该值。 |
| `createTs` | integer | The Unix timestamp (s) when the Converter is created. |
| `instanceId` | Number | 请求时设置的 `instanceId`。 |

<div class="alert note">If this method call succeeds, you get a <code>resource</code> ID (<code>resourceId</code>) from the HTTP response body. 请在 5 分钟内使用该 builderToken 发起云端合流请求，超出时间后需要重新生成 builderToken，否则无法调用云端合流其他方法。

## 开启任务：创建 cloud transcoder

### HTTP request

```http
POST https://api.agora.io/v1/projects/<appId>/rtmp-converters?regionHintIp={regionHintIp}
```
### Path parameter

`appId`: (Required) String type parameter. The App ID provided by Agora for each developer. You can get an App ID after creating a project in the Agora console. An App ID is the unique identification of a project.

### Query Parameters

`builderToken`: String 型必填字段，即动态密钥。 通过**生成 builderToken** 方法获取 `builderToken` 的参数值 `tokenName`。


#### Header field of the request message

- `Content-Type`: `application/json`
- `Authorization`: The value of this field needs to refer to the [authentication instructions.](https://docs.agora.io/cn/faq/restful_authentication)

#### Body of the request message

Request Body is the `converter `field of JSON Object type, including the following fields:

字段结构如图所示：

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1gnzxcugrdzj30u017otda.jpg" alt="create_request" style="zoom: 50%;" />

- The details about `the recording status`.

   | Field Name | Category | Description |
   |---|----|---|
   | `<service>` |  (Required)JSON Object | 服务名称，开发者自行设置。 需要保证一个 cloud transcoder 中使用的服务名称唯一。 |
   | `<service>.serviceType` | (Required)String  | 服务类型。 云端合流：`cloudTranscoder`。 |
   | `<service>.config` |  (Required)JSON Object | 4: Invalid parameters of the video profile of the mixed video. 用于设置 cloud transcoder 的业务参数。 |
   | `<service>.config.transcoder` | (Required)String  | cloud transcoder 的对象。 |

- `<service>.config.transcoder` 包含如下字段：

   | Field Name | Category | Description |
   |---|----|---|
   | `idleTimeOut` | UInt，可选 | The maximum time (s) that the Converter is idle. Idle means that all users corresponding to the media stream processed by the Converter have left the channel. After the idle state exceeds the set `idleTimeOut`, the Converter will be destroyed automatically. Integer only. The value range is [[0,10000]], and the default value is `360`. |
   | `inputRtcTokens` | List，可选 | Leaves the RTC channel. cloud transcoder 需要该信息才能把转码处理后的流输入 RTC 频道。<li>Your Agora project has enabled the App Certificate on Console.</li><li>Your Agora project has enabled the App Certificate on Console.</li> |
   | `inputRtcTokens.rtcChannel` | (Required)String  | Leaves the RTC channel. |
   | `inputRtcTokens.rtcToken` | (Required)String  | 进入 RTC 频道所需要的 Token，用于确保频道安全。 |
   | `inputRtcTokens.rtcUid` | Uint，必填 | UID。 RTC 频道内不允许存在相同的 UID，因此请确保取值和 `inputs.videoInputs.inputSources.in.rtcUid` 不同。 |
   | `inputs` |  (Required)JSON Object | cloud transcoder 的输入配置。 |
   | `inputs.audioInputs` | (Optional)JSON Object | cloud transcoder 的音频输入配置。<li>如果你不传值，Agora 会将 `inputs.videoInputs.inputSources.in.rtcUid` 对应的输入源作为 cloud   transcoder 的音频输入源。 这种取值方式适用于对主播的音频和视频都转码的场景。</li><li>如果你传值，Agora 会将你指定的音频输入源进行转码混音。 这种取值方式适用于 `inputs.audioInputs.  inputSources.in.rtcUid` 和 `inputs.videoInputs.inputSources.in.rtcUid` 不完全一致的场景，即部分主播的视频转码但音频不转码。</li> |
   | `inputs.audioInputs.inputSources` | List，必填 | cloud transcoder 的音频输入源。 支持多个输入源。 |
   | `inputs.audioInputs.inputSources.in` |  (Required)JSON Object | cloud transcoder 的音频输入源。 |
   | `inputs.audioInputs.inputSources.in.rtcChannel` | (Required)String  | Leaves the RTC channel. |
   | `inputs.audioInputs.inputSources.in.rtcUid` | (Required)Number  | 输入源所对应的 UID。 Multiple users joins the channel with the same uid. |
   | `inputs.videoInputs` |  (Required)JSON Object | cloud transcoder 的视频输入配置。 |
   | `inputs.videoInputs.canvas` |  (Required)JSON Object | 承载 cloud transcoder 合图的画布。 |
   | `inputs.videoInputs.canvas.height` | (Required)Number  | The height of the canvas (pixel). The value range is [1,30]. |
   | `inputs.videoInputs.canvas.width` | (Required)Number  | The width of the canvas (pixel). The value range is [1,30]. |
   | `inputs.videoInputs.inputSources` | List，必填 | cloud transcoder 的视频输入源。 支持多个输入源。 |
   | `inputs.videoInputs.inputSources.in` |  (Required)JSON Object | cloud transcoder 的视频输入源。 |
   | `inputs.videoInputs.inputSources.in.rtcChannel` | (Required)String  | Leaves the RTC channel. |
   | `inputs.videoInputs.inputSources.in.rtcUid` | (Required)Number  | 输入源所对应的 UID。 取值和 `inputs.audioInputs.inputSources.in.rtcUid` 一致。 |
   | `inputs.videoInputs.inputSources.in.OfflineImage` | (Optional)JSON Object | 主播离线后的背景图。 如果你不传值，主播离线后的画面无背景图。 |
   | `inputs.videoInputs.inputSources.in.OfflineImage.imageType` | (Required)String  | The image watermark. Support JPG and PNG format pictures. |
   | `inputs.videoInputs.inputSources.in.OfflineImage.imageUrl` | (Required)String  | 图片 URL。 必须为合法和 URL，且包含 `jpg` 或 `png` 后缀。 |
   | `inputs.videoInputs.inputSources.region` |  (Required)JSON Object | cloud transcoder 的视频输入源画面在画布上的位置。 |
   | `inputs.videoInputs.inputSources.region.x` | (Required)Number  | The x coordinate (pixel) of the screen on the canvas. The lateral displacement relative to the origin. (Take the upper left corner of the canvas as the origin, and the x coordinate as the upper left corner of the screen.) The value range is [1,30]. |
   | `inputs.videoInputs.inputSources.region.y` | (Required)Number  | The y coordinate (pixel) of the screen on the canvas. The longitudinal displacement to the origin.（Take the upper left corner of the canvas as the origin and the y coordinate as the upper left corner of the screen.） The value range is [0,100]. |
   | `inputs.videoInputs.inputSources.region.width` | (Required)Number  | The width (px) of the video image captured by the local camera. The value range is [1,30]. |
   | `inputs.videoInputs.inputSources.region.height` | (Required)Number  | The height (px) of the video image captured by the local camera. The value range is [1,30]. |
   | `inputs.videoInputs.inputSources.zOrder` | (Required)Number  | cloud transcoder 的视频输入画面的图层编号。 The value range is [0,100]. 0 represents the lowest layer. 100 represents the top layer. |
   | `outputs` | List，必填 | cloud transcoder 的输出配置。 支持输出多个经过不同转码配置处理后的流。 |
   | `outputs.out` |  (Required)JSON Object | cloud transcoder 的输出配置。 |
   | `outputs.out.rtcChannel` | (Required)String  | Leaves the RTC channel. 取值和 `inputRtcTokens.rtcChannel` 一致。 |
   | `outputs.out.rtcToken` | (Required)String  | 进入 RTC 频道所需要的 Token，用于确保频道安全。 取值和 `inputRtcTokens.rtcToken` 一致。 |
   | `outputs.out.rtcUid` | Uint，必填 | UID。 取值和 `inputRtcTokens.rtcUid` 一致。 |
   | `outputs.audioOption` | (Optional)JSON Object | cloud transcoder 对音频流的转码混音配置。 AUDIO_PROFILE_MUSIC_STANDARD`(2): A sample rate of` 48 kHz, music encoding, mono, and a bitrate of up to 48 Kbps. |
   | `outputs.audioOption.profileType` |  (Optional)String | Audio profiles. 支持取值：<li>`AUDIO_PROFILE_MUSIC_STANDARD(2`): A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 48 Kbps.</li><li>`AUDIO_PROFILE_MUSIC_STANDARD_STEREO(3)`: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 56 Kbps.</li><li>`AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)`: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 128 Kbps.</li><li>`AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)`: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 192 Kbps.</li> |
   | `outputs.videoOption` |  (Required)JSON Object | cloud transcoder 对视频流的转码合图配置。 |
   | `outputs.videoOption.fps` | Int，可选 | The decoder output frame rate (fps) of the remote video. The value range is [1,30]. The default value is 15. |
   | `outputs.videoOption.codec` | Int，必填 | 转码输出视频的 codec。 支持取值为 `"H265"`。 |
   | `outputs.videoOption.bitrate` | Int，可选 | Bitrate of the CDN live output video stream. The value range is [1,10000]. 如果你不传值，Agora 会根据网络情况和其他视频属性自动设置视频码率。 |
   | `outputs.videoOption.width` | Int，必填 | The width (px) of the video image captured by the local camera. The value range is [1,30]. |
   | `outputs.videoOption.height` | Int，必填 | The height (px) of the video image captured by the local camera. The value range is [1,30]. |


### HTTP response

#### Header field of the response message.

`X-Request-ID`: UUID (Universal Unique Identifier), which identifies this request.
<div class="alert note"><ul><li>If there is an error in the request, please print out the value in the log to troubleshoot the problem.</li><li>If the response status code of this request is not 2XX, there may not be this field in the response header.</li></ul></div>

#### Body of the response message

响应包体包含以下字段：

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1go15n67ctej30b8088wep.jpg" alt="create_response" style="zoom:80%;" />

Recoveries

| Field Name | Category | Description |
|---|----|---|
| `taskId` | JSON Object | cloud transcoder 的任务 ID，为 UUID，用于标识本次请求创建的 cloud transcoder。 |
| `createTs` | integer | The Unix timestamp (s) when the Converter is created. |
| `status` | String | 创建 cloud transcoder 任务的运行状态：<li>`"IDLE"`: 任务未开始</li><li>`"PREPARED"`: 任务已收到开启请求</li><li>`"STARTING"`: 任务正在开启</li><li>`"CREATED"`: 任务初始化完成</li><li>`"STARTED"`: 任务已经启动</li><li>`"IN_PROGRESS"`: 任务正在进行</li><li>`"STOPPING"`: 任务正在停止</li><li>``"stopped"``: The SDK stops processing the audio buffer.</li><li>`"EXIT"`: 任务正常退出</li><li>`"FAILURE_STOP"`: 任务异常退出</li> |
| `services` | JSON Object | 任务包含的所有服务的相关信息。 |
| `services.<service>` | JSON Object | 服务名称。 |
| `services.<service>.serviceType` | String | 服务类型。 云端合流：`cloudTranscoder`。 |
| `services.<service>.config` | JSON Object | 服务参数。 |
| `services.<service>.status` | String | Service status<li>`"IDLE"`: 服务未开始</li><li>`"READY"`: 服务已经就绪</li><li>`"STARTED"`: 服务已经开始</li><li>`"IN_PROGRESS"`: 服务正在进行</li><li>`"COMPLETED"`: 服务已经停止，任务全部完成</li><li>`"PARTIAL_COMPLETED"`: 服务已经停止，任务部分完成</li><li>`"VALIDATION_FAILED"`: 服务参数验证失败</li><li>`"ABNORMAL"`: 服务异常退出</li><li>`"unknown": Unknown` status.</li> |
| `services.<service>.message` | String | 服务的执行信息，描述服务异常的具体原因。 |
| `services.<service>.details` | JSON Object | 服务的执行细节。 |

## 查询任务：查询 cloud transcoder 状态信息
### HTTP request

```http
PATCH https://api.agora.io/v1/projects/<appId>/rtmp-converters/<converterId>?sequence={sequence}
```
### Path parameter

- `appId`: (Required) String type parameter. The App ID provided by Agora for each developer. You can get an App ID after creating a project in the Agora console. An App ID is the unique identification of a project.
- `taskId`: cloud transcoder 的任务 ID，为 UUID，用于标识本次请求创建的 cloud transcoder。

### Query Parameters

`builderToken`: String 型必填字段，即动态密钥。 通过**生成 builderToken** 方法获取 `builderToken` 的参数值 `tokenName`。

#### Header field of the request message

- `Content-Type`: `application/json`
- `Authorization`: The value of this field needs to refer to the [authentication instructions.](https://docs.agora.io/cn/faq/restful_authentication)

#### Body of the request message

None

### HTTP response

#### Header field of the response message.

`X-Request-ID`: UUID (Universal Unique Identifier), which identifies this request.
<div class="alert note"><ul><li>If there is an error in the request, please print out the value in the log to troubleshoot the problem.</li><li>If the response status code of this request is not 2XX, there may not be this field in the response header.</li></ul></div>

#### Body of the response message

响应包体包含以下字段：

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1go15n67ctej30b8088wep.jpg" alt="create_response" style="zoom:80%;" />

Recoveries

| Field Name | Category | Description |
|---|----|---|
| `taskId` | JSON Object | cloud transcoder 的任务 ID，为 UUID，用于标识本次请求创建的 cloud transcoder。 |
| `createTs` | integer | The Unix timestamp (s) when the Converter is created. |
| `status` | String | 创建 cloud transcoder 任务的运行状态：<li>`"IDLE"`: 任务未开始</li><li>`"PREPARED"`: 任务已收到开启请求</li><li>`"STARTING"`: 任务正在开启</li><li>`"CREATED"`: 任务初始化完成</li><li>`"STARTED"`: 任务已经启动</li><li>`"IN_PROGRESS"`: 任务正在进行</li><li>`"STOPPING"`: 任务正在停止</li><li>``"stopped"``: The SDK stops processing the audio buffer.</li><li>`"EXIT"`: 任务正常退出</li><li>`"FAILURE_STOP"`: 任务异常退出</li> |
| `services` | JSON Object | 任务包含的所有服务信息。 |
| `services.<service>` | JSON Object | 服务名称。 |
| `services.<service>.serviceType` | String | 服务类型。 云端合流：`cloudTranscoder`。 |
| `services.<service>.config` | JSON Object | 服务参数。 |
| `services.<service>.status` | String | Service status<li>`"IDLE"`: 服务未开始</li><li>`"READY"`: 服务已经就绪</li><li>`"STARTED"`: 服务已经开始</li><li>`"IN_PROGRESS"`: 服务正在进行</li><li>`"COMPLETED"`: 服务已经停止，任务全部完成</li><li>`"PARTIAL_COMPLETED"`: 服务已经停止，任务部分完成</li><li>`"VALIDATION_FAILED"`: 服务参数验证失败</li><li>`"ABNORMAL"`: 服务异常退出</li><li>`"unknown": Unknown` status.</li> |
| `services.<service>.message` | String | 服务的执行信息，描述服务异常的具体原因。 |
| `services.<service>.details` | JSON Object | 服务的执行细节。 |

## 停止任务：销毁 cloud transcoder

### HTTP request

```http
DELETE https://api.agora.io/v1/projects/<appId>/rtmp-converters/<converterId>
```

### Path parameter

- `appId`: (Required) String type parameter. The App ID provided by Agora for each developer. You can get an App ID after creating a project in the Agora console. An App ID is the unique identification of a project.
- `taskId`: cloud transcoder 的任务 ID，为 UUID，用于标识本次请求创建的 cloud transcoder。

### Query Parameters

`builderToken`: String 型必填字段，即动态密钥。 通过**生成 builderToken** 方法获取 `builderToken` 的参数值 `tokenName`。


#### Header field of the request message

- `Content-Type`: `application/json`
- `Authorization`: The value of this field needs to refer to the [authentication instructions.](https://docs.agora.io/cn/faq/restful_authentication)

#### Body of the request message

None

### HTTP response

#### Header field of the response message.

- `X-Request-ID`: UUID (Universal Unique Identifier), which identifies this request.
   <div class="alert note"><ul><li>If there is an error in the request, please print out the value in the log to troubleshoot the problem.</li><li>If the response status code of this request is not 2XX, there may not be this field in the response header.</li></ul></div>

#### Body of the response message

响应包体包含以下字段：

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1go15n67ctej30b8088wep.jpg" alt="create_response" style="zoom:80%;" />

Recoveries

| Field Name | Category | Description |
|---|----|---|
| `taskId` | JSON Object | cloud transcoder 的任务 ID，为 UUID，用于标识本次请求创建的 cloud transcoder。 |
| `createTs` | integer | The Unix timestamp (s) when the Converter is created. |
| `status` | String | 创建 cloud transcoder 任务的运行状态：<li>`"IDLE"`: 任务未开始</li><li>`"PREPARED"`: 任务已收到开启请求</li><li>`"STARTING"`: 任务正在开启</li><li>`"CREATED"`: 任务初始化完成</li><li>`"STARTED"`: 任务已经启动</li><li>`"IN_PROGRESS"`: 任务正在进行</li><li>`"STOPPING"`: 任务正在停止</li><li>``"stopped"``: The SDK stops processing the audio buffer.</li><li>`"EXIT"`: 任务正常退出</li><li>`"FAILURE_STOP"`: 任务异常退出</li> |
| `services` | JSON Object | 任务包含的所有服务信息。 |
| `services.<service>` | JSON Object | 服务名称。 |
| `services.<service>.serviceType` | String | 服务类型。 云端合流：`cloudTranscoder`。 |
| `services.<service>.config` | JSON Object | 服务参数。 |
| `services.<service>.status` | String | Service status<li>`"IDLE"`: 服务未开始</li><li>`"READY"`: 服务已经就绪</li><li>`"STARTED"`: 服务已经开始</li><li>`"IN_PROGRESS"`: 服务正在进行</li><li>`"COMPLETED"`: 服务已经停止，任务全部完成</li><li>`"PARTIAL_COMPLETED"`: 服务已经停止，任务部分完成</li><li>`"VALIDATION_FAILED"`: 服务参数验证失败</li><li>`"ABNORMAL"`: 服务异常退出</li><li>`"unknown": Unknown` status.</li> |
| `services.<service>.message` | String | 服务的执行信息，描述服务异常的具体原因。 |
| `services.<service>.details` | JSON Object | 服务的执行细节。 |


## 更新任务：更新 cloud transcoder

### HTTP request

```http
PATCH https://api.agora.io/v1/projects/<appid>/rtsc/cloud-service-builder/tasks/<taskId>?builderToken=<tokenName>&sequenceId=<sequenceId>&updateMask=<updateMask>
```

### Path parameter

- `appId`: (Required) String type parameter. The App ID provided by Agora for each developer. You can get an App ID after creating a project in the Agora console. An App ID is the unique identification of a project.
- `taskId`: cloud transcoder 的任务 ID，为 UUID，用于标识本次请求创建的 cloud transcoder。

### Query Parameters

- `builderToken`: String 型必填字段，即动态密钥。 通过**生成 builderToken** 方法获取 `builderToken` 的参数值 `tokenName`。
- `zIndex`: Number type required field. 请求序号，由用户自行指定，从 0 开始计数且需保证自增，用于防止请求乱序。
- `imageUrl`: String type field. For the field mask of JSON encoding, please refer to the[ Google protobuf FieldMask document for details](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#fieldmask).

#### Header field of the request message

- `Content-Type`: `application/json`
- `Authorization`: The value of this field needs to refer to the [authentication instructions.](https://docs.agora.io/cn/faq/restful_authentication)

#### Body of the request message

Request Body is the `converter `field of JSON Object type, including the following fields:

字段结构如图所示：

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1gnzxcugrdzj30u017otda.jpg" alt="create_request" style="zoom: 50%;" />

- The details about `the recording status`.

   | Field Name | Category | Description |
   |---|----|---|
   | region: JSON Object `type field`. | 服务名称，创建 cloud transcoder 时设置。 |
   | `<service>.serviceType` | (Required)String  | 服务类型。 云端合流：`cloudTranscoder`。 |
   | `<service>.config` |  (Required)JSON Object | 云端合流参数。 用于设置 cloud transcoder 的业务参数。 |
   | `<service>.config.transcoder` | (Required)String  | cloud transcoder 的对象。 |

- `services.config.transcoder` 包含如下字段：

   | Field Name | Category | Description |
   |---|----|---|
   | `inputRtcTokens` | List，可选 | Leaves the RTC channel. cloud transcoder 需要该信息才能把转码处理后的流输入 RTC 频道。<li>Your Agora project has enabled the App Certificate on Console.</li><li>Your Agora project has enabled the App Certificate on Console.</li> |
   | `inputRtcTokens.rtcChannel` | (Required)String  | Leaves the RTC channel. |
   | `inputRtcTokens.rtcToken` | (Required)String  | 进入 RTC 频道所需要的 Token，用于确保频道安全。 |
   | `inputRtcTokens.rtcUid` | Uint，必填 | UID。 RTC 频道内不允许存在相同的 UID，因此请确保取值和 `inputs.videoInputs.inputSources.in.rtcUid` 不同。 |
   | `inputs` |  (Required)JSON Object | cloud transcoder 的输入配置。 |
   | `inputs.audioInputs` | (Optional)JSON Object | cloud transcoder 的音频输入配置。<li>如果你不传值，Agora 会将 `inputs.videoInputs.inputSources.in.rtcUid` 对应的输入源作为 cloud   transcoder 的音频输入源。 这种取值方式适用于对主播的音频和视频都转码的场景。</li><li>如果你传值，Agora 会将你指定的音频输入源进行转码混音。 这种取值方式适用于 `inputs.audioInputs.  inputSources.in.rtcUid` 和 `inputs.videoInputs.inputSources.in.rtcUid` 不完全一致的场景，即部分主播的视频转码但音频不转码。</li> |
   | `inputs.audioInputs.inputSources` | List，必填 | cloud transcoder 的音频输入源。 支持多个输入源。 |
   | `inputs.audioInputs.inputSources.in` |  (Required)JSON Object | cloud transcoder 的音频输入源。 |
   | `inputs.audioInputs.inputSources.in.rtcChannel` | (Required)String  | Leaves the RTC channel. |
   | `inputs.audioInputs.inputSources.in.rtcUid` | (Required)Number  | 输入源所对应的 UID。 Multiple users joins the channel with the same uid. |
   | `inputs.videoInputs` |  (Required)JSON Object | cloud transcoder 的视频输入配置。 |
   | `inputs.videoInputs.canvas` |  (Required)JSON Object | 承载 cloud transcoder 合图的画布。 |
   | `inputs.videoInputs.canvas.height` | (Required)Number  | The height of the canvas (pixel). The value range is [1,30]. |
   | `inputs.videoInputs.canvas.width` | (Required)Number  | The width of the canvas (pixel). The value range is [1,30]. |
   | `inputs.videoInputs.inputSources` | List，必填 | cloud transcoder 的视频输入源。 支持多个输入源。 |
   | `inputs.videoInputs.inputSources.in` |  (Required)JSON Object | cloud transcoder 的视频输入源。 |
   | `inputs.videoInputs.inputSources.in.rtcChannel` | (Required)String  | Leaves the RTC channel. |
   | `inputs.videoInputs.inputSources.in.rtcUid` | (Required)Number  | 输入源所对应的 UID。 取值和 `inputs.audioInputs.inputSources.in.rtcUid` 一致。 |
   | `inputs.videoInputs.inputSources.in.OfflineImage` | (Optional)JSON Object | 主播离线后的背景图。 如果你不传值，主播离线后的画面无背景图。 |
   | `inputs.videoInputs.inputSources.in.OfflineImage.imageType` | (Required)String  | The image watermark. Support JPG and PNG format pictures. |
   | `inputs.videoInputs.inputSources.in.OfflineImage.imageUrl` | (Required)String  | 图片 URL。 必须为合法和 URL，且包含 `jpg` 或 `png` 后缀。 |
   | `inputs.videoInputs.inputSources.region` |  (Required)JSON Object | cloud transcoder 的视频输入源画面在画布上的位置。 |
   | `inputs.videoInputs.inputSources.region.x` | (Required)Number  | The x coordinate (pixel) of the screen on the canvas. The lateral displacement relative to the origin. (Take the upper left corner of the canvas as the origin, and the x coordinate as the upper left corner of the screen.) The value range is [1,30]. |
   | `inputs.videoInputs.inputSources.region.y` | (Required)Number  | The y coordinate (pixel) of the screen on the canvas. The longitudinal displacement to the origin.（Take the upper left corner of the canvas as the origin and the y coordinate as the upper left corner of the screen.） The value range is [0,100]. |
   | `inputs.videoInputs.inputSources.region.width` | (Required)Number  | The width (px) of the video image captured by the local camera. The value range is [1,30]. |
   | `inputs.videoInputs.inputSources.region.height` | (Required)Number  | The height (px) of the video image captured by the local camera. The value range is [1,30]. |
   | `inputs.videoInputs.inputSources.zOrder` | (Required)Number  | cloud transcoder 的视频输入画面的图层编号。 The value range is [0,100]. 0 represents the lowest layer. 100 represents the top layer. |


Agora 支持你调用 `Update` 方法更新如下字段：

- `inputs`
- `inputs.audioInputs`
- `inputs.videoInputs`
- `inputRtcTokens`

### HTTP response

#### Header field of the response message.

`X-Request-ID`: UUID (Universal Unique Identifier), which identifies this request.
<div class="alert note"><ul><li>If there is an error in the request, please print out the value in the log to troubleshoot the problem.</li><li>If the response status code of this request is not 2XX, there may not be this field in the response header.</li></ul></div>

#### Body of the response message

响应包体包含以下字段：

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1go15n67ctej30b8088wep.jpg" alt="create_response" style="zoom:80%;" />

Recoveries

| Field Name | Category | Description |
|---|----|---|
| `taskId` | JSON Object | cloud transcoder 的任务 ID，为 UUID，用于标识本次请求创建的 cloud transcoder。 |
| `createTs` | integer | The Unix timestamp (s) when the Converter is created. |
| `status` | String | 创建 cloud transcoder 任务的运行状态：<li>`"IDLE"`: 任务未开始</li><li>`"PREPARED"`: 任务已收到开启请求</li><li>`"STARTING"`: 任务正在开启</li><li>`"CREATED"`: 任务初始化完成</li><li>`"STARTED"`: 任务已经启动</li><li>`"IN_PROGRESS"`: 任务正在进行</li><li>`"STOPPING"`: 任务正在停止</li><li>``"stopped"``: The SDK stops processing the audio buffer.</li><li>`"EXIT"`: 任务正常退出</li><li>`"FAILURE_STOP"`: 任务异常退出</li> |
| `services` | JSON Object | 服务包含的所有信息。 |
| `services.<service>` | JSON Object | 服务名称。 |
| `services.<service>.serviceType` | String | 服务类型。 云端合流：`cloudTranscoder`。 |
| `services.<service>.config` | JSON Object | 服务参数。 |
| `services.<service>.status` | String | Service status<li>`"IDLE"`: 服务未开始</li><li>`"READY"`: 服务已经就绪</li><li>`"STARTED"`: 服务已经开始</li><li>`"IN_PROGRESS"`: 服务正在进行</li><li>`"COMPLETED"`: 服务已经停止，任务全部完成</li><li>`"PARTIAL_COMPLETED"`: 服务已经停止，任务部分完成</li><li>`"VALIDATION_FAILED"`: 服务参数验证失败</li><li>`"ABNORMAL"`: 服务异常退出</li><li>`"unknown": Unknown` status.</li> |
| `services.<service>.message` | String | 服务的执行信息，描述服务异常的具体原因。 |
| `services.<service>.details` | JSON Object | 服务的执行细节。 |

## Sample code

### Create: Create a Converter

- Request URL:
```
POST https://api.agora.io/v1/projects/<appId>/rtmp-converters?regionHintIp={regionHintIp}
```
- `Content-type` is `application/json;charset=utf-8`.
- `Authorization` is the basic authentication, see[ RESTful API authentication for details](https://docs.agora.io/cn/faq/restful_authentication).
- The request body:

```json
{
    "services": {
        "cloudTranscoder": {
            "serviceType": "cloudTranscoder",
            config
                "transcoder": {
                    "idleTimeout": 300,
                    "inputs": {
                        "audioInputs": {
                            "inputSources": [
                                {
                                    "in": {
                                        "rtcChannel": "ccft",
                                        "rtcUid": 123456
                                    }
                                },
                                {
                                    "in": {
                                        "rtcChannel": "mcu_test1",
                                        "rtcUid": 8989
                                    }
                                }
                            ]
                        },
                        "videoInputs": {
                            "canvas": {
                                "height": 1080,
                                "width": 1920,
                                "fps": 30
                            },
                            "inputSources": [
                                {
                                    "in": {
                                        "rtcChannel": "ccft",
                                        "rtcUid": 123456
                                    },
                                    "region": {
                                        "x": 0,
                                        "y": 0,
                                        "width": 400,
                                        "height": 400
                                    },
                                    "zOrder": 1
                                },
                                {
                                    "in": {
                                        "rtcChannel": "mcu_test1",
                                        "rtcUid": 8989
                                    },
                                    "region": {
                                        "x": 0,
                                        "y": 400,
                                        "width": 400,
                                        "height": 400
                                    },
                                    "zOrder": 1
                                }
                            ]
                        }
                    },
                    "outputs": [
                        {
                            "out": {
                                "rtcChannel": "mcu_test1",
                                "rtcUid": 9393,
                                "rtcToken": "aab8b8f5a8cd4469a63042fcfafe7063"
                            },
                            "videoOption": {
                                "fps": 30,
                                "codec": "H264",
                                "height": 1080,
                                "width": 1920
                            }
                        }
                    ]
                }
            }
        }
    }
}
```


### Update: Update the specified Converter configuration.
- Request URL:
```
PATCH https://api.agora.io/v1/projects/<appid>/rtsc/cloud-service-builder/tasks/<taskId>?builderToken=<tokenName>&sequenceId=<sequenceId>&updateMask=<updateMask>
```
- `Content-type` is `application/json;charset=utf-8`.
- `Authorization` is the basic authentication, see[ RESTful API authentication for details](https://docs.agora.io/cn/faq/restful_authentication).
- The request body:

```json
{
    "services": {
        "cloudTranscoder": {
            "serviceType": "cloudTranscoder",
            config
                "transcoder": {
                    "name": "web",
                    "idleTimeout": 300,
                    "inputs": {
                        "audioInputs": {
                            "inputSources": [
                                {
                                    "in": {
                                        "rtcChannel": "test_transcoder_input_1",
                                        "rtcUid": 1000002
                                    }
                                }
                            ]
                        },
                        "videoInputs": {
                            "canvas": {
                                "height": 1080,
                                "width": 1920,
                                "fps": 30
                            },
                            "inputSources": [
                                {
                                    "in": {
                                        "rtcChannel": "test_transcoder_input_1",
                                        "rtcUid": 1000002
                                    },
                                    "region": {
                                        "x": 0,
                                        "y": 0,
                                        "width": 1280,
                                        "height": 720
                                    },
                                    "zOrder": 1
                                }
                            ]
                        }
                    },
                    "outputs": [
                        {
                            "out": {
                                "rtcChannel": "test_failover_12",
                                "rtcUid": 9222,
                                "rtcToken": "aab8b8f5a8cd4469a63042fcfafe7063"
                            },
                            "videoOption": {
                                "fps": 30,
                                "codec": "H264",
                                "height": 1080,
                                "width": 1920
                            }
                        }
                    ]
                }
            }
        }
    }
}
```

## Status codes

- If the status code is `2XX`, the request is successful.
- If the status code is not `2XX`, the request fails. Please troubleshoot the problem based on the content of the `message field in the corresponding response message Body`.

| Status code | Description |
| ----------------------- | -------------- |
| 200 OK | The request succeeds. |
| 201 Created | 任务已经在进行中 ，请勿用同一个 builderToken 重复开启任务。 |
| 202 Accepted | 服务端已经收到任务请求，但未执行完成。 请通过 <code>GET</code> 方法查询执行状态。 |
| 400 Bad Request | The request parameter is incorrect. 如果你填入的 <code>appid</code> 没有开通云端录制权限，也会返回 <code>400</code>，请结合响应报文的 <code>message</code> 字段进行处理。 |
| 401 Unauthorized | Authorization: The value of this field needs to refer to the authentication instructions. |
| 403 Forbidden | 你的 App ID 尚未开通 cloud transcoder，请联系我们。 |
| 404 Not Found | 找不到 cloud transcoder。 |
| 409 Conflict | 已有同名的 cloud transcoder。 如果你想创建新的 cloud transcoder，请先将旧的同名 cloud transcoder 删除。 |
| 429 Too Many Requests | The method call frequency exceeds the limit. |
| 500 Unknown | An error occurs in the Agora server. Try uploading the log files later. |
| 501 Not Implemented | 该方法未实现。 |
| 503 Service Unavailable | Agora 服务器暂时超载或在临时维护中。 请使用重试机制或联系我们。 |
| 504 Gateway Timeout | The server was acting as a gateway or proxy and did not receive a timely response from the upstream server. 请联系我们。 |

## Item

This section summarizes the important considerations for using Push Streaming RESTful API.

- 请不要对响应报文包体里的 `message` 字段的内容做任何逻辑处理如果请求失败请结合状态码排查问题。
- `202` 的状态码仅表示服务端已经收到任务请求，但不代表执行完成，需要继续通过 <code>GET</code> 方法查询执行状态来判断任务是否执行完成。
- 收到 `404` 的状态码后，如果 `CREATE` 请求已返回成功且没有主动调用 `DELETE` 方法，或者 cloud transcoder 的空闲状态超过请求参数中的 `idleTimeout` 字段，建议采取退避算法（例如间隔 5 秒、10 秒、15 秒）调用 `GET` 方法进行确认。
- 收到 `5xx` 的响应状态码后，一般是服务端在响应的过程中出现了问题，建议采取退避算法（例如间隔 5 秒、10 秒、15 秒）调用请求进行确认。