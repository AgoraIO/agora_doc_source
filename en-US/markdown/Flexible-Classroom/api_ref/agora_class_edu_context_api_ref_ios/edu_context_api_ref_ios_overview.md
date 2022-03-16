## Overview

Agora Edu Context enables developers to implement the functions in the Flexible Classroom.

Different contexts represent different function modules in the Flexible Classroom. Each context contains methods for the app to call and also reports event callbacks to the app.

Agora provides the following contexts:

- [Chat Context](/en/agora-class/edu_context_api_ref_ios_chat?platform=iOS): Chat.
- [Device Context](/en/agora-class/edu_context_api_ref_ios_device?platform=iOS): Audio and video device control during a class.
- [Hands-up Context](/en/agora-class/edu_context_api_ref_ios_handsup?platform=iOS): Hand raising.
- [Media Context](/en/agora-class/edu_context_api_ref_ios_media?platform=iOS): Local preview before a class.
- [Room Context](en/agora-class/edu_context_api_ref_ios_room?platform=iOS): Classroom management.
- [Screen Sharing Context](/en/agora-class/edu_context_api_ref_ios_screensharing?platform=iOS): Screen sharing.
- [User Context](/en/agora-class/edu_context_api_ref_ios_userlist?platform=iOS): User list.
- [Whiteboard Context](/en/agora-class/edu_context_api_ref_ios_whiteboard?platform=iOS): Whiteboard, including the whiteboard basic editing tools and page controller.

## AgoraEduContextPool

The edu context pool interface. Use this interface to implement all the functions provided by the Agora Classroom SDK.

```swift
public protocol AgoraEduContextPool {
    // 白板通用控制，包含下载
    var whiteBoard: AgoraEduWhiteBoardContext { get }
    // 白板基础工具
    var whiteBoardTool: AgoraEduWhiteBoardToolContext { get }
    // 白板页面控制工具
    var whiteBoardPageControl: AgoraEduWhiteBoardPageControlContext { get }
    // 课堂管理
    var room: AgoraEduRoomContext { get }
    // 消息聊天
    var chat: AgoraEduMessageContext { get }
    // 用户列表
    var user: AgoraEduUserContext { get }
    // 举手上台
    var handsUp: AgoraEduHandsUpContext { get }
    // 屏幕分享
    var shareScreen: AgoraEduScreenShareContext { get }
    // 扩展应用
    var extApp: AgoraEduExtAppContext { get }
}
```
