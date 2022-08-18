# 管理聊天室成员

聊天室是支持多人沟通的即时通讯系统。本文介绍如何使用即时通讯 IM iOS SDK 在实时互动 app 中管理聊天室成员，并实现聊天室的相关功能。

## 技术原理

即时通讯 IM iOS SDK 提供 `IAgoraChatroomManager`、`AgoraChatroomManagerDelegate` 和 `AgoraChatRoom` 类，可以实现以下功能：

- 将成员移出聊天室
- 获取聊天室成员列表
- 管理聊天室黑名单
- 管理聊天室白名单
- 管理聊天室禁言列表
- 开启和关闭聊天室全员禁言
- 管理聊天室所有者及管理员

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_ios?platform=iOS)。
- 了解即时通讯 IM 的 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=iOS)。
- 了解不同版本的聊天室相关数量限制，详见 [套餐包详情](https://docs.agora.io/en/agora-chat/agora_chat_plan?platform=iOS)。

## 实现方法

本节介绍如何使用即时通讯 IM iOS SDK 提供的 API 实现上述功能。

### 获取聊天室成员列表

所有聊天室成员均可调用 `getChatroomMemberListFromServerWithId` 方法获取当前聊天室成员列表。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager getChatroomMemberListFromServerWithId:@"chatroomId" cursor:1 pageSize:20 error:&error];
```

### 将成员移出聊天室

仅聊天室所有者和管理员可调用 `removeMembers` 方法将指定成员移出聊天室。

被移出后，该成员收到 `didDismissFromChatroom` 回调，其他成员收到 `AgoraChatRoomChangeListener#userDidLeaveChatroom` 回调。

被移出的成员可以重新进入聊天室。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager removeMembers:@[@"userName"] fromChatroom:@"chatroomId" error:&error];
```

### 管理聊天室黑名单

#### 将成员加入聊天室黑名单

仅聊天室所有者和管理员可调用 `blockMembers` 方法将指定成员添加至黑名单。

被加入黑名单后，该成员收到 `didDismissFromChatroom` 回调，其他成员收到 `userDidLeaveChatroom` 回调。移出原因为 `AgoraChatroomBeKickedReasonBeRemoved`。

被加入黑名单后，该成员无法再收发聊天室消息并被移出聊天室，黑名单中的成员如想再次加入聊天室，聊天室所有者或管理员必须先将其移出黑名单列表。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager blockMembers:@[@"userName"] fromChatroom:@"chatroomId" error:&error];
```

#### 将成员移出聊天室黑名单

仅聊天室所有者和管理员可以调用 `unblockMembers` 方法将成员移出聊天室黑名单。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager unblockMembers:@[@"userName"] fromChatroom:@"chatroomId" error:&error];
```

#### 获取聊天室黑名单列表

仅聊天室所有者和管理员可以调用 `getChatroomBlacklistFromServerWithId` 方法获取当前聊天室黑名单。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager getChatroomBlacklistFromServerWithId:@"chatroomId" pageNumber:1 pageSize:20 error:&error];
```

### 管理聊天室白名单

#### 获取聊天室白名单列表

仅聊天室所有者和管理员可以调用 `getChatroomWhiteListFromServerWithId` 获取当前聊天室白名单成员列表。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[AgoraChatClient.sharedClient.roomManager getChatroomWhiteListFromServerWithId:@"aChatroomId" error:&error];
```

#### 将成员加入聊天室白名单

仅聊天室所有者和管理员可以调用 `addWhiteListMembers` 将成员加入聊天室白名单，被添加后，该成员和其他未操作的聊天室管理员或聊天室所有者收到 `AgorachatroomWhiteListDidUpdate#addedWhiteListMembers` 回调。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[AgoraChatClient.sharedClient.roomManager addWhiteListMembers:@[@"userId1",@"userId2"] fromChatroom:@"aChatroomId" error:&error];
```

#### 将成员移出聊天室白名单列表

仅聊天室所有者和管理员可以调用 `removeWhiteListMembers` 将成员从聊天室白名单移出，被移出后，该成员和其他未操作的聊天室管理员或聊天室所有者收到 `AgorachatroomWhiteListDidUpdate#removedWhiteListMembers` 回调。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[AgoraChatClient.sharedClient.roomManager removeWhiteListMembers:@[@"userId1",@"userId2"] fromChatroom:@"aChatroomId" error:&error];
```

#### 检查自己是否在聊天室白名单中

所有聊天室成员可以调用 `isMemberInWhiteListFromServerWithChatroomId` 方法检查自己是否在白名单中，示例代码如下：

```objective-c
AgoraChatError *error = nil;
[AgoraChatClient.sharedClient.roomManager isMemberInWhiteListFromServerWithChatroomId:@"aChatroomId" error:&error];
```



### 管理聊天室禁言列表

#### 添加成员至聊天室禁言列表

仅聊天室所有者和管理员可以调用 `muteMembers` 方法将指定成员添加至聊天室禁言列表。被禁言后，操作者外其他成员收到 `AgorachatroomMuteListDidUpdate:addedMutedMembers` 回调。

**注意**：
聊天室所有者可禁言聊天室所有成员，聊天室管理员可禁言聊天室普通成员。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager muteMembers:@[@"userName"] muteMilliseconds:-1 fromChatroom:@"chatroomId" error:&error];
```

#### 将成员移出聊天室禁言列表

仅聊天室所有者和管理员可以调用 `unmuteMembers` 方法将成员移出聊天室禁言列表。被解除禁言后，其他成员收到 `AgorachatroomMuteListDidUpdate: removedMutedMembers` 回调。

**注意**
聊天室所有者可对聊天室所有成员解除禁言，聊天室管理员可对聊天室普通成员解除禁言。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager unmuteMembers:@[@"userName"] fromChatroom:@"chatroomId" error:&error];
```

#### 获取聊天室禁言列表

仅聊天室所有者和管理员可以调用 `getChatroomMuteListFromServerWithId` 获取聊天室禁言列表。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager getChatroomMuteListFromServerWithId:@"chatroomId" pageNumber:1 pageSize:20 error:&error];
```

### 开启和关闭聊天室全员禁言

为了快捷管理聊天室发言，聊天室所有者和管理员可以开启和关闭聊天室全员禁言。全员禁言和单独的成员禁言不冲突，设置或者解除全员禁言，原禁言列表并不会变化。

#### 开启聊天室全员禁言

仅聊天室所有者和管理员可以调用 `muteAllMembersFromChatroom` 方法开启全员禁言。全员禁言开启后，除了在白名单中的成员，其他成员不能发言。调用成功后，聊天室成员会收到 `AgorachatroomMuteListDidUpdate: addedMutedMembers: muteExpire` 回调。

示例代码如下：

```objective-c
ChatClient.getInstance().chatroomManager().muteAllMembers(chatRoomId, new ValueCallBack<ChatRoom>() {
AgoraChatError *error = nil;
[AgoraChatClient.sharedClient.roomManager muteAllMembersFromChatroom:@"chatRoomId" error:&error];
```

#### 关闭聊天室全员禁言

仅聊天室所有者和管理员可以调用 `unmuteAllMembersFromChatroom` 方法取消全员禁言。调用成功后，聊天室成员会收到 `AgorachatroomMuteListDidUpdate: addedMutedMembers: muteExpire` 回调。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[AgoraChatClient.sharedClient.roomManager unmuteAllMembersFromChatroom:@"chatRoomId" error:&error];
```

### 管理聊天室所有者和管理员

#### 变更聊天室所有者

仅聊天室所有者可以调用 `updateChatroomOwner` 方法将权限移交给聊天室中指定成员。成功移交后，原聊天室所有者变为聊天室成员，新的聊天室所有者和聊天室管理员收到 `chatroomOwnerDidUpdate: newOwner: oldOwner` 回调。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager updateChatroomOwner:@"chatroomId" newOwner:@"textString" error:&error];
```

#### 添加聊天室管理员

仅聊天室所有者可以调用 `addAdmin` 方法添加聊天室管理员。成功添加后，新管理员及其他管理员收到 `chatroomAdminListDidUpdate: addedAdmin` 回调。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager addAdmin:@"userName" toChatroom:@"chatroomId" error:&error];
```

#### 移除聊天室管理员

仅聊天室所有者可以调用 `removeChatRoomAdmin` 方法移除聊天室管理员。成功移除后，被移除的管理员及其他管理员收到 `chatroomAdminListDidUpdate: removedAdmin` 回调。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager removeAdmin:@"userName" fromChatroom:@"chatroomId" error:&error];
```

### 监听聊天室事件

有关详细信息，请参阅 [监听聊天室事件](https://docs.agora.io/en/agora-chat/agora_chat_chatroom_ios?platform=iOS#listen-for-chat-room-events)。