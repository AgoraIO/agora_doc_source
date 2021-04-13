---
title: 设置订阅状态
platform: Android
updatedAt: 2021-03-12 04:55:47
---
## 概述

在实时音视频互动过程中，你可能需要结合业务场景设置音视频流的[订阅](https://docs.agora.io/cn/Agora%20Platform/subscribe)状态。例如，用户在加入频道后不订阅单个远端用户。

本文介绍如何在常见场景中设置订阅状态。

<div class="alert note"><li>本文适用于 3.3.0 及之后版本 SDK。</li><li>如果你从 3.3.0 之前版本升级到 3.3.0 及之后版本，为保证你的业务功能不受影响，Agora 推荐你参考 <a href="#api_changes">API 变更</a >调整订阅设置。</li><li>订阅音视频流会产生用量并影响计费。</li></div>

## API 介绍

默认情况下，用户加入或切换频道时会订阅所有远端用户的音视频流。你可以调用如下 API 设置订阅状态：

| API                                                          | 设置对象           | 调用要求                                               |
| :----------------------------------------------------------- | :----------------- | :----------------------------------------------------- |
| `channelMediaOptions` 的 `autoSubscribeAudio` 或 `autoSubscribeVideo` | 所有远端用户       | 调用 `joinChannel`[2/2] 或 `switchChannel`[2/2] 时设置 |
| `muteAllRemoteAudioStreams` 或 `muteAllRemoteVideoStreams`   | 所有远端用户       | 在频道内可以随时调用                                   |
| `muteRemoteAudioStream` 或 `muteRemoteVideoStream`           | 指定的单个远端用户 | 在频道内可以随时调用                                   |

<div class="alert note"><li>在频道内，加入或切换频道时的订阅设置会被 <code>muteAll</code> 或 <code>muteRemote</code> 为前缀的方法改变。</li><li><code>muteAll</code> 和 <code>muteRemote</code> 为前缀的方法相互独立。一起调用时，后调用的方法会生效。</li></div>

## 推荐设置

### 场景一：在频道内取消订阅指定用户

如果用户在加入或切换频道时订阅所有远端用户，用户可能需要在频道内取消订阅单个或多个远端用户。Agora 推荐按如下步骤设置：

1. 在用户加入或切换频道时使用 SDK 的默认设置。
2. 在频道内，根据用户的选择，调用 `muteRemoteAudioStream(uid, true)` 或 `muteRemoteVideoStream(uid, true)` 取消订阅指定的远端用户。

### <a name="scenario2"></a>场景二：加入频道时订阅指定用户

用户可能需要在加入或切换频道时订阅单个或多个远端用户。Agora 推荐按如下步骤设置：

1. 调用 `joinChannel`[2/2] 或 `switchChannel`[2/2] 并设为 `autoSubscribeAudio(false)` 或 `autoSubscribeVideo(false)` 不订阅所有远端用户。
2. 在频道内，根据用户的选择，调用 `muteRemoteAudioStream(uid, false)` 或 `muteRemoteVideoStream(uid, false)` 订阅指定的远端用户。

### 场景三：在频道内更换订阅的用户

用户可能需要在加入或切换频道时订阅指定远端用户，一段时间后，再更换订阅的远端用户。Agora 推荐按如下步骤设置：

1. 参考[场景二](#scenario2)在加入或切换频道时订阅指定远端用户。
2. 当用户需要更换订阅的远端用户时，调用 `muteAllRemoteAudioStreams(true)` 和 `muteAllRemoteVideoStreams(true)` 取消订阅所有远端用户。
3. 调用 `muteRemoteAudioStream(uid, false)` 或 `muteRemoteVideoStream(uid, false)` 订阅其他远端用户。

### 场景四：被系统或第三方应用打断时的订阅设置

在实时音视频通话或直播过程中，用户可能会遇到被系统或第三方应用打断的情况，例如被系统电话打断。该场景的如下阶段可能需要设置订阅状态：

1. 用户开始使用系统或第三方应用，并且该应用会占用设备的音视频模块时，Agora 推荐取消订阅所有用户。
2. 用户结束使用系统或第三方应用时，Agora 推荐恢复原始的订阅状态。

原始订阅状态不同，则订阅设置的逻辑不同。

- 如果用户在实时音视频通话或直播过程中订阅了**所有**远端用户，Agora 推荐按如下步骤设置：

  a. 在用户开始使用系统或第三方应用时，调用 `muteAllRemoteAudioStreams(true)` 或 `muteAllRemoteVideoStreams(true)` 取消订阅所有远端用户。
  b. 在用户结束使用系统或第三方应用时，调用 `muteAllRemoteAudioStreams(false)` 或 `muteAllRemoteVideoStreams(false)` 恢复订阅所有远端用户。

- 如果用户在实时音视频通话或直播过程中订阅了**部分**远端用户，Agora 推荐按如下步骤设置：

  a. 记录原始订阅状态。例如只订阅远端用户 A 和 B。
  b. 在用户开始使用系统或第三方应用时，调用 `muteAllRemoteAudioStreams(true)` 或 `muteAllRemoteVideoStreams(true)` 取消订阅所有远端用户。
  c. 在用户结束使用系统或第三方应用时，根据步骤 1 的记录恢复原始订阅状态。例如，调用如下方法恢复订阅远端用户 A 和 B。
     - 调用 `muteRemoteAudioStream(A, false)` 和 `muteRemoteVideoStream(A, false)` 恢复订阅远端用户 A。
     - 调用 `muteRemoteAudioStream(B, false)` 和 `muteRemoteVideoStream(B, false)` 恢复订阅远端用户 B。

## <a name="api_changes"></a>API 变更

自 3.3.0 版本起，Agora 新增 `joinChannel`[2/2] 和 `switchChannel`[2/2]，并修改了 `mute` 相关方法的使用逻辑。如果你需要升级至 3.3.0 及之后版本，为保证你的业务功能不受影响，Agora 推荐你参考如下内容调整订阅设置。

在 3.3.0 之前版本中：

- 加入或切换频道时不能设置订阅状态，默认订阅当前频道内的音频或视频流。

- `mute` 相关方法在加入频道或切换频道**前后**均可调用。

- `muteAll` 为前缀的方法（下文简称为 `muteAll`）起着总开关的作用，`muteRemote` 或 `setDefaultMute` 为前缀的方法（下文简称为 `muteRemote` 和 `setDefaultMute`）起着子开关的作用。

 ![](https://web-cdn.agora.io/docs-files/1611154569739)

  - 调用 `muteAll(true)` 时，总开关断开，用户取消订阅所有音视频流。`muteRemote` 或 `setDefaultMute` 的设置不生效。

  - 调用 `muteAll(false)` 时，总开关闭合。用户的订阅状态由 `muteRemote` 或 `setDefaultMute` 控制。

    - 设置为 `true` 时，子开关断开，状态为不订阅。
    - 设置为 `false` 时，子开关闭合，状态为订阅。

- `muteAll` 只能设置是否订阅当前频道内的音频或视频流。

- `muteAll(false)` 不会恢复订阅所有音频或视频流，只会恢复原有的订阅状态。

自 3.3.0 版本起：

- 废弃 `setDefaultMuteAllRemoteAudioStreams` 和 `setDefaultMuteAllRemoteVideoStreams`。
- 加入或切换频道时，可以调用 `joinChannel`[2/2] 或 `switchChannel`[2/2] 设置订阅状态。
- `mute` 相关方法需要在加入频道或切换频道**后**调用，否则会不生效。
- `muteAll` 不再作为总开关，每个 `mute` 相关的方法都能独立控制用户的订阅状态。一起调用 `muteAll` 和 `muteRemote` 时，后调用的方法会生效。
- `muteAll` 设置是否订阅所有音频或视频流，包含调用时刻之后加入频道的用户的音频或视频流，即 `muteAll` 包含了 `setDefaultMute` 的功能。Agora 不推荐一起调用 `muteAll` 和 `setDefaultMute`，否则设置可能会不生效。
- `muteAll(false)` 会恢复订阅所有音频或视频流。

## 各语言方法对照表

| Java/C++                    | Objective-C                 |
| :-------------------------- | :-------------------------- |
| `joinChannel`[2/2]          | `joinChannelByToken`[2/2]   |
| `switchChannel`[2/2]        | `switchChannelByToken`[2/2] |
| `muteAllRemoteAudioStreams` | `muteAllRemoteAudioStreams` |
| `muteAllRemoteVideoStreams` | `muteAllRemoteVideoStreams` |
| `muteRemoteAudioStream`     | `muteRemoteAudioStream`     |
| `muteRemoteVideoStream`     | `muteRemoteVideoStream`     |