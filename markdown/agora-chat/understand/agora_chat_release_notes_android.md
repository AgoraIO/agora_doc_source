本页面提供即时通讯 IM Android SDK 的发版说明。

## v1.1.0

v1.1.0 于 2023 年 2 月 28 日发布。

#### 新增特性

- 新增聊天室自定义属性功能实现语聊房的麦位管理和同步等功能。
- 新增 `ChatMessage#setPriority(ChatRoomMessagePriority)` 方法实现聊天室消息优先级功能，确保高优先级消息优先处理。
- 在 `ChatManager#asyncFetchConversationsFromServer` 方法中新增分页参数 `pageNum` 和 `pageSize`，支持分页获取会话列表功能。

#### 优化

提升代码安全性。

## v1.0.9

v1.0.9 于 2022 年 12 月 19 日发布。

#### 修复

 - 修复 Android 12 上的一些告警。
 - 修复极少数场景下调用 `updateMessage` 方法导致的内存与数据库消息不一致的问题。       
 - 修复极少数场景下的崩溃问题。

## v1.0.8

v1.0.8 于 2022 年 11 月 22 日发布。

#### 修复

 - 修复少数场景下，从服务器获取较大数量的消息时失败的问题。
 - 修复数据统计不正确的问题。       
 - 修复极少数场景下打印日志导致的崩溃。

## v1.0.7 

v1.0.7 于 2022 年 9 月 7 日发布。

#### 新增特性

  - `Group` 中增加 `isDisabled()` 属性显示群组禁用状态，需要开发者在服务端设置。该属性在调用 `GroupManager` 中的 `getGroupFromServer()` 方法获取群组详情时返回。
  - 发送前回调服务拒绝发送消息时，返回给发送方的错误描述中增加自定义的错误信息。
  - 在 `Error` 中新增错误码 1101（`PRESENCE_CANNOT_SUBSCRIBE_YOURSELF`），提示用户不能订阅自己的在线状态。
  - 新增 `ChatLogListener` 类，实现 SDK 运行日志回调。
  
#### 优化

  - 优化登录过程，缩短登录时间。
  - 优化遇到连接问题时更新接入点的策略，增强可用性。
  - 消息加密算法由 CBC 升级为 GCM。
  - SDK 的 HTTPS 请求支持 TLS 1.3。
  - 升级 libcipherdb 依赖的 OpenSSL 版本到 1.1.1q。
  - 优化 SDK 方法的参数显示。

#### 修复

  - 修复 `Conversation` 中的 `getAllMessage` 方法未去重的问题。
  - 修复密码登录时偶尔出现的崩溃问题。
  - 修复调用 `ChatManager` 中的 `fetchHistoryMessages()` 方法重复拉取漫游的问题。

## v1.0.6

v1.0.6 于 2022 年 7 月 22 日发布。

### 新增特性

- 支持使用 `ChatMessage` 中的 `isOnlineState` 标记消息是否为在线消息 。
- 在 `Error` 中添加错误码 509 `MESSAGE_CURRENT_LIMITING`，表示群组消息发送已超出并发限制。
- 在状态规范更新时在 `GroupChangeListener` 中添加 `onSpecificationChanged` 回调。
- 在 `PushManager` 中添加 `bindDeviceToken` 方法用于绑定设备 token。

### 优化

- 改进了子区功能相关的方法和类。与 1.0.4 相比，此版本用 `ChatThread` 替换 `ChatThreadInfo`。
- 在 `onInvitationReceived` 回调中增加了返回值 `groupName`。
- 移除了 Android 层中的 CBC 和 EBC 加密算法。
- 升级网络链接库。
- 支持以远程地址作为附件发送消息。

### 修复

- 获取到的 Reaction 对象为空。
- 运行早期 Android 版本的设备无法加载数据库。

## v1.0.4

v1.0.4 于 2022 年 5 月 17 日发布。

### 新增特性

- 支持 Reaction 功能，即用户可以将 Reaction 表情符号添加到指定的消息中。
- 支持使用 `reportMessage` 方法进行内容审核。
- 支持消息推送配置，用户可以配置各种推送设置。

### 优化

- 用于检索服务器访问点的增强型 DNS 配置。
- 改进了数据报告。
- 更改了 `libsqlcipher` 的文件名，以避免在使用官方 AAR 时发生冲突。
- 为 `ChatMessage` 中的 `ext` 属性添加了对双精度和浮点数据类型的支持。
- 将 `openssl` 更改为 `boringssl`。
- 将最低 API 级别更改为 21 (Android 5.0)。

### 修复

- 将应用上传到 Google Play 时报告由加密算法引起的问题。
- 翻译 API 未生效。

## v1.0.3.1

v1.0.3.1 于 2022 年 4 月 27 日发布。此版本修复了偶尔无法显示检索到的历史消息的问题。

## v1.0.3

v1.0.3 于 2022 年 4 月 19 日发布。

### 新增特性

支持在线状态功能，可发布和订阅用户的在线状态。

### 优化

- 缩短了发送消息的时间。
- 提高了请求成功率。
- 支持升级的 OPPO 推送（从 2.1.0 到 3.0.0）和 VIVO 推送（从 2.3.1 到 3.is 0.0.4_484）。

### 修复

修复了 PendingIntent，它在将应用程序上传到 Google Play 时会导致警告。

## v1.0.2

v1.0.2 于 2022 年 2 月 22 日发布。

### 新增特性

- 支持通过调用 `deleteConversationFromServer` 删除服务器上的对话。
- 添加错误代码 221 `USER_NOT_ON_ROSTER`，当用户向非联系人的其他用户发送消息时报告该错误代码。
- 支持使用 RESTful API 调用消息。

### 优化

减少了在网络条件差的情况下准备发送消息的时间。

### 修复

- 消息重发被连接成功事件中断。
- 内存泄漏。
- 时间计算不正确导致的崩溃。

## v1.0.1.1

v1.0.1.1 于 2021 年 12 月 30 日发布。

此版本修复了在极端条件下无法加载数据库的问题。

## v1.0.1

V1.0.1 于 2021 年 12 月 27 日发布。

### 新增特性

v1.0.1 增加了以下功能：

- 支持在创建位置消息时设置建筑物名称。
- 支持在特定时间之前删除本地消息。
- 支持在一次对话中获取消息数。

### 修复

此版本修复了以下问题：

- 一些崩溃问题。
- 数据库加密出现的问题。

### API 更改

v1.0.1 增加了以下 API：

- `createLocationSendMessage`[1/2]
- `deleteMessagesBeforeTimestamp`
- `getAllMsgCount`

## v1.0.0

v1.0.0 于 2021 年 12 月 6 日发布。

此版本存在数据库偶尔无法加载的问题。建议您尽快升级到最新版本。

### 新增特性

此版本支持通过 `isLoggedIn` 和 `isLoggedInBefore` 方法获取用户的登录状态。

### 优化

此版本进行了以下改进：

- 优化更新推送 token 的逻辑，减少服务器请求时间。
- 提高登录速度。
- 默认情况下仅使用 HTTPS 进行 REST 操作。
- 优化 token 过期逻辑。

### 修复

此版本修复了以下问题：

- 获取的历史消息不完整。
- 在某些情况下会发生崩溃。
- 显示消息的未读状态时出现问题。