# 消息表情回复 Reaction iOS

即时通讯 IM 提供消息表情回复（下文统称 “Reaction”）功能。表情符号被广泛用于实时聊天，因为它们允许用户以直接和生动的方式表达自己的感受。在即时通讯 IM 中，“Reation” 允许用户在一对一聊天和聊天组中使用表情符号快速对消息做出反应。在群聊中，反应也可用于投票，例如，通过计算附加到消息的不同表情符号的数量。

下图展示了 Reaction 的功能界面和使用。

![img](https://web-cdn.agora.io/docs-files/1655257598155)

本页展示了如何使用 Agora Chat SDK 在项目中实现 Reacition 功能。

## 技术原理

SDK 支持你通过调用 API 在项目中实现如下功能：

- `addReaction` 在消息上添加 Reaction；
- `removeReaction` 删除消息的 Reaction；
- `getReactionList` 获取消息的 Reaction 列表；
- `getReactionDetail` 获取 Reaction 详情；
- `AgoraChatMessage.reactionlist`：从本地数据库中的 `AgoraChatMessage` 对象中获取 Reaction 列表。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_ios?platform=iOS)。
- 了解即时通讯 IM 的 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=iOS)。

所有类型的 [套餐包](https://docs.agora.io/en/agora-chat/agora_chat_plan) 都支持 Reaciton 功能，一旦你在 [Agora 控制台](https://console.agora.io/) 中启用了聊天功能，就会默认启用该功能。

## 实现方法

### 在消息上添加 Reaction

调用 `addReaction` 在消息上添加 Reaction，在 `messageReactionDidChange` 监听事件中会收到这条消息的最新 Reaction 概览。

示例代码如下：

```objective-c
// 添加 Reaction。
[AgoraChatClient.sharedClient.chatManager addReaction:"reaction" toMessage:"messageId" completion:^(AgoraChatError * _Nullable error) {
    refreshBlock(error, changeSelectedStateHandle);
}];

// 监听 Reaction 更新。
- (void)messageReactionDidChange:(NSArray<AgoraChatMessageReactionChange *> *)changes
{

}
```

### 删除消息的 Reaction

调用 `removeReaction` 删除消息的 Reaction，在 `onReactionChange` 监听事件中会收到这条消息的最新 Reaction 概览。

示例代码如下：

```objective-c
// 删除 Reaction。
[AgoraChatClient.sharedClient.chatManager removeReaction:"reaction" fromMessage:"messageId" completion:^(AgoraChatError * _Nullable error) {
    refreshBlock(error, changeSelectedStateHandle);
}];

// 监听 Reaction 更新。
- (void)messageReactionDidChange:(NSArray<AgoraChatMessageReactionChange *> *)changes
{

}
```

### 获取消息的 Reaction 列表

调用 `getReactionList` 从服务器获取指定消息的 Reaction 概览列表，列表内容包含 Reaction 内容，用户数量，用户列表（概要数据，即前三个用户信息）。示例代码如下：

```objective-c
[AgoraChatClient.sharedClient.chatManager getReactionList:@["messageId"] groupId:@"groupId" chatType:AgoraChatTypeChat completion:^(NSDictionary<NSString *, AgoraChatMessageReaction *> * _Nonnull, AgoraChatError * _Nullable) {

}];
```

### 获取 Reaction 详情

调用 `getReactionDetail` 可以从服务器获取指定 Reaction 的详情，包括 Reaction 内容，用户数量和全部用户列表。示例代码如下：

```objective-c
[AgoraChatClient.sharedClient.chatManager getReactionDetail:@"messageId" reaction:@"reaction" cursor:nil pageSize:30 completion:^(AgoraChatMessageReaction * _Nonnull, NSString * _Nullable cursor, AgoraChatError * _Nullable) {

}];
```

## 下一步

[Chat UIKit](https://docs.agora.io/en/agora-chat/agora_chat_uikit_ios?platform=iOS) 也支持 Reaction，其中包含更广泛的表情符号。你可以使用 UIKit 在项目中实现 Reaction 功能。