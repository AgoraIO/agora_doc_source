---
title: 加入多频道
platform: Unity
updatedAt: 2020-09-16 16:28:29
---

## 功能描述

为方便用户同时加入多个频道，接收多个频道的音视频流，Agora Unity SDK 自 v3.0.1 起新增支持多频道管理，且频道数量无限制。

该功能可应用于类似多人游戏开黑的场景：所有玩家都在一个频道中，全员可以进行实时音视频互动。玩家各自组队后，还可以在队内进行实时音视频互动，沟通游戏策略。

## 实现方法

Unity SDK 通过一个 `AgoraChannel` 类实现多频道控制。你可以通过如下任一种方法实现该功能：

### 方法一：仅使用 AgoraChannel 类加入多频道

参考如下步骤在项目中实现多频道功能：

1. 调用 `IRtcEngine` 类的 `CreateChannel` 方法，通过 `channelId` 创建一个 `AgoraChannel` 对象。
2. 调用 `AgoraChannel` 对象中的 `JoinChannel` 方法加入频道。
3. 重复步骤 1、2，创建多个 `AgoraChannel` 对象，然后分别调用这些 `AgoraChannel` 对象中的 `JoinChannel` 方法，同时加入多个频道。

该方法适用于需求频繁切换发布音、视频流频道的场景。

<div class="alert note"><li>如需接收和渲染多频道的视频，你需要在加入频道前调用 <tt>SetMultiChannelWant</tt> 为当前引擎开启多频道状态，并在绑定 <tt>VideoSurface.cs</tt> 前调用 <tt>SetForMultiChannelUser</tt> 渲染本地或远端视图。</li><li>加入多个频道后，你可以调用各 <tt>AgoraChannel</tt> 对象中的 <tt>Publish</tt> 方法在对应的频道中发布音视频流。但需要注意，用户同一时间只能在一个 <tt>AgoraChannel</tt> 对象的频道里发布音视频流。</li><li>调用频道一内的 <tt>Publish</tt> 方法发布流后，必须先调用频道一的 <tt>Unpublish</tt> 方法结束发布，才能调用频道二的 <tt>Publish</tt> 方法。</li></div>

**API 调用时序**

参考如下步骤，在你的项目中使用 `AgoraChannel` 类加入多频道。

![](https://web-cdn.agora.io/docs-files/1600076444694)

**示例代码**

你还可以参考如下示例代码。

```c#
void Start ()
{
    // 1. 初始化 IRtcEngine 实例。
    mRtcEngine = IRtcEngine.GetEngine(APP_ID);

    // 如需接收和渲染多频道的视频，你需要在加入频道前调用 SetMultiChannelWant 为当前引擎开启多频道状态。
    mRtcEngine.SetMultiChannelWant(true);

    // 2. 创建 AgoraChannel 对象。
    mRtcchannel = mRtcEngine.CreateChannel(channelName);

    // 3. 监听加入频道、离开频道回调。
    mRtcchannel.ChannelOnJoinChannelSuccess = ChannelOnJoinChannelSuccessHandler;
    mRtcchannel.ChannelOnLeaveChannel = ChannelOnLeaveChannelHandler;

    // 4. 加入频道。
    mRtcchannel.JoinChannel("", "", 0, new ChannelMediaOptions(true, true));
    // 发布音视频流。
    mRtcchannel.Publish();
}

void OnApplicationQuit()
{
    if (mRtcEngine != null)
    {
        // 5. 离开频道。
        mRtcchannel.LeaveChannel();
        // 6. 释放 AgoraChannel 对象。
        mRtcchannel.ReleaseChannel();
        // 7. 销毁 IRtcEngine 实例。
        IRtcEngine.Destroy();
    }
}

// 成功加入频道回调。
void ChannelOnJoinChannelSuccessHandler(string channelId, uint uid, int elapsed)
{
    makeVideoView(channelId ,0);
}

// 成功离开频道回调。
void ChannelOnLeaveChannelHandler(string channelId, RtcStats rtcStats)
{
}

void makeVideoView(string channelId, uint uid)
{
    GameObject go = GameObject.Find(uid.ToString());
    if (!ReferenceEquals(go, null))
    {
        return;
    }

    // 创建 GameObject 并与 VideoSurface 绑定。
    VideoSurface videoSurface = makeImageSurface(uid.ToString());
    if (!ReferenceEquals(videoSurface, null))
    {
        // 渲染本地或远端视图。
        videoSurface.SetForMultiChannelUser(channelId, uid);
    }
}

VideoSurface makeImageSurface(string goName)
{
    GameObject go = new GameObject();

    go.name = goName;
    go.AddComponent<RawImage>();

    GameObject canvas = GameObject.Find("VideoCanvas");
    if (canvas != null)
    {
        go.transform.parent = canvas.transform;
    }

    go.transform.Rotate(0f, 0.0f, 180.0f);
    float xPos = Random.Range(Offset - Screen.width / 2f, Screen.width / 2f - Offset);
    float yPos = Random.Range(Offset, Screen.height / 2f - Offset);
    go.transform.localPosition = new Vector3(xPos, yPos, 0f);
    go.transform.localScale = new Vector3(3f, 4f, 1f);

    VideoSurface videoSurface = go.AddComponent<VideoSurface>();
    return videoSurface;
}
```

### 方法二：混用 AgoraChannel 和 IRtcEngine 类加入多频道

参考如下步骤在项目中实现多频道功能：

1. 调用 `IRtcEngine` 类下的 `JoinChannelByKey` 方法加入第一个频道。
2. 调用 `IRtcEngine` 类的 `CreateChannel` 方法，通过 `channelId` 创建一个 `AgoraChannel` 对象。
3. 调用 `AgoraChannel` 对象中的 `JoinChannel` 方法加入第二个频道。
4. 重复步骤 2、3，创建多个 `AgoraChannel` 对象，然后分别调用这些 `AgoraChannel` 对象中的 `JoinChannel` 方法，加入更多频道。

该方法适用于只需要将音、视频流固定发布到 `IRtcEngine` 频道的场景。对于已经使用 Agora SDK 实现实时音视频功能的开发者，该方法不涉及原有代码逻辑变动。

<div class="alert note"><li>如需在 IRtcEngine 频道中设置本地或远端视频显示，你需要在绑定 <tt>VideoSurface.cs</tt> 前调用调用 <tt>SetForUser</tt>。</li><li>如需接收和渲染多频道的视频，你需要在加入频道前调用 <tt>SetMultiChannelWant</tt> 为当前引擎开启多频道状态。</li></div>

**API 调用时序**

参考如下步骤，在你的项目中使用 `IRtcEngine` 和 `AgoraChannel` 类加入多频道。

![](https://web-cdn.agora.io/docs-files/1600076457961)

### API 参考

- [`CreateChannel`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html)
- [`AgoraChannel`](./API%20Reference/unity/classagora__gaming__rtc_1_1_agora_channel.html) 类

## 开发注意事项

### 精细订阅限制

如果你在调用 `AgoraChannel` 对象中的 `JoinChannel` 方法加入频道时将 `autoSubscribeAudio` 或 `autoSubscribeVideo` 设为 `false`，选择不自动订阅音频流或视频流，那么加入频道后，你不能再调用 `MuteRemoteAudioStream(false)` 或 `MuteRemoteVideoStream(false)` 接收指定用户的音频流或视频流。如想实现上述操作，我们建议在加入频道前调用 `SetDefaultMuteAllRemoteAudioStreams(true)` 或 `SetDefaultMuteAllRemoteVideoStreams(true)` 设置默认不接收所有音频流或所有视频流。

### 设置远端视图

在视频场景中，如需接收多频道的视频流，你需要在加入频道前调用 `SetMultiChannelWant` 为当前引擎开启多频道状态。如需渲染远端视频画面，你需要在绑定 `VideoSurface.cs` 前调用 `SetForMultiChannelUser`，并指定远端用户的 `uid` 及其所在频道的 `channelId`。

### 多频道发流限制

SDK 仅支持用户同一时间在一个频道内发布音、视频流。因此只要你在一个频道内正在发布音、视频流，就无法在另一个频道发布。

通过 `IRtcEngine` 类和 `AgoraChannel` 类下的方法加入频道后，SDK 的默认行为有以下差异：

- `IRtcEngine` 类下，SDK 默认发布本地音视频流到本频道。
- `AgoraChannel` 类下，SDK 默认不发布本地音视频流到本频道。

因此，以下操作会导致 SDK 返回 `ERR_REFUSED(5)` 错误码：

- 通过 `AgoraChannel` 类加入多频道：
  - 调用频道一的 `Publish` 方法后，未调用频道一的 `Unpublish` 方法结束发布，就调用频道二的 `Publish` 方法；
- 通过混用 `IRtcEngine` 类和 `AgoraChannel` 类加入多频道：
  - 通信或直播场景下，通过 `IRtcEngine` 类加入频道一，然后通过 `AgoraChannel` 类加入频道二后，试图调用 `AgoraChannel` 类的 `Publish` 方法；
  - 直播场景下，加入多个频道后，试图以观众身份调用 `AgoraChannel` 类的 `Publish` 方法；
  - 调用 `AgoraChannel` 类的 `Publish` 方法后，未调用对应 `AgoraChannel` 类的 `Unpublish` 方法，就试图通过 `IRtcEngine` 类的 `JoinChannelByKey` 方法加入频道。
