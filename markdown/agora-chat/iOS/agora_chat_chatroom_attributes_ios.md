# 管理聊天室属性

聊天室是支持多人沟通的即时通讯系统。本文介绍如何管理聊天室的属性信息。

## 技术原理

即时通讯 IM iOS SDK 提供了聊天室管理的 `IAgoraChatroomManager`、`AgoraChatroomManagerDelegate` 和 `AgoraChatRoom` 类，可以实现以下功能：

- 获取聊天室公告
- 更新聊天室公告
- 更新聊天室名称
- 更新聊天室描述

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_ios?platform=iOS)。
- 了解即时通讯 IM 的 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=iOS)。
- 了解不同版本的聊天室相关数量限制，详见 [套餐包详情](https://docs.agora.io/en/agora-chat/agora_chat_plan?platform=iOS)。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 获取聊天室详情

所有聊天室成员都可以检索到当前聊天室的详细信息，包括主题、公告、描述、成员类型和管理员列表。

聊天室所有者和管理员还可以设置和更新聊天室信息。

```objective-c
AgoraChatError *error = nil;
AgoraChatroom *chatroom = [[AgoraChatClient sharedClient].roomManager getChatroomSpecificationFromServerWithId:@“chatroomId” error:&error];
```

### 更新聊天室名称

仅聊天室所有者和聊天室管理员可以调用 `updateSubject` 方法设置和更新聊天室名称，聊天室名称的长度限制为 128 个字符。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager updateSubject:textString forChatroom:self.chatroom.chatroomId error:&error];
```

### 更新聊天室描述

仅聊天室所有者和聊天室管理员可以调用 `updateDescription` 方法设置和更新聊天室描述，聊天室描述的长度限制为 512 个字符。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager updateDescription:textString forChatroom:self.chatroom.chatroomId error:&error];
```

### 获取聊天室公告

聊天室所有成员均可调用 `getChatroomAnnouncementWithId` 方法获取聊天室公告。

示例代码如下：

```objective-c
[AgoraChatClient.sharedClient.roomManager getChatroomAnnouncementWithId:@"chatRoomId" error:&error];
```

### 修改聊天室公告

仅聊天室所有者和聊天室管理员可以调用 `updateChatroomAnnouncementWithId` 方法设置和更新聊天室公告，聊天室公告的长度限制为 512 个字符。公告更新后，其他聊天室成员收到 `chatroomAnnouncementDidUpdate` 回调。

示例代码如下：

```objective-c
AgoraChatError *error =  nil;
[[AgoraChatClient sharedClient].roomManager updateChatroomAnnouncementWithId:_chatroomId announcement:textString error:&error];
```

### 监听聊天室事件

有关详细信息，请参阅 [聊天室事件](https://docs.agora.io/en/agora-chat/agora_chat_chatroom_ios?platform=iOS#listen-for-chat-room-events)。