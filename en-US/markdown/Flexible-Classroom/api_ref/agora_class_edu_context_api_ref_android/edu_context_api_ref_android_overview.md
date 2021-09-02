## Overview

Agora Edu Context provides methods and callbacks for developers to implement the modular features in Flexible Classroom.

![](https://web-cdn.agora.io/docs-files/1623761240753)

Agora provides the following contexts:

- Whiteboard Context, including:
  - General control over the whiteboard
  - The whiteboard basic editing tools
  - The whiteboard page controller
- Chat Context: Real-time text chat
- Room Context: Classroom management
- Hands-up Context: The feature of students "raise their hands" for permission to speak
- Screenshare Context: Screen sharing
- User List Context: User management
- Video Context: Real-time audio and video interaction

## EduContextPool

The edu context pool interface. Use this interface to implement all the methods provided by the Agora Classroom SDK.

```kotlin
interface EduContextPool {
    fun chatContext (): ChatContext?
 
    fun handsUpContext (): HandsUpContext?
 
    fun roomContext(): RoomContext?
 
    fun screenShareContext(): ScreenShareContext?
 
    fun userContext(): UserContext?
 
    fun videoContext(): VideoContext?
 
    fun whiteboardContext(): WhiteboardContext?
}
```

## IHandlerPool

The handler pool interface. Use this interface to implement all the callbacks provided by the Agora Classroom SDK.

```kotlin
interface IHandlerPool<T> {
    // Register the callback listener for the context
    fun addHandler(handler: T?)
     
    // Remove the callback listener for the context
    fun removeHandler(handler: T?)
 
    // Get all callback listeners of the context
    fun getHandlers(): List<T>?
}
```
