After joining an Agora Chat channel, a user can update information such as the nickname, avatar, age, and mobile phone number as needed. These are known as user attributes.

This page shows how to use the Agora Chat SDK to implement managing user attributes.

<div class="alert note"><ul><li>User attributes are stored on the Agora Chat server. If you have security concerns, Agora recommends that you manage user attributes yourself.</li><li>To ensure information security, app users can only modify their own user attributes. Only app admins can modify the user attributes of other users.</li></ul></div>

## Understand the tech

The Agora Chat SDK uses `ChatUserInfoManager` to retrieve, set, and modify user attributes. Followings are the core methods:
- `updateOwnInfo`: Set and update user attributes.
- `fetchUserInfoById`: Retrieve the user attributes of the specified user.
- `fetchOwnInfo`: Retrieve the user's own user attributes.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- Have a project that has implemented [the basic real-time chat functionalities](./agora_chat_get_started_flutter?platform=Flutter).
- Have a thorough understanding of the API call frequency limit, the maximum size of all the attributes of a specified user, and the maximum size of all user attribtues in an app. For details, see [Known limitations](./agora_chat_limitation?platform=Flutter).

## Implementation

This section shows how to manage user attributes and contacts with the methods provided by the Agora Chat SDK.

### Set user attributes

Chat users can set and update their own attributes. Refer to the code example to set user attributes:

```dart
try {
  ChatClient.getInstance.userInfoManager.updateUserInfo(userInfo);
} on ChatError catch (e) {
  // Fails to update user attributes. See e.code for the error code, and e.description for the error description.
}
```



### Retrieve user attributes

You can use `fetchUserInfoById` to retrieve the user attributes of the specified users. For each method call, you can retrieve the user attributes of a maximum of 100 users.

Refer to the following code example:

```dart
List<String> list = ["tom", "json"];
try {
  Map<String, ChatUserInfo> userInfos =
      await ChatClient.getInstance.userInfoManager.fetchUserInfoById(list);
} on ChatError catch (e) {
  // Fails to retrive the user attributes. See e.code for the error code, and e.description for the error description.
}
```


### Retrieve the user's own attributes

Call `fetchOwnInfo` to fetch the user attributes of the local user:

```dart
try {
  ChatUserInfo? userInfo =
      await ChatClient.getInstance.userInfoManager.fetchOwnInfo();
} on ChatError catch (e) {
  // Fails to retrieve the user attributes of the current user. See e.code for the error code, and e.description for the error description.
}
```

## Next steps

This section introduces extra functions you can implement in your app using user attributes and contact management.

### Manage user avatar

The Agora Chat SDK only supports storing the URL address of the avatar file rather than the file itself. To manage user avatars, you need to use a third-party file storage service.

To implement user avatar management in your app, take the following steps:

1. Upload the avator file to the third-party file storage service. Once the file is successfully uploaded, you get a URL address of the avatar file.
2. Set the `avatarUrl` parameter in user attributes as the URL address of the avatar file.
3. To display the avatar, call `fetchUserInfoById` to retrieve the URL of the avatar file, and then render the image on the local UI.
