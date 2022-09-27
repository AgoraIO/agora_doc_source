Chat room attributes consists of basic attributes (such as room name, room description, and room annoucement) and custom attributes. When basic attributes cannot satisfy the business requirements, users can add custom attributes that are synchronized with all chat room members. 
Custom attributes can be used to store information such as chat room type, game roles, game status, and host positions. They are stored as key-value maps, and the updates of custom attributes are synchronized with all chat room members

This page shows how to use the Agora Chat SDK to manage basic and custom attributes of chat rooms in your app.

## Understand the tech

The Agora Chat SDK provides the `ChatManager` and `ChatRoom` classes for chat room management, which allows you to implement the following features:

- Retrieve or modify basic attributes of a chat room
- Retrieve custom attributes of a chat room
- Set custom attributes of a chat room
- Remove custom attributes of a chat room

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Android](./agora_chat_get_started_android?platform=Android).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=Android).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan?platform=Android).


## Implementation

This section introduces how to call the APIs provided by the Agora Chat SDK to implement the features listed above.

### Retrieve basic chat room attributes

All the chat room members can call `fetchChatRoomFromServer` to retrieve the detailed information of the current chat room, including the subject, annoucenments, description, member type, and admin list. 

```java
// The `fetchPublicChatRoomsFromServer` method returns basic attributes including ID, name, description, mamximum members, owners, roles, and whether all members are muted.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().fetchChatRoomFromServer(chatRoomId);
```

### Change room subject or description
Only the chat room owner and admin can set and update the chat room subject and description.

```java
// The chat room owner and admin call changeChatRoomSubject to modify the chat room subject.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().changeChatRoomSubject(chatRoomId, newSubject);

// The chat room owner and admin call changeChatroomDescription to modify the chat room description.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().changeChatroomDescription(chatRoomId, newDescription);
```

### Retrieve or change chat room announcements

All the chat room members can retrieve the chat room announcements. 

Only the chat room owner and admin can set and update the announcements. Once the announcements are updated, all the chat room members receive the `onAnnouncementChanged` callback.

```java
// Chat room members can call fetchChatRoomAnnouncement to retrieve the chat room annoucements.
String announcement = ChatClient.getInstance().chatroomManager().fetchChatRoomAnnouncement(chatRoomId);

// The chat room owner and admin can call updateChatRoomAnnouncement to set or update the chat room announcements.
ChatClient.getInstance().chatroomManager().updateChatRoomAnnouncement(chatRoomId, announcement);
```

### Manage custom chat room attributes

#### Retrieve specified or all custom attributes 
All chat room members can call `asyncFetchChatroomAttributesFromServer` to retrieve specified or all custom attributes of the chat room.

```java
// Retrieves certain custom attributes by specifying chat room ID and attribute keys. 
ChatClient.getInstance().chatroomManager().asyncFetchChatroomAttributesFromServer(chatRoomId, keyList, new ValueCallBack<Map<String, String>>() {
                @Override
                public void onSuccess(Map<String, String> value) {
                }
                @Override
                public void onError(int error, String errorMsg) {
                }
            });

// Retrieves all custom attributes by specifying chat room ID.
ChatClient.getInstance().chatroomManager().asyncFetchChatRoomAllAttributesFromServer(chatRoomId, new ValueCallBack<Map<String, String>>() {
                @Override
                public void onSuccess(Map<String, String> value) {
                }
                @Override
                public void onError(int error, String errorMsg) {
                }
            });
```


#### Set a custom attribute
Chat room members can call `asyncSetChatroomAttributes` to set one single custom attribute. Use this method to add new custom attributes or update existing attributes that set by yourself. After you successfully call this method, other members in the chat room receives an `onAttributesUpdate` callback. 

```java
// Sets a custom attribute by specifying chat room ID, attribute key, and attribute value. 
ChatClient.getInstance().chatroomManager().asyncSetChatroomAttribute(chatRoomId,attributeKey,attributeValue,false, new CallBack() {
                @Override
                public void onSuccess() {
                }
                @Override
                public void onError(int error, String errorMsg) {
                }
            });
```

If you want to update a custom attribute that set by other members, call `asyncSetChatroomAttributesForced` instead. After you successfully call this method, other members in the chat room receives an `onAttributesUpdate` callback.

```java
// Sets a custom attribute by specifying chat room ID, attribute key, and attribute value.
ChatClient.getInstance().chatroomManager().asyncSetChatroomAttributesForced(chatRoomId,attributeKey,attributeValue,false, new CallBack() {
                @Override
                public void onSuccess() {
                }
                @Override
                public void onError(int error, String errorMsg) {
                }
            });
```       


#### Set multiple custom attributes
To set multiple custom attributes, call the `asyncSetChatroomAttributes` method with same name. Use this method to add new custom attributes or update existing attributes that set by yourself. After you successfully call this method, other members in the chat room receives an `onAttributesUpdate` callback. 

```java
// Sets multiple custom attribute by specifying chat room ID and the key-value maps of the attributes. 
ChatClient.getInstance().chatroomManager().asyncSetChatroomAttributes(chatRoomId, map, false, new ResultCallBack<Map<String, Integer>>() {
            @Override
            public void onSuccess(int code,Map<String, Integer> value) {
                // code == Error.EM_NO_ERROR indicates all the custom attributes are set successfully. 
                // value represents the custome attributes that are not successfully set.
            }
            @Override
            public void onError(int error, String errorMsg) {
            }
        });
```

If you want to update custom attributes that set by other members, call `asyncSetChatroomAttributesForced` instead. After you successfully call this method, other members in the chat room receives an `onAttributesUpdate` callback.

```java
// Sets a custom attribute by specifying chat room ID and the key-value maps of the attributes. 
ChatClient.getInstance().chatroomManager().asyncSetChatroomAttributesForced(chatRoomId, map, false, new ResultCallBack<Map<String, Integer>>() {
            @Override
            public void onSuccess(int code,Map<String, Integer> value) {
                // code == Error.EM_NO_ERROR indicates all the custom attributes are set successfully. 
                // value represents the custome attributes that are not successfully set.
            }
            @Override
            public void onError(int error, String errorMsg) {
            }
        });
```       


#### Remove a custom attribute
Chat room members can call `asyncRemoveChatRoomAttributesFromServer` to remove one single custom attribute that set by themselves. After you successfully call this method, other members in the chat room receives an `onAttributesRemoved` callback. 

```java
// Removes a custom attribute by specifying chat room ID and attribute key. 
ChatClient.getInstance().chatroomManager().asyncRemoveChatRoomAttributeFromServer(chatRoomId,attributeKey, new CallBack() {
                    @Override
                    public void onSuccess() {
                    }
                    @Override
                    public void onError(int error, String errorMsg) {
                    }
                });
```

If you want to update custom attributes that set by other members, call `asyncRemoveChatRoomAttributesFromServerForced` instead. After you successfully call this method, other members in the chat room receives an `onAttributesRemoved` callback.

```java
// Removes a custom attribute by specifying chat room ID and attribute key.  
ChatClient.getInstance().chatroomManager().asyncRemoveChatRoomAttributeFromServerForced(chatRoomId,attributeKey, new CallBack() {
                    @Override
                    public void onSuccess() {
                    }
                    @Override
                    public void onError(int error, String errorMsg) {
                    }
                });
```       

#### Remove multiple custom attributes
To remove multiple custom attributes, chat room members can call the `asyncRemoveChatRoomAttributesFromServer` method with same name to remove multiple custom attribute that set by themselves. After you successfully call this method, other members in the chat room receives an `onAttributesRemoved` callback. 

```java
// Removes multiple custom attributes by specifying chat room ID and the attribute key list. 
ChatClient.getInstance().chatroomManager().asyncRemoveChatRoomAttributesFromServer(chatRoomId,keyList, new ResultCallBack<Map<String, Integer>>() {
                    @Override
                    public void onSuccess(int code,Map<String, Integer> value) {
                    // code == Error.EM_NO_ERROR indicates all the custom attributes are removed successfully. 
                    // value represents the custome attributes that are not successfully removed.
                    }
                    @Override
                    public void onError(int error, String errorMsg) {
                    }
                });
```

If you want to update custom attributes that set by other members, call `asyncRemoveChatRoomAttributesFromServerForced` instead. After you successfully call this method, other members in the chat room receives an `onAttributesRemoved` callback.

```java
// Removes multiple custom attributes by specifying chat room ID and the attribute key list.  
ChatClient.getInstance().chatroomManager().asyncRemoveChatRoomAttributesFromServerForced(chatRoomId,keyList, new ResultCallBack<Map<String, Integer>>() {
                    @Override
                    public void onSuccess(int code,Map<String, Integer> value) {
                    // code == Error.EM_NO_ERROR indicates all the custom attributes are removed successfully. 
                    // value represents the custome attributes that are not successfully removed.
                    }
                    @Override
                    public void onError(int error, String errorMsg) {
                    }
                });
```       


