`useRoomContext`() enables developers to implement the classroom management.

## joined

```typescript
joined: boolean;
```

> Since v1.1.5.

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

> Since v1.1.5.

开启学生轮播功能。 Once the teacher or TA enables this feature, students go onto the "stage" at specified intervals. 仅适用于在线互动小班课。 如果教室内学生人数小于等于 6，调用该方法后，`interval`  后，全部学生都会上台但无法轮播。

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `range` | 自动上台的学生范围：<li>`1`: 课堂内全部学生。 </li><li>`2`: 全部摄像头非禁用的学生。</li> |
| `type` | 学生上台顺序：<li>学生按照加入房间顺序轮流上台。</li><li>学生随机上台。</li> |
| `interval` | 学生上台的时间间隔。 默认值为 60，单位为秒。 The value range is 0 to 20. |

## stopCarousel

```typescript
stopCarousel: () => Promise<any>;
```

> Since v1.1.5.

停止学生自动分批上台功能。

## sceneType

```typescript
sceneType: number,
```

The classroom type:

- `0`: One-to-one Classroom.
- `2`: Lecture Hall.
- `4`: Small Classroom.

## destroyRoom

```typescript
async destroyRoom(): void
```

Destroy the classroom.

## joinRoom

```typescript
async joinRoom(): void
```

Join a classroom.

## startNativeScreenShareBy

```typescript
async startNativeScreenShareBy(windowId: number): void
```

Start screen sharing by the window ID.


| Parameter | Description |
| :--------- | :---------- |
| `windowId` | The window ID。 |


## teacherAcceptHandsUp

```typescript
async teacherAcceptHandsUp(userUuid: string): void
```

Kick a student out of the classroom and prohibit the student from re-joining the classroom.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | The student ID. |

## teacherRejectHandsUp

```typescript
async teacherRejectHandsUp(userUuid: string): void
```

Kick a student out of the classroom. The student who is kicked out of the classroom can re-join the classroom.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | The student ID. |
| `roomUuid` | The room ID. |

## liveClassStatus

```typescript
liveClassStatus: {
    classState: string;
    duration: number;
},
```

> Since v1.1.5. Agora 建议改用 `LiveRoomStatsContext` 中的 `liveClassStatus`。

The current state of the classroom.

## queryCameraDeviceState

```typescript
queryCameraDeviceState: (userList: EduUser[], userUuid: string, streamUuid: string) => any;
```

> Since v1.1.5.

查询摄像头状态。

## queryMicrophoneDeviceState

```typescript
queryMicrophoneDeviceState: (userList: EduUser[], userUuid: string, streamUuid: string) => any;
```

> Since v1.1.5.

查询麦克风状态。

## isJoiningRoom

```typescript
isJoiningRoom: boolean,
```

## handsUpStudentList

```typescript
handsUpStudentList: array<{userUuid, userName, coVideo}>,
```

The list of students who raise their hand to apply for speaking up.

## processUserCount

```typescript
processUserCount: number,
```

The total number of users who are sending video streams.

## roomInfo

```typescript
roomInfo: object,
```

The information of the current classroom.

## isCourseStart

```typescript
isCourseStart: boolean,
```

Whether the class has started.

## kickOutOnce

```typescript
async kickOutOnce(userUuid: string, roomUuid: string): void
```

Kick a student out of the classroom. The student who is kicked out of the classroom can re-join the classroom.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | The student ID. |
| `roomUuid` | The room ID. |

## kickOutBan

```typescript
async kickOutBan(userUuid: string, roomUuid: string): void
```

Kick a student out of the classroom and prohibit the student from re-joining the classroom.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | The student ID. |
| `roomUuid` | The room ID. |

## liveClassStatus

```typescript
liveClassStatus: object,
```

The current state of the classroom.

## muteVideo

```typescript
async muteVideo(userUuid: string, isLocal: boolean): void  
```

Disable the video of the specified user.

| Parameter | Description |
| :--------- | :--------------- |
| `userUuid` | The user ID. |
| `isLocal` | Whether the user is the local user. |

## unmuteVideo

```typescript
async unmuteVideo(userUuid: string, isLocal: boolean): void
```

Enable the video of the specified user.

| Parameter | Description |
| :--------- | :--------------- |
| `userUuid` | The user ID. |
| `isLocal` | Whether the user is the local user. |

## muteAudio

```typescript
async muteAudio(userUuid: string, isLocal: boolean): void
```

Disable the audio of the specified user.

| Parameter | Description |
| :--------- | :--------------- |
| `userUuid` | The user ID. |
| `isLocal` | Whether the user is the local user. |

## unmuteAudio

```typescript
async unmuteAudio(userUuid: string, isLocal: boolean): void
```

Enable the audio of the specified user.

| Parameter | Description |
| :--------- | :--------------- |
| `userUuid` | The user ID. |
| `isLocal` | Whether the user is the local user. |