# useUserListContext

`useUserListContext()` 提供用户列表相关能力。

你可以通过 `import { useUserListContext } from 'agora-edu-core';  ` 引入 `useUserListContext`，然后使用 `const {...} = useUserListContext()` 获取灵动课堂中课堂管理相关能力。

以下具体列出 `useUserListContext()` 提供的能力。

## localUserUuid

```javascript
localUserUuid: string,
```

本地用户的 ID。

## muteAudio

```javascript
myRole: string,
```

本地用户的角色。

## rosterUserList

```javascript
rosterUserList: array,  
```

当前课堂显示在用户列表中的学生列表。

## handleRosterClick

```javascript
async handleRosterClick(actionType: string, uid: string): void
```

处理在用户列表上的点击事件，如上台、白板授权、打开摄像头或麦克风。

| 参数         | 描述          |
| :----------- | :------------ |
| `actionType` | 操作类型。    |
| `uid`        | 操作者的 ID。 |

## revokeCoVideo

```javascript
async revokeCoVideo(userUuid: string): void
```

关闭指定用户的摄像头。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 用户 ID。 |

## teacherAcceptHandsUp

```javascript
async teacherAcceptHandsUp(userUuid: string): void
```

老师同意学生的举手请求。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 用户 ID。 |

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
