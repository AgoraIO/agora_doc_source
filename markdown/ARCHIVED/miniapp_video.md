---
title: 集成客户端
platform: 微信小程序
updatedAt: 2019-11-25 18:14:10
---
## 前提条件

请确保满足以下开发环境要求：

-   请确保已安装 [微信开发者工具](https://mp.weixin.qq.com/debug/wxadoc/dev/devtools/devtools.html?t=2018323)。

-   请确保你的微信小程序基础库支持 `live-pusher` 及 `live-player` 组件，且这两个组件在微信开发者工具中打开。

-   请确保在微信公众平台账号的开发设置中，给予以下域名请求权限：

	```
	https://miniapp.agoraio.cn
	https://miniapp-1.agoraio.cn
	https://miniapp-2.agoraio.cn
	https://miniapp-3.agoraio.cn
	https://miniapp-4.agoraio.cn
	https://uni-webcollector.agora.io
	wss://miniapp.agoraio.cn
	```

-   请确保在使用 Agora 相关功能及服务前，已打开特定端口，详见 [防火墙说明](/cn/Agora%20Platform/firewall)。


> 在集成微信小程序组件之前，Agora 建议你先阅读 [微信小程序开发官方文档](https://mp.weixin.qq.com/debug/wxadoc/dev/)。

## 创建 Agora 账号并获取 App ID

1.  进入 [https://dashboard.agora.io/](https://dashboard.agora.io/) ，按照屏幕提示创建一个开发者账号。

2.  登录 Dashboard 页面，点击 **添加新项目**。

	<img alt="../_images/appid_1.jpg" src="https://web-cdn.agora.io/docs-files/cn/appid_1.jpg" />

3.  填写 **项目名**，然后点击 **提交**。

4.  在你创建的项目下，查看并获取该项目对应的 **App ID**。

	<img alt="../_images/appid_2.jpg" src="https://web-cdn.agora.io/docs-files/cn/appid_2.jpg" />

5.  联系 [sales@agora.io](mailto:sales@agora.io) 为该 App ID 开通小程序权限。


## 创建微信小程序组件

在微信小程序中实现音视频功能，需要使用微信的 [live-player 组件](#live_player) 和 [live-pusher 组件](#live_pusher)。

<a name = "live_player"></a>
### live-player 组件

该组件用于实现微信小程序的实时音视频播放功能。开发者在创建该组件后，还需要在 js 文件中调用 API 接口对应的组件来实现该功能。详见 [微信小程序 API 说明](https://mp.weixin.qq.com/debug/wxadoc/dev/api/api-live-player.html)。

声网小程序中，创建 live-player 的示例代码如下：

```
<live-player
    id="player"
    src="{{rtmp 播放地址}}"
    mode="RTC"
    bindstatechange="playerStateChange"
    object-fit="fillCrop" />
```

<a name = "live_pusher"></a>
### live-pusher 组件

该组件用于实现微信小程序的实时音视频录制功能。开发者在创建该组件后，还需要在 js 文件中调用 API 接口对应的组件来实现该功能。详见 [微信小程序 API 说明](https://mp.weixin.qq.com/debug/wxadoc/dev/api/api-live-pusher.html)。

声网小程序中，创建 `live-pusher` 的示例代码如下：

```
<live-pusher
    url="{{rtmp 推流地址}}"
    mode="RTC"
    bindstatechange="recorderStateChange" />
```

## 集成小程序 SDK

1.  [下载](https://docs.agora.io/cn/Agora%20Platform/downloads) 声网小程序 SDK 并解压。

2.  将 SDK 包中到的 mini-app-sdk-production 文件复制到你的小程序项目文件夹中。

3.  使用 `require` 将小程序 SDK 集成到项目中：


```
const AgoraMiniappSDK = require('../../lib/mini-app-sdk-production.js');
```

其中 `../../lib/mini-app-sdk-production.js` 为你的 js 文件本地路径。

## 相关文档

完成了客户端集成后，你可以使用 Agora SDK，参考左侧《快速开始》菜单栏下的步骤，并结合下图中的 API 调用顺序，进行通话/直播：

![](https://web-cdn.agora.io/docs-files/1541990512316)

如果在使用过程中遇到问题，请参考[小程序 SDK 常见问题回答](/cn/Agora%20Platform/wechat_how_to)排除解决。