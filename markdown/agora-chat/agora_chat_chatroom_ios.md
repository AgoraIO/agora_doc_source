聊天室是支持多人加入的类似 Twitch 的组织。聊天室中的成员没有固定关系，用户离线后，超过 5 分钟会自动退出聊天室。聊天室成员在离线后，不会收到推送消息。聊天室可以应用于直播、消息广播等。

本文指导你如何使用 Agora Chat SDK 在实时互动 app 中创建聊天室并管理聊天室和聊天室成员。

## 技术原理

Agora Chat SDK 提供 `IAgoraChatroomManager`、`AgoraChatroomManagerDelegate` 和 `AgoraChatRoom` 类用于聊天室管理，支持你通过调用 API 在项目中实现如下功能：
- 创建、解散聊天室
- 加入、退出聊天室
- 从服务器获取聊天室
- 管理聊天室成员
- 管理聊天室属性和聊天室公告

## 前提条件

开始前，请确保你的项目满足以下条件：

- 已完成 SDK 初始化。详见[实现发送和接收消息](agora_chat_get_started_ios)。
- 了解 Agora Chat API 的接口调用频率限制。详见[限制条件](agora_chat_limitation_ios)。
- 了解聊天室数量限制。详见[套餐包详情](agora_chat_plan)。
- 只有超级管理员才有创建聊天室的权限，因此你还需要确保已调用[超级管理员 RESTful API](agora_chat_restful_chatroom_superadmin) 添加了超级管理员。

## 实现方法

本节介绍如何使用 Agora Chat SDK 提供的 API 实现上述功能。

### 创建与解散聊天室

[超级管理员](agora_chat_restful_chatroom_superadmin)可以调用 `createChatroomWithSubject` 方法创建聊天室，并设置聊天室的主题、描述、最大人数等信息。成功创建聊天室后，该超级管理员就是该聊天室的所有者。

```objective-c
// 超级管理员调用 createChatroomWithSubject 创建聊天室。成功创建聊天室后，超级管理员成为聊天室所有者
AgoraError *error = nil;
AgoraChatroom *retChatroom = [[AgoraChatClient sharedClient].roomManager createChatroomWithSubject:@"aSubject" description:@"aDescription" invitees:@[@"user1",@[user2]]message:@"aMessage" maxMembersCount:aMaxMembersCount error:&error];

// 只有聊天室所有者才能调用 destroyChatroom 解散聊天室
// 成功解散聊天室后，其他聊天室成员会收到 didDismissFromChatroom 回调，并被踢出聊天室
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager destroyChatroom:self.chatroom.chatroomId error:&error];
```

### 获取聊天室列表及信息

你可以从服务器获取指定数目的聊天室列表，并通过指定聊天室 ID 获取指定聊天室的基本信息。

示例代码如下：

```objective-c
// 聊天室成员调用 getChatroomsFromServerWithPage 从服务器获取指定数目的聊天室列表。其中 pageSize 的最大值为 1,000
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager getChatroomsFromServerWithPage:1 pageSize:50 error:&error];
														
// 聊天室成员调用 chatroomWithId 并指定聊天室 ID 开获取指定聊天室的基本信息
AgoraChatroom *chatRoom = [AgoraChatroom chatroomWithId:@"chatroomId"];
```

### 加入和退出聊天室

所以用户都可以通过调用 `joinChatroom` 加入指定聊天室。示例代码如下：

```objective-c
// 成功加入聊天室后，聊天室其他成员会收到 userDidJoinChatroom 回调
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager joinChatroom:@"aChatroomId" error:&error]; 

// 聊天室所有成员都可以调用 leaveChatroom 离开指定聊天室。成功离开后，聊天室其他成员会收到 userDidLeaveChatroom 回调
AgoraError *error = nil;
[AgoraChatClient sharedClient].roomManager leaveChatroom:@"aChatroomId" error:&error];
```

退出聊天室时，SDK 默认会删除该聊天室在本地的所有消息。如果不想删除，可以将 `AgoraOptions`  中的 `isDeleteMessagesWhenExitChatRoom` 设为 `NO`。

### 获取、修改聊天室信息

聊天室所有成员都可以调用 `fetchChatRoomFromServer` 方法获取聊天室详情，包括聊天室的主题、公告、描述、成员类型、管理员列表等。聊天室 Owner 和管理员还可以设置和更新聊天室名称。示例代码如下：

```objective-c
// 聊天室成员调用 getChatroomSpecificationFromServerWithId 获取聊天室信息
AgoraError *error = nil;
AgoraChatroom *chatroom = [[AgoraChatClient sharedClient].roomManager getChatroomSpecificationFromServerWithId:@“chatroomId” error:&error];

// 聊天室所有者和管理员调用 updateSubject 更改聊天室主题
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager updateSubject:textString forChatroom:self.chatroom.chatroomId error:&error];

// 聊天室所有者和管理员调用 updateDescription 更改聊天室描述
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager updateDescription:textString forChatroom:self.chatroom.chatroomId error:&error];
```

### 管理聊天室成员

所有聊天室成员都可以调用 `getChatroomMemberListFromServerWithId` 方法获取当前聊天室的成员列表。示例代码如下：

```objective-c
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager getChatroomMemberListFromServerWithId:@"chatroomId" cursor:1 pageSize:20 error:&error];
```

聊天室所有者和管理员可以调用 `removeMembers` 将指定用户移出聊天室。成功移除后，其他聊天室成员会收到 `didDismissFromChatroom` 回调。用户被移出聊天室后，还可以再次加入聊天室。

移除聊天室成员的示例代码如下：

```objective-c
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager removeMembers:@[@"userName"] fromChatroom:@"chatroomId" error:&error];
```

### 管理聊天室黑名单列表

聊天室所有者及管理员可以将聊天室中的指成员加入或者移出聊天室黑名单。聊天室成员被加入黑名单后将无法收发聊天室消息，且无法申请再次加入聊天室。

添加、移除、获取聊天室黑名单的示例代码如下：

```objective-c
// 聊天室所有者或管理员调用 blockMembers 将指定成员加入聊天室黑名单
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager blockMembers:@[@"userName"] fromChatroom:@"chatroomId" error:&error];

// 聊天室所有者或管理员调用 unblockMembers 将指定成员移出聊天室黑名单
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager unblockMembers:@[@"userName"] fromChatroom:@"chatroomId" error:&error];

// 聊天室所有者或管理员调用 getChatroomBlacklistFromServerWithId 获取当前的聊天室黑名单列表
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager getChatroomBlacklistFromServerWithId:@"chatroomId" pageNumber:1 pageSize:20 error:&error];
```

### 管理聊天室禁言列表

为了管理聊天室成员发言，聊天室所有者和管理员可以将指定聊天室成员加入或者移出聊天室禁言列表。聊天室成员被加入聊天室禁言列表后，将不能够发言，即使其被加入群白名单也不能发言。

添加、移除、获取聊天室禁言列表的示例代码如下：

```objective-c
// 聊天室所有者或管理员调用 muteMembers 将指定用户加入聊天室禁言列表。被禁言成员和其他未操作的聊天室所有者或管理员会收到 chatroomMuteListDidUpdate 回调
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager muteMembers:@[@"userName"] muteMilliseconds:-1 fromChatroom:@"chatroomId" error:&error];

// 聊天室所有者或管理员调用 unMuteChatRoomMembers 将指定用户加入聊天室禁言列表。被禁言成员和其他未操作的聊天室所有者或管理员会收 chatroomMuteListDidUpdate 回调
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager unmuteMembers:@[@"userName"] fromChatroom:@"chatroomId" error:&error];

// 聊天室所有者或管理员调用 getChatroomMuteListFromServerWithId 获取聊天室禁言列表
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager getChatroomMuteListFromServerWithId:@"chatroomId" pageNumber:1 pageSize:20 error:&error];
```

为方便快捷管理，Agora Chat 还支持聊天室所有者和管理员开启和关闭聊天室全员禁言。开启聊天室全员禁言后，除了在聊天室白名单中的成员，其他成员将不能发言。

开启、关闭全员禁言的示例代码如下：

```objective-c
// 聊天室所有者或管理员调用 muteAllMembersFromChatroom 开启全员禁言。成功开启后，聊天室成员会收到 chatroomMuteListDidUpdate 回调
AgoraError *error = nil;
[AgoraChatClient.sharedClient.roomManager muteAllMembersFromChatroom:@"chatRoomId" error:&error];

// 聊天室所有者或管理员调用 unmuteAllMembersFromChatroom 解除全员禁言。成功解除后，聊天室成员会收到  chatroomMuteListDidUpdate 回调
AgoraError *error = nil;
[AgoraChatClient.sharedClient.roomManager unmuteAllMembersFromChatroom:@"chatRoomId" error:&error];
```

### 管理聊天室白名单

聊天室白名单用户不受全员禁言限制。但是如果该白名单用户在聊天室禁言列表中，则该用户不能发言。

添加、移除、获取聊天室白名单的示例代码如下：

```objective-c
// 聊天室所有者或管理员调用 addWhiteListMembers 将指定成员添加到聊天室白名单中
AgoraError *error = nil;  
[AgoraChatClient.sharedClient.roomManager addWhiteListMembers:@[@"userId1",@"userId2"] fromChatroom:@"aChatroomId" error:&error];

// 聊天室所有者或管理员调用 removeWhiteListMembers 将指定成员从聊天室白名单中移除
AgoraError *error = nil;  
[AgoraChatClient.sharedClient.roomManager removeWhiteListMembers:@[@"userId1",@"userId2"] fromChatroom:@"aChatroomId" error:&error];

// 聊天室成员可以调用 isMemberInWhiteListFromServerWithChatroomId 查看自己是否在聊天室白名单中
AgoraError *error = nil;
[AgoraChatClient.sharedClient.roomManager isMemberInWhiteListFromServerWithChatroomId:@"aChatroomId" error:&error];

// 聊天室所有者或管理员调用 getChatroomWhiteListFromServerWithId 获取当前的聊天室白名单列表
AgoraError *error = nil;
[AgoraChatClient.sharedClient.roomManager getChatroomWhiteListFromServerWithId:@"aChatroomId" error:&error];
```

### 转让聊天室所有者、添加和移除聊天室管理员

聊天室所有者可以将权限移交给聊天室中指定成员。成功移交后，原聊天室所有者变为聊天室成员，新的聊天室所有者和聊天室管理员会收到 `chatroomOwnerDidUpdate` 回调。

聊天室所有者还可以添加聊天室管理员。成功添加后，新添加的聊天室管理员和其他管理员会收到 `chatroomAdminListDidUpdate` 回调。

转让聊天室所有者、添加和移除聊天室管理员的示例代码如下：

```objective-c
// 聊天室所有者调用 updateChatroomOwner 将权限移交给指定聊天室成员
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager updateChatroomOwner:@"chatroomId" newOwner:@"textString" error:&error];

// 聊天室所有者调用 addAdmin 添加聊天室管理员
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager addAdmin:@"userName" toChatroom:@"chatroomId" error:&error];

// 聊天室所有者调用 removeAdmin 移除聊天室管理员。被移除的聊天室管理员和其他管理员会收到 chatroomAdminListDidUpdate 回调
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager removeAdmin:@"userName" fromChatroom:@"chatroomId" error:&error];
```

### 管理聊天室公告

聊天室所有成员都可以获取聊天室公告；聊天室所有者和管理员可以设置和更新群公告。成功设置或更新后，聊天室成员会收到 `groupAnnouncementDidUpdate` 回调。示例代码如下：

```objective-c
// 聊天室成员调用 getChatroomAnnouncementWithId 获取聊天室公告
[AgoraChatClient.sharedClient.roomManager getChatroomAnnouncementWithId:@"chatRoomId" error:&error];

// 聊天室所有者和管理员调用 updateChatroomAnnouncementWithId 设置或更新聊天室公告
AgoraError *error =  nil;
[[AgoraChatClient sharedClient].roomManager updateChatroomAnnouncementWithId:_chatroomId announcement:textString error:&error];
```

### 监听聊天室事件

`ChatRoomManager` 中提供了聊天室事件的监听接口。你可以通过设置此监听，获取到聊天室中的事件，并作出相应的处理。如果不再使用该监听，需要移除，防止出现内存泄露。

监听聊天室事件的示例代码如下：

```objective-c
//注册聊天室回调
[[AgoraChatClient sharedClient].roomManager addDelegate:self delegateQueue:nil];

// 移除聊天室回调
[[AgoraChatClient sharedClient].roomManager removeDelegate:self];
```

具体可以添加的回调事件如下：

```objective-c
/**
 *  有用户加入聊天室
 *  @param aChatroom    加入的聊天室
 *  @param aUsername    加入者
 */
- (void)userDidJoinChatroom:(AgoraChatroom *)aChatroom
                   user:(NSString *)aUsername{

}

/**
 *  有用户离开聊天室
 *  @param aChatroom    离开的聊天室
 *  @param aUsername    离开者
 */
- (void)userDidLeaveChatroom:(AgoraChatroom *)aChatroom
                        user:(NSString *)aUsername {
}

/**
 *  被踢出聊天室
 *  @param aChatroom    被踢出的聊天室
 *  @param aReason      被踢出聊天室的原因
 */
- (void)didDismissFromChatroom:(AgoraChatroom *)aChatroom
                        reason:(AgoraChatroomBeKickedReason)aReason {
                        
  }

/**
 *  有成员被加入禁言列表
 *  @param aChatroom        聊天室
 *  @param aMutedMembers    被禁言的成员
 *  @param aMuteExpire      禁言失效时间，暂时不可用
 */
- (void)chatroomMuteListDidUpdate:(AgoraChatroom *)aChatroom
                addedMutedMembers:(NSArray *)aMutes
                       muteExpire:(NSInteger)aMuteExpire {
                        
  }

/**
 *  有成员被移出禁言列表
 *  @param aChatroom        聊天室
 *  @param aMutedMembers    移出禁言列表的成员
 */
- (void)chatroomMuteListDidUpdate:(AgoraChatroom *)aChatroom
              removedMutedMembers:(NSArray *)aMutes {
                        
  }
  
/**
 *  有成员被加入管理员列表
 *  @param aChatroom    聊天室
 *  @param aAdmin       加入管理员列表的成员
 */
- (void)chatroomAdminListDidUpdate:(AgoraChatroom *)aChatroom
                        addedAdmin:(NSString *)aAdmin {
                        
  }

/**
 *  有成员被移出管理员列表
 *  @param aChatroom    聊天室
 *  @param aAdmin       移出管理员列表的成员
 */
- (void)chatroomAdminListDidUpdate:(AgoraChatroom *)aChatroom
                      removedAdmin:(NSString *)aAdmin {
                        
  }

/**
 *  聊天室所有者有更新
 *  @param aChatroom    聊天室
 *  @param aNewOwner    新聊天室所有者
 *  @param aOldOwner    旧聊天室所有者
 */
- (void)chatroomOwnerDidUpdate:(AgoraChatroom *)aChatroom
                      newOwner:(NSString *)aNewOwner
                      oldOwner:(NSString *)aOldOwner {
                        
  }
```