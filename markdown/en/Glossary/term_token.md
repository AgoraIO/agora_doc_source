---
title: Token
platform: All Platforms
updatedAt: 2020-09-18 12:37:01
---
A Token, also known as a dynamic key, is used for authentication when your app user joins an RTC channel or logs onto the Agora RTM system.

Tokens expire, ensuring better communication security.

Tokens are generated on the business server. When generating a token, developers need to provide information such as the App ID, App Certificate, user ID, and token expiration timestamp.

Once a token expires, developers can no longer access the Agora service: App users are kicked out of the channel, or can no longer log onto the service system. To prevent this from happening, the Agora SDKs have callbacks to remind the app to renew the token both before and after the token expires. When this happens, developers need to generate a new token on the business server and pass the new token to the SDK to resume communication.

<div class="alert info">References: 
	<li><a href="https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms">Generate a token for Agora RTC SDK, On-premise Recording, or Cloud Recording</a></li>
	<li><a href="https://docs.agora.io/en/Real-time-Messaging/rtm_token">Generate a token for Agora RTM SDK</a></li>
	<li><a href="https://docs.agora.io/en/faq/token_error">Troubleshooting token-related errors</a></li>
</div>

<a href="./terms"><button>Back to glossary</button></a>