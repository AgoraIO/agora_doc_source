This page provides release notes for the Agora Chat SDK for C#.

## v1.0.8

V1.0.8 was released on September 30, 2022. 
#### New features

- Supports custom chat room attributes.
- Adds the `areaCode` attribute to the `ChatOptions` class to restrict the scope of accessible edge nodes.
- Adds the `isDisabled` attribute to the `ChatGroup` class to indicate whether a group is disabled. This attribute needs to be set by developers at the server side. This attribute is returned when you call the `GetGroupSpecificationFromServer` method in `IGroupManager` to get group details.

#### Improvements

- Removed some redundant logs of the SDK.
- Changed the namespace from ChatSDK to AgoraChat.

#### Bugs fixed

- Failures in getting a large number of messages from the server in rare scenarios.
- The issue of incorrect data statistics.
- Crashes caused by log printing in rare scenarios.
- The issue that the connection listener occasionally fails to receive connection callbacks.

## v1.0.5

v1.0.5 was released on August 12, 2022.

#### New features

- Supports the presence subscription, which allows one user to subscribe to the presence of other users.
- Supports reaction, which enables users to add reaction emojis to the specified message.
- Supports message threading, which allows users to in-depth discussions on a specific message, without disrupting the conversation flow.
- Supports message translation, which allows users to translate messages.
- Supports message reporting, which allows users to report illegal messages.

#### Improvements

- Modified the way SDK handlers are managed;
- Added SDK initialization detection points;
- Allowed certain message attributes to be obtained in real time.

#### Issues fixed

- Certain data structure conversion issues.
- The JSON data was not properly converted into HTTP parameters;
- Crashes caused by incompatible character passed to parameters in HTTP requests.

## v1.0.2

v1.0.2 was released on June 17.

This is the first release for the Agora Chat C# SDK, which enables you to add real-time chatting functionalities to a Unity or Windows app. Major features include the following:

- Sending and receiving messages in one-to-one chats, chat groups, and chatrooms.
- Retrieving and managing conversations and messages.
- Managing chat groups and chatrooms.
- Managing contact and block lists.

For the complete feature list, see [Product Overview](./agora_chat_overview?platform=Unity).

Agora Chat is charged on a MAU (Monthly Active Users) basis. For details, see [Pricing for Agora Chat](./agora_chat_pricing?platform=Unity) and [Pricing Plan Details](./agora_chat_plan?platform=Unity).

Refer to the following documentations to enable Agora Chat and use the Chat SDK to implement real-time chatting functionalities in your app:

- [Enable and Configure Agora Chat](./enable_agora_chat?platform=Unity)
- [Get Started with Agora Chat](./agora-chat/agora_chat_get_started_unity?platform=Unity)
- [Messages](./agora_chat_message_overview?platform=Unity)
- [Chat Group](./agora_chat_group_overview?platform=Unity)
- [Chat Room](./agora_chat_chatroom_overview?platform=Unity)
- [API Reference](./agora-chat/API%20Reference/im_csharp/class_chat_s_d_k_1_1_s_d_k_client.html?transId=86800a60-e862-11ec-ba28-998741466f1a)