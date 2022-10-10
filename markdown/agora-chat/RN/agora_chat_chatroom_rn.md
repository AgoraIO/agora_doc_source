聊天室是支持多人沟通的即时通讯系统。

聊天室中的成员没有固定关系，用户离线后，超过 5 分钟会自动退出聊天室。聊天室成员在离线后，不会收到推送消息。聊天室可以应用于直播、消息广播等。

本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中创建和管理聊天室，并实现聊天室的相关功能。

消息相关内容见 [消息管理](./agora_chat_message_overview)。

## 技术原理

即时通讯 IM SDK 提供 `ChatRoomManager`、`ChatRoom` 和 `ChatRoomEventListener` 类用于聊天室管理，支持你通过调用 API 在项目中实现如下功能：

- 创建聊天室
- 从服务器获取聊天室列表
- 加入聊天室
- 获取聊天室详情
- 退出聊天室
- 解散聊天室
- 监听聊天室事件

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 快速开始](./agora_chat_get_started_rn?platform=rn)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation?platform=rn)。
- 了解不同版本的聊天室相关数量限制，详见 [套餐包详情](./agora_chat_plan?platform=rn)。
- 只有应用超级管理员才有创建聊天室的权限。确保你已通过调用 [super-admin RESTful API](./agora_chat_restful_chatroom_superadmin?platform=RESTful#adding-a-chat-room-super-admin) 添加了应用超级管理员。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 创建聊天室

仅 [应用超级管理员](./agora_chat_restful_chatroom_superadmin) 可以调用 `createChatRoom` 方法创建聊天室，并设置聊天室的名称、描述、最大成员数等信息。成功创建聊天室后，该超级管理员自动成为聊天室所有者。

只有聊天室所有者才能解散聊天室。聊天室一旦解散，所有聊天室成员都会收到 `didDismissFromChatroom` 回调，并立即从聊天室中删除。

示例代码如下：

```typescript
// 聊天室名称，不能超过 128 个字符
const subject = "";
// 聊天室描述， 不能超过 512 个字符
const desc = "this is room description.";
// 欢迎消息
const welcomeMsg = "welcome to you.";
// 聊天室成员列表
const members = ["Tom", "Json"];
// 最大成员数
const maxCount = 10000;
ChatClient.getInstance()
  .roomManager.createChatRoom(subject, desc, welcomeMsg, members, maxCount)
  .then(() => {
    console.log("get room success.");
  })
  .catch((reason) => {
    console.log("get room fail.", reason);
  });
```

### 加入聊天室

用户申请加入聊天室的步骤如下：

1. 调用 `fetchPublicChatRoomsFromServer` 方法从服务器获取聊天室列表，查询到想要加入的聊天室 ID。
2. 调用 `joinChatRoom` 方法传入聊天室 ID，申请加入对应聊天室。新成员加入聊天室时，其他成员收到 `onMemberJoined` 回调。

示例代码如下：

```typescript
// 获取公开聊天室列表，每次最多可获取 1,000 个。
ChatClient.getInstance()
  .roomManager.fetchPublicChatRoomsFromServer(pageNum, pageSize)
  .then((rooms) => {
    console.log("get room success.", rooms);
  })
  .catch((reason) => {
    console.log("get room fail.", reason);
  });
// 加入聊天室
ChatClient.getInstance()
  .roomManager.joinChatRoom(roomId)
  .then(() => {
    console.log("join room success.");
  })
  .catch((reason) => {
    console.log("join room fail.", reason);
  });
```

### 获取聊天室详情

聊天室所有成员均可调用 `fetchChatRoomInfoFromServer` 从服务器获取聊天室的详情，包括聊天室 ID、聊天室名称，聊天室描述、聊天室公告、管理员列表、最大成员数、聊天室所有者、是否全员禁言以及聊天室权限类型。成员列表、黑名单列表、禁言列表需单独调用接口获取。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.fetchChatRoomInfoFromServer(roomId)
  .then((info) => {
    console.log("get room info success.", info);
  })
  .catch((reason) => {
    console.log("get room info fail.", reason);
  });
```

此外，你也可以从本地获取聊天室信息。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.getChatRoomWithId(roomId)
  .then((info) => {
    console.log("get room info success.", info);
  })
  .catch((reason) => {
    console.log("get room info fail.", reason);
  });
```

### 退出聊天室

聊天室所有成员均可以调用 `leaveChatRoom` 方法退出当前聊天室。成员退出聊天室时，其他成员收到 `ChatRoomEventListener#onMemberExited` 回调。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.leaveChatRoom(roomId)
  .then(() => {
    console.log("join room success.");
  })
  .catch((reason) => {
    console.log("join room fail.", reason);
  });
```

退出聊天室时，SDK 默认删除该聊天室所有本地消息，若要保留这些消息，可在 SDK 初始化时将 `ChatOptions#deleteMessagesAsExitChatRoom` 设置为 `false`。

示例代码如下：

```typescript
ChatOptions options = new ChatOptions();
options.deleteMessagesAsExitChatRoom = false;
```

与群主无法退出群组不同，聊天室所有者可以离开聊天室，例如所有者从服务器下线则 5 分钟后自动离开聊天室。如果所有者重新进入聊天室仍是该聊天室的所有者。

### 解散聊天室

仅聊天室所有者可以调用 `destroyChatRoom` 方法解散聊天室。聊天室解散时，其他成员收到 `onChatRoomDestroyed` 回调并被踢出聊天室。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.destroyChatRoom(roomId)
  .then(() => {
    console.log("destroy room success.");
  })
  .catch((reason) => {
    console.log("destroy room fail.", reason);
  });
```

### 监听聊天室事件

`ChatRoomEventListener` 类中提供了聊天室事件的监听接口。你可以通过注册聊天室监听器，获取聊天室事件，并作出相应处理。如不再使用该监听器，需要移除，防止出现内存泄露。

示例代码如下：

```typescript
// 实现监听器以及定义监听器对象。
const roomListener: ChatRoomEventListener = new (class
  implements ChatRoomEventListener
{
  that: QuickTestScreenBase<S, SL>;
  constructor(parent: QuickTestScreenBase<S, SL>) {
    this.that = parent;
  }
    // 聊天室被解散。聊天室的所有成员会收到该事件。
  onChatRoomDestroyed(params: {
    roomId: string;
    roomName?: string | undefined;
  }): void {
    console.log(`onChatRoomDestroyed:`, params.roomId, params.roomName);
  }
    // 有用户加入聊天室。聊天室的所有成员（除新成员外）会收到该事件。
  onMemberJoined(params: { roomId: string; participant: string }): void {
    console.log(`onMemberJoined:`, params.roomId, params.participant);
  }
  // 有成员主动退出聊天室。聊天室的所有成员（除退出的成员）会收到该事件。
  onMemberExited(params: {
    roomId: string;
    participant: string;
    roomName?: string | undefined;
  }): void {
    console.log(
      `onMemberJoined:`,
      params.roomId,
      params.participant,
      params.roomName
    );
  }
  // 有成员被移出聊天室。被移出的成员会收到该事件。
  onRemoved(params: {
    roomId: string;
    participant?: string | undefined;
    roomName?: string | undefined;
  }): void {
    console.log(
      `onRemoved:`,
      params.roomId,
      params.participant,
      params.roomName
    );
  }
  // 有成员被加入禁言列表。被添加的成员收到该事件。
  onMuteListAdded(params: {
    roomId: string;
    mutes: string[];
    expireTime?: string | undefined;
  }): void {
    console.log(
      `onMuteListAdded:`,
      params.roomId,
      params.mutes,
      params.expireTime
    );
  }
  // 有成员被移出禁言列表。被解除禁言的成员会收到该事件。
  onMuteListRemoved(params: { roomId: string; mutes: string[] }): void {
    console.log(`onMuteListRemoved:`, params.roomId, params.mutes);
  }
    // 有成员被设为管理员。被添加的管理员会收到该事件。
  onAdminAdded(params: { roomId: string; admin: string }): void {
    console.log(`onAdminAdded:`, params.roomId, params.admin);
  }
    // 有成员被移除管理员权限。被移除的管理员会收到该事件。
  onAdminRemoved(params: { roomId: string; admin: string }): void {
    console.log(`onAdminRemoved:`, params.roomId, params.admin);
  }
    // 聊天室所有者变更。聊天室所有成员会收到该事件。
  onOwnerChanged(params: {
    roomId: string;
    newOwner: string;
    oldOwner: string;
  }): void {
    console.log(
      `onOwnerChanged:`,
      params.roomId,
      params.newOwner,
      params.oldOwner
    );
  }
    // 聊天室公告变更。聊天室的所有成员会收到该事件。
  onAnnouncementChanged(params: {
    roomId: string;
    announcement: string;
  }): void {
    console.log(`onAnnouncementChanged:`, params.roomId, params.announcement);
  }
  // 有成员被加入聊天室白名单。被添加的成员收到该事件。
  onAllowListAdded(params: { roomId: string; members: string[] }): void {
    console.log(`onAllowListAdded:`, params.roomId, params.members);
  }
  // 有成员被移出聊天室白名单。被移出白名单的成员会收到该事件。
  onAllowListRemoved(params: { roomId: string; members: string[] }): void {
    console.log(`onAllowListRemoved:`, params.roomId, params.members);
  }
  // 聊天室全员禁言状态变更。聊天室所有成员会收到该事件。
  onAllChatRoomMemberMuteStateChanged(params: {
    roomId: string;
    isAllMuted: boolean;
  }): void {
    console.log(
      `onAllChatRoomMemberMuteStateChanged:`,
      params.roomId,
      params.isAllMuted ? "true" : "false"
    );
  }
  // 聊天室详情变更。聊天室所有成员会收到该事件。
  onSpecificationChanged?(room: ChatRoom): void {
    console.log(`onSpecificationChanged:`, room);
  }
  // 聊天室自定义属性（key-value）有更新。聊天室所有成员会收到该事件。
  onAttributesUpdated?(params: {
    roomId: string;
    attributes: Map<string, string>;
    from: string;
  }): void {
    console.log(
      `onAttributesUpdated:`,
      params.roomId,
      params.attributes,
      params.from
    );
  }
  // 聊天室自定义属性（key-value）被删除。聊天室所有成员会收到该事件。
  onAttributesRemoved?(params: {
    roomId: string;
    removedKeys: Array<string>;
    from: string;
  }): void {
    console.log(
      `onAttributesRemoved:`,
      params.roomId,
      params.removedKeys,
      params.from
    );
  }
})(this);

// 清空所有监听器
ChatClient.getInstance().roomManager.removeAllRoomListener();

// 添加监听器
ChatClient.getInstance().roomManager.addRoomListener(roomListener);
```