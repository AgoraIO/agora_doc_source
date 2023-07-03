Chat room attributes consists of basic attributes (such as room name, room description, and room announcement) and custom attributes. When basic attributes cannot satisfy the business requirements, users can add custom attributes that are synchronized with all chat room members. 
Custom attributes can be used to store information such as chat room type, game roles, game status, and host positions. They are stored as key-value maps, and the updates of custom attributes are synchronized with all chat room members.

This page shows how to use the Agora Chat SDK to manage basic and custom attributes of chat rooms in your app.

## Understand the tech

The Agora Chat SDK allows you to implement the following features:

- Retrieve or modify basic attributes of a chat room
- Retrieve custom attributes of a chat room
- Set custom attributes of a chat room
- Remove custom attributes of a chat room


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Web](./agora_chat_get_started_web?platform=Web).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=Web).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan?platform=Web).


## Implementation

This section introduces how to call the APIs provided by the Agora Chat SDK to implement the features listed above.

### Manage basic chat room attributes

#### Retrieve basic chat room attributes

All chat room members can retrieve the detailed information of the current chat room, including the subject, announcements, description, member type, and admin list.

```javascript
// Chat room members can call getChatRoomDetails to get the information of the specified chat room.
AgoraError *error = nil;
let option = {
    chatRoomId: 'chatRoomId'
}
conn.getChatRoomDetails(option).then(res => console.log(res))
```

#### Change basic chat room attributes
Only the chat room owner and admin can set and update the basic chat room attributes, including subject, description, and maximum room members.

```javascript
// The chat room owner and admins can call modifyChatRoom to update the chat room attributes.
let option = {
    chatRoomId: 'chatRoomId',
    chatRoomName: 'chatRoomName', // The name of the chat room
    description: 'description',   // The description of the chat room
    maxusers: 200                 // The maximum number of chat room members
}
conn.modifyChatRoom(option).then(res => console.log(res))
```

#### Retrieve or change chat room announcements

All chat room members can retrieve the chat room announcements.

The chat room owner and admins can set and update the chat room announcements. Once the announcements are updated, all the chat room members receive the `updateAnnouncement` callback.

```javascript
// Chat room members can call fetchChatRoomAnnouncement to retrieve the chat room announcements.
var option = {
    roomId: 'roomId'                        
};
conn.fetchChatRoomAnnouncement(option).then(res => console.log(res))

// The chat room owner and admins can call updateChatRoomAnnouncement to set or update the chat room announcements.
let option = {
    roomId: 'roomId',  
    announcement: 'hello everyone'                  
};
conn.updateChatRoomAnnouncement(option).then(res => console.log(res))
```


### Manage custom chat room attributes

#### Retrieve specified or all custom attributes 
All chat room members can call `getChatRoomAttributes` to retrieve specified or all custom attributes of the chat room.

```javascript
// Retrieves certain custom attributes by specifying chat room ID and attribute keys. 
let option = {
    chatRoomId: "chatRoomId",  // The chat room ID.
    attributeKeys: ["attributeKey1","attributeKey2","..."] // The attribute key. If you leave it empty, all custom attributes are returned.
}
conn.getChatRoomAttributes(option).then(res => console.log(res))
```

#### Set a custom attribute
Chat room members can call `setChatRoomAttribute` to set one single custom attribute. After you successfully call this method, other members in the chat room receive an `updateChatRoomAttributes` callback. 

```javascript
// Sets a custom attribute by specifying chat room ID, attribute key, and attribute value. 
let option = {
    chatRoomId: "chatRoomId",// The chat room ID.
    attributeKey: "attributeKey";// The attribute key. 
    attributeValue: "attributeValue"; // The attribute value. 
    autoDelete: true; // (Optional) Whether to automatically delete the custom attributes set by a member when the member leaves the chat room. 
    isForced: false  // (Optional) If the attribute is already set by another room member, whether to overwrite other members' setting. 
}
conn.setChatRoomAttribute(option).then(res => console.log(res))
```


#### Set multiple custom attributes
To set multiple custom attributes, call the `setChatroomAttributes` method. After you successfully call this method, other members in the chat room receive an `updateChatRoomAttributes` callback. 

```javascript
// Sets multiple custom attributes by specifying chat room ID and the key-value maps of the attributes. 
   let option = {
       chatRoomId: "chatRoomId",  // The chat room ID.
       attributes:{  // The key-value maps of the attributes in the format of {"key":"value"}.
            "attributeKey1":"attributeValue1",
        	"attributeKey2":"attributeValue2",
         	"..."
       },
       autoDelete: true; // (Optional) Whether to automatically delete the custom attributes set by a member when the member leaves the chat room. 
   	   isForced: false  // (Optional) If the attribute is already set by another room member, whether to overwrite other members' setting. 
   }
   conn.setChatRoomAttributes(option).then(res => console.log(res))
```

#### Remove a custom attribute
Chat room members can call `removeChatroomAttribute` to remove one single custom attribute. After you successfully call this method, other members in the chat room receive a `removeChatRoomAttributes` callback. 

```javascript
// Removes a custom attribute by specifying chat room ID and attribute key. 
let option = {
    chatRoomId: "chatRoomId",  // The chat room ID.
    attributeKey: "attributeKey",  // The attribute key. 
    isForced: false // (Optional) If the attribute is already set by another room member, whether to overwrite other members' setting. 
}
conn.removeChatRoomAttribute(option).then(res => console.log(res))
```
 

#### Remove multiple custom attributes
To remove multiple custom attributes, chat room members can call the `removeChatroomAttributes` method. After you successfully call this method, other members in the chat room receive a  `removeChatRoomAttributes` callback. 
 
```javascript
// Removes multiple custom attributes by specifying chat room ID and the attribute key list. 
let option = {
    chatRoomId: "chatRoomId",  // The chat room ID.
    attributeKeys: ["attributeKey1","attributeKey2","..."], // The attribute keys. 
    isForced: false // (Optional) If the attribute is already set by another room member, whether to overwrite other members' setting. 
}
conn.removeChatRoomAttributes(option).then(res => console.log(res))
```

