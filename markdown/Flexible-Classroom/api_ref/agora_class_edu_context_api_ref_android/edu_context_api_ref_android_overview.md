## 概览

Agora Classroom SDK 通过 Edu Context 为 App 开发者提供实现灵动课堂业务功能的能力。

![](https://web-cdn.agora.io/docs-files/1619696813295)

不同的 Context 代表灵动课堂中不同的业务功能模块，每个 Context 既包含供 App 调用的方法，也会向 App 报告事件回调。

Agora 提供以下 Context：

- [Chat Context](/cn/agora-class/edu_context_api_ref_android_chat?platform=Android): 消息聊天。
- [Device Context](/cn/agora-class/edu_context_api_ref_android_device?platform=Android): 课中音视频设备控制。
- [Extension App Context](): 扩展应用。
- [Hands-up Context](/cn/agora-class/edu_context_api_ref_android_handsup?platform=Android): 举手上台。
- [Media Context](): 课前本地预览。

- [Room Context](/cn/agora-class/edu_context_api_ref_android_room?platform=Android): 教室管理。
- [Screen Sharing Context](/cn/agora-class/edu_context_api_ref_android_screensharing?platform=Android): 屏幕共享。
- [User Context](/cn/agora-class/edu_context_api_ref_android_userlist?platform=Android): 用户列表。
- [Video Context](/cn/agora-class/edu_context_api_ref_android_video?platform=Android): 课中媒体控制，主要用于控制一对一课堂中的老师和学生的音视频以及小班课和大班课中老师的音视频。
- [Whiteboard Context](/cn/agora-class/edu_context_api_ref_android_whiteboard?platform=Android): 白板，包含白板基础工具和页面控制工具。

## EduContextPool

灵动课堂功能能力池。你可以通过这个对象使用目前灵动课堂提供的各种业务功能。

```kotlin
interface EduContextPool {
    fun chatContext(): ChatContext?
    fun handsUpContext(): HandsUpContext?
    fun roomContext(): RoomContext?
    fun screenShareContext(): ScreenShareContext?
    fun userContext(): UserContext?
    fun videoContext(): VideoContext?
    fun whiteboardContext(): WhiteboardContext?
    fun extAppContext(): ExtAppContext?
}
```

## IHandlerPool

灵动课堂回调能力池。你可以通过这个对象监听目前灵动课堂提供的各种回调能力。

```kotlin
interface IHandlerPool<T> {
    // 注册对应 Context 的回调监听
    fun addHandler(handler: T?)
  
    // 移除对应 Context 的回调监听
    fun removeHandler(handler: T?)
 
    // 获取对应 Context 的所有回调监听
    fun getHandlers(): List<T>?
}
```