聊天室是支持多人沟通的即时通讯系统。本文介绍如何管理聊天室的属性信息。

## 技术原理

即时通讯 IM React Native SDK 提供 `ChatRoomManager` 类和 `ChatRoom` 类用于聊天室管理，支持你通过调用 API 在项目中实现如下功能：

- 获取聊天室公告
- 更新聊天室公告
- 更新聊天室名称
- 更新聊天室描述

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_rn?platform=rn)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation?platform=rn)。
- 了解不同版本的聊天室相关数量限制，详见 [套餐包详情](./agora_chat_plan?platform=rn)。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 获取聊天室公告

聊天室所有成员均可调用 `fetchChatRoomAnnouncement` 方法获取聊天室公告。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.fetchChatRoomAnnouncement(roomId)
  .then((ann) => {
    console.log("get ann success.", ann);
  })
  .catch((reason) => {
    console.log("get ann fail.", reason);
  });
```

### 更新聊天室公告

仅聊天室所有者和聊天室管理员可以调用 `updateChatRoomAnnouncement` 方法设置和更新聊天室公告，聊天室公告的长度限制为 512 个字符。公告更新后，其他聊天室成员收到 `onAnnouncementChanged` 回调。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.updateChatRoomAnnouncement(roomId, announcement)
  .then(() => {
    console.log("update ann success.");
  })
  .catch((reason) => {
    console.log("update ann fail.", reason);
  });
```

### 更新聊天室名称

仅聊天室所有者和聊天室管理员可以调用 `changeChatRoomSubject` 方法设置和更新聊天室名称，聊天室名称的长度限制为 128 个字符。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.changeChatRoomSubject(roomId, subject)
  .then(() => {
    console.log("change subject success.");
  })
  .catch((reason) => {
    console.log("change subject fail.", reason);
  });
```

### 更新聊天室描述

仅聊天室所有者和聊天室管理员可以调用 `changeChatroomDescription` 方法设置和更新聊天室描述，聊天室描述的长度限制为 512 个字符。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.changeChatRoomDescription(roomId, desc)
  .then(() => {
    console.log("change desc success.");
  })
  .catch((reason) => {
    console.log("change desc fail.", reason);
  });
```

### 监听聊天室事件

有关详细信息，请参阅 [监听聊天室事件](./agora_chat_chatroom_rn?platform=rn#监听聊天室事件)。