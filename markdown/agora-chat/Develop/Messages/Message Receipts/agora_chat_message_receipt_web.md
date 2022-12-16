用户向其他用户或群组发送消息后，希望知道该消息是否送达或已读。即时通讯 IM SDK 提供消息回执功能，让你可以在消息发送或已读后向消息发送方发送回执。

本页介绍如何使用即时通讯 IM SDK 在单聊和群聊中实现消息回执功能。

## 技术原理

实现消息送达回执和已读回执的逻辑如下：

- 单聊消息送达回执

  1. SDK 初始化时，用户将 `options.delivery` 设置为 `true` 开启消息送达回执。
  2. 发送方发送一条消息。
  3. 接收方收到消息后，SDK 会自动向发送方发送送达回执。
  4. 发送方通过监听 `onDeliveredMessage` 收到送达回执。

- 单聊会话及消息已读回执
  1. 发送方发送一条消息。
  2. 消息接收方收到消息后，调用 `send` 发送会话或消息已读回执；
  3. 消息发送方通过监听 `onChannelMessage` 或 `onReadMessage` 回调接收会话或消息已读回执。

- 群聊只支持消息已读回执
  1. 发送方发送一条消息，消息中的 `allowGroupAck` 字段设置为 `true`，要求返回已读回执；
  2. 消息接收方收到消息后调用 `send` 方法发送群组消息的已读回执。
  3. 发送方在线监听 `onReadMessage` 回调或离线监听 `onStatisticsMessage` 回调接收消息回执。
  4. 发送方通过 `getGroupMsgReadUser` 获取阅读消息的用户的详情。

## 前提条件

开始前，请确保满足以下要求：

- 集成即时通讯 IM Web SDK，初始化 SDK，并实现了注册账号和登录功能。详情请参见 [Web 快速开始](./agora_chat_get_started_web)。
- 了解即时通讯 IM API 的调用频率限制，详见 [限制条件](./agora_chat_limitation)。
- 默认情况下不启用群聊的消息已读回执。要使用此功能，请联系 [support@agora.io](mailto:support@agora.io)。

## 实现方法

### 发送单聊消息送达回执

发送消息送达回执，可参考以下步骤：

1. 消息发送方在 SDK 初始化时将 `options` 中的 `delivery` 设置为 `true`。示例代码如下：

```javascript
const conn = new websdk.connection({
  appKey: "your appKey",
  delivery: true
})
```

2. 接收方收到消息后，消息发送方会收到 `onDeliveredMessage` 回调，得知消息已送达接收方。

```javascript
conn.addEventHandler('customEvent', {
    onReceivedMessage: function(message){},    // 收到消息送达服务器回执。
    onDeliveredMessage: function(message){},   // 收到消息送达客户端回执。
});
```

### 发送消息已读回执

消息已读回执用于告知单聊或群聊中的用户接收方已阅读其发送的消息。为降低消息已读回执方法的调用次数，SDK 还支持在单聊中使用会话已读回执功能，用于获知接收方是否阅读了会话中的未读消息。

#### 单聊

单聊既支持消息已读回执，也支持会话已读回执。我们建议你按照如下逻辑结合使用两种回执，减少发送消息已读回执数量。

- 聊天页面未打开时，若有未读消息，进入聊天页面，发送会话已读回执；
- 聊天页面打开时，若收到消息，发送消息已读回执。

##### 会话已读回执

参考以下步骤在单聊中实现会话已读回执。

1. 接收方发送会话已读回执。

消息接收方进入会话页面，查看会话中是否有未读消息。若有，调用 `send` 方法发送会话已读回执，没有则不再发送。

```javascript
let option = {
    chatType: 'singleChat', // 会话类型，设置为单聊。
    type: 'channel',        // 消息类型。
    to: 'userId'            // 接收消息对象的用户 ID。
}
let msg = WebIM.message.create(option);
conn.send(msg);
```

2. 消息发送方在 `onChannelMessage` 回调中收到会话已读回执：

```javascript
conn.addEventHandler('customEvent', {
    onChannelMessage: (message) => {}
})
```

同一用户 ID 登录多设备的情况下，用户在一台设备上发送会话已读回执，服务器会将会话的未读消息数置为 0，同时其他设备会收到 `onChannelMessage` 回调。

##### 消息已读回执

参考如下步骤在单聊中实现消息已读回执。

1. 接收方发送消息已读回执。

消息接收方进入会话时，发送会话已读回执。

```javascript
let option = {
    chatType: 'singleChat', // 会话类型，设置为单聊。
    type: 'channel',        // 消息类型。
    to: 'userId'            // 接收消息对象的用户 ID。
}
let msg = WebIM.message.create(option);
conn.send(msg);
```

在会话页面，接收到消息时发送消息已读回执，如下所示：

```javascript
 let option = {
    type: 'read',           // 消息是否已读。
    chatType: 'singleChat', // 会话类型，这里为单聊。
    to: 'userId',           // 消息接收方的用户 ID。
    id: 'id'                // 需要发送已读回执的消息 ID。
}
let msg = WebIM.message.create(option);
conn.send(msg);
```

2. 消息发送方监听消息已读回调。

你可以调用接口监听指定消息是否已读，示例代码如下：

```javascript
conn.addEventHandler('customEvent', {
    onReadMessage: (message) => {}
})
```
#### 群聊

1. 发送群消息时，群主或管理员可以要求群消息已读回执，即将 `allowGroupAck` 设置为 `true`：

   ```javascript
    sendGroupReadMsg = () => {
      let option = {
          type: 'txt',            // 消息类型。
          chatType: 'groupChat',  // 会话类型，这里为群聊。
          to: 'groupId',          // 消息接收方，即群组 ID。
          msg: 'message content'  // 消息内容。
          msgConfig: { allowGroupAck: true } // 设置此消息需要已读回执。
      }

      let msg = WebIM.message.create(option);
      conn.send(msg).then((res) => {
          console.log('send message success');
      }).catch((e) => {
          console.log("send message error");
      })
    }
   ```

2. 阅读消息后，消息接收方发送群消息已读回执。

   ```javascript
      sendReadMsg = () => {
        let option = {
            type: 'read',           // 消息是否已读。
            chatType: 'groupChat',  // 会话类型，这里为群聊。
            id: 'msgId',            // 需要发送已读回执的消息 ID。
            to: 'groupId',          // 群组 ID。
            ackContent: JSON.stringify({}) // 回执内容。
        }
        let msg = WebIM.message.create(option);
        conn.send(msg)
      }
   ```

3. 消息发送方通过监听以下任一回调接收消息已读回执：

   - `onReadMessage`：消息发送方在线时监听该回调。
   - `onStatisticMessage`：消息发送方离线时监听该回调。

   ```javascript
    // 在线时可以在 onReadMessage 里监听。
    conn.addEventHandler('customEvent', {
      onReadMessage: (message) => {
        let { mid } = message;
        let msg = {
          id: mid
        };
        if(message.groupReadCount){
          // 消息已读数。
          msg.groupReadCount = message.groupReadCount[message.mid];
        }
      },

      // 离线时收到回执，登录后会在这里监听到。
      onStatisticMessage: (message) => {
        let statisticMsg = message.location && JSON.parse(message.location);
        let groupAck = statisticMsg.group_ack || [];
      }
    })
   ```

4. 消息发送方收到群消息已读回执后，可以获取已阅读该消息的用户的详细信息：

   ```javascript
    conn.getGroupMsgReadUser({
        msgId: 'messageId',  // 消息 ID。
        groupId: 'groupId' // 群组 ID。
    }).then((res)=>{
        console.log(res)
    })
   ```