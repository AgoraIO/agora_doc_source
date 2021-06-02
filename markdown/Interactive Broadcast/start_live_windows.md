---
title: 实现视频直播
platform: Windows
updatedAt: 2021-04-01 07:50:51
---
本文介绍如何通过 Agora SDK 快速实现视频互动直播。

互动直播和实时通话的区别就在于，直播频道的用户有角色之分。你可以将角色设置为主播或者观众，其中主播可以收、发流，观众只能收流。


## 示例项目
Agora 在 GitHub 上提供开源的视频直播示例项目 [OpenLive-Windows](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-Windows) 和 [OpenLive-Windows-MFC](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-Windows-MFC)。在实现相关功能前，你可以下载并查看源代码。

## 前提条件
- Microsoft Visual Studio 2017 或以上版本
- Windows 7 或以上版本的设备
- 有效的 Agora 账户（免费[注册](https://dashboard.agora.io)）

<div class="alert note">如果你的网络环境部署了防火墙，请根据<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">应用企业防火墙限制</a>打开相关端口。</div>

## 设置开发环境
本节介绍如何创建项目，并将 Agora SDK 集成至你的项目中。
### 创建 Windows 项目
参考以下步骤创建一个 Windows 项目。若已有 Windows 项目，直接查看[集成 SDK](#inte)。

<details>
	<summary><font color="#3ab7f8">创建 Windows 项目</font></summary>

1. 打开 <b>Microsoft Visual Studio</b> 并点击新建项目。
2. 进入<b>新建项目</b>窗口，选择项目类型为 <b>MFC 应用程序</b>，输入项目名称，选择项目存储路径，并点击<b>确认</b>。
3. 进入<b>MFC 应用程序</b>窗口，选择应用程序类型为<b>基于对话框</b>，并点击完成。
	

</details>

<a name="inte"></a>
### 集成 SDK
参考以下步骤将 Agora 视频 SDK 集成到你的项目中。

**1. 配置项目文件**

- 根据应用场景，从 [SDK 下载](./downloads?platform=Windows)获取最新 SDK，解压并打开。

- 根据你的开发环境将下载包中的 **x86** 或 **x86_64** 文件夹复制到你的项目文件夹下。

**2. 配置项目属性**

在**解决方案资源管理器**窗口中，右击项目名称并点击属性进行以下配置，配置完成后点击**确定**。

- 进入 **C/C++ > 常规 > 附加包含目录**菜单，点击**编辑**，并在弹出窗口中输入 **$(SolutionDir)include**。

- 进入**链接器 > 常规 > 附加库目录**菜单，点击**编辑**，并在弹出窗口中输入 **$(SolutionDir)**。

- 进入**链接器 > 输入 > 附加依赖项**菜单，点击**编辑**，并在弹出窗口中输入 **agora_rtc_sdk.lib**。

## 实现音视频直播
本节介绍如何实现视频直播。视频直播的 API 使用时序见下图：

![](https://web-cdn.agora.io/docs-files/1568257965768)

### 1. 创建用户界面

为直观地体验视频通话，需根据应用场景创建用户界面（UI)。若项目中已有用户界面，直接查看[初始化 IRtcEngine](#ini)。

如果你想实现一个视频直播，推荐在 UI 上添加以下控件：
- 主播视频窗口
- 离开频道按钮

当你使用示例项目中的 UI 设计时，你将会看到如下界面：

![](https://web-cdn.agora.io/docs-files/1568792771048)

<a name="ini"></a>
### 2. 初始化 IRtcEngine

在调用其他 Agora API 前，需要创建并初始化 `IRtcEngine` 对象。

你需要在该步骤中填入项目的 App ID。请参考如下步骤在控制台[创建 Agora 项目](https://docs.agora.io/cn/Agora%20Platform/manage_projects?platform=All%20Platforms)并获取 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id )。

1. 登录[控制台](https://console.agora.io/)，点击左侧导航栏的**[项目管理](https://console.agora.io/projects)**图标 ![](https://web-cdn.agora.io/docs-files/1551254998344)。
2. 点击**创建**，按照屏幕提示设置项目名，选择一种鉴权机制，然后点击**提交**。
3. 在**项目管理**页面，你可以获取该项目的 **App ID**。

调用 `createAgoraRtcEngine` 和 `initialize` 方法，传入获取到的 App ID，即可初始化 `IRtcEngine`。

你也可以根据需求，在初始化时实现其他功能，如注册用户加入频道和离开频道的回调。

```C++
// 创建实例。
m_lpRtcEngine = createAgoraRtcEngine();
RtcEngineContext ctx;

// 添加注册回调和事件。
ctx.eventHandler = &m_engineEventHandler;

// 输入你的 App ID。
ctx.appId = "YourAppID";

// 初始化 IRtcEngine。
m_lpRtcEngine->initialize(ctx);
```

```C++
// 继承 IRtcEngineEventHandler 类中的回调与事件。
class CAGEngineEventHandler :
    public IRtcEngineEventHandler
{
public:
    CAGEngineEventHandler();
    ~CAGEngineEventHandler();
    void setMainWnd(HWND wnd);
    HWND GetMsgReceiver() {return m_hMainWnd;};

    // 注册 onJoinChannelSuccess 回调。
    // 本地用户成功加入频道时，会触发该回调。
    virtual void onJoinChannelSuccess(const char* channel, uid_t uid, int elapsed);

    // 注册 onLeaveChannel 回调。
    // 本地主播成功离开频道时，会触发该回调。
    virtual void onLeaveChannel(const RtcStats& stat);

    // 注册 onUserJoined 回调。
    // 远端主播成功加入频道时，会触发该回调。
    // 收到该回调后，需立即调用 setupRemoteVideo 设置远端主播的视图。
    virtual void onUserJoined(uid_t uid, int elapsed) override;

    // 注册 onUserOffline 回调。
    // 远端主播离开频道或掉线时，会触发该回调。
    virtual void onUserOffline(uid_t uid, USER_OFFLINE_REASON_TYPE reason);
private:
    HWND m_hMainWnd;
};
```

### 3. 设置频道场景
初始化结束后，调用 `setChannelProfile` 方法，将频道场景设为直播。

一个 IRtcEngine 只能使用一种频道场景。如果想切换为其他模式，需要先调用 `release` 方法释放当前的 IRtcEngine 实例，然后调用 `createAgoraRtcEngine` 和 `initialize` 方法创建一个新实例，再调用 `setChannelProfile` 设置新的频道场景。

```C++
// 设置频道场景为直播。
m_lpRtcEngine->setChannelProfile(CHANNEL_PROFILE_LIVE_BROADCASTING);
```

### 4. 设置用户角色
直播频道有两种用户角色：主播和观众，其中默认的角色为观众。设置频道场景为直播后，你可以在 App 中参考如下步骤设置用户角色：
- 让用户选择自己的角色是主播还是观众
- 调用 `setClientRole` 方法，然后使用用户选择的角色进行传参

注意，直播频道内的用户，只能看到主播的画面、听到主播的声音。加入频道后，如果你想切换用户角色，也可以调用 `setClientRole` 方法。

```C++
BOOL CAgoraObject::SetClientRole(CLIENT_ROLE_TYPE role, LPCSTR lpPermissionKey)
{
    // 设置用户角色。
    int nRet = m_lpAgoraEngine->setClientRole(role);
    m_nRoleType = role;
    return nRet == 0 ? TRUE : FALSE;
}
```

```C++
// 创建选择用户角色的对话框。
void CEnterChannelDlg::OnCbnSelchangeCmbRole()
{
    int nSel = m_ctrRole.GetCurSel();
    if (nSel == 0)
        CAgoraObject::GetAgoraObject()->SetClientRole(CLIENT_ROLE_BROADCASTER);
    else
        CAgoraObject::GetAgoraObject()->SetClientRole(CLIENT_ROLE_AUDIENCE);
}
```

### 5. 设置本地视图

成功初始化 `IRtcEngine` 对象后，需要在加入频道前设置本地视图，以便主播在直播中看到本地图像。参考以下步骤设置本地视图：
- 调用 `enableVideo` 方法启用视频模块。
- 调用 `setupLocalVideo` 方法设置本地视图。

```C++
// 启用视频模块。
m_lpRtcEngine->enableVideo();
 
// 设置本地视图。
VideoCanvas vc;
vc.uid = 0;
vc.view = hVideoWnd;
vc.renderMode = RENDER_MODE_TYPE::RENDER_MODE_HIDDEN;
m_lpRtcEngine->setupLocalVideo(vc);
```

<a name="join"></a>
### 6. 加入频道
完成设置角色和本地视图后，你就可以调用 `joinChannel` 方法加入频道。你需要在该方法中传入如下参数：

- `channelName`: 传入能标识频道的频道 ID。输入频道 ID 相同的用户会进入同一个频道。

* `token`：传入用于鉴权的 Token，可设为如下一个值：
   * 临时 Token。你可以在控制台里生成一个临时 Token，详见[获取临时 Token](token#get-a-temporary-token)。加入频道时，请确保填入的频道名和生成临时 Token 时填入的频道名一致。
   * 在你的服务器端生成的 Token。在安全要求高的场景下，我们推荐你使用此种方式生成的 Token，详见[从服务端生成 Token](./token_server)。加入频道时，请确保填入的频道名和 uid 与生成 Token 时填入的频道名和 uid 一致。

 <div class="alert note"><ul><li>若项目已启用 App 证书，请使用 Token。</li><li>请勿将 <code>token</code> 设为 ""。</li></div>

- `uid`: 本地用户的 ID。数据类型为整型，且频道内每个用户的 `uid` 必须是唯一的。若将 `uid` 设为 0，则 SDK 会自动分配一个 `uid`，并在 `onJoinChannelSuccess` 回调中报告。
  <div class="alert note">用户成功加入频道后，会默认订阅频道内其他所有用户的音频流和视频流，因此产生用量并影响计费。如果想取消订阅，可以通过调用相应的 <code>mute</code> 方法实现。</div>

更多的参数设置注意事项请参考 [`joinChannel`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#adc937172e59bd2695ea171553a88188c) 接口中的参数描述。

```C++
// 对于 v3.0.0 之前的 SDK，如果频道中有 Web SDK，需要调用该方法开启 Native SDK 和 Web SDK 互通。v3.0.0 及之后的 SDK 在通信和直播场景下均自动开启了与 Web SDK 的互通。
m_lpRtcEngine->enableWebSdkInteroperability(true);
 
 
// 加入频道。
BOOL CAgoraObject::JoinChannel(LPCTSTR lpChannelName, UINT nUID, LPCSTR lpDynamicKey)
{
    int nRet = 0;
    LPCSTR lpStreamInfo = "{\"owner\":true,\"width\":640,\"height\":480,\"bitrate\":500}";
#ifdef UNICODE
    CHAR szChannelName[128];
    ::WideCharToMultiByte(CP_ACP, 0, lpChannelName, -1, szChannelName, 128, NULL, NULL);
    nRet = m_lpAgoraEngine->joinChannel(lpDynamicKey, szChannelName, lpStreamInfo, nUID);
#else
    nRet = m_lpAgoraEngine->joinChannel(lpDynamicKey, lpChannelName, lpStreamInfo, nUID);
#endif
    if (nRet == 0)
        m_strChannelName = lpChannelName;
    return nRet == 0 ? TRUE : FALSE;
}
```

### 7. 设置远端视图

视频直播中，不论你是主播还是观众，都应该看到频道中的所有主播。在加入频道后，可通过调用 `setupRemoteVideo` 方法设置远端主播的视图。

远端主播成功加入频道后，SDK 会触发 `onUserJoined` 回调，该回调中会包含这个主播的 `uid` 信息。在该回调中调用 `setupRemoteVideo` 方法，传入获取到的 `uid`，设置该主播的视图。

```C++
// 远端主播成功加入频道时，会触发该回调。
// 收到该回调后，需立即调用 setupRemoteVideo 设置远端主播的视图。
void CAGEngineEventHandler::onUserJoined(uid_t uid, int elapsed)
{
	LPAGE_USER_JOINED lpData = new AGE_USER_JOINED;

	lpData->uid = uid;
	lpData->elapsed = elapsed;

	if(m_hMainWnd != NULL)
		::PostMessage(m_hMainWnd, WM_MSGID(EID_USER_JOINED), (WPARAM)lpData, 0);
}
```

```C++
VideoCanvas canvas;
canvas.renderMode = RENDER_MODE_FIT;
POSITION pos = m_listWndInfo.GetHeadPosition();
......
AGVIDEO_WNDINFO &agvWndInfo = m_listWndInfo.GetNext(pos);
canvas.uid = agvWndInfo.nUID;
canvas.view = m_wndVideo[nIndex].GetSafeHwnd();
agvWndInfo.nIndex = nIndex;

// 设置远端视图。
CAgoraObject::GetEngine()->setupRemoteVideo(canvas);
```

### 8. 离开频道
根据场景需要，如结束通话、关闭 App 或 App 切换至后台时，调用 `leaveChannel` 离开当前通话频道。

```C++
BOOL CAgoraObject::LeaveCahnnel()
{
    m_lpAgoraEngine->stopPreview();
     
    // 离开频道。
    int nRet = m_lpAgoraEngine->leaveChannel();
    m_nSelfUID = 0;
    return nRet == 0 ? TRUE : FALSE;
}
 
 
void CAgoraObject::CloseAgoraObject()
{
    if(m_lpAgoraEngine != NULL)
        // 释放 IRtcEngine 对象。
        m_lpAgoraEngine->release();
    if(m_lpAgoraObject != NULL)
        delete m_lpAgoraObject;
    m_lpAgoraEngine = NULL;
    m_lpAgoraObject = NULL;
}
```

## 运行项目
在 Windows 设备中运行该项目。当成功开始视频直播时，主播可以看到自己的画面；观众可以看到主播的画面。


## 相关链接

- [直播场景下，如何监听远端观众用户加入/离开频道的事件？](https://docs.agora.io/cn/faq/audience_event)
- [如何设置日志文件？](https://docs.agora.io/cn/faq/logfile)
- [如何处理视频黑屏问题？](https://docs.agora.io/cn/faq/video_blank)

