This page lists all the functions and events provided by `ScreenShareContext` for the screen sharing feature of Flexible Classroom.

## nativeAppWindowItems

```typescript
nativeAppWindowItems: any[],
```

The list of remote screen sharing streams.

## screenShareStream

```typescript
screenShareStream: EduMediaStream,
```

The information of the local screen sharing screen.

## startOrStopSharing

```typescript
startOrStopSharing: (type?:ScreenShareType) => Promise<void>
```

Start or stop screen sharing.
