# CloudDriveContext

`CloudDriveContext` 提供课件相关能力。

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

