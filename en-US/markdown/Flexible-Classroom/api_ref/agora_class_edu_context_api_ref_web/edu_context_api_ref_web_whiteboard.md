This page lists all the functions and events provided by `BoardContext` for the interactive whiteboard module of Flexible Classroom.

## room

```typescript
room: object,
```

The whiteboard room object.

## zoomValue

```typescript
zoomValue: number,
```

The value of zooming in or out the whiteboard.

## currentPage

```typescript
currentPage: number,
```

The current number of the whiteboard page.

## totalPage

```typescript
totalPage: number,
```

The total number of whiteboard pages.

## courseWareList

```typescript
courseWareList: array,
```

The list of the courseware.

## currentColor

```typescript
currentColor: string,
```

The color.

## currentStrokeWidth

```typescript
currentStrokeWidth: number,
```

The line thickness.

## hasPermission

```typescript
hasPermission: boolean,
```

Whether the user has permission of drawing on the whiteboard.

## currentSelector

```typescript
currentSelector: string,
```

The whiteboard selector.

## lineSelector

```typescript
lineSelector: string,
```

The line drawing tool.

## activeMap

```typescript
activeMap: Record<string, boolean>,
```

The active whiteboard tools by default.

## ready

```typescript
ready: boolean,
```

Whether the whiteboard is ready.

## tools

```typescript
tools: any[],
```

The list of the whiteboard editing tools.

## changeStroke

```typescript
changeStroke: (value: any) => void,
```

Set the line thickness.

## changeHexColor

```typescript
changeHexColor: (value: any) => void,
```

Select a color.

## mountToDOM

```typescript
mountToDOM: (dom: HTMLDivElement | null) => void,
```

Mount or unmount the whiteboard to the DOM.

## setTool

```typescript
setTool: (tool: string) => void,
```

Switch tools.

## zoomBoard

```typescript
zoomBoard: (type: string) => void,
```

Whether to make the whitboard fullscreen.

| Parameter | Description                                                  |
| :-------- | :----------------------------------------------------------- |
| `type`    | <li> `fullscreen` : Make the whitboard fullscreen.<li> `fullscreenExit`: Exit fullscreen. |

## setZoomScale

```typescript
setZoomScale: (operation: string) => void,
```

Zoom in or out the whiteboard.

## changeFooterMenu

```typescript
changeFooterMenu: (itemName: string) => void,
```

Set to which whiteboard page that you want to jump to.

## updatePen

```typescript
updatePen: (value: any) => void,
```

Update the pen.

## boardPenIsActive

```typescript
boardPenIsActive: boolean,
```

Whether the currently selected tool is a pen.

## setLaserPoint

```typescript
setLaserPoint: () => void,
```

Select the laser pointer.

## installTools

```typescript
async installTools(tools: any[]): void
```

Install tools.

## revokeUserPermission

```typescript
async revokeUserPermission(userUuid: string): void
```

Cancel the whiteboard authorization.

## grantUserPermission

```typescript
async grantUserPermission(userUuid: string): void
```

Grant the permission of drawing on the whiteboard to a specified student.