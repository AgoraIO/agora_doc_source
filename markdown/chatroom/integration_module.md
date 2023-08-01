本文介绍语聊房解决方案中常见的进阶设置。

## 设置高音质

高音质会给语聊房带来更好的用户体验。建议参考如下示例代码，调用声网 RTC SDK 中的 setAudioProfile、setAudioScenarios、setParameters 方法来设置高音质：

- 当主播使用声卡采集音频时，设置高音质：

  ```java
  setAudioProfile(Constants.MUSIC_HIGH_QUALITY_STEREO)
  setAudioScenario(Constants.AUDIO_SCENARIO_GAME_STREAMING)
  setParameters("{\"che.audio.enable.aec\":false}");
  setParameters("{\"che.audio.enable.ns\":false}");
  setParameters("{\"che.audio.enable.agc\":false}");
  setParameters("{\"che.audio.custom_payload_type\":78}");
  setParameters("{\"che.audio.custom_bitrate\":128000}");
  setRecordingDeviceVolume(128)
  setParameters("{\"che.audio.input_channels\":2}");
  ```

- 当主播未使用声卡采集音频时，设置高音质：

  ```java
  setAudioProfile(Constants.MUSIC_HIGH_QUALITY_STEREO)
  setAudioScenario(Constants.AUDIO_SCENARIO_GAME_STREAMING)
  setParameters("{\"che.audio.custom_bitrate\":128000}");
  setParameters("{\"che.audio.custom_payload_type\":78}");
  ```

**注意**：上述高音质设置仅适用于语聊房。如果在其他场景解决方案中需要设置高音质，可以联系声网技术支持进行咨询。

## 背景音乐和音效

主播可以通过播放背景音乐和音效活跃语聊房内的气氛。

### 本地音乐文件或在线音乐文件

如果主播使用的音乐文件是本地文件或在线文件，播放方式有如下两种：

- 调用 声网 RTC SDK 中的 [`startAudioMixing`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_audio_process.html#api_irtcengine_startaudiomixing) 方法播放文件：

```objective-c
- (int)startAudioMixing:(NSString *  _Nonnull)filePath
               loopback:(BOOL)loopback
                replace:(BOOL)replace
                  cycle:(NSInteger)cycle;
```

- 使用 声网 RTC SDK 中[内置媒体播放器](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_mediaplayer.html)来播放文件。

### 声网 DRM 音乐 //TODO

目前声网和音集协合作提供了数十万首热门歌曲，支持直播间 BGM 版权。我们建议您使用声网 SDK 中自带的 DRM 模块来使用声网版权音乐。具体步骤如下：

1. 联系声网服务人员，开通版权音乐使用权限。

2. 自己业务服务器通过 OpenAPI 向声网版权音乐服务获取歌曲信息，保存在自己的服务端。

3. 做一个客户端歌曲搜索与点歌页面。当用户点击某一首歌曲后，可以获得歌曲的 SongCode，然后通过声网 SDK 进行歌曲预加载和播放。

4. 如果需要歌词展示，声网 SDK 还可以直接通过 SongCode 获取具体的歌词文件地址，获取歌词后就可以展示。

5. 在歌曲播放时，需要使用声网 SDK 中的 MediaPlayerKit 播放器，通过 SongCode 播放。

注意：声网 DRM 版权音乐不仅能用于聊天室中的背景音乐，还可以用于 K 歌等应用。更多关于版权音乐的信息，请参考[声网歌曲内容中心](https://docs.agora.io/cn/online-ktv/ktv_song_rest?platform=All%20Platforms)。

### 第三方版权音乐（例如：AME）//TODO

版权来源还可以来自第三方版权音乐服务商，例如 AME。一般第三方音乐服务商都会提供一个 SDK，用于音乐播放。

声网 SDK 可以很好地适配第三方版权音乐。具体流程如下（以 AME 为例）：

1. 歌曲搜索、点歌等逻辑都与 APP 业务逻辑及第三方版权音乐相关。

2. 用户确认歌曲后，只需要 AME SDK 对音乐进行解码，禁止声音播放。

3. 从 AME SDK 的音乐裸数据回调中，获取 PCM 裸数据，然后使用声网自采集相关 API 将其发送给声网 SDK，声网 SDK 内部自动将麦克风声音和 AME 音乐声音混合后发送到声网频道中。音频裸数据的使用请参考[声网自定义音频采集](https://docs.agora.io/cn/live-streaming-premium-4.x/custom_audio_src_apple_ng?platform=iOS)。

4. 声网 SDK 启用 localPlayback 模式，以使 AME 解码出来的 PCM 数据能够用声网 SDK 播放。

5. 总结来说就是：音频自采集 + localPlayback。

## 音量波纹提示

在语聊房中，房间内的听众一般需要知道谁在说话，通常是使用波纹提示。该功能可以直接使用声网 RTC SDK 中的 [enableAudioVolumeIndication](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_audio_process.html#api_irtcengine_enableaudiovolumeindication) 方法启用音量提示功能，建议你在启用音量提示时设置音量提示时间间隔为 500 毫秒。你可以从 SDK 触发的 [onAudioVolumeIndication](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#callback_irtcengineeventhandler_onaudiovolumeindication) 回调获得本地和远端讲话者的音量信息，一般在 `volume` 值大于 20 的时，你需要给出音量提示。

