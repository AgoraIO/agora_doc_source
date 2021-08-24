# ScreenShareContext

`ScreenShareContext` 提供屏幕共享相关能力。

## nativeAppWindowItems

```typescript
nativeAppWindowItems: any[],
```

远端屏幕共享流列表。

## screenShareStream

```typescript
screenShareStream: EduMediaStream,
```

本地屏幕共享媒体流。

## screenEduStream

```typescript
screenEduStream: EduStream,
```

本地屏幕共享数据流。

## startOrStopSharing

```typescript
startOrStopSharing: (type?:ScreenShareType) => Promise<void>
```

开始或停止屏幕共享。

| 参数   | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| `type` | 屏幕共享类型，包含 `Window` （共享一个窗口，默认）和 `Screen`（共享一个屏幕）。 |

## screenEduStream

```typescript
screenEduStream: EduStream,
```

本地屏幕共享数据流。

## isScreenSharing

```typescript
isScreenSharing: boolean,
```

> 自 v1.1.2 起新增。

当前是否正在共享屏幕。

## customScreenSharePickerType

```typescript
customScreenSharePickerType: ScreenShareType,
```

> 自 v1.1.2 起新增。

当前显示的屏幕共享选择器类型。

## startNativeScreenShareBy

```typescript
startNativeScreenShareBy: (windowId: number, type?: ScreenShareType) => Promise<void>,
```

> 自 v1.1.2 起新增。

使用指定的窗口或屏幕 ID 进行屏幕共享。

| 参数       | 描述                                                         |
| :--------- | :----------------------------------------------------------- |
| `windowId` | 窗口或屏幕 ID。                                              |
| `type`     | 屏幕共享类型，包含 `Window` （共享一个窗口，默认）和 `Screen`（共享一个屏幕）。 |

## canSharingScreen

```typescript
canSharingScreen: boolean;
```

> 自 v1.1.2 起新增。

当前是否允许屏幕共享。