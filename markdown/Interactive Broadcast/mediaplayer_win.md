---
title: 媒体播放器组件
platform: Windows
updatedAt: 2020-12-16 09:02:05
---
## 功能描述

媒体播放器组件（MediaPlayer Kit）是一款功能强大的播放器，支持播放本地或在线的媒体资源。通过该播放器，你可以本地播放媒体资源，或将媒体资源同步分享给 Agora 频道内的远端用户观看/收听。

### 使用须知

- 目前支持播放的媒体格式：AVI、MP4、MP3、MKV 和 FLV 格式的本地文件，HTTP、RTMP 和 RTSP 协议的在线媒体流。
- 本地播放媒体资源时，只需单独使用 MediaPlayer Kit。分享媒体资源到远端时，需同时使用 MediaPlayer Kit，Agora Native SDK 和 RtcChannelPublishPlugin 三者。其中，MediaPlayer Kit 支持本地用户使用播放器功能，Native SDK 支撑本地用户和远端用户的实时音视频直播场景，RtcChannelPublishPlugin 支持将播放的媒体流发送给 Agora 频道中远端用户。
- 分享媒体资源到远端时，播放器的画面会抢占主播摄像头采集的画面。所以，如果你希望远端用户同时看到主播和播放器的画面，则需另起一个进程来采集主播的画面。

## 准备开发环境

### 前提条件

- Microsoft Visual Studio 2015 或以上版本
- 支持 Windows 7 或以上版本的 Windows 设备

> 如果你的网络环境部署了防火墙，请根据<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">应用企业防火墙限制</a>打开相关端口。
>
> 分享媒体资源到远端时，还需有效的 Agora 账户（免费[注册](https://dashboard.agora.io)）。

### 创建项目

参考以下步骤创建一个 Windows 项目。

<details>
	<summary><font color="#3ab7f8">创建 Windows 项目</font></summary>

1. 打开 <b>Microsoft Visual Studio</b> 并点击新建项目。
2. 进入<b>新建项目</b>窗口，选择项目类型为 <b>MFC 应用程序</b>，输入项目名称，选择项目存储路径，并点击<b>确认</b>。
3. 进入<b>MFC 应用程序</b>窗口，选择应用程序类型为<b>基于对话框</b>，并点击完成。
	

</details>

### 集成 MediaPlayer Kit

#### 配置项目文件

1. 前往[下载页面](./downloads?platform=Windows)，下载最新版 MediaPlayer Kit，然后解压。
2. 将 **sdk** 文件夹复制到你的项目文件夹下。

#### 配置项目属性

在**解决方案资源管理器**窗口中，右击项目名称并点击属性进行以下配置，配置完成后点击**确定**。

- 进入 **VC++ 目录> 常规 > 包含目录**菜单，点击**编辑**，并在弹出窗口中输入 **./sdk/include**。
- 进入 **VC++ 目录> 常规 > 库目录**菜单，点击**编辑**，并在弹出窗口中输入 **./sdk/lib**。
- 进入**链接器 > 输入 > 附加依赖项**菜单，点击**编辑**，并在弹出窗口中输入 **AgoraMediaPlayer.lib** 和 **shell32.lib**。

### 集成 Native SDK

**版本要求**：2.4.0 或更高版本。

集成步骤：参考[集成 Native SDK](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_windows?platform=Windows#集成-sdk)。

### 集成 RtcChannelPublishPlugin

**版本要求**：与你使用的 Native SDK 版本系列一致。

集成步骤：

1. [下载](https://github.com/AgoraIO/Agora-Extensions/releases) MediaPlayerExtensions.zip 并解压文件。
2. 将 ./MediaPlayerExtensions/win/RtcChannelPublishHelper 文件夹拷贝到你的项目文件中。
3. 在**解决方案资源管理器**窗口中，右击项目名称并点击属性进行以下配置，配置完成后点击**确定**：
   进入 **VC++ 目录> 常规 > 包含目录**菜单，点击**编辑**，并在弹出窗口中输入 **./RtcChannelPublishPlugin/utils**。

## 实现方法

<a name="local"></a>

### 本地播放媒体资源

集成 MediaPlayer Kit 后，参考如下步骤实现本地播放功能。

**初始化媒体播放器**

1. 调用 `createAgoraMediaPlayer` 方法创建 `IMediaPlayer` 实例。
  
  > 如需同时播放不同的媒体资源，你可以创建多个实例。
  
2. 调用 `initialize` 方法初始化媒体播放器。

**设置日志**

日志文件包含媒体播放器组件运行时产生的所有日志。日志文件的默认输出地址为 `C:/Users/{user_name}/AppData/Local/Agora/{project_name}`。调用以下方法可以对日志文件进行如下设置：

- 调用 `IMediaPlayer` 类的 `setLogFile` 方法设置日志文件的输出地址。
- 调用 `IMediaPlayer` 类的 `setLogFilter` 方法设置输出日志的过滤等级。

**注册一个播放器观测器对象**

1. 实现 `IMediaPlayerObserver` 接口，并实例化 `IMediaPlayerObserver` 对象。
2. 调用 `IMediaPlayer` 类的 `registerPlayerObserver` 方法注册一个播放器的观测器对象，监听以下播放事件：
   - `onPositionChanged`，报告当前播放进度
   - `onPlayerStateChanged`，报告播放状态改变
   - `onPlayerEvent`，报告播放器事件
   - `onMetadata`，报告媒体附属信息（metadata）的接收

通过监听这些事件，你可以更好地掌握播放过程，并使用自定义格式数据（媒体附属信息）。如果播放发生异常，你可以根据这些事件排查问题。

**（可选）注册一个音频观测器对象**

1. 实现 `IAudioFrameObserver` 接口，并实例化 `IAudioFrameObserver` 对象。
2. 调用 `IMediaPlayer` 类的 `registerAudioFrameObserver` 方法注册一个音频观测器对象，监听每帧音频帧的接收事件。获取到 `AudioPcmFrame` 后你可以对音频进行录制。

**（可选）注册一个视频观测器对象**

1. 实现 `IVideoFrameObserver` 接口，并实例化 `IVideoFrameObserver` 对象。
2. 调用 `IMediaPlayer` 类的 `registerVideoFrameObserver` 方法注册一个视频观测器对象，监听每帧视频帧的接收事件。获取到 `VideoFrame` 后你可以对视频进行录制和截图。

**准备播放**

1. 调用 `IMediaPlayer` 类的 `setView` 方法设置播放器的渲染视图。

2. 调用 `IMediaPlayer` 类的 `setRenderMode` 方法设置播放器视图的渲染模式。

3. 调用 `IMediaPlayer` 类的 `open` 方法打开媒体资源。媒体资源路径可以为网络路径或本地路径，支持绝对路径和相对路径。

   > 请收到 `onPlayerStateChanged` 回调报告播放状态为 `PLAYER_STATE_OPEN_COMPLETED(2)` 后再进行下一步操作。

4. 调用 `IMediaPlayer` 类的 `play` 方法本地播放该媒体资源。

**调节播放设置**

调用 `AgoraMediaPlayerKit` 接口的其他方法，你可以实现如下播放设置：

1. 暂停/恢复播放，调节播放进度和速度，调节本地播放音量等。
2. 获取媒体资源总时长，获取播放进度，获取当前播放状态，获取该媒体资源中媒体流的个数和每个媒体流的详细信息。

**结束播放**

1. 调用 `IMediaPlayer` 类的 `stop` 方法停止播放。

2. 调用 `IMediaPlayer` 类的 `unregisterAuidoFrameObserver` 方法取消观测音频帧。

   > 如果你没有注册音频观测器，请略过此步。

3. 调用 `IMediaPlayer` 类的 `unregisterVideoFrameObserver` 方法取消观测视频帧。

   > 如果你没有注册视频观测器，请略过此步。

4. 调用 `IMediaPlayer` 类的 `unregisterPlayerObserver` 方法取消观测播放器事件。

5. 调用 `IMediaPlayer` 类的 `release` 方法释放 `IMediaPlayer` 资源。

**示例代码**

```C++

class CPlayerSimpleDemo : public CWnd, public agora::rtc::IMediaPlayerObserver {
public:
    DECLARE_MESSAGE_MAP()
    CPlayerSimpleDemo() : media_player_( nullptr )
    {
    }
 
 
    ~CPlayerSimpleDemo()
    {
        if ( media_player_ )
        {
            media_player_->Release();
            media_player_ = nullptr;
        }
    }
 
 
    // IMediaPlayerObserver
    virtual void onPlayerStateChanged( const IMediaPlayer::PLAYER_STATE state,
                       const IMediaPlayer::PLAYER_ERROR ec ) override
    {
        switch ( state )
        {
        case IMediaPlayer::PLAYER_STATE_OPEN_COMPLETE:
            media_player_->play();
            break;
        case IMediaPlayer::PLAYER_STATE_FAILED:
            media_player_->stop();
            break;
        case IMediaPlayer::PLAYER_STATE_PLAYBACKCOMPLETED:
            media_player_->stop();
            break;
        default:
            break;
        }
    }
 
 
    virtual void onPositionChanged( const int64_t position ) override
    {
    }
 
 
    virtual void onMetaData( void* data, int length ) override
    {
    }
 
 
    virtual void onPlayerEvent( const IMediaPlayer::PLAYER_EVENT event ) override
    {
    }
 
 
    afx_msg int OnCreate( LPCREATESTRUCT lpCreateStruct )
    {
        if ( CWnd::OnCreate( lpCreateStruct ) == -1 )
            return(-1);
        media_player_ = createAgoraMediaPlayer();
        if ( media_player_ )
        {
            media_player_->registerPlayerObserver( this );
            media_player_->setView( m_hWnd );
            media_player_->open( "http://tb-video.bdstatic.com/tieba-smallvideo/68_20df3a646ab5357464cd819ea987763a.mp4" );
        }
        return(0);
    }
 
 
private:
    agora::rtc::IMediaPlayer* media_player_;
};

```


### 分享媒体资源到远端

集成 MediaPlayer Kit、Agora Native SDK 和 RtcChannelPublishPlugin 后，参考如下步骤将本地用户使用播放器播放的媒体资源分享给 Agora 频道内的远端用户。

**实例化**

1. [初始化 IRtcEngine](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_windows?platform=Windows#2-初始化-irtcengine)。
2. 初始化 IMediaPlayer 和 RtcChannelPublishPlugin。
3. 调用 RtcChannelPublishPlugin 的 `attachPlayerToRtc` 方法将播放器和 Agora 频道捆绑。

**播放器完成准备工作**

参考[本地播放媒体资源](#local)，**注册播放器、音频和视频的观测器对象**，完成**准备播放**。

> 请收到 `onPlayerStateChanged` 回调报告播放状态为 `PLAYER_STATE_PLAYING (3)` 后再进行下一步操作。

**本地用户加入频道**

参考 [RTC 快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_windows?platform=Windows#3-设置频道场景)，实现本地用户以主播身份加入 Agora 直播频道：

1. 调用 `setChannelProfile` 方法设置频道场景为直播。
2. 调用 `setClientRole` 方法设置本地用户角色为主播。
3. 调用 `enableVideo` 方法开启视频模块。
4. 调用 `joinChannel` 方法使本地用户加入频道。

> 请收到 `onJoinChannelSuccess` 回调后再进行下一步操作。

**开始分享**

1. 为避免远端用户听到播放音视频的回声，请调用 `adjustPlayoutSignalVolume` 方法设置播放音量为 `0`，再调用 `IMediaPlayer` 类的 `mute(true)`。
2. 调用 `publishVideo`/`publishAudio` 方法将播放的视频/音频流分享给 Agora 频道内远端用户。
3. 调用 `adjustPublishSignalVolume` 方法调节远端播放音量。

**取消分享**

1. 调用 `unpublishVideo`/`unpublishAudio` 方法取消分享该视频/音频流。
2. 调用 `detachPlayerFromRtc` 方法将播放器和 Agora 频道解绑。

<div class="alert note">请不要略过此步直接调用 <code>leaveChannel</code> 使本地用户取消分享媒体流，否则本地用户重新加入频道时可能会出现以下问题：
	<li>之前停止分享的媒体流会自动发送给频道内远端用户。</li>
	<li>播放媒体资源时，音画不同步。</li></div>

**示例代码**

```C++
AgoraRtcChannelPublishHelper *agora_rtc_channel_publish_helper_= new AgoraRtcChannelPublishHelper()
virtual void onPlayerStateChanged( const IMediaPlayer::PLAYER_STATE state,
                   const IMediaPlayer::PLAYER_ERROR ec ) override
{
    switch ( state )
    {
    case IMediaPlayer::PLAYER_STATE_OPEN_COMPLETE:
        agora_rtc_channel_publish_helper_->attachPlayerToRtc(rtc_engine_, media_player_);
        agora_rtc_channel_publish_helper_->publishAudio();
        agora_rtc_channel_publish_helper_->publishVideo();
        break;
    case IMediaPlayer::PLAYER_STATE_FAILED:
        media_player_->stop();
        break;
    case IMediaPlayer::PLAYER_STATE_PLAYBACKCOMPLETED:
        media_player_->stop();
        break;
    default:
        break;
    }
}
```

## 注意事项

为避免播放过程中，本地用户切换语音路由后，新的语音路由无声的问题，Agora 建议你进行如下操作：
- 在本地播放媒体资源的场景下，Agora 建议本地用户不要切换语音路由为蓝牙设备。
- 在分享媒体资源到远端的场景下，Agora 建议你在切换语音路由为蓝牙设备前进行如下操作：
   1. 在 `joinChannel` 后调用 [`enumeratePlaybackDevices`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#aa13c99d575d89e7ceeeb139be723b18a) 方法获取蓝牙设备的 `deviceId`。
   2. 调用 [`setPlaybackDevice`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#a1ee23eae83165a27bcbd88d80158b4f1) 方法并传入 `deviceId`，设置通过该蓝牙设备播放。

## API 文档

详见 [API 文档](./API%20Reference/mediaplayer_cpp/index.html)