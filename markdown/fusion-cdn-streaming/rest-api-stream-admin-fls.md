## 封禁直播流

封禁指定的直播流。

### HTTP 请求

```http
PATCH https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/admin/banned_streams/{stream_name}
```

#### 路径参数

- `appid`：String 型，必填。Agora 为每个开发者提供的 App ID。在 Agora 控制台创建一个项目后即可得到一个 App ID。一个 App ID 是一个项目的唯一标识。
- `entry_point`：String 型，必填。发布点名称。
- `stream_name`：String 型，必填。要封禁的直播流名称。

#### 请求包体

请求包体为 JSON Object 类型，参数如下：

`resumeTime`：String 型，选填。恢复流的时间，RFC3339 格式，例如：`2018-1129T19:00:00+08:00`。默认恢复时间为封禁后 7 天。

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
PATCH https://api.agora.io/v1/projects/{your_appid}/fls/entry_points/live/admin/banned_streams/{your_stream_name} HTTP/1.1
```

**请求 body**

```json
{
    "resumeTime": "2021-11-29T19:00:00+08:00"
}
```

**响应行**

```http
HTTP/1.1 200 OK
```



## 取消封禁直播流

取消封禁指定的直播流。

### HTTP 请求

```http
DELETE https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/admin/banned_streams/{stream_name}
```

#### 路径参数

- `appid`：String 型，必填。发布点对应的 App ID。
- `entry_point`：String 型，必填。发布点名称。
- `stream_name`：String 型，必填。要取消封禁的直播流名称。

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
DELETE https://api.agora.io/v1/projects/{your_appid}/fls/entry_points/live/admin/banned_streams/{your_stream_name} HTTP/1.1
```

**响应行**

```http
HTTP/1.1 200 OK
```

## 获取封禁的流列表

获取指定发布点下所有被封禁的直播流的列表。

### HTTP 请求

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/admin/banned_streams
```

#### 路径参数

- `appid`：String 型，必填。发布点对应的 App ID。
- `entry_point`：String 型，必填。发布点名称。

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功。响应包体中包含以下字段：

`bannedStreamList`：JSON Array 型，由 `Stream` 组成的数组。已被封禁的直播流列表：

- `Stream`：JSON Object 型。包含一个直播流的信息：
  - `name`：String 型，流的名称。
  - `resumeTime`：String 型，恢复流的时间。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/live/admin/banned_streams HTTP/1.1
```

**响应行**

```http
HTTP/1.1 200 OK
```

**响应 body**

```json
{
    "bannedStreamList": [
        {
            "name": "{your_stream_name}",
            "resumeTime": "2021-11-29T19:00:00+08:00"
        }
    ]
}
```

## 查询在线流列表

分页查询指定发布点下的在线流列表。

### HTTP 请求

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/reports/online_streams
```

#### 路径参数

- `appid`：String 型，必填。发布点对应的 App ID。
- `entry_point`：String 型，必填。发布点名称。

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功。响应包体中包含以下字段：

`streamList`：JSON Array 型，由 `Stream` 组成的数组。在线流列表：

- `Stream`：JSON Object 型。包含一个直播流的信息：
  - `name`：String 型，流的名称。
  - `startTime`：String 型，推流的时间。RFC3339 格式，例如 `"2019-01-07T12:00:00Z"`。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/live/reports/online_streams HTTP/1.1
```

**响应行**

```http
HTTP/1.1 200 OK
```

**响应 body**

```json
{
    "streamList": [
        {
            "name": "{your_stream_name_1}",
            "startTime": "2021-11-29T19:00:00+08:00"
        },
        {
            "name": "{your_stream_name_2}",
            "startTime": "2021-11-29T19:00:00+08:00"
        },
    ]
}
```

## 获取在线流信息

获取指定在线流的信息。

### HTTP 请求

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/reports/online_streams/{stream_name}
```

#### 路径参数

- `appid`：String 型，必填。发布点对应的 App ID。
- `entry_point`：String 型，必填。发布点名称。
- `stream_name`：String 型，必填。要查询的直播流名称。

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功。响应包体中包含以下字段：

`startTime`：String 型，推流的时间。RFC3339 格式，例如 `"2019-01-07T12:00:00Z"`。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/live/reports/online_streams/{stream_name} HTTP/1.1
```

**响应行**

```http
HTTP/1.1 200 OK
```

## 获取推流历史

获取指定发布点下某个时间范围内的推流历史。支持查询 60 天内的推流记录。

### HTTP 请求

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/reports/publish_history?start_time={start_time}&end_time={end_time}?stream_name={stream_name}
```

#### 路径参数

- `appid`：String 型，必填。发布点对应的 App ID。
- `entry_point`：String 型，必填。发布点名称。

#### Query 参数

- `start_time`：String 型，选填。查询推流历史的开始时间，格式为 RFC3339 时间格式对应的 URL 编码，例如 `2019-01-07T12:00:00+08:00` 对应 `2019-01-07T12%3A00%3A00%2B08%3A00`。开始时间不可设置为早于当前时间 60 天前的时间。
- `end_time`：String 型，选填。查询推流历史的结束时间，格式为 RFC3339 时间格式对应的 URL 编码，例如 `2019-01-07T12:00:00+08:00` 对应 `2019-01-07T12%3A00%3A00%2B08%3A00`。结束时间不可设置为晚于当前时间。
- `stream_name`：String 型，必填。要查询历史的直播流名称。

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功。响应包体中包含以下字段：

`publishHistory`：JSON Array 型，由 `PublishInfo` 组成的数组。推流历史信息列表，按照推流结束时间从晚到早排序：

- `PublishInfo`：JSON Object 型。包含一条推流记录的信息：
  - `name`：String 型，流的名称。
  - `startTime`：String 型，推流开始的时间。RFC3339 格式，例如 `"2019-01-07T12:00:00+08:00"`。
  - `endTime`：String 型，推流结束的时间。RFC3339 格式，例如 `"2019-01-07T12:00:00+08:00"`。
  - `duration`：Integer 型，推流持续的时长，单位为秒。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/live/reports/publish_history?start_time={start_time}&end_time={end_time}?stream_name={stream_name} HTTP/1.1
```

**响应行**

```http
HTTP/1.1 200 OK
```

**响应 body**

```json
{
    "publishHistory": [
        {
            "name": "{your_stream_name}",
            "startTime": "2021-08-25T12:19:23+08:00"
            "endTime": "2021-08-25T14:42:58+08:00"
            "duration": 8616
        },
        {
            "name": "{your_stream_name}",
            "startTime": "2021-08-25T10:44:40+08:00"
            "endTime": "2021-08-25T11:01:49+08:00"
            "duration": 1030
        }
    ]
}
```

<a name="http-code"></a>

## HTTP 状态码

| 状态码 | 可能的原因                                                   |
| :----- | :----------------------------------------------------------- |
| 200    | /                                                            |
| 400    | <li>参数非法，如 `appid` 或者 `entry_point` 为空。</li><li>查询时间格式不正确。</li> |
| 404    | 发布点不存在。                                               |
| 500    | 服务器内部错误。                                             |
