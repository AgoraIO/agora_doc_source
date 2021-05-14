# useRecordingContext useRecordingContext

`useRecordingContext()` enables developers to implement the recording function in the flexible classroom. `useRecordingContext()` enables developers to implement the recording function in the flexible classroom.

You can` import useRecordingContext by import { useRecordingContext } from 'agora-edu-core';``` , and then use` const {...} = useRecordingContext()` to implement the functions and events related to recording. You can` import useRecordingContext by import { useRecordingContext } from 'agora-edu-core';``` , and then use` const {...} = useRecordingContext()` to implement the functions and events related to recording.

This page lists all the functions and events provided by `useRecordingContext()`. This page lists all the functions and events provided by `useRecordingContext()`.

## isRecording isRecording

```typescript
isRecording: boolean, isRecording: boolean,
```

Whether the class is being recorded. Whether the class is being recorded.

## startRecording startRecording

```typescript
async startRecording(): void async startRecording(): void
```

Start recording. Start recording.

## stopRecording stopRecording

```typescript
async stopRecording(): void async stopRecording(): void
```

Stop recording. Stop recording.
