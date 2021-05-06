# Whiteboard Context

## AgoraEduWhiteBoardContext

`AgoraEduWhiteBoardContext` 类提供可供 App 调用的白板控制相关方法。

### boardInputEnable

```swift
func boardInputEnable(_ enable: Bool)
```

设置是否可以使用白板工具。

| 参数     | 描述                   |
| :------- | :--------------------- |
| `enable` | 是否可以使用白板工具。 |

### skipDownload

```swift
func skipDownload(_ url: String)
```

跳过课件下载。

| 参数  | 描述           |
| :---- | :------------- |
| `url` | 课件下载地址。 |

### cancelDownload

```swift
func cancelDownload(_ url: String)
```

取消课件下载。

| 参数  | 描述           |
| :---- | :------------- |
| `url` | 课件下载地址。 |

### retryDownload

```swift
func retryDownload(_ url: String)
```

课件下载重试。

| 参数  | 描述           |
| :---- | :------------- |
| `url` | 课件下载地址。 |

### boardRefreshSize

```swift
func boardRefreshSize()
```

刷新白板大小。在白板容器大小发送变化的时候，需要调用该方法

### registerBoardEventHandler

```swift
// 事件监听
func registerBoardEventHandler(_ handler: AgoraEduWhiteBoardHandler)
```

注册事件监听。

| 参数      | 描述                               |
| :-------- | :--------------------------------- |
| `handler` | 详见 `AgoraEduWhiteBoardHandler`。 |

## AgoraEduWhiteBoardHandler

### onGetBoardContainer

```swift 
@objc optional func onGetBoardContainer() -> UIView
```

获取白板容器 View。

### onSetDrawingEnabled

```swift
@objc optional func onSetDrawingEnabled(_ enabled: Bool)
```

报告白板工具是否可用。

| 参数      | 描述               |
| :-------- | :----------------- |
| `enabled` | 白板工具是否可用。 |

### onSetLoadingVisible

```swift
@objc optional func onSetLoadingVisible(_ visible: Bool)
```

报告白板加载状态是否可见。

| 参数      | 描述                   |
| :-------- | :--------------------- |
| `visible` | 白板加载状态是否可见。 |

### onSetDownloadProgress

```swift
@objc optional func onSetDownloadProgress(_ url: String,
                                            progress: Float)
```

报告当前课件下载进度。

| 参数       | 描述                                |
| :--------- | :---------------------------------- |
| `url`      | 课件下载 URL 地址。                 |
| `progress` | 课件下载进度，取值范围为 0 到 100。 |

### onSetDownloadTimeOut

```swift
@objc optional func onSetDownloadTimeOut(_ url: String)
```

报告课件下载超时。当一次课件下载所花的时间超过了 15 秒，就会触发该回调。

| 参数  | 描述                |
| :---- | :------------------ |
| `url` | 课件下载 URL 地址。 |


### onSetDownloadComplete

```swift
@objc optional func onSetDownloadComplete(_ url: String)
```

报告课件下载完成。

| 参数  | 描述                |
| :---- | :------------------ |
| `url` | 课件下载 URL 地址。 |


### onDownloadError

```swift
@objc optional func onDownloadError(_ url: String)
```

报告课件下载失败。

| 参数  | 描述                |
| :---- | :------------------ |
| `url` | 课件下载 URL 地址。 |

### onCancelCurDownload

```swift
@objc optional func onCancelCurDownload()
```

报告当前课件下载任务被取消。

| 参数  | 描述                |
| :---- | :------------------ |
| `url` | 课件下载 URL 地址。 |

### onShowPermissionTips 

```swift
@objc optional func onShowPermissionTips(_ granted: Bool)
```

报告白板权限发生变化。

| 参数      | 描述               |
| :-------- | :----------------- |
| `granted` | 是否具有白板权限。 |

## AgoraEduWhiteBoardToolContext

`AgoraEduWhiteBoardToolContext` 类提供可供 App 调用的白板工具相关方法。

### applianceSelected

```swift
func applianceSelected(_ mode: AgoraEduContextApplianceType)
```

选中白板工具。

| 参数   | 描述                                                |
| :----- | :-------------------------------------------------- |
| `type` | 白板工具类型，详见 `AgoraEduContextApplianceType`。 |

### colorSelected

```swift
func colorSelected(_ color: UIColor)
```

选择颜色。

| 参数    | 描述   |
| :------ | :----- |
| `color` | 颜色。 |

### fontSizeSelected

```swift
func fontSizeSelected(_ size: Int)
```

选择字体大小。

| 参数 | 描述 |
| :--- | :--- |
| `size`   |   字体大小。   |

### thicknessSelected

```swift
func thicknessSelected(_ thick: Int)
```

选择画笔粗细。

| 参数 | 描述 |
| :--- | :--- |
|  `think`    |  画笔粗细。   |

## AgoraEduWhiteBoardPageControlContext

### zoomOut

```swift
func zoomOut()
```

缩小白板。每调用一次，缩小 10%。

### zoomIn

```swift
func zoomIn()
```

放大白板。每调用一次，放大 10%。

### prevPage

```swift
func prevPage()
```

翻至上一页。

### nextPage

```swift
func nextPage()
```

翻至下一页。

### registerPageControlEventHandler

```swift
func registerPageControlEventHandler(_ handler: AgoraEduWhiteBoardPageControlHandler)
```

注册事件监听。

## AgoraEduWhiteBoardPageControlHandler

### onSetPageIndex

```swift
@objc optional func onSetPageIndex(_ pageIndex: NSInteger,
                                     pageCount: NSInteger)
```

报告白板当前页数和总页数。

| 参数        | 描述       |
| :---------- | :--------- |
| `pageIndex` | 当前页数。 |
| `pageCount` | 总页数。   |


### onSetPagingEnable

```swift
@objc optional func onSetPagingEnable(_ enable: Bool)
```

报告是否可翻页。

| 参数     | 描述         |
| :------- | :----------- |
| `enable` | 是否可翻页。 |


### onSetZoomEnable

```swift
@objc optional func onSetZoomEnable(_ zoomOutEnable: Bool,
                                      zoomInEnable: Bool)
```

报告是否可放大、缩小。

| 参数            | 描述         |
| :-------------- | :----------- |
| `zoomOutEnable` | 是否可缩小。 |
| `zoomInEnable`  | 是否可放大。 |

### onSetResizeFullScreenEnable

```swift
@objc optional func onSetResizeFullScreenEnable(_ enable: Bool)
```

报告是否可全屏白板。

| 参数     | 描述             |
| :------- | :--------------- |
| `enable` | 是否可全屏白板。 |

### onSetFullScreen

```swift
@objc optional func onSetFullScreen(_ fullScreen: Bool)
```

报告当前白板是否全屏。

| 参数         | 描述               |
| :----------- | :----------------- |
| `fullScreen` | 当前白板是否全屏。 |
