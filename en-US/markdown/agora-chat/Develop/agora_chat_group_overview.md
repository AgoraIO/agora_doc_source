Chat groups are systems that allow instant messaging among multiple chat users. The relationship between chat group members is quite stable: chat group members can send and receive messages in the group; when a chat group member goes offline, this member can receive push messages.

## Chat group types

Agora Chat has the following two chat group types: 
- Public. Public chat groups can be searched, and users can join a public chat group with or without the authorization of the group owner or admin.
- Private. Private chat groups cannot be searched, and users can only join a private group if the group owner or admin sends an invitation.

## Chat group roles and privileges

Chat groups have the following roles and privileges:

- Chat group members: Regular members that can send and receive group messages. They do not have any administrative privileges.
- Chat group admins: They are specified by the chat group owner. Apart from sending and receiving group messages, they have some administrative privileges, including modifying the group notification and managing chat group members.
- Chat group owner: The creator of the chat group. Chat group owners have the highest privileges, including specifying the chat group admin, disbanding the group, transferring the chat group ownership, modifying group notifications, and managing other chat group members.

## Differences between chat group and chat room

Both chat group and chat room support instant messaging among multiple users. The major difference lies in whether members have a stable relationship. Chat group members tend to remain for a long time, whereas chat room members join and leave freely.

The following table shows the feature comparisons between a chat group and a chat room:

| Feature    | Chat group   | Chat room     |
| --- | --- | --- |
| Use cases  | Group chat scenarios in Signal and Skype, where all members have a stable relationship. | Stream chat scenarios in Twitch, where viewers have no relationship with each other. Once a member quits the stream chat channel, this member leaves the chat room.  |
| Maximum number of members | 5,000 | 20,000 and more  |
| Message push support | Members receive push messages when they go offline. | Members do not recieve push messages when they go offline. |
| Message storage support | Supports message storage when a member is offline. Once online, this member receives all the stored messages. A maximum number of 200 messages can be stored for each group chat thread.   | This feature can be enabled and disabled. If you enable this feature, the SDK supports message storage when a member is offline. Once online, this member receives all the stored messages. By default, 10 messages can be stored for each chat room thread, and you can set this number to a maximum value of 200. |
| Message reliablity | All members can receive all the messages in the chat group. | When message overload occurs, the SDK discards the messages based on the threshold, which is 100 messages per second. You can adjust this threshold according to your needs.  |


## Chat group features

The Agora Chat SDK supports creating and managing chat groups, managing group members, and modifying group attributes.

You can implement the following features with the chat group APIs.

###  Create a chat group

Any chat user can create a chat group, and once you do so, you are the chat group owner. The maximum number of chat group numbers and group members supported vary accroding to the pricing plan. For details, see [Limitations of chat group member count](./limitations).

### Join a chat group

Users can join chat groups. For public chat groups, you can search them with the group ID and request to join it. For private chat groups, you can only join the group if the group owner or admin sends you a group chat invitation.

### Leave a chat group

Chat group members can quit a chat group and once they do, they no longer receive the group messages. Group owners cannot quit the chat group; instead, they disband the chat group. When a chat group is disbanded, all the chat group members quit the group involuntarily.

### Add a chat group member

Whether public or private chat groups, the group owner and admin can invite other users to join the chat group. 

### Remove a chat group member

The group owner and admin can remove the specified member from the group.

### Disband a chat group

Only the group owner can disband the chat group. Once a chat group is disbanded, all the local group data are deleted, and all the group messages receive the callback event.

### Retrieve the group memberlist

All the chat group users can retrieve the group members from the server with pagination. And the retrieved members are in the descending order of the timestamp when these members join the chat group.

### Retrieve the chat group list

You can retrieve the list of groups that you have created or joined.

### Block and unblock group messages

All chat group members can block and unblock group messages. Once you block the group messages, you no longer receive messages from the specified chat group.

### Listen for chat group events

You can listen for chat group events such as when a user joins and leaves the group, and add app logic as needed.

### Manage the chat group block list

The group owner or admin can add the specified group members to the block list and remove them from it. Once a member is added to the block list, this member is removed from the chat group and can no longer join it.

### Retrieve the chat group block list

You need to be a chat group owner or admin to retrieve the chat group block list. Members in the group block list cannot join the chat group.

### Manage the chat group allow list

The chat group owner and admin can add the specified group members to the group allow list and remove them from it. Once a member is added to the allow list, this member can send group messages when the group owner or admin has muted all the group members.

### Retrieve the chat group allow list

You need to be a chat group owner or admin to retrieve the chat group allow list. Members in the group allow list can send group messages when the chat group owner or admin has muted all the group members.

### Manage the chat group mute list

The group owner or admin can add the specifed group members to the group mute list and remove them from it. Once a member is added to the mute list, this member can no longer send chat group messages. Muted members can still receive group messages. 

### Mute all chat group members

The group owner or admin can mute or unmute all the chat group members. Once all the members can muted, none of the group members can send group messages except the group owner, admin, and the group members in the group allow list.

### Retrieve the chat group mute list

You need to be a chat group owner or admin to retrieve the chat group mute list. Members in the group mute list cannot send group messages.

### Transfer the chat group ownership

The group owner can transfer the ownership to the specified group member. Once the ownership is transferred, the group owner becomes a regular group member.

### Add and remove the group admin

The group owner can add or delete the chat group admin list.


### Modify the chat group attributes

The chat group owner or admin can modify the chat group name and descriptions. They can also set or update the group announcements. Chat group members can retrieve the group notifications.

### Manage the chat group shared files

All the chat group members can upload or download group shared files. The chat group owner or admin can delete all the group shared files, whereas group members can only delete the shared files that are uploaded by themselves.

### Set chat group extensions

The chat group owner or admin can update the extesnion information of the chat group. Extension information can be used to customize group extensions. The data length of the extension information cannot exceed 8 KB.

<a name="limitations"></a>

## Limitations of chat group member count

The maximum number of chat group members vary according to your pricing plan. For the Free pricing plan, the maximum number of members for each chat group is 100, for Starter, 250, and for Enterprise, 5,000.