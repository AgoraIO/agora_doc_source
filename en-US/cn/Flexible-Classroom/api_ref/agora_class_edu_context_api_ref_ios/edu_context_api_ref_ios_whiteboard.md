# Whiteboard Context

## AgoraEduWhiteBoardContext

The` AgoraEduWhiteBoardContext` class provides whiteboard control related methods that can be called by App.

### boardInputEnable

```swift
func boardInputEnable(_ enable: Bool)
```

设置是否可以使用白板基础工具。

| Parameter | Description |
| :------- | :--------------------- |
| `enable` | Is it possible to use whiteboard tools. |

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

Refresh the size of the whiteboard. This method needs to be called when the size of the whiteboard container changes

### registerBoardEventHandler

```swift
func registerBoardEventHandler(_ handler: AgoraEduWhiteBoardHandler)
```

Register the event listener.

| Parameter | Description |
| :-------- | :--------------------------------- |
| `handler` | See AgoraEduWhiteBoardHandler for details``. |

## AgoraEduWhiteBoardHandler

### onGetBoardContainer

```swift
@objc optional func onGetBoardContainer() -> UIView
```

Get the whiteboard container View.

### onSetDrawingEnabled

```swift
@objc optional func onSetDrawingEnabled(_ enabled: Bool)
```

报告白板基础工具是否可用。

| Parameter | Description |
| :-------- | :----------------- |
| `enabled` | 白板基础工具是否可用。 |

### onSetLoadingVisible

```swift
@objc optional func onSetLoadingVisible(_ visible: Bool)
```

Indicates whether the whiteboard loading status is visible.

| Parameter | Description |
| :-------- | :--------------------- |
| `visible` | Whether the whiteboard loading status is visible. |

### onSetDownloadProgress

```swift
@objc optional func onSetDownloadProgress(_ url: String,
                                            progress: Float)
```

Indicates the progress of the current courseware download.

| Parameter | Description |
| :--------- | :---------------------------------- |
| `url` | The download link of the file. |
| `progress` | Courseware download progress, the value range is 0-100. |

### onSetDownloadTimeOut

```swift
@objc optional func onSetDownloadTimeOut(_ url: String)
```

Occurs when the courseware download task times out. When a courseware download task takes more than 15 seconds, the SDK triggers this callback.

| Parameter | Description |
| :---- | :------------------ |
| `url` | The download link of the file. |


### onSetDownloadComplete

```swift
@objc optional func onSetDownloadComplete(_ url: String)
```

Occurs when the courseware download task completes.

| Parameter | Description |
| :---- | :------------------ |
| `url` | The download link of the file. |


### onDownloadError

```swift
@objc optional func onDownloadError(_ url: String)
```

Occurs when the courseware download task fails.

| Parameter | Description |
| :---- | :------------------ |
| `url` | The download link of the file. |

### onCancelCurDownload

```swift
@objc optional func onCancelCurDownload ()
```

Occurs when the current courseware download task is canceled.

| Parameter | Description |
| :---- | :------------------ |
| `url` | The download link of the file. |

### onShowPermissionTips

```swift
@objc optional func onShowPermissionTips(_ granted: Bool)
```

Occurs when the whiteboard permission changes.

| Parameter | Description |
| :-------- | :----------------- |
| `granted` | Whether the local client has the permission of drawing on the whiteboard. |

## AgoraEduWhiteBoardToolContext

The` AgoraEduWhiteBoardToolContext` class provides whiteboard tool-related methods that can be called by App.

### applianceSelected

```swift
func applianceSelected(_ mode: AgoraEduContextApplianceType)
```

选中白板基础工具。

| Parameter | Description |
| :----- | :-------------------------------------------------- |
| `type` | 白板基础工具类型，详见 `AgoraEduContextApplianceType`。 |

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

### zoomOut

```swift
func zoomOut()
```

Zoom out the whiteboard. Each call is reduced by 10%.

### zoomIn

```swift
func zoomIn ()
```

Zoom in the whiteboard. Each time it is called, the zoom is 10%.

### prevPage

```swift
func prevPage ()
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

### onSetPageIndex

```swift
@objc optional func onSetPageIndex(_ pageIndex: NSInteger,
                                     pageCount: NSInteger)
```

Report the current page number and total page number of the whiteboard.

| Parameter | Description |
| :---------- | :--------- |
| `pageIndex` | The current page number. |
| `pageCount` | The total number of pages. |


### onSetPagingEnable

```swift
@objc optional func onSetPagingEnable(_ enable: Bool)
```

Report whether the paging function is enabled.

| Parameter | Description |
| :------- | :----------- |
| `enable` | Whether the paging function is enabled. |


### onSetZoomEnable

```swift
@objc optional func onSetZoomEnable(_ zoomOutEnable: Bool,
                                      zoomInEnable: Bool)
```

Report whether the zooming function is enabled.

| Parameter | Description |
| :-------------- | :----------- |
| `zoomOutEnable` | Whether the zooming out function is enabled. |
| `zoomInEnable` | Whether the zooming in function is enabled. |

### onSetResizeFullScreenEnable

```swift
@objc optional func onSetResizeFullScreenEnable(_ enable: Bool)
```

Report whether the can be a full-screen whiteboard.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | Whether whiteboard can be full screen. |

### onSetFullScreen

```swift
@objc optional func onSetFullScreen(_ fullScreen: Bool)
```

Report whether the current whiteboard is full screen.

| Parameter | Description |
| :----------- | :----------------- |
| `fullScreen` | Whether the current whiteboard is full screen. |
