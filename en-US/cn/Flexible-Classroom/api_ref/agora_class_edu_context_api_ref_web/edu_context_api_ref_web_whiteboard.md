# useBoardContext

`useBoardContext() provides whiteboard` related capabilities.

You can` import useBoardContext by import {useBoardContext} from'agora-edu-core';```, and then` use const {...} = useBoardContext()` to get the ability to chat in the  Flexible Classroom.

The following specifically lists` the capabilities provided by useBoardContext()`.

## room

```typescript
room: object,
```

whiteboard room object.

## zoomValue

```typescript
zoomValue: number,
```

The value of  whiteboard zoom.

## currentPage

```typescript
currentPage: number,
```

The current number of whiteboard pages.

## totalPage

```typescript
totalPage: number,
```

The total number of whiteboard pages.

## courseWareList

```typescript
courseWareList: [],

```

List of courseware.

## currentColor

```typescript
currentColor: string,
```

The current pen color.

## currentStrokeWidth

```typescript
currentStrokeWidth: number,
```

The current pen width.

## hasPermission

```typescript
hasPermission: boolean,
```

Whether to have whiteboard permission.

## currentSelector

```typescript
currentSelector: string,
```

The selection tool of the current whiteboard.

## lineSelector

```typescript
lineSelector: string,
```

The line tool of the current whiteboard.

## activeMap

```typescript
activeMap: Record<string, boolean>,
```

Tools activated by default.

## ready

```typescript
ready: boolean,
```

Is  whiteboard ready?

## tools

```typescript
tools: array,
```

List of whiteboard tools.

## changeStroke

```typescript
async changeStroke(value: any): void
```

Modify the brush width.

## changeHexColor

```typescript
async changeHexColor(colorHex: string): void
```

Modify the brush color.

## mountToDOM

```typescript
async mountToDOM(dom: HTMLDivElement | null): void
```

Mount  whiteboard on the DOM node or unmount  whiteboard.

## setTool

```typescript
async setTool(tool: string): void
```

Switch tools.

## zoomBoard

```typescript
async zoomBoard(type: string): void
```

Zoom in or zoom out  whiteboard.

## setZoomScale

```typescript
async setZoomScale(operation: string): void
```

Set the enlargement or reduction ratio.

## changeFooterMenu

```typescript
async changeFooterMenu(itemName: string): void
```

Set which page the whiteboard jumps to.

## downloadList

```typescript
downloadList: array,
```

List of downloadable cloud disk resources.

## putSceneByResourceUuid

```typescript
async putSceneByResourceUuid(uuid: string): void
```

Open the courseware on the whiteboard.

## startDownload

```typescript
async startDownload (taskUuid: string): void
```

Start preloading the courseware.

## updatePen

```typescript
async updatePen(value: any): void
```

Update the brush.

## boardPenIsActive

```typescript
boardPenIsActive: boolean,
```

Whether the tool currently used by  whiteboard is a pen.

## startOrStopSharing

```typescript
async startOrStopSharing(): void
```

Start or stop screen sharing.

## setLaserPoint

```typescript
setLaserPoint(): void
```

Set the current tool as a laser pointer.

## resourcesList

```typescript
resourcesList: array,
```

List of courseware.

## refreshCloudResources

```typescript
async refreshCloudResources(): void
```

Update the list of courseware.

## removeMaterialList

```typescript
async removeMaterialList(resourceUuids: string[]): void
```

Remove courseware.

## cancelUpload

```typescript
async cancelUpload(): void
```

Cancel upload of courseware.

## doUpload

```typescript
async doUpload(payload: any): void
```

Upload the courseware.

## closeMaterial

```typescript
async closeMaterial(resourceUuid: string): void
```

Close the courseware.

## installTools

```typescript
async installTools(tools: any[]): void
```

Installation tools.

## personalResources

```typescript
personalResources: array,
```

The list of courseware uploaded by the teacher through the  Flexible Classroom client.

## publicResources

```typescript
publicResources: array,
```

A list of courseware assigned by the teaching institution.

## revokeUserPermission

```typescript
async revokeUserPermission(userUuid: string): void
```

Cancel the whiteboard authorization.

## grantUserPermission

```typescript
async grantUserPermission(userUuid: string): void
```

Grant designated students whiteboard permissions.