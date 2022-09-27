聊天室是支持多人沟通的即时通讯系统。本文介绍如何管理聊天室的属性信息。

## 技术原理

即时通讯 IM SDK 提供 `Room`、`IRoomManager` 和 `IRoomManagerDelegate` 类用于聊天室管理，支持你通过调用 API 在项目中实现如下功能：

- 获取聊天室公告
- 更新聊天室公告
- 更新聊天室名称
- 更新聊天室描述

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_unity)。
- 了解 [使用限制](./agora_chat_limitation)。
- 了解聊天室的数量限制，详见 [套餐包详情](./agora_chat_plan)。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 获取聊天室公告

聊天室所有成员均可以调用 `FetchRoomAnnouncement` 方法获取聊天室公告。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.FetchRoomAnnouncement(roomId, new ValueCallBack<string>(
  onSuccess: (str) => {
  },
  onError: (code, desc) => {
  }
));
```

### 更新聊天室公告

仅聊天室所有者和聊天室管理员可以调用 `UpdateRoomAnnouncement` 方法设置和更新聊天室公告，聊天室公告的长度限制为 512 个字符。公告更新后，其他聊天室成员收到 `OnAnnouncementChangedFromRoom` 回调。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.UpdateRoomAnnouncement(roomId, announcement, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) => {
  }
));
```

### 更新聊天室名称

仅聊天室所有者和聊天室管理员可以调用 `ChangeRoomName` 方法设置和更新聊天室名称，聊天室名称的长度限制为 128 个字符。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.ChangeRoomName(roomId, name, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) => {
  }
));
```

### 更新聊天室描述

仅聊天室所有者和聊天室管理员可以调用 `ChangeRoomDescription` 方法设置和更新聊天室描述，聊天室描述的长度限制为 512 个字符。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.ChangeRoomDescription(currentRoomId, description, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) => {
  }
));
```

### 监听聊天室事件

有关详细信息，请参阅 [监听聊天室事件](./agora_chat_chatroom_unity#监听聊天室事件)。