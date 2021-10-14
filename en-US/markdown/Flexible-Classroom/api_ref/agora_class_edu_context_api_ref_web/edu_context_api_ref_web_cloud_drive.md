`CloudDriveContext` provides capabilities for class files.

## upsertResources

```typescript
upsertResources(items: CourseWareItem[]): void;
```

> Since v1.1.5.

Updates a file.

| Parameter | Description |
| :------ | :--------- |
| `items` | The file object. |

## allResources

```typescript
allResources: MaterialDataResource[];
```

> Since v1.1.5.

All class files.

## initCourseWareProgress

```typescript
initCourseWareProgress: number;
```

> Since v1.1.5.

The loading progress of the initial class file.

## initCourseWareLoading

```typescript
initCourseWareLoading: boolean;
```

> Since v1.1.5.

Whether the initial class file is being loaded.

## initCourseWare

```typescript
initCourseWare: MaterialDataResource
```

> Since v1.1.5.

The initial class files.

## downloadList

```typescript
downloadList: StorageCourseWareItem[],
```

List of downloadable files.

## openCloudResource

```typescript
openCloudResource: (uuid: string) => Promise<void>,
```

Opens a file.

| Parameter | Description |
| :----- | :-------- |
| `uuid` | The file ID. |

## startDownload

```typescript
startDownload: (taskUuid: string) => Promise<void>,
```

Starts downloading a file.

| Parameter | Description |
| :--------- | :---------------- |
| `taskUuid` | File conversion task ID. |

## deleteSingle

```typescript
deleteSingle: (taskUuid: string) => Promise<void>,
```

Deletes a file.

| Parameter | Description |
| :--------- | :---------------- |
| `taskUuid` | File conversion task ID. |

## personalResources

```typescript
personalResources: MaterialDataResource[],
```

Updates the personal file list.

## publicResources

```typescript
publicResources: MaterialDataResource[],
```

Updates the public file list.

## resourcesList

```typescript
resourcesList: Resource[],
```

The list of all files.

## refreshCloudResources

```typescript
refreshCloudResources: () => Promise<void>,
```

Refreshes the file list.

## removeMaterialList

```typescript
removeMaterialList: (resourceUuids: string[]) => Promise<void>,
```

Deletes a file.

| Parameter | Description |
| :-------------- | :-------- |
| `resourceUuids` | The file ID. |

## cancelUpload

```typescript
cancelUpload: () => Promise<void>,
```

Cancels uploading a file to the classroom.

## doUpload

```typescript
doUpload: (payload: any) => Promise<void>,
```

Uploads a file to the classroom.

## closeMaterial

```typescript
closeMaterial: (resourceUuid: string) => void,
```

Closes the file.