本文介绍如何使用空间音效功能以增强元宇宙音频体验。

在元宇宙中，空间音效可以为用户带来更加真实的虚拟体验。例如，在一个虚拟的 3D 旅游场景中，空间音效可以让用户宛如身临其境般听到旅游中路人聊天声、海浪声、风声，让用户更沉浸式体验。

![](https://web-cdn.agora.io/docs-files/1679566933312)

## 技术原理

空间音效功能基于声学原理，模拟声音在不同空间环境中的传播、反射、吸收效果。通过在不同位置放置音源和听众，模拟现实中的声音传播效果，使得听众可以听到更真实自然的声音。

结合 `IMetaSceneEventHandler` 提供的用户位置信息回调和 `ILocalSpatialAudioEngine` 提供的空间音效系列方法，你可以实现带空间音效的元语聊。

## 示例项目

声网在 GitHub 上提供开源 [Agora-MetaWorld](https://github.com/AgoraIO-Community/Agora-MetaWorld/tree/dev_metasdk1.0) 示例项目供你参考。

如果你还需了解 Unity 部分的工程文件和功能指南，请联系 [sales@agora.io](mailto:sales@agora.io) 获取。


## 前提条件

实现该进阶功能前，请确保你已实现基础的元语聊或元直播功能，如创建 Meta 服务、获取并下载场景资源、创建场景、设置虚拟形象的信息并进入场景。详见[基础功能](https://docs.agora.io/cn/metaworld/mw_integration_metachat_android?platform=All%20Platforms)。


## 实现步骤

用户在元宇宙中听到的声音分为两类：

- 远端用户的音频
- 本地媒体播放器播放的音频

因此，实现空间音效时，你需要按照如下步骤对两种音频都进行处理。

### 用户空间音效

下图介绍实现用户空间音效的 API 时序：

![](https://web-cdn.agora.io/docs-files/1688115484780)


#### 1. 创建和初始化空间音效引擎

使用空间音效前，你需要调用 [`create`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_effect.html#api_ilocalspatialaudioengine_create) 和 [`initialize`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_effect.html#api_ilocalspatialaudioengine_initialize) 创建和初始化空间音效引擎。

**注意**：
- 请在加入 RTC 频道前调用。
- 当使用空间音效时，请确保在 `RtcEngine` 中停止发布和订阅音频流。

```java
// 创建和初始化空间音效引擎
spatialAudioEngine = ILocalSpatialAudioEngine.create();
LocalSpatialAudioConfig config = new LocalSpatialAudioConfig() {{
    mRtcEngine = rtcEngine;
}};
spatialAudioEngine.initialize(config);
```


#### 2.设置空间音效接收范围

调用 [`setAudioRecvRange`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_effect.html?platform=Android#api_ibasespatialaudioengine_setaudiorecvrange) 设置空间音效接收范围，当远端用户相对本地用户的距离超出这个范围，本地用户就会听不到远端用户的声音。

你可以通过 `ILocalSpatialAudioEngine` 处理是否停止发布和订阅音频流。

```java
// 设置空间音效的音频接收范围
// 如果超过设置的值，那么本地用户听不见远端用户的声音
spatialAudioEngine.setAudioRecvRange(100);
// ILocalSpatialAudioEngine 设置恢复发布本地音频流
// 此时需要额外检查本地用户角色不是观众，否则无法发流
spatialAudioEngine.muteLocalAudioStream(false);
// ILocalSpatialAudioEngine 设置恢复订阅所有远端音频流
spatialAudioEngine.muteAllRemoteAudioStreams(false);
```


#### 3. 处理用户位置变化

通过 [`onUserPositionChanged`](https://docs.agora.io/cn/metaworld/mw_api_ref_android?platform=All%20Platforms#onuserpositionchanged) 回调监听用户的位置变化。如果当前用户是本地用户，调用 [`updateSelfPosition`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_effect.html#api_ibasespatialaudioengine_updateselfposition) 更新本地用户位置信息；如果当前用户是远端用户，调用 [`updateRemotePosition`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_effect.html#api_ilocalspatialaudioengine_updateremoteposition) 更新远端用户的信息位置。

**注意**：请在加入 RTC 频道后监听和处理用户位置变化。

```java
// 处理用户位置的变化
@Override
public void onUserPositionChanged(String uid, MetaUserPositionInfo posInfo) {
    Log.d(TAG, String.format("onUserPositionChanged %s %s %s %s %s", uid,
            Arrays.toString(posInfo.mPosition),
            Arrays.toString(posInfo.mForward),
            Arrays.toString(posInfo.mRight),
            Arrays.toString(posInfo.mUp)
    ));

    if (spatialAudioEngine != null) {
        try {
            int userId = Integer.parseInt(uid);
            // 如果当前用户是本地用户
            // 那么使用 updateSelfPosition 更新本地用户的位置信息
            // 否则使用 updateRemotePosition 更新远端用户的位置信息
            if (KeyCenter.RTC_UID == userId) {
                spatialAudioEngine.updateSelfPosition(
                        posInfo.mPosition, posInfo.mForward, posInfo.mRight, posInfo.mUp
                );
            } else {
                spatialAudioEngine.updateRemotePosition(userId, new RemoteVoicePositionInfo() {{
                    position = posInfo.mPosition;
                    forward = posInfo.mForward;
                }});
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}
```

#### 4. 销毁空间音效引擎

不需要使用空间音效时，调用 [`destroy`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_effect.html#api_ilocalspatialaudioengine_release) 销毁空间音效引擎。

**注意**：请在离开 RTC 频道后和销毁 RTC 引擎前调用 destroy。

```java
// 销毁空间音效引擎
if (spatialAudioEngine != null) {
    ILocalSpatialAudioEngine.destroy();
    spatialAudioEngine = null;
}
```


### 音乐空间音效

下图介绍实现媒体播放器空间音效的 API 时序：

![](https://web-cdn.agora.io/docs-files/1688115497503)

由于空间音效是基于 NPC 或物体的位置驱动，因此在进入 Unity 场景后，无论 NPC 或物体是否移动，都需要 Unity 脚本主动向 app 发送一次 NPC 或物体的位置信息。这样可以确保空间音效引擎始终基于最新的位置数据提供空间音效。

#### 1. 实现媒体播放器

参考[媒体播放器](https://docs.agora.io/cn/live-streaming-premium-4.x/media_player_android_ng?platform=Android)功能指南创建一个 `IMediaPlayer` 对象，然后打开、播放媒体资源。

```java
mRtcEngine = RtcEngine.create(config);
// 创建 IMediaPlayer 对象
mediaPlayer = engine.createMediaPlayer();
mediaPlayer.open(url, 0);
// 请确保在收到 onPlayerStateChanged 回调报告 PLAYER_STATE_OPEN_COMPLETED 后再调用 play
mediaPlayer.play();
```

#### 2. 设置播放器空间音效

处理 Unity 场景的回调信息，解析得到物体的三维坐标位置和朝向，并将这些信息传入 [`updatePlayerPositionInfo`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_effect.html#api_ibasespatialaudioengine_updateplayerpositioninfo) 方法，设置播放器的空间音效。

```java
// 处理 Unity 场景回调信息
@Override
public void onRecvMessageFromScene(byte[] message) {
    // 解析 message，得到物体在场景里面的位置信息，包含 position 和 forward
    // position 是物体的三维坐标位置
    // forward 是物体朝向
    // 注意：message 协议格式需要由你们的 Unity 开发人员和 Native 开发人员协商规定
    ...

    // 创建 RemoteVoicePositionInfo 对象，设置位置和朝向信息
    RemoteVoicePositionInfo posInfo = new RemoteVoicePositionInfo();
    posInfo.position = pos;  // pos 为解析得到的物体位置
    posInfo.forward = forward;  // forward 为解析得到的物体朝向

    // 设置播放器的空间音效
    spatialAudioEngine.updatePlayerPosition(mMediaPlayer.getMediaPlayerId(), posInfo);
}
```


