# useUserListContext

`useUserListContext()` provides user list related capabilities.

You can` import useUserListContext by import {useUserListContext} from'agora-edu-core';```, and then` use const {...} = useUserListContext()` to obtain classroom management related capabilities in  Flexible Classroom.

The following specifically lists the capabilities provided by `useUserListContext()`.

## localUserUuid

```javascript
localUserUuid: string,
```

The ID of the local user.

## muteAudio

```javascript
myRole: string,
```

The role of the local user.

## rosterUserList

```javascript
rosterUserList: array,
```

The current class is displayed in the list of students in the user list.

## handleRosterClick

```javascript
async handleRosterClick(actionType: string, uid: string): void
```

Handle the click events on the user list, such as going to the stage, whiteboard authorization, turning on the camera or microphone.

| Parameter | Description |
| :----------- | :------------ |
| `actionType` | Operation type. |
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

The teacher agreed to the student's request to raise his hand.

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

Raise your hand to request a list of students approved by the teacher.
