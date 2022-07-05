## 概览

由于客户对在线课堂场景存在多种多样、定制化的需求，Agora 提供 Widget 帮助用户根据自身的需求开发插件并内嵌至灵动课堂内。

Widget 是包含界面与功能的独立插件。开发者可基于 `AgoraBaseWidget` 自定义实现一个 Widget，然后在 Agora Classroom SDK 内注册该 Widget。Agora Classroom SDK 支持注册多个 Widget。 Widget 与 Widget 之间，以及 Widget 与 UI 层的其他插件都能进行通讯。

## 基本步骤

本节以云盘插件为例，介绍通过 Widget 实现自定义插件并在灵动课堂内嵌入该插件的基本步骤。

### 1. 实现 Widget

首先，你需要继承 `AgoraBaseWidget` 类，在你的 App 中实现 `FCRCloudDiskWidget` 类：

```kotlin
class FCRCloudDiskWidget : AgoraBaseWidget() {
    override val tag = "AgoraEduNetworkDiskWidget"

    private var cloudDiskContent: AgoraEduCloudDiskWidgetContent? = null

    // 初始化 Widget
    // 建议在这里把你自定义的 UI 布局添加到 container 中
    override fun init(container: ViewGroup) {
        super.init(container)
        container.post {
            widgetInfo?.let {
                // 实例化 content，并把 ClooudDisk 的 view 添加到 container 上
                cloudDiskContent = AgoraEduCloudDiskWidgetContent(container, it)
            }
        }
    }

    // 释放相关资源
    override fun release() {
        cloudDiskContent?.dispose()
        super.release()
    }

    // content 类只是为了代码的封装性考虑，把功能细节都放在了 content 中
    private inner class AgoraEduCloudDiskWidgetContent(val container: ViewGroup, val widgetInfo: AgoraWidgetInfo) {
        ......
    }
}
```

<div class="alert info">完整代码可在 <a href="https://github.com/AgoraIO-Community/CloudClass-Android">CloudClass-Android</a> 仓库 <code>/AgoraEduUIKit/src/main/java/com/agora/edu/component/teachaids/networkdisk/FCRCloudDiskWidget.kt</code> 文件中查看。</div>

### 2. 在 Agora Classroom SDK 中注册 Widget

在 `launchConfig` 中配置插件，在调用 `launch` 时将实现好的插件注册到 Agora Classroom SDK 中：

```kotlin
...
private fun configPublicCourseware(launchConfig: AgoraEduLaunchConfig) {
    val courseware0 = CoursewareUtil.transfer(DefaultPublicCoursewareJson.data0)
    val courseware1 = CoursewareUtil.transfer(DefaultPublicCoursewareJson.data1)
    val publicCoursewares = ArrayList<AgoraEduCourseware>(2)
    publicCoursewares.add(courseware0)
    publicCoursewares.add(courseware1)
    // map 结构的自定义数据
    val cloudDiskExtra = mutableMapOf<String, Any>()
    cloudDiskExtra[publicResourceKey] = publicCoursewares
    cloudDiskExtra[configKey] = Pair(launchConfig.appId, launchConfig.userUuid)
    val widgetConfigs = mutableListOf<AgoraWidgetConfig>()
    widgetConfigs.add(
        // 实例化 widgetConfig 并加入到 widgetConfig 集合中
        AgoraWidgetConfig(widgetClass = FCRCloudDiskWidget::class.java, widgetId = AgoraWidgetDefaultId.AgoraCloudDisk.id,
            extraInfo = cloudDiskExtra)
    )
    // 把 widgetConfigs 复制到 SDK 的启动参数中。调用 launch 之后灵动课堂会把 widgetConfigs 传递给内部完成注册。
    launchConfig.widgetConfigs = widgetConfigs
}
...
```

<div class="alert info">完整代码可在 <a href="https://github.com/AgoraIO-Community/CloudClass-Android">CloudClass-Android</a> 仓库 <code>/app/src/main/java/io/agora/education/MainActivity.kt</code> 文件中查看。</div>

### 实例化并初始化 widget：

```kotlin
...
// 通过 widgetContext.addWidgetActiveObserver 添加一个 AgoraWidgetActiveObserver 来监听 Widget 的激活和注销
private val widgetActiveObserver = object : AgoraWidgetActiveObserver {
    override fun onWidgetActive(widgetId: String) {
        createWidget(widgetId)
    }

    override fun onWidgetInActive(widgetId: String) {
        destroyWidget(widgetId)
    }
}
...
private fun createWidget(widgetId: String) {
    if (teachAidWidgets.contains(widgetId)) {
        AgoraLog?.w("$tag->'$widgetId' is already created, can not repeat create!")
        return
    }
    AgoraLog?.w("$tag->create teachAid that of '$widgetId'")
    // 此处通过 widgetId 搜索之前注册过的 widgetConfigs
    val widgetConfig = eduContext?.widgetContext()?.getWidgetConfig(widgetId)
    widgetConfig?.let { config ->
        // 从 widgetConfig 中取出 widgetClass 并通过反射实例化一个 Widget 对象实例
        val widget = eduContext?.widgetContext()?.create(config)
        widget?.let {
            AgoraLog?.w("$tag->successfully created '$widgetId'")
            when (widgetId) {
                CountDown.id -> {
                    (it as? AgoraCountDownWidget)?.getWidgetMsgObserver()?.let { observer ->
                        eduContext?.widgetContext()?.addWidgetMessageObserver(observer, widgetId)
                    }
                }
                Selector.id -> {
                    (it as? AgoraIClickerWidget)?.getWidgetMsgObserver()?.let { observer ->
                        eduContext?.widgetContext()?.addWidgetMessageObserver(observer, widgetId)
                    }
                }
                Polling.id -> {
                    (it as? AgoraVoteWidget)?.getWidgetMsgObserver()?.let { observer ->
                        eduContext?.widgetContext()?.addWidgetMessageObserver(observer, widgetId)
                    }
                }
            }
            // 记录 widget
            teachAidWidgets[widgetId] = widget
            // 创建 widgetContainer 并与根 Container 绑定
            val widgetContainer = managerWidgetsContainer(allWidgetsContainer = binding.root, widgetId = widgetId)
            AgoraLog?.i("$tag->successfully created '$widgetId' container")
            widgetContainer?.let { group ->
                AgoraLog?.w("$tag->initialize '$widgetId'")
                // 初始化 Widge
                widget.init(group)
            }
        }
    }
}
...
private fun destroyWidget(widgetId: String) {
    // remove from map
    val widget = teachAidWidgets.remove(widgetId)
    // remove UIDataProviderListener
    when (widgetId) {
        CountDown.id -> {
            (widget as? AgoraTeachAidCountDownWidget)?.getWidgetMsgObserver()?.let { observer ->
                eduContext?.widgetContext()?.removeWidgetMessageObserver(observer, widgetId)
            }
        }
        Selector.id -> {
            (widget as? AgoraTeachAidIClickerWidget)?.getWidgetMsgObserver()?.let { observer ->
                eduContext?.widgetContext()?.removeWidgetMessageObserver(observer, widgetId)
            }
        }
        Polling.id -> {
            (widget as? AgoraTeachAidVoteWidget)?.getWidgetMsgObserver()?.let { observer ->
                eduContext?.widgetContext()?.removeWidgetMessageObserver(observer, widgetId)
            }
        }
        AgoraCloudDisk.id -> {
            (widget as? AgoraTeachAidVoteWidget)?.getWidgetMsgObserver()?.let { observer ->
                eduContext?.widgetContext()?.removeWidgetMessageObserver(observer, widgetId)
            }
        }
    }
    widget?.let {
        handler.post { it.release() }
        it.container?.let { group ->
            managerWidgetsContainer(binding.root, widgetId, group)
        }
    }
}
```

<div class="alert info">完整代码可在 <a href="https://github.com/AgoraIO-Community/CloudClass-Android">CloudClass-Android</a> 仓库 <code>/AgoraEduUIKit/src/main/java/com/agora/edu/component/teachaids/component/AgoraEduTeachAidContainerComponent.kt</code> 文件中查看。</div>

## API 参考

### AgoraBaseWidget 类

```kotlin
// Widget 基础类
abstract class AgoraBaseWidget {
    // 当前 Widget 的父布局
    var container: ViewGroup? = null

    // 当前 Widget 的相关信息
    var widgetInfo: AgoraWidgetInfo? = null

    /**
     * 初始化当前 Widget
     * @param container 当前 Widget 的父布局
     */
    open fun init(container: ViewGroup) {
        this.container = container
    }

    /**
     * 向远端同步当前 Widget 的位置和大小比例信息
     * @param frame 当前 Widget 的位置和大小比例信息
     * @param contextCallback 同步操作的回调监听
     */
    protected fun updateSyncFrame(frame: AgoraWidgetFrame, contextCallback: EduContextCallback<Unit>? = null) {
        ......
    }

    /**
     * @param properties 需要被更新的 Widget 内自定义房间属性的Map。需要传全路径："a.b.c.d": value
     * @param cause 自定义的更新原因
     * @param contextCallback 更新操作的回调监听
     */
    protected fun updateRoomProperties(
            properties: MutableMap<String, Any>,
            cause: MutableMap<String, Any>,
            contextCallback: EduContextCallback<Unit>? = null
    ) {
        ......
    }

    /**
     * @param keys 需要被删除的 Widget 内自定义用户属性的 key 值集合。需要传全路径：a.b.c.d
     * @param cause 自定义的删除原因
     * @param contextCallback 删除操作的回调监听
     */
    protected fun deleteRoomProperties(
            keys: MutableList<String>,
            cause: MutableMap<String, Any>,
            contextCallback: EduContextCallback<Unit>? = null
    ) {
        ......
    }

    /**
     * @param properties 需要被更新的 Widget 内自定义用户属性的 Map。需要传全路径："a.b.c.d": value
     * @param cause 自定义的更新原因
     * @param contextCallback 更新操作的回调监听
     */
    protected fun updateUserProperties(
        properties: MutableMap<String, Any>,
        cause: MutableMap<String, Any>,
        contextCallback: EduContextCallback<Unit>? = null
    ) {
        ......
    }

    /**
     * @param keys 需要被删除的 Widget 内自定义用户属性的 key 值集合。需要传全路径：a.b.c.d
     * @param cause 自定义的删除原因
     * @param contextCallback 删除操作的回调监听
     */
    protected fun deleteUserProperties(
        keys: MutableList<String>,
        cause: MutableMap<String, Any>,
        contextCallback: EduContextCallback<Unit>? = null
    ) {
        ......
    }

    /**
     * Widget 内部向外部发送消息
     */
    protected fun sendMessage(message: String) {
        ......
    }

    /**
     * Widget 的位置和大小发生改变
     * @params frame Widget 的位置和大小的比例信息
     */
    open fun onSyncFrameUpdated(frame: AgoraWidgetFrame) {
    }

    /**
     * 接收来自 Widget 外部的消息。消息来自于 widgetContext 中的 sendMessageToWidget
     */
    open fun onMessageReceived(message: String) {
    }

    /**
     * 本地用户信息发生更新的回调
     */
    open fun onLocalUserInfoUpdated(info: AgoraWidgetUserInfo) {
        widgetInfo?.let {
            ......
        }
    }

    /**
     * 房间信息发生更新的回调
     */
    open fun onRoomInfoUpdated(info: AgoraWidgetRoomInfo) {
        widgetInfo?.let {
            ......
        }
    }

    /**
     * Widget 内的自定义房间属性被更新的回调
     */
    open fun onWidgetRoomPropertiesUpdated(properties: MutableMap<String, Any>, cause: MutableMap<String, Any>?,
                                           keys: MutableList<String>) {
        ......
    }

    /**
     * Widget 内的自定义房间属性被删除的回调
     */
    open fun onWidgetRoomPropertiesDeleted(properties: MutableMap<String, Any>, cause: MutableMap<String, Any>?,
                                           keys: MutableList<String>) {
        ......
    }

    /**
     * Widget 内的自定义本地用户属性被更新的回调
     */
    open fun onWidgetUserPropertiesUpdated(properties: MutableMap<String, Any>,
                                           cause: MutableMap<String, Any>?,
                                           keys: MutableList<String>) {
        ......
    }

    /**
     * Widget 内的自定义本地用户属性被删除的回调
     */
    open fun onWidgetUserPropertiesDeleted(properties: MutableMap<String, Any>,
                                           cause: MutableMap<String, Any>?,
                                           keys: MutableList<String>) {
        ......
    }

    // 释放资源
    open fun release() {
        ......
    }
}
```

### AgoraWidgetContext 类

```kotlin
// WidgetContext 能力接口
interface AgoraWidgetContext {
    /**
     * 创建一个 Widget 对象实例
     * @param config 此 Widget 对象的配置信息
     * @return Widget 实例，为空说明创建失败
     */
    fun create(config: AgoraWidgetConfig): AgoraBaseWidget?

    /**
     * 获取 Widget 当前的位置和大小比例信息
     * @param widgetId Widget 的唯一标识符
     * @return widget 当前的位置和大小比例信息。比例的基准需要开发者自己多端统一。
     */
    fun getWidgetSyncFrame(widgetId: String): AgoraWidgetFrame?

    /**
     * 获取所有已注册的 Widget 的配置信息
     */
    fun getWidgetConfigs(): MutableList<AgoraWidgetConfig>

    /**
     * 获取某一个已注册的 Widget 的配置信息
     * @param widgetId Widget的唯一标识符
     */
    fun getWidgetConfig(widgetId: String): AgoraWidgetConfig?

    /**
     * 激活某一个 Widget。
     * 操作成功后，你将会收到 AgoraWidgetActiveObserver.onWidgetActive 的回调
     * @param widgetId Widget 的唯一标识符
     * @param ownerUserUuid 当前被激活的 Widget 所属用户的 userUuid
     * @param roomProperties 初始化的房间属性
     * @param callback 激活操作的回调监听
     */
    fun setWidgetActive(widgetId: String, ownerUserUuid: String? = null,
                        roomProperties: Map<String, Any>? = null,
                        callback: EduContextCallback<Unit>? = null)

    /**
     * 注销指定 Widget
     * @param widgetId Widget 的唯一标识符
     * @param isRemove 是否彻底删除此 Widget 在当前教室内的所有信息：
     * - true: 彻底删除。roomProperties.widgets.'widgetId' 和 userProperties.widgets.'widgetId' 下的所有信息都会被删除
     * - false: 仅设置 roomProperties.widgets.'widgetId'.state 为 '0'，即设置当前 Widget 为不活跃状态。不管此值传什么，都会收到 AgoraWidgetActiveObserver.onWidgetInActive 的回调。
     * @param callback 注销操作的回调监听
     */
    fun setWidgetInActive(widgetId: String, isRemove: Boolean = false, callback: EduContextCallback<Unit>? = null)

    /**
     * 获取某一个 Widget 的激活状态
     * @param widgetId Widget 的唯一标识符
     */
    fun getWidgetActive(widgetId: String): Boolean

    /**
     * 获取所有已注册的 Widget 的激活状态
     * @param widgetId Widget 的唯一标识符
     */
    fun getAllWidgetActive(): Map<String, Boolean>

    /**
     * 添加一个 AgoraWidgetActiveObserver 监听器，监听此 Widget 是否活跃
     */
    fun addWidgetActiveObserver(observer: AgoraWidgetActiveObserver, widgetId: String)

    /**
     * 删除一个 AgoraWidgetActiveObserver 监听器
     */
    fun removeWidgetActiveObserver(observer: AgoraWidgetActiveObserver, widgetId: String)

    /**
     * 添加一个 AgoraWidgetMessageObserver 监听器，监听此 Widget 发出的所有消息
     */
    fun addWidgetMessageObserver(observer: AgoraWidgetMessageObserver, widgetId: String)

    /**
     * 删除一个 AgoraWidgetMessageObserver 监听器
     */
    fun removeWidgetMessageObserver(observer: AgoraWidgetMessageObserver, widgetId: String)

    /**
     * 向某一个 Widget 内部发送消息
     */
    fun sendMessageToWidget(msg: String, widgetId: String)
}
```

### 类型定义

```kotlin
// Widget 配置类
data class AgoraWidgetConfig(
    // 此 WidgetId 对应的自定义 Widget 类
    var widgetClass: Class<out AgoraBaseWidget>,
    // 当前 Widget 的唯一标识符
    var widgetId: String,
    // 未选中(默认或未激活)状态下的 icon
    val image: Int? = null,
    // 选中或激活状态下的 icon
    val selectedImage: Int? = null,
    // 自定义数据，Widget 实例化后被传递给 AgoraWidgetInfo.extraInfo
    var extraInfo: Any? = null
)

// Widget 信息类
data class AgoraWidgetInfo(
    var roomInfo: AgoraWidgetRoomInfo,
    var localUserInfo: AgoraWidgetUserInfo,
    // 当前 Widget 的唯一标识符
    val widgetId: String,
    // 外部传入的自定义数据
    val extraInfo: Any?,
    // 当前 Widget 内的自定义房间属性
    var roomProperties: MutableMap<String, Any>?,
    // 当前 Widget 内的自定义本地用户属性
    var localUserProperties: MutableMap<String, Any>?
)


// Widget 的位置和大小比例信息类
data class AgoraWidgetFrame(
    val x: Float? = null,
    val y: Float? = null,
    val width: Float? = null,
    val height: Float? = null
)

// Widget 内的用户信息类
data class AgoraWidgetUserInfo(
        val userUuid: String,
        val userName: String,
        val userRole: Int
)

// Widget 内的房间信息类
data class AgoraWidgetRoomInfo(
        val roomUuid: String,
        val roomName: String,
        val roomType: Int
)
```
