Emojis are widely used in real-time chats because they allow users to express their feelings in a direct and vivid way. In Agora Chat, "reactions" allow users to quickly react to a message using emojis in one-to-one chats and chat groups. In group chats, reactions can also be used to cast a vote, for example, by calculating the number of different emojis attached to the message. 

The following illustration shows the implementation of adding a reaction to a message, how a conversation looks with reactions, and what retrieving a list of reactions (with related information) looks like.

![](https://web-cdn.agora.io/docs-files/1655257598155)


This page shows how to use the Agora Chat SDK to implement reactions in your project.

## Understand the tech

The SDK provides the following APIs to implement reaction functionalities:

- `addReaction`: Adds a reaction to the specified message.
- `removeReaction`: Removes the reaction from the specified message.
- `getReactionList`: Retrieves a list of reactions from the server.
- `getReactionDetail`: Retrieves the details of the reaction from the server.
- `AgoraChatMessage.reactionlist`: Retrieves a list of reactions from the `AgoraChatMessage` objects in the local database.

## Prerequisites

Before proceeding, ensure that your environment meets the following requirements:

- The project integrates a version of the Agora Chat SDK later than v1.0.3 and has implemented the [basic real-time chat functionalities](./agora_chat_get_started_ios?platform=iOS).
- You understand the API call frequency limit as described in [Limitations](./agora_chat_limitation?platform=iOS).

<div class="alert info">The reaction feature is supported by all types of <a href="https://docs.agora.io/en/agora-chat/agora_chat_plan">Pricing Plans</a> and is enabled by default once you have enabled Chat in <a href="https://console.agora.io/">Agora Console</a>.</div>

## Implementation

This section introduces how to implement reaction functionalities in your project.

### Add a reaction

Call `addReaction` to add a reaction to the specified message. You can use `messageReactionDidChange` to listen for the state of adding the reaction.

```Objective-C
// Add a reaction
[AgoraChatClient.sharedClient.chatManager addReaction:"reaction" toMessage:"messageId" completion:^(AgoraChatError * _Nullable error) {
	refreshBlock(error, changeSelectedStateHandle);
}];
// Listen for the state of the reaction.
- (void)messageReactionDidChange:(NSArray<AgoraChatMessageReactionChange *> *)changes
{
	
}
```

### Remove a reaction

Call `removeReaction` to remove the specified reaction. You can also listen for the reaction change in `messageReactionDidChange`.

```Objective-C
// Remove the reaction.
[AgoraChatClient.sharedClient.chatManager removeReaction:"reaction" fromMessage:"messageId" completion:^(AgoraChatError * _Nullable error) {
	refreshBlock(error, changeSelectedStateHandle);
}];
// Listen for reaction state change.
- (void)messageReactionDidChange:(NSArray<AgoraChatMessageReactionChange *> *)changes
{
	
}
```

### Retrieve a list of reactions

Call `getReactionList` to retrieve a list of reactions from the server. This method also returns the basic information of the reactions, including the content of the reaction, the number of users that added or removed the reaction, and a list of the first three user IDs that added or removed the reaction.

```Objective-C
[AgoraChatClient.sharedClient.chatManager getReactionList:@["messageId"] groupId:@"groupId" chatType:AgoraChatTypeChat completion:^(NSDictionary<NSString *, AgoraChatMessageReaction *> * _Nonnull, AgoraChatError * _Nullable) {
                    
}];
```

### Retrieve the details of the reaction

Call `getReactionDetail` to get the detailed information of the reaction from the server. The detailed information includes the reaction content, the number of users that added or removed the reaction, and the complete list of user IDs that added or removed the reaction.

```Objective-C
[AgoraChatClient.sharedClient.chatManager getReactionDetail:@"messageId" reaction:@"reaction" cursor:nil pageSize:30 completion:^(AgoraChatMessageReaction * _Nonnull, NSString * _Nullable cursor, AgoraChatError * _Nullable) {
            
}];
```

## Next steps

Reactions are also supported in the [Chat UIKit](./agora_chat_uikit_ios?platform=iOS), which contains a wider range of emojis. You can also use the UIKit to implement reactions in your project.