This page provides release notes for the Agora Chat Flutter SDK.

## v1.1.0

v1.1.0 was released on February 28, 2023.

#### New features

1. Adds the function of managing custom chat room attributes.
2. Adds the chat room message delivery prioritization function.
3. Adds the pagination parameters `XXX` and `XXX` in the `XXX` method to allow users to get the conversation list from the server with pagination.
4. Adds the `XXX` method to allow users to delete messages on the server in a unidirectional way.

#### Issues fixed

Some insecure code was fixed.

## v1.0.9

v1.0.9 was released on December 19.

#### Issues fixed

- Some alerts on Android 12.
- The inconsistency of messages in the memory and the database due to a call to the `updateMessage` method in rare scenarios.
- The `EMGroupEventHandler#onDestroyedFromGroup` callback that occurs when a group is destroyed does not work on the Android platform.
- The `EMGroupEventHandler#onAutoAcceptInvitationFromGroup` callback that occurs when a user's group invitation is accepted automatically does not work on the Android platform.
- Crashes in rare scenarios.

## v1.0.8

v1.0.8 was released on November 22, 2022.

#### Improvements

Removed some redundant logs of the SDK.

#### Issues fixed

- Failures in getting a large number of messages from the server in few scenarios.
- The issue of incorrect data statistics.
- Crashes caused by log printing in rare scenarios.

## v1.0.7

v1.0.7 was released on September 7, 2022.

#### New features

- Adds the `customEventHandler` attribute in `ChatClient` to allow you to set custom listeners to receive the data sent from the Android or iOS device to the Flutter. 
- Adds event listener classes for event listening.
- Adds the `PushTemplate` method in `PushManager to support custom push templates. 
- Adds the `isDisabled` attribute in `Group` to to indicate whether a group is disabled. This attribute needs to be set by developers at the server side. This attribute is returned when you call the `fetchGroupInfoFromServer` method to get group details.
- Adds the the `displayName` attribute in `PushConfigs` to allow you to check the nickname displayed in your push notifications.

#### Improvements

- Marked `AddXXXManagerListener` methods (like `addChatManagerListener`  and `addContactManagerListener`) as deprecated.

- Modified API references.

## v1.0.6

v1.0.6 was released on July 21.

#### Issues fixed

- The callbacks for messaging thread were not triggered on iOS.
- The callbacks for reaction were not triggered in iOS.
- Occasional crashes occurred on Android when retrieving conversations from the server.

## v1.0.5

v1.0.5 was released on June 17.

This is the first release for the Agora Chat Flutter SDK, which enables you to add real-time chatting functionalities to an Android or iOS app. Major features include the following:

- Sending and receiving messages in one-to-one chats, chat groups, and chat rooms.
- Retrieving and managing conversations and messages.
- Managing chat groups and chat rooms.
- Managing contact and block lists.

For the complete feature list, see [Product Overview](./agora_chat_overview?platform=Flutter).

Agora Chat is charged on a MAU (Monthly Active Users) basis. For details, see [Pricing for Agora Chat](./agora_chat_pricing?platform=Flutter) and [Pricing Plan Details](./agora_chat_plan?platform=Flutter).

Refer to the following documentations to enable Agora Chat and use the Chat SDK to implement real-time chatting functionalities in your app:

- [Enable and Configure Agora Chat](./enable_agora_chat)
- [Get Started with Agora Chat](./agora_chat_get_started_flutter)
- [Messages](./agora_chat_message_overview?platform=Flutter)
- [Chat Group](./agora_chat_group_overview?platform=Flutter)
- [Chat Room](./agora_chat_chatroom_overview?platform=Flutter)
- [API Reference](./api-ref?platform=Flutter)