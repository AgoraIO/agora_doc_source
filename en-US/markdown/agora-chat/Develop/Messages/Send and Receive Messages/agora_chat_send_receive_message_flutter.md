After logging in to Agora Chat, users can send the following types of messages to a peer user, a chat group, or a chat room:
- Text messages, including hyperlinks and emojis.
- Attachment messages, including image, voice, video, and file messages.
- Location messages.
- CMD messages.
- Extended messages.
- Custom messages.

In high-concurrency scenarios, you can set a certain message type or messages from a chat room member as high, normal, or low. In this case, low-priority messages are dropped first to reserve resources for the high-priority ones (e.g. gifts and announcements) when the server is overloaded. This ensures that the high-priority messages can be dealt with first when loads of messages are being sent in high concurrency or high frequency. Note that this feature can increase the delivery reliability of high-priority messages, but cannot guarantee the deliveries. Even high-priorities messages can be dropped when the server load goes too high.

This page shows how to implement sending and receiving these messages using the Agora Chat SDK.

## Understand the tech

The Agora Chat SDK for Flutter uses the `ChatMessage` and `ChatMessage` classes to send, receive, and withdraw messages.

The process of sending and receiving a message is as follows:

1. The message sender creates a text, file, or attachment message using the corresponding `create` method.
2. The message sender calls `sendMessage` to send the message.
3. The message recipient listens for `ChatEventHandler` and receives the message in the `onMessagesReceived` callback.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:
- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_flutter?platform=Flutter).
- You understand the [API call frequency limits](./agora_chat_limitation?platform=Flutter).

## Implementation

This section shows how to implement sending and receiving the various types of messages.

### Send a message

Follow the steps to create and send a message, and listen for the result of sending the message.

1. Use the `ChatMessage` class to create a message.

```dart
// Sets the message type. Agora Chat supports 8 message types.
MessageType messageType = MessageType.TXT;
// Sets `targetId` to the user ID of the peer user in one-to-one chat, group ID in group chat, and chat room ID in room chat.
String targetId = "tom";
// Sets `chatType` as `Chat`, `GroupChat`, or `ChatRoom` for one-to-one chat, group chat, or room chat.
ChatType chatType = ChatType.Chat;
// Creates a message. Parameters vary with message types.
// Creates a text message.
ChatMessage msg = ChatMessage.createTxtSendMessage(
    targetId: targetId,
    content: "This is text message",
);
// Creates an image message. You need to set the local path, length, and width of the image file, and the image name displayed on the UI.
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
// Creates a CMD message. A CMD message contains a command for the recipient to take action. You can customize the command.
String action = "writing";
ChatMessage msg = ChatMessage.createCmdSendMessage(
    targetId: targetId,
    action: action,
);
// Creates a custom message. A custom message contains the message event type and the extension field.
// You can customize the extension field according to your use case.
String event = "gift";
Map<String, String> params = {"key": "value"};
ChatMessage msg = ChatMessage.createCustomSendMessage(
    targetId: targetId,
    event: event,
    params: params,
);
// Creates a file message. A file message contains the local file path and the name displayed on the UI.
String filePath = "data/.../foo.zip";
String fileName = "foo.zip";
int fileSize = 6000;
ChatMessage fileMsg = ChatMessage.createFileSendMessage(
    targetId: targetId,
    filePath: filePath,
    displayName: fileName,
    fileSize: fileSize,
);
// Creates a location message. You need to set the longitude and latitude information of the location, as well as the name of the location.
// To send a location message, you need to integrate a third-party map service provider to get the longitude and latitude information of the location. When the recipient receives the location information, the service provider renders the location on the map according to the longitude and latitude information.
double latitude = 114.78;
double longitude = 39.89;
String address = "darwin";
ChatMessage msg = ChatMessage.createLocationSendMessage(
    targetId: targetId,
    latitude: latitude,
    longitude: longitude,
    address: address,
);
// Creates a video message. A video message includes two attachment files, including the video file and the thumbnail of the video. The SDK uses the first frame of the video as the thumbnail. You also need to set the local path, length, width, display name, and duration of the video file.
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
// Creates a voice message. A voice message contains the local path, display name, and duration of the audio file.
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
// Set the priority of the chat room message. The default priority is `Normal`, indicating the normal priority.
if (msg.chatType == ChatType.ChatRoom) {
    msg.chatroomMessagePriority = ChatRoomMessagePriority.High;
}
```

2. Send the message using `sendMessage` in `ChatManager`.

```dart
ChatClient.getInstance.chatManager.sendMessage(message).then((value) {
});
```

To get the progress and result of the message sending, you need to implement `ChatManager#addMessageEvent`. For CMD messages which do not necessarily need a result, you do not need to set the callback.

```dart
// Adds a message status listener.
ChatClient.getInstance.chatManager.addMessageEvent(
    "UNIQUE_HANDLER_ID",
    ChatMessageEvent(
        // Occurs when the message sending succeeds. You can update the message and add other operations in this callback.
        onSuccess: (msgId, msg) {
        // msgId: The pre-sending message ID.
        // msg: The message that is sent successfully.
        },
        // Occurs when the message sending fails. You can update the message status and add other operations in this callback.
        onError: (msgId, msg, error) {
        // msgId: The pre-sending message ID.
        // msg: The message that fails to be sent.
        // error: The error description.
        },
        // For attachment messages such as image, voice, file, and video, you can get a progress value for uploading or downloading them in this callback.
        onProgress: (msgId, progress) {
        // msgId: The pre-sending message ID.
        // progress: The sending progress.
        },
    ),
);
void dispose() {
    // Removes the message status listener.
    ChatClient.getInstance.chatManager.removeMessageEvent("UNIQUE_HANDLER_ID");
    super.dispose();
}
// The result of the messaging sending is returned in the callback. The return value of the method only indicates the result of the message call.
ChatClient.getInstance.chatManager.sendMessage(message).then((value) {
   // Finishes sending the message.
});
```

### Receive the message

You can use `ChatEventHandler` to listen for message events. You can add multiple `ChatEventHandler` objects to listen for multiple events. When you no longer listen for an event, for example, when you call `dispose`, ensure that you remove the object.

When a message arrives, the recipient receives an `onMessagesReceived` callback. Each callback contains one or more messages. You can traverse the message list, and parse and render these messages in this callback.

```dart
// Adds a chat event handler.
ChatClient.getInstance.chatManager.addEventHandler(
    "UNIQUE_HANDLER_ID",
    ChatEventHandler(
        onMessagesReceived: (messages) {},
    ),
);

...

// Removes the chat event handler.
ChatClient.getInstance.chatManager.removeEventHandler("UNIQUE_HANDLER_ID");
```

When a voice message is received, the SDK automatically downloads the audio file.

For image and video messages, the SDK automatically generates a thumbnail when you create the message. When an image or video message is received, the SDK automatically downloads the thumbnail. To manually download the attachment files, follow the steps:

1. Set `isAutoDownloadThumbnail` as true when initializing the SDK.

```dart
ChatOptions options = ChatOptions(
    appKey: "<#Your AppKey#>",
    isAutoDownloadThumbnail: false,
);
```

2. Set the status callback for the download.

```dart
// Adds a message status listener.
ChatClient.getInstance.chatManager.addMessageEvent(
    "UNIQUE_HANDLER_ID",
    ChatMessageEvent(
        // Occurs when the message is downloaded successfully.
        onSuccess: (msgId, msg) {
        // msgId: The message ID.
        // msg: The message that is downloaded successfully.
        },
        // Occurs when the message fails to be downloaded.
        onError: (msgId, msg, error) {
        // msgId: The message ID.
        // msg: The message that fails to be downloaded.
        // error: The reason for the download failure.
        },
        // For attachment messages such as image, voice, file, and video, you can get a progress value for uploading or downloading them in this callback.
        onProgress: (msgId, progress) {
        // msgId: The message ID.
        // progress: The upload or download progress.
        },
    ),
);
void dispose() {
    // Removes the message status listener.
    ChatClient.getInstance.chatManager.removeMessageEvent("UNIQUE_HANDLER_ID");
    super.dispose();
}
```

3. Download the thumbnail and get the path to it.

```dart
ChatClient.getInstance.chatManager.downloadThumbnail(message);
```

  Get the path to the thumbnail from the `thumbnailLocalPath` member in the message body.

```dart
// Get the message body of the image file.
ChatImageMessageBody imgBody = message.body as ChatImageMessageBody;
// Get the local path to the thumbnail.
String? thumbnailLocalPath = imgBody.thumbnailLocalPath;
```

4. Call `downloadAttachment` to download the file.

  ```dart
  ChatClient.getInstance.chatManager.downloadAttachment(message);
  ```

  Get the path to the attachment from the `localPath` member in the message body.

  ```dart
  // Get the message body.
  ChatFileMessageBody fileBody = message.body as ChatFileMessageBody;
  // Get the local path of the file.
  String? localPath = fileBody.localPath;
  ```

### Recall a message

After a message is sent, you can recall it. The `recallMessage` method recalls a message that is saved both locally and on the server, whether it is a historical message, offline message or a roaming message on the server, or a message in the memory or local database of the message sender or recipient.

You can recall a message sent within two minutes by default. If you want to adjust the time limit, contact [support@agora.io](mailto:support@agora.io).

```dart
try {
  await ChatClient.getInstance.chatManager.recallMessage(msgId);
} on ChatError catch (e) {}
```

You can also use `ChatEventHandler` to listen for the state of recalling the message:

```dart
ChatClient.getInstance.chatManager.addEventHandler(
    "UNIQUE_HANDLER_ID",
    ChatEventHandler(
    onMessagesRecalled: (messages) {},
    ),
);
```

### Use message extensions

If the message types listed above do not meet your requirements, you can use message extensions to add attributes to the message. This can be applied in more complicated messaging scenarios.

```typescript
try {
  final msg = ChatMessage.createTxtSendMessage(
    targetId: targetId,
    content: 'content',
  );

  msg.attributes = {'k': 'v'};
  ChatClient.getInstance.chatManager.sendMessage(msg);
} on ChatError catch (e) {}

```

## Next steps

After implementing sending and receiving messages, you can refer to the following documents to add more messaging functionalities to your app:

- [Manage local messages](./agora_chat_manage_message_flutter?platform=Flutter)
- [Retrieve conversations and messages from the server](./agora_chat_retrieve_message_flutter?platform=Flutter)
- [Message receipts](./agora_chat_message_receipt_flutter?platform=Flutter)