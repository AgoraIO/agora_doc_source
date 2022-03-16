## Overview

Agora Edu Context enables developers to implement the functions in the Flexible Classroom.

![](https://web-cdn.agora.io/docs-files/1619696813295)

Different contexts represent different function modules in the Flexible Classroom. Each context contains methods for the app to call and also reports event callbacks to the app.

Agora provides the following contexts:

- [Chat Context](/en/agora-class/edu_context_api_ref_android_chat?platform=Android): Chat.
- [Device Context](/en/agora-class/edu_context_api_ref_android_device?platform=Android): Audio and video device control during a class.
- [Extension App Context](): Extension applications.
- [Hands-up Context](/en/agora-class/edu_context_api_ref_android_handsup?platform=Android): Hand raising.
- [Media Context](): Local preview before a class.

- [Room Context](/en/agora-class/edu_context_api_ref_android_room?platform=Android): Classroom management.
- [Screen Sharing Context](en/agora-class/edu_context_api_ref_android_screensharing?platform=Android): Screen sharing.
- [User Context](/en/agora-class/edu_context_api_ref_android_userlist?platform=Android): User list.
- [Video Context](/en/agora-class/edu_context_api_ref_android_video?platform=Android): In-class media control, mainly for controlling the audio and video of the teacher and student in the One-to-one Classrooms scenario and the audio and video of the teacher in the Small Classroom and Lecture Hall scenarios.
- [Whiteboard Context](/en/agora-class/edu_context_api_ref_android_whiteboard?platform=Android): Whiteboard, including the whiteboard basic editing tools and page controller.

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
