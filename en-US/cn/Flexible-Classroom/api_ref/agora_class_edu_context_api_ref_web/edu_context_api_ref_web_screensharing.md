# useScreenShareContext

`useScreenShareContext()` enables developers to implement the screen sharing function in the flexible classroom.

You can import `useScreenShareContext` by `import { useScreenShareContext } from 'agora-edu-core';` and then use `const {...} = useScreenShareContext()` to implement the functions and events related to screen sharing.

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
