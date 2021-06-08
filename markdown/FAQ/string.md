---
title: 如何使用 String 型用户 ID？
platform: ["Android","iOS","macOS","Web","Windows"]
updatedAt: 2020-11-12 03:25:37
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
## 场景描述

<div class="alert warning">该功能目前正在验证阶段。如需使用，我们建议你联系声网技术支持。<p>以下产品或功能不支持 String 型的用户 ID：<li><a href="https://docs.agora.io/cn/cloud-recording/product_cloud_recording?platform=All%20Platforms">云端录制</a ><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/cdn_streaming_android?platform=Android">RTMP 推流</a ><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/rtc_restful_api?platform=All%20Platforms">服务端 RESTful API</a ><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/start_live_wechat?platform=微信小程序">微信小程序</a ></p></div>


很多 App 使用 String 类型的用户账号。为降低开发成本，Agora 新增支持 String 型的用户 ID，方便用户使用 App 账号直接加入 Agora 频道。

为保证通信质量，频道内所有用户需使用同一数据类型的用户 ID，即频道内的所有用户名应同为 Int 型或同为 String 型。

## 实现方法

开始前请确保你已了解实现基本的实时音视频功能的步骤及代码逻辑。Agora RTC SDK 在 Native 端和 Web 端分别使用不同的方法实现支持 String 型用户 ID。

### Native 端

从 v2.8.0 起，Native SDK 新增使用 User Account 来标识用户在频道中的身份

- registerLocalUserAccount：注册本地用户 User Account
- joinChannelWithUserAccount（Android 和 Windows）/joinChannelByUserAccount（iOS 和 macOS）：使用 User Account 加入频道

参考如下步骤，在你的项目中实现使用 String 型用户 ID 加入频道：

1. 完成初始化 RtcEngine 后，调用 `registerLocalUserAccount` 方法，注册本地用户的 User account。
2. 调用 `joinChannelWithUserAccount` 方法，使用注册的 User account 加入频道。
3. 离开频道时，调用 `leaveChannel` 方法。

**API 时序图**

下图展示 Native 端使用 User Account 加入频道的 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1568708771646)

<div class="alert note">本图使用 C++ 语言的方法名作演示。其他语言请直接使用相应的接口名进行替换。</div>

其中：

- 在 `registerLocalUserAccount` 和 `joinChannelWithUserAccount` 方法中，`userAccount` 参数均为必填，不可为 null。
- `registerLocalUserAccount` 为选调。你可以注册后再调用 `joinChannelWithUserAccount` 方法加入频道，也可以不注册直接调用 `joinChannelWithUserAccount` 加入频道。我们建议你调用。提前调用 `registerLocalUserAccount` 可以减少调用 `joinChannelWithUserAccount` 加入频道的时间。
- 对于其他接口，Agora SDK 仍沿用 Int 型的 UID 参数标识用户身份。你可以使用 `getUserInfoByUid` 或 `getUserInfoByUserAccount` 获取对应的 User Account 或 UID，无需自己维护映射表。

Agora 的其他接口仍使用 Int 型的 UID 作为参数。Agora 维护一个 String 型 User account 和 Int 型 UID 的映射表，方便随时通过 User account 获取 UID 或者通过 UID 获取 User account。

**示例代码**

你可以对照 API 时序图，参考下面的示例代码片段，在项目中实现使用 String 型用户 ID：

```java
// Java
private void initializeAgoraEngine() {
  try {
    String appId = getString(R.string.agora_app_id);
    mRtcEngine = RtcEngine.create(getBaseContext(), appId, mRtcEventHandler);
    // 初始化后、加入频道前先注册用户名，可以缩短加入频道的时间
    mRtcEngine.registerLocalUserAccount(appId, mLocal.userAccount);
  } catch (Exception e) {
    Log.e(LOG_TAG, Log.getStackTraceString(e));
    
    throw new RuntimeException("NEED TO check rtc sdk init fatal error\n" + Log.getStackTraceString(e));
  }
}

private void joinChannel() {
  String token = getString(R.string.agora_access_token);
  if (token.isEmpty()) {
    token = null;
  }
  // 使用注册的用户 ID 加入频道
  mRtcEngine.joinChannelWithUserAccount(token, "stringifiedChannel1", mLocal.userAccount);
}
```

```swift
// Swift
func joinChannel() {
  // 加入频道前注册用户 ID
  let myStringId = "someStringId"
  agoraKit.registerLocalUserAccount(userAccount: myStringId, appId: myAppId)
  // 使用注册的用户 ID 加入频道
  agoraKit.joinChannel(byUserAccount: myStringId, token: Token, channelId: "demoChannel1") {
    sid, uid, elapsed) in
  }
}
```

```C++
// C++
LRESULT COpenLiveDlg::OnJoinChannel(WPARAM wParam, LPARAM lParam)
{
	IRtcEngine		*lpRtcEngine = CAgoraObject::GetEngine();
	CAgoraObject	*lpAgoraObject = CAgoraObject::GetAgoraObject();

	// 注册本地用户名
	lpAgoraObject->RegisterLocalUserAccount(APP_ID, m_dlgEnterChannel.GetStringUid());
	// 使用用户名加入频道
	lpAgoraObject->JoinChannelWithUserAccount(strChannelName, m_dlgEnterChannel.GetStringUid());
	
}
```


同时，我们在 Github 提供一个开源的 [String-Account](https://github.com/AgoraIO/Advanced-Video/tree/dev/backup/String-Account) 示例项目。你可以前往下载，或参考各平台相应文件中的源代码。

**API 参考**

- Java

	- [`registerLocalUserAccount`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa37ea6307e4d1513c0031084c16c9acb)
	- [`joinChannelWithUserAccount`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a310dbe072dcaec3892c4817cafd0dd88)
	- [`getUserInfoByUid`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a9a787b8d0784e196b08f6d0ae26ea19c)
	- [`getUserInfoByUserAccount`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#afd4119e2d9cc360a2b99eef56f74ae22)
	- [`onLocalUserRegistered`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aca1987909703d84c912e2f1e7f64fb0b)
	- [`onUserInfoUpdated`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aa3e9ead25f7999272d5700c427b2cb3d)

- Objective-C

	- [`registerLocalUserAccount`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/registerLocalUserAccount:appId:)
	- [`joinChannelByUserAccount`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByUserAccount:token:channelId:joinSuccess:)
	- [`getUserInfoByUid`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getUserInfoByUid:withError:)
	- [`getUserInfoByUserAccount`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getUserInfoByUserAccount:withError:)
	- [`didRegisteredLocalUser`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didRegisteredLocalUser:withUid:)
	- [`didUpdatedUserInfo`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didUpdatedUserInfo:withUid:)

- C++

	- [`registerLocalUserAccount`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a0d44b74ced4005ee86353c13186f870d)
	- [`joinChannelWithUserAccount`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a14f8c308c6c57c55653552b939a8527a)
	- [`getUserInfoByUid`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#abf4572004e6ceb99ce0ff76a75c69d0b)
	- [`getUserInfoByUserAccount`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a4f75984d3c5de5f6e3e4d8bd81e3b409)
	- [`onLocalUserRegistered`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a919404869f86412e1945c730e5219b20)
	- [`onUserInfoUpdated`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ad086cc4d8e5555cc75a0ab264c16d5ff)

### Web 端

从 v2.5.0 起，Web SDK 支持将 join 方法中的 uid 设为 Number 或 String 型。因此，你可以直接在调用该方法时，传入 String 型的用户 ID 即可。

**API 时序图**

下图展示 Web 端使用 String 型用户 ID 加入频道的 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1568875087634)

**示例代码**

你可以对照 API 时序图，参考下面的示例代码片段，在项目中实现使用 String 型用户 ID：

```javascript
// Javascript
// 将 UID 设为 agora，然后加入频道 1024
client.join("<token>", "1024", "agora", function(uid) {
  console.log("client" + uid + "joined channel");
  // 创建本地流
  // ...
}, function(err) {
  console.error("client join failed", err)
  // 处理报错
});
```

**API 参考**

- [`Client.join`](./API%20Reference/web/interfaces/agorartc.client.html#join)

## 开发注意事项

- 同一频道内，Int 型和 String 型的用户 ID 不可混用。如果你的频道内有不支持 String 型 User account 的 SDK，则只能使用 Int 型的 User ID。目前支持 String 型 User account 的 SDK 如下：
  - Native SDK：v2.8.0 及之后版本
  - Web SDK：v2.5.0 及之后版本
- 如果你将用户名切换至 String 型，请确保所有终端用户同步升级。
- 如果使用 String 型的用户 ID 加入频道，请确保你的服务端用户生成 Token 的脚本已升级至最新版本，并使用该用户 ID 或其对应的 Int 型 UID 来生成 Token。
- 如果频道中 Native SDK 和 Web SDK 互通，请确保该两者使用的用户 ID 的类型一致。
