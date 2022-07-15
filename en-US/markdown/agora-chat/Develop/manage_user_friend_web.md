After joining an Agora Chat channel, a user can update information such as their nickname, avatar, age, and mobile phone number as needed. To enjoy real-time chatting with friends, they can also add, delete, and manage contacts.

This page shows how to use the Agora Chat SDK to implement managing user attributes and contacts.

<div class="alert note"><ul><li>User attributes are stored on the Agora Chat server. If you have security concerns, Agora recommends that you manage user attributes yourself.</li><li>To ensure information security, app users can only modify their own user attributes. Only app admins can modify the user attributes of other users.</li></ul></div>


## Understand the tech

The Agora Chat SDK provides the following methods in the `Connection` class for implementing user attributes and contacts:
- `updateOwnUserInfo` sets the user attributes, including the user ID, nickname, avatar, signature, phone number, email address, and gender.
- `fetchUserInfoById` retrieves the various attributes.
- `ContactManager` enables users to add or delete contacts, accept or decline contact invitations, and add other users to a block list.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK, and implemented the functionality of users logging in. For details, see [Get Started with Agora Chat](agora_chat_get_started_web?platform=Web).
- You understand the [API call frequency limits](./agora_chat_limitation_web?platform=Web).

## Implement managing user attributes and contacts

This section shows how to manage user attributes and contacts with the methods provided by the Agora Chat SDK.

### Set, retrieve, and update user attributes

The Agora Chat SDK uses the `updateOwnUserInfo` and `fetchUserInfoById` methods to manage user attributes. Chat users can set and update their own attributes. They can also retrieve the user attributes of other users.

Refer to the code snippets below to see how to set, retrieve, and update user attributes:

```javascript
// Set or update all the user attributes of the specified user.
let options = {
    nickname: "<The nickname>",
    avatarurl: "http://avatarurl",
    mail: "123@qq.com",
    phone: "16888888888",
    gender: "female",
    birth: "2000-01-01",
    sign: "a sign",
    ext: JSON.stringify({
        nationality: "China",
        merit: "Hello, world！",
    }),
};
// Call updateOwnUserInfo to set or update the user attributes.
WebIM.conn.updateOwnUserInfo(options).then(res => {
    console.log(res);

// Any chat user can retrieve all the user attributes of the specified user(s). 
// For each method call, you can retrieve the user attributes of a maximum number of 100 users.
let users = "user1" || ["user1", "user2"];
WebIM.conn.fetchUserInfoById(users).then(res => {
    console.log(res);
});

// Update the specified user attribute of the current user, for example, the nickname.
WebIM.conn.updateOwnUserInfo("nickname", "<The nickname>").then(res => {
    console.log(res);
});
});
```

### Manage contacts

In a real-time chat, users can add or remove contacts, accept or decline a contact invitation, and add other users to a block list. The Agora Chat SDK uses a `ContactManager` class to enable these functionalities in your app. Refer to the following sample code to see how to implement contact management:

```javascript
// Call addContact to send a contact invitation
let message = "Hello";
WebIM.conn.addContact("username", message);

// Call addEventHandler to listen for contact invitation events
connection.addEventHandler('CONTACT', {
    // Occurs when the contact invitation is received.
    onContactInvited: function(msg){
        // Call acceptContactInvite to accept the contact invitation. `username` indicates the username of the contact.
        WebIM.conn.acceptContactInvite("username");
        // To decline the contact invitation, call declineContactInvite.
        WebIM.conn.declineContactInvite("username");
    }
    // Occurs when the contact is deleted.
    onContactDeleted: function(msg){}
    // Occurs when the contact is added.
    onContactAdded: function(msg){}
    // Occurs when the contact invitation is declined.
    onContactRefuse: function(msg){}
    // Occurs when the contact invitation is accepted.
    onContactAgreed: function(msg){}
})

// Call getRoster to retrieve the contact list
WebIM.conn.getRoster().then( (res) => {
    console.log(res) // res.data > ['user1', 'user2']
}

// Call deleteContact to delete the specified contact
WebIM.conn.deleteContact("username");
```

You can also add a specified user to your block list. Once you do that, you can still send chat messages to that user, but you cannot receive messages from them. The following code shows how to add a user to the block list.

<div class="note alert">Users can add any other chat user to their block list, regardless of whether this other user is a contact or not. A contact added to the block list remains in the contact list.</div>

```javascript
// Call addUsersToBlocklist to add user1 and user2 to the block list.
WebIM.conn.addUsersToBlocklist({
    name: ["user1", "user2"],
});

// Call getBlocklist to retrieve the block list from the server.
WebIM.conn.getBlocklist();

// Call removeUserFromBlockList to remove user1 and user2 from the block list.
WebIM.conn.removeUserFromBlockList({
    name: ["user1", "user2"],
});
```

## Next steps

This section introduces extra functions you can implement in your app using user attributes and contact management.

### Manage user avatar

The Agora Chat SDK only supports storing the URL address of the avatar file rather than the file itself. To manage user avatars, you need to use a third-party file storage service.

To implement user avatar management in your app, take the following steps:

1. Upload the avatar file to the third-party file storage service. Once the file is successfully uploaded, you get a URL address of the avatar file.
2. Set the `avatarUrl` parameter in user attributes as the URL address of the avatar file.
3. To display the avatar, call `fetchUserInfoByUserId` to retrieve the URL of the avatar file, and then render the image on the local UI.

### Create and send a namecard using user attributes

Namecard messages are custom messages that include the user ID, nickname, avatar, email address, and phone number of the specified user. To create and send a namecard, take the following steps:

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

- Agora provides an open source [sample project]() on GitHub for your reference.
- For detailed information on user attributes, refer to the following API References:
  - [updateOwnUserInfo]()
  - [fetchUserInfoById]()
  - [ContactManager]()