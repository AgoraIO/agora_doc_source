聊天室支持多个用户之间的实时消息传递。

本页介绍如何使用即时通讯 IM SDK 管理应用中的聊天室成员。

## 技术原理

即时通讯 IM SDK 提供 `EMChatRoomManager` 类 和 `EMChatRoom` 类，支持对聊天室成员的管理，包括获取、添加和移出聊天室成员等，主要方法如下：

- 获取聊天室成员列表
- 将成员移出聊天室
- 管理聊天室黑名单
- 管理聊天室白名单
- 管理聊天室禁言列表
- 开启和关闭聊天室全员禁言
- 管理聊天室所有者及管理员

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Android 入门](./agora_chat_get_started_android?platform=Android)。
- 了解 [使用限制](./agora_chat_limitation?platform=Android)。
- 了解聊天室的数量限制，详见 [套餐包详情](./agora_chat_plan?platform=Android)。

## 实现方法

本节介绍如何调用即时通讯 IM SDK 提供的 API 来实现上述功能。

### 获取聊天室成员列表

所有聊天室成员均可调用 `fetchChatRoomMembers` 方法获取当前聊天室成员列表。

示例代码如下：

```java
Map<String, Long> members = ChatClient.getInstance().chatroomManager().fetchChatRoomMembers(chatRoomId, cursor, pageSize);
```

### 将成员移出聊天室

仅聊天室所有者和管理员可调用 `EMChatRoomManager#removeChatRoomMembers` 方法将指定成员移出聊天室。

删除成员后，该成员收到 `onRemovedFromChatRoom` 回调，其他聊天室成员收到 `onMemberExited` 回调。

被移出的成员可以重新进入聊天室。

示例代码如下：

```java
ChatClient.getInstance().chatroomManager().removeChatRoomMembers(chatRoomId, members);
```

### 管理聊天室黑名单


#### 将成员加入聊天室黑名单

仅聊天室所有者和管理员可以调用 `blockChatroomMembers` 方法将指定成员添加至黑名单。

被加入黑名单后，该成员收到 `onRemovedFromChatRoom` 回调，其他成员收到 `onMemberExited` 回调。移出原因为 `BE_KICKED`。

被加入黑名单后，该成员无法再收发聊天室消息并被移出聊天室，黑名单中的成员如想再次加入聊天室，聊天室所有者或管理员必须先将其移出黑名单列表。

示例代码如下：

```java
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().blockChatroomMembers(chatRoomId, members);
```

#### 将成员移出聊天室黑名单

仅聊天室所有者和管理员可以调用 `unblockChatRoomMembers` 方法将成员移出聊天室黑名单。

示例代码如下：

```java
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().unblockChatRoomMembers(chatRoomId, members);
```

#### 获取聊天室黑名单列表

仅聊天室所有者和管理员可以调用 `fetchChatRoomBlockList` 方法获取当前聊天室黑名单。

示例代码如下：

```java
ChatClient.getInstance().chatroomManager().fetchChatRoomBlackList(chatRoomId, new ValueCallBack<List<String>>() {
    @Override
    public void onSuccess(List<String> value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});
```

### 管理聊天室禁言列表

要管理聊天室中的消息，聊天室所有者和管理员可以将指定成员添加到聊天室禁言列表中，并将其从其中删除。将聊天室成员添加到禁言列表后，该成员将无法再发送聊天室消息，即使添加到聊天室白名单列表后也无法发送。

#### 添加成员至聊天室禁言列表

仅聊天室所有者和管理员可以调用 `muteChatRoomMembers` 方法将指定成员添加至聊天室禁言列表，操作者外其他成员收到 `onMuteListAdded` 回调。

**注意**：
聊天室所有者可禁言聊天室所有成员，聊天室管理员可禁言聊天室普通成员。

示例代码如下：

```java
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().muteChatRoomMembers(chatRoomId, members, duration);
```

#### 将成员移出聊天室禁言列表

仅聊天室所有者和管理员可以调用 `unMuteChatRoomMembers` 将成员从聊天室禁言列表移出。被解除禁言后，其他成员收到 `onMuteListRemoved` 回调。

**注意**
聊天室所有者可对聊天室所有成员解除禁言，聊天室管理员可对聊天室普通成员解除禁言。

示例代码如下：

```java
// The chat room owner or admin can call unMuteChatRoomMembers to remove the specified user from the chat room block list. The unmuted member and all the other chat room admins or owner receive the onMuteListRemoved callback.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().unMuteChatRoomMembers(chatRoomId, members);
```

#### 获取聊天室禁言列表

仅聊天室所有者和管理员可调用 `fetchChatRoomMuteList` 获取聊天室禁言列表。

示例代码如下：

```java
// The chat room owner or admin can call fetchChatRoomMuteList to fetch the mute list of the current chat room.
Map<String, Long> memberMap =  ChatClient.getInstance().chatroomManager().fetchChatRoomMuteList(chatRoomId, pageNum, pageSize);
```

### 开启和关闭聊天室全员禁言

为了快捷管理聊天室发言，聊天室所有者和管理员可以开启和关闭聊天室全员禁言。全员禁言和单独的成员禁言不冲突，设置或者解除全员禁言，原禁言列表并不会变化。

#### 开启全员禁言

仅聊天室所有者和管理员可以调用 `muteAllMembers` 方法开启全员禁言。全员禁言开启后，除了在白名单中的成员，其他成员不能发言。调用成功后，聊天室成员会收到 `onAllMemberMuteStateChanged` 回调。

示例代码如下：

```java
ChatClient.getInstance().chatroomManager().muteAllMembers(chatRoomId, new ValueCallBack<ChatRoom>() {
    @Override
    public void onSuccess(ChatRoom value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});
```

#### 关闭全员禁言

仅聊天室所有者和管理员可以调用 `EMChatRoomManager#unmuteAllMembers` 方法取消全员禁言。调用成功后，聊天室成员会收到 `onAllMemberMuteStateChanged` 回调。

示例代码如下：

```java
ChatClient.getInstance().chatroomManager().unmuteAllMembers(chatRoomId, new ValueCallBack<ChatRoom>() {
    @Override
    public void onSuccess(ChatRoom value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});
```

### 管理聊天室白名单列表

即使聊天室所有者或管理员使用 `muteAllMembers` 开启了全员禁言，聊天室白名单列表中的成员也可以发送聊天室消息。但是，如果某个成员已经在聊天室禁言列表中，则将该成员添加到白名单列表中不会生效。

#### 将成员加入聊天室白名单

仅聊天室所有者和管理员可以调用 `addToChatRoomWhiteList` 将成员加入聊天室白名单。

示例代码如下：

```java
ChatClient.getInstance().chatroomManager().addToChatRoomWhiteList(chatRoomId, members, new ValueCallBack<ChatRoom>() {
    @Override
    public void onSuccess(ChatRoom value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});
```

#### 将成员移出聊天室白名单列表

仅聊天室所有者和管理员可以调用 `removeFromChatRoomWhiteList` 将成员从聊天室白名单移出。

示例代码如下：

```java
ChatClient.getInstance().chatroomManager().removeFromChatRoomWhiteList(chatRoomId, members, new ValueCallBack<ChatRoom>() {
    @Override
    public void onSuccess(ChatRoom value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});
```

#### 检查自己是否在聊天室白名单中

所有聊天室成员可以调用 `checkIfInChatRoomWhiteList` 方法检查自己是否在聊天室白名单中，示例代码如下：

```java
ChatClient.getInstance().chatroomManager().checkIfInChatRoomWhiteList(chatRoomId, new ValueCallBack<Boolean>() {
    @Override
    public void onSuccess(Boolean value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});
```

#### 获取聊天室白名单列表

仅聊天室所有者和管理员可以调用 `fetchChatRoomWhiteList` 获取当前聊天室白名单成员列表。

示例代码如下：

```java
ChatClient.getInstance().chatroomManager().fetchChatRoomWhiteList(chatRoomId, new ValueCallBack<List<String>>() {
    @Override
    public void onSuccess(List<String> value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});
```

### 管理聊天室所有权和管理员

#### 变更聊天室所有者

聊天室所有者可以调用 `changeOwner` 方法将所有权转让给指定的聊天室成员。一旦所有权转移，原来的聊天室所有者就会成为普通成员。新的聊天室所有者和聊天室管理员会收到 `onOwnerChanged` 回调。

示例代码如下：

```java
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().changeOwner(chatRoomId, newOwner);
```

#### 添加聊天室管理员

仅聊天室所有者可以调用 `addChatRoomAdmin` 方法添加聊天室管理员。成功添加后，新管理员及其他管理员收到 `onAdminAdded` 回调。

示例代码如下：

```java
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().addChatRoomAdmin(chatRoomId, admin);
```

#### 移除聊天室管理员

仅聊天室所有者可以调用 `removeChatRoomAdmin` 方法移除聊天室管理员。成功移除后，被移除的管理员及其他管理员收到 `onAdminRemoved` 回调。

示例代码如下：

```java
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().removeChatRoomAdmin(chatRoomId, admin);
```

### 监听聊天室事件

有关详细信息，请参阅 [监听聊天室事件](./agora_chat_chatroom_android?platform=Android#监听聊天室事件)。