
[COMPANY]: Agora
[CHAT]: 'AgoraChat'
[PLATFORM]: "AgoraPlatform"

# [CHAT] overview

[CHAT] is a highly reliable global communication platform where your users can chat one-to-one, in groups or in chat rooms. Users communicate with text messages, they can share images, audio, video, files, emojis, and locations. [CHAT] supplies typing indicators out-of-the-box. 

The [PLATFORM] supplies a low-latency, high-concurrency, and secure cloud service for your user conversations. [PLATFORM] is asynchronous and stateless; it supports cluster service, horizontal scaling and peak traffic handling. 

![Agora Chat architecture](./images/chat-architecture.png)

Stop reinventing the wheel and spending valuable engineering resources on building a chat infrastructure yourself, [CHAT] has your in-app chat system covered. The [Web](<add link>), [Android](<add link>), and [iOS](<add link>) SDKs plus the [REST API](<add link>) enable you to easily integrate [CHAT] into your client apps. This leaves you free to focus on building and optimizing your business logic your app.

Want to experience what [CHAT] can do? Click the [Online demo](<add link>).
Feel like making your own app? Use the [Quickstart Guide](<add link>) to rapidly integrate [CHAT] into your app. 

## App features

[CHAT] delivers the following features:

### Rich message types

[CHAT] supports the following message types in one-to-one and group chat:

- Text - simple text that can including hyperlinks and emojis.
- Image - thumbnails are downloaded automatically by the receiver app. 
- Audio - downloaded automatically by the receiver app.
- Video - video thumbnails are downloaded automatically by the receiver app.
- File - download a file as an attachment.
- Location - [geographical coordinates](https://en.wikipedia.org/wiki/Geographic_coordinate_system) and addresses.
- CMD - send a signalling message. A CMD is not displayed in a conversation, stored in the local database, and cannot be sent as a push notification when the receiver is offline. 
- Custom - create a message type unique to your product.


### One-to-one chat

[CHAT] supplies online, and offline messages in managed conversations. This entire message history can be downloaded when users change mobile device. Users can acknowledge message receipt, recall, and delete messages; they can also change the name of the other participant in the conversation. 

### Multi-device login

One account logs your users into [CHAT] on multiple devices concurrently. All messages are synchronized between all devices.

### User management

Each user manages their own:

- Profile - add a personal avatar, nickname, mail, birthday, signature, and custom properties.
- Contacts - invite, add and remove friends. Control an excludelist for people who you have no desire to be friends with. 
- Group memberships - accept and decline group invitations. Join and leave groups.

### Groups and chat rooms

As well as the features supplied for [one-to-one-chat](#one-to-one-chat), [CHAT] has complete group and chat room management capabilities. This includes:

- Lifecycle - create and delete groups, update the group name, description and subject.
- Membership - set a group to be invitation only, or open to everyone. Add and remove users to the group, and stop unwanted users from joining the group.
- Roles - each user in a group is either a member, an administrator, or one of the owners. Permissions are different for each role.   
- Announcements - publishing group announcements.
- Excludelist - block users in a group. You can also configure an authorization strategy for users who wish to join the group. 

When the member of a group is offline, new messages to the group are sent to the offline member using push notifications. 


### Message recall

[CHAT] enables users to recall a message from one-to-one, chat room, and group conversations.

### Push notifications

When your app is either running in the background or the process terminated, the user is offline. As well as being stored in [CHAT], incoming messages are forwarded to a third-party push server. As soon as the user comes back online, all undelivered messages are pushed to mobile devices the app is installed on. 

Push notifications for Android are implemented using **[Firebase Cloud Messaging (FCM)](https://pub.dev/packages/firebase_messaging)**, iOS notifications are sent using the **[Apple Push Notification service (APNs)](https://pub.dev/packages/flutter_apns)**.

### Message synchronization between multiple devices

All messages are stored in [CHAT] servers. Messages sent and received from multiple devices that use the same account are completely synchronized.


## Platform advantages

As well as the rich features supplied by [CHAT] SDK, the [COMPANY] platform gives your app the following advantages:

### Ultra low latency

With the engine and algorithms developed by [COMPANY], [CHAT] reduces the transmission of redundant data and delivers latency as low as 100 ms. This enables smooth real-time communication that uses less bandwidth. [CHAT] is deployed across the globe. Strategies such as proximity access and smart routing ensure a smooth user experience for all regions.

### Stability and reliability

[COMPANY]'s globally distributed and clustered server system, backup and disaster recovery plans work together to guarantee the high availability of the [CHAT] service.

### Multi-platform support and easy integration

[CHAT] supports the following major platforms: Android, iOS, and Web. You easily integrate [CHAT] into your app with a few lines of code.

### Pricing

[CHAT] offers competitive pricing and transparent billing. You enjoy a generous amount of cost-free usage every month; if your usage exceeds this threshold, you can pay as you go. The more you use, the larger your discount. See [Pricing](<link to pricing page>) for details.


## Supported platforms

[CHAT] is supported on major platforms such as Android, iOS, and Web, and it allows for cross-platform connections. The minimum version requirements are as follows:

| Platform | Minimum required version                                     |
| :------- | :----------------------------------------------------------- |
| Web      | <li>Google Chrome 58 or later<li>Safari 11 or later (macOS 10 or later) |
| Android  | Android 4.4 or later (API Level 19 or later)                 |
| iOS      | iOS 9.0 or later                                             |

