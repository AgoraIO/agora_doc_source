# usePretestContext

`usePretestContext()` 提供课前检测相关能力，用于检测摄像头、麦克风和扬声器是否正常工作。

你可以通过 `import { usePretestContext } from 'agora-edu-core';  ` 引入 `usePretestContext`，然后使用 `const {...} = usePretestContext()` 获取灵动课堂中课堂管理相关能力。

以下具体列出 `usePretestContext()` 提供的能力。

## cameraList

```typescript
cameraList: array,
```

摄像头列表。

## microphoneList

```typescript
microphoneList: array,
```

麦克风列表。

## speakerList

```typescript
speakerList: array,
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

当前麦克风音量。取值范围为 0 到 20。

## changeTestSpeakerVolume

```typescript
async changeTestSpeakerVolume(value: any): void
```

调整扬声器的音量。

## changeTestMicrophoneVolume

```typescript
async changeTestMicrophoneVolume(value: any): void
```

调整麦克风的音量。

## changeTestCamera

```typescript
async changeTestCamera(deviceId: string): void
```

切换摄像头。

## changeTestMicrophone

```typescript
async changeTestMicrophone(deviceId: string): void
```

切换麦克风。

## startPretestCamera

```typescript
async startPretestCamera(): void
```

开启摄像头。

## startPretestMicrophone

```typescript
async startPretestMicrophone(): void
```

开启麦克风。

## stopPretestCamera

```typescript
async stopPretestCamera(): void
```

关闭摄像头。

## stopPretestMicrophone

```typescript
async stopPretestMicrophone():void
```

关闭麦克风。
