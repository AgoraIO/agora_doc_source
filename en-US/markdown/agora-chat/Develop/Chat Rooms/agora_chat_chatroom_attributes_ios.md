Chat room attributes consists of basic attributes (such as room name, room description, and room announcement) and custom attributes. When basic attributes cannot satisfy the business requirements, users can add custom attributes that are synchronized with all chat room members. 
Custom attributes can be used to store information such as chat room type, game roles, game status, and host positions. They are stored as key-value maps, and the updates of custom attributes are synchronized with all chat room members.

This page shows how to use the Agora Chat SDK to manage basic and custom attributes of chat rooms in your app.

## Understand the tech

The Agora Chat SDK provides the `IAgoraChatroomManager`, `AgoraChatroomManagerDelegate`, and `AgoraChatRoom` classes for chat room management, which allows you to implement the following features:

- Retrieve or modify basic attributes of a chat room
- Retrieve custom attributes of a chat room
- Set custom attributes of a chat room
- Remove custom attributes of a chat room


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with iOS](./agora_chat_get_started_ios?platform=iOS).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=iOS).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan?platform=iOS).


## Implementation

This section introduces how to call the APIs provided by the Agora Chat SDK to implement the features listed above.

### Manage basic chat room attributes

#### Retrieve basic chat room attributes
All chat room members can call `getChatroomSpecificationFromServerWithId` to retrieve the detailed information of the current chat room, including the subject, announcements, description, member type, and admin list. 

```objective-c
// Chat room members can call getChatroomSpecificationFromServerWithId to get the information of the specified chat room.
AgoraChatError *error = nil;
AgoraChatroom *chatroom = [[AgoraChatClient sharedClient].roomManager getChatroomSpecificationFromServerWithId:@“chatroomId” error:&error];
```

#### Change chat room subject or description
Only the chat room owner and admin can set and update the chat room subject and description.

```objective-c
// The chat room owner and admins can call updateSubject to update the chat room subject.
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager updateSubject:textString forChatroom:self.chatroom.chatroomId error:&error];

// The chat room owner and admins can call updateDescription to update the chat room description.
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager updateDescription:textString forChatroom:self.chatroom.chatroomId error:&error];
```

#### Retrieve or change chat room announcements

All chat room members can retrieve the chat room announcements.

Only the chat room owner and admins can set and update the chat room announcements. Once the announcements are updated, all the chat room members receive the `groupAnnouncementDidUpdate` callback.

```objective-c
// Chat room members can call getChatroomAnnouncementWithId to retrieve the chat room announcements.
[AgoraChatClient.sharedClient.roomManager getChatroomAnnouncementWithId:@"chatRoomId" error:&error];

// The chat room owner and admins can call updateChatroomAnnouncementWithId to set or update the chat room announcements.
AgoraChatError *error =  nil;
[[AgoraChatClient sharedClient].roomManager updateChatroomAnnouncementWithId:_chatroomId announcement:textString error:&error];
```

### Manage custom chat room attributes

#### Retrieve specified or all custom attributes 
All chat room members can call `fetchChatroomAttributes` or `fetchChatroomAllAttributes` to retrieve specified or all custom attributes of the chat room.

```objective-c
// Retrieves certain custom attributes by specifying chat room ID and attribute keys. 
[AgoraChatClient.sharedClient.roomManager fetchChatroomAttributes:self.currentConversation.conversationId keys:@[@"123"] completion:^(NSDictionary * _Nullable map, EMError * _Nullable error) {
            }];

// Retrieves all custom attributes by specifying chat room ID.
[AgoraChatClient.sharedClient.roomManager fetchChatroomAllAttributes:self.currentConversation.conversationId completion:^(NSDictionary * _Nullable map, EMError * _Nullable error) {
            }];
```


#### Set a custom attribute
Chat room members can call `setChatroomAttributes` to set one single custom attribute. Use this method to add new custom attributes or update existing attributes that are set by yourself. After you successfully call this method, other members in the chat room receive a `chatroomAttributesDidUpdated` callback. 

```objective-c
// Sets a custom attribute by specifying chat room ID, attribute key, and attribute value. 
[AgoraChatClient.sharedClient.roomManager setChatroomAttributes:self.currentConversation.conversationId key:@"234" value:@"123" autoDelete:YES completionBlock:^(EMError * _Nullable aError, NSDictionary<NSString *,NSString *> * _Nullable failureKeys) {
                }];
```

If you want to update a custom attribute that is set by other members, call `setChatroomAttributesForced` instead. After you successfully call this method, other members in the chat room receive a `chatroomAttributesDidUpdated` callback.

```objective-c
// Sets a custom attribute by specifying chat room ID, attribute key, and attribute value.
[AgoraChatClient.sharedClient.roomManager setChatroomAttributesForced:self.currentConversation.conversationId key:@"234" value:@"123" autoDelete:YES completionBlock:^(EMError * _Nullable aError, NSDictionary<NSString *,NSString *> * _Nullable failureKeys) {
                }];
```       


#### Set multiple custom attributes
To set multiple custom attributes, call the `setChatroomAttributes` method with same name. Use this method to add new custom attributes or update existing attributes that are set by yourself. After you successfully call this method, other members in the chat room receive a `chatroomAttributesDidUpdated` callback. 

```objective-c
// Sets multiple custom attributes by specifying chat room ID and the key-value maps of the attributes. 
[AgoraChatClient.sharedClient.roomManager setChatroomAttributes:self.currentConversation.conversationId attributes:@{@"testKey":@"123"} autoDelete:YES completionBlock:^(EMError * _Nullable aError, NSDictionary<NSString *,NSString *> * _Nullable failureKeys) {
                }];
```

If you want to update custom attributes that are set by other members, call `setChatroomAttributesForced` instead. After you successfully call this method, other members in the chat room receive a `chatroomAttributesDidUpdated` callback.

```objective-c
// Sets a custom attribute by specifying chat room ID and the key-value map of the attribute. 
[AgoraChatClient.sharedClient.roomManager setChatroomAttributesForced:self.currentConversation.conversationId attributes:@{@"testKey":@"123"} autoDelete:YES completionBlock:^(EMError * _Nullable aError, NSDictionary<NSString *,NSString *> * _Nullable failureKeys) {
                }];
```       


#### Remove a custom attribute
Chat room members can call `removeChatroomAttributes` to remove one single custom attribute that is set by themselves. After you successfully call this method, other members in the chat room receive a `chatroomAttributesDidRemoved` callback. 

```objective-c
// Removes a custom attribute by specifying chat room ID and attribute key. 
[AgoraChatClient.sharedClient.roomManager removeChatroomAttributes:self.currentConversation.conversationId key:@"234" autoDelete:YES completionBlock:^(EMError * _Nullable aError, NSDictionary<NSString *,NSString *> * _Nullable failureKeys) {
                }];
```

If you want to update custom attributes that are set by other members, call `removeChatroomAttributesForced` instead. After you successfully call this method, other members in the chat room receive a `chatroomAttributesDidRemoved` callback.

```objective-c
// Removes a custom attribute by specifying chat room ID and attribute key.  
[AgoraChatClient.sharedClient.roomManager removeChatroomAttributesForced:self.currentConversation.conversationId key:@"234" autoDelete:YES completionBlock:^(EMError * _Nullable aError, NSDictionary<NSString *,NSString *> * _Nullable failureKeys) {
                }];
```       

#### Remove multiple custom attributes
To remove multiple custom attributes, chat room members can call the `removeChatroomAttributes` method with same name to remove multiple custom attributes that are set by themselves. After you successfully call this method, other members in the chat room receive a  `chatroomAttributesDidRemoved` callback. 

```objective-c
// Removes multiple custom attributes by specifying chat room ID and the attribute key list. 
[AgoraChatClient.sharedClient.roomManager removeChatroomAttributes:self.currentConversation.conversationId attributes:@[@"testKey"] completionBlock:^(EMError * _Nullable aError, NSDictionary<NSString *,NSString *> * _Nullable failureKeys) {
                }];
```

If you want to update custom attributes that are set by other members, call `removeChatroomAttributesForced` instead. After you successfully call this method, other members in the chat room receive a `chatroomAttributesDidRemoved` callback.

```objective-c
// Removes multiple custom attributes by specifying chat room ID and the attribute key list.  
[AgoraChatClient.sharedClient.roomManager removeChatroomAttributesForced:self.currentConversation.conversationId attributes:@[@"testKey"] completionBlock:^(EMError * _Nullable aError, NSDictionary<NSString *,NSString *> * _Nullable failureKeys) {
                }];
```       


