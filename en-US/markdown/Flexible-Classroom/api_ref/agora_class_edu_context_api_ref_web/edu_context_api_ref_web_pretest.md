`PretestContext` enables developers to implement the pre-class test module in the flexible classroom, such as check whether the camera, microphone and speaker are working properly.

## isBeauty

```typescript
isBeauty: boolean;
```

> - Since v1.1.5.
> - Only applicable to Electron.

Whether the basic image enhancement is enabled.

## setBeauty

```typescript
setBeauty: (isBeauty: boolean) => void;
```

> - Since v1.1.5.
> - Only applicable to Electron.

Enables/Disables the basic image enhancement.

| Parameter | Description |
| :--------- | :----------------- |
| `isBeauty` | Whether to enable the image enhancement: |

## whitening

```typescript
whitening: number;
```

> - Since v1.1.5.
> - Only applicable to Electron.

The brightness value.

## buffing

```typescript
buffing: number;
```

> - Since v1.1.5.
> - Only applicable to Electron.

The smoothness value.

## ruddy

```typescript
ruddy: number;
```

> - Since v1.1.5.
> - Only applicable to Electron.

The red saturation value.

## setWhitening

```typescript
setWhitening: (whitening: number) => void;
```

> - Since v1.1.5.
> - Only applicable to Electron.

Sets the brightness value.

| Parameter | Description |
| :---------- | :------------------------------------------- |
| `whitening` | The brightness value The value range is 0 to 100, and the default value is 70. |

## setBuffing

```typescript
setBuffing: (buffing: number) => void;
```

> - Since v1.1.5.
> - Only applicable to Electron.

Sets the smoothness value.

| Parameter | Description |
| :-------- | :------------------------------------------- |
| `buffing` | The smoothness value. The value range is 0 to 100, and the default value is 50. |

## setRuddy

```typescript
setRuddy: (ruddy: number) => void;
```

> - Since v1.1.5.
> - Only applicable to Electron.

Sets the red saturation value.

| Parameter | Description |
| :------ | :------------------------------------------- |
| `ruddy` | The red saturation value. The value range is 0 to 100, and the default value is 10. |

## changeTestSpeaker

```typescript
changeTestSpeaker: (deviceId: string) => Promise<void>;
```

> Since v1.1.5.

Switches the speaker.

| Parameter | Description |
| :--------- | :-------- |
| `deviceId` | The device ID. |

## cameraList

```typescript
cameraList: array,
```

The camera list.

## microphoneList

```typescript
microphoneList: array,
```

The microphone list.

## speakerList

```typescript
speakerList: array,
```

The speaker list.

## cameraError

```typescript
cameraError: boolean,
```

Whether the camera is working properly.


## microphoneError

```typescript
microphoneError: boolean,
```

Whether the microphone is working properly.

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

## isMirror

```typescript
isMirror: boolean,
```

Whether the current camera view is mirrored.

## setMirror

```typescript
setMirror(mirror: boolean): void
```

Whether to mirror the camera view.

## microphoneLevel

```typescript
microphoneLevel: number,
```

The current volume of the microphone. The value range is 0 to 20.

## changeTestSpeakerVolume

```typescript
async changeTestSpeakerVolume(value: any): void
```

Adjusts the volume of the speaker.

## changeTestMicrophoneVolume

```typescript
async changeTestMicrophoneVolume(value: any): void
```

Adjusts the volume of the microphone.

## changeTestCamera

```typescript
async changeTestCamera(deviceId: string): void
```

Switches the camera.

## changeTestMicrophone

```typescript
async changeTestMicrophone(deviceId: string): void
```

Switches the microphone.

## startPretestCamera

```typescript
async startPretestCamera(): void
```

Turn on the camera.

## startPretestMicrophone

```typescript
async startPretestMicrophone(): void
```

Turn on the microphone.

## stopPretestCamera

```typescript
async stopPretestCamera(): void
```

Turn off the camera.

## stopPretestMicrophone

```typescript
async stopPretestMicrophone():void
```

Turn off the microphone.
