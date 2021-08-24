This page lists all the functions and events provided by `CloudDriveContext` for coureseware management.

## downloadList

```typescript
downloadList: StorageCourseWareItem[],
```

The list of downloadable classroom resources.

## openCloudResource

```typescript
openCloudResource: (uuid: string) => Promise<void>,
```

Open a file and display it on the whiteboard.

| Parameter | Description  |
| :-------- | :----------- |
| `uuid`    | The file ID. |

## startDownload

```typescript
startDownload: (taskUuid: string) => Promise<void>,
```

Start downloading the a file to the local device.

| Parameter  | Description                                    |
| :--------- | :--------------------------------------------- |
| `taskUuid` | The ID of the whiteboard file conversion task. |

## deleteSingle

```typescript
deleteSingle: (taskUuid: string) => Promise<void>,
```

Delete a file from the cloud driver.

| Parameter  | Description                                    |
| :--------- | :--------------------------------------------- |
| `taskUuid` | The ID of the whiteboard file conversion task. |

## personalResources

```typescript
personalResources: MaterialDataResource[],
```

The list of courseware uploaded by the teacher through the Flexible Classroom client.

## publicResources

```typescript
publicResources: MaterialDataResource[],
```

The list of courseware assigned by the teaching institution.

## refreshCloudResources

```typescript
refreshCloudResources: () => Promise<void>,
```

Update the courseware list.

## removeMaterialList

```typescript
removeMaterialList: (resourceUuids: string[]) => Promise<void>,
```

Remove the courseware.

## cancelUpload

```typescript
cancelUpload: () => Promise<void>,
```

Cancel uploading a file to the classroom.

## doUpload

```typescript
doUpload: (payload: any) => Promise<void>,
```

Upload a file to the classroom.

## closeMaterial

```typescript
closeMaterial: (resourceUuid: string) => void,
```

Close the file.
