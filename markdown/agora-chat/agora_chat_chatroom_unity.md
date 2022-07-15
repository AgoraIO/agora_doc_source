# 管理聊天室

聊天室是支持多人沟通的即时通讯系统。聊天室中的成员没有固定关系，用户离线后，超过 5 分钟会自动退出聊天室。聊天室成员在离线后，不会收到推送消息。聊天室可以应用于直播、消息广播等。

本文指导你如何使用 Agora Chat SDK 在实时互动 app 中实现聊天室的相关功能。

## 技术原理

Agora Chat SDK 提供 `Room`、`IRoomManager` 和 `IRoomManagerDelegate` 类用于聊天室管理，支持你通过调用 API 在项目中实现如下功能：

- 创建、解散聊天室
- 加入、退出聊天室
- 获取聊天室详情
- 从服务器获取聊天室列表
- 监听聊天室事件

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速入门](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_get_started_unity)；
- 了解 Agora Chat API 的接口调用频率限制，详见 [使用限制](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_limitation_unity)；
- 了解聊天室的数量限制，详见 [套餐包详情](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_plan)；
- 只有超级管理员才有创建聊天室的权限，因此你还需要确保已调用 RESTful API 添加了超级管理员，详见 [添加聊天室超级管理员](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_restful_chatroom_superadmin#%E6%B7%BB%E5%8A%A0%E8%81%8A%E5%A4%A9%E5%AE%A4%E8%B6%85%E7%BA%A7%E7%AE%A1%E7%90%86%E5%91%98)。

## 实现方法

本节介绍如何使用 Agora Chat SDK 提供的 API 实现上述功能。

### 创建聊天室

仅 [超级管理员](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_restful_chatroom_superadmin) 可以调用 `CreateRoom` 方法创建聊天室，并设置聊天室的名称、描述、最大人数等信息。成功创建聊天室后，该超级管理员为聊天室所有者。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.CreateRoom(subject, description, welcomeMsg, maxUserCount, members,handle: new ValueCallBack<Room>(
  onSuccess: (room) => {
  },
  onError:(code, desc) => {
  }
));
```

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

### 加入聊天室

用户申请加入聊天室的步骤如下：

1. 调用 `FetchPublicRoomsFromServer` 方法从服务器获取聊天室列表，查询到想要加入的聊天室 ID。

2. 调用 `JoinPublicGroup` 方法传入聊天室 ID，申请加入对应聊天室。新成员加入聊天室时，其他成员收到 `OnMemberJoinedFromRoom` 回调。

示例代码如下：

```c#
// 获取公开聊天室列表
SDKClient.Instance.RoomManager.FetchPublicRoomsFromServer(handle: new ValueCallBack<PageResult<Room>>(
            //result 为 PageResult<Room> 类型
            onSuccess: (result) => {
            },
            onError:(code, desc) => {
            }
        ));

// 申请加入聊天室
SDKClient.Instance.RoomManager.JoinRoom(roomId, new ValueCallBack<Room>(
  onSuccess: (room) => {
  },
  onError: (code, desc) => {
  }
));
```

### 退出聊天室

聊天室所有成员均可以调用 `LeaveRoom` 方法退出指定聊天室。成员退出聊天室时，其他成员收到 `OnMemberExitedFromRoom` 回调。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.LeaveRoom(roomId, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) => {
  }
));
```

离开聊天室时，SDK 默认删除该聊天室的所有本地消息，若要保留这些消息，在初始化 SDK 时将 `Options#DeleteMessagesAsExitRoom` 设置为 `false`。

示例代码如下：

```c#
Options options = new Options();
options. DeleteMessagesAsExitRoom = false;
```

### 获取聊天室详情

聊天室成员可以调用 `FetchRoomInfoFromServer` 获取聊天室详情，包括聊天室 ID、聊天室名称，聊天室描述、聊天室公告、管理员列表、成员列表、黑名单列表、禁言列表、最大成员数、聊天室所有者、是否全员禁言以及聊天室权限类型。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.FetchRoomInfoFromServer(roomId, new ValueCallBack<Room>(
  onSuccess: (room) => {
  },
  onError: (code, desc) => {
  }
));
```

### 从服务器获取指定数目的聊天室

用户可以调用 `FetchPublicRoomsFromServer` 方法从服务器获取指定数目的聊天室列表，每次最多可获取 1,000 个。

示例代码如下：

```c#
SDKClient.Instance.RoomManager.FetchPublicRoomsFromServer(pageNum, pageSize, handle: new ValueCallBack<PageResult<Room>>(
  // rooms 是 PageResult<Room> 类型
  onSuccess: (rooms) => {
  },
  onError:(code, desc) => {
  }
));
```

### 监听聊天室事件

`IRoomManagerDelegate` 类中提供了聊天室事件的监听接口。你可以通注册聊天室监听器，获取聊天室事件，并作出相应处理。如不再使用该监听，需要移除，防止出现内存泄露。

示例代码如下：

```c#
// 继承并实现 IRoomManagerDelegate 类
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
        /**
        * 聊天室解散
        * 
        * @param roomId        聊天室 ID
        * @param roomName      聊天室名称
        *
        */
        void OnDestroyedFromRoom(string roomId, string roomName);
        /**
        * 有新成员加入聊天室
        * 
        * @param roomId        聊天室 ID
        * @param participant   新成员的用户 ID
        *
        */
        void OnMemberJoinedFromRoom(string roomId, string participant);
        /**
        * 有成员离开聊天室
        * 
        * @param roomId        聊天室 ID
        * @param roomName      聊天室名称
        * @param participant   退出成员的用户 ID
        *
        */
        void OnMemberExitedFromRoom(string roomId, string roomName, string participant);
        /**
        * 聊天室成员被移出聊天室
        *
        * @param roomId        聊天室 ID
        * @param roomName      聊天室名称
        * @param participant   移出成员的用户 ID
        *
        */
        void OnRemovedFromRoom(string roomId, string roomName, string participant);
        /**
        * 聊天室成员被禁言
        *
        * @param roomId        聊天室 ID
        * @param mutes         被禁言的用户 ID
        * @param expireTime    禁言有效期，单位为毫秒
        *
        */
        void OnMuteListAddedFromRoom(string roomId, List<string> mutes, long expireTime);
        /**
        * 聊天室成员被解除禁言
        *
        * @param roomId        聊天室 ID
        * @param mutes         被解禁的用户 ID
        *
        */
        void OnMuteListRemovedFromRoom(string roomId, List<string> mutes);
        /**
        * 聊天室成员被设为管理员权限
        *
        * @param roomId        聊天室 ID
        * @param admin         被设为管理员的用户 ID
        *
        */
        void OnAdminAddedFromRoom(string roomId, string admin);
        /**
        * 聊天室成员被移除管理员权限
        *
        * @param  roomId       聊天室 ID
        * @param  admin        被移除管理员的用户 ID
        *
        */
        void OnAdminRemovedFromRoom(string roomId, string admin);
        /**
        * 聊天室所有者转让聊天室所有权
        *
        * @param roomId        聊天室 ID
        * @param newOwner      新聊天室所有者的用户 ID
        * @param oldOwner      原聊天室所有者的用户 ID
        *
        */
        void OnOwnerChangedFromRoom(string roomId, string newOwner, string oldOwner);
        /**
        * 聊天室公告更新
        * @param roomId        聊天室 ID
        * @param announcement  更新的公告内容
        *
        */
        void OnAnnouncementChangedFromRoom(string roomId, string announcement);
    }
```