---
title: 播放音频文件
platform: Android
updatedAt: 2020-12-03 12:01:02
---
## 功能描述

在通话或直播过程中，除了用户自己说话的声音，有时候需要播放自定义的声音或者音乐文件并且让频道内的其他人也听到，比如需要给游戏添加音效，或者需要播放背景音乐等，Agora 提供以下两组方法可以满足播放音效和音乐文件的需求。

开始前请确保已在你的项目中实现基本的实时音视频功能。 详见[开始音视频通话](start_call_android)或[开始互动直播](start_live_android)。

## 播放音效文件

音效通常指持续很短的音频。播放音效文件方法主要用来播放短小的音效，比如鼓掌、游戏子弹撞击声音等，可以多个音效叠加播放，且音效文件可以预加载以提高性能。
Agora SDK 提供 `IAudioEffectManager` 类统一管理音效，包含一些管理音效的常用方法。 音效由音频文件路径指定，但在 `IAudioEffectManager` 内部使用 sound id 来识别和处理音效。音效文件通常保存在 **assets** 文件夹下；SDK 并不强制如何定义 sound id，保证每个音效有唯一的识别即可。一般的做法有自增 id，使用音效文件名的 hashCode 等。

### 实现方法

参考如下步骤，在你的项目中实现播放音效文件：

1. 在加入频道前调用 `getAudioEffectManager` 方法获取音效管理类 `IAudioEffectManager`。
2. 调用 `preloadEffect` 方法预加载音效文件，可以多次调用该方法加载多个音效文件。
3. 加入频道后调用 `playEffect` 方法播放音效文件，可以多次调用该方法同时播放多个音效。我们建议最多同时播放三个音效文件。

<div class="alert note">管理音效的方法需通过 <code>IAudioEffectManager</code> 接口类调用。</div>

下图展示与播放音效相关的 API 时序，在开始播放音效后你还可以调用其他音效相关的方法实现更多功能，包括暂停播放音效、设置音效音量、释放预加载的音效等。

![](https://web-cdn.agora.io/docs-files/1569321491742)

**示例代码**

```java
// 首先获取全局的音效管理类
IAudioEffectManager manager = rtcEngine.getAudioEffectManager();
  
// 预加载音效（推荐），需注意音效文件的大小，并在加入频道前完成加载
// 仅支持 mp3，aac，m4a，3gp，wav格式
// 开发者可能需要额外记录 id 与文件路径的关联关系，用来播放和停止音效
int id = 0;
manager.preloadEffect(id++, "path/to/effect1");
  
// 可以加载多个音效
manager.preloadEffect(id++, "path/to/effect2");
  
// 播放一个音效
manager.playEffect(
0,                         // 要播放的音效 id 
"path/to/effect1",         // 播放文件的路径
-1,                        // 播放次数，-1 代表无限循环
0.0,                       // 改变音效的空间位置，0表示正前方
100,                       // 音量，取值 0 ~ 100， 100 代表原始音量
true                       // 是否令远端也能听到音效的声音
 );
  
// 暂停所有音效播放
manager.pauseAllEffects();
  
// 获取音效的音量，范围为 0 ~ 100
double volume = manager.getEffectsVolume();
  
// 保证音效音量在原始音量的 80% 以上
volume = volume < 80 ? 80 : volume;
manager.setEffectsVolume(volume);
  
// 继续播放暂停的音效
manager.resumeAllEffects();
  
// 停止所有音效
manager.stopAllEffects();
  
// 释放预加载的音效
manager.unloadAllEffects();
```

### API 参考

- [`getAudioEffectManager`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#afd61b8d5e923f9e03cd419dcaf23b4af)


### 开发注意事项

- 预加载不是一个必须的步骤，一般来说为了提高性能或者需要反复播放某个特定的音效的时候，我们建议使用预加载。但如果音效文件比较大，不建议预加载。
- 以上方法都有返回值，返回值小于 0 表示方法调用失败。

## 音乐混音

混音是指播放本地或者在线音乐文件，同时让频道内的其他人听到此音乐。混音方法主要用来播放比较长的背景音，比如直播的时候播放的音乐，同时只可以有一个文件播放。如果在混音播放第一个文件的过程中播放第二个文件，会自动停止第一个文件的播放。

Agora 混音功能支持如下设置：

- 混音或替换： 混音指的是音乐文件的音频流跟麦克风采集的音频流进行混音（叠加）并编码发送给对方；替换指的是麦克风采集的音频被音乐文件的音频流替换掉，对方只能听见音乐播放。
- 循环：可以设置是否循环播放混音文件，以及循环次数。

### 实现方法

```java
// 混音设置
int loopCount = -1; //无限循环播放混音文件；设置为正整数表示混音文件播放的次数
boolean shouldLoop = true; ////文件音频流是否发送给对端；如果设置为 true，文件音频流仅在本地可以听见，不会发送到对端
boolean replaceMic = false; //不替换麦克风采集的音频
  
// 开始播放混音
rtcEngine.startAudioMixing("path/to/music", shouldLoop, replaceMic, loopCount);
  
// 调整混音的音量。取值为 0 ~ 100, 100 代表维持原来混音的音量（默认）。
int volume = 50;
rtcEngine.adjustAudioMixingVolume(volume);
  
// 获取当前播放的混音音乐的时长
int duration = rtcEngine.getAudioMixingDuration();
// duration 可以用来设置播放进度条的最大进度等
// seekBar.setMax(duration);
  
// 获取当前混音的播放进度
int currentPosition = rtcEngine.getAudioMixingCurrentPosition();
// 可以设置 timer 定时获取播放进度，用来显示播放进度
// seekBar.setProgress(currentPosition);
  
// 若用户拖动了进度条，可以在 seekBar 的回调中获取 progress 并重设音乐当前播放的位置
rtcEngine.setAudioMixingPosition(progress);
  
// 暂停、恢复混音文件播放
rtcEngine.pauseAudioMixing();
rtcEngine.resumeAudioMixing();
  
// 停止播放混音文件，麦克风采集播放恢复
rtcEngine.stopAudioMixing()；
```

同时，我们在 GitHub 提供一个实现了混音功能的的开源示例项目。你可以在 [OpenVideoCall-Android](https://github.com/AgoraIO/Basic-Video-Call/blob/master/Group-Video/OpenVideoCall-Android) 下载体验并参考 [`CallActivity.java`](https://github.com/AgoraIO/Basic-Video-Call/blob/master/Group-Video/OpenVideoCall-Android/app/src/main/java/io/agora/openvcall/ui/CallActivity.java) 中的代码。

### API 参考

- [`startAudioMixing`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ac56ceea1a143a4898382bce10b04df09)
- [`stopAudioMixing`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#addb1cbc23b7f725eea6eedd18412854d)
- [`adjustAudioMixingVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a13c5737248d5a5abf6e8eb3130aba65a)
- [`pauseAudioMixing`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ab2d4fb72ec3031f59da72b55857e0da7)
- [`resumeAudioMixing`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aedad78215c21f0a6acac7f155199f3ce)
- [`getAudioMixingDuration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8bbeb8a8b07e4e7b1a0a493f1c66998d)
- [`getAudioMixingCurrentPosition`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a5119b0e6b356f867f7e13a6e1b2bb3e5)
- [`setAudioMixingPosition`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a12c3dc250c86d54552c1589dfda2e002)

### 开发注意事项

- 混音要求安卓系统版本 4.2 以上、API Level 至少为 16。
- 在频道内调用混音方法，否则会有潜在问题。
- 若运行在模拟器中，混音只能播放位于 **/sdcard/** 下的 mp3 文件。
- 以上方法都有返回值。返回值小于 0 表示方法调用失败。

## 相关链接

当播放音乐文件时，你还可以参考如下文档：

- [为什么 Android 10 无法使用 startAudioMixing 播放背景音乐？](https://docs.agora.io/cn/faq/android_startaudiomixing_permission)