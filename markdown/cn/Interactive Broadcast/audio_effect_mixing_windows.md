---
title: 播放音频文件
platform: Windows
updatedAt: 2020-12-04 01:39:56
---
## 功能描述

在实时音视频互动过程中，为烘托气氛、增添趣味性，用户通常需要播放音效或音乐文件并且让频道内所有用户都听到。例如，在游戏中添加打斗声，在唱歌时添加伴奏。Agora 提供两组独立的方法，你可以分别实现播放音效和音乐文件。

## 示例项目

Agora 在 GitHub 上提供已实现播放[音效](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample/APIExample/Advanced/AudioEffect)和[音乐](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample/APIExample/Advanced/AudioMixing)文件功能的开源示例项目。你可以下载体验并参考源代码。

## 音效文件

本文提到的音效是指持续时间短的氛围音，例如掌声、欢呼声、打斗声、枪击声等，通常多个音效可以叠加使用。

Agora 提供一组方法播放和管理音效文件，主要包括如下功能：

- 播放本地或在线音效文件
- 设置音效的空间位置、循环次数、播放位置、音量等播放选项
- 灵活控制指定或全部音效文件的播放、暂停、恢复与停止

<div class="alert note">支持的音效文件格式包括 MP3、AAC、M4A、MP4、WAV 和 3GP。详见 <a href="https://docs.microsoft.com/zh-cn/windows/desktop/medfound/supported-media-formats-in-media-foundation">Supported Media Formats in Media Foundation</a>。</div>

参考如下步骤实现播放音效文件：

1. 加入频道前调用 `preloadEffect` 方法预加载本地音效文件。
2. 加入频道后调用 `playEffect` 方法播放音效文件。当音效文件播放完成时，SDK 会触发 `onAudioEffectFinished` 回调。

### 指定音效文件

在播放音效文件前，你需要设置 `filePath` 和 `soundId `指定音效文件。两个参数的含义如下：

- `filePath`: 音效文件路径，支持本地或在线文件路径。SDK 会在该路径中查找音效文件。
- `soundId`: 音效 ID，由你自行定义，具有唯一性。SDK 会根据音效 ID 来识别音效文件。常见的音效 ID 定义方法有自增 ID、使用音效文件名的 hashCode 等。

```c++
// 设置根据指定的音效文件路径自动分配 soundId，并将音效文件路径和 soundId 关联。
m_mapEffect.insert(std::make_pair(strPath, m_soundId++));
```

### 预加载

SDK 支持预加载功能，你可以将音效文件提前加载到内存，以提高性能。预加载不是一个必须的步骤，Agora 建议你按需选择。

- 如果需要反复播放某个特定的音效，则建议预加载音效文件。
- 如果音效文件较大，则不建议预加载音效文件。

如需加载多个音效文件，你需要多次调用 `preloadEffect`。

<div class="alert note"><li>仅支持预加载本地音效文件。</li>
<li><code>preloadEffect</code> 需要在加入频道前调用。</li>
<li>调用 <code>preloadEffect</code> 后，音效文件会一直占用内存，直至调用 <code>unloadEffect</code> 或者离开频道。</li></div>

```c++
// 将指定的本地音效文件预加载至内存。 
m_rtcEngine->preloadEffect(m_mapEffect[strEffect], strPath.c_str());

// 释放预加载的音效文件。 
m_rtcEngine->unloadEffect(m_mapEffect[strEffect]);
```

### 播放和停止

调用 `playEffect` 播放音效文件。根据需求，你可以多次调用 `playEffect` 同时播放多个音效文件。在播放音效文件时，你可以设置循环次数、音调、音量、播放位置等。

<div class="alert note"><code>playEffect</code> 需要在加入频道后调用。</div>

```c++
// 设置音效循环播放的次数。-1 表示无限循环。 
int loops = -1;
// 设置的音效的音调。取值范围为 [0.5, 2.0]。1.0 表示原始音调。
double pitch = 1.5; 
// 设置音量。取值范围为 [0,100]，100 表示原始音量。 
int gain = 100; 
// 设置的音效空间位置。取值范围为 [-1.0,1.0]。
// -1.0 表示音效出现在左边；0 表示音效出现在正前方；1 表示音效出现在右边。
double pan = 1.0; 
// 设置是否将音效发布至远端。true 表示本地用户和远端用户都能听到音效；false 表示只有本地用户能听到音效。 
BOOL publish = true; 
// 设置音效文件的播放位置。500 表示从音效文件的第 500 ms 开始播放。
int startPos = 500; 
 
// 播放指定的音效文件。
m_rtcEngine->playEffect(m_mapEffect[strEffect], strFile.c_str(), loops, pitch, pan, gain, publish, startPos); 
 
// 本地音效文件播放已结束回调。 
void onAudioEffectFinished(m_mapEffect[strEffect]);
```

成功播放后，你可以停止播放指定或全部的音效文件。

```c++
// 停止播放指定的音效文件。
m_rtcEngine->stopEffect(m_mapEffect[strEffect]);
 
// 停止播放所有音效文件。
m_rtcEngine->stopAllEffects();
```

### 暂停与恢复

在音效文件播放时，你可以暂停或恢复播放指定或全部音效文件。

<div class="alert note">本组方法需要在 <code>playEffect</code> 后调用。</div>

```c++
// 暂停播放指定的音效文件。 
m_rtcEngine->pauseEffect(m_mapEffect[strEffect]);
 
// 暂停播放所有的音效文件。
m_rtcEngine->pauseAllEffects();
 
// 恢复播放指定的音效文件。 
m_rtcEngine->resumeEffect(m_mapEffect[strEffect]);
 
// 恢复播放所有的音效文件。
m_rtcEngine->resumeAllEffects();
```

### 播放位置

如需在播放音效文件后调整播放位置，你可以调用本组方法。例如，在循环播放音效文件期间，你可以调用本组方法调整播放位置，无需停止播放。

<div class="alert note"><li><code>getEffectDuration</code> 需要在加入频道后调用，本组其他方法需要在 <code>playEffect</code> 后调用。</li>
<li>本组方法仅适用于本地音效文件。</li></div>

```c++
// 获取指定本地音效文件的总时长。 
m_rtcEngine->getEffectDuration(strFile.c_str());
 
// 设置指定音效文件的播放位置。500 表示从音效文件的第 500 ms 开始播放。 
m_rtcEngine->setEffectPosition(m_mapEffect[strEffect], 500);
 
// 获取指定本地音效文件的总时长。
m_rtcEngine->getEffectCurrentPosition(m_mapEffect[strEffect]);
```

### 音量

在音效文件开始播放后，你可以调用本组方法调节播放音量。例如，在循环播放音效文件期间，你可以调用本组方法调节播放音量，无需停止播放。

<div class="alert note">本组方法需要在 <code>playEffect</code> 后调用。</div>

```c++
// 设置所有音效文件的播放音量。取值范围为 [0,100]，100 表示原始音量。 
m_rtcEngine->setEffectsVolume(50);
 
// 设置指定音效文件的播放音量。取值范围为 [0,100]，100 表示原始音量。 
m_rtcEngine->setVolumeOfEffect(m_mapEffect[strEffect], 50); 
 
// 获取音效文件的播放音量。音量范围为 [0,100]，100 表示原始音量。 
m_rtcEngine->getEffectsVolume();
```

### API 参考

- [`preloadEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a02d0b23b0b66e8fb0e898eb2811a8e74)
- [`unloadEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#aa560240d5994be0c1a7853e96077e5f9)
- [`playEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#aa713b173d4b9aa234f482ebb932f5955)
- [`stopEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ad74eb7c7799b8762bff2b1e7e7bba8b9)
- [`stopAllEffects`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a888ecfec4fda81831988898420d60e49)
- [`pauseEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a3c820db172c7fb43da58d81b7916d174)
- [`pauseAllEffects`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ad731a94d9db9e2c3390e1443b379095f)
- [`resumeEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a6489955af474172afe4f4b44e4edb38a)
- [`resumeAllEffects`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a2fc1b5996df964f8e12ce579e0eb5f98)
- [`getEffectDuration`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a4d2a31c0016d1da9106222edb6c395fd)
- [`setEffectPosition`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#acc753bf864b6c84d97c2d6778234c36e)
- [`getEffectCurrentPosition`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#abe60e8ce475a3fef96245ffc47e95e50)
- [`setEffectsVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#add9a7fd856700acd288d47ff3c7da19d)
- [`setVolumeOfEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a08287428f277b7bf24d51a86ef61799b)
- [`getEffectsVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a0e9787c57db5b5e8fcc53ef5bb6d24c7)
- [`onAudioEffectFinished`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ab329b207f42408b3f673837a5de3b9e5)

## 音乐混音

音乐混音是指将音乐文件与麦克风采集的音频混合。使用混音功能的用户通常会播放比较长的音乐文件，并且同一时间只播放一个音乐文件。例如，在唱歌时播放伴奏，在聊天时播放背景音乐。

Agora 提供一组方法播放和管理音乐文件，主要包括如下功能：

- 播放本地或在线音乐文件
- 设置音乐文件的播放次数、播放位置、音量、音调等播放选项
- 灵活控制音乐文件的播放、暂停、恢复与停止
- 报告当前的音乐文件播放状态和播放状态改变的原因

<div class="alert note">支持的音效文件格式包括 MP3、AAC、M4A、MP4、WAV 和 3GP。详见 <a href="https://docs.microsoft.com/zh-cn/windows/desktop/medfound/supported-media-formats-in-media-foundation">Supported Media Formats in Media Foundation</a>。</div>

成功调用 `startAudioMixing` 后，当音乐文件播放状态发生改变时，SDK 会触发 `onAudioMixingStateChanged` 回调。

### 播放和停止

调用 `startAudioMixing` 播放音乐文件。在播放音乐文件时，可以设置循环次数、播放位置等。

<div class="alert note">如果在播放一个音乐文件时再次调用 <code>startAudioMixing</code>，则 SDK 会自动停止播放上一个音乐文件并开始播放下一个音乐文件。</div>

```c++
// 指定需要混音的本地或在线音乐文件的绝对路径。 
std::string strAudioPath = "C:\music\audio.mp4";
// 设置是否只在本地播放音乐文件。true 表示只有本地用户能听到音乐；false 表示本地用户和远端用户都能听到音乐。 
BOOL bOnlyLocal = FALSE;
// 设置是否用音乐文件替换麦克风采集的音频。true 表示用户只能听到音乐；false 表示用户可以听到音乐和麦克风采集的音频。 
BOOL bReplaceMicroPhone = TRUE;
// 设置音乐文件的播放次数。1 表示播放 1 次。 
int iRepeatTimes = 1;
// 设置音乐文件的播放位置。500 表示从音乐文件的第 500 ms 开始播放。 
int startPos = 500; 
 
// 开始播放音乐文件。 
m_rtcEngine->startAudioMixing(strAudioPath.c_str(), bOnlyLocal, bReplaceMicroPhone, iRepeatTimes, startPos);
 
// 本地用户的音乐文件播放状态已改变回调。 
void onAudioMixingStateChanged(AUDIO_MIXING_STATE_TYPE state, AUDIO_MIXING_REASON_TYPE reason)
```

成功播放音乐文件后，你可以调用 `stopAudioMixing` 停止播放。

```c++
//停止播放音乐文件。
m_rtcEngine->stopAudioMixing();
```

### 暂停与恢复

在音乐文件播放时，你可以暂停或恢复播放音乐文件。

<div class="alert note">本组方法需要在 <code>startAudioMixing</code> 后调用。</div>

```c++
// 暂停播放音乐文件。 
m_rtcEngine->pauseAudioMixing();
 
// 恢复播放音乐文件。 
m_rtcEngine->resumeAudioMixing();
```

### 播放位置

在音乐文件播放时，你可以调用本组方法调整音乐文件的播放位置，无需停止播放。

<div class="alert note">本组方法需要在调用 <code>startAudioMixing</code> 并收到 <code>onAudioMixingStateChanged(AUDIO_MIXING_STATE_PLAYING)</code> 回调后调用。</div>

```c++
// 获取指定音乐文件的总时长。 
m_rtcEngine->getAudioMixingDuration(strAudioPath.c_str()); 
 
// 设置当前音乐文件的播放位置。500 表示从音乐文件的第 500 ms 开始播放。 
m_rtcEngine->setAudioMixingPosition(500); 
 
// 获取当前音乐文件的播放位置。 
m_rtcEngine->getAudioMixingCurrentPosition();
```

### 音量与音调

成功播放音乐文件后，你可以调用本组方法调整音乐文件的播放音量与音调，无需停止播放。

<div class="alert note">本组方法需要在调用 <code>startAudioMixing</code> 并收到 <code>onAudioMixingStateChanged(AUDIO_MIXING_STATE_PLAYING)</code> 回调后调用。</div>

```c++
// 调节当前音乐文件在本地和远端的播放音量。取值范围为 [0,100]，100 表示原始音量。 
m_rtcEngine->adjustAudioMixingVolume(50); 
 
// 调节当前音乐文件在远端的播放音量。取值范围为 [0,100]，100 表示原始音量。 
m_rtcEngine->adjustAudioMixingPublishVolume(50); 
 
// 调节当前音乐文件在本地的播放音量。取值范围为 [0,100]，100 表示原始音量。 
m_rtcEngine->adjustAudioMixingPlayoutVolume(50); 
 
// 获取当前音乐文件在本地的播放音量。音量范围为 [0,100]，100 表示原始音量。 
m_rtcEngine->getAudioMixingPlayoutVolume(); 
 
// 获取当前音乐文件在远端的播放音量。音量范围为 [0,100]，100 表示原始音量。 
m_rtcEngine->getAudioMixingPublishVolume(); 
 
// 调节当前音乐文件的音调。取值范围为 [-12,12]，0 表示原始音调，1 表示升高一个半音。
m_rtcEngine->setAudioMixingPitch(5);
```

### API 参考

- [`startAudioMixing`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a21063bfb71a8a5cbc0d391f9d7ac75be)
- [`stopAudioMixng`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a2b90cbf4142c913b3efa795482713b08)
- [`pauseAudioMixing`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ab86885c38e7ee7a4b37d5bbacafcaa24)
- [`resumeAudioMixing`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a5a9606ad7ca4995e0d37fcf1642fe401)
- [`getAudioMixingDuration`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a3b67f2476a43679cc5174ac5424efed5)
- [`setAudioMixingPosition`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a6c69e2229c438fd587b8f81df34214ad)
- [`getAudioMixingCurrentPosition`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#aae54b86e9e6a7c0ed955b96f011855cb)
- [`adjustAudioMixingVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a544aee96b789ac5a57d26b61b7e1a5fa)
- [`adjustAudioMixingPublishVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a9fafbaaf39578810ec9c11360fc7f027)
- [`adjustAudioMixingPlayoutVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a8677c3f3160927d25d9814a88ab06da6)
- [`getAudioMixingPlayoutVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#aed9dda5a7b2683776f41f6ba0e1f281c)
- [`getAudioMixingPublishVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#aa65e55a9a331cfd32b36d8847a9631a4)
- [`setAudioMixingPitch`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a26b117f7e097801b03522f7da9257425)
- [`onAudioMixingStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ae2e257d7bbf120b970b600b9b3731a07)