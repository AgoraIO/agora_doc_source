---
title: Agora Web SDK 支持哪些浏览器？
platform: ["Web"]
updatedAt: 2021-03-04 07:06:24
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
## 浏览器支持

本节列出 Agora RTC Web SDK 支持的浏览器及平台。

<div class="alert note">为保证最佳的用户体验，Agora 强烈推荐使用桌面端 Google Chrome 浏览器<a href="https://www.google.com/intl/zh-CN/chrome/">官方最新版本</a>。</div>
<div class="alert note">以下场景中请务必将 Web SDK 升级至最新版本：<li>iOS 12.1.4 及以上版本上使用 Safari 浏览器。</li><li>macOS 上使用 Safari 12.1 及以上版本。</li></li></div>

### 桌面端

Web SDK 对桌面端浏览器的支持情况详见下表：

| 平台       | Chrome 58+ | Firefox 56+ | Safari 11+ | Opera 45+ | QQ 浏览器 10.5+ | 360 安全浏览器 | Edge 浏览器 80+ |
| :--------- | :--------- | :---------- | :--------- | :-------- | :-------------- | :------------- | :-------------- |
| macOS 10+  | <font color="green">✔</font>          | <font color="green">✔</font>           | <font color="green">✔</font>          | <font color="green">✔</font>         | <font color="green">✔</font>               | <font color="red">✘</font>              | <font color="red">✘</font>               |
| Windows 7+ | <font color="green">✔</font>          | <font color="green">✔</font>           | N/A        | <font color="green">✔</font>         | <font color="green">✔</font>               | <font color="green">✔</font>              | <font color="green">✔</font>               |

除上述浏览器外，Web SDK 对桌面端浏览器还有以下支持：

- Web SDK 2.5 及以上版本支持 Windows XP 平台的 Chrome 49 版本浏览器（仅支持 VP8 编解码，不能与 Native SDK 互通）。
- Web SDK 理论上还支持 360 极速浏览器，但未经过验证，不保证全部功能正常工作。

### 移动端

Web SDK 对移动端浏览器的支持情况受到具体设备和浏览器的限制：

- 在 Android 4.1+ 上，Web SDK 支持 **Google Chrome 58 及以上版本**，且 Agora 建议使用 VP8 编解码格式。这是由于 Android Chrome 对 H.264 的支持依赖硬件，而部分 Android 设备不支持 H.264 编解码格式。
- 在 iOS 11+ 上，Web SDK 支持 **Safari 11 及以上版本**。但是由于 iOS Safari 存在较多[已知问题](#ios)，Agora 不推荐使用。你可以使用 [Agora RTC iOS SDK](https://docs.agora.io/cn/Interactive%20Broadcast/downloads) 在 iOS 上实现实时音视频功能。

除上述浏览器外，对于移动端的一些应用内置浏览器，Web SDK 的支持情况较为复杂，详见[移动端如何使用 Agora Web SDK？](https://docs.agora.io/cn/faq/web_on_mobile)

## 浏览器使用限制

由于浏览器的差异，在不同浏览器及平台上支持的功能可能不同。下面列出浏览器和平台的已知问题和限制。

Chrome 81 及以上版本、Safari 和 Firefox 浏览器需要在获得媒体设备权限后才能获取设备 ID，详见[为什么在 Chrome 81 浏览器上无法获取设备 ID？](https://docs.agora.io/cn/faq/empty_deviceId)

### Chrome

Agora Web SDK 是基于 WebRTC 实现的采集和编解码，而 Chrome 又是第一批支持 WebRTC 的先行者，所以在 Chrome 上的限制最少，已知限制：

- Chrome 版本要求 58 及以上。
- 部分 Android 设备上，Chrome 不支持 H.264 编解码格式。
- 部分 API 需要 Chrome 更高版本支持，具体见 API 参考内的描述。
- 在所有使用 AMD 芯片和部分使用 Intel 芯片的 Windows 设备上，Chrome 使用 H.264 编码时，发送码率可能达不到设定值。你可以使用 VP8 编码或者尝试关闭硬件加速。

### Safari

#### <a name="ios"></a>**iOS Safari**

以下为 iOS 平台 Safari 的已知问题和限制：

- 语音路由随机切换，即可能出现插着耳机但是仍然从扬声器出声，或者没有耳机却从听筒出声的情况。
- iOS 13 上可能出现远端用户音量随机变化的问题。
- 不支持 `setAudioLevel` 方法。
- 连续两次调用 `getUserMedia` 获取相同媒体类型的轨道，第一次获取的媒体轨道会静音或黑屏。
- iOS Safari 上互通时，某用户的角色从观众切换为主播且获取麦克风权限之后，该用户听远端用户音量会明显变低。
- 偶现问题：使用过其他使用音视频输入设备的 app 后（例如 Siri 或者 Skype 通话），无法采集本地音频或视频。
- 偶现问题：音频会话（Audio Session）中断后（包括 mute、unmute、唤醒 Siri、接听电话等），听不到远端用户的声音。

#### **其他限制**

以下为 iOS 和 macOS 平台 Safari 的已知问题和限制：

- Safari 11 只支持 480P 及以上分辨率。
- Safari 12.1 及之前版本仅支持 H.264 编解码格式。
- Safari 13 的用户可能听不到远端用户的声音。
- iOS Safari 14.2 和 macOS Safari 14.0.1 上音频可能断断续续。
- 设备权限限制：
  - Safari 无法获取输出设备信息，因此不支持 `getPlayoutDevices` 和 `setAudioOutput` 这两个方法。
  - 如果 Safari 没有打开**自动播放**（如下图所示），直接播放音视频流会听不到声音，必须在播放前调用 `navigator.mediaDevices.getUserMedia` 方法获取设备权限。
   ![](https://web-cdn.agora.io/docs-files/1591078696865)
- Safari 不支持 `addTrack` 和 `removeTrack`。
- Safari 不支持开启[双流模式](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#dual-stream)。
- Safari 上调用相关方法获取质量相关统计数据时，多个字段的值为 0。例如调用 `getLocalAudioStats` 获取数据时，`RecordingLevel` 和 `SendLevel` 字段值为 0。

### Firefox 

- Firefox 上使用 Web SDK 时与某些设备互通时，Firefox 端看其他端的视频画面会发生旋转。
- Firefox 只支持视频帧率设为 30 fps。
- 在部分设备上 Firefox 设置视频编码配置不生效，目前已知有此问题的设备如下：
  - MacBook Pro (13-inch, 2016, Two Thunderbolt 3 ports)
  - Windows 10 (MI)
- Firefox 上调用相关方法获取质量相关统计数据时，多个字段的值为 0。例如调用 `getLocalAudioStats` 获取数据时，`RecordingLevel` 和 `SendLevel` 字段值为 0。
- 在使用 Apple M1 芯片的 Mac 设备上 Firefox 不支持 H.264 编解码，详见 [Firefox 官方说明](https://bugzilla.mozilla.org/show_bug.cgi?id=1686470)。

## 相关链接
[移动端如何使用 Agora Web SDK？](https://docs.agora.io/cn/faq/web_on_mobile)