After joining an Agora Chat channel, a user can update information such as the nickname, avatar, age, and mobile phone number as needed. These are known as user attributes.

This page shows how to use the Agora Chat SDK to implement managing user attributes.

<div class="alert note"><ul><li>User attributes are stored on the Agora Chat server. If you have security concerns, Agora recommends that you manage user attributes yourself.</li><li>To ensure information security, app users can only modify their own user attributes. Only app admins can modify the user attributes of other users.</li></ul></div>

## Understand the tech

The Agora Chat SDK uses `IUserInfoManager` to retrieve, set, and modify user attributes. Followings are the core methods:
- `UpdateOwnInfo`: Set and update user attributes.
- `FetchUserInfoByUserId`: Retrieve the user attributes of the specified user.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_unity?platform=Unity).
- Have a thorough understanding of the API call frequency limit, the maximum size of all the attributes of a specified user, and the maximum size of all user attribtues in an app. For details, see [Known limitations](./agora_chat_limitation?platform=Unity).

## Implementation

This section shows how to manage user attributes and contacts with the methods provided by the Agora Chat SDK.

### Set user attributes

Chat users can set and update their own attributes. Refer to the code example to set user attributes:

```C#
// Set the user attributes of the specified user.
UserInfo userInfo;
userInfo.userId = currentId;
userInfo.nickName = "chatuser";
userInfo.avatarUrl = "http://www.easemob.com";
userInfo.birth = "2000.10.10";
userInfo.signature = "hello world";
userInfo.phoneNumber = "13333333333";
userInfo.email = "123456@qq.com";
userInfo.gender = 1; // 1 indicates that the gender is male. 2 means female.
SDKClient.Instance.UserInfoManager.UpdateOwnInfo(userInfo, new CallBack(
  onSuccess: () => {
  },
  onError:(code, desc) => {
  }            
));
```

### Retrieve user attributes

You can use `FetchUserInfoByUserId` to retrieve the user attributes of the specified users. For each method call, you can retrieve the user attributes of a maximum of 100 users.

Refer to the following code example:

```C#
// Retrieve user attributes of one or multiple users.
List<string> idList = new List<string>();
idList.Add("usename");
SDKClient.Instance.UserInfoManager.FetchUserInfoByUserId
SDKClient.Instance.UserInfoManager.FetchUserInfoByUserId(idList, type, startId, loadCount, new ValueCallBack<Dictionary<string, UserInfo>>(
  // `result` is in the format of Dictionary<string, UserInfo>
  onSuccess: (result) => {
	// Traverse all the user attributes in the dictionary
  },
  onError:(code, desc) => {
  }
));
```


## Next steps

This section introduces extra functions you can implement in your app using user attributes and contact management.

### Manage user avatar

The Agora Chat SDK only supports storing the URL address of the avatar file rather than the file itself. To manage user avatars, you need to use a third-party file storage service.

To implement user avatar management in your app, take the following steps:

1. Upload the avator file to the third-party file storage service. Once the file is successfully uploaded, you get a URL address of the avatar file.
2. Set the `avatarUrl` parameter in user attributes as the URL address of the avatar file.
3. To display the avatar, call `FetchUserInfoByUserId` to retrieve the URL of the avatar file, and then render the image on the local UI.

### Create and send a namecard using user attributes

Namecard messages are custom messages that include the user ID, nickname, avator, email address, and phone number of the specified user. To create and send a namecard, take the following steps:

1. Create a custom message and set the `event` of the custom message as `userCard`.
2. Add `userID`, `nickname`, and `avatarUrl` as fileds in `ext`. Send the custom message.

Followings are the sample code for creating and sending a namecard message:

```C#
string event = "userCard";
Dictionary<string, string> adict = new Dictionary<string, string>();
adict.Add("userId", userInfo.userId);
adict.Add("nickname", userInfo. nickname);
adict.Add("avatarUrl", userInfo.avatarUrl);
// You can add more fields.

// Create a custom message.
Message msg = Message.CreateCustomSendMessage(toChatUsername, event, adict);

// Send the message.
SDKClient.Instance.ChatManager.SendMessage(ref msg, new CallBack(
   onSuccess: () => {
      Debug.Log($"{msg.MsgId}发送成功");
   },
   onError: (code, desc) => {
      Debug.Log($"{msg.MsgId}发送失败，errCode={code}, errDesc={desc}");
   }
));
```