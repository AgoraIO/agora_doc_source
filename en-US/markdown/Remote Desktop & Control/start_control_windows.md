# Start a Remote Control

Use this guide to quickly implement the remote control feature with the Agora RDC SDK for Windows.

## Understand the tech

The following figure shows the workflow to implement a remote control:

![](https://web-cdn.agora.io/docs-files/1652409464374)

As shown in the figure, the workflow for implementing a remote control between a host side and a controlled side is as follows:

1. Set up the role for the user. The role can be either a host side or a controlled side.
2. The host and controlled sides log in to the Agora RDC service.
3. The host and controlled sides call [`joinChannel`](./api_win_control?platform=Windows#a-namejoinchannelajoinchannel) and use the same channel ID to join the same channel.
<div class="alert info">
Every user who joins the channel must have the following:   <ul><li> App ID: The unique identifier assigned to your app by the Agora service. You can generate an app ID for your project in <a href="https://console.agora.io/">Agora Console</a>.</li><li> User ID: The unique identifier of a user. You can set your own user ID.</li></ul>
</div>
4. The controlled side sends a screen sharing stream, and the host side receives the screen sharing stream.
5. The host side sends a remote control message, and the controlled side receives the remote control message and acts accordingly.

## Prerequisites

Before proceeding, ensure that your development environment meets the following requirements:

- A valid [Agora account](https://console.agora.io/).
- An Agora project with an App ID. A token is not required for this quick start guide. For details, see [Get Started with Agora](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms).
- Microsoft Visual Studio 2017 or later.
- A Windows device running Windows 7 or later with access to the internet. If your network has a firewall, follow the instructions in [Firewall Requirements](https://docs.agora.io/en/AgoraPlatform/firewall?platform=AllPlatforms).

## Create a Windows project

Skip to [Integrate the SDK](#integration) if a Windows project already exists. To create a Windows project from scratch, do the following:

1. Open **Microsoft Visual Studio**, and click **Create new project**.
2. On the **New Project** panel, choose **MFC Application** as the project type, input the project name, choose the project location, and click **OK**.
3. On the **MFC Application** panel, choose **Application type** > **Dialog based**, and click **Finish**.

## <a name="integration"></a>Integrate the Agora RDC SDK

Follow these steps to integrate the Agora RDC SDK into your project.

### Configure the project files.

1. Download the latest version of the [Agora RDC SDK for Windows](https://docs.agora.io/en/remote-control/downloads?platform=Windows) and [Agora Video SDK for Windows](https://docs.agora.io/en/Video/downloads?platform=Windows), and unzip the downloaded SDK packages.

2. Copy the **x86** or **x86_64** folder of the downloaded SDK packages to your project files according to your development environment.

### Configure the project properties.

Right-click the project name in the **Solution Explorer** window, click **Properties** to configure the following project properties, and click **OK**.

- Go to the **C/C++** > **General** > **Additional Include Directories** menu, click **Edit**, and input `$(SolutionDir)libs\agora_rdc_sdk\include;$(SolutionDir)libs\agora_rtc_sdk\include` in the pop-up window.

- Go to the **Linker** > **General** > **Additional Library Directories** menu, click **Edit**, and input `$(SolutionDir)libs\agora_rdc_sdk\$(PlatformTarget);$(SolutionDir)libs\agora_rtc_sdk\$(PlatformTarget)` in the pop-up window.

- Go to the **Linker** > **Input** > **Additional Dependencies** menu, click **Edit**, and input `agora_rtc_sdk.lib` and `agora_rdc_sdk.lib` in the pop-up window.

## Implement the remote control

This section introduces how to use the Agora RDC SDK to implement a remote control in your app step by step.

The following figure shows the API call sequence of the remote control service:

![](https://web-cdn.agora.io/docs-files/1652244656074)

1. Add the following lines to the `RDC-TestDlg.h` file in your project folder to import header files and declare variables.

```C++
#include <IAgoraRtcEngine.h> // Import the Agora RTC SDK.
#include <IAgoraRDCEngine.h> // Import the Agora RDC SDK.
 
#define DEFAULT_CHANNEL_ID "channelId" // Fill the channel ID.
#define DEFAULT_APP_ID "appId" // Fill the App ID of your project generated in Agora Console.
#define HOST_USER "rdc_host"  // Fill the user ID of the host side.
#define CONTROLLED_USER "rdc_controlled"    // Fill the user ID of the controlled side.
 
agora::rtc::IRtcEngine* g_lpEngine = nullptr; // Declare the RTC objects.
agora::rc::IRemoteControlEngine* g_lpRDCEngine = nullptr; // Declare the RDC objects.
 
 
// Declare the RTC callback class.
class CRDCTestDlg
    : public agora::rtc::IRtcEngineEventHandler
    , public agora::rc::IRemoteControlEventHandler
{
  public:
      CRDCTestDlg(CWnd* pParent = nullptr); // Declare the constructor.
 
  protected:
    // IRtcEngineEventHandler overrides.
    void onJoinChannelSuccess(const char* channel, agora::rtc::uid_t userId, int elapsed) override;
    void onError(int err, const char* msg) override;
    void onWarning(int warn, const char* msg) override;
    void onLeaveChannel(const agora::rtc::RtcStats& stats) override;
    void onUserJoined(uid_t uid, int elapsed) override;
    void onStreamMessage(uid_t uid, int streamId, const char* data, size_t length) override;
 
    // IRemoteControlEventHandler overrides.
    void onEvent(agora::rc::RDC_EVENT event, int code, const char* msg) override;
    ......
  private:
    BOOL    m_bHost;  // Whether the current user is the host side.
    CString m_szUserId; // The user ID of the current user.
};
 
// Declare the RDC callback class.
void CRDCTestDlg::onEvent(agora::rc::RDC_EVENT event, int code, const char* msg) override {
    switch(event) {
      // The callback when the login succeeds.
      case agora::rc::EVT_LOGIN:
        if (code != 0) {
          ... // The handling logics for a login failure. 
        } else {
          ... // The handling logics for a login success.
        }
        break;
       
      // The callback when the logout succeeds.
      case agora::rc::EVT_LOGOUT:
        if (code != 0) {
          // The handling logics for a logout failure. 
        } else {
          // The handling logics for a logout success.
        }
        break;
 
      // The callback when an error occurs.
      case agora::rc::EVT_ERROR:
        // TRACE("[RDC] err:%d, message:%s", code, msg);
        break;
      // The other RDC callbacks.
      ......
    }
}
```

2. Add the following lines to the `RDC-TestDlg.cpp` file in your project folder to implement the logic for both the host side and the controlled side in remote controls.

```cpp
// Implement the constructor.
CRDCTestDlg::CRDCTestDlg(CWnd* pParent /*=nullptr*/) {
  if (MessageBox(L"Whether the current user is the host side.", L"Set up the role.", MB_YESNO | MB_ICONQUESTION)) {
    m_bHost = TRUE;
  } else {
    m_bHost = FALSE;
  }
}

// Initialize the RTC SDK service, and join the channel.
int CRDCTestDlg::initAndLoginRTC() {
  // Create RtcEngine objects.
  g_lpEngine = createAgoraRtcEngine();
  // Declare the Context used for initialization.
  agora::rtc::RtcEngineContext ctx;
  ctx.appId = DEFAULT_APP_ID;
  // Declare RTC callback events.
  ctx.eventHandler = reinterpret_cast<agora::rtc::IRtcEngineEventHandler*>(this);
  //Initialize the RtcEngine engine.
  g_lpEngine->initialize(ctx);

  // The controlled side publishes the screen sharing stream.
  // The host side subscribes to the stream of the controlled side.
  if (!g_bHost) {

    g_lpEngine->setClientRole(agora::rtc::CLIENT_ROLE_BROADCASTER);
    g_lpEngine->enableAudio();
    g_lpEngine->enableVideo();

    // The controlled side shares the screen or window to the host side. For details, see Share the Screen in Interactive Live Streaming.
    g_lpEngine->startScreenCaptureByScreenRect(...);
  } else {
    g_lpEngine->setClientRole(agora::rtc::CLIENT_ROLE_AUDIENCE);
    g_lpEngine->disableAudio();
    g_lpEngine->disableVideo();
  }

  // Join a channel.
  if (g_lpEngine->joinChannel(NULL, DEFAULT_CHANNEL_ID, NULL, 0) != 0) {
      // Error: Failed to join the channel.
      return -1;
  }
  return 0;
}

// The host side displays the window handler of the controlled side.
int CRDCTestDlg::initAndLoginRDC(HWND hWnd) {
  // Create RDCEngine objects.
  g_lpRDCEngine = createRDCEngine();
  // Use the Configuration class.
  agora::rc::Configuration config;
  config.appId = DEFAULT_APP_ID;
  // Declare RDC callback events.
  config.eventHandler =
          reinterpret_cast<agora::rc::IRemoteControlEventHandler*>(this);
  // Pass the window handler to RDCEngine.
  config.hwnd = hWnd;
  // Pass the role of the user to RDCEngine.
  config.role = g_bHost ? agora::rc::HOST : agora::rc::CONTROLLED;

  if (g_lpRDCEngine->initialize(config) != 0) {
      // Error: Failed to initialize the SDK.
      return -1001;
  }

  if (g_lpRDCEngine->login(DEFAULT_USER_ID, NULL) != 0) {
      // Error: Failed to log in to the RDC service.
      return -1002;
  }

  return 0;
}

// Initialize the RDCEngine engine.
void CRDCTestDlg::onJoinChannelSuccess(const char* channel, 
                                           agora::rtc::uid_t userId, 
                                           int elapsed) {
    if (!g_lpRDCEngine) {
        initAndLoginRDC(GetSafeHwnd());
    }
}

// When the controlled side joins the channel, the RDC service starts to render its screen.
void CRDCTestDlg::onUserJoined(agora::rtc::uid_t uid, int elapsed) {

  // When the host side joins the channel, the RDC service starts to render the screen of the controlled side.
  if (m_bHost) {
    agora::rtc::VideoCanvas vc;
    vc.renderMode = agora::rtc::RENDER_MODE_FILL;
    vc.uid = uid;
    vc.view = g_hWnd;
    g_lpEngine->setupRemoteVideo(vc);
  }
}
```

## Run the project

Run the project on your Windows device. You can see the login screen when you successfully implement the remote control in your app.

## Next steps

To ensure security in your formal production environment, you must generate tokens for authentication on your app server. The Agora RDC SDK uses the message service and authentication logic in the Agora RTM service. For details, see [Authenticate with RTM tokens](./token_server_rtm?platform=All%20Platforms).
