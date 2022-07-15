Emojis are widely used in real-time chats because they allow users to express their feelings in a direct and vivid way. In Agora Chat, "reactions" allow users to quickly react to a message using emojis in one-to-one chats and chat groups. In group chats, reactions can also be used to cast a vote, for example, by calculating the number of different emojis attached to the message. 

The following illustration shows the implementation of adding a reaction to a message, how a conversation looks with reactions, and what retrieving a list of reactions (with related information) looks like.

![](https://web-cdn.agora.io/docs-files/1655257598155)

This page shows how to use the Agora Chat SDK to implement reactions in your project.

## Understand the tech

The SDK provides the following APIs to implement reaction functionalities:

- `addReaction`: Adds a reaction to the specified message.
- `removeReaction`: Removes the reaction from the specified message.
- `fetchReactionList`: Retrieves a list of reactions from the server.
- `fetchReactionDetail`: Retrieves the details of the reaction from the server.

## Prerequisites

Before proceeding, ensure that your environment meets the following requirements:

- The project integrates a version of the Agora Chat SDK later than v1.0.5 and has implemented the [basic real-time chat functionalities](./agora_chat_get_started_flutter?platform=Flutter).
- You understand the API call frequency limit as described in [Limitations](./agora_chat_limitation?platform=Flutter).

## Implementation

This section introduces how to implement reaction functionalities in your project.

### Add a reaction

Call `addReaction` to add a reaction to the specified message. You can use `onMessageReactionDidChange` to listen for the state of adding the reaction.

```dart
// reaction: Reaction ID
// msgId: The message ID
// Adds a reaction to the specified message
ChatClient.getInstance()
  .chatManager.addReaction(reaction, msgId)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### Remove a reaction

Call `removeReaction` to remove the specified reaction. You can also listen for the reaction change in `onMessageReactionDidChange`.

```dart
try {
  await ChatClient.getInstance.chatManager.addReaction(
    messageId: messageId,
    reaction: reaction,
  );
} on ChatError catch (e) {
}
```

### Retrieve a list of reactions

Call `getReactionList` to retrieve a list of reactions from the server. This method also returns the basic information of the reactions, including the content of the reaction, the number of users that added or removed the reaction, and a list of the first three user IDs that added or removed the reaction.

```dart
try {
  Map<String, List<ChatMessageReaction>> map =
      await ChatClient.getInstance.chatManager.fetchReactionList(
    messageIds: messageIds,
    chatType: ChatType.GroupChat,
    groupId: groupId,
  );
} on ChatError catch (e) {
}
```

You can also use the `reactionList` member in `ChatMessage` to quickly retrieve the reactions of the specified message.

```dart
try {
    List<ChatMessageReaction> reactions = await msg.reactionList();
}on ChatError catch (e) {
}
```

### Retrieve the details of the reaction

Call `fetchReactionDetail` to get the detailed information of the reaction from the server. The detailed information includes the reaction content, the number of users that added or removed the reaction, and the complete list of user IDs that added or removed the reaction.

```dart
try {
  ChatCursorResult<ChatMessageReaction> result =
      await ChatClient.getInstance.chatManager.fetchReactionDetail(
    messageId: messageId,
    reaction: reaction,
  );
} on ChatError catch (e) {
}
```


### Listen for reaction status

Use `onMessageReactionDidChange` to listen for changes or status of the reaction.

```dart
// Listen for reaction updates
class _ChatPageState extends State<ChatPage> implements ChatManagerListener {
  @override
  void initState() {
    super.initState();
    ChatClient.getInstance.chatManager.addChatManagerListener(this);
  }
  @override
  void dispose() {
    ChatClient.getInstance.chatManager.removeChatManagerListener(this);
    super.dispose();
  }
  @override
  void onMessageReactionDidChange(List<ChatMessageReactionChange> list) {}
  // Add other callbacks according to your business logic
  ...
}
```