# PretestContext

`PretestContext` 提供课前检测相关能力，用于检测摄像头、麦克风和扬声器是否正常工作。

## cameraList

```typescript
cameraList: any[],
```

摄像头列表。

## microphoneList

```typescript
microphoneList: any[],
```

麦克风列表。

## speakerList

```typescript
speakerList: any[],
```

扬声器列表。

## cameraError

```typescript
cameraError: boolean,
```

摄像头是否正常工作。


## microphoneError

```typescript
microphoneError: boolean,
```

麦克风是否正常工作。

## cameraId

```typescript
cameraId: string,
```

当前选中的摄像头 ID 。

## microphoneId

```typescript
microphoneId: string,
```

当前选中的麦克风 ID。

## speakerId

```typescript
speakerId: string,
```

当前选中的扬声器 ID。

## isMirror

```typescript
isMirror: boolean,
```

当前摄像头画面是否镜像。

## setMirror

```typescript
setMirror(mirror: boolean): void
```

设置摄像头是否镜像。

## microphoneLevel

```typescript
microphoneLevel: number,
```

> 自 v1.1.2 起废弃。Agora 建议使用 `VolumeContext` 中的 `microphoneLevel`。

当前麦克风音量。取值范围为 0 到 20。

## changeTestSpeakerVolume

```typescript
changeTestSpeakerVolume: (value: any) => Promise<void>
```

调整扬声器的音量。

## changeTestMicrophoneVolume

```typescript
changeTestMicrophoneVolume: (deviceId: string) => Promise<void>,
```

调整麦克风的音量。

## changeTestCamera

```typescript
changeTestCamera: (deviceId: string) => Promise<void>,
```

切换摄像头。

## changeTestMicrophone

```typescript
changeTestMicrophone: (deviceId: string) => Promise<void>,
```

切换麦克风。

## startPretestCamera

```typescript
startPretestCamera: () => Promise<void>,
```

开启摄像头。

## startPretestMicrophone

```typescript
startPretestMicrophone: (payload: { enableRecording: boolean; }) => Promise<void>,
```

开启麦克风。

## stopPretestCamera

```typescript
stopPretestCamera: () => void,
```

关闭摄像头。

## stopPretestMicrophone

```typescript
stopPretestMicrophone: () => void,
```

关闭麦克风。

## pretestCameraRenderer

```typescript
pretestCameraRenderer: LocalUserRenderer | undefined,
```

课前检测阶段的摄像头渲染器。

## pretestNoticeChannel

```typescript
pretestNoticeChannel: Subject<any>;
```

> 自 v1.1.2 起新增。

设备检测频道通知。