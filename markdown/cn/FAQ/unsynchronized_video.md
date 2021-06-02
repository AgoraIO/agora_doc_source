---
title: 如何处理音画不同步问题？
platform: ["Android","iOS","macOS","Web","Windows","Unity","Electron","React Native","Flutter"]
updatedAt: 2020-07-07 20:34:51
Products: ["Video","Interactive Broadcast"]
---
音画不同步问题一般由网络、设备性能、自采集、自渲染或第三方美颜 SDK 等原因造成。你可以参考以下步骤解决音画不同步问题。

## 步骤 1：自检

请按以下步骤进行排查：

- 判断音画不同步现象是持续的还是暂时的。暂时的音画不同步由网络和设备的随机性导致，属于正常现象。

- 如果使用视频自采集，检查视频帧的 `timeStamp` 参数传值是否正确。注意 `timeStamp` 的单位是毫秒。

  <div class="alert note">如果你通过摄像头采集视频，系统会报告每一帧视频的时间戳，即是你需要传入 <code>timeStamp</code> 的值。</div>

- 检查网络状态是否良好。你可以尝试更换网络连接，检查音画是否恢复同步。

- 如果使用了第三方美颜 SDK，请先关闭美颜，再检查音画是否同步。如果关闭美颜后音画恢复同步，则很可能是美颜导致的问题，请联系第三方美颜 SDK 的技术支持。

- 如果条件允许，请尝试更换性能更好的设备，再检查音画是否同步。

- 如果使用自渲染，你需要自行排查实现自渲染的代码逻辑，判断音画不同步是否由自渲染引起。你可以参考 Agora 提供的[自渲染](https://github.com/AgoraIO/Advanced-Video/tree/master/Android/sample-custom-render)示例项目。

## 步骤 2：联系技术支持

如果经过上述排查无法解决问题，请联系 [Agora 技术支持](https://agora-ticket.agora.io/)并提供下列信息：

- 出现音画不同步现象的频道名和时间段。
- 发生音画不同步的应用场景，如通信场景、直播场景、单主播直播或连麦直播场景。
- 音画不同步时，发送端和接收端的 UID。
- 音画不同步是否出现在使用自采集或自渲染的场景下。
- 音画不同步现象是否可以复现以及复现步骤。
- 音画不同步现象发生时的录屏文件。
- SDK 日志文件，参考[如何设置日志文件](https://docs.agora.io/cn/faq/logfile)。