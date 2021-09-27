# CloudDriveContext

`CloudDriveContext` 提供课件相关能力。

## upsertResources

```typescript
upsertResources(items: CourseWareItem[]): void;
```

> Since v1.1.5.

Update the courseware list.

| Parameter | Description |
| :------ | :--------- |
| `items` | 课件对象。 |

## allResources

```typescript
allResources: MaterialDataResource[];
```

> Since v1.1.5.

所有课件。

## initCourseWareProgress

```typescript
initCourseWareProgress: number;
```

> Since v1.1.5.

初始课件加载进度。

## initCourseWareLoading

```typescript
initCourseWareLoading: boolean;
```

> Since v1.1.5.

是否正在加载初始课件。

## initCourseWare

```typescript
initCourseWare: MaterialDataResource
```

> Since v1.1.5.

初识课件。

## downloadList

```typescript
downloadList: StorageCourseWareItem[],
```

可下载的课件列表。

## openCloudResource

```typescript
openCloudResource: (uuid: string) => Promise<void>,
```

打开课件。

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
| `taskUuid` | 课件转换任务 ID。 |

## deleteSingle

```typescript
deleteSingle: (taskUuid: string) => Promise<void>,
```

删除课件。

| Parameter | Description |
| :--------- | :---------------- |
| `taskUuid` | 课件转换任务 ID。 |

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

删除课件。

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