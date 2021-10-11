## 设置预置的转码模版

为指定发布点设置预置的转码模版。

### HTTP 请求

```http
PATCH https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/settings/transcode/standard/{name}
```

#### 路径参数

|参数|类型|描述|
|:------|:------|:------|
|`appid`|String|必填。发布点对应的 App ID。|
|`entry_point`|String|必填。发布点名称。 |
|`name`|String|必填。转码模版，详见下表。|

**转码模版配置**

| `name` | 转码模版 | 分辨率                | 视频码率（kbps） | 编码格式 |
| :----- | :------- | :-------------------- | :--------------- | :------- |
| `ld`   | 流畅     | 高度 240，宽度自适应  | 400              | H.264    |
| `sd1`  | 标清一   | 高度 360，宽度自适应  | 640              | H.264    |
| `sd2`  | 标清二   | 高度 480，宽度自适应  | 800              | H.264    |
| `sd3`  | 标清三   | 高度 540，宽度自适应  | 1,200            | H.264    |
| `hd`   | 高清     | 高度 720，宽度自适应  | 1,500            | H.264    |
| `fhd`  | 超清     | 高度 1080，宽度自适应 | 2,100            | H.264    |


#### 请求包体

请求包体为 JSON Object 类型，包含以下字段：

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

|参数|类型|描述|
|:------|:------|:------|
|`appid`|String|必填。发布点对应的 App ID。|
|`entry_point`|String|必填。发布点名称。 |

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

`transcodeList`: JSON Array 型，转码模版列表。一个转码模版对应一个 JSON Object，包含以下字段：

|字段|类型|描述|
|:------|:------|:------|
|`name`|String|转码模版的名称。|
|`enabled`|Bool|转码模版是否已启用。|

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

| 状态码 | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| 200    | 请求成功。                                                   |
| 400    | 参数非法，如 `appid` 或者 `name` 为空。                      |
| 401    | 未经授权的（客户 ID/客户密钥匹配错误）。                     |
| 404    | 服务器无法根据请求找到资源，即请求的发布点不存在，或者请求的 URI 路径非法。 |
| 500    | 服务器内部错误，无法完成请求。                               |
| 504    | 服务器内部错误。充当网关或代理的服务器未从远端服务器获取请求。 |
