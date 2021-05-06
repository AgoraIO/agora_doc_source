# useRecordingContext

`useRecordingContext()` 提供屏幕共享相关能力。

你可以通过 `import { useRecordingContext } from 'agora-edu-core';  ` 引入 `useRecordingContext`，然后使用 `const {...} = useRecordingContext()` 获取灵动课堂中消息聊天相关能力。

以下具体列出`useRecordingContext()` 提供的能力。

## isRecording

```typescript
isRecording: boolean,
```

当前是否正在录制 。

## startRecording

```typescript
async startRecording(): void
```

开始录制。

## stopRecording

```typescript
async stopRecording(): void
```

停止录制。
