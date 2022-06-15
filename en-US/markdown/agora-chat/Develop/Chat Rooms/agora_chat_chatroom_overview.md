Chat rooms enable real-time messaging among multiple users. Chat rooms do not have a strict membership, and members do not retain any permanent relationship with each other. Once a chat room member goes offline, this member does not receive any push messages from the chat room and automatically leaves the chat room in five minutes. Chat rooms are widely applied in live broadcast use cases as stream chat in Twitch.

## Chat room roles and privileges

Chat rooms have the following roles and privileges:

- Chat room members: Members can send and receive chat room messages. 
- Chat room admins: Admins are appointed by the chat group owner. Apart from sending and receiving chat room messages, admins have some administrative privileges. Chat rooms can be configured to have up to 99 admins.
- Chat room owner: When a user creates a chat room, they automatically become the owner. Owners have the most privileges in a chat room, including appointing admins, modifying chat room attributes, and managing other chat room members (including admins). Owners can also disband the chat room or transfer ownership to another member.

## Chat groups vs. chat rooms

Chat groups and chat rooms both support instant messaging among multiple users. However, chat groups typically have a more consistent membership than chat rooms. Chat group users are normally connected to the group itself; chat room users are more likely to be connected by their interest in the subject of the chat room, and so they tend to join and leave more freely.

The specific feature differences are listed in the following table:

| Feature    | Chat group   | Chat room     |
| --- | --- | --- |
| Use cases  | Group chat scenarios in Signal and Skype, where members have a preexisting relationship with each other. | Stream chat scenarios in Twitch, where viewers have no relationship with each other. Once a member quits the stream channel, they leave the chat room.  |
| Maximum number of members | 5,000 | 20,000+  |
| Message push support | Members receive push messages when they go offline. | Members do not receive push messages when they go offline. |
| Message storage support | Supports message storage when a member is offline. Once online, this member receives all the stored messages. A maximum number of 200 messages can be stored for each group chat thread.   | This feature can be enabled and disabled. If you enable this feature, the SDK supports message storage when a member is offline. Once online, this member receives all the stored messages. By default, 10 messages can be stored for each chat room thread, and you can set this number to a maximum value of 200. |
| Message reliablity | All members receive all the messages in the chat group. | Members might not see all messages. The SDK discards messages if the chat group message threshold is exceeded. The default threshold is 100 messages per second. You can adjust this threshold according to your needs.  |

## Chat room features

The Agora Chat SDK supports creating and managing chat rooms, managing chat room members, and modifying chat room attributes.

You can implement the following features with the chat room APIs:


### Create a chat room

Only the [chat room super admin](./agora_chat_restful_chatroom_superadmin) can create a chat room, and the user that creates the chat room becomes the chat room owner. The maximum number of chat room members supported varies according to the pricing plan. For details, see [Limitations of chat room](#limitations).

### Join and leave a chat room

All the chat users can join and leave the chat room freely.

### Disband a chat room

Only the chat room owner can disband the chat room. 

### Retrieve the chat room list

All the chat users can retrieve the chat room list from the server with pagination.

### Retrieve the chat room attributes

All the chat room members can retrieve the chat room attributes, including the chat room name and descriptions.

### Modify the chat room name

Only the chat room owner has the privilege to modify the chat room name.

### Modify chat room notifications

Only the chat room owner has the privilege to edit and delete chat room notifications. Once the notification is updated, all the chat room members are informed of this update by callback events.

### Transfer the chat room ownership

The chat room owner can transfer the ownership to a specified chat room member.

### Add and remove the chat room admin

The chat room owner can add and remove a chat room admin.

### Mute a specified chat room member

The chat room owner or an admin can mute a specified chat room member.

### Mute all chat room members

The chat room owner or an admin can mute all the chat room members at once. By default, the chat room owner and all admins are excluded from the chat room mute list, as are any members on the allow list.

### Manage the chat room allow list

The chat room owner or admin add or remove specified members from the chat room allow list. Members on the allow list can send messages to the chat room even when the chat room owner or an admin has muted all the chat room members.

### Manage the chat room block list

The chat room owner or admin can add the specified members to the chat room block list, and remove them from the list. Once added to the chat room block list, the members cannot send or receive chat group messages, nor can they join the chat room again.


<a name="limitations"></a>

## Chat room limitations

The maximum number of chat room members, the total number of chat rooms you can create, and the maximum number of chat rooms a user can join vary according to your pricing plan.

| Pricing plan   | Number of chat room members   | Number of chat rooms you can create | Number of chat rooms a user can join |
| :--------- | :------------- | :----------- | ------------------ |
| **Free**       | 100            | 100          | 100                |
| **Starter**    | 2,000          | 10,000       | 1,000              |
| **Pro**        | 10,000         | 50,000       | 2,000              |
| **Enterprise** | 20,000 and more| 100,000      | 10,000             |