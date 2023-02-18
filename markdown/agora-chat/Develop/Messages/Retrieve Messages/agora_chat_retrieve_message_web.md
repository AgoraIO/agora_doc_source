即时通讯 IM 提供消息漫游功能，即将用户的所有会话的历史消息保存在消息服务器，用户在任何一个终端设备上都能获取到历史信息，使用户在多个设备切换使用的情况下也能保持一致的会话场景。

本文介绍如何实现用户从消息服务器获取和删除会话和消息。

## 技术原理

即时通讯 IM SDK 支持从服务器获取会话和删除历史消息。以下是核心方法：

- `getConversationlist` 分页获取会话列表以及会话中的最新一条消息。
- `getHistoryMessages` 按服务器接收消息的时间顺序获取服务器上保存的指定会话中的消息。
- `removeHistoryMessages` 按照时间或消息 ID 单向删除服务端的历史消息。
- `deleteConversation` 删除服务器端会话及其对应的消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Web 快速开始](./agora_chat_get_started_web)。
- 了解即时通讯 IM API 的调用频率限制，详见 [限制条件](./agora_chat_limitation)。

## 实现方法

## 从服务器分页获取会话列表

你可以调用 `getConversationlist` 方法从服务端分页获取会话列表，每个会话包含最新一条历史消息。

<div class="alert note">登录用户的 ID 大小写混用会导致拉取会话列表时提示会话列表为空，因此避免大小写混用。</div>

```java
// pageNum：当前页面，从 1 开始。
// pageSize：每页获取的会话数量。取值范围为 [1,20]。
connection.getConversationlist({pageNum: 1, pageSize: 20}).then((res) => {})
```

对于使用 `getConversationlist` 方法未实现分页获取会话的用户，SDK 默认可拉取 7 天内的 10 个会话，每个会话包含最新一条历史消息。如需调整时间限制或会话数量，请联系 [support@agora.io](mailto:support@agora.io)。

### 从服务器获取指定会话的历史消息

你可以调用 `getHistoryMessages` 方法从服务器获取指定会话的消息（消息漫游）。你可以指定消息查询方向，即明确按服务器接收消息的时间顺序或时间倒序获取消息。为确保数据可靠，我们建议你每次获取少于 50 条消息，可多次获取。拉取后默认 SDK 会自动将消息更新到本地数据库。

```javascript
var options = {
    // 对方的用户 ID 或者群组 ID 或聊天室 ID。
    targetId:'user1',
    // （可选）每页期望获取的消息条数。取值范围为 [1,50]，默认值为 20。
    pageSize: 20,
    // （可选）查询的起始位置。若该参数设置为 `-1`、`null` 或空字符串，从最新消息开始。
    cursor: -1,
    // （可选）会话类型：（默认） `singleChat`：单聊；`groupChat`：群聊；`chatRoom`：聊天室聊天。
    chatType:'groupChat',
    // 消息搜索方向：（默认）`up`：按服务器收到消息的时间的逆序获取；`down`：按服务器收到消息的时间的正序获取。
    searchDirection: 'up',
}
WebIM.conn.getHistoryMessages(options).then((res)=>{
    // 成功获取历史消息。
    console.log(res)
}).catch((e)=>{
    // 获取失败。
})
```

### 单向删除服务端的历史消息

你可以调用 `removeHistoryMessages` 方法按照时间或消息 ID 单向删除服务端的历史消息。每次最多可删除 50 条消息。消息删除后，消息删除后，该用户无法从服务端拉取到该消息。其他用户不受该操作影响。多端多设备登录时，删除成功后会触发 `onMultiDeviceEvent#deleteRoaming` 回调。

示例代码如下：

```javascript
// 按时间戳删除历史消息
connection.removeHistoryMessages({targetId: 'userId', chatType: 'singleChat', beforeTimeStamp: Date.now()})

// 按消息 ID 删除历史消息
connection.removeHistoryMessages({targetId: 'userId', chatType: 'singleChat', messageIds: ['messageId']})
```

### 删除服务端会话及其历史消息

你可以调用 `deleteConversation` 方法删除服务器端会话和历史消息。会话删除后，当前用户和其他用户均无法从服务器获取该会话。若该会话的历史消息也删除，所有用户均无法从服务器获取该会话的消息。

```javascript
let options = {
  // 会话 ID：单聊为对方的用户 ID，群聊为群组 ID。
  channel: "channel",
  // 会话类型：（默认） `singleChat`：单聊；`groupChat`：群聊。
  chatType: "singleChat",
  // 删除会话时是否同时删除服务端漫游消息。
  deleteRoam: true,
};
WebIM.conn
  .deleteConversation(options)
  .then((res) => {
    console.log(res);
  })
  .catch((e) => {
    // 删除失败。
  });
```

## 后续步骤

实现从服务器获取会话和历史消息后，可以参考以下文档为应用添加更多消息功能：

- [消息回执](./agora_chat_message_receipt_web)