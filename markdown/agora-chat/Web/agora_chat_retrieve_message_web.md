# 消息管理–从服务器获取消息

即时通讯 IM SDK 在消息服务器上存储历史消息。当聊天用户从其他设备登录或加入群组后，您可以从服务器检索历史消息，以便用户也可以在新设备上浏览这些消息。

本文介绍如何实现用户从消息服务器获取会话和消息。

## 技术原理

即时通讯 IM SDK 提供 `ChatManager` 类支持从服务器获取会话和历史消息。以下是核心方法：

- `getSessionList` 获取服务器上保存的会话列表；
- `getConversationList` 获取会话列表以及会话中的最新一条消息；
- `fetchHistoryMessages` 获取服务器上保存的指定会话中的消息；
- `getHistoryMessages` 按服务器接收消息的时间顺序获取服务器上保存的指定会话中的消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [即时通讯 IM 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_web?platform=Web)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Web)。

## 实现方法

### 从服务器获取会话列表

对于单聊或群聊，用户发消息时，会自动将对方添加到用户的会话列表。用户可通过调用 `getConversationList` 方法从服务器获取会话列表及每个会话中的最新一条消息。

**注意**
登录用户的 ID 大小写混用会导致拉取会话列表时提示会话列表为空，因此避免大小写混用。

```javascript
WebIM.conn.getConversationList().then((res) => {
    console.log(res)
    /**
     * 返回参数说明。
     * channel_infos：所有会话。
     * channel_id：会话 ID。
     * lastMessage：最新一条消息。
     * unread_num：当前会话的未读消息数。
     */
})
```

该功能需联系商务开通，开通后，用户默认可拉取 7 天内的 10 个会话（每个会话包含最新一条历史消息），如需调整会话数量或时间限制请联系 [support@agora.io](mailto:support@agora.io)。

### 从服务器获取指定会话的历史消息

检索对话后，您可以通过分页从服务器检索历史消息。

您可以设置搜索方向，以服务器接收消息的时间顺序或时间倒序检索消息。

为确保数据可靠性，我们建议每次方法调用获取的历史消息少于 50 条。要获取超过 50 条历史消息，请多次调用此方法。获取到消息后，SDK 会自动在本地数据库中更新这些消息。

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

## 下一步

实现从服务器获取会话和历史消息后，可以参考以下文档为应用添加更多消息功能：

- [消息回执](https://docs.agora.io/en/agora-chat/agora_chat_message_receipt_web?platform=Web)