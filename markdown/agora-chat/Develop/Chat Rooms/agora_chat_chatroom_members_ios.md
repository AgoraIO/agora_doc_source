聊天室是支持多人沟通的即时通讯系统。本文介绍如何使用即时通讯 IM iOS SDK 在实时互动 app 中管理聊天室成员，并实现聊天室的相关功能。

## 技术原理

即时通讯 IM iOS SDK 提供 `IAgoraChatroomManager`、`AgoraChatroomManagerDelegate` 和 `AgoraChatRoom` 类，可以实现以下功能：

- 加入、退出聊天室
- 获取聊天室成员列表
- 管理聊天室所有权及管理员
- 管理聊天室白名单
- 管理聊天室黑名单
- 管理聊天室禁言

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 快速开始](./agora_chat_get_started_ios)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation)。
- 了解不同版本的聊天室相关数量限制，详见 [套餐包详情](./agora_chat_plan)。

## 实现方法

本节介绍如何使用即时通讯 IM iOS SDK 提供的 API 实现上述功能。

### 加入聊天室

用户申请加入聊天室的步骤如下：

1. 调用 `getChatroomsFromServerWithPage` 方法从服务器获取聊天室列表，获得要加入的聊天室 ID。

2. 调用 `joinChatroom` 方法传入聊天室 ID，申请加入对应聊天室。新成员加入聊天室时，其他成员收到 `AgoraChatroomManagerDelegate#userDidJoinChatroom` 回调。

示例代码如下：

```objective-c
// 获取聊天室列表，每次最多可获取 1,000 个。
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager getChatroomsFromServerWithPage:1 pageSize:50 error:&error];

// 加入聊天室。
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager joinChatroom:@"aChatroomId" error:&error];
```

### 退出聊天室

#### 成员主动退出聊天室

所有聊天室成员都可以调用 `leaveChatroom` 方法退出指定的聊天室。聊天室成员退出聊天室后，其他成员会收到 `AgoraChatroomManagerDelegate#userDidLeaveChatroom` 回调。

与群主无法退出群组不同，聊天室所有者可以离开聊天室，如果所有者从服务器下线则 5 分钟后自动离开聊天室。如果所有者重新进入聊天室仍是该聊天室的所有者。

```objective-c
// 退出聊天室。
AgoraChatError *error = nil;
[AgoraChatClient sharedClient].roomManager leaveChatroom:@"aChatroomId" error:&error];
```

退出聊天室时，SDK 默认删除该聊天室所有本地消息。若要保留本地数据，可在 SDK 初始化时将 `isDeleteMessagesWhenExitChatRoom` 设置为 `NO`。

示例代码如下：

```objective-c
AgoraChatOptions *retOpt = [AgoraChatOptions optionsWithAppkey:@"appkey"];
retOpt.isDeleteMessagesWhenExitChatRoom = NO;
```

#### 将成员移出聊天室

仅聊天室所有者和管理员可调用 `removeMembers` 方法将指定成员移出聊天室。被移出的成员收到 `AgoraChatroomManagerDelegate#didDismissFromChatroom` 回调，其他成员收到 `AgoraChatroomManagerDelegate#userDidLeaveChatroom` 回调。被移出的成员仍可以重新进入聊天室。

将成员移出聊天室的步骤如下：

1. 调用 `getChatroomMemberListFromServerWithId` 方法获取聊天室成员列表，获得要移出的成员的用户 ID。
2. 调用 `removeMembers` 方法将指定成员移出聊天室。

示例代码如下：

```objective-c
// 获取聊天室成员列表
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager getChatroomMemberListFromServerWithId:@"chatroomId" cursor:1 pageSize:20 error:&error];
// 将成员移出聊天室
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager removeMembers:@[@"userName"] fromChatroom:@"chatroomId" error:&error];
```

### 获取聊天室成员列表

所有聊天室成员均可调用 `getChatroomMemberListFromServerWithId` 方法获取当前聊天室成员列表。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager getChatroomMemberListFromServerWithId:@"chatroomId" cursor:1 pageSize:20 error:&error];
```

### 管理聊天室所有者和管理员

#### 变更聊天室所有者

仅聊天室所有者可以调用 `updateChatroomOwner` 方法将权限移交给聊天室的指定成员。成功移交后，原聊天室所有者变为聊天室普通成员，新的聊天室所有者和聊天室管理员收到 `chatroomOwnerDidUpdate: newOwner: oldOwner` 回调。

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

### 管理聊天室白名单

即使聊天室所有者或管理员开启了全员禁言，聊天室白名单列表中的成员也可以发送聊天室消息。但是，聊天室禁言列表中的成员即使被添加到白名单列表中仍无法在聊天室中发送消息。

#### 将成员加入聊天室白名单

仅聊天室所有者和管理员可以调用 `addWhiteListMembers` 方法将成员加入聊天室白名单。被添加的成员、聊天室所有者和聊天室管理员（除操作者外）收到 `chatroomMuteListDidUpdate:addedMutedMembers` 回调。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[AgoraChatClient.sharedClient.roomManager addWhiteListMembers:@[@"userId1",@"userId2"] fromChatroom:@"aChatroomId" error:&error];
```

#### 将成员移出聊天室白名单

仅聊天室所有者和管理员可以调用 `removeWhiteListMembers` 将成员移出聊天室白名单。被移出的成员、聊天室所有者和聊天室管理员（除操作者外）收到 `chatroomMuteListDidUpdate:removedMutedMembers` 回调。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[AgoraChatClient.sharedClient.roomManager removeWhiteListMembers:@[@"userId1",@"userId2"] fromChatroom:@"aChatroomId" error:&error];
```

#### 检查当前用户是否在聊天室白名单中

所有聊天室成员可以调用 `isMemberInWhiteListFromServerWithChatroomId` 方法检查自己是否在白名单中。示例代码如下：

```objective-c
AgoraChatError *error = nil;
[AgoraChatClient.sharedClient.roomManager isMemberInWhiteListFromServerWithChatroomId:@"aChatroomId" error:&error];
```

#### 获取聊天室白名单列表

仅聊天室所有者和管理员可以调用 `getChatroomWhiteListFromServerWithId` 获取当前聊天室的白名单成员列表。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[AgoraChatClient.sharedClient.roomManager getChatroomWhiteListFromServerWithId:@"aChatroomId" error:&error];
```

### 管理聊天室黑名单

#### 将成员加入聊天室黑名单

仅聊天室所有者和管理员可调用 `blockMembers` 方法将指定成员添加至黑名单。被加入黑名单的成员收到 `AgoraChatroomManagerDelegate#didDismissFromChatroom` 回调，其他成员收到 `AgoraChatroomManagerDelegate#userDidLeaveChatroom` 回调。移出原因为 `AgoraChatroomBeKickedReasonBeRemoved`。

黑名单中的成员会被移出聊天室，无法再收发聊天室消息，只有先被移出黑名单才能重新加入聊天室。

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

仅聊天室所有者和管理员可以调用 `getChatroomBlacklistFromServerWithId` 方法获取当前聊天室黑名单列表。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager getChatroomBlacklistFromServerWithId:@"chatroomId" pageNumber:1 pageSize:20 error:&error];
```

### 管理聊天室禁言

聊天室所有者和管理员可以将指定成员添加或移出禁言列表，也可开启或关闭全员禁言。全员禁言和单独的成员禁言不冲突，开启和关闭全员禁言并不影响禁言列表。

将聊天室成员添加到禁言列表后，该成员将无法再发送聊天室消息，即使添加到聊天室白名单列表后也无法发送。

#### 将成员添加至聊天室禁言列表

仅聊天室所有者和管理员可以调用 `muteMembers` 方法将指定成员添加至聊天室禁言列表。被禁言后，其他成员（除操作者外）收到  `chatroomMuteListDidUpdate:addedMutedMembers` 回调。

聊天室所有者可禁言聊天室所有成员，聊天室管理员可禁言聊天室普通成员。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager muteMembers:@[@"userName"] muteMilliseconds:-1 fromChatroom:@"chatroomId" error:&error];
```

#### 将成员移出聊天室禁言列表

仅聊天室所有者和管理员可以调用 `unmuteMembers` 方法将成员移出聊天室禁言列表。被解除禁言后，其他成员收到 `chatroomMuteListDidUpdate:removedMutedMembers` 回调。

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

#### 开启聊天室全员禁言

仅聊天室所有者和管理员可以调用 `muteAllMembersFromChatroom` 方法开启全员禁言。全员禁言开启后，除了在白名单中的成员，其他成员不能发言。调用成功后，聊天室成员会收到 `chatroomAllMemberMuteChanged:isAllMemberMuted` 回调。

示例代码如下：

```objective-c
ChatClient.getInstance().chatroomManager().muteAllMembers(chatRoomId, new ValueCallBack<ChatRoom>() {
AgoraChatError *error = nil;
[AgoraChatClient.sharedClient.roomManager muteAllMembersFromChatroom:@"chatRoomId" error:&error];
```

#### 关闭聊天室全员禁言

仅聊天室所有者和管理员可以调用 `unmuteAllMembersFromChatroom` 方法取消全员禁言。调用成功后，聊天室成员会收到 `chatroomAllMemberMuteChanged:isAllMemberMuted` 回调。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[AgoraChatClient.sharedClient.roomManager unmuteAllMembersFromChatroom:@"chatRoomId" error:&error];
```

### 监听聊天室事件

有关详细信息，请参阅 [监听聊天室事件](./agora_chat_chatroom_ios#监听聊天室事件)。
