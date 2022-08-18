# 聊天室-创建和管理聊天室以及监听器介绍

聊天室是支持多人沟通的即时通讯系统。

聊天室中的成员没有固定关系，用户离线后，超过 5 分钟会自动退出聊天室。聊天室成员在离线后，不会收到推送消息。聊天室可以应用于直播、消息广播等。

本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中创建和管理聊天室，并实现聊天室的相关功能。

消息相关内容见 [消息管理](https://docs.agora.io/en/agora-chat/agora_chat_message_overview?platform=iOS)。

## 技术原理

即时通讯 IM iOS SDK 提供 `IAgoraChatroomManager`、`AgoraChatroomManagerDelegate` 和 `AgoraChatRoom` 类，可以实现以下功能：

- 创建聊天室
- 从服务器获取聊天室列表
- 加入聊天室
- 获取聊天室详情
- 退出聊天室
- 解散聊天室
- 监听聊天室事件

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_ios?platform=iOS)。
- 了解即时通讯 IM 的 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=iOS)。
- 了解不同版本的聊天室相关数量限制，详见 [套餐包详情](https://docs.agora.io/en/agora-chat/agora_chat_plan?platform=iOS)。
- 只有应用超级管理员才有创建聊天室的权限。确保你已通过调用 [super-admin RESTful API](https://docs.agora.io/en/agora-chat/agora_chat_restful_chatroom_superadmin?platform=RESTful#adding-a-chat-room-super-admin) 添加了应用超级管理员。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 创建和解散聊天室

仅 [应用超级管理员](https://docs.agora.io/en/agora-chat/agora_chat_restful_chatroom_superadmin) 可以调用 `createChatroomWithSubject` 方法创建聊天室，并设置聊天室的主题、描述、最大成员数等聊天室属性。创建聊天室后，超级管理员自动成为聊天室所有者。

只有聊天室所有者才能解散聊天室。聊天室一旦解散，所有聊天室成员都会收到 `didDismissFromChatroom` 回调，并立即从聊天室中删除。

```objective-c
AgoraChatError *error = nil;
AgoraChatroom *retChatroom = [[AgoraChatClient sharedClient].roomManager createChatroomWithSubject:@"aSubject" description:@"aDescription" invitees:@[@"user1",@[user2]]message:@"aMessage" maxMembersCount:aMaxMembersCount error:&error];


AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager destroyChatroom:self.chatroom.chatroomId error:&error];
```

### 加入和退出聊天室

用户申请加入聊天室的步骤如下：

1. 调用 `getChatroomsFromServerWithPage` 方法从服务器获取聊天室列表，查询到想要加入的聊天室 ID。

2. 调用 `joinChatroom` 方法传入聊天室 ID，申请加入对应聊天室。新成员加入聊天室时，其他成员收到 `userDidJoinChatroom` 回调。

3. 所有聊天室成员都可以调用 `leaveChatroom` 离开指定的聊天室。聊天室成员离开聊天室后，所有其他成员都会收到 `userDidLeaveChatroom` 回调，默认删除所有本地数据。要将数据保留在本地设备上，请在 `AgoraChatOptions` 中将 `isDeleteMessagesWhenExitChatRoom` 参数设置为 `NO`。

```objective-c
// 获取公开聊天室列表，每次最多可获取 1,000 个。
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager getChatroomsFromServerWithPage:1 pageSize:50 error:&error];

// 加入聊天室。
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager joinChatroom:@"aChatroomId" error:&error];

// 退出聊天室。
AgoraChatError *error = nil;
[AgoraChatClient sharedClient].roomManager leaveChatroom:@"aChatroomId" error:&error];
```

退出聊天室时，SDK 默认删除该聊天室所有本地消息，若要保留这些消息，可在 SDK 初始化时将 `isDeleteMessagesWhenExitChatRoom` 设置为 `NO`。

```objective-c
@property (nonatomic, assign) BOOL isDeleteMessagesWhenExitChatRoom;

```

示例代码如下：

```objective-c
AgoraChatOptions *retOpt = [AgoraChatOptions optionsWithAppkey:@"appkey"];
retOpt.isDeleteMessagesWhenExitChatRoom = NO;
```

### 获取聊天室详情

聊天室所有成员均可调用 `getChatroomSpecificationFromServerWithId` 获取聊天室的详情，包括聊天室 ID、聊天室名称，聊天室描述、聊天室公告、管理员列表、最大成员数、聊天室所有者、是否全员禁言以及聊天室角色类型。成员列表、黑名单列表、禁言列表需单独调用接口获取。

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
// 注册聊天室回调。
[[AgoraChatClient sharedClient].roomManager addDelegate:self delegateQueue:nil];
// 移除聊天室回调。
[[AgoraChatClient sharedClient].roomManager removeDelegate:self];
```

具体事件如下：

```objective-c
// 有用户加入聊天室。
- (void)userDidJoinChatroom:(AgoraChatroom *)aChatroom
                   user:(NSString *)aUsername{

}

// 有成员离开聊天室。
- (void)userDidLeaveChatroom:(AgoraChatroom *)aChatroom
                        user:(NSString *)aUsername {
}

// 有成员被踢出聊天室
- (void)didDismissFromChatroom:(AgoraChatroom *)aChatroom
                        reason:(AgoraChatroomBeKickedReason)aReason {

  }

// 聊天室成员被禁言

- (void)chatroomMuteListDidUpdate:(AgoraChatroom *)aChatroom
                addedMutedMembers:(NSArray *)aMutes
                       muteExpire:(NSInteger)aMuteExpire {

  }

// 聊天室成员被解除禁言
- (void)chatroomMuteListDidUpdate:(AgoraChatroom *)aChatroom
              removedMutedMembers:(NSArray *)aMutes {

  }

// 聊天室成员被设为管理员
- (void)chatroomAdminListDidUpdate:(AgoraChatroom *)aChatroom
                        addedAdmin:(NSString *)aAdmin {

  }

// 聊天室成员被移除管理员权限
- (void)chatroomAdminListDidUpdate:(AgoraChatroom *)aChatroom
                      removedAdmin:(NSString *)aAdmin {

  }

// 聊天室所有者变更
- (void)chatroomOwnerDidUpdate:(AgoraChatroom *)aChatroom
                      newOwner:(NSString *)aNewOwner
                      oldOwner:(NSString *)aOldOwner {

  }
```