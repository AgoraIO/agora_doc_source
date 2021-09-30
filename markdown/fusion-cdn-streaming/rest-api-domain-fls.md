域名分为推流域名和播流域名两种，主要影响流的接入区域、调度等行为。同一条直播流可以通过多个不同的域名进行推流和播流。

> 域名管理功能目前处于内测阶段，使用前请联系 [sales@agora.io](mailto:sales@agora.io)。

## 增加域名

增加一个直播域名。

增加域名时需要指定你的 Agora 项目的 App ID。一个 App ID 下仅支持添加一个推流域名，可以添加多个播流域名。

### HTTP 请求

```http
POST https://api.agora.io/v1/projects/{appid}/fls/domains?id={domain}
```

#### 路径参数

`appid`：String 型，必填。Agora 为每个开发者提供的 **App ID**。在 Agora 控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。

#### Query 参数

`id`：String 型，必填。要增加的域名名称，不支持泛域名。

#### 请求包体

请求包体为 JSON Object 类型的 data 字段，包含如下字段：

- `type`：String 型，必填。域名类型：
  - `"publish"`：推流域名。
  - `"play"`：播流域名。
- `region`：String 型，域名为推流域名时该参数必填，域名为播流域名时该参数选填。域名使用的 Agora 服务器所在区域：
  - `"cn"`：中国。
  - `"ap"`：除中国大陆以外的亚洲区域。
  - `"eu"`：欧洲。
  - `"na"`：北美。

### HTTP 响应

如果返回的 HTTP 状态码为 201，表示请求成功，响应包体中包含以下字段：

- `appid`：String 型。Agora 项目的 App ID。
- `type`：String 型。设置的域名类型：
  - `"publish"`：推流域名。
  - `"play"`：播流域名。
- `region`：String 型。设置的 Agora 服务器所在区域。
- `authKey`：String 型。防盗链密钥。
- `cname`：String 型。域名对应的 cname，你需要在自己的 DNS 托管商处进行配置。

如果返回的 HTTP 状态码非 201，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
POST https://api.agora.io/v1/projects/{your appid}/fls/domains?id={your domain} HTTP/1.1
```

**请求 body**

```json
{
    "region": "cn",
    "type": "publish"
}
```

**响应行**

```http
HTTP/1.1 201 Created
```

**响应 body**

```json
{
    "appid": "{your appid}",
    "name": "{your domain}",
    "region": "cn",
    "type": "publish"
}
```



## 删除域名

删除一个直播域名。

### HTTP 请求

```http
DELETE https://api.agora.io/v1/projects/{appid}/fls/domains/{domain}
```

#### 路径参数

- `appid`：String 型，必填。要删除的域名对应的 App ID。
- `domain`：String 型，必填。要删除的域名名称。

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
DELETE https://api.agora.io/v1/projects/{your appid}/fls/domains/{your domain} HTTP/1.1
```

**响应行**

```http
HTTP/1.1 200 OK
```

## 获取域名列表

获取一个 Agora 项目下所有的直播域名。

### HTTP 请求

```http
GET https://api.agora.io/v1/projects/{appid}/fls/domains
```

#### 路径参数

`appid`：String 型，必填。你的 Agora 项目的 App ID。

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

`domainList`：JSON Array 型，由 `Domain` 组成的数组。域名列表。

- `Domain`：JSON Object 型，包含一个域名相关的信息。
  - `appid`：String 型。Agora 项目的 App ID。
  - `name`：String 型，域名名称。
  - `type`：String 型，域名类型。
    - `"publish"`：推流域名。
    - `"play"`：播流域名。
  - `region`：String 型，域名使用的 Agora 服务器所在区域。
  - `authKey`：String 型，防盗链密钥。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
GET https://api.agora.io/v1/projects/{your appid}/fls/domains HTTP/1.1
```

**响应行**

```http
HTTP/1.1 200 OK
```

**响应 body**

```json
{
    "domainList": [
        {
            "appid": "{your appid}",
            "authKey": "{your authkey}",
            "name": "{your play domain}",
            "type": "play"
        },
        {
            "appid": "{your appid}",
            "name": "{your publish domain}",
            "region": "cn",
            "type": "publish"
        }
    ]
}
```



## 获取域名属性

获取指定域名的属性。

### HTTP 请求

```http
GET https://api.agora.io/v1/projects/{appid}/fls/domains/{domain}
```

#### 路径参数

- `appid`：String 型，必填。要查询的域名对应的 App ID。
- `domain`：String 型，必填。要查询的域名名称。

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

- `appid`：String 型。Agora 项目的 App ID。
- `type`：String 型，域名类型。
  - `"publish"`：推流域名。
  - `"play"`：播流域名。
- `region`：String 型，域名使用的 Agora 服务器所在区域。
- `authKey`：String 型，防盗链密钥。
- `cname`：String 型，域名对应的 cname，你需要在自己的 DNS 托管商处进行配置。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
GET https://api.agora.io/v1/projects/{your appid}/fls/domains?id={your domain} HTTP/1.1
```

**响应行**

```http
HTTP/1.1 200 OK
```

**响应 body**

```json
{
    "appid": "{your appid}",
    "authKey": "{your authkey}",
    "name": "{your domain}",
    "region": "cn",
    "type": "publish"
}
```

<a name="http-code"></a>

## HTTP 状态码

| 状态码 | 可能的原因                                                   |
| :----- | :----------------------------------------------------------- |
| 200    | /                                                            |
| 400    | <li>参数非法，如 `appid` 或者 `domain` 为空。</li><li>要增加的域名已经存在。</li><li>域名数目超出上限。目前仅支持添加一个推流域名。</li> |
| 404    | 请求的域名不存在。                                           |
| 500    | 服务器内部错误。                                             |