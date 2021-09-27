# Manage User Attributes

User attributes refer to the information specific to a user, including the nickname, avatar, age, mobile phone number, and so on. Managing user attributes in a real-time chat session enables you to set and retrieve the information of a specified user or the specified users.

This page shows how to implement managing user attributes in your app by using the Agora Chat SDK.

> To manage user attributes, you need to store the user information in the Agora Chat server. If you are not comfortable with this, we recommend you managing user attributes yourself. 

## Understand the tech

### Android/iOS

The Agora Chat SDK uses a `UserInfo` class to set the various attributes of a specified user, including the user ID, nickname, avatar, signature, phone number, Email address, and gender.

To update the user attributes, you can use the `UserInfoManager` class, which enables you to retrieve and update the user attributes of a specified user, or a particular user attribute of many specified users.

### Web

The Agora Chat SDK enables you to set, retrieve, and update the user attributes, including the user ID, nickname, avatar, signature, phone number, Email address, and gender, with the following two APIs:

- `updateOwnUserInfo`: Set and update the user attributes.
- `fetchUserInfoById`: Retrieve the specified user attributes.


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- Have a project that has implemented [the basic real-time chat functionalities]().
- Have a thorough understanding of the API call frequency limit, the maximum size of all the attributes of a specified user, and the maximum size of all user attributes in an app. For details, see [Known limitations]().

## Implement managing user attributes

This section shows how to set, retrieve, and update user attributes with the methods provided by the Agora Chat SDK.

### Set all attributes of a specified user

The following sample code shows how to set all the attributes of a specified user:

```java
// Java
EMUserInfo userInfo = new EMUserInfo();
userInfo.setUserId(EMClient.getInstance().getCurrentUser());
userInfo.setNickName("jian");
userInfo.setAvatarUrl("url");
userInfo.setBirth("2000.10.10");
userInfo.setSignature("坚持就是胜利");
userInfo.setPhoneNumber("1343444");
userInfo.setEmail("9892029@qq.com");
userInfo.setGender(1);
EMClient.getInstance().userInfoManager().updateOwnInfo(userInfo, new EMValueCallBack<String>() {
            @Override
            public void onSuccess(String value) {     
            }
            @Override
            public void onError(int error, String errorMsg) {
            }
    });
```

```objective-c
// Objective-C
AgoraUserInfo *userInfo = [[AgoraUserInfo alloc] init];
userInfo.userId = AgoraChatClient.sharedClient.currentUsername;
userInfo.nickName = @"jian";
userInfo.avatarUrl = @"url";
userInfo.birth = @"2000.10.10";
userInfo.sign = @"坚持就是胜利";
userInfo.phone = @"13434449999";
userInfo.mail = @"9892029@qq.com";
userInfo.gender = 1;
[AgoraChatClient.sharedClient.userInfoManager updateOwnUserInfo:userInfo completion:^(AgoraUserInfo *aUserInfo, AgoraError *aError)      

}];
```

```javascript
// Javascript
let options = {
    nickname: '昵称',
    avatarurl: 'http://avatarurl',
    mail: '123@qq.com',
    phone: '16888888888',
    gender: 'female',
    birth: '2000-01-01',
    sign: 'a sign',
    ext: JSON.stringify({
          nationality: 'China',
          merit: 'Hello，世界！'
        })
}
WebIM.conn.updateOwnUserInfo(options).then((res) => {
    console.log(res)
})
```

### Update the specified user attribute

During a real-time chat session, the user can also change their own user information. The following sample code shows how a user updates the avator:

```java
// Java
String url = "https://download-sdk.oss-cn-beijing.aliyuncs.com/downloads/IMDemo/avatar/Image1.png";
 EMClient.getInstance().userInfoManager().updateOwnInfoByAttribute(EMUserInfoType.AVATAR_URL, url, new EMValueCallBack<String>() {
              @Override
              public void onSuccess(String value) {
                        
              }

              @Override
              public void onError(int error, String errorMsg) {    
              }
   });
```

```objective-c
// Objective-C
NSString *url = @"https://download-sdk.oss-cn-beijing.aliyuncs.com/downloads/IMDemo/avatar/Image1.png";
 
[[AgoraChatClient sharedClient].userInfoManager updateOwnUserInfo:url withType:AgoraUserInfoTypeAvatarURL completion:^(AgoraUserInfo *aUserInfo, AgoraError *aError) {
        if (aUserInfo && completion) {
            completion(aUserInfo);
        }
    }];
```

```javascript
// Javascript
WebIM.conn.updateOwnUserInfo('nickname', '昵称').then((res) => {
    console.log(res)
})
```


### Retrieve user attributes

You can retrieve all user attributes speicyfing the user ID. See the following sample code:

```java
// Java
String[] userId = new String[1];
userId[0] = username;
EMClient.getInstance().userInfoManager().fetchUserInfoByUserId(userId, new EMValueCallBack<Map<String, EMUserInfo>>() {}
```

```objective-c
// Objective-C
[[AgoraChatClient sharedClient].userInfoManager fetchUserInfoById:@[AgoraChatClient.sharedClient.currentUsername] 		completion:^(NSDictionary *aUserDatas, AgoraError *aError) {               
 }];
```

```javascript
// Javascript
let users = 'user1' || ['user1', 'user2']
WebIM.conn.fetchUserInfoById(users).then((res) => {
    console.log(res)
})
```

### Retrieve multiple user attributes

Refer to the following code to see how to retrieve multiple user attributes:

```java
// Java
String[] userId = new String[1];
userId[0] = EMClient.getInstance().getCurrentUser();
EMUserInfoType[] userInfoTypes = new EMUserInfoType[2];
// Retrieve the nickname of the local user
userInfoTypes[0] = EMUserInfoType.NICKNAME;
// Retrieve the avatar url of the local user
userInfoTypes[1] = EMUserInfoType.AVATAR_URL;
EMClient.getInstance().userInfoManager().fetchUserInfoByAttribute(userId, userInfoTypes,
           new EMValueCallBack<Map<String, EMUserInfo>>() {}
```

```objective-c
// Objective-C
// Retrieve the user attributes of both user1 and user2
NSString *userIds = @[@"user1",@"user2"];
// Retrieve the avatar, phone number, and mail address of the specified users
NSArray<NSNumber *> *userInfoTypes = @[@(AgoraUserInfoTypeAvatarURL),@(AgoraUserInfoTypePhone),@(AgoraUserInfoTypeMail)];
[[AgoraChatClient sharedClient].userInfoManager fetchUserInfoById:userIds type:userInfoTypes completion:^(NSDictionary *aUserDatas, AgoraError *aError) {
              
}];
```

```javascript
// Javascript
// Retrieve the nickname of the specified user
WebIM.conn.fetchUserInfoById('userId', 'nickname').then((res) => {
    console.log(res)
})

// Retrieve the nickname and avatarurl of both user1 and user2
WebIM.conn.fetchUserInfoById(['user1', 'user2'], ['nickname', 'avatarurl']).then((res) => {
    console.log(res)
})
```

## Next steps

This section introduces extra functions you can implement in your project using user attributes.

### Manage user avatar

The Agora Chat SDK only supports storing the URL address of the avatar file, but not the file itself. To manage user avatar, you need to use a third-party file storage service.

To implement user avatar management in your project, take the following steps:

1. Upload the avator file to the third-party file storage service.
   Once the file is successfully uploaded, you get a URL address of the avatar file.
2. Set the `AvatarUrl` parameter in user attributes as the URL address of the avatar file.
3. To display the avatar, call `fetchUserInfoByUserId` to retrieve the URL of the avatar file and then render the image on the local UI.


### Create and send a namecard using user attributes

Namecard messages are custome messages that include the ID, nickname, avator, Email address, and phone number of the specified user. To create and send a namecard, take the following steps:

1. Set the messsage type as custom.
2. Set the `event` of the custom message as "user card".
3. Retrieve the value of the `userId`, `nickname`, and `avatarurl` of the user attributes and set them as the the cutom message body.

Followings are the sample code for creating and sending a namecard message:

```java
// Java
EMMessage message = EMMessage.createSendMessage(EMMessage.Type.CUSTOM);
                EMCustomMessageBody body = new EMCustomMessageBody(DemoConstant.USER_CARD_EVENT);
                Map<String,String> params = new HashMap<>();
                params.put(DemoConstant.USER_CARD_ID,userId);
                params.put(DemoConstant.USER_CARD_NICK,user.getNickName());
                params.put(DemoConstant.USER_CARD_AVATAT,user.getAvatar());
                // Get more information according to your needs

                body.setParams(params);
                message.setBody(body);
                message.setTp(toUser);
EMClient.getInstance().chatManager().sendMessage(message);
```

```objective-c
// Objective-C
CustomMessageBody *body = [[CustomMessageBody alloc] init];
    body.event = @"userCard";
    NSDictionary *messageExt = @{@"userId":AgoraChatClient.sharedClient.currentUsername,
                          @"nickname":@"nickname",
                          @"avatar":@"https://download-sdk.oss-cn-beijing.aliyuncs.com/downloads/IMDemo/avatar/Image1.png"
                          // Get more information according to your needs
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

```javascript
// Javascript
let id = conn.getUniqueId();             
let msg = new WebIM.message('custom', id); 
let customEvent = "userCard";
let customExts = {
  nickname: '昵称',
  avatarurl: 'http://avatarurl',
  mail: '123@qq.com',
  phone: '16888888888',
  gender: 'female',
  birth: '2000-01-01',
  sign: 'a sign',
  // Get more information according to your needs
};
msg.set({
  to: 'username',
  customEvent,
  customExts,
  ext: {},
  chatType: 'singleChat', 
  success: function (id, serverMsgId) {},
  fail: function(e){}
});
WebIM.conn.send(msg.body);
```

## Reference

This section includes reference information that you may need to know during the implementation.

- Agora provides an open source [sample project]() on GitHub for your reference.
- For detailed information on user attributes, refer to the following API Reference:
  - [UserInfo]()
  - [UserInfoManager]()
  - [updateOwnUserInfo]()
  - [fetchUserInfoById]()



