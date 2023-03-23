本文介绍如何使用空间音效功能以增强元宇宙音频体验。//TODO(api sequence pic)

在元宇宙中，空间音效可以为用户带来更加真实、身临其境的虚拟体验。例如，在一个虚拟的 3D 旅游场景中，空间音效可以让用户宛如身临其境般听到旅游中路人聊天声、海浪声、风声，让用户更沉浸式体验。

![](https://web-cdn.agora.io/docs-files/1679566933312)

## 技术原理

空间音效功能基于声学原理，模拟声音在不同空间环境中的传播、反射、吸收效果。通过在不同位置放置音源和听众，模拟现实中的声音传播效果，使得听众可以听到更真实自然的声音。


结合 `IMetachatSceneEventHandler` 提供的用户位置信息回调和 `ILocalSpatialAudioEngine` 提供的空间音效系列方法，你可以实现带空间音效的元语聊。


## 前提条件


实现空间音效前，请确保你已实现基础的元语聊功能，如创建、进入 3D 常见，更新用户角色。详见[客户端实现](https://docs.agora.io/cn/metachat/metachat_client_android?platform=All%20Platforms)。


## 实现步骤

用户听到的声音是接收到的远端音频流，包含如下音频流：

- 远端用户音频流，即人声和环境背景音。
- 远端媒体播放器音频流，即音乐音效。

因此，实现空间音效时你需要对两种音频流都进行处理。

### 用户空间音效

下图介绍实现用户空间音效的 API 时序图：

<pic>


#### 1. 创建和初始化空间音效引擎

使用空间音效前，你需要调用 [`create`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/v4.1.1/API/toc_audio_effect.html#api_ilocalspatialaudioengine_create) 和 [`initialize`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_effect.html#api_ilocalspatialaudioengine_initialize) 创建和初始化空间音效引擎。

**注意**：请在加入 RTC 频道前调用。

```java
// 创建和初始化空间音效引擎
spatialAudioEngine = ILocalSpatialAudioEngine.create();
LocalSpatialAudioConfig config = new LocalSpatialAudioConfig() {{
    mRtcEngine = rtcEngine;
}};
spatialAudioEngine.initialize(config);
```


#### 2.设置空间音效接收范围 //TODO mute true？mute 前面的应该是 rtcEngine？

调用 [`setAudioRecvRange`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_effect.html?platform=Android#api_ibasespatialaudioengine_setaudiorecvrange) 设置空间音效接收范围，当远端用户相对本地用户的距离超出这个范围，本地用户就会听不到远端用户的声音。

```java
// 设置空间音效的音频接收范围
// 如果超过设置的值，那么本地用户听不见远端用户的声音
spatialAudioEngine.setAudioRecvRange(100);
// 恢复发布本地音频流
// 此时需要额外检查本地用户角色不是观众，否则无法发流
spatialAudioEngine.muteLocalAudioStream(false);
// 恢复订阅所有远端音频流
// SDK 默认本地用户订阅所有远端音频流，如果你此前取消订阅，那么此时应恢复订阅
spatialAudioEngine.muteAllRemoteAudioStreams(false);
```


#### 3. 处理用户位置变化

通过 [`onUserPositionChanged`](https://docs.agora.io/cn/metachat/metachat_api_android?platform=All%20Platforms#onuserpositionchanged) 回调监听用户的位置变化。如果当前用户是本地用户，调用 [`updateSelfPosition`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_effect.html#api_ibasespatialaudioengine_updateselfposition) 更新本地用户位置信息；如果当前用户是远端用户，调用 [`updateRemotePosition`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_effect.html#api_ilocalspatialaudioengine_updateremoteposition) 更新远端用户的信息位置。

**注意**：请在加入 RTC 频道后监听和处理用户位置变化。

```java
// 处理用户位置的变化
@Override
public void onUserPositionChanged(String uid, MetachatUserPositionInfo posInfo) {
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

下图介绍实现媒体播放器空间音效的 API 时序图：

<pic>


由于空间音效是基于人物的位置驱动，因此在进入 Unity 场景后，无论人物是否移动，都需要 Unity 脚本主动向 app 发送一次人物的位置信息。这样可以确保空间音效引擎始终基于最新的位置数据提供空间音效。

#### 1. 实现媒体播放器

参考[媒体播放器](https://docs.agora.io/cn/live-streaming-premium-4.x/media_player_android_ng?platform=Android)功能指南创建一个 `IMediaPlayer` 对象，然后打开、播放媒体资源。

```java
mRtcEngine = RtcEngine.create(config);
// 创建 IMediaPlayer 对象
mediaPlayer = engine.createMediaPlayer();
mediaPlayer.open(url, 0);
// 请确保在收到 PLAYER_STATE_OPEN_COMPLETED 后再调用 play
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


