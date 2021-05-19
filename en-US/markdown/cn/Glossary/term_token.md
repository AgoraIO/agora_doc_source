---
title: Token
platform: All Platforms
updatedAt: 2021-01-28 10:43:18
---
#### <a name="token"></a>**Token**

A token is also known as a dynamic key. It serves as an authentication mechanism. To ensure communication security, Agora supports the use of tokens to check the permissions of app users.

The following figure shows the process of verifying user permissions with a token:

![token-workflow](/Users/wangjie/Desktop/token-workflow.png)

Developers need to generate tokens on their app servers and send them back to the client. When users use Agora services (such as joining an RTC channel, logging in to the RTM system, entering a whiteboard room), they pass the tokens, and the Agora server checks the user permissions with the information in the tokens.

For different products, the information contained in a token is not exactly the same. Generally speaking, a token includes information about an Agora project (such as the App ID), information about the Agora service to be used (such as the RTC channel name, the UUID of the whiteboard room), user roles or permissions, and the expiration time of the token.

After the token expires, the user cannot use the Agora service. Developers can set the expiration time of the token according to their business needs, and renew the expired tokens in time.

<div class="alert info">See also:<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/faq/appid_to_token">How do I upgrade to token-based authentication?</a></li><li><a href="https://docs.agora.io/cn/Agora%20Platform/token#temptoken">Get a temporary token</a></li><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/token_server">Generate a token for Agora RTC SDK, On-premise Recording, or Cloud Recording</a></li><li><a href="https://docs.agora.io/cn/Real-time-Messaging/rtm_token">Generate a token for Agora RTM SDK</a></li><li><a href="https://docs.agora.io/cn/whiteboard/whiteboard_token_overview">Interactive Whiteboard Token Overview</a></li>
</div>

<a href="./terms"><button>Back to glossary</button></a>