# 管理用户属性

用户属性指实时消息互动用户的信息，如用户昵称、头像、邮箱、电话、性别、签名和生日等。

例如，在招聘场景下，利用用户属性功能可存储性别、邮箱、用户类型（面试者）、职位类型（Web 研发）等。查看用户信息时，可直接查询服务器存储的用户属性信息。

本文介绍如何管理用户属性，包括设置、更新、存储并获取用户的相关信息。

**注意**

- 用户属性存储在即时通讯 IM 服务器。如果你有安全方面的顾虑，建议你自行管理用户属性。
- 为保证信息安全，app 用户只能修改自己的用户属性。只有 app 管理员可以修改其他用户的用户属性。

## 技术原理

即时通讯 IM Web SDK 提供 `UserInfoManager` 类用于获取、设置和修改用户属性：

- 设置或修改用户属性。
- 获取指定用户的用户属性。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Agora Chat 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_web?platform=Web)。
- 了解即时通讯 IM 的使用限制，指定用户的所有属性的最大大小，以及应用程序中所有用户属性的最大大小。详见 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Web)。

## 实现方法

本节介绍如何在项目中设置及获取用户属性。

实现过程中注意单个用户的所有属性的长度不超过 2 KB，单个 app 的所有用户属性的数据长度不超过 10 GB。

### 设置当前用户的属性

当前用户设置自己的所有属性或者仅设置一项指定属性。

参考如下示例代码，设置所有用户属性：

```javascript
let option = {
    nickname: 'The nickname',
    avatarurl: 'http://avatarurl',
    mail: '123@qq.com',
    phone: '16888888888',
    gender: 'female',
    birth: '2000-01-01',
    sign: 'a sign',
    ext: JSON.stringify({
          nationality: 'China',
          merit: 'Hello, world！'
        })
}
conn.updateUserInfo(option).then((res) => {
    console.log(res)
})
```

参考如下示例代码，设置指定用户属性，例如昵称：

```javascript
conn.updateUserInfo('nickname', 'Your nickname').then((res) => {
    console.log(res)
})
```

用户属性包括如下字段：

| 字段        | 类型   | 备注                                                         |
| :---------- | :----- | :----------------------------------------------------------- |
| `nickname`  | String | 用户昵称。长度在 64 字符内。                                 |
| `avatarurl` | String | 用户头像 URL 地址。长度在 256 字符内。                       |
| `phone`     | String | 用户联系方式。长度在 32 字符内。                             |
| `mail`      | String | 用户邮箱。长度在 64 字符内。                                 |
| `gender`    | Number | 用户性别。 <br/> - `1`：男；<br/> - `2`：女；<br/> - （默认）`0`：未知；<br/> - 设置为其他值无效。 |
| `sign`      | String | 用户签名。长度在 256 字符内。                                |
| `birth`     | String | 用户生日。长度在 64 字符内。                                 |
| `ext`       | String | 扩展字段。                                                   |

### 获取用户属性

你可以调用 `fetchUserInfoById` 方法查询指定用户的用户属性。每次调用最多可获取 100 个用户的用户属性。

参考以下示例代码获取指定用户的所有属性：

```javascript
/**
 * @param {String|Array} users 用户 ID。可设置一个用户 ID，也可通过数组形式设置多个。
 */
let users = 'user1' || ['user1', 'user2']
conn.fetchUserInfoById(users).then((res) => {
    console.log(res)
})
```

参考以下示例代码获取用户的指定属性。

```javascript
/**
 * @param {String|Array} users 用户 ID。可设置一个用户 ID，也可通过数组形式设置多个。
 * @param {String|Array} properties 查询的用户属性。
 */
conn.fetchUserInfoById('userId', 'nickname').then((res) => {
    console.log(res)
})

// 同时查询多个用户属性。
conn.fetchUserInfoById(['user1', 'user2'], ['nickname', 'avatarurl']).then((res) => { console.log(res)
})
```

## 下一步

本节介绍可以使用用户属性和联系人管理在应用程序中实现的额外功能。

### 管理用户头像

即时通讯 IM SDK 仅支持存储头像文件的 URL 地址，不支持存储头像文件本身。要管理用户头像，你需要使用第三方文件存储服务。

在 app 中进行用户头像管理，需采取以下步骤：

1. 将头像文件上传到第三方文件存储服务。文件上传成功后，获得头像文件的 URL 地址。
2. 将用户属性中的 `avatarUrl` 参数设置为头像文件的 URL 地址。
3. 要显示头像，调用 `fetchUserInfoById` 获取头像文件的 URL，然后在本地 UI 上渲染图像。

### 使用用户属性创建和发送名片消息

名片消息是自定义消息，包括指定用户的用户 ID、昵称、头像、电子邮件地址和电话号码。要创建和发送名片，请参考以下步骤：

1. 将消息类型设置为`custom`。
2. 将自定义消息中的 `customEvent` 设置为 `userCard`。
3. 在用户属性中查询 `nickname`、`mail` 和 `avatarurl` 的值，然后使用 `customExts` 将其设置为自定义消息的扩展信息。

参考以下示例代码创建和发送名片消息：

```javascript

// 将自定义事件类型设置为 `userCard`。
let customEvent = "userCard";
// 通过 `customExts` 将这些属性设置为自定义消息的扩展信息。
let customExts = {
    nickname: "昵称",
    avatarurl: "http://avatarurl",
    mail: "123@qq.com",
    phone: "16888888888",
    gender: "female",
    birth: "2000-01-01",
    sign: "a sign",
};
let option = {
    // 设置消息类型。
    type: "custom",
    // 设置消息接收方。
    to: "username",
    // 设置消息事件。
    customEvent,
    // 设置消息内容。
    customExts,
    chatType: "singleChat"
}
// 创建自定义消息。
let msg = WebIM.message.create(option;
conn.send(msg).then((res)=>{
    console.log('Success')
}).catch((e)=>{
    console.log('Fail')
});
```

如果需要在名片中展示更丰富的信息，可以在 `ext` 中添加更多字段。

## 参考

本节包含您在实施过程中可能需要了解的参考信息。

- 有关用户属性的详细信息，请参阅以下 API 参考：
  - [用户信息](https://docs.agora.io/en/agora-chat/API Reference/im_oc/interface_agora_chat_user_info.html)
  - [fetchUserInfoById](https://docs.agora.io/en/agora-chat/API Reference/im_ts/modules/Contact.html)