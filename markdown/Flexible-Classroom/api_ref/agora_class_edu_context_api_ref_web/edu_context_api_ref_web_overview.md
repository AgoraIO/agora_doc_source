## 概览

Agora Classroom SDK 通过 Edu Context 为 App 开发者提供实现灵动课堂业务功能的能力。

![](https://web-cdn.agora.io/docs-files/1619696813295)

不同的 Context 代表灵动课堂中不同的业务功能模块，每个 Context 既包含供 App 调用的方法，也会向 App 报告事件回调。

Agora Classroom SDK 提供以下 Context：

- `usePretestContext()`：课前检测。
- `useBoardContext()`：白板。
- `useChatContext()` ：消息聊天。
- `useRoomContext()` ：课堂管理。
- `useHandsUpContext`：举手上台。
- `useScreenShareContext()`：屏幕共享。
- `useUserListContext()`：用户列表。
- `useRecordingContext()`：课堂录制。

举例来说，`useRoomContext()` 提供课堂管理相关能力。你可以通过 `import { useRoomContext } from 'agora-edu-core';  ` 引入 `useRoomContext`，然后使用 `const {...} = useRoomContext()` 获取灵动课堂中课堂管理相关能力。假设你需要获取聊天消息列表以及确认本地是否为主播，可以通过 `const { messageList, isHost } = useChatConxt();` 获取这个能力。