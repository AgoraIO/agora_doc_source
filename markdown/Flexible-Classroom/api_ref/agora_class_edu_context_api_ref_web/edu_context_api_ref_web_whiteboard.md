`BoardContext` 提供白板相关能力。

## boardConnectionState

```typescript
boardConnectionState: string;
```

> 自 v1.1.5 起新增。

白板连接状态。

## joinBoard

```typescript
joinBoard: () => Promise<any>;
```

> 自 v1.1.5 起新增。

加入白板房间。

## leaveBoard

```typescript
leaveBoard: () => Promise<any>;
```

> 自 v1.1.5 起新增。

离开白板房间。

## room

```typescript
room: object,
```

白板房间对象。

## zoomValue

```typescript
zoomValue: number,
```

白板缩放的值。

## currentPage

```typescript
currentPage: number,  
```

当前白板页数。

## totalPage

```typescript
totalPage: number,
```

白板总页数。

## courseWareList

```typescript
courseWareList: array,
```

课件列表。

## currentColor

```typescript
currentColor: string,
```

当前画笔颜色。

## currentStrokeWidth

```typescript
currentStrokeWidth: number,
```

当前画笔宽度。

## hasPermission

```typescript
hasPermission: boolean,
```

是否拥有白板权限。

## currentSelector

```typescript
currentSelector: string,
```

当前白板的选择工具。

## lineSelector

```typescript
lineSelector: string,
```

当前白板的线条工具。

## activeMap

```typescript
activeMap: Record<string, boolean>,
```

默认激活的工具。

## ready

```typescript
ready: boolean,
```

白板是否准备完毕。

## tools

```typescript
tools: array,
```

白板基础工具列表。

## changeStroke

```typescript
async changeStroke(value: any): void
```

修改画笔宽度。

## changeHexColor

```typescript
async changeHexColor(colorHex: string): void
```

修改颜色。

## mountToDOM

```typescript
async mountToDOM(dom: HTMLDivElement | null): void
```

将白板挂载在 DOM 节点上或者卸载白板。

## setTool

```typescript
async setTool(tool: string): void
```

切换工具。

## zoomBoard

```typescript
async zoomBoard(type: string): void
```

放大或缩小白板。

## setZoomScale

```typescript
async setZoomScale(operation: string): void
```

设置放大或缩小的比例。

## changeFooterMenu

```typescript
async changeFooterMenu(itemName: string): void
```

设置白板跳转到哪一页。

## downloadList

```typescript
downloadList: array,
```

可下载的云盘资源列表。

## putSceneByResourceUuid

```typescript
async putSceneByResourceUuid(uuid: string): void
```

在白板上打开课件。

## startDownload

```typescript
async startDownload(taskUuid: string): void
```

开始下载课件。

## updatePen

```typescript
async updatePen(value: any): void
```

更新画笔。

## boardPenIsActive

```typescript
boardPenIsActive: boolean,
```

当前白板使用的工具是否为画笔。

## startOrStopSharing

```typescript
async startOrStopSharing(): void
```

开始或停止屏幕共享。

## setLaserPoint

```typescript
setLaserPoint(): void
```

设置当前工具为激光笔。

## resourcesList

```typescript
resourcesList: array,
```

课件列表。

## refreshCloudResources

```typescript
async refreshCloudResources(): void
```

更新课件列表。

## removeMaterialList

```typescript
async removeMaterialList(resourceUuids: string[]): void
```

移除课件。

## cancelUpload

```typescript
async cancelUpload(): void
```

取消上传课件。

## doUpload

```typescript
async doUpload(payload: any): void
```

上传课件。

## closeMaterial

```typescript
async closeMaterial(resourceUuid: string): void
```

关闭课件。

## installTools

```typescript
async installTools(tools: any[]): void
```

安装工具。

## personalResources

```typescript
personalResources: array,
```

老师通过灵动课堂客户端上传的课件列表。

## publicResources

```typescript
publicResources: array,
```

教学机构指派的课件列表。

## revokeUserPermission

```typescript
async revokeUserPermission(userUuid: string): void
```

取消白板授权。

## grantUserPermission

```typescript
async grantUserPermission(userUuid: string): void
```

给予指定学生白板权限。