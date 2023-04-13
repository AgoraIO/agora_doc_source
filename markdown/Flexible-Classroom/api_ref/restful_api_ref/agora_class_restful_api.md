灵动课堂提供了多种服务端对服务端 RESTful API（包括但不限于房间管理、用户管理、事件同步、扩展组件等），供开发者灵活扩展课堂功能及与自身业务系统的快速对接，大幅降低开发门槛，轻松实现复杂应用逻辑，为企业、学校提供高稳定高性价比的线上互动课堂服务。

## 公共请求参数
公共参数是用于标识用户 App ID 和接口签名的参数和请求区域，如非必要，在每个接口单独的文档中不再对这些参数进行说明，但每次请求均需要携带这些参数，才能正常发起请求。

### 域名

所有请求都发送给域名：api.agora.io。

为保障 REST 服务的高可用，避免因区域网络故障造成的服务不可用，声网提供切换域名的方案，详情请参考[切换域名](/cn/Real-time-Messaging/rtm_integration_bp?platform=RESTful#切换域名)。

### 数据格式

所有请求的 Content-Type 类型为 application/json。

### 认证方式

灵动课堂 RESTful API 支持 Token 认证。你需要在发送 HTTP 请求时在 HTTP 请求头部的 `x-agora-token` 字段和 `x-agora-uid` 字段分别填入：

-   服务端生成的 RTM Token。
-   生成 RTM Token 时使用的 uid。

具体生成 RTM Token 的方法请参考[生成 RTM Token](/cn/Real-time-Messaging/token_upgrade_rtm) 文档。

### 区域

灵动课堂 RESTful API 所有接口 `region` 字段的可选值如下表所示。如果有接口不支持该表中的所有区域，则会在该接口文档中单独说明。

<div class="alert note">对于同一课堂，服务端接口调用的区域需要与客户端课堂创建的区域一致，否则会报告“房间不存在”的错误。</div>

|  取值    | 区域  |
|:-------|:----|
| `cn` | 中国大陆 |
| `ap` | 亚太 |
| `na` | 北美 |
| `eu` | 欧洲 |


### 其他业务参数


| 参数       | 类型   | 描述           |
| :--------- | :----- |:-----------------------------|
| `appId` | String | 声网 App ID，详见[获取 App ID](cn/Agora%20Platform/get_appid_token#获取-app-id)。 |
| `roomUuid` | String | 课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 时所使用的频道名。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）: <ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>空格</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", " |", "~", ","</li></ul> |
| `userUuid` | String | 用户 uuid。这是用户的唯一标识符，也是登录 RTM 系统时所使用的用户 ID。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）: <ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>空格</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", " |", "~", ","</li></ul>                                                                                    |

## 公共响应参数

| 参数   | 类型    | 描述     |
| :----- | :------ |:---------------------------------------------------------------------------------|
| `code` | Integer | 响应状态码：<ul><li>`0`: 请求成功。</li><li>非 `0`: 请求失败。详见[响应状态码](/cn/agora-class/agora_class_restful_api?platform=RESTful#响应状态码)。</li></ul> |
| `msg`  | String  | 接口响应文字信息。                                                                                                             |
| `ts` | Number | 当前服务端的 Unix 时间戳，UTC 时间，单位为毫秒。 |
| `data` | Object | 返回数据，部分接口的该字段有值，详见单个接口的说明。 |


### 响应示例
#### 成功返回结果
当接口请求成功时，所有接口响应的 HTTP 状态码均为 `200`。

```json
"status": 200,
"body":
{
  "code": 0,
  "msg": "Success",
  "ts": 1610450153520
}
```

#### 错误返回结果
若为客户端错误，HTTP 状态码（`status` 字段）为 `40x`。

```json
"status": 404,
"body":
{
  "code": 20404100,
  "msg": "Room not exists!",
  "ts": 1610450153520
}
```

若为服务端错误，HTTP 状态码（`status` 字段）为 `50x`。

```json
"status": 500,
"body":
{
    "msg": "Internal Server Error",
    "code": 500,
    "ts": 1610167740309
}
```

## 房间相关

### 创建课堂

#### 接口描述

课堂创建后，默认保留 5 天。

#### 接口原型

-   方法：POST
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}

#### 请求参数

**URL 参数**

| 参数       | 类型   | 是否必填 | 描述                                                         |
| :--------- | :----- |:-----| :----------------------------------------------------------- |
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |

**请求包体参数**

| 参数                                         | 类型    | 非必填  | 描述                                                                                                                                                                             |
| :------------------------------------------- | :------ | :------ |:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `roomType`                                   | String  | 必填    | 房间类型，可设为：<ul><li>`0`: 一对一</li><li>`2`: 大班课</li><li>`4`: 小班课</li></ul><p>该字段不可更新。</p>                                                                                             |
| `roomName` | String | 必填 | 房间名称，用于用户显示目的。最长不可超过 64 字节。 |
| `roomProperties`                             | Object  | 非必填     | 房间属性。                       |
| `roomProperties.schedule`                    | Object  | 非必填       | 课程计划，包含开始时间，持续时长，拖堂时长等属性。     |
| `roomProperties.schedule.startTime`          | Integer | 非必填 | 课堂开始时间戳，单位为毫秒。该字段不可更新。 |
| `roomProperties.schedule.duration`           | Integer | 非必填 | 课堂持续时长，单位为秒。如果你设置了课堂持续时长和拖堂时长，当开启录制时，会按照二者之和向上取整设置最长录制时间 `maxRecordingHour` 参数。详见[设置录制状态](#设置录制状态)的 `maxRecordingHour` 参数说明。  |
| `roomProperties.schedule.closeDelay`         | Integer | 非必填 | 拖堂时长，单位为秒。当课堂持续时长结束后，课程会进入“结束”状态（`state`= 2），此时用户仍可以正常进入和逗留在教室。当拖堂时间结束时，课堂会进入“关闭”状态（`state`= 3），并踢出所有用户。 |
| `roomProperties.processes`                   | Object  | 非必填   | 申请邀请流程，包含举手等功能。     |
| `roomProperties.processes.handsUp`           | Object  | 非必填    | 上台设置，包含上台人数上限等。   |
| `roomProperties.processes.handsUp.maxAccept` | Integer |  非必填   | 上台人数上限。            |


#### 请求示例

```json
curl -X POST 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}' \
--data-raw '{
    "roomName": "test_class",
    "roomType": 4,
    "roomProperties": {
        "schedule": {
            "startTime": 1655452800000,
            "duration": 600,
            "closeDelay": 300
        },
        "processes": {
            "handsUp": {
                "maxAccept": 10
            }
        }
    }
}'
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |


#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```


### 设置课堂状态

#### 接口描述

设置课堂状态。课堂状态可以设置为以下值：
- `0`: 未开始。
- `1`: 开始。
- `2`: 结束。课堂时间结束，但在拖堂时间内，用户可以加入课堂和在课堂内逗留。
- `3`: 关闭。拖堂时间结束，课堂关闭，所有用户被踢出并无法再进入。
详见[灵动课堂有哪些课堂状态？](/cn/agora-class/faq/agora_class_state)。

#### 接口原型

-   方法：PUT
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/states/{state}

#### 请求参数

**URL 参数**

| 参数       | 类型    |  是否必填 | 描述                                                         |
| :--------- | :------ |  :------ | :----------------------------------------------------------- |
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |
| `state` | Integer | 必填 |课堂状态，可以设置为以下值：<ul><li>`0`: 未开始。</li><li>`1`: 开始。</li><li>`2`: 结束。课堂时间结束，但在拖堂时间内，用户可以加入课堂和在课堂内逗留。</li><li>`3`: 关闭。拖堂时间结束，课堂关闭，所有用户被踢出并无法再进入。</li></ul>|

#### 请求示例

```json
curl -X PUT 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/states/1' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}'
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |

#### 响应示例

```json
"status": 200,
"body":
{
    "code": 0,
    "msg": "Success",
    "ts": 1610450153520
}
```

### 更新课堂自定义属性

#### 接口描述

新增或更新指定课堂的自定义属性。

你可以结合自身的业务需求，设置任意课堂自定义属性，灵动课堂会将这个属性的变更同步到所有端，以此来实现你自己的扩展业务。详见[如何设置自定义用户属性和课堂属性？](/cn/agora-class/faq/agora_class_custom_properties)

#### 接口原型

-   方法：PUT
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/properties

#### 请求参数

**URL 参数**


| 参数       | 类型   | 是否必填                                                                          | 描述                                                         |
| :--------- | :----- |:------------------------------------------------------------------------------| :----------------------------------------------------------- |
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |

**请求包体参数**

| 参数         | 类型   | 是否必填 | 描述            |
| :----------- | :----- |:-----|:--------------|
| `properties` | Object | 必填   | 本次设置的课堂自定义属性。 |
| `cause`      | Object | 非必填  | 本次设置原因。       |

#### 请求示例


```json
curl -X PUT 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/properties' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}' \
--data-raw '{
  "properties": {
    "key1": "value1",
    "key2": "value2"
  },
  "cause": {}
}'
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

### 删除课堂自定义属性

#### 接口描述

删除指定课堂的自定义属性。

你可以删除任意课堂自定义属性，灵动课堂会将这个属性的变更同步到所有端，以此来实现你自己的扩展业务。详见[如何设置自定义用户属性和课堂属性？](/cn/agora-class/faq/agora_class_custom_properties)

#### 接口原型

-   方法：DELETE
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/properties

#### 请求参数

**URL 参数**


| 参数       | 类型   |  是否必填 | 描述                                                         |
| :--------- | :----- | :----- | :----------------------------------------------------------- |
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |

**请求包体参数**


| 参数         | 类型       | 是否必填 | 描述                   |
| :----------- |:---------|:-----|:---------------------|
| `properties` | String[] | 必填   | 本次删除的课堂自定义属性对应的 key。 |
| `cause`      | Object   | 非必填  | 本次删除原因。              |

#### 请求示例

```json
curl -X DELETE 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/properties' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}' \
--data-raw '{
  "properties": ["key1", "key2"],
  "cause": {}
}'
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

### 开启/关闭分组讨论

#### 接口描述
开启或关闭课堂分组讨论功能。

#### 接口原型
- 方法：PUT
- 接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/groups/states/{state}

#### 请求参数

**URL 参数**

| 参数       | 类型   | 描述    |
| :--------- | :----- | :------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`    | String | （必填）声网 App ID。     |
| `roomUUid` | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |
| `state` | Integer | （必填）是否开启分组讨论：<ul><li>`1`: 开启。</li><li>`0`: 关闭。</li></ul> |


**请求包体参数**

开启分组讨论时需要在请求包体中传入以下参数；关闭分组讨论时不需要传任何参数。

| 参数              | 类型   | 描述                                                         |
| :---------------- | :----- | :----------------------------------------------------------- |
| `groups` | Array | （必填）待创建的分组列表。包含：<ul><li>`groupUuid`: （选填）待创建的分组 ID，String 型。如果不填，系统会自动分配一个 ID。</li><li>`groupName`: （选填）分组名，String 型。</li><li>`users`：（必填）分组内用户列表，Array 型。包含：<ul><li>`userUuid`：（必填）分组内用户的 uuid。这是用户的唯一标识符，也是登录 RTM 系统时使用的用户 ID。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~</li></ul></ul> |

#### 请求示例
```json
curl -X PUT 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/states/1' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}' \
--data-raw '{
    "groups":[
        {
            "groupUuid": "group1",
            "groupName":"Group 01",
            "users":[{
                "userUuid": "user1"
            }]
        }
    ]
}'
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 业务状态码：<ul><li>0: 请求成功。</li><li>非 0: 请求失败。</li></ul> |
| `msg`  | String  | 详细信息。                                                  |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1672989034831
}
```


## 用户相关

### 查询指定用户

#### 接口原型

-   方法：GET
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/users/{userUuid}

#### 请求参数

**URL 参数**


| 参数       | 类型   | 是否必填                                    |  描述                                         |
| :--------- | :----- |:----------------------------------------|:--------------------------------------------|
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |
| `userUuid` | String | 必填   | 用户 uuid，为公共参数，详见[其他业务参数](#其他业务参数)  |

#### 请求示例

```json
curl -X GET 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/users/test_user' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}'
```
#### 响应参数

| 参数   | 类型    | 描述              |
| :----- | :------ | :---------------------------------------- |
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `data` | Object  | 返回数据，为[公共响应参数](#公共响应参数)。包含以下数据：<ul><li>`userUuid`: 用户 ID。</li><li>`userName`: 用户名称。</li><li>`role`: 用户角色：<ul><li>`1`: 老师</li><li>`2`: 学生</li><li>`3`: 助教</li></ul></li><li>`streamUuid`: 流 ID。</li><li>`state`: 该用户是否在线：<ul><li>`0`：不在线</li><li>`1`：在线</li></ul></li><li>`userProperties`: 用户属性。</li><li>`updateTime`: 更新时间。</li></ul> |

#### 响应示例

```json
{
    "msg":"Success",
    "code":0,
    "ts":1658126805245,
    "data":{
        "userName":"jasoncai",
        "userUuid":"681d9aca4924e9a84ad301e8cca438a71",
        "role":"1",
        "userProperties":{},
        "updateTime":1658126782174,
        "streamUuid":"1417753684",
        "state":1
    }
}
```


### 更新用户自定义属性

#### 接口描述

新增或更新指定用户的自定义属性。

你可以对用户设置任意用户自定义属性，灵动课堂会将这个属性的变更同步到所有端，以此来实现你自己的扩展业务。详见[如何设置自定义用户属性和课堂属性？](/cn/agora-class/faq/agora_class_custom_properties)

#### 接口原型

-   方法：PUT
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/users/{userUuid}/properties

#### 请求参数

**URL 参数**


| 参数       | 类型   |  是否必填 | 描述                                                         |
| :--------- | :----- |:----- | :----------------------------------------------------------- |
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |
| `userUuid` | String | 必填   | 用户 uuid，为公共参数，详见[其他业务参数](#其他业务参数)  |

**请求包体参数**


| 参数         | 类型   | 是否必填 | 描述           |
| :----------- | :----- |:-----|:-------------|
| `properties` | Object | 必填   |  本次设置的用户自定义属性。 |
| `cause`      | Object | 非必填  | 本次设置的原因。 |

#### 请求示例

```json
curl -X PUT 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/users/test_user/properties' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}' \
--data-raw '{
  "properties": {
    "key1": "value1",
    "key2": "value2"
  },
  "cause": {}
}'
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

### 删除用户自定义属性

#### 接口描述

删除指定用户的用户自定义属性。

你可以删除用户的任意属性，灵动课堂会将这个属性的变更同步到所有端，以此来实现你自己的扩展业务。详见[如何设置自定义用户属性和课堂属性？](/cn/agora-class/faq/agora_class_custom_properties)

#### 接口原型

-   方法：DELETE
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/users/{userUuid}/properties

#### 请求参数

**URL 参数**


| 参数       | 类型   | 是否必填 |  描述                                                         |
| :--------- | :----- | :-----|:----------------------------------------------------------- |
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |
| `userUuid` | String | 必填   | 用户 uuid，为公共参数，详见[其他业务参数](#其他业务参数)  |

**请求包体参数**


| 参数         | 类型       | 是否必填 |  描述            |
| :----------- |:---------|:-----|:--------------|
| `properties` | String[] | 必填   |本次删除的用户自定义属性对应的 key。 |
| `cause`      | Object   | 非必填  |本次删除的原因。      |

#### 请求示例

```json
curl -X DELETE 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/users/test_user/properties' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}' \
--data-raw '{
  "properties": ["key1", "key2"],
  "cause": {}
}'
```

#### 响应参数

| 参数   | 类型    | 描述                                                      |
| :----- | :------ |:--------------------------------------------------------|
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```


### 踢人

#### 接口描述

将指定用户从课堂中踢出。成功调用此接口后，服务端会触发一个用户进出课堂事件。你可通过该接口的 `dirty` 参数设置该用户后续是否还能再加入课堂。

#### 接口原型

-   方法：POST
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/users/{userUuid}/exit

#### 请求参数

**URL 参数**


| 参数       | 类型   | 是否必填  |  描述                                          |
| :--------- | :----- |:----- |:---------------------------------------------|
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |
| `userUuid` | String | 必填   | 用户 uuid，为公共参数，详见[其他业务参数](#其他业务参数)  |

**请求包体参数**


| 参数    | 类型   | 是否必填  | 描述                                                                                                                                                                                                             |
| :------ | :----- | :----- |:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `dirty` | Object | 非必填   | 用户踢人标记，包含以下字段：<ul><li>`state`: Integer 型，踢人状态：<ul><li>`1`: 被踢，无法进入课堂。</li><li> `0`: 未被踢，可以进入课堂。</li></ul><li>`duration`: Number 型，临时踢人持续时间，单位为秒。该字段仅在 `state` 为 `1` 时生效。从被踢出时开始计时，过了 `duration` 设置的时长后，用户自动恢复为未被踢状态。若不传该参数，则用户被永久踢出。</li></ul> |

#### 请求示例

```json
curl -X POST 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/users/test_user/exit' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}' \
--data-raw '{
  "dirty": {
    "state": 1,
    "duration": 600
  }
}'
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## 录制相关


### 设置录制状态

#### 接口描述

开始或结束录制指定课堂。详见[课堂录制最佳实践](/cn/agora-class/agora_class_record?platform=Web)。

#### 接口原型

-   方法：PUT
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/records/states/{state}

#### 请求参数

**URL 参数**


| 参数       | 类型    | 是否必填  |  描述                                                         |
| :--------- | :------ |:------|  :----------------------------------------------------------- |
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |
| `state`    | Integer | 必填    | 录制状态：<ul><li>`0`: 结束</li><li>`1`: 开始</li></ul>       |

**请求包体参数**


| 参数       | 类型    | 是否必填  | 描述    |
| :---------------- | :----- |:----------------|:--------------|
| `mode`            | String | 非必填           | 录制模式：<ul><li>`web`：启用[页面录制模式](/cn/Agora%20Platform/webpage_recording)。录制生成 MP4 文件。此外，录制服务会在当前 MP4 文件时长超过 2 小时或大小超过 2 GB 时创建一个新的 MP4 文件。</li><li>不填：启用[合流录制模式](/cn/Agora%20Platform/composite_recording_mode)且只录制老师的音视频。录制生成 M3U8 和 TS 文件。 <li></ul>   |
| `webRecordConfig`| Object | 非必填    | 页面录制配置。当 `mode` 设为 `web` 时，你需要通过该参数设置页面录制的详细信息，包含以下字段：<ul><li>`rootUrl`: （必填）String 类型，待录制页面的根地址。实际录制时，灵动课堂 RESTful API 会根据 `rootUrl` 自动拼接上 `roomUuid`、`roomType` 等参数，以便声网页面录制服务可以以一个“隐身用户”的身份加入指定课堂进行录制。</li><li>`publishRtmp`: （非必填）是否将页面录制的流推到 CDN：<ul><li>`true`: 推。</li><li>`false`: 不推。</li></ul></li><li>`onhold`:（非必填）Boolean 类型，可设为：<ul><li>`true`: 在启动页面录制任务后立即暂停录制。录制服务会打开并渲染待录制页面，但不生成切片文件。</li><li>`false`:（默认）启动页面录制任务并开始录制。</li></ul></li><li>`videoBitrate`:（非必填）Number 类型，输出视频的码率，单位为 kbps，范围为 [50, 8000]。针对不同的输出视频分辨率，`videoBitrate` 的默认值不同：<ul><li>输出视频分辨率大于或等于 1280 × 720：默认值为 2000。</li><li>输出视频分辨率小于 1280 × 720：默认值为 1500。</li></ul></li><li>`videoFps`:（非必填）Number 类型，输出视频的帧率，单位为 fps，范围为 [5, 60]，默认值为 15。</li><li>`audioProfile`: Number 类型，设置输出音频的采样率、码率、编码模式和声道数。<ul><li>0：（默认）48 kHz 采样率，音乐编码，单声道，编码码率约 48 Kbps</li><li>1：48 kHz 采样率，音乐编码，单声道，编码码率约 128 Kbps</li><li>2：48 kHz 采样率，音乐编码，双声道，编码码率约 192 Kbps</li></ul></li><li>`videoWidth`: Number 类型，设置输出视频的宽度，单位为 pixel，范围为 [480, 1920]。默认为 1280。`videoWidth` 和 `videoHeight` 的乘积需小于等于 1920 x 1080。</li><li>`videoHeight`: Number 类型，设置输出视频的高度，单位为 pixel，范围为 [480, 1920]。默认为 720。`videoWidth` 和 `videoHeight` 的乘积需小于等于 1920 × 1080。</li><li>`maxRecordingHour`: Number 类型，设置最长录制时间，单位为小时，范围为 [1,720]。如果你设置了课堂持续时长和拖堂时长，当开启录制时，会按照二者之和向上取整设置最长录制时间 `maxRecordingHour` 参数。例如，课堂持续时长是 1800 秒，拖堂时长是 600 秒，则最长录制时间为二者之和约 0.66 小时（2400 秒）向上取整的值 1 小时。如果不设置课堂持续时长，则最长录制时间默认为 2 小时。当录制时长超过 `maxRecordingHour`，录制会自动停止。</li></ul> |
| `retryTimeout`    | Number | 非必填      | 重试超时时间，单位为秒。灵动课堂RESTful API最多重试两次。设置 `retryTimeout` 参数后，声网建议你参考[课堂录制最佳实践](/cn/agora-class/agora_class_record?platform=RESTful#启动课堂录制)进行操作。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |

#### 请求示例

```json
curl -X PUT 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/records/states/1' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}' \
--data-raw '{
    "mode": "web",
    "webRecordConfig": {
        "url": "https://webdemo.agora.io/xxxxx/?userUuid={recorder_id}&roomUuid={room_id_to_be_recorded}&roleType=0&roomType=4&pretest=false&rtmToken={recorder_token}&language=en&appId={your_app_id}",
        "rootUrl": "https://xxx.yyy.zzz",
        "publishRtmp": "true"
    },
    "retryTimeout": 60
}'
```

#### 响应参数

| 参数   | 类型    | 描述        |
| :----- | :------ |:--------------------------------------------------|
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |
| `data` | Object  | 返回数据，为[公共响应参数](#公共响应参数)。包含以下数据：<ul><li>`recordId`: String 型，一次录制行为的唯一标识符。调用设置录制状态 API 开始录制到结束录制视为一次录制行为。</li><li>`sid`: String 型，声网云端录制服务的 `sid`。</li> <li>`resourceId`: String 型，声网云端录制服务的 `resourceId`。</li> <li>`state`: Integer 型，录制状态。<ul><li>`0`: 结束</li><li>`1`: 开始</li></ul></li> <li>`startTime`: Integer 型，录制开始时间戳，单位为毫秒。</li> <li>`streamingUrl`: Object 型，CDN 拉流地址，若请求时开启了 `publishRtmp=true` 会返回该对象。学生可以通过该地址观看教学。 <ul><li>`rtmp`: String 型，RTMP 协议拉流地址 </li><li>`flv`: String 型，FLV 协议拉流地址 </li><li>`hls`: String 型，HLS 协议拉流地址 </li></ul></li> |

#### 响应示例

```json
"status": 200,
"body":
{
    "code": 0,
    "ts": 1610450153520,
    "streamingUrl": {
            "rtmp": "",
            "flv": "",
            "hls": ""
        }
}
```

### 更新录制设置

#### 接口描述

在录制过程中随时调用此接口更新录制相关设置。每次调用此接口都会覆盖原先的设置。

<div class="alert note">由于录制启动需要一定时间，建议在开启录制至少一分钟后再调用此接口。</div>

#### 接口原型

-   方法：PATCH
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/records/states/1

#### 请求参数

**URL 参数**


| 参数       | 类型   | 是否必填                                     | 描述                                      |
| :--------- | :----- |:-----------------------------------------|:----------------------------------------|
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |

**请求包体参数**


| 参数              | 类型   | 是否必填 | 描述                                                         |
| :---------------- | :----- |:-----| :----------------------------------------------------------- |
| `webRecordConfig` | Object | 非必填  | 页面录制设置，包含 `onhold` 属性，必填，Boolean 类型，可设为：<ul><li>`true`: 在页面录制过程中暂停录制。暂停后，录制服务不再生成切片文件。</li><li>`false`: （默认）继续进行页面录制。录制暂停后，你可调用此接口并将 `onhold` 参数设为 `false` 继续页面录制。</li></ul> |

#### 请求示例

```json
curl -X PATCH 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/records/states/1' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}' \
--data-raw '{
    "webRecordConfig": {
        "onhold": false
    }
}'
```


#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |

#### 响应示例

```json
"status": 200,
"body":
{
    "code": 0,
    "ts": 1610450153520
}
```

### 查询录制列表

#### 接口描述

查询指定课堂内的录制列表。每次开启录制会生成一条记录，你可以通过查询录制列表接口的 `nextId` 参数分批拉取，每批最多拉取 100 条数据。

- 当类型为页面录制时，单次录制记录可能因为时长或文件大小拆分多个录像 URL，在 `recordDetails.url` 参数中返回。
- 当类型为单流录制时，每条流的录像会拆分成多个录像 URL，在 `recordDetails.url` 参数中返回。

#### 接口原型

-   方法：GET
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/records

#### 请求参数

**URL 参数**


| 参数       | 类型   | 是否必填                                    | 描述                                      |
| :--------- | :----- |:----------------------------------------|:----------------------------------------|
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |

**Query 参数**

| 参数     | 类型   | 是否必填 | 描述                                                         |
| :------- | :----- |:-----| :----------------------------------------------------------- |
| `nextId` | String | 非必填  |下一批数据的起始 ID。第一次查询可传 null，后续查询传入响应结果里得到的 `nextId` 的值继续查询。 |

#### 请求示例

```json
curl -X GET 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/records' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}'
```

#### 响应参数

| 参数   | 类型    | 描述                                                         |
| :----- | :------ | :----------------------------------------------------------- |
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |
| `data` | Object  | 返回数据，为[公共响应参数](#公共响应参数)。包含以下数据：<ul><li>`count`: Integer 型，本批数据条数。</li><li>`list`: 由多个 Object 组成的数组。每个 Object 包含以下字段：<ul><li>`appId`: 你的声网 App ID。 </li><li>`roomUuid`: 课堂 uuid。这是课堂的唯一标识符，也是声网 RTC SDK 和声网 RTM SDK 中使用的频道名。 </li><li>`recordId`: 一次录制行为的唯一标识符。调用设置录制状态 API 开始录制到结束录制视为一次录制行为。</li><li>`startTime`: 录制开始的 UTC 时间戳，单位为毫秒。 </li><li>`endTime`: 录制结束的 UTC 时间戳，单位为毫秒。 </li><li>`resourceId`: 声网云端录制服务的 `resourceId`。 </li><li>`sid`: 声网云端录制服务的 `sid`。 </li><li>`recordUid`: 声网云端录制服务在频道内使用的 UID。 </li><li>`boardAppId`: 声网互动白板服务的 `App Identifier` 的值。 </li><li>`boardToken`: 声网互动白板服务的 SDK Token。</li><li>`boardId`: 白板的唯一标识符。 </li><li>`type`: Integer 型，录制类型：<ul><li>`1`: 单流录制</li><li>`2`: 合流录制</li></ul></li><li>`status`: Integer 型，录制状态：<ul><li>`1`: 录制中</li><li>`2`: 录制已结束</li></ul></li><li>`url`: String 型，合流录制模式下录制文件的访问地址。 </li><li>`recordDetails`: JSONArray 类型。包含以下字段：<ul><li>`url`: String 型，网页录制模式下录制文件的访问地址。</li></ul></li><li>`nextId`: String 型，下一批数据的起始 ID。如为 null，则表示没有下一批数据。如不为 null，则可用此 `nextId` 继续查询，直到查到 null 为止。</li><li>`total`: Integer 型，数据总条数。</li><li>`unready`: Boolean 型，值为 `true` 表示录制失败。如果在开启录制时设置了 `retryTimeout` 参数，由于超时未报告 `ready` 而被自动终止的录制任务会被添加 `unready` 标记。</li></ul></li><li>`webRecordUrlQuery`: String 型，页面录制中的 query 参数。拼接 [`LaunchOption`](agora_class_api_ref_web#launchoption) 参数传入的录制页面的 `recordUrl` 的值和 `webRecordUrlQuery` 的值即可得到录制页面的 URL，可用于本地调试。<div class="alert note">本地访问录制页面时，远端开启录制的用户会被踢出，请确保录制停止后再访问录制页面。</div></li></ul> |

#### 响应示例

```json
"status": 200,
"body":
{
    "code": 0,
    "msg": "Success",
    "ts": 1610450153520,
    "data": {
      "total": 17,
      "list": [
          {
            "recordId": "xxxxxx",
            "appId": "xxxxxx",
            "roomUuid": "jason0",
            "startTime": 1602648426497,
            "endTime": 1602648430262,
            "resourceId": "xxxxxx",
            "sid": "xxxxxx",
            "recordUid": "xxxxxx",
            "boardId": "xxxxxx",
            "boardToken": "xxxxxx",
            "type": 2,
            "status": 2,
            "url": "scenario/recording/xxxxxx/xxxxxx/xxxxxx.m3u8",
            "recordDetails":[
                {
                    "url":"xxxx/xxxx.mp4"
                }
            ]
          },
          {...},
      ],
      "count": 17
    }
}
```

## Widget 相关

### 删除 Widget

#### 接口描述

删除指定 Widget。

灵动课堂会将这个变化同步到所有端，以此来实现你自己的扩展业务。

#### 接口原型

-   方法：DELETE
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/widgets/{widgetUuid}

#### 请求参数

**URL 参数**


| 参数         | 类型   |  是否必填 |  描述     |
| :----------- | :----- |:-----|:---------|
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |
| `widgetUuid` | String | 必填   | Widget uuid。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）: <>ul<li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>空格</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", " |", "~", ","</li></ul> |

**请求包体参数**


| 参数         | 类型       | 是否必填 | 描述            |
| :----------- |:---------|:-----|:--------------|
| `cause`      | Object   | 非必填  | 本次删除原因。       |

#### 请求示例

```json
curl -X DELETE 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/widgets/test_widget' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}' \
--data-raw '{
  "cause": {}
}'
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

### 设置 Widget 房间属性

设置指定 Widget 的房间属性。

你可以对 Widget 设置任意房间属性，灵动课堂会将这个属性的变更同步到所有端，以此来实现你自己的扩展业务。详见[如何设置自定义用户属性和课堂属性？](/cn/agora-class/faq/agora_class_custom_properties)。

#### 接口原型

-   方法：PUT
-   请求路径：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/widgets/{widgetUuid}

#### 请求参数

**URL 参数**


| 参数         | 类型   |  是否必填 | 描述                                                         |
| :----------- | :----- | :-----|:----------------------------------------------------------- |
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |
| `widgetUuid` | String | 必填   | Widget uuid。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>空格</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","</li></ul> |

**请求包体参数**


| 参数            | 类型    | 是否必填 | 描述                                                         |
| :-------------- | :------ |:-----| :----------------------------------------------------------- |
| `extra`         | Object  | 非必填   | Widget 属性。                                  |
| `cause`         | Object  | 非必填   | 更新原因。                                         |
| `state`         | Integer | 非必填   | Widget 的活跃状态：<ul><li>`0`：关闭</li><li>`1`：开启</li></ul>    |
| `ownerUserUuid` | String  | 非必填   | Widget 所属用户。如果填写了该参数，在 widget 索书用户离线后，widget 会被自动删除。 |

#### 请求示例


```json
curl -X PUT 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/widgets/test_widget' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}' \
--data-raw '{
  "properties": {
    "key1": "value1",
    "key2": "value2"
  },
  "cause": {}
}'
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

### 删除 Widget 房间属性

#### 接口描述

删除指定 Widget 的属性。

你可以删除任意 Widget 属性，灵动课堂会将这个属性的变更同步到所有端，以此来实现你自己的扩展业务。设置方式同课堂属性和用户属性，详见[如何设置自定义用户属性和课堂属性？](/cn/agora-class/faq/agora_class_custom_properties)


#### 接口原型

-   方法：DELETE
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/widgets/{widgetUuid}/extra

#### 请求参数


| 参数         | 类型   |  是否必填 |  描述                   |
| :----------- | :----- |:-----|:--------------------------------------------------|
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |
| `widgetUuid` | String | 必填   | Widget uuid。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）: <ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>空格</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", " |", "~", ","</li></ul> |

**请求包体参数**


| 参数         | 类型        | 是否必填 | 描述                              |
| :----------- | :---------- |:-----| :-------------------------------- |
| `properties` | String [] | 必填   | 需删除的 widget 属性数组，即 `extra` 字段的值。 |
| `cause`      | Object      | 非必填  | 删除原因。                |

#### 请求示例

```json
curl -X DELETE 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/widgets/test_widget/extra' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}' \
--data-raw '{
  "properties": ["key-path1", "key-path2"],
  "cause": {}
}'
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

### 设置 Widget 用户属性

设置指定 Widget 的用户属性。

你可以对 widget 设置用户属性，灵动课堂会将这个属性的变更同步到所有端，以此来实现你自己的扩展业务。设置方式同课堂属性和用户属性，详见[如何设置自定义用户属性和课堂属性？](/cn/agora-class/faq/agora_class_custom_properties)


#### 接口原型

-   方法：PUT
-   请求路径：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/widgets/{widgetUuid}/users/{userUuid}

#### 请求参数

**URL 参数**


| 参数         | 类型   |  是否必填 | 描述                                                         |
| :----------- | :----- | :-----|:----------------------------------------------------------- |
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |
| `widgetUuid` | String | 必填   | Widget uuid。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）: <li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>空格</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","</li> |
| `userUuid` | String | 必填   | 用户 uuid，为公共参数，详见[其他业务参数](#其他业务参数)  |

**请求包体参数**


| 参数         | 类型   | 是否必填       | 描述                               |
| :----------- | :----- |:-----------|:--------------------------------- |
| `properties` | Object | 必填         | 需设置的 Widget 用户属性。 |
| `cause`      | Object | 非必填   | 更新原因。 |

#### 请求示例

```json
curl -X PUT 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/widgets/test_widget/users/test_user' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}' \
--data-raw '{
  "properties": {
    "key1": "value1",
    "key2": "value2"
  },
  "cause": {}
}'
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

### 删除 Widget 用户属性

#### 接口描述

删除指定 Widget 的用户属性。

你可以删除 widget 的用户属性，灵动课堂会将这个属性的变更同步到所有端，以此来实现你自己的扩展业务。设置方式同课堂属性和用户属性，详见[如何设置自定义用户属性和课堂属性？](/cn/agora-class/faq/agora_class_custom_properties)


#### 接口原型

-   方法：DELETE
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/widgets/{widgetUuid}/users/{userUuid}

#### 请求参数

| 参数         | 类型   |  是否必填 | 描述                                                         |
| :----------- | :----- |:-----| :----------------------------------------------------------- |
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |
| `widgetUuid` | String | 必填   | Widget uuid。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）: <ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>空格</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","</li></ul> |
| `userUuid` | String | 必填   | 用户 uuid，为公共参数，详见[其他业务参数](#其他业务参数)  |

**请求包体参数**


| 参数         | 类型        | 是否必填       | 描述                                   |
| :----------- | :---------- |:-----------| :------------------------------------- |
| `properties` | String [] | 必填         | 需删除的 Widget 用户属性。 |
| `cause`      | Object      | 非必填   | 删除原因。 |

#### 请求示例

```json
curl -X DELETE 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/widgets/test_widget/users/test_user' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}' \
--data-raw '{
  "properties": ["key1","key2"],
  "cause": {}
}'
```


#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## 事件同步

### 查询所有课堂事件

#### 接口描述

在服务端查询指定 App ID 下所有课堂中发生的事件。

你可定时轮询该接口来监听灵动课堂中发生的事件。

<div class="alert note"><ul><li>同一个事件只会返回一次，即第二次查询时不会返回该事件。</li><li>最早可查一小时内未销毁的课堂里的事件。</li></li></div>

#### 接口原型

-   方法：GET
-   接入点：/{region}/edu/polling/apps/{appId}/v2/rooms/sequences

#### 请求参数

**URL 参数**


| 参数       | 类型     | 是否必填  | 描述                                          |
|:---------|:-------|:-------|:--------------------------------------------|
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |

#### 请求示例

```json
curl -X GET 'https://api.agora.io/{region}/edu/polling/apps/{yourAppId}/v2/rooms/sequences' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}'
```

#### 响应参数

| 参数   | 类型    | 描述                                                         |
| :----- | :------ | :----------------------------------------------------------- |
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |
| `data` | Object  | 返回数据，为[公共响应参数](#公共响应参数) 。包含以下数据：<ul><li>`roomUuid`: String 型，课堂 uuid。</li><li>`cmd`: Integer 型，事件类型。详见[事件枚举](/cn/agora-class/agora_class_restful_api_event)。</li><li>`sequence`: Integer 型，事件序号，是每个课堂内事件的唯一标识符，课堂内全局自增，用于确保事件的有序性。<li>`version`: Integer 型，版本号。</li><li>`data`: Object 型，事件的具体数据，不同事件类型返回不同数据。详见[事件枚举](/cn/agora-class/agora_class_restful_api_event)。</li></ul> |

#### 响应示例

```json
"status": 200,
"body":
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309,
    "data":[
        {
            "roomUuid": "xxxxxx",
            "cmd": 20,
            "sequence": 1,
            "version": 1,
            "data":{}
        }
    ]
}
```

### 查询指定类型事件

#### 接口描述

查询指定课堂内指定类型的事件。

你可以通过 `nextId` 分批查询，每批最多查询 100 条数据。

<div class="note info"><ul><li>同一事件可重复查询。</li><li> 仅能查询未销毁课堂内的事件。默认情况下，课堂会在结束后一小时销毁。</li></li></div>

#### 接口原型

-   方法：GET
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/sequences

#### 请求参数

**URL 参数**


| 参数       | 类型   | 是否必填  | 描述                                                         |
| :--------- | :----- |:----- | :----------------------------------------------------------- |
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |

**Query 参数**

| 参数       | 类型    | 是否必填 | 描述                                                |
|:---------| :------ |:-----|:--------------------------------------------------|
| `nextId` | String   | 非必填  | 下一批数据的起始 ID。第一次查询可传 null，后续查询传入响应结果里得到的 `nextId` 的值。 |
| `cmd`    | Integer | 非必填  | 事件类型，详见[事件枚举](/cn/agora-class/agora_class_restful_api_event)。 |

#### 请求示例

```json
curl -X GET 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/sequences?cmd=20' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}'
```

#### 响应参数

| 参数   | 类型    | 描述                                                         |
| :----- | :------ | :----------------------------------------------------------- |
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |
| `data` | Object  | 返回数据，为[公共响应参数](#公共响应参数)。包含以下数据：<ul><li>`count`: Integer 型，本批数据条数。 </li><li>`list`: 由多个 Object 组成的数组。每个 Object 包含以下字段：<ul><li>`roomUuid`: String 型，课堂 uuid。</li><li>`cmd`: Integer 型，事件类型。详见[事件枚举](/cn/agora-class/agora_class_restful_api_event)。</li><li>`sequence`: Integer 型，事件序号，是每个课堂内事件的唯一标识符，课堂内全局自增，用于确保事件的有序性。</li><li>`version`: Integer 型，版本号。</li><li>`data`: Object 型，事件的具体数据，不同事件类型返回不同数据。详见[事件枚举](/cn/agora-class/agora_class_restful_api_event)。</li></ul><li>`nextId`: String 型，下一批数据的起始 ID。如为 null，则表示没有下一批数据。如不为 null，则可用此 `nextId` 继续查询，直到查到 null 为止。</li></ul> |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610433913533,
    "data": {
        "total": 1,
        "list": [
            {
                "roomUuid": "",
                "cmd": 20,
                "sequence": 1,
                "version": 1,
                "data": {}
            }
        ],
        "nextId": null,
        "count": 1
    }
}
```


### 查询指定 Widget 事件

#### 接口描述

查询指定课堂内指定 Widget 的相关事件。

你可以通过 `nextId` 分批查询，每批最多查询 100 条数据。

<div class="note info"><li>同一事件可重复查询。</li><li> 仅能查询未销毁课堂内的事件。默认情况下，课堂会在结束后一小时销毁。</li></div>

#### 接口原型

-   方法：GET
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/widgets/{widgetUuid}/sequences

#### 请求参数

**URL 参数**


| 参数       | 类型   |  是否必填 | 描述                                                         |
| :--------- | :----- | :----- | :----------------------------------------------------------- |
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |
| `widgetUuid` | String | 必填   | Widget uuid。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）: <ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>空格</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","</li></ul> |

**Query 参数**


| 参数     | 类型    |  是否必填 | 描述                                                         |
| :------- | :------ | :-----|:----------------------------------------------------------- |
| `nextId` | String  | 非必填   | 下一批数据的起始 ID。第一次查询可传 null，后续查询传入响应结果里得到的 `nextId` 的值。 |

#### 请求示例


```json
curl -X GET 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/widgets/test_widget/sequences' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}'
```

#### 响应参数

| 参数   | 类型    | 描述         |
| :----- | :------ |:------------------------------------|
| `code` | Integer | 响应状态码，详见[公共响应参数](#公共响应参数)。|
| `msg`  | String  | 接口响应文字信息，详见[公共响应参数](#公共响应参数)。                                                 |
| `ts`   | Number  | 当前服务端的 Unix 时间戳，详见[公共响应参数](#公共响应参数)。                |
| `data` | Object  | 返回数据，为[公共响应参数](#公共响应参数) 。包含以下数据：<ul><li>`count`: Integer 型，本批数据条数。 </li><li>`list`: 由多个 Object 组成的数组。每个 Object 包含以下内容：<ul><li>`roomUuid`: String 型，课堂 uuid，详见[其他业务参数](#其他业务参数)。</li><li>`cmd`: Integer 型，事件类型，此处为 `1110`。</li><li>`sequence`: Integer 型。事件序号，是每个课堂内事件的唯一标识符，课堂内全局自增，用于确保事件的有序性。</li><li>`version`: Integer 型，版本号。</li><li>`data`: Object 型，事件的具体数据，包含以下字段： <ul><li>`action`: Integer 型，属性操作类型： <ul><li>`1`: 设置属性</li><li>`2`: 删除属性</li></ul></li><li>`widgetUuid`: String 型，本次查询的 widget 的 uuid。</li><li>`changeProperties`: Object 型，本次变更的 widget 用户属性。<ul><li>`position`: Object 型，本次变更的位置。</li><li>`size`: Object 型，本次变更的大小。</li><li>`extra`: Object 型，本次变更的 widget 房间属性。</li></ul> </li></ul></li></ul><ul><li>`fromUser`: Object 型，更新属性的用户。当事件为更新 widget 用户属性事件时，该字段有值。包含以下字段：<ul><li>`userUuid`: String 型，用户 uuid。</li><li>`userName`: String 型，用户名。</li><li>`role`: Integer 型，用户角色。</li></ul></li><li>`operator`: Object 型，操作人，包含以下字段：<ul><li>`userUuid`: String 型，用户 uuid。</li><li>`userName`: String 型，用户名。</li><li>`role`: Integer 型，用户角色。</li></ul></li></ul><li>`nextId`: String 型，下一批数据的起始 ID。如为 null，则表示没有下一批数据。如不为 null，则可用此 `nextId` 继续查询，直到查到 null 为止。</li></ul> |

#### 响应示例


```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610433913533,
    "data": {
        "total": 1,
        "list": [
            {
                "roomUuid": "",
                "cmd": 1110,
                "sequence": 1,
                "version": 1,
                "data": {
                    "action": 1,
                    "widgetUuid": "test_widget",
                    "changeProperties": {
                        "extra": {},
                        "state": 1
                    }
                },
                "fromUser": {
                    "userUuid": "userUuid1",
                    "userName": "userName1",
                    "role": 1
                },
                "operator": {
                    "userUuid": "userUuid1",
                    "userName": "userName1",
                    "role": 1
                }
            }
        ],
        "nextId": null,
        "count": 1
    }
}
```


### 查询答题器事件

#### 接口原型

-   方法：GET
-   请求路径：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/widgets/popupQuiz/sequences

#### 请求参数

**URL 参数**


| 参数       | 类型   |  是否必填 | 描述                                                         |
| :--------- | :----- | :-----|:----------------------------------------------------------- |
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |

**Query 参数**

| 参数     | 类型    |  是否必填 | 描述                                                         |
| :------- | :------ |:-----| :----------------------------------------------------------- |
| `nextId` | String  | 非必填   | 下一批数据的起始 ID。第一次查询可传 null，后续查询传入响应结果里得到的 `nextId` 的值。 |
| `count`  | Integer | 非必填   | 本批数据条数，默认值为 100。                       |

#### 请求示例

```json
curl -X GET 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/widgets/popupQuiz/sequences' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}'
```


#### 响应参数

不同情况下 `data` 中返回的字段不同，具体如下：

-   老师开启答题后，答题器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                       | 类型     | 说明                                                         |
        | :----------------------------------------- | :------- | :----------------------------------------------------------- |
    | action                                     | Integer  | 操作类型                                                     |
    | widgetUuid                                 | String   | Widget ID                                                    |
    | changeProperties                           | Object   | 发生变更的属性                                               |
    | changeProperties.extra                     | Object   | 属性补充信息                                                 |
    | changeProperties.extra.correctItems        | Object[] | 正确选项                                                     |
    | changeProperties.extra.correctCount        | Integer  | 本题答对人数                                                 |
    | changeProperties.extra.answerState         | Integer  | 本次答题状态：<ul><li>`1` : 答题进行中</li><li>`0`: 答题结束</li></ul> |
    | changeProperties.extra.receiveQuestionTime | Long     | 收到题目时间                                                 |
    | changeProperties.extra.popupQuizId         | String   | 题目 ID                                                      |
    | changeProperties.extra.averageAccuracy     | Float    | 本题正确率                                                   |
    | changeProperties.extra.totalCount          | Integer  | 本题回答总人数                                               |
    | changeProperties.extra.items               | Object[] | 本题的所有选项                                               |
    | changeProperties.state                     | Integer  | 答题器状态：<ul><li>`0`: 非活跃</li><li>`1`: 活跃</li></ul>  |
    | cause                                      | Object   | 属性变更原由。                                               |
    | cause.popQuizId                            | String   | 答题器 ID。                                                  |
    | cause.action                               | Integer  | 操作类型：<ul><li>`1`: 老师开始答题。</li><li>`2`: 老师结束答题。</li><li>`3`: 学生提交答案。</li><li>`4`: 汇总信息同步。</li></ul> |
    | operator                                   | Object   | 操作人                                                       |
    | operator.userUuid                          | String   | 用户 ID                                                      |
    | operator.userName                          | String   | 用户名称                                                     |
    | operator.role                              | String   | 用户角色                                                     |

-   学生提交答案后，该学生的答题数据会发生变化，`data` 中包含以下字段：

    | 字段                            | 类型     | 说明                                                         |
        | :------------------------------ | :------- | :----------------------------------------------------------- |
    | action                          | Integer  | 操作类型                                                     |
    | widgetUuid                      | String   | Widget ID                                                    |
    | changeProperties                | Object   | 发生变更的属性                                               |
    | changeProperties.lastCommitTime | Long     | 最后一次提交时间                                             |
    | changeProperties.popupQuizId    | String   | 题目 ID                                                      |
    | changeProperties.selectedItems  | Object[] | 该学生提交的答案                                             |
    | changeProperties.isCorrect      | Boolean  | 该学生提交的答案是否正确                                     |
    | cause                           | Object   | 属性变更原由。                                               |
    | cause.popQuizId                 | String   | 答题器 ID。                                                  |
    | cause.action                    | Integer  | 操作类型：<ul><li>`1`: 老师开始答题。</li><li>`2`: 老师结束答题。</li><li>`3`: 学生提交答案。</li><li>`4`: 汇总信息同步。</li></ul> |
    | operator                        | Object   | 操作人                                                       |
    | operator.userUuid               | String   | 用户 uuid                                                    |
    | operator.userName               | String   | 用户名称                                                     |
    | operator.role                   | String   | 用户角色                                                     |
    | fromUser                        | Object   | 发起本次答题的用户                                           |
    | fromUser.userUuid               | String   | 用户 ID                                                      |
    | fromUser.userName               | String   | 用户名称                                                     |
    | fromUser.role                   | String   | 用户角色                                                     |

-   学生提交答案后，答题器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                   | 类型    | 说明                                                         |
        | :------------------------------------- | :------ | :----------------------------------------------------------- |
    | action                                 | Integer | 操作类型                                                     |
    | widgetUuid                             | String  | Widget ID                                                    |
    | changeProperties                       | Object  | 发生变更的属性                                               |
    | changeProperties.extra                 | Object  | 属性补充信息                                                 |
    | changeProperties.extra.selectedCount   | Integer | 已经答题人数                                                 |
    | changeProperties.extra.correctCount    | Integer | 本题答对人数                                                 |
    | changeProperties.extra.averageAccuracy | Float   | 本题正确率                                                   |
    | changeProperties.extra.totalCount      | Integer | 本题回答总人数                                               |
    | cause                                  | Object  | 属性变更原由。                                               |
    | cause.popQuizId                        | String  | 答题器 ID。                                                  |
    | cause.action                           | Integer | 操作类型：<ul><li>`1`: 老师开始答题。</li><li>`2`: 老师结束答题。</li><li>`3`: 学生提交答案。</li><li>`4`: 汇总信息同步。</li></ul> |
    | operator                               | Object  | 操作人                                                       |
    | operator.userUuid                      | String  | 用户 ID                                                      |
    | operator.userName                      | String  | 用户名称                                                     |
    | operator.role                          | String  | 用户角色                                                     |

-   老师结束答题后，答题器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                   | 类型    | 说明                                                         |
        | :------------------------------------- | :------ | :----------------------------------------------------------- |
    | action                                 | Integer | 操作类型                                                     |
    | widgetUuid                             | String  | Widget ID                                                    |
    | changeProperties                       | Object  | 发生变更的属性                                               |
    | changeProperties.extra                 | Object  | 属性补充信息                                                 |
    | changeProperties.extra.selectedCount   | Integer | 已经答题人数                                                 |
    | changeProperties.extra.correctCount    | Integer | 本题答对人数                                                 |
    | changeProperties.extra.answerState     | Integer | 本次答题状态：<ul><li>`1` : 答题进行中</li><li>`0`: 答题结束</li></ul> |
    | changeProperties.extra.averageAccuracy | Float   | 本题正确率                                                   |
    | changeProperties.extra.totalCount      | Integer | 本题回答总人数                                               |
    | cause                                  | Object  | 属性变更原由。                                               |
    | cause.popQuizId                        | String  | 答题器 ID。                                                  |
    | cause.action                           | Integer | 操作类型：<ul><li>`1`: 老师开始答题。</li><li>`2`: 老师结束答题。</li><li>`3`: 学生提交答案。</li><li>`4`: 汇总信息同步。</li></ul> |
    | operator                               | Object  | 操作人                                                       |
    | operator.userUuid                      | String  | 用户 uuid                                                    |
    | operator.userName                      | String  | 用户名称                                                     |
    | operator.role                          | String  | 用户角色                                                     |

#### 响应示例

-   老师开启答题后，答题器的汇总数据发生变化：

    ```json
    "action": NumberInt("1"),
    "widgetUuid": "xxxxxxxxx",
    "changeProperties": {
        "extra.correctItems": [
            "A",
            "B",
            "D"
        ],
        "extra.totalCount": NumberInt("1"),
        "extra.answerState": NumberInt("1"),
        "state": NumberInt("1"),
        "extra.popupQuizId": "ab5b183238a74d5a9c955dc87c6397e0",
        "extra.averageAccuracy": 0,
        "extra.correctCount": NumberInt("0"),
        "extra.items": [
            "A",
            "C",
            "B"
        ],
        "extra.receiveQuestionTime": NumberLong("1652413962895")
    },
    "operator": {
        "userName": "server",
        "userUuid": "server",
        "role": "server"
    }
    ```

-   学生提交答案后，该学生的答题数据发生变化：

    ```json
    "action": NumberInt("1"),
    "widgetUuid": "xxxxxxxxx",
    "changeProperties": {
        "selectedItems": [
            "A",
            "B",
            "D"
        ],
        "isCorrect": true,
        "popupQuizId": "ab5b183238a74d5a9c955dc87c6397e0",
        "lastCommitTime": NumberLong("1652413989997")
    },
    "fromUser": {
        "userName": "yerongzhe2",
        "userUuid": "yerongzhe22",
        "role": "audience"
    }
    ```

-   老师结束答题后，答题器的汇总数据发生变化：

    ```json
    "action": NumberInt("1"),
    "widgetUuid": "xxxxxxxxx",
    "changeProperties": {
        "extra.totalCount": NumberInt("1"),
        "extra.answerState": NumberInt("0"),
        "extra.selectedCount": NumberInt("1"),
        "extra.averageAccuracy": 1,
        "extra.correctCount": NumberInt("1")
    },
    "operator": {
        "userName": "server",
        "userUuid": "server",
        "role": "server"
    }
    ```

### 查询投票器事件

#### 接口原型

-   方法：GET
-   请求路径：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/widgets/poll/sequences

#### 请求参数

**URL 参数**

| 参数       | 类型   |  是否必填 | 描述                                                         |
| :--------- | :----- | :-----|:----------------------------------------------------------- |
| `region`      | String | 必填   | 服务区域，为公共参数，详见[区域](#区域)。        |
| `appId`    | String | 必填   | 声网 App ID，为公共参数，详见[其他业务参数](#其他业务参数)。 |
| `roomUuid` | String | 必填   | 课堂 uuid，为公共参数，详见[其他业务参数](#其他业务参数)。  |

**Query 参数**

| 参数     | 类型    |  是否必填 | 描述                                                         |
| :------- | :------ |:-----| :----------------------------------------------------------- |
| `nextId` | String  | 非必填   | 下一批数据的起始 ID。第一次查询可传 null，后续查询传入响应结果里得到的 `nextId`。 |
| `count`  | Integer | 非必填   | 本批数据条数，默认值为 100。                       |


#### 请求示例

```json
curl -X GET 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class/widgets/popupQuiz/sequences' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-uid: {rtmToken}'
```


#### 响应参数

不同情况下 `data` 中返回的字段不同，具体如下：

-   老师开启投票后，投票器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                          | 类型                | 说明                                                         |
    | :-------------------------------------------- | :------------------ | :----------------------------------------------------------- |
    | action                                        | Integer             | 操作类型                                                     |
    | widgetUuid                                    | String              | Widget ID                                                    |
    | changeProperties                              | Object              | 发生变更的属性                                               |
    | changeProperties.extra                        | Object              | 属性补充信息                                                 |
    | changeProperties.extra.mode                   | Integer             | 投票模式：<ul><li>`1`: 单选</li><li>`2`: 多选</li></ul>      |
    | changeProperties.extra.pollingState           | Integer             | 本次投票状态：<ul><li>`1` : 投票进行中</li><li>`0`: 投票结束</li></ul> |
    | changeProperties.extra.pollDetails            | Map<String，Object> | 投票详情，`key` 为选项索引，从 `0` 开始。                    |
    | changeProperties.extra.pollDetails.num        | Integer             | 选择该选项的人数                                             |
    | changeProperties.extra.pollDetails.percentage | Float               | 选择该选项的人数所占百分比                                   |
    | changeProperties.extra.pollId                 | String              | 本次投票 ID                                                  |
    | changeProperties.extra.pollItems              | Object[]            | 选项内容                                                     |
    | changeProperties.state                        | Integer             | 投票器状态：<ul><li>`0`: 非活跃</li><li>`1`: 活跃</li></ul>  |
    | cause                                         | Object              | 属性变更原由。                                               |
    | cause.pollId                                  | String              | 投票器 ID。                                                  |
    | cause.action                                  | Integer             | 操作类型：<ul><li>`1`: 老师开始投票。</li><li>`2`: 老师结束投票。</li><li>`3`: 学生提交投票。</li><li>`4`: 汇总信息同步。</li></ul> |
    | operator                                      | Object              | 操作人                                                       |
    | operator.userUuid                             | String              | 用户 ID                                                      |
    | operator.userName                             | String              | 用户名称                                                     |
    | operator.role                                 | String              | 用户角色                                                     |

-   学生提交选项后，该学生的投票数据会发生变化，`data` 中包含以下字段：

    | 字段                               | 类型     | 说明                                                         |
        | :--------------------------------- | :------- | :----------------------------------------------------------- |
    | action                             | Integer  | 操作类型                                                     |
    | widgetUuid                         | String   | Widget ID                                                    |
    | changeProperties                   | Object   | 发生变更的属性                                               |
    | changeProperties.extra             | Object   | 属性补充信息                                                 |
    | changeProperties.extra.pollId      | String   | 本次投票 ID                                                  |
    | changeProperties.extra.selectIndex | Object[] | 该学生选择的选项的索引                                       |
    | cause                              | Object   | 属性变更原由。                                               |
    | cause.pollId                       | String   | 投票器 ID。                                                  |
    | cause.action                       | Integer  | 操作类型：<ul><li>`1`: 老师开始投票。</li><li>`2`: 老师结束投票。</li><li>`3`: 学生提交投票。</li><li>`4`: 汇总信息同步。</li></ul> |
    | operator                           | Object   | 操作人                                                       |
    | operator.userUuid                  | String   | 用户 ID                                                      |
    | operator.userName                  | String   | 用户名称                                                     |
    | operator.role                      | String   | 用户角色                                                     |
    | fromUser                           | Object   | 发起本次投票的用户                                           |
    | fromUser.userUuid                  | String   | 用户 ID                                                      |
    | fromUser.userName                  | String   | 用户名称                                                     |
    | fromUser.role                      | String   | 用户角色                                                     |

-   学生提交选项后，投票器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                          | 类型                | 说明                                                         |
        | :-------------------------------------------- | :------------------ | :----------------------------------------------------------- |
    | action                                        | Integer             | 操作类型                                                     |
    | widgetUuid                                    | String              | Widget ID                                                    |
    | changeProperties                              | Object              | 发生变更的属性                                               |
    | changeProperties.extra                        | Object              | 属性补充信息                                                 |
    | changeProperties.extra.pollDetails            | Map<String，Object> | 投票详情，`key` 为选项索引，从 `0` 开始。                    |
    | changeProperties.extra.pollDetails.num        | Integer             | 选择该选项的人数                                             |
    | changeProperties.extra.pollDetails.percentage | Float               | 选择该选项的人数所占百分比                                   |
    | changeProperties.extra.pollId                 | String              | 本次投票 ID                                                  |
    | cause                                         | Object              | 属性变更原由。                                               |
    | cause.pollId                                  | String              | 投票器 ID。                                                  |
    | cause.action                                  | Integer             | 操作类型：<ul><li>`1`: 老师开始投票。</li><li>`2`: 老师结束投票。</li><li>`3`: 学生提交投票。</li><li>`4`: 汇总信息同步。</li></ul> |
    | operator                                      | Object              | 操作人                                                       |
    | operator.userUuid                             | String              | 用户 ID                                                      |
    | operator.userName                             | String              | 用户名称                                                     |
    | operator.role                                 | String              | 用户角色                                                     |

-   老师结束投票后，投票器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                          | 类型                | 说明                                                         |
        | :-------------------------------------------- | :------------------ | :----------------------------------------------------------- |
    | action                                        | Integer             | 操作类型                                                     |
    | widgetUuid                                    | String              | Widget ID                                                    |
    | changeProperties                              | Object              | 发生变更的属性                                               |
    | changeProperties.extra                        | Object              | 属性补充信息                                                 |
    | changeProperties.extra.pollingState           | Integer             | 本次投票状态：<ul><li>`1` : 投票进行中</li><li>`0`: 投票结束</li></ul> |
    | changeProperties.extra.pollDetails            | Map<String，Object> | 投票详情，`key` 为选项索引，从 `0` 开始。                    |
    | changeProperties.extra.pollDetails.num        | Integer             | 选择该选项的人数                                             |
    | changeProperties.extra.pollDetails.percentage | Float               | 选择该选项的人数所占百分比                                   |
    | changeProperties.extra.pollId                 | String              | 本次投票 ID                                                  |
    | cause                                         | Object              | 属性变更原由。                                               |
    | cause.pollId                                  | String              | 投票器 ID。                                                  |
    | cause.action                                  | Integer             | 操作类型：<ul><li>`1`: 老师开始投票。</li><li>`2`: 老师结束投票。</li><li>`3`: 学生提交投票。</li><li>`4`: 汇总信息同步。</li></ul> |
    | operator                                      | Object              | 操作人                                                       |
    | operator.userUuid                             | String              | 用户 ID                                                      |
    | operator.userName                             | String              | 用户名称                                                     |
    | operator.role                                 | String              | 用户角色                                                     |

#### 响应示例

-   老师开启投票后，投票器的汇总数据发生变化：

    ```json
    "action": NumberInt("1"),
    "widgetUuid": "xxxxxxxxx",
    "changeProperties": {
        "extra.pollId": "e556ce3df5cd4c23941b03bf54d29ba3",
        "extra.pollState": NumberInt("1"),
        "extra.pollItems": [
            "aaa",
            "bbb",
            "ccc",
            "ddd",
            "eee"
        ],
        "extra.mode": NumberInt("2"),
        "state": NumberInt("1"),
        "extra.pollDetails": {
            "0": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "1": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "2": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "3": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "4": {
                "num": NumberInt("0"),
                "percentage": 0
            }
        }
    },
    "operator": {
        "userName": "server",
        "userUuid": "server",
        "role": "server"
    }
    ```

-   学生提交选项后，该学生的投票数据发生变化：

    ```json
    "action": NumberInt("1"),
    "widgetUuid": "xxxxxxxxx",
    "changeProperties": {
        "pollId": "e556ce3df5cd4c23941b03bf54d29ba3",
        "selectIndex": [
            NumberInt("1"),
            NumberInt("2"),
            NumberInt("4")
        ]
    },
    "fromUser": {
        "userName": "yerongzhe2",
        "userUuid": "yerongzhe22",
        "role": "audience"
    },
    "operator": {
        "userName": "server",
        "userUuid": "server",
        "role": "server"
    }
    ```

-   学生提交选项后，投票器的汇总数据发生变化：

    ```json
    "action": NumberInt("1"),
    "widgetUuid": "xxxxxxxxx",
    "changeProperties": {
        "extra.pollId": "e556ce3df5cd4c23941b03bf54d29ba3",
        "extra.pollDetails": {
            "0": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "1": {
                "num": NumberInt("1"),
                "percentage": 1
            },
            "2": {
                "num": NumberInt("1"),
                "percentage": 1
            },
            "3": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "4": {
                "num": NumberInt("1"),
                "percentage": 1
            }
        }
    },
    "operator": {
        "userName": "server",
        "userUuid": "server",
        "role": "server"
    }
    ```

-   老师结束投票后，投票器的汇总数据会发生变化，`data` 中包含以下字段：

    ```json
    "action": NumberInt("1"),
    "widgetUuid": "xxxxxxxxx",
    "changeProperties": {
        "extra.pollId": "e556ce3df5cd4c23941b03bf54d29ba3",
        "extra.pollState": NumberInt("0"),
        "extra.pollDetails": {
            "0": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "1": {
                "num": NumberInt("1"),
                "percentage": 1
            },
            "2": {
                "num": NumberInt("1"),
                "percentage": 1
            },
            "3": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "4": {
                "num": NumberInt("1"),
                "percentage": 1
            }
        }
    },
    "operator": {
        "userName": "server",
        "userUuid": "server",
        "role": "server"
    }
    ```

## 响应状态码

| HTTP 响应状态码 | 响应状态码 | 描述                                                                                              |
|:-----------| :--------- |:------------------------------------------------------------------------------------------------|
| 200        | 0          | 请求成功。                                                                                           |
| 400        | 400        | 请求参数错误。                                                                                        |
| 401        | N/A        | 可能的原因：<ul><li>App ID 无效。</li><li>Token Authorization 中 `x-agora-uid` 和 `x-agora-token` 错误或不匹配。</li></li> |
| 403        | 30403200   | 课堂已禁言，无法发送聊天消息。                                                                                 |
| 404        | N/A        | 服务器无法找到请求的资源。                                                                                   |
| 404        | 20404100   | 课堂不存在。                                                                                          |
| 404        | 20404200   | 用户不存在。                                                                                          |
| 410        | 30410100   | 课堂已结束。                                                                                          |
| 409        | 30409410   | 录制状态冲突，录制未开始。                                                                                   |
| 409        | 30409411   | 录制状态冲突，录制未结束。                                                                                   |
| 400        | 30400412   | 参数 `rootUrl` 不能为空。                                                                                  |
| 409        | 30409100   | 课程状态冲突，课程已开始。                                                                                   |
| 409        | 30409101   | 课程状态冲突，课程已结束。                                                                                   |
| 400        | 30400100   | 租户 ID 不能为空。                                                                                       |
| 500        | 500        | 服务器内部错误，无法完成请求。                                                                                 |
| 503        | N/A        | 服务器内部错误，充当网关或代理的服务器未从远端服务器获取响应。                                                                 |

