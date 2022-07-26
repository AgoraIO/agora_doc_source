After joining an Agora Chat channel, a user can update information such as the nickname, avatar, age, and mobile phone number as needed. These are known as user attributes.

This page shows how to use the Agora Chat SDK to implement managing user attributes.

<div class="alert note"><ul><li>User attributes are stored on the Agora Chat server. If you have security concerns, Agora recommends that you manage user attributes yourself.</li><li>To ensure information security, app users can only modify their own user attributes. Only app admins can modify the user attributes of other users.</li></ul></div>

## Understand the tech

The Agora Chat SDK uses `UserInfoManager` to retrieve, set, and modify user attributes. Followings are the core methods:
- `updateOwnUserInfo`: Set or update user attributes.
- `fetchUserInfoById`: Retrieve the user attributes of the specified user.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_ios?platform=iOS).
- Have a thorough understanding of the API call frequency limit, the maximum size of all the attributes of a specified user, and the maximum size of all user attributes in an app. For details, see [Known limitations](./agora_chat_limitation?platform=iOS).

## Implementation

This section shows how to manage user attributes and contacts with the methods provided by the Agora Chat SDK.

### Set user attributes

Chat users can set and update their own attributes. Refer to the code example to set all the user attributes:

```objective-c
// Sets the user attributes.
AgoraChatUserInfo *userInfo = [[AgoraChatUserInfo alloc] init];
userInfo.userId = AgoraChatClient.sharedClient.currentUsername;
userInfo.nickName = @"agora";
userInfo.avatarUrl = @"http://www.agora.io";
userInfo.birth = @"2000.10.10";
userInfo.sign = @"hello world";
userInfo.phone = @"12333333333";
userInfo.mail = @"123456@qq.com";
userInfo.gender = 1;
[AgoraChatClient.sharedClient.userInfoManager updateOwnUserInfo:userInfo completion:^(AgoraChatUserInfo *aUserInfo, AgoraChatError *aError)      

}];        
```

The following sample code uses avatar as an example to show how to set the specified user attribute:

```objective-c
NSString *url = @"https://download-sdk.oss-cn-beijing.aliyuncs.com/downloads/IMDemo/avatar/Image1.png";
 
[[AgoraChatClient sharedClient].userInfoManager updateOwnUserInfo:url withType:AgoraChatUserInfoTypeAvatarURL completion:^(AgoraChatUserInfo *aUserInfo, AgoraChatError *aError) {
        if (aUserInfo && completion) {
            completion(aUserInfo);
        }
    }];
```

### Retrieve user attributes

You can use `fetchUserInfoById` to retrieve the user attributes of the specified users. For each method call, you can retrieve the user attributes of a maximum of 100 users.

Refer to the following code example to retrieve all the attributes of the specified user:

```objective-c
[[AgoraChatClient sharedClient].userInfoManager fetchUserInfoById:@[AgoraChatClient.sharedClient.currentUsername] 		completion:^(NSDictionary *aUserDatas, AgoraChatError *aError) {               
}];
```

The following sample code shows how to retrieve the specified attributes of the user.

```objective-c
NSString *userIds = @[@"user1",@"user2"];
NSArray<NSNumber *> *userInfoTypes = @[@(AgoraChatUserInfoTypeAvatarURL),@(AgoraChatUserInfoTypePhone),@(AgoraChatUserInfoTypeMail)];
[[AgoraChatClient sharedClient].userInfoManager fetchUserInfoById:userIds type:userInfoTypes completion:^(NSDictionary *aUserDatas, AgoraChatError *aError) {
              
}];
```

## Next steps

This section introduces extra functions you can implement in your app using user attributes and contact management.

### Manage user avatar

The Agora Chat SDK only supports storing the URL address of the avatar file rather than the file itself. To manage user avatars, you need to use a third-party file storage service.

To implement user avatar management in your app, take the following steps:

1. Upload the avator file to the third-party file storage service. Once the file is successfully uploaded, you get a URL address of the avatar file.
2. Set the `avatarUrl` parameter in user attributes as the URL address of the avatar file.
3. To display the avatar, call `fetchUserInfoById` to retrieve the URL of the avatar file, and then render the image on the local UI.

### Create and send a namecard using user attributes

Namecard messages are custom messages that include the user ID, nickname, avator, email address, and phone number of the specified user. To create and send a namecard, take the following steps:

1. Create a custom message and set the `event` of the custom message as `userCard`.
2. Add `userId`, `nickname`, and `avator` as fileds in `ext`. Send the custom message.

Followings are the sample code for creating and sending a namecard message:

```objective-c
AgoraChatCustomMessageBody *body = [[AgoraChatCustomMessageBody alloc] init];
    body.event = @"userCard";
    NSDictionary *messageExt = @{@"userId":AgoraChatClient.sharedClient.currentUsername,
                          @"nickname":@"nickname",
                          @"avatar":@"https://download-sdk.oss-cn-beijing.aliyuncs.com/downloads/IMDemo/avatar/Image1.png"
                        };
    body.ext = messageExt;
    AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:@"conversationID"
                                                          from:@"sender"
                                                            to:@"receiver"
                                                          body:body
                                                           ext:nil];
    // send message
    [[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:^(AgoraChatMessage *message, AgoraChatError *error) {
    }];
```

## Reference

This section includes reference information that you may need to know during the implementation.

- For detailed information on user attributes, refer to the following API Reference:
  - [AgoraChatUserInfo](./API%20Reference/im_oc/interface_agora_chat_user_info.html)
  - [IAgoraChatUserInfoManager](./API%20Reference/im_oc/protocol_i_agora_chat_user_info_manager-p.html)
