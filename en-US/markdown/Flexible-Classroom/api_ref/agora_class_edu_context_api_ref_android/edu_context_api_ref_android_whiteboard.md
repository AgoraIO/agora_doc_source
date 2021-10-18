## WhiteboardContext

`WhiteboardContext` provides the methods that can be called by your app for the whiteboard.

### initWhiteboard

```kotlin
abstract fun initWhiteboard(container: ViewGroup)
```

Initializes the whiteboard.

### joinWhiteboard

```kotlin
abstract fun joinWhiteboard()
```

Joins a whiteboard room.

### isGranted

```kotlin
abstract fun isGranted(): Boolean
```

Sets whether the local client has permission to operate the whiteboard.

### leave

```kotlin
abstract fun leave()
```

Leaves a whiteboard room.

### selectAppliance

```kotlin
abstract fun selectAppliance(type: WhiteboardApplianceType)
```

Selects a whiteboard basic editing tool.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `type` | The whiteboard editing tool type. See [WhiteboardApplianceType](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#whiteboardappliancetype). |

### selectColor

```kotlin
abstract fun selectColor(color: Int)
```

Selects a color.

| Parameter | Description |
| :------ | :----- |
| `color` | The color. |

### selectFontSize

```kotlin
abstract fun selectFontSize(size: Int)
```

Selects a font size.

| Parameter | Description |
| :--- | :--- |
| `size` | The font size. |

### selectThickness

```kotlin
abstract fun selectThickness(thick: Int)
```

Selects the line thickness.

| Parameter | Description |
| :--- | :--- |
| `thick` | The line thickness |

### selectRoster

```kotlin
abstract fun selectRoster(anchor: View)
```

Clicks the user list.

| Parameter | Description |
| :--- | :--- |
| `anchor` | The Icon-View of the user list. |

### setBoardInputEnable

```kotlin
abstract fun setBoardInputEnable(enable: Boolean)
```

| Parameter | Description |
| :--- | :--- |
| `enable` | Enables or disables the whiteboard basic editing tools and page controller. When a whiteboard courseware downloading progress bar or dialog box appears, the whiteboard basic tools and page controller are not available. |

### skipDownload

```kotlin
abstract fun skipDownload(url: String?)
```

Skips the courseware download.

| Parameter | Description |
| :--- | :--- |
| `url` | The download link of the file. |

### cancelDownload

```kotlin
abstract fun cancelDownload(url: String?)
```

Cancels the courseware download.

| Parameter | Description |
| :--- | :--- |
| `url` | The download link of the file. |

### retryDownload

```kotlin
abstract fun retryDownload(url: String?)
```

Retries the courseware download.

| Parameter | Description |
| :--- | :--- |
| `url` | The download link of the file. |

### setFullScreen

```kotlin
abstract fun setFullScreen(full: Boolean)
```

Makes the whiteboard full screen.

| Parameter | Description |
| :--- | :--- |
| `full` | Whether to make the whiteboard full screen. |

### setZoomOut

```kotlin
abstract fun setZoomOut()
```

Zooms out the whiteboard. Every time you call this method, the whiteboard is zoomed out by 20%.

### setZoomIn

```kotlin
abstract fun setZoomIn()
```

Zooms in the whiteboard. Every time you call this method, the whiteboard is zoomed in by 20%.

### setPrevPage

```kotlin
abstract fun setPrevPage()
```

Goes to the previous page.

### setNextPage

```kotlin
abstract fun setNextPage()
```

Goes to the next page.

## WhiteboardHandler

`WhiteboardContext` reports whiteboard-related event callbacks to the app.

### onWhiteboardJoinSuccess

```kotlin
fun onWhiteboardJoinSuccess(config: WhiteboardDrawingConfig)
```

Occurs when the local cliet successfully joins the whiteboard room.

| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `config` | The initial configuration of the whiteboard. See [WhiteboardDrawingConfig](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#whiteboarddrawingconfig). |

### onWhiteboardJoinFail

```kotlin
fun onWhiteboardJoinFail(msg: String)
```

Occurs when the local client fails to join the whiteboard room.

| Parameter | Description |
| :---- | :--------- |
| `msg` | The error message. |

### onWhiteboardLeft

```kotlin
fun onWhiteboardLeft(boardId: String, timestamp: Long)
```

Occurs when the local client successfully leaves the whiteboard room.

| Parameter | Description |
| :---------- | :------------------- |
| `boardId` | The whiteboard ID. |
| `timestamp` | The timestamp when the local client leaves the whiteboard room. |

### getBoardContainer

```kotlin
fun getBoardContainer(): ViewGroup?
```

Gets the whiteboard container ViewGroup.

| Parameter | Description |
| :--- | :--- |
| `ViewGroup` | The whiteboard container ViewGroup. |


### onDrawingConfig

```kotlin
fun onDrawingConfig(config: WhiteboardDrawingConfig)
```

Indicates the initial tool configuration of the whiteboard.

| Parameter | Description |
| :--- | :--- |
| `config` | The initial configuration of the whiteboard. See [WhiteboardDrawingConfig](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#whiteboarddrawingconfig). |

### onDrawingEnabled

```kotlin
fun onDrawingEnabled(enabled: Boolean)
```

Indicates whether the whiteboard basic editing tools are enabled.

| Parameter | Description |
| :--- | :--- |
| `enabled` | Whether the whiteboard editing tools are enabled. |


### onPageNo

```kotlin
fun onPageNo(no: Int, count: Int)
```

Indicates the current page number and total page number of the whiteboard.

| Parameter | Description |
| :--- | :--- |
| `no` | The current page number. |
| `count` | The total number of pages. |


### onPagingEnabled

```kotlin
fun onPagingEnabled(enabled: Boolean)
```

Indicates whether the whiteboard page navigator is enabled.

| Parameter | Description |
| :--- | :--- |
| `enabled` | Whether the paging function is enabled. |


### onZoomEnabled

```kotlin
fun onZoomEnabled(zoomOutEnabled: Boolean?, zoomInEnabled: Boolean?)
```
Indicates whether the page zoom function is enabled.

| Parameter | Description |
| :--- | :--- |
| `zoomOutEnabled` | Whether the local user has permission to zoom out the whiteboard. |
| `zoomInEnabled` | Whether the local user has permission to zoom in the whiteboard. |

### onFullScreenEnabled

```kotlin
fun onFullScreenEnabled(enabled: Boolean)
```
Indicates whether the whiteboard full-screen function is enabled.

| Parameter | Description |
| :--- | :--- |
| `enabled` | Whether the whiteboard full-screen function is enabled. |

### onFullScreenChanged

```kotlin
fun onFullScreenChanged(isFullScreen: Boolean)
```
Indicates whether the whiteboard is full screen.

| Parameter | Description |
| :--- | :--- |
| `isFullScreen` | Whether the whiteboard is full screen. |


### onInteractionEnabled

```kotlin
fun onInteractionEnabled(enabled: Boolean)
```

Indicates whether the whiteboard page controller is enabled.

| Parameter | Description |
| :--- | :--- |
| `enabled` | Indicates whether the whiteboard page controller is enabled. |


### onBoardPhaseChanged

```kotlin
fun onBoardPhaseChanged(phase: EduBoardRoomPhase)
```

Occurs when the whiteboard connection state changes.

| Parameter | Description |
| :--- | :--- |
| `phase` | The connection state of the whiteboard. See [EduBoardRoomPhase](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#eduboardroomphase). |


### onDownloadProgress

```kotlin
fun onDownloadProgress(url: String, progress: Float)
```
Indicates the progress of the current courseware download.

| Parameter | Description |
| :--- | :--- |
| `url` | The download link of the file. |
| `progress` | The courseware download progress. The value range is 0 to 1. |

### onDownloadTimeout

```kotlin
fun onDownloadTimeout(url: String)
```
Occurs when the courseware download task times out. When a courseware download task takes more than 15 seconds, the SDK triggers this callback.

| Parameter | Description |
| :--- | :--- |
| `url` | The download link of the file. |


### onDownloadCompleted

```kotlin
fun onDownloadCompleted(url: String)
```

Occurs when the courseware download task completes.

| Parameter | Description |
| :--- | :--- |
| `url` | The download link of the file. |


### onDownloadError

```kotlin
fun onDownloadError(url: String)
```

Occurs when the courseware download task fails.

| Parameter | Description |
| :--- | :--- |
| `url` | The download link of the file. |

### onDownloadCanceled

```kotlin
fun onDownloadCanceled(url: String)
```

Occurs when the current courseware download task is canceled.

| Parameter | Description |
| :--- | :--- |
| `url` | The download link of the file. |

### onPermissionGranted

```kotlin
fun onPermissionGranted(granted: Boolean)
```

Occurs when the whiteboard permission changes.

| Parameter | Description |
| :--- | :--- |
| `granted` | Whether the local client has the permission of drawing on the whiteboard. |

