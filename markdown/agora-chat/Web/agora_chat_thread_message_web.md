# 管理子区消息 Web

子区消息消息类型属于群聊消息类型，与普通群组消息的区别是需要添加 `isChatThread` 标记。本文介绍环信即时通讯 IM Web SDK 如何发送、接收以及撤回子区消息。

## 技术原理

环信即时通讯 IM Web SDK 支持你通过调用 API 在项目中实现如下功能：

- 发送子区消息
- 接收子区消息
- 撤回子区消息
- 获取子区消息

消息收发流程如下：

1. 用户 A 发送一条消息到环信的消息服务器;
2. 单聊时消息时，服务器投递消息给用户 B；对于群聊时消息，服务器投递给群内其他每一个成员;
3. 用户收到消息。

下图显示了客户端如何发送和接收点对点消息的工作流程。

![img](https://web-cdn.agora.io/docs-files/1636443945728)

## 前提条件

开始前，请确保满足以下条件：

- 完成即时通讯 IM SDK 初始化，详见[Web 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_web?platform=Web)。
- 了解即时通讯 IM API 的[使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Web)中所述。

所有类型的 [定价计划](https://docs.agora.io/en/agora-chat/agora_chat_plan) 都支持该功能，并且在 [Agora 控制台](https://console.agora.io/) 中启用聊天后默认启用。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 发送子区消息

发送子区消息和发送群组消息的方法基本一致，区别在于 `isChatThread` 字段。

单设备登录时，子区所属群组的所有成员会收到 `onChatThreadChange` 回调。

如以下代码示例所示：

```javascript
// 在 thread 内发送文本消息
function sendTextMessage() {
    let option = {
        chatType: 'groupChat',     // 会话类型，设置为群聊。
        type: 'txt',               // 消息类型。
        to: chatThreadId,          // 消息接收方（子区 ID)。
        msg: 'message content'     // 消息内容。
        isChatThread:true,   // thread 消息标记
    }
    let msg = WebIM.message.create(option);
    connection.send(msg).then(() => {
        console.log('send private text Success');
    }).catch((e) => {
        console.log("Send private text error");
    })
};
```

有关发送消息的更多信息，请参阅 [发送消息](https://docs.agora.io/en/agora-chat/agora_chat_send_receive_message_web?platform=Web#send-a-text-message)。

### 接收子区消息

一旦子区有新消息，所有群组成员都会收到 `onChatThreadChange` 由事件触发的回调 `update`。子区成员也可以通过监听 `onTextMessage` 回调来接收子区消息，如下代码示例所示：

```javascript
// 监听收到的文本消息
connection.addEventHandler('THREADMESSAGE',{
  onTextMessage:(message) =>{
            if(message.chatThread && JSON.stringify(message.chatThread)!=='{}'){
        console.log(message)
        // 接收到子区消息，添加处理逻辑。
      }
    },
});
```

有关接收消息的更多信息，请参阅 [接收消息](https://docs.agora.io/en/agora-chat/agora_chat_send_receive_message_web?platform=Web#receive-a-message)。

### 撤回子区消息

发送子区消息类似于在群组中发送消息。区别在于 `isChatThread` 字段。

一旦在子区中撤回消息，所有群组成员都会收到 `onChatThreadChange` 由事件触发的回调 `update`。线程成员也可以监听`onRecallMessage`回调，如下代码示例所示：

```javascript
let option = {
  mid: 'msgId',
  to: 'userID',
  chatType: 'groupChat'
  isChatThread: true
};
connection.recallMessage(option).then((res) => {
  console.log('success', res)
}).catch((error) => {
  // 消息撤回失败 (超过 2 分钟)。
  console.log('fail', error)
})

// 监听要撤回的消息：
conn.addEventHandler('MESSAGES',{
   onRecallMessage: => (msg) {
       // 接收到子区消息被撤回，添加处理逻辑。
       console.log('撤回成功'，msg)
   },
})
```

有关撤回消息的更多信息，请参阅撤回 [消息](https://docs.agora.io/en/agora-chat/agora_chat_send_receive_message_web?platform=Web#recall-a-message)。

### 从服务器获取子区消息

关于如何从服务器获取子区消息的详细信息，请参见从服务器获取 [历史消息](https://docs.agora.io/en/agora-chat/agora_chat_retrieve_message_web?platform=Web#retrieve-historical-messages-of-the-specified-conversation)。