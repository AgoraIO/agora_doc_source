`MediaContext` provides capabilities for device control. `MediaContext` provides capabilities for device control.

## enableMediaEncryption enableMediaEncryption

```typescript
enableMediaEncryption(enabled: boolean, config: any): number;
```

> Since v1.1.5. Since v1.1.5.

Enables media stream encryption. Enables media stream encryption.

## getAudioRecordingVolume getAudioRecordingVolume

```typescript
getAudioRecordingVolume: () => number;
```

> Since v1.1.5. Since v1.1.5.

Gets the volume of the audio collected by the microphone. Gets the volume of the audio collected by the microphone.

## getAudioPlaybackVolume getAudioPlaybackVolume

```typescript
getAudioPlaybackVolume: () => number;ng) => Promise<void>;
```

> Since v1.1.5. Since v1.1.5.

Get the volume of the audio played by the speaker. Get the volume of the audio played by the speaker.

## isNative isNative

```typescript
isNative: boolean,
```

Whether the local client is a Windows or macOS application. Whether the local client is a Windows or macOS application.

## cpuUsage cpuUsage

```typescript
cpuUsage: number,
```

> Deprecated as of v1.1.5. Deprecated as of v1.1.5. Use `cpuUsage` in `ClassroomStatsContext` instead. Use `cpuUsage` in `ClassroomStatsContext` instead.

The CPU usage. The CPU usage.

## networkQuality networkQuality

```typescript
networkQuality: string,
```

> Deprecated as of v1.1.5. Deprecated as of v1.1.5. Use `networkQuality` in `ClassroomStatsContext` instead. Use `networkQuality` in `ClassroomStatsContext` instead.

Network quality types. Network quality types.

## networkLatency networkLatency

```typescript
networkLatency: number,
```

> Deprecated as of v1.1.5. Deprecated as of v1.1.5. Use `networkLatency` in `ClassroomStatsContext` instead. Use `networkLatency` in `ClassroomStatsContext` instead.

Network delay (ms). Network delay (ms).

## packetLostRate packetLostRate

```typescript
packetLostRate: number,
```

> Deprecated as of v1.1.5. Deprecated as of v1.1.5. Use `packetLostRate` in `ClassroomStatsContext` instead. Use `packetLostRate` in `ClassroomStatsContext` instead.

Packet loss rate (%). Packet loss rate (%).

## cameraList cameraList

```typescript
cameraList: any[],
```

The camera list. The camera list.

## microphoneList microphoneList

```typescript
microphoneList: any[],
```

The microphone list. The microphone list.

## speakerList speakerList

```typescript
speakerList: any[],
```

The speaker list. The speaker list.

## cameraId cameraId

```typescript
cameraId: string,
```

The ID of the selected ID. The ID of the selected ID.

## microphoneId microphoneId

```typescript
microphoneId: string,
```

The ID of the selected microphone. The ID of the selected microphone.

## speakerId speakerId

```typescript
speakerId: string,
```

The ID of the selected speaker. The ID of the selected speaker.

## changeDevice changeDevice

```typescript
changeDevice: (deviceType: string, value: any) => Promise<void>,
```

Switches the media device (camera, microphone, or speaker). Switches the media device (camera, microphone, or speaker).

| Parameter Parameter | Description Description |
| ------------ | ------------------------------------------------------ |
| `deviceType ``deviceType` | The device type. You can set the parameter as `camera`, `microphone` or `speaker`. The device type. You can set the parameter as `camera`, `microphone` or `speaker`. |
| `value ``value` | The device ID. The device ID. |

## changeAudioVolume changeAudioVolume

```typescript
changeAudioVolume: (deviceType: string, value: any) => Promise<void>,
```

Adjusts the device volume. Adjusts the device volume.

| Parameter Parameter | Description Description |
| ------------ | ------------------------------------------- |
| `deviceType ``deviceType` | The device type. You can set the parameter as `microphone` or `speaker`. The device type. You can set the parameter as `microphone` or `speaker`. |
| `value ``value` | The volume. The volume. |

## changeCamera changeCamera

```typescript
changeCamera: (deviceId: string) => Promise<void>
```

> Since v1.1.5. Since v1.1.5.

Switches the camera. Switches the camera.

| Parameter Parameter | Description Description |
| ---------- | --------- |
| `deviceId ``deviceId` | The device ID. The device ID. |

## changeMicrophone changeMicrophone

```typescript
changeMicrophone: (deviceId: string) => Promise<void>
```

> Since v1.1.5. Since v1.1.5.

Switches the microphone. Switches the microphone.

| Parameter Parameter | Description Description |
| ---------- | --------- |
| `deviceId ``deviceId` | The device ID. The device ID. |

## changeSpeakerVolume changeSpeakerVolume

```typescript
changeSpeakerVolume: (v: number) => Promise<void>
```

> Since v1.1.5. Since v1.1.5.

Adjusts the volume of the speaker. Adjusts the volume of the speaker.

## changeMicrophoneVolume changeMicrophoneVolume

```typescript
changeMicrophoneVolume: (v: number) => Promise<void>
```

> Since v1.1.5. Since v1.1.5.

Adjusts the volume of the microphone. Adjusts the volume of the microphone.