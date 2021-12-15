`CloudDriveContext` 提供课件相关能力。

## upsertResources

```typescript
upsertResources(items: CourseWareItem[]): void;
```

> 自 v1.1.5 起新增。

更新课件。

| 参数    | 描述       |
| :------ | :--------- |
| `items` | 课件对象。 |

## allResources

```typescript
allResources: MaterialDataResource[];
```

> 自 v1.1.5 起新增。

所有课件。

## initCourseWareProgress

```typescript
initCourseWareProgress: number;
```

> 自 v1.1.5 起新增。

初始课件加载进度。

## initCourseWareLoading

```typescript
initCourseWareLoading: boolean;
```

> 自 v1.1.5 起新增。

是否正在加载初始课件。

## initCourseWare

```typescript
initCourseWare: MaterialDataResource;
```

> 自 v1.1.5 起新增。

初始课件。

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

| 参数   | 描述      |
| :----- | :-------- |
| `uuid` | 课件 ID。 |

## startDownload

```typescript
startDownload: (taskUuid: string) => Promise<void>,
```

开始下载课件。

| 参数       | 描述              |
| :--------- | :---------------- |
| `taskUuid` | 课件转换任务 ID。 |

## deleteSingle

```typescript
deleteSingle: (taskUuid: string) => Promise<void>,
```

删除课件。

| 参数       | 描述              |
| :--------- | :---------------- |
| `taskUuid` | 课件转换任务 ID。 |

## personalResources

```typescript
personalResources: MaterialDataResource[],
```

个人课件列表。

## publicResources

```typescript
publicResources: MaterialDataResource[],
```

公共课件列表。

## resourcesList

```typescript
resourcesList: Resource[],
```

所有课件列表。

## refreshCloudResources

```typescript
refreshCloudResources: () => Promise<void>,
```

刷新课件列表。

## removeMaterialList

```typescript
removeMaterialList: (resourceUuids: string[]) => Promise<void>,
```

删除课件。

| 参数            | 描述      |
| :-------------- | :-------- |
| `resourceUuids` | 课件 ID。 |

## cancelUpload

```typescript
cancelUpload: () => Promise<void>,
```

取消上传课件。

## doUpload

```typescript
doUpload: (payload: any) => Promise<void>,
```

上传课件。

## closeMaterial

```typescript
closeMaterial: (resourceUuid: string) => void,
```

关闭课件。
