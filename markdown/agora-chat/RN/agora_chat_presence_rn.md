在线状态功能使用户可以公开显示其在线状态并快速确定其他用户的状态。用户还可以自定义他们的在线状态，为实时聊天增添乐趣和多样性。

下图显示了创建自定义在线状态的实现以及各种在线状态在联系人列表中的外观：

![img](https://web-cdn.agora.io/docs-files/1655302046418)

本文介绍如何使用即时通讯 IM SDK 在项目中实现在线状态。

## 技术原理

即时通讯 IM SDK 提供 `ChatPresence`、`ChatPresenceManager` 和 `ChatPresenceEventListener` 类，用于管理在线状态订阅，包含如下核心方法：

- 订阅指定用户的在线状态
- 取消订阅指定用户的在线状态
- 发布自定义在线状态
- 查询被订阅用户列表
- 获取用户的当前在线状态

订阅用户在线状态的基本工作流程如下：

![img](https://web-cdn.agora.io/docs-files/1655306619037)

如上图所示，订阅用户在线状态的基本步骤如下：

1. 用户 A 订阅用户 B 的在线状态；
2. 用户 B 的在线状态发生变更；
3. 用户 A 收到 B 的状态变更通知。

## 前提条件

使用在线状态功能前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_rn?platform=rn)。
- 了解 [使用限制](./agora_chat_limitation)。
- 在 [Agora 控制台](http://console.agora.io/) 中启用在线状态功能。

## 实现方法

本节介绍如何使用 SDK 提供的 API 实现上述功能。

### 订阅指定用户的在线状态

默认情况下，你不关注任何其他用户的在线状态。你可以通过调用 `ChatPresenceManager#subscribe` 方法订阅指定用户的在线状态，示例代码如下：

```typescript
// memberIds: 要订阅的用户列表
// expiry: 过期时长，单位为秒
ChatClient.getInstance()
  .presenceManager.subscribe(memberIds, expiry)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

在线状态变更时，订阅者会收到 `ChatPresenceEventListener#onPresenceStatusChanged` 回调。

- 订阅时长最长为 30 天，过期需重新订阅。如果未过期的情况下重复订阅，新设置的有效期会覆盖之前的有效期。
- 每次调用接口最多只能订阅 100 个账号，若数量较大需多次调用。每个用户 ID 订阅的用户数不超过 3000。如果超过 3000，后续订阅也会成功，但默认会将订阅剩余时长较短的替代。

### 取消订阅指定用户的在线状态

若取消指定用户的在线状态订阅，可调用 `ChatPresenceManager#unSubscribe` 方法，示例代码如下：

```typescript
// memberIds: 将要取消订阅的用户列表
ChatClient.getInstance()
  .presenceManager.unSubscribe(memberIds)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### 发布自定义在线状态

用户在线时，可调用 `ChatPresenceManager#publishPresence` 方法发布自定义在线状态：

```typescript
// description: 状态描述
ChatClient.getInstance()
  .presenceManager.publishPresence(description)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

在线状态发布后，发布者和订阅者均会收到 `ChatPresenceEventListener#onPresenceStatusChanged` 回调。

### 添加在线状态监听器

添加用户在线状态的监听器以及接收状态变更事件通知，示例代码如下：

```typescript
// 导入 Presence 监听模块
class ChatPresenceEvent implements ChatPresenceEventListener {
  onPresenceStatusChanged(list: ChatPresence[]): void {
    console.log(`onPresenceStatusChanged:`, list.length, list);
  }
}
// 移除所有的 Presence 监听器
ChatClient.getInstance().presenceManager.removeAllPresenceListener();
// 添加 Presence 监听器
ChatClient.getInstance().presenceManager.addPresenceListener(
  new ChatPresenceEvent()
);
```

### 查询被订阅用户列表

为方便用户管理订阅关系，SDK 提供 `ChatPresenceManager#fetchSubscribedMembers` 方法，可使用户分页查询自己订阅的用户列表，示例代码如下：

```typescript
// pageNum: 页码
// pageSize: 单次请求返回的成员数，取值范围为 [1, 50]
ChatClient.getInstance()
  .presenceManager.fetchSubscribedMembers(pageNum, pageSize)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### 获取用户的当前在线状态

如果不关注用户的在线状态变更，你可以调用 `ChatPresenceManager#fetchPresenceStatus` 获取用户当前的在线状态，而无需订阅状态。示例代码如下：

```typescript
// memberIds: 要获取在线状态的用户列表
ChatClient.getInstance()
  .presenceManager.fetchPresenceStatus(memberIds)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```