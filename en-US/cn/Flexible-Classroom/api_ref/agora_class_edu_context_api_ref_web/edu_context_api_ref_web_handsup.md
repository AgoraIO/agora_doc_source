# useHandsUpContext

`useHandsUpContext()` 提供举手上台相关能力。

You can import `useHandsUpContext` by `import { useHandsUpContext } from 'agora-edu-core';` and then use `const {...} = useHandsUpContext()` to implement the functions and events related to classroom management.

This page lists all the functions and events provided by `useHandsUpContext()`.

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

在线用户总数（不包含角色为观众的用户）。

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