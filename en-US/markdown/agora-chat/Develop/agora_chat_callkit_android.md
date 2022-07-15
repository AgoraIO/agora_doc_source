AgoraChatCallKit is an open-source audio and video UI library developed based on Agora's real-time communications and signaling services. With this library, you can implement audio and video calling functionalities with enhanced synchronization between multiple devices. In scenarios where a user ID is logged in to multiple devices, once the user deals with an incoming call that is ringing on one device, all the other devices stop ringing simultaneously.

This page describes how to implement real-time audio and video communications using the AgoraChatCallKit.

## Understand the tech

The basic process for implementing real-time audio and video communications with AgoraChatCallKit is as follows:

1. Initialize AgoraChatCallKit by calling `init` and add the `AgoraChatCallKit` event listener by calling `setCallKitListener`.
2. Call `startSingleCall` or `startInviteMultipleCall` on the caller's client to send a call invitation for one-to-one or group calls.
3. On the callee's client, accept or decline the call invitation after receiving `onReceivedCall`. Once a user accepts the invitation, they enter the call.
4. When the call ends, the SDK triggers the `onEndCallWithReason` callback.

## Prerequisites

Before proceeding, ensure that your development environment meets the following requirements:

- [Java Development Kit](https://www.oracle.com/java/technologies/downloads/) 1.8 or later.
- Android Studio 3.5 or later.
- `targetSdkVersion` 30.
- `minSdkVersion` 21.
- Gradle 4.6 or later.
- An Agora Chat project that has integrated the Chat SDK and implemented the [basic real-time chat functionalities](./agora_chat_get_started_android?platform=Android), including users logging in and out and sending and receiving messages.

## Project setup

Take the following steps to integrate the AgoraChatCallKit into your project and set up the development environment.

1. Add the dependency

    AgoraChatCallKit is developed upon `io.agora.rtc:chat-sdk:x.x.x` (1.0.5 and later) and `io.agora.rtc:full-rtc-basic:x.x.x` (3.6.2 and later). Follow the steps to add AgoraChatCallKit using Gradle.

    In `/Gradle Scripts/build.gradle(Module: <projectname>.app)`, add the following lines to integrate the AgoraChatCallKit into your Android project:

    ```java
    implementation 'io.agora.rtc:chat-callkit:1.0.1'
    ```

2. Add project permissions

    In `/app/Manifests/AndroidManifest.xml`, add the following permissions after `</application>`:

    ```xml
    <!-- Add alert window -->
    <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
    <!-- Access to the internet -->
    <uses-permission android:name="android.permission.INTERNET" />
    <!-- Access to the microphone -->
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <!-- Access to the camera -->
    <uses-permission android:name="android.permission.CAMERA" />
    <!-- Access to the tasks -->
    <uses-permission android:name="android.permission.REORDER_TASKS" />
    ```

3. Add the AgoraChatCallKit Activity

    In `/app/Manifests/AndroidManifest.xml`, add activities for the one-to-one audio and video call, and the group video call, for example, `CallSingleBaseActivity` (inherited from `EaseCallSingleBaseActivity`) and `CallMultipleBaseActivity` (inherited from `EaseCallMultipleBaseActivity`).

    ```xml
    <activity
        android:name=".av.CallSingleBaseActivity"
        android:configChanges="orientation|keyboardHidden|screenSize"
        android:excludeFromRecents="true"
        android:label="@string/demo_activity_label_video_call"
        android:launchMode="singleInstance"
        android:screenOrientation="portrait" />
    <activity
        android:name=".av.CallMultipleBaseActivity"
        android:configChanges="orientation|keyboardHidden|screenSize"
        android:excludeFromRecents="true"
        android:label="@string/demo_activity_label_multi_call"
        android:launchMode="singleInstance"
        android:screenOrientation="portrait" />
    ```

## Implement audio and video calling

This section introduces the core steps for implementing audio and video calls in your project.

### Initialize AgoraChatCallKit

Call `init` to initialize the AgoraChatCallKit after the Chat SDK is initialized. You can also add callback events to listen for and set the configurations. Refer to the following sample code:


```java
// Construct the CallKitConfig class.
EaseCallKitConfig callKitConfig = new EaseCallKitConfig();
// Set the call out time (ms).
callKitConfig.setCallTimeOut(30 * 1000);
// Set the Agora App ID.
callKitConfig.setAgoraAppId("******");
// Set whether to enable token authentication.
callKitConfig.setEnableRTCToken(true);
// Set the default avatar.   
callKitConfig.setDefaultHeadImage(getUsersManager().getCurrentUserInfo().getAvatar());
// Set the ringtone file.   
String ringFile = EaseFileUtils.getModelFilePath(context,"huahai.mp3");
callKitConfig.setRingFile(ringFile);
// Set the user information.
Map<String, EaseCallUserInfo> userInfoMap = new HashMap<>();
userInfoMap.put("***",new EaseCallUserInfo("****",null));
userInfoMap.put("***",new EaseCallUserInfo("****",null));
callKitConfig.setUserInfoMap(userInfoMap);
// Call init to initialie EaseCallKit.
EaseCallKit.getInstance().init(context, callKitConfig);
// Register the activity added in the Manifest file.
EaseCallKit.getInstance().registerVideoCallClass(CallSingleBaseActivity.class);
EaseCallKit.getInstance().registerMultipleVideoClass(CallMultipleBaseActivity.class);
// Add event listeners to the AgoraChatCallKit.
addCallkitListener();
```

In this method, you need to set the `EaseCallKitConfig` class. Some of the configurations include the following:

```java
/**
 * The EaseCallKitConfig class. 
 * @param defaultHeadImage The default avatar. Set it as the absolute path of a local file or a URL.
 * @param userInfoMap      The dictionary of the user information. The data format is key-value pairs, where key represents the user ID and value is EaseCallUser.
 * @param callTimeOut      The timeout duration for the call invitation, in miliseconds. The default value is 30 seconds.
 * @param agoraAppId       The Agora App ID.
 * @param ringFile         The ringtone file, represented by the absolute path of a local file.  
 * @param enableRTCToken   Whether to enable token authentication for using the RTC service. If you enabled token authentication in Agora Console, set this parameter as true. The default value is false. 
  */
  public class EaseCallKitConfig {
    private String defaultHeadImage;
    private Map<String, EaseCallUserInfo> userInfoMap = new HashMap<>();
    private String ringFile;
    private String agoraAppId;
    private long callTimeOut = 30 * 1000;
    private boolean enableRTCToken = false;
   	public EaseCallKitConfig(){
  ...
  }
```

### Send a call invitation

From the caller's client, call `startSingleCall` or `startInviteMultipleCall` to send a call invitation for a one-to-one call or group call. You need to specify the call type when calling the method.

- One-to-one audio and video call

  Call `startSingleCall` to start a one-to-one call. You need to specify the call type as an audio call or video call in this method.

    ```java
    /**
    * Starts a one-to-one call.
    * 
    * @param type The call type:
    * - SINGLE_VOICE_CALL: A one-to-one voice call.
    * - SINGLE_VIDEO_CALL: A one-to-one video call.
    * @param user The user ID of the callee. Ensure that you set this parameter.
    * @param ext  The extension information in the call invitation. Set it as null if you do not need this information.
    */
    public void startSingleCall(final EaseCallType type, final String user, final Map<String, Object> ext){}
    ```

The following screenshot gives an example of the user interface after sending a call invitation for one-to-one audio call:

<img src="https://web-cdn.agora.io/docs-files/1655258438574" style="zoom:50%;" />

- Group audio and video call

  Call `startInviteMultipleCall` to start a group call. Set the call type as audio call or video call. You can set the users you want to invite from a chat group or the contact list. Refer to `ConferenceInviteActivity` in the sample project for implementation.

    ```java
    /**
    * Starts a group call.
    * 
    * @param type The call type:
    * - SINGLE_VOICE_CALL: A one-to-one voice call.
    * - SINGLE_VIDEO_CALL: A one-to-one video call.
    * @param user The user ID of the callee. Ensure that you set this parameter.
    * @param ext  The extension information in the call invitation. Set it as null if you do not need this information.
    */
    public void startInviteMultipleCall(final EaseCallType type, final String[] users, final Map<String, Object> ext) {}
    ```

### Receive the invitation

Once a call invitaion is sent, the callee receives the invitation in the `onReceivedCall` callback.

```java
/**
 * Occurs when a call invitation is received.
 * @param callType The call type.
 * @param fromUserId The user ID of the caller.
 * @param ext The extension information in the call invitation. Set it as null if you do not need this information.
 */
void onReceivedCall(EaseCallType callType, String fromUserId, JSONObject ext);
```

If the callee is online and available for a call, you can pop out a user interface that allows the callee to accept or decline the invitation. Refer to the following screenshot to implement the interface:

<img src="https://web-cdn.agora.io/docs-files/1655258456953" style="zoom:50%;" />


### Send a call invitation during a group call

In call sessions with multiple users, these users can also send call invitations to other users. After sending the invitation, the SDK triggers the `onInviteUsers` callback in `EaseCallKitListener` on the sender's client.

```java
/**
 * Occurs when the local user sends a call invitation during a group call.
 * @param callType The call type.
 * @param existMembers The current members of the group call, excluding the local user.
 * @param ext The extension information in the call invitation. Set it as null if you do not need this information.
 */
void onInviteUsers(EaseCallType callType, String[] existMembers, JSONObject ext);
```

Refer to `io.agora.chatdemo.group.fragments.MultiplyVideoSelectMemberChildFragment` in the [sample project](https://github.com/AgoraIO-Usecase/AgoraChat-android) for the user interface of the call invitation.

### Listen for callback events

When a remote user joins the call, all the other users in the call receive the `onRemoteUserJoinChannel` callback. You need to look up the Agora Chat user ID corresponding to the Agora UID in you app server.
- If you find the Agora Chat user ID, construct the user ID to an `EaseUserAccount` object and return it to the app using the `callback` parameter in `onRemoteUserJoinChannel`. For the `callback` parameter, implement `onUserAccount` in `EaseCallGetUserAccountCallback`.
- If you fail to find the Agora Chat user ID, report the error code and descriptions using the `onSetUserAccountError` callback in the `EaseCallGetYserAccountCallback` class.

```java
/**
 * Occurs when the remote user joins the channel.
 * 
 * @param channelName The channel name.
 * @param userName The Agora Chat user ID.
 * @param uid The Agora UID.
 * @param callback The callback object.
 */
void onRemoteUserJoinChannel(String channelName, String userName, int uid, EaseCallGetUserAccountCallback callback);
```

### End the call

A one-to-one call ends as soon as one of the two users hangs up, while a group call ends only after the local user hangs up. When the call ends, the SDK triggers the `onEndCallWithReason` callback.

```java
/**
 * Occurs when a call ends.
 * @param callType The call type.
 * @param channelName The channel name.
 * @param reason The reason why the call ends.
 * @param callTime The call duration.
 */
void onEndCallWithReason(EaseCallType callType, String channelName, EaseCallEndReason reason, long callTime);

// The reasons for a call ending. 
public enum EaseCallEndReason {
    EaseCallEndReasonHangup(0), // One of the call members hangs up.
    EaseCallEndReasonCancel(1), // The local user cancels the call. 
    EaseCallEndReasonRemoteCancel(2), // The remote user cancels the call.
    EaseCallEndReasonRefuse(3),// The remote user rejects the call.
    EaseCallEndReasonBusy(4), // The remote user is busy.
    EaseCallEndReasonNoResponse(5), // The local user did not answer the phone.
    EaseCallEndReasonRemoteNoResponse(6), // The remote user did not answer the phone.
    EaseCallEndReasonHandleOnOtherDeviceRefused(7),// The call is rejected on another device.
    EaseCallEndReasonHandleOnOtherDeviceAgreed; // The call is answered on another device.
   ....
}
```

## Next steps

This section contains extra steps you can take for the audio and video call functionalities in your project.

### Call exceptions

If exceptions or errors occur during a call, the SDK triggers the `onCallError` callback in the `EaseCallKitListener` class, which reports the detailed information of the exception in `AggoraChatCallError`. 

```java
/**
 * Reports call exceptions.
 * @param type        The error type.
 * @param errorCode   The error code.
 * @param description The error description.
 */
void onCallError(EaseCallError type, int errorCode, String description);
```

Types of call errors are as follows:

```java
public enum EaseCallError {
    // The process error.
    PROCESS_ERROR,
    // The RTC service error.
    RTC_ERROR,
    // The IM service error.
    IM_ERROR
}
```

### Update the call kit configuration

After initializing the AgoraChatCallKit, you can refer to the following sample code to update the configuration of the call kit:

```java
/**
 * Gets the current call kit configuration.
 *
 * @return The current call kit configuration.
 */
public EaseCallKitConfig getCallKitConfig();
// Sets the default avatar.
EaseCallKitConfig config = EaseCallKit.getInstance().getCallKitConfig();
	if(config != null){
    String Image = EaseFileUtils.getModelFilePath(context,"bryant.png"……);
    callKitConfig.setDefaultHeadImage(Image);
}
```

### Update the user avator or nickname

When changes to the UI or the channel state occur, for example, when a new user joins the channel, `onUserInfoUpdated` is triggered to notify the app to update the UI.

After a user updates the user information, call `io.agora.chat.callkit.general.EaseCallKitConfig#setUserInfo` to set the modified user information. Ensure that this method is implemented in a synchronous function so that the UI is updated timely.

```java
/**
 * \~chinese
 * Occurs when the user information is updated.
 * @param userName The Agora Chat user ID.
 */
void onUserInfoUpdate(String userName){
    // For example,
    /**
    EaseUser user = mUsersManager.getUserInfo(userName);
    EaseCallUserInfo userInfo = new EaseCallUserInfo();
        if (user != null) {
            userInfo.setNickName(user.getNickname());
            userInfo.setHeadImage(user.getAvatar());
        }
    EaseCallKit.getInstance().getCallKitConfig().setUserInfo(userName, userInfo);
    */
}
```

### Authenticate users with the RTC token

To enhance communication security, Agora recommends that you authenticate app users with the RTC token before they join a call. To do this, you need to make sure that the [Primary Certificate of your project is enabled](https://docs.agora.io/en/All/faq/appid_to_token), and `setEnableRTCToken` in the AgoraChatCallKit is set to `true`.

```java
EaseCallKitConfig callKitConfig = new EaseCallKitConfig();
 ……
 callKitConfig.setEnableRTCToken(true);
 ……
 EaseCallKit.getInstance().init(context, callKitConfig);
```

Once you enable token authentication, the SDK triggers the `onGenerateRTCToken` callback. You need to retrieve an RTC token in this callback following the steps:

1. Retrieve the RTC token and Agora UID from your app server.
2. Trigger `onSetToken` to pass the token and UID to the callback object.
3. AgoraChatCallKit uses the token and UID to join the channel.

Tokens are generated on your app server using the token generator provided by Agora. For how to generate a token on the server and retrieve and renew the token on the client, see [Authenticate Your Users with Tokens](https://docs.agora.io/en/Video/token_server?platform=android).


```java
/**
 * Occurs when RTC token authentication is enabled.
 * 
 * @param userId       The Agora Chat user ID of the current user.
 * @param channelName  The channel name.
 * @param callback     The callback object.
 */
default void onGenerateRTCToken(String userId, String channelName, EaseCallKitTokenCallback callback) {
    // Pass the token and UID to the callback object.
    // callback.onSetToken(token, uid);
}
```

### Push notifications

In scenarios where the app runs on the background or goes offline, use push notifications to ensure that the callee receives the call invitation. To enable push notifications, see [Set up push notifications](./agora_chat_push_android?platform=Android). 

Once push notifications are enabled, when a call invitation arrives, a notification message pops out on the notification panel. Users can click the message to see the call invitation.

## Reference

This section provides other reference information that you can refer to when implementing real-time audio and video communications functionalities.

### API list

The AgoraChatCallKit provides the following APIs:

| Method | Description |  
| ---- | ---- |
| init | Initializes AgoraChatCallKit. |  
| setCallKitListener | Sets the event listener of the call kit. |
| startSingleCall | Starts a one-to-one call. | 
| startInviteMultipleCall  | Starts a group call. |
| getCallKitConfig | Retrieves the configurations of AgoraChatCallKit. |
| registerVideoCallClass | Registers a one-to-one video call class. |
| registerMultipleVideoClass | Registers a group video call class. |

`EaseCallKitListener` provides the following callback events:

| Event | Description |
| ---- | ---- |
| onEndCallWithReason | Occurs when the call ends. |
| onInviteUsers | Occurs when a member of the group call invites other users to the call. |
| onReceivedCall | Occurs when the call invitation is received and the device rings. |
| onGenerateToken | Requests the RTC token. You need to pass the token to AgoraChatCallKit with callbacks. |
| onCallError | Reports exceptions and errors during the call. |
| onInviteCallMessageSent | Occurs when the call invitation is sent. |
| onRemoteUserJoinChannel | Occurs when a remote user joins the call. |
| onUserInfoUpdated | Occurs when the user information is updated. This callback is triggered when changes occur to the UI or the channel state in the AgoraChatCallKit. |

`EaseCallGetUserAccountCallback` contains the following APIs:

| Event | Description |
| --- | --- |
| onUserAccount | Occurs when the Agora Chat user ID correspondting to the Agora UID is retrieved. |
| onSetUserAccountError | Occurs when the app fails to retrieve the user account. |

`EaseCallKitTokenCallback` contains the following APIs:

| Event | Description |
| --- | --- |
| onSetToken | Occurs when the app passes the retrieved RTC token to the AgoraChatCallKit. |
| onGetTokenError | Occurs when the app fails to get the RTC token. |


### Sample project

Agora provides an open-source [AgoraChat-android](https://github.com/AgoraIO-Usecase/AgoraChat-android) sample project on GitHub. You can download the sample to try it out or view the source code.

The sample project uses the Agora Chat user ID to join a channel, which enables displaying the user ID in the view of the call. If you use the methods of the Agora RTC SDK to start a call, you can also use the Integer UID to join a channel.

