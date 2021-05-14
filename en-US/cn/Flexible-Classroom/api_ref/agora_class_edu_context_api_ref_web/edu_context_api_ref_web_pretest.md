# usePretestContext

`usePretestContext()` enables developers to implement the pre-class test module in the flexible classroom, such as check whether the camera, microphone, and speaker are working properly.

You can import `usePretestContext` by `import { usePretestContext } from 'agora-edu-core'; ` and then use `const {...} = usePretestContext()` to implement the functions and events related to classroom management.

This page lists all the functions and events provided by `usePretestContext()`.

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
