## Whiteboard Context

```
interface IWhiteboardHandler {
    // 获取白板容器ViewGroup, 真正的白板会放在这个容器里面
    fun getBoardContainer(): ViewGroup?
 
    // 设置教具配置(一般用于设置白板初始教具的属性)
    fun onDrawingConfig(config: WhiteboardDrawingConfig)
 
    // 设置教具是否可用
    fun onDrawingEnabled(enabled: Boolean)
 
    // 设置总页数，当前第几页
    fun onPageNo(no: Int, count: Int)
 
    // 是否可以翻页
    fun onPagingEnabled(enabled: Boolean)
 
    // 是否可以缩放
    fun onZoomEnabled(zoomOutEnabled: Boolean?, zoomInEnabled: Boolean?)
 
    // 是否可以全屏，注意和setIsFullScreen的区别
    fun onFullScreenEnabled(enabled: Boolean)
 
    // 设置是否全屏，注意和setResizeFullScreenEnable的区别
    fun onFullScreenChanged(isFullScreen: Boolean)
 
    // 设置PageControl工具条是否可用
    fun onInteractionEnabled(enabled: Boolean)
 
    // 白板加载状态
    fun onLoadingVisible(visible: Boolean)
 
    // 课件下载进度，url是课件地址，progress:0-1
    fun onDownloadProgress(url: String, progress: Float)
 
    // 课件下载时间过长，一次课件下载超过了15秒，会有该调用
    fun onDownloadTimeout(url: String)
 
    // 课件下载完成
    fun onDownloadCompleted(url: String)
 
    // 课件下载失败
    fun onDownloadError(url: String)
 
    // 取消当前下载任务
    fun onDownloadCanceled(url: String)
 
    // 白板权限发生变化
    fun onPermissionGranted(granted: Boolean)
}
```





### WhiteboardContext



### IWhiteboardHandler



