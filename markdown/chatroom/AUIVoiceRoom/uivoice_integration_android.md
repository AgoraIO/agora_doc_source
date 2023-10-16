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

调用声网云服务中 `voiceServiceProtocol` 类的 `fetchRoomList` 方法获取房间列表。获取到房间列表后刷新 UI 并将房间列表展示在界面上。

```kotlin
voiceServiceProtocol.fetchRoomList(page, completion = { error, result ->
    ...
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
2. 调用声网 RTC SDK 中的 [`create`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_initialize) 方法创建并初始化 `RtcEngine`。

```kotlin
// 初始化配置
val config = RtcEngineConfig()
// 设置 App ID
config.mAppId = "YourAppId"
// 创建 RtcEngine 实例
val rtcEngine = RtcEngineEx.create(config) as RtcEngineEx
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

    - 调用声网 RTC SDK 中 `RtcEngine` 类的 `joinChannel` 加入 RTC 频道以实现房间内的实时音频通话。方法中的参数含义和支持取值请参考 [`joinChannel`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_joinchannel)。在这一步里需要填写声网 RTC Token。你可以参考[开始使用声网平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)从声网控制台获得临时用途的声网 RTC Token。你也可以参考[使用 Token 鉴权](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/token_server_android_ng?platform=Android)获取正式用途的声网 RTC Token。临时 Token 的有效期为 24 小时，建议你仅在测试用途下使用。
    你还可以调用 [`setChannelProfile`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_setchannelprofile)、[`setAudioProfile`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#api_irtcengine_setaudioprofile2)、[`setAudioScenario`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#api_irtcengine_setaudioscenario)、[`setParameters`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_network.html#api_irtcengine_setparameters) 来为不同业务场景（语聊社交、KTV、游戏陪玩、专业音频直播场景）设置语聊房的最佳音效。

        ```kotlin
        // 实现房间内的语音互动
        rtcEngine?.apply {
            when (soundEffect) {
                // 在线 K 歌房和泛娱乐社交场景下推荐设置
                ConfigConstants.SoundSelection.Social_Chat,
                ConfigConstants.SoundSelection.Karaoke -> {
                    // 设置频道属性为直播
                    setChannelProfile(Constants.CHANNEL_PROFILE_LIVE_BROADCASTING)
                    // 设置 48 kHz 采样率，音乐编码，单声道，编码码率最大值为 96 Kbps
                    setAudioProfile(Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY)
                    // 设置为高音质场景
                    setAudioScenario(Constants.AUDIO_SCENARIO_GAME_STREAMING)
                }
                // 1 对 1 游戏陪玩通话场景下推荐
                ConfigConstants.SoundSelection.Gaming_Buddy -> {
                    // 设置频道属性为通信
                    setChannelProfile(Constants.CHANNEL_PROFILE_COMMUNICATION)
                }
                else -> {
                    // 专业音频直播场景下推荐设置
                    // 设置频道属性为直播
                    setChannelProfile(Constants.CHANNEL_PROFILE_LIVE_BROADCASTING)
                    // 指定 48 kHz 采样率，音乐编码，双声道，编码码率最大值为 128 Kbps
                    setAudioProfile(Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY)
                    // 设置为高音质场景
                    setAudioScenario(Constants.AUDIO_SCENARIO_GAME_STREAMING)
                    // 设置私有参数以获得好的实时音频互动体验
                    setParameters("{\"che.audio.custom_payload_type\":73}")
                    setParameters("{\"che.audio.custom_bitrate\":128000}")
                    setParameters("{\"che.audio.input_channels\":2}")
                }
            }
        }
        // 加入 RTC 频道
        // 此处的 Token 为声网 RTC Token
        val status = rtcEngine?.joinChannel(VoiceBuddyFactory.get().getVoiceBuddy().rtcToken(), channelId, "", rtcUid)
        ```

### 5. 麦位管理

具体步骤详见[麦位管理](./chatroom_mic_seat_android)。

### 6. 退出房间

1. 调用 `voiceServiceProtocol` 对象的 `leaveRoom` 方法离开房间。

    ```kotlin
    voiceServiceProtocol.leaveRoom(roomId, isRoomOwnerLeave, completion = { error, result ->
        ...
    })
    ```


2. 调用 `RtcEngine` 类的 [`leaveChannel`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_leavechannel) 方法离开 RTC 频道。

    ```kotlin
    rtcEngine?.leaveChannel()
    ```

3. 调用 [`leaveChatRoom`](https://docs-preprod.agora.io/cn/agora-chat/API%20Reference/im_java/v1.1.0/classio_1_1agora_1_1chat_1_1_chat_room_manager.html#a4f2c430782206971480c73a49311b1437) 离开聊天室，调用 [`asyncDestroyChatRoom`](https://docs-preprod.agora.io/cn/agora-chat/API%20Reference/im_java/v1.1.0/classio_1_1agora_1_1chat_1_1_chat_room_manager.html?transId=194274c0-bee4-11ed-b167-a39cc89dc96e#a0d50d2e34d9992fc3f8ea1c82e2db1a) 销毁聊天室。调用 [`destroy`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_release) 销毁 RTC 引擎。

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

![](https://web-cdn.agora.io/docs-files/1691399288269)