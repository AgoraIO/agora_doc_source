# Manage Chat Group Attributes

Chat groups enable real-time messaging among multiple users.

This page shows how to use the Agora Chat SDK to manage the attributes of a chat group in your app.

## Understand the tech

The Agora Chat SDK provides the `Group`, `IGroupManager`, and `IGroupManagerDelegate` classes for chat group management, which allows you to implement the following features:

- Update the name and description of a chat group
- Retrieve and update the announcements of a chat group
- Manage the shared files in a chat group
- Update the extension fields of a chat group

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Windows](./agora_chat_get_started_windows).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](https://docs-preprod.agora.io/en/agora-chat/agora_chat_limitation).
- You understand the number of chat groups and chat group members supported by different pricing plans as described in [Pricing Plan Details](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_plan).

## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement chat group features.

### Update the chat group name

The chat group owner and admins can call `ChangeGroupName` to set and update the chat group name. The maximum length of a chat group name is 128 characters.

The following code sample shows how to update the chat group name:

```c#
SDKClient.Instance.GroupManager.ChangeGroupName(groupId, groupName, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### Update the chat group description

The chat group owner and admins can call `ChangeGroupDescription` to set and update the chat group description. The maximum length of a chat group description is 512 characters.

The following code sample shows how to update the chat group description:

```c#
SDKClient.Instance.GroupManager.ChangeGroupDescription(groupId, description, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### Update the chat group announcements

Only the chat group owner and admins can call `UpdateGroupAnnouncement` to set and update the announcements. Once the chat group announcements are updated, all the other chat group members receive the `IGroupManagerDelegate#OnAnnouncementChangedFromGroup` callback. The maximum total length of chat group announcements is 512 characters.

The following code sample shows how to update the chat group announcements:

```c#
SDKClient.Instance.GroupManager.UpdateGroupAnnouncement(groupId, announcement, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
       
```

### Retrieve the chat group announcements

All chat group members can call `GetGroupAnnouncementFromServer` to retrieve the chat group announcements from the server.

The following code sample shows how to retrieve the chat group announcements:

```c#
SDKClient.Instance.GroupManager.GetGroupAnnouncementFromServer(currentGroupId, new ValueCallBack<string>(
  onSuccess: (str) =>
  {
  },
  onError: (code, desc) =>
  {
  }
));    
```

### Manage the chat group shared files

#### Upload chat group shared files

All chat group members can call `UploadGroupSharedFile` to upload shared files to a chat group. The maximum file size is 10 MB. Once a shared file is uploaded, all the other chat group members receive the `IGroupManagerDelegate#OnSharedFileAddedFromGroup` callback.

The following code sample shows how to upload chat group shared files:

```c#
SDKClient.Instance.GroupManager.UploadGroupSharedFile(groupId, filePath, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### Delete chat group shared files

All chat group members can call `DeleteGroupSharedFile` to delete shared files in a chat group. Once a shared file is deleted, all the other chat group members receive the `IGroupManagerDelegate#OnSharedFileAddedFromGroup#OnSharedFileDeletedFromGroup` callback. The chat group owner and chat group admins can delete all of the shared files, whereas chat group members can only delete the shared files that they have personally uploaded.

The following code sample shows how to delete chat group shared files:

```c#
SDKClient.Instance.GroupManager.DeleteGroupSharedFile(groupId, id, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### Retrieve the shared file list

All chat group members can call `GetGroupFileListFromServer` to retrieve the list of shared files in a chat group from the server.

The following code sample shows how to retrieve the list of shared files in a chat group:

```c#
SDKClient.Instance.GroupManager.GetGroupFileListFromServer(groupId, pageNum, pageSize, handle: new ValueCallBack<List<GroupSharedFile>> (
  onSuccess: (fileList) =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### Update the chat group extension fields

Only the chat group owner and admins can call `UpdateGroupExt` to update the extension fields of a chat group. The extension fields enable users to perform customized operations on a chat group. The maximum length of each extension field is 8 KB, and it must be in the JSON format.

The following code sample shows how to update the chat group extension fields:

```c#
SDKClient.Instance.GroupManager.UpdateGroupExt(currentGroupId, extension, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### Listen for chat group events

For details, see [Chat Group Events](./agora_chat_group_windows#listen-for-chat-group-events).