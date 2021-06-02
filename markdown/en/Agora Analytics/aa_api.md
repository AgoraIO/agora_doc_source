---
title: Agora Analytics RESTful API (Beta)
platform: All Platforms
updatedAt: 2021-03-11 08:31:17
---
Agora Analytics provides RESTful APIs for you to retrieve the statistics of your calls and use them in your own application.

Before moving on to the RESTful APIs, check out Agora Analytics at [Agora Console](https://console.agora.io) to get a visual understanding of the quality and usage metrics. See [Agora Analytics](./aa_guide) for details.

You can use the Agora Analytics RESTful APIs to request the following data.

- [Call Search](#search)
  - A list of calls with basic information.
  - Detailed quality metrics of a call.
- [Data Insight](#insight)
  - Usage statistics within a specified time frame.
- [Realtime](#live)
  - Statistics of specified metrics updated per minute.
  - Detailed diagnostic data.

> Agora Analytics RESTful API is in the Beta release. Contact support@agora.io to enable this service.

## Authentication

Before using the Agora RESTful API, you need to pass the [basic HTTP authentication](https://docs.agora.io/en/faq/restful_authentication).

## Data format

All requests are sent to the host: api.agora.io.

- Request: The request uses query string parameters in the URL.
- Response: The response content is in JSON format. 

## <a name="search"></a>Call Search

Using Call Search APIs, you can search the calls with quality issues and obtain the detailed quality metrics.

### API limitations

The Call Search RESTful APIs support searching calls in the past three days, and have the following limitations in terms of request times, data delay, and response content:

| Endpoint                     | Request frequency | Maximum data delay | Response content                  | Available calls     |
| ---------------------------- | ------------- | ------------------ | --------------------------------- | ------------------- |
| /beta/analytics/call/lists   | 3/s, 1000/day | 20 s               | A maximum of 10 calls.            | In the past 3 days. |
| /beta/analytics/call/details | 1/s, 1000/day | 150 s              | A maximum of three hours of data. | In the past 3 days. |

> Maximum data delay means the time between when a call begins and when the call's data is available.

### Get call list

This method gets a list of the calls that meet the search criteria.

- Method: GET
- Endpoint: /beta/analytics/call/lists

#### Parameters

The following query string parameters are required in the URL as search criteria.

| Parameter  | Type   | Description                                                  |
| ---------- | ------ | ------------------------------------------------------------ |
| `start_ts` | Number | The starting time of the search time frame. Unix format (time in seconds since 1970) in UTC. |
| `end_ts`   | Number | The ending time of the search time frame. Unix format (time in seconds since 1970) in UTC. |
| `cname`    | String | (Optional) The channel name.                                 |
| `appid`    | String | [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id) of your project. |

#### An HTTP request example

```http
GET /beta/analytics/call/lists?start_ts=1550024508&end_ts=1550025508&appid=xxxxxxxxxxxxxxxxxxxx HTTP/1.1
Host: api.agora.io
Accept: application/json
Authorization: Basic ZGJhZDMyNmFkMzQ0NDk2NGEzYzAwNjZiZmYwNTZmNjo2ZjIyMmZhMTkzNWE0MWQzYTczNzg2ODdiMmNiYjRh
```

#### A response example

```json
{
"code": 200,
"message": "",
"has_more": false,
"call_lists": 
[
  {
  "call_id": "cxxxxxxxxxxxxxxxxxxxx",
  "cname":   "cname1",
  "created_ts": 1547448383,
  "destroyed_ts": 1547448483,
  "finished": true
  }
]
}
```

Where:

- `code`: Number. The [status code](#code).
- `message`: String. The error message.
- `has_more`: Boolean. Whether or not there are more calls in `call_lists`. If the call you need is not in `call_lists`, try narrowing the search and resend the request.
- `call_lists`: JSONArray. The returned calls. Agora Analytics returns the most recent 10 calls in descending order of the starting time. Each call has the following properties:
  - `call_id`: String. The unique ID of the call.
  - `cname`: String. The channel name.
  - `created_ts`: Number. The starting time of the call. Unix format in UTC.
  - `destroyed_ts`: Number. The ending time of the call. Unix format in UTC.
  - `finished`: Boolean. Whether the call finishes or is still ongoing.

### Get quality metrics

This method gets the detailed statistics of a call.

- Method: GET
- Endpoint: /beta/analytics/call/details

#### Parameters

This API requires the following parameters to specify the call.

| Parameter             | Type    | Description                                                  |
| --------------------- | ------- | ------------------------------------------------------------ |
| `start_ts`            | Number  | The starting time of the call. Unix format (seconds since 1970) in UTC. |
| `end_ts`              | Number  | The ending time of the call. Unix format (seconds since 1970) in UTC. |
| `appid`               | String  | [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id) of your project. |
| `call_id`             | String  | The unique ID of the call.                                   |
| `exclude_server_user` | Boolean | (Optional) Whether or not to exclude Linux users. `true` by default.    |
| `exclude_metrics_info` | Boolean | (Optional) Whether or not to exclude the metric details. <li>  `true`: Exclude the metric details. </li><li> `false`: (Default) Do not exclude the metric details.</li>  |

#### An HTTP request example

```http
GET /beta/analytics/call/details?start_ts=1548665345&end_ts=1548670821&appid=axxxxxxxxxxxxxxxxxxxx&call_id=cxxxxxxxxxxxxxxxxxxxx HTTP/1.1
Host: api.agora.io
Accept: application/json
Authorization: Basic ZGJhZDMyNmFkMzQ0NDk2NGEzYzAwNjZiZmYwNTZmNjo2ZjIyMmZhMTkzNWE0MWQzYTczNzg2ODdiMmNiYjRh
```

#### A response example

```json
{
    "code": 200,
    "message": "",
    "call_id": "00057b6093a5d3e8b1fc67aa",
    "call_info": [
        {
            "sid": "EDB224CCF4FB4F99815C24302BDF3301",
            "cname": "15056678066620",
            "uid": 630985881,
            "network": "Wi-Fi",
            "platform": "Android",
            "speaker": true,
            "sdk_version": "2.2.0.07_14",
            "device_type": "Android (6.0)",
            "join_ts": 1548670251,
            "leave_ts": 1548670815,
            "finished": true
        },
		......
		],
    "metrics": [
        {
            "sid": "EDB224CCF4FB4F99815C24302BDF3301",
            "data": [
                {
                    "mid": 20003,
                    "kvs": [
                        [
                            1548670255,
                            215
                        ],
                        [
                            1548670257,
                            129
                        ],
                        [
                            1548670259,
                            121
                        ],
						......
					],
					"peer_uid": 0,
				},
				......
			]
		},
......
]
}
```

Where:

- `code`: Number. The [status code](#code).
- `message`: String. The error message.
- `call_id`: String. The unique ID of the call.
- `call_info`: JSONArray. Information of each user in the call. Agora Analytics returns a maximum of 10 users in descending order of the joining time. Each user has the following properties:
  - `sid`: String. The unique ID of the user session.
  - `cname`: String. The channel name.
  - `uid`: Number. The user ID.
  - `network`: String. The network type.
  - `platform`: String. The platform.
  - `speaker`: Boolean. Whether or not the user speaks in the call.
  - `sdk_version`: String. The SDK version.
  - `device_type`: String. The type of the device.
  - `join_ts`: Number. The time when the user joins the call. Unix format (time in seconds since 1970) in UTC.
  - `leave_ts`: Number. The time when the user leaves the call. Unix format (time in seconds since 1970) in UTC.
  - `finished`: Boolean. Whether or not the user is in the call.
  - `metrics`: JSONArray. Details of each user session (`sid`). Each user session includes the following properties:
    - `sid`: String. The unique ID of the user session.
    - `data`: JSONArray. Details of each metric.
    - `mid`: Number. The ID of the metric. See [Metrics ID](#mid) for details.
    - `peer_uid`: Number. The user ID of the remote user. 0 for the local user.
    - `kvs`: Array. Pairs of the timestamp and the corresponding metric value.

## <a name="insight"></a>Data Insight

You can use the Data Insight API to get the usage statistics within a specified time frame.

### API limitations

The Data Insight RESTful API has the following limitations:

| Endpoint                    | Request frequency | Available calls    |
| :-------------------------- | :------------ | :----------------- |
| /beta/insight/usage/by_time | 1/min, 10/day | In the past 7 days |

<div class="alert note"><b>Data Insight</b> finishes calculating data for the previous day, closing at 08:00 UTC. You may find that there is no data available prior to this time. To view real-time data, use <a href="#live">Realtime</a> RESTful APIs.</div>

### Get number of channels & users

This method gets the number of channels, users, and session counts within a certain time frame.

- Method: GET
- Endpoint: /beta/insight/usage/by_time

#### Parameters

The URL requires the following query string parameters:

| Parameter  | Type   | Description                                                  |
| :--------- | :----- | :----------------------------------------------------------- |
| `start_ts` | Number | The starting time of the search time frame. Unix format (time in seconds since 1970) in UTC. |
| `end_ts`   | Number | The starting time of the search time frame. Unix format (time in seconds since 1970) in UTC. |
| `appid`    | String | [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id) of your project. |
| `metric`   | String | The metric(s) you want to query.<li>`userCount`: Total number of unique UIDs. If two channels have a same UID, Agora Analytics counts it as two users.</li><li>`sessionCount`: It counts each time a user joins a channel.</li><li>`channelCount`: Total number of channels. A channel begins when the first user joins and ends when the last user leaves.</li>To query multiple metrics, add a comma between metrics, such as `userCount,sessionCount`. |

<div class="alert note">Data Insight uses one day as the time unit for data calculation. Ensure that the specified time frame is at least one day, otherwise you get an empty response.</div>

#### An HTTP request example

```http
GET /beta/insight/usage/by_time?start_ts=1570579200&end_ts=1570838400&appid=axxxxxxxxxxxxxxxxxxxx&metric=userCount HTTP/1.1
Host: api.agora.io
Accept: application/json
Authorization: Basic ZGJhZDMyNmFkMzQ0NDk2NGEzYzAwNjZiZmYwNTZmNjo2ZjIyMmZhMTkzNWE0MWQzYTczNzg2ODdiMmNiYjRh
```

#### A response example

```json
{
    "code": 200,
    "message": "success",
    "data": [
        {
            "userCount": 42,
            "ts": 1570752000
        },
        ......
    ]
}
```

- `code`: Number. The [status code](#code).
- `message`: String. The error message.
- `data`: JSONArray. An array of JSON objects. Each JSON object contains a Unix timestamp representing the date (00:00 UTC) and the statistics of the specified metrics for that day. 
  - `ts`: Number. Unix timestamp (sec).
  - `userCount`: Number. Number of users.

## <a name="live"></a>Realtime APIs

Using Realtime APIs, you can obtain the statistics of a given metric within a certain period of time, along with detailed diagnostic data.

### API limitations

The Realtime RESTful APIs have the following limitations:

| Endpoint                      | Request times | Maximum data delay | Response content                    | Available calls     |
| :---------------------------- | :------------ | :----------------- | :---------------------------------- | :------------------ |
| /beta/live/scale/by_time      | 1/s, 1000/day | 60 s ~ 120 s       | -                                   | In the past 1 hour. |
| /beta/live/experience/by_time | 1/s, 1000/day | 60 s ~ 120 s       | -                                   | In the past 1 hour. |
| /beta/live/net/by_time        | 1/s, 1000/day | 60 s ~ 120 s       | -                                   | In the past 1 hour. |
| /beta/live/diagnosis          | 1/s, 1000/day | 60 s ~ 120 s       | A maximum of 10 diagnostic messages | In the past 1 hour. |

> Maximum data delay means the time between when a call begins and when the call's data is available.

### Live scale API

This method gets the per-minute statistics of scale-related metrics within a certain time frame.

- Method: GET
- Endpoint: /beta/live/scale/by_time

#### Parameters

The URL requires the following query string parameters:

| Parameter  | Type   | Description                                                  |
| :--------- | :----- | :----------------------------------------------------------- |
| `start_ts` | Number | The starting time of the search time frame. Unix format (time in seconds since 1970) in UTC. |
| `end_ts`   | Number | The ending time of the search time frame. Unix format (time in seconds since 1970) in UTC. |
| `appid`    | String | [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id) of your project. |
| `metric`   | String | The metric(s) you want to query. To query multiple metrics, add a comma between metrics, such as `pcu,pcc`. See the following table for details. |

#### Metrics

| Metric             | Metric ID | Description                                                  |
| :----------------- | :-------- | :----------------------------------------------------------- |
| Number of users    | `pcu`     | Total number of unique UIDs. <div class="note">If two channels have a same UID, Agora Analytics counts it as two users.</div> |
| Number of channels | `pcc`     | Total number of channels. A channel begins when the first user joins the channel and ends when the last user leaves that channel. |

#### An HTTP request example

```http
GET /beta/live/scale/by_time?start_ts=1548665345&end_ts=1548670821&appid=axxxxxxxxxxxxxxxxxxxx&metric=pcu,pcc HTTP/1.1
Host: api.agora.io
Accept: application/json
Authorization: Basic ZGJhZDMyNmFkMzQ0NDk2NGEzYzAwNjZiZmYwNTZmNjo2ZjIyMmZhMTkzNWE0MWQzYTczNzg2ODdiMmNiYjRh
```

#### A response example

```json
{
    "code": 200,
    "message": "success",
    "data": [
        {
            "pcc": 42,
            "pcu": 102,
            "ts": 1548665578
        },
        ......
    ]
}
```

- `code`: Number. The [status code](https://docs-preview.agoralab.co/en/Agora%20Platform/aa_api?platform=All%20Platforms#code).
- `message`: String. The error message.
- `data`: JSONArray. The returned per-minute statistics of the specified metric. 
  - `ts`: Number. Unix timestamp (sec).
  - `pcu`: Number. Number of users.
  - `pcc`: Number. Number of channels.

### Live experience API

This method gets the per-minute statistics of experience-related metrics within a certain time frame.

- Method: GET
- Endpoint: /beta/live/experience/by_time

#### Parameters

The URL requires the following query string parameters:

| Parameter  | Type   | Description                                                  |
| :--------- | :----- | :----------------------------------------------------------- |
| `start_ts` | Number | The starting time of the search time frame. Unix format (time in seconds since 1970) in UTC. |
| `end_ts`   | Number | The ending time of the search time frame. Unix format (time in seconds since 1970) in UTC. |
| `appid`    | String | [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id) of your project. |
| `metric`   | String | The metric(s) you want to query. To query multiple metrics, add a comma between metrics. See the following table for details. |

#### Metrics

| Metric                     | Metric ID              | Description                                                  |
| :------------------------- | :--------------------- | :----------------------------------------------------------- |
| Join-channel success rate  | `joinSuccessRate`      | Number of users joined / Number of users trying to join.     |
| Join success in 5 sec rate | `joinSuccess5SecsRate` | Number of users who have joined a channel successfully within 5 seconds / Number of users who have tried to join. |
| Video freeze rate          | `videoFreezeRate`      | Total video freeze time / Total video playback duration. Video freeze time counts all the video freezes at least 600 ms in length. |
| Audio freeze rate          | `audioFreezeRate`      | Total audio freeze time / Total audio playback duration. Audio freeze time counts all the audio freezes at least 200 ms in length. |

#### An HTTP request example

```http
GET /beta/live/experience/by_time?start_ts=1548665345&end_ts=1548670821&appid=axxxxxxxxxxxxxxxxxxxx&metric=joinSuccessRate HTTP/1.1
Host: api.agora.io
Accept: application/json
Authorization: Basic ZGJhZDMyNmFkMzQ0NDk2NGEzYzAwNjZiZmYwNTZmNjo2ZjIyMmZhMTkzNWE0MWQzYTczNzg2ODdiMmNiYjRh
```

#### A response example

```json
{
    "code": 200,
    "message": "success",
    "data": [
        {
            "joinSuccessRate": 42,
            "ts": 1548666023
        },
        ......
    ]
}
```

- `code`: Number. The [status code](https://docs-preview.agoralab.co/en/Agora%20Platform/aa_api?platform=All%20Platforms#code).
- `message`: String. The error message. See the following table for details.
- `data`: JSONArray. The returned per-minute statistics of the specified metric. 
  - `ts`: Number. Unix timestamp (sec).
  - `joinSuccessRate`: Number. Join-channel success rate (%).

### Live network API

This method gets the per-minute statistics of network-related metrics within a certain time frame.

- Method: GET
- Endpoint: /beta/live/net/by_time

#### Parameters

The URL requires the following query string parameters:

| Parameter  | Type   | Description                                                  |
| :--------- | :----- | :----------------------------------------------------------- |
| `start_ts` | Number | The starting time of the search time frame. Unix format (time in seconds since 1970) in UTC. |
| `end_ts`   | Number | The ending time of the search time frame. Unix format (time in seconds since 1970) in UTC. |
| `appid`    | String | [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id) of your project. |
| `metric`   | String | The metric(s) you want to query. To query multiple metrics, add a comma metrics. See the following table for details. |

#### Metrics

| Metric                                          | Metric ID                         | Description                                                  |
| :---------------------------------------------- | :-------------------------------- | :----------------------------------------------------------- |
| Upstream high-quality video transmission rate   | `videoUpstreamExcellentTransRate` | The high-quality video transmission rate from the sender to the Agora SD-RTN. High-quality video transmission rate means the percentage of video transmission with a ≤ 5% packet loss rate. |
| Upstream high-quality audio transmission rate   | `audioUpstreamExcellentTransRate` | The high-quality audio transmission rate from the sender to the Agora SD-RTN. High-quality audio transmission rate means the percentage of audio transmission with a ≤ 5% packet loss rate. |
| End-to-end high-quality video transmission rate | `videoEnd2EndExcellentTransRate`  | The high-quality video transmission rate from the sender to the receiver. |
| End-to-end high-quality audio transmission rate | `audioEnd2EndExcellentTransRate`  | The high-quality audio transmission rate from the sender to the receiver. |

#### An HTTP request example

```http
GET /beta/live/net/by_time?start_ts=1548665345&end_ts=1548670821&appid=axxxxxxxxxxxxxxxxxxxx&metric=videoUpstreamExcellentTransRate HTTP/1.1
Host: api.agora.io
Accept: application/json
Authorization: Basic ZGJhZDMyNmFkMzQ0NDk2NGEzYzAwNjZiZmYwNTZmNjo2ZjIyMmZhMTkzNWE0MWQzYTczNzg2ODdiMmNiYjRh
```

#### A response example

```json
{
    "code": 200,
    "message": "success",
    "data": [
        {
            "videoUpstreamExcellentTransRate": 42,
            "ts": 1548667235
        },
        ......
    ]
}
```

- `code`: Number. The [status code](https://docs-preview.agoralab.co/en/Agora%20Platform/aa_api?platform=All%20Platforms#code).
- `message`: String. The error message.
- `data`: Array. The returned per-minute statistics of the specified metric. 
  - `ts`: Number. Unix timestamp (sec).
  - `videoUpstreamExcellentTransRate`: Number. Upstream high-quality video transmission rate (%).

### Diagnostics API

This method gets the diagnostic data and the factors that cause the abnormalities within a certain time frame.

- Method: GET
- Endpoint: /beta/live/diagnosis

#### Parameters

The URL requires the following query string parameters:

| Parameter  | Type   | Description                                                  |
| :--------- | :----- | :----------------------------------------------------------- |
| `start_ts` | Number | The starting time of the search time frame. Unix format (time in seconds since 1970) in UTC. |
| `end_ts`   | Number | The ending time of the search time frame. Unix format (time in seconds since 1970) in UTC. |
| `appid`    | String | [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id) of your project. |

#### An HTTP request example

```http
GET /beta/live/diagnosis?start_ts=1548665345&end_ts=1548670821&appid=axxxxxxxxxxxxxxxxxxxx HTTP/1.1
Host: api.agora.io
Accept: application/json
Authorization: Basic ZGJhZDMyNmFkMzQ0NDk2NGEzYzAwNjZiZmYwNTZmNjo2ZjIyMmZhMTkzNWE0MWQzYTczNzg2ODdiMmNiYjRh
```

#### A response example

```json
{
    "code": 200,
    "message": "success",
    "data": [
        {
            "user": "83817682",
            "exp_id": 4,
            "cname": "C148474015",
            "cause_tags": [
                {
                    "factor_id": 18,
                    "host_user": "44361248"
                },
                {
                    "factor_id": 23,
                    "host_user": ""
                },
                {
                    "factor_id": 18,
                    "host_user": ""
                }
            ],
            "ts": 1548668575
        },
        ......
       ]
}
```

- `code`: Number. The [status code](https://docs-preview.agoralab.co/en/Agora%20Platform/aa_api?platform=All%20Platforms#code).
- `message`: String. The error message.
- `data`: JSONArray. The returned per-minute diagnostic data. 
  - `ts`: Number. Unix timestamp (sec).
  - `user`: String. The UID encountering an abnormality.
  - `exp_id`: Number. Experience ID, describing the type of abnormality. See [Experience ID](#exp_id) for details.
  - `cname`: String. Name of the channel where the abnormality occurs.
  - `cause_tags`: JSONArray. The factor(s) causing the abnormality and the related UIDs. `cause_tags` contains a maximum of three tags.
    - `factor_id`: Number. Factor ID, which represents the cause of the abnormality. See [Factor ID](#factor_id) for details.
    - `host_user`: String. 
      - If the factor relates to a remote user, `host_user` is the UID of the remote user. 
      - If the factor relates to the local user, `host_user` is an empty string "".

## References

### <a name="code"></a>Status codes

| Code | Description                                                |
| ---- | ---------------------------------------------------------- |
| 200  | The request handle is successful.                          |
| 400  | The input is in the wrong format.                          |
| 401  | Unauthorized.                                              |
| 403  | Wrong authorization information. The request is forbidden. |
| 404  | Wrong API invoked.                                         |
| 500  | Internal error of the Agora RESTful API service.           |

### <a name="mid"></a>Metrics ID

| `mid` | Name                                                         |
| ----- | ------------------------------------------------------------ |
| 20001 | App CPU usage.                                               |
| 20002 | System CPU usage.                                            |
| 20003 | The upstream bitrate of the sent audio (Kbps).               |
| 20004 | The downstream bitrate of the received audio (Kbps).         |
| 20005 | The freeze time in rendering the audio (ms).                 |
| 20006 | The upstream bitrate of the sent video (Kbps).               |
| 20007 | The capturing frame rate of the video (fps).                 |
| 20008 | The frame rate of the sent video (fps).                      |
| 20009 | The downstream bitrate of the received video (Kbps).         |
| 20010 | The frame rate of the received video (fps).                  |
| 20011 | The freeze time in rendering the video (ms).                 |
| 20013 | Quality of Picture (QP) of the video. The lower the value, the higher the video quality. |
| 20015 | The upstream packet loss rate of the sent audio.             |
| 20016 | The end-to-end packet loss rate of the sent audio.           |
| 20017 | The upstream packet loss rate of the sent video.             |
| 20018 | The end-to-end packet loss rate of the sent video.           |
| 20019 | The width of the video.                                      |
| 20020 | The height of the video.                                     |

### <a name="exp_id"></a>Experience ID

| `exp_id` | Description        |
| :------- | :----------------- |
| 4        | Video freeze       |
| 5        | Audio freeze       |
| 6        | Join-channel delay |

### <a name="factor_id"></a>Factor ID

| `factor_id` | Description                                                  |
| :---------- | :----------------------------------------------------------- |
| 1       | Two same UIDs interfere with each other.                     |
| 2       | The user is banned by the administrator.                     |
| 3       | Connection failure                                           |
| 8       | Downstream network latency in video transmission             |
| 9       | Downstream network latency in audio transmission             |
| 10      | High CPU usage                                               |
| 11      | Device is busy.                                              |
| 12      | The user stops sending audio streams.                        |
| 13      | The user stops sending video streams.                        |
| 14      | The user disables the audio module.                          |
| 15      | The user disables the video module.                          |
| 16      | The remote user stops receiving the audio stream of the local user. |
| 17      | The remote user stops receiving the video stream of the local user. |
| 21      | Upstream packet loss in video transmission                   |
| 22      | Upstream packet loss in audio transmission                   |
| 23      | Downstream packet loss in video transmission                 |
| 24      | Downstream packet loss in audio transmission                 |
| 25      | Electron integration                                         |
| 29      | Weak Wi-Fi signal (including hotspots)                       |
| 30      | The user is banned from the channel.                         |
| 31      | Join-channel failure because of an invalid APP ID.           |
| 32      | Join-channel failure because of an invalid channel name.     |
| 33      | Join-channel failure because of an invalid token.            |
| 34      | Join-channel failure because of an expired token.            |
| 35      | Join-channel fails because the user is intercepted.          |
| 36      | Join-channel timeout                                         |
| 37      | Network reconnection triggered by network disconnection      |
| 38      | Network reconnection triggered by proxy server setup         |
| 39      | Network reconnection triggered by token renewal              |
| 40      | Network reconnection triggered by user IP address change     |
| 41      | Network reconnection triggered by network connection timeout |
| 42      | Upstream network latency in video transmission               |
| 43      | Upstream network latency in audio transmission               |
| 44      | Upstream network jitter in video transmission.               |
| 45      | Upstream network jitter in audio transmission.               |
| 46      | Downstream network jitter in video transmission.             |
| 47      | Downstream network jitter in audio transmission.             |