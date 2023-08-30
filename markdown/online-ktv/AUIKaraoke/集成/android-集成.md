# 实现在线 K 歌房

本文介绍如何通过 [AUIKitKaraoke 组件](#)快速搭建一个含 UI 界面的在线 K 歌房。

下图展示搭建 K 歌房间的流程：

<img src="/Users/admin/Library/Application Support/typora-user-images/image-20230830103826589.png" alt="image-20230830103826589" style="zoom:50%;" />

## 准备开发环境

### 前提条件

- [Git](https://git-scm.com/downloads)
- Android API Level 24 及以上
- Android Studio 3.5 及以上
- Android 设备，版本 Android 7.0 及以上
- [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html) 17 及以上

<Admonition type="caution" title="注意">

声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。

</Admonition>

### 创建项目

按照以下步骤来准备开发环境：

1. 如需创建新项目，在 **Android Studio** 里，依次选择 **Phone and Tablet > Empty Activity**，创建 [Android 项目](https://developer.android.com/studio/projects/create-project)。

   <Admonition type="info" title="信息">创建项目后，**Android Studio** 会自动开始同步 gradle, 稍等片刻至同步成功后再进行下一步操作。

   </Admonition>

2. 集成 asceneskit。

   1. 将 [asceneskit 文件夹](https://github.com/AgoraIO-Community/AUIKitKaraoke/tree/main/Android/asceneskit)复制到你的项目中。
   
   2. 在 `settings.gradle` 文件中添加 asceneskit 库：
   
      ```java
      include ':asceneskit'
      ```
   
   3. 在 `build.grade` 文件中添加以下依赖：
   
      ```java
      dependencies {
          implementation project(':asceneskit')
      }
      ```
   
   4. 添加权限并设置主题。在你的 `AndroidManifest.xml` 文件中添加下列内容：
   
      ```java
      <manifest xmlns:android="http://schemas.android.com/apk/res/android"
          xmlns:tools="http://schemas.android.com/tools">
      
          <uses-permission android:name="android.permission.INTERNET" />
          <uses-permission android:name="android.permission.RECORD_AUDIO" />
          <uses-permission android:name="android.permission.CAMERA" />
          <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
          <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
          <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" /> 
          <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
          <uses-permission android:name="android.permission.CALL_PHONE" />
      
          <application
              android:theme="@style/Theme.AKaraoke"
              tools:replace="android:theme">
              
              ...
      
          </application>
      
      </manifest>
      ```
   
   5. 配置你的业务服务器域名。在你的项目的 `local.properties` 文件中添加你的业务服务器域名。你可以参考[后台服务](https://github.com/AgoraIO-Community/AUIKitKaraoke/blob/main/backend/README_zh.md)来搭建你的业务服务器，也可以使用声网用于测试的域名来体验：https://service.agora.io/uikit-karaoke
   
      ![image-20230830113539829](/Users/admin/Library/Application Support/typora-user-images/image-20230830113539829.png)
   
      ```java
      SERVER_HOST=你的业务服务器域名
      ```

## 实现在线 K 歌房

