---
title: Token Migration Guide
platform: NULL
updatedAt: 2018-11-02 12:16:03
---
# Token Migration Guide

This page describes how to migrate from the legacy Dynamic Key to a Token.

## 1. Client API Change Log

### Android API Change Log

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



### iOS API Change Log

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



### macOS API Change Log

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



### Windows API Change Log

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



### Web API Change Log

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



## 2. Dynamic Key Generation Parameters \(2.0.2\) versus Token Generation Parameters \(2.1\)

The following table compares the parameters used for generating a dynamic key with those used for generating a Token:

<table>
<colgroup>
<col/>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Dynamic Key</strong></td>
<td><strong>Token</strong></td>
<td><strong>Description</strong></td>
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
<td>Removes the time stamp parameter.</td>
</tr>
<tr><td>uid</td>
<td>uid</td>
<td> </td>
</tr>
<tr><td>expiredTs/timeputFromNow</td>
<td>expiredTs/timeputFromNow</td>
<td>Keeps the service timeout parameter.</td>
</tr>
<tr><td>randomint/r</td>
<td>randomint/r</td>
<td> </td>
</tr>
<tr><td>N/A</td>
<td>Role</td>
<td>Adds the roles and the privileges related to the roles. See <a href="key_native.html#roleprivilege"><span>Role-privilege Model</span></a>.</td>
</tr>
</tbody>
</table>



