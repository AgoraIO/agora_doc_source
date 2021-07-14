Agora Analytics provides RESTful APIs for you to retrieve the statistics of your calls and use them in your own application.

Before moving on to the RESTful APIs, check out Agora Analytics at [Agora Console](https://console.agora.io) to get a visual understanding of the quality and usage metrics. See [Agora Analytics](./aa_guide) for details.

You can use the Agora Analytics RESTful APIs to request the following data.

- [Data Insight](#datainsight)
  - Usage statistics within a specified time frame.
  - Quality statistics within a specified time frame.
- [Call Search](#callsearch)
  - A list of calls with basic information.
  - Detailed quality metrics of a call.

<div class="alert info">Agora Analytics RESTful API is in the Beta release. Purchase the <a href="https://console.agora.io/support/plan">support package</a > or contact <a href="mailto:support@agora.io">support@agora.io</a > to enable this function.</div>

## Authentication

~747f9590-91b4-11e9-8d5e-b591da73c18d~

## Data format

All requests are sent to the host: `api.agora.io`.

- Request: The request uses query string parameters in the URL.
- Response: The response content is in JSON format. 

## <a name="insight"></a>Data Insight

With the Data Insight RESTful APIs, you can query the usage and quality metrics within a specified time frame.

### API limitations

The Data Insight RESTful APIs have the following limitations in terms of request frequency, available data, specified time frame, data granularity, and data delay :

| Endpoint                      | Request frequency             | Available data     | Specified time frame | Data granularity | Data delay |
| :---------------------------- | :---------------------------- | :----------------- | -------------------- | ---------------- | ---------- |
| /beta/insight/usage/by_time   | No more than 1/min and 10/day | In the past 3 days | No more than 1 day   | Daily            | 24 hours   |
| /beta/insight/quality/by_time | No more than 1/min and 10/day | In the past 3 days | No more than 1 day   | Daily and hourly | 12 hours   |

<div class="alert note"><li>Request frequency is calculated using the server's UTC time.</li><li>Data delay refers to the lag between the time when a call begins and the time when the call data is available for query.</li></div>

### Query usage metrics

This method queries usage metrics such as the number of users and channels.

- Method: GET
- Endpoint: /beta/insight/usage/by_time

#### Request parameters

The following query string parameters are required in the URL:

| Parameter              | Type   | Description                                                  |
| :--------------------- | :----- | :----------------------------------------------------------- |
| `startTs`              | Number | The start point (Unix timestamp) of the time frame to query. |
| `endTs`                | Number | The end point (Unix timestamp) of the time frame to query.   |
| `appid`                | String | [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id) of your project. |
| `metric`               | String | The metrics you want to query. You can set it to:<li>`userCount`: Total number of users across channels. A user joining the same channel with different UIDs or joining different channels with the same UID is counted multiple times.</li><li>`sessionCount`: Total channel-joining counts. Each time a user joins a channel is counted.</li><li>`channelCount`: Total number of channels. A channel begins when the first user joins and ends when the last user leaves.</li><li>`peakCurrentChannels`: The maximum number of channels in use.</li><li>`peakCurrentUsers`: The maximum number of in-call users across channels.</li><li>`totalDuration`: The total duration of video and audio-only calls calculated by users</li><li>`totalVideoDuration`: The total duration of video calls calculated by users.</li><li>`totalAudioDuration`: The total duration of audio-only calls calculated by users</li> |
| `aggregateGranularity` | String | The level of time-related detail in the returned data. You can only set it to `1d`, which returns the values corresponding to 12:00 am (UTC) on each day within the specified time frame. |

#### HTTP Request example

The following example queries the total number of users across channels starting from 8:00 am on July 1st, 2021 to 8:00 am on July 3rd, 2021:

```http
GET /beta/insight/usage/by_time?startTs=1625097600&endTs=1625270400&appid=axxxxxxxxxxxxxxxxxxxx&metric=userCount&aggregateGranularity=1d HTTP/1.1
Host: api.agora.io
Accept: application/json
Authorization: Basic ZGJhZDMyNmFkxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxWQzYTczNzg2ODdiMmNiYjRh
```

#### Response example

The response for the previous HTTP request example should look like:

```json
{
    "code": 200,
    "message": "success",
    "data": [
       {
            "userCount": 42,
            "ts": 1625155200
       },
       {
            "userCount": 65,
            "ts": 1625241600
       },
   ]
}
```

The response contains the following fields:

- `code`: Number. The [status code](#code).

- `message`: String. The error message.

- `data`: JSONArray, an array of JSON objects. Each JSON object contains a Unix timestamp representing 12:00 am (UTC) on each day within the specified time frame and the corresponding value of the specified metrics. In the case of the previous request example, two JSON objects should be returned: one is for 12:00 am on July 2, 2021, and the other is for 12:00 am on July 3, 2021.
  - `ts`: Number. Unix timestamp.
  - `userCount`: Number. Total number of users across channels.

### Query quality metrics

This method queries quality metrics such as video freeze rate.

- Method: GET
- Endpoint: /beta/insight/quality/by_time

#### Request parameters

The following query string parameters are required in the URL:

| Parameter              | Type   | Description                                                  |
| :--------------------- | :----- | :----------------------------------------------------------- |
| `startTs`              | Number | The start point (Unix timestamp) of the time frame to query. |
| `endTs`                | Number | The end point (Unix timestamp) of the time frame to query.   |
| `appid`                | String | [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id) of your project. |
| `metric`               | String | The metrics you want to query. You can set it to:<li>`joinSuccessRate`: Channel-joining success rate, which equals Number of users who have joined ÷ Number of attempts to join.</li><li>`joinSuccessIn5sRate`: Channel-joining success rate within 5 seconds, which equals Number of users who have joined within 5 seconds ÷ Number of attempts to join.</li><li>`audioFreezeRate`: Total audio freeze time ÷ Total audio minutes calculated by streams. Only audio freezes longer than 200 milliseconds are counted.</li><li>`videoFreezeRate`: Total video freeze time ÷ Total video minutes calculated by streams. Only video freezes longer than 600 milliseconds are counted.</li><li>`networkDelay`: Total end-to-end network delay ÷ Total audio and video minutes calculated by streams. Only end-to-end network delays longer than 400 milliseconds are counted.</li> |
| `aggregateGranularity` | String | The level of time-related detail in the returned data. You can set it to: <li> `1d`, which returns the metrics corresponding to 12:00 am (UTC) on each day within the specified time frame.</li><li>`1h`, which returns the metrics corresponding to every hour within the specified time frame.</li> |
| `productType`          | String | The product for which you want to query the metrics. You can set it to: <li>`Native`: The Agora RTC SDK for Android, iOS, macOS, and Windows.</li><li>`WebRTC`: The Agora RTC SDK for Web.</li> |

#### HTTP Request example

The following example queries the daily network delay rate starting from 8:00 am on July 1st, 2021 to 8:00 am on July 3rd, 2021:

```http
GET /beta/insight/quality/by_time?startTs=1625097600&endTs=1625270400&appid=axxxxxxxxxxxxxxxxxxxx&metric=networkDelay&aggregateGranularity=1d&productType=Native HTTP/1.1
Host: api.agora.io
Accept: application/json
Authorization: Basic ZGJhZDMyNmFkxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxWQzYTczNzg2ODdiMmNiYjRh
```

#### Response example

The response for the previous HTTP request example should look like:

```json
{
    "code": 200,
    "message": "success",
    "data": [
       {
            "networkDelay": 0.064762,
            "ts": 1625155200
       },
       {
            "networkDelay": 0.046284,
            "ts": 1625241600
       },
   ]
}
```

The response contains the following fields:

- `code`: Number. The [status code](#code).
- `message`: String. The error message.
- `data`: JSONArray, an array of JSON objects. Each JSON object contains a Unix timestamp representing 12:00 am (UTC) on each day within the specified time frame and the corresponding value of the specified metrics. In the case of the previous request example, two JSON objects should be returned: one is for 12:00 am on July 2, 2021, and the other is for 12:00 am on July 3, 2021.
  - `ts`: Number. Unix timestamp (sec).
  - `networkDelay`: Number. Network delay rate.

## <a name="search"></a>Call Search

With the Call Search RESTful APIs, you can search for calls with quality issues and obtain detailed metrics about call quality.

### API limitations

The Call Search RESTful APIs have the following limitations in terms of request frequency, data delay, response content, and available calls:

| Endpoint                      | Request frequency | Maximum data delay | Response content              | Available calls     |
| ----------------------------- | ----------------- | ------------------ | ----------------------------- | ------------------- |
| /beta/analytics/call/lists    | 1/s, 1000/day     | 60 s               | A maximum of 8 hours of data. | In the past 3 days. |
| /beta/analytics/call/sessions | 1/s, 1000/day     | 300 s              | A maximum of 1 hour of data.  | In the past day.    |
| /beta/analytics/call/metrics  | 1/s, 1000/day     | 300 s              | A maximum of 1 hour of data.  | In the past day.    |

<div class="alert info"><li>Request frequency is calculated using the server's UTC time.</li>
<li>Maximum data delay means the time between when a call begins and when the call's data is available.</li></div>

### Get call list

This method gets a list of the calls that meet the search criteria.

- Method: GET
- Endpoint: /beta/analytics/call/lists

#### Request parameters

The following query string parameters are required in the URL as search criteria:

| Parameter  | Type   | Description                                                  |
| ---------- | ------ | ------------------------------------------------------------ |
| `start_ts` | Number | The starting time of the search time frame. Unix time (in seconds since 1 January 1970) in UTC. |
| `end_ts`   | Number | The ending time of the search time frame. Unix time (in seconds since 1 January 1970) in UTC. |
| `cname`    | String | (Optional) The channel name.                                 |
| `appid`    | String | [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id) of your project. |

#### An HTTP request example

```http
GET /beta/analytics/call/lists?start_ts=1550024508&end_ts=1550025508&appid=xxxxxxxxxxxxxxxxxxxx HTTP/1.1
Host: api.agora.io
Accept: application/json
Authorization: Basic ZGJhZDMyNmFkxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxWQzYTczNzg2ODdiMmNiYjRh
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
- `has_more`: Boolean. Whether there are calls not included in `call_lists`. `true` represents that some calls that meet the search criteria are not listed. If the call you need is not in `call_lists`, try narrowing the search and resend the request.
- `call_lists`: JSONArray. The returned calls. Agora Analytics returns the most recent 100 calls in descending order of the starting time. Each call has the following properties:
  - `call_id`: String. The unique ID of the call.
  - `cname`: String. The channel name.
  - `created_ts`: Number. The starting time of the call. Unix time (in seconds since 1 January 1970) in UTC.
  - `destroyed_ts`: Number. The ending time of the call. Unix time (in seconds since 1 January 1970) in UTC.
  - `finished`: Boolean. Whether the call has finished or is still ongoing.

### Get session details

This method gets the detailed call statistics of users by specifying the unique ID of the call.

- Method: GET
- Endpoint: /beta/analytics/call/sessions

#### Request parameters

The following query string parameters are required in the URL to specify the call ID and statistics:

| Parameter             | Type    | Description                                                  |
| --------------------- | ------- | ------------------------------------------------------------ |
| `start_ts`            | Number  | The starting time of the call. Unix time (in seconds since 1 January 1970) in UTC. |
| `end_ts`              | Number  | The ending time of the call. Unix time (in seconds since 1 January 1970) in UTC. |
| `call_id`             | String  | The unique ID of the call.                                   |
| `page_no`             | Number  | (Optional) The page number. The default is 1.                |
| `page_size`           | Number  | (Optional) The number of user sessions on each page. The default is a maximum of 20 user sessions on each page. |
| `uids`                | String  | (Optional) The list of user IDs seperated by commas (for example, `uids=10001,10002,10003`). You can specify a maximum of 10 user IDs. A user ID may occur twice in the list according to the actual scenario. Therefore, if you specify 10 user IDs in the request, 10 or more user IDs are returned. |
| `appid`               | String  | [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id) of your project. |
| `exclude_server_user` | Boolean | (Optional) Whether or not to exclude Linux users. `true` by default, which represents excluding Linux users. |

#### An HTTP request example

```http
GET /beta/analytics/call/sessions?start_ts=1548665345&end_ts=1548670821&appid=axxxxxxxxxxxxxxxxxxxx&call_id=cxxxxxxxxxxxxxxxxxxxx&page_no=1&page_size=20&uids=uxx1,uxx2 HTTP/1.1
Host: api.agora.io
Accept: application/json
Authorization: Basic ZGJhZDMyNmFkxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxWQzYTczNzg2ODdiMmNiYjRh
```

#### A response example

```json
{
   {
    "code": 200,
    "message": "",
      "total_size": 101,
    "page_no": 1,
    "page_size": 20,
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
        ]
}
```

Where:

- `code`: Number. The [status code](#code).
- `message`: String. The error message.
- `total_size`: Number. The total number of returned user sessions.
- `page_no`:  Number. The page number.
- `page_size`: Number. The number of user sessions on each page.
- `call_info`: JSONArray. Information of each user in the call. Agora Analytics returns a maximum of 20 users in descending order of the joining time per page. Each user has the following properties:
  - `sid`: String. The unique ID of the user session.
  - `cname`: String. The channel name.
  - `uid`: Number. The user ID.
  - `network`: String. The network type.
  - `platform`: String. The platform.
  - `speaker`: Boolean. Whether or not the user speaks in the call.
  - `sdk_version`: String. The SDK version.
  - `device_type`: String. The type of the device used by the user.
  - `join_ts`: Number. The time when the user joins the call. Unix time (in seconds since 1 January 1970) in UTC.
  - `leave_ts`: Number. The time when the user leaves the call. Unix time (in seconds since 1 January 1970) in UTC.
  - `finished`: Boolean. Whether the user is in the call or has left it.

### Get quality metrics

Gets the quality metrics of a specified call.

- Method: GET
- Endpoint: /beta/analytics/call/metrics

#### Request parameters

The following query string parameters are required in the URL to specify the call:

| Parameter  | Type   | Description                                                  |
| ---------- | ------ | ------------------------------------------------------------ |
| `start_ts` | Number | The starting time of the call. Unix time (in seconds since 1 January 1970) in UTC. |
| `end_ts`   | Number | The ending time of the call. Unix time (in seconds since 1 January 1970) in UTC. |
| `appid`    | String | [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id) of your project. |
| `call_id`  | String | The unique ID of the call.                                   |
| `sids`     | String | The list of user session IDs separated by commas, for example,  `sids=SXXXXXXXXXXXXXXXX1,SXXXXXXXXXXXXXXXX2`. You can specify a maximum of 20 user session IDs. |

#### An HTTP request example

```http
GET /beta/analytics/call/metrics?start_ts=1548665345&end_ts=1548670821&appid=axxxxxxxxxxxxxxxxxxxx&call_id=cxxxxxxxxxxxxxxxxxxxx&sids=sxxxxxxxxxxxxxxxx1,sxxxxxxxxxxxxxxxx2,sxxxxxxxxxxxxxxxx3 HTTP/1.1
Host: api.agora.io
Accept: application/json
Authorization: Basic ZGJhZDMyNmFkxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxWQzYTczNzg2ODdiMmNiYjRh
```

#### A response example

```json
{
    "code": 200,
    "message": "",
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

- `code`: Number. The [status code](#code).
- `message`: String. The error message.
- `metrics`: JSONArray. Detailed quality metrics of each user session (`sid`). Each user session includes the following properties:
    - `sid`: String. The unique ID of the user session.
    - `data`: Array. The quality metrics of the user session.
    - `mid`: Number. The ID of the metric. See [Metrics ID](#mid) for details.
    - `kvs`: Array. Pairs of the timestamp and the corresponding metric value.
    - `peer_uid`: Number. The user ID of the remote user. 0 represents that the returned metrics are the local user's.
## References

### <a name="code"></a>Status codes
The following status codes apply to all Agora Analytics RESTful APIs:

| Code | Description                                                |
| ---- | ---------------------------------------------------------- |
| 200  | The request is successful.                                 |
| 400  | Invalid parameters.                                        |
| 401  | Unauthorized.                                              |
| 403  | Wrong authorization information. The request is forbidden. |
| 404  | Wrong API invoked.                                         |
| 500  | Unknown error.                                             |

The following status code applies to <a href="#search">Call Search</a> only:
- `300`: API limitations are exceeded. This status code might be returned together with the following error messages:
   - `qps limit error`: The limitation on requests per second is exceeded.
   - `qpd limit error`: The limitation on requests per day is exceeded.
   - `query latency limit error`: The limitation on data delay is exceeded.
   - `query time range limit error`: The limitation on available calls is exceeded.
   - `query time length limit error`: The limitation on response content is exceeded.
   - `no auth`: You have no access to this service.

### <a name="mid"></a>Metrics ID

| `mid` | Name                                                         |
| ----- | ------------------------------------------------------------ |
| 20001 | App CPU usage.                                               |
| 20002 | System CPU usage.                                            |
| 20003 | The upstream bitrate (Kbps) of the audio.                    |
| 20004 | The downstream bitrate (Kbps) of the audio.                  |
| 20005 | The freeze time (ms) in rendering the audio.                 |
| 20006 | The upstream bitrate (Kbps) of the low-quality video stream. |
| 20007 | The capturing frame rate (fps) of the video.                 |
| 20008 | The upstream frame rate (fps) of the high-quality video stream. |
| 20009 | The downstream bitrate (Kbps) of the video.                  |
| 20010 | The downstream frame rate (fps) of the video.                |
| 20011 | The freeze time (ms) in rendering the video.                 |
| 20013 | Quality of Picture (QP) of the video. The lower the value, the higher the video quality. |
| 20015 | The upstream packet loss rate of the audio.                  |
| 20016 | The end-to-end packet loss rate of the audio.                |
| 20017 | The upstream packet loss rate of the video.                  |
| 20018 | The end-to-end packet loss rate of the video.                |
| 20019 | The width of the received video.                             |
| 20020 | The height of the received video.                            |
| 20021 | The task scheduling delay (ms).                              |
| 20022 | The round-trip time delay (ms) from the client to the local router. |
| 20023 | The upstream frame rate (fps) of the low-quality video stream. |
| 20024 | The upstream bitrate (Kbps) of the high-quality video stream. |
| 20025 | The sampling volume of the sent audio.                       |
| 20026 | The playback volume of the received audio.                   |
| 20027 | The width of the sent video.                                 |
| 20028 | The height of the sent video.                                |



### <a name="exp_id"></a>Experience ID

| `exp_id` | Description        |
| :------- | :----------------- |
| 4        | Video freeze       |
| 5        | Audio freeze       |
| 6        | Join-channel delay |

### <a name="factor_id"></a>Factor ID

| `factor_id` | Description                                                  |
| :---------- | :----------------------------------------------------------- |
| 1           | Two same UIDs interfere with each other.                     |
| 2           | The user is banned by the administrator.                     |
| 3           | Connection failure                                           |
| 8           | Downstream network latency in video transmission             |
| 9           | Downstream network latency in audio transmission             |
| 10          | High CPU usage                                               |
| 11          | Device is busy.                                              |
| 12          | The user stops sending audio streams.                        |
| 13          | The user stops sending video streams.                        |
| 14          | The user disables the audio module.                          |
| 15          | The user disables the video module.                          |
| 16          | The remote user stops receiving the audio stream of the local user. |
| 17          | The remote user stops receiving the video stream of the local user. |
| 21          | Upstream packet loss in video transmission                   |
| 22          | Upstream packet loss in audio transmission                   |
| 23          | Downstream packet loss in video transmission                 |
| 24          | Downstream packet loss in audio transmission                 |
| 25          | Electron integration                                         |
| 29          | Weak Wi-Fi signal (including hotspots)                       |
| 30          | The user is banned from the channel.                         |
| 31          | Join-channel failure because of an invalid APP ID.           |
| 32          | Join-channel failure because of an invalid channel name.     |
| 33          | Join-channel failure because of an invalid token.            |
| 34          | Join-channel failure because of an expired token.            |
| 35          | Join-channel fails because the user is intercepted.          |
| 36          | Join-channel timeout                                         |
| 37          | Network reconnection triggered by network disconnection      |
| 38          | Network reconnection triggered by proxy server setup         |
| 39          | Network reconnection triggered by token renewal              |
| 40          | Network reconnection triggered by user IP address change     |
| 41          | Network reconnection triggered by network connection timeout |
| 42          | Upstream network latency in video transmission               |
| 43          | Upstream network latency in audio transmission               |
| 44          | Upstream network jitter in video transmission.               |
| 45          | Upstream network jitter in audio transmission.               |
| 46          | Downstream network jitter in video transmission.             |
| 47          | Downstream network jitter in audio transmission.             |