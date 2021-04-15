---
title: 播放音频文件
platform: Windows
updatedAt: 2020-12-04 01:39:56
---
## 功能描述

在实时音视频互动过程中，为烘托气氛、增添趣味性，用户通常需要播放音效或音乐文件并且让频道内所有用户都听到。 例如，在游戏中添加打斗声，在唱歌时添加伴奏。 Agora 提供两组独立的方法，你可以分别实现播放音效和音乐文件。

## Sample project

Agora 在 GitHub 上提供已实现播放[音效](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample/APIExample/Advanced/AudioEffect)和[音乐](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample/APIExample/Advanced/AudioMixing)文件功能的开源示例项目。 You can view the source code on Github or download the project to try it out.

## 音效文件

本文提到的音效是指持续时间短的氛围音，例如掌声、欢呼声、打斗声、枪击声等，通常多个音效可以叠加使用。

Agora 提供一组方法播放和管理音效文件，主要包括如下功能：

- 播放本地或在线音效文件
- 设置音效的空间位置、循环次数、播放位置、音量等播放选项
- 灵活控制指定或全部音效文件的播放、暂停、恢复与停止



支持的音效文件格式包括 MP3、AAC、M4A、MP4、WAV 和 3GP。 详见 [Supported Media Formats in Media Foundation](https://docs.microsoft.com/zh-cn/windows/desktop/medfound/supported-media-formats-in-media-foundation)。

参考如下步骤实现播放音效文件：

1. 加入频道前调用 `preloadEffect` 方法预加载本地音效文件。
2. 加入频道后调用 `playEffect` 方法播放音效文件。 当音效文件播放完成时，SDK 会触发 `onAudioEffectFinished` 回调。

### 指定音效文件

在播放音效文件前，你需要设置 `filePath` 和 `soundId `指定音效文件。 两个参数的含义如下：

- `filePath`: 音效文件路径，支持本地或在线文件路径。 SDK 会在该路径中查找音效文件。
- `soundId`: 音效 ID，由你自行定义，具有唯一性。 SDK 会根据音效 ID 来识别音效文件。 常见的音效 ID 定义方法有自增 ID、使用音效文件名的 hashCode 等。

```
// 设置根据指定的音效文件路径自动分配 soundId，并将音效文件路径和 soundId 关联。 
m_mapEffect.insert(std::make_pair(strPath, m_soundId++));
```

### **预加载**

SDK 支持预加载功能，你可以将音效文件提前加载到内存，以提高性能。 预加载不是一个必须的步骤，Agora 建议你按需选择。

- 如果需要反复播放某个特定的音效，则建议预加载音效文件。
- 如果音效文件较大，则不建议预加载音效文件。

如需加载多个本地音效文件，你需要多次调用 `preloadEffect`。


- 仅支持预加载本地音效文件。
- `preloadEffect` 需要在加入频道前调用。
- 调用 `preloadEffect` 后，音效文件会一直占用内存，直至调用 `unloadEffect` 或者离开频道。

```
// 将指定的本地音效文件预加载至内存。  
m_rtcEngine->preloadEffect(m_mapEffect[strEffect], strPath.c_str()); 

// 释放预加载的音效文件。  
m_rtcEngine->unloadEffect(m_mapEffect[strEffect]);
```

### **播放和停止**

调用 `playEffect` 播放音效文件。 根据需求，你可以多次调用 `playEffect` 同时播放多个音效文件。 在播放音效文件时，你可以设置循环次数、音调、音量、播放位置等

- `playEffect` 需要在加入频道后调用。
- 不支持同时播放多个在线音效文件。

```
// 设置音效循环播放的次数。 -1 表示无限循环。  
int loops = -1; 
// 设置的音效的音调。 取值范围为 [0.5, 2.0]。  
double pitch = 1.5; 
// 设置音量。 取值范围为 [0,100]，100 表示原始音量。  
int gain = 100; 
// 设置的音效空间位置。 1.0 表示音效出现在右边。  
double pan = 1.0; 
// 设置是否将音效发布至远端。 true 表示本地用户和远端用户都能听到音效；false 表示只有本地用户能听到音效。  
BOOL publish = true; 
// 设置音效文件的播放进度。 500 表示从音效文件的第 500 ms 开始播放。  
int startPos = 500; 
 
// 播放指定的音效文件。 （demo 缺少 startPos 的示例代码） 
m_rtcEngine->playEffect(m_mapEffect[strEffect], strFile.c_str(), loops, pitch, pan, gain, publish, startPos); 
 
// 本地音效文件播放已结束回调。  
void onAudioEffectFinished(m_mapEffect[strEffect]);
```

成功播放后，你可以停止播放指定或全部的音效文件。

```
// 停止播放指定的音效文件。 
m_rtcEngine->stopEffect(m_mapEffect[strEffect]);
 
// 停止播放所有音效文件。 
m_rtcEngine->stopAllEffects();
```

### **暂停与恢复**

在音效文件播放时，你可以暂停或恢复播放指定或全部音效文件。

本组方法需要在 `playEffect` 后调用。

```
// 暂停播放指定的音效文件。  
m_rtcEngine->pauseEffect(m_mapEffect[strEffect]); 
 
 
// 恢复播放指定的音效文件。  
m_rtcEngine->resumeEffect(m_mapEffect[strEffect]); 
 
 
// 暂停播放所有的音效文件。 
m_rtcEngine->pauseAllEffects(); 
 
 
// 恢复播放所有的音效文件。 
m_rtcEngine->resumeAllEffects();
```

### **播放位置**

如需在播放音效文件后调整播放位置，你可以调用本组方法。 例如，在循环播放音效文件期间，你可以调用本组方法调整播放位置，无需停止播放。

- 本组方法需要在 `playEffect` 后调用。
- 本组方法仅适用于本地音效文件。

```
// 获取指定本地音效文件的总时长。  
m_rtcEngine->getEffectDuration(m_mapEffect[strEffect]); 
 
 
// 设置指定音效文件的播放位置。  
m_rtcEngine->setEffectPosition(m_mapEffect[strEffect], pos); 
 
 
// 获取指定本地音效文件的总时长。  
m_rtcEngine->getEffectCurrentPosition(m_mapEffect[strEffect]);
```

### 音量

在音效文件开始播放后，你可以调用本组方法调节播放音量。 例如，在循环播放音效文件期间，你可以调用本组方法调节播放音量，无需停止播放。

本组方法需要在 `playEffect` 后调用。

```
// 设置所有音效文件的播放音量。 取值范围为 [0,100]，100 表示原始音量。  
m_rtcEngine->setEffectsVolume(50); 
 
 
// 设置指定音效文件的播放音量。 取值范围为 [0,100]，100 表示原始音量。  
m_rtcEngine->setVolumeOfEffect(m_mapEffect[strEffect], 50); 
 
 
// 获取音效文件的播放音量。 音量范围为 [0,100]，100 表示原始音量。  
m_rtcEngine->getEffectsVolume();
```

### API reference

- `preloadEffect`
- `unloadEffect`
- `playEffect`
- `stopEffect`
- `stopAllEffects`
- `pauseEffect`
- `pauseAllEffects`
- `resumeEffect`
- `resumeAllEffects`
- `getEffectDuration`
- `setEffectPosition`
- `getEffectCurrentPosition`
- `setEffectsVolume`
- `setVolumeOfEffect`
- `getEffectsVolume`
- `onAudioEffectFinished`

## 音乐混音

音乐混音是指将音乐文件与麦克风采集的音频混合。 使用混音功能的用户通常会播放比较长的音乐文件，并且同一时间只播放一个音乐文件。 例如，在唱歌时播放伴奏，在聊天时播放背景音乐。

Agora 提供一组方法播放和管理音乐文件，主要包括如下功能：

- 播放本地或在线音乐文件
- 设置音乐文件的播放次数、播放位置、音量、音调等播放选项
- 灵活控制音乐文件的播放、暂停、恢复与停止
- 报告当前的音乐文件播放状态和播放状态改变的原因

支持的音乐文件格式包括 MP3、AAC、M4A、MP4、WAV 和 3GP。 详见 [Supported Media Formats in Media Foundation](https://docs.microsoft.com/zh-cn/windows/desktop/medfound/supported-media-formats-in-media-foundation)。

成功调用 `startAudioMixing` 后，当音乐文件播放状态发生改变时，SDK 会触发 `onAudioMixingStateChanged` 回调。

### **播放和停止**

调用 `startAudioMixing` 播放音乐文件。 在播放音乐文件时，可以设置循环次数、播放位置等。

- `startAudioMixing` 需要在加入频道后调用。
- 如果在播放一个音乐文件时再次调用 `startAudioMixing`，则 SDK 会自动停止播放上一个音乐文件并开始播放下一个音乐文件。

```
// 指定需要混音的本地或在线音乐文件的绝对路径。  
std::string filePath = "http://www.hochmuth.com/mp3/Haydn_Cello_Concerto_D-1.mp3"; 
// 设置是否只在本地播放音乐文件。 true 表示只有本地用户能听到音乐；false 表示本地用户和远端用户都能听到音乐。  
BOOL loopback = false; 
// 设置是否用音乐文件替换麦克风采集的音频。 true 表示用户只能听到音乐；false 表示用户可以听到音乐和麦克风采集的音频。  
BOOL replace = true; 
// 设置音乐文件的播放次数。 1 表示播放 1 次。  
int cycle = 1; 
// 设置音乐文件的播放进度。 500 表示从音乐文件的第 500 ms 开始播放。  
int startPos = 500; 
 
 
// 开始播放音乐文件。 （demo 缺 startPos 的示例代码） 
m_rtcEngine->startAudioMixing(filePath, loopback, replace, cycle, startPos); 
 
 
// 本地用户的音乐文件播放状态已改变回调。  
void onAudioMixingStateChanged(AUDIO_MIXING_STATE_TYPE state, AUDIO_MIXING_REASON_TYPE reason)
```

成功播放音乐文件后，你可以调用 `stopAudioMixing` 停止播放。

```
//停止播放音乐文件。 
m_rtcEngine->stopAudioMixing();
```

### **暂停与恢复**

在音乐文件播放时，你可以暂停或恢复播放音乐文件。

本组方法需要在 `startAudioMixing` 后调用。

```
// 暂停播放音乐文件。  
m_rtcEngine->pauseAudioMixing(); 
 
// 恢复播放音乐文件。  
m_rtcEngine->resumeAudioMixing();
```

### **播放位置**

在音乐文件播放时，你可以调用本组方法调整音乐文件的播放位置，无需停止播放。

本组方法需要在调用 `startAudioMixing` 并收到 `onAudioMixingStateChanged(AUDIO_MIXING_STATE_PLAYING)` 回调后调用。

```
// 获取指定音乐文件的总时长。  
m_rtcEngine->getAudioMixingDuration(filePath); 
 
// 设置当前音乐文件的播放位置。 500 表示从音乐文件的第 500 ms 开始播放。  
m_rtcEngine->setAudioMixingPosition(500); 
 
// 获取当前音乐文件的播放进度。  
m_rtcEngine->getAudioMixingCurrentPosition();
```

### 音量与音调

成功播放音乐文件后，你可以调用本组方法调整音乐文件的播放音量与音调，无需停止播放。

本组方法需要在调用 `startAudioMixing` 并收到 `onAudioMixingStateChanged(AUDIO_MIXING_STATE_PLAYING)` 回调后调用。

```
// 调节当前音乐文件在本地和远端的播放音量。 取值范围为 [0,100]，100 表示原始音量。  
m_rtcEngine->adjustAudioMixingVolume(50); 
 
 
// 调节当前音乐文件在远端的播放音量。 取值范围为 [0,100]，100 表示原始音量。  
m_rtcEngine->adjustAudioMixingPublishVolume(50); 
 
 
// 调节当前音乐文件在本地的播放音量。 取值范围为 [0,100]，100 表示原始音量。  
m_rtcEngine->adjustAudioMixingPlayoutVolume(50); 
 
 
// 获取当前音乐文件在本地的播放音量。 音量范围为 [0,100]，100 表示原始音量。  
m_rtcEngine->getAudioMixingPlayoutVolume(); 
 
 
// 获取当前音乐文件在远端的播放音量。 音量范围为 [0,100]，100 表示原始音量。  
m_rtcEngine->getAudioMixingPublishVolume(); 
 
 
// 调节当前音乐文件的音调。 取值范围为 [-12,12]，0 表示原始音调，1 表示升高一个半音。 
m_rtcEngine->setAudioMixingPitch(5);
```

### API reference

- `startAudioMixing`
- `stopAudioMixng`
- `pauseAudioMixing`
- `resumeAudioMixing`
- `getAudioMixingDuration`
- `setAudioMixingPosition`
- `getAudioMixingCurrentPosition`
- `adjustAudioMixingVolume`
- `adjustAudioMixingPublishVolume`
- `adjustAudioMixingPlayoutVolume`
- `getAudioMixingPlayoutVolume`
- `getAudioMixingPublishVolume`
- `setAudioMixingPitch`
- `onAudioMixingStateChanged`