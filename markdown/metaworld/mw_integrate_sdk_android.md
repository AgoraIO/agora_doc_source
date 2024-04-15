本文件介绍如何集成声网 Meta SDK。

## 前提条件

- [Git](https://git-scm.com/downloads)
- [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html)
- [Android Studio](https://developer.android.com/studio/) 4.1 及以上。
- Android 手机，版本 Android 5.1（API Level 22）及以上。
- 可以访问互联网的计算机。确保你的网络环境没有部署防火墙，否则无法正常使用声网服务。
- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)。

<div class="alert note">声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。</div>

## 创建声网项目

1. 进入声网控制台的[项目管理](https://console.agora.io/projects)页面。
2. 在项目管理页面，点击**创建**按钮。
3. 在弹出的对话框内输入项目名称、使用场景，然后选择**安全模式：APP ID + Token**。
4. 点击**提交**按钮。新建的项目会显示在项目管理页中。

## 开通服务

1. 创建项目后，从控制台获取以下信息：
  - App ID：声网项目的 App ID。详见[获取 App ID](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id)。
  - App Certificate：声网项目的 App 证书。详见[获取 App 证书](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-证书)。
  - 频道名称：用于标识直播频道的字符串。
2. 联系 [sales@agora.io](mailto:sales@agora.io) 并供你的声网项目 App ID，以开通声网内容中心的权限并获取声网面部捕捉插件的 App ID 和 Certificate。

## 创建项目并集成 SDK

### 1. 创建项目

如果你没项目文件，你需要创建新项目。在 **Android Studio** 里，依次选择 **Phone and Tablet > Empty Activity**，创建 [Android 项目](https://developer.android.com/studio/projects/create-project)。

<div class="alert note">创建项目后，<b>Android Studio</b> 会自动开始同步 gradle, 稍等片刻至同步成功后再进行下一步操作。</div>

### 2. 集成 SDK

声网 Meta SDK 是基于声网 RTC SDK 4.0.1 版开发的元系列特殊版 SDK。

1. 联系销售获取该 SDK，下载并解压。
2. 打开解压文件，将以下文件或文件夹复制到你的项目路径中。

  | 文件或子文件夹             | 项目路径     |
  |:-------------------------|:-----------|
  | `agora-rtc-sdk.jar` 文件	| `/app/libs/` |
  | `AgoraMetaKit.aar` 文件 	| `/app/libs/` |
  | `face_capture.jar` 文件   | `/app/libs/` |
  | `FaceCapture.aar` 文件    | `/app/libs/` |
  | `metakit.jar` 文件        | `/app/libs/` |
  | `arm64-v8a` 文件夹      	| `/app/src/main/jniLibs/` |
  | `armeabi-v7a` 文件夹	    | `/app/src/main/jniLibs/` |
  | `x86_64` 文件夹           | `/app/src/main/jniLibs/` |
  | `x86` 文件夹	            | `/app/src/main/jniLibs/` |

### 3. 添加第三方库和依赖

在项目的 `build.gradle` 文件中的 `dependencies` 节点中添加行，以添加第三方库和依赖。

```java
dependencies {
    ...
    implementation fileTree(dir: "libs", include: ["*.jar", "*.aar"])
    implementation(['com.squareup.okhttp3:logging-interceptor:3.9.0',
                        'com.squareup.retrofit2:retrofit:2.3.0',
                        'com.squareup.retrofit2:adapter-rxjava2:2.3.0',
                        'com.squareup.retrofit2:converter-gson:2.3.0'])
    implementation(["io.reactivex.rxjava2:rxandroid:2.0.1",
                    "io.reactivex.rxjava2:rxjava:2.1.3"])
}
```

![](https://web-cdn.agora.io/docs-files/1687674307175)

### 4. 添加网络和设备权限

在 `/app/Manifests/AndroidManifest.xml` 文件中，在 `</application>` 后面添加如下权限：

```xml
 <uses-permission android:name="android.permission.INTERNET"/>
 <uses-permission android:name="android.permission.CAMERA"/>
 <uses-permission android:name="android.permission.RECORD_AUDIO"/>
 <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS"/>
 <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
 <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
 <uses-permission android:name="android.permission.BLUETOOTH"/>
 <!-- 对于 Android 12.0 及以上且集成 v4.1.0 以下声网 SDK 的设备，还需要添加以下权限 -->
 <uses-permission android:name="android.permission.BLUETOOTH_CONNECT"/>
 <!-- 对于 Android 12.0 及以上设备，还需要添加以下权限 -->
 <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
 <uses-permission android:name="android.permission.BLUETOOTH_SCAN"/>
```

### 5. 代码防混淆

在 `/Gradle Scripts/proguard-rules.pro` 文件中添加如下行，以防止声网 SDK 的代码被混淆：

```java
-keep class io.agora.**{*;}
-dontwarn javax.**
-dontwarn com.google.devtools.build.android.**
```

## 下一步

集成后，你可以参考下一篇文档实现元语聊、元直播。