# 管理聊天室成员

聊天室是支持多人沟通的即时通讯系统。本文指导你如何使用 Agora Chat SDK 在实时互动 app 中实现聊天室的相关功能。

## 技术原理

Agora Chat SDK 提供 `Room`、`IRoomManager` 和 `IRoomManagerDelegate` 类用于聊天室管理，支持你通过调用 API 在项目中实现如下功能：

- 将成员移除聊天室
- 获取聊天室成员列表
- 管理聊天室黑名单
- 管理聊天室禁言列表
- 管理聊天室所有者及管理员

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速入门](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_get_started_unity)；
- 了解 Agora Chat API 的接口调用频率限制，详见 [使用限制](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_limitation_unity)；
- 了解聊天室的数量限制，详见 [套餐包详情](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_plan)。

## 实现方法

本节介绍如何使用 Agora Chat SDK 提供的 API 实现上述功能。

### 将成员移出聊天室

仅聊天室所有者和聊天室管理员可以调用 `DeleteRoomMembers` 方法将指定成员移出聊天室。被移出后，该成员收到 `OnRemovedFromRoom` 回调，其他成员收到 `OnMemberExitedFromRoom` 回调。被移出聊天室后，该用户还可以再次加入聊天室。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.DeleteRoomMembers(roomId, members, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) => {
  }
));
```

### 获取聊天室成员列表

所有聊天室成员均可以调用 `FetchRoomMembers` 方法获取当前聊天室的成员列表。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.FetchRoomMembers(roomId, cursor, pageSize, handle: new ValueCallBack<CursorResult<string>>(
  // members 类型为 CursorResult<string>。
  onSuccess: (members) => {
  },
  onError: (code, desc) => {
  }
));
```

### 管理聊天室黑名单

#### 将成员加入聊天室黑名单

仅聊天室所有者和管理员可以调用 `BlockRoomMembers` 方法将指定成员添加至黑名单。被加入黑名单后，该成员收到 `OnRemovedFromRoom` 回调，其他成员收到 `OnMemberExitedFromRoom` 回调。被加入黑名单后，该成员无法再收发聊天室消息并被移出聊天室，黑名单中的成员如想再次加入聊天室，聊天室所有者或管理员必须先将其移除黑名单。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.BlockRoomMembers(roomId, members, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### 将成员移出聊天室黑名单

仅聊天室所有者和管理员可以调用 `UnBlockRoomMembers` 方法将成员移出聊天室黑名单。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.UnBlockRoomMembers(roomId, members, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) => {
  }
));
```

#### 获取聊天室黑名单

仅聊天室所有者和管理员可以调用 `FetchRoomBlockList` 方法获取当前聊天室黑名单。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.FetchRoomBlockList(roomId, pageNum, pageSize, handle: new ValueCallBack<List<string>>(
  // list 类型为 List<string>。
  onSuccess: (list) => {
  },
  onError: (code, desc) => {
  }
));
```

### 管理聊天室禁言列表

#### 添加成员至聊天室禁言列表

仅聊天室所有者和管理员可以调用 `MuteRoomMembers` 方法将指定成员添加至聊天室禁言列表。被禁言后，该成员和其他未操作的聊天室管理员或聊天室所有者收到 `OnMuteListAddedFromRoom` 回调。

**注意**：聊天室所有者可禁言聊天室所有成员，聊天室管理员可禁言聊天室普通成员。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.MuteRoomMembers(roomId, members, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) => {
  }
));
```

#### 将成员移出聊天室禁言列表

仅聊天室所有者和管理员可以调用 `UnMuteRoomMembers` 方法将成员移出聊天室禁言列表。被解除禁言后，该成员和其他未操作的聊天室管理员或聊天室所有者收到 `OnMuteListRemovedFromRoom` 回调。

**注意**：聊天室所有者可对聊天室所有成员解除禁言，聊天室管理员可对聊天室普通成员解除禁言。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.UnMuteRoomMembers(roomId, members, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) => {
  }
));
```

#### 获取聊天室禁言列表

仅聊天室所有者和管理员可以调用 `FetchRoomMuteList` 方法获取当前聊天室的禁言列表。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.FetchRoomMuteList(roomId, pageSize, pageNum, handle: new ValueCallBack<List<string>>(
  // list 类型为 List<string>
  onSuccess: (list) => {
  },
  onError: (code, desc) => {
  }
));
```

### 管理聊天室所有者和管理员

#### 转让聊天室所有者

仅聊天室所有者可以调用 `ChangeRoomOwner` 方法将权限移交给聊天室中指定成员。成功移交后，原聊天室所有者变为聊天室成员，新的聊天室所有者和聊天室管理员收到 `OnOwnerChangedFromRoom` 回调。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.ChangeRoomOwner(roomId, newOwner, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) => {
  }
));
```

#### 添加聊天室管理员

仅聊天室所有者可以调用 `AddRoomAdmin` 方法添加聊天室管理员。成功添加后，新管理员及其他管理员收到 `OnAdminAddedFromRoom` 回调。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.AddRoomAdmin(roomId, adminId, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) => {
  }
));
```

#### 移除聊天室管理员

仅聊天室所有者可以调用 `RemoveRoomAdmin` 方法移除聊天室管理员。成功移除后，被移除的管理员及其他管理员收到 `OnAdminRemovedFromRoom` 回调。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.RemoveRoomAdmin(roomId, adminId, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) => {
  }
));
```

### 监听聊天室事件

详见 [监听聊天室事件](https://docs-preprod.agora.io/cn/null/agora_chat_chatroom_unity?platform=Unity#%E7%9B%91%E5%90%AC%E8%81%8A%E5%A4%A9%E5%AE%A4%E4%BA%8B%E4%BB%B6)。