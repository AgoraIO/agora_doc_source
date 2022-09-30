子区是群组成员的子集，是支持多人沟通的即时通讯系统，子区让用户能够在群组中的特定消息上创建单独的会话，以保持主聊天界面整洁。

下图展示了如何创建子区、子区中的会话以及可以在子区中执行的操作：

![img](https://web-cdn.agora.io/docs-files/1655176932917)

本文介绍如何使用即时通讯 IM Unity SDK 在实时互动 app 中创建和管理子区，并实现子区相关功能。

## 技术原理

即时通讯 IM Unity SDK 提供 `ChatThreadManager`, `ChatThread`, `ChatThreadEventHandler` 和 `ChatThreadEvent` 类用于子区管理，可以实现以下功能：

- 创建、解散子区
- 加入、退出子区
- 子区踢人
- 修改子区名称
- 获取子区详情
- 获取子区成员列表
- 获取子区列表
- 批量获取子区中的最新消息
- 监听子区事件

## 前提条件

开始前，请确保满足以下条件：

- 完成 `1.0.5 或 以上版本` SDK 初始化，详见 [快速开始](./agora_chat_get_started_unity)。
- 了解 [使用限制](./agora_chat_limitation)。
## 实现方法

本节介绍如何使用即时通讯 IM Unity SDK 提供的 API 实现上述功能。

### 创建子区

所有群成员均可以调用 `CreateThread` 方法，基于一条群组消息新建子区。

单设备登录时，子区所属群组的所有成员均会收到 `IChatThreadManagerDelegate#OnCreateThread` 回调；多设备登录时，其他设备会同时收到 `IMultiDeviceDelegate#onThreadMultiDevicesEvent` 回调，回调事件为 `THREAD_CREATE`。

示例代码如下：

```c#
SDKClient.Instance.ThreadManager.CreateThread(threadName, msgId, groupid, new ValueCallBack<ChatThread>(
    onSuccess: (thread) =>
    {
        DebugLog($"CreateThread success");
        if (null != thread)
        {
            //处理返回的子区对象
        }
    },
    onError: (code, desc) =>
    {
        Debug.Log($"CreateThread failed, code:{code}, desc:{desc}");
    }
));
```

### 解散子区

仅子区所在群组的群主和群管理员可以调用 `DestroyThread` 方法解散子区。

单设备登录时，子区所属群组的所有成员均会收到 `IChatThreadManagerDelegate#onThreadNotifyChange` 回调；多设备登录时，其他设备会同时收到 `IMultiDeviceDelegate#onThreadMultiDevicesEvent` 回调，回调事件为 `THREAD_DESTROY`。

解散子区或解散子区所在的群组后，将删除本地数据库及内存中关于该子区的全部数据，需谨慎操作。

示例代码如下：

```c#
SDKClient.Instance.ThreadManager.DestroyThread(tid, new CallBack(
    onSuccess: () =>
    {
        Debug.Log($"DestroyThread success");
    },
    onError: (code, desc) =>
    {
        Debug.Log($"DestroyThread failed, code:{code}, desc:{desc}");
    }
));
```

### 加入子区

子区所在群组的所有成员均可以调用 `JoinThread` 方法加入群组。

加入子区的具体步骤如下：

1. 收到 `IChatThreadManagerDelegate#OnCreateThread` 回调或 `IChatThreadManagerDelegate#onThreadNotifyChange` 回调，或调用 `FetchThreadListOfGroup` 方法从服务器获取指定群组的子区列表，从中获取到想要加入的子区 ID。
2. 调用 `JoinThread` 传入子区 ID 加入对应子区。

多设备登录时，其他设备会同时收到 `IMultiDeviceDelegate#onThreadMultiDevicesEvent` 回调，回调事件为 `THREAD_JOIN`。

示例代码如下：

```c#
SDKClient.Instance.ThreadManager.JoinThread(tid, new ValueCallBack<ChatThread>(
    onSuccess: (thread) =>
    {
        Debug.Log($"JoinThread success");
        if (null != thread)
        {
           //处理返回 thread 对象
        }
    },
    onError: (code, desc) =>
    {
        Debug.Log($"JoinThread failed, code:{code}, desc:{desc}");
    }
));
```

### 退出子区

子区成员均可以主动调用 `LeaveThread` 方法退出子区，退出子区后，该成员将不会再收到子区消息。

多设备登录时，其他设备会同时收到 `IMultiDeviceDelegate#onThreadMultiDevicesEvent` 回调，回调事件为 `THREAD_LEAVE`。

示例代码如下：

```C#
SDKClient.Instance.ThreadManager.LeaveThread(tid, new CallBack(
    onSuccess: () =>
    {
        Debug.Log($"LeaveThread success");
    },
    onError: (code, desc) =>
    {
        Debug.Log($"LeaveThread failed, code:{code}, desc:{desc}");
    }
));
```

### 从子区移出成员

仅群主和群管理员可以调用 `RemoveThreadMember` 方法将指定成员 (群管理员或普通成员) 踢出子区，被踢出子区的成员将不再接收到子区消息。

被踢出子区的成员会收到 `IChatThreadManagerDelegate#OnUserKickOutOfChatThread` 回调。多设备登录时，执行踢人操作的成员的其他设备会同时收到 `IMultiDeviceDelegate#onThreadMultiDevicesEvent` 回调，回调事件为 `THREAD_KICK`。

示例代码如下：

```c#
SDKClient.Instance.ThreadManager.RemoveThreadMember(tid, uname, new CallBack(
    onSuccess: () =>
    {
        Debug.Log($"RemoveThreadMember success");
    },
    onError: (code, desc) =>
    {
        Debug.Log($"RemoveThreadMember failed, code:{code}, desc:{desc}");
    }
));
```

### 修改子区名称

仅群主和群管理员以及子区的创建者可以调用 `ChangeThreadSubject` 方法修改子区名称。

单设备登录时，子区所属群组的所有成员会收到 `IChatThreadManagerDelegate#OnChatThreadUpdate` 回调；多设备登录时，其他设备会同时收到 `IMultiDeviceDelegate#onThreadMultiDevicesEvent` 回调，回调事件为 `THREAD_UPDATE`。

示例代码如下：

```c#
SDKClient.Instance.ThreadManager.ChangeThreadSubject(tid, subject, new CallBack(
    onSuccess: () =>
    {
        Debug.Log($"ChangeThreadSubject success");
    },
    onError: (code, desc) =>
    {
        Debug.Log($"ChangeThreadSubject failed, code:{code}, desc:{desc}");
    }
));
```

### 获取子区详情

子区所属群组的所有成员均可以调用 `GetThreadDetail` 方法从服务器获取子区详情。

示例代码如下：

```c#
SDKClient.Instance.ThreadManager.GetThreadDetail(tid, new ValueCallBack<ChatThread>(
        onSuccess: (thread) =>
        {
            Debug.Log($"GetThreadDetail success");
            if (null != thread)
            {
            //添加子区处理
            }
        },
        onError: (code, desc) =>
        {
            Debug.Log($"GetThreadDetail failed, code:{code}, desc:{desc}");
        }
    ));
```

### 获取子区成员列表

子区所属群组的所有成员均可以调用 `FetchThreadMembers` 方法从服务器分页获取子区成员列表。

```c#
SDKClient.Instance.ThreadManager.FetchThreadMembers(tid, cursor, page_size, new ValueCallBack<CursorResult<string>>(
    onSuccess: (cursor_result) =>
    {
        Debug.Log($"FetchThreadMembers success");
        if(null != cursor_result)
        {
            //处理返回的结果
        }
    },
    onError: (code, desc) =>
    {
        Debug.Log($"FetchThreadMembers failed, code:{code}, desc:{desc}");
    }
));
```

### 获取子区列表

1. 用户可以调用 `FetchMineJoinedThreadList` 方法从服务器分页获取自己加入和创建的子区列表：

```c#
 SDKClient.Instance.ThreadManager.FetchMineJoinedThreadList(cursor, page_size, new ValueCallBack<CursorResult<ChatThread>>(
    onSuccess: (cursor_result) =>
    {
        Debug.Log($"FetchMineJoinedThreadList success");
        if (null != cursor_result)
        {
            //处理返回的子区列表cursor_result.Data
        }
    },
    onError: (code, desc) =>
    {
        Debug.Log($"FetchMineJoinedThreadList failed, code:{code}, desc:{desc}");
    }
));
```

2. 用户还可以调用 `FetchThreadListOfGroup` 方法从服务器分页获取指定群组的子区列表：

```c#
SDKClient.Instance.ThreadManager.FetchThreadListOfGroup(tid, joined, cursor, page_size, new ValueCallBack<CursorResult<ChatThread>>(
    onSuccess: (cursor_result) =>
    {
        Debug.Log($"FetchThreadListOfGroup success");
        if (null != cursor_result)
        {
            //处理返回的子区列表 cursor_result.Data
        }
    },
    onError: (code, desc) =>
    {
        Debug.Log($"FetchThreadListOfGroup failed, code:{code}, desc:{desc}");
    }
));
```

### 批量获取子区中的最新一条消息

用户可以调用 `GetLastMessageAccordingThreads` 方法从服务器批量获取子区中的最新一条消息。

示例代码如下：

```c#
SDKClient.Instance.ThreadManager.GetLastMessageAccordingThreads(threadIds, new ValueCallBack<Dictionary<string, Message>>(
    onSuccess: (dict) =>
    {
        Debug.Log($"GetLastMessageAccordingThreads success");
        foreach (var it in dict)
        {
            //遍历字典，依次处理里面的每一个最新消息
        }
    },
    onError: (code, desc) =>
    {
        Debug.Log($"GetLastMessageAccordingThreads failed, code:{code}, desc:{desc}");
    }
));
```

### 监听子区事件

`IChatThreadManagerDelegate` 类中提供子区事件的监听接口。开发者可以通过设置此监听，获取子区中的事件，并做出相应处理。如果不再使用该监听，需要移除，防止出现内存泄漏。

示例代码如下：

```c#
class ThreadManagerDelegate : IChatThreadManagerDelegate
{
    public void OnChatThreadCreate(ChatThreadEvent threadEvent)
    {
    }
    public void OnChatThreadUpdate(ChatThreadEvent threadEvent)
    {
    }
    public void OnChatThreadDestroy(ChatThreadEvent threadEvent)
    {
    }
    public void OnUserKickOutOfChatThread(ChatThreadEvent threadEvent)
    {
    }
}
// 注册监听
IChatThreadManagerDelegate threadManagerDelegate = new ThreadManagerDelegate();
SDKClient.Instance.ThreadManager.AddThreadManagerDelegate(threadManagerDelegate);

// 移除监听
SDKClient.Instance.ThreadManager.RemoveThreadManagerDelegate(threadManagerDelegate);
```