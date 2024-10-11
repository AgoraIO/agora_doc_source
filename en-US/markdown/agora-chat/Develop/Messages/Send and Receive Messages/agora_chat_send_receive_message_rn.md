After logging in to Agora Chat, users can send the following types of messages to a peer user, a chat group, or a chat room:
- Text messages, including hyperlinks and emojis.
- Attachment messages, including image, voice, video, and file messages.
- Location messages.
- CMD messages.
- Custom messages.

In high-concurrency scenarios, you can set a certain message type or messages from a chat room member as high, normal, or low. In this case, low-priority messages are dropped first to reserve resources for the high-priority ones (e.g. gifts and announcements) when the server is overloaded. This ensures that the high-priority messages can be dealt with first when loads of messages are being sent in high concurrency or high frequency. Note that this feature can increase the delivery reliability of high-priority messages, but cannot guarantee the deliveries. Even high-priorities messages can be dropped when the server load goes too high.

This page shows how to implement sending and receiving these messages using the Agora Chat SDK.

## Understand the tech

The Agora Chat SDK uses the `ChatManager` and `ChatMessage` classes to send, receive, and withdraw messages.

The process of sending and receiving a message is as follows:

1. The message sender creates a text, file, or attachment message using the corresponding `Create` method.
2. The message sender calls `sendMessage` to send the message.
3. The message recipient listens for `ChatMessageEventListener` and receives the message in the `onMessagesReceived` callback.

## Prerequistes

Before proceeding, ensure that you meet the following requirements:
- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_rn?platform=React%20Native).
- You understand the [API call frequency limits](./agora_chat_limitation?platform=React%20Native).

## Implementation

This section shows how to implement sending and receiving the various types of messages.

### Send a message

Implement the `ChatMessageStatusCallback` class to listen for the progress and result of the message sending. 

```typescript
// Implement ChatMessageStatusCallback
class ChatMessageCallback implements ChatMessageStatusCallback {
  onProgress(localMsgId: string, progress: number): void {
    console.log(`sendMessage: onProgress: `, localMsgId, progress);
    // For attachment messages such as voice and video, you can use the percentage value to represent the uploading or downloading progress.
  }
  onError(localMsgId: string, error: ChatError): void {
    console.log(`sendMessage: onError: `, localMsgId, error);
    // Update the message state or add subsequent handling logics after receiving the callback.
  }
  onSuccess(message: ChatMessage): void {
    console.log(`sendMessage: onSuccess: `, message);
    // Update the message state or add subsequent handling logics after receiving the callback.
  }
  // You can set the priority of chat room messages. The default priority is `PriorityNormal`, indicating the normal priority.
  if (ret.chatType === ChatMessageChatType.ChatRoom) {
    ret.messagePriority = priority;
  }

  ChatClient.getInstance()
  .chatManager.sendMessage(msg!, new ChatMessageCallback())
  .then(() => {
  // The sending operation is complete and the log is printed here. 
  // The sending operation is returned via callback.
  console.log("send message operation success.");
  })
  .catch((reason) => {
  // The sending operation fails and the log is printed here.
  console.log("send message operation fail.", reason);
  })
  };
```

Use the `ChatMessage` class to create a message, and `ChannelManager` to send the message. 

```typescript
// Set the message type. The SDK supports 8 message types. 
const messageType = ChatMessageType.TXT;
// Set `targetId` to the user ID of the peer user in one-to-one chat, group ID in group chat, and chat room ID in room chat.
const targetId = "tom";
// Set `chatType` as `PeerChat`, `GroupChat`, or `ChatRoom` for one-to-one chat, group chat, or room chat.
const chatType = ChatMessageChatType.PeerChat;
// Construct the message. Parameters vary with message types.
let msg: ChatMessage;
if (messageType === ChatMessageType.TXT) {
  // For a text message, set the message content.
  const content = "This is text message";
  msg = ChatMessage.createTextMessage(targetId, content, chatType);
} else if (messageType === ChatMessageType.IMAGE) {
  // For an image message, set the file path, width, height, and display name of the image file.
  // For the image file path, `file://` is unnecessary.
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
  // Construct a command message. You can customize the command.
  const action = "writing";
  msg = ChatMessage.createCmdMessage(targetId, action, chatType);
} else if (messageType === ChatMessageType.CUSTOM) {
  // Customize the message. The message content comprises of the event type and the extension field.
  // Allow the chat users to set the event and the extension field.
  const event = "gift";
  const ext = { key: "value" };
  msg = ChatMessage.createCustomMessage(targetId, event, chatType, {
    params: JSON.parse(ext),
  });
} else if (messageType === ChatMessageType.FILE) {
  // Construct a file message. You need to set the file path and display name of the file.
  // For the file path, `file://` is unnecessary.
  const filePath = "data/.../foo.zip";
  const displayName = "study_data.zip";
  msg = ChatMessage.createFileMessage(targetId, filePath, chatType, {
    displayName,
  });
} else if (messageType === ChatMessageType.LOCATION) {
  // Construct a location message. You need to set the latitude and longitude information of the location, as well as the address of the location.
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
  // Construct a video message, which includes the video file and thumbnail of the video. You need to set the file path, width, height, display name, and duration of the video file.
  // You also need to set the path of the thumbnail on the local device.
  // A video message contains two attachment files.
  // For the video file path and thumbnail path, `file://` is unnecessary.
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
  // Construct a voice message. You need to set the filepath, display name, and duration of the audio file.
  // For the voice file path, `file://` is unnecessary.
  const filePath = "data/.../foo.wav";
  const displayName = "bar.mp4";
  const duration = 5;
  msg = ChatMessage.createVoiceMessage(targetId, filePath, chatType, {
    displayName,
    duration,
  });
} else {
  // Exceptions occur if the message type you set is not supported.
  throw new Error("Not implemented.");
}
// Implement ChatMessageCallback to listen for the message sending event. The result only indicates the result of this method call, not whether the message sending succeeds or fails.
ChatClient.getInstance()
  .chatManager.sendMessage(msg!, new ChatMessageCallback())
  .then(() => {
    // Print the log here if the method call succeeds.
    console.log("send message success.");
  })
  .catch((reason) => {
    // Print the log here if the method call fails.
    console.log("send message fail.", reason);
  });
```

### Receive the message

You can use `ChatMessageEventListener` to listen for message events. You can add multiple `ChatMessageEventListener` objects to listen for multiple events. When you no longer listen for an event, ensure that you remove the object.

When a message arrives, the recipient receives an `onMessgesReceived` callback. Each callback contains one or more messages. You can traverse the message list, and parse and render these messages in this callback.

```typescript
// Inherit and implement ChatMessageEventListener
class ChatMessageEvent implements ChatMessageEventListener {
  onMessagesReceived(messages: ChatMessage[]): void {
    console.log(`onMessagesReceived: `, messages);
  }
  onCmdMessagesReceived(messages: ChatMessage[]): void {
    console.log(`onCmdMessagesReceived: `, messages);
  }
  onMessagesRead(messages: ChatMessage[]): void {
    console.log(`onMessagesRead: `, messages);
  }
  onGroupMessageRead(groupMessageAcks: ChatGroupMessageAck[]): void {
    console.log(`onGroupMessageRead: `, groupMessageAcks);
  }
  onMessagesDelivered(messages: ChatMessage[]): void {
    console.log(`onMessagesDelivered: ${messages.length}: `, messages);
  }
  onMessagesRecalled(messages: ChatMessage[]): void {
    console.log(`onMessagesRecalled: `, messages);
  }
  onConversationsUpdate(): void {
    console.log(`onConversationsUpdate: `);
  }
  onConversationRead(from: string, to?: string): void {
    console.log(`onConversationRead: `, from, to);
  }
}
// Listen for the message event.
const listener = new ChatMessageEvent();
ChatClient.getInstance().chatManager.addMessageListener(listener);
// Remove the specified message listener.
ChatClient.getInstance().chatManager.removeMessageListener(listener);
// Remove all the message listeners.
ChatClient.getInstance().chatManager.removeAllMessageListener();
```

### Recall a message

After a message is sent, you can recall it. The `recallMessage` method recalls a message that is saved both locally and on the server, whether it is a historical message, offline message or a roaming message on the server, or a message in the memory or local database of the message sender or recipient. 

You can recall a message sent within two minutes by default. If you want to adjust the time limit, contact [support@agora.io](mailto:support@agora.io).

<div class="alert info">Except CMD messages, you can recall all types of message.</div>

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

You can also use `ChatMessageEventListener` to listen for the state of recalling the message:

```typescript
// Occurs when the message is recalled.
onMessagesRecalled(messages: ChatMessage[]): void;
```

### Use message extensions

If the message types listed above do not meet your requirements, you can use message extensions to add attributes to the message. This can be applied in more complicated messaging scenarios.

```typescript
const msg = ChatMessage.createTextMessage(targetId, 'textmessage', chatType);
msg.attributes = {
  key: "value",
  {
    key2: 100
  }
};
EMClient.getInstance().chatManager().sendMessage(msg, callback).then().catch();

```

## Next steps

After implementing sending and receiving messages, you can refer to the following documents to add more messaging functionalities to your app:

- [Manage local messages](./agora_chat_manage_message_rn?platform=React%20Native)
- [Retrieve conversations and messages from the server](./agora_chat_retrieve_message_rn?platform=React%20Native)
- [Message receipts](./agora_chat_message_receipt_rn?platform=React%20Native)



