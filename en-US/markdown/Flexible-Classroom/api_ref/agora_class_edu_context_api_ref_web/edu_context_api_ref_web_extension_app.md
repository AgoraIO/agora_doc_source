# Ext App Context

## AgoraExtAppContext

### properties

```JavaScipt
properties: any;
```

Extend the properties of the application.

### dependencies {


```JavaScipt
dependencies: Map<string, any>;
```

Extend the dependency of the application.

### localUserInfo

```JavaScipt
localUserInfo: AgoraExtAppUserInfo;
```

User-related information in the current classroom, including:

- `userUuid`: The UUID of the` user`.
- `userName`: The name of the` user`.
- `roleType`: User` role`.

### roomInfo

```JavaScipt
roomInfo: AgoraExtAppRoomInfo;
```

Current classroom related information, including:

- `roomUuid`: The classroom ID.
- `roomName`: The name of the` room`.
- `roomType`: The type of the classroom to be recorded.

### language

```JavaScipt
language: string;
```

Extend the language of the application.

## AgoraExtAppHandle

### updateRoomProperty

```TypeScipt
updateRoomProperty: (properties: any, cause: any) => Promise<void>;
```

Update class attributes.

| Parameter | Description |
| :----------- | :--------- |
| `properties` | Attributes. |
| `cause` | Reason for update. |

### deleteRoomProperties

```JavaScipt
deleteRoomProperties: (properties: string[], cause: any) => Promise<void>;
```

Delete properties.

| Parameter | Description |
| :----------- | :--------- |
| `properties` | Attributes. |
| `cause` | Reason for update. |