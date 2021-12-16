---
title: 播放音频文件
platform: Windows
updatedAt: 2020-12-04 01:39:56
---
## 功能描述
在通话或直播过程中，除了用户自己说话的声音，有时候需要播放自定义的声音或者音乐文件并且让频道内的其他人也听到，比如需要给游戏添加音效，或者需要播放背景音乐等，Agora 提供以下两组方法可以满足播放音效和音乐文件的需求。

开始前请确保已在你的项目中实现基本的实时音视频功能。 详见[开始音视频通话](start_call_windows)或[开始互动直播](start_live_windows)。

## 播放音效文件

音效通常指持续很短的音频。播放音效文件方法主要用来播放短小的氛围音，比如鼓掌、游戏子弹撞击声音等，可以多个音效叠加播放。
音效由音频文件路径指定，但在 SDK 内部使用 sound id 来识别和处理音效。SDK 并不强制如何定义 sound id，保证每个音效有唯一的识别即可。一般的做法有自增 id，使用音效文件名的 hashCode 等。

### 实现方法

```c++
// 预加载音效（推荐），需注意音效文件的大小，并在加入频道前完成加载
#ifdef UNICODE
  CHAR wdFilePath[MAX_PATH];
  ::WideCharToMultiByte(CP_UTF8, 0, filePath, -1, wdFilePath, MAX_PATH, NULL, NULL);
  int nRet = rtcEngine.preloadEffect(nSoundID, wdFilePath);
#else
  int nRet = rtcEngine.preloadEffect(nSoundID, filePath);
#endif

// 开始播放音效文件，如果设置了预加载，需要指定 nSoundID 
#ifdef UNICODE
  CHAR wdFilePath[MAX_PATH];
  ::WideCharToMultiByte(CP_UTF8, 0, filePath, -1, wdFilePath, MAX_PATH, NULL, NULL);
  int nRet = rtcEngine.playEffect(nSoundID, // 音效唯一标识
  wdFilePath, // 文件路径
  nLoopCount, // 重复播放次数
  dPitch, // 音效的音调
  dPan, // 音效的空间位置，0 表示正前方
  nGain, // 音效音量，取值 0 - 100， 100 代表原始音量
  TRUE // 是否令远端也能听到音效的声音
#else
  int nRet = rtcEngine.playEffect(nSoundID, filePath, nLoopCount, dPitch, dPan, nGain, TRUE);
#endif

// 暂停指定的音效播放
int nRet = rtcEngine.pauseEffect(nSoundID);

// 暂停所有音效播放
int nRet = rtcEngine.pauseAllEffects();

// 继续指定的已经暂停的音效播放
int nRet = rtcEngine.resumeEffect(nSoundID);

// 继续所有已经暂停的音效播放
int nRet = rtcEngine.resumeAllEffects();

// 停止指定的音效播放
int nRet = rtcEngine.stopEffect(nSoundID);

// 停止所有音效播放
int nRet = rtcEngine.stopAllEffects();

// 释放预加载的音效
int nRet = rtcEngine.unloadEffect(nSoundID);
```

### API 参考

- [`preloadEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a02d0b23b0b66e8fb0e898eb2811a8e74)
- [`playEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a7f4ddb5170b19a471d8c3c721fa19c8d)
- [`pauseEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a3c820db172c7fb43da58d81b7916d174)
- [`pauseAllEffects`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ad731a94d9db9e2c3390e1443b379095f)
- [`resumeEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a6489955af474172afe4f4b44e4edb38a)
- [`resumeAllEffects`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a2fc1b5996df964f8e12ce579e0eb5f98)
- [`stopEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ad74eb7c7799b8762bff2b1e7e7bba8b9)
- [`stopAllEffects`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a888ecfec4fda81831988898420d60e49)
- [`unloadEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#aa560240d5994be0c1a7853e96077e5f9)

### 开发注意事项

- 预加载不是一个必须的步骤，一般来说为了提高性能或者需要反复播放某个特定的音效的时候，我们建议使用预加载。但如果音效文件较大，不建议预加载。
- 以上方法都有返回值，返回值小于 0 表示方法调用失败。

## 音乐混音

混音是指播放本地或者在线音乐文件，同时让频道内的其他人听到此音乐。混音方法主要用来播放比较长的背景音，比如直播的时候播放的音乐，同时只可以有一个文件播放。如果在混音播放第一个文件的过程中播放第二个文件，会自动停止第一个文件的播放。

Agora 混音功能支持如下设置：

- 混音或替换： 混音指的是音乐文件的音频流跟麦克风采集的音频流进行混音（叠加）并编码发送给对方；替换指的是麦克风采集的音频被音乐文件的音频流替换掉，对方只能听见音乐播放。
- 循环：可以设置是否循环播放混音文件，以及循环次数。
- 调节音量：可以同时或分别调节音乐文件在本地和远端的播放音量。
- 调节音调：可以分别调节本地人声的音调和音乐文件的音调。

### 实现方法

```c++
LPCTSTR filePath = "http://www.hochmuth.com/mp3/Haydn_Cello_Concerto_D-1.mp3";
// 开始播放混音
#ifdef UNICODE
 CHAR wdFilePath[MAX_PATH];
 ::WideCharToMultiByte(CP_UTF8, 0, filePath, -1, wdFilePath, MAX_PATH, NULL, NULL);
int nRet = rtcEngine.startAudioMixing(wdFilePath, // 混音文件路径，支持网络文件，比如 http 协议的
 FALSE, // 只在本端播放
  TRUE, // 混音文件内容替换麦克风采集的声音
  1 // 混音文件重复播放次数
  );
#else
int nRet = rtcEngine.startAudioMixing(filePath, FALSE, TRUE, 1);
#endif

// 结束播放混音
int nRet = rtcEngine.stopAudioMixing();
```

### API 参考

- [`startAudioMixing`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a6f573cd61d53147ed6a2b7f033091d86)
- [`stopAudioMixng`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a2b90cbf4142c913b3efa795482713b08)
- [`adjustAudioMixingVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a544aee96b789ac5a57d26b61b7e1a5fa)
- [`setLocalVoicePitch`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a43616f919e0906279dff5648830ce31a)
- [`setAudioMixingPitch`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a26b117f7e097801b03522f7da9257425)
- [`pauseAudioMixing`](./API%20Reference/cpp/v3.0.1/classagora_1_1rtc_1_1_i_rtc_engine.html#ab86885c38e7ee7a4b37d5bbacafcaa24)
- [`resumeAudioMixing`](./API%20Reference/cpp/v3.0.1/classagora_1_1rtc_1_1_i_rtc_engine.html#a5a9606ad7ca4995e0d37fcf1642fe401)
- [`getAudioMixingDuration`](./API%20Reference/cpp/v3.0.1/classagora_1_1rtc_1_1_i_rtc_engine.html#a6a87b6b9135a6f45095dcf6aa62295cb)
- [`getAudioMixingCurrentPosition`](./API%20Reference/cpp/v3.0.1/classagora_1_1rtc_1_1_i_rtc_engine.html#aae54b86e9e6a7c0ed955b96f011855cb)
- [`setAudioMixingPosition`](./API%20Reference/cpp/v3.0.1/classagora_1_1rtc_1_1_i_rtc_engine.html#a6c69e2229c438fd587b8f81df34214ad)
- [`onAudioMixingStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a298389513bfaa50af4277fc3296e3f22)

### 开发注意事项

- 在频道内调用混音方法，否则会有潜在问题。
- 以上方法都有返回值，返回值小于 0 表示方法调用失败。