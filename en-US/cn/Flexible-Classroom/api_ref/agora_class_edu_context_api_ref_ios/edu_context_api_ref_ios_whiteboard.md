# Whiteboard Context

## AgoraEduWhiteBoardContext

The` AgoraEduWhiteBoardContext` class provides whiteboard control related methods that can be called by App.

### boardInputEnable

```swift
func boardInputEnable(_ enable: Bool)
```

Set whether the whiteboard tool can be used.

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
// event monitoring
func registerBoardEventHandler(_ handler: AgoraEduWhiteBoardHandler)
```

Register event listener.

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

Report whether the whiteboard tool is available.

| Parameter | Description |
| :-------- | :----------------- |
| `enabled` | Whether the whiteboard tool is available. |

### onSetLoadingVisible

```swift
@objc optional func onSetLoadingVisible(_ visible: Bool)
```

Report whether  whiteboard loading status is visible.

| Parameter | Description |
| :-------- | :--------------------- |
| `visible` | Whether the loading status of  whiteboard is visible. |

### onSetDownloadProgress

```swift
@objc optional func onSetDownloadProgress(_ url: String,
                                            progress: Float)
```

Report the progress of the current courseware download.

| Parameter | Description |
| :--------- | :---------------------------------- |
| `url` | Courseware download URL address. |
| `progress` | Courseware download progress, the value range is 0-100. |

### onSetDownloadTimeOut

```swift
@objc optional func onSetDownloadTimeOut(_ url: String)
```

Report that the courseware download timed out. When a courseware download takes more than 15 seconds, the callback will be triggered.

| Parameter | Description |
| :---- | :------------------ |
| `url` | Courseware download URL address. |


### onSetDownloadComplete

```swift
@objc optional func onSetDownloadComplete(_ url: String)
```

The download of the report courseware is complete.

| Parameter | Description |
| :---- | :------------------ |
| `url` | Courseware download URL address. |


### onDownloadError

```swift
@objc optional func onDownloadError(_ url: String)
```

Report that the download of the courseware failed.

| Parameter | Description |
| :---- | :------------------ |
| `url` | Courseware download URL address. |

### onCancelCurDownload

```swift
@objc optional func onCancelCurDownload ()
```

Report that the current courseware download task is cancelled.

| Parameter | Description |
| :---- | :------------------ |
| `url` | Courseware download URL address. |

### onShowPermissionTips

```swift
@objc optional func onShowPermissionTips(_ granted: Bool)
```

Report whiteboard permissions have changed.

| Parameter | Description |
| :-------- | :----------------- |
| `granted` | Whether you have whiteboard permissions. |

## AgoraEduWhiteBoardToolContext

The` AgoraEduWhiteBoardToolContext` class provides whiteboard tool-related methods that can be called by App.

### applianceSelected

```swift
func applianceSelected(_ mode: AgoraEduContextApplianceType)
```

Select a whiteboard editing tool.

| Parameter | Description |
| :----- | :-------------------------------------------------- |
| `type` | whiteboard tool type, see `AgoraEduContextApplianceType `for details. |

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

Register event listener.

## AgoraEduWhiteBoardPageControlHandler

### onSetPageIndex

```swift
@objc optional func onSetPageIndex(_ pageIndex: NSInteger,
                                     pageCount: NSInteger)
```

Report the current page number and total page number of the whiteboard.

| Parameter | Description |
| :---------- | :--------- |
| `pageIndex` | current page number. |
| `pageCount` | total pages. |


### onSetPagingEnable

```swift
@objc optional func onSetPagingEnable(_ enable: Bool)
```

Whether the report can be paged.

| Parameter | Description |
| :------- | :----------- |
| `enable` | Whether the page can be turned. |


### onSetZoomEnable

```swift
@objc optional func onSetZoomEnable(_ zoomOutEnable: Bool,
                                      zoomInEnable: Bool)
```

Whether the report can be zoomed in or out.

| Parameter | Description |
| :-------------- | :----------- |
| `zoomOutEnable` | Whether it can be reduced. |
| `zoomInEnable` | Whether it can be zoomed in. |

### onSetResizeFullScreenEnable

```swift
@objc optional func onSetResizeFullScreenEnable(_ enable: Bool)
```

Whether the report can be a full-screen whiteboard.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | Whether  whiteboard can be full screen. |

### onSetFullScreen

```swift
@objc optional func onSetFullScreen(_ fullScreen: Bool)
```

Report whether the current whiteboard is full screen.

| Parameter | Description |
| :----------- | :----------------- |
| `fullScreen` | Whether the current whiteboard is full screen. |
