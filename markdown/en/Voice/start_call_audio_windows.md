---
title: Start a Voice Call
platform: Windows
updatedAt: 2021-01-28 10:31:58
---
Use this guide to quickly start a basic voice call with the Agora Voice SDK for Windows.

## Sample projects
We provide the open-source sample projects that implement the video call on GitHub:

- [Agora-Windows-Tutorial-1to1](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-Windows-Tutorial-1to1) 
- [Agora-Windows-GroupVideoCall](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-Windows) 

Before implementing a voice call, you can download the sample projects and refer to the source code.

## Prerequisites
- Microsoft Visual Studio 2017 or later
- A Windows device running Windows 7 or later
- A valid Agora account. ([Sign up](https://dashboard.agora.io) for free)

<div class="alert note">Open the specified ports in <a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a> if your network has a firewall.</div>

## Set up the development environment
In this section, we will create a Windows project and integrate the SDK into the project.

### Create a Windows project
Now, let's build a Windows project from scratch. Skip to [Integrate the SDK](#inte) if a Windows project already exists.

<details>
	<summary><font color="#3ab7f8">Create a Windows project</font></summary>

1. Open <b>Microsoft Visual Studio</b> and click <b>Create new project</b>.
2. On the <b>New Project</b> panel, choose <b>MFC Application</b> as the project type, input the project name, choose the project location, and click <b>OK</b>.
3. On the <b>MFC Application</b> panel, choose <b>Application type > Dialog based</b>, and click <b>Finish</b>.
	

</details>

<a name="inte"></a>
### Integrate the SDK
Follow these steps to integrate the Agora Voice SDK into your project.

**1. Configure the project files**

- Go to [SDK Downloads](https://docs.agora.io/en/Agora%20Platform/downloads), download the latest version of the Agora SDK for Windows, and unzip the downloaded SDK package.
- Copy the **sdk** folder of the downloaded SDK package to your project files.

**2. Configure the project properties**

Right-click the project name in the **Solution Explorer** window, click **Properties** to configure the following project properties, and click **OK**.

- Go to the **C/C++ > General > Additional Include Directories** menu, click **Edit**, and input **$(SolutionDir)include** in the pop-up window.
- Go to the **Linker > General > Additional Library Directories** menu, click **Edit**, and input **$(SolutionDir)** in the pop-up window.
- Go to the **Linker > Input > Additional Dependencies** menu, click **Edit**, and input **agora_rtc_sdk.lib** in the pop-up window.

## Implement the basic call
This section introduces how to use the Agora SDK to make a voice call. The following figure shows the API call sequence of a basic one-to-one voice call.

![](https://web-cdn.agora.io/docs-files/1585289374686)

### 1. Create the UI

Create the user interface (UI) for the one-to-one voice call in your project. Skip to [Initialize IRtcEngine](#ini) if you already have a UI in your project.

If you are implementing a voice call, we recommend adding the  elements into the UI:
- The end-call button

When you use the UI setting of the demo project, you can see the following interface:

![](https://web-cdn.agora.io/docs-files/1585289388263)

<a name="ini"></a>
### 2. Initialize IRtcEngine
Create and initialize the IRtcEngine object before calling any other Agora APIs.

In this step, you need to use the App ID of your project. Follow these steps to [create an Agora project](https://docs.agora.io/en/Agora%20Platform/manage_projects?platform=All%20Platforms) in Console and get an [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id ).

1. Go to [Console](https://dashboard.agora.io/) and click the **[Project Management](https://dashboard.agora.io/projects)** icon ![](https://web-cdn.agora.io/docs-files/1551254998344) on the left navigation panel. 
2. Click **Create** and follow the on-screen instructions to set the project name, choose an authentication mechanism, and Click **Submit**. 
3. On the **Project Management** page, find the **App ID** of your project. 

Call the `createAgoraRtcEngine` method and the `initialize` method, and pass in the App ID to initialize the IRtcEngine object.

You can also listen for callback events, such as when the local user joins the channel, and when the local user leaves the channel.

```C++
CAgoraObject *CAgoraObject::GetAgoraObject(LPCTSTR lpAppId)
{
    if (m_lpAgoraObject == NULL)
        m_lpAgoraObject = new CAgoraObject();
    if (m_lpAgoraEngine == NULL)
        // Create the instance.
        m_lpAgoraEngine = (IRtcEngine *)createAgoraRtcEngine();
    if (lpAppId == NULL)
        return m_lpAgoraObject;
    RtcEngineContext ctx;
    ctx.eventHandler = &m_EngineEventHandler;
#ifdef UNICODE
    char szAppId[128];
    ::WideCharToMultiByte(CP_ACP, 0, lpAppId, -1, szAppId, 128, NULL, NULL);
    // Input your App ID.
    ctx.appId = szAppId;
#else
    ctx.appId = lpAppId;
#endif
    // Initialize the RtcEngine object.
    m_lpAgoraEngine->initialize(ctx);
    return m_lpAgoraObject;
}
```

```C++
// Inherit the events and callbacks of IRtcEngineEventHandler.
class CAGEngineEventHandler :
    public IRtcEngineEventHandler
{
public:
    CAGEngineEventHandler(void);
    ~CAGEngineEventHandler(void);
    void SetMsgReceiver(HWND hWnd = NULL);
    HWND GetMsgReceiver() {return m_hMainWnd;};
  
    // Listen for the onJoinChannelSuccess callback.
    // This callback occurs when the local user successfully joins the channel.
    virtual void onJoinChannelSuccess(const char* channel, uid_t uid, int elapsed);
  
 
    // Listen for the onLeaveChannel callback.
    // This callback occurs when the local user successfully leaves the channel.
    virtual void onLeaveChannel(const RtcStats& stat);
  
  
    // Listen for the onUserOffline callback.
    // This callback occurs when the remote user leaves the channel or drops offline.
    virtual void onUserOffline(uid_t uid, USER_OFFLINE_REASON_TYPE reason);
private:
    HWND        m_hMainWnd;
};
```

### 3. Join a channel
After initializing the `IRtcEngine` object, you can call the `joinChannel` method to join a channel. In this method, set the following parameters:

- `channelName`: Specify the channel name that you want to join.

* `token`: Pass a token that identifies the role and privilege of the user.  You can set it as one of the following values:
  * A temporary token generated in Console. A temporary token is valid for 24 hours. For details, see [Get a Temporary Token](token#get-a-temporary-token). When joining a channel, ensure that the channel name is the same with the one you use to generate the temporary token.
  * A token generated at the server. This applies to scenarios with high-security requirements. For details, see [Generate a token from Your Server](./token_server). When joining a channel, ensure that the channel name and `uid` is the same with those you use to generate the token.
  
 <div class="alert note"><ul><li>If your project has enabled the app certificate, ensure that you provide a token.</li><li>Ensure that you do not set <code>token</code> as "".</li></div>

- `uid`: ID of the local user that is an integer and should be unique. If you set `uid` as 0,  the SDK assigns a user ID for the local user and returns it in the `onJoinChannelSuccess` callback.

For more details on the parameter settings, see [joinChannel](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#adc937172e59bd2695ea171553a88188c).

```C++
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
        // Join a channel with a token.
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

### 4. Leave the channel
Call the `leaveChannel` method to leave the current call according to your scenario, for example, when the call ends, when you need to close the app, or when your app runs in the background.

```C++
BOOL CAgoraObject::LeaveChannel()
{
    m_lpAgoraEngine->stopPreview();
    // Leave the current channel.
    int nRet = m_lpAgoraEngine->leaveChannel();
    return nRet == 0 ? TRUE : FALSE;
}
 
 
void CAgoraObject::CloseAgoraObject()
{
    if(m_lpAgoraEngine != NULL)
        // Release the IRtcEngine object.
        m_lpAgoraEngine->release();
    if(m_lpAgoraObject != NULL)
        delete m_lpAgoraObject;
    m_lpAgoraEngine = NULL;
    m_lpAgoraObject = NULL;
}
```

## Run the project
Run the project on your Windows device. You can hear the remote user when you successfully start a one-to-one voice call in your app.