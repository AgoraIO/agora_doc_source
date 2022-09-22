用户属性指实时消息互动用户的信息，如用户昵称、头像、邮箱、电话、性别、签名、生日等。

例如，在招聘场景下，利用用户属性功能可以存储性别、邮箱、用户类型（面试者）、职位类型（web 研发）等。查看用户信息时，可以直接查询服务器存储的用户属性信息。

本文介绍如何通过管理用户属性设置、更新、存储并获取实时消息用户的相关信息。

- 用户属性存储在即时通讯 IM 服务器上。如果有安全方面的顾虑，建议你自行管理用户属性。
- 为保证信息安全，应用用户只能修改自己的用户属性。只有应用管理员可以修改其他用户的用户属性。

## 技术原理

即时通讯 IM React Native SDK 提供一个 `ChatUserInfoManager` 类，支持获取、设置及修改用户属性信息，其中包含如下方法：

- `updateOwnUserInfo` 设置和修改当前用户自己的属性信息；
- `fetchUserInfoById` 获取指定用户的所有用户属性信息。

## 前提条件

开始前，请确保满足以下条件：

- 完成即时通讯 IM SDK 集成，并实现基本的实时聊天功能，详见 [快速开始](./agora_chat_get_started_rn?platform=rn)。
- 了解即时通讯 IM API 的 [使用限制](./agora_chat_limitation)。

## 实现方法

本节介绍如何在项目中设置及获取用户属性。

实现过程中注意单个用户的所有属性最大不超过 2 KB，单个 app 所有用户属性数据最大不超过 10 GB。

### 设置当前用户的属性

参考如下示例代码，在你的项目中当前用户设置自己的所有属性或者仅设置某一项属性。

```typescript
// 更新当前用户信息
// 除了用户 ID，其他属性都可以更新
// 可以同时更新任何一个或者多个属性
ChatClient.getInstance()
  .userManager.updateOwnUserInfo({
    nickName,
    avatarUrl,
    mail,
    phone,
    gender,
    sign,
    birth,
    ext,
  })
  .then(() => {
    console.log("update userInfo success.");
  })
  .catch((reason) => {
    console.log("update userInfo fail.", reason);
  });
```

用户属性包括如下字段：

<UserAttribute />

### 获取用户属性

用户可以获取指定一个或多个用户的全部用户属性。

示例代码如下：

```typescript
// 指定获取的一个或者多个用户 ID，一次调用用户 ID 数量不超过 100。
const userIds = ["tom", "json"];
// 执行获取操作
ChatClient.getInstance()
  .userManager.fetchUserInfoById(userIds)
  .then((users) => {
    console.log("get userInfo success.", users);
  })
  .catch((reason) => {
    console.log("get userInfo fail.", reason);
  });
```

### 获取当前用户的属性

```typescript
// 执行获取操作
ChatClient.getInstance()
  .userManager.fetchOwnInfo()
  .then((users) => {
    console.log("get userInfo success.", users);
  })
  .catch((reason) => {
    console.log("get userInfo fail.", reason);
  });
```

## 更多功能

本节介绍你可以使用用户属性和联系人管理在应用程序中实现的额外功能。

### 用户头像管理

即时通讯 IM SDK 仅支持存储头像文件的 URL 地址，不支持存储头像文件本身。要管理用户头像，需要使用第三方文件存储服务。

如果你的应用场景中涉及用户头像管理，还可以参考如下步骤进行操作：

1. 开通第三方文件存储服务。详情可以参考文件储存服务商的文档。
2. 将头像文件上传至上述第三方文件存储，并获取存储 URL 地址。
3. 将该 URL 地址传入用户属性的头像字段（avatarUrl）。
4. 显示头像时，通过调用 `fetchUserInfoById` 获取头像 URL，并在本地 UI 中渲染头像。

### 使用用户属性创建和发送名片

名片消息是自定义消息，包括指定用户的用户 ID、昵称、头像、电子邮件地址和电话号码。要创建和发送名片，请执行以下步骤：

```typescript
// 自定义消息。消息内容由两部分组成：消息事件和扩展字段。
// 扩展字段用户可以自行实现和使用。
const event = "userCard";
const ext = { userId: "userId", nickname: "nickname", avatarUrl: "avatarUrl" };
const msg = ChatMessage.createCustomMessage(targetId, event, chatType, {
  params: JSON.parse(ext),
});
// 消息发送结果会通过回调对象返回，这里返回的结果只是说明发送消息的动作成功或者失败。不代表消息发送的成功或者失败。
ChatClient.getInstance()
  .chatManager.sendMessage(msg!, new ChatMessageCallback())
  .then(() => {
    // 消息发送动作完成，会在这里打印日志。
    console.log("send message success.");
  })
  .catch((reason) => {
    // 消息发送动作失败，会在这里打印日志。
    console.log("send message fail.", reason);
  });
```

如果需要在名片中展示更丰富的信息，可以在 `ext` 中增加更多字段。