`RoomContext` enables developers to implement classroom management.

## joined

```typescript
joined: boolean;
```

> Since v1.1.5.

Whether the local client successfully joins the class.

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

Enables the feature of students automatically going onto the "stage". Once the teacher or TA enables this feature, students go onto the "stage" at specified intervals. This feature is only applicable to the Small Classroom scenario. If the number of students in the classroom is less than or equal to 6, after calling this method, all students go onto the "stage" after an `interval`, but cannot be rotated.

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `range` | Scope of students who automatically go onto the "stage":<li>`1`: All students in the classroom.</li><li>`2`: All students whose cameras are not disabled.</li> |
| `type` | Order of students going onto the "stage":<li>Students go onto the "stage" in the order of joining the room.</li><li>Students go onto the "stage" randomly.</li> |
| `interval` | The interval (seconds) for students going onto the "stage". The default value is 60. The value range is 10 to 99. |

## stopCarousel

```typescript
stopCarousel: () => Promise<any>;
```

> Since v1.1.5.

Disables the feature of students automatically going onto the "stage".

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

Kicks a student out of the classroom and prohibits the student from re-joining the classroom.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | The student ID. |

## teacherRejectHandsUp

```typescript
async teacherRejectHandsUp(userUuid: string): void
```

Kicks a student out of the classroom. The student who is kicked out of the classroom can re-join the classroom.

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

> Deprecated as of v1.1.5. Use `liveClassStatus` in `LiveRoomStatsContext` instead.

The current state of the classroom.

## queryCameraDeviceState

```typescript
queryCameraDeviceState: (userList: EduUser[], userUuid: string, streamUuid: string) => any;
```

> Since v1.1.5.

Gets the camera state.

## queryMicrophoneDeviceState

```typescript
queryMicrophoneDeviceState: (userList: EduUser[], userUuid: string, streamUuid: string) => any;
```

> Since v1.1.5.

Gets the microphone status.

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

Kicks a student out of the classroom. The student who is kicked out of the classroom can re-join the classroom.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | The student ID. |
| `roomUuid` | The room ID. |

## kickOutBan

```typescript
async kickOutBan(userUuid: string, roomUuid: string): void
```

Kicks a student out of the classroom and prohibits the student from re-joining the classroom.

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