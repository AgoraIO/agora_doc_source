After joining an Agora Chat channel, a user can update information such as the nickname, avatar, age, and mobile phone number as needed. These are known as user attributes.

This page shows how to use the Agora Chat SDK to implement managing user attributes.

<div class="alert note"><ul><li>User attributes are stored on the Agora Chat server. If you have security concerns, Agora recommends that you manage user attributes yourself.</li><li>To ensure information security, app users can only modify their own user attributes. Only app admins can modify the user attributes of other users.</li></ul></div>

## Understand the tech

The Agora Chat SDK uses `UserInfoManager` to retrieve, set, and modify user attributes. Followings are the core methods:
- `updateOwnUserInfo`: Set or update user attributes.
- `fetchUserInfoById`: Retrieve the user attributes of the specified user.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_web?platform=Web).
- Have a thorough understanding of the API call frequency limit, the maximum size of all the attributes of a specified user, and the maximum size of all user attribtues in an app. For details, see [Known limitations](./agora_chat_limitation?platform=Web).

## Implementation

This section shows how to manage user attributes and contacts with the methods provided by the Agora Chat SDK.

### Set user attributes

Chat users can set and update their own attributes. Refer to the code example to set all the user attributes:

```javascript
// Sets all user attributes
let options = {
    nickname: 'The nickname',
    avatarurl: 'http://avatarurl',
    mail: '123@qq.com',
    phone: '16888888888',
    gender: 'female',
    birth: '2000-01-01',
    sign: 'a sign',
    ext: JSON.stringify({
          nationality: 'China',
          merit: 'Hello, world！'
        })
}
WebIM.conn.updateOwnUserInfo(options).then((res) => {
    console.log(res)
})      
```

The following sample code uses nickname as an example to show how to set the specified user attribute:

```javascript
WebIM.conn.updateOwnUserInfo('nickname', 'Your nickname').then((res) => {
    console.log(res)
})
```

### Retrieve user attributes

You can use `fetchUserInfoById` to retrieve the user attributes of the specified users. For each method call, you can retrieve the user attributes of a maximum of 100 users.

Refer to the following code example to retrieve all the attributes of the specified user:

```javascript
/**
 * @param {String|Array} users - The user ID. You can set it as one user ID, or multiple user IDs in the format of array.
 */
let users = 'user1' || ['user1', 'user2']
WebIM.conn.fetchUserInfoById(users).then((res) => {
    console.log(res)
})
```

The following sample code shows how to retrieve the specified attributes of the user.

```javascript
/**
 * @param {String|Array} users - The user ID. You can set it as one user ID, or multiple user IDs in the format of array.
 * @param {String|Array} properties - The specified attribute.
 */
WebIM.conn.fetchUserInfoById('userId', 'nickname').then((res) => {
    console.log(res)
})

// Retrieves the specified attributes of the specified users.
WebIM.conn.fetchUserInfoById(['user1', 'user2'], ['nickname', 'avatarurl']).then((res) => {
    console.log(res)
})
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

1. Set the messsage type as `custom`.
2. Set the `customEvent` of the custom message as `userCard`.
3. Retrieve the values of `nickname`, `mail`, and `avatarurl` from the user attributes, and then set them as the the extension of the custom message using `customExts`.

Followings are the sample code for creating and sending a namecard message:

```javascript
// The unique ID of the message.
let id = conn.getUniqueId();
// Create a custom message.
let msg = new WebIM.message("custom", id);
// Set custom event type as userCard
let customEvent = "userCard";
// Set these attributes as the extension of the custom message using customExts. 
let customExts = {
    nickname: "昵称",
    avatarurl: "http://avatarurl",
    mail: "123@qq.com",
    phone: "16888888888",
    gender: "female",
    birth: "2000-01-01",
    sign: "a sign",
};
let options = {
    // Set the message type.
    type: "custom",
    // Set the message recipient.
    to: "username",
    // Set the message event.
    customEvent,
    // Set the message content
    customExts,
    chatType: "singleChat"
}
// Create a custom message.
let msg = WebIM.message.create(options);
WebIM.conn.send(msg).then((res)=>{
    console.log('Success')
}).catch((e)=>{
    console.log('error')
});
```

## Reference

This section includes reference information that you may need to know during the implementation.

- For detailed information on user attributes, refer to the following API Reference:
  - [AgoraChatUserInfo](./API%20Reference/im_oc/interface_agora_chat_user_info.html)
  - [fetchUserInfoById](./API%20Reference/im_ts/modules/Contact.html)
