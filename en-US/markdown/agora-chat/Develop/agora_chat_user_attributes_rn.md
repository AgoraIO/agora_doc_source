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

- Have a project that has implemented [the basic real-time chat functionalities](./agora_chat_get_started_rn?platform=React%20Native).
- Have a thorough understanding of the API call frequency limit, the maximum size of all the attributes of a specified user, and the maximum size of all user attribtues in an app. For details, see [Known limitations](./agora_chat_limitation?platform=React%20Native).

## Implementation

This section shows how to manage user attributes and contacts with the methods provided by the Agora Chat SDK.

### Set user attributes

Chat users can set and update their own attributes. Refer to the code example to set user attributes:

```typescript
// Update the user attributes.
// All the user attributes except user ID can be updated.
// You can update one or more attribtues with each method call.
ChatClient.getInstance()
  .userManager.updateOwnUserInfo({
    nickName,
    avatarUrl,
    mail,
    phone,
    gender,
    sign,
    birth,
    ext,
  })
  .then(() => {
    console.log("update userInfo success.");
  })
  .catch((reason) => {
    console.log("update userInfo fail.", reason);
  });
```

### Retrieve user attributes

You can use `fetchUserInfoById` to retrieve the user attributes of the specified users. For each method call, you can retrieve the user attributes of a maximum of 100 users.

Refer to the following code example:

```typescript
// Specify one or more user IDs.
const userIds = ["tom", "json"];
// Call fetchUserInfoById
ChatClient.getInstance()
  .userManager.fetchUserInfoById(userIds)
  .then((users) => {
    console.log("get userInfo success.", users);
  })
  .catch((reason) => {
    console.log("get userInfo fail.", reason);
  });
```

### Retrieve the user's own attributes

Call `fetchOwnInfo` to fetch the user attributes of the local user:

```typescript
ChatClient.getInstance()
  .userManager.fetchOwnInfo()
  .then((users) => {
    console.log("get userInfo success.", users);
  })
  .catch((reason) => {
    console.log("get userInfo fail.", reason);
  });
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
2. Add `userId`, `nickname`, and `avatarUrl` as fileds in `ext`. Send the custom message.

Followings are the sample code for creating and sending a namecard message:

```typescript
// Customize the message.
const event = "userCard";
// You can also add more fields in ext
const ext = { userId: "userId", nickname: "nickname", avatarUrl: "avatarUrl" };
const msg = ChatMessage.createCustomMessage(targetId, event, chatType, {
  params: JSON.parse(ext),
});
// Call sendMessage to send the customized message.
ChatClient.getInstance()
  .chatManager.sendMessage(msg!, new ChatMessageCallback())
  .then(() => {
    console.log("send message success.");
  })
  .catch((reason) => {
    console.log("send message fail.", reason);
  });
```
