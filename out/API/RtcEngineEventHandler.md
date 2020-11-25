# IRtcEngineEventHandler {#rtcevent}

IRtcEngineEventHandler 接口类用于SDK向 App 发送回调事件通知，App 通过继承该接口类的方法获取 SDK 的事件通知。

接口类的所有方法都有缺省（空）实现， app 可以根据需要只继承关心的事件。在回调方法中，app 不应该做耗时或者调用可能会引起阻塞的 API（如 SendMessage），否则可能影响 SDK 的运行。

## onClientRoleChanged {#onclientrolechanged}

```java
public void onClientRoleChanged(int oldRole, int newRole);
```

直播场景下用户角色已切换回调。如从观众切换为主播，反之亦然。

该回调由本地用户在加入频道后调用 setClientRole 改变用户角色触发的。

## onUserJoined {#onuserjoined}

远端用户（通信场景）/主播（直播场景）加入当前频道回调。

-   通信场景下，该回调提示有远端用户加入了频道，并返回新加入用户的 ID；如果加入之前，已经有其他用户在频道中了，新加入的用户也会收到这些已有用户加入频道的回调。

-   直播场景下，该回调提示有主播加入了频道，并返回该主播的用户 ID。如果在加入之前，已经有主播在频道中了，新加入的用户也会收到已有主播加入频道的回调。Agora 建议连麦主播不超过 17 人。


该回调在如下情况下会被触发：

-   远端用户/主播调用 joinChannel 方法加入频道。

-   远端用户加入频道后调用 setClientRole 将用户角色改变为主播。

-   远端用户/主播网络中断后重新加入频道。

-   主播通过调用 addInjectStreamUrl 方法成功输入在线媒体流。


