# 移动端已知问题和限制

本页列出在移动端使用 Web SDK 的已知问题和限制，并提供规避方案。

> - Agora 建议你遇到问题时，先查阅本页看是否为已知问题。
> - 如想提升在移动端的体验，Agora 建议你升级到 Web SDK 4.x 最新版本。

## 已知问题

### iOS

<details>
<summary>iOS 15.1.x: 使用 H.264 编码发送视频流导致页面奔溃</summary>
<p>

**影响范围**：iOS 15.1.x 上的所有浏览器和内嵌 WkWebView 的应用（如微信浏览器和 Chrome 浏览器）。
</p>
<p>

**问题描述**：在 iOS 15.1.x 上的 Safari 浏览器和内嵌 WkWebView 的应用中，如果你调用 `createClient` 时将 `codec` 设为 `'h264'`，发送视频流后，页面会崩溃。
</p>
<p>

**问题原因**：该问题是由 iOS 15.x 上 WebKit 视频编码功能回退导致，详见 [WebKit Bug 231505](https://bugs.webkit.org/show_bug.cgi?id=231505)。
</p>
<p>

**规避方案**：使用 VP8 进行视频编码。

```javascript
createClient({codec:'vp8', mode})
```
</p>
</details>

<details>
<summary>iOS 15.x: 本地用户听到远端音频流的音量极低</summary>
<p>

**影响范围**：iOS 15.x 上的所有浏览器及内嵌 WkWebView 的应用（如微信浏览器和 Chrome 浏览器）。</p>
<p>

**问题描述**：在 iOS 15.x 上的 Safari 浏览器和内嵌 WkWebView 的应用中，订阅并播放远端音频轨道 `RemoteAudioTrack` 后，播放音量有概率极低，且音频从听筒中而不是扬声器中播放出来。</p>
<p>

**问题原因**：该问题是由 iOS 15.x 上 WebKit 音频功能回退导致，详见 [WebKit Bug 230902](https://bugs.webkit.org/show_bug.cgi?id=230902)。
</p>
<p>

**规避方案**：在 iOS 15.x 上使用 `WebAudio` 进行音频播放并使用 `GainNode` 调整音量后，可以提高播放音量。Agora 建议你按照以下步骤规避该问题：
1. 升级至 Web SDK 4.9.0 或以上版本。
2. 设置 SDK 私有参数 `REMOTE_AUDIO_TRACK_USES_WEB_AUDIO` 为 `true`。SDK 内部会使用 `WebAudio` 播放远端音频流。示例代码如下：
   ```javascript
   function isIOS15(ua){
       // 通过 UA 判断 iOS 版本是否为 15
   }

   if(isIOS15(navigator.userAgent)){
       AgoraRTC.setParameter("REMOTE_AUDIO_TRACK_USES_WEB_AUDIO", true);
   }
   ```
</p>
</details>

<details>
<summary>iOS 15.x: 播放视频有概率出现黑屏</summary>
<p>

**影响范围**：iOS 15.x 上的所有浏览器及内嵌 WkWebView 的应用（如微信浏览器和 Chrome 浏览器）。
</p>
<p>

**问题描述**：在 iOS 15.x 上的 Safari 浏览器和内嵌 WkWebView 的应用中，在 DOM 中播放视频且在 `video` 元素或其父元素添加某些 CSS 属性（如 `transform`、`animation`）后，或者改变 CSS 属性重绘视频渲染区域后，有概率视频播放出现黑屏。
</p>
<p>

**问题原因**：该问题是由 iOS 15.x 上 WebKit 视频渲染功能回退导致，详见 [WebKit Bug 230902](https://bugs.webkit.org/show_bug.cgi?id=230902)。
</p>
<p>

**规避方案**：升级至 Web SDK 4.x 最新版本，并且尽量减少更改 `video` 元素及其父元素的 CSS 属性。
</p>
</details>


<details>
<summary>iOS 15.x: 用户佩戴蓝牙耳机后，播放音频有概率明显失真</summary>
<p>

**影响范围**：iOS 15.x 上的所有浏览器及内嵌 WkWebView 的应用（如微信浏览器和 Chrome 浏览器）。
</p>
<p>

**问题描述**：在 iOS 15.x 上的 Safari 浏览器和内嵌 WkWebView 的应用中，如果用户佩戴蓝牙耳机进行音频播放，音频有概率明显失真。
</p>
<p>

**问题原因**：该问题是由 iOS 15.x 上 WebKit 音频播放功能回退导致，详见 [WebKit Bug 231422](https://bugs.webkit.org/show_bug.cgi?id=231422)。
</p>
<p>

**规避方案**：暂无
</p>
</details>

<details>
<summary>iOS 15.x: 浏览器切换到后台后，音频流发送中断</summary>
<p>

**影响范围**：iOS 15.x 上的所有浏览器及内嵌 WkWebView 的应用（如微信浏览器和 Chrome 浏览器）。
</p>
<p>

**问题描述**：在 iOS 15.x 上的 Safari 浏览器和内嵌 WkWebView 的应用中发送音频流，浏览器或应用切换到后台后，音频流发送会中断。
</p>
<p>

**问题原因**：由于 WebKit 的 [bug](https://bugs.webkit.org/show_bug.cgi?id=231105)，浏览器切换至后台后，`WebAudio` 的 `AudioContext` 会停止音频处理。
</p>
<p>

**规避方案**：参考以下步骤规避此问题：
1. 升级至 Web SDK 4.7.3 或之后版本。
2. 调用 `createMicrophoneAudioTrack` 创建音频轨道时，将`bypassWebAudio` 参数设为 `true`，本地音频流会不经由 `WebAudio` 处理直接发布。

   ```javascript
   const localAudioTrack = await AgoraRTC.createMicrophoneAudioTrack({bypassWebAudio: true});
   ```

   > 注意：此方案会导致混音功能（`MixingAudioTrack`）失效。
</p>
</details>

<details>
<summary>iOS 15.x: 被其它语音或视频通话应用、Siri 呼叫、闹钟等打断后，音视频播放有概率无法自动恢复</summary>
<p>

**影响范围**：iOS 15.x 上的所有浏览器及内嵌 WkWebView 的应用（如微信浏览器和 Chrome 浏览器）。
</p>
<p>

**问题描述**：在 iOS 15.x 上的 Safari 浏览器和内嵌 WkWebView 的应用中播放音视频，如果被其它语音或视频通话应用、Siri 呼叫、闹钟等打断，音视频播放有概率无法自动恢复。
</p>
<p>

**问题原因**：音视频播放被打断后，DOM `video` 元素和 `audio` 元素的状态变为 `paused`。打断结束后，状态无法自动切回 `playing`，且调用`HTMLMediaElement.play` 方法也无法恢复媒体的播放。详见 [WebKit bug 232599](https://bugs.webkit.org/show_bug.cgi?id=232599) 和[WebKit bug 226698](https://bugs.webkit.org/show_bug.cgi?id=226698)。
</p>
<p>

**规避方案**：升级至 Web SDK 4.x 最新版本。SDK 会尝试在打断事件后恢复媒体播放。
</p>
</details>

<details>
<summary>其他历史已知问题</summary>
<p>

- iOS 13 和 14 上可能出现远端用户音量随机变化的问题。
- 切换前置、后置摄像头后采集画面可能会瞬间旋转。
- 语音路由随机切换，即可能出现插着耳机但是仍然从扬声器出声，或者没有耳机却从听筒出声的情况。
- 连续两次调用 `getUserMedia` 获取相同媒体类型的轨道，第一次获取的媒体轨道会静音或黑屏。
- 使用过其他使用音视频输入设备的 app 后（例如 Siri 或者 Skype 通话），无法采集本地音频或视频。
</p>
</details>

### Android

<details>
<summary>Android 12: 使用 WebRTC 视频硬件编码可能会导致花屏</summary>

<p>

**影响范围**：部分安装了 Android 12 的设备，如 Pixel 3 和 Pixel 4。
</p>
<p>

**问题描述**：在 Android 12 上使用 Chrome 浏览器或 Chromium 内核浏览器，如果默认开启 WebRTC `H264` 或 `VP8` 视频硬件编码，可能会导致花屏。
</p>
<p>

**问题原因**：该问题是由 Chromium WebRTC 模块视频编码回退导致，详见 [Chromium issue 1237677](https://bugs.chromium.org/p/chromium/issues/detail?id=1237677)。
</p>
<p>

**规避方案**：引导使用 Android 12 的客户在 Chrome 浏览器中打开 `Chrome://flags` 配置页面，关闭 WebRTC 视频硬件编码相关配置。Chrome 计划在 97 版本中修复该问题。
</p>
</details>

<details>
<summary>Chrome 浏览器上发送视频流，码率无法达到预设值</summary>
<p>

**影响范围**：部分 Android 设备，如部分小米及 One Plus 机型。
</p>
<p>

**问题描述**：在 Chrome 浏览器或 Chromium 内核浏览器上视频发送码率无法达到 Web SDK 的预设值。
</p>
<p>

**问题原因**：可能是因为硬件编码导致特定视频编码帧率下码率无法达到预设值。
</p>
<p>

**规避方案**：大部分情况下，视频编码帧率为 15 fps 时，码率会过低，而帧率为 30 fps 时码率则相对较高。因此 Agora 建议遇到码率问题时，尝试将帧率设为 30 fps。
</p>
</details>

<details>
<summary>微信浏览器中视频无法自动播放</summary>
<p>

**影响范围**：使用 Chromium 89 内核的微信浏览器
</p>
<p>

**问题描述**：视频无法自动播放，并且当通过用户手势（点击、触摸）恢复自动播放后，下一次的视频播放仍然无法自动播放。
</p>
<p>

**问题原因**：可能是微信浏览器对自动播放的行为处理有异常，与其他浏览器的行为不一致。
</p>
<p>

**规避方案**：参考以下步骤规避此问题：
1. 升级至 Web SDK 4.x 最新版本。
2. 监听 `AgoraRTC.onAutoplayFailed` 事件。在此事件中，引导用户点击页面，恢复播放：

    ```javascript
    AgoraRTC.onAutoplayFailed = ()=>{
        document.alert('请点击页面后恢复播放');
    }
    ```
</p>
</details>

<details>
<summary>本地用户佩戴蓝牙耳机，开始发送音频流后就无法听到远端音频</summary>
<p>

**影响范围**：部分小米及 One Plus 机型
</p>
<p>

**问题描述**：如果本地用户佩戴蓝牙耳机，在通话过程中通过蓝牙耳机采集本地音频且发送音频流后，有概率会无法收听到远端用户的声音。
</p>
<p>

**问题原因**：可能是由于 Chromium 在蓝牙设备的 profile 切换后会产生音频异常。
</p>
<p>

**规避方案**：暂无
</p>
</details>

<details>
<summary>某些 Android 机型特有的问题</summary>
<p>

- 在搭载**联发科芯片**的设备上无法使用 H.264 编码在 Chrome 浏览器中发送视频流。
- 在搭载**华为海思麒麟芯片**的设备上，Android Chrome 88 以下版本上，无法使用 H.264 编码发送视频流。
- 在**OnePlus 6**上使用 Chrome 浏览器接收远端视频流期间熄灭屏幕，可能会导致视频流冻结。
</p>
</details>

<details>
<summary>其他历史已知问题</summary>
<p>

- 在部分 Android 设备上可能无法获取到媒体设备的 device label。
- 在部分 Android 设备上音视频流被系统电话呼叫或其他语音和视频通话应用打断，可能会导致 track-ended，需要重新采集音视频。
- 在 Android Chrome 上无法使用 H.264 编码发送大小流。
</p>
</details>

## 已知限制

### iOS

<details>
<summary>不支持调用 <code>createScreenVideoTrack</code> 进行屏幕共享</summary>
<p>

原因：iOS Safari 及 WkWebView 不支持 `mediaDevices.getDisplayMedia` 接口。
</p>
</details>

<details>
<summary>不支持调用 <code>setBeautyEffect</code> 开启美颜</summary>
<p>

原因：iOS Safari 及 WkWebView 对 WebGL 支持不佳，且 iOS 设备在进行美颜算法处理时性能消耗过大。
</p>
</details>

<details>
<summary>不支持 <code>IBufferSourceAudioTrack.seekAudioBuffer</code> 方法</summary>
<p>

原因：iOS 上 `WebAudio` 不支持实现该方法。
</p>
</details>

<details>
<summary>无法使用 H.264 编码发送 1080p 及以上分辨率的视频流</summary>
<p>

原因：Web SDK 使用 H.264 Baseline Profile 进行协商，因此 iOS 上不支持编码发送 1080p 及以上分辨率的视频流。
</p>
</details>

<details>
<summary>发送小流时，不支持设置 <code>LowStreamParameter.bitrate</code>，且小流分辨率需要与大流分辨率成比例</summary>
<p>

原因：iOS Safari 及 WkWebView 中 `RTCRTPSender.setParameters` 方法无法指定帧率，通过 `scaleResolutionDownBy` 属性进行分辨率压缩后，小流分辨率与大流成固定比率。
</p>
</details>

<details>
<summary>不支持获取 <code>encodeDelay</code></summary>
<p>

原因：iOS 上无法通过 WebRTC 的 `getStats` 接口计算出 `encodeDelay`。
</p>
</details>

### Android

<details>
<summary>不支持调用 <code>createScreenVideoTrack</code> 进行屏幕共享</summary>
<p>

原因：移动端浏览器及 WkWebView 未实现 `mediaDevices.getDisplayMedia` 接口。
</p>
</details>

<details>
<summary>不支持调用 <code>setBeautyEffect</code> 开启美颜</summary>
<p>

原因：移动端设备在进行美颜算法处理时性能消耗过大。
</p>
</details>