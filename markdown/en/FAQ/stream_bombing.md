---
title: How to protect interactive live streaming from stream bombing?
platform: ["Android","iOS","macOS","Web","Windows","Unity","Cocos Creator","Electron","React Native","Flutter"]
updatedAt: 2021-02-05 07:18:08
Products: ["Voice","Video","Interactive Broadcast"]
---
In interactive live streaming, stream bombing refers to confusion caused by incorrect host seat information due to vulnerabilities in your application, or the use of these vulnerabilities by unauthorized users to deliberately disrupt a streaming session.

Stream bombing can occur in the following scenarios:

- Online voice chatrooms
- Interactive live video streaming involving multiple hosts

Typical stream bombing examples include:

- Due to flaws in your application, the host seat information displayed on the clients does not match the actual number of hosts in the channel, and therefore the audience in the channel cannot identify who is talking.
- An attacker hijacks the signaling messages to prevent the application server from sending status messages to the clients, disrupting host seat updates or room management.
- During live streaming, a troublemaker makes noise or bombards other users with disturbing audio or video content.
- An intruder repeatedly joins a channel with a token that should have expired but has not, because the valid time of the token is set too long.

## Solutions

### Locate disruptive users

The key to stopping stream bombing is to quickly locate any disruptive users. You can use the following methods:

- **Method one (recommended)**

  Call [`enableAudioVolumeIndication`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aaec0b8db9458b45d14cdcb3003f76fbe) on the client to enable the [`onAudioVolumeIndication`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a4d37f2b4d569fa787bb8c0e3ae8cd424) callback. The callback reports which users are speaking and the speakers' volume. Compare the UIDs reported in the callback with the user list maintained on your application server to discover disruptive users.

- **Method two**

  Call the Agora RESTful API [`https://api.agora.io/dev/v1/channel/user/{appid}/{channelName}`](https://web-cdn.agora.io/docs-cms/swagger/en/rtc/restfulapi/index.html#/Online%20channel%20statistics%20query/userProperty) on your application server regularly to query the user list of a channel. Compare the user list returned by Agora with the user list maintained on your application server to discover disruptive users.

- **Method three**

  Enable the [Agora message notification service](https://docs-preview.agoralab.co/en/Agora%20Platform/ncs) and subscribe to [real-time communication events](https://docs-preview.agoralab.co/en/Agora%20Platform/rtc_eventtype?platform=All%20Platforms). When receiving the following events, check the user list on your application server to determine whether the newly joined host is authorized.

  - A host joins the channel.
  - An audience member switches their hole to host after joining the channel.

 <div class="alert note">Agora Message Notification Service is in the Beta stage. Agora recommends that core apps should not rely on the Message Notification Service.</div>

- **Method four**
  If the channel has troublemakers who keep sending pornographic, violent, or politically sensitive voice content, you can use the individual recording mode of Agora Cloud Recording to record the audio and then upload the audio to a third-party content review service. Use the review results to discover the user sending the disruptive content.

### Manage disruptive users

After discovering unauthorized users, you need to stop their disruptive behaviors to restore orderly live streaming as soon as possible. You can manage disruptive users in any of the following ways:

- **Prohibit disruptive users from sending streams.**
  Method one:
  
  Your application server sends a role-switching message to the client of the disruptive user. When it receives the message, the client calls [`setClientRole`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa2affa28a23d44d18b6889fba03f47ec) to set the user role as audience, thus removing the user's privilege to send streams.

  Method Two:

  Call the Agora RESTful API [`https://api.agora.io/dev/v1/kicking-rule`](https://docs.agora.io/en/rtc/restfulapi/#/Banning%20rule%20management/createKickingRule) on your application server, and set the `privileges` parameter as `publish_audio` and `publish_video` in the request body to ban disruptive users from sending audio and video streams.

- **Stop receiving audio streams from disruptive users.**

  If an unauthorized user hijacks the message that your application server sends to its client, your application server can send a mute message to the clients of all authorized users. When receiving the message, the clients call [`muteRemoteAudioStream`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a3e17b5d2b71d628206d740d895044c5d) to stop receiving unauthorized user's audio stream.

- **Kick disruptive users out of the channel or block their IP addresses.**

  Call [`https://api.agora.io/dev/v1/kicking-rule`](https://docs.agora.io/en/rtc/restfulapi/#/Banning%20rule%20management/createKickingRule) on your application server to kick unauthorized users out of the channel or block their IP addresses.
  To implement the functions, you need to set the `privileges` parameter as `join_channel` in the request body and fill in the `cname`, `uid`, and `ip` fields in one of the following ways:

  - Set `ip`, but not `cname` or `uid` to ban a user with this IP address from joining any channel in the app.
  - Set `uid`, but not `cname` or `ip` to ban a user with this ID from joining any channel in the app.
  - Set `cname` and `uid`, but not `ip` to ban a user with this ID from joining the channel specified by the `cname` field.

### Precautions against stream bombing

You can take the following measures to avoid vulnerabilities and strengthen security, thus protecting your live streaming from disruptions:

- Optimize your Token management.

  Set the token expiration timestamp (the [`privilegeExpiredTs`](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=Android#api-reference) parameter) according to the average user online time in the channel. Once the token expires, all users are removed from the channel. Thus, an unauthorized user cannot repeatedly join a channel with the token.
  Listen for the [`onTokenPrivilegeWillExpire`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a0ecee4bcca9b98dda251a57cfe92adb5) callback to monitor the event that the token is about to expire. Upon receiving this callback, you need to generate a new `token` on the server and call [`renewToken`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af1428905e5778a9ca209f64592b5bf80) to pass the new `token` to the SDK. 

- Prevent the disclosure of your [App ID and App certificate](https://docs.agora.io/en/Interactive%20Broadcast/token?platform=All%20Platforms).
  Agora recommends that you store the App ID and App certificate on your server to keep them secret. If there is a suspected leak, you need to update the App certificate.

  <div class="alert info">Agora recommends updating the App certificate when the number of online users in the channel is at a low level to avoid causing a large number of login failures.</div>

- To avoid the signaling message sent by the server being hijacked, you can establish a timeout mechanism between your server and clients. Only after receiving a confirmation message from the client does the server proceed to the next operation.
  For example, when the server sends a notification of switching user role to a client, the timeout timer starts. If the server receives a confirmation message from the client within a specified time, then the server determines the client has switched its user role to audience and then updates the host seat on the UI.

- To avoid inconsistencies between the channel user list on your application server and the one on the Agora server, you need to monitor the [`onRejoinChannelSuccess` ](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ad222912d35c5f9c22f95f3072feed77d) callback when the network reconnects after interruption and review each user ID that rejoins the channel.