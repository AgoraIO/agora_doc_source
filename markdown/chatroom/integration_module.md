本文介绍语聊房解决方案中常用的进阶功能。

## 设置高音质

高音质会给语聊房带来更好的音频体验。你可以参考如下示例代码，调用声网 RTC SDK 中的 [`setAudioProfile`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#api_irtcengine_setaudioprofile2)、[`setAudioScenarios`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#api_irtcengine_setaudioscenario)、[`setParameters`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_network.html#api_irtcengine_setparameters) 方法来设置高音质：

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

## 播放背景音乐和音效

播放背景音乐和音效可以活跃语聊房内的气氛。本节介绍如何在语聊房中播放多种来源的音乐：

- 本地音乐文件或在线音乐文件。
- 声网提供的版权音乐。
- 第三方厂商提供的版权音乐。

### 本地音乐文件或在线音乐文件

如果主播使用的音乐文件是本地文件或在线文件，播放方式有如下两种：

- 调用声网 RTC SDK 中的 [`startAudioMixing`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#api_irtcengine_startaudiomixing) 方法播放文件。

- 使用声网 RTC SDK 中[内置媒体播放器](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_mediaplayer.html)来播放文件。

### 声网版权音乐

声网和音集协合作提供了数十万首热门歌曲。声网支持你在语聊房和直播间播放有版权的背景音乐。你可以参考如下步骤使用声网版权音乐来给语聊房增加趣味性：

1. 联系 sales@agora.io 开通声网版权音乐和内容中心服务。

2. 在你的业务服务器中，通过 RESTful API 向声网内容中心获取歌曲详细信息，并将信息保存在你的服务端。详见[声网内容中心 RESTful API](https://docportal.shengwang.cn/cn/online-ktv/ktv_song_rest?platform=All%20Platforms)。

3. 在你的业务客户端中，增加歌曲搜索和点歌的功能。当用户点击播放某首歌曲时，你需要获得歌曲的 `SongCode`（标识音乐资源的编号），然后通过声网 RTC SDK 中的[版权音乐 API](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_drm.html)预加载歌曲，通过声网 RTC SDK 中[内置媒体播放器](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_mediaplayer.html)播放歌曲。详见[客户端实现点歌](https://docportal.shengwang.cn/cn/online-ktv/ktv_integration_android?platform=Android)。

4. 如果需要展示歌词，你可以通过版权音乐 API 和 `SongCode` 来获取歌词文件地址，获取后你就可以展示歌词。详见[歌词组件](https://docportal.shengwang.cn/cn/online-ktv/ktv_karaoke_view_android?platform=Android)。


### 第三方版权音乐

你还可以在语聊房中使用第三方厂商提供的版权音乐，例如[腾讯正版曲库直通车（AME）](https://cloud.tencent.com/product/ame)。参考如下步骤在语聊房中播放第三方版权音乐：

1. 在你的业务客户端中，通过第三方版权音乐 SDK 实现歌曲搜索、点歌功能。当用户选中歌曲播放时，你需要使用第三方版权音乐 SDK 对歌曲进行解码，同时禁止播放歌曲声。

2. 通过第三方版权音乐 SDK 的原始音频数据 API，获取 PCM 格式的原始音频数据。

3. 通过[声网音频自采集功能](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/custom_audio_src_android_ng?platform=Android)将你之前获取的原始音频数据发送给声网 RTC SDK。声网 RTC SDK 内部会自动将麦克风采集到的声音和第三方版权音乐的歌曲声混合，并发送到声网 RTC 频道中，频道内的听众都可以听到这个混音。

**注意**：声网建议你在自采集音频时，将 [`setExternalAudioSource`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#api_imediaengine_setexternalaudiosource2) 方法中的 `localPlayback` 参数设置为 `true`，以使第三方音频可以在本地播放。


## 增加音量波纹提示

语聊房中的音量波纹提示功能可以让房间的听众看到谁正在发言。该功能的实现流程如下：

1. 调用声网 RTC SDK 中的 [enableAudioVolumeIndication](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#api_irtcengine_enableaudiovolumeindication) 方法启用音量提示功能，建议你在启用音量提示时设置音量提示时间间隔为 500 毫秒。

2. 你可以从 SDK 触发的 [onAudioVolumeIndication](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#callback_irtcengineeventhandler_onaudiovolumeindication) 回调获得本地和远端讲话者的音量信息。建议你在 `volume` 值大于 20 的时给出音量提示并在 UI 上制作音量对应的波纹效果。

