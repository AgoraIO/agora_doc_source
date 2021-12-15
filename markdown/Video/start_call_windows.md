---
title: 实现视频通话
platform: Windows
updatedAt: 2021-04-01 07:56:07
---

本文介绍如何使用 Agora 视频 SDK 快速实现视频通话。

## 示例项目

Agora 在 GitHub 上提供开源的实时视频通话示例项目 [Agora-Windows-Tutorial-1to1](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-Windows-Tutorial-1to1) 和 [GroupVideoCall-Windows-MFC](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-Windows-MFC)。在实现相关功能前，你可以下载并查看源代码。

如果你是第一次使用声网的服务，我们推荐观看下面的视频，了解关于声网服务的基本信息以及如何快速跑通示例项目。

<video src="https://web-cdn.agora.io/docs-files/1594372280348" poster="https://web-cdn.agora.io/docs-files/1597911296425"   controls width = 100% height = auto>你的浏览器不支持 <code>video</code> 标签。</video>

<div class="alert note">视频中展示的 UI 可能有部分调整更新，请以当前最新版为准。</div>

## 前提条件

- Microsoft Visual Studio 2017 或以上版本
- Windows 7 或以上版本的设备
- 有效的 Agora 账户（免费[注册](https://dashboard.agora.io)）

<div class="alert note">如果你的网络环境部署了防火墙，请根据<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">应用企业防火墙限制</a>打开相关端口。</div>

## 设置开发环境

本节介绍如何创建项目，并将 Agora 视频 SDK 集成至你的项目中。

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

## 实现视频通话

本节介绍如何实现视频通话。视频通话的 API 调用时序见下图：

![](https://web-cdn.agora.io/docs-files/1568257788359)

### 1. 创建用户界面

根据场景需要，为你的项目创建视频通话的用户界面。若已有用户界面，可以直接查看[初始化 IRtcEngine](#ini)。

如果你想实现一个视频通话，我们推荐你添加如下 UI 元素：

- 本地视频窗口
- 远端视频窗口
- 结束通话按钮

当你使用示例项目中的 UI 设计时，你将会看到如下界面：

![](https://web-cdn.agora.io/docs-files/1568792590013)

<a name="ini"></a>

### 2. 初始化 IRtcEngine

在调用其他 Agora API 前，需要创建并初始化 IRtcEngine 对象。

你需要在该步骤中填入项目的 App ID。请参考如下步骤在控制台[创建 Agora 项目](https://docs.agora.io/cn/Agora%20Platform/manage_projects?platform=All%20Platforms)并获取 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id)。

1. 登录[控制台](https://console.agora.io/)，点击左侧导航栏的**[项目管理](https://console.agora.io/projects)**图标 ![](https://web-cdn.agora.io/docs-files/1551254998344)。
2. 点击**创建**，按照屏幕提示设置项目名，选择一种鉴权机制，然后点击**提交**。
3. 在**项目管理**页面，你可以获取该项目的 **App ID**。

调用 `createAgoraRtcEngine` 和 `initialize` 方法，传入获取到的 App ID，即可初始化 `IRtcEngine`。

你还可以根据场景需要，在初始化时注册想要监听的回调事件，如注册用户加入频道和离开频道的回调。

```C++
CAgoraObject *CAgoraObject::GetAgoraObject(LPCTSTR lpAppId)
{
    if (m_lpAgoraObject == NULL)
        m_lpAgoraObject = new CAgoraObject();
    if (m_lpAgoraEngine == NULL)

        // 创建实例。
        m_lpAgoraEngine = (IRtcEngine *)createAgoraRtcEngine();
    if (lpAppId == NULL)
        return m_lpAgoraObject;
    RtcEngineContext ctx;

    // 添加注册回调和事件。
    ctx.eventHandler = &m_EngineEventHandler;
#ifdef UNICODE
    char szAppId[128];
    ::WideCharToMultiByte(CP_ACP, 0, lpAppId, -1, szAppId, 128, NULL, NULL);

    // 输入你的 App ID。
    ctx.appId = szAppId;
#else
    ctx.appId = lpAppId;
#endif

    // 初始化 IRtcEngine。
    m_lpAgoraEngine->initialize(ctx);
    return m_lpAgoraObject;
}
```

```C++
// 继承 IRtcEngineEventHandler 类中的回调与事件。
class CAGEngineEventHandler :
    public IRtcEngineEventHandler
{
public:
    CAGEngineEventHandler(void);
    ~CAGEngineEventHandler(void);
    void SetMsgReceiver(HWND hWnd = NULL);
    HWND GetMsgReceiver() {return m_hMainWnd;};

    // 注册 onJoinChannelSuccess 回调。
    // 本地用户成功加入频道时，会触发该回调。
    virtual void onJoinChannelSuccess(const char* channel, uid_t uid, int elapsed);

    // 注册 onLeaveChannel 回调。
    // 本地用户成功离开频道时，会触发该回调。
    virtual void onLeaveChannel(const RtcStats& stat);

    // 注册 onUserJoined 回调。
    // 远端用户成功加入频道时，会触发该回调。
    // 收到该回调后，需立即调用 setupRemoteVideo 设置远端用户的视图。
    virtual void onUserJoined(uid_t uid, int elapsed) override;

    // 注册 onUserOffline 回调。
    // 远端用户离开频道或掉线时，会触发该回调。
    virtual void onUserOffline(uid_t uid, USER_OFFLINE_REASON_TYPE reason);
private:
    HWND        m_hMainWnd;
};
```

### 3. 设置本地视图

成功初始化 IRtcEngine 对象后，需要在加入频道前设置本地视图，以便在通话中看到本地图像。参考以下步骤设置本地视图：

- 调用 `enableVideo` 方法启用视频模块。
- 调用 `setupLocalVideo` 方法设置本地视图。

```C++
// 启用视频模块。
m_lpAgoraObject->GetEngine()->enableVideo();

// 设置本地视图。
VideoCanvas vc;
vc.uid = 0;
vc.view = m_wndLocal.GetSafeHwnd();
vc.renderMode = RENDER_MODE_FIT;
m_lpAgoraObject->GetEngine()->setupLocalVideo(vc);
```

<a name="join"></a>

### 4. 加入频道

完成初始化和设置本地视图后，你就可以调用 `joinChannel` 方法加入频道。你需要在该方法中传入如下参数：

- `channelName`: 传入能标识频道的频道 ID。输入频道 ID 相同的用户会进入同一个频道。

* `token`：传入用于鉴权的 Token，可设为如下一个值：
  - 临时 Token。你可以在控制台里生成一个临时 Token，详见[获取临时 Token](token#get-a-temporary-token)。加入频道时，请确保填入的频道名和生成临时 Token 时填入的频道名一致。
  - 在你的服务器端生成的 Token。在安全要求高的场景下，我们推荐你使用此种方式生成的 Token，详见[从服务端生成 Token](./token_server)。加入频道时，请确保填入的频道名和 uid 与生成 Token 时填入的频道名和 uid 一致。

 <div class="alert note"><ul><li>若项目已启用 App 证书，请使用 Token。</li><li>请勿将 <code>token</code> 设为 ""。</li></div>

- `uid`: 本地用户的 ID。数据类型为整型，且频道内每个用户的 `uid` 必须是唯一的。若将 `uid` 设为 0，则 SDK 会自动分配一个 `uid`，并在 `onJoinChannelSuccess` 回调中报告。
  <div class="alert note">用户成功加入频道后，会默认订阅频道内其他所有用户的音频流和视频流，因此产生用量并影响计费。如果想取消订阅，可以通过调用相应的 <code>mute</code> 方法实现。</div>

更多的参数设置注意事项请参考 [`joinChannel`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#adc937172e59bd2695ea171553a88188c) 接口中的参数描述。

```C++
// 加入频道。
BOOL CAgoraObject::JoinChannel(LPCTSTR lpChannelName, UINT nUID,LPCTSTR lpToken)
{
    int nRet = 0;
#ifdef UNICODE
    CHAR szChannelName[128];
    ::WideCharToMultiByte(CP_UTF8, 0, lpChannelName, -1, szChannelName, 128, NULL, NULL);
    char szToken[128];
    ::WideCharToMultiByte(CP_UTF8, 0, lpToken, -1, szToken, 128, NULL, NULL);
    if(0 == _tcslen(lpToken))
        nRet = m_lpAgoraEngine->joinChannel(NULL, szChannelName, NULL, nUID);
    else
        nRet = m_lpAgoraEngine->joinChannel(szToken, szChannelName, NULL, nUID);
#else
    if(0 == _tcslen(lpToken))
        nRet = m_lpAgoraEngine->joinChannel(NULL, lpChannelName, NULL, nUID);
    else
        nRet = m_lpAgoraEngine->joinChannel(lpToken, lpChannelName, NULL, nUID);
#endif
    if (nRet == 0)
        m_strChannelName = lpChannelName;
    return nRet == 0 ? TRUE : FALSE;
}
```

### 5. 设置远端视图

视频通话中，通常你也需要看到其他用户。在加入频道后，可通过调用`setupRemoteVideo` 方法设置远端用户的视图。

远端用户成功加入频道后，SDK 会触发 `onUserJoined` 回调，该回调中会包含这个远端用户的 `uid` 信息。在该回调中调用 `setupRemoteVideo` 方法，传入获取到的 `uid`，设置远端用户的视图。

```C++
// 远端用户成功加入频道时，会触发该回调。
// 收到该回调后，需立即调用 setupRemoteVideo 设置远端用户的视图。
LRESULT CAgoraTutorialDlg::OnEIDUserJoined(WPARAM wParam, LPARAM lParam)
{
	LPAGE_USER_JOINED lpData = (LPAGE_USER_JOINED)wParam;
	VideoCanvas vc;
	vc.renderMode = RENDER_MODE_FIT;
	vc.uid = lpData->uid;
	vc.view = m_wndRemote.GetSafeHwnd();
    // 设置远端视图。
	m_lpAgoraObject->GetEngine()->setupRemoteVideo(vc);
	delete lpData;
	return 0;
}
```

### 6. 离开频道

根据场景需要，如结束通话、关闭 App 或 App 切换至后台时，调用 `leaveChannel` 离开当前通话频道。

```C++
BOOL CAgoraObject::LeaveChannel()
{
    m_lpAgoraEngine->stopPreview();
    // 离开频道。
    int nRet = m_lpAgoraEngine->leaveChannel();
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

你可以在 Windows 设备中运行此项目。当你成功开始视频通话时，你可以同时看到本地和远端的视频。

## 相关链接

- [如何设置日志文件？](https://docs.agora.io/cn/faq/logfile)
- [如何处理视频黑屏问题？](https://docs.agora.io/cn/faq/video_blank)
- [如何在通话应用中实现呼叫邀请通知功能？](./faq/call_invite_notification)
