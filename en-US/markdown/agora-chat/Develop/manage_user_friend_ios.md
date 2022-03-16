After joining an Agora Chat channel, a user can update information such as the nickname, avatar, age, and mobile phone number as needed. To enjoy real-time chattings with friends, they can also add, delete and manage contacts.

This page shows how to use the Agora Chat SDK to implement managing user attributes and contacts.

> User attributes are stored in the Agora Chat server. If you have concerns in this regard, we recommend you managing user attributes yourself.


## Understand the tech

The following figure shows the workflow to manage user attribtues and contacts in your app:

![attributes_contact](https://web-cdn.agora.io/docs-files/1639032677528)

The Agora Chat SDK provides the following classes:
- [`IAgoraChatUserInfoManager`]() sets and retrieves the various user attributes with a `UserInfo` struct.
- [`IAgoraChatContactManager`]() enables users to add or delete contacts, accept or decline contact invitations, and add other users to the blocklist.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- Have a project that has implemented [the basic real-time chat functionalities](agora_chat_get_started_android).
- Have a thorough understanding of the API call frequency limit, the maximum size of all the attributes of a specified user, and the maximum size of all user attribtues in an app. For details, see [Known limitations]().

## Implement managing user attributes and contacts

This section shows how to manage user attributes and contacts with the methods provided by the Agora Chat SDK.

### Set, retrieve and update user attributes

The Agora Chat SDK uses the `UserInfoManager` class to manage user attributes, which enables you to set, retrieve, and update all attributes of a specified user or a particular user attribute of many specified users.

Refer to the code snippets below to see how to set, retrieve, and update user attribtues:

```objective-c
// Instantiate a UserInfo object
AgoraUserInfo *userInfo = [[AgoraUserInfo alloc] init];

// Set the user ID, nickname, avatar...
userInfo.userId = AgoraChatClient.sharedClient.currentUsername;
userInfo.nickName = @"agora";
userInfo.avatarUrl = @"http://www.agora.io";
userInfo.birth = @"2000.10.10";
userInfo.sign = @"hello world";
userInfo.phone = @"12333333333";
userInfo.mail = @"123456@qq.com";
userInfo.gender = 1;

// Call updateOwnInfo to set all user attributes
[AgoraChatClient.sharedClient.userInfoManager updateOwnUserInfo:userInfo completion:^(AgoraUserInfo *aUserInfo, AgoraError *aError)      

}];

// Call fetchUserInfoByUserId to retrieve user attributes
NSString *userIds = @[@"user1",@"user2"];
 NSArray<NSNumber *> *userInfoTypes = @[@(AgoraUserInfoTypeAvatarURL),@(AgoraUserInfoTypePhone),@(AgoraUserInfoTypeMail)];
 [[AgoraChatClient sharedClient].userInfoManager fetchUserInfoById:userIds type:userInfoTypes completion:^(NSDictionary *aUserDatas, AgoraError *aError) {
              
 }];

// Update the avatar by specifying the image URL
NSString *url = @"https://download-sdk.oss-cn-beijing.aliyuncs.com/downloads/IMDemo/avatar/Image1.png";
 
[[AgoraChatClient sharedClient].userInfoManager updateOwnUserInfo:url withType:AgoraUserInfoTypeAvatarURL completion:^(AgoraUserInfo *aUserInfo, AgoraError *aError) {
        if (aUserInfo && completion) {
            completion(aUserInfo);
        }
    }];
```

### Manage contacts

In a real-time chat, users can add or remove contacts, accept or decline a contact invitation, and add other users to a blocklist. The Agora Chat SDK uses a `ContactManager` class to enable these functionalities in your app. Refer to the following sample code to see how to implement contact management.

```objecitve-c
// Call addContact to send a contact invitation
[[EMClient sharedClient].contactManager addContact:@"aUsername" message:@"Message" completion:^(NSString *aUsername, EMError *aError) {
    if (!aError) {
        NSLog(@"Added the contact successfully %@",aUsername);
    } else {
        NSLog(@"Reasons for failing to add a contact %@", aError.errorDescription);
    }
}];

// Call addDelegate to listen for contact invitation events
[[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
})
// Call removeDeledate for contact invitation events
[[EMClient sharedClient].contactManager removeDelegate:self];
```

The following sample code shows how to use delegates to listen for friend requests and accpet or decline the request:

```objective-c
// Occurs when a  friend request is received
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername
                                message:(NSString *)aMessage
{ }

// Approves the friend request. The request sender will receive the friendRequestDidApprove callback
[[EMClient sharedClient].contactManager approveFriendRequestFromUser:@"aUsername" completion:^(NSString *aUsername, EMError *aError) {
    if (!aError) {
        NSLog(@"Successfully approves the friend request");
    } else {
        NSLog(@"Reasons for failing to approve the friend request --- %@", aError.errorDescription);
    }
}];

// Declines the friend request. The request sender will receive the friendRequestDidDecline callback
[[EMClient sharedClient].contactManager declineFriendRequestFromUser:@"aUsername" completion:^(NSString *aUsername, EMError *aError) {
    if (!aError) {
        NSLog(@"Successfully decines the friend request");
    } else {
        NSLog(@"Reasons for failing to decline the friend request %@", aError.errorDescription);
    }
}];
```

You can also add a specified user to your blocklist. Once you do that, you can still send chat messages to that user, but not receive messages from them. The following code shows how to add a user into a blocklist.

```objective-c
// Gets the blocklist from the server
[[EMClient sharedClient].contactManager getBlackListFromServerWithCompletion:^(NSArray *aList, EMError *aError) {
    if (!aError) {
        NSLog(@"Successfully getting the contact blocklist %@",aList);
    } else {
        NSLog(@"Reasons for failing to get the contact blocklist %@", aError.errorDescription);
    }
}];

// Gets the blocklist from the local database
NSArray *blockList = [[EMClient sharedClient].contactManager getBlackList];

// Call addUserToBlacklist to add a user, whehter your contact or not, to your blocklist
[[EMClient sharedClient].contactManager addUserToBlackList:@"aUsername" completion:^(NSString *aUsername, EMError *aError) {
    if (!aError) {
        NSLog(@"Successfully adding the user to the blocklist");
    } else {
        NSLog(@"Reasons for failing to add the user to the blocklist %@", aError.errorDescription);
    }
}];

// To remove a user from the blocklist, call removeUserFromBlackList
[[EMClient sharedClient].contactManager removeUserFromBlackList:@"aUsername" completion:^(NSString *aUsername, EMError *aError) {
    if (!aError) {
        NSLog(@"Successfully removing the user from the blocklist");
    } else {
        NSLog(@"Reasons for failing to remove the user from the blocklist %@", aError.errorDescription);
    }
}]; 
```

## Next steps

This section introduces extra functions you can implement in your app using user attributes and contact management.

### Manage user avatar

The Agora Chat SDK only supports storing the URL address of the avatar file, but not the file itself. To manage user avatar, you need to use a third-party file storage service.

To implement user avatar management in your app, take the following steps:

1. Upload the avator file to the third-party file storage service. Once the file is successfully uploaded, you get a URL address of the avatar file.
2. Set the `avatarUrl` parameter in user attributes as the URL address of the avatar file.
3. To display the avatar, call `fetchUserInfoByUserId` to retrieve the URL of the avatar file and then render the image on the local UI.

### Create and send a namecard using user attributes

Namecard messages are custom messages that include the user ID, nickname, avator, Email address, and phone number of the specified user. To create and send a namecard, take the following steps:

1. Set the messsage type as custom.
2. Set the `event` of the custom message as "user card".
3. Retrieve the values of the `userId`, `nickname`, and `avatarurl` of the user attributes and set them as the the cutom message body.

Followings are the sample code for creating and sending a namecard message:

```objective-c
// Set event of the cutom message as userCardm and add the chat ID, nickname and avatar in the ext property
CustomMessageBody *body = [[CustomMessageBody alloc] init];
    body.event = @"userCard";
    NSDictionary *messageExt = @{@"userId":AgoraChatClient.sharedClient.currentUsername,
                          @"nickname":@"nickname",
                          @"avatar":@"https://download-sdk.oss-cn-beijing.aliyuncs.com/downloads/IMDemo/avatar/Image1.png"
                        };
    body.ext = messageExt;
    Message *message = [[Message alloc] initWithConversationID:@"conversationID"
                                                          from:@"sender"
                                                            to:@"receiver"
                                                          body:body
                                                           ext:nil];
    // send message
    [[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:^(Message *message, AgoraError *error) {
    }];
```

## Reference

This section includes reference information that you may need to know during the implementation.

- Agora provides an open source [sample project]() on GitHub for your reference.
- For detailed information on user attributes, refer to the following API Reference:
  - [AgoraChatUserInfo]()
  - [IAgoraChatUserInfoManager]()
  - [IAgoraChatContactManager]()