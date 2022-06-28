# Chat Overview

Agora Chat is a highly reliable global communication platform where your users can chat one-to-one, in groups, or in chat rooms. Users can communicate with text messages and can share images, audio clips, videos, files, emojis, and locations. Agora Chat supplies typing indicators out-of-the-box. 

The Agora platform supplies a low-latency, high-concurrency, and secure cloud service for your user conversations. In addition to being asynchronous and stateless, it supports cluster service, horizontal scaling, and peak traffic handling.

Stop reinventing the wheel and spending valuable engineering resources on building a chat infrastructure yourself, Agora Chat has your in-app chat system covered. The Web, Android, and iOS SDKs plus the REST API enable you to easily integrate Agora Chat into your client apps. This leaves you free to focus on building and optimizing your business logic for your app.

Feel like making your own app? Refer to the [Quickstart Guides](./agora_chat_get_started_android) to rapidly integrate Agora Chat into your app. 

## App features

Agora Chat delivers the following features:

### Rich message types

Agora Chat supports the following message types in one-to-one and group chat:

- Text - simple text, hyperlinks, and emojis.
- Image - thumbnails are downloaded automatically by the receiver app. 
- Audio - downloaded automatically by the receiver app.
- Video - video thumbnails are downloaded automatically by the receiver app.
- File - download a file as an attachment.
- Location - [geographical coordinates](https://en.wikipedia.org/wiki/Geographic_coordinate_system) and addresses.
- CMD - send a signalling message. A CMD is stored in the local database. It is not displayed in a conversation, and cannot be sent as a push notification when the receiver is offline. 
- Custom - create a message type that is unique to your product.

<a name="one-to-one-chat"></a>
### One-to-one chat

Agora Chat provides online and offline messages in conversations. This entire message history can be downloaded. Users can acknowledge message receipt, recall, and delete messages; they can also change the name of the other participant in the conversation. 

### Multi-device login

One account logs your users into Agora Chat on multiple devices concurrently. All messages are synchronized between all devices.

### User management

Each user manages their own:

- Profile - add a personal avatar, nickname, mail, birthday, signature, and custom properties.
- Contacts - invite, add, and remove friends. Control a block list that prevents users in the list from adding you as a contact or sending you messages. 
- Group memberships - accept and decline group invitations. Join and leave groups.

### Groups and chat rooms

Apart from [one-to-one-chat](#one-to-one-chat), the Agora Chat SDK provides group and chat room support as well. This includes:

- Lifecycle - create and delete groups, update the group name, description and subject.
- Membership - set a group to be invitation only, or open to everyone. Add and remove users to the group, and stop unwanted users from joining the group.
- Roles - each user in a group is either a member, an admin, or one of the owners. Permissions are different for each role.   
- Announcements - publishing group announcements.
- Block list - block users in a group. 

When a member of the group is offline, new messages to the group are sent to the offline member using push notifications. 


### Message recall

Agora Chat enables users to recall a message from one-to-one, chat room, and group conversations.

### Push notifications

When your app is either running in the background or the process terminated, or the user is offline, incoming messages are forwarded to a third-party push server. As soon as the user comes back online, all undelivered messages are pushed to mobile devices the app is installed on. 

Push notifications for Android are implemented using [Firebase Cloud Messaging (FCM)](https://pub.dev/packages/firebase_messaging), iOS notifications are sent using the [Apple Push Notification service (APNs)](https://pub.dev/packages/flutter_apns).

### Message synchronization between multiple devices

All messages are stored in Agora Chat servers. Messages sent and received from multiple devices that use the same account are completely synchronized.


## Platform advantages

As well as the rich features supplied by Agora Chat SDK, the Agora platform gives your app the following advantages:

### Ultra low latency

With the engine and algorithms developed by Agora, Agora Chat reduces the transmission of redundant data and delivers latency as low as 100 ms. This enables smooth real-time communication that uses less bandwidth. Agora Chat is deployed across the globe. Strategies such as proximity access and smart routing ensure a smooth user experience for all regions.

### Stability and reliability

Agora Chat's globally distributed and clustered server system, backup and disaster recovery plans work together to guarantee the high availability of the Agora Chat service.

### Multi-platform support and easy integration

Agora Chat supports the following major platforms: Android, iOS, and Web. You can easily integrate Agora Chat into your app.

### Pricing

Agora Chat offers four competitive pricing and transparent billing. You enjoy a generous amount of cost-free usage every month; if your usage exceeds this threshold, you can pay as you go. The more you use, the larger your discount. See [Pricing](./agora_chat_pricing) for details.


## Supported platforms

Agora Chat is supported on major platforms such as Android, iOS, and Web, and it allows for cross-platform connections. The minimum version requirements are as follows:

| Platform | Minimum required version                                     |
| :------- | :----------------------------------------------------------- |
| Android  | Android 4.4 or later (API Level 19 or later)                 |
| iOS      | iOS 9.0 or later                                             |
| Web      | <li>Internet Explorer 9 or later</li><li>FireFox 10 or later</li><li>Chrome 54 or later</li><li>Safari 6 or later</li><li>Edge 12 or later</li><li>Opera 58 or later</li> |


## RTM and Chat comparison

The following table compares Real-time Messaging (RTM) and Chat:

|          | RTM   | Chat   |
| :------- | :---------------- | :----------------- |
| Technical architecture | A distributed system where data can be processed and switched on edge nodes.   | A centralized system where data is processed and switched on the central node.  |
| Product positioning | A highly reliable synchronization and transportation service for signals, messages, and statuses that features low latency and high concurrency. | A highly interactive instant messaging service that provides contact management, multimedia messages, chat rooms, chat groups, data storage, and content moderation.  |
| Latency performance | Ultra-low latency: < 100 ms. | Low latency: 200 ms - 400 ms. |
| Applicable scenarios |<li>Online education with collaborative operations of teacher and students on slides and other elements<li>Real-time data synchronization of the statuses, positions, and attributes from players.<li>Virtual gifting for live-streamers.<li>Data report by IoT sensors.<li>Call invitations and host management in voice calls and video calls. | <li>Instant messaging for business.<li>Group chats in games.<li>Interactive chats in live-streaming channels. |

In a nutshell, RTM is widely used in multiple scenarios, whereas Chat targets the instant messaging scenario by providing mature SDK integration and versatile user experience.

In addition to the applicable scenarios stated above, RTM and Chat have overlapped applicable scenarios such as bullet screen. Whether to use RTM or Chat requires a comprehensive evaluation according to your business demands and subsequent extensions.