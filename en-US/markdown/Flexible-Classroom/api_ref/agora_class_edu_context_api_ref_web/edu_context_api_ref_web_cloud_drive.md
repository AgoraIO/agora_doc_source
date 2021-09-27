# CloudDriveContext

`CloudDriveContext` provides courseware-related capabilities.

## upsertResources

```typescript
upsertResources(items: CourseWareItem[]): void;
```

> Since v1.1.5.

Update the courseware list.

| Parameter | Description |
| :------ | :--------- |
| `items` | Courseware object. |

## allResources

```typescript
allResources: MaterialDataResource[];
```

> Since v1.1.5.

All courseware.

## initCourseWareProgress

```typescript
initCourseWareProgress: number;
```

> Since v1.1.5.

Initial courseware loading progress.

## initCourseWareLoading

```typescript
initCourseWareLoading: boolean;
```

> Since v1.1.5.

Whether the initial courseware is being loaded.

## initCourseWare

```typescript
initCourseWare: MaterialDataResource
```

> Since v1.1.5.

Get to know the courseware for the first time.

## downloadList

```typescript
downloadList: StorageCourseWareItem[],
```

List of downloadable courseware.

## openCloudResource

```typescript
openCloudResource: (uuid: string) => Promise<void>,
```

Open the courseware.

| Parameter | Description |
| :----- | :-------- |
| `uuid` | The file ID. |

## startDownload

```typescript
startDownload: (taskUuid: string) => Promise<void>,
```

Start downloading the courseware.

| Parameter | Description |
| :--------- | :---------------- |
| `taskUuid` | Courseware conversion task ID. |

## deleteSingle

```typescript
deleteSingle: (taskUuid: string) => Promise<void>,
```

Delete the courseware.

| Parameter | Description |
| :--------- | :---------------- |
| `taskUuid` | Courseware conversion task ID. |

## personalResources

```typescript
personalResources: MaterialDataResource[],
```

Update the courseware list.

## publicResources

```typescript
publicResources: MaterialDataResource[],
```

Update the courseware list.

## resourcesList

```typescript
resourcesList: Resource[],
```

Update the courseware list.

## refreshCloudResources

```typescript
refreshCloudResources: () => Promise<void>,
```

Update the courseware list.

## removeMaterialList

```typescript
removeMaterialList: (resourceUuids: string[]) => Promise<void>,
```

Delete the courseware.

| Parameter | Description |
| :-------------- | :-------- |
| `resourceUuids` | The file ID. |

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