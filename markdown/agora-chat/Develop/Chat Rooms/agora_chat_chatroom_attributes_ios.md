聊天室是支持多人沟通的即时通讯系统。聊天室属性可分为聊天室名称、描述和公告等基本属性和自定义属性（key-value）。若聊天室基本属性不满足业务要求，用户可增加自定义属性并同步给所有成员。利用自定义属性可以存储直播聊天室的类型、狼人杀等游戏中的角色信息和游戏状态以及实现语聊房的麦位管理和同步等。聊天室自定义属性以键值对（key-value）形式存储，属性信息变更会实时同步给聊天室成员。

本文介绍如何管理聊天室属性信息。

## 技术原理

即时通讯 IM iOS SDK 提供 `IAgoraChatroomManager`、`AgoraChatroomManagerDelegate` 和 `AgoraChatRoom` 类用于聊天室属性管理，可以实现以下功能：

- 获取和更新聊天室基本属性
- 获取聊天室自定义属性
- 设置聊天室自定义属性
- 删除聊天室自定义属性

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 快速开始](./agora_chat_get_started_ios)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation)。
- 了解不同版本的聊天室相关数量限制，详见 [套餐包详情](./agora_chat_plan)。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 管理聊天室基本属性

#### 获取聊天室名称和描述

你可以调用 `getChatroomSpecificationFromServerWithId` 方法查看聊天室名称和描述。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
AgoraChatChatroom *chatroom = [[AgoraChatClient sharedClient].roomManager getChatroomSpecificationFromServerWithId:@“chatroomId” error:&error];
```

#### 修改聊天室名称和描述

- 仅聊天室所有者和聊天室管理员可以调用 `updateSubject` 方法设置和修改聊天室名称，聊天室其他成员会收到 `AgoraChatroomManagerDelegate#chatroomSpecificationDidUpdate` 回调。聊天室名称的长度限制为 128 个字符。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager updateSubject:textString forChatroom:self.chatroom.chatroomId error:&error];
```

- 仅聊天室所有者和聊天室管理员可以调用 `updateDescription` 方法设置和修改聊天室描述，聊天室其他成员会收到 `AgoraChatroomManagerDelegate#chatroomSpecificationDidUpdate` 回调。聊天室描述的长度限制为 512 个字符。

示例代码如下：

```objective-c
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager updateDescription:textString forChatroom:self.chatroom.chatroomId error:&error];
```

#### 获取聊天室公告

聊天室所有成员均可调用 `getChatroomAnnouncementWithId` 方法获取聊天室公告。

示例代码如下：

```objective-c
[AgoraChatClient.sharedClient.roomManager getChatroomAnnouncementWithId:@"chatRoomId" error:&error];
```
#### 更新聊天室公告

仅聊天室所有者和聊天室管理员可以调用 `updateChatroomAnnouncementWithId` 方法设置和更新聊天室公告。公告更新后，其他聊天室成员收到 `AgoraChatroomManagerDelegate#chatroomAnnouncementDidUpdate` 回调。聊天室公告的长度限制为 512 个字符。

示例代码如下：

```objective-c
AgoraChatError *error =  nil;
[[AgoraChatClient sharedClient].roomManager updateChatroomAnnouncementWithId:_chatroomId announcement:textString error:&error];
```

### 管理聊天室自定义属性（key-value）

#### 获取聊天室指定自定义属性

聊天室所有成员均可调用 `fetchChatroomAttributes` 方法获取聊天室指定自定义属性。

示例代码如下：

```objective-c
// 异步方法
[AgoraChatClient.sharedClient.roomManager fetchChatroomAttributes:self.currentConversation.conversationId keys:@[@"123"] completion:^(NSDictionary * _Nullable map, EMError * _Nullable error) {

            }];
```

#### 获取聊天室所有自定义属性

聊天室所有成员均可调用 `fetchChatroomAllAttributes` 方法获取聊天室所有自定义属性。

示例代码如下：

```objective-c
// 异步方法
[AgoraChatClient.sharedClient.roomManager fetchChatroomAllAttributes:self.currentConversation.conversationId completion:^(NSDictionary * _Nullable map, EMError * _Nullable error) {

            }];
```

#### 设置单个聊天室属性

聊天室所有成员均可调用 `setChatroomAttributes` 方法设置和更新单个聊天室自定义属性。该方法只能添加新属性字段以及更新当前用户已添加的属性字段。设置后，其他聊天室成员收到 `AgoraChatroomManagerDelegate#chatroomAttributesDidUpdated` 回调。

示例代码如下：

```objective-c
// 异步方法
[AgoraChatClient.sharedClient.roomManager setChatroomAttributes:self.currentConversation.conversationId key:@"234" value:@"123" autoDelete:YES completionBlock:^(EMError * _Nullable aError, NSDictionary<NSString *,NSString *> * _Nullable failureKeys) {

                }];
```

若要覆盖其他聊天室成员设置的自定义属性，需调用 `setChatroomAttributesForced` 方法。设置成功后，其他聊天室成员收到 `AgoraChatroomManagerDelegate#chatroomAttributesDidUpdated` 回调。

示例代码如下：

```objective-c
// 异步方法
[AgoraChatClient.sharedClient.roomManager setChatroomAttributesForced:self.currentConversation.conversationId key:@"234" value:@"123" autoDelete:YES completionBlock:^(EMError * _Nullable aError, NSDictionary<NSString *,NSString *> * _Nullable failureKeys) {

                }];
```

#### 设置多个聊天室自定义属性

聊天室所有成员均可调用 `setChatroomAttributes` 方法设置和更新多个聊天室自定义属性。该方法只能添加新属性字段以及更新当前用户已添加的属性字段。设置成功后，其他聊天室成员收到 `AgoraChatroomManagerDelegate#chatroomAttributesDidUpdated` 回调。

示例代码如下：

```objective-c
// 异步方法
[AgoraChatClient.sharedClient.roomManager setChatroomAttributes:self.currentConversation.conversationId attributes:@{@"testKey":@"123"} autoDelete:YES completionBlock:^(EMError * _Nullable aError, NSDictionary<NSString *,NSString *> * _Nullable failureKeys) {

                }];
```

若要覆盖其他聊天室成员设置的自定义属性，需调用 `setChatroomAttributesForced` 方法。设置成功后，其他聊天室成员收到 `AgoraChatroomManagerDelegate#chatroomAttributesDidUpdated` 回调。

示例代码如下：

```objective-c
// 异步方法
[AgoraChatClient.sharedClient.roomManager setChatroomAttributesForced:self.currentConversation.conversationId attributes:@{@"testKey":@"123"} autoDelete:YES completionBlock:^(EMError * _Nullable aError, NSDictionary<NSString *,NSString *> * _Nullable failureKeys) {
                }];
```

#### 删除单个聊天室自定义属性

聊天室所有成员均可调用 `removeChatroomAttributes` 方法删除单个聊天室自定义属性。该方法只能删除自己设置的自定义属性。删除后，其他聊天室成员收到 `AgoraChatroomManagerDelegate#chatroomAttributesDidRemoved` 回调。

示例代码如下：

```objective-c
// 异步方法
[AgoraChatClient.sharedClient.roomManager removeChatroomAttributes:self.currentConversation.conversationId key:@"234" autoDelete:YES completionBlock:^(EMError * _Nullable aError, NSDictionary<NSString *,NSString *> * _Nullable failureKeys) {

                }];
```

若要删除其他聊天室成员设置的自定义属性，需调用 `removeChatroomAttributesForced` 方法。删除后，聊天室其他成员收到 `AgoraChatroomManagerDelegate#chatroomAttributesDidRemoved` 回调。

示例代码如下：

```objective-c
// 异步方法
[AgoraChatClient.sharedClient.roomManager removeChatroomAttributesForced:self.currentConversation.conversationId key:@"234" autoDelete:YES completionBlock:^(EMError * _Nullable aError, NSDictionary<NSString *,NSString *> * _Nullable failureKeys) {

                }];
```

#### 删除多个聊天室自定义属性

聊天室所有成员均可调用 `removeChatroomAttributes` 方法删除多个聊天室自定义属性。该方法只能删除自己设置的自定义属性。设置成功后，其他聊天室成员收到 `AgoraChatroomManagerDelegate#chatroomAttributesDidRemoved` 回调。

示例代码如下：

```objective-c
// 异步方法
[AgoraChatClient.sharedClient.roomManager removeChatroomAttributes:self.currentConversation.conversationId attributes:@[@"testKey"] completionBlock:^(EMError * _Nullable aError, NSDictionary<NSString *,NSString *> * _Nullable failureKeys) {

                }];
```

若要删除其他聊天室成员设置的自定义属性，需调用 `removeChatroomAttributesForced` 方法。删除后，聊天室其他成员收到 `AgoraChatroomManagerDelegate#chatroomAttributesDidRemoved` 回调。

示例代码如下：

```objective-c
// 异步方法
[AgoraChatClient.sharedClient.roomManager removeChatroomAttributesForced:self.currentConversation.conversationId attributes:@[@"testKey"] completionBlock:^(EMError * _Nullable aError, NSDictionary<NSString *,NSString *> * _Nullable failureKeys) {

                }];
```

### 监听聊天室事件

详见 [监听聊天室事件](./agora_chat_chatroom_ios#监听聊天室事件)。