用户完成登录后，就会进行添加联系人、获取好友列表等操作。

SDK 提供用户关系管理功能，包括好友列表管理和黑名单管理：

- 好友列表管理：查询好友列表、请求添加好友、同意好友请求、拒绝好友请求和删除好友等操作。
- 黑名单管理：查询黑名单列表、添加用户至黑名单以及将用户移除黑名单等操作。

本文介绍如何通过环信即时通讯 IM SDK 管理好友关系。

## 技术原理

即时通讯 IM Unity SDK 提供 `IContactManager` 类实现好友的添加移除，黑名单的添加移除等功能。主要方法如下：

- `AddContact` 请求添加好友。
- `AcceptInvitation` 同意好友请求。
- `DeclineInvitation` 拒绝好友请求。
- `DeleteContact` 删除好友。
- `GetAllContactsFromServer` 从服务器获取好友列表。
- `AddUserToBlockList` 添加用户到黑名单。
- `RemoveUserFromBlockList` 将用户从黑名单移除。
- `GetBlockListFromServer` 从服务器获取黑名单列表。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_unity)。
- 了解 [使用限制](./agora_chat_limitation)。

## 实现方法

本节展示如何在项目中管理好友的添加移除和黑名单的添加移除。

### 管理好友请求

好友请求部分主要功能是发送好友请求、接收好友请求、处理好友请求和好友请求处理结果回调等。

#### 请求添加好友

调用 `AddContact` 添加指定用户为联系人示例代码如下：：

```C#
//username 为要添加的联系人的用户名，reason 为添加原因
SDKClient.Instance.ContactManager.AddContact(username, reason, handle: new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### 监听与好友请求相关的回调

请监听与好友请求相关事件的回调，这样当用户收到好友请求，可以调用接受请求的 RESTful API 添加好友。服务器不会重复下发与好友请求相关的事件，建议退出应用时保存相关的请求数据。设置监听示例代码如下：

```C#
//继承并实现 IContactManagerDelegate。
public class ContactManagerDelegate : IContactManagerDelegate {
    // 当前用户新增了联系人。用户 B 向用户 A 发送好友请求，用户 A 同意该请求，用户 A 收到该事件，而用户 B 收到 `onContactAgreed` 事件。
    public void OnContactAdded(string username)
    {
    }
    // 当前用户被其他用户从联系人列表上移除。用户 B 将用户 A 从联系人列表上删除，用户 A 收到该事件。
    public void OnContactDeleted(string username)
    {
    }
    // 当前用户收到好友请求。用户 B 向用户 A 发送好友请求，用户 A 收到该事件。
    public void OnContactInvited(string username, string reason)
    {
    }
    // 当前用户发送的好友请求经过了对方同意。用户 A 向用户 B 发送好友请求，用户 B 收到好友请求后，同意加好友，则用户 A 收到该事件。
    public void OnFriendRequestAccepted(string username)
    {
    }
    // 当前用户发送的好友请求被拒绝。用户 A 向用户 B 发送好友请求，用户 B 收到好友请求后，拒绝加好友，则用户 A 收到该事件。
    public void OnFriendRequestDeclined(string username)
    {
    }
}

//添加监听器。
ContactManagerDelegate adelegate = new ContactManagerDelegate();
SDKClient.Instance.ContactManager.AddContactManagerDelegate(adelegate);

//移除监听器。
SDKClient.Instance.ContactManager.RemoveContactManagerDelegate(adelegate);
```

收到好友请求后，可以选择同意或拒绝加好友请求，示例代码如下：

收到后 `OnContactInvited`，调用 `AcceptInvitation` 或 `DeclineInvitation` 接受或拒绝邀请。

```C#
//同意好友请求。
SDKClient.Instance.ContactManager.AcceptInvitation(username, handle: new CallBack(
   onSuccess: () =>
   {
   },
   onError: (code, desc) =>
   {
   }
));

//拒绝好友请求。
SDKClient.Instance.ContactManager.DeclineInvitation(username, handle: new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

当你同意或者拒绝后，对方会通过好友事件回调，收到 `OnFriendRequestAccepted` 或者 `OnFriendRequestDeclined` 回调。

### 删除好友

调用 `DeleteContact` 删除指定联系人。被删除的用户收到 `OnContactDeleted` 回调。删除联系人时会同时删除对方联系人列表中的该用户，建议执行双重确认，以免发生误删操作。删除操作不需要对方同意或者拒绝。

```C#
SDKClient.Instance.ContactManager.DeleteContact(username, handle: new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

调用 `DeleteContact` 删除好友后，对方会收到 `OnContactDeleted` 回调。

### 获取好友列表

你可以从服务器获取好友列表，也可以从本地数据库获取保存的好友列表。

从服务器获取好友列表之后才能从本地数据库获取到好友列表。

```C#
//从服务器获取好友列表。
SDKClient.Instance.ContactManager.GetAllContactsFromServer(new ValueCallBack<List<string>>(
  onSuccess: (list) =>
  {
  },
  onError: (code, desc) =>
  {
  }
));

//从本地数据库获取好友列表。
List<string>list = SDKClient.Instance.ContactManager.GetAllContactsFromDB();
```

### 管理黑名单

将指定用户加入黑名单后，对方将无法给你发送消息。黑名单部分主要功能是获取黑名单列表、添加用户至黑名单以及将用户从黑名单移除等。获取黑名单时，可从服务器获取黑名单列表，也可从本地数据库获取已保存的黑名单列表。

黑名单是与好友无任何关系的独立体系。可以将任何用户加入黑名单，不论该用户与你是否是好友关系。好友加入黑名单后仍在好友列表上显示。

#### 添加用户到黑名单

你可以调用 `AddUserToBlockList` 添加用户到黑名单，示例代码如下：

```C#
//将好友拉入黑名单后，用户依然可以向该好友发送消息，但无法接收该好友发送的消息。
SDKClient.Instance.ContactManager.AddUserToBlockList(username, handle: new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### 将用户从黑名单移除

你可以调用 `RemoveUserFromBlockList` 将用户从黑名单移除，示例代码如下：

```C#
SDKClient.Instance.ContactManager.RemoveUserFromBlockList(username, handle: new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### 从服务器获取黑名单列表

你可以调用 `GetBlockListFromServer` 从服务端获取黑名单列表。示例代码如下：

```C#
SDKClient.Instance.ContactManager.GetBlockListFromServer(new ValueCallBack<List<string>>(
  onSuccess: (list) =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```