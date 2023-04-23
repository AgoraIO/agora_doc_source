# 环信超级社区（Circle）快速开始

## 集成准备

使用环信超级社区 （Circle）之前，确保你已经集成环信即时通讯 IM Web SDK 1.0.8，详见 [即时通讯 IM Web 快速开始](./agora_chat_get_started_web?platform=Web)。

## 技术原理

用户需加入一个社区，然后选择加入社区中的频道，这样才可以在频道中发送消息。

发送和接收消息的逻辑如下：

1. 发送方获取社区 ID；
2. 发送方获取频道 ID；
3. 发送方通过 `send` 发送消息；
4. 接收方通过 `addEventHandler` 注册监听器接收各类消息的回调。

## 实现方法

### 获取指定的社区

你可以通过三种方式获取指定的社区 ID：

- 创建社区；
- 加入一个现有社区；
- 获取已加入的社区列表。

#### 创建社区

你可以调用 `createServer` 方法创建一个社区：

```javascript
let options = {
  name: 'server name',
  icon: 'image url',
  description: 'a test server',
  ext: '',
}
WebIM.conn.createServer(options).then(res => {
  console.log(res)
})

```

#### 加入一个现有社区

你可以调用 `joinServer` 方法加入一个现有社区：

```javascript
WebIM.conn.joinServer({serverId: 'serverId'}).then(res=>{
  console.log(res)
})
```

#### 获取已加入的社区列表

你可以调用 `getJoinedServers` 方法获取已加入的社区列表：

```javascript
WebIM.conn.getJoinedServers({pageSize: '10',cursor: ''}).then(res=>{
  console.log(res)
})
```

### 获取指定的频道

你可以通过三种方式获取指定的频道 ID：

- 创建频道；
- 加入一个现有频道；
- 获取已加入的频道列表。

#### 创建频道

你可以调用 `createChannel` 方法创建频道：

```javascript
let options = {
  serverId: 'serverID',
  isPublic: true,
  name: 'channelName',
  description: 'this is my channel',
  ext: ''
}
WebIM.conn.createChannel(options).then(res => {
  console.log(res)
})
```

#### 加入一个现有频道

你可以调用 `joinChannel` 方法加入频道：

```javascript
WebIM.conn.joinChannel({serverId: 'serverId', channelId: 'channelId'}).then(res => {
  console.log(res)
})
```

#### 获取已加入的公开频道列表

你可以调用 `getPublicChannels` 方法获取已加入的公开频道列表：

```javascript
let options = {
  serverId: 'serverId',
  pageSize: 20,
  cursor: ''
}
WebIM.conn.getPublicChannels(options).then(res => {
  console.log(res)
})
```

#### 获取社区中当前用户可见的私有频道列表

社区中的普通成员只能获取到自己加入的私有频道，而社区所有者和管理员可以获取全部的私有频道。

```javascript
let options = {
  serverId: 'serverId',
  pageSize: 20,
  cursor: ''
}
WebIM.conn.getVisiblePrivateChannels(options).then(res => {
  console.log(res)
})
```

### 发送和接收一条频道消息

在频道中发送和接收消息，你可以参考 [发送和接收消息](./agora_chat_manage_message_android?platform=Web)。

#### 发送一条频道消息

你可以调用 `create` 方法构造一文本消息并在指定频道中发送：

```javascript
// 在指定频道发送文本消息。
function sendChannelText() {
    let option = {
        chatType: 'groupChat',    // 会话类型，设置为群聊。
        type: 'txt',              // 消息类型。
        to: 'channelId',          // 消息接收方（频道 ID)。
        msg: 'message content'    // 消息内容。
    }
    let msg = WebIM.message.create(option); 
    WebIM.conn.send(msg).then(() => {
        console.log('send text message Success');  
    }).catch((e) => {
        console.log("Send text message error");  
    })
};
```

#### 接收一条频道消息

你可以通过 `addEventHandler` 注册监听器接收文本消息的回调。

```javascript
WebIM.conn.addEventHandler('messageHandler', {
  // 收到文本消息。
   onTextMessage: function ( message ) {
      console.log(message)
   }
});
```