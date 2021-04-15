---
title: Glossary
platform: All Platforms
updatedAt: 2021-01-18 03:39:03
---
# Agora Key Terms

Learn the key terms of Agora platform .

## Basics

Things you need to know before using the Agora SDK.

### Agora Dashboard

[Agora Dashboard](https://dashboard.agora.io/) is a platform provided by Agora for you to create and manage your projects.After [sigining up](https://dashboard.agora.io/en/signup), you can create projects, get [App ID](#appid)s, view your usage statistics, analyze the quality of your calls, and check your bills on [Dashboard](https://dashboard.agora.io/).

### <a name="appid"></a>App ID

App ID is issued to application developers by Agora to identify the project and organization. After signing up at [Agora Dashboard](https://dashboard.agora.io/), you can create multiple projects and each project will have a unique App ID. See [Getting an App ID](./token#getting-an-app-id) for detailed instruction.

All the communication sessions created across the Agora SD-RTN with one App ID are isolated from all other sessions with other App IDs. Therefore, communication sessions with different App IDs will not be connected. Statistics, management, and billing are all separated according to the App ID. If an organization has multiple applications that should be kept completely separate, for example they are built by completely different teams, then they should use different App IDs. If applications need to communicate with each other, then a single App ID should be used.

### App Certificate

App certificate is provided by Agora for generating [dynamic keys](#key). 

You can enable the App Certificate in the [Agora Dashboard](https://dashboard.agora.io). See [Getting an App Certificate](./token#getting-an-app-certificate) for detailed instruction.

### <a name="key"></a>Dynamic Key

Using your App ID directly is easy and works well for the initial development of applications. However, if someone illicitly obtains your App ID, then they will be able to perform the same operations on their own client applications. This will allow them to join sessions that belong to you and are billed to you. To prevent this and to secure your applications, Agora recommends you use dynamic keys for large-scale production applications.

Dynamical Keys are generated within the server-side code by App Certificate and other key materials, and App Certicaite is never accessible in any client code, which makes Dynamical Key more secure than the static App ID.

Dynamical Keys have expiry dates and contain client permissions such as different role privileges (host and audience).

Based on the SDK version, the Dynamic Key could be a Channel Key or a Token, see [Security Keys](token) for details.

### SD-RTN

Agora’s audio and video transmission relies on its self-built SD-RTN (Software Defined Real-time Network), a virtual and UDP (User Datagram Protocol)-based network architecture designed specifically for real-time communications. By deploying software networking units, which work in synergy with one another, at different data centers across the Internet, Agora managed to add a virtual layer. To ensure stable transmission and low latency, particularly on the weak networks, the SD-RTN automatically assigns optimal path according to the following node conditions in a real-time way:

- Transmission status
- Load conditions
- Distance to the users
- Response time

## SDK Core Concepts

Agora ships its SDKs with a set of API methods (engine interfaces) and callbacks (event callbacks).

- Method: The client calls the API methods to implement the features provided by Agora’s SDK.
- Callback: Feedback sent from the SDK to the client on a local or remote event that has just happened. A remote event callback is an event callback of a remote user in the channel. A remote event callback transmits through the UDP channel and is not 100% reliable.

For detailed information on specific methods and callbacks, see our API Reference docs for [Android](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/index.html), [iOS/macOS](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/index.html), [Web](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/index.html), and [Windows](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/index.html).


### Channel

If we imagine an App as a building, a channel is like a room in the building.

A channel is created when the first user joins the channel, and automatically destroyed when the last user leaves the channel.

When entering a room, you need a key to open the door. Similarly, when joining a channel, you need to pass in an [App ID](#appid) or [Dynamic Key](#key) as authentication.

### Channel Profile/Mode

The SDK will apply different optimization methods according to the channel profile.

Users in the same channel must use the same channel profile.

Currently we have three channel profiles:

#### Communication

This is used in one-on-one calls or group calls, where all users in the channel can talk freely.

#### Live Broadcast

In a live broadcasting channel, the users have two types of roles: host and audience. The host sends and receives audio/video, while the audience receives audio/video only with the sending function disabled.

#### Gaming

> This profile applies to the Agora Gaming SDK only.

Any user in the channel can talk freely. This profile uses the codec with low-power consumption and low bitrate by default.

### UID

User ID, the identifier of a user in the channel. Each user in the same channel should have a unique UID.

If you leave the UID empty or set it to 0, the SDK will automatically assign one for you.

### Stream

A stream usually refers to an object that contains audio/video data. Users in a channel can publish the local stream and subscribe to the remote streams from other users.

### Publish

After joining the channel, the user can send the local audio/video data to other users in the channel, namely publishing the stream.

In a live broadcast channel, only the hosts can publish streams.

### Subscribe

After joining the channel, the user can receive the audio/video stream published by other users in the channel, namely subscribing to the stream.

### Dual-stream Mode

Dual streams are a hybrid of a high-video stream and a low-video stream. The publisher can choose to enable the dual-stream mode to send both video streams at the same time.

#### High-video Stream

High bitrate, and high resolution video stream.

#### Low-video Stream

Low bitrate, and low resolution video stream.

#### Stream Fallback

Under poor network conditions, the publisher/subscriber can enable stream fallback to send/receive the low-video stream or audio-only stream. Stream fallback works only when the dual-stream mode is enabled.

## Live Broadcast Core Concepts

Live broadcasting refers to the broadcast of a live performance with an App and via Internet, where the spectators or viewers are called the audience and the one who gives the performance is a host.

Agora’s products allow you to easily implement the live broadcasting feature on any App:

- To give a live broadcast, set up a channel and enter it in the host role.
- To view a live broadcast, enter the channel created by the host in the audience role.

### Host

In a live broadcast channel, hosts refer to the users who can publish and subscribe to streams.

### Audience

In a live broadcast channel, audience refer to the users who can only subscribe to streams. Audience cannot publish streams. 

### Hosting-In

An audience can apply to become a host to interact directly with the existing hosts. Such process is called hosting-in.

### CDN Live Streaming

The process of publishing streams onto CDN (Content Delivery Network) is called CDN live streaming where users can view live broadcast via a web browser.

### Transcoding

Transcoding is often involved in the process of CDN live streaming when there are multiple hosts in the channel.

In CDN live streaming, audio and video streams sent to the SD-RTN are transferred into an RTMP (Real-Time Messaging Protocol) stream and then pushed to CDN. If there are multiple hosts, their streams need to be combined into a single stream by transcoding. 

Transcoding sets the audio/video profiles and the picture-in-picture layout for the stream to be pushed to CDN.

> Agora recommends you not use transcoding in the case of a single host.