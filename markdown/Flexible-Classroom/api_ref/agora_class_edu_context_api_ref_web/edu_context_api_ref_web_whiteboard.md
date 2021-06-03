# BoardContext

`BoardContext` 提供白板相关能力。

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

当前白板的画线工具。

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
tools: any[],
```

白板基础工具列表。

## changeStroke

```typescript
changeStroke: (value: any) => void,
```

修改画笔宽度。

## changeHexColor

```typescript
changeHexColor: (value: any) => void,
```

修改颜色。

## mountToDOM

```typescript
mountToDOM: (dom: HTMLDivElement | null) => void,
```

将白板挂载在 DOM 节点上或者卸载白板。

## setTool

```typescript
setTool: (tool: string) => void,
```

切换白板工具。

| 参数   | 描述       |
| :----- | :--------- |
| `tool` | 工具名称。 |

## zoomBoard

```typescript
zoomBoard: (type: string) => void,
```

全屏白板。

| 参数   | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| `type` | 可设为：<li> `fullscreen` : 全屏。<li> `fullscreenExit`: 退出全屏。 |

## setZoomScale

```typescript
setZoomScale: (operation: string) => void,
```

放大或缩小白板。

| 参数        | 描述                                                |
| :---------- | :-------------------------------------------------- |
| `operation` | 可设为：<li> `out`: 缩小白板。<li> `in`: 放大白板。 |

## changeFooterMenu

```typescript
changeFooterMenu: (itemName: string) => void,
```

设置白板跳转到哪一页。

| 参数       | 描述                                                         |
| :--------- | :----------------------------------------------------------- |
| `itemName` | 可设为：<li>`first_page`: 第一页。<li> `last_page`: 最后一页。<li>`next_page`: 下一页。<li>`prev_page`: 上一页。 |

## updatePen

```typescript
updatePen: (value: any) => void,
```

更新画笔。

## boardPenIsActive

```typescript
boardPenIsActive: boolean,
```

当前白板使用的工具是否为画笔。

## setLaserPoint

```typescript
setLaserPoint: () => void,
```

设置当前工具为激光笔。

## installTools

```typescript
async installTools(tools: any[]): void
```

安装白板工具。

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

## showBoardTool

```typescript
showBoardTool: [boolean, boolean];
```

当前是否显示白板基础工具栏和页面控制工具栏。