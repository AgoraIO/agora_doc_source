## 概览

Agora Classroom SDK 通过 Edu Context 为 App 开发者提供实现灵动课堂业务功能的能力。

不同的 Context 代表灵动课堂中不同的业务功能模块，每个 Context 既包含供 App 调用的方法，也会向 App 报告事件回调。

Agora Classroom SDK 提供以下 Context：

- Whiteboard Context：白板。
- Chat Context：消息聊天。
- Room Context：课堂管理。
- Hands-up Context：举手上台。
- Screenshare Context：屏幕共享。
- User List Context：用户列表。
- Video Context：媒体控制。

## EduContextPool

灵动课堂功能能力池。你可以通过这个对象使用目前灵动课堂提供的各种业务功能。

```kotlin
interface EduContextPool {
    // 聊天功能
    fun chatContext(): ChatContext?
 
    // 举手上台
    fun handsUpContext(): HandsUpContext?
 
    // 课堂管理
    fun roomContext(): RoomContext?
 
    // 屏幕共享
    fun screenShareContext(): ScreenShareContext?
 
    // 用户列表
    fun userContext(): UserContext?
 
    // 媒体控制，主要控制一对一中的老师和学生的音视频，以及小班课、大班课中老师的音视频
    fun videoContext(): VideoContext?
 
    // 白板，包含 toolBar 和 pageControl
    fun whiteboardContext(): WhiteboardContext?
 
    // 私密语音：目前只支持个人对个人
    fun privateChatContext(): PrivateChatContext?
 
    // 扩展容器：该应用容器提供了生命周期、扩展
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