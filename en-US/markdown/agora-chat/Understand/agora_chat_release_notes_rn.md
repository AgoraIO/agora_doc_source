This page provides release notes for the Agora React Native Chat SDK.

## 1.1.1

v1.1.1 was released on March 8, 2023. 

#### Issues fixed

Upon a call to the `ChatGroupManager#fetchJoinedGroupsFromServer` method, the returned extension field is empty for the joined public groups.

## v1.1.0

v1.1.0 was released on February 28, 2023.

#### New features

1. Upgrades the native platforms `iOS` and `Android` that the React Native platform depends on to v1.1.0.
2. Adds the function of managing custom chat room attributes.
3. Adds the `ChatManager#fetchConversationsFromServerWithPage` method to allow users to get the conversation list from the server with pagination.
4. Adds the `ChatMessage#messagePriority` method to implement the chat room message priority function.
5. Adds the support for push notifications on the server side to allow you to send push notifications to all users, individual users specified by IDs, or groups of users by labels. For how to configure and send push notifications, see the following RESTful API documents:
- Send push notifications (./agora_chat_restful_send_push_notification).
- Configure push notifications(./agora_chat_restful_config_push_notification).
- Set push labels(./agora_chat_restful_push_tag).

#### Improvements

- Removed the sensitive information from the test data.
- Renamed the `inviterUser` method in the `ChatGroupManager` class to `inviteUser`.
- Renamed `GROUP_ADD_USER_WHITE_LIST` in the enumeration type `ChatMultiDeviceEvent` to `GROUP_ADD_USER_ALLOW_LIST`.
- Renamed `GROUP_REMOVE_USER_WHITE_LIST` in the enumeration type `ChatMultiDeviceEvent`  to `GROUP_REMOVE_USER_ALLOW_LIST`.  

#### Issues fixed

- Some insecure code of native platforms.
- The issue of failing to retrieve conversations.
- The potential deadlock issue caused by a callback method that repeatedly enters the main thread for execution. This issue occurs only on the iOS platform.

## v1.0.11

v1.0.11 was released on December 19.

#### Issues fixed

- Some alerts on Android 12.
- The inconsistency of messages in the memory and the database due to a call to the `updateMessage` method in rare scenarios.
- Crashes in rare scenarios.

## v1.0.10

v1.0.10 was released on November 22, 2022. 

#### New features

Adds two events to the `ChatGroupEventListener` class:
- `onDetailChanged`: Occurs when group details change.
- `onStateChanged`: Occurs when the group is enabled or disabled.

#### Issues fixed

- The overlimit issue during JSON conversion on the Android platform.
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