登录即时通讯 app 后，用户可以在一对一单聊、群聊、聊天室中发送如下类型的消息：

- 文字消息，包含超链接和表情消息。
- 附件消息，包含图片、语音、视频及文件消息。
- 位置消息。
- 透传消息。
- 自定义消息。

以及对以上消息进行自定义扩展。

本文介绍如何使用即时通讯 IM SDK 实现发送和接收这些类型的消息。

## 技术原理

即时通讯 IM React Native SDK 通过 `ChatManager` 和 `ChatMessage` 类来发送、接收和撤回消息、发送、接收消息已读回执，并管理用户设备上存储的消息会话数据，其中包含如下主要方法：

- 发送消息给某个用户，群组或者聊天室；
- 撤回自己发出的消息；
- 添加消息接收的回调通知；
- 发送会话已读通知；
- 发送指定消息已读的通知；

发送和接收消息的过程如下：

1. 发送方调用相应 Create 方法创建文本、文件、附件等类型的消息；
2. 发送方再调用 `SendMessage` 发送消息；
3. 接收方通过 `ChatMessageEventListener` 方法监听消息回调事件。在收到 `onMessagesReceived` 后，即表示成功接收到消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [React Native 快速开始](./agora_chat_get_started_rn?platform=rn)。
- 了解 [使用限制](./agora_chat_limitation)。

## 实现方法

### 发送消息

1. 首先，利用 `ChatMessage` 类构造一个消息。

示例代码：

```typescript
// 设置发送的消息类型。消息类型共支持 8 种。具体详见 `ChatMessageType` 枚举类型。
// 通过指定该值，可以发送不同类型的消息。
const messageType = ChatMessageType.TXT;

// 设置消息接收对象 ID。
const targetId = "tom";

// 设置消息接收对象类型。 消息接收对象类型包括 单人、群组和聊天室。具体详见 `ChatMessageChatType` 枚举类型
const chatType = ChatMessageChatType.PeerChat;

// 构造消息。构造不同类型的消息，需要不同的参数。
let msg: ChatMessage;
if (messageType === ChatMessageType.TXT) {
  // 构建文本消息。只需要消息文本内容。
  const content = "This is text message";
  msg = ChatMessage.createTextMessage(targetId, content, chatType);
} else if (messageType === ChatMessageType.IMAGE) {
  // 构建图片消息
  // 需要图片的本地地址，长宽，和界面用来显示的名称
  const filePath = "/data/.../image.jpg";
  const width = 100;
  const height = 100;
  const displayName = "test.jpg";
  msg = ChatMessage.createImageMessage(targetId, filePath, chatType, {
    displayName,
    width,
    height,
  });
} else if (messageType === ChatMessageType.CMD) {
  // 构建透传消息
  // 根据透传消息可以执行具体的命令，命令的内容格式支持自定义
  const action = "writing";
  msg = ChatMessage.createCmdMessage(targetId, action, chatType);
} else if (messageType === ChatMessageType.CUSTOM) {
  // 构建自定义消息
  // 消息内容由消息事件和扩展字段两部分组成，扩展字段用户可以自行实现和使用。
  const event = "gift";
  const ext = { key: "value" };
  msg = ChatMessage.createCustomMessage(targetId, event, chatType, {
    params: JSON.parse(ext),
  });
} else if (messageType === ChatMessageType.FILE) {
  // 构建文件消息
  // 文件消息主要需要本地文件地址和文件在页面显示的名称。
  const filePath = "data/.../foo.zip";
  const displayName = "study_data.zip";
  msg = ChatMessage.createFileMessage(targetId, filePath, chatType, {
    displayName,
  });
} else if (messageType === ChatMessageType.LOCATION) {
  // 构建位置消息
  // 位置消息可以传递经纬度和地名信息
  // 当你需要发送位置时，需要集成第三方的地图服务，获取到位置点的经纬度信息。接收方接收到位置消息时，需要将该位置的经纬度，借由第三方的地图服务，将位置在地图上显示出来。
  const latitude = "114.78";
  const longitude = "39,89";
  const address = "darwin";
  msg = ChatMessage.createLocationMessage(
    targetId,
    latitude,
    longitude,
    chatType,
    { address }
  );
} else if (messageType === ChatMessageType.VIDEO) {
  // 构建视频消息
  // 视频消息相当于包含 2 个附件的消息，主要由视频和视频缩略图组成。视频参数包括视频本地地址、视频长宽值，显示名称，播放时间长度；视频的缩略图需要缩略图的本地地址。
  const filePath = "data/.../foo.mp4";
  const width = 100;
  const height = 100;
  const displayName = "bar.mp4";
  const thumbnailLocalPath = "data/.../zoo.jpg";
  const duration = 5;
  msg = ChatMessage.createVideoMessage(targetId, filePath, chatType, {
    displayName,
    thumbnailLocalPath,
    duration,
    width,
    height,
  });
} else if (messageType === ChatMessageType.VOICE) {
  // 构建语音消息
  // 该消息需求本地语音文件地址、显示名称和播放时长
  const filePath = "data/.../foo.wav";
  const displayName = "bar.mp4";
  const duration = 5;
  msg = ChatMessage.createVoiceMessage(targetId, filePath, chatType, {
    displayName,
    duration,
  });
} else {
  // 其他不支持的消息类型会在此处抛出异常
  throw new Error("Not implemented.");
}
// 消息发送结果会通过回调对象返回，这里返回的结果只是说明发送消息的动作成功或者失败。不代表消息发送的成功或者失败
ChatClient.getInstance()
  .chatManager.sendMessage(msg!, new ChatMessageCallback())
  .then(() => {
    // 消息发送动作完成，会在这里打印日志
    // 消息的发送结果通过回调返回
    console.log("send message operation success.");
  })
  .catch((reason) => {
    // 消息发送动作失败，会在这里打印日志
    console.log("send message operation fail.", reason);
  });
```

2. 通过 `ChatManager` 将该消息发出。

```typescript
ChatClient.getInstance().chatManager.sendMessage(
  msg!,
  new ChatMessageCallback()
);
```

你可以设置发送消息结果回调，用于接收消息发送进度或者发送结果，如发送成功或失败。需要实现 `ChatMessageStatusCallback` 接口。

对于透传消息可能并不需要结果，可以不用赋值。

```typescript
// 实现回调对象
class ChatMessageCallback implements ChatMessageStatusCallback {
  onProgress(localMsgId: string, progress: number): void {
    console.log(`sendMessage: onProgress: `, localMsgId, progress);
    // 对于附件类型的消息，如图片，语音，文件，视频类型，上传或下载文件时会收到相应的进度值，表示附件的上传或者下载进度
  }
  onError(localMsgId: string, error: ChatError): void {
    console.log(`sendMessage: onError: `, localMsgId, error);
    // 收到回调之后，可以将发送的消息状态进行更新，或者进行其他操作
  }
  onSuccess(message: ChatMessage): void {
    console.log(`sendMessage: onSuccess: `, message);
    // 收到成功回调之后，可以对发送的消息进行更新处理，或者其他操作
  }
}
```

### 接收消息

你可以用注册监听 `ChatMessageEventListener` 接收消息。

该 `ChatMessageEventListener` 可以多次添加，请记得在不需要的时候移除该监听。如在 `componentWillUnmount` 的卸载组件的时候。

在新消息到来时，你会收到 `OnMessagesReceived` 的回调，消息接收时可能是一条，也可能是多条。你可以在该回调里遍历消息队列，解析并显示收到的消息。

```typescript
// 继承并实现 ChatMessageEventListener
class ChatMessageEvent implements ChatMessageEventListener {
  onMessagesReceived(messages: ChatMessage[]): void {
    console.log(`onMessagesReceived: `, messages);
  }
  // 其他回调接收省略，实际开发中需要实现
}

// 注册监听器
const listener = new ChatMessageEvent();
ChatClient.getInstance().chatManager.addMessageListener(listener);

// 移除监听器
ChatClient.getInstance().chatManager.removeMessageListener(listener);

// 移除所有监听器
ChatClient.getInstance().chatManager.removeAllMessageListener();
```

文件消息不会自动下载。图片消息和视频消息默认会生成缩略图，接收到图片消息和视频消息，默认会自动下载缩略图。语音消息接收到后会自动下载。

若手动下载，需进行如下设置：

在初始化 SDK 时将 `isAutoDownload` 设置为 `false`。

```typescript
ChatClient.getInstance()
  .init(
    new ChatOptions({
      appKey: <your app key>,
      isAutoDownload: false,
    })
  )
  .then(() => {
    console.log("init success: ");
  })
  .catch((reason) => {
    console.log("init fail: ", reason);
  });
```

下载缩略图。

```typescript
// 收到的图片或者视频消息
const msg;
// 下载缩略图的回调
const callback = new ChatMessageCallback();
// 进行缩略图下载
ChatClient.getInstance()
  .chatManager.downloadThumbnail(msg, msgCallback)
  .then((result) => {
    console.log("success: ", result);
    // 可以获取文件下载到本地的地址
    const body = msg.body as ChatImageMessageBody;
    console.log("thumb picture address: ", body.localPath);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

下载附件。

```typescript
// 收到的图片、视频、音频、文件等消息
const msg;
// 下载附件的回调
const callback = new ChatMessageCallback();
// 进行附件下载
ChatClient.getInstance()
  .chatManager.downloadAttachment(msg, msgCallback)
  .then((result) => {
    console.log("success: ", result);
    // 可以获取文件下载到本地的地址
    const body = msg.body as ChatImageMessageBody;
    console.log("download success: ", body.localPath);
  })
  .catch((error) => {
    console.log("download fail: ", error);
  });
```

下载完成后，调用相应消息 body 的 `localPath` 获取附件路径。

### 撤回消息

消息发送后 2 分钟之内，消息的发送方可以撤回该消息。如果需要调整可撤回时限，可以联系商务。

```typescript
ChatClient.getInstance()
  .chatManager.recallMessage(this.state.lastMessage.msgId)
  .then(() => {
    console.log("recall message success");
  })
  .catch((reason) => {
    console.log("recall message fail.", reason);
  });
```

设置消息撤回监听：

```typescript
// 接收到消息被撤回时触发此回调（此回调位于 `ChatMessageEventListener` 中）
class ChatMessageEvent implements ChatMessageEventListener {
  onMessagesRecalled(messages: ChatMessage[]): void {
    console.log(`onMessagesReceived: `, messages);
  }
  // 其他回调接收省略，实际开发中需要实现
}
```

### 监听器介绍

除了上述介绍的部分，还有如下：

```typescript
let msgListener = new (class implements ChatMessageEventListener {
  onMessagesReceived(messages: ChatMessage[]): void {
    // 这里接收除了透传消息之外的消息数组
  }
  onCmdMessagesReceived(messages: ChatMessage[]): void {
    // 这里接收透传消息数据
  }
  onMessagesRead(messages: ChatMessage[]): void {
    // 这里接收个人类型消息已读回执通知，messages 为已经已读回执的消息数组
  }
  onGroupMessageRead(groupMessageAcks: ChatGroupMessageAck[]): void {
    // 这里接收群组类型的消息已读回执通知，messages 为已经已读回执的消息数组
  }
  onMessagesDelivered(messages: ChatMessage[]): void {
    // 消息送达回执通知，messages 为回执的消息数组
  }
  onMessagesRecalled(messages: ChatMessage[]): void {
    // 消息撤回通知，messages 为撤销的消息
  }
  onConversationsUpdate(): void {
    // 会话更新通知，通知会话列表发生了变化
  }
  onConversationRead(from: string, to?: string): void {
    // 会话已读通知，当前的会话消息已读
  }
  // reaction 和 thread 在对应章节进行详细介绍
})();
```