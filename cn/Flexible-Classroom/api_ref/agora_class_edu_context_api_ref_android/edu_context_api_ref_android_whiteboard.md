# Whiteboard Context

## WhiteboardContext

`WhiteboardContext` 类提供可供 App 调用的白板相关方法。

### selectAppliance

```kotlin
abstract fun selectAppliance(type: WhiteboardApplianceType)
```

选中白板工具。

| 参数   | 描述                                           |
| :----- | :--------------------------------------------- |
| `type` | 白板工具类型，详见 `WhiteboardApplianceType`。 |

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
|  `think`    |  画笔粗细。   |

### selectRoster

```kotlin
abstract fun selectRoster(anchor: View)
```

选中人员列表。

| 参数 | 描述 |
| :--- | :--- |
|  `anchor`    |  用户列表的 Icon-View。  |

### setBoardInputEnable

```kotlin
abstract fun setBoardInputEnable(enable: Boolean)
```

| 参数 | 描述 |
| :--- | :--- |
|  `enable`    | 是否可以使用白板工具和 PageControl 工具条。白板弹出进度框或下载失败框的时候，白板工具和 PageControl 工具条不可使用。 |

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
|  `config`    |  白板初始配置，详见 `WhiteboardDrawingConfig`。  |

### onDrawingEnabled

```kotlin
fun onDrawingEnabled(enabled: Boolean)
```

报告白板工具是否可用。

| 参数 | 描述 |
| :--- | :--- |
| `enabled`     |  白板工具是否可用。  |


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

报告 PageControl 工具条是否可用。

| 参数 | 描述 |
| :--- | :--- |
| `enabled`     |  PageControl 工具条是否可用。     |


### onLoadingVisible

```kotlin
fun onLoadingVisible(visible: Boolean)
```

报告白板加载状态是否可见。

| 参数 | 描述 |
| :--- | :--- |
|  `visible`    |  白板加载状态是否可见。    |


### onDownloadProgress

```kotlin
fun onDownloadProgress(url: String, progress: Float)
```
报告当前课件下载进度。

| 参数 | 描述 |
| :--- | :--- |
|  `url`    |  课件下载 URL 地址。    |
|  `progress`    | 课件下载进入，取值范围为 0 到 1。     |

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

