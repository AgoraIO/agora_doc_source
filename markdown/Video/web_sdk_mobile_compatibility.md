# 移动端已知问题和限制

本页列出在移动端使用 Web SDK 的已知问题和限制。

## 已知问题

### iOS

<details>
<summary>iOS 15.1.x: 使用 H.264 编码发送视频流导致页面奔溃</summary>
<p>

**影响范围**：iOS 15.1.x 版本上的所有浏览器及内嵌 WebView 的应用。
</p>
<p>

**问题描述**：在 iOS 15.1.x 版本上的 Safari 浏览器和内嵌 WkWebView 的应用（微信浏览器和 Chrome 浏览器等）中，如果你调用 `createClient` 时将 `codec` 设为 `'h264'`，发送视频流后，页面会崩溃。
</p>
<p>

**问题原因**：由 iOS 15.x 上 WebKit 视频编码功能回退，详见 [WebKit Bug Report](https://bugs.webkit.org/show_bug.cgi?id=231505)。
</p>
<p>

**规避方案**：使用 VP8 进行视频编码。

```javascript
createClient({codec:'vp8', mode})
```
</p>
</details>

<details>
<summary>iOS 15.x: 本地用户听到的远端音频流的音量极低</summary>
<p>

**影响范围**：iOS 15.x 版本上的所有浏览器及内嵌 WebView 的应用。</p>
<p>

**问题描述**：在 iOS 15.x 版本上的 Safari 浏览器和内嵌 WkWebView 的应用（如微信浏览器和 Chrome 浏览器等）中，订阅远端音频流 `RemoteAudioTrack` 并播放后，有概率播放音频音量极低，且音频从听筒中而不是扬声器中播放出来。</p>
<p>

**问题原因**：未定位具体原因，由 iOS 15.x 版本中的音频功能回退导致，详见 [WebKit Bug Report](https://bugs.webkit.org/show_bug.cgi?id=230902)。
</p>
<p>

**规避方案**：在 iOS 15.x 版本的浏览器中使用 `WebAudio` 进行音频播放并使用 `GainNode` 调整音量后，可以提高播放音量。Agora 建议你按照以下步骤规避该问题：
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
<summary>iOS 15.x: 视频播放有概率出现黑屏</summary>
<p>

**影响范围**：iOS 15.x 版本上的所有浏览器及内嵌 WebView 的应用。
</p>
<p>

**问题描述**：在 iOS 15.x 版本上的 Safari 浏览器和内嵌 WkWebView 的应用（微信浏览器和 Chrome 浏览器等）中，在 DOM 中播放视频流且在 `video` 元素或其父元素添加某些 CSS 属性（如 `transform`、`animation`）后，或者改变 CSS 属性重绘视频渲染区域后，有概率视频播放出现黑屏。
</p>
<p>

**问题原因**：未定位具体原因，由 iOS 15.x 版本中的视频渲染功能回退导致，详见 [WebKit Bug Report](https://bugs.webkit.org/show_bug.cgi?id=230902)。
</p>
<p>

**规避方案**：升级至 Web SDK 4.x 最新版本，并且尽量减少对`video` 元素及其父元素的 CSS 属性的更改。
</p>
</details>


<details>
<summary>iOS 15.x: 用户佩戴蓝牙耳机后，播放的音频有概率明显失真。</summary>
<p>

**影响范围**：iOS 15.x 版本上的所有浏览器及内嵌 WebView 的应用。
</p>
<p>

**问题描述**：在 iOS 15.x 版本上的 Safari 浏览器和内嵌 WkWebView 的应用（微信浏览器和 Chrome 浏览器等）中，如果用户佩戴蓝牙耳机进行音频播放，音频有概率明显失真。
</p>
<p>

**问题原因**：未定位具体原因，由 iOS 15.x 版本中的音频播放功能回退导致，详见 [WebKit Bug Report](https://bugs.webkit.org/show_bug.cgi?id=231422)。
</p>
<p>

**规避方案**：无
</p>
</details>

<details>
<summary>iOS 15.x: 浏览器切换到后台后，音频流发送会中断</summary>
<p>

**影响范围**：iOS 15.x 版本上的所有浏览器及内嵌 WebView 的应用。
</p>
<p>

**问题描述**：在 iOS 15.x 版本上的 Safari 浏览器和内嵌 WkWebView 的应用（微信浏览器和 Chrome 浏览器等）中发送音频流，浏览器切换到后台后，音频流发送会中断。
</p>
<p>

**问题原因**：由于 [WebKit bug](https://bugs.webkit.org/show_bug.cgi?id=231105)，浏览器切换至后台后，`WebAudio` 的 `AudioContext` 会停止音频处理。
</p>
<p>

**规避方案**：参考以下步骤规避此问题：
1. 升级至 Web SDK 4.7.3 或之后版本。
2. 在调用 `createMicrophoneAudioTrack` 创建音频轨道时，将`bypassWebAudio` 参数设为 `true`，本地音频流会不绕过 `WebAudio` 处理直接发布。

   ```javascript
   const localAudioTrack = await AgoraRTC.createMicrophoneAudioTrack({bypassWebAudio: true});
   ```

> 注意：此方案会导致混音功能（`MixingAudioTrack`）失效。
</p>
</details>

<details>
<summary>iOS 15.x: 被其它语音或视频通话应用、Siri 呼叫、闹钟等打断后，音视频播放有概率无法自动恢复</summary>
<p>

**影响范围**：iOS 15.x 版本上的所有浏览器及内嵌 WebView 的应用。
</p>
<p>

**问题描述**：在 iOS 15.x 版本上的 Safari 浏览器和内嵌 WkWebView 的应用（微信浏览器和 Chrome 浏览器等）中播放音视频，如果被其它语音或视频通话应用、Siri 呼叫、闹钟等打断，音视频播放有概率无法自动恢复。
</p>
<p>

**问题原因**：音视频播放被打断后，DOM `video` 元素和 `audio` 元素的状态变为 `paused`。打断结束后，元素状态无法自动切换回 `playing`，且调用`HTMLMediaElement.play` 方法也无法恢复媒体的播放。详见 [WebKit issue 232599](https://bugs.webkit.org/show_bug.cgi?id=232599) 和[WebKit issue 226698](https://bugs.webkit.org/show_bug.cgi?id=226698)。
</p>
<p>

**规避方案**：升级至 Web SDK 4.x 最新版本。SDK 会尝试在打断事件后恢复媒体流的播放。
</p>
</details>

<details>
<summary>更多已知问题</summary>
<p>以下为没有 WebKit 记录的历史问题：

- iOS 13 和 14 上可能出现远端用户音量随机变化的问题。
- 切换前置、后置摄像头后采集画面可能会瞬间旋转。
- 语音路由随机切换，即可能出现插着耳机但是仍然从扬声器出声，或者没有耳机却从听筒出声的情况。
- 连续两次调用 `getUserMedia` 获取相同媒体类型的轨道，第一次获取的媒体轨道会静音或黑屏。
- 使用过其他使用音视频输入设备的 app 后（例如 Siri 或者 Skype 通话），无法采集本地音频或视频。
</p>
</details>

### Android

Android 12中使用硬件进行WebRTC视频编码，会导致视频花屏

  - 详情：在Android 12的部分设备中，Chrome浏览器或Chromium内核浏览器如默认开启WebRTC `H264`、`VP8`的视频硬件编码，会导致编码后的视频花屏
  - 影响范围：安装Android 12系统的Android设备
  - 原因：Chromium WebRTC模块视频编码回退[chromium issue](https://bugs.chromium.org/p/chromium/issues/detail?id=1237677)
  - 规避方案：引导使用Android 12的客户，在Chrome浏览器中的`Chrome://flags`配置页面中，关闭WebRTC视频硬件编码的相关配置。（Chrome 97版本有计划修复该问题）

<details>
<summary></summary>
<p>

**影响范围**：
</p>
<p>

**问题描述**：
</p>
<p>

**问题原因**：
</p>
<p>

**规避方案**：
</p>
</details>

<details>
<summary></summary>
<p>

**影响范围**：
</p>
<p>

**问题描述**：
</p>
<p>

**问题原因**：
</p>
<p>

**规避方案**：
</p>
</details>

<details>
<summary></summary>
<p>

**影响范围**：
</p>
<p>

**问题描述**：
</p>
<p>

**问题原因**：
</p>
<p>

**规避方案**：
</p>
</details>

<details>
<summary></summary>
<p>

**影响范围**：
</p>
<p>

**问题描述**：
</p>
<p>

**问题原因**：
</p>
<p>

**规避方案**：
</p>
</details>

<details>
<summary></summary>
<p>

**影响范围**：
</p>
<p>

**问题描述**：
</p>
<p>

**问题原因**：
</p>
<p>

**规避方案**：
</p>
</details>

- 使用Chrome浏览器，视频发送码率无法达到预设值

  - 详情：在部分Android设备中，使用Chrome浏览器或Chromium内核浏览器，视频发送码率无法达到Web SDK的预设值
  - 影响范围：具体设备列表未知，但包括部分小米及One Plus手机
  - 原因：可能是因为硬件编码导致特定视频编码帧率下，编码码率无法达到预设值
  - 规避方案：目前发现大部分情况下使用15fps进行视频编码会导致码率过低，而使用30fps则情况较好。因此在遇到此问题时，我们推荐使用30fps进行视频编码测试问题是否可以解决

- 在微信浏览器中，视频无法自动播放

  - 详情：在微信浏览器中，视频无法自动播放；且当通过用户手势（点击、触摸）恢复自动播放后，下一次的视频播放仍然无法自动播放

  - 影响范围：使用Chromium 89内核的微信浏览器

  - 原因：可能是微信浏览器对浏览器自动播放的行为处理有异常，导致与其他浏览器的媒体自动播放行为不一致

  - 规避方案：推荐升级到最新的Web SDK NG版本，并且监听`AgoraRTC.onAutoplayFailed`事件，在此事件中，引导用户点击页面，恢复播放：

    ```javascript
    AgoraRTC.onAutoplayFailed = ()=>{
      document.alert('请点击页面后恢复播放');
    }
    ```

- 使用蓝牙耳机，开始发送音频流后，无法听到远端音频

  - 详情：在佩戴蓝牙耳机时，当在通话过程中通过蓝牙耳机采集本地音频，发送音频流后，有概率会导致无法收听到远端媒体流
  - 影响范围：具体影响范围未知，但包括部分小米及One Plus手机
  - 原因：明确原因仍未知，但猜测可能是Chromium在蓝牙设备的profile切换后产生的音频异常
  - 规避方案：暂无

  

其他一些与具体Android设备相关的已知问题包括：

- 在**搭载联发科芯片的设备**上无法使用 H.264 编码在Chrome浏览器中发送视频流
- 在 Android Chrome 88 以下版本，搭载**华为海思麒麟芯片**的设备无法使用 H.264 编码发送视频流
- 在**OnePlus 6**使用Chrome 浏览器接收远端视频流期间熄灭屏幕，可能会导致视频流冻结



其他一些我们收到客户反馈，或者在研发过程中发现的，但并没有相关Chromium issue记录的历史问题包括：

- 在部分 Android 设备上可能无法获取到媒体设备的 device label
- 在部分 Android 设备上音视频流被系统电话呼叫或其他语音和视频通话应用打断，可能会导致 track-ended，需要重新采集音视频
- 在 Android Chrome 上无法使用 H.264 编码发送大小流

## 二、移动端已知功能限制

### iOS

- 不支持调用 `createScreenVideoTrack` 进行屏幕共享
  - 原因：iOS Safari及WebView未实现`mediaDevices.getDisplayMedia`接口
- 不支持调用 `setBeautyEffect` 开启美颜
  - 原因：iOS Safari及WebView对WebGL支持不佳，且iOS设备在进行美颜算法处理时性能消耗过于巨大
- 不支持 `IBufferSourceAudioTrack.seekAudioBuffer` 方法
  - 原因：在iOS上`WebAudio`不支持实现该方法
- 无法使用 H.264 编码发送 1080p 及以上分辨率的视频流
  - 原因：目前使用H264 baseline profile进行协商，在iOS上不支持编码发送1080p及以上分辨率
- 发送小流时，不支持设置 `LowStreamParameter.bitrate`，且小流分辨率需要与大流分辨率成比例
  - 原因：iOS Safari及WebView中`RTCRTPSender.setParameters`方法无法指定帧率，通过`scaleResolutionDownBy`属性进行分辨率压缩后，小流分辨率与大流成固定比率
- 不支持获取 `encodeDelay`
  - 原因：在iOS上无法通过WebRTC `getStats`API计算的到此结果

### Android

- 不支持调用 `createScreenVideoTrack` 进行屏幕共享
  - 原因：移动端浏览器及WebView未实现`mediaDevices.getDisplayMedia`接口
- 不支持调用 `setBeautyEffect` 开启美颜
  - 原因：移动端设备在进行美颜算法处理时性能消耗过于巨大