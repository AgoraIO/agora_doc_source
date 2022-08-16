# 管理聊天室
聊天室是支持多人沟通的即时通讯系统。聊天室中的成员没有固定关系，用户离线后，超过 5 分钟会自动退出聊天室。聊天室成员在离线后，不会收到推送消息。聊天室可以应用于直播、消息广播等。

本页介绍如何使用即时通讯 IM（环信）SDK 在应用中创建和管理聊天室。

消息相关内容见 [消息管理](https://docs-preprod.agora.io/en/agora-chat/agora_chat_message_overview?platform=Android)。

## 技术原理

即时通讯 IM（环信）SDK 提供了聊天室管理的 `ChatManager` 和 `ChatRoom` 类，可以实现以下功能：

- 创建和解散聊天室
- 加入和退出聊天室
- 从服务器获取聊天室列表
- 获取聊天室的详情
- 监听聊天室事件

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Android 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_android?platform=Android)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Android)中所述。
- 了解即时通讯 IM 不同版本的聊天室相关数量限制，详见 [套餐包详情](https://docs.agora.io/en/agora-chat/agora_chat_plan?platform=Android)中所述，您了解不同定价计划支持的聊天室数量。
- 只有超级管理员才有创建聊天室的权限。确保你已通过调用 [super-admin RESTful API](https://docs.agora.io/en/agora-chat/agora_chat_restful_chatroom_superadmin?platform=RESTful#adding-a-chat-room-super-admin) 添加了超级管理员。
- 聊天室创建者和管理员的数量之和不能超过 100，即管理员最多可添加 99 个。

## 实现方法

本节介绍如何调用即时通讯 IM（环信）SDK 提供的 API 来实现上述功能。

### 创建和解散聊天室

仅 [超级管理员](https://docs.agora.io/en/agora-chat/agora_chat_restful_chatroom_superadmin?platform=RESTful#adding-a-chat-room-super-admin) 可以调用 `createChatRoom` 创建聊天室，设置聊天室名称、描述、最大成员数等聊天室属性。

你也可以直接调用 [super-admin RESTful API](https://docs.agora.io/en/agora-chat/agora_chat_restful_chatroom_superadmin?platform=RESTful#adding-a-chat-room-super-admin) 创建聊天室。

示例代码如下：

```java
// 创建聊天室
ChatRoom  chatRoom = ChatClient.getInstance().chatroomManager().createChatRoom(subject, description, welcomMessage, maxUserCount, members);

// 解散聊天室
// 仅聊天室所有者可以调用 `destroyChatRoom` 方法解散聊天室。聊天室解散时，其他成员收到 `onChatRoomDestroyed` 回调并被踢出聊天室。
ChatClient.getInstance().chatroomManager().destroyChatRoom(chatRoomId);
```

### 加入和离开聊天室

所有聊天用户都可以调用 `joinChatRoom` 加入指定的聊天室。

```java
// 调用 `joinChatRoom` 方法传入聊天室 ID，申请加入对应聊天室。新成员加入聊天室时，其他成员收到 `onMemberJoined` 回调。
ChatClient.getInstance().chatroomManager().joinChatRoom(chatRoomId, new ValueCallBack<ChatRoom>() {
    @Override
    public void onSuccess(ChatRoom value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});

// 聊天室所有成员均可以调用 `leaveChatRoom` 方法退出当前聊天室。成员退出聊天室时，其他成员收到 `onMemberExited` 回调。
ChatClient.getInstance().chatroomManager().leaveChatRoom(chatRoomId);
```

默认情况下，离开聊天室时，SDK 会删除本地设备上的所有聊天室消息。如果不想删除这些消息，请设置 `ChatOptions` 中 `setDeleteMessagesAsExitChatRoom` 为 `false`。

### 获取公开聊天室列表和详情

所有聊天用户都可以从服务器获取聊天室列表，并使用聊天室 ID 检索指定聊天室的基本信息。

```java
// 调用 `fetchPublicChatRoomsFromServer` 获取公开聊天室列表，每次最多可获取 1,000 个。
PageResult<ChatRoom> chatRooms = ChatClient.getInstance().chatroomManager().
                            fetchPublicChatRoomsFromServer(pageNumber, pageSize);

// 聊天室所有成员均可调用 `fetchChatRoomFromServer` 获取聊天室的详情，包括聊天室 ID、聊天室名称，聊天室描述、聊天室公告、管理员列表、最大成员数、聊天室所有者、是否全员禁言以及聊天室角色类型。成员列表、黑名单列表、禁言列表需单独调用接口获取。
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().fetchChatRoomFromServer(chatRoomId);
```

### 监听聊天室事件

`ChatRoomChangeListener` 类中提供了聊天室事件的监听接口。你可以通过注册聊天室监听器，获取聊天室事件，并作出相应处理。如不再使用该监听器，需要移除，防止出现内存泄露。

示例代码如下：

```java
// 注册聊天室监听
ChatClient.getInstance().chatroomManager().addChatRoomChangeListener(chatRoomChangeListener);

// 移除聊天室监听
ChatClient.getInstance().chatroomManager().removeChatRoomListener(chatRoomChangeListener);
```

具体事件如下：

```java
public interface ChatRoomChangeListener {
    // 聊天室被解散
    void onChatRoomDestroyed(final String roomId, final String roomName);

    // 有用户加入聊天室
    void onMemberJoined(final String roomId, final String participant);

    // 有成员离开聊天室
    void onMemberExited(final String roomId, final String roomName, final String participant);

    /**
     * 有成员被移出聊天室
     *
     * @param reason        用户被移出聊天室的原因：
     *                        - xxx BE_KICKED：该用户被聊天室管理员移出；
     *                        - xxxBE_LICKED)FOR_OFFLINE：该用户由于当前设备断网被服务器移出聊天室。
     */
    void onRemovedFromChatRoom(final int reason, final String roomId, final String roomName, final String participant);

    // 有成员被加入禁言列表
    void onMuteListAdded(final String chatRoomId, final List<String> mutes, final long expireTime);

    // 有成员被移出禁言列表
    void onMuteListRemoved(final String chatRoomId, final List<String> mutes);

    // 有成员被加入白名单列表
    void onWhiteListAdded(final String chatRoomId, final List<String> whitelist);

    // 有成员被移出白名单列表
    void onWhiteListRemoved(final String chatRoomId, final List<String> whitelist);

    // 全员禁言状态变更
    void onAllMemberMuteStateChanged(final String chatRoomId, final boolean isMuted);

    // 有成员被设为管理员
    void onAdminAdded(final String chatRoomId, final String admin);

    // 有成员被移除管理员权限
    void onAdminRemoved(final String chatRoomId, final String admin);

    // 聊天室所有者变更
    void onOwnerChanged(final String chatRoomId, final String newOwner, final String oldOwner);

    // 聊天室公告变更
    void onAnnouncementChanged(String chatRoomId, String announcement);
}
```
