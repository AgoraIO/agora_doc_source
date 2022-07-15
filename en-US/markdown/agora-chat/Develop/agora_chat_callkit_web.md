AgoraChatCallKit is an open-source audio and video UI library developed based on Agora's real-time communications and signaling services. With this library, you can implement audio and video calling functionalities with enhanced synchronization between multiple devices. In scenarios where a user ID is logged in to multiple devices, once the user deals with an incoming call that is ringing on one device, all the other devices stop ringing simultaneously.

This page describes how to implement real-time audio and video communications using the AgoraChatCallKit.

## Understand the tech

The basic process for implementing real-time audio and video communications with AgoraChatCallKit is as follows:

1. Initialize AgoraChatCallKit by calling `init`.
2. Call `startCall` on the caller's client to send a call invitation for one-to-one or group calls.
3. On the callee's client, accept or decline the call invitation after receiving `onInvite`. Once a user accepts the invitation, they enter the call.
4. When the call ends, the SDK triggers the `onStateChange` callback.

## Prerequisites

Before proceeding, ensure that your development environment has the following:

- A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=Android#create-an-agora-account).
- An Agora project that has [enabled Agora Chat](./enable_agora_chat?platform=Web).
- An Agora Chat project that has integrated the Chat SDK and implemented the [basic real-time chat functionalities](./agora_chat_get_started_web?platform=Web), including users logging in and out and sending and receiving messages.

## Project setup

Take the following steps to download and import AgoraChatCallKit into your project

1. In your terminal, run the following command to install the call kit:

   ```bash
   npm install AgoraChatCallKit
   ```

2. Add the following line to import the callkit:

   ```javascript
   import Callkit from 'chat-callkit';
   ```

## Implement audio and video calling

This section introduces the core steps for implementing audio and video calls in your project.

### Initialize AgoraChatCallKit

Call `init` to initialize the AgoraChatCallKit.

```javascript
/**
 * Initialize AgoraChatCallKit
 *
 * @param appId       The Agora App ID.
 * @param agoraUid    The Agora user ID (UID).
 * @param connection  The Agora Chat SDK Connection instance.
 */
CallKit.init(appId, agoraUid, connection);
```

### Send a call invitation

From the caller's client, call `startCall` to send a call invitation for a one-to-one call or group call. You need to specify the call type when calling the method.

- One-to-one call

  In a one-to-one call, the caller sends a text message to the callee as the call invitation.

    ```javascript
    let options = {
        /** The call type:
         * 0: One-to-one audio call
         * 1: One-to-one video call
         * 2: Group video call
         * 3: Group audio call
         */
        callType: 0, 
        chatType: 'singleChat',
        /** The Agora Chat user ID. */
        to: 'userId',
        /** The invitation message. */
        message: 'Join me on the call', 
        /** The channel name for the call. */
        channel: 'channel',
        /** The Agora RTC token. */
        accessToken: 'Agora token',
    };
    CallKit.startCall(options);
    ```

- Group call

  In a group call, the caller sends a text message to the chat group or chat room, while sending a CMD message to the users for joining the call.

    ```javascript
    let options = {
        /** The call type:
         * 0: One-to-one audio call
         * 1: One-to-one video call
         * 2: Group video call
         * 3: Group audio call
         */
        callType: 2,
        chatType: 'groupChat', 
        /** The Agora Chat user ID. */
        to: ['userId'], 
        /** The invitation message. */
        message: 'Join me on the call',
        /** The group ID. */
        groupId: 'groupId',
        /** The group name. */
        groupName: 'group name',
        /** The Agora RTC token. */
        accessToken: 'Agora token',
        /** The channel name for the call. */
        channel: 'channel',
    };
    CallKit.startCall(options);
    ```

The following screenshot gives an example of the user interface after sending a call invitation for one-to-one video call:

![](https://web-cdn.agora.io/docs-files/1655259671848)

### Receive the invitation

Once a call invitaion is sent, if the callee is online and available for a call, the callee receives the invitation in the `onInvite` callback. You can pop out a user interface that allows the callee to accept or decline the invitation in this callback.

```javascript
/**
 * Handles the call invitation.
 * 
 * @param result Whether to pop out the user interface for answering the call.
 *               - true: Yes.
 *               - false: No. In this situation, you do not need to pass the RTC token.
 * @param accessToken The Agora RTC token.
 */
CallKit.answerCall(result, accessToken);
```

The following screenshot gives an example of the user interface after receiving a call invitation for one-to-one video call:

![](https://web-cdn.agora.io/docs-files/1655259682186)


### Send a call invitation during a group call

In call sessions with multiple users, these users can also send call invitations to other users. After sending the invitation, the SDK triggers the `onAddPerson` callback on the sender's client. In this callback, you can ask the senders to specify the user they want to invite to the group call and then call `startCall` to send out the invitation.


### Listen for callback events

During the call, you can also listen for the following callback events:

```javascript
function Call() {
	// Handles call state changes.
	const handleCallStateChange = (info) => {
		switch (info.type) {
			case 'hangup':
				// The call is hung up.
				break;
			case 'accept':
				// The callee accepts the call invitation.
				break;
			case 'refuse':
				// The callee refuses the call invitation.
				break;
			case 'user-published':
				// A remote user publishes media streams during the call.
				break;
			case 'user-unpublished':
				// A remote user stops publishing media streams during the call.
				break;
			case 'user-left':
				// A remote user leaves the call.
				break;
			default:
				break;
		}
	};
	return <Callkit onStateChange={handleCallStateChange} />;
}
```

### End the call

A one-to-one call ends as soon as one of the two users hangs up, while a group call ends only after the local user hangs up. If the local user hangs up the call, the SDK triggers `onStateChange` with the `info.type` of `hangup`. If the remote user hangs up the call, the SDK triggers `onStateChange` with the `info.type` of `user-left`.

## Next steps

This section contains extra steps you can take for the audio and video call functionalities in your project.

### Authenticate users with the RTC token

To enhance communication security, Agora recommends that you authenticate app users with the RTC token before they join a call. To do this, you need to make sure that the [Primary Certificate of your project is enabled](https://docs.agora.io/en/All/faq/appid_to_token).


Tokens are generated on your app server using the token generator provided by Agora. After you retrieve the token, pass the token to the callkit when calling `startCall` and `answerCall`. For how to generate a token on the server and retrieve and renew the token on the client, see [Authenticate Your Users with Tokens](https://docs.agora.io/en/Video/token_server?platform=Web).

## Reference

This section provides other reference information that you can refer to when implementing real-time audio and video communications functionalities.

### API list

AgoraChatCallKit provides the following APIs:

Methods:

| Method | Description |  
| ---- | ---- |
| initWithConfig:delegate | Initializes AgoraChatCallKit. |  
| startCall | Starts a call. | 
| answerCall  | Answers the call. |
| setUserIdMap | Sets the mapping between Agora Chat user ID and Agora user ID (UID). The format is `{[uid1]: 'custom name', [uid2]: 'custom name'}`. |  

Callbacks:

| Event | Description |
| ---- | ---- |
| onAddPerson | Occurs when the user invites another user to the call. |
| onInvite | Occurs when the call invitation is received. |
| onStateChange | Occurs when the call state changes. |

Attributes

| Attribute | Description |
| --- | --- |
| contactAvatar | The avatar displayed during one-to-one calls. |
| groupAvatar | The avatar displayed during group calls.

### Sample project

Agora provides an open-source [AgoraChatCallKit](https://github.com/AgoraIO-Usecase/AgoraChat-CallKit-web/tree/master/demo) sample project on GitHub. You can download the sample to try it out or view the source code.

The sample project uses the Agora Chat user ID to join a channel, which enables displaying the user ID in the view of the call. If you use the methods of the Agora RTC SDK to start a call, you can also use the Integer UID to join a channel.
