---
title: 灵动课堂云服务事件枚举
platform: All Platforms
updatedAt: 2021-03-19 09:10:10
---
本页列出通过灵动课堂云服务[获取课堂事件接口](./agora_class_restful_api#获取课堂事件)获取到的所有事件类型。

## 课堂状态变更

`cmd` 为 `1` 时，该事件提示课堂状态发生变更，`data` 中包含以下字段：

- `startTime`: Integer 型，课堂开始时间，Unix 时间戳（毫秒），UTC 时间。课堂开始后此字段有值。

- `state`: Integer 型，当前课堂状态：
  - `0`: 未开始。
  - `1`: 进行中。
  - `2`: 已结束，新用户无法进入。

**示例**：
```
{
    "startTime":1611561776588,
    "state":1
}
```

## 课堂聊天消息

`cmd` 为 `3` 时，该事件提示收到课堂聊天消息，`data` 中包含以下字段：

- `fromUser`:  Object 型，发送该消息的用户，包含以下字段：
  - `userUuid`: 用户 uuid。
  - `userName`: 用户名称。
  - `role`: 用户在课堂中的角色：
    - `0`: 学生
    - `1`: 老师
- `message`: String 型，消息内容。
- `type`: Integer 型，消息类型，当前只支持 `1`，表示文本消息。

**示例**：
```
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

`cmd` 为 `20` 时，该事件提示有用户进出课堂。`data` 中包含以下字段：
- `total`: Integer 型，进入和退出课堂的用户总数。
- `onlineUsers`: Object 数组，进入课堂的用户，包含以下字段：
  - `userName`: String 型，用户名称。
  - `userUuid`: String 型，用户 uuid。
  - `role`: Integer 型，用户在课堂中的角色：
    - `0`: 学生
    - `1`: 老师
  - `userProperties`: Object 型，用户属性。
  - `streamUuid`: String 型，用户流的 uuid，也是加入 RTC 频道时用的 UID。
  - `type`: Integer 型，用户进入类型：
    - `1`: 正常进入 
    - `2`: 重连
  - `updateTime`: Integer 型，用户进入课堂时间，Unix 时间戳（毫秒），UTC 时间。
- `offlineUsers`: Object 数组，退出课堂的用户，包含以下字段：
  - `userName`: String 型，用户名称。
  - `userUuid`: String 型，用户 uuid。
  - `role`: Integer 型，用户在课堂中的角色：
    - `0`: 学生
    - `1`: 老师
  - `userProperties`: Object 型，用户属性。
  - `streamUuid`: String 型，用户主流的 uuid。
  - `type`: Integer 型，用户推出类型：
    - `1`: 正常推出 
    - `2`: 被踢出
  - `updateTime`: Integer 型，用户退出课堂时间，Unix 时间戳（毫秒），UTC 时间。

**示例**：
```
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

- `recordId`: String 型，一次录制的的唯一标识符。调用设置录制状态 API 开始录制然后结束录制视为一次录制。

- `sid`: String 型，Agora 云端录制服务的 `sid`。

- `resourceId`: String 型，Agora 云端录制服务的 `resourceId`。

- `state`: Integer 型，当前录制状态：
  - `1`: 录制中
  - `2`: 录制已结束
- `startTime`: Integer 型，录制开始时间，Unix 时间戳（毫秒），UTC 时间。录制开始后此字段有值。

**示例**：
```
{
    "recordId":"xxx",
    "sid":"xxx",
    "resourceId":"xxx",
    "state":1,
    "startTime":1611564500488
}
```