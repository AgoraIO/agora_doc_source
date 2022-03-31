# Implement the Chat Group Workflow

Chat groups enable real-time messaging among multiple users.

This page describes how to use the Agora Chat SDK to create and manage a chat group in your app.


## Understand the tech

The Agora Chat SDK provides a `GroupManager` and a `Group` class for chat group management, which allows you to implement the following features:
- Create and destroy a chat group
- Join and leave a chat group
- Retrieve the member list of a chat group
- Mute and unmute a chat group
- Manage chat group members
- Manage the attributes, announcements, and shared files of a chat group


## Prerequisites

Before proceeding, ensure that you meet the following requirements:
- You have initialized the Agora Chat SDK. For details, see [Get Started with Android](agora_chat_get_started_android).
- You understand the call frequency of the Agora Chat APIs supported by different pricing plans as described in [Limitations](agora_caht_limitation).
- You understand the number of chat groups and chat group members supported by different pricing plans as described in [Pricing Plan Details](agora_chat_plan).


## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement the features listed above.

### Create and destroy a chat group

You can create a chat group and set the chat group attributes such as the name, description, group members, and reasons to create the group. You can also set the `GroupOptions` parameter to specify the size and type of the chat group. Once a chat group is created, the creator of the chat group becomes the chat group owner automatically.

Only chat group owners can disband chat groups. Once a chat group is disbanded, all the chat group members receive the `onGroupDestroyed` callback and are immediately removed from the chat group. All the local data of the chat group are also removed from the database and memory.

Refer to the following sample code to create and destroy a chat group:

```java
GroupOptions option = new GroupOptions();
// Set the size of a chat group to 100 members.
option.maxUsers = 100;
// Set the type of a chat group to private. Allow chat group members to invite other users to join the chat group.
option.style = GroupStyle.GroupStylePrivateMemberCanInvite;

// Call createGroup to create a chat group.
ChatClient.getInstance().groupManager().createGroup(groupName, desc, allMembers, reason, option);


// Call destroyGroup to disband a chat group.
ChatClient.getInstance().groupManager().destroyGroup(groupId);
```


### Join and leave a chat group

You can request to join a public chat group as follows:

1. Call `getJoinedGroupsFromServer` to retrieve the list of the groups that you are already in. This prevents repetitive join requests.
2. Call `getPublicGroupsFromServer` to retrieve the list of public groups by page. You can obtain the ID of the group that you want to join.
3. Call `joinGroup` to send a join request to the chat group:
    - If the type of the chat group is set to `GroupStylePublicJoin`, your request is accepted automatically and the chat group memebers receive the `onMemberJoined` callback.
    - If the type of the chat group is set to `GroupStylePublicNeedApproval`, the chat group owner and chat group admins receive the `onRequestToJoinReceived` callback and determine whether to accept your request.

You can call `leaveGroup` to leave a chat group. Once you leave the group, all the other group members receive the `onMemberExited` callback.

Refer to the following sample code to join and leave a chat group:

```java
// Call getJoinedGroups to retrieve the list of joined groups.
List<Group> grouplist = ChatClient.getInstance().groupManager().getJoinedGroupsFromServer();

// Call getAllGroups to retrieve the list of all groups.
List<Group> grouplist = ChatClient.getInstance().groupManager().getAllGroups();

// List public groups by page.
CursorResult<GroupInfo> result = ChatClient.getInstance().groupManager().getPublicGroupsFromServer(pageSize, cursor);
List<GroupInfo> groupsList = List<GroupInfo> returnGroups = result.getData();
String cursor = result.getCursor();

// Call joinGroup to send a join request to a chat group.
ChatClient.getInstance().groupManager().joinGroup(groupId);

// Call leaveGroup to leave a chat group.
ChatClient.getInstance().groupManager().leaveGroup(groupId);
```


### Retrieve the member list of a chat group

To retrieve the member list of a chat group, choose the method based on the group size:

- If the members of a chat group are greater than or equal to 200, list members of the chat group by page.
- If the members of a chat group are less than 200, call `getGroupFromServer` to retrieve the member list of the chat group.

Refer to the following sample code to retrieve the member list of a chat group:

```java
// List members of a chat group by page.
List<String> memberList = new ArrayList<>;
CursorResult<String> result = null;
final int pageSize = 20;
do {
     result = ChatClient.getInstance().groupManager().fetchGroupMembers(groupId,
             result != null? result.getCursor(): "", pageSize);
     memberList.addAll(result.getData());
} while (!TextUtils.isnull(result.getCursor()) && result.getData().size() == pageSize);

// Call getGroupFromServer to retrieve the member list of a chat group.
Group group = ChatClient.getInstance().groupManager().getGroupFromServer(groupId, true);
List<String> memberList = group.getMembers();
```


### Mute and unmute a chat group

Group members can mute and unmute a chat group, whereas the chat group owner and chat group admins cannot perform such operations. Once you mute a chat group, you won't receive notifications from this chat group.

Refer to the following sample code to mute and unmute a chat group:

```java
// Call blockGroupMessage to mute a chat group.
ChatClient.getInstance().groupManager().blockGroupMessage(groupId);

// Call unblockGroupMessage to unmute a chat group.
ChatClient.getInstance().groupManager().unblockGroupMessage(groupId);
```


### Manage chat group members

1. Add users to a chat group.  
Whether a chat group is public or private, the chat group owner and chat group admins can add users to the chat group. As for private groups, if the type of a chat group is set to `GroupStylePrivateMemberCanInvite`, group members can invite users to join the chat group.

2. Implement chat group invitations.   
After a user is invited to join a chat group, the implementation logic varies based on the settings of the user:

    - If the user requires a group invitation confirmation, the invitor receives the `onInvitationReceived` callback. Once the user accepts the request and joins the group, the invitor receives the `onInvitationAccepted` callback and all the group members receive the `onMemberJoined` callback. Otherwise, the invitor receives the `onInvitationDeclined` callback.

    - If the user doesn't require a group invitation confirmation, the invitor receives the `onAutoAcceptInvitationFromGroup` callback. In this case, the user automatically accepts the group invitation and receives the `onInvitationAccepted` callback. All the group members receive the `onMemberJoined` callback.

3. Remove chat group members from a chat group.  
The chat group owner and chat group admins can remove chat group members from a chat group, whereas chat group members do not have this privilege. Once a group member is removed, all the other group members receive the `onMemberExited` callback.

Refer to the following sample code to add and remove a user:

```java
// The chat group owner and chat group admins can call addUsersToGroup to add users to a chat group.
ChatClient.getInstance().groupManager().addUsersToGroup(groupId, newmembers);

// Chat group members can call inviteUser to invite users to a chat group.
ChatClient.getInstance().groupManager().inviteUser(groupId, newmembers, null);

// The chat group owner and chat group admins can call removeUsersToGroup to remove group members from a chat group.
ChatClient.getInstance().groupManager().removeUserFromGroup(groupId, username);
```


### Manage chat group ownership and admin

1. Transfer the chat group ownership.  
The chat group owner can transfer the ownership to the specified chat group member. Once the ownership is transferred, the original chat group owner becomes a group member. All the other chat group members receive the `onOwnerChanged` callback.

2. Add chat group admins.  
The chat group owner can add admins. Once added to the chat group admin list, the newly added admin and the other chat group admins receive the `onAdminAdded` callback.

3. Remove chat group admins.  
The chat group owner can remove admins. Once removed from the chat group admin list, the removed admin and the other chat group admins receive the `onAdminRemoved` callback.

Refer to the following sample code the manage chat group ownership and admin:

```java
// The chat group owner can call changeOwner to transfer the ownership to the specified chat group member.
ChatClient.getInstance().groupManager().changeOwner(groupId, newOwner);

// The chat group owner can call `addGroupAdmin` to add admins.
ChatClient.getInstance().groupManager().addGroupAdmin(groupId, admin);

// The chat group owner can call `removeGroupAdmin` to remove admins.
ChatClient.getInstance().groupManager().removeGroupAdmin(groupId, admin);
```


### Manage the chat group block list

The chat group owner and chat group admins can add the specified member to the chat group block list and remove them from it. Once a chat group member is added to the block list, this member cannot send or receive chat group messages, nor can this member join the chat group again.

Refer to the following sample code to manage the chat group block list:

```java
// The chat group owner and admins can call blockUser to add the specified member to the chat group block list.
ChatClient.getInstance().groupManager().blockUser(groupId, username);

// The chat group owner and admins can call unblockUser to remove the specified member from the chat group block list.
ChatClient.getInstance().groupManager().unblockUser(groupId, username);

// The chat group owner and admins can call getBlockedUsers to retrieve the chat group block list.
ChatClient.getInstance().groupManager().getBlockedUsers(groupId);
```


### Manage the chat group mute list

The chat group owner and chat group admins can add the specified member to the chat group mute list and remove them from it. Once a chat group member is added to the mute list, this member can no longer send chat group messages, not even after being added to the chat group allow list.

Refer to the following sample code to manage the chat group mute list:

```java
// The chat group owner and admins can call muteGroupMember to add the specified member to the chat group mute list. The muted member and all the other chat group admins or owner receive the onMuteListAdded callback. 
ChatClient.getInstance().groupManager().muteGroupMembers(groupId, muteMembers, duration);

// The chat group owner and admins can call unmuteGroupMember to remove the specified user from the chat group mute list. The unmuted member and all the other chat group admins or owner recieve the onMuteListRemoved callback.
ChatClient.getInstance().groupManager().unMuteGroupMembers(String groupId, List<String> members);

// The chat group owner or admin can call fetchGroupMuteList to retrieve the chat group mute list.
ChatClient.getInstance().groupManager().fetchGroupMuteList(String groupId, int pageNum, int pageSize);
```


### Mute and unmute all the chat group members

The chat group owner and chat group admins can mute or unmute all the chat group members. Once all the members are muted, only those in the chat group allow list can send messages in the chat group.

Refer to the following sample code to mute and unmute all the chat group members:

```java
// The chat group owner or admin can call muteAllMembers to mute all the chat group members. Once all the members are muted, these members receive the onAllMemberMuteStateChanged callback.
public void muteAllMembers(final String groupId, final ValueCallBack<Group> callBack);

// The chat group owner or admin can call unmuteAllMembers to unmute all the chat group members. Once all the members are unmuted, these members receive the onAllMemberMuteStateChanged callback.
public void unmuteAllMembers(final String groupId, final ValueCallBack<Group> callBack);
```


### Manage the chat group allow list

Members in the chat group allow list can send chat group messages even when the chat group owner or admin has muted all the chat group members. However, if a member is already in the chat group mute list, adding this member to the allow list does not take effect.

Refer to the following sample code to manage the chat group allow list:

```java
// The chat group owner or admin can call addToChatGroupWhiteList to add the specified member to the chat group allow list. Once the member is added, all the other chat group admins or owner receive the onWhiteListAdded callback.
public void addToGroupWhiteList(final String groupId, final List<String> members, final CallBack callBack);

// The chat group owner or admin can call removeFromChatGroupWhiteList to remove the specifeid member from the chat group list. Once the member is removed, all the other chat group admins or owner receive the onWhiteListRemoved callback.
public void removeFromGroupWhiteList(final String groupId, final List<String> members, final CallBack callBack);

// Chat group members can call checkIfInChatGroupWhiteList to check whether they are in the chat group allow list.
public void checkIfInGroupWhiteList(final String groupId, ValueCallBack<Boolean> callBack);

// The chat group owner or admin can call fetchChatGroupWhiteList to retrieve the chat group allow list.
public void fetchGroupWhiteList(final String groupId, final ValueCallBack<List<String>> callBack);
```


### Modify the chat group name and description

The chat group owner and chat group admins can modify the name and description of the chat group.

Refer to the following sample code to modify the chat group name and description: 

```java
// The chat group owner and chat group admins can call changeGroupName to modify the name of the chat group. Thd name length can be up to 128 characters.
ChatClient.getInstance().groupManager().changeGroupName(groupId,changedGroupName);

// The chat group owner and chat group admins can call changeGroupDescription to modify the description of the caht group. The description length can be up to 512 characters. 
ChatClient.getInstance().groupManager().changeGroupDescription(groupId,description);
```


### Manage chat group announcements

The chat group owner and chat group admins can set and update the announcements. Once the announcements are updated, all the chat group members receive the onAnnouncementChanged callback. All the chat group members can retrieve the chat group announcements.

Refer to the following sample code to manage chat group announcements:

```java
// The chat group owner and chat group admins can call updateGroupAnnouncement to set or update the chat group announcements. The announcement length can be up to 512 characters.
ChatClient.getInstance().groupManager().updateGroupAnnouncement(groupId, announcement);

// All the chat group members can call fetchGroupAnnouncement to retrieve the chat group announcements.
ChatClient.getInstance().groupManager().fetchGroupAnnouncement(groupId);
```


### Manage chat group shared files

All the chat group members can upload or download group shared files. The chat group owner and chat group admins can delete all the group shared files, whereas group members can only delete the shared files that they have personally uploaded.

Refer to the following sample code to manage chat group shared files:

```java
// All the chat group members can call uploadGroupSharedFile to upload group shared files. The file size can be up to 10 MB.
// Once shared files are uploaded, group members receive the onSharedFileAdded callback.
ChatClient.getInstance().groupManager().uploadGroupSharedFile(groupId, filePath, callBack);

// All the chat group members can call deleteGroupSharedFile to delete group shared files.
// Once shared files are deleted, chat group members receive the onSharedFileDeleted callback.
ChatClient.getInstance().groupManager().deleteGroupSharedFile(groupId, fileId);

// All the chat group memebers can call fetchGroupSharedFileList to retrieve the list of the shared files in the chat group.
ChatClient.getInstance().groupManager().fetchGroupSharedFileList(groupId, pageNum, pageSize);
```


### Listen for chat group events

To monitor the chat group events, you can listen for the callbacks in the `GroupManager` class and add app logics accordingly. If you want to stop listening for the callbacks, make sure that you remove the listener to prevent memory leakage.

Refer to the following sample code to listen for chat group events:

```java
GroupChangeListener groupListener = new GroupChangeListener() { 
    // Occurs when an invitee receives a group invitation.
    @Override
    public void onInvitationReceived(String groupId, String groupName, String inviter, String reason) {
        
    }

    // Occurs when a user sends a join request to a chat group.
    @Override
    public void onRequestToJoinReceived(String groupId, String groupName, String applyer, String reason) {
        
    }

    // Occurs when the chat group owner or admin approves a join request.
    @Override
    public void onRequestToJoinAccepted(String groupId, String groupName, String accepter) {
        
    }

    // Occurs when the chat group owner or admin rejects a join request.
    @Override
    public void onRequestToJoinDeclined(String groupId, String groupName, String decliner, String reason) {
        
    }

    // Occurs when an invitee accepts a group invitation.
    @Override
    public void onInvitationAccepted(String groupId, String inviter, String reason) {
        
    }

    // Occurs when an invitee declines a group invitation.
    @Override
    public void onInvitationDeclined(String groupId, String invitee, String reason) {
        
    }

    // Occurs when a member is removed from a chat group.
    @Override
    public void onUserRemoved(String groupId, String groupName) {
        
    }

    // Occurs when the chat group owner disbands a chat group.
    @Override
    public void onGroupDestroyed(String groupId, String groupName) {

    }

    // Occurs when an invitee accepts a group invitation automatically.   
    @Override
    public void onAutoAcceptInvitationFromGroup(String groupId, String inviter, String inviteMessage) {
        
    }

    // Occurs when a member is added to the chat group mute list.
    @Override
    public void onMuteListAdded(String groupId, final List<String> mutes, final long muteExpire) {
        
    }

    // Occurs when a member is removed from the chat group mute list.
    @Override
    public void onMuteListRemoved(String groupId, final List<String> mutes) {
        
    }

    // Occurs when a member is added to the chat group allow list.
    @Override
    public void onWhiteListAdded(String groupId, List<String> whitelist) {
          
    }

    // Occurs when a member is removed from the chat group allow list.
    @Override
    public void onWhiteListRemoved(String groupId, List<String> whitelist) {
         
    }

    // Occurs when all the chat group members are muted or unmuted.
    @Override
    public void onAllMemberMuteStateChanged(String groupId, boolean isMuted) {
          
    }

    // Occurs when a member is added to the chat group admin list.
    @Override
    public void onAdminAdded(String groupId, String administrator) {
        
    }

    // Occurs when an admin is removed from the chat group admin list.
    @Override
    public void onAdminRemoved(String groupId, String administrator) {
        
    }

    // Occurs when the chat group owner is changed.
    @Override
    public void onOwnerChanged(String groupId, String newOwner, String oldOwner) {
        
    }

    // Occurs when a user joins a chat group.
    @Override
    public void onMemberJoined(final String groupId, final String member){
        
    }

    // Occurs when a member leaves a chat group.
    @Override
    public void onMemberExited(final String groupId, final String member) {
        
    }

    // Occurs when a member updates the chat group announcement.
    @Override
    public void onAnnouncementChanged(String groupId, String announcement) {
        
    }

    // Occurs when a member uploads a chat group shared file.
    @Override
    public void onSharedFileAdded(String groupId, MucSharedFile sharedFile) {
        
    }

    // Occurs when a member deletes a chat group shared file.
    @Override
    public void onSharedFileDeleted(String groupId, String fileId) {
        
    }
};

// Set the group listener.
ChatClient.getInstance().groupManager().addGroupChangeListener(groupListener);

// Remove the group listener if not use.
ChatClient.getInstance().groupManager().removeGroupChangeListener(groupListener);
```
