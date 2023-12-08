Emojis are widely used in real-time chats because they allow users to express their feelings in a direct and vivid way. In Agora Chat, "reactions" allow users to quickly react to a message using emojis in one-to-one chats and chat groups. In group chats, reactions can also be used to cast a vote, for example, by calculating the number of different emojis attached to the message. 

The following illustrations show the implementation of adding a reaction to a message, and what retrieving a list of reactions (with related information) looks like.

- Adding a reaction

  ![](https://web-cdn.agora.io/docs-files/1655257804635)
	
- Retrieving a list of reactions

  ![](https://web-cdn.agora.io/docs-files/1655257845986)

This page shows how to use the Agora Chat SDK to implement reactions in your project.

## Understand the tech

The SDK provides the following APIs to implement reaction functionalities:

- `addReaction`: Adds a reaction to the specified message.
- `deleteReaction`: Removes the reaction from the specified message.
- `getReactionList`: Retrieves a list of reactions from the server.
- `getReactionDetail`: Retrieves the details of the reaction from the server.
- `getHistoryMessages`：Retrieves the reactions in historical messages from the server.

## Prerequisites

Before proceeding, ensure that your environment meets the following requirements:

- The project integrates a version of the Agora Chat SDK later than v1.0.3 and has implemented the [basic real-time chat functionalities](./agora_chat_get_started_web?platform=Web).
- You understand the API call frequency limit as described in [Limitations](./agora_chat_limitation?platform=Web).

<div class="alert info">The reaction feature is supported by all types of <a href="https://docs.agora.io/en/agora-chat/agora_chat_plan">Pricing Plans</a> and is enabled by default once you have enabled Chat in <a href="https://console.agora.io/">Agora Console</a>.</div>

## Implementation

This section introduces how to implement reaction functionalities in your project.

### Add a reaction

Call `addReaction` to add a reaction to the specified message. In a one-to-one conversation, the peer user receives the `onReactionChange` event. In a group conversation, other group members than the operator receive this event. This event contains the conversation ID, message ID, reaction list of the message, and reaction operation list (reaction ID, user ID of the user that adds the reaction, and the addition operation). 

For a reaction, a user can add only once, or the error 1101 is reported for repeated addition.

```javascript
// Add a reaction
conn.addReaction({ messageId: "messageId", reaction: "reaction" });
// Listen for the state of the reaction.
conn.addEventHandler("REACTION", {
  onReactionChange: (reactionMsg) => {
    console.log(reactionMsg);
  },
});
```

### Remove a reaction

Call `deleteReaction` to remove the specified reaction. In a one-to-one conversation, the peer user receives the `onReactionChanged` event. In a group conversation, other group members than the operator receive this event. This event contains the conversation ID, message ID, reaction list of the message, and reaction operation list (ID of the removed reaction, user ID of the user that removes the reaction, and the removal operation). 

```javascript
// Remove the reaction.
conn.deleteReaction({ messageId: "messageId", reaction: "reaction" });
// Listen for reaction state change.
conn.addEventHandler("REACTION", {
  onReactionChange: (reactionMsg) => {
    console.log(reactionMsg);
  },
});
```

### Retrieve a list of reactions

Call `getReactionList` to retrieve a list of reactions of messages from the server. This method also returns the basic information of the reactions, including the content of the reaction, the number of users that added or removed the reaction, and a list of the first three user IDs that added or removed the reaction.

```javascript
conn
  .getReactionList({ chatType: "singleChat", messageId: "messageId" })
  .then((res) => {
    console.log(res);
  });
```

### Retrieve the details of the reaction

Call `getReactionDetail` to get the detailed information of the reaction from the server. The detailed information includes the reaction content, the number of users that added or removed the reaction, and the complete list of user IDs that added or removed the reaction.

```javascript
conn
  .getReactionDetail({
    messageId: "messageId",
    reaction: "reaction",
    cursor: null,
    pageSize: 20,
  })
  .then((res) => {
    console.log(res);
  });
```

### Retrieve the reaction in the historical message from the server

When calling `getHistoryMessages` to retrieve historical messages from the server, if the message has a reaction attached to it, the retrieved message body also contains the information of the reaction.

```javascript
conn.getHistoryMessages({ targetId:'targetId',chatType:'groupChat', pageSize: 20 }).then((messages) => {
  console.log(messages);
});
```

## Next steps

Reactions are also supported in the [Chat UIKit](./agora_chat_uikit_web?platform=Web), which contains a wider range of emojis. You can also use the UIKit to implement reactions in your project.