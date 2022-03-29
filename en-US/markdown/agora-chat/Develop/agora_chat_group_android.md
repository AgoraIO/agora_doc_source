# Implement the Chat Group Workflow

Chat groups enable real-time messaging among multiple users.

This page describes how to use the Agora Chat SDK to create and manage a chat group in your app.


## Understand the tech

The Agora Chat SDK provides a `GroupManager` and a `Group` class for chat group management, which allows you to implement the following features:
- Create and destroy a chat group
- Join and leave a chat group
- Retrieve group member list and joined group list
- Mute and unmute chat group notifications
- Manage chat group members
- Manage the attributes, announcements, and shared files of a chat group


## Prerequisites

Before proceeding, ensure that you meet the following requirements:
- You have initialized the Agora Chat SDK. For details, see [Get Started with Android](agora_chat_get_started_android).
- You understand the call frequency of the Agora Chat APIs supported by different pricing plans as described in [Limitations](agora_caht_limitation_android).
- You understand the number of chat groups and chat group members supported by different pricing plans as described in [Pricing Plan Details](agora_chat_plan).


## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement the feature listed above.

### Create and destroy a chat group

1. Create a chat group   
A user can call `createGroup` to create a chat group. The user can specify the group name, group description, group members, and the reason to create the group. The user can also specify the group size and group style through `GroupOptions`. Once the chat group is created, the user who call the method becomes the chat group owner automatically.

2. Destroy the caht group  
Only the chat group owner can call `destroyGroup` to destroy the chat group. Once the chat group is destroyed, all the chat group members receive the `onGroupDestroyed` callback and are immediately removed from the group chat. All the group-related data are also removed from the database and memory.

Refer to the following sample code to create and destroy a chat group:

```java
// Call createGroup to create a chat group.
ChatClient.getInstance().groupManager().createGroup(groupName, desc, allMembers, reason, option);

GroupOptions option = new GroupOptions();
// Set the group size to 100 members.
option.maxUsers = 100;
// Set the group style to private. Chat group members can invite other users to join the group.
option.style = GroupStyle.GroupStylePrivateMemberCanInvite;

// Call destroyGroup to destroy the chat group.
ChatClient.getInstance().groupManager().destroyGroup(groupId);
```


### Join and leave a chat group

If the style of a group is set to public, you can request to join the group as follows:

1. Call `getJoinedGroupsFromServer` to retrieve the list of the groups that you have joined and created. This prevents repetitive join requests.
2. Call `getAllGroups` to retrieve the list of the groups. You can find the ID of the group that you want to join.
3. Call `joinGroup` to request to join the group:
    - If the group style is set to `GroupStylePublicJoin`, your request is accepted automatically and all the group memebers receive the `onMemberJoined` callback.
    - If the group style is set to `GroupStylePublicNeedApproval`, the chat group owner and chat group admins receive the `onRequestToJoinReceived` callback and determine whether to accept your request.

To leave the chat group, you can call `leaveGroup`. Once you leave the group, the other group members receive the `onMemberExited` callback.

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

// Call joinGroup to request to join the chat group.
ChatClient.getInstance().groupManager().joinGroup(groupId);

// Call leaveGroup to leave the chat group.
ChatClient.getInstance().groupManager().leaveGroup(groupId);
```


### Retrieve the member list of a chat group

To retrieve the member list of a chat group, choose the method based on the group size.

Refer to the following sample code to retrieve the member list of a chat group:

```java
// Retrieve the member list of the chat group by page when the group members are greather than or equal to 200.
List<String> memberList = new ArrayList<>;
CursorResult<String> result = null;
final int pageSize = 20;
do {
     result = ChatClient.getInstance().groupManager().fetchGroupMembers(groupId,
             result != null? result.getCursor(): "", pageSize);
     memberList.addAll(result.getData());
} while (!TextUtils.isnull(result.getCursor()) && result.getData().size() == pageSize);

// Call getGroupFromServer when the group members are less than 200.
Group group = ChatClient.getInstance().groupManager().getGroupFromServer(groupId, true);
List<String> memberList = group.getMembers();
```


### Mute and unmute a chat group

Group members can mute and unmute a chat group, whereas the group owner and group admins cannot perform this operation. Once you mute a chat group, you won't receive notifications from the chat group.

```java
// Call blockGroupMessage to mute a chat group.
ChatClient.getInstance().groupManager().blockGroupMessage(groupId);

// Call unblockGroupMessage to unmute the chat group.
ChatClient.getInstance().groupManager().unblockGroupMessage(groupId);
```

### Manage chat group members

1. Add a user to a chat group.  
Whether a chat group is public or private, the group owner and group admins can call `addUsersToGroup` to add a user to the chat group. As for private groups, if the group style is set to `GroupStylePrivateMemberCanInvite`, group members can call `inviteUser` to invite a user to the chat group as well.

2. Accept the chat group invitation.  
After the group invitation is sent to the user, the implementation logic varies based on the settings of the user:

    - If the user requires a group invitation request, the invitor receives the `onInvitationReceived` callback. Once the user accepts the request and joins the group, the invitor receives the `onInvitationAccepted` callback and all the group members receive the `onMemberJoined` callback. Otherwise, the invitor receives the `onInvitationDeclined` callback.

    - If the user doesn't require a group invitation request, the invitor receives the `onAutoAcceptInvitationFromGroup` callback. In this case, the user automatically accepts the group invitation and receives the `onInvitationAccepted` callback, and all the group members receive the `onMemberJoined` callback.

3. Remove the user from the chat group.  
The chat group owner and admins can call `onUserRemoved` to remove the user from the chat group. Once the user is removed, all the other group members receive the `onMemberExited` callback. Only the chat group owner and admins can remove users, whereas chat group members cannot perform this operation.

Refer to the following sample code to add and remove a user:

```java
// The chat group owner and admins call addUsersToGroup to add a user to a chat group.
ChatClient.getInstance().groupManager().addUsersToGroup(groupId, newmembers);

// Chat roup members call inviteUser to invite a user to a chat group.
ChatClient.getInstance().groupManager().inviteUser(groupId, newmembers, null);

// The chat group owner and admins call removeUsersToGroup to remove the user from the chat group.
ChatClient.getInstance().groupManager().removeUserFromGroup(groupId, username);
```


### Manage chat group ownership and admin

1. Transfer the chat group ownership  
The chat group owner can call `changeOwner` to transfer the ownership to the specified chat group member. Once the ownership is transferred, the original chat group owner becomes a regular member. The other group members receive the `onOwnerChanged` callback.

2. Add a chat group admin  
The chat group owner can call `addGroupAdmin` to add admins. Once added to the chat group admin list, the newly added admin and the other chat group admins receive the `onAdminAdded` callback.

3. Remove the chat group admin  
The chat group owner can call `removeGroupAdmin` to remove admins. Once removed from the chat group admin list, the removed admin and the other chat group admins receive the `onAdminRemoved` callback.

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

The chat group owner and admin can add the specified member to the chat group block list and remove them from it. Once a chat group member is added to the block list, this member cannot send or receive chat group messages, nor can this member join the chat room again.

Refer to the following sample code to manage the chat group block list:

```java
// The chat group owner or admin call blockChatroomMembers to add the specified member to the chat group block list.
ChatClient.getInstance().groupManager().blockUser(groupId, username);

// The chat group owner or admin call blockChatroomMembers to remove the specified member from the chat group block list.
ChatClient.getInstance().groupManager().unblockUser(groupId, username);

// The chat group owner or admin call getBlockedUsers to retrieve the block list of the chat group.
ChatClient.getInstance().groupManager().getBlockedUsers(groupId);
```


### Manage the chat group mute list

The chat group owner and admin can add the specified member to the chat group mute list and remove them from it. Once a chat group member is added to the mute list, this member can no longer send chat group message, not even after being added to the chat group allow list.

Refer to the following sample code to manage the chat group mute list:

```java
// The chat group owner or admin can call muteGroupMember to add the specified member to the chat group mute list. The muted member and all the other chat group admins or owner receive the onMuteListAdded callback. 
ChatClient.getInstance().groupManager().muteGroupMembers(groupId, muteMembers, duration);

// The chat group owner or admin can call unmuteChatRoomMember to remove the specified user from the chat group mute list. The unmuted member and all the other chat group admins or owner recieve the onMuteListRemoved callback.
ChatClient.getInstance().groupManager().unMuteGroupMembers(String groupId, List<String> members);

// The chat group owner or admin can call fetchGroupMuteList to fetch the mute list of the chat group.
ChatClient.getInstance().groupManager().fetchGroupMuteList(String groupId, int pageNum, int pageSize);
```


### Mute and unmute all the chat group members

The chat group owner or admin can mute or unmute all the chat group members. Once all the members are muted, only those in the chat group allow list can send messages in the chat group.

Refer to the following sample code to mute and unmute all the chat group members:

```java
// The chat group owner or admin can call muteAllMembers to mute all the chat group members. Once all the members are muted, these members receive the onAllMemberMuteStateChanged callback.
public void muteAllMembers(final String groupId, final ValueCallBack<Group> callBack);

// The chat group owner or admin can call unmuteAllMembers to unmute all the chat group members. Once all the members are unmuted, these members receive the onAllMemberMuteStateChanged callback.
public void unmuteAllMembers(final String groupId, final ValueCallBack<Group> callBack);
```


### Manage the chat group allow list

Members in the chat group allow list can send chat group messages even when the chat room owner or admin has muted all the chat group members. However, if a member is already in the chat group mute list, adding this member to the allow list does not take effect.

Refer to the following sample code to manage the chat group allow list:

```java
// The chat group owner or admin can call addToChatGroupWhiteList to add the specified member to the chat group allow list. Once the member is added, all the other chat group admins or owner receive the onWhiteListAdded callback.
public void addToGroupWhiteList(final String groupId, final List<String> members, final CallBack callBack);

// The chat group owner or admin can call removeFromChatRoomWhiteList to remove the specifeid member from the chat room group list. Once the member is removed, all the other chat group admins or owner receive the onWhiteListRemoved callback.
public void removeFromGroupWhiteList(final String groupId, final List<String> members, final CallBack callBack);

// Chat group members can call checkIfInChatGroupWhiteList to check whether they are in the chat group allow list.
public void checkIfInGroupWhiteList(final String groupId, ValueCallBack<Boolean> callBack);

// The chat group owner or admin can call fetchChatGroupWhiteList to retrive the allow list of the chat group.
public void fetchGroupWhiteList(final String groupId, final ValueCallBack<List<String>> callBack);
```


### Modify the chat group name and description

The chat group owner and admins can modify the name and description of the chat group.

Refer to the following sample code to modify the name and description of the chat group: 

```java
// The chat group owner or admin can call changeGroupName to modify the name of the chat group. Thd name length can be up to 128 characters.
ChatClient.getInstance().groupManager().changeGroupName(groupId,changedGroupName);

// The chat group owner or admin can call changeGroupDescription to modify the description of the caht group. The description length can be up to 512 characters. 
ChatClient.getInstance().groupManager().changeGroupDescription(groupId,description);
```


### Manage chat group announcements

The chat room owner or admin can set and update the announcements. Once the announcements are updated, all the chat group members receive the onAnnouncementChanged callback. All the chat group members can retrieve the chat group announcements.

Refer to the following sample code to manage chat group announcements:

```java
// The chat group owner or admin can call updateGroupAnnouncement to set or update the chat group announcements. The announcement length can be up to 512 characters.
ChatClient.getInstance().groupManager().updateGroupAnnouncement(groupId, announcement);

// Chat group members can call fetchGroupAnnouncement to retrieve the chat group announcements.
ChatClient.getInstance().groupManager().fetchGroupAnnouncement(groupId);
```


### Manage chat group shared files

All the chat group members can upload or download group shared files. Chat group owners and admins can delete all the group shared files, whereas group members can only delete the shared files that they have personally uploaded.

Refer to the following sample code to manage chat group shared files:

```java
// All the chat group members can call uploadGroupSharedFile to upload group shared files. The file size can be up to 10 MB.
// Once shared files are uploaded, group members receive the onSharedFileAdded callback.
ChatClient.getInstance().groupManager().uploadGroupSharedFile(groupId, filePath, callBack);

// All the chat group members can call deleteGroupSharedFile to delete group shared files.
// Once shared files are deleted, group members receive the onSharedFileDeleted callback.
ChatClient.getInstance().groupManager().deleteGroupSharedFile(groupId, fileId);

// All the chat group memebers can call fetchGroupSharedFileList to retieve the list of the shared files in the chat group.
ChatClient.getInstance().groupManager().fetchGroupSharedFileList(groupId, pageNum, pageSize);
```


### Listen for chat group events

To monitor the chat group events, you can listen for the callbacks in the `ChatRoomManager` class and add app logics accordingly. If you want to stop listening for the callbacks, make sure that you remove the listener to prevent memory leakage.

Refer to the following sample code to listen for chat group events:

```java
GroupChangeListener groupListener = new GroupChangeListener() { 
    @Override
    public void onInvitationReceived(String groupId, String groupName, String inviter, String reason) {
        
    }

    @Override
    public void onRequestToJoinReceived(String groupId, String groupName, String applyer, String reason) {
        
    }

    @Override
    public void onRequestToJoinAccepted(String groupId, String groupName, String accepter) {
        
    }

    @Override
    public void onRequestToJoinDeclined(String groupId, String groupName, String decliner, String reason) {
        
    }

    @Override
    public void onInvitationAccepted(String groupId, String inviter, String reason) {
        
    }

    @Override
    public void onInvitationDeclined(String groupId, String invitee, String reason) {
        
    }

    @Override
    public void onUserRemoved(String groupId, String groupName) {
        
    }

    @Override
    public void onGroupDestroyed(String groupId, String groupName) {

    }
    
    @Override
    public void onAutoAcceptInvitationFromGroup(String groupId, String inviter, String inviteMessage) {
        
    }

    @Override
    public void onMuteListAdded(String groupId, final List<String> mutes, final long muteExpire) {
        
    }

    @Override
    public void onMuteListRemoved(String groupId, final List<String> mutes) {
        
    }
    
    @Override
    public void onWhiteListAdded(String groupId, List<String> whitelist) {
          
    }

    @Override
    public void onWhiteListRemoved(String groupId, List<String> whitelist) {
         
    }

    @Override
    public void onAllMemberMuteStateChanged(String groupId, boolean isMuted) {
          
    }

    @Override
    public void onAdminAdded(String groupId, String administrator) {
        
    }

    @Override
    public void onAdminRemoved(String groupId, String administrator) {
        
    }

    @Override
    public void onOwnerChanged(String groupId, String newOwner, String oldOwner) {
        
    }

    @Override
    public void onMemberJoined(final String groupId, final String member){
        
    }

    @Override
    public void onMemberExited(final String groupId, final String member) {
        
    }

    @Override
    public void onAnnouncementChanged(String groupId, String announcement) {
        
    }

    @Override
    public void onSharedFileAdded(String groupId, MucSharedFile sharedFile) {
        
    }

    @Override
    public void onSharedFileDeleted(String groupId, String fileId) {
        
    }
};

// Set group listener.
ChatClient.getInstance().groupManager().addGroupChangeListener(groupListener);

// Remove group listener if not use.
ChatClient.getInstance().groupManager().removeGroupChangeListener(groupListener);
```
