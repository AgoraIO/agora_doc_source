本文介绍如何通过 Agora 即时通讯 IM（环信） SDK 管理好友关系，包括添加、同意、拒绝、删除、查询好友，以及管理黑名单，包括添加、移出、查询黑名单。文中简称为即时通讯。

## 技术原理

Agora 即时通讯 SDK 提供 `ContactManager` 类，用于管理好友关系，包含核心方法如下：

- `addContact`：申请添加好友。
- `acceptInvitation`：同意好友申请。
- `declineInvitation`：拒绝好友申请。
- `deleteContact`：删除好友。
- `getAllContactsFromServer`：从服务器获取好友列表。
- `addUserToBlackList`：添加黑名单。
- `removeUserFromBlackList`：删除黑名单。
- `getBlackListFromServer`：从服务器获取黑名单列表。

## 前提条件

开始前，请确保满足以下条件：

- 已[集成 Agora 即时通讯 SDK](./agora_chat_get_started_android?platform=Android#集成-agora-chat-sdk)。
- 了解消息相关限制和 Agora 即时通讯 API 的调用频率限制，详见[限制条件](./agora_chat_limitation_android?platform=Android)。

## 实现方法

### 管理好友关系

本节展示如何在项目中管理好友关系。

#### 申请添加好友

1. 发送申请添加好友请求。

```java
// 设置待添加的好友的用户名和添加原因。
ChatClient.getInstance().contactManager().addContact(toAddUsername, reason);
```

2. 处理好友请求。
当接收方收到添加好友请求时，有以下两种处理方式：
- 同意添加对方为好友。
```js
// 同意添加 username 为好友。
ChatClient.getInstance().contactManager().acceptInvitation(username);
```
- 拒绝添加对方为好友。
```js
// 拒绝添加 username 为好友。
ChatClient.getInstance().contactManager().declineInvitation(username);
```
当接收方同意或者拒绝添加好友后，发送方收到 `onFriendRequestAccepted` 或者 `onFriendRequestDeclined` 回调。

3. 监听好友关系相关事件。
当接收方收到添加好友请求，调用 RESTful API 添加好友。
<div class="alert note"> 服务器不会重复下发与好友请求相关的事件，建议退出应用时保存相关的请求数据。</div>

```java
 ChatClient.getInstance().contactManager().setContactListener(new ContactListener() {

            // 同意添加好友请求事件。
            @Override
            public void onFriendRequestAccepted(String username) { }

            // 拒绝添加好友请求事件。
            @Override
            public void onFriendRequestDeclined(String username) { }

            // 收到添加好友请求事件。
            @Override
            public void onContactInvited(String username, String reason) { }

            // 删除好友事件。
            @Override
            public void onContactDeleted(String username) { }

            // 添加好友事件。
            @Override
            public void onContactAdded(String username) { }
        });
```


#### 删除好友

参考如下示例代码，调用 `deleteContact` 删除指定用户名的好友。删除成功后，被删除方收到 `onContactDeleted` 回调。

```java
ChatClient.getInstance().contactManager().deleteContact(username);
```

#### 获取好友列表

从服务器获取好友列表并存储到本地数据库后，你可以从本地数据库获取好友列表。

```java
//从服务器获取好友列表
List<String> usernames = ChatClient.getInstance().contactManager().getAllContactsFromServer();
//从本地数据库获取好友列表
List<String> usernames = ChatClient.getInstance().contactManager().getContactsFromLocal
```

### 管理黑名单

将指定用户加入黑名单后，对方将无法向你发送消息，但你仍然可以向对方发送消息。本节展示如何在项目中管理黑名单。

黑名单部分主要功能是获取黑名单列表，加入进黑名单，从黑名单移出等。获取黑名单可从服务器获取黑名单列表，也可从本地数据库获取已保存的黑名单列表。

> - 黑名单是与好友关系是两个独立体系，你可以将任何用户加入黑名单，不论该用户是否与你是好友关系。
> - 如果你将好友加入黑名单，该用户仍然在你的好友列表中。

#### 添加黑名单

参考如下代码，将指定用户加入黑名单：

```java
// 将 username 加入黑名单。
ChatClient.getInstance().contactManager().addUserToBlackList(username,true);
```

#### 移出黑名单

参考如下代码，将指定用户移出黑名单：

```java
ChatClient.getInstance().contactManager().removeUserFromBlackList(username);
```

#### 从服务器获取黑名单列表

参考如下代码，从服务器获取黑名单列表：

```java
ChatClient.getInstance().contactManager().getBlackListFromServer();
```

#### 从本地数据库获取黑名单列表

从服务器获取到黑名单列表后，参考如下代码，从本地数据库获取黑名单列表：

```java
ChatClient.getInstance().contactManager().getBlackListUsernames();
```