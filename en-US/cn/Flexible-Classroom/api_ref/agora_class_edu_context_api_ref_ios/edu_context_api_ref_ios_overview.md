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

## AgoraEduContextPool

 Flexible Classroom ability pool. You can use and monitor various business abilities currently provided by  Flexible Classroom through this object.

```swift
public protocol AgoraEduContextPool {
    // whiteboard general control, including download
    var whiteBoard: AgoraEduWhiteBoardContext { get }
    // whiteboard tools
    var whiteBoardTool: AgoraEduWhiteBoardToolContext { get }
    // whiteboard page control
    var whiteBoardPageControl: AgoraEduWhiteBoardPageControlContext { get }
    // Classroom management
    var room: AgoraEduRoomContext {get
    // Message chat
    var chat: AgoraEduMessageContext { get }
    // user list
    var user: AgoraEduUserContext { get }
    // Raise hands on stage
    var handsUp: AgoraEduHandsUpContext {get}
    // screen sharing
    var shareScreen: AgoraEduScreenShareContext { get }
    // Extended application
    var extApp: AgoraEduExtAppContext {get}
}
```
