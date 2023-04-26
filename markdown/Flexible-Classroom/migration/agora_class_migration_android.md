# 升级指南

## 升级源代码的建议

如果你通过源码方式集成灵动课堂，并且对源码进行了修改，那么当灵动课堂升级时，你需要进行相应升级。建议如下：

- 为了方便后续升级操作，建议对于需要修改的模块，通过源码方式引用；不需要修改的模块，通过 Maven 方式引用。
- 如果你需要修改灵动课堂的源码，建议将自己的业务封装在自己的类中，再引用到灵动课堂的模块代码，以便后续升级时减少代码冲突。
- 如果你修改的源码量少，可以直接通过 Beyond Compare 工具对比代码差异及合并。
- 如果你修改的源码量多，可参考以下步骤：
    假设你基于灵动课堂的 2.8.0 版本修改了源码，现要升级到 3.0.0 版本：
    1. 下载源码 [CloudClass-Android](https://github.com/AgoraIO-Community/CloudClass-Android)，并切换到 `release/2.8.0` 分支。
    2. 导入源码到 Android Studio。
    3. 在 Android Studio 中，右击 **CloudClass-Android**，选择 **Git** -> **Compare with Branch** -> **release/3.0.0**。
    4. 把两个版本代码的差异合并到自己项目中。


## 从 2.7.x 升级到  2.8.x

- 如果将灵动课堂所有 SDK 从之前版本升级到 2.8.0，不需要任何操作。

- 如果只升级 `AgoraEduCore` 模块，那么需要升级 `AgoraEduUIKit` 模块的 `AgoraRendererUtils` 类。因为从 2.8.0 版本开始，默认不再自动订阅所有的音视频，改为依据接口下发来控制。
  需要合并的代码参考 [`AgoraRendererUtils.kt`](https://github.com/AgoraIO-Community/CloudClass-Android/blob/release/2.8.0/AgoraEduUIKit/src/main/java/com/agora/edu/component/helper/AgoraRendererUtils.kt)。

- 如果你没有使用灵动课堂的组件，而是自定义了控制音视频流的逻辑，可参考以下代码实现： 

    ```kotlin
    // 订阅音频和停止订阅音频
    eduCore?.eduContextPool()?.mediaContext()?.startPlayAudio(roomUuid, streamUuid)
    eduCore?.eduContextPool()?.mediaContext()?.stopPlayAudio(roomUuid, streamUuid)

    // 订阅视频和停止订阅视频
    eduCoe?.eduContextPool()?.mediaContext()?.startRenderVideo(EduContextRenderConfig(mirrorMode = EduContextMirrorMode.DISABLED), viewGroup, streamUuid)
    eduCore?.eduContextPool()?.mediaContext()?.stopRenderVideo(streamUuid)
    ```

## 从 2.0.0 升级到  2.7.x

- 如果你使用 Maven 引用依赖库，需要在项目根目录的 `build.gradle` 文件中添加以下代码去除 hyphenate 依赖：

    ```
    implementation "io.github.agoraio-community:hyphenate:版本号"
    ```

    例如，你想获取 2.8.20 的版本，可以这样写：

    ```
    implementation "io.github.agoraio-community:hyphenate:2.8.20"
    ```

- 如果你引用 GitHub 仓库源码，则直接去除 hyphenate 模块即可。


## 从 1.1.5 升级至 2.0.0

在 2.0.0 版中，声网优化了声网 Classroom SDK 的内部架构，重新设计了 Edu Context API。

本节列出 2.0.0 与 1.1.5 在 Edu Context API 上的主要变动。

<div class="alert info">如需了解 Edu Context API 2.0.0 的具体信息，查看 <a href="/cn/agora-class/API%20Reference/edu_context_kotlin/v2.0.0/API/edu_context_api_overview.html" target="_blank">API 文档</a>。</div>

### Chat context

移除 `ChatContext` 和 `IChatHandler`。

### Whiteboard context

移除 `WhiteboardContext`、`IWhiteboardHandler`。2.0.0 中白板功能在 `AgoraUIKit` 中实现。

### Device context

移除 `DeviceContext` 和 `IDeviceHandler`，该类提供的方法和回调由 `MediaContext` 和 `IMediaHandler` 代替，具体如下：

- `getDeviceConfig` 由 `getLocalDeviceState` 代替。
- `setCameraDeviceEnable`、`switchCameraFacing`、`setMicDeviceEnable`、`setSpeakerEnable` 由 `openSystemDevice` 和 `closeSystemDevice` 代替。
- 移除 `setDeviceLifecycle`。2.0.0 中 SDK 不再进行设备状态的维护。
- `onCameraDeviceEnableChanged`、`onCameraFacingChanged`、`onMicDeviceEnabledChanged`、`onSpeakerEnabledChanged` 由 `onLocalDeviceStateUpdated` 替代。
- 移除 `onDeviceTips`。

### Hands-up context

移除 `HandsUpContext` 和 `IHandsUpHandler`，该类提供的方法和回调由 `UserContext` 和 `IUserHandler` 代替，具体如下：

- `performHandsUp` 由 `handsWave` 和 `handsDown` 代替。
- `onHandsUpEnabled` 由 `onHandsWaveEnabled` 代替。
- `onHandsUpStateUpdated`、`onHandsUpStateResultUpdated`  由 `onUserHandsWave` 和 `onUserHandsDown` 代替。
- 移除 `onHandsUpTips`。

### Room context

- `roomInfo` 由 `getRoomInfo` 代替。
- `leave` 由 `leaveRoom` 代替。
- `uploadLog` 移至 `MonitorContext`。
- `updateFlexRoomProps` 由 `updateRoomProperties` 和 `deleteRoomProperties` 代替。
- `joinClassroom` 更名为 `joinRoom`。
- 移除 `onClassroomName`。你可通过 `getRoomInfo` 获取房间名称。
- `onClassState` 更名为 `onClassStateUpdated`。
- 移除 `onClassTime`。
- 移除 `onNetworkStateChanged`，由 `IMonitorHandler` 中的`onLocalNetworkQualityUpdated` 代替。
- 移除 `onLogUploaded`。如需获取日志 `serailNumber`，可通过`MonitorContext` 中的 `uploadLog` 方法中的回调函数获取。
- 移除 `onConnectionStateChanged`，由 `IMonitorHandler` 中的`onLocalConnectionUpdated` 代替。
- 移除 `onClassTip`。
- 移除 `onFlexRoomPropsInitialized`。如需在加入房间成功后获取房间自定义属性，可调用`getRoomProperties`。
- 移除 `onFlexRoomPropsChanged`，由 `onRoomPropertiesUpdated` 和 `onRoomPropertiesDeleted` 代替。
- 移除 `onError`。
- 移除 `onClassroomJoinSuccess` 和 `onClassroomJoinFail`。由 `joinRoom` 中的 `callback` 代替。
- `onClassroomLeft` 由 `onRoomClosed` 代替。

### Screen-sharing context

- 移除 `ScreenShareContext`，由 `StreamContext` 代替。当 `AgoraEduContextStreamInfo` 里 `videoSourceType` 为 `Screen` 时，可以判断为屏幕共享视频流。
- 移除 `IScreenShareHandler`，由 `IStreamHandler` 代替。`onScreenShareStateUpdated` 由 `IStreamHandler` 中的`onStreamJoined`、`onStreamLeft`、`onStreamUpdated` 代替。

### User context

- `localUserInfo` 由 `getLocalUserInfo` 代替。
- 移除 `muteVideo`、`muteAudio`，由 `StreamContext` 中的 `muteStreams` 代替。
- 移除 `renderVideo`，由 `MediaContext` 中的`startRenderLocalVideo` 和 `startRenderRemoteVideo` 代替。
- 移除 `updateFlexUserProps`，由 `updateUserProperties` 和 `deleteUserProperties` 代替。
- 移除 `setVideoEncoderConfig`，由 `StreamContext`中的 `setLocalVideoConfig` 代替。
- 移除 `onUserListUpdated`，其功能 由 `UserContext` 中的`getAllUserList`、`getUserList` 方法和 `UserHandler` 中的 `onRemoteUserJoined`、`onRemoteUserLeft`、`onUserUpdated` 代替。
- 移除 `onCoHostListUpdated`，由 `onCoHostUserListAdded`、`onCoHostUserListRemoved` 代替，也可通过 `UserContext` 中的 `getCoHostList` 获取所有台上用户信息。
- `onUserReward` 更名为 `onUserRewarded`。
- `onKickOut` 更名为 `onLocalUserKickedOut`。
- 移除 `onUserTip`、`onRoster`。
- 移除 `onFlexUserPropsChanged`，其功能由 `IUserHandler` 中的 `onUserPropertiesUpdated`、`onUserPropertiesDeleted` 代替，也可通过 `UserContext` 中的 `getUserProperties` 获取自定义的用户属性。