## AgoraEduWhiteBoardContext

`AgoraEduWhiteBoardContext` provides whiteboard-related methods that can be called by your app.

### boardInputEnable

```swift
func boardInputEnable(_ enable: Bool)
```

Enable or disable the whiteboard basic editing tools.

| Parameter | Description |
| :------- | :--------------------- |
| `enable` | Whether to enable the whiteboard basic editing tools. |

### skipDownload

```swift
func skipDownload(_ url: String)
```

Skip the courseware download.

| Parameter | Description |
| :---- | :------------- |
| `url` | The download link of the file. |

### cancelDownload

```swift
func cancelDownload(_ url: String)
```

Cancel the courseware download.

| Parameter | Description |
| :---- | :------------- |
| `url` | The download link of the file. |

### retryDownload

```swift
func retryDownload(_ url: String)
```

Retry the courseware download.

| Parameter | Description |
| :---- | :------------- |
| `url` | The download link of the file. |

### boardRefreshSize

```swift
func boardRefreshSize()
```

Refresh the whiteboard size. You need to call this method when the size of the whiteboard container changes.

### getContentView

```swift
func getContentView() -> UIView?
```

Gets the whiteboard container view. 如果白板没有初始化成功，返回值为 `nil`。

### registerBoardEventHandler

```swift
func registerBoardEventHandler(_ handler: AgoraEduWhiteBoardHandler)
```

Register the event listener.

| Parameter | Description |
| :-------- | :--------------------------------- |
| `handler` | See AgoraEduWhiteBoardHandler for details``. |

## AgoraEduWhiteBoardHandler

### onBoardContentView

```swift
@objc optional func onBoardContentView(_ view: UIView)
```

> 自 v1.1.5 起新增。

Gets the whiteboard container view.

| Parameter | Description |
| :----- | :-------------- |
| `view` | Gets the whiteboard container view. |

### onDrawingEnabled

```swift
@objc optional func onDrawingEnabled(_ enabled: Bool)
```

> 自 v1.1.5 起新增。

报告本地是否有权限操作白板。

- `enabled` 为 `true` 时，UI 层会提示：
   - 中文：你可以使用白板了
   - 英文：You can now use the whiteboard tools.
- `enabled` 为 `false` 时，UI 层会提示：
   - 中文：你现在无权使用白板了
   - 英文：Your cannot use the whiteboard tools.

| Parameter | Description |
| :-------- | :----------------- |
| `enabled` | 本地是否有权限操作白板。 |

### onLoadingVisible

```swift
@objc optional func onLoadingVisible(_ visible: Bool)
```

> 自 v1.1.5 起新增。

Indicates whether the whiteboard loading status is visible.

| Parameter | Description |
| :-------- | :--------------------- |
| `visible` | Whether the whiteboard loading status is visible. |

### onDownloadProgress

```swift
@objc optional func onDownloadProgress(_ url: String,
                                    progress: Float)
```

> 自 v1.1.5 起新增。

Indicates the progress of the current courseware download.

| Parameter | Description |
| :--------- | :---------------------------------- |
| `url` | The download link of the file. |
| `progress` | The courseware download progress. The value range is 0 to 100. |

### onDownloadTimeout

```swift
@objc optional func onDownloadTimeOut(_ url: String)
```

> 自 v1.1.5 起新增。

Occurs when the courseware download task times out. When a courseware download task takes more than 15 seconds, the SDK triggers this callback.

| Parameter | Description |
| :---- | :------------- |
| `url` | The download link of the file. |


### onDownloadComplete

```swift
@objc optional func onDownloadComplete(_ url: String)
```

> 自 v1.1.5 起新增。

Occurs when the courseware download task completes.

| Parameter | Description |
| :---- | :------------- |
| `url` | The download link of the file. |


### onDownloadError

```swift
@objc optional func onDownloadError(_ url: String)
```

Occurs when the courseware download task fails.

| Parameter | Description |
| :---- | :------------- |
| `url` | The download link of the file. |

### onCancelCurDownload

```swift
@objc optional func onCancelCurDownload()
```

Occurs when the current courseware download task is canceled.

## AgoraEduWhiteBoardToolContext

`AgoraEduWhiteBoardContext` provides the methods that can be called by your app for whiteboard basic editing tools.

### applianceSelected

```swift
func applianceSelected(_ mode: AgoraEduContextApplianceType)
```

Select a whiteboard basic editing tool.

| Parameter | Description |
| :----- | :-------------------------------------------------- |
| `type` | The whiteboard editing tool type. See `AgoraEduContextApplianceType`. |

### colorSelected

```swift
func colorSelected(_ color: UIColor)
```

Select a color.

| Parameter | Description |
| :------ | :----- |
| `color` | The color. |

### fontSizeSelected

```swift
func fontSizeSelected(_ size: Int)
```

Select a font size.

| Parameter | Description |
| :--- | :--- |
| `size` | The font size. |

### thicknessSelected

```swift
func thicknessSelected(_ thick: Int)
```

Select the line thickness.

| Parameter | Description |
| :--- | :--- |
| `thick` | The line thickness |

## AgoraEduWhiteBoardPageControlContext

`AgoraEduWhiteBoardContext` provides the methods that can be called by your app for whiteboard basic editing tools.

### zoomOut

```swift
func zoomOut()
```

Zoom out the whiteboard. Every time you call this method, the whiteboard is zoomed out by 10%.

### zoomIn

```swift
func zoomIn()
```

Zoom in the whiteboard. Every time you call this method, the whiteboard is zoomed in by 10%.

### prevPage

```swift
func prevPage()
```

Go to the previous page.

### nextPage

```swift
func nextPage()
```

Go to the next page.

### registerPageControlEventHandler

```swift
func registerPageControlEventHandler(_ handler: AgoraEduWhiteBoardPageControlHandler)
```

Register the event listener.

## AgoraEduWhiteBoardPageControlHandler

### onPageIndex

```swift
@objc optional func onPageIndex(_ pageIndex: NSInteger,
                                  pageCount: NSInteger)
```

> 自 v1.1.5 起新增。

Indicates the current page number and total page number of the whiteboard.

| Parameter | Description |
| :---------- | :--------- |
| `pageIndex` | The current page number. |
| `pageCount` | The total number of pages. |


### onPagingEnable

```swift
@objc optional func onPagingEnable(_ enable: Bool)
```

> 自 v1.1.5 起新增。

报告本地是否有权限翻页。

| Parameter | Description |
| :------- | :----------- |
| `enable` | Whether the paging function is enabled. |


### onZoomEnable

```swift
@objc optional func onZoomEnable(_ zoomOutEnable: Bool,
                                    zoomInEnable: Bool)
```

> 自 v1.1.5 起新增。

报告本地是否有权限放大或缩小白板。

| Parameter | Description |
| :-------------- | :----------- |
| `zoomOutEnable` | Whether the zooming out function is enabled. |
| `zoomInEnable` | Whether the zooming in function is enabled. |

### onResizeFullScreenEnable

```swift
@objc optional func onResizeFullScreenEnable(_ enable: Bool)
```

> 自 v1.1.5 起新增。

报告本地是否有权限全屏白板。

| Parameter | Description |
| :------- | :--------------- |
| `enable` | Whether the whiteboard full-screen function is enabled. |

### onFullScreen

```swift
@objc optional func onFullScreen(_ fullScreen: Bool)
```

> 自 v1.1.5 起新增。

Indicates whether the whiteboard is full screen.

| Parameter | Description |
| :----------- | :----------------- |
| `fullScreen` | Whether the whiteboard is full screen. |
