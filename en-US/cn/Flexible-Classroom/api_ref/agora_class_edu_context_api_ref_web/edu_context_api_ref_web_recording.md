# useRecordingContext useRecordingContext

`useRecordingContext()` 提供录制相关能力。 `useRecordingContext()` 提供录制相关能力。

你可以通过 `import { useRecordingContext } from 'agora-edu-core';  ` 引入 `useRecordingContext`，然后使用 `const {...} = useRecordingContext()` 获取灵动课堂中录制相关能力。 你可以通过 `import { useRecordingContext } from 'agora-edu-core';  ` 引入 `useRecordingContext`，然后使用 `const {...} = useRecordingContext()` 获取灵动课堂中录制相关能力。

以下具体列出`useRecordingContext()` 提供的能力。 This page lists all the functions and events provided by `useRecordingContext()`.

## isRecording isRecording

```typescript
isRecording: boolean, isRecording: boolean,
```

当前是否正在录制 。 Whether the class is being recorded.

## startRecording startRecording

```typescript
async startRecording(): void async startRecording(): void
```

开始录制。 Start recording.

## stopRecording stopRecording

```typescript
async stopRecording(): void async stopRecording(): void
```

停止录制。 Stop recording.
