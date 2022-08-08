本文介绍如何通过 Agora 即时通讯 IM（环信） SDK 管理好友关系，包括添加、同意、拒绝、删除、查询好友，以及管理黑名单，包括添加、移出、查询黑名单。文中简称为即时通讯。

## 技术原理

Agora 即时通讯 SDK 提供 `ContactManager` 类，用于管理好友关系，包含核心方法如下：

- `addContact`：申请添加好友。
- `deleteContact`：删除好友。
- `getContactsFromServerWithCompletion`：从服务器获取好友列表。
- `addUserToBlackList`：添加黑名单。
- `removeUserFromBlackList`：删除黑名单。
- `getBlackListFromServerWithCompletion`：从服务器获取黑名单列表。

## 前提条件

开始前，请确保满足以下条件：

- 已[集成 Agora 即时通讯 SDK](./agora_chat_get_started_ios?platform=iOS)。
- 了解消息相关限制和 Agora 即时通讯 API 的调用频率限制，详见[限制条件](./agora_chat_limitation_ios?platform=iOS)。

## 实现方法

### 管理好友关系

本节展示如何在项目中管理好友关系。

#### 申请添加好友

1. 发送申请添加好友请求。

```objective-c
// 导入 IEMContactManager 类
#import <IEMContactManager.h>
// 设置待添加的好友的用户名和添加原因。
ChatClient.getInstance().contactManager().addContact(toAddUsername, reason);
```

2. 处理好友请求。

当接收方收到添加好友请求时，有以下两种处理方式：
- 同意添加对方为好友。
```objective-c
[[EMClient sharedClient].contactManager approveFriendRequestFromUser:@"aUsername" completion:^(NSString *aUsername, EMError *aError) {
    if (!aError) {
        NSLog(@"同意加好友申请成功");
    } else {
        NSLog(@"同意加好友申请失败的原因 --- %@", aError.errorDescription);
    }
}];
```
- 拒绝添加对方为好友。
```objective-c
[[EMClient sharedClient].contactManager declineFriendRequestFromUser:@"aUsername" completion:^(NSString *aUsername, EMError *aError) {
    if (!aError) {
        NSLog(@"拒绝加好友申请成功");
    } else {
        NSLog(@"拒绝加好友申请失败的原因 %@", aError.errorDescription);
    }
}];
```

3. 监听好友关系相关事件。
当接收方收到添加好友请求，调用 RESTful API 添加好友。
<div class="alert note"> 服务器不会重复下发与好友请求相关的事件，建议退出应用时保存相关的请求数据。</div>

添加回调：
```objective-c
// 导入 EMContactManagerDelegate 类
#import <EMContactManagerDelegate.h>
// 添加好友回调。
[[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
// 移除好友回调。
[[EMClient sharedClient].contactManager removeDelegate:self];
```

监听回调：

```objective-c
// 用户 A 向用户 B 发送添加好友申请，用户 B 收到添加好友回调。
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername
                                message:(NSString *)aMessage
{ }
```

#### 删除好友

参考如下示例代码，删除指定用户名的好友。删除成功后，删除方和被删除方均收到 `friendshipDidRemoveByUser` 回调。

```objective-c
[[EMClient sharedClient].contactManager deleteContact:@"aUsername" isDeleteConversation:aIsDeleteConversation completion:^(NSString *aUsername, EMError *aError) {
    if (!aError) {
        NSLog(@"删除好友成功");
    } else {
        NSLog(@"删除好友失败的原因 %@", aError.errorDescription);
    }
}];
```

#### 获取好友列表

从服务器获取好友列表并存储到本地数据库后，你可以从本地数据库获取好友列表。

```objective-c
// 从服务器获取好友列表。
[[EMClient sharedClient].contactManager getContactsFromServerWithCompletion:^(NSArray *aList, EMError *aError) {
    if (!aError) {
        NSLog(@"获取所有好友成功 %@",aList);
    } else {
        NSLog(@"获取所有好友失败的原因 %@", aError.errorDescription);
    }
}];

// 从本地数据库获取好友列表。
NSArray *userlist = [[EMClient sharedClient].contactManager getContacts];
```

### 管理黑名单

将指定用户加入黑名单后，对方将无法向你发送消息，但你仍然可以向对方发送消息。本节展示如何在项目中管理黑名单。

> - 黑名单是与好友关系是两个独立体系，你可以将任何用户加入黑名单，不论该用户是否与你是好友关系。
> - 如果你将好友加入黑名单，该用户仍然在你的好友列表中。

#### 添加黑名单

参考如下代码，将指定用户加入黑名单：

```objective-c
// 将 aUsername 加入黑名单。
[[EMClient sharedClient].contactManager addUserToBlackList:@"aUsername" completion:^(NSString *aUsername, EMError *aError) {
    if (!aError) {
        NSLog(@"将用户加入黑名单成功");
    } else {
        NSLog(@"将用户加入黑名单失败的原因 %@", aError.errorDescription);
    }
}];
```

#### 移出黑名单

参考如下代码，将指定用户移出黑名单：

```objective-c
// 将 aUsername 移出黑名单。
[[EMClient sharedClient].contactManager removeUserFromBlackList:@"aUsername" completion:^(NSString *aUsername, EMError *aError) {
    if (!aError) {
        NSLog(@"将用户移出黑名单成功");
    } else {
        NSLog(@"将用户移出黑名单失败的原因 %@", aError.errorDescription);
    }
}]; 
```

#### 从服务器获取黑名单列表

参考如下代码，从服务器获取黑名单列表：

```objective-c
// 从服务器获取黑名单列表。该方法为异步。
[[EMClient sharedClient].contactManager getBlackListFromServerWithCompletion:^(NSArray *aList, EMError *aError) {
    if (!aError) {
        NSLog(@"获取黑名单列表成功 %@",aList);
    } else {
        NSLog(@"获取黑名单列表失败的原因 %@", aError.errorDescription);
    }
}];
```

#### 从本地数据库获取黑名单列表

从服务器获取到黑名单列表后，参考如下代码，从本地数据库获取黑名单列表：

```objective-c
NSArray *blockList = [[EMClient sharedClient].contactManager getBlackList];
```