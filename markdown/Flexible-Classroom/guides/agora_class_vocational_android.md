# 职业教育大班课最佳实践

声网在职业教育大班课中定义了多种服务类型，方便你用于不同业务场景。你可以在 `launch` 的时候通过 `config.serviceType` 选择服务类型：

- `LivePremium`
- `LiveStandard`
- `CDN`
- `Fusion`

本文介绍职业教育大班课提供的各种服务类型，以及对应的实现方法。

## LivePremium 和 LiveStandard

LivePremium 是一种与互动直播大班课逻辑一致的职业教育大班课。课堂使用 RTC 服务。频道为直播模式，延时为超低延时。

相比 LivePremium，LiveStandard 延时更高，其余逻辑一致。LiveStandard 又称为极速直播模式。RTC 服务的延时均低于 CDN 服务的延时。

### 实现方法

客户端调用 `launch` 方法启动课堂时，`config` 中的字段设置如下：

- 将 `roomType` 设为 `AgoraEduRoomTypeBig`
- 根据可接受的延时高低，将 `roomServiceType` 设为 `LivePremium` 或 `LiveStandard`
- 如果 `roomServiceType` 设为 `LivePremium`，将 `latencyLevel` 设为 `AgoraEduLatencyLevelUltraLow`；如果 `roomServiceType` 设为 `LiveStandard`，将 `latencyLevel` 设为 `AgoraEduLatencyLevelLow` 。

其他字段按需设置即可。

## CDN 和 Fusion

`CDN` 是 CDN 直播课。课堂使用 CDN 推拉流服务。老师的音视频流推到 CDN 上，学生通过拉取 CDN 流实时观看老师的音视频。

`Fusion` 混合了 CDN 直播课和 RTC 互动直播大班课。课堂使用 RTC 和 CDN 推拉流服务。老师的音视频流既发送到 RTC 频道内，又推到 CDN 上。学生既可以通过拉取 CDN 流实时观看老师的音视频流，又可以通过上台与老师实时互动。CDN 直播课的延时比 RTC 直播课的延时高。

### 实现方法

1. 配置 CDN 推拉流功能，详见[配置步骤]()。
2. 客户端调用 `launch` 方法启动课堂时，`config` 中的字段设置如下：

    - 将 `roomType` 设为 `AgoraEduRoomTypeBig`
    - 根据学生是否需要上台，将 `serviceType` 设为 `CDN` 或 `Fusion`

    其他字段按需设置即可。

设置完毕，学生端可以拉取该 CDN 流，实时观看老师的音视频。

这种场景下，你需要在学生端集成白板，在学生端将 IM 消息区域与老师的音视频和白板区域拼接起来。

