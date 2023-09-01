# 实现在线 K 歌房

本文介绍如何通过 [AUIKitKaraoke 组件](#)快速搭建一个含 UI 界面的在线 K 歌房。

下图展示搭建 K 歌房间的完整流程：

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

- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora Platform/sign_in_and_sign_up)和声网项目，请参考[开始使用声网平台](https://docs.agora.io/cn/Agora Platform/get_appid_token?platform=All Platforms)，从声网控制台获取以下信息：
  - App ID：声网随机生成的字符串，用于识别你的 app。
  - 临时 Token：你的 app 客户端加入频道时会使用 Token 对用户进行鉴权。临时 Token 的有效期为 24 小时。
  - rtm token xxxx

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

下图展示了创建一个在线 K 歌房的 API 调用时序：

<img src="/Users/admin/Library/Application Support/typora-user-images/image-20230830161719228.png" alt="image-20230830161719228" style="zoom:50%;"/>

### 1. 初始化 KaraokeUiKit

创建 `AUiCommonConfig` 对象，调用 `setup` 初始化 KaraokeUiKit。

```java
// 创建 AUiCommonConfig 对象
val config = AUiCommonConfig()
config.context = application
// 获取你在声网控制台获取的 app ID
config.appId = "Agora APP ID"
// 用户 ID
config.userId = "User ID"
// 用户名
config.userName = "User Name"
// 用户头像
config.userAvatar = "User Avatar"
// 初始化
KaraokeUiKit.setup(
    // AUiCommonConfig 对象
    config = config,
    // RtmClient 实例。如果的你的项目中还未集成声网 RTM SDK，请传入 null，KaraokeUiKit 内部会自行创建
    rtmClient = null,
    // RtcEngineEx 实例。如果的你的项目中还未集成声网 RTC SDK，请传入 null，KaraokeUiKit 内部会自行创建
    rtcEngineEx = null, 
    // KtvApi 实例。如果你的项目中还未集成 KtvApi，请传入 null，KaraokeUiKit 内部会自行创建
    ktvApi = null
)
```

### 2. 创建房间

调用 `createRoom` 创建房间。在创建房间之前，请确保你已经调用 `setup` 成功初始化。

```kotlin
val createRoomInfo = AUiCreateRoomInfo()
createRoomInfo.roomName = roomName
// 创建房间
KaraokeUiKit.createRoom(
    createRoomInfo,
    success = { roomInfo ->
        // 创建房间成功时调用
    },
    failure = { error ->
        // 创建房间失败时调用
    }
)
```

### 3. 获取房间列表

调用 `getRoomList` 获取已创建房间的列表。

```kotlin
// 获取房间列表 TODO 这里的参数名是lastCreateTime，但是api参考以及代码仓库里面都是startTime
KaraokeUiKit.getRoomList(lastCreateTime, 10,
    // 房间创建成功时调用
    success = { roomList ->
        runOnUiThread {
            
        }
    },
   // 房间创建失败时调用  
    failure = { error ->
        runOnUiThread {
            // update ui
        }
    }
)
```

### 4. 拉起房间

调用 `launchRooom` 拉起房间。至此，你已经成功搭建一个自带 UI 界面的在线 K 歌房间。

<Abmonition tpye="caution" title="注意">在调用该方法前，你需要先调用 <code>getRoomList</code> 获取房间列表及相关房间信息。</Abmonition>

```kotlin
// 房间信息，通过 getRoomList 获取
val roomInfo : AUIRoomInfo
val karaokeRoomView: KaraokeRoomView
val config = AUiRoomConfig(roomInfo.roomId)
// 生成config.channelName及AUIRoomContext.shared().currentUserInfo.userId的token
config.rtmToken = ""
config.rtcToken = ""
// 生成config.rtcChannelName及AUIRoomContext.shared().currentUserInfo.userId的token
config.rtcRtmToken = ""
//
config.rtcRtcToken = ""
// 生成config.rtcChorusChannelName及AUIRoomContext.shared().currentUserInfo.userId的token
config.rtcChorusRtcToken = ""
// 拉起房间
KaraokeUiKit.launchRoom(
    roomInfo,
    config, 
    karaokeRoomView
)

// 订阅房间事件
KaraokeUiKit.bindRespDelegate(object: AUIRoomManagerRespDelegate{
    override fun onRoomDestroy(roomId: String){
        // 房间被销毁
    }
})
```

### 5. 销毁房间

K 歌结束后，调用 `destroyRoom` 销毁房间。

```kotlin
KaraokeUiKit.destroyRoom(roomId)
// 取消订阅房间事件
KaraokeUiKit.unbindRespDelegate(this@RoomActivity)
```

