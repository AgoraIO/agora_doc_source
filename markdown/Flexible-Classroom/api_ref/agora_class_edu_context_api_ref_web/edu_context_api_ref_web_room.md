# useRoomContext

`useRoomContext()` 提供课堂管理相关能力。

你可以通过 `import { useRoomContext } from 'agora-edu-core';  ` 引入 `useRoomContext`，然后使用 `const {...} = useRoomContext()` 获取灵动课堂中课堂管理相关能力。

以下具体列出 `useChatContext()` 提供的能力。

## sceneType

```typescript
sceneType: number,
```

房间类型：

- `0`: 1 对 1 在线互动教学。
- `2`: 互动直播大班课。
- `4`: 在线互动小班课。

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

老师接受学生举手请求。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 学生 ID。 |

## teacherRejectHandsUp

```typescript
async teacherRejectHandsUp(userUuid: string): void
```

老师拒绝学生举手请求。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 学生 ID。 |

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