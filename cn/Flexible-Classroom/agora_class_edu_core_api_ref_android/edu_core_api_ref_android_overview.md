## 概览



## EduContextPool

灵动课堂功能能力池。你可以通过这个对象使用目前灵动课堂提供的各种业务功能

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
 
    // 音视频，主要控制一对一中的老师和学生的音视频，以及小班课、大班课中老师的音视频
    fun videoContext(): VideoContext?
 
    // 白板通用控制，包含 toolBar 和 pageControl
    fun whiteboardContext(): WhiteboardContext?
 
    // 私密语音：目前只支持个人对个人
    fun privateChatContext(): PrivateChatContext?
 
    // 扩展容器：该应用容器提供了生命周期、扩展
    fun extAppContext(): ExtAppContext?
}
```



## IHandlerPool

灵动课堂回调能力池。你可以通过这个对象监听目前灵动课堂提供的各种回调能力。

```
interface IHandlerPool<T> {
    // 注册对应 Context 的回调监听
    fun addHandler(handler: T?)
     
    // 移除对应 Context 的回调监听
    fun removeHandler(handler: T?)
 
    // 获取对应 Context 的所有回调监听
    fun getHandlers(): List<T>?
}
```

