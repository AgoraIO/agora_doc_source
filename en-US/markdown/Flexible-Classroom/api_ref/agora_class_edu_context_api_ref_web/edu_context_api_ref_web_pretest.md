This page lists all the functions and events provided by `PretestContext` for the device test module before a class begins, such as check whether the camera, microphone, and speaker are working properly.

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
changeTestSpeakerVolume: (value: any) => Promise<void>
```

Adjust the volume of the speaker.

## changeTestMicrophoneVolume

```typescript
async changeTestMicrophoneVolume(value: any): void
```

Adjust the volume of the microphone.

## changeTestCamera

```typescript
changeTestCamera: (deviceId: string) => Promise<void>,
```

Switch the camera.

## changeTestMicrophone

```typescript
changeTestMicrophone: (deviceId: string) => Promise<void>,
```

Switch the microphone.

## startPretestCamera

```typescript
startPretestCamera: () => Promise<void>,
```

Turn on the camera.

## startPretestMicrophone

```typescript
startPretestMicrophone: (payload: { enableRecording: boolean; }) => Promise<void>,
```

Turn on the microphone.

## stopPretestCamera

```typescript
stopPretestCamera: () => void,
```

Turn off the camera.

## stopPretestMicrophone

```typescript
stopPretestMicrophone: () => void,
```

Turn off the microphone.
