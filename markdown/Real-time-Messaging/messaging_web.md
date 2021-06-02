---
title: 发送和接收点对点消息及频道消息
platform: Web
updatedAt: 2021-03-02 02:30:46
---

本页介绍在正式使用 [Agora RTM Web SDK](https://docs.agora.io/cn/Real-time-Messaging/downloads) 进行实时消息通讯前，需要准备的开发环境要求及 SDK 集成方法等内容。

## 快速跑通 Demo

如果你是第一次使用声网的服务，我们推荐观看下面的视频，了解关于声网服务的基本信息以及如何快速跑通 demo。

<div class="alert info">点击参与<a href="https://www.wenjuan.com/s/7FbeEz6/" target="_blank">视频教程问卷调查</a>，帮助我们改进体验。</div>

<video src="https://web-cdn.agora.io/docs-files/1593742453707" poster="https://web-cdn.agora.io/docs-files/1584610484891"   controls width = 100% height = auto>你的浏览器不支持 <code>video</code> 标签。</video>

<div class="alert note">视频中展示的 UI 可能有部分调整更新，请以当前最新版为准。</div>

## Demo 体验


<div class="alert info">点击<a href="https://webdemo.agora.io/agora-web-showcase/examples/Agora-RTM-Tutorial-Web/">在线体验</a>试用Agora RTM Tutorial for Web功能。</div>

你可以到 GitHub 下载最新版的 [Agora-RTM-Tutorial-for-Web](https://github.com/AgoraIO/RTM/tree/master/Agora-RTM-Tutorial-Web) 查看完整的源码和代码逻辑


## 开发环境要求


 
- 安装一款 Agora RTM Web SDK 支持的浏览器，如下表所示：



| 平台             | 兼容性 |
| :------------------- | :----------------- |
| Chrome 49+ | ✔                  |
| Android Browser 4.4.3+ | ✔     |
| Safari 9+   | ✔                  |
| Internet Explorer 11+  | ✔                  |
| Firefox 52+ |  ✔                  |
| 微信浏览器 |  ✔                  |
| QQ 浏览器 10.5+ |  ✔                  |




- 一个有效的 [Agora 开发者账号](https://sso.agora.io/en/signup)。

<div class="alert note">如果你的网络环境部署了防火墙，请根据<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">应用企业防火墙限制</a >打开相关端口并设置域名白名单。</div> 


## 设置开发环境

本节介绍如何获取 App ID 并将 Agora RTM SDK for Web 集成至你的项目中。

### <a name="appid"></a> 获取 App ID


参考以下步骤获取一个 App ID。若已有App ID，可以直接查看[集成客户端](#integrate)。

<details>
	<summary><font color="#3ab7f8">获取 App ID</font></summary>

1. 进入[控制台](https://console.agora.io/)，并按照屏幕提示注册账号并登录控制台。详见[创建新账号](sign_in_and_sign_up)。

2. 点击左侧导航栏的 ![](https://web-cdn.agora.io/docs-files/1551254998344) 图标进入[项目管理](https://console.agora.io/projects)页面，点击**创建**按钮。

![](https://web-cdn.agora.io/docs-files/1574156100068)

3. 在弹出的对话框内输入**项目名称**，选择 App ID 作为**鉴权机制**，再点击“提交”。

![](https://web-cdn.agora.io/docs-files/1574921599254)

4. 项目创建成功后，你会在**项目列表**下看到刚刚创建的项目，并找到对应的 App ID。

![](https://web-cdn.agora.io/docs-files/1574921811175)




</details>

### <a name="integrate"></a>集成客户端

#### 方法 1：从官网获取 SDK

使用 \<script\> 方法引入的 SDK 会在 <code>window</code> 上生成名为 <code>AgoraRTM</code> 的全局变量。



1. 从 Agora 官方网站下载最新版 [Agora RTM SDK for Web](/cn/Real-time-Messaging/downloads) 压缩包。
2. 将下载下来的压缩包中路径为 `libs/agora-rtm-sdk-1.2.2.js` 的文件保存到你所操作的项目下。
3. 在项目相应的前端页面文件中，对刚才保存的 SDK 文件进行引用（其中 `/path/to/agora-rtm-sdk-1.2.2.js` 替换为可访问的 SDK 公开网址）：

    ```html
    <script src="/path/to/agora-rtm-sdk-1.2.2.js"></script>
    ```

<details>
	<summary><font color="#3ab7f8">（可选）开启智能提示和类型检查</font></summary>

使用 `<script>` 标签引入后，可以在 JavaScript/TypeScript 代码中使用全局 `AgoraRTM` 变量，但无法开启智能提示和类型检查。

可以通过下面的步骤开启上述功能：

1. 将压缩包中路径为 `libs/agora-rtm-sdk.d.ts` 的文件保存到你所操作的项目下。
2. 在 JavaScript/TypeScript 文件开头加入下面的注释（其中 `path/to/agora-rtm-sdk.d.ts` 替换为 `agora-rtm-sdk.d.ts` 所在本地路径）：

```JavaScript
/// <reference path="path/to/agora-rtm-sdk.d.ts" />
```
</details>
	
#### 方法 2：通过 npm 引入

该方法需要安装 npm。详见 [Install npm](https://www.npmjs.com/get-npm)。

1. 安装最新版的 SDK：
`npm i agora-rtm-sdk`
2. 导出 AgoraRTM 模块：
`import AgoraRTM from 'agora-rtm-sdk'`

## 实时消息和基本频道操作

本节主要提供实现实时消息和基本频道操作的示例代码以及相关注意事项。

### 初始化

登入 RTM 之前，调用 `AgoraRTM.createInstance` 方法创建一个 `RtmClient` 实例。

创建实例需要填⼊准备好的 App ID, 只有 App ID 相同的应⽤才能互通。
> 示例代码中的 `client` 变量为 RtmClient 实例，下同。

```JavaScript
const client = AgoraRTM.createInstance('<APPID>');
```

#### 监听连接状态改变

通过监听 `RtmClient` 上的 `ConnectionStateChanged` 事件可以获得 SDK 连接状态改变的通知。

```JavaScript
client.on('ConnectionStateChanged', (newState, reason) => {
  console.log('on connection state changed to ' + newState + ' reason: ' + reason);
});
```

### 登录
	
![](https://web-cdn.agora.io/docs-files/1583998779687)

Web 应用必须在登录 RTM 服务器之后，才可以使用 RTM 的点对点消息和群聊功能。

在 `client.login` 方法中传入一个有如下属性的对象：

* `token`: 如果安全要求不高，不填或将参数值设为 null；如果安全要求高，传入从你的服务端获得的 token 值。Token 需要在应用程序的服务器端生成，具体生成办法，详见 [校验用户权限](/cn/Real-time-Messaging/rtm_token?platform=All%20Platforms)。
* `uid`: User ID 为字符串，必须是可见字符（可以带空格），不能为空或者多于64个字符，也不能是字符串 “null”。

该方法的返回值为 Promise。使用该 Promise 上的 `then` 方法传入回调；使用 `catch` 方法捕获异常并处理。也可以使用 ES7 的 `async/await` 语法来进行 SDK 异步方法的调用，这样就可以使用同步 `try/catch` 块来捕获异常（其他返回 Promise 的异步 API 也均如此）。

> 示例代码中均使用 then/catch 方法传入回调与捕获异常。

```JavaScript
client.login({ token: '<TOKEN>', uid: '<UID>' }).then(() => {
  console.log('AgoraRTM client login success');
}).catch(err => {
  console.log('AgoraRTM client login failure', err);
});
```

如果需要退出登录，可以调用 logout 方法，退出登录之后可以调用 login 重新登录或者切换账号。

```JavaScript
client.logout();
```

### 点对点消息

![](https://web-cdn.agora.io/docs-files/1583942817585)

App 在成功登录 RTM 服务器之后，可以开始使用 RTM 的点对点消息功能。

#### 发送点对点消息

调用 `client` 上的 `sendMessageToPeer` 方法发送点对点消息。在该方法中：

* 传入目标消息接收方的用户账号 ID。
* 传入符合 `RtmMessage` 接口的参数对象。

该方法返回一个 Promise：  
该 Promise 执行（resolve）的值指示消息接收方是否已收到该消息。  
该 Promise 拒绝（reject）的情况可能为超时、服务器拒绝或连接失败等。

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

#### 接收点对点消息

监听 `client` 上的事件 `MessageFromPeer` 接收点对点消息。

```JavaScript
client.on('MessageFromPeer', ({ text }, peerId) => { // text 为消息文本，peerId 是消息发送方 User ID
  /* 收到点对点消息的处理逻辑 */
});
```

### 频道消息

#### 创建并加入频道
	
![](https://web-cdn.agora.io/docs-files/1583942850227)

创建频道：

```JavaScript
const channel = client.createChannel('<CHANNEL_ID>'); // 此处传入频道 ID
```

加入频道（channel 为刚才创建的频道实例，每个频道 ID 都需要创建一个独立的频道实例，下同）：

```JavaScript
channel.join().then(() => {
  /* 加入频道成功的处理逻辑 */
}).catch(error => {
  /* 加入频道失败的处理逻辑 */
});
```

#### 发送频道消息
	
![](https://web-cdn.agora.io/docs-files/1583942885608)

加入频道成功后可发送频道消息。

```JavaScript
channel.sendMessage({ text: 'test channel message' }).then(() => {
  /* 频道消息发送成功的处理逻辑 */
}).catch(error => {
  /* 频道消息发送失败的处理逻辑 */
});
```

#### 接收频道消息

加入频道后可通过监听 `RtmChannel` 实例上的 `ChannelMessage` 事件接收到频道消息。

```JavaScript
channel.on('ChannelMessage', ({ text }, senderId) => { // text 为收到的频道消息文本，senderId 为发送方的 User ID
  /* 收到频道消息的处理逻辑 */
});
```


#### 退出频道

调用实例的 leave 方法可以退出该频道。退出频道之后可以调用 join 方法再重新加入频道。

```JavaScript
channel.leave();
```
## 开发注意事项
	

- RTM 支持多个相互独立的 [RtmClient](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html) 实例。

- 在收发点对点消息或进行其他频道操作前，请确保你已成功登录 Agora RTM 系统。

- 使用频道核心功能前必须通过调用 [createChannel](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#createchannel) 方法创建频道实例。
- 你可以创建多个 [RtmClient](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html) 客户端实例，但是每个客户端实例最多只能同时加入 20 个频道。每个频道都应有不同的 `channelId` 参数。

- 当你不再使用某个实例时，可以通过调用继承的 `removeAllListeners` 方法删除它的所有监听函数。 

- 接收到的 [RtmMessage](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmmessage.html) 消息对象不能重复利用再用于发送。


	
	