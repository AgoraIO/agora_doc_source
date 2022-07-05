## AgoraExtAppContext

### properties

```JavaScipt
properties: any;
```

扩展应用的属性。

### dependencies

```JavaScipt
dependencies: Map<string, any>;
```

扩展应用的依赖。

### localUserInfo

```JavaScipt
localUserInfo: AgoraExtAppUserInfo;
```

当前课堂的用户相关信息，包含：

-   `userUuid`: 用户 ID。
-   `userName`: 用户名称。
-   `roleType`: 用户角色。

### roomInfo

```JavaScipt
roomInfo: AgoraExtAppRoomInfo;
```

当前课堂相关信息，包含：

-   `roomUuid`: 课堂 ID。
-   `roomName`: 课堂名称。
-   `roomType`: 课堂类型。

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

| 参数         | 描述       |
| :----------- | :--------- |
| `properties` | 属性。     |
| `cause`      | 更新原因。 |

### deleteRoomProperties

```JavaScipt
deleteRoomProperties: (properties: string[], cause: any) => Promise<void>;
```

删除课堂属性。

| 参数         | 描述       |
| :----------- | :--------- |
| `properties` | 属性。     |
| `cause`      | 更新原因。 |
