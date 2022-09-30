# Manage Chat Group Attributes

Chat groups enable real-time messaging among multiple users.

This page shows how to use the Agora Chat SDK to manage the attributes of a chat group in your app.


## Understand the tech

The Agora Chat SDK provides the `ChatGroup`, `ChatGroupManager`, and `ChatGroupEventHandler` classes for chat group management, which allows you to implement the following features:

- Update the name and description of a chat group
- Retrieve and update the announcements of a chat group
- Manage the shared files in a chat group
- Update the extension fields of a chat group


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Flutter](./agora_chat_get_started_flutter).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation).
- You understand the number of chat groups and chat group members supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan).


## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement chat group features.

### Update the chat group name

The chat group owner and admins can call `changeGroupName` to set and update the chat group name. The maximum length of a chat group name is 128 characters.

The following code sample shows how to update the chat group name:

```dart
try {
  await ChatClient.getInstance.groupManager.changeGroupName(
    groupId,
    newName,
  );
} on ChatError catch (e) {
}
```

### Update the chat group description

The chat group owner and admins can call `changeGroupDescription` to set and update the chat group description. The maximum length of a chat group description is 512 characters.

The following code sample shows how to update the chat group description:

```dart
try {
  await ChatClient.getInstance.groupManager.changeGroupDescription(
    groupId,
    newDesc,
  );
} on ChatError catch (e) {
}
```

### Update the chat group announcements

Only the chat group owner and admins can call `updateGroupAnnouncement` to set and update the announcements. Once the chat group announcements are updated, all the other chat group members receive the `ChatGroupEventHandler#onAnnouncementChangedFromGroup` callback. The maximum total length of chat group announcements is 512 characters.

The following code sample shows how to update the chat group announcements:

```dart
try {
  await ChatClient.getInstance.groupManager.updateGroupAnnouncement(
    groupId,
    newAnnouncement,
  );
} on ChatError catch (e) {
}
```

### Retrieve the chat group announcements

All chat group members can call `fetchAnnouncementFromServer` to retrieve the chat group announcements from the server.

The following code sample shows how to retrieve the chat group announcements:

```dart
try {
  String? announcement =
      await ChatClient.getInstance.groupManager.fetchAnnouncementFromServer(
    groupId,
  );
} on ChatError catch (e) {
}
```

### Manage the chat group shared files

#### Upload chat group shared files

All chat group members can call `uploadGroupSharedFile` to upload shared files to a chat group. The maximum file size is 10 MB. Once a shared file is uploaded, all the other chat group members receive the `ChatGroupEventHandler#onSharedFileAddedFromGroup` callback.

The following code sample shows how to upload chat group shared files:

```dart
try {
  await ChatClient.getInstance.groupManager.uploadGroupSharedFile(
    groupId,
    filePath,
  );
} on ChatError catch (e) {
}
```

#### Delete chat group shared files

All chat group members can call `removeGroupSharedFile` to delete shared files in a chat group. Once a shared file is deleted, all the other chat group members receive the `ChatGroupEventHandler#onSharedFileDeletedFromGroup` callback. The chat group owner and chat group admins can delete all of the shared files, whereas chat group members can only delete the shared files that they have personally uploaded.

The following code sample shows how to delete chat group shared files:

```dart
try {
  await ChatClient.getInstance.groupManager.removeGroupSharedFile(
    groupId,
    fileId,
  );
} on ChatError catch (e) {
}
```

#### Retrieve the shared file list

All chat group members can call `fetchGroupFileListFromServer` to retrieve the list of shared files in a chat group from the server.

The following code sample shows how to retrieve the list of shared files in a chat group:

```dart
try {
  List<ChatGroupSharedFile> list =
      await ChatClient.getInstance.groupManager.fetchGroupFileListFromServer(
    groupId,
    pageNum: pageNum,
    pageSize: pageSize,
  );
} on ChatError catch (e) {
}
```

### Update the chat group extension fields

Only the chat group owner and admins can call `updateGroupExtension` to update the extension fields of a chat group. The extension fields enable users to perform customized operations on a chat group. The maximum length of each extension field is 8 KB, and it must be in the JSON format.

The following code sample shows how to update the chat group extension fields:

```dart
try {
  await ChatClient.getInstance.groupManager.updateGroupExtension(
    groupId,
    extension,
  );
} on ChatError catch (e) {
}
```

### Listen for chat group events

For details, see [Chat Group Events](./agora_chat_group_flutter#listen-for-chat-group-events).