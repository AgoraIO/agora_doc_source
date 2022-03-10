`GlobalContext` 提供全局控制相关能力。

## region

```javascript
region: string;
```

> 自 v1.1.2 起新增。

当前设置的区域。

## loading

```javascript
loading: boolean,
```

> 自 v1.1.2 起废弃。Agora 建议改用 `RoomContext` 的 `isJoiningRoom`。

正在加载中。

## isFullScreen

```javascript
isFullScreen: boolean,
```

当前是否全屏。

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

> 自 v1.1.2 起新增。

是否成功加入课堂。

## sequenceEventObserver

```javascript
sequenceEventObserver: Subject<any>,
```

> 自 v1.1.2 起新增。

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
