# 用户属性

加入 Agora Chat 频道后，用户可以根据需要更新用户的信息，如用户昵称、头像、邮箱、电话、性别、签名、生日等。

本页介绍如何使用 Agora Chat SDK 实现用户属性管理。

- 用户属性存储在 Agora Chat 服务器上。如果您有安全方面的顾虑，Agora 建议您自行管理用户属性。
- 为保证信息安全，应用用户只能修改自己的用户属性。只有应用管理员可以修改其他用户的用户属性。

## 技术原理

SDK 提供一个 `UserInfoManager` 类，支持获取、设置及修改用户属性信息，其中包含如下方法：

- `updateOwnInfo` 设置和修改当前用户自己的属性信息；
- `updateOwnInfoByAttribute` 设置和修改用户信息中的某个属性；
- `fetchUserInfoByUserId` 获取指定用户的所有用户属性信息；
- `fetchUserInfoByAttribute` 获取指定用户 ID 的指定用户属性。

## 前提条件

设置用户属性前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Agora Chat 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_unity?platform=Unity)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Unity)。

## 实现方法

本节介绍如何使用 Agora Chat SDK 提供的方法管理用户属性。

### 设置当前用户的属性

参考如下示例代码，在你的项目中当前用户设置自己的所有属性或者仅设置某一项属性。

```java
// 设置所有用户属性。
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

以修改用户头像为例，演示如何修改指定用户属性。

```java
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

### 获取用户属性

调用 `fetchUserInfoByUserId` 来获取指定用户的用户属性。每次调用最多可以获取 100 个用户的用户属性。

请参考以下代码示例：

```java
String[] userId = new String[1];
// `username` 指用户 ID
userId[0] = username;
ChatClient.getInstance().userInfoManager().fetchUserInfoByUserId(userId, new ValueCallBack<Map<String, UserInfo>>() {});
```

### 获取指定用户的指定用户属性


用户可以获取指定用户的指定用户属性信息。

```java
String[] userId = new String[1];
userId[0] = ChatClient.getInstance().getCurrentUser();
UserInfoType[] userInfoTypes = new UserInfoType[2];
userInfoTypes[0] = UserInfoType.NICKNAME;
userInfoTypes[1] = UserInfoType.AVATAR_URL;
ChatClient.getInstance().userInfoManager().fetchUserInfoByAttribute(userId, userInfoTypes,
           new ValueCallBack<Map<String, UserInfo>>() {});
```

## 下一步

本节介绍您可以使用用户属性和联系人管理在应用程序中实现的额外功能。

### 管理用户头像

Agora Chat SDK 仅支持存储头像文件的 URL 地址，不支持存储头像文件本身。要管理用户头像，需要使用第三方文件存储服务。

要在应用中实现用户头像管理，请执行以下步骤：

1. 将头像文件上传到第三方文件存储服务。文件上传成功后，将获得头像文件的 URL 地址。
2. 将 `avatarUrl` 用户属性中的参数设置为头像文件的 URL 地址。
3. 要显示头像，调用 `fetchUserInfoByUserId` 获取头像文件的 URL，然后在本地 UI 上渲染图像。

### 使用用户属性创建和发送名片

名片消息是自定义消息，包括指定用户的用户 ID、昵称、头像、电子邮件地址和电话号码。要创建和发送名片，请执行以下步骤：

1. 创建自定义消息并将自定义消息的 设置 `event` 为 `USER_CARD_EVENT`。
2. 在 `params` 中添加 `userId`、`getNickname` 和 `getAvatarUrl` 作为文件。发送自定义消息。

以下是创建和发送名片消息的示例代码：

```java
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.CUSTOM);
                CustomMessageBody body = new CustomMessageBody(DemoConstant.USER_CARD_EVENT);
                Map<String,String> params = new HashMap<>();
                params.put(DemoConstant.USER_CARD_ID,userId);
                params.put(DemoConstant.USER_CARD_NICK,user.getNickname());
                params.put(DemoConstant.USER_CARD_AVATAR,user.getAvatarUrl());
                body.setParams(params);
                message.setBody(body);
                message.setTo(toUser);

ChatClient.getInstance().chatManager().sendMessage(message);
```

如果需要在名片中展示更丰富的信息，可以在 `ext` 中增加更多字段。

## 参考

本节包含您在实施过程中可能需要了解的参考信息。

- 有关用户属性的详细信息，请参阅以下 API 参考：
  - [用户信息](https://docs.agora.io/en/agora-chat/.A/API Reference/im_java/classio_1_1agora_1_1chat_1_1_user_info.html)
  - [用户信息管理器](https://docs.agora.io/en/agora-chat/API Reference/im_java/classio_1_1agora_1_1chat_1_1_user_info_manager.html)