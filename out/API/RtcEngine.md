# RtcEngine {#engine}

RtcEngine 类包含应用程序调用的主要方法。

## setChannelProfile {#setchannelprofile}

```

public abstract int setChannelProfile(int profile);

```

设置直播场景下的用户角色。

在加入频道前，用户需要通过本方法设置观众（默认）或主播模式。在加入频道后，用户可以通过本方法切换用户模式。

直播场景下，如果你在加入频道后调用该方法切换用户角色，调用成功后，本地会触发 onClientRoleChanged 回调；远端会触发 onUserJoined/onUserOffline\(USER\_OFFLINE\_BECOME\_AUDIENCE\) 回调。

