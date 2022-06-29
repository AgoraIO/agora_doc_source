# Manage Chat Group Attributes

Chat groups enable real-time messaging among multiple users.

This page shows how to use the Agora Chat SDK to manage the attributes of a chat group in your app.


## Understand the tech

The Agora Chat SDK provides the `IAgoraChatGroupManager`, `AgoraChatGroupManagerDelegate`, and `AgoraChatGroup` classes for chat group management, which allows you to implement the following features:

- Modify the chat group name and description
- Manage chat group announcements
- Manage chat group shared files

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with iOS](./agora_chat_get_started_ios?platform=iOS).
- You understand the call frequency limits of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=iOS).
- You understand the number of chat groups and chat group members supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan?platform=iOS).

## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement chat group features.

### Modify the chat group name and description

The chat group owner and chat group admins can modify the name and description of the chat group.

Refer to the following sample code to modify the chat group name and description:

```objective-c
// The chat group owner and chat group admins can call changeGroupSubject to modify the name of the chat group. The name length can be up to 128 characters.
[[AgoraChatClient sharedClient].groupManager changeGroupSubject:@"subject"
 																											 forGroup:@"groupID" 
 																												  error:nil];

// The chat group owner and chat group admins can call changeDescription to modify the description of the chat group. The description length can be up to 512 characters.
[[AgoraChatClient sharedClient].groupManager changeDescription:@"desc"
 																											forGroup:@"groupID" 
 																										 	   error:nil];
```


### Manage chat group announcements

The chat group owner and chat group admins can set and update chat group announcements. Once the announcements are updated, all chat group members receive the `groupAnnouncementDidUpdate` callback. All chat group members can retrieve chat group announcements.

Refer to the following sample code to manage chat group announcements:

```objective-c
// The chat group owner and chat group admins can call updateGroupAnnouncementWithId to set or update the chat group announcements. The announcement length can be up to 512 characters.
[[AgoraChatClient sharedClient].groupManager updateGroupAnnouncementWithId:@"groupID"
 																														 announcement:@"announcement" 
 																										 	   					  error:nil];

// All chat group members can call getGroupAnnouncementWithId to retrieve the chat group announcements.
[[AgoraChatClient sharedClient].groupManager getGroupAnnouncementWithId:@"groupID" 
 																																  error:nil];
```


### Manage chat group shared files

All chat group members can upload or download group shared files. The chat group owner and chat group admins can delete all of the group shared files, whereas group members can only delete the shared files that they have personally uploaded.

Refer to the following sample code to manage chat group shared files:

```objective-c
// All chat group members can call uploadGroupSharedFileWithId to upload group shared files. The file size can be up to 10 MB.
// Once shared files are uploaded, group members receive the groupFileListDidUpdate callback.
[[AgoraChatClient sharedClient].groupManager uploadGroupSharedFileWithId:@"groupID"
 																																filePath:@"filePath" 
 																															  progress:nil 
 																															completion:nil];

// All chat group members can call removeGroupSharedFileWithId to delete group shared files.
// Once shared files are deleted, chat group members receive the groupFileListDidUpdate callback.
[[AgoraChatClient sharedClient].groupManager removeGroupSharedFileWithId:@"groupID"
 																													  sharedFileId:@"fileID" 
 																															     error:nil];

// All chat group members can call getGroupFileListWithId to retrieve the list of shared files in the chat group.
[[AgoraChatClient sharedClient].groupManager getGroupFileListWithId:@"groupID"
 																												 pageNumber:pageNumber 
 																												   pageSize:pageSize 
 																														  error:nil];
```

### Listen for chat group events

For details, see [Chat Group Events](./agora_chat_group_ios?platform=iOS#listen-for-chat-group-events).