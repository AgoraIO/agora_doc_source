---
title: 使用 String 型用户名
platform: Android
updatedAt: 2020-04-02 14:04:21
---
## 功能描述
Agora RTSA SDK 自 v1.2.0 起支持使用 String 型的用户 ID作为用户标识进行初始化。

为保证传输质量，建议同一频道内的所有用户使用同一数据类型的用户标识，即一个频道内的所有用户要么都使用 Int 型的用户 ID，要么的都使用 String 型的用户 ID，两者不要混用。

## 实现方法
调用 `initWithName` 方法初始化 Agora RTSA service。

在该方法中，你需要：

- 设置 `appId`。这是 Agora 为 App 开发者签发的 App ID。
- 设置 `uname`。这是由用户自行指定的用户 ID。最大不可超过 255 字节，且需要确保其在频道内的唯一性。支持的字符集范围如下：
	- 26 个小写英文字母 a-z
	- 26 个大写英文字母 A-Z
	- 10 个数字 0-9
	- 空格
	- "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","
- 设置事件回调 `events`，用以通知 SDK 在运行过程中发生的事件。
- 设置用于存放 SDK 日志的目录。设为 null 表示使用默认目录 /sdcard/。

示例代码如下，仅供参考：
~~~ java
// 'listener' implements AgoraRtcEvents, and should live long enough.
AgoraRtcService.initWithName("$MY_APP_ID",
                             "$MY_USER_NAME",
						     listener,
                             null);
~~~

本端使用 String 型的用户 ID成功初始化后，SDK 会触发 `onLocalUserRegistered` 回调向本端报告该 `uname` 对应的 `uid`。

本端加入频道后，SDK 会通知频道内的远端用户本端的 `uname` 和 `uid`，并在远端触发 `onRemoteUserRegistered` 回调。

## API 参考
- [`initWithName`](./API%20Reference/rtsa_java/classio_1_1agora_1_1rtc_1_1_agora_rtc_service.html#a198521eef805ceb90f58316b8297d9fe)
- [`onLocalUserRegistered`](./API%20Reference/rtsa_java/interfaceio_1_1agora_1_1rtc_1_1_agora_rtc_events.html#aec963b9d6be487e315d809225146ada6)
- [`onRemoteUserRegistered`](./API%20Reference/rtsa_java/interfaceio_1_1agora_1_1rtc_1_1_agora_rtc_events.html#ac1826cd7d5075df88e6c59bb933fd044)

## 开发注意事项
- 同一频道内，String 型用户 ID和 Int 型用户 ID 不要混用。如果你的频道内有不支持 String 型用户 ID的 SDK，则只能使用 Int 型的用户 ID。
- 如果你从 Int 型用户 ID 切换至 String 型用户 ID，请确保所有终端用户同步升级至支持 String 型用户 ID的版本。