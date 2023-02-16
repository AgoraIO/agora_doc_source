本页面提供即时通讯 IM RN SDK 的发版说明。

## 1.1.0

#### 新增特性

- 依赖的原生平台 `iOS` 和 `Android` 的 SDK 升级为 v1.1.0 版本。
- 新增实现聊天室自定义属性功能。
- 新增 `ChatManager#fetchConversationsFromServerWithPage` 方法实现从服务器分页获取会话列表。
- 新增 `ChatMessage#messagePriority` 方法实现聊天室消息优先级功能。
- 新增 `ChatManager#removeMessagesFromServerWithTimestamp` 和 `ChatManager#removeMessagesFromServerWithMsgIds` 方法实现单向删除服务端历史消息。

#### 优化

移除测试数据的敏感信息。

#### 修复

- 修复原生平台部分不安全代码。
- 修复获取会话可能失败的问题。
- 修复回调方法可能多次进入主线程导致死锁的问题。该问题只可能发生在 iOS 平台。
## v1.0.11 

v1.0.11 于 2022 年 12 月 19 日发布。

#### 修复

- 修复 Android 12 上的一些告警。
- 修复极少数场景下调用 `updateMessage` 方法导致的内存与数据库中的消息不一致的问题。       
- 修复极少数场景下的崩溃问题。

## v1.0.10

v1.0.10 于 2022 年 11 月 22 日发布。

#### 新增特性

`ChatGroupEventListener` 中新增两个事件：
- `onDetailChanged`：群组详情变更事件。
- `onStateChanged`：群组禁用状态变更事件。

#### 修复

- 修复 Android 平台进行 JSON 转换出现的超限问题。
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



