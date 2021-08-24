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

## AgoraEduContextPool

The edu context pool interface. Use this interface to implement all the functions provided by the Agora Classroom SDK.

```swift
public protocol AgoraEduContextPool {
    var whiteBoard: AgoraEduWhiteBoardContext { get }
    var whiteBoardTool: AgoraEduWhiteBoardToolContext { get }
    var whiteBoardPageControl: AgoraEduWhiteBoardPageControlContext { get }
    var room: AgoraEduRoomContext {get
    var chat: AgoraEduMessageContext { get }
    var user: AgoraEduUserContext { get }
    var handsUp: AgoraEduHandsUpContext {get}
    var shareScreen: AgoraEduScreenShareContext { get }
}
```
