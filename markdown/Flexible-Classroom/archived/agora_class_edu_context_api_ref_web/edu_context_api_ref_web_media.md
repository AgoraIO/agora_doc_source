`MediaContext` 提供本地媒体设备控制相关能力。

## enableMediaEncryption

```typescript
enableMediaEncryption(enabled: boolean, config: any): number;
```

> 自 v1.1.5 起新增。

启用媒体流加密。

## getAudioRecordingVolume

```typescript
getAudioRecordingVolume: () => number;
```

> 自 v1.1.5 起新增。

获取麦克风采集的声音的音量。

## getAudioPlaybackVolume

```typescript
getAudioPlaybackVolume: () => number;ng) => Promise<void>;
```

> 自 v1.1.5 起新增。

获取扬声器播放的声音的音量。

## isNative

```typescript
isNative: boolean,
```

本地是否为 Windows 或 macOS 客户端应用。

## cpuUsage

```typescript
cpuUsage: number,
```

> 自 v1.1.5 起废弃。Agora 建议改用 `ClassroomStatsContext` 中的 `cpuUsage`。

CPU 使用情况。

## networkQuality

```typescript
networkQuality: string,
```

> 自 v1.1.5 起废弃。Agora 建议改用 `ClassroomStatsContext` 中的 `networkQuality`。

网络质量。

## networkLatency

```typescript
networkLatency: number,
```

> 自 v1.1.5 起废弃。Agora 建议改用 `ClassroomStatsContext` 中的 `networkLatency`。

网络延时（毫秒）。

## packetLostRate

```typescript
packetLostRate: number,
```

> 自 v1.1.5 起废弃。Agora 建议改用 `ClassroomStatsContext` 中的 `packetLostRate`。

网络丢包率（百分比）。

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

## changeDevice

```typescript
changeDevice: (deviceType: string, value: any) => Promise<void>,
```

切换媒体设备（摄像头、麦克风、扬声器）。

| 参数         | 描述                                                   |
| ------------ | ------------------------------------------------------ |
| `deviceType` | 设备类型，可设为 `camera`、`microphone` 或 `speaker`。 |
| `value`      | 设备 ID。                                              |

## changeAudioVolume

```typescript
changeAudioVolume: (deviceType: string, value: any) => Promise<void>,
```

调整设备音量。

| 参数         | 描述                                        |
| ------------ | ------------------------------------------- |
| `deviceType` | 设备类型，可设为`microphone` 或 `speaker`。 |
| `value`      | 音量大小。                                  |

## changeCamera

```typescript
changeCamera: (deviceId: string) => Promise<void>
```

> 自 v1.1.2 起新增。

切换摄像头。

| 参数       | 描述      |
| ---------- | --------- |
| `deviceId` | 设备 ID。 |

## changeMicrophone

```typescript
changeMicrophone: (deviceId: string) => Promise<void>
```

> 自 v1.1.2 起新增。

切换麦克风。

| 参数       | 描述      |
| ---------- | --------- |
| `deviceId` | 设备 ID。 |

## changeSpeakerVolume

```typescript
changeSpeakerVolume: (v: number) => Promise<void>
```

> 自 v1.1.2 起新增。

调整扬声器的音量。

## changeMicrophoneVolume

```typescript
changeMicrophoneVolume: (v: number) => Promise<void>
```

> 自 v1.1.2 起新增。

调整麦克风的音量。
