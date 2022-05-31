`RoomContext` 提供课堂管理相关能力。

## joined

```typescript
joined: boolean;
```

> 自 v1.1.5 起新增。

是否成功加入课堂。

## startCarousel

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

## stopCarousel

```typescript
stopCarousel: () => Promise<any>;
```

> 自 v1.1.5 起新增。

停止学生自动分批上台功能。

## sceneType

```typescript
sceneType: number,
```

房间类型：

-   `0`: 1 对 1 在线互动教学。
-   `2`: 互动直播大班课。
-   `4`: 在线互动小班课。

## destroyRoom

```typescript
async destroyRoom(): void
```

销毁房间。

## joinRoom

```typescript
async joinRoom(): void
```

加入房间。

## startNativeScreenShareBy

```typescript
async startNativeScreenShareBy(windowId: number): void
```

通过 Window ID 进行屏幕共享。

| 参数       | 描述        |
| :--------- | :---------- |
| `windowId` | Window ID。 |

## teacherAcceptHandsUp

```typescript
async teacherAcceptHandsUp(userUuid: string): void
```

将学生踢出课堂并禁止学生再进入该课堂。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 学生 ID。 |

## teacherRejectHandsUp

```typescript
async teacherRejectHandsUp(userUuid: string): void
```

将学生踢出课堂。后续学生还能够再进入课堂。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 学生 ID。 |
| `roomUuid` | 课堂 ID。 |

## liveClassStatus

```typescript
liveClassStatus: {
    classState: string;
    duration: number;
},
```

> 自 v1.1.5 起废弃。Agora 建议改用 `LiveRoomStatsContext` 中的 `liveClassStatus`。

当前课堂状态。

## queryCameraDeviceState

```typescript
queryCameraDeviceState: (userList: EduUser[], userUuid: string, streamUuid: string) => any;
```

> 自 v1.1.2 起新增。

查询摄像头状态。

## queryMicrophoneDeviceState

```typescript
queryMicrophoneDeviceState: (userList: EduUser[], userUuid: string, streamUuid: string) => any;
```

> 自 v1.1.2 起新增。

查询麦克风状态。

## isJoiningRoom

```typescript
isJoiningRoom: boolean,
```

## handsUpStudentList

```typescript
handsUpStudentList: array<{userUuid, userName, coVideo}>,
```

举手学生列表。

## processUserCount

```typescript
processUserCount: number,
```

当前发送视频流的用户总数。

## roomInfo

```typescript
roomInfo: object,
```

当前课堂信息。

## isCourseStart

```typescript
isCourseStart: boolean,
```

课堂是否开始。

## kickOutOnce

```typescript
async kickOutOnce(userUuid: string, roomUuid: string): void
```

将学生踢出课堂一次。后续学生还能够再进入课堂。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 学生 ID。 |
| `roomUuid` | 课堂 ID。 |

## kickOutBan

```typescript
async kickOutBan(userUuid: string, roomUuid: string): void
```

将学生踢出课堂并禁止学生再进入该课堂。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 学生 ID。 |
| `roomUuid` | 课堂 ID。 |

## liveClassStatus

```typescript
liveClassStatus: object,
```

当前课堂状态。

## muteVideo

```typescript
async muteVideo(userUuid: string, isLocal: boolean): void
```

禁用指定用户的视频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

## unmuteVideo

```typescript
async unmuteVideo(userUuid: string, isLocal: boolean): void
```

取消禁用指定用户的视频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

## muteAudio

```typescript
async muteAudio(userUuid: string, isLocal: boolean): void
```

禁止指定用户的音频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

## unmuteAudio

```typescript
async unmuteAudio(userUuid: string, isLocal: boolean): void
```

取消禁止指定用户的音频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |
