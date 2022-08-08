# 职业教育大班课最佳实践

声网在职业教育大班课中定义了多种服务类型，方便你用于不同业务场景。你可以在 `vocationalLaunch` 的时候通过 `config.serviceType` 选择服务类型：

- `livePremium`
- `liveStandard`
- `CDN`
- `fusion`
- `mixStreamCDN`
- `hostingScene`

本文介绍职业教育大班课提供的各种服务类型，以及对应的实现方法。

## livePremium 和 liveStandard

livePremium 是一种与互动直播大班课逻辑一致的职业教育大班课。课堂使用 RTC 服务。频道为直播模式，延时为超低延时。

相比 livePremium，liveStandard 延时更高，其余逻辑一致。liveStandard 又称为极速直播模式。RTC 服务的延时均低于 CDN 服务的延时。

### 实现方法

客户端调用 `vocationalLaunch` 方法启动课堂时，`config` 中的字段设置如下：

- 将 `roomType` 设为 `AgoraEduRoomTypeBig`
- 根据可接受的延时高低，将 `serviceType` 设为 `livePremium` 或 `liveStandard`
- 如果 `serviceType` 设为 `livePremium`，将 `latencyLevel` 设为 `ultraLow`；如果 `serviceType` 设为 `liveStandard`，将 `latencyLevel` 设为 `low`。

其他字段按需设置即可。

## CDN 和 fusion

`CDN` 是 CDN 直播课。课堂使用 CDN 推拉流服务。老师的音视频流推到 CDN 上，学生通过拉取 CDN 流实时观看老师的音视频。

`fusion` 混合了 CDN 直播课和 RTC 互动直播大班课。课堂使用 RTC 和 CDN 推拉流服务。老师的音视频流既发送到 RTC 频道内，又推到 CDN 上。学生既可以通过拉取 CDN 流实时观看老师的音视频流，又可以通过上台与老师实时互动。CDN 直播课的延时比 RTC 直播课的延时高。

### 实现方法

1. 配置 CDN 推拉流功能，详见[配置步骤]()。
2. 客户端调用 `vocationalLaunch` 方法启动课堂时，`config` 中的字段设置如下：

    - 将 `roomType` 设为 `AgoraEduRoomTypeBig`
    - 根据学生是否需要上台，将 `serviceType` 设为 `CDN` 或 `fusion`

    其他字段按需设置即可。

设置完毕，学生端可以拉取该 CDN 流，实时观看老师的音视频。

这种场景下，你需要在学生端集成白板，在学生端将 IM 消息区域与老师的音视频和白板区域拼接起来。

## mixStreamCDN

`mixStreamCDN` 是 CDN 合流直播课。课堂使用了 CDN 推拉流服务。老师的音视频流和白板经由页面录制后实时推到 CDN 上，学生通过拉取 CDN 流实时观看老师的音视频和白板。学生无法上台互动，但可以通过 IM 消息与课堂中其他用户（如老师、助教老师、其他学生）互动。CDN 直播课的延时比 RTC 直播课的延时高。

### 实现方法

1. 配置 CDN 推拉流功能，详见[配置步骤]()。
2. 客户端调用 `vocationalLaunch` 方法启动课堂时，`config` 中的字段设置如下：

    - 将 `roomType` 设为 `AgoraEduRoomTypeBig`
    - 将 `serviceType` 设为 `mixStreamCDN`

    其他字段按需设置即可。

3. 服务端通过 RESTful API [设置录制状态]()，请求包体的字段设置如下：

    - 将 `mode` 设为 `web`
    - 将 `webRecordConfig.publishRtmp` 设为 `true`

    其他字段按需设置即可。


设置完毕，学生端可以拉取该 CDN 流，实时观看老师的音视频和白板。

这种场景下，你需要在学生端将 IM 消息区域与老师的音视频和白板的直播视频区域拼接起来。


## hostingScene

`hostingScene` 是 CDN 合流录播课。课堂使用了 CDN 推拉流服务。老师的音视频流和白板经由页面录制后推到 CDN 上，学生通过拉取 CDN 流观看老师的音视频和白板的录像。学生无法上台互动，但可以通过 IM 消息与课堂中其他用户（如老师、助教老师、其他学生）互动。

### 实现方法

1. 配置 CDN 推拉流功能，详见[配置步骤]()。
2. 客户端调用 `vocationalLaunch` 方法启动课堂时，`config` 中的字段设置如下：

    - 将 `roomType` 设为 `AgoraEduRoomTypeBig`
    - 将 `serviceType` 设为 `hostingScene`

其他字段按需设置即可。

设置完毕，学生端可以拉取该 CDN 流，观看老师的音视频和白板录像。


这种场景下，你需要通过服务器时间对齐各端的课堂时间。你还需要在学生端将 IM 消息区域与老师的音视频和白板录播视频区域拼接起来。

### 注意事项

老师的录像播放结束或课堂时间结束，都会被判断为课堂结束。
