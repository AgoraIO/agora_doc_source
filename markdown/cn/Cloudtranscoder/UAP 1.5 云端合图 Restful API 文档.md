## 简介

Agora 针对多人连麦直播场景研发云端合流服务，支持在 Agora 服务端将多个主播的音视频流转码合流并输入到 Agora RTC 频道。频道内观众仅需订阅转码合流后的音视频流即可观看直播。

使用云端合流服务后，观众无需订阅多个主播的音视频流，可大幅节省下行带宽压力和客户端设备性能消耗。

### 工作原理

Agora 服务端将多路流转码合流的过程相当于创建一个 cloud transcoder（云端转码器）。转码前的多路流是 cloud transcoder 的输入，转码后的流是 cloud transcoder 的输出。

你可以通过云端合流 RESTful API 控制 cloud transcoder：

- `Create`: 创建 cloud transcoder。Agora 服务器会开始将你指定的多路流转码合流并输入到 Agora RTC 频道。
- `Query`: 查询 cloud transcoder 状态信息。Agora 服务器会查询你指定的云端转码器。
- `Delete`: 销毁 cloud transcoder。Agora 服务器会停止转码合流。
- `Update`: 更新 cloud transcoder。Agora 服务器会根据你指定的配置更新转码合流。

使用云端合流 RESTful API 后，Agora 消息通知服务器会通过 HTTPS 请求给你的服务器回调通知。

## 生成 builderToken

Token，也称动态密钥，是 app 用户在加入频道或登录服务系统时采用的一种鉴权方式。在创建 `transcoder` 前，需要调用该方法生成一个 builderToken。

### HTTP 请求

```http
POST https://api.agora.io/v1/projects/<appid>/rtsc/cloud-service-builder/builderTokens
```
`appid`: String 型必填参数。Agora 为每个开发者提供的 App ID。在 Agora 控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。

#### 请求报文的 Header 字段

- `Content-Type`: `application/json`
- `Authorization`: 该字段的值需参考[认证说明](https://docs.agora.io/cn/faq/restful_authentication)

#### 请求报文的 Body

在请求包体中传入以下参数：

| 字段 | 类型 | 描述  |
|---|----|---|
|`instanceId`  | String，必填 | 用户指定的实例 ID。长度必须在 64 个字符以内，支持的字符集范围为：<li>所有小写英文字母（a-z>）</li><li>所有大写英文字母（A-Z）</li><li>数字 0-9</li><li>"-", "_"</li><div class="alert note"><li>不传值时该字段为空。</li><li>一个 `instanceId` 可以生成多个 builderToken。</li><li>同一时间使用的 builderToken 必须唯一，否则在后续调用其他方法时会收到响应状态码 `401(Conflict)`。</li></div>|

### HTTP 响应

#### 响应报文的 Header 字段

- `x-request-id`: UUID（通用唯一识别码），用于标识本次请求。
    <div class="alert note"><ul><li>如果请求出错，请在日志中打印出该值，排查问题。</li><li>如果本次请求的响应状态码不是 2XX，那么响应 header 中可能无该字段。</li></ul></div>
- `x-resource-id`: UUID（通用唯一识别码），标识本次请求创建的 cloud transcoder。  

#### 响应报文的 Body

响应包体包含以下字段：

| 字段 | 类型 | 描述  |
|---|----|---|
| `tokenName`  | String | builderToken 的值，在后续调用其他方法时需要传入该值。  |
| `createTs` | Integer   | 创建 cloud transcoder 时的 Unix 时间戳（秒）。|
| `instanceId`| Number  | 请求时设置的 `instanceId`。|

<div class="alert note">调用该方法成功后，你可以从 HTTP 响应包体中的 <code>tokenName</code>字段得到一个 builderToken。该 builderToken 的时效为 5 分钟，超出时间后需要重新生成 builderToken，否则无法调用云端合流其他方法。

## Create：创建 cloud transcoder

### HTTP 请求

```http
POST https://api.agora.io/v1/projects/<appid>/rtsc/cloud-service-builder/tasks?builderToken=<tokenName>
```
### 路径参数

`appid`: String 型必填字段。Agora 为每个开发者提供的 App ID。在 Agora 控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。

### Query Parameters

`builderToken`: String 型必填字段，即动态密钥。通过**生成 builderToken** 方法获取 `builderToken` 的参数值 `tokenName`。

```
https://api.agora.io/v1/projects/<appid>/rtsc/cloud-service-builder/tasks?builderToken=<tokenName>
```

#### 请求报文的 Header 字段

- `Content-Type`: `application/json`
- `Authorization`: 该字段的值需参考[认证说明](https://docs.agora.io/cn/faq/restful_authentication)

#### 请求报文的 Body

请求 Body 为 JSON Object 类型的 `services` 字段。

字段结构如图所示：

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1gnzxcugrdzj30u017otda.jpg" alt="create_request" style="zoom: 50%;" />

- `services` 包含如下字段：

  | 字段 | 类型 | 描述  |
  |---|----|---|
  |`service`：JSON Object，必填| 服务名称，用户自行设置。需要保证一个 cloud transcoder 中使用的服务名称唯一。|
  |`service.serviceType`| String，必填| 服务类型。云端合流：`cloudTranscoder`。|
  |`service.config`| JSON Object，必填| 云端合流参数设置。用于设置 cloud transcoder 的业务参数。|
  |`service.config.transcoder`|String，必填|cloud transcoder 的对象。|
  
- `service.config.transcoder` 包含如下字段：
  
  | 字段 | 类型 | 描述  |
  |---|----|---|
  |`idleTimeout`| UInt，可选| cloud transcoder 处于空闲状态的最大时长（秒）。空闲指 cloud transcoder 处理的音视频流所对应的所有主播均已离开频道。空闲状态超过设置的 `idleTimeOut` 后， cloud transcoder 会自动销毁。取值范围为 [1,86400]，默认值为 `300`。|
  |`inputRtcTokens`|List，可选| 进入 RTC 频道所需的信息。cloud transcoder 需要该信息才能把转码处理后的流输入 RTC 频道。<li>如果你在 Agora 控制台未启用 App 证书，则不需要传值。</li><li>如果你在 Agora 控制台未启用 App 证书，则必须传值。</li>|
  |`inputRtcTokens.rtcChannel`|String，必填| RTC 频道名。 |
  |`inputRtcTokens.rtcToken`|String，必填| 进入 RTC 频道所需要的 Token，用于确保频道安全。 |
  |`inputRtcTokens.rtcUid`|Uint，必填| UID。RTC 频道内不允许存在相同的 UID，因此请确保取值和 `inputs.videoInputs.inputSources.in.rtcUid` 不同。 |
  |`inputs`|JSON Object，必填|cloud transcoder 的输入配置。|
  |`inputs.audioInputs`|JSON Object，可选|cloud transcoder 的音频输入配置。<li>如果你不传值，Agora 会将 `inputs.videoInputs.inputSources.in.rtcUid` 对应的输入源作为 cloud   transcoder 的音频输入源。这种取值方式适用于对主播的音频和视频都转码的场景。</li><li>如果你传值，Agora 会将你指定的音频输入源进行转码混音。这种取值方式适用于 `inputs.audioInputs.  inputSources.in.rtcUid` 和 `inputs.videoInputs.inputSources.in.rtcUid` 不完全一致的场景，即部分主播的视频转码但音频不转码。</li>|
  |`inputs.audioInputs.inputSources`|List，必填|cloud transcoder 的音频输入源。支持多个输入源。 |
  |`inputs.audioInputs.inputSources.in`|JSON Object，必填|cloud transcoder 的音频输入源。|
  |`inputs.audioInputs.inputSources.in.rtcChannel`|String，必填|输入源所属的 RTC 频道名。|
  |`inputs.audioInputs.inputSources.in.rtcUid`|Number，必填| 输入源所对应的 UID。RTC 频道内不允许存在相同的 UID。|
  |`inputs.videoInputs`|JSON Object，必填|cloud transcoder 的视频输入配置。|
  |`inputs.videoInputs.canvas`|JSON Object，必填|承载 cloud transcoder 合图的画布。|
  |`inputs.videoInputs.canvas.height`|Number，必填|画布的高度 (px)。取值范围为 [120,3840]。|
  |`inputs.videoInputs.canvas.width`|Number，必填|画布的宽度 (px)。取值范围为 [120,3840]。|
  |`inputs.videoInputs.inputSources`|List，必填|cloud transcoder 的视频输入源。支持多个输入源。 |
  |`inputs.videoInputs.inputSources.in`|JSON Object，必填|cloud transcoder 的视频输入源。|
  |`inputs.videoInputs.inputSources.in.rtcChannel`|String，必填|输入源所属的 RTC 频道名。|
  |`inputs.videoInputs.inputSources.in.rtcUid`|Number，必填|输入源所对应的 UID。取值和 `inputs.audioInputs.inputSources.in.rtcUid` 一致。|
  |`inputs.videoInputs.inputSources.in.OfflineImage`|JSON Object，可选|主播离线后的背景图。如果你不传值，主播离线后的画面无背景图。|
  |`inputs.videoInputs.inputSources.in.OfflineImage.imageType`|String，必填|图片类型。支持 JPG 和 PNG。|
  |`inputs.videoInputs.inputSources.in.OfflineImage.imageUrl`|String，必填|图片 URL。必须为合法和 URL，且包含 `jpg` 或 `png` 后缀。|
  |`inputs.videoInputs.inputSources.region`|JSON Object，必填|cloud transcoder 的视频输入源画面在画布上的位置。|
  |`inputs.videoInputs.inputSources.region.x`|Number，必填|画面在画布上的 x 坐标 (px)。以画布左上角为原点，x 坐标为画面左上角相对于原点的横向位移。取值范围为 [0,3840]。|
  |`inputs.videoInputs.inputSources.region.y`|Number，必填|画面在画布上的 y 坐标 (px)。以画布左上角为原点，y 坐标为画面左上角相对于原点的纵向位移。取值范围为 [0,3840]。|
  |`inputs.videoInputs.inputSources.region.width`|Number，必填|图片的宽度 (px)。取值范围为 [120,3840]。|
  |`inputs.videoInputs.inputSources.region.height`|Number，必填|图片的高度 (px)。取值范围为 [120,3840]。|
  |`inputs.videoInputs.inputSources.zOrder`|Number，必填| cloud transcoder 的视频输入画面的图层编号。取值范围为 [0,100]。0 代表最下层的图层。100 代表最上层的图层。 |
  |`inputRtcTokens`|JSON Array，可选| 进入 RTC 频道所需的信息。cloud transcoder 需要该信息才能把转码处理后的流输入 RTC 频道。<li>如果你在 Agora 控制台未启用 App 证书，则不需要传值。</li><li>如果你在 Agora 控制台未启用 App 证书，则必须传值。</li>|
  |`outputs.out`|JSON Object，必填|cloud transcoder 的输出配置。|
  |`outputs`| List，必填|cloud transcoder 的输出配置。支持输出多个经过不同转码配置处理后的流。|
  |`outputs.out.rtcChannel`|String，必填|RTC 频道名。取值和 `inputRtcTokens.rtcChannel` 一致。 |
  |`outputs.out.rtcToken`|String，必填|进入 RTC 频道所需要的 Token，用于确保频道安全。取值和 `inputRtcTokens.rtcToken` 一致。 |
  |`outputs.out.rtcUid`|Uint，必填|UID。取值和 `inputRtcTokens.rtcUid` 一致。|
  |`outputs.audioOption`|JSON Object，可选| cloud transcoder 对音频流的转码混音配置。如果你不传值，Agora 转码输出的音频属性为 `AUDIO_PROFILE_MUSIC_STANDARD`，即 48 KHz 采样率，音  乐编码，单声道，编码码率最大值为 64 Kbps。|
  |`outputs.audioOption.profileType`|String，可选| 音频属性。支持取值：<li>`"AUDIO_PROFILE_MUSIC_STANDARD"`: （默认值）48 KHz 采样率，音乐编码，单声道，编码码率最大值为 64 Kbps。  </li><li>`"AUDIO_PROFILE_MUSIC_STANDARD_STEREO"`: 48 KHz 采样率，音乐编码，双声道，编码码率最大值为 80 Kbps。</li><li>`"AUDIO_PROFILE_MUSIC_HIGH_QUALITY"`: 48 KHz 采样率，音  乐编码，单声道，编码码率最大值为 96 Kbps。</li><li>`"AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO"`: 48 KHz 采样率，音乐编码，双声道，编码码率最大值为 128 Kbps。</li>|
  |`outputs.videoOption`|JSON Object，必填|cloud transcoder 对视频流的转码合图配置。|
  |`outputs.videoOption.fps`|Int，可选|转码输出视频的帧率 (fps)。取值范围为 [1,30]。默认值为 15。|
  |`outputs.videoOption.codec`|Int，必填|转码输出视频的 codec。支持取值为 `"H265"`。|
  |`outputs.videoOption.bitrate`|Int，可选|转码输出视频的码率。取值范围为 [1,10000]。如果你不传值，Agora 会根据网络情况和其他视频属性自动设置视频码率。|
  |`outputs.videoOption.width`|Int，必填|转码输出视频的宽度 (px)。取值范围为 [120,3840]。|
  |`outputs.videoOption.height`|Int，必填|转码输出视频的高度 (px)。取值范围为 [120,3840]。|
  

### HTTP 响应

#### 响应报文的 Header 字段

`x-request-id`: UUID（通用唯一识别码），用于标识本次请求。
  <div class="alert note"><ul><li>如果请求出错，请在日志中打印出该值，排查问题。</li><li>如果本次请求的响应状态码不是 2XX，那么响应 header 中可能无该字段。</li></ul></div>

#### 响应报文的 Body

响应包体包含以下字段：

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1go15n67ctej30b8088wep.jpg" alt="create_response" style="zoom:80%;" />

字段含义详见下表：

| 字段 | 类型 | 描述  |
|---|----|---|
| `taskId`  | JSON Object |cloud transcoder 的任务 ID，为 UUID，用于标识本次请求创建的 cloud transcoder。 |
| `createTs`| Integer  | 创建 cloud transcoder 时的 Unix 时间戳（秒）。  |
| `status`| String   | 创建 cloud transcoder 任务的运行状态：<li>IDLE: 任务未开始</li><li>PREPARED: 任务已收到开启请求</li><li>STARTING: 任务正在开启</li><li>CREATED: 任务初始化完成</li><li>STARTED: 任务已经启动</li><li>IN_PROGRESS: 任务正在进行</li><li>STOPPING: 任务正在停止</li><li>STOPPED: 任务已经停止</li><li>EXIT: 任务正常退出</li><li>FAILURE_STOP: 任务异常退出</li> |
| `services`  | JSON Object | 服务包含的所有信息。 |
| `services.service`  | JSON Object | 服务名称。创建 cloud transcoder 时设置。 |
| `services.service.serviceType`| String| 服务类型。云端合流：`cloudTranscoder`。|
| `services.service.config`| JSON Object| 服务参数。|
| `services.service.status`| String     | 服务的运行状态：<li>IDLE: 服务未开始</li><li>READY: 服务已经就绪</li><li>STARTED: 服务已经开始</li><li>IN_PROGRESS: 服务正在进行</li><li>COMPLETED: 服务已经停止，任务全部完成</li><li>PARTIAL_COMPLETED: 服务已经停止，任务部分完成</li><li>VALIDATION_FAILED: 服务参数验证失败</li><li>ABNORMAL: 服务异常退出</li><li>UNKNOWN: 服务异常退出</li> |
| `services.service.message`|String|服务的执行信息，描述服务异常的具体原因。|
| `services.service.details`|JSON Object|服务的执行细节。|

## GET：查询 cloud transcoder 状态信息
### HTTP 请求

```http
GET https://api.agora.io/v1/projects/<appid>/rtsc/cloud-service-builder/tasks/<taskId>?builderToken=<tokenName>
```
### 路径参数

`appid`: String 型必填字段。Agora 为每个开发者提供的 App ID。在 Agora 控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。

### Query Parameters

`builderToken`: String 型必填字段，即动态密钥。通过**生成 builderToken** 方法获取 `builderToken` 的参数值 `tokenName`。

```
https://api.agora.io/v1/projects/<appid>/rtsc/cloud-service-builder/tasks?builderToken=<tokenName>
```

#### 请求报文的 Header 字段

- `Content-Type`: `application/json`
- `Authorization`: 该字段的值需参考[认证说明](https://docs.agora.io/cn/faq/restful_authentication)

#### 请求报文的 Body

空

### HTTP 响应

#### 响应报文的 Header 字段

`x-request-id`: UUID（通用唯一识别码），用于标识本次请求。
 <div class="alert note"><ul><li>如果请求出错，请在日志中打印出该值，排查问题。</li><li>如果本次请求的响应状态码不是 2XX，那么响应 header 中可能无该字段。</li></ul></div>

#### 响应报文的 Body

响应包体包含以下字段：

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1go15n67ctej30b8088wep.jpg" alt="create_response" style="zoom:80%;" />

字段含义详见下表：

| 字段 | 类型 | 描述  |
|---|----|---|
| `taskId`  | JSON Object |cloud transcoder 的任务 ID，为 UUID，用于标识本次请求创建的 cloud transcoder。 |
| `createTs`| Integer  | 创建 cloud transcoder 时的 Unix 时间戳（秒）。  |
| `status`| String   | 创建 cloud transcoder 任务的运行状态：<li>IDLE: 任务未开始</li><li>PREPARED: 任务已收到开启请求</li><li>STARTING: 任务正在开启</li><li>CREATED: 任务初始化完成</li><li>STARTED: 任务已经启动</li><li>IN_PROGRESS: 任务正在进行</li><li>STOPPING: 任务正在停止</li><li>STOPPED: 任务已经停止</li><li>EXIT: 任务正常退出</li><li>FAILURE_STOP: 任务异常退出</li> |
| `services`  | JSON Object | 服务包含的所有信息。 |
| `services.service`  | JSON Object | 服务名称。 |
| `services.service.serviceType`| String| 服务类型。云端合流：`cloudTranscoder`。|
| `services.service.config`| JSON Object| 服务参数。|
| `services.service.status`| String     | 服务的运行状态：<li>IDLE: 服务未开始</li><li>READY: 服务已经就绪</li><li>STARTED: 服务已经开始</li><li>IN_PROGRESS: 服务正在进行</li><li>COMPLETED: 服务已经停止，任务全部完成</li><li>PARTIAL_COMPLETED: 服务已经停止，任务部分完成</li><li>VALIDATION_FAILED: 服务参数验证失败</li><li>ABNORMAL: 服务异常退出</li><li>UNKNOWN: 服务异常退出</li> |
| `services.service.message`|String|服务的执行信息，描述服务异常的具体原因。|
| `services.service.details`|JSON Object|服务的执行细节。|

## Delete：销毁 cloud transcoder

### HTTP 请求

```http
DELETE https://api.agora.io/v1/projects/<appid>/rtsc/cloud-service-builder/tasks/
```

### 路径参数

`appid`: String 型必填字段。Agora 为每个开发者提供的 App ID。在 Agora 控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。

### Query Parameters

`builderToken`: String 型必填字段，即动态密钥。通过**生成 builderToken** 方法获取 `builderToken` 的参数值 `tokenName`。

```
https://api.agora.io/v1/projects/<appid>/rtsc/cloud-service-builder/tasks/<taskId>?builderToken=<tokenName>
```

#### 请求报文的 Header 字段

- `Content-Type`: `application/json`
- `Authorization`: 该字段的值需参考[认证说明](https://docs.agora.io/cn/faq/restful_authentication)

#### 请求报文的 Body

空

### HTTP 响应

#### 响应报文的 Header 字段

- `x-request-id`: UUID（通用唯一识别码），用于标识本次请求。
  <div class="alert note"><ul><li>如果请求出错，请在日志中打印出该值，排查问题。</li><li>如果本次请求的响应状态码不是 2XX，那么响应 header 中可能无该字段。</li></ul></div>

#### 响应报文的 Body

响应包体包含以下字段：

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1go15n67ctej30b8088wep.jpg" alt="create_response" style="zoom:80%;" />

字段含义详见下表：

| 字段 | 类型 | 描述  |
|---|----|---|
| `taskId`  | JSON Object |cloud transcoder 的任务 ID，为 UUID，用于标识本次请求创建的 cloud transcoder。 |
| `createTs`| Integer  | 创建 cloud transcoder 时的 Unix 时间戳（秒）。  |
| `status`| String   | 创建 cloud transcoder 任务的运行状态：<li>IDLE: 任务未开始</li><li>PREPARED: 任务已收到开启请求</li><li>STARTING: 任务正在开启</li><li>CREATED: 任务初始化完成</li><li>STARTED: 任务已经启动</li><li>IN_PROGRESS: 任务正在进行</li><li>STOPPING: 任务正在停止</li><li>STOPPED: 任务已经停止</li><li>EXIT: 任务正常退出</li><li>FAILURE_STOP: 任务异常退出</li> |
| `services`  | JSON Object | 服务包含的所有信息。 |
| `services.service`  | JSON Object | 服务名称。 |
| `services.service.serviceType`| String| 服务类型。云端合流：`cloudTranscoder`。|
| `services.service.config`| JSON Object| 服务参数。|
| `services.service.status`| String     | 服务的运行状态：<li>IDLE: 服务未开始</li><li>READY: 服务已经就绪</li><li>STARTED: 服务已经开始</li><li>IN_PROGRESS: 服务正在进行</li><li>COMPLETED: 服务已经停止，任务全部完成</li><li>PARTIAL_COMPLETED: 服务已经停止，任务部分完成</li><li>VALIDATION_FAILED: 服务参数验证失败</li><li>ABNORMAL: 服务异常退出</li><li>UNKNOWN: 服务异常退出</li> |
| `services.service.message`|String|服务的执行信息，描述服务异常的具体原因。|
| `services.service.details`|JSON Object|服务的执行细节。|


## Update：更新 cloud transcoder

### HTTP 请求

```http
PATCH /v1/projects/<appid>/rtsc/cloud-service-builder/tasks/
```

### 路径参数

`appid`: String 型必填字段。Agora 为每个开发者提供的 App ID。在 Agora 控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。

### Query Parameters

- `builderToken`: String 型必填字段，即动态密钥。通过**生成 builderToken** 方法获取 `builderToken` 的参数值 `tokenName`。
- `sequenceId`: Integer 型必填字段。请求序号，由用户自行指定，从 0 开始计数且需保证自增，用于防止请求乱序。
- `updateMask`: String 型必填字段。JSON 编码方式的字段掩码，详见[谷歌 protobuf FieldMask 文档](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#fieldmask)。在本示例中，`updateMask` 指定了 `builderToken` 和 `sequenceId` 字段子集。

```
https://api.agora.io/v1/projects/<appid>/rtsc/cloud-service-builder/tasks/<taskId>?builderToken=<tokenName>&sequenceId=<sequenceId>&updateMask=<updateMask>
```


#### 请求报文的 Header 字段

- `Content-Type`: `application/json`
- `Authorization`: 该字段的值需参考[认证说明](https://docs.agora.io/cn/faq/restful_authentication)

#### 请求报文的 Body

请求 Body 为 JSON Object 类型的 `services` 字段。

字段结构如图所示：

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1gnzxcugrdzj30u017otda.jpg" alt="create_request" style="zoom: 50%;" />

- `services` 包含如下字段：

  | 字段 | 类型 | 描述  |
  |---|----|---|
  |`service`：JSON Object，必填| 服务名称，创建 cloud transcoder 时设置。|
  |`service.serviceType`| String，必填| 服务类型。云端合流：`cloudTranscoder`。|
  |`service.config`| JSON Object，必填| 云端合流参数。用于设置 cloud transcoder 的业务参数。|
  |`service.config.transcoder`|String，必填|cloud transcoder 的对象。|
  
- `services.config.transcoder` 包含如下字段：
  
  | 字段 | 类型 | 描述  |
  |---|----|---|
  |`inputRtcTokens`|List，可选| 进入 RTC 频道所需的信息。cloud transcoder 需要该信息才能把转码处理后的流输入 RTC 频道。<li>如果你在 Agora 控制台未启用 App 证书，则不需要传值。</li><li>如果你在 Agora 控制台未启用 App 证书，则必须传值。</li>|
  |`inputRtcTokens.rtcChannel`|String，必填| RTC 频道名。 |
  |`inputRtcTokens.rtcToken`|String，必填| 进入 RTC 频道所需要的 Token，用于确保频道安全。 |
  |`inputRtcTokens.rtcUid`|Uint，必填| UID。RTC 频道内不允许存在相同的 UID，因此请确保取值和 `inputs.videoInputs.inputSources.in.rtcUid` 不同。 |
  |`inputs`|JSON Object，必填|cloud transcoder 的输入配置。|
  |`inputs.audioInputs`|JSON Object，可选|cloud transcoder 的音频输入配置。<li>如果你不传值，Agora 会将 `inputs.videoInputs.inputSources.in.rtcUid` 对应的输入源作为 cloud   transcoder 的音频输入源。这种取值方式适用于对主播的音频和视频都转码的场景。</li><li>如果你传值，Agora 会将你指定的音频输入源进行转码混音。这种取值方式适用于 `inputs.audioInputs.  inputSources.in.rtcUid` 和 `inputs.videoInputs.inputSources.in.rtcUid` 不完全一致的场景，即部分主播的视频转码但音频不转码。</li>|
  |`inputs.audioInputs.inputSources`|List，必填|cloud transcoder 的音频输入源。支持多个输入源。 |
  |`inputs.audioInputs.inputSources.in`|JSON Object，必填|cloud transcoder 的音频输入源。|
  |`inputs.audioInputs.inputSources.in.rtcChannel`|String，必填|输入源所属的 RTC 频道名。|
  |`inputs.audioInputs.inputSources.in.rtcUid`|Number，必填| 输入源所对应的 UID。RTC 频道内不允许存在相同的 UID。|
  |`inputs.videoInputs`|JSON Object，必填|cloud transcoder 的视频输入配置。|
  |`inputs.videoInputs.canvas`|JSON Object，必填|承载 cloud transcoder 合图的画布。|
  |`inputs.videoInputs.canvas.height`|Number，必填|画布的高度 (px)。取值范围为 [120,3840]。|
  |`inputs.videoInputs.canvas.width`|Number，必填|画布的宽度 (px)。取值范围为 [120,3840]。|
  |`inputs.videoInputs.inputSources`|List，必填|cloud transcoder 的视频输入源。支持多个输入源。 |
  |`inputs.videoInputs.inputSources.in`|JSON Object，必填|cloud transcoder 的视频输入源。|
  |`inputs.videoInputs.inputSources.in.rtcChannel`|String，必填|输入源所属的 RTC 频道名。|
  |`inputs.videoInputs.inputSources.in.rtcUid`|Number，必填|输入源所对应的 UID。取值和 `inputs.audioInputs.inputSources.in.rtcUid` 一致。|
  |`inputs.videoInputs.inputSources.in.OfflineImage`|JSON Object，可选|主播离线后的背景图。如果你不传值，主播离线后的画面无背景图。|
  |`inputs.videoInputs.inputSources.in.OfflineImage.imageType`|String，必填|图片类型。支持 JPG 和 PNG。|
  |`inputs.videoInputs.inputSources.in.OfflineImage.imageUrl`|String，必填|图片 URL。必须为合法和 URL，且包含 `jpg` 或 `png` 后缀。|
  |`inputs.videoInputs.inputSources.region`|JSON Object，必填|cloud transcoder 的视频输入源画面在画布上的位置。|
  |`inputs.videoInputs.inputSources.region.x`|Number，必填|画面在画布上的 x 坐标 (px)。以画布左上角为原点，x 坐标为画面左上角相对于原点的横向位移。取值范围为 [0,3840]。|
  |`inputs.videoInputs.inputSources.region.y`|Number，必填|画面在画布上的 y 坐标 (px)。以画布左上角为原点，y 坐标为画面左上角相对于原点的纵向位移。取值范围为 [0,3840]。|
  |`inputs.videoInputs.inputSources.region.width`|Number，必填|图片的宽度 (px)。取值范围为 [120,3840]。|
  |`inputs.videoInputs.inputSources.region.height`|Number，必填|图片的高度 (px)。取值范围为 [120,3840]。|
  |`inputs.videoInputs.inputSources.zOrder`|Number，必填| cloud transcoder 的视频输入画面的图层编号。取值范围为 [0,100]。0 代表最下层的图层。100 代表最上层的图层。 |


Agora 支持你调用 `Update` 方法更新如下字段：

- `inputs`
- `inputs.audioInputs`
- `inputs.videoInputs`
- `inputRtcTokens`

### HTTP 响应

#### 响应报文的 Header 字段

`x-request-id`: UUID（通用唯一识别码），用于标识本次请求。
  <div class="alert note"><ul><li>如果请求出错，请在日志中打印出该值，排查问题。</li><li>如果本次请求的响应状态码不是 2XX，那么响应 header 中可能无该字段。</li></ul></div>

#### 响应报文的 Body

响应包体包含以下字段：

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1go15n67ctej30b8088wep.jpg" alt="create_response" style="zoom:80%;" />

字段含义详见下表：

| 字段 | 类型 | 描述  |
|---|----|---|
| `taskId`  | JSON Object |cloud transcoder 的任务 ID，为 UUID，用于标识本次请求创建的 cloud transcoder。 |
| `createTs`| Integer  | 创建 cloud transcoder 时的 Unix 时间戳（秒）。  |
| `status`| String   | 创建 cloud transcoder 任务的运行状态：<li>IDLE: 任务未开始</li><li>PREPARED: 任务已收到开启请求</li><li>STARTING: 任务正在开启</li><li>CREATED: 任务初始化完成</li><li>STARTED: 任务已经启动</li><li>IN_PROGRESS: 任务正在进行</li><li>STOPPING: 任务正在停止</li><li>STOPPED: 任务已经停止</li><li>EXIT: 任务正常退出</li><li>FAILURE_STOP: 任务异常退出</li> |
| `services`  | JSON Object | 服务包含的所有信息。 |
| `services.service`  | JSON Object | 服务名称。 |
| `services.service.serviceType`| String| 服务类型。云端合流：`cloudTranscoder`。|
| `services.service.config`| JSON Object| 服务参数。|
| `services.service.status`| String     | 服务的运行状态：<li>IDLE: 服务未开始</li><li>READY: 服务已经就绪</li><li>STARTED: 服务已经开始</li><li>IN_PROGRESS: 服务正在进行</li><li>COMPLETED: 服务已经停止，任务全部完成</li><li>PARTIAL_COMPLETED: 服务已经停止，任务部分完成</li><li>VALIDATION_FAILED: 服务参数验证失败</li><li>ABNORMAL: 服务异常退出</li><li>UNKNOWN: 服务异常退出</li> |
| `services.service.message`|String|服务的执行信息，描述服务异常的具体原因。|
| `services.service.details`|JSON Object|服务的执行细节。|

## 示例代码

### Create：创建 cloud transcoder

- 请求 URL：
```
POST https://api.agora.io/v1/projects/<appid>/rtsc/cloud-service-builder/tasks?builderToken=<yourtokenName>
```
- `Content-type` 为 `application/json;charset=utf-8`
- `Authorization` 为 Basic authorization，生成方法请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。
- 请求包体内容：

```json
{
    "services": {
        "cloudTranscoder": {
            "serviceType": "cloudTranscoder",
            "config": {
                "transcoder": {
                    "idleTimeOut": 300,
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


### Update：更新 cloud transcoder
- 请求 URL：
```
PATCH https://api.agora.io/v1/projects/<appid>/rtsc/cloud-service-builder/tasks/<taskId>?builderToken=<tokenName>&sequenceId=<sequenceId>&updateMask=<updateMask>
```
- `Content-type` 为 `application/json;charset=utf-8`
- `Authorization` 为 Basic authorization，生成方法请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。
- 请求包体内容：

```json
{
    "services": {
        "cloudTranscoder": {
            "serviceType": "cloudTranscoder",
            "config": {
                "transcoder": {
                    "name": "11aaa",
                    "idleTimeOut": 10,
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

## 状态码汇总表

- 如果状态码为 `2XX`，则请求成功。
- 如果状态码不为 `2XX`，则请求失败。请根据对应的响应报文 Body 中的 `message` 字段内容排查问题。

| 状态码                  | 含义             |
| ----------------------- | -------------- |
| 200 OK                  | 请求成功。  |
| 201 Created             | 任务已经在进行中 ，请勿用同一个 buildToken 重复开启任务。  |
| 202 Accepted            | 服务端已经收到任务请求，但未执行完成。请通过 <code>GET</code> 方法查询执行状态。  |
| 400 Bad Request         | 请求的语法错误（如参数错误）。如果你填入的 <code>appid</code> 没有开通云端录制权限，也会返回 <code>400</code>，请结合响应报文的 <code>message</code> 字段进行处理。 |
| 401 Unauthorized        | Authorization 无效。            |
| 403 Forbidden           | 你的 App ID 尚未开通 cloud transcoder，请联系我们。|
| 404 Not Found           | 找不到 cloud transcoder。|
| 409 Conflict            | 已有同名的 cloud transcoder。如果你想创建新的 cloud transcoder，请先将旧的同名 cloud transcoder 删除。|
| 429 Too Many Requests   | 请求速率超过上限。|
| 500 Unknown             | Agora 服务器内部错误，请联系我们。|
| 501 Not Implemented     | 该方法未实现。|
| 503 Service Unavailable | Agora 服务器暂时超载或在临时维护中。请使用重试机制或联系我们。|
| 504 Gateway Timeout     | Agora 服务器内部错误，充当网关或代理的服务器未从远端服务器获取请求。请联系我们。|

## 注意事项

本节总结使用云端合流 RESTful API 的重要注意事项。

- 请不要对响应报文包体里的 `message` 字段的内容做任何逻辑处理如果请求失败请结合状态码排查问题。 
- `202` 的状态码仅表示服务端已经收到任务请求，但不代表执行完成，需要继续通过 <code>GET</code> 方法查询执行状态来判断任务是否执行完成。  
- 收到 `404` 的状态码后，如果 `CREATE` 请求已返回成功且没有主动调用 `DELETE` 方法，或者 cloud transcoder 的空闲状态超过请求参数中的 `idleTimeout` 字段，建议采取退避算法（例如间隔 5 秒、10 秒、15 秒）调用 `GET` 方法进行确认。 
- 收到 `5xx` 的响应状态码后，一般是服务端在响应的过程中出现了问题，建议采取退避算法（例如间隔 5 秒、10 秒、15 秒）调用请求进行确认。