# Ext App Context

## AgoraExtAppContext

### properties

```JavaScipt
properties: any;
```

扩展应用的属性。

### dependencies {


```JavaScipt
dependencies: Map<string, any>;
```

扩展应用的依赖。

### localUserInfo

```JavaScipt
localUserInfo: AgoraExtAppUserInfo;
```

当前课堂的用户相关信息，包含：

- `userUuid`: The UUID of the` user`.
- `userName`: The name of the` user`.
- `roleType`: 用户角色。

### roomInfo

```JavaScipt
roomInfo: AgoraExtAppRoomInfo;
```

当前课堂相关信息，包含：

- `roomUuid`: The classroom ID.
- `roomName`: The name of the` room`.
- `roomType`: The type of the classroom to be recorded.

### language

```JavaScipt
language: string;
```

扩展应用的语言。

## AgoraExtAppHandle

### updateRoomProperty

```TypeScipt
updateRoomProperty: (properties: any, cause: any) => Promise<void>;
```

更新课堂属性。

| Parameter | Description |
| :----------- | :--------- |
| `properties` | 属性。 |
| `cause` | 更新原因。 |

### deleteRoomProperties

```JavaScipt
deleteRoomProperties: (properties: string[], cause: any) => Promise<void>;
```

Delete properties.

| Parameter | Description |
| :----------- | :--------- |
| `properties` | 属性。 |
| `cause` | 更新原因。 |