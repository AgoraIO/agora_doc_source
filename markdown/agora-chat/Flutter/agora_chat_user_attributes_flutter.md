用户属性指实时消息互动用户的信息，如用户昵称、头像、邮箱、电话、性别、签名、生日等。

例如，在招聘场景下，利用用户属性功能可以存储性别、邮箱、用户类型（面试者）、职位类型（web 研发）等。查看用户信息时，可以直接查询服务器存储的用户属性信息。

本文介绍如何通过管理用户属性设置、更新、存储并获取实时消息用户的相关信息。

- 用户属性存储在即时通讯 IM 服务器上。如果你有安全方面的顾虑，Agora 建议你自行管理用户属性。
- 为保证用户信息安全，SDK 仅支持用户设置或更新自己的用户属性。

## 技术原理

即时通讯 IM Flutter SDK 提供 `ChatUserInfoManager` 类用于获取、设置和修改用户属性信息。以下是核心方法：

- `updateUserInfo` 设置和修改当前用户自己的属性信息；
- `fetchUserInfoById`：检索指定用户的用户属性。
- `fetchOwnInfo`：检索用户自己的用户属性。

## 前提条件

设置用户属性前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_flutter)。
- 了解 [使用限制](./agora_chat_limitation)。

## 实现方法

本节介绍如何在项目中设置及获取用户属性。

实现过程中注意单个用户的所有属性最大不超过 2 KB，单个 app 所有用户属性数据最大不超过 10 GB。

### 设置当前用户的属性

参考如下示例代码，在你的项目中当前用户设置自己的所有属性或者仅设置某一项属性。

```dart
try {
  ChatClient.getInstance.userInfoManager.updateUserInfo(userInfo);
} on ChatError catch (e) {
  // 更新用户属性失败，返回错误信息。
}
```

### 获取用户属性

用户可以调用 `fetchUserInfoById` 获取指定一个或多个用户的全部用户属性。一次调用用户 ID 数量不超过 100。

请参考以下代码示例：

```dart
List<String> list = ["tom", "json"];
try {
  Map<String, ChatUserInfo> userInfos =
      await ChatClient.getInstance.userInfoManager.fetchUserInfoById(list);
} on ChatError catch (e) {
  // 获取用户属性失败，返回错误信息。
}
```

### 获取当前用户的属性

调用 `fetchOwnInfo` 获取当前用户的用户属性：

```dart
try {
  ChatUserInfo? userInfo =
      await ChatClient.getInstance.userInfoManager.fetchOwnInfo();
} on ChatError catch (e) {
  // 获取当前用户属性失败，返回错误信息。
}
```

## 下一步

本节介绍可以使用用户属性和联系人管理在应用程序中实现的额外功能。

### 管理用户头像

SDK 仅支持存储头像文件的 URL 地址，不支持存储头像文件本身。管理用户头像需要使用第三方文件存储服务。

参考如下步骤：

1. 将头像文件上传至第三方文件存储服务。文件上传成功后，获得头像文件的 URL 地址。
2. 将用户属性中的 `avatarUrl` 参数设置为头像文件的 URL 地址。
3. 要显示头像，调用 `fetchUserInfoById` 方法获取头像文件的 URL，然后在本地 UI 上渲染图像。