# PretestContext

`PretestContext` 提供课前检测相关能力，用于检测摄像头、麦克风和扬声器是否正常工作。

## isBeauty

```typescript
isBeauty: boolean;
```

> 自 v1.1.5 起新增。

当前是否开启基础美颜。

## setBeauty

```typescript
setBeauty: (isBeauty: boolean) => void;
```

> 自 v1.1.5 起新增。

开启/关闭基础美颜功能。

| 参数       | 描述               |
| :--------- | :----------------- |
| `isBeauty` | 是否开启美颜功能。 |

## whitening

```typescript
whitening: number;
```

> 自 v1.1.5 起新增。

当前美白数值。

## buffing

```typescript
buffing: number;
```

> 自 v1.1.5 起新增。

当前磨皮数值。

## ruddy

```typescript
ruddy: number;
```

> 自 v1.1.5 起新增。

当前红润数值。

## setWhitening

```typescript
setWhitening: (whitening: number) => void;
```

> 自 v1.1.5 起新增。

设置美白数值。

| 参数        | 描述                                         |
| :---------- | :------------------------------------------- |
| `whitening` | 美白数值。取值范围为 0 到 100，默认值为 70。 |

## setBuffing

```typescript
setBuffing: (buffing: number) => void;
```

> 自 v1.1.5 起新增。

设置磨皮数值。

| 参数      | 描述                                         |
| :-------- | :------------------------------------------- |
| `buffing` | 磨皮数值。取值范围为 0 到 100，默认值为 50。 |

## setRuddy

```typescript
setRuddy: (ruddy: number) => void;
```

> 自 v1.1.5 起新增。

设置红润数值。

| 参数    | 描述                                         |
| :------ | :------------------------------------------- |
| `ruddy` | 红润数值。取值范围为 0 到 100，默认值为 10。 |

## setBeautyEffectOptions

```typescript
setBeautyEffectOptions: any;
```

> 自 v1.1.5 起新增。

## changeTestSpeaker

```typescript
changeTestSpeaker: (deviceId: string) => Promise<void>;
```

> 自 v1.1.5 起新增。

切换扬声器。

| 参数       | 描述      |
| :--------- | :-------- |
| `deviceId` | 设备 ID。 |

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