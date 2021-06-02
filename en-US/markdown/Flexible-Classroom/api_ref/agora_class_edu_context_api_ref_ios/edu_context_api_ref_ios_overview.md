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

## AgoraEduContextPool

The edu context pool interface. Use this interface to implement all the functions provided by the Agora Classroom SDK.

```swift
public protocol AgoraEduContextPool {
    // General control over the whiteboard
    var whiteBoard: AgoraEduWhiteBoardContext { get }
    // The whiteboard basic editing tools
    var whiteBoardTool: AgoraEduWhiteBoardToolContext { get }
    // The whiteboard page controller
    var whiteBoardPageControl: AgoraEduWhiteBoardPageControlContext { get }
    // Classroom management
    var room: AgoraEduRoomContext {get
    // Chat
    var chat: AgoraEduMessageContext { get }
    // User list
    var user: AgoraEduUserContext { get }
    // Hand raising
    var handsUp: AgoraEduHandsUpContext {get}
    // Screen sharing
    var shareScreen: AgoraEduScreenShareContext { get }
    // Extension application
    var extApp: AgoraEduExtAppContext { get }
}
```
