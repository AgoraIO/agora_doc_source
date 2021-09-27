`GlobalContext` provides` global` control related capabilities.

## region

```javascript
region: string;
```

> Since v1.1.5.

The currently set area.

## loading

```javascript
loading: boolean,
```

> Deprecated as of v2.3.2. Agora recommends using `isJoiningRoom` of `RoomContext `instead.

Loading.

## isFullScreen

```javascript
isFullScreen: boolean,
```

Whether the whiteboard is full screen.

## params

```javascript
params: AppStoreInitParams,
```

Class initialization parameters.

## mainPath

```javascript
mainPath: string | undefined,
```

Main route.

## language

```javascript
language: LanguageEnum,
```

Current language.

## isJoined

```javascript
isJoined: boolean;
```

> Since v1.1.5.

Whether the local client successfully joins the class.

## sequenceEventObserver

```javascript
sequenceEventObserver: Subject<any>,
```

> Since v1.1.5.

Flexible Classroom event sequence observer.

## toastEventObserver

```javascript
toastEventObserver: Subject<any>,
```

Toast observer.

## dialogEventObserver

```javascript
dialogEventObserver: Subject<any>,
```

Dialogue viewer.