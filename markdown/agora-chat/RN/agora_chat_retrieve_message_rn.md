本文介绍用户如何从消息服务器获取会话和消息，该功能也称为消息漫游，指即时通讯服务将用户的历史消息保存在消息服务器上，用户即使切换终端设备，也能从服务器获取到单聊、群聊的历史消息，保持一致的会话场景。

## 技术原理

使用即时通讯 IM React Native SDK 可以从服务器获取会话和历史消息。

- 获取在服务器保存的会话列表；
- 获取服务器保存的指定会话中的消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [快速开始](./agora_chat_get_started_rn?platform=RN)。
- 了解即时通讯 IM [使用限制](./agora_chat_limitation?platform=RN)。

## 实现方法

### 从服务器获取会话

默认情况下用户可拉取 7 天内的 10 个最新会话（每个会话包含最新一条历史消息），如需调整会话数量或时间限制请联系 [support@agora.io](mailto:support@agora.io)。

你可以调用 `fetchAllConversations` 方法从服务器获取所有会话，示例代码如下：

```typescript
ChatClient.getInstance()
  .chatManager.fetchAllConversations()
  .then(() => {
    console.log("get conversions success");
  })
  .catch((reason) => {
    console.log("get conversions fail.", reason);
  });
```


### 分页获取指定会话的历史消息

从服务器分页获取指定会话的历史消息（消息漫游）。

你可以指定消息查询方向，即明确按时间顺序或逆序获取。

建议每次获取少于 50 条消息，可多次获取。拉取后默认 SDK 会自动将消息更新到本地数据库。

你可以调用 `fetchHistoryMessages` 方法从服务器分页获取指定会话的历史消息。建议该方法每次调用获取的消息不超过 50 条。若获取较大数量的消息，你可以多次调用该方法，确保数据可靠。获取数据后，SDK 会自动将消息更新到本地数据库。

```typescript
// 会话 ID
const convId = "convId";
// 会话类型。详见 `ChatConversationType` 枚举类型。
const convType = ChatConversationType.PeerChat;
// 获取的最大消息数目
const pageSize = 10;
// 搜索的起始消息 ID
const startMsgId = "";
ChatClient.getInstance()
  .chatManager.fetchHistoryMessages(convId, chatType, pageSize, startMsgId)
  .then((messages) => {
    console.log("get message success: ", messages);
  })
  .catch((reason) => {
    console.log("load conversions fail.", reason);
  });
```
];
```

## 下一步

实现从服务器获取消息后，您可以参考以下文档为您的应用添加更多消息功能：

- [消息回执](./agora_chat_message_receipt_rn?platform=RN)