聊天室是支持多人沟通的即时通讯系统。聊天室中的成员没有固定关系，用户离线后，超过 5 分钟会自动退出聊天室。聊天室成员在离线后，不会收到推送消息。聊天室可以应用于直播、消息广播等。

本页介绍如何使用即时通讯 IM SDK 在应用中创建和管理聊天室。

聊天室消息相关内容见 [消息管理](./agora_chat_message_overview)。

## 技术原理

即时通讯 IM SDK 提供了聊天室管理的 `ChatManager` 和 `ChatRoom` 类，可以实现以下功能：

- 创建、解散聊天室
- 从服务器获取聊天室列表和指定聊天室的详情
- 监听聊天室事件

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Android 快速开始](./agora_chat_get_started_android)。
- 了解 [使用限制](./agora_chat_limitation)。
- 了解即时通讯 IM 不同版本的聊天室相关数量限制，详见 [套餐包详情](./agora_chat_plan)。
- 仅超级管理员才能创建聊天室。确保你已调用 [添加超级管理员的 RESTful API](./agora_chat_restful_chatroom_superadmin?platform=RESTful#添加超级管理员) 添加了超级管理员。
- 聊天室创建者和管理员的数量之和不能超过 100，即管理员最多可添加 99 个。

## 实现方法

本节介绍如何调用即时通讯 IM SDK 提供的 API 实现上述功能。

### 创建聊天室

仅[超级管理员](./agora_chat_restful_chatroom_superadmin?platform=RESTful#添加聊天室超级管理员) 可以调用 `createChatRoom` 创建聊天室，设置聊天室名称、描述、最大成员数等聊天室属性。创建聊天室后，超级管理员自动成为聊天室所有者。

你也可以直接调用 RESTful API [从服务端创建聊天室](./agora_chat_restful_chatroom#创建聊天室)。

示例代码如下：

```java
ChatRoom  chatRoom = ChatClient.getInstance().chatroomManager().createChatRoom(subject, description, welcomMessage, maxUserCount, members);
```

### 解散聊天室

仅聊天室所有者可以调用 `destroyChatRoom` 方法解散聊天室。聊天室解散时，其他成员收到 `onChatRoomDestroyed` 回调并被踢出聊天室。

```java 
ChatClient.getInstance().chatroomManager().destroyChatRoom(chatRoomId);
```

### 获取聊天室列表和详情

- 聊天室所有成员都可以调用 `fetchPublicChatRoomsFromServer` 获取从服务器获取聊天室列表，每次最多可获取 1,000 个。获取聊天室列表后，可使用聊天室 ID 查询指定聊天室的基本信息。

```java
PageResult<ChatRoom> chatRooms = ChatClient.getInstance().chatroomManager().
                            fetchPublicChatRoomsFromServer(pageNumber, pageSize);
```

- 聊天室所有成员均可调用 `fetchChatRoomFromServer` 获取聊天室的详情，包括聊天室 ID、聊天室名称，聊天室描述、最大成员数、聊天室所有者、是否全员禁言以及聊天室角色类型。聊天室公告、管理员列表、成员列表、黑名单列表和禁言列表需单独调用接口获取。

```java
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
    // 聊天室被解散。聊天室的所有成员会收到该事件。
    void onChatRoomDestroyed(final String roomId, final String roomName);

    // 有用户加入聊天室。聊天室的所有成员（除新成员外）会收到该事件。
    void onMemberJoined(final String roomId, final String participant);

    // 有成员主动退出聊天室。聊天室的所有成员（除退出成员外）会收到该事件。
    void onMemberExited(final String roomId, final String roomName, final String participant);

    /**
     * 有成员被踢出聊天室。被踢出聊天室的成员会收到该事件。
     *
     * @param reason        用户被移出聊天室的原因：
     *                        - xxx BE_KICKED：该用户被聊天室管理员移出；
     *                        - xxxBE_LICKED)FOR_OFFLINE：该用户由于当前设备断网被服务器移出聊天室。
     */
    void onRemovedFromChatRoom(final int reason, final String roomId, final String roomName, final String participant);

    // 有成员被加入禁言列表。聊天室所有者、管理员和被禁言的成员会收到该事件。
    void onMuteListAdded(final String chatRoomId, final List<String> mutes, final long expireTime);

    // 有成员被移出禁言列表。聊天室所有者、管理员和被解除禁言的成员会收到该事件。
    void onMuteListRemoved(final String chatRoomId, final List<String> mutes);

    // 有成员被加入白名单列表。被添加的成员及聊天室所有者和管理员（除操作者外）会收到该事件。
    void onWhiteListAdded(final String chatRoomId, final List<String> whitelist);

    // 有成员被移出白名单列表。被移出的成员及聊天室所有者和管理员（除操作者外）会收到该事件。
    void onWhiteListRemoved(final String chatRoomId, final List<String> whitelist);

    // 全员禁言状态变更。聊天室所有者、管理员和禁言状态变更的成员会收到该事件。
    void onAllMemberMuteStateChanged(final String chatRoomId, final boolean isMuted);

    // 有成员被设为管理员。新管理员、聊天室所有者和其他管理员会收到该事件。
    void onAdminAdded(final String chatRoomId, final String admin);

    // 有成员被移除管理员权限。被移除管理权限的管理员、聊天室所有者和其他管理员会收到该事件。
    void onAdminRemoved(final String chatRoomId, final String admin);

    // 聊天室所有者变更。聊天室的所有成员会收到该事件。
    void onOwnerChanged(final String chatRoomId, final String newOwner, final String oldOwner);

    // 聊天室公告变更。聊天室的所有成员（除操作者）会收到该事件。
    void onAnnouncementChanged(String chatRoomId, String announcement);

    // 聊天室自定义属性有更新。聊天室的所有成员会收到该事件。
    default void onChatroomAttributesDidChanged(String chatRoomId, Map<String,String> attributeMap , String from){}

    // 有聊天室自定义属性被移除
    default void onChatroomAttributesDidRemoved(String chatRoomId, List<String> keyList , String from){}

}
```