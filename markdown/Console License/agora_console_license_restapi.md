# RESTful API 参考

本页面介绍 Agora 控制台 License RESTful API 的详细信息。

## 基本信息

本节介绍所有 Agora 控制台 License RESTful API 的基本信息。

### 域名

所有请求都发送给域名：`api.agora.io`。

### 数据格式

所有 HTTP 请求头部的 `Content-Type` 类型为 `application/json`。所有请求和响应内容的格式均为 JSON。所有的请求 URL 和请求包体内容都区分大小写。

### 认证方式

Agora 控制台 RESTful API 仅支持 HTTPS 协议。发送请求时，你需要使用 Agora 提供的客户 ID 和客户密钥生成一个 Base64 算法编码的凭证，并填入 HTTP 请求头部的 `Authorization` 字段中。详见 [如何在 RESTful API 中进行 HTTP 基本认证和 Token 认证](https://docs.agora.io/cn/Video/faq/restful_authentication)。

### 调用频率限制

对于每个 Agora 账号（非每个 App ID），本页每个 API 的调用频率上限为每秒 10 次。如果调用频率超出限制，参考 [如何处理服务端 RESTful API 调用超出频率限制](https://docs.agora.io/cn/Video/faq/restful_api_call_frequency) 优化调用频率。


## 激活 License




