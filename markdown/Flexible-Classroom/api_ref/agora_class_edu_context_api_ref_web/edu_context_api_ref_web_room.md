# RoomContext

`RoomContext` 提供课堂管理相关能力。

## sceneType

```typescript
sceneType: number,
```

课堂类型：

- `0`: 1 对 1 在线互动教学。
- `2`: 互动直播大班课。
- `4`: 在线互动小班课。

## destroyRoom

```typescript
destroyRoom: () => Promise<void>,
```

销毁课堂。

## joinRoom

```typescript
joinRoom: () => Promise<void>,
```

加入课堂。

## roomInfo

```typescript
roomInfo: RoomInfo,
```

当前课堂信息。

## isCourseStart

```typescript
isCourseStart: boolean,
```

课堂是否开始。

## kickOutOnce

```typescript
kickOutBan: (userUuid: string, roomUuid: string) => Promise<void>,
```

将学生踢出课堂。后续学生还能够再进入课堂。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 学生 ID。 |
| `roomUuid` | 课堂 ID。 |

## kickOutBan

```typescript
kickOutOnce: (userUuid: string, roomUuid: string) => Promise<void>,
```

将学生踢出课堂并禁止学生再进入该课堂。

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

> 自 v1.1.2 起新增。

是否正在加入课堂。

## roomProperties

```typescript
roomProperties: any,
```

> 自 v1.1.2 起新增。

获取全部课堂属性，包含灵动课堂内置的课堂属性和开发者自定义的课堂属性。

## updateFlexRoomProperties

```typescript
updateFlexRoomProperties: (properties: any, cause: any) => Promise<any>;
```

> 自 v1.1.2 起新增。

新增或更新自定义课堂属性。支持整体修改和根据路径查找并修改某个属性的值。

| 参数         | 描述       |
| :----------- | :--------- |
| `properties` | 课堂属性。 |
| `cause`      | 更新原因。 |

## flexRoomProperties

```typescript
flexRoomProperties: any;
```

> 自 v1.1.2 起新增。

获取由开发者自定义的课堂属性。

## startNativeScreenShareBy

```typescript
startNativeScreenShareBy: (windowId: number) => Promise<void>,
```

> 自 v1.1.2 起废弃。Agora 建议使用 `ScreenShareContext` 中 `startNativeScreenShareBy`。

使用指定的窗口或屏幕 ID 进行屏幕共享。

| 参数       | 描述            |
| :--------- | :-------------- |
| `windowId` | 窗口或屏幕 ID。 |

## teacherAcceptHandsUp

```typescript
teacherAcceptHandsUp: (userUuid: string) => Promise<void>,
```

> 自 v1.1.2 起废弃。Agora 建议改用 `HandsUpContext` 中的 `teacherAcceptHandsUp`。

老师接受学生举手请求。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 用户 ID。 |

## teacherRejectHandsUp

```typescript
teacherRejectHandsUp: (userUuid: string) => Promise<void>,
```

> 自 v1.1.2 起废弃。Agora 建议改用 `HandsUpContext` 中的 `teacherRejectHandsUp`。

老师拒绝学生举手请求。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 用户 ID。 |

## handsUpStudentList

```typescript
handsUpStudentList: any[],
```

> 自 v1.1.2 起废弃。Agora 建议改用 `HandsUpContext` 中的 `handsUpStudentList`。

举手学生列表。

## handsUpState

```typescript
handsUpStudentList: any[],
```

> 自 v1.1.2 起废弃。Agora 建议改用 `HandsUpContext` 中的 `handsUpStudentList`。

学生的举手状态。

## processUserCount

```typescript
processUserCount: number,
```

> 自 v1.1.2 起废弃。Agora 建议改用 `HandsUpContext` 中的 `processUserCount`。

申请上台的用户总数。

## muteAudio

```javascript
muteAudio: (userUuid: string, isLocal: boolean) => Promise<void>,
```

> 自 v1.1.2 起废弃。Agora 建议改用 `StreamListContext` 中的 `muteAudio`。

禁用指定用户的音频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

## unmuteAudio

```javascript
unmuteAudio: (userUuid: string, isLocal: boolean) => Promise<void>,
```

> 自 v1.1.2 起废弃。Agora 建议改用 `StreamListContext` 中的 `unmuteAudio`。

取消禁用指定用户的音频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

## muteVideo

```javascript
muteVideo: (userUuid: string, isLocal: boolean) => Promise<void>,
```

> 自 v1.1.2 起废弃。Agora 建议改用 `StreamListContext` 中的 `muteVideo`。

禁用指定用户的视频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

## unmuteVideo

```javascript
unmuteVideo: (userUuid: string, isLocal: boolean) => Promise<void>,
```

> 自 v1.1.2 起废弃。Agora 建议改用 `StreamListContext` 中的 `unmuteVideo`。

取消禁用指定用户的视频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

