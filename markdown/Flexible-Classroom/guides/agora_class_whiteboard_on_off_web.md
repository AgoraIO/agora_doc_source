灵动课堂中的白板模块是基于 `AgoraWidget` 实现的。你可以通过将 widget 状态设置为活跃（active）或非活跃（inactive）来在教室中打开或关闭白板模块。

关闭白板模块后，铅笔、文本框、形状和橡皮擦等绘图工具将不再可用，用户也不能在白板上显示课件，上传或删除课程文件。弹出式测验、倒计时和屏幕共享等其他不依赖白板的功能不会受到影响。

## 开启和关闭白板

白板界面打包在 `packages/agora-classroom-sdk/src/infra/stores/common/base.ts` 文件中，白板相关的接口在 `packages/agora-classroom-sdk/src/infra/protocol/board.ts` 文件中。

```typescript
 get boardApi() {
   return EduUIStoreBase._boardApi;
 }
```

实现开启或关闭白板的过程中，你需要监控教师客户端引起的白板状态变化，并相应地调整 UI。 

调用白板相关接口 `boardApi.enable()` 和 `boardApi.disable()` 以开启和关闭白板。 

```typescript
...
// 开启白板
this.boardApi.enable();
...
// 关闭白板
this.boardApi.disable();
...
```

## API 参考

#### connected

```typescript
@computed
get connected() {
  return this.connState === BoardConnectionState.Connected;
}
```

查询白板是否连接到服务器。

**返回值**

- `true`：已连接。
- `false`：未连接。

#### mounted

```typescript
@computed
get mounted() {
  return this.mountState === BoardMountState.Mounted;
}
```

查询白板是否已挂载。

**返回值**

- `true`：已挂载。
- `false`：未挂载。

#### granted

```typescript
@computed
get granted() {
  return this.hasPrivilege();
}
```

查询用户是否有操作白板权限。

**返回值**

- `true`：有权限。
- `false`：无权限。
 
 #### enable

 ```typescript
enable() {
  this._sendBoardCommandMessage(AgoraExtensionRoomEvent.ToggleBoard, true);
}
```

连接并开启白板。

#### disable

```typescript
disable() {
  this._sendBoardCommandMessage(AgoraExtensionRoomEvent.ToggleBoard, false);
}
```

断开连接并关闭白板。

