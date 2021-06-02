---
title: 实现视频通话
platform: Web
updatedAt: 2021-03-26 08:35:41
---
根据本文指导快速集成 Agora Web SDK 并在你自己的 app 里实现实时音视频通话。

本文会详细介绍如何建立一个简单的项目并使用 Agora Web SDK 实现基础的一对一视频通话。我们建议你阅读本文以快速了解 Agora 的核心方法。

<div class="alert warning">由于浏览器的安全策略对除 127.0.0.1 以外的 HTTP 地址作了限制，Agora Web SDK 仅支持 HTTPS 协议或者 http://localhost（http://127.0.0.1），请勿使用 HTTP 协议部署你的项目。</div>

## 示例项目
我们在 GitHub 上提供一个开源的基础一对一视频通话[示例项目](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-Web-Tutorial-1to1)供你参考。

同时，你可以通过我们的[在线 demo](https://webdemo.agora.io/agora-web-showcase/examples/Agora-Web-Tutorial-1to1-Web/) 快速体验 Agora 实现的音视频通话效果。

## 前提条件

1. 安装一款 Agora Web SDK 支持的浏览器，如下表所示：

   | 平台         | Chrome 58+ | Firefox 56+ | Safari 11+ | Opera 45+ | QQ 浏览器最新版 | 360 安全浏览器 | 微信浏览器 |
   | ------------ | ---------- | ----------- | ---------- | --------- | --------------- | -------------- | ---------- |
   | Android 4.1+ | ✔          | ✘           | **N/A**    | ✘         | ✘               | ✘              | ✘          |
   | iOS 11+      | ✘          | ✘           | ✔          | ✘         | ✘               | ✘              | ✘          |
   | macOS 10+    | ✔          | ✔           | ✔          | ✔         | ✔               | ✘              | ✘          |
   | Windows 7+   | ✔          | ✔           | **N/A**    | ✔         | ✔               | ✔              | ✘          |

2. 获得一个有效的 Agora 账号。 （免费[注册](https://sso.agora.io/cn/signup)）

<div class="alert note">如果你的网络环境部署了防火墙，请根据<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">应用企业防火墙限制</a>打开相关端口。</div>

## 设置开发环境

你需要准备一个自己的项目并且将 Agora Web SDK 集成到其中。

### 创建 Web 项目

如果你已经有一个 Web 项目了，跳过该节，直接阅读**集成 SDK**。

<div class="alert note">我们提供的示例代码使用了一些第三方的库文件来实现页面的样式和布局，你可以点击以下链接获得文件，或者使用其他方式实现。<li><a href="https://github.com/AgoraIO/Basic-Video-Call/blob/master/One-to-One-Video/Agora-Web-Tutorial-1to1/assets/common.css">common.css</a></li>
	<li><a href="https://github.com/AgoraIO/Basic-Video-Call/blob/master/One-to-One-Video/Agora-Web-Tutorial-1to1/vendor/jquery.min.js">jquery.min.js</a></li>
	<li><a href="https://github.com/AgoraIO/Basic-Video-Call/blob/master/One-to-One-Video/Agora-Web-Tutorial-1to1/vendor/materialize.min.js">materialize.min.js</a></li>
	</div>	

<details>
	<summary><font color="#3ab7f8">点击查看示例代码</font></summary>
这个项目只需要用到一个 HTML 文件。
	
1. 新建一个 HTML 文件。这里我们将文件命名为 index.html（以下简称项目文件）。
2. 用一个代码编辑器（例如 VS Code）打开该文件。
3. 复制以下代码，粘贴到项目文件中。
   该步骤会为你的项目创建前端页面的 UI。这里我们直接用了 Agora 示例项目中的代码，你也可以自定义你的 UI。
	```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Basic Communication</title>
  <link rel="stylesheet" href="./assets/common.css" />
</head>
<body class="agora-theme">
  <div class="navbar-fixed">
    <nav class="agora-navbar">
      <div class="nav-wrapper agora-primary-bg valign-wrapper">
        <h5 class="left-align">Basic Communication</h5>
      </div>
    </nav>
  </div>
  <form id="form" class="row col l12 s12">
    <div class="row container col l12 s12">
      <div class="col" style="min-width: 433px; max-width: 443px">
        <div class="card" style="margin-top: 0px; margin-bottom: 0px;">
          <div class="row card-content" style="margin-bottom: 0px;">
              <div class="input-field">
                <label for="appID" class="active">App ID</label>
                <input type="text" placeholder="App ID" name="appID">
              </div>
              <div class="input-field">
                <label for="channel" class="active">Channel</label>
                <input type="text" placeholder="channel" name="channel">
              </div>
              <div class="input-field">
                <label for="token" class="active">Token</label>
                <input type="text" placeholder="token" name="token">
              </div>
              <div class="row" style="margin: 0">
                <div class="col s12">
                <button class="btn btn-raised btn-primary waves-effect waves-light" id="join">JOIN</button>
                <button class="btn btn-raised btn-primary waves-effect waves-light" id="leave">LEAVE</button>
                <button class="btn btn-raised btn-primary waves-effect waves-light" id="publish">PUBLISH</button>
                <button class="btn btn-raised btn-primary waves-effect waves-light" id="unpublish">UNPUBLISH</button>
                </div>
              </div>
          </div>
        </div>
      </div>
      <div class="col s7">
        <div class="video-grid" id="video">
          <div class="video-view">
            <div id="local_stream" class="video-placeholder"></div>
            <div id="local_video_info" class="video-profile hide"></div>
            <div id="video_autoplay_local" class="autoplay-fallback hide"></div>
          </div>
        </div>
      </div>
    </div>
  </form>
<script src="vendor/jquery.min.js"></script>
<script src="vendor/materialize.min.js"></script>
</body>
</html>
```
</details>

### 集成 SDK

选择如下任意一种方法获取 Agora Web SDK：

#### 方法 1. 使用 npm 获取 SDK

使用该方法需要先安装 npm，详见 [npm 快速入门](https://www.npmjs.com.cn/getting-started/installing-node/)。

1. 运行安装命令

   ```bash
   npm install agora-rtc-sdk
   ```

2. 在你的项目的 Javascript 代码中添加一行：

   ```javascript
   import AgoraRTC from 'agora-rtc-sdk'
   ```

#### 方法 2. 使用 CDN 方法获取 SDK

该方法无需下载安装包。在项目文件中，将以下代码添加到 `<style>` 上一行：

```javascript
<script src="https://cdn.agora.io/sdk/release/AgoraRTCSDK-3.0.0.js"></script>
```

#### 方法 3. 从官网获取 SDK

1. [下载](https://docs.agora.io/cn/Agora%20Platform/downloads)最新版 Agora Web SDK 软件包。

2. 将下载下来的软件包中的 `AgoraRTCSDK-3.0.0.js` 文件保存到项目文件所在的目录下。

3. 在项目文件中，将如下代码添加到 `<style>` 上一行：

   ```javascript
   <script src="./AgoraRTCSDK-3.0.0.js"></script>
   ```

为方便起见，这里我们选择第二种方法，直接使用 CDN 链接。

现在，我们已经将 Agora Web SDK 集成到项目中了。接下来我们要通过调用 Agora Web SDK 提供的核心 API 实现基础的音视频通话功能。

## 实现音视频通话

本节介绍如何使用 Agora Web SDK 实现音视频通话。

在使用 Agora Web SDK 时，你会经常用到以下两种对象：

- Client 对象，代表一个本地客户端。Client 类的方法提供了音视频通话的主要功能，例如加入频道、发布音视频流等。
- Stream 对象，代表本地和远端的音视频流。Stream 类的方法用于定义音视频流对象的行为，例如流的播放控制、音视频的编码配置等。调用 Stream 方法时，请注意区分本地流和远端流对象。

下图展示了基础的一对一音视频通话的 API 调用。注意图中的方法是对不同的对象调用的。

![](https://web-cdn.agora.io/docs-files/1568094608983)

> 本文只介绍 Agora Web SDK 最基础的方法和回调。完整的 API 方法和回调详见 [Web API 参考](./API%20Reference/web/index.html)。

为方便起见，我们为下面要用到的示例代码定义了两个变量。此步骤不是必须的，你可以根据你的项目有其他的实现。

```javascript
// rtc object
var rtc = {
  client: null,
  joined: false,
  published: false,
  localStream: null,
  remoteStreams: [],
  params: {}
};
 
// Options for joining a channel
var option = {
  appID: "Your App ID",
  channel: "Channel name",
  uid: null,
  token: "Your token"
}
```



### 加入频道

1. 加入频道前，我们需要先创建并初始化一个客户端对象。

   ```javascript
   // Create a client
   rtc.client = AgoraRTC.createClient({mode: "rtc", codec: "h264"});
   
   // Initialize the client
   rtc.client.init(option.appID, function () {
     console.log("init success");
     }, (err) => {
     console.error(err);
   });
   ```

   在 `AgoraRTC.createClient` 方法中，需注意 `mode` 和 `codec` 这两个参数的设置：

   - `mode` 用于设置[频道模式](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms%23live-broadcast-core-concepts#频道模式)。一对一或多人通话中，建议设为 `"rtc"` ，使用通信模式；[互动直播](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms%23live-broadcast-core-concepts#a-name-livea直播核心概念)中，建议设为 `"live"`，使用直播模式。
   - `codec` 用于设置浏览器使用的编解码格式。如果你需要使用 Safari 12.1 及之前版本，将该参数设为 `"h264"`；如果你需要在手机上使用 Agora Web SDK，请参考[移动端使用 Web SDK](https://docs.agora.io/cn/faq/web_on_mobile)。
   
你需要在该步骤中填入项目的 App ID。请参考如下步骤在控制台[创建 Agora 项目](https://docs.agora.io/cn/Agora%20Platform/manage_projects?platform=All%20Platforms)并获取 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id )。

1. 登录[控制台](https://console.agora.io/)，点击左侧导航栏的**[项目管理](https://console.agora.io/projects)**图标 ![](https://web-cdn.agora.io/docs-files/1551254998344)。
2. 点击**创建**，按照屏幕提示设置项目名，选择一种鉴权机制，然后点击**提交**。
3. 在**项目管理**页面，你可以获取该项目的 **App ID**。
	 
<div class="alert note">为方便演示，我们的示例项目在网页上设置了一个文本框用于输入 App ID。在实际的应用中，App ID 应该是在代码中填写的。</div> 

2. 在 `Client.init` 的 `onSuccess` 回调中调用 `Client.join` 加入频道。

   ```javascript
   // Join a channel
   rtc.client.join(option.token ? option.token : null, option.channel, option.uid ? +option.uid : null, function (uid) {
       console.log("join channel: " + option.channel + " success, uid: " + uid);
       rtc.params.uid = uid;
     }, function(err) {
       console.error("client join failed", err)
   })
   ```

	在 `Client.join` 中注意以下参数的设置：

	- `token`: 该参数为可选。如果你的 Agora 项目开启了 App 证书，你需要在该参数中传入一个 Token，详见 [使用 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#使用-token)。
		- 在测试环境，我们推荐使用控制台生成临时 Token，详见[获取临时 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms%23get-a-temporary-token#获取临时-token)。
		- 在生产环境，我们推荐你在自己的服务端生成 Token，详见 [生成 Token](./token_server).
	- `channel`: 频道名，长度在 64 字节以内的字符串。
	- `uid`: 用户 ID，频道内每个用户的 UID 必须是唯一的。如果你将 `uid` 设为 `null`，Agora 会自动分配一个 UID 并在 `onSuccess` 回调中返回。

  更多的参数设置注意事项请参考 [`Client.join`](./API%20Reference/web/interfaces/agorartc.client.html#join) 接口中的参数描述。

### 发布本地流

1. 在`Client.join` 的 `onSuccess` 回调中调用 `AgoraRTC.createStream` 方法创建一个本地音视频流。

   在创建流时，通过设置 `audio` 和 `video` 参数来控制是否发布音频和视频。

   ```javascript
   // Create a local stream
   rtc.localStream = AgoraRTC.createStream({
     streamID: rtc.params.uid,
     audio: true,
     video: true,
     screen: false,
   })
   ```

2. 调用 `Stream.init` 方法初始化创建的流。

   ```javascript
   // Initialize the local stream
   rtc.localStream.init(function () {
     console.log("init local stream success");
   }, function (err) {
     console.error("init local stream failed ", err);
   })
   ```

   在初始化流时，浏览器会跳出弹窗要求摄像头和麦克风权限，请确保授权。

3. 在 `Stream.init` 的 `onSuccess` 回调中调用 `Client.publish` 方法，发布本地流。

   ```javascript
   // Publish the local stream
   rtc.client.publish(rtc.localStream, function (err) {
     console.log("publish failed");
     console.error(err);
   })
   ```

### 订阅远端流

当远端流加入频道时，会触发 `stream-added` 事件，我们需要通过 `Client.on` 监听该事件并在回调中订阅新加入的远端流。

<div class="alert note">我们建议在创建客户端对象之后立即监听事件。</div>

1. 监听 `"stream-added"` 事件，当有远端流加入时订阅该流。

   ```javascript
   rtc.client.on("stream-added", function (evt) {  
     var remoteStream = evt.stream;
     var id = remoteStream.getId();
     if (id !== rtc.params.uid) {
       rtc.client.subscribe(remoteStream, function (err) {
         console.log("stream subscribe failed", err);
       })
     }
     console.log('stream-added remote-uid: ', id);
   });
   ```

2. 监听 `"stream-subscribed"` 事件，订阅成功后播放远端流。

   ```javascript
   rtc.client.on("stream-subscribed", function (evt) {
     var remoteStream = evt.stream;
     var id = remoteStream.getId();
     // Add a view for the remote stream.
     addView(id);
     // Play the remote stream.
     remoteStream.play("remote_video_" + id);
     console.log('stream-subscribed remote-uid: ', id);
   })
   ```
<div class="alert note">受浏览器策略影响，在 Chrome 70+ 和 Safari 浏览器上，<code>Stream.play</code> 方法必须由用户手势触发，详情请参考 <a href="autoplay_policy_web">处理浏览器的自动播放策略</a>。</div>
3. 监听 `"stream-removed"` 事件，当远端流被移除时（例如远端用户调用了 `Stream.unpublish`）， 停止播放该流并移除它的画面。

   ```javascript
   rtc.client.on("stream-removed", function (evt) {
     var remoteStream = evt.stream;
     var id = remoteStream.getId();
     // Stop playing the remote stream.
     remoteStream.stop("remote_video_" + id);
     // Remove the view of the remote stream. 
     removeView(id);
     console.log('stream-removed remote-uid: ', id);
   })
   ```

我们建议在创建客户端对象之后立即监听事件。

> 你需要自己实现 `addView` 和 `removeView` 的功能，可以参考我们的[示例项目](https://github.com/AgoraIO/Basic-Video-Call/blob/5eeadc97f646a5e2bf4c11e42edea47af8b963fe/One-to-One-Video/Agora-Web-Tutorial-1to1/index.html#L191)。

### 离开频道

调用 `Client.leave` 方法离开频道。

```javascript
// Leave the channel
rtc.client.leave(function () {
  // Stop playing the local stream
  rtc.localStream.stop();
  // Close the local stream
  rtc.localStream.close();
  // Stop playing the remote streams and remove the views
  while (rtc.remoteStreams.length > 0) {
    var stream = rtc.remoteStreams.shift();
    var id = stream.getId();
    stream.stop();
    removeView(id);
  }
  console.log("client leaves channel success");
}, function (err) {
  console.log("channel leave failed");
  console.error(err);
})
```

## 运行你的 app

本节以我们的示例项目为例说明如何运行和测试你的 web app。

我们建议在本地 Web 服务器上测试你的 app。这里我们用 npm 的 live-server 设置一个本地 服务器。
<div class="alert note">在本地服务器（localhost）运行 web app 仅作为测试用途。部署生产环境时，请确保使用 HTTPS 协议。</div>

1. 安装 live-server。
   ```bash
npm i live-server -g
	 ```
2. 在命令行中进入你的项目所在的目录。对于我们的示例项目，该目录位于 **/Basic-Video-Call/One-to-One-Video/Agora-Web-Tutorial-1to1**。
3. 运行 app。
   ```bash
live-server .
	 ```

   现在你的浏览器应该会自动打开你的 web app 页面。

4. 输入你的 App ID，频道名，token，点击 **JOIN** 开始通话。
   你可能需要给浏览器摄像头和麦克风权限。如果在创建本地流时打开了视频，你现在应该可以看到自己的视频画面。

5. 在浏览器中打开另一个页面，输入相同的 URL 地址。点击 **JOIN** 按钮。现在你应该可以看到两个视频画面。

如果页面没有正常工作，可以打开浏览器的控制台查看错误信息进行排查。常见的错误信息包括：
- `INVALID_VENDOR_KEY`：App ID 错误，检查你填写的 App ID。
- `ERR_DYNAMIC_USE_STATIC_KE`：你的 Agora 项目启用了 App 证书，需要在加入频道时填写 Token。
- `Media access:NotFoundError`：检查你的摄像头和麦克风是否正常工作。
- `MEDIA_NOT_SUPPORT`：请使用 HTTPS 协议 或者 localhost。

<div class="alert warning">Agora Web SDK 不支持在浏览器上模拟移动设备调试。</div>

