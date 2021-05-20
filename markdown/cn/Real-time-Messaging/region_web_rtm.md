---
title: 限定访问区域
platform: Web
updatedAt: 2020-12-07 07:07:51
---
## 功能描述

为适应不同国家或地区的法律法规，Agora RTM SDK 支持限定访问区域功能。你可以将 Agora RTM SDK 的数据传输限定在某一区域范围内。限定区域之后，RTM SDK 只能连接位于限定区域的 Agora RTM 服务器。

<div class="alert note">如果要设置印度为限定区域，你必须从印度的 IP 地址发起请求。否则会设置失败。</div>

## 实现方法

你需要在调用 `createInstance` 初始化 RTM 客户端时通过 `areaCodes` 参数设置限定区域。RTM SDK 支持以下区域：

- `GLOB`: （默认）全球。
- `CN`: 中国大陆。
- `NA`: 北美区域。
- `EU`: 欧洲区域。
- `AS`: 除中国大陆外的亚洲区域。
- `JP`: 日本。
- `IN`: 印度。

### 示例代码

```javascript
// 设置限定区域
AgoraRTM.createInstance('<appid>', {}, ["CN","GLOB"])；
```

##  开发注意事项

### 防火墙要求

如果你的网络环境部署了防火墙，你需要根据你指定的区域将下表中对应的域名添加到防火墙白名单，不对 IP 地址设限，且开放相应端口。

- 域名白名单

| 区域                   | 域名                                                         |
| :--------------------- | :----------------------------------------------------------- |
| 中国大陆               | `webrtc2-ap-web-2.agoraio.cn` <br> `webrtc2-ap-web-4.agoraio.cn` <br> `statscollector-3.agoraio.cn` <br> `statscollector-4.agoraio.cn` <br> `logservice-china.agora.io` |
| 北美区域               | `ap-web-1-north-america.agora.io` <br> `ap-web-2-north-america.agora.io` <br> `statscollector-1-north-america.agora.io` <br> `statscollector-2-north-america.agora.io`  <br>`logservice-north-america.agora.io` |
| 欧洲区域               | `ap-web-1-europe.agora.io`<br>`ap-web-2-europe.agora.io`<br>`statscollector-1-europe.agora.io`  <br> `statscollector-2-europe.agora.io` <br> `logservice-europe.agora.io` |
| 日本                   | `ap-web-1-japan.agora.io`<br>`ap-web-2-japan.agora.io`<br>`statscollector-1-japan.agora.io`<br>`statscollector-2-japan.agora.io`<br>`logservice-japan.agora.io` |
| 印度                   | `ap-web-1-india.agora.io`<br>`ap-web-2-india.agora.io`<br>`statscollector-1-india.agora.io`<br>`statscollector-2-india.agora.io`<br>`logservice-india.agora.io` |
| 除中国大陆外的亚洲区域 | `ap-web-1-asia.agora.io`<br>`ap-web-2-asia.agora.io`<br>`statscollector-1-asia.agora.io`<br>`statscollector-2-asia.agora.io`<br>`logservice-asia.agora.io` |

- 端口

详见[应用企业防火墙限制](https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms)。


## API 参考

[`createInstance`](/cn/Real-time-Messaging/API%20Reference/RTM_web/modules/agorartm.html#createinstance)