# useBoardContext

`useBoardContext()` provides whiteboard-related capabilities.

You can import `useBoardContext` by `import {useBoardContext} from'agora-edu-core';`, and then use `const {...} = useBoardContext()` to get the whiteboard-related ability in the flexible classroom.

This page lists all the functions and events provided by `useBoardContext()`.

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
courseWareList: [],

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
tools: array,
```

The list of the whiteboard editing tools.

## changeStroke

```typescript
async changeStroke(value: any): void
```

Set the line thickness.

## changeHexColor

```typescript
async changeHexColor(colorHex: string): void
```

Select a color.

## mountToDOM

```typescript
async mountToDOM(dom: HTMLDivElement | null): void
```

Mount or unmount the whiteboard to the DOM.

## setTool

```typescript
async setTool(tool: string): void
```

Switch tools.

## zoomBoard

```typescript
async zoomBoard(type: string): void
```

Zoom in or out the whiteboard.

## setZoomScale

```typescript
async setZoomScale(operation: string): void
```

Set the ration of zooming in or out.

## changeFooterMenu

```typescript
async changeFooterMenu(itemName: string): void
```

Set to which whiteboard page that you want to jump to.

## downloadList

```typescript
downloadList: array,
```

The list of downloadable classroom resources.

## putSceneByResourceUuid

```typescript
async putSceneByResourceUuid(uuid: string): void
```

Display the courseware on the whiteboard.

## startDownload

```typescript
async startDownload (taskUuid: string): void
```

Start downloading the courseware.

## updatePen

```typescript
async updatePen(value: any): void
```

Update the pen.

## boardPenIsActive

```typescript
boardPenIsActive: boolean,
```

Whether the currently selected tool is a pen.

## startOrStopSharing

```typescript
async startOrStopSharing(): void
```

Start or stop screen sharing.

## setLaserPoint

```typescript
setLaserPoint(): void
```

Select the laser pointer.

## resourcesList

```typescript
resourcesList: array,
```

The list of the courseware.

## refreshCloudResources

```typescript
async refreshCloudResources(): void
```

Update the courseware list.

## removeMaterialList

```typescript
async removeMaterialList(resourceUuids: string[]): void
```

Remove the courseware.

## cancelUpload

```typescript
async cancelUpload(): void
```

Cancel uploading a file to the classroom.

## doUpload

```typescript
async doUpload(payload: any): void
```

Upload a file to the classroom.

## closeMaterial

```typescript
async closeMaterial(resourceUuid: string): void
```

Close the file.

## installTools

```typescript
async installTools(tools: any[]): void
```

Install tools.

## personalResources

```typescript
personalResources: array,
```

The list of courseware uploaded by the teacher through the Flexible Classroom client.

## publicResources

```typescript
publicResources: array,
```

The list of courseware assigned by the teaching institution.

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