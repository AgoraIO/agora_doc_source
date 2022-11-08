聊天室是支持多人沟通的即时通讯系统。聊天室属性可分为聊天室名称、描述和公告等基本属性和自定义属性（key-value）。若聊天室基本属性不满足业务要求，用户可增加自定义属性并同步给所有成员。利用自定义属性可以存储直播聊天室的类型、狼人杀等游戏中的角色信息和游戏状态以及实现语聊房的麦位管理和同步等。聊天室自定义属性以键值对（key-value）形式存储，属性信息变更会实时同步给聊天室成员。

## 技术原理

即时通讯 IM SDK 提供 `Room`、`IRoomManager` 和 `IRoomManagerDelegate` 类用于聊天室管理，支持你通过调用 API 在项目中实现如下功能：

- 获取和更新聊天室基本属性；
- 获取聊天室自定义属性；
- 设置聊天室自定义属性；
- 删除聊天室自定义属性。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_unity)。
- 了解 [使用限制](./agora_chat_limitation)。
- 了解聊天室的数量限制，详见 [套餐包详情](./agora_chat_plan)。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 管理聊天室基本属性

对于聊天室名称和描述，你可以调用 [`FetchRoomInfoFromServer`](./agora_chat_chatroom_unity#获取聊天室详情) 获取聊天室详情时查看。

#### 修改聊天室名称

仅聊天室所有者和聊天室管理员可以调用 `ChangeRoomName` 方法设置和修改聊天室名称，聊天室名称的长度限制为 128 个字符。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.ChangeRoomName(roomId, name, new CallBack(
    onSuccess: () => {
    },
    onError: (code, desc) => {
    }
));
```

#### 修改聊天室描述

仅聊天室所有者和聊天室管理员可以调用 `ChangeRoomDescription` 方法设置和修改聊天室描述，聊天室描述的长度限制为 512 个字符。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.ChangeRoomDescription(roomId, newDesc, new CallBack(
    onSuccess: () => {
    },
    onError: (code, desc) => {
    }
));
```

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

### 管理聊天室自定义属性（key-value）

#### 获取聊天室自定义属性

聊天室所有成员均可调用 `FetchAttributes` 方法获取聊天室自定义属性。

示例代码如下：

```c#
/**
 * 异步方法。
 *
 * @param String roomId            聊天室 ID。
 * @param List<String> keys        聊天室自定义属性的 Key 列表。传 `null` 或空字符串时返回所有自定义属性。
 * @param ValueCallBack            结果回调，成功时回调 {@link ValueCallBack#onSuccess(Object)}，
 *                                 失败时回调 {@link ValueCallBack#onError(int, String)}。
 */
SDKClient.Instance.RoomManager.FetchAttributes(roomId, keys, new ValueCallBack<Dictionary<string, string>>(
    onSuccess: (Dictionary<string, string> dict) => {
    },
    onError: (code, desc) => {
    }
));
```

#### 设置聊天室自定义属性

所有聊天室成员均可调用 `AddAttributes` 方法设置一个或多个聊天室自定义属性。利用该方法可设置新属性，也可以修改自己或其他成员设置的现有属性。设置后，其他聊天室成员收到 `OnChatroomAttributesChanged` 回调。

示例代码如下：

```c#
/**
 * 异步方法。
 *
 * @param String  roomId                  聊天室 ID。
 * @param Dictionary<string, string> kv   新增的属性。
 * @param bool deleteWhenExit             当前成员退出聊天室时是否自动删除其设置的自定义属性。
 *       - （默认）`true`：是；
 *       - `false`：否。
 * @param bool forced                     是否覆盖其他成员设置的 key 相同的属性。
 *       - （默认）`true`：是；
 *       - `false`：否。
 * @param CallBackResult                  回调对象。
 */
SDKClient.Instance.RoomManager.AddAttributes(roomId, kv, deleteWhenExit, forced, new CallBackResult(
    onSuccessResult: (Dictionary<string, int> failInfo) => {
        if(failInfo.Count == 0)
        {
            // 所有聊天室自定义属性成功添加。
        }
        else
        {
            // 部分聊天室自定义属性添加失败。
        }
    },
    onError: (code, desc) => {
    }
));
```

#### 删除聊天室自定义属性

所有聊天室成员均可以调用 `RemoveAttributes` 方法删除一个或多个聊天室自定义属性。利用该方法可删除自己和其他成员设置的自定义属性。删除后，聊天室其他成员收到 `OnChatroomAttributesRemoved` 回调。

示例代码如下：

```c#
/**
 * 异步方法。
 *
 * @param String roomId             聊天室 ID。
 * @param String keys               待删除属性的键值。
 * @param bool forced               是否删除其他成员设置的 key 相同的属性。
 * @param CallBackResult            结果回调，成功时回调 {@link CallBackResult#onSuccessResult(int,Object)}，
 *                                  失败时回调 {@link CallBackResult#onError(int, String)}。
 */
SDKClient.Instance.RoomManager.RemoveAttributes(roomId, keys, forced, new CallBackResult(
    onSuccessResult: (Dictionary<string, int> failInfo) => {
        if (failInfo.Count == 0)
        {
            // 所有聊天室自定义属性成功删除。
        }
        else
        {
            // 部分聊天室自定义属性删除失败。
        }
    },
    onError: (code, desc) => {
    }
));
```

### 监听聊天室事件

有关详细信息，请参阅 [监听聊天室事件](./agora_chat_chatroom_unity#监听聊天室事件)。