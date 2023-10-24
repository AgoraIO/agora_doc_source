---
title: 实现语聊房
---

本文介绍如何集成语聊 UIKit 来实现房间的创建、用户进房、退房和销毁等功能。

## 示例项目

声网提供 [API-Examples-AUIKit/Android/VoiceRoomApp](https://github.com/AgoraIO-Community/API-Examples-AUIKit/tree/dev/voiceroom-android/Android/VoiceRoomApp) 示例项目供你参考本文提到的集成步骤和代码逻辑。


## 准备开发环境

### 前提条件

- [Android Studio](https://developer.android.com/studio/) 3.5 及以上。本文以 [Android Studio Giraffe | 2022.3.1](https://developer.android.google.cn/studio/releases?hl=zh-cn) 和 JBR 17.0.6 为例。
- Android 手机，版本 Android 5.0（API Level 21）及以上。
- 可以访问互联网的计算机。确保你的网络环境没有部署防火墙，否则无法正常使用声网服务。
- [开通服务](./enable-service)。


### 创建项目

如需创建新项目，在 **Android Studio** 里，依次选择 **Phone and Tablet > Empty Activity**，创建 [Android 项目](https://developer.android.com/studio/projects/create-project)。

<Admonition type="caution" title="注意">
创建项目后，<b>Android Studio</b> 会自动开始同步 gradle，稍等片刻至同步成功后再进行下一步操作。
</Admonition>

### 集成依赖

本节介绍如何集成语聊项目所需的依赖库：

1. 下载声网提供的 [AUIVoiceRoom/Android/asceneskit](https://github.com/AgoraIO-Community/AUIVoiceRoom/tree/main/Android/asceneskit) 文件夹，并将该文件夹复制到与你的 `app` 文件夹所在的同一级目录下。

2. 在 `<your_app>/setting.gradle.kts` 文件中添加如下行：

    ```kotlin
    dependencyResolutionManagement {
        repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
        repositories {
            google()
            mavenCentral()
            // 添加 jitpack 仓库，拉取 auikit 库
            maven { url = java.net.URI.create("https://www.jitpack.io") }
        }
    }

    // 项目名需为你的 Android Studio 项目的真实名称
    rootProject.name = "VoiceRoomApp"
    include(":app")
    // 添加 asceneskit 库到项目里
    include(":asceneskit")
    ```

3. 在 `<your_app>/app/build.gradle.kts` 文件中添加如下行：

    ```kotlin
    dependencies {
        ...

        // 添加 asceneskit 依赖
        implementation(project(":asceneskit"))
    }
    ```

4. 点击 **Sync Now** 按钮，等待 gradle 同步完成。//TODO 图

### 配置权限

本节介绍如何配置项目所需权限：

1. 在 `<your_app>/app/Manifests/AndroidManifest.xml` 文件中添加如下行，配置网络、录音等权限：

    ```xml
    <manifest xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:tools="http://schemas.android.com/tools">

        <!-- 网络权限 -->
        <uses-permission android:name="android.permission.INTERNET" />
        <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
        <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
        <!-- 录音权限 -->
        <uses-permission android:name="android.permission.RECORD_AUDIO" />
        <uses-permission android:name="android.permission.CALL_PHONE" />
        <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
        ...

    </manifest>
    ```

2. 如果你的后端服务 host url 不是 https 开头，那么你需要在 `<your_app>/app/Manifests/AndroidManifest.xml` 文件中添加如下高亮行：//TODO 后端 link

    ```xml
    <manifest xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:tools="http://schemas.android.com/tools">

        <!-- 网络权限 -->
        <uses-permission android:name="android.permission.INTERNET" />
        <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
        <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
        <!-- 录音权限 -->
        <uses-permission android:name="android.permission.RECORD_AUDIO" />
        <uses-permission android:name="android.permission.CALL_PHONE" />
        <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />

        <!-- highlight-start -->
        <application
            android:usesCleartextTraffic="true">
            ...
        </application>
        <!-- highlight-end -->

        ...

    </manifest>
    ```

### 配置主题

在 `<your_app>/app/src/main/res/values/themes.xml` 文件中添加如下行配置语聊房 UI 主题：

```xml
<resources>
    <!-- 将 VoiceRoomApp 改成你实际的项目名 -->
    <style name="Theme.VoiceRoomApp" parent="Theme.VoiceRoom" />
</resources>
```

### （可选）防止代码混淆

在 `<your_app>/app/proguard-rules.pro` 文件中添加如下行，以防止声网 SDK 的代码被混淆：

```kotlin
-keep class io.agora.**{*;}
-dontwarn javax.**
-dontwarn com.google.devtools.build.android.**
```

## 实现语聊房

### 1. 初始化 AUIVoiceRoomUiKit

### 2. 房主创建房间

#### 2.1 添加按钮：创建房间

#### 2.2 创建语聊房

### 3. 房主加入房间

#### 3.1 创建房间详情页

#### 3.2 启动房间

### 4. （可选）观众加入房间

#### 4.1 添加按钮：加入房间

#### 4.2 获取房间列表

### 5. （可选）退出或销毁房间


## 下一步

在创建、进入房间后，你可以参考如下业务流程图开发后续的麦位管理、聊天、礼物等功能。

![](https://web-cdn.agora.io/docs-files/1697095578162)