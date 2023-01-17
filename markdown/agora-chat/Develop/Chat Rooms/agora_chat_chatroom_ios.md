聊天室是支持多人沟通的即时通讯系统。聊天室中的成员没有固定关系，用户离线后，超过 5 分钟会自动退出聊天室。聊天室成员在离线后，不会收到推送消息。聊天室可以应用于直播、消息广播等。

本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中创建和管理聊天室，并实现聊天室的相关功能。

聊天室消息相关内容详见 [消息管理](./agora_chat_message_overview)。

## 技术原理

即时通讯 IM iOS SDK 提供 `IAgoraChatroomManager`、`AgoraChatroomManagerDelegate` 和 `AgoraChatRoom` 类，可以实现以下功能：

- 创建、解散聊天室
- 从服务器获取聊天室列表和聊天室详情
- 监听聊天室事件

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 快速开始](./agora_chat_get_started_ios)。
- 了解即时通讯 IM 的[使用限制](./agora_chat_limitation)。
- 了解不同版本的聊天室相关数量限制，详见 [套餐包详情](./agora_chat_plan)。
- 仅超级管理员才能创建聊天室。确保你已调用[添加超级管理员的 RESTful API](./agora_chat_restful_chatroom_superadmin?platform=RESTful#添加超级管理员) 添加了应用超级管理员。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 创建聊天室

仅[应用超级管理员](./agora_chat_restful_chatroom_superadmin?platform=RESTful#添加超级管理员) 可以调用 `createChatroomWithSubject` 方法创建聊天室，设置聊天室名称、描述、最大成员数等聊天室属性。创建聊天室后，超级管理员自动成为聊天室所有者。

你也可以直接调用 RESTful API [从服务端创建聊天室](./agora_chat_restful_chatroom#创建聊天室)。

```objective-c
AgoraChatError *error = nil;
AgoraChatroom *retChatroom = [[AgoraChatClient sharedClient].roomManager createChatroomWithSubject:@"aSubject" description:@"aDescription" invitees:@[@"user1",@[user2]]message:@"aMessage" maxMembersCount:aMaxMembersCount error:&error];
```

### 解散聊天室

只有聊天室所有者才能解散聊天室。聊天室一旦解散，所有聊天室成员都会收到 `AgoraChatroomManagerDelegate#didDismissFromChatroom` 回调，并立即从聊天室中删除。

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager destroyChatroom:self.chatroom.chatroomId error:&error];
```

### 获取聊天室列表和详情

- 聊天室所有成员都可以调用 `getChatroomsFromServerWithPage` 从服务器获取聊天室列表，每次最多可获取 1,000 个。获取聊天室列表后，可使用聊天室 ID 查询指定聊天室的基本信息。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager getChatroomsFromServerWithPage:1 pageSize:50 error:&error];
```

- 聊天室所有成员均可调用 `getChatroomSpecificationFromServerWithId` 方法获取聊天室的详情，包括聊天室 ID、聊天室名称、聊天室描述、最大成员数、聊天室所有者、是否全员禁言以及聊天室角色类型。聊天室公告、管理员列表、成员列表、黑名单列表、禁言列表需单独调用接口获取。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
AgoraChatChatroom *chatroom = [[AgoraChatClient sharedClient].roomManager getChatroomSpecificationFromServerWithId:@“chatroomId” error:&error];

// 从服务器获取后聊天室详情后，聊天室成员也可以从本地数据库获取聊天室实例。
AgoraChatroom *chatRoom = [AgoraChatroom chatroomWithId:@"chatroomId"];
```

### 监听聊天室事件

SDK 中提供了聊天室事件的监听接口。你可以通过注册聊天室监听器，获取聊天室事件，并作出相应处理。如不再使用该监听器，需要移除，防止出现内存泄露。

```objective-c
// 注册聊天室监听。
[[AgoraChatClient sharedClient].roomManager addDelegate:self delegateQueue:nil];
// 移除聊天室监听。
[[AgoraChatClient sharedClient].roomManager removeDelegate:self];
```

具体事件如下：

```objective-c
// 有用户加入聊天室。聊天室的所有成员（除新成员外）会收到该事件。
- (void)userDidJoinChatroom:(AgoraChatroom *)aChatroom
                   user:(NSString *)aUsername{

}

// 有成员主动退出聊天室。聊天室的所有成员（除退出成员外）会收到该事件。
- (void)userDidLeaveChatroom:(AgoraChatroom *)aChatroom
                        user:(NSString *)aUsername {
}

// 有成员被踢出聊天室。被踢出聊天室的成员会收到该事件。
- (void)didDismissFromChatroom:(AgoraChatroom *)aChatroom
                        reason:(AgoraChatroomBeKickedReason)aReason {

  }

// 更新聊天室公告。聊天室的所有成员会收到该事件。
- (void)chatroomAnnouncementDidUpdate:(AgoraChatroom *)aChatroom
                          announcement:(NSString *_Nullable)aAnnouncement {
  
  }  

// 聊天室详情有变更。聊天室的所有成员会收到该事件。
- (void)chatroomSpecificationDidUpdate:(AgoraChatroom *)aChatroom {
  
  }

// 有成员被添加至聊天室白名单。被添加的成员收到该事件。
- (void)chatroomWhiteListDidUpdate:(AgoraChatroom *)aChatroom
              addedWhiteListMembers:(NSArray<NSString *> *)aMembers {
  
  }

// 有成员被移出白名单。被移出的成员收到该事件。
- (void)chatroomWhiteListDidUpdate:(AgoraChatroom *)aChatroom
            removedWhiteListMembers:(NSArray<NSString *> *)aMembers {
  
  }

// 聊天室一键禁言状态变化。聊天室所有成员（除操作者外）会收到该事件。
- (void)chatroomAllMemberMuteChanged:(AgoraChatroom *)aChatroom
                     isAllMemberMuted:(BOOL)aMuted {
  
  }

// 有成员被加入禁言列表。聊天室所有者、管理员和被禁言的成员会收到该事件。
- (void)chatroomMuteListDidUpdate:(AgoraChatroom *)aChatroom
                addedMutedMembers:(NSArray *)aMutes
                       muteExpire:(NSInteger)aMuteExpire {

  }

// 有成员被移出禁言列表。聊天室所有者、管理员和被解除禁言的成员会收到该事件。
- (void)chatroomMuteListDidUpdate:(AgoraChatroom *)aChatroom
              removedMutedMembers:(NSArray *)aMutes {

  }

// 聊天室成员被设为管理员。新管理员、聊天室所有者和其他管理员会收到该事件。
- (void)chatroomAdminListDidUpdate:(AgoraChatroom *)aChatroom
                        addedAdmin:(NSString *)aAdmin {

  }

// 聊天室成员被移除管理员权限。被移除管理权限的管理员、聊天室所有者和其他管理员会收到该事件。
- (void)chatroomAdminListDidUpdate:(AgoraChatroom *)aChatroom
                      removedAdmin:(NSString *)aAdmin {

  }

// 聊天室所有者变更。聊天室的所有成员会收到该事件。
- (void)chatroomOwnerDidUpdate:(AgoraChatroom *)aChatroom
                      newOwner:(NSString *)aNewOwner
                      oldOwner:(NSString *)aOldOwner {

// 聊天室自定义属性有更新。聊天室的所有成员会收到该事件。
- (void)chatroomAttributesDidUpdated:(NSString *_Nonnull)roomId attributeMap:(NSDictionary<NSString *, NSString *> *_Nullable)attributeMap from:(NSString *_Nonnull)fromId;
  }

// 有聊天室自定义属性被移除。聊天室所有成员会收到该事件。
- (void)chatroomAttributesDidRemoved:(NSString *_Nonnull)roomId attributes:(NSArray<__kindof NSString *> *_Nullable)attributes from:(NSString *_Nonnull)fromId;
```