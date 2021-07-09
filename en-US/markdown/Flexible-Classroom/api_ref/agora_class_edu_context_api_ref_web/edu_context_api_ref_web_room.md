# useRoomContext

`useRoomContext()` enables developers to implement the classroom management.

You can import `useRoomContext` by `import {useRoomContext} from'agora-edu-core';` and then use `const {...} = useRoomContext()` to implement the functions and events related to classroom management.

This page lists all the functions and events provided by `useChatContext()`.

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

The teacher accepts the student's application for speaking up.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | The student ID. |

## teacherRejectHandsUp

```typescript
async teacherRejectHandsUp(userUuid: string): void
```

The teacher approves the student's application for speaking up.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | The student ID. |

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