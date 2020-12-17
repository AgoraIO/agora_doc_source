# [setClientRole]

<p conref="../conref/conref_rtc_api.dita#apidef/setclientrole" />

设置直播场景下的用户角色。

## 调用顺序

- 在加入频道前，用户需要通过本方法设置观众（默认）或主播模式。
- 在加入频道后，用户可以通过本方法切换用户模式。

## 关联回调

如果你在加入频道后调用该方法切换用户角色，调用成功后，本地会触发 [onClientRoleChanged] 回调；远端会触发 [onUserJoined]/[onUserOffline]\(USER_OFFLINE_BECOME_AUDIENCE) 回调。

## 注意事项

该方法仅在直播场景下生效。



## 参数

## 返回值