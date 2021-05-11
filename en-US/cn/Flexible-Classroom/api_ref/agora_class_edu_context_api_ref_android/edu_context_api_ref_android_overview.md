## Overview

The Agora Classroom SDK provides App developers with the ability to implement smart classroom business functions through Edu Context.

Different Contexts represent different business function modules in the  Flexible Classroom. Each Context contains methods for the App to call and also reports event callbacks to the App.

The Agora Classroom SDK provides the following Context:

- Whiteboard Context: Whiteboard.
- Chat Context: Message chat.
- Room Context: Classroom management.
- Hands-up Context: Raise your hands on stage.
- Screenshare Context: Screen sharing.
- User List Context: User list.
- Video Context: media control.

## EduContextPool

 Flexible Classroom functional ability pool. You can use this object to use various business functions currently provided by Flexible Classroom Class.

```kotlin
interface EduContextPool {
    // chat function
    fun chatContext (): ChatContext?
 
    // Raise hands on stage
    fun handsUpContext (): HandsUpContext?
 
    // Classroom management
    fun roomContext(): RoomContext?
 
    // screen sharing
    fun screenShareContext(): ScreenShareContext?
 
    // user list
    fun userContext(): UserContext?
 
    // Media control, mainly controlling the audio and video of teachers and students in one-to-one, as well as the audio and video of teachers in small and large classes
    fun videoContext(): VideoContext?
 
    // whiteboard, including toolBar and pageControl
    fun whiteboardContext(): WhiteboardContext?
 
    // Private voice: currently only supports person-to-person
    fun privateChatContext(): PrivateChatContext?
 
    // Expansion container: The application container provides life cycle, expansion
    fun extAppContext(): ExtAppContext?
}
```

## IHandlerPool

 Flexible Classroom callback ability pool. You can monitor various callback capabilities currently provided by  Flexible Classroom through this object.

```kotlin
interface IHandlerPool <T> {
    // Register the callback listener corresponding to the Context
    fun addHandler(handler: T?)
     
    // Remove the callback listener corresponding to the Context
    fun removeHandler(handler: T?)
 
    // Get all callback listeners corresponding to Context
    fun getHandlers(): List<T>?
}
```
