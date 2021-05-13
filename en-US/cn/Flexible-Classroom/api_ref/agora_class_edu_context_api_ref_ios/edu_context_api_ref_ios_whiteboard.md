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

Refresh the whiteboard size. 在白板容器大小发生变化时，需要调用该方法。

### registerBoardEventHandler

```swift
func registerBoardEventHandler(_ handler: AgoraEduWhiteBoardHandler)
```

Register the event listener.

| Parameter | Description |
| :-------- | :--------------------------------- |
| `handler` | See `AgoraEduWhiteBoardHandler` for details. |

## AgoraEduWhiteBoardHandler

### onGetBoardContainer

```swift
@objc optional func onGetBoardContainer() -> UIView
```

Gets the whiteboard container view.

### onSetDrawingEnabled

```swift
@objc optional func onSetDrawingEnabled(_ enabled: Bool)
```

Indicates whether the whiteboard basic editing tools are enabled.

| Parameter | Description |
| :-------- | :----------------- |
| `enabled` | Whether the whiteboard editing tools are enabled. |

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
| `progress` | The courseware download progress. The value range is 0 to 100. |

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

`AgoraEduWhiteBoardToolContext` 类提供可供 App 调用的白板基础工具相关方法。

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

### zoomOut

```swift
func zoomOut()
```

Zoom out the whiteboard. Every time you call this method, the whiteboard is zoomed out by 10%.

### zoomIn

```swift
func zoomIn ()
```

Zoom in the whiteboard. Every time you call this method, the whiteboard is zoomed in by 10%.

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

Indicates the current page number and total page number of the whiteboard.

| Parameter | Description |
| :---------- | :--------- |
| `pageIndex` | The current page number. |
| `pageCount` | The total number of pages. |


### onSetPagingEnable

```swift
@objc optional func onSetPagingEnable(_ enable: Bool)
```

Indicates whether the whiteboard page navigator is enabled.

| Parameter | Description |
| :------- | :----------- |
| `enable` | Whether the paging function is enabled. |


### onSetZoomEnable

```swift
@objc optional func onSetZoomEnable(_ zoomOutEnable: Bool,
                                      zoomInEnable: Bool)
```

Indicates whether the page zoom function is enabled.

| Parameter | Description |
| :-------------- | :----------- |
| `zoomOutEnable` | Whether the zooming out function is enabled. |
| `zoomInEnable` | Whether the zooming in function is enabled. |

### onSetResizeFullScreenEnable

```swift
@objc optional func onSetResizeFullScreenEnable(_ enable: Bool)
```

Indicates whether the whiteboard full-screen function is enabled.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | Whether the whiteboard full-screen function is enabled. |

### onSetFullScreen

```swift
@objc optional func onSetFullScreen(_ fullScreen: Bool)
```

Indicates whether the whiteboard is full screen.

| Parameter | Description |
| :----------- | :----------------- |
| `fullScreen` | Whether the whiteboard is full screen. |
