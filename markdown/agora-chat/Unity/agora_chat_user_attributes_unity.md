用户属性指实时消息互动用户的信息，如用户昵称、头像、邮箱、电话、性别、签名、生日等。

例如，在招聘场景下，利用用户属性功能可以存储性别、邮箱、用户类型（面试者）、职位类型（web 研发）等。查看用户信息时，可以直接查询服务器存储的用户属性信息。

本文介绍如何通过管理用户属性设置、更新、存储并获取实时消息用户的相关信息。

为保证用户信息安全，SDK 仅支持用户设置或更新自己的用户属性。

## 技术原理

即时通讯 IM Unity SDK 提供一个 `IUserInfoManager` 类，支持获取、设置及修改用户属性信息，其中包含如下方法：

- `UpdateOwnInfo` 设置和修改当前用户自己的属性信息；
- `FetchUserInfoByUserId` 获取指定用户的所有用户属性信息；

## 前提条件

设置用户属性前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_unity)。
- 了解 [使用限制](./agora_chat_limitation)。

## 实现方法

本节介绍如何在项目中设置及获取用户属性。

实现过程中注意单个用户的所有属性最大不超过 2 KB，单个 app 所有用户属性数据最大不超过 10 GB。

### 设置当前用户的属性

参考如下示例代码，在你的项目中当前用户设置自己的所有属性或者仅设置某一项属性。

```C#
//设置所有用户属性。
UserInfo userInfo;
userInfo.userId = currentId;
userInfo.nickName = "chatuser";
userInfo.avatarUrl = "http://www.easemob.com";
userInfo.birth = "2000.10.10";
userInfo.signature = "hello world";
userInfo.phoneNumber = "13333333333";
userInfo.email = "123456@qq.com";
userInfo.gender = 1; // 1 为男性；2 为女性。
SDKClient.Instance.UserInfoManager.UpdateOwnInfo(userInfo, new CallBack(
  onSuccess: () => {
  },
  onError:(code, desc) => {
  }
));
```

### 获取用户属性

用户可以获取指定一个或多个用户的全部用户属性。

示例代码如下：

```C#
//获取一个或多个用户的所有属性，一次调用用户 ID 数量不超过 100。
List<string> idList = new List<string>();
idList.Add("username");
SDKClient.Instance.UserInfoManager.FetchUserInfoByUserId
SDKClient.Instance.UserInfoManager.FetchUserInfoByUserId(idList, type, startId, loadCount, new ValueCallBack<Dictionary<string, UserInfo>>(
  //result 是 Dictionary<string, UserInfo> 类型。
  onSuccess: (result) => {
	//遍历 dictionary 里所有的用户信息。
  },
  onError:(code, desc) => {
  }
));
```

## 下一步

本节介绍可以使用用户属性和联系人管理在应用程序中实现的额外功能。

### 管理用户头像

即时通讯 IM SDK 仅支持存储头像文件的 URL 地址，不支持存储头像文件本身，因此管理用户头像需要使用第三方文件存储服务。

要在应用中实现用户头像管理，请执行以下步骤：

1. 将头像文件上传到第三方文件存储服务。文件上传成功后，获得头像文件的 URL 地址。
2. 将用户属性中的 `avatarUrl` 参数设置为头像文件的 URL 地址。
3. 调用 `FetchUserInfoByUserId` 获取头像文件的 URL，然后在本地 UI 上渲染图像。

### 使用用户属性创建和发送名片

名片消息是自定义消息，包括指定用户的用户 ID、昵称、头像、电子邮件地址和电话号码。要创建和发送名片，可以使用自定义属性功能，并参考如下示例代码实现：

```C#
// 设置自定义消息的 `event` 为 `"userCard"`，并在 `ext` 中添加展示名片所需要的用户 ID、昵称和头像等字段。
string event = "userCard";
Dictionary<string, string> adict = new Dictionary<string, string>();
adict.Add("userId", userInfo.userId);
adict.Add("nickname", userInfo. nickname);
adict.Add("avatarUrl", userInfo.avatarUrl);

// 创建自定义消息。
Message msg = Message.CreateCustomSendMessage(toChatUsername, event, adict);

SDKClient.Instance.ChatManager.SendMessage(ref msg, new CallBack(
   onSuccess: () => {
      Debug.Log($"{msg.MsgId}发送成功");
   },
   onError: (code, desc) => {
      Debug.Log($"{msg.MsgId}发送失败，errCode={code}, errDesc={desc}");
   }
));
```