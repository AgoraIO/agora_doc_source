# useUserListContext

`useUserListContext()` enables developers to implement the user list module in the flexible classroom.

You can` import useUserListContext by import { useUserListContext } from 'agora-edu-core';` and then `use`` const {...} = useUserListContext()` to implement the functions and events related to the user list.

This page lists all the functions and events provided by `useUserListContext()`.

## localUserUuid

```javascript
localUserUuid: string,
```

The ID of the local user.

## myRole

```javascript
myRole: string,
```

The role of the local user.

## rosterUserList

```javascript
rosterUserList: array,  
```

The students displayed in the user list of the classroom.

## handleRosterClick

```javascript
async handleRosterClick(actionType: string, uid: string): void
```

Handle the click events on the user list, such as standing on the stage, whiteboard authorization, turning on the camera or microphone.

| Parameter | Description |
| :----------- | :------------ |
| `actionType` | The action. |
| `uid` | The ID of the operator. |

## revokeCoVideo

```javascript
async revokeCoVideo(userUuid: string): void
```

Turn off the camera of the specified user.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | The user ID. |

## teacherAcceptHandsUp

```javascript
async teacherAcceptHandsUp(userUuid: string): void
```

The teacher accepts the student's application for speaking up.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | The user ID. |

## userList

```javascript
userList: array,
```

The list of all users in the classroom.

## acceptedUserList

```javascript
acceptedUserList: array,
```

The list of users whose application for speaking up has been approved by the teacher.
