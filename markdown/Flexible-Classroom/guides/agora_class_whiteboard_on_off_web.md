灵活课堂中的白板模块是基于 `AgoraWidget` 实现的。你可以通过将 widget 状态设置为活跃（active）或非活跃（inactive）来在教室中打开或关闭白板模块。

禁用白板模块后，铅笔、文本框、形状和橡皮擦等绘图工具将不再可用，用户也不能在白板上显示类文件。 上传或删除课程文件、弹出式测验、倒计时和屏幕共享等其他不依赖白板的功能不会受到影响。//TODO 什么是类文件

## 启用和禁用白板

实现启用或禁用白板的过程中，你需要监控教师客户端引起的白板状态变化，并相应地调整 UI。 你可以参考下面这个 web 端示例项目。

1. 获取源码 flexibleclassroom //TODO 为什么 ios 端获取的是 cloudclass 仓库

2. 调用白板相关接口 `boardApi.enable()` 和 `boardApi.disable()` 以启用和禁用白板。 //TODO ios 端写了在哪个文件中调用相关接口，以及检测状态变化改变 UI。示例代码是否需要用上检查连接状态，权限相关的接口

    ```typescript
    ...
    // 启用白板
    this.boardApi.enable();
    ...
    // 禁用白板
    this.boardApi.disable();
    ...
    ```

## API 参考

白板界面打包在这个目录下：packages/agora-classroom-sdk/src/infra/stores/common/base.ts文件夹：

```typescript
 get boardApi() {
   return EduUIStoreBase._boardApi;
 }
```

白板相关的接口在这个文件中 `packages/agora-classroom-sdk/src/infra/protocol/board.ts`:

//TODO 如果提供 API 参考，是否要提供 BoardConnectionState，BoardMountState，hasPrivilege()，sendBoardCommandMessage的信息
#### connected

```typescript
@computed
get connected() {
  return this.connState === BoardConnectionState.Connected;
}
```

查询白板是否连接到服务器。

**返回值**
//TODO 确认下
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
//TODO 确认下
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
//TODO 确认下
- `true`：有权限。
- `false`：无权限。
 
 #### enable

 ```typescript
enable() {
  this._sendBoardCommandMessage(AgoraExtensionRoomEvent.ToggleBoard, true);
}
```

连接并启用白板。

#### disable

```typescript
disable() {
  this._sendBoardCommandMessage(AgoraExtensionRoomEvent.ToggleBoard, false);
}
```

断开连接并关闭白板。

