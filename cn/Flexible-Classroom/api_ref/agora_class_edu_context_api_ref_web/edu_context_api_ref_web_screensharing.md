# useScreenShareContext

`useScreenShareContext()` 提供屏幕共享相关能力。

你可以通过 `import { useScreenShareContext } from 'agora-edu-core';  ` 引入 `useScreenShareContext`，然后使用 `const {...} = useScreenShareContext()` 获取灵动课堂中消息聊天相关能力。

以下具体列出 `useScreenShareContext()` 提供的能力。

## nativeAppWindowItems

```typescript
nativeAppWindowItems: array,
```

远端屏幕共享流列表。

## screenShareStream

```typescript
screenShareStream: object,
```

本地屏幕共享流信息。

## startOrStopSharing

```typescript
async startOrStopSharing(): void
```

开始或停止屏幕共享。
