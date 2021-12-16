---
title: 创建并初始化 Client 对象
platform: Web
updatedAt: 2019-03-26 16:19:47
---
在创建并初始化 Client 对象前，请确保你已完成环境准备、安装包获取等步骤，详见[集成客户端](./web_prepare)。

1. 将下面的代码复制粘贴到 demo.html 文件中 `<script>` 下面：

   ```javascript
   function join() {
       // 创建 client 对象
       client = AgoraRTC.createClient({mode: "rtc", codec: "h264"});
   
       // 初始化 client 对象
       client.init("yourAppId", function() {
         console.log("AgoraRTC client initialized");
         }, function(err) {
         console.log("AgoraRTC client init failed", err)});
     
       // 加入频道
   
       // 订阅远端流
   } 
   ```

	在 [`AgoraRTC.createClient`](./API%20Reference/web/globals.html#createclient) 方法中，需注意 `mode` 和 `codec` 这两个参数的设置：
	- `mode` 用于设置频道模式。一对一或多人通话中，建议设为 `"rtc"` ，使用通信模式；互动直播中，建议设为 `"live"`，使用直播模式，详见 [mode](./API%20Reference/web/interfaces/agorartc.clientconfig.html#mode)。
	- `codec` 用于设置浏览器使用的编解码格式。如果你需要使用 Safari 浏览器，将该参数设为 `"h264"`；如果你需要在手机上使用 Chrome 浏览器进行通话，将该参数设为 `"vp8"`。

2. 登入 [Agora.io](https://dashboard.agora.io)，在左侧导航栏**项目**菜单下点击**项目列表**，项目页面会显示你的项目信息。

   > 如果你没有项目，点击页面右上方的**添加新项目**即可创建项目。

3. 复制你的项目的 App ID，替换上面代码中的 `yourAppId`（注意保留双引号）。

完成初始化后，我们就可以加入频道开始通话了，点击左侧菜单栏**快速开始**下的**加入频道**查看具体代码。