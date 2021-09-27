`usePretestContext`() enables developers to implement the pre-class test module in the flexible classroom, such as check whether the camera, microphone, and speaker are working properly.

## isBeauty

```typescript
isBeauty: boolean;
```

> - Since v1.1.5.
> - 仅适用于 Electron。

当前是否开启基础美颜。

## setBeauty

```typescript
setBeauty: (isBeauty: boolean) => void;
```

> - Since v1.1.5.
> - 仅适用于 Electron。

开启/关闭基础美颜功能。

| Parameter | Description |
| :--------- | :----------------- |
| `isBeauty` | Whether to enable the image enhancement function: |

## whitening

```typescript
whitening: number;
```

> - Since v1.1.5.
> - 仅适用于 Electron。

当前美白数值。

## buffing

```typescript
buffing: number;
```

> - Since v1.1.5.
> - 仅适用于 Electron。

当前磨皮数值。

## ruddy

```typescript
ruddy: number;
```

> - Since v1.1.5.
> - 仅适用于 Electron。

当前红润数值。

## setWhitening

```typescript
setWhitening: (whitening: number) => void;
```

> - Since v1.1.5.
> - 仅适用于 Electron。

设置美白数值。

| Parameter | Description |
| :---------- | :------------------------------------------- |
| `whitening` | 美白数值。 取值范围为 0 到 100，默认值为 70。 |

## setBuffing

```typescript
setBuffing: (buffing: number) => void;
```

> - Since v1.1.5.
> - 仅适用于 Electron。

设置磨皮数值。

| Parameter | Description |
| :-------- | :------------------------------------------- |
| `buffing` | 磨皮数值。 取值范围为 0 到 100，默认值为 50。 |

## setRuddy

```typescript
setRuddy: (ruddy: number) => void;
```

> - Since v1.1.5.
> - 仅适用于 Electron。

设置红润数值。

| Parameter | Description |
| :------ | :------------------------------------------- |
| `ruddy` | 红润数值。 取值范围为 0 到 100，默认值为 10。 |

## changeTestSpeaker

```typescript
changeTestSpeaker: (deviceId: string) => Promise<void>;
```

> Since v1.1.5.

切换扬声器。

| Parameter | Description |
| :--------- | :-------- |
| `deviceId` | 设备 ID。 |

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

Adjust the volume of the speaker.

## changeTestMicrophoneVolume

```typescript
async changeTestMicrophoneVolume(value: any): void
```

Adjust the volume of the microphone.

## changeTestCamera

```typescript
async changeTestCamera(deviceId: string): void
```

Switch the camera.

## changeTestMicrophone

```typescript
async changeTestMicrophone(deviceId: string): void
```

Switch the microphone.

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
