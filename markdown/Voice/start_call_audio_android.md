实时语音通话能够拉近人与人之间的距离，为用户提供沉浸式的交流体验，帮助你的 app 提高用户黏性。

本文介绍如何通过少量代码集成 Agora 音频 SDK，在你的 Android 应用里实现语音通话功能。

## 技术原理

下图展示在 app 中集成 Agora 语音通话的基本工作流程：

![img](https://web-cdn.agora.io/docs-files/1637569394869)

如图所示，实现语音通话的步骤如下：

1. 获取 Token：当 app 客户端加入频道时，你需要使用 Token 验证用户身份。在测试或生产环境中，从 app 服务器中获取 Token。
2. 加入频道：调用 `joinChannel` 创建并加入频道。使用同一频道名称的 app 客户端默认加入同一频道。
3. 在频道内发布和订阅音频流：加入频道后，app 客户端均可以在频道内发布和订阅音频。

App 客户端加入 RTC 频道需要以下信息：

- App ID：Agora 随机生成的字符串，用于识别你的 app，可从 [Agora 控制台](https://console.agora.io/)获取。
- 用户 ID：用户的唯一标识。 你需要自行设置用户 ID，并确保它在频道内是唯一的。
- Token：在测试或生产环境中，app 客户端从你的服务器中获取 Token。在本文介绍的流程中，你可以从 Agora 控制台获取临时 Token。临时 Token 的有效期为 24 小时。
- 频道名称：用于标识语音通话频道的字符串。

## 前提条件

开始前，请确保你的开发环境满足以下条件：

- Android Studio 3.0 或以上版本。
- Android SDK API 等级 16 或以上。
- 有效的 [Agora 账户](https://console.agora.io/)。
- 带有 App ID 和临时 Token 的 Agora 项目。详情请参考[开始使用 Agora 平台](https://docs.agora.io/cn/AgoraPlatform/get_appid_token?platform=All%20Platforms)。
- 可以访问互联网的计算机。如果你的网络环境部署了防火墙，请参考[应用企业防火墙限制](https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms)。
- 运行 Android 4.1 或更高版本的移动设备。

## 项目设置

实现语音通话之前，参考如下步骤设置你的项目：

1. 如需创建新项目，在 **Android Studio** 里，依次选择 **Phone and Tablet** > **Empty Activity**，创建 [Android 项目](https://developer.android.com/studio/projects/create-project)。

   创建项目后，**Android Studio** 会自动开始同步 gradle。请确保同步成功再进行下一步操作。

2. 将音频 SDK 集成到你的项目中。 对 3.5.0 版或之后的 SDK，请参考以下步骤使用 mavenCentral 集成 SDK。 对 3.5.0 版之前的 SDK 版本，请参考<a href="https://docs.agora.io/cn/Voice/start_call_audio_android?platform=Android#othermethods">集成 SDK 的其他方法</a>。

   a. 在 `/Gradle Scripts/build.gradle(Project: <projectname>)` 文件中添加如下代码，以添加 mavenCentral 依赖：

   ```java
    buildscript {
        repositories {
            ...
            mavenCentral()
        }
        ...
   }

     allprojects {
        repositories {
            ...
            mavenCentral()
        }
   }
   ```

   b. 在 `/Gradle Scripts/build.gradle(Module: <projectname>.app)` 文件中添加如下代码，将 Agora 音频 SDK 集成到你的 Android 项目中：

   ```java
    ...
    dependencies {
     ...
     // x.y.z，请填写具体的 SDK 版本号，如：3.5.0。
     // 通过发版说明获取最新版本号。
     implementation 'io.agora.rtc:voice-sdk:x.y.z'
    }
   ```

3. 在 `/app/Manifests/AndroidManifest.xml` 文件中的 `</application>` 后面添加如下网络和设备权限：

   ```xml
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.BLUETOOTH" />
   ```

4. 为防止代码混淆，在 `/Gradle Scripts/proguard-rules.pro` 文件中添加如下代码：

   ```
    -keep class io.agora.**{*;}
   ```

## 客户端实现

本节介绍如何使用 Agora 音频 SDK 在你的 app 里实现语音通话。

### 创建用户界面

将 `/app/res/layout/activity_main.xml` 文件中的内容替换成如下代码：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/activity_main"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">


      <FrameLayout
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:background="@android:color/darker_gray" />

        <TextView
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginBottom="40dp"
            android:layout_marginLeft="16dp"
            android:layout_marginStart="16dp"
            android:layout_gravity="center_vertical|start"
            android:text="Welcome to the Agora Voice Call channel."/>

      </FrameLayout>
</RelativeLayout>
```

### 处理 Android 系统逻辑

参考如下步骤，导入必要的 Android 类，并添加授权必要权限的逻辑。

1. 导入必要的 Android 类

   在 `/app/java/com.example.<projectname>/MainActivity` 文件中的 `package com.example.<projectname>` 后添加如下代码：

   ```java
    // Java
    import androidx.core.app.ActivityCompat;
    import androidx.core.content.ContextCompat;
    import android.Manifest;
    import android.content.pm.PackageManager;
   ```

   ```kotlin
    // Kotlin
    import android.content.pm.PackageManager
    import androidx.core.app.ActivityCompat
    import androidx.core.content.ContextCompat
    import android.Manifest
    import java.lang.Exception
   ```

2. 添加必要权限的授权逻辑

   启动应用程序时，检查是否已在 app 中授予了实现语音通话所需的权限。如果未授权，使用内置的 Android 功能申请权限；如果已授权，则返回 `true`。

   为实现授权逻辑，在 `/app/java/com.example.<projectname>/MainActivity` 文件的 `onCreate` 函数前添加如下代码：

   ```java
    // Java
    private static final int PERMISSION_REQ_ID = 22;

    private static final String[] REQUESTED_PERMISSIONS = {
             Manifest.permission.RECORD_AUDIO,
             Manifest.permission.CAMERA
    };

    private boolean checkSelfPermission(String permission, int requestCode) {
            if (ContextCompat.checkSelfPermission(this, permission) !=
                            PackageManager.PERMISSION_GRANTED) {
                    ActivityCompat.requestPermissions(this, REQUESTED_PERMISSIONS, requestCode);
                    return false;
            }
            return true;
    }
   ```

   ```kotlin
    // Kotlin
    private val PERMISSION_REQ_ID_RECORD_AUDIO = 22
    private val PERMISSION_REQ_ID_CAMERA = PERMISSION_REQ_ID_RECORD_AUDIO + 1

    private fun checkSelfPermission(permission: String, requestCode: Int): Boolean {
        if (ContextCompat.checkSelfPermission(this, permission) !=
                PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this,
                                                                             arrayOf(permission),
                                                                             requestCode)
            return false
        }
        return true
    }
   ```

### 实现互动语音通话逻辑

应用开启时，你需要依次创建 `RtcEngine` 实例，加入频道，并在频道中发布本地音频。如果其他用户加入频道时，你的应用会捕捉到这一加入事件，并接收远端用户的音频。

下图展示语音通话的 API 调用时序：

![img](https://web-cdn.agora.io/docs-files/1637740486081)

按照以下步骤实现该逻辑：

1. 导入必要的 Agora 类。

   在 `/app/java/com.example.<projectname>/MainActivity` 文件中的 `import android.os.Bundle;` 后添加如下代码：

   ```java
    import io.agora.rtc.RtcEngine;
    import io.agora.rtc.IRtcEngineEventHandler;
   ```

2. 创建变量用以创建并加入语音通话频道。

   在 `/app/java/com.example.<projectname>/MainActivity` 文件中的 `AppCompatActivity {` 后添加如下代码：

   ```java
    // Java
    // 填写你的项目在 Agora 控制台中生成的 App ID。
    private String appId = "";
    // 填写频道名称。
    private String channelName = "";
    // 填写 Agora 控制台中生成的临时 Token。
    private String token = "";
    private RtcEngine mRtcEngine;
    private final IRtcEngineEventHandler mRtcEventHandler = new IRtcEngineEventHandler() {
    };
   ```

   ```kotlin
    // Kotlin
    // 填写你的项目在 Agora 控制台中生成的 App ID。
    private val APP_ID = ""
    // 填写频道名称。
    private val CHANNEL = ""
    // 填写 Agora 控制台中生成的临时 Token。
    private val TOKEN = ""
    private var mRtcEngine: RtcEngine ?= null
    private val mRtcEventHandler = object : IRtcEngineEventHandler() {
    }
   ```

3. 初始化 app 并加入频道。

   在 `MainActivity` 类中调用如下核心方法加入频道。在如下示例代码中，我们使用 `initializeAndJoinChannel` 函数来封装这些核心方法。

   在 `/app/java/com.example.<projectname>/MainActivity` 文件中的 `onCreate` 函数后添加如下代码：

   ```java
    // Java
    private void initializeAndJoinChannel() {
        try {
            mRtcEngine = RtcEngine.create(getBaseContext(), appId, mRtcEventHandler);
        } catch (Exception e) {
            throw new RuntimeException("Check the error.");
        }
        mRtcEngine.joinChannel(token, channelName, "", 0);
    }
   ```

   ```kotlin
    // Kotlin
    private fun initializeAndJoinChannel() {
        try {
            mRtcEngine = RtcEngine.create(baseContext, APP_ID, mRtcEventHandler)
        } catch (e: Exception) {
        }
        mRtcEngine!!.joinChannel(TOKEN, CHANNEL, "", 0)
    }
   ```

### 启动和关闭 app

现在你已经完成语音通话的逻辑，接下来需要添加启动和关闭 app 的逻辑。用户打开你的 app 时，语音通话开始；用户关闭你的 app 关闭时，语音通话结束。

1. 检查 app 是否获取正确的权限。如果已获取权限，调用 `initializeAndJoinChannel` 加入语音通话频道。

   在 `/app/java/com.example.<projectname>/MainActivity` 文件中，用如下代码替换 `MainActivity` 类中的 `onCreate`：

   ```java
    // Java
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        if (checkSelfPermission(REQUESTED_PERMISSIONS[0], PERMISSION_REQ_ID)) {
            initializeAndJoinChannel();
        }
    }
   ```

   ```kotlin
    // Kotlin
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        if (checkSelfPermission(Manifest.permission.RECORD_AUDIO, PERMISSION_REQ_ID_RECORD_AUDIO)) {
            initializeAndJoinChannel();
        }
    }
   ```

2. 当用户关闭 app 关闭时，清理你在 `initializeAndJoinChannel` 函数中创建的所有资源。

   在 `/app/java/com.example.<projectname>/MainActivity` 文件的 `onCreate` 函数后添加 `onDestroy`：

   ```java
    // Java
    protected void onDestroy() {
        super.onDestroy();
        mRtcEngine.leaveChannel();
        mRtcEngine.destroy();
    }
   ```

   ```kotlin
    // Kotlin
    override fun onDestroy() {
        super.onDestroy()
        mRtcEngine?.leaveChannel()
        RtcEngine.destroy()
    }
   ```

## 测试你的 app

按照以下步骤测试你的 app：

1. 在 `appId` 和 `token` 参数中分别填写从 Agora 控制台获取的 App ID 和临时 Token。在 `channelName` 中填写用于生成临时 token 的频道名称。
2. 将 Android 设备连接到你的电脑，并在 **Android Studio** 里点击 `Run 'app'`。片刻后，项目便会安装到你的设备上。
3. 启动 app，你可以看到我们创建的用户界面。
4. 请一位朋友在[演示 app](https://webdemo.agora.io/agora-websdk-api-example-4.x/basicVideoCall/index.html) 中加入你的语音通话。输入相同的 App ID 和频道名称。你的朋友加入频道后，你们可以看到彼此，并听到彼此的声音。

## 后续步骤

在生产环境中，为保证通信安全，Agora 推荐从服务器中获取 Token，详情请参考[使用 Token 鉴权](https://docs.agora.io/cn/Video/token_server?platform=Android)。

## 相关信息

### <a name="https://docs.agora.io/cn/Voice/start_call_audio_android?platform=Android#othermethods">集成 SDK 的其他方法</a>

除了通过 mavenCentral 集成 Android 音频 SDK 外，你也可以使用 JitPack 或者手动复制 SDK 文件，将 SDK 导入你的项目。

**使用 JCenter 自动集成 SDK**

JitPack 的集成方式仅适用于早于 3.5.0 版的 SDK。

1. 在 `/Gradle Scripts/build.gradle(Project: <projectname>)` 文件中添加如下代码，将 JitPack 添加到仓库列表中：

```java
 all projects {
         repositories {
         ...
         maven { url 'https://www.jitpack.io' }
         }
 }
```

2. 在 `/Gradle Scripts/build.gradle(Module: <projectname>.app)`文件中，添加如下代码，将 Agora 音频 SDK 集成到你的 Android 项目中：

```java
 ...
 dependencies {
         ...
         // x.y.z，填写具体的 SDK 版本号，如：3.4.0。
         // 通过发版说明获取最新版本号。
         implementation 'io.agora.rtc:voice-sdk:x.y.z'
 }
```

**手动复制 SDK 文件**

<div class="alert note">手动的集成方式适用于所有版本 SDK。</div>

1. 在 [SDK 下载](https://docs.agora.io/cn/Voice/downloads?platform=Android)页面下载最新版本的 Agora 音频 SDK ，并解压。

2. 打开 SDK 包 libs 文件夹，将以下文件或子文件夹复制到你的项目路径中。

   | 文件或子文件夹           | 你的项目路径             |
   | :----------------------- | :----------------------- |
   | `agora-rtc-sdk.jar` 文件 | `/app/libs/`             |
   | `arm-v8a` 文件夹         | `/app/src/main/jniLibs/` |
   | `armeabi-v7a` 文件夹     | `/app/src/main/jniLibs/` |
   | `x86` 文件夹             | `/app/src/main/jniLibs/` |
   | `x86_64` 文件夹          | `/app/src/main/jniLibs/` |
   | `include` 文件夹         | `/app/src/main/jniLibs/` |

   - 如果你使用 armeabi 架构, 请将 `armeabi-v7a` 文件夹的文件复制到你的项目 `armeabi` 文件中。如果出现不兼容问题，请[联系我们](https://agora-ticket.agora.io)
   - SDK 包中的库不是全部必须。详情请参考[如何减少集成 RTC Native SDK 的 app 体积](https://docs.agora.io/en/Video/faq/reduce_app_size_rtc)。
