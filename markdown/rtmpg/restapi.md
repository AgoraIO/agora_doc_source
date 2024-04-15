你可以通过 RESTful API 创建推流密钥，使用该密钥将在线媒体流作为直播视频源流输入到声网频道内。同时，也可以通过 RESTful API 开启并配置在线流的转码能力。

## 开通服务

第一次使用 RTMP 网关功能，需要联系[声网技术支持](/cn/Agora%20Platform/ticket)开通服务。

## 工作原理

以使用 OBS 推流软件输入 RTMP 协议的媒体流为例，工作原理及实现代码如下：

![](https://web-cdn.agora.io/docs-files/1687156698789)

- 服务器：填写的值为推流域名后加 `/live`。可以使用声网统一域名，也可以绑定用户自己的域名。
  <a id="region"></a>
  - 声网统一域名为 `rtls-ingress-prod-{region}.agoramdn.com`，你需要根据实际区域填写 {region} 字段，支持的区域如下：
    - `cn`：中国大陆
    - `ap`：除中国大陆以外的亚洲区域
    - `na`：北美
    - `eu`：欧洲

  - 使用用户自己的域名，请联系[声网技术支持](/cn/Agora%20Platform/ticket)进行配置，配置成功后方可使用。

- 推流码：生成方式取决于你使用声网域名还是用户域名。

  - 使用声网域名，需要使用声网 RESTful API 创建，详见 [Create：创建推流码](#create-创建推流码)。
  - 使用用户域名，既可以使用声网 RESTful API 创建，也可以用户本地生成。本地生成方法详见[本地生成推流码](#本地生成推流码)。

默认情况下，推流到 RTMP 网关之后，视频会不经转码直接被推送到声网频道。如果你需要转码，需要使用 RESTful API 设置相关参数，详见 [Update：设置服务配置信息](#update-设置服务配置信息)。

### 避免源流包含 B 帧

在默认不开启转码的情况下，如果源流中包含 B 帧，Web 端的声网观众会有兼容性问题。

以 OBS 推流软件为例，可以通过以下两种方式确保源流中不会出现 B 帧。

- 添加 x264 编码参数
  在**设置** > **输出** > **直播**页面的**编码器设置**中，将 **x264 选项**设置为 `bframes=0`。

    ![](https://web-cdn.agora.io/docs-files/1687156708354)

  该设置作用为不编码 B 帧。

- 添加微调（Tune）参数
  在**设置** > **输出** > **直播**页面的**编码器设置**中，将**微调（Tune）**设置 `zerolatency` 模式。

    ![](https://web-cdn.agora.io/docs-files/1687156716833)

  该设置作用为加速流编码，包含不编码 B 帧。

### 本地生成推流码

当使用用户自己的域名进行推流时，可以在用户本地生成推流码。
<div class="alert note">请先确保已经联系<a href="/cn/Agora%20Platform/ticket">声网技术支持</a>成功绑定用户域名。</div>

在生成推流码过程中，你需要用到以下信息：

- 声网项目的 App ID，详见[获取 App ID](https://docs.agora.io/cn/AgoraPlatform/get_appid_token?platform=AllPlatforms#获取-app-id)。
- 声网项目对应的 App 证书，详见[管理 App 证书](https://docportal.shengwang.cn/cn/AgoraPlatform/manage_projects?platform=AllPlatforms#管理-app-证书)。
- 声网频道名称 `channelName`。
- 声网频道内主播的 `uid`。
- 推流码的有效时长（秒）。

以下的 Node.js 示例代码，演示了如何本地生成推流码：

```js
const crypto = require('crypto');
const msgpack = require('msgpack-lite');
 
// 你的声网项目的 App ID 对应的 App 证书
appcert = ""
// 声网频道名称
channel = "";
// 声网频道内的主播 uid
uid = "";
// 推流码的有效时长（秒）
expiresAfter = 86400;
 
const expiresAt = Math.floor(Date.now() / 1000) + expiresAfter;
 
const rtcInfo = {
  C: channel,
  U: uid,
  E: expiresAt,
};
 
// 使用 msgpack 序列化
const data = msgpack.encode(rtcInfo);
 
// 随机生成一个初始化向量（IV）
const iv = crypto.randomBytes(16);
 
// 使用 App 证书作为加密密钥
const key = Buffer.from(appcert, 'hex');
 
// 创建一个 AES-128 的 CTR 加密器
const encrypter = crypto.createCipheriv('aes-128-ctr', key, iv);
 
// 对数据进行加密
const encrypted = Buffer.concat([iv, encrypter.update(data), encrypter.final()]);
 
 // base64 转换，并保证 URL 安全
const streamkey = encrypted.toString('base64').replace(/\+/g, '-').replace(/\//g, '_').replace(/\=+$/, '');

console.log(`streamkey is ${streamkey}`);
```

以上示例代码依赖 `msgpack-lite` 模块。如果你还没有安装，在项目根目录执行执行 `npm install msgpack-lite` 后运行 `node app.js` 即可。

## 通过  RESTful API 认证
声网 RESTful API 要求通过安全认证，支持 Basic HTTP 认证和 HMAC HTTP 认证两种认证方式。其中，HMAC 认证安全性较高，为推荐认证方式；Bacsic 认证则更为易用，但安全性较弱。

### 通过 Basic HTTP 认证
每次发送 HTTP 请求时，你都必须在请求头部填入 `Authorization` 字段。关于如何生成该字段的值，请参考 [RESTful API 要求 认证](https://docportal.shengwang.cn/cn/agora-class/faq/restful_authentication)。

### 通过 HMAC HTTP 认证
在发送 HTTP 请求时，你需要通过 HMAC-SHA256 算法生成一个签名，并在请求头部的 `Authorization` 字段传入签名及相关信息。

在生成认证字段过程中，你需要用到以下声网账号的信息：

- 声网项目的 App ID，详见[获取 App ID](https://docs.agora.io/cn/AgoraPlatform/get_appid_token?platform=AllPlatforms#获取-app-id)。
- 声网控制台 RESTful API 中提供的用户 ID 及用户密钥，详见[生成客户 ID 和密钥](https://docs.agora.io/cn/AgoraPlatform/get_appid_token?platform=AllPlatforms生成客户-id-和密钥)。

下面的 Node.js 代码以获取服务配置信息的 API 为例，演示如何生成 `Authorization` 字段的值：

```js
const crypto = require('crypto');
const http = require('http');
 
// 你的声网项目的 App ID
appid = ""
// 声网控制台 RESTful API 中获取的客户 ID
customer_username = ""
// 声网控制台 RESTful API 中获取的客户密钥
customer_secret = ""
// 请求包体
data = ""
 
function hashData(data) {
    const hash = crypto.createHash('sha256');
    hash.update(data);
    return hash.digest('base64');
}
function signData(data) {
    const hmac = crypto.createHmac('sha256', customer_secret);
    hmac.update(data);
    return hmac.digest('base64');
}
 
date = (new Date()).toUTCString();
reqpath = `/cn/v1/projects/${appid}/rtls/ingress/appconfig`;
reqline = `GET ${reqpath} HTTP/1.1`;
// 计算 Body 的 SHA-256 的哈希值
bodySign = hashData(args.data);
digest = `SHA-256=${bodySign}`;
// 生成签名
signingStr = `host: ${host}\ndate: ${date}\n${reqline}\ndigest: ${digest}`;
sign = signData(signingStr);
 
auth = `hmac username="${customer_username}", `
auth += `algorithm="hmac-sha256", `
auth += `headers="host date request-line digest", `
auth += `signature="${sign}"`;
 
console.log(`Authorization: ${auth}`);
```

## Create: 创建推流码

调用该接口创建一个推流码。

### HTTP 请求

```text
POST https://api.agora.io/{region}/v1/projects/{appId}/rtls/ingress/streamkeys
```

#### 路径参数

- `appId`：（必填）声网为每个开发者提供的 App ID，String 型。在声网控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。
- `region`：（必填）创建推流码的区域，String 型。声网支持分区域创建推流码，目前支持以下区域：
  - `cn`：中国大陆
  - `ap`：除中国大陆以外的亚洲区域
  - `na`：北美
  - `eu`：欧洲

<div class="alert note"><ul><li>请确保设置的 <code>region</code> 与输入的源流在同一个区域。</li><li>请确保设置的 <code>region</code> 与推流使用的域名在同一个区域。</li><li>请确保传入 <code>region</code> 的值为小写。</li></ul></div>

#### 请求头部

- `Authorization`：该字段的值详见[通过 HMAC HTTP 认证](#通过-hmac-http-认证)。
- `X-Request-ID`：本次请求的 UUID（通用唯一识别码）。传入该字段后，声网服务器会在响应 header 中返回该字段。

<div class="alert info">声网推荐用户对 <code>X-Request-ID</code> 赋值。如果用户不赋值，声网服务器会自动生成一个 UUID 传入。</div>

#### 请求包体

请求包体为 JSON Object 类型的 `settings` 字段，包含如下字段：

- `channel`：（必填）声网频道名称，String 型。字符串长度必须在 64 字节以内，支持以下字符集（共 89 个字符）：
  - 所有小写英文字母（a-z）
  - 所有大写英文字母（A-Z）
  - 数字 0-9
  - 空格
  - "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","
  <a id="uid"></a>
- `uid`：（必填）RTMP 网关在声网频道内的主播用户 UID，String 型。可以为数字 ID 或字符串 ID。如果为数字 ID，取值范围为 1 到 2<sup>32</sup>-1；如果为字符串 ID，不能超过 255 字节，也不能为空字符串。支持的字符集范围（共 89 个字符）如下：
  - 所有小写英文字母（a-z）
  - 所有大写英文字母（A-Z）
  - 数字 0-9
  - 空格
  - "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","
  详见[如何使用 String 型用户名](https://docs.agora.io/cn/faqs/string)。
- `expiresAfter`：（选填）创建的推流码的有效时长，Number 型，单位为秒。从创建时开始计算。如果填 `0`，则推流码永远有效。

<div class="alert note">为确保请求成功，请不要将必填字段设为 <code>null</code> 或 <code>""</code>。</div>

### HTTP 响应

所有可能的响应状态码详见[状态码汇总表](#状态码汇总表)。

#### 响应头部

`X-Request-ID`：本次请求的 UUID（通用唯一识别码）。该值为本次请求 header 中的 `X-Request-ID`。
- 如果请求出错，请在日志中打印出该值，排查问题。
- 如果本次请求的响应状态码为 `401(Unauthorized)`，那么响应头部中无该字段。

#### 响应包体

如果状态码为 `2xx` ，则请求成功。Body 中包含如下字段：

- `status`：请求状态，String 型，值为 `success`。
- `data`：JSON Object 型，包含以下字段：
  - `streamKey`：新创建的推流码，String 型。
  - `channel`：推流码绑定的声网频道名称，String 型。
  - `uid`：推流码绑定的声网频道内的用户 UID，String 型。
  - `expiresAfter`：推流码的有效时长，Number 型，从创建时开始计算，单位为秒。
  - `createdAt`：推流码创建的 Unix 间戳，String 型，单位为秒。


如果状态码不为 `2xx`，则请求失败。Body 中包含 String 型的 `message` 字段，描述失败的具体原因。

#### 响应示例

```json
{
    "status": "success",
    "data": {
        "streamKey": "2dfMTR****fys",
        "channel": "shx001",
        "uid": "1001",
        "expiresAfter": 0,
        "createdAt": "1686820170"
    }
}
```

## Query: 查询推流码信息

调用该接口，查询推流码的信息，如绑定的 UID，绑定的频道名，有效时长等。

### HTTP 请求

```text
GET https://api.agora.io/{region}/v1/projects/{appId}/rtls/ingress/streamkeys/{streamkey}
```

#### 路径参数

- `appId`：（必填）声网为每个开发者提供的 App ID，String 型。在声网控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。
- `region`：（必填）推流码的区域，String 型。目前支持以下区域：
  - `cn`：中国大陆
  - `ap`：除中国大陆以外的亚洲区域
  - `na`：北美
  - `eu`：欧洲

    <div class="alert note"><ul><li>请确保设置的 <code>region</code> 与创建推流码的区域一致。</li><li>请确保传入的 <code>region</code> 的值为小写。</li></ul></div>

- `streamkey`：（必填）要查询的推流码，String 型。

#### 请求头部

- `Authorization` ：该字段的值详见[通过 HMAC HTTP 认证](#通过-hmac-http-认证)。
- `X-Request-ID`：本次请求的 UUID（通用唯一识别码）。传入该字段后，声网服务器会在响应 header 中返回该字段。

<div class="alert info">声网推荐用户对 <code>X-Request-ID</code> 赋值。如果用户不赋值，声网服务器会自动生成一个 UUID 传入。</div>

### HTTP 响应

所有可能的响应状态码详见[状态码汇总表](#状态码汇总表)。

#### 响应头部

`X-Request-ID`：本次请求的 UUID（通用唯一识别码）。该值为本次请求 header 中的 `X-Request-ID`。
- 如果请求出错，请在日志中打印出该值，排查问题。
- 如果本次请求的响应状态码为 `401(Unauthorized)`，那么响应头部中无该字段。

#### 响应包体

如果状态码为 `2xx`，则请求成功。Body 中包含如下字段：

- `status`：请求状态，String 型，值为 `success`。
- `data`：JSON Object 型，包含以下字段：
  - `streamKey`：要查询的推流码，String 型。
  - `channel`：推流码绑定的声网频道名称，String 型。
  - `uid`：推流码绑定的声网频道内的用户 UID，String 型。
  - `expiresAfter`：推流码的有效时长，Number 型，从创建时开始计算，单位为秒。
  - `createdAt`：推流码创建的 Unix 间戳，String 型，单位为秒。

如果状态码不为 `2xx`，则请求失败。Body 中包含 String 类型的 `message` 字段，描述失败的具体原因。

#### 响应示例

```json
{
    "status": "success",
    "data": {
        "streamKey": "2dfMTR****fys",
        "channel": "shx001",
        "uid": "1001",
        "expiresAfter": 0,
        "createdAt": "1686820170"
    }
}
```

## Delete: 销毁推流码

调用该接口销毁不再使用的推流码。

### HTTP 请求

```text
DELETE https://api.agora.io/{region}/v1/projects/{appId}/rtls/ingress/streamkeys/{streamkey}
```

#### 路径参数

- `appId`：（必填）声网为每个开发者提供的 App ID，String 型。在声网控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。
- `region`：（必填）推流码的区域，String 型。目前支持以下区域：
  - `cn`：中国大陆
  - `ap`：除中国大陆以外的亚洲区域
  - `na`：北美
  - `eu`：欧洲

    <div class="alert note"><ul><li>请确保设置的 <code>region</code> 与创建推流码的区域一致。</li><li>请确保传入 <code>region</code> 的值为小写。</li></ul></div>
- `streamkey`：（必填）要销毁的推流码，String 型。

<div class="alert note">推流码被删除之后，就不能再使用该推流码进行推流。但如果推流码正在使用中，删除推流码并不会影响当前正在推送的流。如果要立即禁用该条流，请联系<a href="/cn/Agora%20Platform/ticket">声网技术支持</a>。</div>

#### 请求头部

- `Authorization` ：该字段的值详见[通过 HMAC HTTP 认证](#通过-hmac-http-认证)。
- `X-Request-ID`：本次请求的 UUID（通用唯一识别码）。传入该字段后，声网服务器会在响应 header 中返回该字段。

<div class="alert info">声网推荐用户对 <code>X-Request-ID</code> 赋值。如果用户不赋值，声网服务器会自动生成一个 UUID 传入。</div>

### HTTP 响应

所有可能的响应状态码详见[状态码汇总表](#状态码汇总表)。

#### 响应头部

`X-Request-ID`：本次请求的 UUID（通用唯一识别码）。该值为本次请求 header 中的 `X-Request-ID`。
- 如果请求出错，请在日志中打印出该值，排查问题。
- 如果本次请求的响应状态码为 `401(Unauthorized)`，那么响应头部中无该字段。

#### 响应包体

如果状态码为 `2xx`，则请求成功。Body 中包含如下字段：

- `status`：请求状态，String 型，值为 `success`。

如果状态码不为 `2xx`，则请求失败。Body 中包含 String 类型的 `message` 字段，描述失败的具体原因。

#### 响应示例

```json
{
    "status": "success"
}
```

## Update: 设置服务配置信息

调用该接口，设置 RTMP 网关服务的转码配置信息。

<div class="alert note"><ul><li>首次调用该接口设置服务配置信息时，设置成功后会立即生效。之后再调用该接口更新配置信息，调用成功后 5 分钟才会更新到全网所有节点。</li><li>调用该接口设置的配置信息对于在推的流不会立即生效，需要断开重推，才能使用更新后的配置信息。</li></ul></div>

### HTTP 请求

```text
PUT https://api.agora.io/{region}/v1/projects/{appId}/rtls/ingress/appconfig
```

#### 路径参数

- `appId`：（必填）声网为每个开发者提供的 App ID，String 型。在声网控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。
- `region`：（必填）创建推流码的区域，String 型。目前支持以下区域：
  - `cn`：中国大陆
  - `ap`：除中国大陆以外的亚洲区域
  - `na`：北美
  - `eu`：欧洲

<div class="alert note"><ul><li>请确保传入的 <code>region</code> 与创建推流码的区域一致。</li><li>请确保设置的 <code>region</code> 与推流使用的域名在同一个区域。</li><li>请确保传入 <code>region</code> 的值为小写。</li></ul></div>

#### 请求头部

- `Authorization` ：该字段的值详见[通过 HMAC HTTP 认证](#通过-hmac-http-认证)。
- `X-Request-ID`：本次请求的 UUID（通用唯一识别码）。传入该字段后，声网服务器会在响应 header 中返回该字段。

<div class="alert info">声网推荐用户对 <code>X-Request-ID</code> 赋值。如果用户不赋值，声网服务器会自动生成一个 UUID 传入。</div>

#### 请求包体

请求包体为 JSON Object 类型的 `settings` 字段，包含如下字段：

- `transcoding`（选填）转码设置，JSON Object 型。包括以下字段：
  - `video`（选填）视频转码设置，JSON Object 型。包括以下字段：
    - `enabled`（必填）是否开启视频转码，Boolean 型，默认值为 `false`（关闭）。
    - `width`（选填）编码分辨率中的宽度，Number 型。取值范围为 2 到 1920。
    - `height`（选填）编码分辨率中的高度，Number 型。取值范围为 2 到 1920。
    - `fps`（选填）编码帧率，Number 型。取值范围为 1 到 60。
    - `bitrate`（选填）编码码率，Number 型。取值范围取决于设置的 `width`，`height`，`fps` 值，如果超出范围会重置到有效范围（具体设置请联系<a href="/cn/Agora%20Platform/ticket">声网技术支持</a>确认）。
  - `audio`（选填）音频转码设置，JSON Object 型。包括以下字段：
    - `enabled`（必填）是否开启音频转码，Boolean 型。默认值为 `true`（开启）。
    - `profile`（选填）编码音频场景，Number 型。默认为 `0`，表示：48 KHz 采样率，音乐编码，单声道，编码码率最大值为 64 Kbps。如要设置其它场景，请联系<a href="/cn/Agora%20Platform/ticket">声网技术支持</a>确认。
- `simulcastStream`（选填）视频大小流功能，用于提高弱网环境下观众端的自适应切换能力，JSON Object 型。包括以下字段：
  - `enabled`（必填）是否开启视频小流转码，Boolean 型。默认值为 `false`（关闭）。如果要开启，必须要同时开启视频转码功能。
  - `width`（选填）小流分辨率中的宽度，Number 型。取值范围为 2 到 1920。
  - `height`（选填）小流分辨率中的高度，Number 型。取值范围为 2 到 1920。
  - `fps`（选填）小流帧率，Number 型。取值范围为 1 到 60。
  - `bitrate`（选填）小流码率，Number 型。取值范围取决于设置的 `width`，`height`，`fps` 值，若超出范围会重置到有效范围（具体设置请联系<a href="/cn/Agora%20Platform/ticket">声网技术支持</a>确认）。

<div class="alert note">为确保请求成功，请不要将必填字段设为 <code>null</code> 或 <code>""</code>。</div>


### HTTP 响应

所有可能的响应状态码详见[状态码汇总表](#状态码汇总表)。

#### 响应头部

`X-Request-ID`：本次请求的 UUID（通用唯一识别码）。该值为本次请求 header 中的 `X-Request-ID`。
- 如果请求出错，请在日志中打印出该值，排查问题。
- 如果本次请求的响应状态码为 `401(Unauthorized)`，那么响应头部中无该字段。

#### 响应包体

如果状态码为 `2xx`，则请求成功。Body 中包含如下字段：

- `status`：请求状态，String 型，值为 `success`。

如果状态码不为 `2xx`，则请求失败。Body 中包含 String 类型的 `message` 字段，描述失败的具体原因。

#### 响应示例

```json
{
    "status": "success"
}
```


## 状态码汇总表

- 如果状态码为 `2xx`，则请求成功。
- 如果状态码不为 `2xx`，则请求失败。请根据对应的响应包体中的 `message` 字段内容排查问题。

| 状态码                  | 可能的 `message` 字段内容                                      | 错误原因 | 解决方案 |
| :---------------------- | :----------------------------------------------------------- | ------- | ------- |
| 200 OK                  |  / | 请求成功。  |    /      |
| 400 Bad Request         | <ul><li>Invalid settings.</li><li>Parameter 'channel' is invalid formatted.</li><li>Streamkey exists in region:na.</li></ul> | 请求参数错误。  |    根据 `message` 字段的具体内容进行排查。      |
| 401 Unauthorized        | Invalid authentication credentials.                          | RESTful API 认证失败。  |    重新进行 [HMAC 认证](#通过-hmac-http-认证)。      |
| 403 Forbidden           | <ul><li>This project has not enabled RTMP Gateway yet. Contact us to enable it.</li><li>Stream does not belong to this app ID.</li></ul> | <ul><li>未开通 RTMP 网关服务。</li><li>查询的推流码不属于该  App ID。</li></ul>  |  <ul><li>[联系技术支持](/cn/Agora%20Platform/ticket)开通 RTMP 网关服务。</li><li>检查传入的 `streamkey` 和 App ID 是否匹配。</li></ul>    |
| 404 Not Found           | Resource is not found and destroyed.                         | 请求的资源不存在。 | 检查传入的 `streamkey` 是否正确。 |
| 409 Conflict            | Resource with the same name already exists.                  | 并发请求过多。 | 采取退避策略重试。例如，第一次等待 1 秒后重试，第二次等待 3 秒后重试，第三次等待 6 秒后重试。 |
| 429 Too Many Requests   | <ul><li>Request rate limit exceeded.</li><li>Resources quota limit exceeded.</li><li>No available resources.</li></ul> | 服务端内部错误。 | 采取退避策略重试。 |
| 500 Unknown             | Some internal error happened. Contact us to help fix it.    | 服务端内部错误。 | 采取退避策略重试。 |
| 503 Service Unavailable | <ul><li>Service overload. Retry with back off strategy, and contact us to help fix it.</li><li>Service unavailable temporarily. Retry with back off strategy.</li></ul> | 服务端内部错误。 | 采取退避策略重试。 |
| 504 Gateway Timeout     | Gateway timeout. Query to check whether the player has been created, or to create another one instead. | 服务端内部错误。 | 采取退避策略重试。 |

## 注意事项

本节总结使用 RTMP 网关功能的基础注意事项：

- 请确保声网频道场景为直播。
- 如果你需要同一个频道内推送多路不同的流，请确保每个推流码的 `uid` 都是唯一的，详见 [`uid` 参数说明](#uid)。
- 请确保将 `region` 设置为媒体流源站所在区域，详见 [`region` 参数说明](#region)。

