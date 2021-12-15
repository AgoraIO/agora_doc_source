---
title: 升级指南：从 v2.0.8 升级至 v2.3.4.100（Windows)
platform: Windows
updatedAt: 2021-01-18 07:56:28
---

本页包含 Agora SDK for Windows 从 v2.0.8 到 v2.3.4.100 升级后，用户需要注意的 API 用法变更。

## 重要变更

#### 1. 动态密钥升级

为更好地提升用户体验，Agora SDK 在 v2.1.0 版本中对动态密钥进行了升级。 如果你从 v2.1.0 之前升级至 v2.1.0 及之后的版本，请务必注意此条变更。

**变更点：**

- v2.1.0 之前，每个鉴权服务，如加入频道或设置用户角色，都需要一个独立的动态密钥；
- v2.1.0 用一个动态密钥（Token）包含了所有的服务权限信息。用户仅需要在加入频道 [`joinChannel`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#adc937172e59bd2695ea171553a88188c) 时传入 Token，需要更新权限时调用 [`renewToken`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a8f25b5ff97e2a070a69102e379295739) 即可。
- 服务端动态密钥的生成字段中，删除了`unixTs/Ts` 授权时间戳字段。

**相关 API 更新对照表**

| **功能**     | **v2.0.2**                                                                                         | **v2.1.0** 及之后                                                                                     |
| ------------ | -------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| 加入频道     | `public int joinChannel(const char* channelKey, const char* channel, const char* info, uid_t uid)` | `virtual int joinChannel(const char* token, const char* channelId, const char* info, uid_t uid) = 0;` |
| 设置用户角色 | `public int setClientRole(CLIENT_ROLE_TYPE role, const char* permissionKey);`                      | `virtual int setClientRole(CLIENT_ROLE_TYPE role) = 0;`                                               |
| 动态密钥过期 | `public virtual void onRequestChannelKey();`                                                       | `virtual void onRequestToken();`                                                                      |
| 更新动态密钥 | `public int renewChannelKey(const char* channelKey);`                                              | `virtual int renewToken(const char* token) = 0;`                                                      |

详细的动态密钥升级及使用指南，请参考：

- [动态密钥升级说明](https://docs.agora.io/cn/Agora%20Platform/token_migration?platform=All%20Platforms)
- [校验用户权限](./token?platform=All%20Platforms)
- [在服务端生成密钥](./token_server)

#### 2. 设置视频编码属性

为满足场景中视频旋转的需要，提升自定义视频源画质，Agora SDK 在 v2.3.2 引入 [`setVideoEncoderConfiguration`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a9bcbdcee0b5c52f96b32baec1922cf2e) 接口替换原 [`setVideoProfile`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ac8b16d2a4e67bd75231a76e06d2d85eb) 接口，来设置视频编码属性。 新接口中的 [`setVideoEncoderConfiguration`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a9bcbdcee0b5c52f96b32baec1922cf2e) 类对应一套视频参数，包含视频的分辨率、帧率、码率、最低编码码率以及视频方向。原接口 [`setVideoProfile`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ac8b16d2a4e67bd75231a76e06d2d85eb)仍可使用，但不再推荐。更多文档请参考：

- [设置视频属性](./video_profile_windows?platform=Windows)

#### 3. 透明质量数据

为提升质量透明的用户体验，Agora SDK 在 v2.3.2 废弃了原有的 [`onAudioQuality`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a36ad42975f3545382de07875016fb7fa) 回调，并新增 [`onRemoteAudioStats`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#af8a59626a9265264fb4638e048091d3a) 回调进行取代。新接口使用更为综合的算法，使回调结果更贴近用户感受。

此外，Agora SDK 对接入频道前和后的 last mile 网络质量进行了算法优化，提高了 [`onLastmileQuality`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ac7e14d1a26eb35ef236a0662d28d2b33) 和 [`onNetworkQuality`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a80003ae8cce02039f3aa0e8ffad7deed) 回调数据的准确性。

#### 4. 新的 SDK 连接状态生成策略

为提升 SDK 使用数据统计的准确性和合理性，Agora SDK 在 v2.3.2 新增 [`getConnectionState`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a512b149d4dc249c04f9e30bd31767362) 和 [`onConnectionStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#af409b2e721d345a65a2c600cea2f5eb4) 接口，用以获取 SDK 的网络连接状态，以及连接状态发生改变的原因。同时废弃了原有的 [`onConnectionInterrupted`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a9927b5cd2a67c1f48f17b5ed2303f483) 和 [`onConnectionBanned`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a38e9d403ae4732dff71110b454149404) 回调。

#### 5. 频道内说话者音量提示

Agora SDK 在 v2.2.0 改进了 [`enableAudioVolumeIndication`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a59ae67333fbc61a7002a46c809e2ec4f) 接口的功能，无论频道内是否有人说话，都会在 [`onAudioVolumeIndication`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aab1184a2b276f509870c055a9ff8fac4) 回调中按设置的时间间隔返回一段时间内说话音量最高的用户及音量提示。

## 主要新增功能

- 支持摄像头设备热插拔。通过 API [`initialize`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ac71db65e66942e4e0a0550e95c16890f) 中 `RtcEngineContext` 结构体的 `context` 成员实现。
- 实时反馈客户端到路由器的网络往返时延。通过 API `onRtcStats` 中 `RtcStats` 结构体的 `gatewayRtt` 成员实现。
- 使用声卡采集系统声音。通过 API [`enableLoopbackRecording`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a065f485fd23b8c24a593680a47d754aa) 实现。
- 音效均衡和音效混淆。分别通过 API [`setLocalVoiceEqualization`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a3de79ba906e6b254b997eda4d395d052) 和 [`setLocalVoiceReverb`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#aa00e903b1cc6f2752373afbe556ef456) 实现。
- 直播场景下导入外部媒体流。通过 API [`addInjectStreamUrl`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a42247db589b55d3cfa98d8e1be06d8e6) 实现。
- 查询在线频道信息。支持使用 RESTful API 查询指定频道内的分角色用户列表、查询厂商频道列表等信息。
- 音效文件管理与播放。支持用户播放短小的音效，比如鼓掌、游戏子弹撞击声音等。多个音效可叠加播放，且音效文件可以预加载以提高性能。包含以下接口：

  - [`getEffectsVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#aab2353ccbd0e09b224448c72fd381d19)：获取音效文件的播放音量
  - [`setEffectsVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#aa3041ef19bfe10ffc5a1130cda91ab7b)：设置音效文件的播放音量
  - [`setVolumeofEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a71fac1633ea84c892879781bee56d001)：设置单个音效文件的播放音量
  - [`playEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a26307c09cbbaecee3bd662294a935821)：播放指定的音效文件
  - [`stopEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#ab0520529fe0ca4eb56d75ff4468e4a03)：停止播放指定的音效文件
  - [`stopAllEffects`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a7f742bd2262899a90f4a36205995419e)：停止播放所有的音效文件
  - [`preloadEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a61e4eac3b78f2774ef1b22d69bd4e166)：将音效文件预加载至内存
  - [`unloadEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#afd2cc4d59101cef1b5dc9296e604d047)：从内存释放某个预加载的音效文件
  - [`pauseEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a75fc09bdd0bd8b2bfe9c47770eb1e928)：暂停播放音效文件
  - [`pauseAllEffects`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a98ff58bdd2b8683bd27a1f75694641dc)：暂停播放所有音效文件
  - [`resumeEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#adae083a10afd4b316a2071ba8d01ff80)：恢复播放指定音效文件
  - [`resumeAllEffects`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a66dd1578478dd3ca163768d1314cd50a)：恢复播放所有音效文件

- 服务端部署代理服务器。支持有企业防火墙的用户使用 Agora 服务。
- 获取远端视频状态。通过 API [`onRemoteVideoStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aac7b62b1307be124423008e45eb02f80) 实现。
- 直播场景下添加视频水印。支持用户将一张 PNG 图片作为水印添加到本地或旁路直播中。本地直播通过 API [`addVideoWatermark`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a7db71d3de47227f7419202fde0875058) 实现；旁路直播通过 [`setLiveTranscoding`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a0601e4671357dc1ec942cccc5a6a1dde) 中 `LiveTranscoding` 结构体的 `watermark` 成员实现。
- 视频自采集（Push 模式）。通过 API [`setExternalVideoSource`](./API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#a6716908edc14317f2f6f14ee4b1c01b7) 和 [`pushVideoFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#ae064aedfdb6ac63a981ca77a6b315985) 实现。
- 音频自渲染（Pull 模式）。通过 API [`setExternalAudioSink`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a08450bffffc578290d4a1317f2938638) 和 [`pullAudioFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#aaf43fc265eb4707bb59f1bf0cbe01940) 实现。
- 分别控制混音音乐文件的本地和远端播放音量。分别通过 API [`adjustAudioMixingPlayoutVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a99ab2878e0c4fbf1be6970a2c545d085) 和 [`adjustAudioMixingPublishVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a8f8d2af4b4c7988934e152e3b281d734) 实现。
- 直播中弱网环境下视频自动回退/重开。网络不理想的环境下，直播音视频的质量都会下降。启用该功能后会优先保证音频的传输质量。涉及如下接口：

  - [`setLocalPublishFallbackOption`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a0402734b50749081b20db3826f6f00ec)：设置本地发布流回退选项
  - [`setRemoteSubscribeFallbackOption`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a50e727c34b662de64c03b0479a7fe8e7)：设置订阅流回退选项
  - [`onLocalPublishFallbackToAudioOnly`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ace4279c4d87c23a1fecc3eb8e862a513)：本地发布流已回退为音频流或恢复为视频流回调
  - [`onRemoteSubscribeFallbackToAudioOnly`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7ee343146ad6e3f120bd04a7a6fdda74)：订阅流已回退为音频流或恢复为视频流回调

- 按用户返回音视频的上下行码率、帧率、丢包率及延迟。通过 API [`onRemoteAudioTransportStats`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ad79bcd56075fa9c9f907bb4a7462352d) 和 [`onRemoteVideoTransportStats`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a3b8fd883a31d4a504ac3cbd50b1c5d0f) 实现。
