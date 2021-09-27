`GlobalContext` 提供全局控制相关能力。

## region

```javascript
region: string;
```

> Since v1.1.5.

当前设置的区域。

## loading

```javascript
loading: boolean,
```

> Deprecated as of v2.3.2. Agora 建议改用 `RoomContext` 的 `isJoiningRoom`。

正在加载中。

## isFullScreen

```javascript
isFullScreen: boolean,
```

Whether the whiteboard is full screen.

## params

```javascript
params: AppStoreInitParams,
```

课堂初始化参数。

## mainPath

```javascript
mainPath: string | undefined,
```

主路由。

## language

```javascript
language: LanguageEnum,
```

当前语言。

## isJoined

```javascript
isJoined: boolean;
```

> Since v1.1.5.

是否成功加入课堂。

## sequenceEventObserver

```javascript
sequenceEventObserver: Subject<any>,
```

> Since v1.1.5.

灵动课堂事件序列观察器。

## toastEventObserver

```javascript
toastEventObserver: Subject<any>,
```

Toast 观察器。

## dialogEventObserver

```javascript
dialogEventObserver: Subject<any>,
```

Dialogue 观察器。