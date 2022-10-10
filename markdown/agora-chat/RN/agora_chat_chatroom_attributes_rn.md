聊天室是支持多人沟通的即时通讯系统。聊天室属性可分为聊天室名称、描述和公告等基本属性和自定义属性（key-value）。若聊天室基本属性不满足业务要求，用户可增加自定义属性并同步给所有成员。利用自定义属性可以存储直播聊天室的类型、狼人杀等游戏中的角色信息和游戏状态以及实现语聊房的麦位管理和同步等。聊天室自定义属性以键值对（key-value）形式存储，属性信息变更会实时同步给聊天室成员。

## 技术原理

即时通讯 IM React Native SDK 提供 `ChatRoomManager` 类和 `ChatRoom` 类用于聊天室管理，支持你通过调用 API 在项目中实现如下功能：

- 获取和更新聊天室基本属性；
- 获取聊天室自定义属性；
- 设置聊天室自定义属性；
- 删除聊天室自定义属性。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_rn?platform=rn)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation?platform=rn)。
- 了解不同版本的聊天室相关数量限制，详见 [套餐包详情](./agora_chat_plan?platform=rn)。

## 实现方法

本节介绍如何使用即时通讯 IM React Native SDK 提供的 API 实现上述功能。

### 管理聊天室基本属性

#### 获取聊天室名称和描述

对于聊天室名称和描述，你可以调用 [`fetchChatRoomInfoFromServer`](./agora_chat_chatroom_rn#获取聊天室详情) 方法获取聊天室详情时查看。

### 修改聊天室名称

仅聊天室所有者和聊天室管理员可以调用 `changeChatRoomSubject` 方法设置和修改聊天室名称，聊天室名称的长度限制为 128 个字符。

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

### 修改聊天室描述

仅聊天室所有者和聊天室管理员可以调用 `changeChatroomDescription` 方法设置和修改聊天室描述，聊天室描述的长度限制为 512 个字符。

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

### 管理聊天室自定义属性（key-value）

#### 获取聊天室自定义属性

聊天室所有成员均可调用 `fetchChatRoomAttributes` 方法获取聊天室自定义属性。

```typescript
// 通过设置聊天室 ID 和属性 key 获取聊天室一些自定义属性。
// 若传入的 key 为空，可获取聊天室所有属性。
ChatClient.getInstance()
  .roomManager.fetchChatRoomAttributes(roomId, keys)
  .then((response) => {
    rollLog(`success: ${response}`);
  })
  .catch((error) => {
    rollLog(`fail: ${error}`);
  });
```

#### 设置聊天室自定义属性

聊天室所有成员均可调用 `addAttributes` 方法设置一个或多个聊天室自定义属性。利用该方法可设置新属性，也可以修改自己或其他成员设置的现有属性。设置后，其他聊天室成员收到 `onAttributesUpdated` 回调。

```typescript
// 通过设置聊天室 ID 和属性的键值对集合设置聊天室自定义属性。
ChatClient.getInstance()
  .roomManager.addAttributes({
    roomId,
    attributes,
    deleteWhenLeft,
    overwrite,
  })
  .then((response) => {
    rollLog(`success: ${response}`);
  })
  .catch((error) => {
    rollLog(`fail: ${error}`);
  });
```

#### 删除聊天室自定义属性

聊天室所有成员均可调用 `removeAttributes` 方法删除一个或多个聊天室自定义属性。利用该方法可删除自己和其他成员设置的自定义属性。删除后，聊天室其他成员收到 `onAttributesRemoved` 回调。

```typescript
// 通过设置聊天室 ID 和属性 key 列表删除聊天室自定义属性。
ChatClient.getInstance()
  .roomManager.removeAttributes({
    roomId,
    keys,
    forced,
  })
  .then((response) => {
    rollLog(`success: ${response}`);
  })
  .catch((error) => {
    rollLog(`fail: ${error}`);
  });
```

### 监听聊天室事件

有关详细信息，请参阅 [监听聊天室事件](./agora_chat_chatroom_rn?platform=rn#监听聊天室事件)。