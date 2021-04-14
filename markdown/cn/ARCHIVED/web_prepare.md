---
title: 集成客户端
platform: Web
updatedAt: 2020-09-11 15:18:59
---
本文介绍在正式使用 Agora Web SDK 进行音视频通话前，需要准备的开发环境，包含前提条件及 SDK 集成方法等内容。

## 前提条件

1. 查看下表安装一款 Agora Web SDK 支持的浏览器。
  <table>
  <tr>
    <th>平台</th>
    <th>Chrome 58+</th>
    <th>Firefox 56+</th>
    <th>Safari 11+</th>
    <th>Opera 45+</th>
    <th>QQ 浏览器 10.5+</th>
    <th>360 安全浏览器</th>
    <th>Edge 浏览器 80+</th>
  </tr>
  <tr>
    <td>Android 4.1+</td>
		<td><font color="green">✔<sup>[1]</sup></td>
    <td><font color="red">✘</td>
		<td><b>N/A</b></td>
    <td><font color="red">✘</td>
    <td><font color="red">✘</td>
    <td><font color="red">✘</td>
    <td><font color="red">✘</td>
  </tr>
  <tr>
    <td>iOS 11+</td>
    <td><font color="red">✘</td>
    <td><font color="red">✘</td>
		<td><font color="green">✔<sup>[2]</sup></td>
    <td><font color="red">✘</td>
    <td><font color="red">✘</td>
    <td><font color="red">✘</td>
    <td><font color="red">✘</td>
  </tr>
  <tr>
    <td>macOS 10+</td>
    <td><font color="green">✔</td>
    <td><font color="green">✔</td>
    <td><font color="green">✔</td>
    <td><font color="green">✔</td>
    <td><font color="green">✔</td>
    <td><font color="red">✘</td>
    <td><font color="red">✘</td>
  </tr>
  <tr>
    <td>Windows 7+</td>
    <td><font color="green">✔</td>
    <td><font color="green">✔</td>
		<td><b>N/A</b></td>
    <td><font color="green">✔</td>
    <td><font color="green">✔</td>
    <td><font color="green">✔</td>
    <td><font color="green">✔</td>
  </tr>
</table>

<div class="alert warning">[1] Android Chrome 对 H.264 的支持依赖硬件，部分 Android 设备不支持 H.264 编解码。<br>
	[2] iOS Safari 上存在较多<a href="/cn/faq/browser_support#ios">已知问题</a>，Agora 不推荐使用。你可以使用 <a href="https://docs.agora.io/cn/Interactive%20Broadcast/downloads">Agora iOS SDK</a> 在 iOS 上实现实时音视频功能。</div>

<div class="alert warning">以下场景中请务必将 Agora Web SDK 升级至最新版本:
	<li>iOS 12.1.4 及以上版本使用 Safari 浏览器。</li>
	<li>macOS 上使用 Safari 12.1 及以上版本。</li>
	</div>
	
除上表浏览器外，还有以下支持：

- Agora Web SDK 2.5 及以上版本支持 Windows XP 平台的 Chrome 49 版本浏览器（仅支持 VP8 编解码，不能与 Native SDK 互通）。
- Agora Web SDK 理论上还支持 360 极速浏览器，但未经过验证，不保证全部功能正常工作。

2. 请确保已打开特定端口，详见 [防火墙说明](/cn/Agora%20Platform/firewall) 。
3. 请确保你已知悉发版说明中列出的问题，详见 [已知问题和局限](release_web_video) 及 [常见问题回答](websdk_related_faq)。

## 创建 Agora 账号并获取 App ID

1. 进入[控制台](https://console.agora.io/)，并按照屏幕提示注册账号并登录控制台。详见[创建新账号](sign_in_and_sign_up)。

2. 点击左侧导航栏的 ![](https://web-cdn.agora.io/docs-files/1551254998344) 图标进入[项目管理](https://console.agora.io/projects)页面，点击**创建**按钮。

![](https://web-cdn.agora.io/docs-files/1574156100068)

3. 在弹出的对话框内输入**项目名称**，选择 App ID 作为**鉴权机制**，再点击“提交”。

![](https://web-cdn.agora.io/docs-files/1574921599254)

4. 项目创建成功后，你会在**项目列表**下看到刚刚创建的项目，并找到对应的 App ID。

![](https://web-cdn.agora.io/docs-files/1574921811175)





## 获取 Agora Web SDK 安装包并保存到项目下

选择如下任意一种方法获取 Agora Web SDK，并保存在你所工作的项目下：

### 方法 1. 使用 npm 获取安装包

使用该方法需要先安装 npm，详见[ npm 快速入门](https://www.npmjs.com.cn/getting-started/installing-node/)。

1. 运行安装命令
  `npm install agora-rtc-sdk`

	
2. 在你的项目文件开头添加以下代码

	```javascript
	import AgoraRTC from 'agora-rtc-sdk'
	```

### 方法 2. 使用 CDN 方法获取安装包

该方法无需在官网下载安装包。在项目相应的前端页面文件中，将如下代码添加到 `</body>` 上一行：

 ```javascript
<script src="http://cdn.agora.io/sdk/web/AgoraRTCSDK-2.5-latest.js"></script>
	```

### 方法 3. 从官网获取安装包

1. 从 Agora 官方网站 [下载](https://docs.agora.io/cn/Agora%20Platform/downloads) 最新版 Agora Web SDK 软件包。

	<img alt="../_images/web_sdk_download.png" src="https://web-cdn.agora.io/docs-files/cn/web_sdk_download.png" style="width: 500px"/>

2. 将下载下来的软件包中的 `AgoraRTCSDK-2.5.js` 文件保存到你所操作的项目下。
3. 在项目相应的前端页面文件中，对 `AgoraRTCSDK-2.5.js` 进行引用。

	<img alt="../_images/web_sdk_reference.jpg" src="https://web-cdn.agora.io/docs-files/cn/web_sdk_reference.jpg" />

> 此处的截图仅供参考，安装时请使用最新版的 SDK 和链接地址。

## 准备网页服务器

1. 安装本地网页服务器，如 Apache、 Nginx 或 Node.js 等。
2. 将下载下来的 Agora Web SDK 部署到网页服务器上。
3. 在网页服务器上用浏览器打开示例程序页面或者你自己创建的页面。

你已经完成了客户端集成，可以开始使用 Agora SDK 了。