## V1.0.8

V1.0.8 于 2022 年 9 月 30 日发布。

#### 新增特性

- 新增聊天室自定义属性功能。
- 在 `ChatOptions` 类中新增  `areaCode` 参数限制连接边缘节点的范围。
- `ChatGroupOptions` 中增加 `isDisabled` 属性显示群组禁用状态，需要开发者在服务端设置。该属性在调用 `ChatGroupManager` 中的 `fetchGroupInfoFromServer` 方法获取群组详情时返回。

#### 修复

- 修复极少数场景下，从服务器获取较大数量的消息时失败的问题。
- 修复数据统计不正确的问题。
- 修复极少数场景下打印日志导致的崩溃。

## v1.0.7

v1.0.7 于 2022 年 9 月 7 日发布。

#### 兼容性变更

`unSubscribe` 方法重命名为 `unsubscribe`。

#### 新增特性

- 新增 `setConversationExtension` 方法用于设置会话扩展。
- 新增 `insertMessage` 方法插入消息。
- 新增 `deleteMessagesBeforeTimestamp` 方法删除指定时间戳之前的消息。
- 新增 `getThreadConversation` 方法获取或创建子区会话。
- `ChatConversation` 类中添加 `isChatThread` 属性确认会话是否为子区会话。
- 新增 `ChatPushManager` 类支持推送通知设置。
- 新增 `ChatPushConfig` 类支持 FCM 推送配置。
- 在 `ChatOptions` 类中新增 `pushConfig` 方法支持推送初始化设置。
- 在 `ChatClient` 类中新增 `updatePushConfig` 方法支持推送配置更新。

#### 优化

- 依赖的原生的 SDK（iOS 和 Android）升级到 v1.0.7。
- 监听方法调整为可选。
- 更新发布脚本。
- 更新 demo。

#### 问题修复

修复相关方法中的 `type` 字段的 JSON 解析错误。



