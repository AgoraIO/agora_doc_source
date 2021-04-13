---
title: How do I use co-host token authentication?
platform: ["Android","iOS","macOS","Web","Windows","Unity","Cocos Creator","Electron","React Native","Flutter"]
updatedAt: 2021-01-04 04:35:48
Products: ["Voice","Video","Interactive Broadcast"]
---
## Introduction

In a live streaming channel, when an audience member applies to co-host, you can use a token to authenticate whether the user can publish a stream. This feature is co-host token authentication.

## Enable authentication

To enable co-host token authentication, contact support@agora.io, and provide the App ID of your project. Ensure that your project has enabled the App Certificate in Console.

Once you have enabled co-host token authentication, you app user must fulfill both of the following requirements to publish a stream in a channel:

- The user role is set as `BROADCASTER` in `setClientRole`.
- The user joins the channel with a token that has the privilege of a publisher (by setting the `role` parameter in the `buildToken` method as `publisher`) .

## Recommended app logic

Refer to the following logic to authenticate whether an app user can publish a stream:

1. Before joining a channel, the app client applies for a token with the privilege of a subscriber. The app server generates a token, and passes it to the app client.
2. The app client calls `joinChannel` and passes the token to the SDK.
3. Before changing the user role, the app client applies for a token with the privilege of a publisher. The app client generates a second token, and passes it to the app client.
4. The app client calls `renewToken` and passes the new token to the SDK.
5. The app client calls `setClientRole` to change the user role from an audience member to a host.
6. The Agora server authenticates the token when the app client calls `setClientRole`. If the token is generated with the privilege of a publisher, the app client can publish a stream.

<div class="alert note">
<ul>
	<li>If the user wants to switch from a host to an audience member, repeat steps 3 to 5. Apply for a token with the privilege of an audience, call <code>renewToken</code> on the app client, and then call <code>setClientRole</code>.</li>
	<li>Once the token expires, you need to generate a new token on the app server and call <code>renewToken</code> to pass the new token to the SDK. The new token also has a service validity period.</li>
</ul>
</div>