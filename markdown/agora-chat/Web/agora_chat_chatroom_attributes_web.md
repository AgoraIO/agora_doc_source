# 聊天室-管理聊天室属性

聊天室是支持多人沟通的即时通讯系统。本文介绍如何管理聊天室的属性信息。

## 技术原理

环信即时通讯 IM SDK 支持你通过调用 API 在项目中实现如下聊天室属性管理功能：

- `getChatRoomDetails` 获取聊天室详情；
- `modifyChatRoom` 更新聊天室详情；
- `fetchChatRoomAnnouncement` 获取聊天室公告；
- `updateChatRoomAnnouncement` 修改聊天室公告。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Web 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_web?platform=Web)。
- 了解即时通讯 IM 的 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Web)。
- 了解聊天室的数量限制，详见 [套餐包详情](https://docs.agora.io/en/agora-chat/agora_chat_plan?platform=Web)。

## 实现方法

### 获取聊天室详情

聊天室所有成员可以通过 `getChatRoomDetails` 方法获取聊天室详情。

聊天室详情包括聊天室名称、公告、描述、成员类型、管理员列表、当前聊天人数和聊天室最大成员数等。

示例代码如下：

```javascript
let option = {
    chatRoomId: 'chatRoomId'
}
conn.getChatRoomDetails(option).then(res => console.log(res))
```

### 更新聊天室详情

聊天室所有者和管理员可以更新聊天室详情，聊天室成员可以获取聊天室详情。

示例代码如下：

```javascript
let option = {
    chatRoomId: 'chatRoomId',
    chatRoomName: 'chatRoomName', // 聊天室名称。
    description: 'description',   // 聊天室描述。
    maxusers: 200                 // 聊天室最大成员数。
}
conn.modifyChatRoom(option).then(res => console.log(res))
```

### 获取聊天室公告

聊天室所有成员均可调用 `fetchChatRoomAnnouncement` 方法获取聊天室公告。

示例代码如下：

```javascript
var option = {
    roomId: 'roomId'
};
conn.fetchChatRoomAnnouncement(option).then(res => console.log(res))
```

### 更新聊天室公告

仅聊天室所有者和管理员可以设置和更新聊天室公告。聊天室公告的长度限制为 512 个字符。公告更新后，其他聊天室成员收到 `updateAnnouncement` 事件。

示例代码如下：

```javascript
let option = {
    roomId: 'roomId',
    announcement: 'hello everyone'
};
conn.updateChatRoomAnnouncement(option).then(res => console.log(res))
```

### 监听聊天室事件

有关详细信息，请参阅 [监听聊天室事件](https://docs.agora.io/en/agora-chat/agora_chat_chatroom_web?platform=Web#监听聊天室事件)。