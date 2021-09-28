`useUserListContext(`) enables developers to implement the user list module in the flexible classroom.

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

Gets the information of the local client.

## teacherInfo

```javascript
teacherInfo?: EduUser,
```

> Since v1.1.5.

当前课堂的老师信息。

## toggleWhiteboardPermission

```javascript
toggleWhiteboardPermission: (userUuid:string, whiteboardGranted: boolean) => Promise<any>,
```

> Since v1.1.5.

设置指定用户的白板权限。

| Parameter | Description |
| :------------------ | :------------------------- |
| `userUuid` | The user ID. |
| `whiteboardGranted` | 是否授予指定用户白板权限。 |

## toggleCamera

```javascript
toggleCamera: (userUuid:string, enabled: boolean) => Promise<any>,
```

> Since v1.1.5.

Turn off the camera of the specified user.

| Parameter | Description |
| :--------- | :--------------- |
| `userUuid` | The user ID. |
| `enabled` | Whether the camera is turned on. |

## toggleMic

```javascript
toggleMic: (userUuid:string, enabled: boolean) => Promise<any>,
```

> Since v1.1.5.

开启或关闭指定用户的麦克风。

| Parameter | Description |
| :--------- | :--------------- |
| `userUuid` | The user ID. |
| `enabled` | Whether to the microphone is turned on. |

## controlTools

```javascript
controlTools: ControlTool[],
```

> Since v1.1.5.

可用的用户管理工具。

## controlTools

```javascript
isHost: boolean
```

> Since v1.1.5.

是否为房主。

## kick

```javascript
kick: (userUuid:string) => Promise<any>,
```

> Since v1.1.5.

将指定用户踢出房间。

| Parameter | Description |
| :--------- | :-------- |
| `userUuid` | The user ID. |
