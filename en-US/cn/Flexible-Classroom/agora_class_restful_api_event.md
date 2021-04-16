## Overview
本页列出通过灵动课堂云服务[获取课堂事件接口](./agora_class_restful_api#获取课堂事件)获取到的所有事件类型。

## 课堂状态变更

`cmd` 为 `1` 时，该事件提示课堂状态发生变更，`data` 中包含以下字段：

| Parameter | Type | Description |
| ----------- | ------- | ------------------------------------------------------------ |
| `startTime` | Number | 课堂开始时间，Unix 时间戳（毫秒），UTC 时间。 课堂开始后此字段有值。 |
| `state` | Integer | 当前课堂状态：<ul><li>`0`: 未开始。</li><li>`1`: 进行中。</li><li>`2`: 已结束，新用户无法进入。</li></ul> |

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
| `fromUser` | Object | 发送该消息的用户，包含以下字段：<ul><li>`userUuid`: String 型，用户 uuid。</li><li>`userName`: String 型，用户名称。</li><li>`role`: Integer 型，用户在课堂中的角色：<ul><li>`1`: Teacher.</li><li>`2`: Student.</li></ul></li> |
| `message` | String | 消息内容。 |
| `type` | Integer | 消息类型，当前只支持 `1`，表示文本消息。 |

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
| `total` | Integer | 进入和退出课堂的用户总数。 |
| `onlineUsers` | Object array | 进入课堂的用户，包含以下字段：<ul><li>`userName`: String 型，用户名称。</li><li>`userUuid`: String 型，用户 uuid。</li><li>`role`: Integer 型，用户在课堂中的角色：<ul><li>`1`: Teacher.</li><li>`2`: Student.</li></ul></li><li>`userProperties`: Object 型，用户属性。</li><li>`streamUuid`: String 型，用户流的 uuid，也是加入 RTC 频道时用的 UID。</li><li>`type`: Integer 型，用户进入类型：<ul><li>`1`: 正常进入</li><li>`2`: 重连</li></ul></li><li>`updateTime`: Number 型，用户进入课堂时间，Unix 时间戳（毫秒），UTC 时间。</li></ul> |
| `offlineUsers` | Object array | 退出课堂的用户，包含以下字段：<ul><li>`userName`: String 型，用户名称。</li><li>`userUuid`: String 型，用户 uuid。</li><li>`role`: Integer 型，用户在课堂中的角色：<ul><li>`1`: Teacher.</li><li>`2`: Student.</li></ul></li><li>`userProperties`: Object 型，用户属性。</li><li>`streamUuid`: String 型，用户流的 uuid，也是加入 RTC 频道时用的 UID。</li><li>`type`: Integer 型，用户退出类型：<ul><li>`1`: 由于客户端原因退出课堂，例如正常离开课堂、应用被强制关闭或由于网络状况不佳而断线。</li><li>`2`: 被踢出课堂。</li></ul></li><li>`updateTime`: Number 型，用户退出课堂时间，Unix 时间戳（毫秒），UTC 时间。</li></ul> |

**示例**
```json
{
    "total":3,
    "onlineUsers":[
        {
            "userName":"",
            "userUuid":"",
            "role":"0",
            "userProperties":{  },
            "streamUuid":"",
            "type":1,
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
            "type":1,
            "updateTime":1611561776588
        }
    ]
}
```


## 录制状态变更

`cmd` 为 `1001` 时，该事件提示录制状态发生变更，`data` 中包含以下字段：

| Parameter | Type | Description |
| ------------ | ------- | ------------------------------------------------------------ |
| `recordId` | String | 一次录制的的唯一标识符。 A recording session starts when you call a method to start recording and ends when you call this method to stop recording. 仅当 `state` 为 `1` 时有此字段。 |
| `sid` | String | Agora 云端录制服务的 `sid`。 仅当 `state` 为 `1` 时有此字段。 |
| `resourceId` | String | Agora 云端录制服务的 `resourceId`。 仅当 `state` 为 `1` 时有此字段。 |
| `state` | Integer | 当前录制状态：<ul><li>`1`: In recording.</li><li>`2`: Recording has ended.</li></ul> |
| `startTime` | Number | 录制开始时间，Unix 时间戳（毫秒），UTC 时间。 录制开始后此字段有值。 |

**示例**
```json
{
    "recordId":"xxx",
    "sid":"xxx",
    "resourceId":"xxx",
    "state":1,
    "startTime":1611564500488
}
```

## 奖励数量变更

`cmd` 为 `1101` 时，该事件提示奖励数量发生变更，`data` 中包含以下字段：

| Parameter | Type | Description |
| :-------------- | :---------- | :----------------------------------------------------------- |
| `rewardDetails` | Object array | 一个 Object 代表一个用户的奖励数量变更情况，包含以下字段：<li>`userUuid`: String 型，用户 uuid。</li><li>`changedReward`: Integer 型，发生变更的奖励个数。</li><li>`totalReward`: Integer 型，变更后用户的奖励总数。</li> |
| `updateTime` | Number | 奖励变更时间，Unix 时间戳（毫秒），UTC 时间。 |

**示例**：

```json
{
     "rewardDetails":[ {
            "userUuid":"",
            "changedReward": 1,
            "totalReward": 10
        } ],
       "updateTime":1611564500488
}
```

## 云盘资源变更

`cmd` 为 `1003` 时，该事件提示云盘资源发生变更，`data` 中包含以下字段：

| Parameter | Type | Description |
| :---------- | :---------- | :----------------------------------------------------------- |
| Parameter | Type | Description |
| `resources` | Object array | 一个 Object 代表一个资源的变更情况，包含以下字段：<li>`resourceUuid`: String. The resource ID.</li><li>`resourceName`: String 型，资源名称。</li><li>`size`: Number, the resource size (bytes).</li><li>`url`: String, the URL address of the resource.</li><li>`taskUuid`: String, the ID of the file conversion task.</li><li>`taskToken`: String, the token used by the file conversion task.</li><li>`taskProgress`: Object 型，文件转换任务进度。</li> |
| `operator` | Object | 操作人，包含以下字段：<li>`userUuid`: String 型，用户 uuid。</li><li>`userName`: String 型，用户名称。</li><li>`role`: String 型，用户角色。</li> |
| `action` | Integer | 资源变更类型：<li>`1`: 资源新增或更新。</li><li>`2`: 资源被删除。</li> |

**示例**：

```json
{
     "resources": [{
            "resourceUuid":"",
            "resourceName": "1",
            "size": 1024,
            "url": "http://xxx.com/ooo",
            "taskUuid": "",
            "taskToken": "",
            "taskProgress": {},
        } ],
      "operator":{
        "role":"1",
        "userName":"jason",
        "userUuid":"jason1"
    },
       "action": 1
}
```
