---
title: 跑通示例项目
platform: 小程序
updatedAt: 2020-12-21 09:03:01
---
## 前提条件

开始前，请确保你的开发环境满足如下条件：

- 一个经过企业认证的微信小程序账号。在调试小程序 Demo 过程中，需要使用 live-pusher 和 live-player 组件。只有特定行业的认证企业账号才可以使用这两个组件。详见[小程序官网文档](https://developers.weixin.qq.com/miniprogram/dev/component/live-player.html)。
- 下载并安装最新版本的[微信开发者工具](https://developers.weixin.qq.com/miniprogram/dev/devtools/download.html)。
- 有效的 Agora [开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)。
- 至少一台安装有微信 app 的移动设备。

## 操作步骤

### 1. 获取小程序组件权限

在[微信公众平台](https://mp.weixin.qq.com/)的小程序**开发**选项中，切换到**接口设置**页签，打开**实时播放音视频流**和**实时录制音视频流**的开关。

![](https://web-cdn.agora.io/docs-files/1605069073929)

### 2. 配置服务器域名

在小程序的开发设置里，将如下域名配到服务器域名里，其中 **request 合法域名**区域填入以 https 开头的域名；**socket 合法域名**区域点入以 wss 开头的域名。

```xml
https://uni-webcollector.agora.io
wss://miniapp.agoraio.cn
https://miniapp-1.agoraio.cn
https://miniapp-2.agoraio.cn
https://miniapp-3.agoraio.cn
https://miniapp-4.agoraio.cn
```

![](https://web-cdn.agora.io/docs-files/1605069238450)

### 3. 创建 Agora 项目

按照以下步骤，在控制台创建一个 Agora 项目。

1. 登录 [Agora 控制台](https://console.agora.io/)，点击左侧导航栏 ![img](https://web-cdn.agora.io/docs-files/1594283671161) **项目管理**按钮进入**[项目管理](https://console.agora.io/projects)**页面**。**

2. 在**项目管理**页面，点击**创建**按钮。

 ![创建项目](https://web-cdn.agora.io/docs-files/1594287028966)

3. 在弹出的对话框内输入**项目名称**，选择**鉴权机制**为 **APP ID + Token。**

4. 点击**提交**，新建的项目就会显示在**项目管理**页中。

### 4. 获取 App ID

Agora 会给每个项目自动分配一个 App ID 作为项目唯一标识。

在 [Agora 控制台](https://console.agora.io/)的**项目管理**页面，找到你的项目，点击 App ID 右侧的眼睛图标就可以直接复制项目的 App ID。

![获取appid](https://web-cdn.agora.io/docs-files/1603974707121)

### 5. 生成临时 Token

为提高项目的安全性，Agora 使用 Token（动态密钥）对即将加入频道的用户进行鉴权。

为了方便测试，Agora 控制台提供生成临时 Token 的功能，具体步骤如下：

1. 在控制台的[项目管理](https://console.agora.io/projects)页面，点击已创建项目的 ![](https://web-cdn.agora.io/docs-files/1574923151660) 图标，打开 **Token** 页面。

	![](https://web-cdn.agora.io/docs-files/1574922827899)

2. 输入一个频道名，例如 test，然后点击**生成临时Token**。临时 Token 的有效期为 24 小时。加入频道时，请确保填入的频道名与生成临时 Token 时填入的频道名一致。

	![](https://web-cdn.agora.io/docs-files/1574928082984)

<div class="alert note">临时 Token 仅作为演示和测试用途。在生产环境中，你需要自行部署服务器签发 Token，详见<a href="token_server">生成 Token</a >。</div>

### 6. 开启小程序服务

第一次使用微信小程序时，需要参考如下步骤开通服务：

1. 登录 Agora [控制台](https://console.agora.io/)，点击左侧导航栏的用量图标 ![](https://web-cdn.agora.io/docs-files/1605069788924)，进入用量页面。
2. 点击页面左上角的**聚合用量**，选择需要开通小程序支持的项目名称，然后点击小程序下的**分钟数**。

	![](https://web-cdn.agora.io/docs-files/1605069848737)
	
3. 点击开启**小程序服务**，然后点击**应用**。

### 7. 获取示例项目并集成小程序 SDK

参考如下步骤获取小程序示例项目，并将小程序 SDK 集成到示例项目中。

1. 下载 [Agora-Miniapp-Tutorial](https://github.com/AgoraIO/Agora-Miniapp-Tutorial) 仓库。
2. 下载最新版[微信小程序 SDK](https://confluence.agoralab.co/pages/viewpage.action?pageId=689218002) 并解压。
3. 将解压后的 SDK 包更名为 **mini-app-sdk-production.js**，然后将其复制到 `Agora-Miniapp-Tutorial-master/lib` 路径下。
4. 打开 `Agora-Miniapp-Tutorial-master/utils/config.js` 文件，然后在 `const APPID` 行后添加你获取到的 Agora 项目 App ID。
5. 打开 `Agora-Miniapp-Tutorial-master/pages/meeting/meeting.js` 文件，将 `client.join` 和 `client.rejoin` 方法中的 `undefined` 参数修改为你获取到的临时 Token，确保需要带 ""。

### 8. 运行示例项目

参考如下步骤在微信开发者工具中运行小程序示例项目。

1. 打开**微信开发者工具**，点击小程序界面的 **+**。
2. 在弹出的界面中选择导入项目页签，然后在目录一栏中选中小程序示例项目在本地的存储路径，填入你**微信小程序的 App ID**，然后点击**导入**。

	![](https://web-cdn.agora.io/docs-files/1605070114544)
	
3. 加载成功后，微信开发者工具上会出现小程序示例项目的界面。为保证体验效果，我们建议选择**真机调试**。点击右上角的真机调试，工具界面会出现一个真机调试的二维码。

	![](https://web-cdn.agora.io/docs-files/1605070164900)
	
4. 使用移动端微信 App 扫描二维码，进入手机调试界面。填入**房间名**，然后点击**加入房间**。在弹出的对话框中点击**确定**，表示作为主播加入频道。稍等片刻，就可以在小程序的界面看到本地的视频画面。请确保此处填入的房间名，和生成临时 Token 时填入的频道名是一致的。

## 常见问题

### 客户端初始化失败

通常客户端初始化失败，会伴随错误码 901 或 903。我们建议你检查确认如下项：

- 填入 `config.js` 文件中的 App ID，确认已在控制台开启了小程序服务。
- 你的微信小程序账号需要在开发界面需要配置域名，且打开了**实时播放音视频流**和**实时录制音视频流**的开关。
- 生成临时 Token 时使用的频道名，需要和运行小程序时填入的频道名一致。