---
title: 发版说明
platform: iOS
updatedAt: 2021-03-29 03:48:52
---
# 发版说明

本文提供 Agora 语音包的发版说明。

## **简介**

iOS 语音包支持两种主要场景:

-   语音通话

-   语音直播


## **2.3.0**

该版本于 2018 年 8 月 31 日发布。新增特性与修复问题列表详见下文。

**升级必看**

-   该版本新增了一个系统库依赖：`Accelerate.framework`。该系统库可以进行大规模的数学计算和图像计算，并针对高性能进行了优化。

-   为更好地提升用户体验，Agora SDK 在 v2.1.0 版本中对动态秘钥进行了升级。如果你当前使用的 SDK 是 v2.1.0 之前的版本，并希望升级到 v2.1.0 或更高版本，请务必参考 [动态秘钥升级说明](/cn/Agora%20Platform/token_migration) 。


**新增功能**

本次发版新增如下功能：

#### 1. 提前 30 秒提醒 Token 即将过期

由于 Token 具有一定的时效，在通话过程中如果 Token 即将失效，SDK 会提前 30 秒触发回调 [tokenPrivilegeWillExpire](/cn/API%20Reference/communication_ios_audio) ，提醒应用程序更新 Token。当收到该回调时，用户需要重新在服务端生成新的 Token，然后调用 [renewToken](/cn/API%20Reference/communication_ios_audio) 将新生成的 Token 传给 SDK。

#### 2. 按用户返回音频上下行码率、帧率、丢包率及延迟

为方便统计每个用户的音频上下行码率、帧率及丢包率，该版本新增 [audioTransportStatsOfUid](/cn/API%20Reference/communication_ios_audio) 回调。通话或直播过程中， 当用户收到远端用户发送的音视频数据包后，会周期性地发生该回调上报，频率约为 2 秒 1 次。回调中包含用户的 UID、音频接收码率、丢包率、以及延迟时间（毫秒）。 并在统计频道内通话相关数据的 Rtcstats 类中增加 lastmileDelay 参数，返回客户端到 vos 服务器的延迟。

#### 3. 设置 SDK 对 Audio Session 的管理限制

在默认情况下，SDK 和 App 对 Audio Session 都有控制权，但某些场景下，App 会希望限制 Agora SDK 对 Audio Session 的控制权限， 而使用其他应用或第三方组件对 Audio Session 进行操控。为满足该需求，本版本新增 [setAudioSessionOperationRestriction](/cn/API%20Reference/communication_ios_audio) 接口。 用户可以选择相应的 Restriction，来实现 SDK 不同程度的管理限制。该方法可动态使用，在加入频道前，或频道中均能调用。

**改进功能**

-   优化了一对一音视频的质量，在降低延时、防止卡顿方面提升明显。优化效果重点覆盖东南亚、南美、非洲和中东等地区

-   直播场景下，改善了音频编码器的效率，保证通话质量的同时节省用户流量

-   采用深度学习算法，改进了通话及直播中的音频质量


**问题修复**

-   修复了特定场景下某些 iOS 设备上推流后出现的崩溃问题

-   修复了某些 iOS 设备上偶现的崩溃的问题

-   修复了某些 iOS 设备上频繁暂停、恢复播放所有音效时出现的崩溃的问题

-   修复了多人连麦场景下，主播频繁进出频道时，偶现的主播内存异常增长的问题

-   修复了特定场景下偶现的主播加入频道、下麦再上麦后，远端用户听不到主播声音的问题

-   修复了特定场景下某些 iOS 设备上偶现的接听系统电话再回到频道后，听不到声音的问题

-   修复了特定场景下偶现的直播观众无法调节频道内通话音量的问题

-   修复了频繁进出频道时，某些 iOS 设备上出现的崩溃的问题

-   修复了 2 人连麦过程中，一端播放背景音乐时将自己静音或关闭音频后，另一端闪退的问题

-   修复了特定场景下，iOS 端和 Web 端互通时，Web 频繁进出频道后，iOS 设备上出现的崩溃的问题

-   修复了特定场景下，预加载音效时某些设备上偶现的崩溃问题

-   修复了偶现的 iOS 与 macOS 设备 无法进入频道互通的问题

-   修复了直播模式下，使用第三方应用播放音乐时，某些 iOS 设备上出现的退出频道时崩溃的问题

-   修复了特定场景下，某些 iOS 设备上出现的退出频道时崩溃的问题

-   修复了部分设备上偶现的使用声卡时回声的问题

-   修复了特定场景下，某些 iOS 设备上无法调节音量的问题


**API 整理**

为提升用户体验，Agora 在 v2.3.0 版本中对 API 进行了梳理，并针对部分接口进行了如下处理：

为避免在直播转码推流中添加多个相同 User，v2.3.0 版本中新增如下接口：

-   [addUser](/cn/API%20Reference/live_video_ios)

-   [removeUser](/cn/API%20Reference/live_video_ios)


以下接口与录制相关，在 v2.3.0 版本后不再支持。Agora 提供专门的 Recording SDK 用于更好的录制服务，详见 [Agora Recording SDK 发版说明](/cn/Product%20Overview/release_recording)。

-   `startRecordingService`

-   `stopRecordingService`

-   `refreshRecordingServiceStatus`

-   `didRefreshRecordingServiceStatus`


以下接口长期处于弃用状态，现进行删除，v2.3.0 版本后不再支持：

-   `setSpeakerphoneVolume`


## **2.2.3 版**

该版本于 2018 年 7 月 5 日发布。新增特性与修复问题列表详见下文。

**升级必看**

为更好地提升用户体验，Agora SDK 在 v2.1.0 版本中对动态秘钥进行了升级。如果你当前使用的 SDK 是 v2.1.0 之前的版本，并希望升级到 v2.1.0 或更高版本，请务必参考 [动态秘钥升级说明](/cn/Agora%20Platform/token_migration) 。

**问题修复**

-   修复了特定场景下偶发的线上统计崩溃的问题。

-   修复了直播时特定场景下偶发的崩溃的问题。

-   修复了多人直播连麦时，SDK 内存增长的问题。

-   复了偶发的无法正常反馈频道内谁在说话以及说话者音量的问题。

-   修复了直播时偶发的观众听到主播声忽大忽小的问题。


## **2.2.1 版**

该版本于 2018 年 5 月 30 日发布。新增特性与修复问题列表详见下文。

**问题修复**

-   修复了部分设备上偶现的 Crash 问题。

-   修复了部分设备上内存泄漏的问题。

-   修复了部分设备上播放网络伴奏时某些 App 闪退的问题。


## **2.2.0 版**

该版本于 2018 年 5 月 4 日发布。新增特性与修复问题列表详见下文。

**新增功能**

本次发版新增如下功能：

#### 1. 音效混响进频道

播放音效 `playEffect`接口新增了一个 `publish` 参数，用于在播放音效时，远端用户可以听到本地播放的音效。详见 [语音通话 API](/cn/API%20Reference/communication_ios_audio) 中 `playEffect` 接口的描述。

**Note:** 

如果你的 SDK 是由之前版本升级到 v2.2 版本，请务必关注该接口功能的变动。

#### 2. 服务端部署代理服务器

通过部署 Agora 提供的代理服务器安装包，设有企业防火墙的用户可以设置代理服务器，使用 Agora 的服务。详见 [进阶：企业部署代理服务器](/cn/Quickstart%20Guide/proxy) 中的描述。

**改进功能**

本次发版改进如下功能：

#### 1. 当前说话者音量提示

改进 `enableAudioVolumeIndication` 接口的功能，无论频道内是否有人说话，都会在回调中按设置的时间间隔返回说话者音量提示。详见 [语音通话 API](/cn/API%20Reference/communication_ios_audio) 中 `enableAudioVolumeIndication` 的接口描述。

#### 2. 频道内网络质量监测

根据用户对频道内实时网络质量监测的需求，在 onNetworkQuality* 中改进了返回数据的准确度。详见 [语音通话 API](/cn/API%20Reference/communication_ios_audio) 中 *onNetworkQuality* 的接口描述。

#### 3. 进入频道前网络条件监测

为方便用户在进频道前检查当前网络是否能支撑语音或视频通话，在 `onLastmileQuality` 中，由根据恒定的码率优化为通过用户设定的 Video Profile 的码率进行监测，提高返回数据的准确度。且在网络状态为 unknown 时，依然以 2 秒的间隔返回回调。详见 [语音通话 API](/cn/API%20Reference/communication_ios_audio) 中 `onLastmileQuality` 的接口描述。

#### 4. 提升音乐场景下的音质

提升了用户在播放音乐等场景下的音乐音质。用户可以通过设置 `setAudioProfile` 中的 Scenario：AgoraAudioScenarioGameStreaming = 3 来实现高保真的音乐传输。详见 [语音通话 API](/cn/API%20Reference/communication_ios_audio) 中 *setAudioProfile* 的接口描述。

#### 5. 支持 Bitcode

新增支持 Bitcode 功能。支持 Bitcode 的 SDK 包大小约为普通包的 2.5 倍；使用 Bitcode 开发的 App 在上传 App Store 后，App Store 会对其进行优化及瘦身，瘦身程度视 App 的代码量而定，代码量越大，瘦身程度越高。

**问题修复**

-   修复了某些 iOS 设备导致频道内其他端的回音问题。

-   修复了大量用户同时直播连麦时，偶发的抖屏现象。


## **2.1.3 版**

该版本于 2018 年 4 月 19 日发布。新增特性与修复问题列表详见下文。

**问题修复**

-   修复了 SDK 没有设置 Delegate 时，偶尔收不到 Block 回调的问题。

-   修复了 SDK 的外链符号里，有 NSAssertionHandler 的问题。

-   修复了部分手机上，用户离开频道后，开启自带的录音设备时，偶现录音出错的问题。

-   修复了通信或直播过程中偶现 Crash 的问题。


## **2.1.2 版**

该版本于 2018 年 4 月 2 日发布。新增特性与修复问题列表详见下文。

**问题修复**

修复了之前版本 SDK 在 dtx+aac 模式下会视频卡顿的问题。

## **2.1.1 版**

该版本于 2018 年 3 月 16 日发布。

请正在或已集成 2.1 SDK 的客户尽快升级更新！ 本次发版修复了一个的系统风险，请尽快升级以免对服务造成影响。

## **2.1.0 版**

该版本于 2018 年 3 月 7 日发布。新增特性与修复问题列表详见下文。

**新增功能**

本次发版新增如下功能：

#### 1. 开黑

新增了一个游戏开黑场景，用于节省流量和去除杂音，通过调用 API `setAudioProfile` 实现。

#### 2. 音效均衡和音效混响

在直播场景下，主播如果需要通过内置的麦克风美化和定制自己的语音输入，可以通过调用 API `setLocalVoiceEqualization` 和 `setLocalVoiceReverb` 轻易地设置音效均衡和混响来实现所需要的效果。

#### 3. 在线频道信息查询

新增 Restful API 查询用户在频道中的状态信息，查询指定频道内的分角色用户列表，查询厂商频道列表，查询用户是否为连麦用户等。详见:

-   通话场景, 详见 [Dashboard RESTful API](/cn/API%20Reference/dashboard_restful_communication)

-   互动直播场景, 详见 [Dashboard RESTful API](/cn/API%20Reference/dashboard_restful_live)


**改进**

本次发版改进如下功能：

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>改进</td>
<td>描述</td>
</tr>
<tr><td>卡顿</td>
<td>改善了观众模式下的卡顿现象</td>
</tr>
<tr><td>卡顿</td>
<td>改善了特定设备导致的卡顿现象</td>
</tr>
<tr><td>鉴权模型优化</td>
<td>旧鉴权模型一个密钥只能对应一个服务权限(例如加入频道)，而新的一个 Token 包含了所有的服务权限(例如加入频道，连麦，推流等)</td>
</tr>
</tbody>
</table>



**问题修复**

-   修复了自采集方案退出频道后 App 录不到声音的问题;

-   修复了偶现的崩溃;

-   修复了偶现的关闭麦克风无法听到声音的问题;


## **2.0.2 版**

该版本于 2017 年 12 月 15 日发布。新增特性与修复问题列表详见下文。

**问题修复**

修复了 ffmpeg 符号冲突问题;

## **2.0 版**

该版本于 2017 年 12 月 6 日发布。新增特性与修复问题列表详见下文。

**新增功能**

-   伴奏和音效回调更新如下:

    <table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>名称</strong></td>
<td><strong>描述</strong></td>
</tr>
<tr><td><code>rtcEngineMediaEngineDidAudioMixingFinish</code></td>
<td>废弃，已经被 <code>rtcEngineLocalAudioMixingDidFinish</code> 替代</td>
</tr>
<tr><td><code>rtcEngineDidAudioEffectFinish</code></td>
<td>新增，当本地结束音效播放时触发该回调</td>
</tr>
<tr><td><code>rtcEngineRemoteAudioMixingDidStart</code></td>
<td>新增，当远端开始伴奏播放时触发该回调</td>
</tr>
<tr><td><code>rtcEngineRemoteAudioMixingDidFinish</code></td>
<td>新增，当远端结束音效播放时触发该回调</td>
</tr>
</tbody>
</table>



-   通信和直播场景下支持音频自采集功能，新增以下 API:

    <table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>名称</strong></td>
<td><strong>描述</strong></td>
</tr>
<tr><td><code>enableExternalAudioSourceWithSampleRate</code></td>
<td>开启外部音频采集</td>
</tr>
<tr><td><code>disableExternalAudioSource</code></td>
<td>关闭外部音频采集</td>
</tr>
<tr><td><code>pushExternalAudioFrameRawData</code></td>
<td>推送外部音频帧</td>
</tr>
</tbody>
</table>



-   通信和直播场景下支持服务端踢人功能。如有需要，请联系 [sales@agora.io](mailto:sales@agora.io) 开通该功能。


**问题修复**

修复了音频路由和蓝牙相关的若干问题;

## **1.14 版**

该版本于 2017 年 10 月 20 日发布。新增特性与修复问题列表详见下文。

**新增功能**

-   新增 API `setAudioProfile` 设置音频参数和应用场景。

-   新增 API `setLocalVoicePitch`提供基础变声功能。

-   直播场景: 新增 API `setInEarMonitoringVolume` 提供调节耳返音量功能。


**改进**

-   优化了在高码率下的音频体验。

-   秒开: 直播场景下，单流模式时观众加入频道 1 秒内看见主播图像\(均值为 938 ms, 网络状态良好时可达 734 ms\)。

-   节省带宽:

    -   1.14 以前: 如果你选择不听某人的音频，音频流会照发。

    -   1.14 开始: 如果你选择不听某人的音频，则不会下发音频流，从而节省带宽。


**问题修复**

修复了部分机器上偶现的崩溃问题。

**改进**

-   优化了在高码率下的音频体验。

-   节省带宽: 1.14 以前如果你选择不听某人的音频，音频流会照发。从 1.14 开始，如果你选择不听某人的音频，则不会下发流，从而节省带宽。


**修复问题**

修复了部分机器上偶现的崩溃问题。

## **1.13.1 版**

该版本于 2017 年 9 月 28 日发布。新增特性与修复问题列表详见下文。

**修复问题**

-   解决了 iOS 11 在 iPhone 7\(及以上版本\) 手机外放下无法调节音量的问题。

-   优化了特定场景下出现的回声问题。


## **1.13 版**

该版本于 2017 年 9 月 4 日发布。新增特性与修复问题列表详见下文。

-   新增 API `didClientRoleChanged` 用于提醒直播场景下主播、观众上下麦的回调。

-   修复了部分机型上偶现的崩溃。


## **1.12 版**

该版本于 2017 年 7 月 25 日发布。新增特性与修复问题列表详见下文。

**新增功能**

-   在 API 方法 `setEncryptionMode` 里新增加密模式 `aes-128-ecb`。

-   在 API 方法 `startAudioRecording` 里新增参数 `quality` 用于设置录音音质。

-   新增了一系列 API 管理音效。


**修复问题**

修复了部分机型上偶现的崩溃问题。

