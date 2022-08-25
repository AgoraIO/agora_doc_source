# 用户关系管理

登录即时通讯 IM（环信）后，用户可以开始添加联系人并互相聊天。他们还可以管理这些联系人，例如添加、获取和删除联系人。他们还可以将指定的用户添加到黑名单列表以停止接收来自该用户的消息。

本页介绍如何使用即时通讯 IM（环信）SDK 实现用户关系管理。

## 了解技术

即时通讯 IM（环信）SDK 提供 `ContactManager` 类用于添加、删除和管理联系人。以下是核心方法：

- `addContact` 申请添加好友。
- `acceptInvitation` 同意好友申请。
- `declineInvitation` 拒绝好友申请。
- `deleteContact` 删除好友。
- `getAllContactsFromServer` 从服务器获取好友列表。
- `addUserToBlackList` 添加用户到黑名单。
- `removeUserFromBlackList` 将用户从黑名单移除。
- `getBlackListFromServer` 从服务器获取黑名单列表。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并实现了注册账号和登录功能。详见 [即时通讯 IM（环信）入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_android?platform=Android)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Android)。

## 实现方法

本节展示如何在项目中管理好友的添加移除和黑名单的添加移除。

### 管理联系人列表

使用本部分了解如何发送好友请求、处理好友请求、监听联系人事件等。

#### 申请添加指定用户为联系人

调用 `addContact` 添加指定用户为联系人：

```java
//The parameters are the username of the contact to be added and the reason for adding
ChatClient.getInstance().contactManager().addContact(toAddUsername, reason);
```

#### 监听联系人事件

请监听与好友请求相关事件的回调，这样当用户收到好友请求，可以调用接受请求的 RESTful API 添加好友。服务器不会重复下发与好友请求相关的事件，建议退出应用时保存相关的请求数据。设置监听示例代码如下：

```java
 ChatClient.getInstance().contactManager().setContactListener(new ContactListener() {

            // 对方同意了好友请求。
            @Override
            public void onFriendRequestAccepted(String username) { }

            // 对方拒绝了好友请求。
            @Override
            public void onFriendRequestDeclined(String username) { }

            // 接收到好友请求。
            @Override
            public void onContactInvited(String username, String reason) { }

            // 联系人被删除。
            @Override
            public void onContactDeleted(String username) { }

            // 联系人已添加。
            @Override
            public void onContactAdded(String username) { }
        });
```

#### 接受或拒绝好友申请

收到 `onContactInvited`，调用 `acceptInvitation` 或 `declineInvitation` 接受或拒绝邀请。

```java
// 同意好友申请。
ChatClient.getInstance().contactManager().acceptInvitation(username);
// 拒绝好友申请。
ChatClient.getInstance().contactManager().declineInvitation(username);
```

当你同意或者拒绝后，对方会通过好友事件回调，收到 `onContactAgreed` 或者 `onContactRefused`。

#### 删除联系人

删除联系人时会同时删除对方联系人列表中的该用户，建议执行双重确认，以免发生误删操作。删除操作不需要对方同意或者拒绝。

```java
ChatClient.getInstance().contactManager().deleteContact(username);
```

调用 `deleteContact` 删除好友后，对方会收到 `onContactDeleted` 回调。

#### 获取联系人列表

要获取联系人列表，你可以调用 `getAllContactsFromServer` 从服务器获取联系人列表。之后，你还可以调用 `getContactsFromLocal` 从本地数据库中获取联系人列表。

```java
// 从服务器获取好友列表。
List<String> usernames = ChatClient.getInstance().contactManager().getAllContactsFromServer();
// 从本地数据库获取好友列表。
List<String> usernames = ChatClient.getInstance().contactManager().getContactsFromLocal
```

### 管理黑名单

你可以将指定的用户添加到黑名单列表中。完成此操作后，你仍然可以向该用户发送聊天消息，但无法接收来自他们的消息。

用户可以将任何其他聊天用户添加到他们的黑名单列表中，无论该用户是否是联系人。添加到黑名单列表的联系人保留在联系人列表中。

#### 将用户添加到黑名单

调用 `addUserToBlackList` 以将指定用户添加到黑名单。

```java
ChatClient.getInstance().contactManager().addUserToBlackList(username,true);
```

### 将用户从黑名单移除

你可以调用 `removeUserFromBlackList` 将用户从黑名单移除，示例代码如下：

```java
ChatClient.getInstance().contactManager().removeUserFromBlackList(username);
```

#### 从服务器获取黑名单列表

调用 `getBlackListFromServer` 从服务器获取黑名单用户的列表。

```java
ChatClient.getInstance().contactManager().getBlackListFromServer();
```

从服务器获取到黑名单列表后，还可以调用 `getBlackListUserNames` 从本地数据库中获取黑名单列表。

```java
ChatClient.getInstance().contactManager().getBlackListUsernames();
```

## 参考

有关接口的详细信息，请参阅以下 API 参考：

- [联系人管理](https://docs.agora.io/en/agora-chat/.API Reference/im_java/classio_1_1agora_1_1chat_1_1_contact_manager.html)