MetaWorld 解决方案支持元语聊、元直播、元 K 歌场景。本文介绍如何实现元语聊。

## 示例项目

## 准备开发环境

### 前提条件

- [Android Studio](https://developer.android.com/studio/) 4.1 及以上。
- Android 手机，版本 Android 5.1（API Level 22）及以上。
- 可以访问互联网的计算机。确保你的网络环境没有部署防火墙，否则无法正常使用声网服务。
- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)和声网项目，请参考[开始使用声网平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)，从声网控制台获取以下信息：
  - App ID：声网随机生成的字符串，用于识别你的 app。
  - 临时 Token：你的 app 客户端加入频道时会使用 Token 对用户进行鉴权。临时 Token 的有效期为 24 小时。
  - 频道名称：用于标识直播频道的字符串。

<div class="alert note">声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。</div>

### 创建项目并集成 SDK

按照以下步骤准备开发环境：

1. 如果你没项目文件，你需要创建新项目。在 **Android Studio** 里，依次选择 **Phone and Tablet > Empty Activity**，创建 [Android 项目](https://developer.android.com/studio/projects/create-project)。

   <div class="alert note">创建项目后，<b>Android Studio</b> 会自动开始同步 gradle, 稍等片刻至同步成功后再进行下一步操作。</div>

2. 集成声网 Meta SDK，该 SDK 是基于 RTC SDK 开发的元系列特殊版 SDK。联系销售获取该 SDK，下载并解压。打开解压文件，将以下文件或文件夹复制到你的项目路径中。

   |  SDK 文件或文件夹      |  项目路径       |
   |----------|--------|
   | agora-rtc-sdk.jar 文件       |/app/libs/         |
   | metakit.jar 文件       | /app/libs/        |
   | face_capture.jar 文件       | /app/libs/        |
   | AgoraMetaKit.aar 文件       | /app/libs/        |
   | FaceCapture.aar 文件       | /app/libs/        |
   | arm64-v8a 文件夹       | /app/src/main/jniLibs/        |
   | armeabi-v7a 文件夹       | /app/src/main/jniLibs/        |
   | x86 文件夹       | /app/src/main/jniLibs/        |
   | x86_64 文件夹               | /app/src/main/jniLibs/                   |

3. 在项目的 `build.gradle` 文件中的 `dependencies` 节点中添加行，以添加第三方库和依赖。

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

4. 添加网络及设备权限。

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

5. 在 `/Gradle Scripts/proguard-rules.pro` 文件中添加如下行，以防止声网 SDK 的代码被混淆：

   ```java
   -keep class io.agora.**{*;}
   -dontwarn javax.**
   -dontwarn com.google.devtools.build.android.**
   ```

## 实现元语聊




