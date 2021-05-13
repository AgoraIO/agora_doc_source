# useScreenShareContext

`useScreenShareContext()` provides screen sharing related capabilities.

You can` import useScreenShareContext by import {useScreenShareContext} from'agora-edu-core';```, and then use` const {...} = useScreenShareContext()` to get the message chat-related capabilities in the  Flexible Classroom.

The following specifically lists the` capabilities provided by useScreenShareContext()`.

## nativeAppWindowItems

```typescript
nativeAppWindowItems: array,
```

Remote screen sharing stream list.

## screenShareStream

```typescript
screenShareStream: object,
```

Stream information for local screen sharing.

## startOrStopSharing

```typescript
async startOrStopSharing(): void
```

Start or stop screen sharing.
