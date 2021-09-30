鉴权功能处于内测阶段，使用前请联系 sales@agora.io。

## 设置鉴权密钥

设置指定域名的鉴权密钥。

### HTTP 请求

```http
PATCH https://api.agora.io/v1/projects/{appid}/fls/domains/{domain}
```

#### 路径参数

- `appid`：String 型，必填。Agora 为每个开发者提供的 App ID。在 Agora 控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。
- `domain`：String 型，必填。域名名称。

#### 请求包体

请求包体为 JSON Object 类型，参数如下：

- `authKey`：String 型，必填，长度不超过 128 个字符。鉴权密钥。

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
PATCH https://api.agora.io/v1/projects/{your appid}/fls/domains/{your domain} HTTP/1.1
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

| 状态码 | 可能的原因                                |
| :----- | :---------------------------------------- |
| 200    | /                                         |
| 400    | 参数非法，如 `appid` 或者 `domain` 为空。 |
| 404    | 请求的域名不存在。                        |
| 500    | 服务器内部错误。                          |