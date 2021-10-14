`MediaContext` provides capabilities for device control.

## enableMediaEncryption

```typescript
enableMediaEncryption(enabled: boolean, config: any): number;
```

> Since v1.1.5.

Enables media stream encryption.

## getAudioRecordingVolume

```typescript
getAudioRecordingVolume: () => number;
```

> Since v1.1.5.

Gets the volume of the audio collected by the microphone.

## getAudioPlaybackVolume

```typescript
getAudioPlaybackVolume: () => number;ng) => Promise<void>;
```

> Since v1.1.5.

Gets the volume of the audio played by the speaker.

## isNative

```typescript
isNative: boolean,
```

Whether the local client is a Windows or macOS application.

## cpuUsage

```typescript
cpuUsage: number,
```

> Deprecated as of v1.1.5. Use `cpuUsage` in `ClassroomStatsContext` instead.

The CPU usage.

## networkQuality

```typescript
networkQuality: string,
```

> Deprecated as of v1.1.5. Use `networkQuality` in `ClassroomStatsContext` instead.

Network quality types.

## networkLatency

```typescript
networkLatency: number,
```

> Deprecated as of v1.1.5. Use `networkLatency` in `ClassroomStatsContext` instead.

Network delay (ms).

## packetLostRate

```typescript
packetLostRate: number,
```

> Deprecated as of v1.1.5. Use `packetLostRate` in `ClassroomStatsContext` instead.

Packet loss rate (%).

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

Switches the media device (camera, microphone, or speaker).

| Parameter | Description |
| ------------ | ------------------------------------------------------ |
| `deviceType` | The device type. You can set the parameter as `camera`, `microphone` or `speaker`. |
| `value` | The device ID. |

## changeAudioVolume

```typescript
changeAudioVolume: (deviceType: string, value: any) => Promise<void>,
```

Adjusts the device volume.

| Parameter | Description |
| ------------ | ------------------------------------------- |
| `deviceType` | The device type. You can set the parameter as `microphone` or `speaker`. |
| `value` | The volume. |

## changeCamera

```typescript
changeCamera: (deviceId: string) => Promise<void>
```

> Since v1.1.5.

Switches the camera.

| Parameter | Description |
| ---------- | --------- |
| `deviceId` | The device ID. |

## changeMicrophone

```typescript
changeMicrophone: (deviceId: string) => Promise<void>
```

> Since v1.1.5.

Switches the microphone.

| Parameter | Description |
| ---------- | --------- |
| `deviceId` | The device ID. |

## changeSpeakerVolume

```typescript
changeSpeakerVolume: (v: number) => Promise<void>
```

> Since v1.1.5.

Adjusts the volume of the speaker.

## changeMicrophoneVolume

```typescript
changeMicrophoneVolume: (v: number) => Promise<void>
```

> Since v1.1.5.

Adjusts the volume of the microphone.