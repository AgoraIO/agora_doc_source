---
title: 调整通话音量
platform: Web
updatedAt: 2020-12-30 09:01:44
---
<div class="alert note">本文仅适用于 Agora Web SDK 3.x 及之前版本。如果你使用 Web SDK 4.x，请查看<a href="./volume_web_ng?platform=Web">调整通话音量</a>。</div>

## 功能描述
 在使用我们 SDK 时，开发者可以对 SDK 采集到的声音及 SDK 播放到声卡的声音音量进行调整，以满足产品在声音上的个性化需求。比如进行双人通话时，想实现静音操作，可以通过调整播放音量的接口将音量设置为 0。


## 实现方法
在调整通话音量前，请确保已在你的项目中实现基本的实时音视频功能。详见[实现音视频通话](start_call_web)或[实现互动直播](start_live_web)。

### 示例代码

#### 调节别人的音量

```javascript
client.on("stream-subscribed", function(evt){
  var stream = evt.stream;
  // 将订阅流的音量设置为 50
  stream.setAudioVolume(50);
});
```

#### 静音

```javascript
client.on("stream-subscribed", function(evt){
  var stream = evt.stream;
  // 将订阅流静音
  stream.setAudioVolume(0);
});
```

### API 参考

- [`setAudioVolume`](./API%20Reference/web/interfaces/agorartc.stream.html#setaudiovolume)

## 开发注意事项

- 音量设置太大在某些设备上可能出现爆音现象

## 相关链接

实现调整通话音量过程中，你还可以参考如下文档：

- [如何处理音量太小问题？](https://docs.agora.io/cn/faq/audio_low)