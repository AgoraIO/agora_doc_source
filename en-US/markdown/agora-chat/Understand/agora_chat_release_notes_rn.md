This page provides release notes for the Agora React Native Chat SDK.

## V1.0.8

V1.0.8 was released on September 30, 2022. 

#### New features

- Supports custom chat room attributes.
- Adds the `areaCode` attribute to the `ChatOptions` class to restrict the scope of accessible edge nodes.
- Adds the `isDisabled` attribute to the `ChatGroupOptions` class to indicate whether a group is disabled. This attribute needs to be set by developers at the server side. This attribute is returned when you call the `fetchGroupInfoFromServer` method in `ChatGroupManager` to get group details.

#### Bugs fixed

- Failures in getting a large number of messages from the server in few scenarios.
- The issue of incorrect data statistics.
- Crashes caused by log printing in rare scenarios.

## v1.0.7

v1.0.7 was released on September 7, 2022.

#### Compatibility changes

The `unSubscribe` method is renamed `unsubscribe`.

#### New features

- Adds the `setConversationExtension` method to set the conversation extension information.
- Adds the `insertMessage` method to insert a message.
- Adds the `deleteMessagesBeforeTimestamp` method to delete messages before a specified timestamp.
- Adds the `getThreadConversation` method to get a specified thread conversation or create the thread conversation if the conversation does not exist. 
- Adds the `isChatThread` attribute to `ChatConversation` to check whether a conversation is a thread conversation.
- Adds `ChatPushManager` for the push notification configuration.
- Adds `ChatPushConfig` for the Firebase Cloud Messaging (FCM) configuration.
- Adds the `pushConfig` method in `ChatOptions` for the push initialization configuration. 
- Adds the `updatePushConfig` method in `ChatClient` for the push configuration update.

#### Improvements

- Upgraded the native SDKs (Android and iOS) to v1.0.7.
- Made the listener methods optional.
- Updated the release script.
- Updated the demo.

#### Issues fixed

JSON paring error of the `type` field in several methods.

## v1.0.6

v1.0.6 was released on July 22, 2022.

#### Compatibility changes

The following APIs are renamed:

- `deleteRemoteConversation` is renamed `removeConversationFromServer`.
- `loadAllConversations` is renamed `getAllConversations`.
- `getConversationsFromServer` is renamed `fetchAllConversations`.
- `getUnreadMessageCount` is renamed `getUnreadCount`.
- `fetchLatestMessage` is renamed `getLatestMessage`.
- `fetchLastReceivedMessage` is renamed `getLatestReceivedMessage`.
- `unreadCount` is renamed `getConversationUnreadCount`.
- `getMessagesFromTime` is renamed `getMessageWithTimestamp`.
- `WhiteList` is renamed `AllowList`.
- `BlackList` is renamed `BlockList`.

The following API are removed:

- `getMessageById`
- `insertMessage`
- `appendMessage`

#### New features

- Adds a `isOnline` field in chat messages.

#### Improvements

- Updated the API example.
- The dependent native SDK (iOS and Android) was upgraded to v3.9.4.
- React-Native was upgraded to 0.66.4 LTS version.
- The Android platform no longer needed to perform additional operations.
- `agora-react-native-chat` was changed to `react-native-agora-chat`.

#### Issues fixed

- Type declaration entry point was incorrect.


## v1.0.5

v1.0.5 was released on June 17.

This is the first release for the Agora Chat C# SDK, which enables you to add real-time chatting functionalities to a Unity or Windows app. Major features include the following:

- Sending and receiving messages in one-to-one chats, chat groups, and chatrooms.
- Retrieving and managing conversations and messages.
- Managing chat groups and chatrooms.
- Managing contact and block lists.

For the complete feature list, see [Product Overview](./agora_chat_overview?platform=React%20Native).

Agora Chat is charged on a MAU (Monthly Active Users) basis. For details, see [Pricing for Agora Chat](./agora_chat_pricing?platform=React%20Native) and [Pricing Plan Details](./agora_chat_plan?platform=React%20Native).

Refer to the following documentations to enable Agora Chat and use the Chat SDK to implement real-time chatting functionalities in your app:

- [Enable and Configure Agora Chat](./enable_agora_chat?platform=React%20Native)
- [Get Started with Agora Chat](./agora-chat/agora_chat_get_started_rn?platform=React%20Native)
- [Messages](./agora_chat_message_overview?platform=React%20Native)
- [Chat Group](./agora_chat_group_overview?platform=React%20Native)
- [Chat Room](./agora_chat_chatroom_overview?platform=React%20Native)
- [API Reference](./api-ref?platform=React%20Native)