用户属性指为用户添加的标签信息，包含属性名和属性值，如用户昵称、头像、邮箱、电话、性别、签名、生日等。

本文介绍如何通过 Agora Chat SDK 管理用户属性，包括设置、更新、获取用户属性。

<div class="alert note"> 为保证用户信息安全，Agora Chat 仅支持用户本人或 app 管理员（使用 app token 鉴权）管理用户属性。</div>

## 技术原理

Agora Chat SDK 提供 `UserInfoManager` 类，用于设置、更新、获取用户属性，包含如下核心方法：

-   `updateOwnInfo`：设置和更新用户的所有用户属性。
-   `updateOwnInfoByAttribute`：设置和更新用户的指定用户属性。
-   `fetchUserInfoByUserId`：获取用户的所有用户属性。
-   `fetchUserInfoByAttribute`：获取用户的指定用户属性。

## 前提条件

开始前，请确保满足以下条件：

-   已[集成 Agora Chat SDK](./agora_chat_get_started_android?platform=Android#集成-agora-chat-sdk)。
-   了解消息相关限制和 Agora Chat API 的调用频率限制，详见[限制条件](./agora_chat_limitation_android?platform=Android)。

## 实现方法

本节展示如何在项目中设置、更新及获取用户属性。

> 单个用户所有属性长度之和不得超过 2 KB，单个 app 所有用户属性长度之和不得超过 10 GB。

### 设置、更新用户属性

参考如下示例代码，设置或更新当前用户的所有用户属性，或设置或更新当前用户的指定属性：

```java
// 设置或更新用户的所有用户属性。
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
// 设置或更新用户的头像。
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

| 字段        | 类型   | 描述                                                       |
| ----------- | ------ | ---------------------------------------------------------- |
| `nickname`  | String | 用户昵称。长度在 64 字节内。                               |
| `avatarurl` | String | 用户头像 URL 地址。长度在 256 字节内。                     |
| `phone`     | String | 用户联系方式。长度在 32 字节内。                           |
| `mail`      | String | 用户邮箱。长度在 64 字节内。                               |
| `gender`    | Number | 用户性别。默认为 `0`。设置为其他值无效。<li>1：男<li>2：女 |
| `sign`      | String | 用户签名。长度在 256 字节内。                              |
| `birth`     | String | 用户生日。长度在 64 字节内。                               |
| `ext`       | String | 扩展字段。                                                 |

### 获取用户属性

参考如下示例代码，获取用户的所有用户属性，或获取用户的指定属性：

```java
// 以 app 管理员身份，获取一个或多个用户的所有用户属性，单次获取的用户数不得超过 100。
String[] userId = new String[1];
// 用户名
userId[0] = username;
ChatClient.getInstance().userInfoManager().fetchUserInfoByUserId(userId, new ValueCallBack<Map<String, UserInfo>>() {});
// 获取指定的用户属性。
String[] userId = new String[1];
userId[0] = ChatClient.getInstance().getCurrentUser();
UserInfoType[] userInfoTypes = new UserInfoType[2];
userInfoTypes[0] = UserInfoType.NICKNAME;
userInfoTypes[1] = UserInfoType.AVATAR_URL;
ChatClient.getInstance().userInfoManager().fetchUserInfoByAttribute(userId, userInfoTypes,
           new ValueCallBack<Map<String, UserInfo>>() {});
```

## 更多功能

### 设置用户头像

参考如下步骤，设置用户头像：

1. 开通第三方文件存储服务。详见[阿里云文件存储 NAS](https://help.aliyun.com/product/27516.html) 或其他第三方文件存储帮助文档。
2. 将头像文件上传至上述第三方文件存储，并获取存储 URL 地址。
3. 将该 URL 地址传入用户属性的头像字段（`avatarurl`）。
4. 调用 `fetchUserInfoByUserId` 或 `fetchUserInfoByAttribute` 获取头像字段，并在本地 UI 中渲染用户头像。

### 实现名片消息

参考如下示例代码，用用户属性扩展字段 `ext` 实现名片消息：

```java
// 设置自定义消息的 event 为 userCard，并在用户属性扩展字段 ext 中添加名片的用户名、昵称和头像等字段。
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

如需在名片中展示更丰富的信息，你可以参考以下类，在 `ext` 中添加更多字段：

-   `ChatUserCardAdapterDelegate`
-   `ChatUserCardAdapterDelegate`
-   `ChatRowUserCard`