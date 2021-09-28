Agora 融合 CDN 直播提供 RESTful API，你可以通过你的业务服务器向 Agora 服务器发送 HTTP 请求，在服务端配置和管理直播。

本文介绍融合 CDN 直播 RESTful API 的基础信息。

## 主要功能

融合 CDN 直播 RESTful API 主要功能如下：

### 域名及发布点管理

- 域名分为推流域名和播流域名两种，主要影响流的接入区域、调度等行为。同一条直播流可以通过多个不同的域名进行推流和播流。
- 发布点用于对直播流进行分组。你可以针对一个发布点配置录制、转码、截图等功能，这些配置适用于这个发布点下的所有流。

### 直播流录制

录制指定发布点的直播流，可以设置录制文件的类型、第三方云存储服务厂商等。

### 直播流内容处理

- 截图及内容审核：对指定发布点的直播流开启/关闭截图和内容审核功能。支持设置截图间隔，将截图上传至第三方云存储服务。
- 转码：对指定发布点的直播流转码，修改音视频编码配置。支持多种预置的转码配置及自定义转码配置。

### 直播流管理

封禁/取消封禁直播流，查询推流信息。

### 推流/播流鉴权

对指定域名下的推流和播流设置鉴权密钥。

## 实现流程

调用融合 CDN 直播 RESTful API 的主要流程如下：

1. 添加推流和播流域名。
2. （可选）添加发布点。
   该步骤为可选操作。Agora 提供一个默认发布点，你可以直接使用。
3. 对发布点进行直播流的功能配置、推流信息查询、管理直播流等操作。

## 请求结构

### 认证方式

融合 CDN 直播 RESTful API 使用 HTTP HMAC (Hash-based Message Authentication Code) 认证。

在发送 HTTP 请求时，你需要通过 HMAC-SHA256 算法生成一个签名，并在请求头部的 `authorization` 字段传入签名及相关信息。

在生成认证字段过程中，你需要用到以下 Agora 账号的信息：

- Agora 项目的 App ID，详见[获取 App ID](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id)。
- Agora 控制台 RESTful API 中提供的客户 ID 及客户密钥，详见[生成客户 ID 和密钥](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#生成客户-id-和密钥)。

下面的 Python 代码（Python 3.7+）以获取域名列表的 API 为例，演示如何生成 `authorization` 字段的值：

```python
import hmac
import base64
import datetime
from hashlib import sha256
 
# 你的 Agora 项目的 App ID
appid = ''
# Agora 控制台 RESTful API 中获取的客户 ID
customer_username = ''
# Agora 控制台 RESTful API 中获取的客户密钥
customer_secret = ''
 
# 请求域名
host = "api.agora.io"
# 请求方法和 endpoint
req_metd = 'GET'
path = f'/v1/projects/{appid}/fls/domains'
 
body_sha256 = sha256(data.encode('utf-8')).digest()
body_sha256_base64 = base64.b64encode(body_sha256)
date = datetime.datetime.utcnow().strftime('%a, %d %b %Y %H:%M:%S GMT')
request_line = "{} {} {}".format(req_metd, path, "HTTP/1.1")
digest = "SHA-256={}".format(body_sha256_base64.decode("utf-8"))
signing_string = "host: {}\ndate: {}\n{}\ndigest: {}".format(host, date, request_line, digest)
signature = base64.b64encode(
    hmac.new(customer_secret.encode("utf-8"), signing_string.encode("utf-8"), sha256).digest())
authorization = 'hmac username="{}", algorithm="hmac-sha256", headers="host date request-line digest", signature="{}"'.format(
    customer_username, signature.decode("utf-8"))
```

### 服务器地址

所有的请求均发送给域名：`api.agora.io`。

### 通信协议

为了保障通信安全，融合 CDN 直播 RESTful API 仅支持 HTTPS 协议。

### 数据格式

- 请求：请求的格式详见具体 API 中的示例。
- 响应：响应内容的格式为 JSON。

> 所有的请求 URL 和请求包体内容都是区分大小写的。

## API 限制

融合 CDN 直播 RESTful API 有以下限制：

- API 调用频率上限为 50 次/秒。如果调用频率超出上限，请参考[如何处理服务端 RESTful API 调用超出频率限制](https://docs.agora.io/cn/fusion-cdn-streaming/faq/restful_api_call_frequency)。
- 一个 App ID 只能添加一个推流域名。