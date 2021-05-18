# useRecordingContext

`useRecordingContext()` enables developers to implement the recording function in the flexible classroom.

You can` import useRecordingContext by import { useRecordingContext } from 'agora-edu-core';``` , and then use` const {...} = useRecordingContext()` to implement the functions and events related to recording.

This page lists all the functions and events provided by `useRecordingContext()`.

## isRecording

```typescript
isRecording: boolean,
```

Whether the class is being recorded.

## startRecording

```typescript
async startRecording(): void
```

Start recording.

## stopRecording

```typescript
async stopRecording(): void
```

Stop recording.
