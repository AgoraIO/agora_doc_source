---
title: 产品概述
platform: All_Platforms|全平台
updatedAt: 2020-12-01 03:00:00
---
Agora 音频互动直播（Live Interactive Audio Streaming）可以实现一对多，多对多的纯音频互动直播。

Agora 音频互动直播和 [Agora 语音通话](https://docs.agora.io/cn/Voice/product_voice?platform=All%20Platforms)的区别是：
- 语音通话，不区分主播和观众，所有用户都可发言，默认流畅和低延时优先，典型场景如多人语音会议。
- 语音直播，用户分为主播和观众，只有主播可以自由发言，默认高音质优先，典型场景如在线音乐直播。

常见的 CDN 直播是一个主播和多个观众，是单向的。而互动直播还能多个主播之间，观众与主播之间连麦，就像在小剧场里观众可以上台表演一样。适用于娱乐直播如狼人杀、教育直播如小班课、电商直播中的导购问答等强互动场景。



## 功能和场景

Agora 音频互动直播提供丰富的功能，你可以根据自己的场景需求灵活组合。

<style> table th:first-of-type {     width: 150px; } th:third-of-type {     width: 170px; }</style>

| 主要功能             | 功能描述                                                     | 典型适用场景                                                 |
| -------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 观众连麦           | 观众与主播连麦聊天，观众围观。                               | <li>大型直播时，主播邀请观众互动 <li>狼人杀、剧本杀          |
| 跨直播间连麦         | 多个主播跨直播间，连麦互动，观众围观。                       | PK 连麦                                                      |
| 伴奏混音             | 将本地或在线的音频和用户声音，同时发送并播放给频道内其他用户 | <li>在线合唱 <li>针对幼儿的音乐互动课堂                      |
| 变声和混响        | 提供多种预置的变声和混响效果，同时支持灵活调整用户声音的音调、均衡及混响效果。 | <li>一起 KTV<li>语音聊天室变声 |
| 听声辨位          | 设置远端用户声音出现的位置，增加游戏角色的方位感，还原真实游戏场景。 | 吃鸡游戏                       |
| 修改音频原始数据   | 可支持变声，支持获取媒体引擎的原始语音数据，对原始数据进行处理 | <li>语音聊天室变声                           |
| 在线媒体流输入       | 可以将媒体流作为一个发送端接入正在进行的直播房间。通过将正在播放的音频添加到直播中，主播和观众可以在一起收听/观看媒体流的同时，实时互动。 可以对输入源的属性进行设置。 | <li>主播和观众一起听演唱会      |
| 推流到 CDN           | 将频道内的音频内容通过 CDN 推送到其他 RTMP 服务器： <li>能够随时启动或停止推流 <li>能够在不间断推流的同时增减推流地址 | <li>在朋友圈、微博等推广直播内容<li>频道人数超限时，让更多人参与直播 |

更多的玩法，点击查看示例代码：

- [PK 连麦](https://github.com/AgoraIO/ARD-Agora-Online-PK/blob/master/README.zh.md)
- [一起 KTV](https://github.com/AgoraIO/Agora-Online-KTV/blob/master/README.zh.md)
- [在线语音聊天室](https://github.com/AgoraIO-Usecase/Chatroom)
- [剧本杀](https://github.com/AgoraIO-Usecase/Murder-Mystery-Game)

## 关键特性

| 特性                      | Agora 音频互动直播指标                                           |
| ------------------------- | ------------------------------------------------------------ |
| SDK 包体积                | 3.14 ～ 5.88 MB                                              |
| 多主播互动                | 17 人                                                        |
| 最多观众人数              | 100 万                                                       |
| 跨频道主播连麦            | 支持                                                         |
| 音频属性                  | <li>音频采样率：16 kHz - 48 kHz <li>支持单、双声道           |
| 音频抗丢包率              | 上下行抗丢包率 80%                                           |

### 平台兼容

音频互动直播支持 iOS、Android、Windows、macOS、Electron、Unity、Web、小程序，并支持平台间互通，具体的兼容性要求见下表。

| 平台       | 支持版本                                                     |
| ---------- | ------------------------------------------------------------ |
	| Android    | <p>4.1+</p><p>Android SDK 支持如下 ABI：</p><ul><li>armeabi-v7a<li>arm64-v8a<li>x86<li>x86-64                                                       |
| iOS        | 8.0+                                                         |
| macOS      | <p>10.0+</p><p>macOS SDK 支持 x86 架构                                                      |
| Windows    | <p>Windows 7+</p><p>Windows SDK 支持如下架构：<p><ul><li>x86<li>x86-64                                                      |
| Web        | <ul><li>Chrome 58+ <li>Chrome 49（仅 Windows XP）<li>Firefox 56+ <li>Safari 11+ <li>Opera 45+ <li>QQ 浏览器 10.5+ <li>360 安全浏览器 9.1+<li>Edge 浏览器 80+</ul><p>Web 平台的支持情况还与设备型号及系统版本等有关，详见 <a href="https://docs.agora.io/cn/faq/browser_support">Agora Web SDK 支持哪些浏览器？</p> |
| Unity      | <p>2017+</p><p>Unity SDK 支持如下平台：<p><ul><li>Android (armeabi-v7a、arm64-v8a、x86)<li>iOS<li>Windows (x86、x86-64)<li>macOS                                                         |
	|Electron | Electron 1.8.3 及以上 |
	| Flutter      | <p>Flutter 1.0.0 或更高版本（暂不支持 Flutter 2.x）                  |
		| React Native      | <p>React Native 0.59.10 或以上</p>                                           |
	
## 相关链接

[Agora RTC SDK 最多支持多少人同时在线？](https://docs.agora.io/cn/faq/capacity)