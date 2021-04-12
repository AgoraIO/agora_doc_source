## 概述
This page lists all types of [events that you can get through the Get classroom ](./agora_class_restful_api#获取课堂事件)events method.

## 课堂状态变更

`cmd` 为 `1` 时，该事件提示课堂状态发生变更，`data` 中包含以下字段：

| Parameter | Type | Description |
| ----------- | ------- | ------------------------------------------------------------ |
| `startTime` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. 课堂开始后此字段有值。 |
| `state` | integer | 当前课堂状态：<ul><li>`0`: 未开始。</li><li>`1`: 进行中。</li><li>`2`: 已结束，新用户无法进入。</li></ul> |

**示例**

```json
{
    "startTime":1611561776588,
    "state":1
}
```

## 课堂聊天消息

`cmd` 为 `3` 时，该事件提示收到课堂聊天消息，`data` 中包含以下字段：

| Parameter | Type | Description |
| ---------- | ------- | ------------------------------------------------------------ |
| `fromUser` | object | 发送该消息的用户，包含以下字段：<ul><li>` roomUuid`: String, the classroom ID.</li><li>`userName`: String 型，用户名称。</li><li>`role`: Integer 型，用户在课堂中的角色：<ul><li>`1`: Teacher.</li><li>`2`: Student.</li></ul></li> |
| `message` | String | 消息内容。 |
| `type` | integer | 消息类型，当前只支持 `1`，表示文本消息。 |

**示例**
```json
{
    "fromUser":{
        "role":"host",
        "userName":"jason",
        "userUuid":"jason1"
    },
    "message":"aa",
    "type":1
}
```

## 用户进出课堂

`cmd` 为 `20` 时，该事件提示有用户进出课堂。 `data` 中包含以下字段：

| Parameter | Type | Description |
| -------------- | ----------- | ------------------------------------------------------------ |
| `total` | integer | 进入和退出课堂的用户总数。 |
| `onlineUsers` | Object 数组 | 进入课堂的用户，包含以下字段：<ul><li>`userName`: String 型，用户名称。</li><li>` roomUuid`: String, the classroom ID.</li><li>`role`: Integer 型，用户在课堂中的角色：<ul><li>`1`: Teacher.</li><li>`2`: Student.</li></ul></li><li>`userProperties`: Object 型，用户属性。</li><li>`streamUuid`: String 型，用户流的 uuid，也是加入 RTC 频道时用的 UID。</li><li>`type`: Integer, the recording type:<ul><li>`1`: 正常进入</li><li>`2`: 重连</li></ul></li><li>`updateTime`: Number 型，用户进入课堂时间，Unix 时间戳（毫秒），UTC 时间。</li></ul> |
| `offlineUsers` | Object 数组 | 退出课堂的用户，包含以下字段：<ul><li>`userName`: String 型，用户名称。</li><li>` roomUuid`: String, the classroom ID.</li><li>`role`: Integer 型，用户在课堂中的角色：<ul><li>`1`: Teacher.</li><li>`2`: Student.</li></ul></li><li>`userProperties`: Object 型，用户属性。</li><li>`streamUuid`: String 型，用户流的 uuid，也是加入 RTC 频道时用的 UID。</li><li>`type`: Integer, the recording type:<ul><li>`1`: 由于客户端原因退出课堂，例如正常离开课堂、应用被强制关闭或由于网络状况不佳而断线。</li><li>`2`: 被踢出课堂。</li></ul></li><li>`updateTime`: Number 型，用户退出课堂时间，Unix 时间戳（毫秒），UTC 时间。</li></ul> |

**示例**
```json
{
    "total": 17,
    "onlineUsers":[
        {
            "userName":"",
            "userUuid":"",
            "role":"0",
            "userProperties":{  },
            "streamUuid":"",
                    "type": 2,
            "updateTime":1611561776588
        }
    ],
    "offlineUsers":[
        {
            "userName":"",
            "userUuid":"",
            "role":"0",
            "userProperties":{},
            "streamUuid":"",
                    "type": 2,
            "updateTime":1611561776588
        }
    ]
}
```


## 录制状态变更

`cmd` 为 `1001` 时，该事件提示录制状态发生变更，`data` 中包含以下字段：

| Parameter | Type | Description |
| ------------ | ------- | ------------------------------------------------------------ |
| `recordId` | String | 一次录制的的唯一标识符。 调用设置录制状态 API 开始录制然后结束录制视为一次录制。 仅当 `state` 为 `1` 时有此字段。 |
| `sid` | String | sid`: The sid of Agora cloud recording service`. 仅当 `state` 为 `1` 时有此字段。 |
| `resourceId` | String | Agora 云端录制服务的 `resourceId`。 仅当 `state` 为 `1` 时有此字段。 |
| `state` | integer | 当前录制状态：<ul><li>`1`: In recording.</li><li>`2`: Recording has ended.</li></ul> |
| `startTime` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. 录制开始后此字段有值。 |

**示例**
```json
{
        "recordId": "xxxxxx",
        "sid": "xxxxxx",
        "resourceId": "xxxxxx",
    "state":1,
    "startTime":1611564500488
}
```
