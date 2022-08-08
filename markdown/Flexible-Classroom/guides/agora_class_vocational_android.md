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
- 如`roomServiceType` 设为 `LivePremium`，将 `latencyLevel` 设为 `AgoraEduLatencyLevelUltraLow`；如`roomServiceType` 设为 `LiveStandard`，将 `latencyLevel` 设为 `AgoraEduLatencyLevelLow` 。

其他字段按需设置即可。

### 示例代码

//TODO

