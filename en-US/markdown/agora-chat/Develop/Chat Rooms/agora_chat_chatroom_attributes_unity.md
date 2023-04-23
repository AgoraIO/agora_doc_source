Chat room attributes consist of basic attributes (such as room subject, room description, and room announcement) and custom attributes. When basic attributes cannot satisfy the business requirements, users can add custom attributes that are synchronized with all chat room members.
Custom attributes can be used to store information such as chat room type, game roles, game status, and host positions. They are stored as key-value maps, and the updates of custom attributes are synchronized with all chat room members.

This page shows how to use the Agora Chat SDK to manage basic and custom attributes of chat rooms in your app.

## Understand the tech

The Agora Chat SDK provides the `Room`, `IRoomManager`, and `IRoomManagerDelegate` classes for chat room management, which allow you to implement the following features:

- Retrieve or modify basic attributes of a chat room
- Retrieve custom attributes of a chat room
- Set custom attributes of a chat room
- Remove custom attributes of a chat room

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Unity](./agora_chat_get_started_unity).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora-chat/agora_chat_limitation).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](./agora-chat/agora_chat_plan).

## Implementation

This section introduces how to call the APIs provided by the Agora Chat SDK to implement the features listed above.

### Manage basic chat room attributes

#### Retrieve basic chat room attributes

All chat room members can call `FetchRoomInfoFromServer` to retrieve the detailed information of the current chat room, including the subject, announcement, description, member type, and admin list. 

```c#
// The chat room members can call FetchRoomInfoFromServer to get the information of the specified chat room.
SDKClient.Instance.RoomManager.FetchRoomInfoFromServer(roomId, new ValueCallBack<Room>(
    onSuccess: (room) => {
    },
    onError: (code, desc) => {
    }
));
```

#### Change chat room subject or description
Only the chat room owner and admin can set and update the chat room subject and description.

```c#
// The chat room owner and admin can call ChangeRoomName to change the chat room subject.
SDKClient.Instance.RoomManager.ChangeRoomName(roomId, name, new CallBack(
    onSuccess: () => {
    },
    onError: (code, desc) => {
    }
));

// The chat room owner and admin can call ChangeRoomDescription to modify the chat room description.
SDKClient.Instance.RoomManager.ChangeRoomDescription(roomId, newDesc, new CallBack(
    onSuccess: () => {
    },
    onError: (code, desc) => {
    }
));
```

#### Retrieve or change chat room announcements

All chat room members can retrieve the chat room announcement.

Only the chat room owner and admin can set and update the announcement. Once the announcement is updated, all the other chat room members receive the `OnAnnouncementChangedFromRoom` callback.

```c#
// Chat room members can call FetchRoomAnnouncement to retrieve the chat room announcement.
SDKClient.Instance.RoomManager.FetchRoomAnnouncement(roomId, new ValueCallBack<string>(
    onSuccess: (announcement) => {
    },
    onError: (code, desc) => {
    }
));

// The chat room owner and admin can call UpdateRoomAnnouncement to set or update the chat room announcement.
SDKClient.Instance.RoomManager.UpdateRoomAnnouncement(roomId, announcement, new CallBack(
    onSuccess: () => {
    },
    onError: (code, desc) => {
    }
));
```

### Manage custom chat room attributes

#### Retrieve specified or all custom attributes

All chat room members can call `FetchAttributes` to retrieve the specified or all custom attributes of the chat room.

```c#
// Retrieves certain or all custom attributes by specifying chat room ID and attribute keys.  
SDKClient.Instance.RoomManager.FetchAttributes(roomId, keys, new ValueCallBack<Dictionary<string, string>>(
    onSuccess: (Dictionary<string, string> dict) => {
    },
    onError: (code, desc) => {
    }
));
```

#### Set one or more custom attributes

All chat room members can call `AddAttributes` to set one or more custom attributes. Use this method to add new custom attributes or update existing attributes that are set by yourself and others. After you successfully call this method, other members in the chat room receive an `OnChatroomAttributesChanged` callback.

```c#
// Sets custom attributes by specifying the chat room ID and key-value maps of the attributes. 
SDKClient.Instance.RoomManager.AddAttributes(roomId, kv, deleteWhenExit, forced, new CallBackResult(
    onSuccessResult: (Dictionary<string, int> failInfo) => {
        if(failInfo.Count == 0)
        {
            //AddAttributes success
        }
        else
        {
            //AddAttributes partial success
        }
    },
    onError: (code, desc) => {
    }
));
```

#### Remove one or more custom attributes

Chat room members can call `RemoveAttributes` to remove one or more custom attributes that are set by themselves and others. After you successfully call this method, other members in the chat room receive an `OnChatroomAttributesRemoved` callback. 

```c#
// Removes custom attributes by specifying the chat room ID and the attribute key list. 
SDKClient.Instance.RoomManager.RemoveAttributes(roomId, keys, forced, new CallBackResult(
    onSuccessResult: (Dictionary<string, int> failInfo) => {
        if (failInfo.Count == 0)
        {
            // All the custom attributes are removed successfully. 
        }
        else
        {
            // Certain custom attributes are not removed successfully. 
        }
    },
    onError: (code, desc) => {
    }
));
```

For details, see [Chat Room Events](./agora_chat_chatroom_unity#listen-for-chat-room-events).

