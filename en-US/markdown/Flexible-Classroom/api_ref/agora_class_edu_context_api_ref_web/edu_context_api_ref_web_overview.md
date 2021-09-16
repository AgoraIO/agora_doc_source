## Overview

Agora Edu Context enables developers to implement the functions in the Flexible Classroom.

![](https://web-cdn.agora.io/docs-files/1619696813295)

Different contexts represent different function modules in the Flexible Classroom. Each context contains methods for the app to call and also reports event callbacks to the app.

The Agora Classroom SDK provides the following contexts:

- `usePretestContext()`: Pre-class test.
- `useBoardContext()`: Whiteboard.
- `useChatContext()`: Chat.
- `useRoomContext()`: Classroom management.
- `useHandsUpContext`: Hand-raising.
- `useScreenShareContext()`: Screen sharing.
- `useUserListContext()`: User list.
- `useRecordingContext()`: Recording.

For example, `useRoomContext()` provides methods and callbacks related to classroom management. You can import `useRoomContext` by `import {useRoomContext} from'agora-edu-core';` and then use `const {...} = useRoomContext()` to implement the functions and events related to classroom management. Suppose you need to get the message list and check whether the local client is the host, you can get this ability through `const {messageList, isHost} = useChatConxt();`