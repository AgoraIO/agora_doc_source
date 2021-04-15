---
title: 动态秘钥升级说明
platform: NULL
updatedAt: 2021-01-18 07:54:45
---
本文帮助需要从老版 SDK 升级高版本的用户升级到最新的动态秘钥 Token。

2.1.0 版本之前，每一个鉴权服务都需要一个独立的秘钥（key）。比如：

-   `joinChannel` 需要 channel key

-   `setClientRole` 需要 permission key


2.1.0 版本用一个 Token 包括了所有的服务权限信息。Token 参数仅在 `joinChannel `时被传入；需要更新权限时调用 `renewToken` 即可。

## 1. 客户端 API 更新日志

### Android 平台 API 更新对照表

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>v2.0.2</strong></td>
<td><strong>v2.1.0</strong></td>
</tr>
<tr><td>public int joinChannel(String channelKey, String channelName, String optionalInfo, int optionalUid);</td>
<td>public int joinChannel(String token, String channelName, String optionalInfo, int optionalUid);</td>
</tr>
<tr><td>public int setClientRole(int role, String permissionKey)</td>
<td>int setClientRole(int role)</td>
</tr>
<tr><td>public void onRequestChannelKey();</td>
<td>public void onRequestToken();</td>
</tr>
<tr><td>public int renewChannelKey(const char* channelKey)</td>
<td>public int renewtoken( const char* token)</td>
</tr>
</tbody>
</table>



### iOS 平台 API 更新对照表

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>v2.0.2</strong></td>
<td><strong>v2.1.0</strong></td>
</tr>
<tr><td>joinChannelByKey:channelName:info:uid:joinSuccess:</td>
<td>joinChannelByToken:channelId:info:uid:joinSuccess:</td>
</tr>
<tr><td>setClientRole:withKey:</td>
<td>setClientRole:</td>
</tr>
<tr><td>rtcEngineRequestChannelKey:</td>
<td>rtcEngineRequestToken:</td>
</tr>
<tr><td>renewChannelKey:</td>
<td>renewToken:</td>
</tr>
</tbody>
</table>



### macOS 平台 API 更新对照表

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>v2.0.2</strong></td>
<td><strong>v2.1.0</strong></td>
</tr>
<tr><td>joinChannelByKey:channelName:info:uid:joinSuccess:</td>
<td>joinChannelByToken:channelId:info:uid:joinSuccess:</td>
</tr>
<tr><td>setClientRole:withKey:</td>
<td>setClientRole:</td>
</tr>
<tr><td>rtcEngineRequestChannelKey:</td>
<td>rtcEngineRequestToken:</td>
</tr>
<tr><td>renewChannelKey:</td>
<td>renewToken:</td>
</tr>
</tbody>
</table>



### Windows 平台 API 更新对照表

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>v2.0.2</strong></td>
<td><strong>v2.1.0</strong></td>
</tr>
<tr><td>public int joinChannel(const char* channelKey, const char* channel, const char* info, uid_t uid)</td>
<td>public int joinChannel(String token, String channelName, String optionalInfo, int optionalUid);</td>
</tr>
<tr><td>public int setClientRole(CLIENT_ROLE_TYPE role, const char* permissionKey);</td>
<td>int setClientRole(int role)</td>
</tr>
<tr><td>public virtual void onRequestChannelKey();</td>
<td>public void onRequestToken();</td>
</tr>
<tr><td>public int renewChannelKey(const char* channelKey)</td>
<td>public int renewtoken( const char* token)</td>
</tr>
</tbody>
</table>



### Web 平台 API 更新对照表

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>v2.3.1</strong></td>
<td><strong>v2.4.0</strong></td>
</tr>
<tr><td>client.join(channelKey, channel, uid, onSuccess, onFailure)</td>
<td>client.join(token, channel, uid, onSuccess, onFailure)</td>
</tr>
<tr><td>client.renewChannelKey</td>
<td>client.renewToken</td>
</tr>
</tbody>
</table>



## 2. 服务器端 Token 生成字段更新对照表

下表比较了生成 Dynamic Key 所需字段和生成 Token 所需字段：

<table>
<colgroup>
<col/>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Dynamic Key</strong></td>
<td><strong>Token</strong></td>
<td><strong>说明</strong></td>
</tr>
<tr><td>App ID</td>
<td>App ID</td>
<td> </td>
</tr>
<tr><td>App Certificate</td>
<td>App Certificate</td>
<td> </td>
</tr>
<tr><td>channelName</td>
<td>channelName</td>
<td> </td>
</tr>
<tr><td>unixTs／Ts</td>
<td>N/A</td>
<td>删除了授权时间戳</td>
</tr>
<tr><td>uid</td>
<td>uid</td>
<td> </td>
</tr>
<tr><td>expiredTs/timeputFromNow</td>
<td>expiredTs/timeputFromNow</td>
<td>保留了服务到期时间</td>
</tr>
<tr><td>randomint/r</td>
<td>randomint/r</td>
<td> </td>
</tr>
<tr><td>N/A</td>
<td>Role</td>
<td>增加了角色及对应权限。更多详情请见：<a href="./token#roleprivilege"><span>Token 的角色权限</span></a> 。</td>
</tr>
</tbody>
</table>



