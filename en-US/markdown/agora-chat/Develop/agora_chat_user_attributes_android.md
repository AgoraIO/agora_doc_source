After joining an Agora Chat channel, a user can update information such as the nickname, avatar, age, and mobile phone number as needed. These are known as user attributes.

This page shows how to use the Agora Chat SDK to implement managing user attributes.

<div class="alert note"><ul><li>User attributes are stored on the Agora Chat server. If you have security concerns, Agora recommends that you manage user attributes yourself.</li><li>To ensure information security, app users can only modify their own user attributes. Only app admins can modify the user attributes of other users.</li></ul></div>

## Understand the tech

The Agora Chat SDK uses `UserInfoManager` to retrieve, set, and modify user attributes. Followings are the core methods:
- `updateOwnInfo`: Set or update user attributes.
- `updateOwnInfoByAttributes`: Set or update the specified user attribute.
- `fetchUserInfoByUserId`: Retrieve the user attributes of the specified user.
- `fetchUserInfoByAttributes`: Retrieve the specified user attributes of the specified user.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_unity?platform=Unity).
- Have a thorough understanding of the API call frequency limit, the maximum size of all the attributes of a specified user, and the maximum size of all user attribtues in an app. For details, see [Known limitations](./agora_chat_limitation?platform=Unity).

## Implementation

This section shows how to manage user attributes and contacts with the methods provided by the Agora Chat SDK.

### Set user attributes

Chat users can set and update their own attributes. Refer to the code example to set all the user attributes:

```java
// Call updateOwnInfo to set all the user attributes
UserInfo userInfo = new UserInfo();
userInfo.setUserId(ChatClient.getInstance().getCurrentUser());
userInfo.setNickname("agora");
userInfo.setAvatarUrl("http://www.agora.io");
userInfo.setBirth("2000.10.10");
userInfo.setSignature("hello world");
userInfo.setPhoneNumber("13333333333");
userInfo.setEmail("123456@qq.com");
userInfo.setGender(1);
ChatClient.getInstance().userInfoManager().updateOwnInfo(userInfo, new ValueCallBack<String>() {
            @Override
            public void onSuccess(String value) {     
            }
  
            @Override
            public void onError(int error, String errorMsg) {
            }
  });
```

The following sample code uses avatar as an example to show how to set the specified user attribute:

```java
// Call updateOwnInfoByAttribute to update the specified attribute of the specified user
String url = "https://download-sdk.oss-cn-beijing.aliyuncs.com/downloads/IMDemo/avatar/Image1.png";
ChatClient.getInstance().userInfoManager().updateOwnInfoByAttribute(UserInfoType.AVATAR_URL, url, new ValueCallBack<String>() {
              @Override
              public void onSuccess(String value) {         
              }

              @Override
              public void onError(int error, String errorMsg) {    
              }
   });
```

### Retrieve user attributes

You can use `fetchUserInfoByUserId` to retrieve the user attributes of the specified users. For each method call, you can retrieve the user attributes of a maximum of 100 users.

Refer to the following code example:

```java
// Call fetchUserInfoByUserId to retrieve all the attributes of the specified user.
String[] userId = new String[1];
//username指的是用户id
userId[0] = username;
ChatClient.getInstance().userInfoManager().fetchUserInfoByUserId(userId, new ValueCallBack<Map<String, UserInfo>>() {});
```

```java
// Call fetchUserInfoByAttribute to retrieve the specified user attribute
String[] userId = new String[1];
userId[0] = ChatClient.getInstance().getCurrentUser();
UserInfoType[] userInfoTypes = new UserInfoType[2];
userInfoTypes[0] = UserInfoType.NICKNAME;
userInfoTypes[1] = UserInfoType.AVATAR_URL;
ChatClient.getInstance().userInfoManager().fetchUserInfoByAttribute(userId, userInfoTypes,
           new ValueCallBack<Map<String, UserInfo>>() {});
```

## Next steps

This section introduces extra functions you can implement in your app using user attributes and contact management.

### Manage user avatar

The Agora Chat SDK only supports storing the URL address of the avatar file rather than the file itself. To manage user avatars, you need to use a third-party file storage service.

To implement user avatar management in your app, take the following steps:

1. Upload the avator file to the third-party file storage service. Once the file is successfully uploaded, you get a URL address of the avatar file.
2. Set the `avatarUrl` parameter in user attributes as the URL address of the avatar file.
3. To display the avatar, call `fetchUserInfoByUserId` to retrieve the URL of the avatar file, and then render the image on the local UI.

### Create and send a namecard using user attributes

Namecard messages are custom messages that include the user ID, nickname, avator, email address, and phone number of the specified user. To create and send a namecard, take the following steps:

1. Create a custom message and set the `event` of the custom message as `USER_CARD_EVENT`.
2. Add `userId`, `getNickname`, and `getAvatarUrl` as fileds in `params`. Send the custom message.

Followings are the sample code for creating and sending a namecard message:

```java
// Creates a cutom message
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.CUSTOM);
                CustomMessageBody body = new CustomMessageBody(DemoConstant.USER_CARD_EVENT);
                Map<String,String> params = new HashMap<>();
                params.put(DemoConstant.USER_CARD_ID,userId);
                params.put(DemoConstant.USER_CARD_NICK,user.getNickname());
                params.put(DemoConstant.USER_CARD_AVATAR,user.getAvatarUrl());
                body.setParams(params);
                message.setBody(body);
                message.setTo(toUser);
// Sends the custom message
ChatClient.getInstance().chatManager().sendMessage(message);
```

## Reference

This section includes reference information that you may need to know during the implementation.

- For detailed information on user attributes, refer to the following API Reference:
  - [UserInfo](.A/API%20Reference/im_java/classio_1_1agora_1_1chat_1_1_user_info.html)
  - [UserInfoManager](./API%20Reference/im_java/classio_1_1agora_1_1chat_1_1_user_info_manager.html)
