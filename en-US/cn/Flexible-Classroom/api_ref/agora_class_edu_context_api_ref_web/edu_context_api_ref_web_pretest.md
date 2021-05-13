# usePretestContext

`usePretestContext()` provides pre-class detection related capabilities to detect whether the camera, microphone, and speaker are working properly.

You can` import usePretestContext by import {usePretestContext} from'agora-edu-core';```, and then` use const {...} = usePretestContext()` to obtain classroom management related abilities in  Flexible Classroom.

The following specifically lists the` capabilities provided by usePretestContext()`.

## cameraList

```typescript
cameraList: array,
```

Camera list.

## microphoneList

```typescript
microphoneList: array,
```

Microphone list.

## speakerList

```typescript
speakerList: array,
```

Speaker list.

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

The currently selected camera ID.

## microphoneId

```typescript
microphoneId: string,
```

The ID of the currently selected microphone.

## speakerId

```typescript
speakerId: string,
```

The currently selected speaker ID.

## isMirror

```typescript
isMirror: boolean,
```

Whether the current camera screen is mirrored.

## setMirror

```typescript
setMirror(mirror: boolean): void
```

Set whether the camera is mirrored.

## microphoneLevel

```typescript
microphoneLevel: number,
```

The current microphone volume. The value range is 0-20.

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

Switch camera.

## changeTestMicrophone

```typescript
async changeTestMicrophone(deviceId: string): void
```

Switch microphone.

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
