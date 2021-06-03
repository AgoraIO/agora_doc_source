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

查询摄像头状态。

## queryMicrophoneDeviceState

```typescript
queryMicrophoneDeviceState: (userList: EduUser[], userUuid: string, streamUuid: string) => any;
```

查询麦克风状态。

## isJoiningRoom

```typescript
isJoiningRoom: boolean,
```

是否正在加入课堂。

## roomProperties

```typescript
roomProperties: any,
```

获取全部课堂属性，包含灵动课堂内置的课堂属性。

## updateFlexRoomProperties

```typescript
updateFlexRoomProperties: (properties: any, cause: any) => Promise<any>;
```

新增或更新自定义课堂属性。

| 参数         | 描述       |
| :----------- | :--------- |
| `properties` | 课堂属性。 |
| `cause`      | 更新原因。 |

## flexRoomProperties

```typescript
flexRoomProperties: any;
```

获取由开发者自定义的课堂属性。
