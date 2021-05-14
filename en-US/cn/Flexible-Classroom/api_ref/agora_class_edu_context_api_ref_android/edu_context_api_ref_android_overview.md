## Overview

Agora Edu Context enables developers to implement the functions in the Flexible Classroom.

Different contexts represent different function modules in the Flexible Classroom. Each context contains methods for the app to call and also reports event callbacks to the app.

The Agora Classroom SDK provides the following contexts:

- Whiteboard Context: Whiteboard.
- Chat Context: Chat.
- Room Context: Classroom management.
- Hands-up Context: Hand raising.
- Screenshare Context: Screen sharing.
- User List Context: User list.
- Video Context: Media control.

## EduContextPool

The edu context pool interface. Use this interface to implement all the functions provided by the Agora Classroom SDK.

```kotlin
interface EduContextPool {
    // Chat
    fun chatContext (): ChatContext?
 
    // Hand raising
    fun handsUpContext (): HandsUpContext?
 
    // Classroom management
    fun roomContext(): RoomContext?
 
    // Screen sharing
    fun screenShareContext(): ScreenShareContext?
 
    // User list
    fun userContext(): UserContext?
 
    // Media control, mainly for the audio and video control of teachers and students in the one-to-one classroom and the audio and video control of teachers in the small classroom and lecture halls
    fun videoContext(): VideoContext?
 
    // Whiteboard, including the whiteboard basic editing tools and page controller.
    fun whiteboardContext(): WhiteboardContext?
 
    // Private audio call.
    fun privateChatContext(): PrivateChatContext?
 
    // Extension application.
    fun extAppContext(): ExtAppContext?
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
