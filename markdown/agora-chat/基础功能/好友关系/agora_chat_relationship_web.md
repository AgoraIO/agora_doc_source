本文介绍如何通过 Agora 即时通讯 IM（环信） SDK 管理好友关系，包括添加、同意、拒绝、删除、查询好友，以及管理黑名单，包括添加、移出、查询黑名单。文中简称为即时通讯。

## 技术原理

Agora 即时通讯 SDK 提供 `ContactManager` 类，用于管理好友关系，包含核心方法如下：

-   `addContact`：申请添加好友。
-   `acceptContactInvite`：同意好友申请。
-   `declineContactInvite`：拒绝好友申请。
-   `deleteContact`：删除好友。
-   `getContacts`：获取好友列表。
-   `addUsersToBlacklist`：添加黑名单。
-   `removeUserFromBlackList`：删除黑名单。
-   `getBlacklist`：获取黑名单列表。
-   `removeUserFromBlackList`：移出黑名单。
-   `connection.addEventHandler`：监听好友状态事件。

## 前提条件

开始前，请确保满足以下条件：

-   已[集成 Agora 即时通讯 SDK](./agora_chat_get_started_web?platform=Web#集成-agora-chat-sdk)。
-   了解消息相关限制和 Agora 即时通讯 API 的调用频率限制，详见[限制条件](./agora_chat_limitation_web?platform=Web)。

## 实现方法

### 管理好友关系

本节展示如何在项目中管理好友关系。

#### 申请添加好友

1. 发送申请添加好友请求。

```js
// 设置待添加的好友的用户名和添加原因。
let message = "加个好友呗!";
WebIM.conn.addContact("username", message);
```

2. 处理好友请求。

当接收方收到添加好友请求时，有以下两种处理方式：

-   同意添加对方为好友。

```js
// 同意添加 username 为好友。
WebIM.conn.acceptContactInvite("username");
```

-   拒绝添加对方为好友。

```js
// 拒绝添加 username 为好友。
WebIM.conn.declineContactInvite("username");
```

3. 监听好友关系相关事件。
   在 `connection.addEventHandler` 后添加以下事件监听：

```js
// msg 为触发回调后的提示信息。
connection.addEventHandler('CONTACT', {
    // 收到添加好友请求回调。
    onContactInvited: function(msg){}
    // 被删除好友回调。
    onContactDeleted: function(msg){}
    // 添加好友回调。
    onContactAdded: function(msg){}
    // 添加好友请求被拒绝回调。
    onContactRefuse: function(msg){}
    // 添加好友请求被同意回调。
    onContactAgreed: function(msg){}
})
```

#### 删除好友

参考如下示例代码，删除指定用户名的好友：

```js
WebIM.conn.deleteContact("username");
```

#### 获取好友列表

参考如下示例代码，获取好友列表：

```js
WebIM.conn.getRoster().then( (res) => {
    console.log(res) // res.data > ['user1', 'user2']
}
```

### 管理黑名单

将指定用户加入黑名单后，对方将无法向你发送消息，但你仍然可以向对方发送消息。本节展示如何在项目中管理黑名单。

> -   黑名单是与好友关系是两个独立体系，你可以将任何用户加入黑名单，不论该用户是否与你是好友关系。
> -   如果你将好友加入黑名单，该用户仍然在你的好友列表中。

#### 添加黑名单

参考如下代码，将指定用户加入黑名单：

```js
// 将 user1 和 user2 加入黑名单。
WebIM.conn.addUsersToBlacklist({
    name: ["user1", "user2"],
});
```

#### 移出黑名单

参考如下代码，将指定用户移出黑名单：

```js
// 将 user1 和 user2 移出黑名单。
WebIM.conn.removeUserFromBlackList({
    name: ["user1", "user2"],
});
```

#### 从服务器获取黑名单列表

参考如下代码，获取黑名单列表：

```js
WebIM.conn.getBlacklist();
```