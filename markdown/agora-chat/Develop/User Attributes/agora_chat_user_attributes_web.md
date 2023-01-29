使用即时通讯 IM 时，用户可以根据需要更新用户的信息，如用户昵称、头像、邮箱、电话、性别、签名、生日等。

- 用户属性存储在即时通讯 IM 服务器上。如果你有安全方面的顾虑，建议你自行管理用户属性。
- 为保证信息安全，应用用户只能修改自己的用户属性。只有应用管理员可以修改其他用户的用户属性。

本文介绍如何使用即时通讯 IM SDK 实现用户属性管理。

## 技术原理

即时通讯 IM Web SDK 提供 `UserInfoManager` 类用于获取、设置和修改用户属性：

- 设置或修改用户属性。
- 获取指定用户的用户属性。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Web 快速开始](./agora_chat_get_started_web)。
- 了解即时通讯 IM 的[使用限制](./agora_chat_limitation)。

## 实现方法

本节介绍如何在项目中设置及获取用户属性。

<div class="alert note">单个用户的所有属性最大不超过 2 KB，单个 app 所有用户属性数据最大不超过 10 GB。</div>

### 设置当前用户的属性

- 参考如下示例代码，设置当前用户的所有用户属性：

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

- 参考如下示例代码，设置当前用户的指定用户属性，例如修改用户昵称：

```javascript
conn.updateUserInfo('nickname', 'Your nickname').then((res) => {
    console.log(res)
})
```

用户属性包括如下字段：

| 字段        | 类型   | 描述                                                         |
| :---------- | :----- | :----------------------------------------------------------- |
| `nickname`  | String | 用户昵称，不能超过 64 个字符。                                |
| `avatarurl` | String | 用户头像 URL 地址，不能超过 256 个字符。                        |
| `phone`     | String | 用户联系方式，不能超过 32 个字符。                            |
| `mail`      | String | 用户邮箱，不能超过 64 个字符。                          |
| `gender`    | Number | 用户性别：<ul><li> `1`：男；</li><li>`2`：女；</li><li>（默认）`0`：未知；</li><li>设置为其他值无效。</li></ul> |
| `sign`      | String | 用户签名，不能超过 256 个字符。                                 |
| `birth`     | String | 用户生日，不能超过 64 个字符。                               |
| `ext`       | String | 扩展字段。                                                   |

### 获取用户属性

你可以调用 `fetchUserInfoById` 方法查询指定用户的用户属性。每次调用最多可获取 100 个用户的用户属性。

- 参考以下示例代码获取指定用户的所有属性：

```javascript
/**
 * @param {String|Array} users 用户 ID。可设置一个用户 ID，也可通过数组形式设置多个。
 */
let users = 'user1' || ['user1', 'user2']
conn.fetchUserInfoById(users).then((res) => {
    console.log(res)
})
```

- 参考以下示例代码获取用户的指定属性。

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

## 更多功能

本节介绍可以使用用户属性和联系人管理在应用程序中实现的额外功能。

### 管理用户头像

即时通讯 IM SDK 仅支持存储头像文件的 URL 地址，不支持存储头像文件本身。要管理用户头像，执行以下步骤：

1. 启用第三方文件存储服务。详见文件储存服务商的文档。
2. 将头像文件上传到第三方文件存储服务。文件上传成功后，获得头像文件的 URL 地址。
3. 将用户属性中的 `avatarurl` 参数设置为头像文件的 URL 地址。
4. 要显示头像，调用 `fetchUserInfoById` 获取头像文件的 URL，然后在本地 UI 上渲染图像。

### 使用用户属性创建和发送名片消息

名片消息是自定义消息，包括指定用户的用户 ID、昵称、头像、电子邮件地址和电话号码。要创建和发送名片，执行以下步骤：

1. 将消息类型设置为 `custom`。
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