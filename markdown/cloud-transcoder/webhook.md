## 概述

声网消息通知服务可以将**云端转码**业务中的发生的一些事件以 HTTPS 请求的方式通知到你的服务器。

![](https://web-cdn.agora.io/docs-files/1675668130158)

## 开通服务

使用声网消息通知服务前需要申请开通并进行配置，关于如何**开通服务**以及**消息通知回调的数据格式**详见[消息通知服务](https://docs.agora.io/cn/AgoraPlatform/ncs)。

## 事件

消息通知服务器可以通知云端转码业务下的四种事件：

- 创建云端转码事件
- 云端转码配置更新事件
- 云端转码状态变化事件
- 停止云端转码事件

### 事件公共字段

云端转码事件 `payload` 包含以下公共字段：

- `taskId`：String 型字段。任务 ID。它是声网服务器生成的一个 UUID（通用唯一识别码），标识一个已创建的 cloud transcoder。

- `instanceId`：String 型可选字段。调用 `Acquire` 时为本次云端转码指定的实例 ID。

- `sequence`：Number 类型，消息序列号，从 0 开始计数。消息可能乱序到达或者丢失重发，可以通过该参数标识消息。

- `sendts`：Number 类型， 事件发生的时间 （UTC 时间）。Unix 时间戳，精确到毫秒。

  - `serviceScene`：服务场景。云端转码的服务场景为 `rtsc/cloud-transcoder`。
  - `details`: JSON Object 型字段。消息内容，详见具体事件。



### 开始云端转码事件

当你调用 `Create` 成功创建一个 cloud transcoder 时，消息通知服务器会向你的服务器通知该事件。

`eventType` 为 110(`cloud_transcoder_started`)，`payload` 示例如下：

```json
{
    "taskId":"1234",
    "instanceId":"123",
    "sequence":123,
    "sendts":1656573243385,
    "serviceScene":"rtsc/cloud-transcoder",
    "details":{
        "event":"cloud_transcoder_started",
        "state":"Transcoder success",
        "createTs":1658112464000,
        "transcoder":{
            "inputs":[
                {
                    "rtcChannel":"test01",
                    "rtcUid":123,
                    "audio":true,
                    "video":false
                },
                {
                    "rtcChannel":"test01",
                    "rtcUid":456,
                    "audio":true,
                    "video":true
                }
            ],
            "outputs":[
                {
                    "rtcChannel":"test01",
                    "rtcUid":1000,
                    "audio":true,
                    "video":true
                }
            ],
            "userConfigDetail":"{XXXX}"
        }
    }
}
```

`details `包含如下字段：

-  `event`: String 型字段。回调事件类型。`cloud_transcoder_started` 表示成功创建一个 cloud transcoder。

- `state`: String 型字段，云端转码的状态。`Transcoder success 表示`成功创建一个 cloud transcoder，开始云端转码。

 - `createTs`：Number 型字段。创建 cloud transcoder 时的 Unix 时间戳（秒）。

 - `userConfigDetail`：String 类型。请求包体中的配置内容（`cloudTranscoder.config`）。

 - `transcoder`：JSON Object 型字段。Cloud transcoder 的输入和输出配置。

    - `inputs`[]：JSON Object 型字段。Cloud transcoder 的音视频输入源配置。

      - `rtcChannel`：String 型字段。音视频输入源所属的 RTC 频道名。

      - `rtcUid`：Number 型字段。音视频输入源所对应的 UID。
      - ` audio`：Bool 型字段。是否有音频输入源：
        - `true`：有音频输入源。
        - `false`：无音频输入源。
      - `video`：Bool 型字段。是否有视频输入源：
        - `true`：有视频输入源。
        - `false`：无视频输入源。
    - `outputs`[]：JSON Object 型字段。Cloud transcoder 的音视频输出配置。

      - `rtcChannel`：String 型字段。输出音视频所属的 RTC 频道名。

      - `rtcUid`：Number 型字段。输出音视频所对应的 UID。

      - `audio`：Bool 型字段。是否有音频输出：
        - `true`：有音频输出。
        - `false`：无音频输出。
      - `video`：Bool 型字段。是否有视频输出：
        - `true`：有视频输出。
        - `false`：无视频输出。

### 云端转码配置更新事件

当你调用 `Update` 成功更新一个 cloud transcoder 配置时，消息通知服务器会向你的服务器通知该事件。

`eventType` 为 113(`cloud_transcoder_updated`)。

```json
{
    "taskId": "1234",
    "instanceId": "123",
    "sequence": 123,
    "sendts": 1656573243385,
    "serviceScene": "rtsc/cloud-transcoder",
    "details": {
        "event": "cloud_transcoder_updated",
        "state": "running",
        "createTs": 1658112464000,
        "updateTs": 1658112464000,
        "transcoder": {
            "inputs": [
                {
                    "rtcChannel": "test01",
                    "rtcUid": 123,
                    "audio": true,
                    "video": false
                },
                {
                    "rtcChannel": "test01",
                    "rtcUid": 456,
                    "audio": true,
                    "video": true
                }
            ],
            "outputs": [
                {
                    "rtcChannel": "test01",
                    "rtcUid": 1000,
                    "audio": true,
                    "video": true
                }
            ],
            "userConfigDetail": "json_string"
        }
    }
}
```

`details `包含如下字段：

- `event`: String 型字段。回调事件类型。`cloud_transcoder_started` 表示成功创建一个 cloud transcoder。

- `state`: String 型字段，云端转码的状态。`running 表示 c`loud transcoder 正常运行中，正在进行云端转码。

- `createT`s：Number 型字段。创建 cloud transcoder 时的 Unix 时间戳（秒）。

- `updateTs`：Number 型字段。更新 cloud transcoder 配置时的 Unix 时间戳（秒）。

- `userConfigDetail`：String 类型。请求包体中的配置内容（`cloudTranscoder.config`）。

- `transcoder`：JSON Object 型字段。Cloud transcoder 的输入和输出配置。

  - `inputs`[]：JSON Object 型字段。Cloud transcoder 的音视频输入源配置。

    - `rtcChannel`：String 型字段。音视频输入源所属的 RTC 频道名。

    - `rtcUid`：Number 型字段。音视频输入源所对应的 UID。

    - `audio`：Bool 型字段。是否有音频输入源：

      - `true`：有音频输入源。
      - `false`：无音频输入源。

    - `video`：Bool 型字段。是否有视频输入源：

      - `true`：有视频输入源。
      - `false`：无视频输入源。

  - `outputs`[]：JSON Object 型字段。Cloud transcoder 的音视频输出配置。

    - `rtcChannel`：String 型字段。输出音视频所属的 RTC 频道名。

    - `rtcUid`：Number 型字段。输出音视频所对应的 UID。

    - `audio`：Bool 型字段。是否有音频输出：

      - `true`：有音频输出。
      - `false`：无音频输出。

    - `video`：Bool 型字段。是否有视频输出：

      - `true`：有视频输出。
      - `false`：无视频输出。

### 云端转码状态变化事件

成功创建一个 cloud transcoder 后，当 cloud transcoder 运行状态改变时，消息通知服务器会向你的服务器通知该事件。

`eventType` 为 112(`cloud_transcoder_status`)，`payload` 示例如下：

```json
{
    "taskId": "1234",
    "instanceId": "123",
    "sequence": 123,
    "sendts": 1656573243385,
    "serviceScene": "rtsc/cloud-transcoder",
    "details": {
        "event": "cloud_transcoder_status",
        "state": "running",
        "createTs": 1658112464000,
        "updateTs": 1658112464000
    }
}
```

`details `包含如下字段：

- `event`: String 型字段。回调事件类型。`cloud_transcoder_started` 表示成功创建一个 cloud transcoder。
- `state`: String 型字段，云端转码的状态。`running` 表示 cloud transcoder 正常运行中，正在进行云端转码。
- `createTs`：Number 型字段。创建 cloud transcoder 时的 Unix 时间戳（秒）。
- `updateTs`：Number 型字段。更新 cloud transcoder 配置时的 Unix 时间戳（秒）。



### 停止云端转码事件

当一个 cloud transcoder 被销毁而停止云端转码时，消息通知服务器会向你的服务器通知该事件。

`eventType` 为 111(`cloud_transcoder_stopped`)，`payload` 示例如下：

```
{
    "taskId": "1234",
    "instanceId": "123",
    "sequence": 123,
    "sendts": 1656573243385,
    "serviceScene": "rtsc/cloud-transcoder",
    "details": {
        "event": "cloud_transcoder_stopped",
        "stopReason": "Stop request",
        "createTs": 1658112464000,
        "updateTs": 1658112464000
    }
}
```

`details `包含如下字段：

- `event`: String 型字段。回调事件类型。`cloud_transcoder_started` 表示成功创建一个 cloud transcoder。
- `stopReason`: String 型字段，云端转码停止的原因。你可以根据该字段排查云端转码异常停止的原因。
- `createTs`：Number 型字段。创建 cloud transcoder 时的 Unix 时间戳（秒）。
- `updateTs`：Number 型字段。更新 cloud transcoder 配置时的 Unix 时间戳（秒）。