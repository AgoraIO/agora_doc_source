# useHandsUpContext

`useHandsUpContext` provides the ability to raise hands.

You can` import useHandsUpContext by import {useHandsUpContext} from'agora-edu-core';```, and then` use const {...} = useHandsUpContext()` to obtain the ability to raise hands in   Flexible Classroom.

The following specifically lists the capabilities provided by `useHandsUpContext()`.

## teacherUuid

```typescript
teacherUuid: string,
```

The ID of the teacher.

## handsUpState

```typescript
handsUpState: string,
```

The student's hand-raising state.

## teacherHandsUpState

```typescript
teacherHandsUpState: string,
```

The teacher's hand-raising state.

## studentHandsUp

```typescript
async studentHandsUp(teacherUuid: string): void
```

The student raised his hand and asked the teacher to speak.


| Parameter | Description |
| :------------ | :---------- |
| `teacherUuid` | The ID of the teacher. |


## studentCancelHandsUp

```typescript
async studentCancelHandsUp(): void
```

The student cancels the request to raise the hand.

## handsUpStudentList

```typescript
handsUpStudentList: array<{userUuid, userName, coVideo}>,
```

Raise your hand to the list of students.

## coVideoUsers

```typescript
coVideoUsers: array,
```

A list of users who are currently sending video streams.

## onlineUserCount

```typescript
onlineUserCount: number,
```

The total number of online users (not including users whose role is audience).

## processUserCount

```typescript
processUserCount: number,
```

The total number of users currently sending video streams.

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