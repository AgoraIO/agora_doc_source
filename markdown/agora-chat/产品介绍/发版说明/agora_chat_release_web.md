## 1.0.1 版

该版本于 2022 年 1 月 XX 日发布。

#### 新增特性

该版本增加了以下功能：

- 支持在创建位置消息时设置建筑物名称。
- 支持在指定时间前删除本地消息。

#### 问题修复

该版本修复了以下问题：

- 收到会话时没有触发已读回执的回调 `onChannelMessage`。
- 其他已知问题。

#### API 变更

该版本新增以下 API、参数和错误码：

- `createLocationSendMessage` [1/2]
- `deleteSession`
- `LocationMsgSetParameters` 类中的 `buildingName`
- 非对方好友导致消息发送失败错误码 `221`
- 全局禁言导致消息发送失败错误码 `219`