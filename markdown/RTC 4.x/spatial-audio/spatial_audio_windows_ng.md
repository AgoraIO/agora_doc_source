~63a4cd20-ada4-11ed-98c1-83ef730c7692~



## 前提条件

- 在实现空间音效前，请确保已在你的项目中实现基本的实时音视频功能。详见[实现视频通话](https://docs.agora.io/cn/video-call-4.x/start_call_windows_ng?platform=Windows)或[实现互动直播](https://docs.agora.io/cn/live-streaming-premium-4.x/start_live_windows_ng?platform=Windows)。
- 用户在空间音效场景下使用蓝牙耳机存在一定限制：
  - 当用户角色为主播时，必须[联系技术支持](https://agora-ticket.agora.io)使用 A2DP 传输协议，即：蓝牙耳机仅用于播放音频，需要使用其他设备采集音频，否则会导致主播无法体验到空间音效。
  - 当用户角色为观众时，无需额外设置，可以直接通过蓝牙耳机听到空间音效；如果该用户需要上麦，则需参考上面对主播角色的限制。

## 实现空间音效
本节介绍如何在你的项目中实现空间音效。

参考以下调用时序图实现空间音效：

![](https://web-cdn.agora.io/docs-files/1676445338246)


参考如下具体步骤，实现空间音效功能：
### 初始化空间音效引擎

初始化 `IRtcEngine` 后，你需要在调用声网空间音效相关 API 前，调用 `ILocalSpatialAudioEngine` 中的 `initialize`，初始化 `ILocalSpatialAudioEngine` 对象。示例代码如下：

``` c++
agora::rtc::ILocalSpatialAudioEngine* localSpatialAudio = NULL;

// 获取 ILocalSpatialAudioEngine 接口类的指针
int ret = rtcEngine->queryInterface(AGORA_IID_LOCAL_SPATIAL_AUDIO,
reinterpret_cast<void**>(&localSpatialAudio));

rtc::LocalSpatialAudioConfig initConf;
initConf.rtcEngine = rtcEngine;

// 初始化空间音效引擎
ret = localSpatialAudio->initialize(initConf);
```

### 加入频道

1. 调用 `setAudioProfile`[2/2]，将 `profile` 设置为你预期的音频编码属性；
2. 调用 `setAudioScenario`， 将 `scenario` 设置为 `AUDIO_SCENARIO_GAME_STREAMING`。
3. 调用 `joinChannel`[2/2] 加入频道，并在 `ChannelMediaOptions` 中按照如下推荐进行设置：
   1. 将 `channelProfile` 设置为 `CHANNEL_PROFILE_LIVE_BROADCASTING` （直播场景）。
   2. 将 `clientRoleType` 设置为 `CLIENT_ROLE_BROADCASTER`（主播）。
   3. 将 `autoSubscribeAudio` 设置为 `false`，即：不自动订阅任何音频流。SDK 会根据你在后续步骤中设置的音频接收范围决定应该订阅哪些音频流。

```c++
// 加入频道
ChannelMediaOptions options;
options.channelProfile = CHANNEL_PROFILE_LIVE_BROADCASTING;
options.clientRoleType = CLIENT_ROLE_BROADCASTER;
options.autoSubscribeAudio = false;

m_rtcEngine->joinChannel("YourToken", szChannelId.c_str(), 0, options);
```

### 设置空间音效基础功能

1. 设置音频接收范围。

   1. 调用 `setMaxAudioRecvCount` 设置音频接收范围内最多可接收的音频流数。参数 `maxCount` 的推荐值 ≤ 16。
   2. 调用 `setAudioRecvRange` 设置音频接收范围，单位为游戏引擎中的距离单位。

    ```c++
    localSpatial.setMaxAudioRecvCount(2);
    localSpatial.setAudioRecvRange(AXIS_MAX_DISTANCE);
    ```

2. 根据实际需求，调用 `updateSelfPosition` 、 `updateRemotePosition` 或 `updatePlayerPositionInfo` 方法，分别更新本地用户、远端用户（或媒体播放器）的空间位置：
   * 当频道内有新用户加入时立刻调用。
   * 当本地或远端用户的位置发生改变时调用。
   * 按照设定的更新频率周期性地调用。推荐更新频率：50 ms ～ 100 ms。
   
  ```c++
    // 更新本地用户空间位置
    float[] pos = getVoicePosition(localIv);
    float[] forward = new float[]{1.0F, 0.0F, 0.0F};
    float[] right = new float[]{0.0F, 1.0F, 0.0F};
    float[] up = new float[]{0.0F, 0.0F, 1.0F};
    localSpatial.updateSelfPosition(pos, forward, right, up);

   // 更新远端用户空间位置
   public void onUserJoined(int uid, int elapsed) {
      super.onUserJoined(uid, elapsed);
      Log.i(TAG, "onUserJoined->" + uid);
      showLongToast(String.format("user %d joined!", uid));
      runOnUIThread(() -> {
          if (remoteLeftTv.getTag() == null) {
              remoteLeftTv.setTag(uid);
              remoteLeftTv.setVisibility(View.VISIBLE);
              remoteLeftTv.setText(uid + "");
              localSpatial.updateRemotePosition(uid, getVoicePositionInfo(remoteLeftTv)   
              remoteLeftTv.setOnClickListener(v -> showRemoteUserSettingDialog(uid));
          } else if (remoteRightTv.getTag() == null) {
              remoteRightTv.setTag(uid);
              remoteRightTv.setVisibility(View.VISIBLE);
              remoteRightTv.setText(uid + "");
              localSpatial.updateRemotePosition(uid, getVoicePositionInfo(remoteRightTv)  
              remoteRightTv.setOnClickListener(v -> showRemoteUserSettingDialog(uid));
          }
      });
   }
    ```

3. 在互动过程中，声网空间音效功能还支持你进行以下操作：
   - 如果你想要在互动过程中关闭空间音效，可在频道内随时调用 `IRtcEngine` 中的 `enableSpatialAudio` 并将参数设置为 `false`。如果之后想再次开启空间音效，可再次调用该方法，并将参数设置为 `true`。此时所有跟空间音效相关的设置都会被重置，你需要重新调用相关 API 并进行设置。
   - 如果你不想将自己的声音发布到远端，可以调用 `ILocalSpatialAudioEngine` 中的 `muteLocalAudioStream`，取消发布本地音频流。
   - 如果某远端用户已退出频道，你可以调用 `removeRemotePositon` 删除该用户的空间位置信息，以节省计算资源。


<div class="alert note">在设置隔声区域、空气衰减效果、人声模糊效果、多普勒音效前，请确保已经在频道中完成了上述空间音效基础设置。</div>

### 设置隔声区域

调用 `setZones` 方法定义一个隔声区域，并设置该区域与外部互通时的声音衰减系数。

```c++
// 定义隔声区域
SpatialAudioZone zones[1];

zones[0].zoneSetId = 1;
zones[0].position[0] = 1.0;
zones[0].position[1] = 2.0;
zones[0].position[2] = 3.0;
zones[0].forward[0] = 1.0;
zones[0].forward[1] = 0;
zones[0].forward[2] = 0;
zones[0].right[0] = 0;
zones[0].right[1] = 1;
zones[0].right[2] = 0;
zones[0].up[0] = 0;
zones[0].up[1] = 0;
zones[0].up[2] = 1.0;

// 设置隔声区域边界的衰减系数，取值范围为 [0,1]。
// 取值越大，隔声区域内的用户与外部用户互通时，内部用户发出的声音衰减效果越强。
zones[0].audioAttenuation = 1.0;

// 设置隔声区域
localSpatialAudio→setZones(zones, 1);

// 设置本地用户在空间里的位置
localSpatialAudio→updateSelfPosition(pos, forward, right, up);

// 设置远端用户在空间里的位置
localSpatialAudio→updateRemotePosition(remoteUid, remotePosInfo);

// 设置媒体播放器在空间里的位置
localSpatialAudio→updatePlayerPositionInfo(playerId, playerPosInfo);
```

### 设置空气衰减效果

调用 `setRemoteUserSpatialAudioParams` 并设置 `params` 参数，当本地用户听指定的远端用户时，能体验到声音的空气衰减效果。示例代码如下：

```c++
// 开启空气衰减
param.enable_air_absorb = true;

// 设置指定远端用户的空间音效参数
m_rtcEngine->setRemoteUserSpatialAudioParams(uid, param);
```

### 设置人声模糊效果

调用 `setRemoteUserSpatialAudioParams` 并设置 `params` 参数，使本地用户听指定的远端用户时能体验到人声模糊效果。示例代码如下：

```c++
// 打开人声模糊功能
param.enable_blur= true;

// 设置指定远端用户的空间音效参数
m_rtcEngine->setRemoteUserSpatialAudioParams(uid, param);
```


### 设置多普勒音效

<div class="alert note"><li>多普勒音效适用于声源高速运动的场景（例如：赛车游戏），在普通音视频互动场景（语聊、连麦、在线 KTV）中不建议开启。</li>
<li>开启多普勒音效时，建议设定一个规律的周期（比如 30 ms），然后调用 <code>updatePlayerPositionInfo</code>、<code>updateSelfPosition</code> 或 <code>updateRemotePosition</code> 方法持续更新声源和接收方的相对距离。以下因素会导致多普勒音效达不到预期或者声音出现抖动：更新距离的周期过长，更新周期不规律，网络丢包或延迟导致距离信息丢失。</li></div>

1. 调用 `setRemoteUserSpatialAudioParams` 并设置 `params` 参数，针对指定的远端用户开启多普勒音效；或者调用 `setSpatialAudioParams` 方法，针对媒体播放器开启多普勒音效（示例代码中以前者为例）。
2. 周期性调用 `updateSelfPosition`、`updateRemotePosition` 或 `updatePlayerPositionInfo` 方法，更新本地用户、远端用户或媒体播放器的位置，使本地用户听到的远端用户或媒体播放器声音具有多普勒音效。
   示例代码如下：

```c++
//打开多普勒音效
param.enable_doppler= true;

// 设置指定远端用户的空间音效参数
m_rtcEngine->setRemoteUserSpatialAudioParams(uid, param);

// 周期性更新本地用户、远端用户或媒体播放器的位置
// 以更新本地用户的位置为例
ILocalSpatialAudioEngine* m_localSpatial;

float pos[3] = {0};
float forward[3] = { 1.0f, 0, 0 };
float right[3] = { 0, 1.0f, 0 };
float up[3] = { 0, 0, 1.0f };
m_localSpatial->updateSelfPosition(pos, forward, right, up);
```

### 设置耳机均衡效果

如果你正在使用的耳机品质不佳、导致在空间音效场景下不能达到到很好的音频体验，你可以使用 SDK 中提供的方法修改耳机均衡效果。
<div class="alert info">如果你使用的耳机已经具备良好的均衡效果，调用该方法时可能不会获得明显的体验提升效果，甚至可能导致体验下降。</div>

1. 调用 `setHeadphoneEQPreset` 方法，选择预设的耳机均衡器收听音频，以达到预期的音频体验。
2. （可选）如果执行上一步后仍未达到预期，你可以调用 `setHeadphoneEQParameters` 自行调节耳机均衡效果。
   示例代码如下：

```c++
// 设置耳机均衡模式为头戴式耳机均衡器
m_rtcEngine > setHeadphoneEQPreset(HEADPHONE_EQUALIZER_OVEREAR)

// 自行调节耳机均衡器的低频和高频参数
// 此操作会覆盖 setHeadphoneEQPreset 中的设置。
m_rtcEngine > setHeadphoneEQParameters(5，8)
```

### 停止空间音效
如果你不想继续体验空间音效，你可以进行如下操作：
1. 调用 `clearRemotePositions` 删除所有远端用户的空间位置信息。
  
   <div class="alert note">成功调用该方法后，本地用户会听不到所有远端用户，声网不推荐你主动调用该方法。如果你在调用该方法后仍需听到远端用户，可调用 <code>ILocalSpatialAudioEngine</code> 中的 <code>muteAllRemoteAudioStreams(false)</code> 恢复订阅远端用户的音频流。</div>

2. (可选) 调用 `IRtcEngine` 的 `leaveChannel` 离开频道。
3. (可选) 销毁引擎。
   1. 调用 `IBaseSpatialAudioEngine` 中的 `release` 销毁 `IBaseSpatialAudioEngine` 对象。
   2. 调用 `IRtcEngine` 中的 `release` 销毁 `IRtcEngine` 对象。


## 相关文档

### 示例项目

声网在 GitHub 上提供开源的 [SpatialAudio](https://github.com/AgoraIO/API-Examples/tree/main/windows/APIExample/APIExample/Advanced/SpatialAudio) 示例项目。你可以前往下载，或查看其中的源代码。

### API 参考

- [ILocalSpatialAudioEngine](./API%20Reference/windows_ng/API/rtc_interface_class.html#class_ilocalspatialaudioengine)
  - [initialize](./API%20Reference/windows_ng/API/toc_audio_effect.html#api_ilocalspatialaudioengine_initialize)
  - [clearRemotePositions](./API%20Reference/windows_ng/API/toc_audio_effect.html#api_ilocalspatialaudioengine_clearremotepositions)
  - [removeRemotePosition](./API%20Reference/windows_ng/API/toc_audio_effect.html#api_ilocalspatialaudioengine_removeremoteposition)
  - [setRemoteAudioAttenuation](./API%20Reference/windows_ng/API/toc_audio_effect.html#api_ilocalspatialaudioengine_setremoteaudioattenuation)
- [IBaseSpatialAudioEngine](./API%20Reference/windows_ng/API/rtc_interface_class.html#class_ibasespatialaudioengine)
  - [updatePlayerPositionInfo](./API%20Reference/windows_ng/API/toc_audio_effect.html#api_ibasespatialaudioengine_updateplayerpositioninfo)
  - [updateSelfPosition](./API%20Reference/windows_ng/API/toc_audio_effect.html#api_ibasespatialaudioengine_updateselfposition)
  - [updateRemotePosition](./API%20Reference/windows_ng/API/toc_audio_effect.html#api_ilocalspatialaudioengine_updateremoteposition)
  - [muteAllRemoteAudioStreams](./API%20Reference/windows_ng/API/toc_audio_effect.html#api_ibasespatialaudioengine_muteallremoteaudiostreams)
  - [muteLocalAudioStream](./API%20Reference/windows_ng/API/toc_audio_effect.html#api_ibasespatialaudioengine_mutelocalaudiostream)
  - [setAudioRecvRange](./API%20Reference/windows_ng/API/toc_audio_effect.html#api_ibasespatialaudioengine_setaudiorecvrange)
  - [setDistanceUnit](./API%20Reference/windows_ng/API/toc_audio_effect.html#api_ibasespatialaudioengine_setdistanceunit)
  - [setMaxAudioRecvCount](./API%20Reference/windows_ng/API/toc_audio_effect.html#api_ibasespatialaudioengine_setmaxaudiorecvcount)
  - [setPlayerAttenuation](./API%20Reference/windows_ng/API/toc_audio_effect.html#api_ibasespatialaudioengine_setplayerattenuation)
  - [setZones](./API%20Reference/windows_ng/API/toc_audio_effect.html#api_ibasespatialaudioengine_setzones)
  - [release](./API%20Reference/windows_ng/API/toc_audio_effect.html#api_ibasespatialaudioengine_release)
- [IRtcEngine](./API%20Reference/windows_ng/API/rtc_interface_class.html#class_irtcengine)
  - [setHeadphoneEQPreset](./API%20Reference/windows_ng/API/toc_audio_effect.html#api_irtcengine_setheadphoneeqparameters)
  - [setHeadphoneEQParameters](./API%20Reference/windows_ng/API/toc_audio_effect.html#api_irtcengine_setheadphoneeqparameters)