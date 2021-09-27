## Overview

Agora Edu Context enables developers to implement the functions in the Flexible Classroom.

![](
![](https://web-cdn.agora.io/docs-files/1619168684154))

Different contexts represent different function modules in the Flexible Classroom. Each context contains methods for the app to call and also reports event callbacks to the app.

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

The edu context pool interface. Use this interface to implement all the functions provided by the Agora Classroom SDK.

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

The handler pool interface. Use this interface to implement all the callbacks provided by the Agora Classroom SDK.

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
