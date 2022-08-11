## Overview
This page lists all types of events that you can get through the [Get classroom events](./agora_class_restful_api#get-classroom-events) method.

## The classroom state changes

When the `cmd` property of an event is `1`, the event indicates the classroom state changes, and the `data` property contains the following fields:

| Parameter | Type | Description |
| ----------- | ------- | ------------------------------------------------------------ |
| `startTime` | Number | The Unix timestamp (in milliseconds) when the classroom starts, in UTC. This property is available after the state of the classroom changes to "Started". |
| `state` | Integer | The current state of the classroom:<ul><li>`0`: Not started.</li><li>`1`: In progress.</li><li>`2`: Ended.</li><li>`3`: After the run-late time of a class, the room is closed and users can no longer enter the room.</li></ul> |

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
| `fromUser` | Object | The user who sends this message. This object contains the following fields:<ul><li>`userUuid`: String. The user ID.</li><li>`userName`: String. The user name.</li><li>`role`: Integer. The user role. This parameter can be set as one of the following values:<ul><li>`1`: Teacher.</li><li>`2`: Student.</li></ul></li></ul> |
| `message` | String | The message. |
| `type` | Integer | The type of the message. Temporarily, you can only set this parameter as `1`(text messages). |

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

When the `cmd` property of an event is `20`, the event indicates that users have entered or left the classroom. `data` includes the following fields:

| Parameter | Type | Description |
| -------------- | ----------- | ------------------------------------------------------------ |
| `total` | Integer | The total number of users who have entered and left the classroom. |
| `onlineUsers` | Object Array | The users who have entered the classroom. This object contains the following fields:<ul><li>`userName`: String. The user name.</li><li>`userUuid`: String. The user ID.</li><li>`role`: Integer. The user role. This parameter can be set as one of the following values:<ul><li>`1`: Teacher.</li><li>`2`: Student.</li></ul></li><li>`userProperties`: Object. The user property.</li><li>`streamUuid`: String. The ID of the stream, which is also the uid used when joining an RTC channel.</li><li>`type`: Integer. The reasons why the user enters the room:<ul><li>`1`: The user enters the classroom in a normal way.</li><li>`2`: The user re-enters the classroom.</li></ul></li><li>`updateTime`: Number. The time when the user enters the classroom, Unix timestamp (milliseconds), UTC time.</li></ul> |
| `offlineUsers` | Object Array | The users who have left the classroom. This object contains the following fields:<ul><li>`userName`: String. The user name.</li><li>`userUuid`: String. The user ID.</li><li>`role`: Integer. The user role. This parameter can be set as one of the following values:<ul><li>`1`: Teacher.</li><li>`2`: Student.</li></ul></li><li>`userProperties`: Object. The user property.</li><li>`streamUuid`: String. The ID of the stream, which is also the uid used when joining an RTC channel.</li><li>`type`: Integer. The reasons why the user leaves the classroom:<ul><li>`1`: The user leaves the classroom on the client, such as leaving the class normally, the application is forcibly closed, or the user is disconnected due to poor network conditions.</li><li>`2`: The user is kicked out of the classroom.</li></ul></li><li>`updateTime`: Number. The time when the user enters or leaves the classroom, Unix timestamp (in milliseconds), UTC time.</li></ul> |

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
| `sid` | String | The `sid` of the Agora Cloud Recording service. This field is available only when `state` is `1`. |
| `resourceId` | String | The `resourceId` of the Agora Cloud Recording service. This field is available only when `state` is `1`. |
| `state` | Integer | The current recording state:<ul><li>`2`: Recording has ended.</li><li>`1`: In recording.</li></ul> |
| `startTime` | Number | The Unix timestamp (in milliseconds) when the recording starts, in UTC. This property is available after the recording state changes to "Started". |
| `streamingUrl`|Object | The URL of the streams of web page recording after pushed to CDN. Students watch class videos with this URL.  |

**Example**
```json
{
    "recordId":"xxx",
    "sid":"xxx",
    "resourceId":"xxx",
    "state":1,
    "startTime":1611564500488,
    "streamingUrl": {
            "rtmp": "",
            "flv": "",
            "hls": ""
        }
}
```

## The number of rewards changes

When the `cmd` property of an event is `1101`, the event indicates the number of rewards changes, and the `data` property contains the following fields:

| Parameter | Type | Description |
| :-------------- | :---------- | :----------------------------------------------------------- |
| `rewardDetails` | Object Array | Each object represents the rewards of a user and contains the following fields:<li>`userUuid`: String. The user ID.</li><li>`changedReward`: Integer. The number of changed rewards.</li><li>`total`: Integer. The total number of rewards after the change.</li> |
| `updateTime` | Number | The Unix timestamp (in milliseconds) when the rewards change, in UTC. |

**Example**

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

## The resources in the classroom change

When the `cmd` property of an event is `1003`, the event indicates the resources in the classroom change, and the `data` property contains the following fields:

| Parameter | Type | Description |
| :---------- | :---------- | :----------------------------------------------------------- |
| Parameter | Type | Description |
| `resources` | Object Array | Each object represents a public resource and contains the following fields:<li>`resourceUuid`: String. The resource ID.</li><li>`resourceName`: String. The resource name.</li><li>`size`: Number. The resourc size (bytes).</li><li>`url`: String. The URL address of the resource.</li><li>`taskUuid`: String. The ID of the file conversion task.</li><li>`taskToken`: String. The token used for the file conversion task.</li><li>`taskProgress`: Object. The progress of a file conversion task.</li> |
| `operator` | Object | It contains the following fields:<li>`userUuid`: String. The user ID.</li><li>`userName`: String. The user name.</li><li>`role`: Integer. Th user role.</li> |
| `action` | Integer | The resource change type:<li>`1`: The resource is added or updated.</li><li>`2`: The resource is deleted.</li> |

**Example**

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

## The users "on the stage" change

When the `cmd` property of an event is `1501`, the event indicates the users "on the stage" change, and the` data` property contains the following fields:

| Parameter | Type | Description |
| :-------------------- | :---------- | :----------------------------------------------------------- |
| `acceptedUsers` | Object Array | The list of users who are now "on the stage". The object contains the following fields:<li>`userUuid`: String. The user ID.</li> |
| `addAcceptedUsers` | Object Array | The list of users who have just "gone onto the stage". The object contains the following fields:<li>`userUuid`: String. The user ID.</li> |
| `removeAcceptedUsers` | Object Array | The list of users who have just "left the stage". The object contains the following fields:<li>`userUuid`: String. The user ID.</li> |

**Example**

```json
{
    "acceptedUsers": [{
        "userUuid":""
    }],
    "addAcceptedUsers": [{
        "userUuid":""
    }],
    "removeAcceptedUsers": [{
        "userUuid":""
    }]
}
```

## The users who wave their hands change

When the `cmd` property of an event is `1502`, the event indicates the users who wave their hands change, and the `data` property contains the following fields:

| Parameter | Type | Description |
| :-------------------- | :---------- | :----------------------------------------------------------- |
| `progressUsers` | Object Array | The list of users who are waving their hands. The object contains the following fields:<li>`userUuid`: String. The user ID.</li><li>`payload`: Object.</li> |
| `addProgressUsers` | Object Array | The list of users who have just started waving their hands. The object contains the following fields:<li>`userUuid`: String. The user ID.</li><li>`payload`: Object.</li> |
| `removeProgressUsers` | Object Array | The list of users who have just stopped waving their hands. The object contains the following fields:<li>`userUuid`: String. The user ID.</li><li>`payload`: Object.</li> |

**Example**

```json
{
    "progressUsers": [{
        "userUuid":"",
        "payload":{}
    }],
    "addProgressUsers": [{
        "userUuid":"",
        "payload": {}
    }],
    "removeProgressUsers": [{
        "userUuid":"",
        "payload": {}
    }]
}
```