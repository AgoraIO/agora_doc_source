# MediaContext

`MediaContext` 提供本地媒体设备控制相关能力。

## enableMediaEncryption

```typescript
enableMediaEncryption(enabled: boolean, config: any): number;
```

> Since v1.1.5.

启用媒体流加密。

## getAudioRecordingVolume

```typescript
getAudioRecordingVolume: () => number;
```

> Since v1.1.5.

获取麦克风采集的声音的音量。

## getAudioPlaybackVolume

```typescript
getAudioPlaybackVolume: () => number;ng) => Promise<void>;
```

> Since v1.1.5.

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

> Since v1.1.5. Agora 建议改用 `ClassroomStatsContext` 中的 `cpuUsage`。

CPU 使用情况。

## networkQuality

```typescript
networkQuality: string,
```

> Since v1.1.5. Agora 建议改用 `ClassroomStatsContext` 中的 `networkQuality`。

Network quality types.

## networkLatency

```typescript
networkLatency: number,
```

> Since v1.1.5. Agora 建议改用 `ClassroomStatsContext` 中的 `networkLatency`。

网络延时（毫秒）。

## packetLostRate

```typescript
packetLostRate: number,
```

> Since v1.1.5. Agora 建议改用 `ClassroomStatsContext` 中的 `packetLostRate`。

网络丢包率（百分比）。

## cameraList

```typescript
cameraList: any[],
```

The camera list.

## microphoneList

```typescript
microphoneList: any[],
```

The microphone list.

## speakerList

```typescript
speakerList: any[],
```

The speaker list.

## cameraId

```typescript
cameraId: string,
```

The ID of the selected ID.

## microphoneId

```typescript
microphoneId: string,
```

The ID of the selected microphone.

## speakerId

```typescript
speakerId: string,
```

The ID of the selected speaker.

## changeDevice

```typescript
changeDevice: (deviceType: string, value: any) => Promise<void>,
```

切换媒体设备（摄像头、麦克风、扬声器）。

| Parameter | Description |
| ------------ | ------------------------------------------------------ |
| `deviceType` | 设备类型，可设为 `camera`、`microphone` 或 `speaker`。 |
| `value` | 设备 ID。 |

## changeAudioVolume

```typescript
changeAudioVolume: (deviceType: string, value: any) => Promise<void>,
```

调整设备音量。

| Parameter | Description |
| ------------ | ------------------------------------------- |
| `deviceType` | 设备类型，可设为`microphone` 或 `speaker`。 |
| `value` | 音量大小。 |

## changeCamera

```typescript
changeCamera: (deviceId: string) => Promise<void>
```

> Since v1.1.5.

Switch the camera.

| Parameter | Description |
| ---------- | --------- |
| `deviceId` | 设备 ID。 |

## changeMicrophone

```typescript
changeMicrophone: (deviceId: string) => Promise<void>
```

> Since v1.1.5.

Switch the microphone.

| Parameter | Description |
| ---------- | --------- |
| `deviceId` | 设备 ID。 |

## changeSpeakerVolume

```typescript
changeSpeakerVolume: (v: number) => Promise<void>
```

> Since v1.1.5.

Adjust the volume of the speaker.

## changeMicrophoneVolume

```typescript
changeMicrophoneVolume: (v: number) => Promise<void>
```

> Since v1.1.5.

Adjust the volume of the microphone.