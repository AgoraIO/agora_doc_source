`GlobalContext` provides capabilities for global control.

## region

```javascript
region: string;
```

> Since v1.1.5.

The region set by the user.

## loading

```javascript
loading: boolean,
```

> Deprecated as of v1.1.5. Use `isJoiningRoom` in `RoomContext` instead.

The page is loading.

## isFullScreen

```javascript
isFullScreen: boolean,
```

Whether the current page is full screen.

## params

```javascript
params: AppStoreInitParams,
```

The initial parameters of the classroom.

## mainPath

```javascript
mainPath: string | undefined,
```

Main path.

## language

```javascript
language: LanguageEnum,
```

The current UI language.

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

The event sequence observer in Flexible Classroom.

## toastEventObserver

```javascript
toastEventObserver: Subject<any>,
```

Toast observer.

## dialogEventObserver

```javascript
dialogEventObserver: Subject<any>,
```

Dialogue observer.