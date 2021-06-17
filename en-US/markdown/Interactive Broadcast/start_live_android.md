# Start Interactive Live Video Streaming

The Agora Video SDK for Android makes it easy to embed interactive live streaming into Android apps. It enables you to develop reapidly to enhance your social, work, education and IoT apps with real-time engagement.

This page shows the minimum code you need to add interactive live streaming into your Android app by using the Agora Video SDK for Android.

## Understand the tech

The following figure shows the workflow of interactive live streaming implemented by the Agora SDK.

![](../Images/live_streaming_tech.png)

To start interactive live streaming, your app client has the following steps to take: 

**1. Set the client role**
An interactive live streaming session differs from a voice or video call in that users in a live streaming channel have different roles: host (`BROADCASTER`) and audience (`AUDIENCE`). 
Only app clients with the role of `BROADCASTER` can publish streams in the channel. Those with the role of `AUDIENCE` can only susbcribe to streams.

**2. Get a token**
The app client requests a token from your app server. This token authenticates the user when the app client joins a channel.

**3. Join an Agora RTC channel**
The client joins an RTC (Real-time Communication) channel by calling the APIs provided by Agora. When that happens, Agora automatically creates an RTC channel. App clients that pass the same channel name join the same channel.

**4. Publish and subscribe to audio and video in the channel**
After joining a channel, only app clients with the role of `BROADCASTER` can publish audio and video. For an auidence memeber to send audio and video, you can call the API to switch the client role. 

For an app client to join an RTC channel, you need the following information:

- The App ID: A randomly generated string provided by Agora for identifying your app. You can get the App ID from [Agora Console](https://console.agora.io).
- The user ID: The unique identifier of a user. You need to specify the user ID yourself, and ensure that it is unique in the channel.
- A token: A credential for authenticating the identity of the user when your app client joins an RTC channel.
- The channel name: A string that identifies the RTC channel for the voice call. 


