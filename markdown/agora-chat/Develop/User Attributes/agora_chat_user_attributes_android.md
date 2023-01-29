使用即时通讯 IM 时，用户可以根据需要更新用户的信息，如用户昵称、头像、邮箱、电话、性别、签名、生日等。

- 用户属性存储在即时通讯 IM 服务器上。如果你有安全方面的顾虑，建议你自行管理用户属性。
- 为保证信息安全，应用用户只能修改自己的用户属性。只有应用管理员可以修改其他用户的用户属性。

本文介绍如何使用即时通讯 IM SDK 实现用户属性管理。

## 技术原理

SDK 提供 `UserInfoManager` 类，支持获取、设置和修改用户属性信息，其中包含如下方法：

- `updateOwnInfo` 设置和修改当前用户自己的属性信息；
- `updateOwnInfoByAttribute` 设置和修改用户信息中的某个属性；
- `fetchUserInfoByUserId` 获取指定用户的所有用户属性信息；
- `fetchUserInfoByAttribute` 获取指定用户 ID 的指定用户属性。

## 前提条件

设置用户属性前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Android 快速开始](./agora_chat_get_started_android)。
- 了解 [使用限制](./agora_chat_limitation)。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的方法管理用户属性。

<div class="alert note">单个用户的所有属性最大不超过 2 KB，单个 app 所有用户属性数据最大不超过 10 GB。</div>

### 设置当前用户的属性

- 参考如下示例代码，设置当前用户的所有用户属性：

```java
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

- 参考如下示例代码，设置当前用户的指定用户属性，例如修改用户头像：

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

用户属性包括如下字段：

| 字段        | 类型   | 描述                                                         |
| :---------- | :----- | :----------------------------------------------------------- |
| `nickname`  | String | 用户昵称，不能超过 64 个字符。                                 |
| `avatarUrl` | String | 用户头像 URL 地址，不能超过 256 个字符。                       |
| `phone`     | String | 用户联系方式，不能超过 32 个字符。                             |
| `mail`      | String | 用户邮箱，不能超过 64 个字符。                                 |
| `gender`    | Number | 用户性别：<ul><li> `1`：男；</li><li>`2`：女；</li><li>（默认）`0`：未知；</li><li>设置为其他值无效。</li></ul>|
| `sign`      | String | 用户签名，不能超过 256 个字符。                                |
| `birth`     | String | 用户生日，不能超过 64 个字符。                                 |
| `userId`    | String | 用户 ID。                                                    |
| `ext`       | String | 扩展字段。                                                   |

### 获取用户属性

调用 `fetchUserInfoByUserId` 方法获取指定用户的全部用户属性。每次最多可获取 100 个用户的用户属性。

```java
String[] userId = new String[1];
// `username` 为用户 ID
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

## 后续步骤

本节介绍你可以使用用户属性和联系人管理在应用程序中实现的额外功能。

### 管理用户头像

即时通讯 IM SDK 仅支持存储头像文件的 URL 地址，不支持存储头像文件本身。要管理用户头像，执行以下步骤：

1. 启用第三方文件存储服务。详见文件储存服务商的文档。
2. 将头像文件上传到第三方文件存储服务。文件上传成功后，获得头像文件的 URL 地址。
3. 将该 URL 地址传入用户属性的头像字段（`avatarUrl`）。
4. 要显示头像，调用 `fetchUserInfoByUserId` 方法获取头像文件的 URL，然后在本地 UI 上渲染图像。

### 使用用户属性创建和发送名片

名片消息是自定义消息，包括指定用户的用户 ID、昵称、头像、电子邮件地址和电话号码。要创建和发送名片，需执行以下步骤：

1. 创建自定义消息并将该消息的 `event` 设置为 `USER_CARD_EVENT`。
2. 在 `params` 中添加 `userId`、`getNickname` 和 `getAvatarUrl` 字段。然后，发送自定义消息。

创建和发送名片消息的示例代码如下：

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