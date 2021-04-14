---
title: Edu Cloud Service Notifications
platform: RESTful
updatedAt: 2021-01-22 09:24:37
---
Agora Edu Cloud Service sends various notifications to clients via RTM channel messages and peer-to-peer messages.

## <a name="commonProperty"></a>Common fields

Every notification contains the following fields:

| Field      | Type    | Description                                                  |
| :--------- | :------ | :----------------------------------------------------------- |
| `cmd`      | `integer` | The type of notification. The client can use this field to determine the content of this notification.<li>Channel messages:<ul><li>1: Changes the room state<li>3: Room chat messages<li>4: Changes the room property <li>20: User(s) entering or leaving the room<li>21: Changes the user state<li>22: Changes the user property<li>40: Adds/updates/deletes a stream<li>99: Customized room messages</ul><li>Peer-to-peer messages:<ul><li>1: Peer-to-peer chat messages<li>99: Peer-to-peer customized messages</ul> |
| `version`  | `integer` | The version of Agora Edu Cloud Service notifications.        |
| `ts`       | `integer` | The UTC timestamp (in milliseconds) when Agora Edu Cloud Service sends a notification. |
| `sequence` | `integer` | The sequence number of a notification, which is also the unique identifier of each message. The room is automatically incremented globally to ensure state changes occur in the proper order. |
| `data`     | `object`  | The specific data of a notification. The data depends on the type of the notification. |

## Notifications

### Channel messages

#### <a name="roomStateUpdated"></a>1. Changes the room state

A `cmd` of `1` indicates a change in the room state, and the `data` contains the following fields: 

- `state`: `integer`. The room has three states:
  - 0: Not started.
  - 1: In progress.
  - 2: Ended. A new user cannot enter the room. 

- `startTime`: `integer`. The time when the room opens, shown in UTC timestamp format (in milliseconds). This field has a value after the room opens. 

- `operator`: `object`. The user who performs the operation. It contains three sub-fields:
  - `userUuid`: The UUID of the user.
  - `userName`: The name of the user.
  - `role`: The role of the user.

#### <a name="roomChatReceived"></a> 2. Room chat messages
	
A `cmd` of `3` indicates the receipt of a room chat message, and the `data` contains the following fields: 

- `fromUser`: `object`. The user who sends the message. It contains three sub-fields:
  - `userUuid`: The UUID of the user.
  - `userName`: The name of the user.
  - `role`: The role of the user.

- `message`: `string`. The content of the message.
- `type`: `integer`. The type of the message. Currently, only type 1 is available, which refers to a text message.

#### <a name="roomPropertyUpdated"></a> 3. Changes the room property

A `cmd` of `4` indicates a change in the room property, and the `data` contains the following fields: 

- `action`: `integer`. The operation has two types:
  - 0: Update the property.
  - 1: Delete the property.

- `changeProperties`: `object`. The changed user properties that are stored in a dictionary table. 

- `cause`: `object`. The reason for the change. It only provides a basis for the immediate processing of business logic of the client and will not persistently affect the room property. 

- `operator`: `object`. The user who performs the operation. It contains three sub-fields:
  - `userUuid`: `string`. The UUID of the user.
  - `userName`: `string`. The name of the user.
  - `role`: `integer`. The role of the user.

####<a name="roomEntry"></a> 4. User(s) entering or leaving the room

A `cmd` of `20` indicates a user or multiple users entering or leaving the room, and the `data` contains the following fields: 

- `total`: `integer`. The number of users entering and leaving the room.

- `onlineUsers`: `object` array. Users who enter the room. It contains the following sub-fields: 

  - `userUuid`: `string`. The UUID of the user.

  - `userName`: `string`. The name of the user.

  - `role`: `integer`. The role of the user.

  - `streams`: `object` array. Users' streams. It contains two sub-fields:

    - `streamUuid`: `string`. The UUID of the stream.
    - `streamName`: `string`. The name of the stream.

  - `updateTime`: `integer`. The time when the user enters the room, shown in UTC timestamp format (in milliseconds).

- `offlineUsers`: `object` array. Users who leave the room. It contains the following sub-fields: 

  - `userUuid`: `string`. The UUID of the user.

  - `userName`: `string`. The name of the user.

  - `role`: `integer`. The role of the user.

  - `streams`: `object` array. Users' s treams. It contains two sub-fields:

    - `streamUuid`: `string`. The UUID of the stream.
    - `streamName`: `string`. The name of the stream.

  - `updateTime`: `integer`. The time when the user leaves the room, shown in UTC timestamp format (in milliseconds).

  - `operator`: `object`. The user who performs the operation. This field is available when the user is kicked out of the room by another user.

    - `userUuid`: `string`. The UUID of the user.
    - `userName`: `string`. The name of the user.
    - `role`: `integer`. The role of the user.

#### <a name="userStateUpdated"></a>5. Changes the user state

A `cmd` of `21` indicates a change in the user state, and the `data` contains the following fields: 

- `userUuid`: `string`. The UUID of the user.

- `userName`: `string`. The name of the user.

- `role`: `integer`. The role of the user.

- `muteChat`: `integer`. Whether the user is prohibited from sending chat messages:

  - 0: Not prohibited.
  - 1: Prohibited.

- `operator`: `object`. The user who performs the operation. It contains three sub-fields:

  - `userUuid`: The UUID of the user.
  - `userName`: The name of the user.
  - `role`: The role of the user.

####<a name="userPropertyUpdated"></a> 6. Changes the user property

A `cmd` of `22` indicates a change in the user property, and the `data` contains the following fields: 

- `fromUser`: `object`. The user whose property changes. It contains three sub-fields:

  - `userUuid`: The UUID of the user.
  - `userName`: The name of the user.
  - `role`: The role of the user.

- `action`: `integer`. The operation has two types: 

  - 0: Update the property.
  - 1: Delete the property.

- `changeProperties`: `object`. The changed user properties that are stored in a dictionary table. 

- `cause`: `object`. The reason for the change. It only provides a basis for the immediate processing of business logic of the client and will not persistently affect the user property. 

- `operator`: `object`. The user who performs the operation. It contains three sub-fields: 

  - `userUuid`: `string`. The UUID of the user.
  - `userName`: `string`. The name of the user.
  - `role`: `integer`. The role of the user.

#### <a name="roomStreamUpdated"></a>7. Adds/updates/deletes a stream

A `cmd` of `40` indicates the adding, updating, or deleting of a stream, and the `data` contains the following fields: 

- `fromUser`: `object`. The user who owns the stream. It contains three sub-fields:

  - `userUuid`: The UUID of the user.
  - `userName`: The name of the user.
  - `role`: The role of the user.

- `streamUuid`: `string`. The UUID of the stream.

- `streamName`: `string`. The name of the stream.

- videoSourceType: `integer`. The video source has three types:

  - 0: No source.
  - 1: Camera.
  - 2: Screen.

- `audioSourceType`: `integer`. The audio source has two types:
  - 0: No source.
  - 1: Microphone.
- `videoState`: `integer`. The video has two states:
  - 0: Closed.
  - 1: Open.
- `audioState`: `integer`. The audio has two states:
  - 0: Closed.
  - 1: Open.
- `action`: `integer`. The action has three types:
  - 0: Add a stream.
  - 1: Update a stream.
  - 2: Delete a stream.

- `updateTime`: `integer`. The time when the stream is updated, shown in UTC timestamp format (in milliseconds).

- `operator`: `object`. The user who performs the operation. It contains three sub-fields:

  - `userUuid`: `string`. The UUID of the user.
  - `userName`: `string`. The name of the user.
  - `role`: `integer`. The role of the user.

####<a name="roomCustomMessageReceived"></a> 8. Customized room messages

A `cmd` of `21` indicates the receiving of a customized room message, and the `data` contains the following fields: 

- `fromUser`: `object`. The user who sends the message. It contains three sub-fields:

  - `userUuid`: The UUID of the user.
  - `userName`: The name of the user.
  - `role`: The role of the user.

- `message`: `string`. The content of the message.

### Peer-to-peer messages

####  <a name="p2pChatMessageReceived"></a>1. Peer-to-peer chat messages

A `cmd` of `1` indicates the receipt of a peer-to-peer chat message, and the `data` contains the following fields:

- `fromUser`: `object`. The user who sends the message. It contains three sub-fields:

  - `userUuid`: The UUID of the user.
  - `userName`: The name of the user.
  - `role`: The role of the user.

- `fromRoom`: `object`. This field is available when the user is in the room. It contains two sub-fields:

  - `roomUuid`: The UUID of the room.
  - `roomName`: The name of the room.

- `message`: `string`. The content of the message.

####  <a name="p2pCustomMessageReceived"></a>2. Peer-to-peer customized messages

A `cmd` of `99` indicates the receipt of a peer-to-peer customized message, and the `data` contains the following fields:

- `fromUser`: `object`. The user who sends the message. It contains three sub-fields:

  - `userUuid`: The UUID of the user.
  - `userName`: The name of the user.
  - `role`: The role of the user.

- `fromRoom`: `object`. This field is available when the user is in the room. It contains two sub-fields:

  - `roomUuid`: The UUID of the room.
  - `roomName`: The name of the room.

- `message`: `string`. The content of the message.