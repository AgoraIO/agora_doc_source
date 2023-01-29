即时通讯 IM SDK 提供用户关系管理功能，包括好友列表管理和黑名单管理：

- 好友列表管理：查询好友列表、申请添加好友、同意好友请求、拒绝好友请求和删除好友等操作。
- 黑名单管理：查询黑名单列表、添加用户至黑名单以及将用户移出黑名单等操作。

## 技术原理

即时通讯 IM iOS SDK 可以实现好友的添加移除，黑名单的添加移除等功能，主要调用方法如下：

- `addContact` 申请添加好友。
- `deleteContact` 删除好友。
- `getContactsFromServerWithCompletion` 从服务器获取好友列表。
- `addUserToBlackList` 添加黑名单。
- `removeUserFromBlackList` 删除黑名单。
- `getBlackListFromServerWithCompletion` 从服务器获取黑名单列表。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 快速开始](./agora_chat_get_started_ios)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation)。

## 实现方法

本节介绍如何利用即时通讯 IM SDK 提供的方法管理联系人。

### 管理联系人列表

本节介绍如何发送好友请求、处理好友请求、监听联系人事件等。

#### 发送好友请求

调用 `addContact` 方法添加指定用户为联系人：

```objective-c
[[AgoraChatClient sharedClient].contactManager addContact:@"aUsername" message:@"Message" completion:^(NSString *aUsername, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"Adding the contact succeeds %@",aUsername);
    } else {
        NSLog(@"Adding the contact fails %@", aError.errorDescription);
    }
}];
```

#### 监听与好友请求相关的回调

添加 `ContactListener` 实现以下回调事件。当用户收到好友请求时，可以接受或拒绝邀请。服务器不会重复下发与好友请求相关的事件，建议退出应用时保存相关的请求数据。

```objectivec
// 注册好友回调。
[[AgoraChatClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
// 移除好友回调。
[[AgoraChatClient sharedClient].contactManager removeDelegate:self];

// 好友请求已收到。
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername
                                message:(NSString *)aMessage
{ }
```

#### 接受或拒绝好友请求

用户收到 `friendRequestDidReceiveFromUser` 回调后，调用 `approveFriendRequestFromUser` 或 `declineFriendRequestFromUser` 方法接受或拒绝好友请求。

```objective-c
// 同意好友请求。
[[AgoraChatClient sharedClient].contactManager approveFriendRequestFromUser:@"aUsername" completion:^(NSString *aUsername, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"Approving the contact invitation succeeds");
    } else {
        NSLog(@"Approving the contact invitation fails because of--- %@", aError.errorDescription);
    }
}];

// 拒绝好友请求。
[[AgoraChatClient sharedClient].contactManager declineFriendRequestFromUser:@"aUsername" completion:^(NSString *aUsername, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"Declining the contact invitation succeeds.");
    } else {
        NSLog(@"Declining the contact invitation fails because of %@", aError.errorDescription);
    }
}];
```

当你同意或者拒绝后，对方会通过好友事件回调，收到 `friendRequestDidApprove` 或者 `friendRequestDidDecline`。

示例代码如下：

```objective-c
// 对方同意了好友请求。
- (void)friendRequestDidApproveByUser:(NSString *)aUsername
{ }

// 对方拒绝了好友请求。
- (void)friendRequestDidDeclineByUser:(NSString *)aUsername
{ }
```

### 删除联系人

调用 `deleteContact` 删除指定联系人。

删除联系人时会同时删除对方联系人列表中的该用户，建议执行双重确认，以免发生误删操作。删除操作不需要对方同意或者拒绝。

示例代码如下：

```objective-c
// 删除好友。
[[AgoraChatClient sharedClient].contactManager deleteContact:@"aUsername" isDeleteConversation:aIsDeleteConversation completion:^(NSString *aUsername, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"Removing the contact succeeds");
    } else {
        NSLog(@"Removing the contact fails %@", aError.errorDescription);
    }
}];
```

一方删除联系人，双方都会收到 `friendshipDidRemoveByUser` 回调，示例代码如下：

```objective-c
// 联系人已被删除。
- (void)friendshipDidRemoveByUser:(NSString *)aUsername
{ }
```

### 获取好友列表

要获取联系人列表，可以调用 `getContactsFromServerWithCompletion` 方法从服务器获取。之后，还可以调用 `getContacts` 方法从本地数据库中检索联系人。

<div class="alert info"> 需要从服务器获取好友列表之后，才能从本地数据库获取到好友列表。<div>

示例代码如下：

```objective-c
// 从服务器获取好友列表。
[[AgoraChatClient sharedClient].contactManager getContactsFromServerWithCompletion:^(NSArray *aList, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"Retrieving the contact list succeeds %@",aList);
    } else {
        NSLog(@"Retrieving the contact list fails because of %@", aError.errorDescription);
    }
}];
// 从本地数据库获取好友列表。
NSArray *userlist = [[AgoraChatClient sharedClient].contactManager getContacts];
```

### 管理黑名单

#### 将用户加入黑名单

调用 `addUserToBlackList` 方法将指定用户添加到黑名单列表。你仍然可以向黑名单用户发送聊天消息，但无法接收来自他们的消息。

用户可以将任何其他聊天用户添加到他们的黑名单列表中，无论该用户是否是联系人。添加到黑名单列表的联系人保留在联系人列表中。

```objective-c
[[AgoraChatClient sharedClient].contactManager addUserToBlackList:@"aUsername" completion:^(NSString *aUsername, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"Adding the contact to the block list succeeds");
    } else {
        NSLog(@"Adding the contact to the block list fails because of %@", aError.errorDescription);
    }
}];
```

#### 将用户移出黑名单

调用 `removeUserFromBlackList` 方法将用户移出黑名单列表。

```objectivec
[[AgoraChatClient sharedClient].contactManager removeUserFromBlackList:@"aUsername" completion:^(NSString *aUsername, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"Removing the user from the block list succeeds");
    } else {
        NSLog(@"Removing the user from the block list fails because of %@", aError.errorDescription);
    }
}];
```

#### 获取黑名单列表

调用 `getBlackListFromServerWithCompletion` 从服务器获取黑名单列表。

```objective-c
[[AgoraChatClient sharedClient].contactManager getBlackListFromServerWithCompletion:^(NSArray *aList, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"Retrieving the block list from server succeeds %@",aList);
    } else {
        NSLog(@"Retrieving the block list from server fails %@", aError.errorDescription);
    }
}];
```

从服务器获取到黑名单列表后，还可以调用 `getBlackList` 从本地数据库中获取黑名单列表。

```objectivec
NSArray *blockList = [[AgoraChatClient sharedClient].contactManager getBlackList];
```