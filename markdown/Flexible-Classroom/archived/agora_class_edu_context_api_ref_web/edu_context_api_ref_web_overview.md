<div class="alert note">本页仅适用于灵动课堂 1.1.5 及之前版本。</div>

## Overview

Agora Classroom SDK 通过 Edu Context 为 App 开发者提供实现灵动课堂业务功能的能力。

![](https://web-cdn.agora.io/docs-files/1619696813295)

不同的 Context 代表灵动课堂中不同的业务功能模块，每个 Context 既包含供 App 调用的方法，也会向 App 报告事件回调。

Agora Classroom SDK 提供以下 Context：

## ChatContext

`ChatContext` 提供消息聊天相关能力。

### isHost

```typescript
isHost: boolean,
```

角色是否为教师或助教。

### getHistoryChatMessage

```typescript
getHistoryChatMessage: (data: {
    nextId: string;
    sort: number;
})=>Promise<any>,
```

获取历史聊天消息。

调用示例：

```javascript
getHistoryChatMeassage({nextId: "idstring", sort: 1});
```

| 参数     | 描述                                                                                     |
| :------- | :--------------------------------------------------------------------------------------- |
| `nextId` | 用于分批获取消息。第一次传空字符串。返回结果里有一个 `nextId` 字段，下一批获取传入该值。 |
| `sort`   | <li>`0`: 正序获取历史聊天消息。</li> <li>`1` : 倒序获取历史聊天消息。</li>               |

### messageList

```typescript
messageList: array,
```

聊天消息列表。

### sendMessage

```typescript
sendMessage: (message: any) => Promise<{
    id: string,
    ts: number,
    text: any,
    account: string,
    sender: boolean,
    messageId: string,
    fromRoomName: string,
}>,
```

发送聊天消息。

| 参数      | 描述       |
| :-------- | :--------- |
| `message` | 聊天消息。 |

### muteChat

```typescript
muteChat: () => void,
```

禁止聊天。

### unmuteChat

```typescript
unmuteChat: () => void,
```

取消禁止聊天。

### chatCollapse

```typescript
chatCollapse: boolean,
```

是否折叠聊天消息框。

### toggleChatMinimize

```typescript
toggleChatMinimize(): void
```

切换折叠状态。

### unreadMessageCount

```typescript
unreadMessageCount: number,
```

未读消息数量。

### canChatting

```typescript
canChatting: boolean,
```

聊天功能是否可用。

### addChatMessage

```typescript
addChatMessage: (args: any) => void
```

向本地消息列表新增一条聊天消息。

| 参数   | 描述                               |
| :----- | :--------------------------------- |
| `args` | 传入发送聊天消息方法中返回的对象。 |

## ClassroomStatsContext

### cpuUsage

```typescript
cpuUsage: number,
```

> 自 v1.1.5 起新增。

CPU 使用情况。

### networkQuality

```typescript
networkQuality: string,
```

> 自 v1.1.5 起新增。

网络质量。

### networkLatency

```typescript
networkLatency: number,
```

> 自 v1.1.5 起新增。

网络延时（毫秒）。

### packetLostRate

```typescript
packetLostRate: number,
```

> 自 v1.1.5 起新增。

网络丢包率（百分比）。

### rxPacketLossRate

```typescript
rxPacketLossRate: number;
```

> 自 v1.1.5 起新增。

音视频下行丢包率。

### txPacketLossRate

```typescript
txPacketLossRate: number;
```

> 自 v1.1.5 起新增。

音视频上行丢包率。

### rxNetworkQuality

```typescript
rxNetworkQuality: string;
```

> 自 v1.1.5 起新增。

下行网络质量。

### txNetworkQuality

```typescript
txNetworkQuality: string;
```

> 自 v1.1.5 起新增。

上行网络质量。

### liveClassStatus

```typescript
liveClassStatus: {
    classState: string;
    duration: number;
}
```

> 自 v1.1.5 起新增。

课堂状态。

| 参数         | 描述                 |
| ------------ | -------------------- |
| `classState` | 课堂状态。           |
| `duration`   | 课堂持续时间（秒）。 |

## CloudDriveContext

`CloudDriveContext` 提供课件相关能力。

### upsertResources

```typescript
upsertResources(items: CourseWareItem[]): void;
```

> 自 v1.1.5 起新增。

更新课件。

| 参数    | 描述       |
| :------ | :--------- |
| `items` | 课件对象。 |

### allResources

```typescript
allResources: MaterialDataResource[];
```

> 自 v1.1.5 起新增。

所有课件。

### initCourseWareProgress

```typescript
initCourseWareProgress: number;
```

> 自 v1.1.5 起新增。

初始课件加载进度。

### initCourseWareLoading

```typescript
initCourseWareLoading: boolean;
```

> 自 v1.1.5 起新增。

是否正在加载初始课件。

### initCourseWare

```typescript
initCourseWare: MaterialDataResource;
```

> 自 v1.1.5 起新增。

初始课件。

### downloadList

```typescript
downloadList: StorageCourseWareItem[],
```

可下载的课件列表。

### openCloudResource

```typescript
openCloudResource: (uuid: string) => Promise<void>,
```

打开课件。

| 参数   | 描述      |
| :----- | :-------- |
| `uuid` | 课件 ID。 |

### startDownload

```typescript
startDownload: (taskUuid: string) => Promise<void>,
```

开始下载课件。

| 参数       | 描述              |
| :--------- | :---------------- |
| `taskUuid` | 课件转换任务 ID。 |

### deleteSingle

```typescript
deleteSingle: (taskUuid: string) => Promise<void>,
```

删除课件。

| 参数       | 描述              |
| :--------- | :---------------- |
| `taskUuid` | 课件转换任务 ID。 |

### personalResources

```typescript
personalResources: MaterialDataResource[],
```

个人课件列表。

### publicResources

```typescript
publicResources: MaterialDataResource[],
```

公共课件列表。

### resourcesList

```typescript
resourcesList: Resource[],
```

所有课件列表。

### refreshCloudResources

```typescript
refreshCloudResources: () => Promise<void>,
```

刷新课件列表。

### removeMaterialList

```typescript
removeMaterialList: (resourceUuids: string[]) => Promise<void>,
```

删除课件。

| 参数            | 描述      |
| :-------------- | :-------- |
| `resourceUuids` | 课件 ID。 |

### cancelUpload

```typescript
cancelUpload: () => Promise<void>,
```

取消上传课件。

### doUpload

```typescript
doUpload: (payload: any) => Promise<void>,
```

上传课件。

### closeMaterial

```typescript
closeMaterial: (resourceUuid: string) => void,
```

关闭课件。

## GlobalContext

`GlobalContext` 提供全局控制相关能力。

### region

```javascript
region: string;
```

> 自 v1.1.2 起新增。

当前设置的区域。

### loading

```javascript
loading: boolean,
```

> 自 v1.1.2 起废弃。Agora 建议改用 `RoomContext` 的 `isJoiningRoom`。

正在加载中。

### isFullScreen

```javascript
isFullScreen: boolean,
```

当前是否全屏。

### params

```javascript
params: AppStoreInitParams,
```

课堂初始化参数。

### mainPath

```javascript
mainPath: string | undefined,
```

主路由。

### language

```javascript
language: LanguageEnum,
```

当前语言。

### isJoined

```javascript
isJoined: boolean;
```

> 自 v1.1.2 起新增。

是否成功加入课堂。

### sequenceEventObserver

```javascript
sequenceEventObserver: Subject<any>,
```

> 自 v1.1.2 起新增。

灵动课堂事件序列观察器。

### toastEventObserver

```javascript
toastEventObserver: Subject<any>,
```

Toast 观察器。

### dialogEventObserver

```javascript
dialogEventObserver: Subject<any>,
```

Dialogue 观察器。

## HandsUpContext

`HandsUpContext` 提供举手上台相关能力。

### teacherUuid

```typescript
teacherUuid: string,
```

老师的 ID。

### handsUpState

```typescript
handsUpState: string,
```

学生的举手状态。

### teacherHandsUpState

```typescript
teacherHandsUpState: string,
```

老师的举手状态。

### studentHandsUp

```typescript
async studentHandsUp(teacherUuid: string): void
```

学生举手向老师请求发言。

| 参数          | 描述        |
| :------------ | :---------- |
| `teacherUuid` | 老师的 ID。 |

### studentCancelHandsUp

```typescript
async studentCancelHandsUp(): void
```

学生取消举手请求。

### handsUpStudentList

```typescript
handsUpStudentList: array<{userUuid, userName, coVideo}>,
```

举手学生列表。

### coVideoUsers

```typescript
coVideoUsers: array,
```

当前发送视频流的用户列表。

### onlineUserCount

```typescript
onlineUserCount: number,
```

在线用户总数（不包含角色名为观众的用户）。

### processUserCount

```typescript
processUserCount: number,
```

当前发送视频流的用户总数。

### teacherAcceptHandsUp

```typescript
async teacherAcceptHandsUp(userUuid: string): void
```

老师接受学生举手请求。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 学生 ID。 |

### teacherRejectHandsUp

```typescript
async teacherRejectHandsUp(userUuid: string): void
```

老师拒绝学生举手请求。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 学生 ID。 |

## MediaContext

`MediaContext` 提供本地媒体设备控制相关能力。

### enableMediaEncryption

```typescript
enableMediaEncryption(enabled: boolean, config: any): number;
```

> 自 v1.1.5 起新增。

启用媒体流加密。

### getAudioRecordingVolume

```typescript
getAudioRecordingVolume: () => number;
```

> 自 v1.1.5 起新增。

获取麦克风采集的声音的音量。

### getAudioPlaybackVolume

```typescript
getAudioPlaybackVolume: () => number;ng) => Promise<void>;
```

> 自 v1.1.5 起新增。

获取扬声器播放的声音的音量。

### isNative

```typescript
isNative: boolean,
```

本地是否为 Windows 或 macOS 客户端应用。

### cpuUsage

```typescript
cpuUsage: number,
```

> 自 v1.1.5 起废弃。Agora 建议改用 `ClassroomStatsContext` 中的 `cpuUsage`。

CPU 使用情况。

### networkQuality

```typescript
networkQuality: string,
```

> 自 v1.1.5 起废弃。Agora 建议改用 `ClassroomStatsContext` 中的 `networkQuality`。

网络质量。

### networkLatency

```typescript
networkLatency: number,
```

> 自 v1.1.5 起废弃。Agora 建议改用 `ClassroomStatsContext` 中的 `networkLatency`。

网络延时（毫秒）。

### packetLostRate

```typescript
packetLostRate: number,
```

> 自 v1.1.5 起废弃。Agora 建议改用 `ClassroomStatsContext` 中的 `packetLostRate`。

网络丢包率（百分比）。

### cameraList

```typescript
cameraList: any[],
```

摄像头列表。

### microphoneList

```typescript
microphoneList: any[],
```

麦克风列表。

### speakerList

```typescript
speakerList: any[],
```

扬声器列表。

### cameraId

```typescript
cameraId: string,
```

当前选中的摄像头 ID 。

### microphoneId

```typescript
microphoneId: string,
```

当前选中的麦克风 ID。

### speakerId

```typescript
speakerId: string,
```

当前选中的扬声器 ID。

### changeDevice

```typescript
changeDevice: (deviceType: string, value: any) => Promise<void>,
```

切换媒体设备（摄像头、麦克风、扬声器）。

| 参数         | 描述                                                   |
| ------------ | ------------------------------------------------------ |
| `deviceType` | 设备类型，可设为 `camera`、`microphone` 或 `speaker`。 |
| `value`      | 设备 ID。                                              |

### changeAudioVolume

```typescript
changeAudioVolume: (deviceType: string, value: any) => Promise<void>,
```

调整设备音量。

| 参数         | 描述                                        |
| ------------ | ------------------------------------------- |
| `deviceType` | 设备类型，可设为`microphone` 或 `speaker`。 |
| `value`      | 音量大小。                                  |

### changeCamera

```typescript
changeCamera: (deviceId: string) => Promise<void>
```

> 自 v1.1.2 起新增。

切换摄像头。

| 参数       | 描述      |
| ---------- | --------- |
| `deviceId` | 设备 ID。 |

### changeMicrophone

```typescript
changeMicrophone: (deviceId: string) => Promise<void>
```

> 自 v1.1.2 起新增。

切换麦克风。

| 参数       | 描述      |
| ---------- | --------- |
| `deviceId` | 设备 ID。 |

### changeSpeakerVolume

```typescript
changeSpeakerVolume: (v: number) => Promise<void>
```

> 自 v1.1.2 起新增。

调整扬声器的音量。

### changeMicrophoneVolume

```typescript
changeMicrophoneVolume: (v: number) => Promise<void>
```

> 自 v1.1.2 起新增。

调整麦克风的音量。

## PretestContext

`PretestContext` 提供课前检测相关能力，用于检测摄像头、麦克风和扬声器是否正常工作。

### isBeauty

```typescript
isBeauty: boolean;
```

> -   自 v1.1.5 起新增。
> -   仅适用于 Electron。

当前是否开启基础美颜。

### setBeauty

```typescript
setBeauty: (isBeauty: boolean) => void;
```

> -   自 v1.1.5 起新增。
> -   仅适用于 Electron。

开启/关闭基础美颜功能。

| 参数       | 描述               |
| :--------- | :----------------- |
| `isBeauty` | 是否开启美颜功能。 |

### whitening

```typescript
whitening: number;
```

> -   自 v1.1.5 起新增。
> -   仅适用于 Electron。

当前美白数值。

### buffing

```typescript
buffing: number;
```

> -   自 v1.1.5 起新增。
> -   仅适用于 Electron。

当前磨皮数值。

### ruddy

```typescript
ruddy: number;
```

> -   自 v1.1.5 起新增。
> -   仅适用于 Electron。

当前红润数值。

### setWhitening

```typescript
setWhitening: (whitening: number) => void;
```

> -   自 v1.1.5 起新增。
> -   仅适用于 Electron。

设置美白数值。

| 参数        | 描述                                         |
| :---------- | :------------------------------------------- |
| `whitening` | 美白数值。取值范围为 0 到 100，默认值为 70。 |

### setBuffing

```typescript
setBuffing: (buffing: number) => void;
```

> -   自 v1.1.5 起新增。
> -   仅适用于 Electron。

设置磨皮数值。

| 参数      | 描述                                         |
| :-------- | :------------------------------------------- |
| `buffing` | 磨皮数值。取值范围为 0 到 100，默认值为 50。 |

### setRuddy

```typescript
setRuddy: (ruddy: number) => void;
```

> -   自 v1.1.5 起新增。
> -   仅适用于 Electron。

设置红润数值。

| 参数    | 描述                                         |
| :------ | :------------------------------------------- |
| `ruddy` | 红润数值。取值范围为 0 到 100，默认值为 10。 |

### changeTestSpeaker

```typescript
changeTestSpeaker: (deviceId: string) => Promise<void>;
```

> 自 v1.1.5 起新增。

切换扬声器。

| 参数       | 描述      |
| :--------- | :-------- |
| `deviceId` | 设备 ID。 |

### cameraList

```typescript
cameraList: array,
```

摄像头列表。

### microphoneList

```typescript
microphoneList: array,
```

麦克风列表。

### speakerList

```typescript
speakerList: array,
```

扬声器列表。

### cameraError

```typescript
cameraError: boolean,
```

摄像头是否正常工作。

### microphoneError

```typescript
microphoneError: boolean,
```

麦克风是否正常工作。

### cameraId

```typescript
cameraId: string,
```

当前选中的摄像头 ID 。

### microphoneId

```typescript
microphoneId: string,
```

当前选中的麦克风 ID。

### speakerId

```typescript
speakerId: string,
```

当前选中的扬声器 ID。

### isMirror

```typescript
isMirror: boolean,
```

当前摄像头画面是否镜像。

### setMirror

```typescript
setMirror(mirror: boolean): void
```

设置摄像头是否镜像。

### microphoneLevel

```typescript
microphoneLevel: number,
```

当前麦克风音量。取值范围为 0 到 20。

### changeTestSpeakerVolume

```typescript
async changeTestSpeakerVolume(value: any): void
```

调整扬声器的音量。

### changeTestMicrophoneVolume

```typescript
async changeTestMicrophoneVolume(value: any): void
```

调整麦克风的音量。

### changeTestCamera

```typescript
async changeTestCamera(deviceId: string): void
```

切换摄像头。

### changeTestMicrophone

```typescript
async changeTestMicrophone(deviceId: string): void
```

切换麦克风。

### startPretestCamera

```typescript
async startPretestCamera(): void
```

开启摄像头。

### startPretestMicrophone

```typescript
async startPretestMicrophone(): void
```

开启麦克风。

### stopPretestCamera

```typescript
async stopPretestCamera(): void
```

关闭摄像头。

### stopPretestMicrophone

```typescript
async stopPretestMicrophone():void
```

关闭麦克风。

## RecordingContext

`RecordingContext` 提供录制相关能力。

### isRecording

```typescript
isRecording: boolean,
```

当前是否正在录制。

### startRecording

```typescript
async startRecording(): void
```

开始录制。

### stopRecording

```typescript
async stopRecording(): void
```

停止录制。

## RoomContext

`RoomContext` 提供课堂管理相关能力。

### joined

```typescript
joined: boolean;
```

> 自 v1.1.5 起新增。

是否成功加入课堂。

### startCarousel

```typescript
startCarousel: ({
    range,
    type,
    interval,
}: {
    range: number;
    type: number;
    interval: number;
    }) => Promise<any>;
```

> 自 v1.1.5 起新增。

开启学生轮播功能。老师或助教开启此功能后，学生按照指定的时间间隔轮流上台。仅适用于在线互动小班课。如果教室内学生人数小于等于 6，调用该方法后，`interval` 后，全部学生都会上台但无法轮播。

| 参数       | 描述                                                                                      |
| :--------- | :---------------------------------------------------------------------------------------- |
| `range`    | 自动上台的学生范围：<li>`1`: 课堂内全部学生。 </li><li>`2`: 全部摄像头非禁用的学生。</li> |
| `type`     | 学生上台顺序：<li>学生按照加入房间顺序轮流上台。</li><li>学生随机上台。</li>              |
| `interval` | 学生上台的时间间隔。默认值为 60，单位为秒。取值范围为 10 到 99。                          |

### stopCarousel

```typescript
stopCarousel: () => Promise<any>;
```

> 自 v1.1.5 起新增。

停止学生自动分批上台功能。

### sceneType

```typescript
sceneType: number,
```

房间类型：

-   `0`: 1 对 1 在线互动教学。
-   `2`: 互动直播大班课。
-   `4`: 在线互动小班课。

### destroyRoom

```typescript
async destroyRoom(): void
```

销毁房间。

### joinRoom

```typescript
async joinRoom(): void
```

加入房间。

### startNativeScreenShareBy

```typescript
async startNativeScreenShareBy(windowId: number): void
```

通过 Window ID 进行屏幕共享。

| 参数       | 描述        |
| :--------- | :---------- |
| `windowId` | Window ID。 |

### teacherAcceptHandsUp

```typescript
async teacherAcceptHandsUp(userUuid: string): void
```

将学生踢出课堂并禁止学生再进入该课堂。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 学生 ID。 |

### teacherRejectHandsUp

```typescript
async teacherRejectHandsUp(userUuid: string): void
```

将学生踢出课堂。后续学生还能够再进入课堂。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 学生 ID。 |
| `roomUuid` | 课堂 ID。 |

### liveClassStatus

```typescript
liveClassStatus: {
    classState: string;
    duration: number;
},
```

> 自 v1.1.5 起废弃。Agora 建议改用 `LiveRoomStatsContext` 中的 `liveClassStatus`。

当前课堂状态。

### queryCameraDeviceState

```typescript
queryCameraDeviceState: (userList: EduUser[], userUuid: string, streamUuid: string) => any;
```

> 自 v1.1.2 起新增。

查询摄像头状态。

### queryMicrophoneDeviceState

```typescript
queryMicrophoneDeviceState: (userList: EduUser[], userUuid: string, streamUuid: string) => any;
```

> 自 v1.1.2 起新增。

查询麦克风状态。

### isJoiningRoom

```typescript
isJoiningRoom: boolean,
```

### handsUpStudentList

```typescript
handsUpStudentList: array<{userUuid, userName, coVideo}>,
```

举手学生列表。

### processUserCount

```typescript
processUserCount: number,
```

当前发送视频流的用户总数。

### roomInfo

```typescript
roomInfo: object,
```

当前课堂信息。

### isCourseStart

```typescript
isCourseStart: boolean,
```

课堂是否开始。

### kickOutOnce

```typescript
async kickOutOnce(userUuid: string, roomUuid: string): void
```

将学生踢出课堂一次。后续学生还能够再进入课堂。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 学生 ID。 |
| `roomUuid` | 课堂 ID。 |

### kickOutBan

```typescript
async kickOutBan(userUuid: string, roomUuid: string): void
```

将学生踢出课堂并禁止学生再进入该课堂。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 学生 ID。 |
| `roomUuid` | 课堂 ID。 |

### liveClassStatus

```typescript
liveClassStatus: object,
```

当前课堂状态。

### muteVideo

```typescript
async muteVideo(userUuid: string, isLocal: boolean): void
```

禁用指定用户的视频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

### unmuteVideo

```typescript
async unmuteVideo(userUuid: string, isLocal: boolean): void
```

取消禁用指定用户的视频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

### muteAudio

```typescript
async muteAudio(userUuid: string, isLocal: boolean): void
```

禁止指定用户的音频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

### unmuteAudio

```typescript
async unmuteAudio(userUuid: string, isLocal: boolean): void
```

取消禁止指定用户的音频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

## ScreenShareContext

`ScreenShareContext` 提供屏幕共享相关能力。

### nativeAppWindowItems

```typescript
nativeAppWindowItems: array,
```

远端屏幕共享流列表。

### screenShareStream

```typescript
screenShareStream: object,
```

本地屏幕共享流信息。

### startOrStopSharing

```typescript
async startOrStopSharing(): void
```

开始或停止屏幕共享。

## StreamListContext

`StreamListContext` 提供流相关能力。

### streamList

```javascript
streamList: EduStream[],
```

全部媒体数据流列表。

### teacherStream

```javascript
teacherStream: any,
```

教师媒体流列表。

### studentStreams

```javascript
studentStreams: EduMediaStream[],
```

学生媒体流列表。

### onPodiumStudentStreams

```javascript
onPodiumStudentStreams: EduMediaStream[],
```

当前上台的学生媒体流列表。

### muteAudio

```javascript
muteAudio: (userUuid: string, isLocal: boolean) => void,
```

禁用指定用户的音频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

### unmuteAudio

```javascript
unmuteAudio: (userUuid: string, isLocal: boolean) => void,
```

取消禁用指定用户的音频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

### muteVideo

```javascript
muteVideo: (userUuid: string, isLocal: boolean) => void,
```

禁用指定用户的视频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

### unmuteVideo

```javascript
unmuteVideo: (userUuid: string, isLocal: boolean) => void,
```

取消禁用指定用户的视频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

### revokeUserPermission

```javascript
revokeUserPermission: (userUuid: string) => void,
```

取消指定用户的白板权限。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 用户 ID。 |

### localStream

```javascript
localStream: EduStream,
```

本地用户的媒体数据流。

### grantUserPermission

```javascript
grantUserPermission: (userUuid: string) => void,
```

授予指定用户白板权限。

## UserListContext

`UserListContext` 提供用户列表相关能力。

### rosterUserList

```javascript
rosterUserList: any[],
```

当前课堂显示在用户列表中的学生列表。

### userList

```javascript
userList: array,
```

当前课堂内的所有用户列表。

### acceptedUserList

```javascript
acceptedUserList: array,
```

举手请求被老师同意的学生列表。

### localUserInfo

```javascript
localUserInfo: EduUser,
```

> 自 v1.1.2 起新增。

本地用户信息。

### teacherInfo

```javascript
teacherInfo?: EduUser,
```

> 自 v1.1.2 起新增。

当前课堂的老师信息。

### toggleWhiteboardPermission

```javascript
toggleWhiteboardPermission: (userUuid:string, whiteboardGranted: boolean) => Promise<any>,
```

> 自 v1.1.2 起新增。

设置指定用户的白板权限。

| 参数                | 描述                       |
| :------------------ | :------------------------- |
| `userUuid`          | 用户 ID。                  |
| `whiteboardGranted` | 是否授予指定用户白板权限。 |

### toggleCamera

```javascript
toggleCamera: (userUuid:string, enabled: boolean) => Promise<any>,
```

> 自 v1.1.2 起新增。

开启或关闭指定用户的摄像头。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `enabled`  | 摄像头是否开启。 |

### toggleMic

```javascript
toggleMic: (userUuid:string, enabled: boolean) => Promise<any>,
```

> 自 v1.1.2 起新增。

开启或关闭指定用户的麦克风。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `enabled`  | 麦克风是否开启。 |

### controlTools

```javascript
controlTools: ControlTool[],
```

> 自 v1.1.2 起新增。

可用的用户管理工具。

### isHost

```javascript
isHost: boolean;
```

> 自 v1.1.2 起新增。

是否为房主。

### kick

```javascript
kick: (userUuid:string) => Promise<any>,
```

> 自 v1.1.2 起新增。

将指定用户踢出房间。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 用户 ID。 |

## BoardContext

`BoardContext` 提供白板相关能力。

### boardConnectionState

```typescript
boardConnectionState: string;
```

> 自 v1.1.5 起新增。

白板连接状态。

### joinBoard

```typescript
joinBoard: () => Promise<any>;
```

> 自 v1.1.5 起新增。

加入白板房间。

### leaveBoard

```typescript
leaveBoard: () => Promise<any>;
```

> 自 v1.1.5 起新增。

离开白板房间。

### room

```typescript
room: object,
```

白板房间对象。

### zoomValue

```typescript
zoomValue: number,
```

白板缩放的值。

### currentPage

```typescript
currentPage: number,
```

当前白板页数。

### totalPage

```typescript
totalPage: number,
```

白板总页数。

### courseWareList

```typescript
courseWareList: array,
```

课件列表。

### currentColor

```typescript
currentColor: string,
```

当前画笔颜色。

### currentStrokeWidth

```typescript
currentStrokeWidth: number,
```

当前画笔宽度。

### hasPermission

```typescript
hasPermission: boolean,
```

是否拥有白板权限。

### currentSelector

```typescript
currentSelector: string,
```

当前白板的选择工具。

### lineSelector

```typescript
lineSelector: string,
```

当前白板的线条工具。

### activeMap

```typescript
activeMap: Record<string, boolean>,
```

默认激活的工具。

### ready

```typescript
ready: boolean,
```

白板是否准备完毕。

### tools

```typescript
tools: array,
```

白板基础工具列表。

### changeStroke

```typescript
async changeStroke(value: any): void
```

修改画笔宽度。

### changeHexColor

```typescript
async changeHexColor(colorHex: string): void
```

修改颜色。

### mountToDOM

```typescript
async mountToDOM(dom: HTMLDivElement | null): void
```

将白板挂载在 DOM 节点上或者卸载白板。

### setTool

```typescript
async setTool(tool: string): void
```

切换工具。

### zoomBoard

```typescript
async zoomBoard(type: string): void
```

放大或缩小白板。

### setZoomScale

```typescript
async setZoomScale(operation: string): void
```

设置放大或缩小的比例。

### changeFooterMenu

```typescript
async changeFooterMenu(itemName: string): void
```

设置白板跳转到哪一页。

### downloadList

```typescript
downloadList: array,
```

可下载的云盘资源列表。

### putSceneByResourceUuid

```typescript
async putSceneByResourceUuid(uuid: string): void
```

在白板上打开课件。

### startDownload

```typescript
async startDownload(taskUuid: string): void
```

开始下载课件。

### updatePen

```typescript
async updatePen(value: any): void
```

更新画笔。

### boardPenIsActive

```typescript
boardPenIsActive: boolean,
```

当前白板使用的工具是否为画笔。

### startOrStopSharing

```typescript
async startOrStopSharing(): void
```

开始或停止屏幕共享。

### setLaserPoint

```typescript
setLaserPoint(): void
```

设置当前工具为激光笔。

### resourcesList

```typescript
resourcesList: array,
```

课件列表。

### refreshCloudResources

```typescript
async refreshCloudResources(): void
```

更新课件列表。

### removeMaterialList

```typescript
async removeMaterialList(resourceUuids: string[]): void
```

移除课件。

### cancelUpload

```typescript
async cancelUpload(): void
```

取消上传课件。

### doUpload

```typescript
async doUpload(payload: any): void
```

上传课件。

### closeMaterial

```typescript
async closeMaterial(resourceUuid: string): void
```

关闭课件。

### installTools

```typescript
async installTools(tools: any[]): void
```

安装工具。

### personalResources

```typescript
personalResources: array,
```

老师通过灵动课堂客户端上传的课件列表。

### publicResources

```typescript
publicResources: array,
```

教学机构指派的课件列表。

### revokeUserPermission

```typescript
async revokeUserPermission(userUuid: string): void
```

取消白板授权。

### grantUserPermission

```typescript
async grantUserPermission(userUuid: string): void
```

给予指定学生白板权限。

## AgoraExtAppContext

### properties

```JavaScipt
properties: any;
```

扩展应用的属性。

### dependencies

```JavaScipt
dependencies: Map<string, any>;
```

扩展应用的依赖。

### localUserInfo

```JavaScipt
localUserInfo: AgoraExtAppUserInfo;
```

当前课堂的用户相关信息，包含：

-   `userUuid`: 用户 ID。
-   `userName`: 用户名称。
-   `roleType`: 用户角色。

### roomInfo

```JavaScipt
roomInfo: AgoraExtAppRoomInfo;
```

当前课堂相关信息，包含：

-   `roomUuid`: 课堂 ID。
-   `roomName`: 课堂名称。
-   `roomType`: 课堂类型。

### language

```JavaScipt
language: string;
```

扩展应用的语言。

## AgoraExtAppHandle

### updateRoomProperty

```TypeScipt
updateRoomProperty: (properties: any, cause: any) => Promise<void>;
```

更新课堂属性。

| 参数         | 描述       |
| :----------- | :--------- |
| `properties` | 属性。     |
| `cause`      | 更新原因。 |

### deleteRoomProperties

```JavaScipt
deleteRoomProperties: (properties: string[], cause: any) => Promise<void>;
```

删除课堂属性。

| 参数         | 描述       |
| :----------- | :--------- |
| `properties` | 属性。     |
| `cause`      | 更新原因。 |
