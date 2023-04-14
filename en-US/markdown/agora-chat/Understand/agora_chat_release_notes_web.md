This page provides release notes for the Agora Chat Web SDK.

## v1.1.0

v1.1.0 was released on February 28, 2023.

#### New features

1. Adds the function of managing custom chat room attributes to implement functions like seat control and synchronization in voice chatrooms.
2. Adds the `priority` attribute to the message creation method `create` to implement the chat room message priority function to ensure that high-priority messages are dealt with first.
3. Adds the pagination parameters `pageNum` and `pageSize` in the `getConversationlist` method to allow users to get the conversation list from the server with pagination.
5. Adds the group creation event `create` which occurs on other devices of the group owner after group creation.
6. Adds the support for push notifications on the server side to allow you to send push notifications to all users, individual users specified by IDs, or groups of users by labels. For how to configure and send push notifications, see the following RESTful API documents:
- Send push notifications (./agora_chat_restful_send_push_notification).
- Configure push notifications(./agora_chat_restful_config_push_notification).
- Set push labels(./agora_chat_restful_push_tag).

#### Improvements

Reduced the size of MiniCore.

#### Issues fixed

Type-related issues in code written in TypeScript.

## v1.0.8

v1.0.8 was released on December 19.

#### Improvements

Optimized the callback for a message sending failure to make sure that it is triggered immediately when the network is disconnected.

#### Issues fixed

The `file_length` parameter in the `create` method did not work when this method was called to create an attachment message.

## v1.0.7

v1.0.7 was released on November 22, 2022. 

#### Improvements

- Split the SDK into several modules.
- Added in-line comments.
- Optimized the reconnection logic.

#### Issues fixed

- An issue with compatibility with Internet Explorer. 
- An issue of lacking the longest validity period of token.

## v1.0.6

v1.0.6 was released on August 26, 2022.

#### New Features

- Adds disaster preparedness policies.
- Adds `resourceId` to the group and chat room APIs to deliver event notifications to multiple devices of a user.
- Adds the `needAffiliations` and `needRole` parameters to the `getJoinedGroups` method to return the number of group members and their roles.

#### Improvements

- Optimized communication protocols to reduce the data volume.
- Added inline documents.

#### Issues fixed

Some type definition errors.

## v1.0.5

v1.0.5 was released on Jul 22, 2022.

#### New features

- Adds the `onGroupEvent` and `onChatroomEvent` callback events.
- Adds the error code `MESSAGE_CURRENT_LIMITING`, which means that the chat group message has exceeded the concurrent limit.

#### Improvements

- Supported retrieving the information of multiple chat groups using `getGroupInfo`.

## v1.0.3

v1.0.3 was released on May 16, 2022.

#### New Features

- Supports reaction, which enables users to add reaction emojis to the specified message.
- Supports content moderation with the reportMessage method.
- Supports message push configuration, which enables users to configure various push settings.
- Supports data report.

#### Improvements

- Supports retrieving chat groups by pagination.
- Supports setting the number of chat group members when creating a chat group.
- Adds thumbnail URL to the received image messages.

#### Issues fixed

When the user switched the user ID, cache remains in the group message.

## v1.0.2

v1.0.2 was released on April 19, 2022.

#### New features

- Supports the presence feature, which indicates the online status of the user.
- Supports translation. You can implement translation on the recipient's client, or auto-translation on the sender's client.

#### Improvements

- The Uni_SDK cannot run on the browser.
- The user cannot modify the group description when creating a chat group.
- The compatibility of SSR.

## v1.0.1.1

v1.0.1.1 was released on January 19, 2022.

**New features**

This release adds the following features:

- Supports downloading group shared files using the `downloadGroupSharedFile` method.
- Supports retrieving group shared files by pagination using the `fecthGroupSharedFileList` method.

## v1.0.1

v1.0.1 was released on January 14, 2022.

**New features**

This release supports deleting the conversation thread using the `deleteSession` method.

**Improvements**

The release made the following improvements:

- Added a `buildingNumber` parameter in the location message.
- Added `error: type 221` for sending a message to a user that is not a contact.
- Added `error: type 219` for failing to send a message because all the users are muted.

**Issues fixed**

This release fixe the issue that the `onChanelMessage` callback was not triggered and other known issues.

## v1.0.0

v1.0.0 was released on December 10, 2021.

**Improvements**

This release made the following improvmenets:

- Added some error codes.
- Renamed some functions and updated the API annotations.

**Fixed issues**

This release fixed the following issues:
- The delivery acknowledgement was not received.
- The group announcement could not be set as null.
- An error was reported when muting a specified user during chat.

