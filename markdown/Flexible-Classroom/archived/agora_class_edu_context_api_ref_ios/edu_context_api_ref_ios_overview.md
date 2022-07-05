## 概览

Agora Classroom SDK 通过 Edu Context 为 App 开发者提供实现灵动课堂业务功能的能力。

不同的 Context 代表灵动课堂中不同的业务功能模块，每个 Context 既包含供 App 调用的方法，也会向 App 报告事件回调。

Agora 提供以下 Context：

-   [Chat Context](/cn/agora-class/edu_context_api_ref_ios_chat?platform=iOS): 消息聊天。
-   [Device Context](/cn/agora-class/edu_context_api_ref_ios_device?platform=iOS): 课中音视频设备控制。
-   [Hands-up Context](/cn/agora-class/edu_context_api_ref_ios_handsup?platform=iOS): 举手上台。
-   [Media Context](/cn/agora-class/edu_context_api_ref_ios_media?platform=iOS): 课前本地预览。
-   [Room Context](/cn/agora-class/edu_context_api_ref_ios_room?platform=iOS): 教室管理。
-   [Screen Sharing Context](/cn/agora-class/edu_context_api_ref_ios_screensharing?platform=iOS): 屏幕共享。
-   [User Context](/cn/agora-class/edu_context_api_ref_ios_userlist?platform=iOS): 用户列表。
-   [Whiteboard Context](/cn/agora-class/edu_context_api_ref_ios_whiteboard?platform=iOS): 白板，包含白板基础工具和页面控制工具。

## AgoraEduContextPool

灵动课堂能力池。你可以通过这个对象使用和监听目前灵动课堂提供的各种业务能力。

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
