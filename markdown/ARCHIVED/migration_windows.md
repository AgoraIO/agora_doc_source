---
title: 升级指南：从 v2.0.8 升级至 v2.3.2（Windows)
platform: Windows
updatedAt: 2021-01-18 07:54:52
---

本页包含 Agora SDK for Windows 从 v2.0.x 到 v2.3.2 升级后，用户需要注意的 API 用法变更。

## 重要变更

#### 1. 动态密钥升级

为更好地提升用户体验，Agora SDK 在 v2.1.0 版本中对动态秘钥进行了升级。 如果你从 v2.1.0 之前升级至 v2.1.0 及之后的版本，请务必注意此条变更。

**变更点：**

- v2.1.0 之前，每个鉴权服务，如加入频道或设置用户角色，都需要一个独立的动态密钥；
- v2.1.0 用一个动态密钥（Token）包含了所有的服务权限信息。用户仅需要在加入频道 `joinChannel` 时传入 Token，需要更新权限时调用 `renewToken` 即可。
- 服务端动态密钥的生成字段中，删除了`unixTs/Ts` 授权时间戳字段。

**相关 API 更新对照表**

| **功能**     | **v2.0.2**                                                                                         | **v2.1.0** 及之后                                                                                     |
| ------------ | -------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| 加入频道     | `public int joinChannel(const char* channelKey, const char* channel, const char* info, uid_t uid)` | `virtual int joinChannel(const char* token, const char* channelId, const char* info, uid_t uid) = 0;` |
| 设置用户角色 | `public int setClientRole(CLIENT_ROLE_TYPE role, const char* permissionKey);`                      | `virtual int setClientRole(CLIENT_ROLE_TYPE role) = 0;`                                               |
| 动态密钥过期 | `public virtual void onRequestChannelKey();`                                                       | `virtual void onRequestToken();`                                                                      |
| 更新动态密钥 | `public int renewChannelKey(const char* channelKey);`                                              | `virtual int renewToken(const char* token) = 0;`                                                      |

详细的动态密钥升级及使用指南，请参考：

- [动态密钥升级说明](./token_migration)
- [校验用户权限](./token?platform=All%20Platforms)
- [在服务端生成密钥](./token_server?platform=服务端)

#### 2. 设置视频编码属性

为满足场景中视频旋转的需要，提升自定义视频源画质，Agora SDK 在 v2.3.2 引入 `setVideoEncoderConfiguration` 接口替换原 `setVideoProfile` 接口，来设置视频编码属性。 新接口中的 `VideoEncoderConfiguration` 类对应一套视频参数，包含视频的分辨率、帧率、码率、最低编码码率以及视频方向。原接口 `setVideoProfile` 仍可使用，但不再推荐。更多文档请参考：

- [设置视频属性](./videoProfile_windows?platform=Windows)
- [视频采集旋转](./rotation_guide_android?platform=Windows)

#### 3. 透明质量数据

为提升质量透明的用户体验，Agora SDK 在 v2.3.2 废弃了原有的 `onAudioQuality` 回调，并新增 `onRemoteAudioStats` 回调进行取代。新接口使用更为综合的算法，使回调结果更贴近用户感受。

此外，Agora SDK 对接入频道前和后的 last mile 网络质量进行了算法优化，提高了 `onLastmileQaulity` 和 `onNetworkQuality` 回调数据的准确性。

#### 4. 新的 SDK 连接状态生成策略

为提升 SDK 使用数据统计的准确性和合理性，Agora SDK 在 v2.3.2 新增 `getConnectionState` 和 `onConnectionStateChanged` 接口，用以获取 SDK 的网络连接状态，以及连接状态发生改变的原因。同时废弃了原有的 `onConnectionInterrupted` 和 `onConnectionBanned`回调。

#### 5. 频道内说话者音量提示

Agora SDK 在 v2.2.0 改进了 `enableAudioVolumeIndication` 接口的功能，无论频道内是否有人说话，都会在 `onAudioVolumeIndication` 回调中按设置的时间间隔返回一段时间内说话音量最高的用户及音量提示。

## 主要新增功能

- 使用声卡采集系统声音。通过 API `enableLoopbackRecording` 实现。
- 音效均衡和音效混淆。分别通过 API `setLocalVoiceEqualization` 和 `setLocalVoiceReverb` 实现。
- 直播场景下导入外部媒体流。通过 API `addInjectStreamUrl` 实现。
- 查询在线频道信息。支持使用 RESTful API 查询指定频道内的分角色用户列表、查询厂商频道列表等信息。
- 音效文件管理与播放。支持用户播放短小的音效，比如鼓掌、游戏子弹撞击声音等。多个音效可叠加播放，且音效文件可以预加载以提高性能。包含以下接口：

  - `getEffectsVolume`：获取音效文件的播放音量
  - `setEffectsVolume`：设置音效文件的播放音量
  - `setVolumeOfEffect`：设置单个音效文件的播放音量
  - `playEffect`：播放指定的音效文件
  - `stopEffect`：停止播放指定的音效文件
  - `stopAllEffects`：停止播放所有的音效文件
  - `preloadEffect`：将音效文件预加载至内存
  - `unloadEffect`：从内存释放某个预加载的音效文件
  - `pauseEffect`：暂停播放音效文件
  - `pauseAllEffects`：暂停播放所有音效文件
  - `resumeEffect`：恢复播放指定音效文件
  - `resumeAllEffects`：恢复播放所有音效文件

- 服务端部署代理服务器。支持有企业防火墙的用户使用 Agora 服务。
- 获取远端视频状态。通过 API `onRemoteVideoStateChanged` 实现。
- 直播场景下添加视频水印。支持用户将一张 PNG 图片作为水印添加到本地或旁路直播中。本地直播通过 API `addVideoWatermark` 实现；旁路直播通过 `setLiveTranscoding` 中的 `watermark` 参数实现。
- 视频自采集（Push 模式）。通过 API `setExternalVideoSource` 和 `pushVideoFrame` 实现。
- 音频自渲染（Pull 模式）。通过 API `setExternalAudioSink` 和 `pullAudioFrame` 实现。
- 分别控制混音音乐文件的本地和远端播放音量。分别通过 API `adjustAudioMixingPlayoutVolume` 和 `adjustAudioMixingPublishVolume` 实现。
- 直播中弱网环境下视频自动回退/重开。网络不理想的环境下，直播音视频的质量都会下降。启用该功能后会优先保证音频的传输质量。涉及如下接口：

  - `setLocalPublishFallbackOption`：设置本地发布流回退选项
  - `setRemoteSubscribeFallbackOption`：设置订阅流回退选项
  - `onLocalPublishFallbackToAudioOnly`：本地发布流已回退为音频流或恢复为视频流回调
  - `onRemoteSubscibeFallbackToAudioOnly`：订阅流已回退为音频流或恢复为视频流回调

- 按用户返回音视频的上下行码率、帧率、丢包率及延迟。通过 API `onRemoteAudioTransportStats` 和 `onRemoteVideoTransportStats` 实现。
