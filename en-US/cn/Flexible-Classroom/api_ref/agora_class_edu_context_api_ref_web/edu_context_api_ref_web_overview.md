## Overview

The Agora Classroom SDK provides App developers with the ability to implement smart classroom business functions through Edu Context.

![](https://web-cdn.agora.io/docs-files/1619696813295)

Different Contexts represent different business function modules in the  Flexible Classroom. Each Context contains methods for the App to call and also reports event callbacks to the App.

The Agora Classroom SDK provides the following Context:

- `usePretestContext()`: Test before class.
- `useBoardContext(): Whiteboard`.
- `useChatContext()`: Message chat.
- `useRoomContext()`: Classroom management.
- `useHandsUpContext`: Raise your hands on the stage.
- `useScreenShareContext()`: Screen sharing.
- `useUserListContext()`: User list.
- `useRecordingContext()`: Class recording.

For example, `useRoomContext()` provides classroom management related capabilities. You can` import useRoomContext by import {useRoomContext} from'agora-edu-core';```, and then use` const {...} = useRoomContext()` to obtain classroom management related abilities in smart classrooms. Suppose you need to get the chat message list and confirm whether the local host is the host, you can get` this ability through const {messageList, isHost} = useChatConxt();`