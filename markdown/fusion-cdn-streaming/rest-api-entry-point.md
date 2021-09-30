发布点用于对直播流进行分组。你可以针对一个发布点配置录制、转码、截图等功能，这些配置适用于这个发布点下的所有流。

Agora 提供一个默认发布点 `live`，你可以直接使用。

> 发布点管理功能处于内测阶段，使用前请联系 sales@agora.io。

## 增加发布点

增加一个发布点。

增加发布点时需要指定你的 Agora 项目的 App ID。

### HTTP 请求

```http
POST https://api.agora.io/v1/projects/{appid}/fls/entry_points?id={entry_point}
```

#### 路径参数

`appid`：String 型，必填参数。Agora 为每个开发者提供的 **App ID**。在 Agora 控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。

#### Query 参数

`id`：String 型，必填参数。要增加的发布点名称。

### HTTP 响应

如果返回的 HTTP 状态码为 201，表示请求成功。

如果返回的 HTTP 状态码非 201，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
POST https://api.agora.io/v1/projects/{your_appid}/fls/entry_points?id=live2 HTTP/1.1
```

**响应行**

```http
HTTP/1.1 201 Created
```

## 删除发布点

删除一个发布点。默认的发布点 `live` 不可删除。

### HTTP 请求

```http
DELETE https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}
```

#### 路径参数

- `appid`：String 型，必填参数。要删除的域名对应的 App ID。
- `entry_point`：String 型，必填参数。要删除的发布点名称。

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
DELETE https://api.agora.io/v1/projects/{your_appid}/fls/entry_points/live2
```

**响应行**

```http
HTTP/1.1 200 OK
```

## 获取发布点列表

获取一个 Agora 项目下所有的发布点。

### HTTP 请求

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points
```

#### 路径参数

`appid`：String 型，必填参数。你的 Agora 项目的 App ID。

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

`entryPointList`：JSON Array 型，由 `EntryPoint` 组成的数组。发布点列表。

- `EntryPoint`：JSON Object 型，包含一个发布点的信息。
  - `name`：String 型，发布点名称。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
GET https://api.agora.io/v1/projects/{your_appid}/fls/entry_points HTTP/1.1
```

**响应行**

```http
HTTP/1.1 200 OK
```

**响应 body**

```json
{
    "entryPointList": [
        {
            "name": "live"
        }
    ]
}
```

<a name="http-code"></a>

## HTTP 状态码

| 状态码 | 可能的原因                                                   |
| :----- | :----------------------------------------------------------- |
| 200    | /                                                            |
| 400    | 参数非法，如 `appid` 或者 `entry_point` 为空。要增加的发布点已经存在。发布点数目超出上限。 |
| 404    | 请求的发布点不存在。                                         |
| 500    | 服务器内部错误。                                             |