Chat room attributes consists of basic attributes (such as room name, room description, and room announcement) and custom attributes. When basic attributes cannot satisfy the business requirements, users can add custom attributes that are synchronized with all chat room members.
Custom attributes can be used to store information such as chat room type, game roles, game status, and host positions. They are stored as key-value maps, and the updates of custom attributes are synchronized with all chat room members.

This page shows how to use the Agora Chat SDK to manage basic and custom attributes of chat rooms in your app.

## Understand the tech

The Agora Chat SDK provides the `Room`, `IRoomManager`, and `IRoomManagerDelegate` classes for chat room management, which allows you to implement the following features:

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
All the chat room members can call `FetchRoomInfoFromServer` to retrieve the detailed information of the current chat room, including the subject, announcements, description, member type, and admin list. 

```c#
// The FetchRoomInfoFromServer method returns basic attributes including ID, name, description, maximum members, owners, roles, and whether all members are muted.
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
// The chat room owner and admin call ChangeRoomName to modify the chat room subject.
SDKClient.Instance.RoomManager.ChangeRoomName(roomId, name, new CallBack(
    onSuccess: () => {
    },
    onError: (code, desc) => {
    }
));

// The chat room owner and admin call ChangeRoomDescription to modify the chat room description.
SDKClient.Instance.RoomManager.ChangeRoomDescription(roomId, newDesc, new CallBack(
    onSuccess: () => {
    },
    onError: (code, desc) => {
    }
));
```

#### Retrieve or change chat room announcements
All the chat room members can retrieve the chat room announcements.

Only the chat room owner and admin can set and update the announcements. Once the announcements are updated, all the chat room members receive the `OnAnnouncementChangedFromRoom` callback.

```c#
// Chat room members can call FetchRoomAnnouncement to retrieve the chat room announcements.
SDKClient.Instance.RoomManager.FetchRoomAnnouncement(roomId, new ValueCallBack<string>(
    onSuccess: (announcement) => {
    },
    onError: (code, desc) => {
    }
));

// The chat room owner and admin can call UpdateRoomAnnouncement to set or update the chat room announcements.
SDKClient.Instance.RoomManager.UpdateRoomAnnouncement(roomId, annoucement, new CallBack(
    onSuccess: () => {
    },
    onError: (code, desc) => {
    }
));
```

### Manage custom chat room attributes

#### Retrieve specified or all custom attributes
All chat room members can call `FetchAttributes` to retrieve specified or all custom attributes of the chat room.

```c#
SDKClient.Instance.RoomManager.FetchAttributes(roomId, keys, new ValueCallBack<Dictionary<string, string>>(
    onSuccess: (Dictionary<string, string> dict) => {
    },
    onError: (code, desc) => {
    }
));
```
Note: In FetchAttributes function, the second parameter `keys` is a List<string> type. If set it with null or empty, then FetchAttributes will retrieve all all custom attributes.


#### Set custom attributes
Chat room members can call `AddAttributes` to set one single custom attribute. Use this method to add new custom attributes or update existing attributes that set by yourself. After you successfully call this method, other members in the chat room receive an `OnChatroomAttributesChanged` callback.

```c#
SDKClient.Instance.RoomManager.AddAttributes(roomId, kv, deleteWhenExit, forced, new CallBackResult(
    onSuccessResult: (Dictionary<string, int> failInfo) => {
        if(failInfo.Count == 0)
        {
            //AddAttributes success
        }
        else
        {
            //AddAttributes partial sucess
        }
    },
    onError: (code, desc) => {
    }
));
```
Note: In AddAttributes, the second parameter `kv` is Dictionary<string, string> type which contains attribute keys and values to be added; the third parameter `deleteWhenExit` means deleting related properties or not when the user exit the room; the forth parameter `forced` means force to update attributes set by others.

If you want to update a custom attribute that is set by other members, call `asyncSetChatroomAttributesForced` instead. After you successfully call this method, other members in the chat room receive an `onAttributesUpdate` callback.


#### Remove custom attributes
Chat room members can call `RemoveAttributes` to remove one or multiple custom attributes. After you successfully call this method, other members in the chat room receive an `OnChatroomAttributesRemoved` callback. 

```c#
SDKClient.Instance.RoomManager.RemoveAttributes(roomId, keys, forced, new CallBackResult(
    onSuccessResult: (Dictionary<string, int> failInfo) => {
        if (failInfo.Count == 0)
        {
            //RemoveAttributes success
        }
        else
        {
            //RemoveAttributes partial sucess.
        }
    },
    onError: (code, desc) => {
    }
));
```
Note: In RemoveAttributes, the second parameter `keys` is List<string> type which contain attribute keys and values to be removed; the third parameter `forced` means force to remove attributes set by others.


