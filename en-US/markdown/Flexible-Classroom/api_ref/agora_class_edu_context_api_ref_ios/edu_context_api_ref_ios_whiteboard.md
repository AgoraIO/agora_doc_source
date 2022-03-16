## AgoraEduWhiteBoardContext

`AgoraEduWhiteBoardContext` provides whiteboard-related methods that can be called by your app.

### boardInputEnable

```swift
func boardInputEnable(_ enable: Bool)
```

Enables or disables the whiteboard basic editing tools.

| Parameter | Description |
| :------- | :--------------------- |
| `enable` | Whether to enable the whiteboard basic editing tools. |

### skipDownload

```swift
func skipDownload(_ url: String)
```

Skips the courseware download.

| Parameter | Description |
| :---- | :------------- |
| `url` | The download link of the file. |

### cancelDownload

```swift
func cancelDownload(_ url: String)
```

Cancels the courseware download.

| Parameter | Description |
| :---- | :------------- |
| `url` | The download link of the file. |

### retryDownload

```swift
func retryDownload(_ url: String)
```

Retries the courseware download.

| Parameter | Description |
| :---- | :------------- |
| `url` | The download link of the file. |

### boardRefreshSize

```swift
func boardRefreshSize()
```

Refreshes the whiteboard size. You need to call this method when the size of the whiteboard container changes.

### getContentView

```swift
func getContentView() -> UIView?
```

Gets the whiteboard container view. If the whiteboard is not initialized successfully, this method returns `nil`.

### registerBoardEventHandler

```swift
func registerBoardEventHandler(_ handler: AgoraEduWhiteBoardHandler)
```

Registers the event listener.

| Parameter | Description |
| :-------- | :--------------------------------- |
| `handler` | See `AgoraEduWhiteBoardHandler` for details. |

## AgoraEduWhiteBoardHandler

### onBoardContentView

```swift
@objc optional func onBoardContentView(_ view: UIView)
```

> Since v1.1.5.

Returns the whiteboard container view.

| Parameter | Description |
| :----- | :-------------- |
| `view` | The whiteboard container view. |

### onDrawingEnabled

```swift
@objc optional func onDrawingEnabled(_ enabled: Bool)
```

> Since v1.1.5.

Reports whether the local client has permission to make drawings on the whiteboard.

- When `enabled` is `true`, Flexible Classroom triggers a pop-up window saying "You can now use the whiteboard tools".
- When `enabled` is `false`, Flexible Classroom triggers a pop-up window saying "You cannot use the whiteboard tools".

| Parameter | Description |
| :-------- | :----------------- |
| `enabled` | Whether the local client has permission to make drawings on the whiteboard. |

### onLoadingVisible

```swift
@objc optional func onLoadingVisible(_ visible: Bool)
```

> Since v1.1.5.

Indicates whether the whiteboard bar status is visible.

| Parameter | Description |
| :-------- | :--------------------- |
| `visible` | Whether the whiteboard loading bar is visible. |

### onDownloadProgress

```swift
@objc optional func onDownloadProgress(_ url: String,
                                    progress: Float)
```

> Since v1.1.5.

Indicates the progress of the current courseware download.

| Parameter | Description |
| :--------- | :---------------------------------- |
| `url` | The download link of the file. |
| `progress` | The courseware download progress. The value range is 0 to 100. |

### onDownloadTimeout

```swift
@objc optional func onDownloadTimeOut(_ url: String)
```

> Since v1.1.5.

Occurs when the courseware download task times out. When a courseware download task takes more than 15 seconds, the SDK triggers this callback.

| Parameter | Description |
| :---- | :------------- |
| `url` | The download link of the file. |


### onDownloadComplete

```swift
@objc optional func onDownloadComplete(_ url: String)
```

> Since v1.1.5.

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

Selects a whiteboard basic editing tool.

| Parameter | Description |
| :----- | :-------------------------------------------------- |
| `type` | The whiteboard editing tool type. See `AgoraEduContextApplianceType`. |

### colorSelected

```swift
func colorSelected(_ color: UIColor)
```

Selects a color.

| Parameter | Description |
| :------ | :----- |
| `color` | The color. |

### fontSizeSelected

```swift
func fontSizeSelected(_ size: Int)
```

Selects a font size.

| Parameter | Description |
| :--- | :--- |
| `size` | The font size. |

### thicknessSelected

```swift
func thicknessSelected(_ thick: Int)
```

Selects the line thickness.

| Parameter | Description |
| :--- | :--- |
| `thick` | The line thickness |

## AgoraEduWhiteBoardPageControlContext

`AgoraEduWhiteBoardContext` provides the methods that can be called by your app for the whiteboard page controller.

### zoomOut

```swift
func zoomOut()
```

Zooms out the whiteboard. Every time you call this method, the whiteboard is zoomed out by 10%.

### zoomIn

```swift
func zoomIn()
```

Zooms in the whiteboard. Every time you call this method, the whiteboard is zoomed in by 10%.

### prevPage

```swift
func prevPage()
```

Goes to the previous page.

### nextPage

```swift
func nextPage()
```

Goes to the next page.

### registerPageControlEventHandler

```swift
func registerPageControlEventHandler(_ handler: AgoraEduWhiteBoardPageControlHandler)
```

Registers the event listener.

## AgoraEduWhiteBoardPageControlHandler

### onPageIndex

```swift
@objc optional func onPageIndex(_ pageIndex: NSInteger,
                                  pageCount: NSInteger)
```

> Since v1.1.5.

Indicates the current page number and total page number of the whiteboard.

| Parameter | Description |
| :---------- | :--------- |
| `pageIndex` | The current page number. |
| `pageCount` | The total number of pages. |


### onPagingEnable

```swift
@objc optional func onPagingEnable(_ enable: Bool)
```

> Since v1.1.5.

Reports whether the local user has permission to turn pages.

| Parameter | Description |
| :------- | :----------- |
| `enable` | Whether the paging function is enabled. |


### onZoomEnable

```swift
@objc optional func onZoomEnable(_ zoomOutEnable: Bool,
                                    zoomInEnable: Bool)
```

> Since v1.1.5.

Reports whether the local user has permission to zoom in or zoom out the whiteboard.

| Parameter | Description |
| :-------------- | :----------- |
| `zoomOutEnable` | Whether the local user has permission to zoom out the whiteboard. |
| `zoomInEnable` | Whether the local user has permission to zoom in the whiteboard. |

### onResizeFullScreenEnable

```swift
@objc optional func onResizeFullScreenEnable(_ enable: Bool)
```

> Since v1.1.5.

Reports whether the local user has permission to make the whiteboard full-screen.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | Whether the whiteboard full-screen function is enabled. |

### onFullScreen

```swift
@objc optional func onFullScreen(_ fullScreen: Bool)
```

> Since v1.1.5.

Indicates whether the whiteboard is full screen.

| Parameter | Description |
| :----------- | :----------------- |
| `fullScreen` | Whether the whiteboard is full screen. |
