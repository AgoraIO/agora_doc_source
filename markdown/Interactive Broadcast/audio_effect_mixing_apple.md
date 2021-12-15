---
title: 播放音频文件
platform: iOS
updatedAt: 2020-12-03 11:26:40
---

## 功能描述

在通话或直播过程中，除了用户自己说话的声音，有时候需要播放自定义的声音或者音乐文件并且让频道内的其他人也听到，比如需要给游戏添加音效，或者需要播放背景音乐等，Agora 提供以下两组方法可以满足播放音效和音乐文件的需求。

开始前请确保已在你的项目中实现基本的实时音视频功能。详见快速开始文档：

- iOS: [实现音视频通话](start_call_ios)/[实现互动直播](start_live_ios)
- macOS: [实现音视频通话](start_call_mac)/[实现互动直播](start_live_mac)

## 播放音效文件

音效通常指持续很短的音频。播放音效文件方法主要用来播放短小的音效，比如鼓掌、游戏子弹撞击声音等，可以多个音效叠加播放，且音效文件可以预加载以提高性能。
音效由音频文件路径指定，soundId 为自行设定的音效 ID，需保证唯一性。SDK 并不强制如何定义 sound id，保证每个音效有唯一的识别即可。一般的做法有自增 id，使用音效文件名的 hashCode 等。

### 实现方法

```swift
// swift
// 预加载音效（推荐），需注意音效文件的大小，并在加入频道前完成加载
// 仅支持 mp3，aac，m4a，3gp，wav 格式
// 开发者可能需要额外记录 id 与文件路径的关联关系，用来播放和停止音效
let soundId = 1
let filePath = "your filepath"

// 可以加载多个音效
agoraKit.preloadEffect(soundId, filePath: filePath)

// 播放音效
let soundId = 1                 // 要播放的音效 id
let filePath = "your filepath"  // 播放文件的路径
let loopCount = 1               // 播放次数，-1 代表无限循环
let pitch = 1                   // 音效的音调
let pan = 1                     // 音效的空间位置，0表示正前方
let gain = 0                    // 音量，取值 0 ~ 100， 100 代表原始音量
let publish = true              // 是否令远端也能听到音效的声音
agoraKit.playEffect(Int32(soundId), filePath: filePath, loopCount: Int32(loopCount), pitch: pitch, pan: pan, gain: gain, publish: publish)

// 暂停所有音效播放
agoraKit.pauseAllEffects()

// 获取音效的音量，范围为 0 ~ 100
let volume = agoraKit.getEffectsVolume()

// 保证音效音量在原始音量的 80% 以上
volume = volume < 80 ? 80 : volume
agoraKit.setEffectsVolume(volume)

// 继续播放暂停的音效
agoraKit.resumeAllEffects()

// 停止所有音效
agoraKit.stopAllEffects()
```

```objective-c
// objective-c
// 预加载音效（推荐），需注意音效文件的大小，并在加入频道前完成加载
// 仅支持 mp3，aac，m4a，3gp，wav 格式
// 开发者可能需要额外记录 id 与文件路径的关联关系，用来播放和停止音效
int soundId = 1
NSString *filePath = "your filepath"

// 可以加载多个音效
[agoraKit preloadEffect: soundId filePath: filePath];

// 播放音效
int soundId = 1;
NSString *filePath = "your filepath";
int loopCount = 1
double pitch = 1
double pan = 1
double gain = 0
BOOL publish = true

[agoraKit playEffect: soundId filePath: filePath loopCount: loopCount, pitch: pitch, pan: pan, gain: gain, publish: publish];

// 暂停所有音效播放
[agoraKit pauseAllEffects];

// 获取音效的音量，范围为 0 ~ 100
int volume = [agoraKit getEffectsVolume];

// 保证音效音量在原始音量的 80% 以上
volume = volume < 80 ? 80 : volume
[agoraKit setEffectsVolume: volume];

// 继续播放暂停的音效
[agoraKit resumeAllEffects];

// 停止所有音效
[agoraKit stopAllEffects];
```

### API 参考

- [`playEffect`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/playEffect:filePath:loopCount:pitch:pan:gain:)
- [`preloadEffect`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/preloadEffect:filePath:)
- [`pauseAllEffects`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pauseAllEffects)
- [`getEffectsVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getEffectsVolume)
- [`setEffectsVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setEffectsVolume:)
- [`resumeAllEffects`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/resumeAllEffects)
- [`stopAllEffects`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopAllEffects)

### 开发注意事项

- 预加载不是一个必须的步骤，但是一般来说为了提高性能或者需要反复播放某个特定的音效的时候，Agora 建议使用预加载。
- 以上方法都有返回值，返回值小于 0 表示方法调用失败。

## 音乐混音

混音是指播放本地或者在线音乐文件，同时让频道内的其他人听到此音乐。混音方法主要用来播放比较长的背景音，比如直播的时候播放的音乐，同时只可以有一个文件播放。如果在混音播放第一个文件的过程中播放第二个文件，会自动停止第一个文件的播放。
Agora 混音功能支持如下设置：

- 混音或替换： 混音指的是音乐文件的音频流跟麦克风采集的音频流进行混音（叠加）并编码发送给对方；替换指的是麦克风采集的音频被音乐文件的音频流替换掉，对方只能听见音乐播放。
- 循环：可以设置是否循环播放混音文件，以及循环次数。

### 实现方法

```swift
// swift
// loopback 为 true 只有本地可以听到混音或替换后的音频流; 为 false 本地和对方都可以听到混音或替换后的音频流
// replace 为 true 只推送设置的本地音频文件或者线上音频文件; 不传输麦克风收录的音频, 为 false 音频文件内容将会和麦克风采集的音频流进行混音
// cycle 为 -1 代表永久循环；其它 >0 的整数表示预设混音播放的循环次数
let filePath = "http://www.hochmuth.com/mp3/Haydn_Cello_Concerto_D-1.mp3"
let loopback = false
let replace = false
let cycle = 1

// 开始播放混音
agoraKit.startAudioMixing(filePath, loopback: loopback, replace: replace, cycle: cycle)
```

```objective-c
// objective-c
// loopback 为 YES 只有本地可以听到混音或替换后的音频流; 为 NO 本地和对方都可以听到混音或替换后的音频流
// replace 为 true 只推送设置的本地音频文件或者线上音频文件; 不传输麦克风收录的音频, 为 false 音频文件内容将会和麦克风采集的音频流进行混音
// cycle 为 -1 代表永久循环；其它 >0 的整数表示预设混音播放的循环次数
NSString *filePath = @"http://www.hochmuth.com/mp3/Haydn_Cello_Concerto_D-1.mp3";
BOOL loopback = NO;
BOOL replace = NO;
NSInteger cycle = 1;

// 开始播放混音
[agoraKit startAudioMixing: filePath loopback: loopback replace: replace cycle: cycle];
```

同时，我们在 GitHub 上提供已实现混音功能的开源示例项目。你可以下载体验并参考源代码。

**iOS**

- Swift 项目：[OpenVideoCall-iOS](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-iOS)，参考 [`RoomViewController.swift`](https://github.com/AgoraIO/Basic-Video-Call/blob/master/Group-Video/OpenVideoCall-iOS/OpenVideoCall/RoomViewController.swift#L45) 中的代码。
- Objective-C 项目：[OpenVideoCall-iOS-Objective-C](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-iOS-Objective-C)，参考 [`RoomViewController.m`](https://github.com/AgoraIO/Basic-Video-Call/blob/master/Group-Video/OpenVideoCall-iOS-Objective-C/OpenVideoCall/RoomViewController.m#L60) 中的代码。

**macOS**

- Swift 项目：[OpenVideoCall-macOS](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-macOS)，参考 [`RoomViewController.swift`](https://github.com/AgoraIO/Basic-Video-Call/blob/master/Group-Video/OpenVideoCall-macOS/OpenVideoCall/RoomViewController.swift#L232) 中的代码。

### API 参考

- [`startAudioMixing`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startAudioMixing:loopback:replace:cycle:)

### 开发注意事项

- 以上方法都有返回值，返回值小于 0 表示方法调用失败。
- 在频道内调用混音方法，否则会有潜在问题。
