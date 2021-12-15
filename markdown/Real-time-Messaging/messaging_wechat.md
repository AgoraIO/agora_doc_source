---
title: 发送和接收点对点消息及频道消息
platform: 微信小程序
updatedAt: 2021-02-07 02:29:34
---

本文介绍如何使用 Agora 微信小程序 SDK 快速实现视频直播。

## 开发环境要求

- 有效的 [Agora 账户](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up) 和 [App ID](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#获取-app-id)
- [微信开发者工具](https://developers.weixin.qq.com/miniprogram/dev/devtools/devtools.html)
- 在微信公众平台账号的开发设置中，给予以下域名请求权限：

  ```JavaScript
  https://miniapp.agoraio.cn
  https://webcollect-rtm.agora.io
  wss://miniapp.agoraio.cn
  ```

<div class="alert note">如果你的网络环境部署了防火墙，请根据<a href="/cn/Agora%20Platform/firewall?platform=All_Platforms&versionId=677b6090-d2f9-11ea-8288-1373da5192cc#微信小程序-sdk-1">应用企业防火墙限制</a>打开相关端口。</div>

<div class="alert info">在集成 RTM 微信小程序组件之前，Agora 建议你先阅读<a href="https://developers.weixin.qq.com/miniprogram/dev/framework/">微信小程序开发官网文档</a>。</div>

## 准备开发环境

1. 下载 [RTM 微信小程序 SDK](https://docs.agora.io/cn/Real-time-Messaging/downloads) 并解压。
2. 将 SDK 包中到的 `rtm.miniapp.js` 文件复制到你的小程序项目文件夹中。
3. 使用 `require` 将 RTM 微信小程序 SDK 集成到项目中：

   ```JavaScript
   // ../../lib/.js 为你的 js 文件本地路径
   const AgoraRTM = require('../../lib/rtm.miniapp.js');
   ```

## 发送和接收点对点消息及频道消息

### 初始化客户端对象

你需要在该步骤中填入项目的 App ID。请参考如下步骤在控制台[创建 Agora 项目](https://docs.agora.io/cn/Agora%20Platform/manage_projects?platform=All%20Platforms)并获取 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id)。

1. 登录[控制台](https://console.agora.io/)，点击左侧导航栏的[项目管理](https://console.agora.io/projects)图标 ![img](https://web-cdn.agora.io/docs-files/1551254998344)。
2. 点击创建，按照屏幕提示设置项目名，选择一种鉴权机制，然后点击提交。
3. 在项目管理页面，你可以获取该项目的 App ID。

调用 `createInstance` 方法，然后填入获取到的 App ID，初始化客户端对象。 只有 App ID 相同的应⽤才能互通。

```JavaScript
// 创建 RtmClient 实例
const client = AgoraRTM.createInstance('<APPID>');
```

### 登录 RTM 系统

RtmClient 实例创建成功后，调用 `join` 登录 RTM 系统：

```JavaScript
// 登录 RTM 系统
client.login({ token: '<TOKEN>', uid: '<UID>' }).then(() => {
  console.log('AgoraRTM client login success');
}).catch(err => {
  console.log('AgoraRTM client login failure', err);
});
```

如果需要退出登录，可以调用 logout 方法，退出登录之后可以调用 login 重新登录或者使用其它用户 ID 登录。

```JavaScript
client.logout();
```

### 监听连接状态改变

通过监听 `RtmClient` 上的 `ConnectionStateChanged` 事件可以获得 SDK 连接状态改变的通知。

```JavaScript
client.on('ConnectionStateChanged', (newState, reason) => {
  console.log('on connection state changed to ' + newState + ' reason: ' + reason);
});
```

### 发送和接收点对点消息

登录成功后，调用 `sendMessageToPeer` 发送点对点消息：

```JavaScript

client.sendMessageToPeer(
    { text: 'test peer message' }, // 符合 RtmMessage 接口的参数对象
    '<PEER_ID>', // 远端用户 ID
).then(sendResult => {
  if (sendResult.hasPeerReceived) {
    /* 远端用户收到消息的处理逻辑 */
  } else {
    /* 服务器已接收、但远端用户不可达的处理逻辑 */
  }
}).catch(error => {
  /* 发送失败的处理逻辑 */
});
```

监听 `client` 上的事件 `MessageFromPeer` 接收点对点消息：

```JavaScript
client.on('MessageFromPeer', ({ text }, peerId) => { // text 为消息文本，peerId 是消息发送方 User ID
  /* 收到点对点消息的处理逻辑 */
});
```

### 发送和接收频道消息

调用 `createChannel` 创建 RTM 频道：

```JavaScript
const channel = client.createChannel('<CHANNEL_ID>'); // 此处传入频道 ID
```

调用 `join` 加入 RTM 频道：

```JavaScript
channel.join().then(() => {
  /* 加入频道成功的处理逻辑 */
}).catch(error => {
  /* 加入频道失败的处理逻辑 */
});
```

调用 `sendMessage` 发送频道消息：

```JavaScript
channel.sendMessage({ text: 'test channel message' }).then(() => {
  /* 频道消息发送成功的处理逻辑 */
}).catch(error => {
  /* 频道消息发送失败的处理逻辑 */
});
```

监听 `channel` 上的事件 `ChannelMessage` 接收频道消息：

```JavaScript
channel.on('ChannelMessage', ({ text }, senderId) => { // text 为收到的频道消息文本，senderId 为发送方的 User ID
  /* 收到频道消息的处理逻辑 */
});
```

调用实例的 `leave` 方法可以退出该频道。退出频道之后可以调用 `join` 方法再重新加入频道。

```JavaScript
channel.leave();
```

### 运行项目

在微信开发者工具中导入你的项目后，点击预览，开发者工具会生成一个二维码。手机微信扫描二维码即可运行小程序。

## 相关文档

使用微信小程序 SDK 开发过程中，你还可以参考如下文档：

- [RTM 微信小程序 SDK API 参考](/cn/Video/API%20Reference/RTM_wechat/v1.0.0/index.html?transId=6cc4d530-d25a-11ea-8288-1373da5192cc)
- [RTM 微信小程序 SDK 限制条件](/cn/Real-time-Messaging/limitations_wechat?platform=微信小程序)
