# 管理用户属性

用户属性指实时消息互动用户的信息，如用户昵称、头像、邮箱、电话、性别、签名、生日等。

例如，在招聘场景下，利用用户属性功能可以存储性别、邮箱、用户类型（面试者）、职位类型（web 研发）等。查看用户信息时，可以直接查询服务器存储的用户属性信息。

本文介绍如何通过管理用户属性设置、更新、存储并获取实时消息用户的相关信息。

- 用户属性存储在即时通讯 IM 服务器上。如果有安全方面的顾虑，建议你自行管理用户属性。
- 为保证信息安全，应用用户只能修改自己的用户属性。只有应用管理员可以修改其他用户的用户属性。

## 技术原理

环信即时通讯 IM iOS SDK 提供一个 `userInfoManager` 类，支持获取、设置及修改用户属性信息，其中包含如下方法：

- `updateOwnUserInfo` 设置和修改当前用户自己的属性信息；
- `fetchUserInfoById` 获取指定用户的所有用户属性信息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_ios?platform=iOS)。
- 了解即时通讯 IM 的 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=iOS)。

## 实现方法

本节介绍如何在项目中设置及获取用户属性。

实现过程中注意单个用户的所有属性最大不超过 2 KB，单个 app 所有用户属性数据最大不超过 10 GB。

### 设置当前用户的属性

参考如下示例代码，在你的项目中当前用户设置自己的所有属性或者仅设置某一项属性。

```objective-c
// 设置用户所有属性。
AgoraChatUserInfo *userInfo = [[AgoraChatUserInfo alloc] init];
userInfo.userId = AgoraChatClient.sharedClient.currentUsername;
userInfo.nickName = @"agora";
userInfo.avatarUrl = @"http://www.agora.io";
userInfo.birth = @"2000.10.10";
userInfo.sign = @"hello world";
userInfo.phone = @"12333333333";
userInfo.mail = @"123456@qq.com";
userInfo.gender = 1;
[AgoraChatClient.sharedClient.userInfoManager updateOwnUserInfo:userInfo completion:^(AgoraChatUserInfo *aUserInfo, AgoraChatError *aError)

}];
```

以下示例代码以头像为例说明如何设置指定的用户属性：

```objective-c
NSString *url = @"https://download-sdk.oss-cn-beijing.aliyuncs.com/downloads/IMDemo/avatar/Image1.png";

[[AgoraChatClient sharedClient].userInfoManager updateOwnUserInfo:url withType:AgoraChatUserInfoTypeAvatarURL completion:^(AgoraChatUserInfo *aUserInfo, AgoraChatError *aError) {
        if (aUserInfo && completion) {
            completion(aUserInfo);
        }
    }];
```

用户属性包括如下字段：

| 字段        | 类型   | 描述                                                       |
| ----------- | ------ | ---------------------------------------------------------- |
| `nickname`  | String | 用户昵称。长度在 64 字符内。                               |
| `avatarurl` | String | 用户头像 URL 地址。长度在 256 字符内。                     |
| `phone`     | String | 用户联系方式。长度在 32 字符内。                           |
| `mail`      | String | 用户邮箱。长度在 64 字符内。                               |
| `gender`    | Number | 用户性别。<br/> - `1`：男；<br/> - `2`：女；<br/> - （默认）`0`：未知；<br/> - 设置为其他值无效。 |
| `sign`      | String | 用户签名。长度在 256 字符内。                              |
| `birth`     | String | 用户生日。长度在 64 字符内。                               |
| `ext`       | String | 扩展字段。                                                 |

### 获取用户属性

用户可以调用 `fetchUserInfoById` 方法获取指定一个或多个用户的全部用户属性。一次最多可以获取 100 个用户的用户属性。

示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].userInfoManager fetchUserInfoById:@[AgoraChatClient.sharedClient.currentUsername]         completion:^(NSDictionary *aUserDatas, AgoraChatError *aError) {
}];
```

以下示例代码为获取指定用户的指定用户属性：

```objectivec
NSString *userIds = @[@"user1",@"user2"];
NSArray<NSNumber *> *userInfoTypes = @[@(AgoraChatUserInfoTypeAvatarURL),@(AgoraChatUserInfoTypePhone),@(AgoraChatUserInfoTypeMail)];
[[AgoraChatClient sharedClient].userInfoManager fetchUserInfoById:userIds type:userInfoTypes completion:^(NSDictionary *aUserDatas, AgoraChatError *aError) {

}];
```

## 更多功能

本节介绍你可以使用用户属性和联系人管理在应用程序中实现的额外功能。

### 管理用户头像

即时通讯 IM SDK 仅支持存储头像文件的 URL 地址，不支持存储头像文件本身。要管理用户头像，需要使用第三方文件存储服务。

如果你的应用场景中涉及用户头像管理，还可以参考如下步骤进行操作：

1. 开通第三方文件存储服务。详情可以参考文件储存服务商的文档。
2. 将头像文件上传至上述第三方文件存储，并获取存储 URL 地址。
3. 将该 URL 地址传入用户属性的头像字段（avatarUrl）。
4. 显示头像时，通过调用 `fetchUserInfoById` 获取头像 URL，并在本地 UI 中渲染头像。

### 使用用户属性创建和发送名片

名片消息是自定义消息，包括指定用户的用户 ID、昵称、头像、电子邮件地址和电话号码。要创建和发送名片，请执行以下步骤：

1. 创建自定义消息并将自定义消息的 设置 `event` 为 `userCard`。
2. 在 `ext` 中添加展示名片所需要的用户 ID、昵称和头像等字段。

以下是创建和发送名片消息的示例代码：

```objective-c
AgoraChatCustomMessageBody *body = [[AgoraChatCustomMessageBody alloc] init];
    body.event = @"userCard";
    NSDictionary *messageExt = @{@"userId":AgoraChatClient.sharedClient.currentUsername,
                          @"nickname":@"nickname",
                          @"avatar":@"https://download-sdk.oss-cn-beijing.aliyuncs.com/downloads/IMDemo/avatar/Image1.png"
                        };
    body.ext = messageExt;
    AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:@"conversationID"
                                                          from:@"sender"
                                                            to:@"receiver"
                                                          body:body
                                                           ext:nil];
    // 发送消息。
    [[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:^(AgoraChatMessage *message, AgoraChatError *error) {
    }];
```

## 参考

本节包含你在实施过程中可能需要了解的参考信息。

- 有关用户属性的详细信息，请参阅以下 API 参考：
  - [即时通讯 IM 用户信息](https://docs.agora.io/en/agora-chat/API Reference/im_oc/interface_agora_chat_user_info.html)
  - [IAgoraChatUserInfoManager](https://docs.agora.io/en/agora-chat/API Reference/im_oc/protocol_i_agora_chat_user_info_manager-p.html)