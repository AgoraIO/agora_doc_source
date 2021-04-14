---
title: 录制 SDK 发版说明
platform: Linux
updatedAt: 2021-01-13 07:35:03
---
## 简介

Agora 本地服务端录制 SDK for Linux (简称本地服务端录制 SDK) 在 Agora Native SDK 或/和 Agora Web SDK 的基础上提供通信和直播录制功能。点击[录制产品概述](/cn/Recording/product_recording)了解关键特性。

### 兼容性

本地服务端录制 SDK 与以下 SDK 兼容:

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><th>SDK</th>
<th>描述</th>
</tr>
<tr><td>Agora Native SDK</td>
<td>本地服务端录制 SDK 与全平台 Agora Native SDK (1.7.0 或更高版本) 兼容，如果频道内有任何人使用了 1.6 版本的 Agora Native SDK， 则整个频道无法录制。</td>
</tr>
<tr><td>Agora Web SDK</td>
<td>本地服务端录制 SDK 与 Agora Web SDK (1.12.0 或更高版本兼容)。</td>
</tr>
</tbody>
</table>

> 从 2.2.0 版本起，下载包里有两个包，Java 和 C++ 。

### 已知问题和局限性

- 在用移动客户端 \(仅 Android 系统\) 录像的过程中，从前置摄像头切换到后置摄像头后，画面将被倒置。
- 如果在频道内调用 `leaveChannel`, 录制会停止, 但默认录制文件最后会包含一段空白片段，这个时间段由调用 `joinChannel` 时在 `config` 里设定的 `idleLimitSec` 字段值决定。详见 [录制 API](./API%20Reference/recording_cpp/index.html)。
- 由于录制的音视频文件是没有加密的，如果要满足 HIPPA 要求，需使用磁盘加密工具对硬盘进行加密，例如 cryptsetup。

## 2.8.0 版

该版本于 2019 年 7 月 24 日发布。

### 新增功能

**1. 给录制视频添加水印**

该版本新增添加水印功能，支持在合流模式下对录制视频添加图片、文字或时间戳水印，作为防伪、宣传等用途。

你可以在 `setVideoMixingLayout` 方法中设置水印，也可以调用 `updateWatermarkConfigs` 方法添加、更新或删除水印设置。

**2. 录制指定用户的音视频**

该版本支持选择录制指定用户的音频或视频。你可以在加入频道时将 `RecordingConfig` 中的 `autoSubscribe` 设为 `false`，然后通过设置 `subscribeVideoUids` 和 `subscribeAudioUids` 参数指定要录制视频和音频的用户 UID，或者调用 `updateSuscribeVideoUids` 和 `updateSuscribeAudioUids` 方法指定需要录制视频和音频的用户 UID。

**3. 支持 String 类型的用户名**

从 2.8.0 版本开始，Agora 支持 String 型的用户名，如果录制频道內的用户使用了 String 型的用户名（即 User Account），录制 SDK 也需要使用相同类型的用户名加入频道。

该版本新增 `joinChannelWithUserAccount/createChannelWithUserAccount` 方法，支持使用 String 型 User Account 加入频道。

**4. 显示最后一帧**

合流模式下，用户离开频道后，支持显示其视频的最后一帧。你可以在 `setVideoMixingLayout` 方法中设置 `keepLastFrame` 参数选择是否显示最后一帧。

**5. 云代理服务**

为方便有企业防火墙的用户正常使用 Agora 的服务，该版本新增云代理服务，详见[使用云代理服务](/cn/Recording/cloudproxy_recording)。

**6. 新增回调**

**频道事件**

- `onRejoinChannelSuccess`：录制 app 重新加入频道
- `onConnectionStateChanged`：网络连接状态改变

**质量透明**

- `onRemoteVideoStats`：远端视频流统计信息
- `onRemoteAudioStats`：远端音频流统计信息
- `onRecordingStats`：录制统计信息

**媒体事件**

- `onRemoteAudioStreamStateChanged`：远端用户音频流状态改变
- `onRemoteVideoStreamStateChanged`：远端用户视频流状态改变

### 修复问题

- 修复了在合流模式录制时，有时录制的合流视频会多出一个画面的问题。
- 修复了录制视频可能出现视频播放速度异常的问题。
- 修复了 syslog 过多的问题。
- 修复了在 `setVideoMixingLayout` 方法中设置 `alpha` 参数导致录制服务崩溃的问题。

## 2.3.4 版

该版本于 2019 年 8 月 5 日发布。改进和修复问题详见下文。

**改进**

- Java API 以下方法由 private 变为 public：
  - `setUserBackground` 方法，支持设置指定 UID 用户的背景图片。当该用户在线且没有发送视频流时，会显示该背景图片。
  - `setLogLevel` 方法，支持设置 log 过滤等级。设置后，SDK 只会生成等于和低于所设等级的 log。
- 增强 Java API 健壮性。
- 增强异常崩溃信息收集能力。

**修复问题**

- 修复合流录制时切换频道模式会切片的问题。
- 修复直播模式下合流录制时不能只录制音频的问题。
- 修复 libyuv 崩溃的问题。
- 修复 Java 调用 `leaveChannel` 方法离开频道崩溃的问题。

## 2.3.3 版

该版本于 2019 年 4 月 1 日发布。新增特性与问题修复详见下文。

**新增功能**

#### 1. 支持监控网络连接状态

为及时获取本地服务端录制 SDK 与服务器的连接状态，该版本新增如下回调，用于监控本地服务端录制 SDK 的网络连接丢失、中断状态。

- `onConnectionLost`：网络连接丢失回调。
- `onConnectionInterrupted`：网络连接中断回调。

#### 2. 提示首帧出图

为及时获取本地对远端音视频流的接收情况，该版本新增如下回调，通知本地服务端录制 SDK 成功接收远端音视频首帧。

- `onFirstRemoteAudioFrame`：已接收远端音频首帧回调。
- `onFirstRemoteVideoDecoded`：已完成远端视频首帧解码回调。

#### 3. 获取流状态

为监控本地服务端录制 SDK 接收音视频流的状态，该版本新增 `onReceivingStreamStatusChanged` 回调，提示本地服务端录制 SDK 接收音频流或视频流的状态发生了变化。

#### 4. 获取说话者音量

为监控频道内通话的实时状态，了解说话者的具体信息，该版本新增 `onAudioVolumeIndication` 获取频道内说话者的人数、 用户 ID 及音量等信息。

**问题修复**

- 修复了手动模式下，本地服务端录制 SDK 退出频道后再次进入频道时，转码脚本失败的问题。
- 修复了调用 `mixedVideoAudio` 时非法参数导致程序崩溃的问题。
- 修复了在录制高清视频时出现卡顿的问题。
- 修复了录制视频帧率设置无效的问题。
- 修复了录制 Java sample code 手动模式编译出错的问题。
- 修复了使用转码命令 `-f . -m 3` 转码不成功的问题。



## 2.3.0 版

该版本于 2019 年 1 月 15 日发布。新增特性与改进问题详见下文。

> 本地服务端录制 SDK 从 2.3.0 版本起，可支持费用独立计算，录制的用量和费用不与语音通话/语音直播 SDK、视频通话/视频直播 SDK混合在一起。具体可咨询商务。

**新增功能**

#### 1. 合流模式音频录制支持双声道

合流模式下音频录制支持双声道高音质：采样率 48 KHz，双声道，码率 192 Kbps。

> 裸数据不支持双声道。

`audio profile` 开放 `0` 和 `1` 两种设置，具体如下：

- 单流模式（file mode）：
  - 默认行为或者 `audio profile=0`，采样率 48 KHz，与原始音频流的单/双声道保持一致，码率根据发送端的码率自适应。
- 单流模式（裸数据）
  - 固定采样率 48 KHz，声道与原始流保持一致
    - PCM：码率可能改变
    - AAC：码率与 file mode 单流的保持一致
- 合流模式（file mode）：  
  - `audio profile=0`，采样率 48 KHz，单声道，码率 48 Kbps
  - `audio profile=1`，采样率 48 KHz，单声道，码率 128 Kbps
  - `audio profile=2`，采样率 48 KHz，双声道，码率 192 Kbps
- 合流模式（裸数据）
  - 固定采样率 48 KHz，单声道

#### 2. 增加 Web 播放器支持

实时转码后的录像文件，和转码脚本转码后的录像文件支持 Android、iOS/macOS、Windows 平台下的 Chrome 和 Safari 浏览器的播放。各平台浏览器播放支持如下表所示：

<table>
  <tr>
    <th>平台</th>
    <th>Chrome </th>
    <th>Safari</th>
  </tr>
  <tr>
    <td>Android </td>
    <td>Chrome 49+</td>
    <td>N/A</td>
  </tr>
  <tr>
    <td>iOS</td>
    <td>✘</td>
    <td>Safari 9+</td>
  </tr>
  <tr>
    <td>macOS 10+</td>
    <td>Chrome 47+</td>
    <td>Safari 11+</td>
  </tr>
  <tr>
    <td>Windows</td>
    <td>Chrome 49+</td>
    <td>N/A</td>
  </tr>
</table>

#### 3. 支持合流模式自定义背景图片

- 合流模式没有视频时可以显示背景图片使录制画面更好看
- 合流模式某个用户没有视频时可以用自定义图片代替该用户的视频画面

> 仅适用于合流模式，且不支持裸数据和截图。

#### 4. 示例代码中增加预置的合流布局模版

为提高本地服务端录制 SDK 自带的示例代码的易用性，增加两种预置的合流布局模版：

##### **自适应布局 （bestFit**）

根据录制画面的数量自动调整每个画面的大小，每个画面大小一致，最多支持 17 个录制画面。例如：

![](https://web-cdn.agora.io/docs-files/1542680053900)

##### **垂直布局 （verticalPresentation）**

指定一个 uid 在屏幕左侧显示大流画面，其他用户的小流画面在右侧垂直排列，最多两列，一列 8 个画面，最多支持共 17 个录制画面。例如：

![](https://web-cdn.agora.io/docs-files/1542680070362)

#### 5. 支持合流模式录制时截图

在合流模式下录制时，支持对每个用户分别截图，并且截图和录制订阅同一路流。

#### 6. 支持说话者监测功能

增加 `onActiveSpeaker` 回调，用于返回频道内说话的用户 UID。

说话者监测功能默认为关闭状态，通过设置 `RecordingConfig` 中的 `audioIndicationInterval` 参数开启。将该参数设置为正整数，SDK 会按照设置的时间间隔返回 `onActiveSpeaker` 回调。

**改进**

- 改善了单流模式下的音画同步问题。
- 支持单流模式非实时转码下的录像视频自动旋转。
- 修改手动模式录制的 idle 行为：
  - 2.3.0 以前的版本，手动模式录制时，idle 一进入频道就开始生效。如果一开始频道内只有一个本地服务端录制 SDK，进程挂起，会导致录制退出频道，idle 不能发挥真正的作用。
  - 2.3.0 版本，`startService`之后，idle 才生效。
- 优化日志信息级别，把一些重要的信息从 INFO 中分拆到 NOTICE，WARN，以及 ERROR 中。
- 优化录制目录命名，确保目录名称的唯一性。

## 2.2.3 版

该版本于 2018 年 10 月 18 日发布。修复问题列表详见下文。

**修复问题**

- 由 .backtrace 引起的 coredump 文件丢失。
- Java jni 引起的崩溃和稳定性的优化。
- manually mode 下转码脚本的 bug 修复。
- Web 端客户加入频道后录制视频生成两份视频文件。
- 偶现的主线程释放后子线程继续使用引起的崩溃。

## 2.2.2 版

该版本于 2018 年 8 月 1 日发布。新增特性与修复问题列表详见下文。

**改进**

- jpeg 图片命名改动：从 `uid\YmdHMS.jpg` 改成 `uid\YmdHMS\ms.jpg`
- 转码脚本自动旋转
- java 包结构改动

**修复问题**

主要修复了以下问题：

- web 录制时间不正常
- 内存泄漏
- 三方互通 bug
- h.264 parser bug
- 音画不同步

## 2.2.1 版

该版本于 2018 年 6 月 5 日发布。新增特性与修复问题列表详见下文。

**改进**

- 提升了通信模式的性能。相同性能的机器能够支持的录制通道数多达 2.2 版的 2.5 倍。
- 减少了寻找端口的时间。
- 寻找端口的时间不再计入 idle 时间。

**修复问题**

主要修复了以下问题：

- 端口冲突导致寻找端口时间过长，超出 idle 时间，以至未连接成功就下线。

## 2.2.0 版

该版本于 2018 年 5 月 4 日发布。新增特性与修复问题列表详见下文。

> 下载包里有两个包，Java 和 C++ 。

**修复问题**

主要修复了以下问题：

- 修复了日志过大的问题
- 修复了录制过程中视频快进的异常问题
- 修复了某些间歇性故障
- 性能提升
- 提高了稳定性

## 2.1.0 版

该版本于 2018 年 3 月 7 日发布。新增特性与修复问题列表详见下文。

**新增功能**

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>功能</td>
<td>描述</td>
</tr>
<tr><td>选择录制模式</td>
<td>支持用户在进入频道时，选择自动或手动模块，方便灵活控制录制</td>
</tr>
<tr><td>自由控制录制开始和结束时间</td>
<td>新增接口解绑了进入频道和开始录制操作。如果选择的是自动录制模式，当频道内有人出现时才会启动录制。如果选择的是手动录制模式，则开发者有能力手动控制录制开始和结束的时间点</td>
</tr>
<tr><td>混音裸数据</td>
<td>混合语音裸数据</td>
</tr>
<tr><td>支持 Java 版</td>
<td>新增 Java 环境下的 API</td>
</tr>
</tbody>
</table>



**改进**

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>改进</td>
<td>描述</td>
</tr>
<tr><td>优化转码脚本</td>
<td>支持设置转码帧率和分辨率，且支持合流模式和单流模式</td>
</tr>
</tbody>
</table>



**修复问题**

主要修复了以下问题:

- 修复了偶现的录制文件转码失败问题;
- 修复了偶现的录制画面翻转问题;
- 修复了录制过程中偶现的音频异常问题;

## 2.0.0 版

该版本于 2017 年 11 月 21 日发布。新增特性与修复问题列表详见下文。

- 裸数据优化，多种格式支持:
  - 修改了参数 `decodeAudio` 和 `decodeVideo` 并新增 `VideoJpgFrame` 结构体。
  - 修改了参数 `getAudioFrame `和 `getVideoFrame `。
- 屏幕截图，新增参数 `captureInterval `用户设置截图的时间间隔。
- 视频大小流，新增参数 `streamType` 。
- 纯视频录制，新增参数 `isVideoOnly`。
- 只要使用了转码脚本，转码完成后会生成一个`convert.log`文件，和音视频文件在同一个路径下。
- `UID\_HHMMSSMS.txt` 里新增了视频旋转信息。

## 1.3.0 版

该版本于 2017 年 10 月 2 日发布。新增特性与修复问题列表详见下文。

**新增功能**

- 支持音视频混合录制, 在 `API joinChannel`里新增参数 `mixedVideoAudio` 和 `cfgFilePath `。
- 新增合并同一个 uid 音视频文件功能，详见 [合流录制](./composite_recording)。
- 新增 `API getProperties`用于在录制开启时便能立即获取录制路径而无需加入频道。
- 修改了 `onError` 和 `onLeaveChannel` 回调。

## 1.2.0 版

该版本于 2017 年 8 月 21 日发布。新增特性与修复问题列表详见下文。

**新增功能**

- 新增功能获取音视频裸数据
- 新增功能支持鉴黄截图
- 新增日志文件 `recording\sys.log` 便于用户查找问题原因
- 新增功能支持本地服务端录制 SDK 时间戳

## 1.1.0 版

该版本于 2017 年 7 月 25 日发布。新增特性与修复问题列表详见下文。

**新增功能**

- 支持 Web 端录制功能, 生成的录制文件格式为 `UID\_HHMMSSMS.webm`
- 新增实时合流功能
- 新增了回调功能
- 修改了转码文件格式
- 新增了自由设置 UDP 端口的功能

**修复问题**

- 修复了偶现的错误时间戳问题
- 修复了偶现的转码失败问题
- 修复了偶现的 VLC 文件无法播放的问题

## 1.0.1 版

该版本于 2017 年 6 月 27 日发布。新增特性与修复问题列表详见下文。

**修复问题**

直播场景下: 修复了服务器端的一个崩溃。

## 1.0.0 版

该版本于 2017 年 6 月 15 日发布。本次发版为本地服务端录制 SDK 的第一次发版，主要包括以下功能:

- 录制通信或直播模式
- 录制一个频道内所有参与者的语音和视频内容
- 同时录制多个频道内所有参与者的语音和视频内容
- 同时录制一个或多个频道内所有参与者的纯语音内容
- 支持加密频道\(使用了 Agora SDK 内置的加密方案\)的录制