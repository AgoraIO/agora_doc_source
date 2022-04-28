聊天室是支持多人加入的类似 Twitch 的组织。聊天室中的成员没有固定关系，用户离线后，超过 5 分钟会自动退出聊天室。聊天室成员在离线后，不会收到推送消息。聊天室可以应用于直播、消息广播等。

本文指导你如何使用 Agora Chat SDK 在实时互动 app 中创建聊天室并管理聊天室和聊天室成员。

## 技术原理

Agora Chat SDK 提供 `ChatRoomManager` 和 `ChatRoom` 类用于聊天室管理，支持你通过调用 API 在项目中实现如下功能：
- 创建、解散聊天室
- 加入、退出聊天室
- 从服务器获取聊天室
- 管理聊天室成员
- 管理聊天室属性和聊天室公告

## 前提条件

开始前，请确保你的项目满足以下条件：

- 已完成 SDK 初始化。详见[实现发送和接收消息](agora_chat_get_started_android)。
- 了解 Agora Chat API 的接口调用频率限制。详见[限制条件](agora_chat_limitation_android)。
- 了解聊天室数量限制。详见[套餐包详情](agora_chat_plan)。
- 只有超级管理员才有创建聊天室的权限，因此你还需要确保已调用[超级管理员 RESTful API](agora_chat_restful_chatroom_superadmin) 添加了超级管理员。

## 实现方法

本节介绍如何使用 Agora Chat SDK 提供的 API 实现上述功能。

### 创建与解散聊天室

[超级管理员](agora_chat_restful_chatroom_superadmin)可以调用 `createChatRoom` 方法创建聊天室，并设置聊天室的主题、描述、最大人数等信息。

```java
// 超级管理员调用 createChatRoom 创建聊天室。成功创建聊天室后，该超级管理员成为聊天室所有者
ChatRoom  chatRoom = ChatClient.getInstance().chatroomManager().createChatRoom(subject, description, welcomMessage, maxUserCount, members);

// 只有聊天室所有者才能调用 destroyChatRoom 解散聊天室
// 成功解散聊天室后，其他聊天室成员会收到 onChatRoomDestroyed 回调，并被踢出聊天室
ChatClient.getInstance().chatroomManager().destroyChatRoom(chatRoomId);
```

### 获取聊天室列表及信息

你可以从服务器获取指定数目的聊天室列表，并通过指定聊天室 ID 获取指定聊天室的基本信息。

示例代码如下：

```java
// 聊天室成员调用 fetchPublicChatRoomsFromServer 从服务器获取指定数目的聊天室列表。其中 pageSize 的最大值为 1,000
PageResult<ChatRoom> chatRooms = ChatClient.getInstance().chatroomManager().
                            fetchPublicChatRoomsFromServer(pageNumber, pageSize);
														
// 聊天室成员调用 fetchChatRoomFromServer 并指定聊天室 ID 开获取指定聊天室的基本信息
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().fetchChatRoomFromServer(chatRoomId);
```

### 加入和退出聊天室

所以用户都可以通过调用 `joinChatRoom` 加入指定聊天室。示例代码如下：

```java
// 成功加入聊天室后，聊天室其他成员会收到 onMemberJoined 回调
ChatClient.getInstance().chatroomManager().joinChatRoom(chatRoomId, new ValueCallBack<ChatRoom>() {
    @Override
    public void onSuccess(ChatRoom value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});

// 聊天室所有成员都可以调用 leaveChatRoom 离开指定聊天室。成功离开后，聊天室其他成员会收到 onMemberExited 回调
ChatClient.getInstance().chatroomManager().leaveChatRoom(chatRoomId);
```

退出聊天室时，SDK 默认会删除该聊天室在本地的所有消息。如果不想删除，可以将 `ChatOptions`  中的 `setDeleteMessagesAsExitChatRoom` 设为 `false`。

### 获取、修改聊天室信息

聊天室所有成员都可以调用 `fetchChatRoomFromServer` 方法获取聊天室详情，包括聊天室的主题、公告、描述、成员类型、管理员列表等。聊天室所有者和管理员还可以设置和更新聊天室名称。示例代码如下：

```java
// 聊天室成员调用 fetchChatRoomFromServer 获取聊天室信息
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().fetchChatRoomFromServer(chatRoomId);

// 聊天室所有者和管理员调用 changeChatRoomSubject 更改聊天室主题
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().changeChatRoomSubject(chatRoomId, newSubject);

// 聊天室所有者和管理员调用 changeChatroomDescription 更改聊天室描述
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().changeChatroomDescription(chatRoomId, newDescription);
```

### 管理聊天室成员

所有聊天室成员都可以调用 `fetchChatRoomMembers` 方法获取当前聊天室的成员列表。示例代码如下：

```java
Map<String, Long> members = ChatClient.getInstance().chatroomManager().fetchChatRoomMembers(chatRoomId, cursor, pageSize);
```

聊天室所有者和管理员可以调用 `removeChatRoomMembers` 将指定用户移出聊天室。成功移除后，被移除的用户会收到 `onRemovedFromChatRoom` 回调，其他聊天室成员会收到 `onMemberExited` 回调。用户被移出聊天室后，还可以再次加入聊天室。

移除聊天室成员的示例代码如下：

```java
ChatClient.getInstance().chatroomManager().removeChatRoomMembers(chatRoomId, members);
```

### 管理聊天室黑名单列表

聊天室所有者及管理员可以将聊天室中的指成员加入或者移出聊天室黑名单。聊天室成员被加入黑名单后将无法收发聊天室消息，且无法申请再次加入聊天室。

添加、移除、获取聊天室黑名单的示例代码如下：

```java
// 聊天室所有者或管理员调用 blockChatroomMembers 将指定成员加入聊天室黑名单
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().blockChatroomMembers(chatRoomId, members);

// 聊天室所有者或管理员调用 unblockChatRoomMembers 将指定成员移出聊天室黑名单
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().unblockChatRoomMembers(chatRoomId, members);

// 聊天室所有者或管理员调用 fetchChatRoomBlackList 获取当前的聊天室黑名单列表
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

为了管理聊天室成员发言，聊天室所有者和管理员可以将指定聊天室成员加入或者移出聊天室禁言列表。聊天室成员被加入聊天室禁言列表后，将不能够发言，即使其被加入群白名单也不能发言。

添加、移除、获取聊天室禁言列表的示例代码如下：

```java
// 聊天室所有者或管理员调用 muteChatRoomMembers 将指定用户加入聊天室禁言列表。被禁言成员和其他未操作的聊天室所有者或管理员会收 onMuteListAdded 回调
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().muteChatRoomMembers(chatRoomId, members, duration);

// 聊天室所有者或管理员调用 unMuteChatRoomMembers 将指定用户加入聊天室禁言列表。被禁言成员和其他未操作的聊天室所有者或管理员会收 onMuteListRemoved 回调
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().unMuteChatRoomMembers(chatRoomId, members);

// 聊天室所有者或管理员调用 fetchChatRoomMuteList 获取聊天室禁言列表
Map<String, Long> memberMap =  ChatClient.getInstance().chatroomManager().fetchChatRoomMuteList(chatRoomId, pageNum, pageSize);
```

为方便快捷管理，Agora Chat 还支持聊天室所有者和管理员开启和关闭聊天室全员禁言。开启聊天室全员禁言后，除了在聊天室白名单中的成员，其他成员将不能发言。

开启、关闭全员禁言的示例代码如下：

```java
// 聊天室所有者或管理员调用 muteAllMembers 开启全员禁言。成功开启后，聊天室成员会收到 onAllMemberMuteStateChanged 回调
ChatClient.getInstance().chatroomManager().muteAllMembers(chatRoomId, new ValueCallBack<ChatRoom>() {
    @Override
    public void onSuccess(ChatRoom value) {
        
    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});

// 聊天室所有者或管理员调用 unmuteAllMembers 解除全员禁言。成功解除后，聊天室成员会收到 onAllMemberMuteStateChanged 回调
ChatClient.getInstance().chatroomManager().unmuteAllMembers(chatRoomId, new ValueCallBack<ChatRoom>() {
    @Override
    public void onSuccess(ChatRoom value) {
        
    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});
```

### 管理聊天室白名单

聊天室白名单用户不受全员禁言限制。但是如果该白名单用户在聊天室禁言列表中，则该用户不能发言。

添加、移除、获取聊天室白名单的示例代码如下：

```java
// 聊天室所有者或管理员调用 addToChatRoomWhiteList 将指定成员添加到聊天室白名单中
ChatClient.getInstance().chatroomManager().addToChatRoomWhiteList(chatRoomId, members, new ValueCallBack<ChatRoom>() {
    @Override
    public void onSuccess(ChatRoom value) {
        
    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});

// 聊天室所有者或管理员调用 removeFromChatRoomWhiteList 将指定成员从聊天室白名单中移除
ChatClient.getInstance().chatroomManager().removeFromChatRoomWhiteList(chatRoomId, members, new ValueCallBack<ChatRoom>() {
    @Override
    public void onSuccess(ChatRoom value) {
        
    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});

// 聊天室成员可以调用 checkIfInChatRoomWhiteList 查看自己是否在聊天室白名单中
ChatClient.getInstance().chatroomManager().checkIfInChatRoomWhiteList(chatRoomId, new ValueCallBack<Boolean>() {
    @Override
    public void onSuccess(Boolean value) {
        
    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});

// 聊天室所有者或管理员调用 fetchChatRoomWhiteList 获取当前的聊天室白名单列表
ChatClient.getInstance().chatroomManager().fetchChatRoomWhiteList(chatRoomId, new ValueCallBack<List<String>>() {
    @Override
    public void onSuccess(List<String> value) {
        
    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});
```



### 转让聊天室所有者、添加和移除聊天室管理员

聊天室所有者可以将权限移交给聊天室中指定成员。成功移交后，原聊天室所有者变为聊天室成员，新的聊天室所有者和聊天室管理员会收到 `onOwnerChanged` 回调。

聊天室所有者还可以添加聊天室管理员。成功添加后，新添加的聊天室管理员和其他管理员会收到 `onAdminAdded` 回调。

转让聊天室所有者、添加和移除聊天室管理员的示例代码如下：

```java
// 聊天室所有者调用 changeOwner 将权限移交给指定聊天室成员
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().changeOwner(chatRoomId, newOwner);

// 聊天室所有者调用 addChatRoomAdmin 添加聊天室管理员
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().addChatRoomAdmin(chatRoomId, admin);

// 聊天室所有者调用 removeChatRoomAdmin 移除聊天室管理员。被移除的聊天室管理员和其他管理员会收到 onAdminRemoved 回调
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().removeChatRoomAdmin(chatRoomId, admin);
```

### 管理聊天室公告

聊天室所有成员都可以获取聊天室公告；聊天室所有者和管理员可以设置和更新群公告。成功设置或更新后，聊天室成员会收到 `onAnnouncementChanged` 回调。示例代码如下：

```java
// 聊天室成员调用 fetchChatRoomAnnouncement 获取聊天室公告
String announcement = ChatClient.getInstance().chatroomManager().fetchChatRoomAnnouncement(chatRoomId);

// 聊天室所有者和管理员调用 updateChatRoomAnnouncement 设置或更新聊天室公告
ChatClient.getInstance().chatroomManager().updateChatRoomAnnouncement(chatRoomId, announcement);
```

### 监听聊天室事件

`ChatRoomManager` 中提供了聊天室事件的监听接口。你可以通过设置此监听，获取到聊天室中的事件，并作出相应的处理。如果不再使用该监听，需要移除，防止出现内存泄露。

监听聊天室事件的示例代码如下：

```java
public interface ChatRoomChangeListener {
    /**
     * 聊天室被解散
     * 
     * @param roomId        聊天室 ID
     * @param roomName      聊天室名称
     */
    void onChatRoomDestroyed(final String roomId, final String roomName);

    /**
     * 聊天室加入新成员事件
     * 
     * @param roomId        聊天室 ID
     * @param participant   新成员 username
     */
    void onMemberJoined(final String roomId, final String participant);

    /**
     * 聊天室成员主动退出事件
     * 
     * @param roomId        聊天室 ID
     * @param roomName      聊天室名字
     * @param participant   退出的成员 ID
      */
    void onMemberExited(final String roomId, final String roomName, final String participant);

    /**
     * 聊天室人员被移除
     *
     * @param reason        被聊天室管理员移除或由于当前设备断网被服务器移出聊天室
     *                      {@link io.agora.chat.adapter.EMAChatRoomManagerListener#BE_KICKED}
     *                      {@link io.agora.chat.adapter.EMAChatRoomManagerListener#BE_KICKED_FOR_OFFLINE}
     * @param roomId        聊天室 ID
     * @param roomName      聊天室名字
     * @param participant   被移除人员 ID
     */
    void onRemovedFromChatRoom(final int reason, final String roomId, final String roomName, final String participant);

    /**
     * 有成员被禁言
     * 禁言期间成员不能发送发消息
     *
     * @param chatRoomId    聊天室 ID
     * @param mutes         禁言的成员
     * @param expireTime    禁言有效期，单位是毫秒
     */
    void onMuteListAdded(final String chatRoomId, final List<String> mutes, final long expireTime);

    /**
     * 成员从禁言列表中移除
     *
     * @param chatRoomId    聊天室 ID
     * @param mutes         从禁言列表中移除的成员名单
     */
    void onMuteListRemoved(final String chatRoomId, final List<String> mutes);

    /**
     * 白名单成员增加
     *
     * @param chatRoomId    聊天室 ID
     * @param whitelist     白名单中增加的成员名单
     */
    void onWhiteListAdded(final String chatRoomId, final List<String> whitelist);

    /**
     * 白名单成员减少
     *
     * @param chatRoomId    聊天室 ID
     * @param whitelist     白名单中移除的成员名单
     */
    void onWhiteListRemoved(final String chatRoomId, final List<String> whitelist);

    /**
     * 全员禁言状态的改变
     *
     * @param chatRoomId    聊天室 ID
     * @param isMuted       是否开启了全员禁言
     */
    void onAllMemberMuteStateChanged(final String chatRoomId, final boolean isMuted);

    /**
     * 有成员提升为管理员权限
     *
     * @param chatRoomId    聊天室 ID
     * @param admin         提升的管理员
     */
    void onAdminAdded(final String chatRoomId, final String admin);

    /**
     * 移除管理员权限
     *
     * @param  chatRoomId   聊天室 ID
     * @param  admin        被移除的管理员
     */
    void onAdminRemoved(final String chatRoomId, final String admin);

    /**
     * 转移聊天室所有者
     *
     * @param chatRoomId    聊天室 ID
     * @param newOwner      新聊天室所有者
     * @param oldOwner      原聊天室所有者
     */
    void onOwnerChanged(final String chatRoomId, final String newOwner, final String oldOwner);


    /**
     * 聊天室公告更改事件
     * @param chatRoomId    聊天室 ID
     * @param announcement  更新的公告内容
     */
    void onAnnouncementChanged(String chatRoomId, String announcement);
}

// 注册聊天室回调
ChatClient.getInstance().chatroomManager().addChatRoomChangeListener(chatRoomChangeListener);

// 移除聊天室回调
ChatClient.getInstance().chatroomManager().removeChatRoomListener(chatRoomChangeListener);
```