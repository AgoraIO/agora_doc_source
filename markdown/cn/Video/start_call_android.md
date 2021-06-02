---
title: 实现视频通话
platform: Android
updatedAt: 2021-03-26 06:47:53
---
本文介绍如何使用 Agora SDK 快速实现音视频通话。

## Demo 体验

Agora 在 GitHub 上提供一个开源的实时音视频通话示例项目 [Agora-Android-Tutorial-1to1](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-Android-Tutorial-1to1)。在实现相关功能前，你可以下载并查看源代码。

<video src="https://web-cdn.agora.io/docs-files/1582781500734" poster="https://web-cdn.agora.io/docs-files/1582785135607"  controlslist="nodownload" width = 100% height = auto></video>

## 前提条件

* Android Studio 3.0 或以上版本
* Android SDK API 等级 16 或以上
* 支持 Android 4.1 或以上版本的移动设备
* 有效的 Agora 账户（免费[注册](https://dashboard.agora.io/)）

<div class="alert note">如果你的网络环境部署了防火墙，请根据<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">应用企业防火墙限制</a>打开相关端口。</div>

## 准备开发环境

本节介绍如何创建项目，将 Agora 视频通话 SDK 集成进你的项目中，并添加相应的设备权限。

### 创建 Android 项目

参考以下步骤创建一个 Android 项目。若已有 Android 项目，可以直接查看[集成 SDK](#integrate_sdk)。

<details>
	<summary><font color="#3ab7f8">创建 Android 项目</font></summary>

1. 打开 <b>Android Studio</b>，点击 <b>Start a new Android Studio project</b>。
2. 在 <b>Choose your project</b> 界面，选择 <b>Phone and Tablet</b> > <b>Empty Activity</b>，然后点击 <b>Next</b>。
3. 在 <b>Configure your project</b> 界面，依次填入以下内容：
	* <b>Name</b>：你的 Android 项目名称，如 HelloAgora
	* <b>Package name</b>：你的项目包的名称，如 io.agora.helloagora
	* <b>Project location</b>：项目的存储路径
	* <b>Language</b>：项目的编程语言，如 Java
	* <b>Minimum API level</b>：项目的最低 API 等级

然后点击 <b>Finish</b>。根据屏幕提示，安装可能需要的插件。
</details>

<a name="integrate_sdk"></a>
### 集成 SDK

选择如下任意一种方式将 Agora 视频通话 SDK 集成到你的项目中。

**方法一：使用 JCenter 自动集成**

在项目的 **/app/build.gradle** 文件中，添加如下行：

```
...
dependencies {
    ...
    // 其中 2.9.4 是最新的 Agora 视频通话 SDK 的版本号。你也可以填写其他版本
    implementation 'io.agora.rtc:full-sdk:2.9.4'
}
```

**方法二：手动复制 SDK 文件**

1. 前往 [SDK 下载](https://docs.agora.io/cn/Agora%20Platform/downloads)页面，获取最新版的 Agora 视频通话 SDK，然后解压。
2. 将 SDK 包内 libs 路径下的如下文件，拷贝到你的项目路径下：


| 文件或文件夹                   | 项目路径                               | 
| ---------------------------- | ------------------------------------ | 
| **agora-rtc-sdk.jar** 文件    | **/app/libs/**                       | 
| **arm-v8a** 文件夹            | **/app/src/main/jniLibs/**           | 
| **armeabi-v7a** 文件夹        | **/app/src/main/jniLibs/**           | 
| **x86** 文件夹                | **/app/src/main/jniLibs/**           | 
| **x86_64** 文件夹             | **/app/src/main/jniLibs/**           | 

### 添加项目权限

根据场景需要，在  **/app/src/main/AndroidManifest.xml** 文件中添加如下行，获取相应的设备权限：

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
   package="io.agora.tutorials1v1acall">
 
   <uses-permission android:name="android.permission.READ_PHONE_STATE" />   
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.RECORD_AUDIO" />
   <uses-permission android:name="android.permission.CAMERA" />
   <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
   <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
   <uses-permission android:name="android.permission.BLUETOOTH" />
   <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
   // 如果你的场景中涉及读取外部存储，需添加如下权限：
   <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
   // 如果你使用的是 Android 10.0 及以上设备，还需要添加如下权限：
   <uses-permission android:name="android.permission.READ_PRIVILEGED_PHONE_STATE" />
 
...
</manifest>
```


如果你的 `targetSdkVersion` &ge; 29，还需要在 **AndroidManifest.xml** 文件的 `<application>` 区域添加如下行：

```xml
   <application
      android:requestLegacyExternalStorage="true">
	  ...
   </application>
```

### 防止代码混淆

在 **app/proguard-rules.pro** 文件中添加如下行，防止代码混淆：

```xml
-keep class io.agora.**{*;}
```

## 实现音视频通话

本节介绍如何实现音视频通话。视频通话的 API 调用时序见下图：

![](https://web-cdn.agora.io/docs-files/1568254412236)

### 1. 创建用户界面

根据场景需要，为你的项目创建音视频通话的用户界面。若已有界面，可以直接查看[导入类](#import_class)。

如果你想实现一个视频通话，我们推荐你添加如下 UI 元素：

* 本地视频窗口
* 远端视频窗口
* 结束通话按钮

你也可以参考 [Agora-Android-Tutorial-1to1](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-Android-Tutorial-1to1) 示例项目的  [activity_video_chat_view.xml](https://github.com/AgoraIO/Basic-Video-Call/blob/master/One-to-One-Video/Agora-Android-Tutorial-1to1/app/src/main/res/layout/activity_video_chat_view.xml) 文件中的代码。

<details>
	<summary><font color="#3ab7f8">创建 UI 示例</font></summary>

```java
<?xml version="1.0" encoding="UTF-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/activity_video_chat_view"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context="io.agora.tutorials1v1vcall.VideoChatViewActivity">
 
    <RelativeLayout
        android:id="@+id/remote_video_view_container"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:background="@color/remoteBackground">
        <RelativeLayout
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:layout_above="@id/icon_padding">
            <ImageView
                android:layout_width="@dimen/remote_back_icon_size"
                android:layout_height="@dimen/remote_back_icon_size"
                android:layout_centerInParent="true"
                android:src="@drawable/icon_agora_largest"/>
        </RelativeLayout>
        <RelativeLayout
            android:id="@+id/icon_padding"
            android:layout_width="match_parent"
            android:layout_height="@dimen/remote_back_icon_margin_bottom"
            android:layout_alignParentBottom="true"/>
    </RelativeLayout>
 
    <FrameLayout
        android:id="@+id/local_video_view_container"
        android:layout_width="@dimen/local_preview_width"
        android:layout_height="@dimen/local_preview_height"
        android:layout_alignParentEnd="true"
        android:layout_alignParentRight="true"
        android:layout_alignParentTop="true"
        android:layout_marginEnd="@dimen/local_preview_margin_right"
        android:layout_marginRight="@dimen/local_preview_margin_right"
        android:layout_marginTop="@dimen/local_preview_margin_top"
        android:background="@color/localBackground">
 
        <ImageView
            android:layout_width="@dimen/local_back_icon_size"
            android:layout_height="@dimen/local_back_icon_size"
            android:layout_gravity="center"
            android:scaleType="centerCrop"
            android:src="@drawable/icon_agora_large" />
    </FrameLayout>
 
    <RelativeLayout
        android:id="@+id/control_panel"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_alignParentBottom="true"
        android:layout_marginBottom="@dimen/control_bottom_margin">
 
        <ImageView
            android:id="@+id/btn_call"
            android:layout_width="@dimen/call_button_size"
            android:layout_height="@dimen/call_button_size"
            android:layout_centerInParent="true"
            android:onClick="onCallClicked"
            android:src="@drawable/btn_endcall"
            android:scaleType="centerCrop"/>
 
        <ImageView
            android:id="@+id/btn_switch_camera"
            android:layout_width="@dimen/other_button_size"
            android:layout_height="@dimen/other_button_size"
            android:layout_toRightOf="@id/btn_call"
            android:layout_toEndOf="@id/btn_call"
            android:layout_marginLeft="@dimen/control_bottom_horizontal_margin"
            android:layout_centerVertical="true"
            android:onClick="onSwitchCameraClicked"
            android:src="@drawable/btn_switch_camera"
            android:scaleType="centerCrop"/>
 
        <ImageView
            android:id="@+id/btn_mute"
            android:layout_width="@dimen/other_button_size"
            android:layout_height="@dimen/other_button_size"
            android:layout_toLeftOf="@id/btn_call"
            android:layout_toStartOf="@id/btn_call"
            android:layout_marginRight="@dimen/control_bottom_horizontal_margin"
            android:layout_centerVertical="true"
            android:onClick="onLocalAudioMuteClicked"
            android:src="@drawable/btn_unmute"
            android:scaleType="centerCrop"/>
    </RelativeLayout>
 
</RelativeLayout>
```
</details>

<a name="import_class"></a>
### 2. 导入类
		
在项目的 Activity 文件中添加如下行：

```java
import io.agora.rtc.IRtcEngineEventHandler;
import io.agora.rtc.RtcEngine;
import io.agora.rtc.video.VideoCanvas;
  
import io.agora.rtc.video.VideoEncoderConfiguration;
```

### 3. 获取设备权限

调用 `checkSelfPermission` 方法，在开启 Activity 时检查并获取 Android 移动设备的摄像头和麦克风使用权限。

```java
private static final int PERMISSION_REQ_ID = 22;
  
// App 运行时确认麦克风和摄像头设备的使用权限。
private static final String[] REQUESTED_PERMISSIONS = {
        Manifest.permission.RECORD_AUDIO,
        Manifest.permission.CAMERA,
        Manifest.permission.WRITE_EXTERNAL_STORAGE
};
  
@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_video_chat_view);
  
    // 获取权限后，初始化 RtcEngine，并加入频道。
    if (checkSelfPermission(REQUESTED_PERMISSIONS[0], PERMISSION_REQ_ID) &&
            checkSelfPermission(REQUESTED_PERMISSIONS[1], PERMISSION_REQ_ID) &&
            checkSelfPermission(REQUESTED_PERMISSIONS[2], PERMISSION_REQ_ID)) {
        initEngineAndJoinChannel();
    }
}
  
private boolean checkSelfPermission(String permission, int requestCode) {
    if (ContextCompat.checkSelfPermission(this, permission) !=
            PackageManager.PERMISSION_GRANTED) {
        ActivityCompat.requestPermissions(this, REQUESTED_PERMISSIONS, requestCode);
        return false;
    }
  
    return true;
}
```

### 4. 初始化 RtcEngine

在调用其他 Agora API 前，需要创建并初始化 RtcEngine 对象。

你需要在该步骤中填入项目的 App ID。请参考如下步骤在控制台[创建 Agora 项目](https://docs.agora.io/cn/Agora%20Platform/manage_projects?platform=All%20Platforms)并获取 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id )。

1. 登录[控制台](https://console.agora.io/)，点击左侧导航栏的**[项目管理](https://console.agora.io/projects)**图标 ![](https://web-cdn.agora.io/docs-files/1551254998344)。
2. 点击**创建**，按照屏幕提示设置项目名，选择一种鉴权机制，然后点击**提交**。
3. 在**项目管理**页面，你可以获取该项目的 **App ID**。

调用 `create` 方法，传入获取到的 App ID，即可初始化 RtcEngine。

你还根据场景需要，在初始化时注册想要监听的回调事件，如本地用户加入频道，及解码远端用户视频首帧等。注意不要在这些回调中进行 UI 操作。

```java
private final IRtcEngineEventHandler mRtcEventHandler = new IRtcEngineEventHandler() {
    @Override
    // 注册 onJoinChannelSuccess 回调。
    // 本地用户成功加入频道时，会触发该回调。
    public void onJoinChannelSuccess(String channel, final int uid, int elapsed) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Log.i("agora","Join channel success, uid: " + (uid & 0xFFFFFFFFL));
            }
        });
    }
  
    @Override
    // 注册 onFirstRemoteVideoDecoded 回调。
    // SDK 接收到第一帧远端视频并成功解码时，会触发该回调。
    // 可以在该回调中调用 setupRemoteVideo 方法设置远端视图。
    public void onFirstRemoteVideoDecoded(final int uid, int width, int height, int elapsed) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Log.i("agora","First remote video decoded, uid: " + (uid & 0xFFFFFFFFL));
                setupRemoteVideo(uid);
            }
        });
    }
  
    @Override
    // 注册 onUserOffline 回调。
    // 远端用户离开频道或掉线时，会触发该回调。
    public void onUserOffline(final int uid, int reason) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Log.i("agora","User offline, uid: " + (uid & 0xFFFFFFFFL));
                onRemoteUserLeft();
            }
        });
    }
};
    
...
  
// 初始化 RtcEngine 对象。
private void initializeEngine() {
    try {
        mRtcEngine = RtcEngine.create(getBaseContext(), getString(R.string.agora_app_id), mRtcEventHandler);
    } catch (Exception e) {
        Log.e(TAG, Log.getStackTraceString(e));
        throw new RuntimeException("NEED TO check rtc sdk init fatal error\n" + Log.getStackTraceString(e));
    }
}
```

### 5. 设置本地视图

如果你想实现一个语音通话，可以直接查看[加入频道](#join_channel)。

成功初始化 RtcEngine 对象后，需要在加入频道前设置本地视图，以便在通话中看到本地图像。参考以下步骤设置本地视图：

* 调用 `enableVideo` 方法启用视频模块。
* 调用 `createRendererView` 方法创建一个 SurfaceView 对象。
* 调用 `setupLocalVideo` 方法设置本地视图。

```java
private void setupLocalVideo() {
  
    // 启用视频模块。
    mRtcEngine.enableVideo();
  
    // 创建 SurfaceView 对象。
    private FrameLayout mLocalContainer;
    private SurfaceView mLocalView;
  
    mLocalView = RtcEngine.CreateRendererView(getBaseContext());
    mLocalView.setZOrderMediaOverlay(true);
    mLocalContainer.addView(mLocalView);
    // 设置本地视图。
    VideoCanvas localVideoCanvas = new VideoCanvas(mLocalView, VideoCanvas.RENDER_MODE_HIDDEN, 0);
    mRtcEngine.setupLocalVideo(localVideoCanvas);
}
```

<a name="join_channel"></a>
### 6. 加入频道

完成初始化和设置本地视图后（视频通话场景），你就可以调用 `joinChannel` 方法加入频道。你需要在该方法中传入如下参数：

* token：传入能标识用户角色和权限的 Token。可设为如下一个值：
   * `NULL`
   * 临时 Token。临时 Token 服务有效期为 24 小时。你可以在控制台里生成一个临时 Token，详见[获取临时 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#获取临时-token)。
   * 在你的服务器端生成的 Token。在安全要求高的场景下，我们推荐你使用此种方式生成的 Token，详见[生成 Token](./token_server)。

 <div class="alert note">若项目已启用 App 证书，请使用 Token。</div>

* channelName：传入能标识频道的频道 ID。App ID 相同、频道 ID 相同的用户会进入同一个频道。
* uid: 本地用户的 ID。数据类型为整型，且频道内每个用户的 uid 必须是唯一的。若将 uid 设为 0，则 SDK 会自动分配一个 uid，并在 `onJoinChannelSuccess` 回调中报告。

更多的参数设置注意事项请参考 [`joinChannel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8b308c9102c08cb8dafb4672af1a3b4c) 接口中的参数描述。

```java
private void joinChannel() {
 
    // 使用 Token 加入频道。
    mRtcEngine.joinChannel(YOUR_TOKEN, "demoChannel1", "Extra Optional Data", 0);
}
```

### 7. 设置远端视图

视频通话中，通常你也需要看到其他用户。在加入频道后，可通过调用 `setupRemoteVideo` 方法设置远端用户的视图。

远端用户成功加入频道后，SDK 会触发 `onFirstRemoteVideoDecoded` 回调，该回调中会包含这个远端用户的 uid 信息。在该回调中调用 `setupRemoteVideo` 方法，传入获取到的 uid，设置远端用户的视图。

```java
    @Override
    // 监听 onFirstRemoteVideoDecoded 回调。
    // SDK 接收到第一帧远端视频并成功解码时，会触发该回调。
    // 可以在该回调中调用 setupRemoteVideo 方法设置远端视图。
    public void onFirstRemoteVideoDecoded(final int uid, int width, int height, int elapsed) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Log.i("agora","First remote video decoded, uid: " + (uid & 0xFFFFFFFFL));
                setupRemoteVideo(uid);
            }
        });
    }
 
private void setupRemoteVideo(int uid) {
 
    // 创建一个 SurfaceView 对象。
    private RelativeLayout mRemoteContainer;
    private SurfaceView mRemoteView;
 
    mRemoteView = RtcEngine.CreateRendererView(getBaseContext());
    mRemoteContainer.addView(mRemoteView);
    // 设置远端视图。
    mRtcEngine.setupRemoteVideo(new VideoCanvas(mRemoteView, VideoCanvas.RENDER_MODE_HIDDEN, uid));
 
}
```

### 8. 更多步骤

你还可以在通话中参考如下代码实现更多功能及场景。

<details>
	<summary><font color="#3ab7f8">停止发送本地音频流</font></summary>
	
调用 `muteLocalAudioStream` 停止或恢复发送本地音频流，实现或取消本地静音。

```java
public void onLocalAudioMuteClicked(View view) {
    mMuted = !mMuted;
    mRtcEngine.muteLocalAudioStream(mMuted);
}
```
</details>

<details>
	<summary><font color="#3ab7f8">切换前后摄像头</font></summary>

调用 `switchCamera` 方法切换摄像头的方向。

```java
public void onSwitchCameraClicked(View view) {
    mRtcEngine.switchCamera();
}
```
</details>
	
### 9. 离开频道

根据场景需要，如结束通话、关闭 App 或 App 切换至后台时，调用 `leaveChannel` 离开当前通话频道。

```java
@Override
protected void onDestroy() {
    super.onDestroy();
    if (!mCallEnd) {
        leaveChannel();
    }
    RtcEngine.destroy();
}
 
private void leaveChannel() {
    // 离开当前频道。
    mRtcEngine.leaveChannel();
}
```

### 示例代码

你可以在 [Agora-Android-Tutorial-1to1](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-Android-Tutorial-1to1) 示例项目的  [VideoChatViewActivity.java](https://github.com/AgoraIO/Basic-Video-Call/blob/master/One-to-One-Video/Agora-Android-Tutorial-1to1/app/src/main/java/io/agora/tutorials1v1vcall/VideoChatViewActivity.java)  文件中查看完整的源码和代码逻辑。

## 运行项目

在 Android 设备中运行该项目。当成功开始视频通话时，你可以同时看到本地和远端的视图。
