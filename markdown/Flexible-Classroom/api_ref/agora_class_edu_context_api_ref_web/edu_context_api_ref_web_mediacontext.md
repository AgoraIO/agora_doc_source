# MediaContext

`MediaContext` 提供本地媒体设备控制相关能力。

## isNative

```typescript
isNative: boolean,
```

本地是否为 Windows 或 macOS 客户端应用。

## cpuUsage

```typescript
cpuUsage: number,
```

CPU 使用情况。

## networkQuality

```typescript
networkQuality: string,
```

网络质量。

## networkLatency

```typescript
networkLatency: number,
```

网络延时（毫秒）。

## packetLostRate

```typescript
packetLostRate: number,
```

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

切换摄像头。

| 参数       | 描述      |
| ---------- | --------- |
| `deviceId` | 设备 ID。 |

## changeMicrophone

```typescript
changeMicrophone: (deviceId: string) => Promise<void>
```

切换麦克风。

| 参数       | 描述      |
| ---------- | --------- |
| `deviceId` | 设备 ID。 |

## changeSpeakerVolume

```typescript
changeSpeakerVolume: (v: number) => Promise<void>
```

调整扬声器的音量。

## changeMicrophoneVolume

```typescript
changeMicrophoneVolume: (v: number) => Promise<void>
```

调整麦克风的音量。
