This page lists all the functions and events provided by `HandsUpContext` for the hand-raising feature of Flexible Classroom.

## teacherUuid

```typescript
teacherUuid: string,
```

The ID of the teacher.

## handsUpState

```typescript
handsUpState: "forbidden" | "actived" | "default",
```

The student's hand state.

## teacherHandsUpState

```typescript
teacherHandsUpState: "actived" | "default",
```

The teacher's hand state.

## studentHandsUp

```typescript
studentHandsUp: (teacherUuid: string) => Promise<void>,
```

The student raises a hand to apply for speaking up.


| Parameter | Description |
| :------------ | :---------- |
| `teacherUuid` | The ID of the teacher. |


## studentCancelHandsUp

```typescript
studentCancelHandsUp: () => Promise<void>,
```

The student lowers the hand to cancel the application for speaking up.

## handsUpStudentList

```typescript
handsUpStudentList: {
    userUuid: string;
    userName: string;
    coVideo: boolean;
}[],
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
teacherAcceptHandsUp: (userUuid: string) => Promise<void>,
```

The teacher accepts the student's application for speaking up.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | The student ID. |

## teacherRejectHandsUp

```typescript
teacherRejectHandsUp: (userUuid: string) => Promise<void>,
```

The teacher approves the student's application for speaking up.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | The student ID. |