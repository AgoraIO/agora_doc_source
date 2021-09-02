This page lists all the functions and events provided by `UserListContext` for user management.

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

## handleRosterClick

```javascript
async handleRosterClick(actionType: string, uid: string): void
```

Handle the click events on the user list, such as standing on the stage, whiteboard authorization, turning on the camera or microphone.

| Parameter | Description |
| :----------- | :------------ |
| `actionType` | The action. |
| `uid` | The ID of the operator. |
