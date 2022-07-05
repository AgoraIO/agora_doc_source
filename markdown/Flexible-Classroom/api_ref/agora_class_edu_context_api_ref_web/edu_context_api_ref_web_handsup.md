`HandsUpContext` 提供举手上台相关能力。

## teacherUuid

```typescript
teacherUuid: string,
```

老师的 ID。

## handsUpState

```typescript
handsUpState: string,
```

学生的举手状态。

## teacherHandsUpState

```typescript
teacherHandsUpState: string,
```

老师的举手状态。

## studentHandsUp

```typescript
async studentHandsUp(teacherUuid: string): void
```

学生举手向老师请求发言。


| 参数          | 描述        |
| :------------ | :---------- |
| `teacherUuid` | 老师的 ID。 |


## studentCancelHandsUp

```typescript
async studentCancelHandsUp(): void
```

学生取消举手请求。

## handsUpStudentList

```typescript
handsUpStudentList: array<{userUuid, userName, coVideo}>,
```

举手学生列表。

## coVideoUsers

```typescript
coVideoUsers: array, 
```

当前发送视频流的用户列表。

## onlineUserCount

```typescript
onlineUserCount: number,
```

在线用户总数（不包含角色名为观众的用户）。

## processUserCount

```typescript
processUserCount: number,
```

当前发送视频流的用户总数。

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