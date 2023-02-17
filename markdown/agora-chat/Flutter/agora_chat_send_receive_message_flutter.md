登录即时通讯 IM 后，用户可以在单聊、群聊或聊天室中发送以下类型的消息：

- 文字消息，包含超链接和表情消息。
- 附件消息，包含图片、语音、视频及文件消息。
- 位置消息。
- 透传消息。
- 自定义消息。

:::tip
针对聊天室消息并发量较大的场景，即时通讯服务提供消息分级功能。你可以通过设置消息优先级，将消息划分为高、普通和低三种级别。你可以在创建消息时，将指定消息类型，或指定成员的所有消息设置为高优先级，确保此类消息优先送达。这种方式可以确保在聊天室内消息并发量较大或消息发送频率过高的情况下，服务器首先丢弃低优先级消息，将资源留给高优先级消息，确保重要消息（如打赏、公告等）优先送达，以此提升重要消息的可靠性 。请注意，该功能并不保证高优先级消息必达。在聊天室内消息并发量过大的情况下，为保证用户实时互动的流畅性，即使是高优先级消息仍然会被丢弃。
:::

本文介绍如何使用即时通讯 IM SDK 实现发送和接收这些类型的消息。

## 技术原理

即时通讯 IM Flutter SDK 使用 `ChatMessage` 和 `ChatMessage` 类来发送、接收和撤回消息。

其中，发送和接收消息的逻辑如下：

1. 消息发送方使用 `create` 方法创建文本、文件、附件等类型的消息。
2. 消息发送方调用 `sendMessage` 发送消息。
3. 消息接收方通过 `ChatEventHandler` 中的方法监听消息回调事件。在收到 `onMessagesReceived` 后，即表示成功接收到消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_flutter?platform=Flutter)。
- 了解 [API 调用频率限制](./agora_chat_limitation?platform=Flutter)。

## 实现方法

本节介绍如何实现发送和接收各种类型的消息。

### 发送消息

按照步骤创建和发送消息，并监听发送消息的结果。

1. 使用 `ChatMessage` 类创建消息。

```dart
// 设置发送的消息类型。消息类型共支持 8 种。具体详见 `MessageType` 枚举类型。
MessageType messageType = MessageType.TXT;
// 设置消息接收对象 ID。
String targetId = "tom";
// 设置消息接收对象类型。消息接收对象类型包括单人、群组和聊天室。具体详见 `ChatType` 枚举类型。
ChatType chatType = ChatType.Chat;
// 构造消息。构造不同类型的消息，需要不同的参数。
// 构造文本消息
ChatMessage msg = ChatMessage.createTxtSendMessage(
    targetId: targetId,
    content: "This is text message",
);

// 构建图片消息，需要图片的本地地址，长宽，和界面用来显示的名称。
String imgPath = "/data/.../image.jpg";
double imgWidth = 100;
double imgHeight = 100;
String imgName = "image.jpg";
int imgSize = 3000;
ChatMessage msg = ChatMessage.createImageSendMessage(
    targetId: targetId,
    filePath: imgPath,
    width: imgWidth,
    height: imgHeight,
    displayName: imgName,
    fileSize: imgSize,
);

// 构建命令消息。根据命令消息可以执行具体的命令，命令的内容格式自定义的。
String action = "writing";
ChatMessage msg = ChatMessage.createCmdSendMessage(
    targetId: targetId,
    action: action,
);

// 自定义消息。消息内容由两部分组成：消息事件和扩展字段。
// 扩展字段用户可以自行实现和使用。
String event = "gift";
Map<String, String> params = {"key": "value"};
ChatMessage msg = ChatMessage.createCustomSendMessage(
    targetId: targetId,
    event: event,
    params: params,
);

// 构建文件消息。文件消息主要需要本地文件地址和文件在页面显示的名称。
String filePath = "data/.../foo.zip";
String fileName = "foo.zip";
int fileSize = 6000;
ChatMessage msg = ChatMessage fileMsg = ChatMessage.createFileSendMessage(
    targetId: targetId,
    filePath: filePath,
    displayName: fileName,
    fileSize: fileSize,
);

// 构建位置消息。位置消息可以传递经纬度和地名信息。
// 当你需要发送位置时，需要集成第三方的地图服务，获取到位置点的经纬度信息。接收方接收到位置消息时，需要将该位置的经纬度，借由第三方的地图服务，将位置在地图上显示出来。
double latitude = 114.78;
double longitude = 39.89;
String address = "darwin";
ChatMessage msg = ChatMessage.createLocationSendMessage(
    targetId: targetId,
    latitude: latitude,
    longitude: longitude,
    address: address,
);

// 构建视频消息。视频消息主要由视频和视频缩略图组成，视频消息支持输入视频的首帧作为缩略图。视频参数包括视频本地地址、视频长宽值，显示名称，播放时间长度。
// 视频的缩略图需要缩略图的本地地址。
// 视频消息相当于包含 2 个附件的消息。
String videoPath = "data/.../foo.mp4";
double videoWidth = 100;
double videoHeight = 100;
String videoName = "foo.mp4";
int videoDuration = 5;
int videoSize = 4000;
ChatMessage msg = ChatMessage.createVideoSendMessage(
    targetId: targetId,
    filePath: videoPath,
    width: videoWidth,
    height: videoHeight,
    duration: videoDuration,
    fileSize: videoSize,
    displayName: videoName,
);

// 构建语音消息。该消息需要本地语音文件地址、显示名称和播放时长。
String voicePath = "data/.../foo.wav";
String voiceName = "foo.wav";
int voiceDuration = 5;
int voiceSize = 1000;
ChatMessage.createVoiceSendMessage(
    targetId: targetId,
    filePath: voicePath,
    duration: voiceDuration,
    fileSize: voiceSize,
    displayName: voiceName,
);
// 对于聊天室消息，还可以设置消息优先级，如果不设置，默认值为Normal，即“普通”优先级。
if (msg.chatType == ChatType.ChatRoom) {
    msg.chatroomMessagePriority = ChatRoomMessagePriority.High;
}
```

2. 在 `ChatManager` 中使用 `sendMessage` 发送消息。

```dart
ChatClient.getInstance.chatManager.sendMessage(message).then((value) {
});
```

你可以设置发送消息结果回调，用于接收消息发送进度或者发送结果，如发送成功或失败。为此，需调用 `ChatManager#addMessageEvent` 方法。

```dart
// 添加消息状态监听器
ChatClient.getInstance.chatManager.addMessageEvent(
    "UNIQUE_HANDLER_ID",
    ChatMessageEvent(
        // 收到成功回调之后，可以对发送的消息进行更新处理，或者其他操作。
        onSuccess: (msgId, msg) {
        // msgId 发送时的消息ID；
        // msg 发送成功的消息;
        },
        // 收到回调之后，可以将发送的消息状态进行更新，或者进行其他操作。
        onError: (msgId, msg, error) {
        // msgId 发送时的消息ID；
        // msg 发送失败的消息;
        // error 错误原因
        },
        // 对于附件类型的消息，如图片，语音，文件，视频类型，上传或下载文件时会收到相应的进度值，表示附件的上传或者下载进度。
        onProgress: (msgId, progress) {
        // msgId 发送时的ID；
        // progress 进度;
        },
    ),
);

void dispose() {
    // 移除消息状态监听器
    ChatClient.getInstance.chatManager.removeMessageEvent("UNIQUE_HANDLER_ID");
    super.dispose();
}

// 消息发送结果会通过回调对象返回，该返回结果仅表示该方法的调用结果，与实际消息发送状态无关。
ChatClient.getInstance.chatManager.sendMessage(message).then((value) {
    // 消息发送动作完成。
});
```

### 接收消息

你可以使用 `ChatEventHandler` 来监听消息事件。可以添加多个 `ChatEventHandler` 对象来监听多个事件。当你不再监听某个事件时，例如，当你调用 `dispose` 时，请确保删除该对象。

当消息到达时，你会收到 `onMessagesReceived` 事件，消息接收时可能是一条，也可能是多条。你可以在该回调里遍历消息队列，解析并显示收到的消息。

```dart
// 添加 chat event handler.
ChatClient.getInstance.chatManager.addEventHandler(
    "UNIQUE_HANDLER_ID",
    ChatEventHandler(
        onMessagesReceived: (messages) {},
    ),
);

...

// 移除监听器
ChatClient.getInstance.chatManager.removeEventHandler("UNIQUE_HANDLER_ID");
```

文件消息不会自动下载。图片消息和视频消息默认会生成缩略图，接收到图片消息和视频消息，默认会自动下载缩略图。语音消息接收到后会自动下载。

若手动下载附件，需进行如下设置：

1. 在初始化 SDK 时将 `isAutoDownloadThumbnail` 设置为 `false`。

```dart
ChatOptions options = ChatOptions(
    appKey: "<#Your AppKey#>",
    isAutoDownloadThumbnail: false,
);
```

2. 设置下载监听器。

```dart
// 添加消息状态监听器
ChatClient.getInstance.chatManager.addMessageEvent(
    "UNIQUE_HANDLER_ID",
    ChatMessageEvent(
        // 收到成功回调表示消息已经下载成功。
        onSuccess: (msgId, msg) {
        // msgId 消息ID；
        // msg 下载成功的消息;
        },
        // 收到失败回调，表示消息下载失败。
        onError: (msgId, msg, error) {
        // msgId 消息ID；
        // msg 下载失败的消息；
        // error 失败原因
        },
        // 对于附件类型的消息，如图片，语音，文件，视频类型，上传或下载文件时会收到相应的进度值，表示附件的上传或者下载进度。
        onProgress: (msgId, progress) {
        // msgId 消息ID；
        // progress 进度;
        },
    ),
);

void dispose() {
    // 移除消息状态监听器
    ChatClient.getInstance.chatManager.removeMessageEvent("UNIQUE_HANDLER_ID");
    super.dispose();
}
```

3. 下载缩略图。

```dart
ChatClient.getInstance.chatManager.downloadThumbnail(message);
```

下载完成后，调用相应消息 body 的 `thumbnailLocalPath` 获取缩略图路径。

```dart
// 获取图片消息 body。
ChatImageMessageBody imgBody = message.body as ChatImageMessageBody;
// 从本地获取图片缩略图路径。
String? thumbnailLocalPath = imgBody.thumbnailLocalPath;
```

4. 下载附件。

```dart
ChatClient.getInstance.chatManager.downloadAttachment(message);
```

下载完成后，调用相应消息 body 的 `localPath` 获取附件路径。

示例代码如下：

```dart
// 获取文件消息 body。
ChatFileMessageBody fileBody = message.body as ChatFileMessageBody;
// 从本地获取文件路径。
String? localPath = fileBody.localPath;
```

### 撤回消息

消息发送后 2 分钟以内，消息的发送方可以撤回该消息。如需调整时间限制，请联系 [support@agora.io](mailto:support@agora.io)。

```dart
try {
  await ChatClient.getInstance.chatManager.recallMessage(msgId);
} on ChatError catch (e) {
```

设置消息撤回监听器：

```dart
ChatClient.getInstance.chatManager.addEventHandler(
    "UNIQUE_HANDLER_ID",
    ChatEventHandler(
    onMessagesRecalled: (messages) {},
    ),
);
```
