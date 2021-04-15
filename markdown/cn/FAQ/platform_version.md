---
title: 声网 SDK 支持哪些平台和版本？
platform: ["All Platforms"]
updatedAt: 2021-03-30 10:03:53
Products: ["Voice","Video","Interactive Broadcast","Recording","Real-time-Messaging","cloud-recording"]
---
Agora 各个产品的 SDK 支持的平台和版本不尽相同。

## 音视频通话/互动直播

Agora 音视频通话/互动直播 SDK 支持 Android、iOS、Windows、macOS、Unity、Web 和微信小程序等平台，并支持平台间互通。具体兼容性见下表：

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

## 本地服务端录制

Agora 本地服务端录制 SDK 需要部署在 Linux 服务器，具体要求请参考[集成录制 SDK 的前提条件](https://docs.agora.io/cn/Recording/recording_integrate_cpp?platform=Linux#前提条件)。

## 云端录制服务

Agora 云端录制支持直接使用 RESTful API 通过网络请求开启和控制云录制。详情请参考[云端录制 RESTful API 快速开始](https://docs.agora.io/cn/cloud-recording/cloud_recording_rest?platform=RESTful)。

## 云信令 (原实时消息，Real-time Messaging)

Agora 云信令 SDK 支持 iOS、Android、macOS、Linux、Windows C++、Web 等平台。详情请参考 [RTM 快速开始](https://docs.agora.io/cn/Real-time-Messaging/messaging_android?platform=Android)。