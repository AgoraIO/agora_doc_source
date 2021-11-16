鉴权功能处于内测阶段，使用前请联系 sales@agora.io。

## 设置防盗链密钥

设置指定域名的防盗链密钥。

### HTTP 请求

```http
PATCH https://api.agora.io/v1/projects/{appid}/fls/domains/{domain}
```

#### 路径参数

|参数|类型|描述|
|:------|:------|:------|
|`appid`|String|必填。要设置的域名对应的 App ID。|
|`domain`|String|必填。域名名称。|

#### 请求包体

请求包体为 JSON Object 类型，包含以下字段：

`authKey`：String 型，必填，长度不超过 128 个字符。防盗链密钥。

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
PATCH https://api.agora.io/v1/projects/{your_appid}/fls/domains/{your_domain} HTTP/1.1
```

**请求 body**

```json
{
    "authKey": "{your auth key}"
}
```

**响应行**

```http
HTTP/1.1 200 OK
```

<a name="http-code"></a>
## HTTP 状态码

| 状态码 | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| 200    | 请求成功。                                                   |
| 400    | 参数非法，如 `appid` 或者 `domain` 为空。                    |
| 401    | 未经授权的（客户 ID/客户密钥匹配错误）。                     |
| 404    | 服务器无法根据请求找到资源，即请求的域名不存在，或者请求的 URI 路径非法。 |
| 500    | 服务器内部错误，无法完成请求。                               |
| 504    | 服务器内部错误。充当网关或代理的服务器未从远端服务器获取请求。 |
