子区消息属于群聊消息类，与普通群消息的区别是需要添加 `isChatThread` 标记。本文介绍即时通讯 IM Web SDK 如何发送、接收、撤回以及获取子区消息。

## 技术原理

即时通讯 IM Web SDK 支持你通过调用 API 在项目中实现如下功能：

- 发送子区消息
- 接收子区消息
- 撤回子区消息
- 获取子区消息

消息收发流程如下图所示：

![img](./agora_doc_source/markdown/agora-chat/images/quickstart/quick_start_workflow.png)

1. 客户端从应用服务器获取 token。
2. 客户端 A 和 B 登录即时通讯。
3. 客户端 A 向客户端 B 发送消息。消息发送至即时通讯 IM 服务器，服务器将消息传递给客户端 B。客户端 B 收到消息后，SDK 触发事件。客户端 B 监听事件并获取消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成即时通讯 IM SDK 初始化，详见 [Web 快速开始](./agora_chat_get_started_web)。
- 了解即时通讯 IM API 的 [使用限制](./agora_chat_limitation)中所述。

所有版本的[套餐包](./agora_chat_plan) 都支持子区功能。在 [Agora 控制台](https://console.agora.io/) 中启用即时通讯服务后默认开启子区功能。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 发送子区消息

发送子区消息和发送群组消息的方法基本一致，区别在于 `isChatThread` 字段，如以下示例代码所示：

```javascript
// 在子区内发送文本消息
function sendTextMessage() {
    let option = {
        chatType: 'groupChat',     // 会话类型，设置为群聊。
        type: 'txt',               // 消息类型。
        to: chatThreadId,          // 消息接收方（子区 ID)。
        msg: 'message content'     // 消息内容。
        isChatThread:true,   // 子区消息标记
    }
    let msg = WebIM.message.create(option);
    connection.send(msg).then(() => {
        console.log('send private text Success');
    }).catch((e) => {
        console.log("Send private text error");
    })
};
```

关于发送消息的逻辑，详见[发送消息](./agora_chat_send_receive_message_web#发送文本消息)。
### 接收子区消息

子区有新消息时，子区所属群组的所有成员收到 `onChatThreadChange`回调，事件为 `update`。子区成员也可以通过监听 `onTextMessage` 回调接收子区消息，如以下代码示例所示：

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

关于接收消息的逻辑，详见[接收消息](./agora_chat_send_receive_message_web#接收文本消息)。

### 撤回子区消息

子区有消息撤回时，子区所属群组的所有成员收到 `onChatThreadChange` 回调，事件为 `update`。子区成员也可以监听 `onRecallMessage` 回调，如下代码示例所示：

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

关于撤回消息的逻辑，详见 [撤回消息](./agora_chat_send_receive_message_web#撤回消息)。

### 从服务器获取子区消息

关于如何从服务器获取子区消息，详见 [从服务器获取历史消息](./agora_chat_retrieve_message_web#从服务器获取指定会话的历史消息)。