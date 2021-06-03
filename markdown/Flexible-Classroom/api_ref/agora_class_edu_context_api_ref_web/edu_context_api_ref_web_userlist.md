# UserListContext

`UserListContext` 提供用户列表相关能力。

## rosterUserList

```javascript
rosterUserList: any[],
```

当前课堂显示在用户列表中的学生列表。

## userList

```javascript
userList: array,
```

当前课堂内的所有用户列表。

## acceptedUserList

```javascript
acceptedUserList: array,
```

举手请求被老师同意的学生列表。

## localUserInfo

```javascript
localUserInfo: EduUser,
```

本地用户信息。

## teacherInfo

```javascript
teacherInfo?: EduUser,
```

当前课堂的老师信息。

## toggleWhiteboardPermission

```javascript
toggleWhiteboardPermission: (userUuid:string, whiteboardGranted: boolean) => Promise<any>,
```

设置指定用户的白板权限。

| 参数                | 描述                       |
| :------------------ | :------------------------- |
| `userUuid`          | 用户 ID。                  |
| `whiteboardGranted` | 是否授予指定用户白板权限。 |

## toggleCamera

```javascript
toggleCamera: (userUuid:string, enabled: boolean) => Promise<any>,
```

开启或关闭指定用户的摄像头。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `enabled`  | 摄像头是否开启。 |

## toggleMic

```javascript
toggleMic: (userUuid:string, enabled: boolean) => Promise<any>,
```

开启或关闭指定用户的麦克风。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `enabled`  | 麦克风是否开启。 |

## kick

```javascript
kick: (userUuid:string) => Promise<any>,
```

将指定用户踢出房间。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 用户 ID。 |
