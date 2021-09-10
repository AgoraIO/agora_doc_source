# HandsUpContext

`HandsUpContext` 提供举手上台相关能力。

## teacherUuid

```typescript
teacherUuid: string,
```

老师的 ID。

## handsUpState

```typescript
handsUpState: "forbidden" | "actived" | "default",
```

学生的举手状态。

## teacherHandsUpState

```typescript
teacherHandsUpState: "actived" | "default",
```

老师的举手状态。

## studentHandsUp

```typescript
studentHandsUp: (teacherUuid: string) => Promise<void>,
```

学生举手向老师请求发言。


| 参数          | 描述        |
| :------------ | :---------- |
| `teacherUuid` | 老师的 ID。 |


## studentCancelHandsUp

```typescript
studentCancelHandsUp: () => Promise<void>,
```

学生取消举手请求。

## handsUpStudentList

```typescript
handsUpStudentList: {
    userUuid: string;
    userName: string;
    coVideo: boolean;
}[],
```

举手学生列表。

## coVideoUsers

```typescript
coVideoUsers: array, 
```

已上台用户列表。

## onlineUserCount

```typescript
onlineUserCount: number,
```

已上台用户总数。

## processUserCount

```typescript
processUserCount: number,
```

申请上台的用户总数。

## teacherAcceptHandsUp

```typescript
teacherAcceptHandsUp: (userUuid: string) => Promise<void>,
```

老师接受学生举手请求。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 学生 ID。 |

## teacherRejectHandsUp

```typescript
teacherRejectHandsUp: (userUuid: string) => Promise<void>,
```

老师拒绝学生举手请求。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 学生 ID。 |

## teacherRevokeCoVideo

```typescript
teacherRevokeCoVideo: (userUuid: string) => Promise<void>,
```

> 自 v1.1.2 起新增。

老师让指定用户下台。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 用户 ID。 |

## studentExitCoVideo

```typescript
studentExitCoVideo: () => Promise<void>,
```

> 自 v1.1.2 起新增。

学生主动下台。