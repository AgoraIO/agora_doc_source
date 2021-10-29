## AgoraExtAppContext

### properties

```JavaScipt
properties: any;
```

The properties of the extension application.

### dependencies

```JavaScipt
dependencies: Map<string, any>;
```

The dependencies of the extension application.

### localUserInfo

```JavaScipt
localUserInfo: AgoraExtAppUserInfo;
```

Information of the local user:

- `userUuid`: The user ID.
- `userName`: The user name.
- `roleType`: The user role.

### roomInfo

```JavaScipt
roomInfo: AgoraExtAppRoomInfo;
```

Information of the current classroom:

- `roomUuid`: The classroom ID.
- `roomName`: The classroom name.
- `roomType`: The classroom type.

### language

```JavaScipt
language: string;
```

The language of the extension application.

## AgoraExtAppHandle

### updateRoomProperty

```TypeScipt
updateRoomProperty: (properties: any, cause: any) => Promise<void>;
```

Updates custom classroom properties.

| Parameter | Description |
| :----------- | :--------- |
| `properties` | Properties. |
| `cause` | The update reason. |

### deleteRoomProperties

```JavaScipt
deleteRoomProperties: (properties: string[], cause: any) => Promise<void>;
```

Delete custom classroom properties.

| Parameter | Description |
| :----------- | :--------- |
| `properties` | Properties. |
| `cause` | The update reason. |