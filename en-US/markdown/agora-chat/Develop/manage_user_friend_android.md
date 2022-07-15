After joining an Agora Chat channel, a user can update information such as the nickname, avatar, age, and mobile phone number as needed. To enjoy real-time chatting with friends, they can also add, delete, and manage contacts.

This page shows how to use the Agora Chat SDK to implement managing user attributes and contacts.

<div class="alert note"><ul><li>User attributes are stored on the Agora Chat server. If you have security concerns, Agora recommends that you manage user attributes yourself.</li><li></li>To ensure information security, app users can only modify their own user attributes. Only app admins can modify the user attributes of other users.</ul></div>


## Understand the tech

The following figure shows the workflow to manage user attribtues and contacts in your app:

![attributes_contact](https://web-cdn.agora.io/docs-files/1639032677528)

The Agora Chat SDK provides the following classes:
- [`UserInfoManager`]() sets and retrieves the various user attributes with a `UserInfo` struct.
- [`ContactManager`]() enables users to add or delete contacts, accept or decline contact invitations, and add other users to the block list.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- Have a project that has implemented [the basic real-time chat functionalities](agora_chat_get_started_android?platform=Android).
- Have a thorough understanding of the API call frequency limit, the maximum size of all the attributes of a specified user, and the maximum size of all user attribtues in an app. For details, see [Known limitations](./agora_chat_limitation_android?platform=Android).

## Implement managing user attributes and contacts

This section shows how to manage user attributes and contacts with the methods provided by the Agora Chat SDK.

### Set, retrieve, and update user attributes

The Agora Chat SDK uses the `UserInfoManager` class to manage user attributes. Chat users can set and update their own attributes. They can also retrieve the user attributes of other users.

Refer to the code snippets below to see how to set, retrieve, and update user attributes:

```java
// Instantiate a UserInfo object
UserInfo userInfo = new UserInfo();

// Call the corresponding method to set the user ID, nickname, avatar...
userInfo.setUserId(AgoraChatClient.getInstance().getCurrentUser());
userInfo.setNickname("jian");
userInfo.setAvatarUrl("url");
userInfo.setBirth("2000.10.10");
userInfo.setSignature("Add you signature");
userInfo.setPhoneNumber("1343444");
userInfo.setEmail("9892029@qq.com");
userInfo.setGender(1);

// Call updateOwnInfo to set all user attributes
ChatClient.getInstance().userInfoManager().updateOwnInfo(userInfo, new ValueCallBack<String>() {
    @Override
    // Occurs when the method call succeeds
    public void onSuccess(String value) {     
    }
    @Override
    // Occurs when the method call fails
    public void onError(int error, String errorMsg) {
    }
});

// Retrieve user attributes by specifying the user ID
String[] userId = new String[1];
userId[0] = username;
// Call fetchUserInfoByUserId to retrieve user attributes
ChatClient.getInstance().userInfoManager().fetchUserInfoByUserId(userId, new ValueCallBack<Map<String, UserInfo>>() {}

// Update the avatar by specifying the image URL
String url = "https://download-sdk.oss-cn-beijing.aliyuncs.com/downloads/IMDemo/avatar/Image1.png";
// Call updateOwnInfoByAttribute to update the specified attribute
ChatClient.getInstance().userInfoManager().updateOwnInfoByAttribute(UserInfoType.AVATAR_URL, url, new ValueCallBack<String>() {
    @Override
    public void onSuccess(String value) {
                        
    }

    @Override
    public void onError(int error, String errorMsg) {    
    }
});
```

### Manage contacts

In a real-time chat, users can add or remove contacts, accept or decline a contact invitation, and add other users to a block list. The Agora Chat SDK uses a `ContactManager` class to enable these functionalities in your app. Refer to the following sample code to see how to implement contact management:

```java
// Call addContact to send a contact invitation
ChatClient.getInstance().contactManager().addContact(toAddUsername, reason);

// Call setContactListener to listen for contact invitation events
AgoraChatClient.getInstance().contactManager().setContactListener(new ContactListener() {
    // Occurs when the contact invitation is accepted
    @Override
    public void onFriendRequestAccepted(String username) {}

    // Occurs when the contact invitation is delined
    @Overview
    public void onFriendRequestDeclined(String username) {}

    // Occurs when you receive a contact invitation
    @Override
    public void onContactInvited(String username, String reason) {
        // Call acceptInvitation to accept the contact invitation. To decline the invitation, call declineInvitation
        ChatClient.getInstance().contactManager().acceptInvitation(username);
    }

    // Occurs when a contact is deleted
    @Override
    public void onContactDeleted(String username) { }
   
    // Occurs when a contact is added
    @Override
    public void onContactAdded(String username) { }
})

// To get the contact list, you need to call getAllContactsFromServer to retrieve the contact list from server first
List<String> usernames = ChatClient.getInstance().contactManager().getAllContactsFromServer();
// Call getContactsFromLocal to retrieve the contact list from the local database
List<String> usernames = ChatClient.getInstance().contactManager().getContactsFromLocal

// Call deleteContact to delete a contact
ChatClient.getInstance().contactManager().deleteContact(username);
```

You can also add a specified user to your block list. Once you do that, you can still send chat messages to that user, but you cannot receive messages from them. The following code shows how to add a user into a block list.

<div class="note alert">Users can add any other chat user to their block list, regardless of whether this other user is a contact or not. A contact added to the block list remains in the contact list.</div>

```java
// Call addUserToBlacklist to add a user, whehter your contact or not, to your block list
ChatClient.getInstance().contactManager().addUserToBlackList(username,true);

// To retrieve the block list, you need to call getBlackListFromServer to retrieve the block list from the server first
ChatClient.getInstance().contactManager().getBlackListFromServer();
// Call getBlackListUsernames to retrieve the usernames from the local database
ChatClient.getInstance().contactManager().getBlackListUsernames();

// To remove a user from the block list, call removeUserFromBlackList
ChatClient.getInstance().contactManager().removeUserFromBlackList(username);
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

1. Set the messsage type as custom.
2. Set the `event` of the custom message as `USER_CARD_EVENT`.
3. Retrieve the values of the `userId`, `nickname`, and `avatarurl` of the user attributes and set them as the the cutom message body.

Followings are the sample code for creating and sending a namecard message:

```java
ChatMessage message = ChatMessage.createSendMessage(AgoraChatMessage.Type.CUSTOM);
    CustomMessageBody body = new CustomMessageBody(DemoConstant.USER_CARD_EVENT);
    Map<String,String> params = new HashMap<>();
    params.put(DemoConstant.USER_CARD_ID,userId);
    params.put(DemoConstant.USER_CARD_NICK,user.getNickName());
    params.put(DemoConstant.USER_CARD_AVATAR,user.getAvatarUrl());
    // Get more information according to your needs

    body.setParams(params);
    message.getBody(body);
    message.setTo(toUser);
ChatClient.getInstance().chatManager().sendMessage(message);
```

## Reference

This section includes reference information that you may need to know during the implementation.

- Agora provides an open source [sample project]() on GitHub for your reference.
- For detailed information on user attributes, refer to the following API Reference:
  - [UserInfo]()
  - [UserInfoManager]()
  - [ContactManager]()