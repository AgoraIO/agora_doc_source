# Manage Chat Group Members

Chat groups enable real-time messaging among multiple users.

This page shows how to use the Agora Chat SDK to manage the members of a chat group in your app.

## Understand the tech

The Agora Chat SDK provides the `Group`, `IGroupManager`, and `IGroupManagerDelegate` classes for chat group management, which allows you to implement the following features:

- Add and remove users from a chat group
- Manage the owner and admins of a chat group
- Manage the block list of a chat group
- Manage the mute list of a chat group
- Mute and unmute all the chat group members
- Manage the allow list of a chat group

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Unity](https://docs-preprod.agora.io/en/agora-chat/agora_chat_get_started_unity).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](https://docs-preprod.agora.io/en/agora-chat/agora_chat_limitation_unity).
- You understand the number of chat groups and chat group members supported by different pricing plans as described in [Pricing Plan Details](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_plan).

## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement chat group features.

### Add a user to a chat group

The logic of adding a user to a chat group varies according to the `GroupStyle` and `inviteNeedConfirm` settings when [creating the chat group]((https://docs-preprod.agora.io/en/null/agora_chat_group_unity?platform=Unity#create-a-chat-group)).

1. Group types (`GroupStyle`):
- No matter a chat group is public or private, the chat group owner and admins can call `IGroupManager#AddGroupMembers` to add users to a chat group;
- For a private group, if `GroupStyle` is set to `PrivateMemberCanInvite`, chat group members can also add users to a chat group.

2. Whether a group invitation requires the consent from an invitee (`inviteNeedConfirm`):
- Yes (`option.InviteNeedConfirm` is set to `true`). After sending a group invitation, the subsequent logic varies based on whether the invitee automatically consents the group invitation (`AutoAcceptGroupInvitation`):
  - Yes (`AutoAcceptGroupInvitation` is set to `true`). The invitee automatically joins the chat group and receives the `IGroupManagerDelegate#OnAutoAcceptInvitationFromGroup` callback, the inviter receives the `IGroupManagerDelegate#OnInvitationAcceptedFromGroup` and `IGroupManagerDelegate#OnMemberJoinedFromGroup` callbacks, and the other chat group members receives the `IGroupManagerDelegate#OnMemberJoinedFromGroup` callback.
  - No (`AutoAcceptGroupInvitation` is set to `false`). The invitee receives the `IGroupManagerDelegate#OnInvitationReceivedFromGroup` callback and choose whether to join the chat group:
    - If the invitee accepts the group invitation, the inviter receives the `IGroupManagerDelegate#OnInvitationAcceptedFromGroup` and `IGroupManagerDelegate#OnMemberJoinedFromGroup` callbacks and the other chat group members receive the `IGroupManagerDelegate#OnMemberJoinedFromGroup` callback;
    - If the invitee declines the group invitation, the inviter receives the `IGroupManagerDelegate#OnInvitationDeclinedFromGroup` callback.

![](https://web-cdn.agora.io/docs-files/1652918263861)

- No (`option.InviteNeedConfirm` is set to `false`). After sending a group invitation, an invitee is added to the chat group regardless of their `IsAutoAcceptGroupInvitation` setting. The invitee receives the `IGroupManagerDelegate#OnAutoAcceptInvitationFromGroup` callback, the inviter receives the `IGroupManagerDelegate#OnInvitationAcceptedFromGroup` and `IGroupManagerDelegate#OnMemberJoinedFromGroup` callbacks, and the other chat group members receive the `IGroupManagerDelegate#OnMemberJoinedFromGroup` callback.

The following code sample shows how to add a user to a chat group:

```c#
SDKClient.Instance.GroupManager.AddGroupMembers(groupId, members, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### Remove a member from a chat group

Only the chat group owner and admins can call `DeleteGroupMembers` to remove the specified member from a chat group. Once removed from the chat group, this member receives the `IGroupManagerDelegate#OnUserRemovedFromGroup` callback, while the other members receive the `IGroupManagerDelegate#OnMemberExitedFromGroup`. After being removed from a chat group, this user can join the chat group again.

The following code sample shows how to remove a member from a chat group:

```c#
SDKClient.Instance.GroupManager.DeleteGroupMembers(groupId, list, new CallBack (
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### Manage the chat group owner and admins

#### Transfer the chat group ownership

Only the chat group owner can call `ChangeGroupOwner` to transfer the ownership to the specified chat group member. Once the ownership is transferred, the original chat group owner becomes a regular member. The other chat group members receive the `IGroupManagerDelegate#OnOwnerChangedFromGroup` callback.

The following code sample shows how to transfer the chat group ownership:

```c#
SDKClient.Instance.GroupManager.ChangeGroupOwner(groupId, newOwner, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### Add a chat group admin

Only the chat group owner can call `AddGroupAdmin` to add an admin. Once promoted to an admin, the new admin and the other chat group admins receive the `IGroupManagerDelegate#OnAdminAddedFromGroup` callback.

The following code sample shows how to add a chat group admin:

```c#
SDKClient.Instance.GroupManager.AddGroupAdmin(groupId, adminId, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));     
```

#### Remove a chat group admin

Only the chat group owner can call `RemoveGroupAdmin` to remove an admin. Once demoted to a regular member, the original admin and the other chat group admins receive the `IGroupManagerDelegate#OnAdminRemovedFromGroup` callback.

The following code sample shows how to remove a chat group admin:

```c#
SDKClient.Instance.GroupManager.RemoveGroupAdmin(groupId, adminId, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### Manage the chat group block list

#### Add a member to the chat group block list

Only the chat group owner and admins can call `BlockGroupMembers` to add the specified member to the chat group block list. Once added to the block list, this member receives the `IGroupManagerDelegate#OnUserRemovedFromGroup` callback, while the other members receive the `IGroupManagerDelegate#OnMemberExitedFromGroup`. After being added to block list, this user cannot send or receive messages in the chat group. They can no longer join the chat group again until being removed from the block list.

The following code sample shows how to add a member to the chat group block list:

```c# 
SDKClient.Instance.GroupManager.BlockGroupMembers(groupId, members, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### Remove a member from the chat group block list

Only the chat group owner and admins can call `UnBlockGroupMembers` to remove the specified member from the chat group block list.

The following code sample shows how to remove a member from the chat group block list:

```c#
SDKClient.Instance.GroupManager.UnBlockGroupMembers(groupId, members, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### Retrieve the chat group block list

Only the chat group owner and admins can call `GetGroupBlockListFromServer` to retrieve the chat group block list.

The following code sample shows how to retrieve the chat group block list:

```c#
SDKClient.Instance.GroupManager.GetGroupBlockListFromServer(groupId, pageNum, pageSize, handle: new ValueCallBack<List<string>>(
  onSuccess: (list) =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### Manage the chat group mute list

#### Add a member to the chat group mute list

Only the chat group owner and admins can call `MuteGroupMembers` to add the specified member to the chat group mute list. Once added to the mute list, this member and all the other chat group admins or owner receive the `IGroupManagerDelegate#OnMuteListAddedFromGroup` callback. Once a chat group member is added to the chat group mute list, this member can no longer send chat group messages, not even after being added to the chat group allow list.

The following code sample shows how to add a member to the chat group mute list:

```c#
SDKClient.Instance.GroupManager.MuteGroupMembers(groupId, members, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### Remove a member from the chat group mute list

Only the chat group owner and admins can call `UnMuteGroupMembers` to remove the specified member from the chat group mute list. Once removed from the chat group mute list, this member and all the other chat group admins or owner receive the `IGroupManagerDelegate#OnMuteListRemovedFromGroup` callback.

The following code sample shows how to remove a member from the chat group mute list:

```c#
SDKClient.Instance.GroupManager.UnMuteGroupMembers(groupId, members, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));    
```

#### Retrieve the chat group mute list

Only the chat group owner and admins can call `GetGroupMuteListFromServer` to retrieve the chat group mute list from the server.

The following code sample shows how to retrieve the chat group mute list:

```c#
SDKClient.Instance.GroupManager.GetGroupMuteListFromServer(groupId, handle: new ValueCallBack<List<string>>(
  onSuccess: (list) => {
  },
  onError: (code, desc) =>
  {
  }
));
```

### Mute and unmute all the chat group members

#### Mute all the chat group members

Only the chat group owner and chat group admins can call `MuteGroupAllMembers` to mute or unmute all the chat group members. Once all the members are muted, only those in the chat group allow list can send messages in the chat group.

The following sample code shows how to mute all the chat group members:

```c#
SDKClient.Instance.GroupManager.MuteGroupAllMembers(groupId, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### Unmute all the chat group members

Only the chat group owner and chat group admins can call `UnMuteGroupAllMembers` to unmute all the chat group members.

The following sample code shows how to unmute all the chat group members:

```c#
SDKClient.Instance.GroupManager.UnMuteGroupAllMembers(groupId, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) =>
  {
  }
));   
```

### Manage the chat group allow list

#### Add a member to the chat group allow list

Only the chat group owner and admins can call `AddGroupWhiteList` to add the specified member to the chat group allow list. Once added to the mute list, this member and all the other chat group admins or owner receive the `IGroupManagerDelegate#OnMuteListAddedFromGroup` callback. Members in the chat group allow list can send chat group messages even when the chat group owner or admin has muted all chat group members. However, if a member is already in the chat group mute list, adding this member to the allow list does not take effect.

The following code sample shows how to add a member to the chat group allow list:

```c#
SDKClient.Instance.GroupManager.AddGroupWhiteList(groupId, members, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) =>
  {
  }
)); 
```

#### Remove a member from the chat group allow list

Only the chat group owner and admins can call `RemoveGroupWhiteList` to remove the specified member from the chat group allow list.

The following code sample shows how to remove a member from the chat group allow list:

```c#
SDKClient.Instance.GroupManager.RemoveGroupWhiteList(groupId, members, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) =>
  {
  }
)); 
```

#### Check whether a user is added to the allow list

All chat group members can call `checkIfInGroupWhiteList` to check whether they are added to the chat group allow list.

```c#
public void checkIfInGroupWhiteList(final String groupId, EMValueCallBack<Boolean> callBack)
SDKClient.Instance.GroupManager.CheckIfInGroupWhiteList(groupId, new ValueCallBack<bool>(
  onSuccess: (ret) => {
  },
  onError: (code, desc)=> {
  }
));
```

#### Retrieve the chat group allow list

Only the chat group owner and admins can call `GetGroupWhiteListFromServer` to retrieve the chat group allow list.

The following code sample shows how to retrieve the chat group allow list:

```c#
SDKClient.Instance.GroupManager.GetGroupWhiteListFromServer(currentGroupId, handle: new ValueCallBack<List<string>>(
  onSuccess: (list) => {
  },
  onError: (code, desc) =>
  {
  }
));
```

### Listen for chat group events

For details, see [Chat Group Events](https://docs-preprod.agora.io/en/null/agora_chat_group_unity?platform=Unity#listen-for-chat-group-events).