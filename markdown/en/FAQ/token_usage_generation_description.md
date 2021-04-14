---
title: What is a token? Where can I get a token? When shall I use it?
platform: ["All Platforms"]
updatedAt: 2020-04-03 14:57:57
Products: ["Voice","Video","Interactive Broadcast","Recording","Real-time-Messaging","cloud-recording"]
---
## Brief description

A token, also known as a dynamic key, is used in situations requiring high security, such as in a production environment. You need a token for authentication when joining an RTC channel or when logging into the Agora RTM system. 

## Function of a token

- For users of the Agora RTC SDK, Agora On-premise Recording SDK, or Agora Cloud Recording service, the Agora server uses a token to verify each user's App ID, privileges (for joining a channel and for publishing different types of streams), privilege expiration period, and token validity. 
- For users of the Agora RTM SDK, the Agora RTM server uses a token to verify each user's App ID, user ID, and token validity. 

## Generate and use a token

In a production environment, an app user must generate a token on a business server and pass the token when joining an RTC channel or when logging in the Agora RTM system. If you are still testing your app or do not wish to take the trouble of setting up your own business server for generating tokens, have [Agora Console](https://console.agora.io/) generate a temporary token for you when creating your project. In this case, a temporary token suffices because it has the same function. 

Relevant links:

- [Get a temporary token for Agora RTC SDK, Agora On-premise Recording SDK, and Agora Cloud Recording Service](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#get-a-temporary-token)
- [Generate a token for Agora RTC SDK, Agora On-premise Recording SDK, and Agora Cloud Recording Service](https://docs.agora.io/en/Interactive%20Broadcast/token_server_cpp?platform=CPP)
- [Generate a token for Agora RTM SDK](https://docs.agora.io/en/Real-time-Messaging/rtm_token?platform=All%20Platforms)

## Expiration period of a token

Each token has a privilege expiration period and a validity period. The privilege expiration period is when the user privilege expires; the validity period is when the token itself expires (24 hours by default). 

## SDK behaviors when a token expires

Users of the Agora RTC SDK, Agora On-premise SDK, or Agora Cloud Recording service are kicked out of the channel immediately when their token expires. Users of the Agora RTM SDK are not immediately kicked out of the Agora RTM system but will not be able to log in the RTM system the next time their client connects to the system. Therefore, when notified that your privilege will soon expire or that the token validity has expired, generate a new token at your earliest convenience and save it for the next channel-join or login. 