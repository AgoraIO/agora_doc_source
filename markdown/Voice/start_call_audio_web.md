---
title: 实现语音通话
platform: Web
updatedAt: 2021-03-26 08:36:54
---
根据本文指导快速集成 Agora Web SDK 并在你自己的 app 里实现实时音频通话。

<div class="alert info">声网已经推出下一代 Agora Web SDK (Agora Web SDK NG)，优化了 SDK 的内部架构，提高了 SDK 的可用性。Agora Web SDK NG 基于 TypeScript 开发，并使用 Promise 来管理异步操作，提供了更灵活更易用的 API 方案。Agora Web SDK NG 当前处于 Beta 阶段，点击<a href="https://agoraio-community.github.io/AgoraWebSDK-NG/zh-CN/">此处</a>抢先体验，如有问题，可直接提交 <a href="https://github.com/AgoraIO-Community/AgoraWebSDK-NG">Issue</a>。</div>

## 前提条件


- 可以连接到互联网的 Windows 或 macOS 计算机。如果你的网络环境部署了防火墙，请参考[应用企业防火墙限制](https://docs.agora.io/cn/Agora%20Platform/firewall?platform=Web)以正常使用 Agora 服务。
- 计算机搭载 2.2 GHz Intel 第二代 i3/i5/i7 处理器或同等性能的其他处理器。
- 物理音频采集设备，如内置麦克风。
- 安装最新稳定版 [Chrome 浏览器](https://www.google.cn/chrome/)。
- 有效的 Agora [开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up?platform=Web)。

## 创建 Web 项目

1. 创建一个文件夹作为音频通话应用的项目文件夹，在该文件夹下按照以下结构创建文件和目录：

   ```bash
   .
   ├── index.html
   ├── scripts
   │   └── script.js
   └── styles
      └── style.css
   ```

   其中，`index.html` 为音频通话应用的前端页面文件，`scripts` 目录下的 `script.js` 文件为实现音频通话功能的 JavaScript 代码，`styles` 目录下的 `style.css` 文件用于设置页面的样式。

2. 将以下代码复制到 `index.html` 文件中。

   ```html
   <!DOCTYPE html>
   <html>
   <head>
       <meta charset="UTF-8">
       <title>Voice Call</title>
       <link rel="stylesheet" href="./styles/style.css">
   </head>
   <body>
       <h1>
           Voice Call<br><small style="font-size: 14pt;">Powered by Agora.io</small>
       </h1>
       <h4>Local video</h4>
       <div id="me"></div>
       <h4>Remote video</h4>
       <div id="remote-container">
       </div>
       <script src="./scripts/script.js"></script>
   </body>
   </html>
   ```

3. 将以下代码复制到 `style.css` 文件中。

   ```css
   *{
       font-family: sans-serif;
   }
   h1,h4{
       text-align: center;
   }
   #me{
       position: relative;
       width: 50%;
       margin: 0 auto;
       display: block;
   }
   #me video{
       position: relative !important;
   }
   #remote-container{
       display: flex;
   }
   #remote-container video{
       height: auto;
       position: relative !important;
   }
   ```

## 获取 SDK

选择如下任意一种方法获取 Agora Web SDK：

### 方法 1. 使用 npm 获取 SDK

使用该方法需要先安装 npm，详见 [npm 快速入门](https://www.npmjs.com.cn/getting-started/installing-node/)。

1. 运行安装命令：

   ```bash
   npm install agora-rtc-sdk
   ```

2. 在项目的 JavaScript 代码中引入 `AgoraRTC` 模块：

   ```javascript
   import AgoraRTC from 'agora-rtc-sdk'
   ```

### 方法 2. 使用 CDN 方法获取 SDK

该方法无需下载安装包。在 `index.html` 中，将如下代码添加到 `<head>` 的下一行：

```
<script src="https://cdn.agora.io/sdk/release/AgoraRTCSDK-3.3.0.js"></script>
```

### 方法 3. 从官网获取 SDK

1. [下载](./downloads?platform=Web)最新版 Agora Web SDK 软件包。

2. 将下载的软件包中的 `AgoraRTCSDK-3.3.0.js` 文件保存到 `scripts` 目录下。

3. 在 `index.html` 中，将以下代码添加到 `<head>` 的下一行：

   ```javascript
   <script src="./AgoraRTCSDK-3.3.0.js"></script>
   ```

## 基本流程

现在，我们已经将 Agora Web SDK 集成到项目中了。接下来我们要在 `script.js` 文件中调用 Agora Web SDK 提供的核心 API 实现基础的视频直播功能。

在使用 Agora Web SDK 时，你会经常用到以下两种对象：

- Client 对象，代表一个本地客户端。Client 类的方法提供了音视频通话的主要功能，例如加入频道、[发布](https://docs.agora.io/cn/Agora%20Platform/terms?platform=Web#pub)音视频流等。
- Stream 对象，代表本地和远端的[媒体流](https://docs.agora.io/cn/Agora%20Platform/terms?platform=Web#media-stream)。Stream 类的方法用于定义媒体流对象的行为，例如流的播放控制、音视频的编码配置等。调用 Stream 方法时，请注意区分本地流和远端流对象。

实现一个简单的视频通话主要包括以下步骤：

1. 创建并初始化一个本地客户端对象。
2. 加入[频道](https://docs.agora.io/cn/Agora%20Platform/terms#channel)。
3. 创建本地音视频流，并发布到频道中。
4. 订阅频道中其他用户的音视频流。

下图展示了基础的一对一音频通话的 API 调用。注意图中的方法是对不同的对象调用的。

![](https://web-cdn.agora.io/docs-files/1592902110501)

为方便起见，我们先定义几个函数，用来处理错误、添加和移除远端用户的视频画面。在 `script.js` 文件开头添加以下代码：

```javascript
// 处理错误的函数
let handleError = function(err){
        console.log("Error: ", err);
};
 
// 定义远端视频画面的容器
let remoteContainer = document.getElementById("remote-container");
 
// 将视频流添加到远端视频画面容器的函数
function addVideoStream(elementId){
        // 给每个流创建一个 div
        let streamDiv = document.createElement("div");
        // 将 elementId 分配到 div
        streamDiv.id = elementId;
        // 处理镜像问题
        streamDiv.style.transform = "rotateY(180deg)";
        // 将 div 添加到容器
        remoteContainer.appendChild(streamDiv);
};
 
// 将视频流从远端视频画面容器移除的函数
function removeVideoStream(elementId) {
        let remoteDiv = document.getElementById(elementId);
        if (remoteDiv) remoteDiv.parentNode.removeChild(remoteDiv);
};
```

### 1. 创建本地客户端

创建并初始化一个用于控制通话的客户端对象。你需要将 `yourAppId` 替换为你的 Agora 项目的 App ID。详见[获取 App ID](./run_demo_live_web?platform=Web#appid)。 

```javascript
let client = AgoraRTC.createClient({
    mode: "rtc",
    codec: "vp8",
});
   
client.init("yourAppId");
```

- 在 `AgoraRTC.createClient` 方法中，需注意 `mode` 和 `codec` 这两个参数的设置：
  - `mode` 用于设置[频道场景](https://docs.agora.io/cn/Agora%20Platform/terms?platform=Web#channel-profile)。一对一或多人通话中，建议设为 `"rtc"` ，使用通信场景；互动直播中，建议设为 `"live"`，使用直播场景。
  - `codec` 用于设置浏览器使用的编解码格式。如果你需要使用 Safari 12.1 及之前版本，将该参数设为 `"h264"`；其他情况推荐设为 `"vp8"`。

### 2. 加入频道

调用 `client.join` 加入频道。

在 `client.join` 中你需要将 `yourToken` 替换成你自己生成的 Token。

- 在测试阶段，你可以直接在控制台[生成临时 Token](./run_demo_live_web?platform=Web#temptoken)。
- 在生产环境，我们推荐你在自己的服务端生成 Token，详见[在服务端生成 Token](./token_server?platform=Web)。

```javascript
// 加入频道
client.join("yourToken", "myChannel", null, (uid)=>{
    // 创建本地媒体流
}, handleError);
```

### 3. 创建并发布本地流

如果用户角色设为主播，成功加入频道后，就可以创建本地流并发布到频道了。

<div class="alert note">如果用户角色设为观众，跳过该步骤。</div>

将以下代码复制到 `client.join` 示例代码中的 `// 创建本地媒体流` 下方。

```javascript
let localStream = AgoraRTC.createStream({
    audio: true,
    video: false,
}); 
// 初始化本地流
localStream.init(()=>{
    // 播放本地流
    localStream.play("me");
    // 发布本地流
    client.publish(localStream, handleError);
}, handleError);
```

### 4. 订阅远端流

当远端流发布到频道时，会触发 `stream-added` 事件，我们需要通过 `client.on` 监听该事件并在回调中订阅新加入的远端流。

```javascript
// 有远端用户发布流时进行订阅
client.on("stream-added", function(evt){
    client.subscribe(evt.stream, handleError);
});
// 订阅成功后播放远端用户的流
client.on("stream-subscribed", function(evt){
    let stream = evt.stream;
    let streamId = String(stream.getId());
    addVideoStream(streamId);
    stream.play(streamId);
});
```

当远端用户取消发布流或者退出频道时，关闭及移除对应的流。

```javascript
// 远端用户取消发布流时，关闭及移除对应的流。
client.on("stream-removed", function(evt){
    let stream = evt.stream;
    let streamId = String(stream.getId());
    stream.close();
    removeVideoStream(streamId);
});
// 远端用户离开频道时，关闭及移除对应的流。
client.on("peer-leave", function(evt){
    let stream = evt.stream;
    let streamId = String(stream.getId());
    stream.close();
    removeVideoStream(streamId);
```



## 运行项目

我们建议在本地 Web 服务器上运行和测试你的项目。这里我们用 npm 的 live-server 设置一个本地服务器。

<div class="alert note"><li>在本地服务器（localhost）运行 Web 应用仅作为测试用途。部署生产环境时，请确保使用 HTTPS 协议。</li>
<li>由于浏览器的安全策略对除 127.0.0.1 以外的 HTTP 地址作了限制，Agora Web SDK 仅支持 HTTPS 协议或者 <code>http://localhost</code>（<code>http://127.0.0.1</code>），请勿使用 HTTP 协议部署你的项目。</li></div>

1. 安装 live-server。在命令行中运行以下命令：

   ```bash
   npm i live-server -g
   ```

2. 在命令行中进入你的项目所在的目录。

3. 运行项目。

   ```bash
   live-server .
   ```

   现在你的浏览器应该会自动打开 `index.html` 页面。

4. 浏览器会弹窗要求麦克风权限，点击**允许**。

5. 在浏览器中复制当前标签页，此时讲话应该会听到回声。

如果页面没有正常工作，可以打开浏览器的控制台查看错误信息进行排查。常见的错误信息包括：

- `INVALID_VENDOR_KEY`：App ID 或 Token 错误，检查你填写的 App ID 及 Token。
- `DYNAMIC_USE_STATIC_KEY`：你的 Agora 项目启用了 App 证书，需要在加入频道时填写 Token。
- `Media access:NotFoundError`：检查你的麦克风是否正常工作。
- `MEDIA_NOT_SUPPORT`：请使用 HTTPS 协议或者 localhost。

<div class="alert warning">Agora Web SDK 不支持在浏览器上模拟移动设备调试。</div>

## 相关链接

使用 Agora 语音通话 SDK 开发过程中，你还可以参考如下文档：

- [如何设置日志文件？](/cn/faq/logfile)
- [如何在通话应用中实现呼叫邀请通知功能？](/cn/faq/call_invite_notification)
- [常见的 Web 浏览器控制台报错](/cn/faq/console_error_web)
- [在调用 Stream.init 时设备报错](/cn/faq/streaminit_error)