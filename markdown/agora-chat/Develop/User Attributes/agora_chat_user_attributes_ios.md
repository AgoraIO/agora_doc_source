使用即时通讯 IM 时，用户可以根据需要更新用户的信息，如用户昵称、头像、邮箱、电话、性别、签名、生日等。

- 用户属性存储在即时通讯 IM 服务器上。如果你有安全方面的顾虑，建议你自行管理用户属性。
- 为保证信息安全，应用用户只能修改自己的用户属性。只有应用管理员可以修改其他用户的用户属性。

本文介绍如何使用即时通讯 IM SDK 实现用户属性管理。

## 技术原理

环信即时通讯 IM iOS SDK 提供 `userInfoManager` 类，支持获取、设置及修改用户属性信息，其中包含如下方法：

- `updateOwnUserInfo` 设置和修改当前用户自己的属性信息；
- `fetchUserInfoById` 获取指定用户的所有用户属性信息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 快速开始](./agora_chat_get_started_ios)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation)。

## 实现方法

本节介绍如何在项目中设置及获取用户属性。

<div class="alert note">单个用户的所有属性最大不超过 2 KB，单个 app 所有用户属性数据最大不超过 10 GB。</div>

### 设置当前用户的用户属性

- 参考如下示例代码，设置当前用户的所有用户属性：

```objective-c
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

- 参考如下示例代码，设置当前用户的指定用户属性，例如修改用户头像：

```objective-c
NSString *url = @"https://download-sdk.oss-cn-beijing.aliyuncs.com/downloads/IMDemo/avatar/Image1.png";

[[AgoraChatClient sharedClient].userInfoManager updateOwnUserInfo:url withType:AgoraChatUserInfoTypeAvatarURL completion:^(AgoraChatUserInfo *aUserInfo, AgoraChatError *aError) {
        if (aUserInfo && completion) {
            completion(aUserInfo);
        }
    }];
```

用户属性包括如下字段：

| 字段        | 类型   | 描述                                                         |
| :---------- | :----- | :----------------------------------------------------------- |
| `nickName`  | String | 用户昵称，不能超过 64 个字符。                                 |
| `avatarUrl` | String | 用户头像 URL 地址，不能超过 256 个字符。                       |
| `phone`     | String | 用户联系方式，不能超过 32 个字符。                             |
| `mail`      | String | 用户邮箱，不能超过 64 个字符。                                 |
| `gender`    | Number | 用户性别：<ul><li> `1`：男；</li><li>`2`：女；</li><li>（默认）`0`：未知；</li><li>设置为其他值无效。</li></ul>|
| `sign`      | String | 用户签名，不能超过 256 个字符。                                |
| `birth`     | String | 用户生日，不能超过 64 个字符。                                 |
| `userId`    | String | 用户 ID。                                                    |
| `ext`       | String | 扩展字段。                                                   |

### 获取用户属性

用户可以调用 `fetchUserInfoById` 方法获取指定一个或多个用户的全部用户属性。每次最多可获取 100 个用户的用户属性。

- 参考以下示例代码，获取指定用户的全部用户属性：

```objective-c
[[AgoraChatClient sharedClient].userInfoManager fetchUserInfoById:@[AgoraChatClient.sharedClient.currentUsername]         completion:^(NSDictionary *aUserDatas, AgoraChatError *aError) {
}];
```

- 参考以下示例代码，获取指定用户的指定用户属性：

```objectivec
NSString *userIds = @[@"user1",@"user2"];
NSArray<NSNumber *> *userInfoTypes = @[@(AgoraChatUserInfoTypeAvatarURL),@(AgoraChatUserInfoTypePhone),@(AgoraChatUserInfoTypeMail)];
[[AgoraChatClient sharedClient].userInfoManager fetchUserInfoById:userIds type:userInfoTypes completion:^(NSDictionary *aUserDatas, AgoraChatError *aError) {

}];
```

## 更多功能

本节介绍你可以使用用户属性和联系人管理在应用程序中实现的额外功能。

### 管理用户头像

即时通讯 IM SDK 仅支持存储头像文件的 URL 地址，不支持存储头像文件本身。要管理用户头像，执行以下步骤：

1. 启用第三方文件存储服务。详见文件储存服务商的文档。
2. 将头像文件上传至上述第三方文件存储，并获取存储 URL 地址。
3. 将该 URL 地址传入用户属性的头像字段（`avatarUrl`）。
4. 要显示头像，调用 `fetchUserInfoById` 获取头像 URL，并在本地 UI 中渲染头像。

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

如果需要在名片中展示更丰富的信息，可以在 `ext` 中增加更多字段。