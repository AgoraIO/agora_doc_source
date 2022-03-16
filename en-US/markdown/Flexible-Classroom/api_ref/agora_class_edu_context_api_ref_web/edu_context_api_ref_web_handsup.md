`HandsUpContext` enables developers to implement the hand-raising function in the flexible classroom.

## teacherUuid

```typescript
teacherUuid: string,
```

The ID of the teacher.

## handsUpState

```typescript
handsUpState: string,
```

The student's hand state.

## teacherHandsUpState

```typescript
teacherHandsUpState: string,
```

The teacher's hand state.

## studentHandsUp

```typescript
async studentHandsUp(teacherUuid: string): void
```

The student raises a hand to apply for speaking up.


| Parameter | Description |
| :------------ | :---------- |
| `teacherUuid` | The ID of the teacher. |


## studentCancelHandsUp

```typescript
async studentCancelHandsUp(): void
```

The student lowers the hand to cancel the application for speaking up.

## handsUpStudentList

```typescript
handsUpStudentList: array<{userUuid, userName, coVideo}>,
```

The list of students who raise their hand to apply for speaking up.

## coVideoUsers

```typescript
coVideoUsers: array,
```

The list of users who are sending video streams.

## onlineUserCount

```typescript
onlineUserCount: number,
```

The total number of online users, excluding users whose role is the audience.

## processUserCount

```typescript
processUserCount: number,
```

The total number of users who are sending video streams.

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