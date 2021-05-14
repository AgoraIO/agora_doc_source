# useScreenShareContext

`useScreenShareContext()` enables developers to implement the screen sharing function in the flexible classroom.

你可以通过 `import { useScreenShareContext } from 'agora-edu-core';  ` 引入 `useScreenShareContext`，然后使用 `const {...} = useScreenShareContext()` 获取灵动课堂中屏幕共享相关能力。

This page lists all the functions and events provided by `useScreenShareContext()`.

## nativeAppWindowItems

```typescript
nativeAppWindowItems: array,
```

The list of remote screen sharing streams.

## screenShareStream

```typescript
screenShareStream: object,
```

The information of the local screen sharing screen.

## startOrStopSharing

```typescript
async startOrStopSharing(): void
```

Start or stop screen sharing.
