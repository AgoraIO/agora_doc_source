---
title: Share the Screen
platform: Windows
updatedAt: 2021-01-12 08:50:14
---
## Introduction

During a video call or interactive streaming, sharing the screen enhances communication by displaying the speaker's screen on the display of other speakers or audience members in the channel.

Screen sharing is applied in the following scenarios:

- In a video conference, the speaker can share an image of a local file, web page, or presentation with other users in the channel.
- In an online class, the teacher can share the slides or notes with students.

## Implementation

Ensure that you implement a video call or interactive streaming in your project. For details, see [Start a Video Call](./start_call_windows) or [Start Interactive Video Streaming](./start_live_windows).

From v2.4.0, Agora supports the following screen sharing functions on Windows:

- Shares the whole or part of a screen by specifying `screenRect`.
- Shares the whole or part of a window by specifying `windowId`.

### Share the whole or part of a screen by specifying screenRect

Windows lays all its screen displays on a virtual screen. You need the following parameters to share a screen:

- The Rectangle coordinate of the display screen on the virtual screen. See [Virtual Screen](https://docs.microsoft.com/en-us/windows/win32/gdi/the-virtual-screen).
- (Optional) The Rectangle coordinate of the area to share on the display screen. See [Rectangles](https://docs.microsoft.com/en-us/windows/win32/gdi/about-rectangles).

Take the following steps to share a screen by specifying screenRect:

1. Get a list of monitor display information. 

```cpp
// Get a list of monitor display information
void CAgoraScreenCapture::InitMonitorInfos()
{
    // m_monitors is an instance of CMonitors. Refer to the sample project for the implementation of the CMonitors class
    // m_monitors calls EnumMonitor to get a list of monitor information
    m_monitors.EnumMonitor();
    // Define the infos vector to store the list
    std::vector<CMonitors::MonitorInformation>  infos = m_monitors.GetMonitors();
    CString str = _T("");
    // Get the Rectangle coordinates of each display screen on the virtual screen
    for (size_t i = 0; i < infos.size(); i++) {
        RECT rcMonitor = infos[i].monitorInfo.rcMonitor;
        CString strInfo;
        strInfo.Format(_T("Screen%d: rect = {%d, %d, %d, %d} ")
            , i + 1, rcMonitor.left, rcMonitor.top, rcMonitor.right, rcMonitor.bottom);
        }
        str += strInfo;
        m_cmbScreenRegion.InsertString(i, utf82cs(infos[i].monitorName));
    }
  
    m_cmbScreenRegion.InsertString(infos.size(), _T("Select Window Hwnd Rect Area"));
    m_staScreenInfo.SetWindowText(str);
    m_cmbScreenRegion.SetCurSel(0);
}
```

<div class="alert info">The <code>EnumMonitor</code> method in the sample code calls <a href="https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-enumdisplaymonitors">EnumDisplayMonitors</a> to list monitor information. See the <a href="https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample">demo</a> project for the implementation of <code>EnumMonitor</code>.</div>

2. Share the screen by the Rectangle coordinates of the display screen to share on the virtual screen and that of the area to share on the display screen.

```cpp
void CAgoraScreenCapture::OnBnClickedButtonStartShareScreen()
{
    m_screenShare = !m_screenShare;
    if (m_screenShare) {
        // Get the selected display screen
        int sel = m_cmbScreenRegion.GetCurSel();
        agora::rtc::Rectangle regionRect = { 0,0,0,0 }, screenRegion = {0,0,0,0};
  
        // Get the Rectangle coordinate of the area to share on the display screen. 
        // See the sample project for the detailed implementation of GetMonitorRectangle
        regionRect = m_monitors.GetMonitorRectangle(sel);
        // Get the Rectangle coordinate of the display screen on the virtual screen. 
        // See the sample project for the implementation of GetScreenRect
        screenRegion = m_monitors.GetScreenRect();
         
        m_monitors.GetScreenRect();
        // Set the encoding configurations for screen sharing
        ScreenCaptureParameters capParam;
        // Start screen sharing
        m_rtcEngine->startScreenCaptureByScreenRect(screenRegion, regionRect, capParam);
        m_btnShareScreen.SetWindowText(screenShareCtrlStopShare);
  
        m_btnStartCap.EnableWindow(FALSE);
         
    }
    else {
        // Stop screen sharing
        m_rtcEngine->stopScreenCapture();
        m_btnShareScreen.SetWindowText(screenShareCtrlShareSCreen);
        m_btnStartCap.EnableWindow(TRUE);
    }
}
```

### Share the whole or part of a window by specifying windowId

Windows assigns a unique window identifier (windowId) for each window with a data type of HWND. To achieve compatibility with the x86 and x64 operating systems, it is in the format of view_t. With this window ID, we can implement window sharing on Windows with the following steps:

1. Get a list of IDs of all top-level windows.

```cpp
// Get the HWND of all top-level windows and store them in m_listWnd
int  CAgoraScreenCapture::RefreshWndInfo()
{
    m_listWnd.RemoveAll();
    ::EnumWindows(&CAgoraScreenCapture::WndEnumProc, (LPARAM)&m_listWnd);
    return static_cast<int>(m_listWnd.GetCount());
}
```

<div class="alert info">The sample code calls <a href="https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-enumwindows">EnumWindows</a>, a Windows native API, to list Window IDs.</div>

2. Share the window by specifying the window ID.

```cpp
void CAgoraScreenCapture::OnBnClickedButtonStartShare()
{
    if (!m_rtcEngine || !m_initialize)
        return;
    HWND hWnd = NULL;
  
    // ID of the window to share
    hWnd = m_listWnd.GetAt(m_listWnd.FindIndex(m_cmbScreenCap.GetCurSel()));
    int ret = 0;
    m_windowShare = !m_windowShare;
    if (m_windowShare)
    {
        // Set captureParameters, which includes encoding parameters for screen sharing
        ScreenCaptureParameters capParam;
        GetCaptureParameterFromCtrl(capParam);
        // Set regionRect, which is the Rectangle coordinate of the area to share on the display window
        CRect rcWnd = { 0 };
        ::GetClientRect(hWnd, &rcWnd);
        agora::rtc::Rectangle rcCapWnd = { rcWnd.left, rcWnd.top, rcWnd.right - rcWnd.left, rcWnd.bottom - rcWnd.top };
  
        // Start screen sharing
        ret = m_rtcEngine->startScreenCaptureByWindowId(hWnd, rcCapWnd, capParam);
  
  
        if (ret == 0)
            m_lstInfo.InsertString(m_lstInfo.GetCount(), _T("Succees!"));
        else
            m_lstInfo.InsertString(m_lstInfo.GetCount(), _T("Failed!"));
  
        m_btnStartCap.SetWindowText(screenShareCtrlEndCap);
  
        m_btnShareScreen.EnableWindow(FALSE);
  
    }
    else {
        // Stop screen sharing
        ret = m_rtcEngine->stopScreenCapture();
        if (ret == 0)
            m_lstInfo.InsertString(m_lstInfo.GetCount(), _T("Success!"));
        else
            m_lstInfo.InsertString(m_lstInfo.GetCount(), _T("Failed!"));
        m_btnStartCap.SetWindowText(screenShareCtrlStartCap);
        m_btnShareScreen.EnableWindow(TRUE);
    }
}
```


### API Reference

* [`startScreenCaptureByWindowId`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#add5ba807256e8e4469a512be14e10e52)
* [`startScreenCaptureByScreenRect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a41893fe9a0ca49c054bf6dbd7d9d68f5)
* [`updateScreenCaptureParameters`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ad680e114ba3b8a0012454af6867c7498)
* [`setScreenCaptureContentHint`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#aff9003c492450dbd8c3f3b9835186c95)
* [`updateScreenCaptureRegion`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ae2ab9c3ff28b64c601f938ab45644586)
* [`stopScreenCapture`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a77412ab7c8653289a28212e60bd00673)


## Sample project

Refer to the [sample project](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample) on GitHub to learn how to share the screen with the Agora SDK.


## Enable both screen sharing and video

We provide an open-source [Agora-Screen-Sharing-Windows](https://github.com/AgoraIO/Advanced-Video/tree/master/Windows/Agora-Screen-Sharing-Windows) demo project on GitHub that implements screen sharing and publishing the local video stream. You can download it and refer to the source code.

## Considerations
- v2.4.0 deprecates the `startScreenCapture` method. You can still use it, but we no longer recommend it.
- Changing `AgoraScreenCaptureParameters` may affect your communication chargers. As of v2.4.1, if you set the `dimendions` parameter as default, Agora uses 1920 x 1080 to calculate the charges.
- Sharing the window of a QQ chat on Windows causes the black screen of the shared window.