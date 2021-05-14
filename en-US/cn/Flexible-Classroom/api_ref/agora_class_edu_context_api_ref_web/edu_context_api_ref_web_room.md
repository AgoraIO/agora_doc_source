# useRoomContext

`useRoomContext()` Provides classroom management related capabilities.

You can` import useRoomContext by import {useRoomContext} from'agora-edu-core';```, and then use` const {...} = useRoomContext()` to obtain classroom management related abilities in smart classrooms.

The following specifically lists` the capabilities provided by useChatContext()`.

## sceneType

```typescript
sceneType: number,
```

Room type:

- `0`: One-to-one Classroom.
- `2`: Lecture Hall.
- `4`: Small Classroom.

## destroyRoom

```typescript
async destroyRoom(): void
```

Destroy the room.

## joinRoom

```typescript
async joinRoom(): void
```

Join the room.

## startNativeScreenShareBy

```typescript
async startNativeScreenShareBy(windowId: number): void
```

Screen sharing via Window ID.


| Parameter | Description |
| :--------- | :---------- |
| `windowId` | Window ID。 |


## teacherAcceptHandsUp

```typescript
async teacherAcceptHandsUp(userUuid: string): void
```

The teacher accepts the student's request to raise their hand.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | Student ID. |

## teacherRejectHandsUp

```typescript
async teacherRejectHandsUp(userUuid: string): void
```

The teacher refused the student's request to raise his hand.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | Student ID. |

## handsUpStudentList

```typescript
handsUpStudentList: array<{userUuid, userName, coVideo}>,
```

Raise your hand to the list of students.

## processUserCount

```typescript
processUserCount: number,
```

The total number of users currently sending video streams.

## roomInfo

```typescript
roomInfo: object,
```

Current classroom information.

## isCourseStart

```typescript
isCourseStart: boolean,
```

Whether the class has started.

## kickOutOnce

```typescript
async kickOutOnce(userUuid: string, roomUuid: string): void
```

Kick the student out of class once. Follow-up students can also re-enter the classroom.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | Student ID. |
| `roomUuid` | The room ID. |

## kickOutBan

```typescript
async kickOutBan(userUuid: string, roomUuid: string): void
```

Kick the student out of the classroom and prohibit the student from re-entering the classroom.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | Student ID. |
| `roomUuid` | The room ID. |

## liveClassStatus

```typescript
liveClassStatus: object,
```

The current state of the classroom:

## muteVideo

```typescript
async muteVideo(userUuid: string, isLocal: boolean): void
```

Disable the video of the specified user.

| Parameter | Description |
| :--------- | :--------------- |
| `userUuid` | The user ID. |
| `isLocal` | Whether it is a local user. |

## unmuteVideo

```typescript
async unmuteVideo(userUuid: string, isLocal: boolean): void
```

Undisable the video of the specified user.

| Parameter | Description |
| :--------- | :--------------- |
| `userUuid` | The user ID. |
| `isLocal` | Whether it is a local user. |

## muteAudio

```typescript
async muteAudio(userUuid: string, isLocal: boolean): void
```

Prohibit the audio of the specified user.

| Parameter | Description |
| :--------- | :--------------- |
| `userUuid` | The user ID. |
| `isLocal` | Whether it is a local user. |

## unmuteAudio

```typescript
async unmuteAudio(userUuid: string, isLocal: boolean): void
```

Unban the audio of the specified user.

| Parameter | Description |
| :--------- | :--------------- |
| `userUuid` | The user ID. |
| `isLocal` | Whether it is a local user. |