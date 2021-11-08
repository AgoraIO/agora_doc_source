## Ban streams

Ban a specified stream.

### HTTP request

```http
PATCH https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/admin/banned_streams/{stream_name}
```

#### Path parameter

| Parameter | Type | Description |
|:------|:------|:------|
| `appid` | String | Required. The App ID corresponding to the entry point. |
| `entry_point` | String | Required. The entry point name. |
| `stream_name` | String | Required. The name of the stream to be banned. |


#### Request body

The request body is in the JSON Object type, and contains the following fields:

- `resumeTime`: String type, optional. The resume time of the stream, in the RFC3339 format, for example: `2018-1129T19:00:00+08:00`. The default resume time is 7 days after the ban.

### HTTP response

If the returned HTTP status code is 200, the request is successful.

If the returned HTTP status code is not 200, the request fails. You can refer to the [HTTP status code](#http-code) for possible reasons.

### Example

**Request line**

```http
PATCH https://api.agora.io/v1/projects/{your_appid}/fls/entry_points/live/admin/banned_streams/{your_stream_name} HTTP/1.1
```

**Request body**

```json
{
    "resumeTime": "2021-11-29T19:00:00+08:00"
}
```

**Response line**

```http
HTTP/1.1 200 OK
```

## Unban streams

Unban a specified stream.

### HTTP request

```http
DELETE https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/admin/banned_streams/{stream_name}
```

#### Path parameter

| Parameter | Type | Description |
|:------|:------|:------|
| `appid` | String | Required. The App ID corresponding to the entry point. |
| `entry_point` | String | Required. The entry point name. |
| `stream_name` | String | Required. The name of the stream being unbanned.  |

### HTTP response

If the returned HTTP status code is 200, the request is successful.

If the returned HTTP status code is not 200, the request fails. You can refer to the [HTTP status code](#http-code) for possible reasons.

### Example

**Request line**

```http
DELETE https://api.agora.io/v1/projects/{your_appid}/fls/entry_points/live/admin/banned_streams/{your_stream_name} HTTP/1.1
```

**Response line**

```http
HTTP/1.1 200 OK
```

## Get banned stream lists

Get the list of all banned streams under the specified entry point.

### HTTP request

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/admin/banned_streams
```

#### Path parameter

| Parameter | Type | Description |
|:------|:------|:------|
| `appid` | String | Required. The App ID corresponding to the entry point. |
| `entry_point` | String | Required. The entry point name. |

### HTTP response

If the returned HTTP status code is 200, the request is successful. The response body contains the following fields:

`bannedStreamList`: JSON Array type, the list of the banned streams. One stream corresponds to a JSON Object, and contains the following fields:

| Field | Type | Description |
|:------|:------|:------|
| `name` | String | The stream name. |
| `resumeTime` | String | The resume time of the stream. |

If the returned HTTP status code is not 200, the request fails. You can refer to the [HTTP status code](#http-code) for possible reasons.

### Example

**Request line**

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/live/admin/banned_streams HTTP/1.1
```

**Response line**

```http
HTTP/1.1 200 OK
```

**Request body**

```json
{
    "bannedStreamList": [
        {
            "name": "{your_stream_namename1}",
            "resumeTime": "2021-11-29T19:00:00+08:00"
        },
        {
            "name": "{your_stream_name2}",
            "resumeTime": "2021-11-28T19:00:00+08:00"
        }
    ]
}
```

## Query online stream lists

Query the online stream list under the specified entry point.

### HTTP request

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/reports/online_streams
```

#### Path parameter

| Parameter | Type | Description |
|:------|:------|:------|
| `appid` | String | Required. The App ID corresponding to the entry point. |
| `entry_point` | String | Required. The entry point name. |

### HTTP response

If the returned HTTP status code is 200, the request is successful. The response body contains the following fields:

`streamList`: JSON Array type, the online stream list. One stream corresponds to a JSON Object, and contains the following fields:

| Field | Type | Description |
|:------|:------|:------|
| `name` | String | The stream name. |
| `startTime` | String | The stream pushing time. In the RFC3339 format, for example `"2019-01-07T12:00:00Z"`. |

If the returned HTTP status code is not 200, the request fails. You can refer to the [HTTP status code](#http-code) for possible reasons.

### Example

**Request line**

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/live/reports/online_streams HTTP/1.1
```

**Response line**

```http
HTTP/1.1 200 OK
```

**Request body**

```json
{
    "streamList": [
        {
            "name": "{your_stream_name_1}",
            "startTime": "2021-11-29T19:00:00+08:00"
        },
        {
            "name": "{your_stream_name2}",
            "startTime": "2021-11-29T19:00:00+08:00"
        },
    ]
}
```

## Get the information of a online stream

Get the information of a specified online stream.

### HTTP request

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/reports/online_streams/{stream_name}
```

#### Path parameter

| Parameter | Type | Description |
|:------|:------|:------|
| `appid` | String | Required. The App ID corresponding to the entry point. |
| `entry_point` | String | Required. The entry point name. |
| `stream_name` | String | Required. The name of the stream to be queried. |

### HTTP response

If the returned HTTP status code is 200, the request is successful. The response body contains the following fields:

- `startTime`: String type. The start time of the stream pushing, in the RFC3339 format, for example `"2019-01-07T12:00:00Z"`.

If the returned HTTP status code is not 200, the request fails. You can refer to the [HTTP status code](#http-code) for possible reasons.

### Example

**Request line**

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/live/reports/online_streams/{stream_name} HTTP/1.1
```

**Response line**

```http
HTTP/1.1 200 OK
```

**Request body**

```json
{
    "startTime": "2021-10-11T04:08:52Z"
}
```

## Get the stream pushing history

You can only query the pushing history of the finished streams under a specified entry point within a specified time range.

There is a delay of about two hours for the stream pushing history, and you can query a pushing history of 60 days.

### HTTP request

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/reports/publish_history?start_time={start_time}&end_time={end_time}?stream_name={stream_name}
```

#### Path parameter

| Parameter | Type | Description |
|:------|:------|:------|
| `appid` | String | Required. The App ID corresponding to the entry point. |
| `entry_point` | String | Required. The entry point name. |

#### Query parameters

| Parameter | Type | Description |
|:------|:------|:------|
| `start_time` | String | Optional. Query the start time of the stream pushing history, in the URL code format corresponding to the RFC3339 format, for example, `2019-01-07T12%3A00%3A00%2B08%3A00` corresponds to `2019-01-07T12:00:00+08:00`. The start time cannot be set 60 days before the current time. |
| `end_time` | String | Optional. Query the end time of the stream pushing history, in the URL code format corresponding to the RFC3339 format, for example,  `2019-01-07T12%3A00%3A00%2B08%3A00` corresponds to `2019-01-07T12:00:00+08:00`. The end time cannot be set later than the current time. |
| `stream_name` | String | Required. The name of the stream being queried. |


### HTTP response

If the returned HTTP status code is 200, the request is successful. The response body contains the following fields:

`publishHistory`: JSON Array type, the information list of the stream pushing history, from the latest to the oldest. One stream corresponds to a JSON Object, and contains the following fields:

| Field | Type | Description |
|:------|:------|:------|
| `name` | String | The stream name. |
| `startTime` | String | The start time of the stream pushing. In the RFC3339 format, for example `"2019-01-07T12:00:00+08:00"`. |
| `endTime` | String | The end time of the stream pushing. In the RFC3339 format, for example `"2019-01-07T12:00:00+08:00"`. |
| `duration` | Integer | The duration of the stream pushing, in seconds. |

If the returned HTTP status code is not 200, the request fails. You can refer to the [HTTP status code](#http-code) for possible reasons.

### Example

**Request line**

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/live/reports/publish_history?start_time={start_time}&end_time={end_time}?stream_name={stream_name} HTTP/1.1
```

**Response line**

```http
HTTP/1.1 200 OK
```

**Request body**

```json
{
    "publishHistory": [
        {
            "name": "{your_stream_name_1}",
            "startTime": "2021-08-25T12:19:23+08:00",
            "endTime": "2021-08-25T14:42:58+08:00",
            "duration": 8616
        },
        {
            "name": "{your_stream_name2}",
            "startTime": "2021-08-25T10:44:40+08:00",
            "endTime": "2021-08-25T11:01:49+08:00",
            "duration": 1030
        }
    ]
}
```

<a name="http-code"></a>

## HTTP status code

| Status code | Description |
| :----- | :----------------------------------------------------------- |
| 200 | The request succeeds. |
| 400 | <li>The parameter is invalid, for example the `appid` or the `entry_point` is empty.</li><li>The query time format is incorrect.</li> |
| 401 | Unauthorized (the customer ID and the customer secret do not match). |
| 404 | The server cannot find the resource according to the request, which means the requested entry point does not exist or the requested URI path is invalid. |
| 500 | An internal error occurs in the server, so the server is not able to complete the request. |
| 504 | An internal error occurs in the server. The gateway or the proxy server did not receive a timely request from the remote server. |

