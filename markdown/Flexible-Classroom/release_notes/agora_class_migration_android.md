
## 从 1.1.5 升级至 2.0.0

在 2.0.0 版中，Agora 优化了 Agora Classroom SDK 的内部架构，重新设计了 Agora Edu Context API。

本节列出 2.0.0 与 1.1.5 在 Edu Context API 上的主要变动。

<div class="alert info">如需了解 Agora Edu Context API 2.0.0 的具体信息，查看 <a href="/cn/agora-class/API%20Reference/edu_context_kotlin/v2.0.0/API/edu_context_api_overview.html" target="_blank">API 文档</a>。</div>

### Chat context

移除 `ChatContext` 和 `IChatHandler`。

### Whiteboard context

移除 `WhiteboardContext`、`IWhiteboardHandler`。2.0.0 中白板功能在 `AgoraUIKit` 中实现。

### Device context

移除 `DeviceContext` 和 `IDeviceHandler`，该类提供的方法和回调由 `MediaContext` 和 `IMediaHandler` 代替，具体如下：

- 移除 `getDeviceConfig`，由 `getLocalDeviceState` 代替。
- 移除 `setCameraDeviceEnable`、`switchCameraFacing`、`setMicDeviceEnable`、`setSpeakerEnable`，由 `openSystemDevice` 和 `closeSystemDevice` 代替。
- 移除 `setDeviceLifecycle`。2.0.0 中 SDK 不再进行设备状态的维护。
- 移除 `onCameraDeviceEnableChanged`、`onCameraFacingChanged`、`onMicDeviceEnabledChanged`、`onSpeakerEnabledChanged`，由 `onLocalDeviceStateUpdated` 代替。
- 移除 `onDeviceTips`。

### Hands-up context

移除 `HandsUpContext` 和 `IHandsUpHandler`，该类提供的方法和回调由 `UserContext` 和 `IUserHandler` 代替，具体如下：

- 移除 `performHandsUp`，由 `handsWave` 和 `handsDown` 代替。
- 移除 `onHandsUpEnabled`，由 `onHandsWaveEnabled` 代替。
- 移除 `onHandsUpStateUpdated`、`onHandsUpStateResultUpdated`，由 `onUserHandsWave` 和 `onUserHandsDown` 代替。
- 移除 `onHandsUpTips`。

### Room context

- 移除 `roomInfo`，由 `getRoomInfo` 代替。
- 移除 `leave`，由 `leaveRoom` 代替。
- `uploadLog` 移至 `MonitorContext`。
- 移除 `updateFlexRoomProps`，由 `updateRoomProperties` 和 `deleteRoomProperties` 代替。
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

- 移除 `localUserInfo`，由 `getLocalUserInfo` 代替。
- 移除 `muteVideo`、`muteAudio`，由 `StreamContext` 中的 `muteStreams` 代替。
- 移除 `renderVideo`，由 `MediaContext` 中的`startRenderLocalVideo` 和 `startRenderRemoteVideo` 代替。
- 移除 `updateFlexUserProps`，由 `updateUserProperties` 和 `deleteUserProperties` 代替。
- 移除 `setVideoEncoderConfig`，由 `StreamContext`中的 `setLocalVideoConfig` 代替。
- 移除 `onUserListUpdated`，其功能由 `UserContext` 中的`getAllUserList`、`getUserList` 方法和 `UserHandler` 中的 `onRemoteUserJoined`、`onRemoteUserLeft`、`onUserUpdated` 代替。
- 移除 `onCoHostListUpdated`，由 `onCoHostUserListAdded`、`onCoHostUserListRemoved` 代替，也可通过 `UserContext` 中的 `getCoHostList` 获取所有台上用户信息。
- `onUserReward` 更名为 `onUserRewarded`。
- `onKickOut` 更名为 `onLocalUserKickedOut`。
- 移除 `onUserTip`、`onRoster`。
- 移除 `onFlexUserPropsChanged`，其功能由 `IUserHandler` 中的 `onUserPropertiesUpdated`、`onUserPropertiesDeleted` 代替，也可通过 `UserContext` 中的 `getUserProperties` 获取自定义的用户属性。