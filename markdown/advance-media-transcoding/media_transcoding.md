---
title: 低码高清快速开始
platform: All Platforms
updatedAt: 2021-01-27 09:11:51
---

## 简介

Agora 为 CDN 直播推流场景研发出低码高清服务，用于接收并处理你的 RTMP 流。经过 Agora 低码高清服务处理后，RTMP 流可以在同等视频清晰度下使用更低的视频码率，从而节省你的 CDN 带宽费用。

CDN 直播推流时，你往往需要在推流工具或 API 中填写用于推流的 RTMP URL。联系 sales@agora.io 开通低码高清服务后，请参考如下步骤进行推流：

1. 通过低码高清 RESTful API，获得与你当前用于推流的 RTMP URL（即原始 URL）相对应的新 RTMP URL。
2. 在推流工具中填写新的 RTMP URL，发起推流。

## HTTP 请求

```http
POST https://api.agora.io/v1/projects/<appId>/rtmp-pusher
```

```http
POST https://api.agora.io/v1/projects/<appId>/rtmp-pusher?streamIp={streamIp}
```

| 参数       | 类型                                 | 含义                                                                                                                  |
| ---------- | ------------------------------------ | --------------------------------------------------------------------------------------------------------------------- |
| `appId`    | 路径参数（必填）。String 型。        | Agora 为每个开发者提供的 App ID。在 Agora 控制台创建一个项目后即可得到一个 App ID。                                   |
| `streamIp` | Query Parameter（可选）。String 型。 | 上行 RTMP 流的 IP 地址。必须为有效的 IPv4 地址。Agora 会根据该 IP 地址就近分配服务器以保障 Agora 低码高清服务的质量。 |

## 请求报文的 Header 字段

- `Content-Type`: `application/json`
- `X-Request-ID`: UUID（通用唯一识别码），标识本次请求。传入该字段后，Agora 服务器会在响应 Header 中返回该字段。
  > Agora 推荐你对 `X-Request-ID` 赋值。如果你不赋值，Agora 服务器会自动生成一个 UUID 传入。
- 鉴权字段：
  - 如果你未在控制台启用 App 证书，请你使用 HTTP Basic 认证。鉴权字段为 `Authorization`。字段值请参考 [HTTP Basic 认证说明](https://docs.agora.io/cn/faq/restful_authentication)。
  - 如果你已经在控制台启用 App 证书，你可以使用 HTTP Basic 认证或 Agora 的 Token 认证。Agora Token 认证的鉴权字段如下：
    - `x-agora-token`: 项目 Token。
    - `x-agora-uid`: 整型的用户 ID。

## 请求报文的 Body

```json
{
  "rtmpUrl": "your original rtmp url"
}
```

| 字段      | 类型              | 含义                                         |
| --------- | ----------------- | -------------------------------------------- |
| `rtmpUrl` | 必填。String 型。 | 当前用于推流的 RTMP URL（即原始 RTMP URL）。 |

**Note**：为正常使用低码高清服务，请确保你的原始 RTMP URL 满足如下要求：

- 原始 RTMP URL 包含 `host`、`app` 和 `name` 这三个路径参数：
  - `host`: CDN 厂商的 host 地址。
  - `app`: RTMP 协议中的 `app` 字段。
  - `name`: RTMP 协议中的 `name` 字段。
- 原始 RTMP URL 包含的 `name` 字段需满足如下要求：
  - 请对不同的 RTMP 流使用不同的 `name` 值。
  - `name` 的字符长度不得超过 31 位。
  - 推荐使用的字符集范围为：
    - 数字 0-9
    - 所有小写英文字母（a-z）
    - 所有大写英文字母（A-Z）
    - "-", "\_"

示例：`rtmp://xxx.agora.io/live/test1?auth_key=1a2b3456`

## 响应报文的 Header 字段

`X-Request-ID`: UUID（通用唯一识别码），标识本次请求。该值为本次请求 Header 中 `X-Request-ID`。

## 响应报文的 Body

如果响应的 HTTP 状态码为 200，请求成功。响应 Body 示例如下：

```json
{
  "rtmpUrl": "your new rtmp url"
}
```

| 字段      | 类型        | 含义                                                                             |
| --------- | ----------- | -------------------------------------------------------------------------------- |
| `rtmpUrl` | String 型。 | Agora 为你生成的新 RTMP URL。该 URL 标识一路已经经过低码高清服务处理的 RTMP 流。 |

**Note**：收到 Agora 响应的 `rtmpUrl` 后，请在 15 分钟内使用该 URL 发起推流。如果超时使用，你将无法成功发起推流。此时，你需要重新向 Agora 发起 HTTP 请求，重新获取一个 Agora 为你生成的 `rtmpUrl`。

如果响应的 HTTP 状态码不为 200，请求失败。Body 中包含 String 型的 `message` 字段，描述请求失败的具体原因。

```json
{
  "message": "Unauthorized"
}
```

## 开发注意事项

- 为正常使用低码高清服务，请不要将上行 RTMP 流的 metadata 中的视频码率设为 0。比如，OBS 推流时，请不要将 OBS 的码率控制模式设置为 CRF。
- HTTP 请求失败时，请通过 `X-Request-ID` 和 `message` 字段排查问题。
- 成功发起推流后，如果遇到推流中断的情况，你需要再次向 Agora 发起 HTTP 请求，重新获取一个 Agora 为你生成的 `rtmpUrl`，并使用该 URL 重新发起推流。
