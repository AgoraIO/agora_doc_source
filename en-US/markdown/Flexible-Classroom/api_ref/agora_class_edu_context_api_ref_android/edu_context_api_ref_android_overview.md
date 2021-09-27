## Overview

Agora Edu Context enables developers to implement the functions in the Flexible Classroom.

![](
![](https://web-cdn.agora.io/docs-files/1619168684154))

Different contexts represent different function modules in the Flexible Classroom. Each context contains methods for the app to call and also reports event callbacks to the app.

Agora provides the following Context:

- [Chat Context](/cn/agora-class/edu_context_api_ref_android_chat?platform=Android): Message chat.
- [Device Context](/cn/agora-class/edu_context_api_ref_android_device?platform=Android): Audio and video device control in class.
- [Extension App Context: Extension]() application.
- [Hands-up Context](/cn/agora-class/edu_context_api_ref_android_handsup?platform=Android): Raise your hands on the stage.
- [Media Context](): Local preview before class.

- [Room Context](/cn/agora-class/edu_context_api_ref_android_room?platform=Android: classroom) management.
- [Screen Sharing Context](/cn/agora-class/edu_context_api_ref_android_screensharing?platform=Android: Screen sharing).
- [User Context](/cn/agora-class/edu_context_api_ref_android_userlist?platform=Android: User) list.
- [Video Context](/cn/agora-class/edu_context_api_ref_android_video?platform=Android): In-class media control, mainly used to control the audio and video of teachers and students in one-to-one classrooms and the audio and video of teachers in small and large classes.
- [Whiteboard Context](/cn/agora-class/edu_context_api_ref_android_whiteboard?platform=Android: Whiteboard), including whiteboard basic tools and page control tools.

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
