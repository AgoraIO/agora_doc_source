---
title: Token
platform: All Platforms
updatedAt: 2021-01-28 10:43:18
---
#### <a name="token"></a>**Token**

A token is also known as a dynamic key, which is an authentication scheme. To ensure communication security, Agora supports the use of tokens to verify app user permissions.

The following figure shows the process of verifying user permissions with Token:

![token-workflow](/Users/wangjie/Desktop/token-workflow.png)

Developers need to generate tokens on their app server and send them back to the client. When users use Agora services (such as joining RTC channels, logging in to the RTM system, entering the whiteboard room, etc.), they will pass in the tokens, and the Agora server will be based on the tokens. The information to verify the user's permissions.

For different products, the information contained in the token is not exactly the same. Generally speaking, the token will include information about the Agora project (such as App ID), information about the Agora service to be used (such as the RTC channel name, the UUID of the whiteboard room), user roles or permissions, and the validity period of the token.

After the token expires, the user will not be able to use the Agora service normally. Developers can reasonably set the validity period of the Token according to their business needs, and replace the expired Token in time.

<div class="alert info">See also:<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/faq/appid_to_token">How do I use co-host token authentication?</a></li><li><a href="https://docs.agora.io/cn/Agora%20Platform/token#temptoken">Get a temporary token</a></li><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/token_server">Generate a token for Agora RTC SDK, On-premise Recording, or Cloud Recording</a></li><li><a href="https://docs.agora.io/cn/Real-time-Messaging/rtm_token">Generate a token for Agora RTM SDK</a></li><li><a href="https://docs.agora.io/cn/whiteboard/whiteboard_token_overview">RTM Token expiration</a></li>
</div>

<a href="./terms"><button>Back to glossary</button></a>