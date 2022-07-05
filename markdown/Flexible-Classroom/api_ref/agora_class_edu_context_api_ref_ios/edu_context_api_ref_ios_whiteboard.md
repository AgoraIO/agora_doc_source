## AgoraEduWhiteBoardContext

`AgoraEduWhiteBoardContext` 类提供可供 App 调用的白板控制相关方法。

### boardInputEnable

```swift
func boardInputEnable(_ enable: Bool)
```

设置是否可以使用白板基础工具。

| 参数     | 描述                   |
| :------- | :--------------------- |
| `enable` | 是否可以使用白板基础工具。 |

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

刷新白板大小。在白板容器大小发生变化时，需要调用该方法。

### getContentView

```swift
func getContentView() -> UIView?
```

获取白板容器 View。如果白板没有初始化成功，返回值为 `nil`。

### registerBoardEventHandler

```swift
func registerBoardEventHandler(_ handler: AgoraEduWhiteBoardHandler)
```

注册事件监听。

| 参数      | 描述                               |
| :-------- | :--------------------------------- |
| `handler` | 详见 `AgoraEduWhiteBoardHandler`。 |

## AgoraEduWhiteBoardHandler

### onBoardContentView

```swift 
@objc optional func onBoardContentView(_ view: UIView)
```

> 自 v1.1.5 起新增。

返回白板容器 View。

| 参数   | 描述            |
| :----- | :-------------- |
| `view` | 白板容器 View。 |

### onDrawingEnabled

```swift
@objc optional func onDrawingEnabled(_ enabled: Bool)
```

> 自 v1.1.5 起新增。

报告本地是否有权限操作白板。

- `enabled` 为 `true` 时，UI 层会提示：你可以使用白板了。
- `enabled` 为 `false` 时，UI 层会提示：你现在无权使用白板了。

| 参数      | 描述               |
| :-------- | :----------------- |
| `enabled` | 本地是否有权限操作白板。 |

### onLoadingVisible

```swift
@objc optional func onLoadingVisible(_ visible: Bool)
```

> 自 v1.1.5 起新增。

报告白板加载状态是否可见。

| 参数      | 描述                   |
| :-------- | :--------------------- |
| `visible` | 白板加载状态是否可见。 |

### onDownloadProgress

```swift
@objc optional func onDownloadProgress(_ url: String,
                                    progress: Float)
```

> 自 v1.1.5 起新增。

报告当前课件下载进度。

| 参数       | 描述                                |
| :--------- | :---------------------------------- |
| `url`      | 课件下载地址。                      |
| `progress` | 课件下载进度，取值范围为 0 到 100。 |

### onDownloadTimeOut

```swift
@objc optional func onDownloadTimeOut(_ url: String)
```

> 自 v1.1.5 起新增。

报告课件下载超时。当一次课件下载所花的时间超过了 15 秒，就会触发该回调。

| 参数  | 描述           |
| :---- | :------------- |
| `url` | 课件下载地址。 |


### onDownloadComplete

```swift
@objc optional func onDownloadComplete(_ url: String)
```

> 自 v1.1.5 起新增。

报告课件下载完成。

| 参数  | 描述           |
| :---- | :------------- |
| `url` | 课件下载地址。 |


### onDownloadError

```swift
@objc optional func onDownloadError(_ url: String)
```

报告课件下载失败。

| 参数  | 描述           |
| :---- | :------------- |
| `url` | 课件下载地址。 |

### onCancelCurDownload

```swift
@objc optional func onCancelCurDownload()
```

报告课件下载被取消。

## AgoraEduWhiteBoardToolContext

`AgoraEduWhiteBoardToolContext` 类提供可供 App 调用的白板基础工具相关方法。

### applianceSelected

```swift
func applianceSelected(_ mode: AgoraEduContextApplianceType)
```

选择一个白板基础工具。

| 参数   | 描述                                                |
| :----- | :-------------------------------------------------- |
| `type` | 白板基础工具类型，详见 `AgoraEduContextApplianceType`。 |

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
|  `thick`   |  画笔粗细。   |

## AgoraEduWhiteBoardPageControlContext

`AgoraEduWhiteBoardPageControlContext` 类提供可供 App 调用的白板页面控制工具相关方法。

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

### onPageIndex

```swift
@objc optional func onPageIndex(_ pageIndex: NSInteger,
                                  pageCount: NSInteger)
```

> 自 v1.1.5 起新增。

报告白板当前页数和总页数。

| 参数        | 描述       |
| :---------- | :--------- |
| `pageIndex` | 当前页数。 |
| `pageCount` | 总页数。   |


### onPagingEnable

```swift
@objc optional func onPagingEnable(_ enable: Bool)
```

> 自 v1.1.5 起新增。

报告本地是否有权限翻页。

| 参数     | 描述         |
| :------- | :----------- |
| `enable` | 是否可翻页。 |


### onZoomEnable

```swift
@objc optional func onZoomEnable(_ zoomOutEnable: Bool,
                                    zoomInEnable: Bool)
```

> 自 v1.1.5 起新增。

报告本地是否有权限放大或缩小白板。

| 参数            | 描述         |
| :-------------- | :----------- |
| `zoomOutEnable` | 是否可缩小。 |
| `zoomInEnable`  | 是否可放大。 |

### onResizeFullScreenEnable

```swift
@objc optional func onResizeFullScreenEnable(_ enable: Bool)
```

> 自 v1.1.5 起新增。

报告本地是否有权限全屏白板。

| 参数     | 描述             |
| :------- | :--------------- |
| `enable` | 是否可全屏白板。 |

### onFullScreen

```swift
@objc optional func onFullScreen(_ fullScreen: Bool)
```

> 自 v1.1.5 起新增。

报告当前白板是否全屏。

| 参数         | 描述               |
| :----------- | :----------------- |
| `fullScreen` | 当前白板是否全屏。 |
