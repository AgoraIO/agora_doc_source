## 设置预置的转码模版

为指定发布点设置预置的转码模版。

### HTTP 请求

```http
PATCH https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/settings/transcode/standard/{name}
```

#### 路径参数

- `appid`：String 型，必填。Agora 为每个开发者提供的 **App ID**。在 Agora 控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。
- `entry_point`：String 型，必填。发布点名称。
- `name`：String 型，必填。转码模版名称：
  - `fhd`
  - `hd`
  - `sd1`
  - `sd2`
  - `sd3`
  - `ld`

#### 请求包体

请求包体为 JSON Object 类型，参数如下：

- `enabled`：Bool 型，必填。是否启用转码模版。
  - `true`：启用转码模版。
  - `false`：不启用转码模版。

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
PATCH https://api.agora.io/v1/projects/{your_appid}/fls/entry_points/live/settings/transcode/standard/sd1 HTTP/1.1
```

**请求 body**

```json
{
    "enabled": true
}
```

**响应行**

```http
HTTP/1.1 200 OK
```



## 获取转码模版列表

获取指定发布点的转码模版列表。

### HTTP 请求

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/settings/transcode/standard
```

#### 路径参数

- `appid`：String 型，必填。发布点对应的 App ID。
- `entry_point`：String 型，必填。发布点名称。

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

- `transcodeList`: JSON Array 型，由 `TranscodeSetting` 组成的数组。转码模版列表。
  - `TranscodeSetting`：JSON Object 型，包含一个转码模版的信息。
    - `name`：String 型，转码模版的名称。
    - `enabled`：Bool 型，转码模版是否已启用。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
GET https://api.agora.io/v1/projects/{your_appid}/fls/entry_points/live/settings/transcode/standard HTTP/1.1
```

**响应行**

```http
HTTP/1.1 200 OK
```

**响应 body**

```json
{
    "transcodeList": [
        {
            "enabled": true,
            "name": "sd1"
        },
        {
            "enabled": true,
            "name": "sd2"
        },
        {
            "enabled": true,
            "name": "sd3"
        }
    ]
}
```

<a name="http-code"></a>
## HTTP 状态码

| 状态码 | 可能的原因                              |
| :----- | :-------------------------------------- |
| 200    | /                                       |
| 400    | 参数非法，如 `appid` 或者 `name` 为空。 |
| 500    | 服务器内部错误。                        |