# useRecordingContext

`useRecordingContext()` provides screen sharing related capabilities.

You can` import useRecordingContext by import {useRecordingContext} from'agora-edu-core';```, and then use` const {...} = useRecordingContext()` to get the ability of messaging and chat in the  Flexible Classroom.

The following specifically lists the capabilities provided by `useRecordingContext()`.

## isRecording

```typescript
isRecording: boolean,
```

Whether it is currently recording.

## startRecording

```typescript
async startRecording(): void
```

Start recording

## stopRecording

```typescript
async stopRecording(): void
```

Stop recording
