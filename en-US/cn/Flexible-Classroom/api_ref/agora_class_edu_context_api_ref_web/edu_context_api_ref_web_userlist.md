# useUserListContext useUserListContext

`useUserListContext()` enables developers to implement the user list module in the flexible classroom. `useUserListContext()` 提供用户列表相关能力。

你可以通过 `import { useUserListContext } from 'agora-edu-core';  ` 引入 `useUserListContext`，然后使用 `const {...} = useUserListContext()` 获取灵动课堂中用户列表相关能力。 你可以通过 `import { useUserListContext } from 'agora-edu-core';  ` 引入 `useUserListContext`，然后使用 `const {...} = useUserListContext()` 获取灵动课堂中用户列表相关能力。

This page lists all the functions and events provided by `useUserListContext()`. 以下具体列出 `useUserListContext()` 提供的能力。

## localUserUuid localUserUuid

```javascript
localUserUuid: string, localUserUuid: string,
```

The ID of the local user. 本地用户的 ID。

## myRole myRole

```javascript
myRole: string, myRole: string,
```

The role of the local user. 本地用户的角色。

## rosterUserList rosterUserList

```javascript
rosterUserList: array, rosterUserList: array,  
```

The students displayed in the user list of the classroom. 当前课堂显示在用户列表中的学生列表。

## handleRosterClick handleRosterClick

```javascript
async handleRosterClick(actionType: string, uid: string): void async handleRosterClick(actionType: string, uid: string): void
```

Handle the click events on the user list, such as standing on the stage, whiteboard authorization, turning on the camera or microphone. 处理在用户列表上的点击事件，如上台、白板授权、打开摄像头或麦克风。

| Parameter Parameter | Description Description |
| :----------- | :------------ |
| `actionType ``actionType` | The action. 操作类型。 |
| `uid ``uid` | The ID of the operator. 操作者的 ID。 |

## revokeCoVideo revokeCoVideo

```javascript
async revokeCoVideo(userUuid: string): void async revokeCoVideo(userUuid: string): void
```

Turn off the camera of the specified user. 关闭指定用户的摄像头。

| Parameter Parameter | Description Description |
| :--------- | :-------- |
| `userUuid ``userUuid` | The user ID. The user ID. |

## teacherAcceptHandsUp teacherAcceptHandsUp

```javascript
async teacherAcceptHandsUp(userUuid: string): void async teacherAcceptHandsUp(userUuid: string): void
```

The teacher accepts the student's application for speaking up. 老师同意学生的举手请求。

| Parameter Parameter | Description Description |
| :--------- | :-------- |
| `userUuid ``userUuid` | The user ID. The user ID. |

## userList userList

```javascript
userList: array, userList: array,
```

The list of all users in the classroom. 当前课堂内的所有用户列表。

## acceptedUserList acceptedUserList

```javascript
acceptedUserList: array, acceptedUserList: array,
```

The list of users whose application for speaking up has been approved by the teacher. 举手请求被老师同意的学生列表。
