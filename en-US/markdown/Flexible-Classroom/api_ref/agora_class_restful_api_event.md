## Overview
本页列出通过灵动课堂云服务[获取课堂事件接口](./agora_class_restful_api#获取课堂事件)获取到的所有事件类型。

## The classroom state changes

When the `cmd` property of an event is `1`, the event indicates the classroom state changes, and the `data` property contains the following fields:

| Parameter | Type | Description |
| ----------- | ------- | ------------------------------------------------------------ |
| `startTime` | Number | The Unix timestamp (in milliseconds) when the classroom starts, in UTC. This property is available after the state of the classroom changes to "Started". |
| `state` | Integer | The current state of the classroom:<ul><li>`0`: Not started.</li><li>`1`: In progress.</li><li>`2`: Ended. Users cannot enter the classroom when the classroom is in the "Ended" state.</li></ul> |

**Example**

```json
{
    "startTime":1611561776588,
    "state":1
}
```

## Receives a room chat message

When the `cmd` property of an event is `3`, the event indicates the server receives a room chat message, and the` data` contains the following fields:

| Parameter | Type | Description |
| ---------- | ------- | ------------------------------------------------------------ |
| `fromUser` | Object | The user who sends this message. This object contains the following fields:<ul><li>`userUuid`: String. The` user` ID.</li><li>`userName`: String. The` user` name.</li><li>`role`: Integer. The user` role`:<ul><li>`1`: Teacher.</li><li>`2`: Student.</li></ul></li> |
| `message` | String | The message. |
| `type` | Integer | The type of the message. Temporarily, you can only set this parameter as `1 `(text). |

**Example**
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

## Users enter or leave the classroom

When `cmd` is `20`, the event indicates that users have entered or left the classroom. `data` includes the following fields:

| Parameter | Type | Description |
| -------------- | ----------- | ------------------------------------------------------------ |
| `total` | Integer | The total number of users who have entered and left the classroom. |
| `onlineUsers` | Object Array | The users who have entered the classroom. This object contains the following fields:<ul><li>`userName`: String. The` user` name.</li><li>`userUuid`: String. The` user` ID.</li><li>`role`: Integer. The user` role`:<ul><li>`1`: Teacher.</li><li>`2`: Student.</li></ul></li><li>`changeProperties`: Object. The` user` property.</li><li>`streamUuid`: String. The ID of the stream, which is also the uid used when joining an RTC channel.</li><li>`type`: Integer, the reasons why the user enters the classroom:<ul><li>`1`: The user enters the classroom in a normal way.</li><li>`2`: The user re-enters the classroom.</li></ul></li><li>`updateTime`: Number, the time when the user enters the classroom, Unix timestamp (milliseconds), UTC time.</li></ul> |
| `offlineUsers` | Object Array | The users who have left the classroom. This object contains the following fields:<ul><li>`userName`: String. The` user` name.</li><li>`userUuid`: String. The` user` ID.</li><li>`role`: Integer. The user` role`:<ul><li>`1`: Teacher.</li><li>`2`: Student.</li></ul></li><li>`changeProperties`: Object. The` user` property.</li><li>`streamUuid`: String. The ID of the stream, which is also the uid used when joining an RTC channel.</li><li>`type`: Integer, the reasons why the user leaves the classroom:<ul><li>`1`: The user left the classroom on the client, such as leaving the class normally, the application is forcibly closed, or the user is disconnected due to poor network conditions.</li><li>`2`: The user was kicked out of the classroom.</li></ul></li><li>`updateTime`: Number, the time when the user enters or leaves the classroom, Unix timestamp (in milliseconds), UTC time.</li></ul> |

**Example**
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


## The recording state changes

When the `cmd` property of an event is `1001`, the event indicates the recording state changes, and the `data` property contains the following fields:

| Parameter | Type | Description |
| ------------ | ------- | ------------------------------------------------------------ |
| `recordId` | String | This is the unique identifier of a recording session. A recording session starts when you call a method to start recording and ends when you call this method to stop recording. This field is available only when `state` is `1`. |
| `sid` | String | The sid of the Agora Cloud Recording service``. This field is available only when `state` is `1`. |
| `resourceId` | String | The resourceId of the Agora Cloud Recording service``. This field is available only when `state` is `1`. |
| `state` | Integer | The current recording state:<ul><li>`1`: In recording.</li><li>`2`: Recording has ended.</li></ul> |
| `startTime` | Number | The Unix timestamp (in milliseconds) when the recording starts, in UTC. This property is available after the recording state changes to "Started". |

**Example**
```json
{
    "recordId":"xxx",
    "sid":"xxx",
    "resourceId":"xxx",
    "state":1,
    "startTime":1611564500488
}
```

## The number of rewards changes

When the` cmd` property of an event is `1101`, the event indicates the number of rewards changes, and the `data` property contains the following fields:

| Parameter | Type | Description |
| :-------------- | :---------- | :----------------------------------------------------------- |
| `rewardDetails` | Object Array | Each object represents the rewards of a user and contains the following fields:<li>`userUuid`: String. The` user` ID.</li><li>`changedReward`: Integer, the number of rewards that have changed.</li><li>`total`: Integer, the` total` number of rewards.</li> |
| `updateTime` | Number | The Unix timestamp (in milliseconds) when the rewards change, in UTC. |

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

## The resources in the classroom changes

When the` cmd` property of an event is `1003`, the event indicates the resources in the classroom changes, and the` data` property contains the following fields:

| Parameter | Type | Description |
| :---------- | :---------- | :----------------------------------------------------------- |
| Parameter | Type | Description |
| `resources` | Object Array | Each object represents a public resource and contains the following fields:<li>`resourceUuid`: String. The resource ID.</li><li>`resourceName`: String, the` resource` name for display in the classroom.</li><li>`size`: Number, the resource` size` (bytes).</li><li>`url`: String, the URL address of the resource.</li><li>`taskUuid`: String, the ID of the file conversion` task`.</li><li>`taskToken`: String, the token used by the file conversion` task`.</li><li>`taskProgress`: Object, the progress of the file conversion` task`.</li> |
| `operator` | Object | It contains the following fields:<li>`userUuid`: String. The` user` ID.</li><li>`userName`: String. The` user` name.</li><li>`role`: integer. The` role` of the user.</li> |
| `action` | Integer | The resource change type:<li>`1`: The resource is added or updated.</li><li>`2`: The resource is deleted.</li> |

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
