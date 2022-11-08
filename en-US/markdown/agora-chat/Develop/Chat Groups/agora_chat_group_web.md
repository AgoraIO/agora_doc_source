# Manage Chat Groups

Chat groups enable real-time messaging among multiple users.

This page shows how to use the Agora Chat SDK to create and manage a chat group in your app.


## Understand the tech

The Agora Chat SDK provides the `GroupManager` and `Group` classes for chat group management, which allows you to implement the following features:

- Create and destroy a chat group
- Join and leave a chat group
- Retrieve the member list of a chat group
- Listen for the chat group events


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Web](./agora_chat_get_started_web?platform=Web).
- You understand the call frequency limits of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=Web).
- You understand the number of chat groups and chat group members supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan?platform=Web).


## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement chat group features.

### Create and destroy a chat group

Users can create a chat group and set the chat group attributes such as the name, description, group members, and reasons for creating the group. Users can also set the `GroupOptions` parameter to specify the size and type of the chat group. Once a chat group is created, the creator of the chat group automatically becomes the chat group owner.

Only chat group owners can disband chat groups. Once a chat group is disbanded, all members of that chat group receive the `destroy` callback and are immediately removed from the chat group. All local data for the chat group is also removed from the database and memory.

Refer to the following sample code to create and destroy a chat group:

```javascript
let option = {
    groupname: "groupName",
    desc: "A description of a group",
    members: ["user1", "user2"],
    // Set the type of a chat group to public. Public chat groups can be searched, and users can send join requests.
    public: true,
    // Join requests must be approved by the chat group owner or chat group admins.
    approval: true,
    // Allow chat group members to invite other users to join the chat group.
    allowinvites: true,
    // Group invitations must be confirmed by invitees.
    inviteNeedConfirm: true
}
// Call createGroup to create a chat group.
conn.createGroup(option).then(res => console.log(res))


// Call destroyGroup to disband a chat group.
let option = {
    groupId: "groupId"
};
conn.destroyGroup(option).then(res => console.log(res))
```


### Join and leave a chat group

Users can request to join a public chat group as follows:

1. Call `getJoinedGroups` to retrieve the list of the groups that the user is already in from the server.
2. Call `getPublicGroups` to retrieve the list of public groups by page. Users can obtain the ID of the group that they want to join.
3. Call `joinGroup` to send a join request to the chat group:
    - If the `approval` parameter of the group type is set to `false`, the request from the user is accepted automatically and the chat group members receive the `memberPresence` callback.
    - If the `approval` parameter is set to `true`, the chat group owner and chat group admins receive the `requestToJoin` callback and determine whether to accept the request from the user.

Users can call `memberAbsence` to leave a chat group. Once a user leaves the group, all the other group members receive the `memberAbsence` callback.

Refer to the following sample code to join and leave a chat group:

```javascript
// Call getJoinedGroups to retrieve the list of joined groups.
conn.getJoinedGroups({
                pageNum: 1,
                pageSize: 500,
                needAffiliations: true,
                needRole: true
})

// Call getPublicGroups to list public groups by page.
let limit = 20,
    cursor = globalCursor;
let option = {
    limit: limit,
    cursor: cursor, 
};
conn.getPublicGroups(option).then(res => console.log(res))

// Call joinGroup to send a join request to a chat group.
let options = {
    groupId: "groupId",
    message: "I am Tom"
};
conn.joinGroup(options).then(res => console.log(res))

// Call memberAbsence to leave a chat group.
let option = {
    groupId: "groupId"
};
conn.leaveGroup(option).then(res => console.log(res))
```


### Retrieve the member list of a chat group

Users can call `listGroupMembers` to retrieve the member list of a chat group by page.

Refer to the following sample code to retrieve the member list of a chat group:

```javascript
let pageNum = 1,
    pageSize = 1000;
let options = {
    pageNum: pageNum,
    pageSize: pageSize,
    groupId: "groupId"
};
conn.listGroupMembers(options).then(res => console.log(res))
```

### Listen for chat group events

Users can call `addEventHandler` to listen for chat group events.

Refer to the following sample code to listen for chat group events:

```javascript
conn.addEventHandler("eventName", {
  onGroupEvent: function(msg){
    switch(msg.operation){
      // Occurs when all chat group members are unmuted.
      case 'unmuteAllMembers':
        break;
      // Occurs when all chat group members are muted.
      case 'muteAllMembers':
        break;
      // Occurs when a member is removed from the chat group allow list.
      case 'removeAllowlistMember':
        break;
      // Occurs when a member is added to the chat group allow list.
      case 'addUserToAllowlist':
        break;
      // Occurs when a member deletes a chat group shared file.
      case 'deleteFile':
        break;
      // Occurs when a member uploads a chat group shared file.
      case 'uploadFile':
        break;
      // Occurs when a member deletes a chat group announcement.
      case 'deleteAnnouncement':
        break;
      // Occurs when a member updates a chat group announcement.
      case 'updateAnnouncement':
        break;
      // Occurs when a member is removed from the chat group mute list.
      case 'unmuteMember': 
        break;
      // Occurs when a member is add to the chat group mute list.
      case 'addMute':
        break;
      // Occurs when a chat group admin is removed from the admin list.
      case 'muteMember':
        break;
      // Occurs when a chat group member is added to the admin list.
      case 'setAdmin':
        break;
      // Occurs when the chat group owner is changed.
      case 'changeOwner':
        break;
      // Occurs when an invitee accepts the group invitation automatically.
      case 'directJoined':
        break;
      // Occurs when a group member leaves a chat group.
      case 'memberAbsence':
        break;
      // Occurs when a user joins a chat group.
      case 'memberPresence':
        break;
      // Occurs when a user is removed from a chat group.
      case 'removeMember':
        break;
      // Occurs when an invitee declines a group invitation.
      case 'rejectInvite':
        break;
      // Occurs when an invitee accepts a group invitation.
      case 'acceptInvite':
        break;
      // Occurs when a user receives a group invitation.
      case 'inviteToJoin':
        break;
      // Occurs when the chat group owner or admin rejects the join request.
      case 'joinPublicGroupDeclined':
        break;
      // Occurs when the chat group owner or admin approves the join request.
      case 'acceptRequest':
        break;
      // Occurs when the chat group owner and admins receive a join request.
      case 'requestToJoin':
        break;
      // Occurs when the chat group owner disbands the chat group.
      case 'destroy':
        break;
      default:
        break;
  }}
})
```