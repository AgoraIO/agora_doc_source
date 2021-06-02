---
title: User and Channel Events RESTful API
platform: All Platforms
updatedAt: 2021-02-23 09:31:02
---
You can now get both user and channel events with the Agora RTM RESTful APIs. 

<div class="alert note">qps of the RESTful APIs: 100 (for each vendor).</div>


## <a name="auth"></a>Authentication

Agora RTM RESTful API supports HTTPS only. You can use either of the following methods to authenticate your HTTP request: 

- [Basic authentication](#basicauth)
- [Token authentication](#tokenauth)

### <a name="basicauth"></a>Basic authentication

You need to pass the basic HTTP authentication and put `api_key:api_secret` in the `Authorization` field of the HTTP header. For more information on how to generate the `Authorization` filed, see [RESTful API authentication](https://docs.agora.io/en/faq/restful_authentication).

### <a name="tokenauth"></a>Token authentication

If you have already generated an RTM Token on your server, you can use token authentication. You need to put the following information to the `x-agora-token` field and the `x-agora-uid` field when sending your HTTP request: 

- The RTM Token generated at your server. 
- The uid you use to generate the RTM Token. 

For more information on how to generate the `x-agora-token` field and the `x-agora-uid` field, see [RESTful API authentication](https://docs.agora.io/en/faq/restful_authentication).

## Data format

All requests are sent to the host: `api.agora.io`.

- Base URL: 

```
https://api.agora.io/dev/v2/project/<appid>/
```

- Content-type: `application/json;charset=utf-8`
- Authorization: See [Authentication](#auth). 
- Request: See the examples in the following APIs. 
- Response: The response content is in JSON format. 

> All the request URLs and request bodies are case sensitive. 


## <a name="get"></a>Gets user events

This method gets the user events from the address specified by the Agora RTM server. 

- Method: GET
- Endpoint: ~/rtm/vendor/user_events
- Request URL：

```
https://api.agora.io/dev/v2/project/<appid>/rtm/vendor/user_events
```

### A response example of `get`

```json
{
    "result": "success",
    "request_id" : "10116762670167749259",
    "events" : [event]
}
```

| Parameter    | Type   | Description                    |
| :----------- | :----- | :----------------------------- |
| `result`     | string | The result of this request.    |
| `request_id` | string | The unique ID of this request. |
| `events`     | JSON   | A login or logout event.       |

### An example of `event`

```json
{
    "user_id": "rtmtest_RTM_4852_4857w7%",
    "type" : "Login",
    "ts" : 1578027420761
}
```

| Parameter     | Type   | Description   |
| :------- | :----- | :-------------------- |
| `user_id` | string | The user ID involved.   |
| `type`   | string | Event type: <li><code>Login</code>: A user has logged in the Agora RTM system;</li><li><code>Logout</code>: A user has logged out of the Agora RTM ststem.</li> |
| `ts`  | int    | Timestamp in milliseconds.      |



> - The RTM backend stores a maximum of 2,000 events. 
> - The backend returns a maximum of 1,000 events each time. 
> - We do not guarantee the time sequence of events across geographies, because we store events by regions. 
> - If you have pulled events from one region, you may get the same events when you pull from a different region. This is because we only synchronize events within a region and do not synchronize events across regions. 

### Error code

| Error code | Description                                                  |
| :--------- | :----------------------------------------------------------- |
| 408        | The server request times out, or the server fails to respond. Try again later. |

## Gets channel events

- Method: GET
- Endpoint: ~/rtm/vendor/channel_events
- Request URL:

```
https://api.agora.io/dev/v2/project/<appid>/rtm/hook/channel_events
```


### A response example of `get`

```json
{
    "result": "success",
    "request_id" : "10116762670167749259",
    "events" : [event]
}
```

| Parameter    | Type   | Description                    |
| :----------- | :----- | :----------------------------- |
| `result`     | string | The result of this request.    |
| `request_id` | string | The unique ID of this request. |
| `events`     | JSON   | A join or leave event.         |

### An example of `event`

```json
{
    "user_id": "rtmtest_RTM_4852_4857w7%",
    "type" : "Login",
    "ts" : 1578027418981
}
```

| Parameter | Type   | Description                                                  |
| :-------- | :----- | :----------------------------------------------------------- |
| `user_id` | string | The user ID involved.                                        |
| `type`    | string | The event type: <li><code>Join</code>: A user has joined the channel;</li><li><code>Leave</code>: A user has left the channel. </li> |
| `ts`      | int    | Timestamp in milliseconds.                                   |

> - The RTM backend stores a maximum of 2,000 events. 
> - The backend returns a maximum of 1,000 events each time. 
> - We do not guarantee the time sequence of events across geographies, because we store events by regions. 
> - If you have pulled events from one region, you may get the same events when you pull from a different region. This is because we only synchronize events within a region and do not synchronize events across regions. 


### Error codes

| Error codes | Description                                                  |
| :---------- | :----------------------------------------------------------- |
| 408         | The server request times out or the server fails to respond. Try again later. |