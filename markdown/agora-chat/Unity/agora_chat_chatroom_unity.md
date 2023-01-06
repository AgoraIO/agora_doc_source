聊天室是支持多人沟通的即时通讯系统。聊天室中的成员没有固定关系，用户离线后，超过 5 分钟会自动退出聊天室。聊天室成员在离线后，不会收到推送消息。聊天室可以应用于直播、消息广播等。

本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中创建和管理聊天室，并实现聊天室的相关功能。

消息相关内容见 [消息管理](./agora_chat_send_receive_message_unity)。

## 技术原理

即时通讯 IM SDK 提供 `Room`、`IRoomManager` 和 `IRoomManagerDelegate` 类用于聊天室管理，支持你通过调用 API 在项目中实现如下功能：

- 创建聊天室
- 从服务器获取聊天室列表
- 加入聊天室
- 获取聊天室详情
- 退出聊天室
- 解散聊天室
- 监听聊天室事件

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_unity)。
- 了解 [使用限制](./agora_chat_limitation)。
- 了解聊天室和聊天室成员的数量限制，详见 [套餐包详情](./agora_chat_plan)。
- 只有应用超级管理员才有创建聊天室的权限。确保已调用 [super-admin RESTful API](./agora_chat_restful_chatroom_superadmin#添加超级管理员) 添加了应用超级管理员。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 创建聊天室

只有 [应用超级管理员](./agora_chat_restful_chatroom_superadmin) 可以调用 `CreateRoom` 方法创建聊天室并设置聊天室名称、描述、最大成员数等聊天室属性。创建聊天室后，该超级管理员自动成为聊天室所有者。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.CreateRoom(
// 聊天室名称，不能超过 128 个字符
subject,
// 聊天室描述， 不能超过 512 个字符
description,
// 欢迎消息
welcomeMsg,
// 最大成员数
maxUserCount,
// 聊天室成员列表
members,
handle: new ValueCallBack<Room>(
  onSuccess: (room) => {
  },
  onError:(code, desc) => {
  }
));
```

### 加入聊天室

用户申请加入聊天室的步骤如下：

1. 调用 `FetchPublicRoomsFromServer` 方法从服务器获取聊天室列表，查询到想要加入的聊天室 ID。
2. 调用 `JoinPublicGroup` 方法传入聊天室 ID，申请加入对应聊天室。新成员加入聊天室时，其他成员收到 `OnMemberJoinedFromRoom` 回调。

示例代码如下：

```c#
// 获取公开聊天室列表，每次最多可获取 1,000 个。
SDKClient.Instance.RoomManager.FetchPublicRoomsFromServer(handle: new ValueCallBack<PageResult<Room>>(
    //result 为 PageResult<Room> 类型
    onSuccess: (result) => {
  },
  onError: (code, desc) => {
  }
));

// 加入聊天室
SDKClient.Instance.RoomManager.JoinRoom(roomId, new ValueCallBack<Room>(
    onSuccess: (room) => {
    },
    onError: (code, desc) => {
    }
));
```

### 获取聊天室详情

聊天室成员均可调用 `FetchRoomInfoFromServer` 获取聊天室详情，包括聊天室 ID、聊天室名称，聊天室描述、聊天室公告、管理员列表、最大成员数、聊天室所有者、是否全员禁言以及聊天室权限类型。成员列表、黑名单列表、禁言列表需单独调用接口获取。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.FetchRoomInfoFromServer(roomId, new ValueCallBack<Room>(
  onSuccess: (room) => {
  },
  onError: (code, desc) => {
  }
));
```

### 退出聊天室

聊天室所有成员均可以调用 `LeaveRoom` 方法退出当前聊天室。成员退出聊天室时，其他成员收到 `OnMemberExitedFromRoom` 回调。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.LeaveRoom(roomId, new CallBack(
    onSuccess: () => {
    },
    onError: (code, desc) => {
    }
));
```

退出聊天室时，SDK 默认删除该聊天室的所有本地消息，若要保留这些消息，可在 SDK 初始化时将 `Options#DeleteMessagesAsExitRoom` 设置为 `false`。

示例代码如下：

```c#
Options options = new Options();
options. DeleteMessagesAsExitRoom = false;
```

与群主无法退出群组不同，聊天室所有者可以离开聊天室，例如所有者从服务器下线则 5 分钟后自动离开聊天室。如果所有者重新进入聊天室仍是该聊天室的所有者。

### 解散聊天室

仅聊天室所有者可以调用 `DestroyRoom` 方法解散聊天室。聊天室解散时，其他聊天室成员收到 `OnDestroyedFromRoom` 回调并被踢出聊天室。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.DestroyRoom(roomId, new CallBack(
    onSuccess: () => {
    },
    onError: (code, desc) => {
    }
));
```

### 监听聊天室事件

`IRoomManagerDelegate` 类中提供了聊天室事件的监听接口。你可以通过注册聊天室监听器，获取聊天室事件，并作出相应处理。如不再使用该监听，需要移除，防止出现内存泄露。

示例代码如下：

```c#
// 实现监听器以及定义监听器对象
public class RoomManagerDelegate : IRoomManagerDelegate {
    ......
    public void OnDestroyedFromRoom(string roomId, string roomName)
    {
    }
    ......
}
// 注册聊天室回调
RoomManagerDelegate adelegate = new RoomManagerDelegate();
SDKClient.Instance.RoomManager.AddRoomManagerDelegate(adelegate);

// 移除聊天室回调
SDKClient.Instance.RoomManager.AddRoomManagerDelegate(adelegate);
```

具体可以添加的回调事件如下：

```c#
public interface IRoomManagerDelegate
{
    // 解除聊天室一键禁言。聊天室所有成员（除操作者外）会收到该事件。
    void OnDestroyedFromRoom(string roomId, string roomName);
    // 有用户加入聊天室。聊天室的所有成员（除新成员外）会收到该事件。
    void OnMemberJoinedFromRoom(string roomId, string participant);
    // 主动退出聊天室。聊天室的所有成员（除退出的成员）会收到该事件。
    void OnMemberExitedFromRoom(string roomId, string roomName, string participant);
    // 有成员被移出聊天室。被踢出的成员会收到该事件。
    void OnRemovedFromRoom(string roomId, string roomName, string participant);
    // 禁言指定成员。被禁言的成员会收到该事件。
    void OnMuteListAddedFromRoom(string roomId, List<string> mutes, long expireTime);
    // 解除对指定成员的禁言。被解除禁言的成员会收到该事件。
    void OnMuteListRemovedFromRoom(string roomId, List<string> mutes);
    // 设置管理员。被添加的管理员会收到该事件。
    void OnAdminAddedFromRoom(string roomId, string admin);
    // 移除管理员。被移除的管理员会收到该事件。
    void OnAdminRemovedFromRoom(string roomId, string admin);
    // 转让聊天室。聊天室所有成员会收到该事件。
    void OnOwnerChangedFromRoom(string roomId, string newOwner, string oldOwner);
    // 更新聊天室公告。聊天室的所有成员会收到该事件。
    void OnAnnouncementChangedFromRoom(string roomId, string announcement);
    // 聊天室自定义属性有更新。聊天室所有成员会收到该事件。
    void OnChatroomAttributesChanged(string roomId, Dictionary<string, string> kv, string from);
    // 聊天室自定义属性被移除。聊天室所有成员会收到该事件。
    void OnChatroomAttributesRemoved(string roomId, List<string> keys, string from);
    }
```