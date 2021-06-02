---
title: How to solve token-related errors?
platform: ["Android","iOS","macOS","Web","Windows","Unity","Cocos Creator","Electron","React Native","Flutter"]
updatedAt: 2020-09-22 16:57:26
Products: ["Voice","Video","Interactive Broadcast"]
---
Once you enable the App Certificate for your Agora project, you have decided that your app authenticates its users with the dynamic token.

Tokens expire. During the runtime of your app, you may receive the following error codes or callback events that are related to the token. This article helps you to learn more about the issues, their causes, and how to troubleshoot.

<div class="alert note">This article applies to the Agora RTC SDK only.</div>

## 101: Invalid app ID

**Issue description:**

- Native: The SDK returns `ERR_INVALID_APP_ID(101)` when initializing the Agora service, or reports the `ERR_INVALID_APP_ID(101)` error in the `onError` callback when you try to join a channel by calling `joinChannel`.
- Web: The Console prints `ERR_INVALID_VENDOR_KEY(101)` when the SDK initializes the Agora service, or when you try to join a channel by calling `Client.join`.

**Reason:** The App ID is invalid, usually because the data format of the App ID is incorrect.

**Solution:** Check the data format of your App ID. Ensure that you use the correct App ID to initialize the Agora service.

## 109/118/2: Token expired

**Issue description:**

- Native: The SDK reports the `ERR_TOKEN_EXPIRED(109)` error in the `onError` callback when you try to join a channel by calling `joinChannel`.
- Web: The Console prints `ERR_DYNAMIC_KEY_TIMEOUT(109)` or `ERR_DYNAMIC_KEY_EXPIRED(118)` when you try to join a channel by calling `Client.join`.

**Reason:** The token has expired.

**Solution:** When a token expires, you need to generate a new token on your server, and try to join the channel by calling `renewToken`.
		
## 110: Invalid token

**Issue description:**

- Native: The SDK reports `ERR_INVALID_TOKEN(110)` in the onError callback when you try to join a channel by calling `joinChannel`.
- Web: The Console prints `ERR_NO_AUTHORIZED(110)` when you try to to join a channel by calling `Client.join`.

**Reason:** The token is invalid, usually for the following reasons:

- Did not provide a token when joining a channel in a situation where the project has enabled the App Certificate.
- Tried to join a channel with a token in a situation where the project has not enabled the App Certificate.
- The App ID, user ID and channel name that you use to generate the token on the server do not match those that you use when joining a channel.

**Solution:**

- Before joining a channel, check whether your project has enabled the App certificate. If yes, you must provide a token when joining a channel; if no, join a channel without a token.
- When using a token to join a channel, ensure that the App ID, user ID, and channel name that you use to generate the token is the same as the App ID that you use to initialize the Agora service, and the user ID and channel name that you use to join the channel.

## 119: Static user using the dynamic key

<div class="alert note">This error code applies to the Agora RTC Web SDK only.</div>

**Issue description:** The Console prints `ERR_STATIC_USE_DYNAMIC_KEY(119)` when the SDK tries to join a channel by calling Client.join.

**Reason:** This is because you try to join a channel with a token in a situation where the Agora project has not enabled the App Certificate. You can use a token to join a channel only when the App Certificate is enabled.

**Solution:** For projects that have not enabled the App Certificate, you can either join a channel without a token, or enable the App Certificate, generate a token on your server, and join a channel using that token.

## 120: Dynamic user using the static key

<div class="alert note">This error code applies to the RTC Web SDK only.</div>

**Issue description:** The Console prints `ERR_DYNAMIC_USE_STATIC_KEY(120)` when you try to join a channel by calling Client.join.

**Reason:** This is because you fail to provide a token when joining a channel in the situation where the Agora project has enabled the App Certificate. Once the App Certificate is enabled, you must use a token to join a channel.

**Solution:** Provide a token when joining a channel. Or you can initialize the Agora service with an App ID that has not enabled the App Certificate.

## Token callback events

To ensure smooth communication, Agora provides the following two callback events to remind the user that the token is about to expire, or has expired.

- `onTokenPrivilegeWillExpire`: Occurs 30 seconds before the token expires. Upon receiving this callback, generate a new token on the server, and call renewToken to pass the new token to the SDK.
- `onRequestToken` (or `onTokenPrivilegeDidExpire` on Web): Occurs when the token expires. Upon receiving this callback, generate a new token on the server, call `joinChannel`, and pass the new token to join the channel.

## Token-related errors in different programming languages

| Error code | Java/C++/C# | Objective-C | Javascript |
| ---------------- | ---------------- | ---------------- | ---------------- |
| 101      | `ERR_INVALID_APP_ID`      | `AgoraErrorCodeInvalidAppId`      | `ERR_INVALID_VENDOR_KEY` |
| 109      | `ERR_TOKEN_EXPIRED`      | `AgoraErrorCodeTokenExpired`      | `ERR_DYNAMIC_KEY_TIMEOUT` |
| 110      | `ERR_INVALID_TOKEN`      | `AgoraErrorCodeInvalidToken`      | `ERR_NO_AUTHORIZED` |
| 2      | /      | /      | `K_TIMESTAMP_EXPIRED` |
| 118      | /      | /      | `ERR_DYNAMIC_KEY_EXPIRED` |
| 119      | /      | /      | `ERR_STATIC_USE_DYNAMIC_KEY` |
| 120      | /      | /      | `ERR_DYNAMIC_USE_STATIC_KEY` |
