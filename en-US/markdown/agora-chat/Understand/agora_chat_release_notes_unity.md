This page provides release notes for the Agora Chat SDK for C#.

## v1.1.0

v1.1.0 was released on February 28, 2023.

#### New features

1. Upgrades the native platforms `iOS` and `Android` that the Unity platform depends on to v1.1.0.
2. Adds the function of managing custom chat room attributes to implement functions like seat control and synchronization in voice chatrooms.
3. Adds the `ChatManager#GetConversationsFromServerWithPage` method to allow users to get the conversation list from the server with pagination.
4. Adds the `Message#Priority` attribute to implement the chat room message priority function to ensure that high-priority messages are dealt with first.
5. Adds the support for push notifications on the server side to allow you to send push notifications to all users, individual users specified by IDs, or groups of users by labels. For how to configure and send push notifications, see the following RESTful API documents:
- Send push notifications (./agora_chat_restful_send_push_notification).
- Configure push notifications(./agora_chat_restful_config_push_notification).
- Set push labels(./agora_chat_restful_push_tag).

#### Improvements

Modified the `SDKClient#InitWithOptionsInitWithOptions` method by adding the return result for the App Key format check.

#### Issues fixed

- Some login bugs.
- The issue that the read flag for the sent messages is set to `false`. After this issue is fixed, the SDK sets the read flag of a sent message to `true`.
- The names of encrypted database files are not properly generated. This issue is specific only to the Mac and Windows platforms for the Unity framework. If you need historical messages upon upgrade to v1.1.0, you are advised to first pull data from the server. 

## v1.0.9

v1.0.9 was released on February 1, 2023.

#### New features

1. Adds the following methods to the `SDKClient` class:     
  - `GetLoggedInDevicesFromServer`: Gets the list of online devices on which you have logged in with a specified account.
  - `KickDevice`: Logs out from a specified account on a device.
  - `kickAllDevices`: Logs out from a specified account on all devices.
2. Adds the following methods to the `RoomManager` class: 
  - `FetchAllowListFromServer`: Gets the allow list of a chat room from the server.
  - `CheckIfInRoomAllowList`: Checks whether the current member is on the chat room block list.
  - `GetChatRoom`: Gets the details of a chat room from the memory.
  - `UnMuteAllRoomMembers`: Unmutes all members of a chat room.
3. Adds the following callbacks to the `IRoomManagerDelegate` class:
  - `OnSpecificationChangedFromRoom`: Occurs when specifications of a chat room are changed.
  - `OnAddAllowListMembersFromChatroom`: Occurs when a chat room member(s) is/are added to the allow list of a chat room.
  - `OnRemoveAllowListMembersFromChatroom`: Occurs when a chat room member(s) is/are removed from the allow list of a chat room.
  - `OnRemoveFromRoomByOffline`: Occurs when a member is removed from a chat room because he or she gets offline.             
4. Adds the following callbacks to the `IConnectionDelegate` class:
  - `OnLoggedOtherDevice`: Occurs when the user logs in to another device with the current account.
  - `OnRemovedFromServer`：Occurs when the current user account is removed from the server.
  - `OnForbidByServer`: Occurs when the current user account is banned by the server.
  - `OnChangedIMPwd`：Occurs when the user is forced to log out of the current account because the login password is changed.
  - `OnLoginTooManyDevice`:  Occurs when the user is forced to log out of the current account because she or he has exceeded the maximum number of devices allowed for this account.
  - `OnKickedByOtherDevice`：Occurs when the user is forced to log out of the current account from the current device due to the login to another device. 
  - `OnAuthFailed`: Occurs when the user is forced to log out of the current account due to an authentication failure.
5. Adds the following attributes to the `Group` class:           
  - `IsMemberOnly`: Whether users can join a group only via a join request or a group invitation, but cannot join freely. 
  - `IsMemberAllowToInvite`: Whether all the group members, other than the group owner and admins, can invite users to join the group.
  - `MaxUserCount`：The maximum number of users that can join the group.
  - `Ext`: The custom group extension information.
  - `IsDisabled`: Whether the group is disabled.     
              
#### Improvements

1. Changed the name space from ChatSDK to AgoraChat.
2. Renamed the `handle` parameter in the methods as `callback`.
3. Removed the `pushmanager` class.
4. Capitalized the name of each field in the `UserInfo` class.
5. Removed the `UINT32` and `JSONSTRING` types from the `AttributeValue` subclass in the `Message` class.
6. Removed the `i` parameter of the integer type from the `OnDisconnected` method.
7. Adjusted the returned result of the following methods:
  - `importmessage`: When this method is called, the asynchronous callback is triggered instead of the result returned directly.
  - `GetGroupMuteListFromServer`: The data type of the returned result is changed from `List<string>` to `Dictionary<string, string>`.
  - `FetchRoomMuteList`: The data type of the returned result is changed from `List<string>` to `Dictionary<string, string>`.
8. Renamed the following methods in the `GroupManager` class:
  - `AddGroupWhiteList` was renamed `AddGroupAllowList`.
  - `CheckIfInGroupWhiteList` was renamed `CheckIfInGroupAllowList`.
  - `GetGroupWhiteListFromServer` was renamed `GetGroupAllowListFromServer`.
  - `RemoveGroupWhiteList` was renamed `RemoveGroupAllowList`.            
9. Renamed the following methods in the `RoomManager` class:
  - `AddWhiteListMembers` was renamed `AddAllowListMembers`.
  - `RemoveWhiteListMembers` was renamed `RemoveAllowListMembers`.                
10. Changed the `ReactionList` attribute in the `Message` class to be a method.           
11. Changed the visibility of options in `Options` in the `Group` class from public to internal.                 
12. Made the following adjustments in the `IGroupManagerDelegate` class:
  - `OnAddWhiteListMembersFromGroup` was renamed `OnAddAllowListMembersFromGroup`.
  - `OnRemoveWhiteListMembersFromGroup` was renamed `OnRemoveAllowListMembersFromGroup`.
  - The `reason` parameter was removed from the `OnInvitationAcceptedFromGroup` method.
  - The `groupName` and `decliner` parameters were removed from the `OnRequestToJoinDeclinedFromGroup` method.

## v1.0.8

v1.0.8 was released on November 3, 2022. 

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