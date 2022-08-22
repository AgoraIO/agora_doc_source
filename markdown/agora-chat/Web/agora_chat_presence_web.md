# 管理在线状态订阅

在线状态功能使用户可以显示自己的在线状态，以公开显示其在线状态并快速确定其他用户的状态。用户还可以自定义他们的在线状态，为实时聊天增添乐趣和多样性。

下图显示了创建自定义在线状态的实现以及各种在线状态在应用程序中的外观：

![img](https://web-cdn.agora.io/docs-files/1655302111155)

本文介绍如何在即时通讯应用中发布、订阅和查询用户的在线状态。

## 技术原理

即时通讯 IM SDK 提供在线状态接口，用于管理在线状态订阅，包含如下核心方法：

- 订阅一位或多位用户的在线状态
- 取消订阅一位或多位用户的在线状态
- 监听在线状态更新
- 发布自定义状态
- 检索订阅列表
- 检索一个或多个用户的在线状态

下图展示了客户端订阅和发布在线状态的工作流程：

![img](https://web-cdn.agora.io/docs-files/1655308138447)

如上图所示，订阅用户在线状态的基本步骤如下：

1. 用户 A 订阅用户 B 的在线状态。
2. 用户 B 发布在线状态。
3. 即时通讯 IM 服务器触发事件通知用户 A 用户 B 的在线状态更新。

## 前提条件

使用在线状态功能前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Web 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_web)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation)。
- 在 [Agora 控制台](http://console.agora.io/) 激活在线状态功能。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 订阅指定用户的在线状态

默认情况下，你不关注任何其他用户的在线状态。你可以通过调用 `subscribePresence` 方法订阅指定用户的在线状态，示例代码如下：

```javascript
let option = {
  usernames: ['Alice','Bob'],
  expiry: 7*24*3600 // 单位为秒
}
conn.subscribePresence(option).then(res => {console.log(res)})
```

在线状态变更时，订阅者会收到 `onPresenceStatusChange` 回调。

**注意**

- 订阅时长最长为 30 天，过期需重新订阅。如果未过期的情况下重复订阅，新设置的有效期会覆盖之前的有效期。
- 每次调用接口最多只能订阅 100 个账号，若数量较大需多次调用。每个用户 ID 订阅的用户数不超过 3000。如果超过 3000，后续订阅也会成功，但默认会将订阅剩余时长较短的替代。

### 发布自定义在线状态

用户在线时，可调用 `publishPresence` 方法发布自定义在线状态，示例代码如下：

```javascript
let option = {
  description: 'custom presence'
}
conn.publishPresence(option).then(res => {console.log(res)})
```

在线状态发布后，发布者和订阅者均会收到 `onPresenceStatusChange` 回调。

### 添加在线状态监听器

参考如下代码，添加用户在线状态的监听器：

```javascript
WebIM.conn.addEventHandler('MESSAGES',{
   onPresenceStatusChange: => (msg) {
       // 这里可以处理订阅用户状态更新后的逻辑。
   	   console.log('状态更新'，msg)
   },
})
```

### 取消订阅指定用户的在线状态

若取消指定用户的在线状态订阅，可调用 `unsubscribePresence` 方法，示例代码如下：

```javascript
let option = {
  usernames: ['Alice','Bob']
}
conn.unsubscribePresence(payload).then(res => {console.log(res)})
```

### 查询被订阅用户列表

为方便用户管理订阅关系，SDK 提供 `getSubscribedPresenceList` 方法，可使用户分页查询自己订阅的用户列表，示例代码如下：

```javascript
let option = {
  pageNum: 0,
  pageSize: 50
}
conn.getSubscribedPresenceList(payload).then(res => {console.log(res)})
```

### 获取用户的当前在线状态

如果不关注用户的在线状态变更，你可以调用 `getPresenceStatus` 获取用户当前的在线状态，而无需订阅状态。示例代码如下：

```javascript
let option = {
  usernames: ['Alice','Bob']
}
conn.getPresenceStatus(payload).then(res => {console.log(res)})
```