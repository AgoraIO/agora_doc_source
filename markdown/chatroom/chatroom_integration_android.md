本文介绍如何实现语聊房。

## 示例项目

声网在 [agora-ent-scenarios](https://github.com/AgoraIO-Usecase/agora-ent-scenarios) 仓库中提供[语聊房（普通版）](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/v3.0.0-all-Android/Android/scenes/voice)供你参考。

## 业务流程图

本节展示语聊房中常见的业务流程。

### 进出房间

下图展示创建、进入、退出房间的流程。

![](https://web-cdn.agora.io/docs-files/1690957909911)

### 房主邀请听众上麦

下图展示房主邀请听众上麦的流程。在这个流程中，房主发起上麦邀请，如果听众接受邀请，房主会收到通知。听众上麦并修改麦位，然后发布自己的音频流。

![](https://web-cdn.agora.io/docs-files/1690957919691)

### 听众申请上麦

下图展示听众向房主申请上麦的流程。在这个流程中，听众主动发起上麦申请，如果房主接受申请，房主修改麦位信息以让听众上麦。听众收到上麦消息后，发布自己的音频流。

![](https://web-cdn.agora.io/docs-files/1690957930139)

## 准备开发环境

### 前提条件

- [Android Studio](https://developer.android.com/studio/) 3.5 及以上。
- Android 手机，版本 Android 5.0（API Level 21）及以上。
- 可以访问互联网的计算机。确保你的网络环境没有部署防火墙，否则无法正常使用声网服务。
- 参考[开始使用声网平台](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)创建声网开发者账号和声网项目。

### 创建项目

秀场直播用到声网 RTC SDK 和即时通讯（IM）SDK。本节介绍如何在 Android Studio 创建项目并集成这两个 SDK：

1. 如需创建新项目，在 **Android Studio** 里，依次选择 **Phone and Tablet > Empty Activity**，创建 [Android 项目](https://developer.android.com/studio/projects/create-project)。

   <div class="alert note">创建项目后，<b>Android Studio</b> 会自动开始同步 gradle, 稍等片刻至同步成功后再进行下一步操作。</div>

2. 使用 Maven Central 将声网 RTC SDK 集成到你的项目中。

   a. 在 `/Gradle Scripts/build.gradle(Project: <projectname>)` 文件中添加如下代码，添加 Maven Central 依赖：

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

    <div class="alert note">如果你的 Android 项目设置了 <a href="https://docs.gradle.org/current/userguide/declaring_repositories.html#sub:centralized-repository-declaration">dependencyResolutionManagement</a>，添加 Maven Central 依赖的方式可能存在差异。</div>

   b. 在 `/Gradle Scripts/build.gradle(Module: <projectname>.app)` 文件中添加如下代码，将声网 RTC SDK 集成到你的 Android 项目中：

   ```java
   ...
    dependencies {
        ...
        // x.y.z，请填写具体的 RTC SDK 版本号，如：4.0.0 或 4.1.0-1
        // 通过互动直播产品发版说明获取最新版本号
        implementation 'io.agora.rtc:full-sdk:x.y.z'
        // x.y.z，请填写具体的 IM SDK 版本号，如：1.1.0。
        // 通过即时通讯产品发版说明获取最新版本号
        implementation 'io.agora.rtc:chat-sdk:x.y.z'
     }
   ```

3. 添加网络及设备权限。

   在 `/app/Manifests/AndroidManifest.xml` 文件中，在 `</application>` 后面添加如下权限：

   ```xml
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.RECORD_AUDIO"/>
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS"/>
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <uses-permission android:name="android.permission.BLUETOOTH"/>
    <!-- 对于 Android 12.0 及以上且集成 v4.1.0 以下声网 RTC SDK 的设备，还需要添加以下权限 -->
    <uses-permission android:name="android.permission.BLUETOOTH_CONNECT"/>
    <!-- 对于 Android 12.0 及以上设备，还需要添加以下权限 -->
    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
    <uses-permission android:name="android.permission.BLUETOOTH_SCAN"/>
   ```

4. 在 `/Gradle Scripts/proguard-rules.pro` 文件中添加如下行，以防止声网 SDK 的代码被混淆：

   ```java
   -keep class io.agora.**{*;}
   -dontwarn javax.**
   -dontwarn com.google.devtools.build.android.**
   ```

## 实现语聊房

如下[时序图](#api-时序图)展示了如何登录即时通讯系统、获取房间列表、创建房间、进入房间、加入 RTC 频道、麦位管理、退出房间、离开 RTC 频道。声网云服务（Service）实现了房间列表的存储和房间生命周期的管理，声网即时通讯（IM）SDK 实现房间内的信令通信，声网 RTC SDK 承担实时音视频的业务。本节会详细介绍如何调用声网云服务（voiceServiceProtocol）、IM SDK API、RTC SDK API 完成这些逻辑。

<div class="alert note">声网云服务为内部自研服务，暂不对外提供。你可以调用声网云服务的 API 用于测试，但是对于正式环境，声网建议你参考文档自行实现相似的一套服务。如需协助，请<a href="https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms">提交工单</a>。</div>


### 1. 获取房间列表

调用声网云服务中 `voiceServiceProtocol` 类的 `fetchRoomList` 方法获取房间列表。获取到房间列表后刷新 UI 并将房间列表展示在界面上。

```kotlin
voiceServiceProtocol.fetchRoomList(page, completion = { error, result ->
    // ...
})
```

### 2. 登录即时通讯系统

参考如下步骤登录即时通讯（IM）系统：

1. 根据[前提条件](#前提条件)在声网控制台创建声网项目后，参考[开启和配置即时通讯服务](https://docs-preprod.agora.io/cn/agora-chat/enable_agora_chat?platform=All%20Platforms)，在声网控制台为你的声网项目开启并配置即时通讯服务。
2. 参考[即时通讯集成概述](https://docs-preprod.agora.io/cn/agora-chat/integration_overview_android?platform=Android#用户登录)，获取登录即时通讯系统所需的用户名（ID）和 Token。
3. 调用声网即时通讯（IM）SDK 中 `ChatClient` 类的 [`loginWithToken`](https://docs-preprod.agora.io/cn/agora-chat/API%20Reference/im_java/v1.1.0/classio_1_1agora_1_1chat_1_1_chat_client.html#ac2b19ffdcd879b5f239baacbaa09423b) 方法并传入即时通讯服务的用户名和 Token 以登录即时通讯系统。


```kotlin
public void login(String uid,String token,CallBack callBack){
    ChatClient.getInstance().loginWithToken(uid, token, new CallBack() {
        @Override
        public void onSuccess() {
            ThreadManager.getInstance().runOnMainThread(new Runnable() {
                @Override
                public void run() {
                    callBack.onSuccess();
                }
            });
            LogTools.d("ChatroomConfigManager","Login success");
        }

        @Override
        public void onError(int code, String msg) {
            ThreadManager.getInstance().runOnMainThread(new Runnable() {
                @Override
                public void run() {
                    callBack.onError(code,msg);
                }
            });
            LogTools.e("ChatroomConfigManager", "Login onError code:" + code + " desc: " + msg);
        }
    });
}
```

### 3. 初始化 RtcEngine

参考如下步骤初始化 RtcEngine：

1. 根据[前提条件](#前提条件)在声网控制台创建声网项目后，复制界面的 App ID。
2. 调用声网 RTC SDK 中的 `create` 方法创建并初始化 `RtcEngine`。

```kotlin //TODO add code
let rtcKit: RtcEngine = RtcEngine.sharedEngine(withAppId: KeyCenter.AppId, delegate: nil)
```
### 4. 创建并进入房间

1. 调用 `voiceServiceProtocol` 对象中的 `createRoom` 方法创建一个房间。

    ```kotlin
    val voiceCreateRoomModel = VoiceCreateRoomModel(
        roomName = roomName,
        soundEffect = soundEffect,
        isPrivate = !TextUtils.isEmpty(password),
        password = password ?: "",
        roomType = roomType
    )
    voiceServiceProtocol.createRoom(voiceCreateRoomModel, completion = { error, result ->
        when (error) {
            VoiceServiceProtocol.ERR_OK -> {
                callBack.onSuccess(createLiveData(result))
            }
            VoiceServiceProtocol.ERR_ROOM_NAME_INCORRECT -> {
                callBack.onError(error, "")
            }
            else -> {
                callBack.onError(error, "")
            }
        }
    })
    ```

2. 调用 `voiceServiceProtocol` 对象的 `joinRoom` 方法进入房间。

    ```kotlin
    voiceServiceProtocol.joinRoom(roomId, completion = { error, result ->
        when (error) {
            VoiceServiceProtocol.ERR_OK -> {
                callBack.onSuccess(createLiveData(result))
            }
            VoiceServiceProtocol.ERR_ROOM_UNAVAILABLE -> {
                callBack.onError(error, "room is not existent")
            }
            else -> {
                callBack.onError(error, "")
            }
        }
    })
    ```

3. 语聊房里需要有消息聊天和语音聊天，因此你还需进行如下操作：
    - 调用声网 IM SDK 中 `joinChatRoom` 实现房间内的消息互动。方法中的参数含义和支持取值请参考 [`joinChatRoom`](https://docs-preprod.agora.io/cn/agora-chat/API%20Reference/im_java/v1.1.0/classio_1_1agora_1_1chat_1_1_chat_room_manager.html#a895dbd6d0217ba08bcf2dbb6cf441591)。
    - 调用声网 RTC SDK 中 `RtcEngine` 类的 `joinChannel` 加入 RTC 频道以实现房间内的实时音频通话。方法中的参数含义和支持取值请参考 [`joinChannelByToken`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_joinchannel)。在这一步里需要填写声网 RTC Token。你可以参考[开始使用声网平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)从声网控制台获得临时用途的声网 RTC Token。你也可以参考[使用 Token 鉴权](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/token_server_ios_ng?platform=iOS)获取正式用途的声网 RTC Token。临时 Token 的有效期为 24 小时，建议你仅在测试用途下使用。

    ```kotlin
    // 实现房间内的消息互动
    public void joinRoom(String chatroomId, ValueCallBack<ChatRoom> callBack){
        ChatClient.getInstance().chatroomManager()
                .joinChatRoom(chatroomId, new ValueCallBack<ChatRoom>() {
                    @Override
                    public void onSuccess(ChatRoom value) {
                        ThreadManager.getInstance().runOnMainThreadDelay(new Runnable() {
                            @Override
                            public void run() {
                                callBack.onSuccess(value);
                            }
                        },200);
                    }

                    @Override
                    public void onError(int error, String errorMsg) {
                        ThreadManager.getInstance().runOnMainThread(new Runnable() {
                            @Override
                            public void run() {
                                callBack.onError(error,errorMsg);
                            }
                        });
                    }
                });
    }
    ```

    ```kotlin
    // 实现房间内的语音互动 //TODO add comment
    rtcEngine?.apply {
        when (soundEffect) {
            ConfigConstants.SoundSelection.Social_Chat,
            ConfigConstants.SoundSelection.Karaoke -> { // 社交语聊，ktv
                setChannelProfile(Constants.CHANNEL_PROFILE_LIVE_BROADCASTING)
                setAudioProfile(Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY)
                setAudioScenario(Constants.AUDIO_SCENARIO_GAME_STREAMING)
            }
            ConfigConstants.SoundSelection.Gaming_Buddy -> { // 游戏陪玩
                setChannelProfile(Constants.CHANNEL_PROFILE_COMMUNICATION)
            }
            else -> { //专业主播
                setAudioProfile(Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY)
                setAudioScenario(Constants.AUDIO_SCENARIO_GAME_STREAMING)
                setParameters("{\"che.audio.custom_payload_type\":73}")
                setParameters("{\"che.audio.custom_bitrate\":128000}")
                // setRecordingDeviceVolume(128) 4.0.1上才支持
                setParameters("{\"che.audio.input_channels\":2}")
            }
        }
    }
    //TODO add comment token
    val status = rtcEngine?.joinChannel(VoiceBuddyFactory.get().getVoiceBuddy().rtcToken(), channelId, "", rtcUid)
    // 启用用户音量提示。
    rtcEngine?.enableAudioVolumeIndication(1000, 3, false)
    ```

### 5. 麦位管理

具体步骤详见[麦位管理](./chatroom_mic_seat_android)。

### 6. 退出房间

1. 调用 `voiceServiceProtocol` 对象的 `leaveRoom` 方法离开房间。

    ```kotlin
    voiceServiceProtocol.leaveRoom(roomId, isRoomOwnerLeave, completion = { error, result ->
        // ...
    })
    ```


2. 调用 `RtcEngine` 类的 [`leaveChannel`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_leavechannel) 方法离开 RTC 频道。

    ```kotlin
    rtcEngine?.leaveChannel()
    ```

3. 调用 [`leaveChatRoom`](https://docs-preprod.agora.io/cn/agora-chat/API%20Reference/im_java/v1.1.0/classio_1_1agora_1_1chat_1_1_chat_room_manager.html#a4f2c430782206971480c73a49311b1437) 离开聊天室，调用 [`destroyChatroom`](https://docs-preprod.agora.io/cn/agora-chat/API%20Reference/im_java/v1.1.0/classio_1_1agora_1_1chat_1_1_chat_room_manager.html?transId=194274c0-bee4-11ed-b167-a39cc89dc96e#a0d50d2e34d9992fc3f8ea1c82e2db1a7) 销毁聊天室。调用 [`destroy`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_release) 销毁 RTC 引擎。

    ```kotlin
    ChatroomIMManager.getInstance().leaveChatRoom(roomKitBean.chatroomId)
    ChatroomIMManager.getInstance().asyncDestroyChatRoom(roomKitBean.chatroomId, object :
        CallBack {
        override fun onSuccess() {}
        override fun onError(code: Int, error: String?) {}
    })
    RtcEngineEx.destroy()
    rtcEngine = null
    ```

### API 时序图

![](https://web-cdn.agora.io/docs-files/1690957970178)