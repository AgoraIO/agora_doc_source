---
title: 使用 String 型用户名
platform: iOS
updatedAt: 2020-04-02 14:04:09
---
## 功能描述
Agora RTSA SDK 自 v1.2.0 起支持使用 String 型的用户 ID作为用户标识进行初始化。

为保证传输质量，建议同一频道内的所有用户使用同一数据类型的用户标识，即一个频道内的所有用户要么都使用 Int 型的用户 ID，要么的都使用 String 型的用户 ID，两者不要混用。

## 实现方法
调用 `+initWithAppId:uname:events:logDirectory:` 方法初始化 Agora RTSA 服务。

在该方法中，你需要：
- 设置 `AppId`。这是 Agora 为 App 开发者签发的 App ID。只有 App ID 相同的 App 才能进入同一个频道。
- 设置 `uname`。这是由用户自行指定的用户 ID。最大不可超过 255 字节，且需要确保其在频道内的唯一性。支持的字符集范围如下：
	- 26 个小写英文字母 a-z
	- 26 个大写英文字母 A-Z
	- 10 个数字 0-9
	- 空格
	- "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","
- 设置事件回调 `listener`，用以通知 SDK 在运行过程中发生的事件。
- 设置用于存放 SDK 日志的目录。设为 nil 表示使用默认目录，即当前应用程序的 documents 目录。

示例代码如下，仅供参考：
~~~ objective-C
// 'listener' implements AgoraRtcServiceEvents, and should live long enough.
[AgoraRtcService initWithAppId:@"$MY_APP_ID" uname:@"MY_USER_NAME" events:listener logDirectory:nil];
~~~

本端使用 String 型的用户 ID成功初始化后，SDK 会触发 `rtcServiceDidRegisterLocalUser` 回调向本端报告该 `uname` 对应的 `uid`。

本端加入频道后，SDK 会通知频道内的远端用户本端的 `uname` 和 `uid`，并在远端触发 `rtcServiceDidRegisterRemoteUser` 回调。

## API 参考
- [`+initWithAppId:uname:events:logDirectory:`](./API%20Reference/rtsa_oc/Classes/AgoraRtcService.html#//api/name/initWithAppId:uname:events:logDirectory:) 
- [`rtcServiceDidRegisterLocalUser`](./API%20Reference/rtsa_oc/Protocols/AgoraRtcServiceEvents.html#//api/name/rtcServiceDidRegisterLocalUser:uid:)
- [`rtcServiceDidRegisterRemoteUser`](./API%20Reference/rtsa_oc/Protocols/AgoraRtcServiceEvents.html#//api/name/rtcServiceDidRegisterRemoteUser:uid:)

## 开发注意事项
- 同一频道内，String 型用户 ID和 Int 型用户 ID 不要混用。如果你的频道内有不支持 String 型用户 ID的 SDK，则只能使用 Int 型的用户 ID。
- 如果你从 Int 型用户 ID 切换至 String 型用户 ID，请确保所有终端用户同步升级至支持 String 型用户 ID的版本。