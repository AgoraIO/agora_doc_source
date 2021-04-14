---
title: 实现语音通话
platform: Android
updatedAt: 2021-03-22 03:46:34
---
本文介绍如何使用 Agora 语音通话 SDK 快速实现语音通话。

## 示例项目

我们在 GitHub 上提供一个开源的一对一语音通话示例项目 [Agora-Android-Voice-Tutorial-1to1](https://github.com/AgoraIO/Basic-Audio-Call/tree/master/One-to-One-Voice/Agora-Android-Voice-Tutorial-1to1) 供你参考。

## 前提条件

* Android Studio 3.0 或以上版本
* Android SDK API 等级 16 或以上
* 支持 Android 4.1 或以上版本的移动设备
* 有效的 [Agora 账户](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up) 和 [App ID](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#getappid)

<div class="alert note">如果你的网络环境部署了防火墙，请根据<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">应用企业防火墙限制</a>打开相关端口。</div>

## 准备开发环境

本节介绍如何创建项目，将 Agora 音频 SDK 集成进你的项目中，并添加相应的设备权限。

### 创建 Android 项目

参考以下步骤创建一个 Android 项目。若已有 Android 项目，可以直接查看[集成 SDK](#integrate_sdk)。

<details>
	<summary><font color="#3ab7f8">创建 Android 项目</font></summary>

1. 打开 <b>Android Studio</b>，点击 <b>Start a new Android Studio project</b>。
2. 在 <b>Select a Project Template</b> 界面，选择 <b>Phone and Tablet</b> > <b>Empty Activity</b>，然后点击 <b>Next</b>。
3. 在 <b>Configure Your Project</b> 界面，依次填入以下内容：
	* <b>Name</b>：你的 Android 项目名称，如 HelloAgora
	* <b>Package name</b>：你的项目包的名称，如 io.agora.helloagora
	* <b>Save location</b>：项目的存储路径
	* <b>Language</b>：项目的编程语言，如 Java
	* <b>Minimum API level</b>：项目的最低 API 等级

然后点击 <b>Finish</b>。根据屏幕提示，安装可能需要的插件。
	
<div class="alert info">上述步骤使用 <b>Android Studio 3.6.2</b> 示例。你也可以直接参考 Android Studio 官网文档<a href="https://developer.android.com/training/basics/firstapp">创建首个应用</a>。</div>
	
</details>


<a name="integrate_sdk"></a>
### 集成 SDK

选择如下任意一种方式将 Agora 音频 SDK 集成到你的项目中。

**方法一：使用 JCenter 自动集成**

在项目的 **/app/build.gradle** 文件中，添加如下行：

```
...
dependencies {
    ...
    // x.y.z 请填写具体版本号，如：3.0.0
    // 可通过 SDK 发版说明取得最新版本号
    implementation 'io.agora.rtc:voice-sdk:x.y.z'
}
```

<div class="alert info">请点击查看<a href = "https://docs.agora.io/cn/Video/release_android_video?platform=Android">发版说明</a>获取最新版本号。</div>

**方法二：手动复制 SDK 文件**

1. 前往 [SDK 下载](./downloads)页面，获取最新版的 Agora 音频 SDK，然后解压。
2. 将 SDK 包内 libs 路径下的如下文件，拷贝到你的项目路径下：

| 文件或文件夹                   | 项目路径                               | 
| ---------------------------- | ------------------------------------ | 
| **agora-rtc-sdk.jar** 文件    | **/app/libs/**                       | 
| **arm64-v8a** 文件夹            | **/app/src/main/jniLibs/**           | 
| **armeabi-v7a** 文件夹        | **/app/src/main/jniLibs/**           | 
| **include** 文件夹   | **/app/src/main/jniLibs/**           | 
| **x86** 文件夹                | **/app/src/main/jniLibs/**           | 
| **x86_64** 文件夹             | **/app/src/main/jniLibs/**           | 

<div class="alert note">
	<ul>
		<li>如果你使用 3.2.0 以下版本的 SDK 且你的项目无需使用加密功能，建议删除 SDK 包内的 <code>libagora-crypto.so</code> 文件。</li>
	<li>如果你使用的是 armeabi 库，可以把 <b>armeabi-v7a</b> 内的文件放入 <b>armeabli</b> 文件夹内。如果遇到不兼容的情况，请联系 <a href ="mailto: sales@agora.io">sales@agora.io</a> 咨询适配相关问题。</li>
		<li>后缀为 <code>extension</code> 的库是可选项，请按需集成。你可以在<a href = "https://docs.agora.io/cn/Video/release_android_video?platform=Android">发版说明</a>中查看扩展库对应的功能。</li>
	</ul>
	</div>

### 添加项目权限

根据场景需要，在  **/app/src/main/AndroidManifest.xml** 文件中添加如下行，获取相应的设备权限：

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
   package="io.agora.tutorials1v1acall">

   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.RECORD_AUDIO" />
   <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
   <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
	
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

在 **app/proguard-rules.pro** 文件中添加如下行，防止混淆 Agora SDK 的代码：

```xml
-keep class io.agora.**{*;}
```

## 实现语音通话

本节介绍如何实现语音通话。语音通话的 API 调用时序见下图：

![](https://web-cdn.agora.io/docs-files/1582626953110)

### 1. 创建用户界面

根据场景需要，为你的项目创建语音通话的用户界面。若已有界面，可以直接查看[导入类](#import_class)。

你可以参考 Agora-Android-Voice-Tutorial-1to1 示例项目的  [activity_voice_chat_view.xml](https://github.com/AgoraIO/Basic-Audio-Call/blob/master/One-to-One-Voice/Agora-Android-Voice-Tutorial-1to1/app/src/main/res/layout/activity_voice_chat_view.xml) 文件中的代码。

<details>
 <summary><font color="#3ab7f8">创建 UI 示例</font></summary>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/activity_voice_chat_view"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context="io.agora.tutorials1v1acall.VoiceChatViewActivity">

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_alignParentBottom="true"
        android:layout_marginBottom="@dimen/activity_vertical_margin"
        android:orientation="vertical">

        <TextView
            android:id="@+id/quick_tips_when_use_agora_sdk"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginBottom="40dp"
            android:layout_marginLeft="@dimen/activity_horizontal_margin"
            android:layout_marginStart="@dimen/activity_horizontal_margin"
            android:gravity="center_vertical|start"
            android:text="1. Default channel name is voiceDemoChannel1\n2. Waiting for remote users\n3. This demo only supports 1v1 voice calling" />

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="50dp"
            android:orientation="horizontal">

            <ImageView
                android:layout_width="0dp"
                android:layout_height="match_parent"
                android:layout_weight="20"
                android:onClick="onLocalAudioMuteClicked"
                android:scaleType="centerInside"
                android:src="@drawable/btn_mute" />

            <ImageView
                android:layout_width="0dp"
                android:layout_height="match_parent"
                android:layout_weight="20"
                android:onClick="onSwitchSpeakerphoneClicked"
                android:scaleType="centerInside"
                android:src="@drawable/btn_speaker" />

            <ImageView
                android:layout_width="0dp"
                android:layout_height="match_parent"
                android:layout_weight="20"
                android:onClick="onEncCallClicked"
                android:scaleType="centerInside"
                android:src="@drawable/btn_end_call" />

        </LinearLayout>

    </LinearLayout>

</RelativeLayout>
```
</details>

<a name="import_class"></a>
### 2. 导入类
		
在项目的 Activity 文件中添加如下行：

```java
import io.agora.rtc.IRtcEngineEventHandler;
import io.agora.rtc.RtcEngine;
```

### 3. 获取设备权限

调用 `checkSelfPermission` 方法，在开启 Activity 时检查并获取 Android 移动设备的麦克风使用权限。

```java
// Java
private static final int PERMISSION_REQ_ID_RECORD_AUDIO = 22;
  
// App 运行时确认麦克风的使用权限。
@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_voice_chat_view);

    // 获取权限后，初始化 RtcEngine，并加入频道。
    if (checkSelfPermission(Manifest.permission.RECORD_AUDIO, PERMISSION_REQ_ID_RECORD_AUDIO)) {
        initAgoraEngineAndJoinChannel();
    }
}
  
private void initAgoraEngineAndJoinChannel() {
    initializeAgoraEngine();
    joinChannel(); 
}

public boolean checkSelfPermission(String permission, int requestCode) {
    Log.i(LOG_TAG, "checkSelfPermission " + permission + " " + requestCode);
    if (ContextCompat.checkSelfPermission(this,
            permission)
            != PackageManager.PERMISSION_GRANTED) {

        ActivityCompat.requestPermissions(this,
                new String[]{permission},
                requestCode);
        return false;
    }
    return true;
}
```

```kotlin
// Kotlin
// app 运行时确认麦克风的使用权限。
override fun onCreate(savedInstanceState: Bundle?) {
  super.onCreate(savedInstanceState)
  setContentView(R.layout.activity_voice_chat_view)
  
  // 获取权限后，初始化 RtcEngine，并加入频道。
  if (checkSelfPermission(Manifest.permission.RECORD_AUDIO, PERMISSION_REQ_ID_RECORD_AUDIO)) {
    initAgoraEngineAndJoinChannel()
  }
}

private fun initAgoraEngineAndJoinChannel() {
  initializeAgoraEngine()
  joinChannel()
}

private fun checkSelfPermission(permission. String, requestCode: Int): Boolean {
  Log.i(LOG_TAG, "checkSelfPermission $permission $reuqestCode")
  if (ContextCompat.checkSelfPermission(this, 
          permission) != PackageManager.PERMISSION_GRANTED) {
     
    ActivityCompat.requestPermission(this
            arrayOf(permission),
            requestCode)
    return false
  }
  return true
}
```

### 4. 初始化 RtcEngine

在调用其他 Agora API 前，需要创建并初始化 RtcEngine 对象。

将获取到的 App ID 添加到 `string.xml` 文件中的 `agora_app_id` 一栏。调用 `create` 方法，传入获取到的 App ID，即可初始化 RtcEngine。

你还根据场景需要，在初始化时注册想要监听的回调事件，如远端用户下线或静音回调。注意不要在这些回调中进行 UI 操作。

```java
// Java
private RtcEngine mRtcEngine;
private final IRtcEngineEventHandler mRtcEventHandler = new IRtcEngineEventHandler() {  

    // 注册 onUserOffline 回调。远端用户离开频道后，会触发该回调。 
    @Override
    public void onUserOffline(final int uid, final int reason) { 
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                onRemoteUserLeft(uid, reason);
            }
        });
    }

    // 注册 onUserMuteAudio 回调。远端用户静音后，会触发该回调。
    @Override
    public void onUserMuteAudio(final int uid, final boolean muted) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                onRemoteUserVoiceMuted(uid, muted);
            }
        });
    }
};
    
...
// 调用 Agora SDK 的方法初始化 RtcEngine。
private void initializeAgoraEngine() {
    try {
        mRtcEngine = RtcEngine.create(getBaseContext(), getString(R.string.agora_app_id), mRtcEventHandler);
        mRtcEngine.setChannelProfile(Constants.CHANNEL_PROFILE_COMMUNICATION);
    } catch (Exception e) {
        Log.e(LOG_TAG, Log.getStackTraceString(e));

        throw new RuntimeException("NEED TO check rtc sdk init fatal error\n" + Log.getStackTraceString(e));
    }
}
```

```kotlin
// Kotlin
private var mRtcEngine: RtcEngine? = null
private val mRtcEventHandler = object : IRtcEngineEventHandler() {
  
  // 注册 onUserOffline 回调。远端用户离开频道后，会触发该回调。
  override fun onUserOffline(uid: Int, reason: Int) {
    runOnUiThread { onRemoteUserLeft() }
  }
  
  // 注册 onUserMuteAudio 回调。远端用户静音后，会触发该回调。
  override fun onUserMuteAudio(uid: Int, muted: Boolean) {
    runOnUiThread { onRemoteUserVoiceMuted(uid, muted)}
  }
}

...

// 调用 Agora SDK 的方法初始化 RtcEngine。
private fun initializeAgoraEngine() {
  try {
    mRtcEngine = RtcEngine.create(baseContext, getString(R.string.agora_app_id), mRtcEventHandler)
  } catch (e: Exception) {
    Log.e(LOG_TAG, Log.getStackTraceString(e))
    
    throw RuntimeException("NEED TO check rtc sdk init fatal error\n" + Log.getStackTraceString(e))
  }
}
```


<a name="join_channel"></a>
### 5. 加入频道

完成初始化后，你就可以调用 `joinChannel` 方法加入频道。你需要在该方法中传入如下参数：

* `token`：传入用于鉴权的 Token，可设为如下一个值：
   * 临时 Token。你可以在控制台里生成一个临时 Token，详见[获取临时 Token](token#get-a-temporary-token)。加入频道时，请确保填入的频道名和生成临时 Token 时填入的频道名一致。
   * 在你的服务器端生成的 Token。在安全要求高的场景下，我们推荐你使用此种方式生成的 Token，详见[从服务端生成 Token](./token_server)。加入频道时，请确保填入的频道名和 uid 与生成 Token 时填入的频道名和 uid 一致。

 <div class="alert note"><ul><li>若项目已启用 App 证书，请使用 Token。</li><li>请勿将 <code>token</code> 设为 ""。</li></div>

* channelName：传入能标识频道的频道 ID。App ID 相同、频道 ID 相同的用户会进入同一个频道。
* uid: 本地用户的 ID。数据类型为整型，且频道内每个用户的 uid 必须是唯一的。若将 uid 设为 0，则 SDK 会自动分配一个 uid，并在 `onJoinChannelSuccess` 回调中报告。

更多的参数设置注意事项请参考 [`joinChannel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8b308c9102c08cb8dafb4672af1a3b4c) 接口中的参数描述。

```java
// Java
private void joinChannel() {
    String accessToken = getString(R.string.agora_access_token);
    if (TextUtils.equals(accessToken, "") || TextUtils.equals(accessToken, "#YOUR ACCESS TOKEN#")) {
        accessToken = null;
    }

    // 调用 Agora SDK 的 joinChannel 方法加入频道。未指定 uid，SDK 会自动分配一个。
    mRtcEngine.joinChannel(accessToken, "voiceDemoChannel1", "Extra Optional Data", 0);
}
```

```kotlin
// Kotlin
private fun joinChannel() {
	
  // 调用 Agora SDK 的 joinChannel 方法加入频道。未指定 uid，SDK 会自动分配一个。
  mRtcEngine!!.joinChannel(token, "demoChannel1", "Extra Optional Data", 0)
}
```

	
### 6. 离开频道

根据场景需要，如结束通话、关闭 App 或 App 切换至后台时，调用 `leaveChannel` 离开当前通话频道。

```java
// Java
private void leaveChannel() {
    mRtcEngine.leaveChannel();
}
```

```kotlin
// Kotlin
private fun leaveChannel() {
  mRtcEngine!!.leaveChannel()
}
```

### 示例代码

你可以在 Agora-Android-Voice-Tutorial-1to1 示例项目的  [VoiceChatViewActivity.java](https://github.com/AgoraIO/Basic-Audio-Call/blob/master/One-to-One-Voice/Agora-Android-Voice-Tutorial-1to1/app/src/main/java/io/agora/tutorials1v1acall/VoiceChatViewActivity.java)  文件中查看完整的源码和代码逻辑。

## 运行项目

在 Android 设备中运行该项目。当成功开始语音通话时，你可以听到对方的说话声音。

## 相关链接

我们在 GitHub 上提供一个开源的一对多语音通话示例项目 [Group-Voice-Call](https://github.com/AgoraIO/Basic-Audio-Call/tree/master/Group-Voice-Call/OpenVoiceCall-Android)。如果你需要实现一对多群聊场景，可以前往下载或查看源代码。

使用 Agora 语音通话 SDK 开发过程中，你还可以参考如下文档：

- [如何设置日志文件？](https://docs.agora.io/cn/faq/logfile)
- [为什么 Android 9 应用锁屏或切后台后采集音视频无效？](https://docs.agora.io/cn/faq/android_background)
