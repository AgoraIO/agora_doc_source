# Whiteboard Context

## WhiteboardContext

The` WhiteboardContext` class provides whiteboard-related methods that can be called by the App.

### selectAppliance

```kotlin
abstract fun selectAppliance(type: WhiteboardApplianceType)
```

Select the whiteboard tool.

| Parameter | Description |
| :----- | :--------------------------------------------- |
| `type` | Whiteboard` tool type, see WhiteboardApplianceType for details`. |

### selectColor

```kotlin
abstract fun selectColor(color: Int)
```

choose the color.

| Parameter | Description |
| :------ | :----- |
| `color` | colour. |

### selectFontSize

```kotlin
abstract fun selectFontSize(size: Int)
```

The font size.

| Parameter | Description |
| :--- | :--- |
| `size` | The font size. |

### selectThickness

```kotlin
abstract fun selectThickness(thick: Int)
```

Choose the brush thickness.

| Parameter | Description |
| :--- | :--- |
| `think` | Brush thickness. |

### selectRoster

```kotlin
abstract fun selectRoster(anchor: View)
```

Select the list of people.

| Parameter | Description |
| :--- | :--- |
| `anchor` | Icon-View of user list. |

### setBoardInputEnable

```kotlin
abstract fun setBoardInputEnable(enable: Boolean)
```

| Parameter | Description |
| :--- | :--- |
| `enable` | Is it possible to use the whiteboard tool and PageControl toolbar. When the progress box or download failure box pops up on the whiteboard, the whiteboard tool and PageControl toolbar cannot be used. |

### skipDownload

```kotlin
abstract fun skipDownload(url: String?)
```

Skip the courseware download.

| Parameter | Description |
| :--- | :--- |
| `url` | The download link of the file. |

### cancelDownload

```kotlin
abstract fun cancelDownload(url: String?)
```

Cancel the courseware download.

| Parameter | Description |
| :--- | :--- |
| `url` | The download link of the file. |

### retryDownload

```kotlin
abstract fun retryDownload(url: String?)
```

Retry the courseware download.

| Parameter | Description |
| :--- | :--- |
| `url` | The download link of the file. |

### setFullScreen

```kotlin
abstract fun setFullScreen(full: Boolean)
```

Set whether the whiteboard is full screen.

| Parameter | Description |
| :--- | :--- |
| `full` | Whether  whiteboard is full screen. |

### setZoomOut

```kotlin
abstract fun setZoomOut()
```

Zoom out  whiteboard. Each call is reduced by 20%.

### setZoomIn

```kotlin
abstract fun setZoomIn()
```

Zoom in on the whiteboard. Each time it is called, it zooms in by 20%.

### setPrevPage

```kotlin
abstract fun setPrevPage()
```

Turn to the previous page.

### setNextPage

```kotlin
abstract fun setNextPage()
```

Turn to the next page.

## WhiteboardHandler

The` WhiteboardContext` class is used to report whiteboard-related event callbacks to the App.

### getBoardContainer

```kotlin
fun getBoardContainer(): ViewGroup?
```

Get the whiteboard container ViewGroup.

| Parameter | Description |
| :--- | :--- |
| `ViewGroup` | whiteboard container ViewGroup. |


### onDrawingConfig

```kotlin
fun onDrawingConfig(config: WhiteboardDrawingConfig)
```

Return to the initial tool configuration of the whiteboard.

| Parameter | Description |
| :--- | :--- |
| `config` | For the initial configuration of the whiteboard, see WhiteboardDrawingConfig for details``. |

### onDrawingEnabled

```kotlin
fun onDrawingEnabled(enabled: Boolean)
```

Report whether the whiteboard tool is available.

| Parameter | Description |
| :--- | :--- |
| `enabled` | Whether the whiteboard tool is available. |


### onPageNo

```kotlin
fun onPageNo(no: Int, count: Int)
```

Report the current page number and total page number of the whiteboard.

| Parameter | Description |
| :--- | :--- |
| `no` | current page number. |
| `count` | total pages. |


### onPagingEnabled

```kotlin
fun onPagingEnabled(enabled: Boolean)
```

Whether the report can be paged.

| Parameter | Description |
| :--- | :--- |
| `enabled` | Whether the page can be turned. |


### onZoomEnabled

```kotlin
fun onZoomEnabled(zoomOutEnabled: Boolean?, zoomInEnabled: Boolean?)
```
Whether the report can be zoomed in or out.

| Parameter | Description |
| :--- | :--- |
| `zoomOutEnabled` | Whether it can be reduced. |
| `zoomInEnabled` | Whether it can be zoomed in. |

### onFullScreenEnabled

```kotlin
fun onFullScreenEnabled(enabled: Boolean)
```
Whether the report can be a full-screen whiteboard.

| Parameter | Description |
| :--- | :--- |
| `enabled` | Whether  whiteboard can be full screen. |

### onFullScreenChanged

```kotlin
fun onFullScreenChanged(isFullScreen: Boolean)
```
Report whether the current whiteboard is full screen.

| Parameter | Description |
| :--- | :--- |
| `isFullScreen` | Whether the current whiteboard is full screen. |


### onInteractionEnabled

```kotlin
fun onInteractionEnabled(enabled: Boolean)
```

Report whether the PageControl toolbar is available.

| Parameter | Description |
| :--- | :--- |
| `enabled` | Whether the PageControl toolbar is available. |


### onLoadingVisible

```kotlin
fun onLoadingVisible(visible: Boolean)
```

Report whether  whiteboard loading status is visible.

| Parameter | Description |
| :--- | :--- |
| `visible` | Whether the loading status of  whiteboard is visible. |


### onDownloadProgress

```kotlin
fun onDownloadProgress(url: String, progress: Float)
```
Report the progress of the current courseware download.

| Parameter | Description |
| :--- | :--- |
| `url` | Courseware download URL address. |
| `progress` | The courseware is downloaded and entered, and the value range is 0 to 1. |

### onDownloadTimeout

```kotlin
fun onDownloadTimeout(url: String)
```
Report that the courseware download timed out. When a courseware download takes more than 15 seconds, the callback will be triggered.

| Parameter | Description |
| :--- | :--- |
| `url` | Courseware download URL address. |


### onDownloadCompleted

```kotlin
fun onDownloadCompleted(url: String)
```

The download of the report courseware is complete.

| Parameter | Description |
| :--- | :--- |
| `url` | Courseware download URL address. |


### onDownloadError

```kotlin
fun onDownloadError(url: String)
```

Report that the download of the courseware failed.

| Parameter | Description |
| :--- | :--- |
| `url` | Courseware download URL address. |

### onDownloadCanceled

```kotlin
fun onDownloadCanceled(url: String)
```

Report that the current courseware download task is cancelled.

| Parameter | Description |
| :--- | :--- |
| `url` | Courseware download URL address. |

### onPermissionGranted

```kotlin
fun onPermissionGranted(granted: Boolean)
```

Report whiteboard permissions have changed.

| Parameter | Description |
| :--- | :--- |
| `granted` | Whether you have whiteboard permissions. |

