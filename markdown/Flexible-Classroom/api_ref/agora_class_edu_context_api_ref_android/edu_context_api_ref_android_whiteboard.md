## WhiteboardContext

`WhiteboardContext` 类提供可供 App 调用的白板相关方法。

### initWhiteboard

```kotlin
abstract fun initWhiteboard(container: ViewGroup)
```

初始化白板。

### joinWhiteboard

```kotlin
abstract fun joinWhiteboard()
```

加入白板房间。

### isGranted

```kotlin
abstract fun isGranted(): Boolean
```

设置是否有权限操作白板。

### leave

```kotlin
abstract fun leave()
```

离开白板房间。

### selectAppliance

```kotlin
abstract fun selectAppliance(type: WhiteboardApplianceType)
```

选中白板基础工具。

| 参数   | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| `type` | 白板基础工具类型，详见 [WhiteboardApplianceType](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#whiteboardappliancetype)。 |

### selectColor

```kotlin
abstract fun selectColor(color: Int)
```

选择颜色。

| 参数    | 描述   |
| :------ | :----- |
| `color` | 颜色。 |

### selectFontSize

```kotlin
abstract fun selectFontSize(size: Int)
```

选择字体大小。

| 参数 | 描述 |
| :--- | :--- |
| `size`   |   字体大小。   |

### selectThickness

```kotlin
abstract fun selectThickness(thick: Int)
```

选择画笔粗细。

| 参数 | 描述 |
| :--- | :--- |
|  `thick`   |  画笔粗细。   |

### selectRoster

```kotlin
abstract fun selectRoster(anchor: View)
```

选中用户列表。

| 参数 | 描述 |
| :--- | :--- |
|  `anchor`    |  用户列表的 Icon-View。  |

### setBoardInputEnable

```kotlin
abstract fun setBoardInputEnable(enable: Boolean)
```

| 参数 | 描述 |
| :--- | :--- |
|  `enable`    | 是否可以使用白板基础工具和白板页面控制工具。白板弹出进度框或下载失败框的时候，白板基础工具和白板页面控制工具不可使用。 |

### skipDownload

```kotlin
abstract fun skipDownload(url: String?)
```

跳过课件下载。

| 参数 | 描述 |
| :--- | :--- |
|  `url`    |   课件下载地址。   |

### cancelDownload

```kotlin
abstract fun cancelDownload(url: String?)
```

取消课件下载。

| 参数 | 描述 |
| :--- | :--- |
|  `url`    |   课件下载地址。   |

### retryDownload

```kotlin
abstract fun retryDownload(url: String?)
```

课件下载重试。

| 参数 | 描述 |
| :--- | :--- |
|  `url`    |   课件下载地址。   |

### setFullScreen

```kotlin
abstract fun setFullScreen(full: Boolean)
```

设置白板是否全屏。

| 参数 | 描述 |
| :--- | :--- |
|  `full`    |  白板是否全屏。    |

### setZoomOut

```kotlin
abstract fun setZoomOut()
```

缩小白板。每调用一次，缩小 20%。

### setZoomIn

```kotlin
abstract fun setZoomIn()
```

放大白板。每调用一次，放大 20%。

### setPrevPage

```kotlin
abstract fun setPrevPage()
```

翻至上一页。

### setNextPage

```kotlin
abstract fun setNextPage()
```

翻至下一页。

## IWhiteboardHandler

`WhiteboardContext` 类用于向 App 报告白板相关的事件回调。

### onWhiteboardJoinSuccess

```kotlin
fun onWhiteboardJoinSuccess(config: WhiteboardDrawingConfig)
```

提示成功加入白板房间。

| 参数     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| `config` | 白板初始配置，详见 [WhiteboardDrawingConfig](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#whiteboarddrawingconfig)。 |

### onWhiteboardJoinFail

```kotlin
fun onWhiteboardJoinFail(msg: String)
```

提示加入白板房间失败。

| 参数  | 描述       |
| :---- | :--------- |
| `msg` | 错误描述。 |

### onWhiteboardLeft

```kotlin
fun onWhiteboardLeft(boardId: String, timestamp: Long)
```

提示成功离开白板房间。

| 参数        | 描述                 |
| :---------- | :------------------- |
| `boardId`   | 白板 ID。            |
| `timestamp` | 离开白板房间的时间。 |

### getBoardContainer

```kotlin 
fun getBoardContainer(): ViewGroup?
```

获取白板容器 ViewGroup。

| 参数 | 描述 |
| :--- | :--- |
| `ViewGroup`     | 白板容器 ViewGroup。    |


### onDrawingConfig

```kotlin
fun onDrawingConfig(config: WhiteboardDrawingConfig)
```

返回白板初始工具配置。

| 参数 | 描述 |
| :--- | :--- |
|  `config`    |  白板初始配置，详见 [WhiteboardDrawingConfig](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#whiteboarddrawingconfig)。  |

### onDrawingEnabled

```kotlin
fun onDrawingEnabled(enabled: Boolean)
```

报告白板基础工具是否可用。

| 参数 | 描述 |
| :--- | :--- |
| `enabled`     |  白板基础工具是否可用。  |


### onPageNo

```kotlin
fun onPageNo(no: Int, count: Int)
```

报告白板当前页数和总页数。

| 参数 | 描述 |
| :--- | :--- |
| `no`     |  当前页数。    |
| `count`     |  总页数。    |


### onPagingEnabled

```kotlin
fun onPagingEnabled(enabled: Boolean)
```

报告是否可翻页。

| 参数 | 描述 |
| :--- | :--- |
|  `enabled`    |   是否可翻页。   |


### onZoomEnabled

```kotlin
fun onZoomEnabled(zoomOutEnabled: Boolean?, zoomInEnabled: Boolean?)
```
报告是否可放大、缩小。

| 参数 | 描述 |
| :--- | :--- |
|  `zoomOutEnabled`    |  是否可缩小。    |
|  `zoomInEnabled`    |  是否可放大。    |

### onFullScreenEnabled

```kotlin
fun onFullScreenEnabled(enabled: Boolean)
```
报告是否可全屏白板。

| 参数 | 描述 |
| :--- | :--- |
|  `enabled`    | 是否可全屏白板。     |

### onFullScreenChanged

```kotlin
fun onFullScreenChanged(isFullScreen: Boolean)
```
报告当前白板是否全屏。

| 参数 | 描述 |
| :--- | :--- |
| `isFullScreen`     | 当前白板是否全屏。     |


### onInteractionEnabled

```kotlin
fun onInteractionEnabled(enabled: Boolean)
```

报告白板页面控制工具是否可用。

| 参数 | 描述 |
| :--- | :--- |
| `enabled`     |  白板页面控制工具是否可用。     |


### onBoardPhaseChanged

```kotlin
fun onBoardPhaseChanged(phase: EduBoardRoomPhase)
```

白板连接状态发生变化。

| 参数 | 描述 |
| :--- | :--- |
|  `phase`  |  白板连接状态，详见 [EduBoardRoomPhase](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#eduboardroomphase)。  |


### onDownloadProgress

```kotlin
fun onDownloadProgress(url: String, progress: Float)
```
报告当前课件下载进度。

| 参数 | 描述 |
| :--- | :--- |
|  `url`    |  课件下载 URL 地址。    |
|  `progress`    | 课件下载进度，取值范围为 0 到 1。   |

### onDownloadTimeout

```kotlin
fun onDownloadTimeout(url: String)
```
报告课件下载超时。当一次课件下载所花的时间超过了 15 秒，就会触发该回调。

| 参数 | 描述 |
| :--- | :--- |
|  `url`    |  课件下载 URL 地址。    |


### onDownloadCompleted

```kotlin
fun onDownloadCompleted(url: String)
```

报告课件下载完成。

| 参数 | 描述 |
| :--- | :--- |
|  `url`    |  课件下载 URL 地址。    |


### onDownloadError

```kotlin
fun onDownloadError(url: String)
```

报告课件下载失败。

| 参数 | 描述 |
| :--- | :--- |
|  `url`    |  课件下载 URL 地址。    |

### onDownloadCanceled

```kotlin
fun onDownloadCanceled(url: String)
```

报告当前课件下载任务被取消。

| 参数 | 描述 |
| :--- | :--- |
|  `url`    |  课件下载 URL 地址。    |

### onPermissionGranted 

```kotlin
fun onPermissionGranted(granted: Boolean)
```

报告白板权限发生变化。

| 参数 | 描述 |
| :--- | :--- |
|  `granted`    |  是否具有白板权限。    |

