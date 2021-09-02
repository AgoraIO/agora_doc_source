This page lists all the functions and events provided by `RoomContext` for classroom management.

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
destroyRoom: () => Promise<void>,
```

Destroy the classroom.

## joinRoom

```typescript
joinRoom: () => Promise<void>,
```

Join a classroom.

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

## kickOutBan

```typescript
kickOutBan: (userUuid: string, roomUuid: string) => Promise<void>,
```

Kick a student out of the classroom and prohibit the student from re-joining the classroom.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | The student ID. |
| `roomUuid` | The room ID. |

## kickOutOnce

```typescript
kickOutOnce: (userUuid: string, roomUuid: string) => Promise<void>,
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

The current state of the classroom.
