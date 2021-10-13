`useUserListContext` enables developers to implement the user list module in the flexible classroom.

## rosterUserList

```javascript
rosterUserList: any[],
```

The students displayed in the user list of the classroom.

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

## localUserInfo

```javascript
localUserInfo: EduUser,
```

> Since v1.1.5.

The information of the local client.

## teacherInfo

```javascript
teacherInfo?: EduUser,
```

> Since v1.1.5.

The information of the teacher in the current classroom.

## toggleWhiteboardPermission

```javascript
toggleWhiteboardPermission: (userUuid:string, whiteboardGranted: boolean) => Promise<any>,
```

> Since v1.1.5.

Grants the permission of drawing on the whiteboard to a specified user.

| Parameter | Description |
| :------------------ | :------------------------- |
| `userUuid` | The user ID. |
| `whiteboardGranted` | Whether to grant the permission of drawing on the whiteboard to the specified user. |

## toggleCamera

```javascript
toggleCamera: (userUuid:string, enabled: boolean) => Promise<any>,
```

> Since v1.1.5.

Turns on or off the camera of a specified user.

| Parameter | Description |
| :--------- | :--------------- |
| `userUuid` | The user ID. |
| `enabled` | Whether the camera is turned on. |

## toggleMic

```javascript
toggleMic: (userUuid:string, enabled: boolean) => Promise<any>,
```

> Since v1.1.5.

Turns on or off the microphone of a specified user.

| Parameter | Description |
| :--------- | :--------------- |
| `userUuid` | The user ID. |
| `enabled` | Whether to the microphone is turned on. |

## controlTools

```javascript
controlTools: ControlTool[],
```

> Since v1.1.5.

Available user management tools.

## isHost

```javascript
isHost: boolean
```

> Since v1.1.5.

Whether the local user is the host.

## kick

```javascript
kick: (userUuid:string) => Promise<any>,
```

> Since v1.1.5.

Kicks a specified user out of the classroom.

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | The user ID. |