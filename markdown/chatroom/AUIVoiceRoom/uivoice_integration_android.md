本文介绍如何实现语聊房。

## 示例项目

声网提供 [AUIVoiceRoom](https://github.com/AgoraIO-Community/AUIVoiceRoom/tree/main) 示例项目供你参考。


## 业务流程图

本节展示语聊房中常见的业务流程。

![](https://web-cdn.agora.io/docs-files/1697095578162)

## 准备开发环境

### 前提条件

- [Android Studio](https://developer.android.com/studio/) 3.5 及以上。
- Android 手机，版本 Android 5.0（API Level 21）及以上。
- 可以访问互联网的计算机。确保你的网络环境没有部署防火墙，否则无法正常使用声网服务。
- 参考[开始使用声网平台](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)创建声网开发者账号和声网项目。

### 创建项目

本节介绍如何在 Android Studio 创建项目并集成语聊项目所需依赖：

1. 如需创建新项目，在 **Android Studio** 里，依次选择 **Phone and Tablet > Empty Activity**，创建 [Android 项目](https://developer.android.com/studio/projects/create-project)。

   <div class="alert note">创建项目后，<b>Android Studio</b> 会自动开始同步 gradle，稍等片刻至同步成功后再进行下一步操作。</div>

2. 集成语聊项目所需的 AScenesKit 和 AUIKit。AUIKit 已包含在 AScenesKit 依赖库中，因此集成步骤如下：

    1. 将示例项目中 `AUIVoiceRoom/Android/asceneskit` 文件夹复制到你的项目中。

    2. 在 `settings.gradle` 中添加如下行：

        ```java
        include ':asceneskit'
        ```

    3. 在 `build.gradle` 中添加如下行：

        ```java
        dependencies {
            ...
            implementation project(':asceneskit')
        }
        ```

3. 在 `/app/Manifests/AndroidManifest.xml` 文件中添加权限和主题：

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
        <!-- 存储权限 -->
        <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
        <!-- 手机状态权限 -->
        <uses-permission android:name="android.permission.READ_PHONE_STATE" />

        <!-- 应用主题 -->
        <application
            android:theme="@style/Theme.VoiceRoom.Voice"
            tools:replace="android:theme">
            ...
        </application>

    </manifest>
    ```

### 部署后端

参考[配置示例项目](//TODO)进行部署。

## 实现语聊房 //TODO

如下[时序图](#api-时序图)展示了如何登录即时通讯系统、获取房间列表、创建房间、进入房间、加入 RTC 频道、麦位管理、退出房间、离开 RTC 频道。声网云服务（Service）实现了房间列表的存储和房间生命周期的管理，声网即时通讯（IM）SDK 实现房间内的信令通信，声网 RTC SDK 承担实时音频的业务。本节会详细介绍如何调用声网云服务（`voiceServiceProtocol`）、IM SDK API、RTC SDK API 完成这些逻辑。

<div class="alert note">声网云服务为内部自研服务，暂不对外提供。你可以调用声网云服务的 API 用于测试，但是对于正式环境，声网建议你参考文档自行实现相似的一套服务。如需协助，请<a href="https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms">提交工单</a>。</div>


### 1. 获取房间列表

