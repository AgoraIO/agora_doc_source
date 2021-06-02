---
title: How can I use string user names?
platform: ["Android","iOS","macOS","Web","Windows"]
updatedAt: 2020-08-20 11:41:44
Products: ["Voice","Video","Interactive Broadcast"]
---
<div class="alert warning">This feature is in BETA. We recommend contacting support@agora.io before implementing this function.<p>The following products or features do not support string user accounts:<li><a href="https://docs.agora.io/en/cloud-recording/product_cloud_recording?platform=All%20Platforms">Cloud Recording</a ><li><a href="https://docs.agora.io/en/Interactive%20Broadcast/cdn_streaming_android?platform=Android">RTMP Converter</a ><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/rtc_restful_api?platform=All%20Platforms">Server RESTful API</a ></p></div>

## Introduction

Many apps use string usernames. To reduce development costs, Agora adds support for string user accounts. Users can now directly use their string usernames as user accounts to join the Agora channel.

To ensure smooth communication, all the users in a channel should use the same type of user account, that is, either the integer user ID, or the string user account.

## Implementation

Before proceeding, ensure that you understand the steps and code logic for implmenting the basic real-time communication functions. 

### Native

Starting from v2.8.0, the Agora Native SDK supports using user accounts to identify the user:

- registerLocalUserAccount: Registers a user account.
- joinChannelWithUserAccount/joinChannelByUserAccount: Joins the channel with the registered user account.

Follow the steps to join an Agora channel with a string user account:

1. After initializing the RtcEngine instance, call the `registerLocalUserAccount` method to register a loca user account.
2. Call the `joinChannelWithUserAccount` method to join a channel with the registered user account.
3. Call the `leaveChannel` method when you want to leave the channel.

**API call sequence**

The following diagram shows how to join a channel with a string user account:

![](https://web-cdn.agora.io/docs-files/1568711868522)

<div class="alert note">This diagram uses Java APIs as an example. </div>


- The `userAccount` parameter in the `registerLocalUserAccount` and `joinChannelWithUserAccount` methods is mandatory. Do not set it as null.
- The `registerLocalUserAccount` method is optional. To join a channel with a user account, you can choose either of the following:
  - Call the `registerLocalUserAccount` method to create a user account, and then the `joinChannelWithUserAccount` method to join the channel.
  - Call the `joinChannelWithUserAccount` method to join the channel.

  The difference between the two is that for the former, the time elapsed between calling the `joinChannelWithUserAccount` method and joining the channel is shorter than the latter.
- For other APIs, Agora uses the integer user ID for identification. You can call the  `getUserInfoByUid` or `getUserInfoByUserAccount` method to get the corresponding user ID or user account without maintaining the map.

For other APIs, Agora uses the integer user ID for identification. Agora maintains a mapping table object that contains the string user account and integer user ID. You can get the user ID by passing in the user account, and vice versa.

**Sample code**

You can also refer to the following code snippets and implement string user accounts in your peoject:

```java
// Java
private void initializeAgoraEngine() {
  try {
    String appId = getString(R.string.agora_app_id);
    mRtcEngine = RtcEngine.create(getBaseContext(), appId, mRtcEventHandler);
    // Registers the local user account after initializing the Agora engine and before joining the channel.
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
  // Joins the channel with the registered user account.
  mRtcEngine.joinChannelWithUserAccount(token, "stringifiedChannel1", mLocal.userAccount);
}
```

```swift
// Swift
func joinChannel() {
  // Registers the local user account before joining the channel.
  let myStringId = "someStringId"
  agoraKit.registerLocalUserAccount(userAccount: myStringId, appId: myAppId)
  // Joins the channel with the registered user account.
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
	
	// Registers the local user account before joining the channel.
	lpAgoraObject->RegisterLocalUserAccount(APP_ID, m_dlgEnterChannel.GetStringUid());
	// Joins the channel with the registered user account.
	lpAgoraObject->JoinChannelWithUserAccount(TOKEN, strChannelName, m_dlgEnterChannel.GetStringUid());

}
```

We provide an open-source [String-Account](https://github.com/AgoraIO/Advanced-Video/tree/dev/backup/String-Account) demo project that implements string user accounts on Github. You can try the demo and view the source code.

**API Reference**

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

### Web

Starting from v2.5, the `uid` parameter in the `Client.join` method can be set as either a number or a string. You can join a channel by calling the `Client.join` method and passing in a string `uid`.

**API call sequence**

The following diagram shows how to join a channel with a string user account:

![](https://web-cdn.agora.io/docs-files/1568875442230)

**Sample code**

You can also refer to the following code snippets and implement string user accounts in your peoject:

```javascript
// Javascript
// Set uid as agora and join channel 1024
client.join("<token>", "1024", "agora", function(uid) {
  console.log("client" + uid + "joined channel");
  // Create a local stream
  // ...
}, function(err) {
  console.error("client join failed", err)
  // Error handling
});
```

**API Reference**

* [`Client.join`](./API%20Reference/web/interfaces/agorartc.client.html#join)

## Considerations

- Do not mix parameter types within the same channel. If you use SDKs that do not support string usernames, only integer user IDs can be used in the channel. The following Agora SDKs support string user accounts:
  - The Native SDK: v2.8.0 and later.
  - The Web SDK: v2.5.0 and later.
- If you change your app usernames into string user accounts, ensure that all app clients are upgraded to the latest version.
- If you use string user accounts to join a channel, ensure that the token generation script on your server is updated to the latest version, and that you use the same user account or its corresponding integer user ID to generate a token. 
- If the Native SDK and Web SDK join the same channel, ensure that the user identification types are the same. 
