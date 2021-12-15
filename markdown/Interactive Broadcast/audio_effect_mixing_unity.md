---
title: 播放音效与混音文件
platform: Unity
updatedAt: 2020-12-03 12:01:03
---

## 功能描述

在通话或直播过程中，除了用户自己说话的声音，有时候需要播放自定义的声音或者音乐文件并且让频道内的其他人也听到，比如需要给游戏添加音效，或者需要播放背景音乐等，Agora 提供以下两组方法可以满足播放音效和音乐文件的需求。

开始前请确保已在你的项目中实现基本的实时音视频功能。 详见[实现音频通话](start_call_audio_unity)或[实现音频直播](start_live_audio_unity)。

## 播放音效文件

音效通常指持续很短的音频。播放音效文件方法主要用来播放短小的氛围音，比如鼓掌、游戏子弹撞击声音等，可以多个音效叠加播放。

音效由音频文件路径指定，但在 SDK 内部使用 `nSoundID` 来识别和处理音效。SDK 并不强制如何定义 `nSoundID`，保证每个音效有唯一的识别即可。一般的做法有自增 id，使用音效文件名的 hashCode 等。

### 实现方法

参考如下步骤，在你的项目中实现播放音效文件：

1. 在加入频道前调用 `GetAudioEffectManager` 方法获取音效管理类 `AudioEffectManagerImpl`。
2. 调用 `PreloadEffect` 方法预加载音效文件，可以多次调用该方法加载多个音效文件。
3. 加入频道后调用 `PlayEffect` 方法播放音效文件，可以多次调用该方法同时播放多个音效。我们建议最多同时播放三个音效文件。

<div class="alert note">管理音效的方法需通过 AudioEffectManagerImpl 接口类调用。</div>

下图展示与播放音效相关的 API 时序，在开始播放音效后你还可以调用其他音效相关的方法实现更多功能，包括暂停播放音效、设置音效音量、释放预加载的音效等。

![](https://web-cdn.agora.io/docs-files/1582636467838)

#### 示例代码

```C#
// 初始化参数对象。
AudioEffectManagerImpl audioEffectManager = (AudioEffectManagerImpl)mRtcEngine.GetAudioEffectManager();
// 预加载音效文件，可以多次调用该方法加载多个音效文件。
int ret = audioEffectManager.PreloadEffect(nSoundID, filePath);
// 播放指定音效文件。
int ret = audioEffectManager.PlayEffect(nSoundID, filePath, nLoopCount, dPitch, dPan, nGain, true);
// 暂停指定的音效播放。
int ret = audioEffectManager.PauseEffect(nSoundID);
// 暂停所有音效播放。
int ret = audioEffectManager.PauseAllEffects();
// 继续播放已暂停的指定音效文件。
int ret = audioEffectManager.ResumeEffect(nSoundID);
// 继续播放所有已暂停的指定音效文件。
int ret = audioEffectManager.ResumeAllEffects();
// 停止播放指定音效文件。
int ret = audioEffectManager.StopEffect(nSoundID);
// 停止播放所有音效文件。
int ret = audioEffectManager.StopAllEffects();
// 从内存释放某个预加载的音效文件。
int ret = audioEffectManager.UnloadEffect(nSoundID);
```

### API 参考

- [GetAudioEffectManager](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a6f928012c4340b00e12aaa0454fb50f6)
- [PreloadEffect](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#aab6c3c7609de0fd828f5ee9aa59ffb0b)
- [PlayEffect](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#a7a207e0a7571300b41dda0d090a6ab02)
- [PauseEffect](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#ab978acce35871df40154119a18595545)
- [PauseAllEffects](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#aa01bdc22a8a367a4170012ad9b5a5310)
- [ResumeEffect](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#a85bec95b2d382fdfaebbcbf3f5a0f10f)
- [ResumeAllEffects](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#a1b7b23d134808c68457f589776731e2f)
- [StopEffect](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#aedeb24d257c949d0f85123f4c6032dab)
- [StopAllEffects](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#aef6fbcc325665a99f681fbe5a19c3aa5)
- [UnloadEffect](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#af7956fe2ea320af080f6970ac446496e)

### 开发注意事项

预加载不是一个必须的步骤，一般来说为了提高性能或者需要反复播放某个特定的音效的时候，我们建议使用预加载。但如果音效文件较大，不建议预加载。

## 音乐混音

混音是指播放本地或者在线音乐文件，同时让频道内的其他人听到此音乐。混音方法主要用来播放比较长的背景音，比如直播的时候播放的音乐，同时只可以有一个文件播放。如果在混音播放第一个文件的过程中播放第二个文件，会自动停止第一个文件的播放。

Agora 混音功能支持如下设置：

- 混音或替换： 混音指的是音乐文件的音频流跟麦克风采集的音频流进行混音（叠加）并编码发送给对方；替换指的是麦克风采集的音频被音乐文件的音频流替换掉，对方只能听见音乐播放。
- 循环：可以设置是否循环播放混音文件，以及循环次数。

### 实现方法

```C#
string filePath = "http://www.hochmuth.com/mp3/Haydn_Cello_Concerto_D-1.mp3";
// 开始播放音乐文件。
int ret = mRtcEngine.StartAudioMixing(filePath, false, true, 1);
// 将本地和远端音乐文件播放音量调节为原始音量的 50%。
int ret = mRtcEngine.AdjustAudioMixingVolume(50);
// 获取音乐文件的本地播放音量。
int ret = mRtcEngine.GetAudioMixingPlayoutVolume();
// 获取音乐文件的远端播放音量。
int ret = mRtcEngine.GetAudioMixingPublishVolume();
// 获取音乐文件总时长。
int ret = mRtcEngine.GetAudioMixingDuration();
// 获取音乐文件的播放进度。
int ret = mRtcEngine.GetAudioMixingCurrentPosition();
// 将音乐文件的播放位置设置为第 3000 毫秒处。
int ret = mRtcEngine.SetAudioMixingPosition(3000);
// 停止播放音乐文件。
int ret = mRtcEngine.StopAudioMixing();
```

### API 参考

- [StartAudioMixing](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a6e819ce8d80033f797fd3044ec7dde86)
- [StopAudioMixng](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a2781e98a720d801d1adffbb02b450929)
- [PauseAudioMixing](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a5150ffea0000bd7c39531192d836f307)
- [ResumeAudioMixing](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#af4bfe442eb4ab52d197a321387f73824)
- [AdjustAudioMixingVolume](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ae6a3b1041004fdd5a031975a2f9cdb7e)
- [AdjustAudioMixingPlayoutVolume](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac7d6df07616489729d521ce47934bb299)
- [AdjustAudioMixingPublishVolume](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a0900c11feef9cbee498f17f95cd0aed2)
- [GetAudioMixingPlayoutVolume](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a0688ea2a1e059c437146653d72d70ac1)
- [GetAudioMixingPublishVolume](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#aba5f24855b141e491b9af60837304625)
- [GetAudioMixingDuration](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a9ea29289b75f1fb4623785854fb147eb)
- [GetAudioMixingCurrentPosition](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a9dce60db3e49f48291a91e199d8c2065)
- [SetAudioMixingPosition](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac332a0186694b1a367996fa41d23b88d)
- [OnAudioMixingStateChangedHandler](./API%20Reference/unity/namespaceagora__gaming__rtc.html#ab061cd429286b98043db14f106029829)
- [OnRemoteAudioMixingBeginHandler](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a09318aee595f81b430aba31a5f6ee7b3)
- [OnRemoteAudioMixingEndHandler](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a72da329b0efbde86c91bb513dfaa43e3)

### 开发注意事项

请确保在频道内调用混音方法，否则会有潜在问题。
