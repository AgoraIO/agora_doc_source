用户登录后，可进行添加联系人、获取好友列表等操作。

SDK 提供用户关系管理功能，包括好友列表管理和黑名单管理：

- 好友列表管理：查询好友列表、申请添加好友、同意好友申请、拒绝好友申请和删除好友等操作。
- 黑名单管理：查询黑名单列表、添加用户至黑名单以及将用户移除黑名单等操作。

本文介绍如何通过即时通讯 IM Flutter SDK 管理用户关系。

## 技术原理

即时通讯 IM Flutter SDK 提供 `ChatContactManager` 类可以实现添加、删除和管理联系人。以下是核心方法：

- `addContact` 申请添加好友；
- `deleteContact` 删除好友；
- `acceptInvitation` 同意好友申请；
- `declineInvitation` 拒绝好友申请；
- `getAllContactsFromServer` 从服务器获取好友列表；
- `getAllContactsFromDB` 从本地数据库中获取好友列表；
- `addUserToBlockList` 添加用户到黑名单；
- `removeUserFromBlockList` 将用户从黑名单移除；
- `getBlockListFromServer` 从服务器获取黑名单列表。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_flutter)。
- 了解 [使用限制](./agora_chat_limitation)。


## 实现方法

### 添加好友

本节以用户 A 和用户 B 为例，介绍添加指定用户为联系人的过程。

用户 A 调用 `addContact` 申请将用户 B 添加为联系人：

```dart
// 要添加为联系人的用户 ID
String userId = "foo";
// 申请加为好友的理由
String reason = "Request to add a friend.";
try{
  await ChatClient.getInstance.contactManager.addContact(userId, reason);
} on ChatError catch (e) {
}
```

当用户 B 收到好友申请时，可以选择接受或拒绝邀请。

- 接受好友申请

  ```dart
  // 用户 ID
  String userId = "bar";
  try{
    await ChatClient.getInstance.contactManager.acceptInvitation(userId);
  } on ChatError catch (e) {
  }
  ```

- 拒绝好友申请

  ```dart
  // 用户 ID
  String userId = "bar";
  try{
    await ChatClient.getInstance.contactManager.declineInvitation(userId);
  } on ChatError catch (e) {
  }
  ```

用户 A 用 `ContactEventHandler` 监听联系人事件。

- 如果用户 B 接受邀请，`onContactInvited` 触发。

  ```dart
  class _ContactPageState extends State<ContactPage> {
    @override
    void initState() {
      super.initState();
      // 注册监听
      ChatClient.getInstance.contactManager.addEventHandler(
        "UNIQUE_HANDLER_ID",
        ContactEventHandler(
          onContactInvited: (userId, reason) {},
        ),
      );
    }
    @override
    void dispose() {
      // 移除监听
      ChatClient.getInstance.contactManager.removeEventHandler("UNIQUE_HANDLER_ID");
      super.dispose();
    }
  }
  ```

- 如果用户 B 拒绝邀请，`onFriendRequestDeclined` 触发。

  ```dart
  class _ContactPageState extends State<ContactPage> {
    @override
    void initState() {
      super.initState();
      // Adds the contact event handler.
      ChatClient.getInstance.contactManager.addEventHandler(
        "UNIQUE_HANDLER_ID",
        ContactEventHandler(
          onFriendRequestDeclined: (userId) {},
        ),
      );
    }
    @override
    void dispose() {
      // 移除监听
      ChatClient.getInstance.contactManager.removeEventHandler("UNIQUE_HANDLER_ID");
      super.dispose();
    }
  }
  ```

### 获取好友列表

1. 从服务器获取好友列表

```dart
List<String> contacts = await ChatClient.getInstance.contactManager.getAllContactsFromServer();
```

2. 从本地数据库中获取好友列表

```dart
List<String> contacts = await ChatClient.getInstance.contactManager.getAllContactsFromDB();
```

### 删除联系人

调用 `deleteContact` 删除指定联系人。删除联系人时会同时删除对方联系人列表中的该用户，建议执行双重确认，以免发生误删操作。删除操作不需要对方同意或者拒绝。

可同时选择是否保留聊天会话，示例代码如下：

```dart
// 用户 ID
String userId = "tom";
// 是否保留聊天会话
bool keepConversation = true;
try {
  await ChatClient.getInstance.contactManager.deleteContact(
    userId,
    keepConversation,
  );
} on ChatError catch (e) {
}
```

### 将用户加入黑名单

你可以调用 `addUserToBlockList` 添加用户到黑名单，添加后对方将无法发送消息给自己。

用户可以将任何其他聊天用户添加到他们的黑名单列表中，无论该用户是否是联系人。添加到黑名单列表的联系人保留在联系人列表中。

```dart
// 用户 ID
String userId = "tom";
try {
  await ChatClient.getInstance.contactManager.addUserToBlockList(userId);
} on ChatError catch (e) {
}
```

### 查看当前用户黑名单列表

1. 调用 `getBlockListFromServer` 通过服务器获取黑名单列表

从服务器获取黑名单列表之后，才能从本地数据库获取到黑名单列表。

```dart
try {
  List<String> list =
      await ChatClient.getInstance.contactManager.getBlockListFromServer();
} on ChatError catch (e) {
}
```

2. 调用 `getBlockListFromDB` 从本地缓存获取黑名单列表。

```dart
try {
  List<String> list =
      await ChatClient.getInstance.contactManager.getBlockListFromDB();
} on ChatError catch (e) {
}
```

### 将用户从黑名单移除

你可以调用 `removeUserFromBlockList` 将用户从黑名单移除，用户发送消息等行为将恢复。

```dart
String userId = "tom";
try {
  await ChatClient.getInstance.contactManager.removeUserFromBlockList(userId);
} on ChatError catch (e) {
}
```