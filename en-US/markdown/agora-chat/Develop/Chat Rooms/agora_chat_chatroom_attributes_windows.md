# Manage Chat Room Attributes

Chat rooms enable real-time messaging among multiple users.

This page shows how to use the Agora Chat SDK to manage the attributes of a chat room in your app.

## Understand the tech

The Agora Chat SDK provides the `Room`, `IRoomManager`, and `IRoomManagerDelegate` classes for chat room management, which allows you to implement the following features:

- Retrieve the announcements of a chat room
- Update the announcements of a chat room
- Update the name of a chat room
- Update the description of a chat room

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Windows](./agora_chat_get_started_windows).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan).

## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement chat room features.

### Retrieve the chat room announcements

All chat room members can call `FetchRoomAnnouncement` to retrieve the chat room announcements. 

The following code sample shows how to retrieve the chat room announcements:

```c#
SDKClient.Instance.RoomManager.FetchRoomAnnouncement(roomId, new ValueCallBack<string>(
  onSuccess: (str) => {
  },
  onError: (code, desc) => {
  }
));
```

### Update the chat room announcements

Only the chat room owner and admins can call `UpdateRoomAnnouncement` to set and update the announcements. The length of the chat room announcements can be a maximum of 512 characters. Once the chat room announcements are updated, all the other chat room members receive the `OnAnnouncementChangedFromRoom` callback.

The following code sample shows how to update the chat room announcements:

```c#
SDKClient.Instance.RoomManager.UpdateRoomAnnouncement(roomId, announcement, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) => {
  }
));
```

### Update the chat room name

The chat room owner and admins can call `ChangeRoomName` to set and update the chat room name. The length of a chat room name can be a maximum of 128 characters.

The following code sample shows how to update the chat room name:

```c#
SDKClient.Instance.RoomManager.ChangeRoomName(roomId, name, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) => {
  }
));
```

### Update the chat room description

The chat room owner and admins can call `ChangeRoomDescription` to set and update the chat room description. The length of a chat room description can be a maximum of 512 characters.

The following code sample shows how to update the chat room description:

```c#
SDKClient.Instance.RoomManager.ChangeRoomDescription(currentRoomId, description, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) => {
  }
));
```

### Listen for chat room events

For details, see [Chat Room Events](./agora_chat_chatroom_windows#listen-for-chat-room-events).