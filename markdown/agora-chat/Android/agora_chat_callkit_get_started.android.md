# 实现音视频通话

AgoraChatCallKit 是一套基于声网的实时通讯和信令服务开发的开源音视频 UI 库。该库可实现音视频通话功能，提升多种服务之间的同步。同时，用户在多个设备登录时能同步处理呼叫振铃，即当用户在一台设备上处理振铃后，其他设备自动停止振铃。

本文展示如何使用 AgoraChatCallKit 快速构建实时音视频场景。

## 实现原理

使用 AgoraChatCallKit 实现音视频通话的基本流程如下：

1. 调用 `init` 初始化 AgoraChatCallKit，并调用 `setCallKitListener` 设置 AgoraChatCallKit 监听器。
2. 主叫方调用 `startSingleCall` 或 `startInviteMultipleCall` 发起一对一通话或多人通话的呼叫邀请。
3. 被叫方收到 `onReceivedCall` 回调，选择是否接听来电。接听来电后，进入通话。
4. 结束通话时，SDK 触发 `onEndCallWithReason` 回调。

## 前提条件

开始前，请确保你的项目满足如下条件：

- [Java 开发工具包](https://www.oracle.com/java/technologies/downloads/) 1.8 或以上版本;
- Android Studio 3.5 或以上版本；
- Gradle 4.6 或以上版本；
- targetSdkVersion 30；
- minSdkVersion 21；
- 集成了 Chat SDK 的即时通讯 IM 项目，实现了基本的实时聊天功能，包括用户的登录和注销、消息的发送和接收。

## 项目设置

参考如下步骤，将 AgoraChatCallKit 集成到你的项目中，并配置开发环境。

1. 集成依赖库

AgoraChatCallKit 主要依赖于 `io.agora.rtc:chat-sdk:x.x.x` (1.0.5 及以上版本) 和 `io.agora.rtc:full-rtc-basic:x.x.x`（3.6.2 及以上版本）开发。按照步骤使用 Gradle 添加 AgoraChatCallKit。

在 `/Gradle Scripts/build.gradle(Module: <projectname>.app)` 中，添加以下代码将 AgoraChatCallKit 集成到你的 Android 项目中：

```java
implementation 'io.agora.rtc:chat-callkit:1.0.1'
```

2. 添加项目权限

在 `/app/Manifests/AndroidManifest.xml` 中，在 </application> 后面添加以下权限：

```java
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.hyphenate.easeim">

    <!-- 添加悬浮窗权限 -->
    <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
    <!-- 添加访问网络权限.-->
    <uses-permission android:name="android.permission.INTERNET" />
    <!-- 添加麦克风权限 -->
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <!-- 添加相机权限 -->
    <uses-permission android:name="android.permission.CAMERA" />
    <!-- 添加任务栈权限 -->
    <uses-permission android:name="android.permission.REORDER_TASKS" />
    ...

</manifest>
```

3. 添加 AgoraChatCallKit 活动

在清单中增加 AgoraChatCallKit 中的 `EaseVideoCallActivity` 和 `EaseMultipleVideoActivity`:

在 `/app/Manifests/AndroidManifest.xml` 中，添加一对一音视频通话和多人视频通话的活动，例如 `CallSingleBaseActivity`（继承自 `EaseCallSingleBaseActivity`）和 `CallMultipleBaseActivity`（继承自 `EaseCallMultipleBaseActivity`）。

```java
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

## 实现音视频通话

参考如下步骤在项目中实现一对一实时音视频通话。

### 初始化 AgoraChatCallKit

在即时通讯 IM SDK 初始化完成后，可以调用 `init` 方法初始化 AgoraChatCallKit，同时添加回调事件对配置进行监听和设置。示例代码如下：

```java
//构建配置信息类。
EaseCallKitConfig callKitConfig = new EaseCallKitConfig();
//设置呼叫超时时间，单位为毫秒。
callKitConfig.setCallTimeOut(30 * 1000);
//设置声网的 App ID。
callKitConfig.setAgoraAppId("******");
//设置是否开启 RTC token 验证。
callKitConfig.setEnableRTCToken(true);
//设置默认头像。    
callKitConfig.setDefaultHeadImage(getUsersManager().getCurrentUserInfo().getAvatar());
//设置振铃文件。   
String ringFile = EaseFileUtils.getModelFilePath(context,"huahai.mp3");
callKitConfig.setRingFile(ringFile);
//设置用户信息。
Map<String, EaseCallUserInfo> userInfoMap = new HashMap<>();
userInfoMap.put("***",new EaseCallUserInfo("****",null));
userInfoMap.put("***",new EaseCallUserInfo("****",null));
callKitConfig.setUserInfoMap(userInfoMap);
//初始化 `EaseCallKit` 类。
EaseCallKit.getInstance().init(context, callKitConfig);
//注册 Manifest 中添加的活动。
EaseCallKit.getInstance().registerVideoCallClass(CallSingleBaseActivity.class);
EaseCallKit.getInstance().registerMultipleVideoClass(CallMultipleBaseActivity.class);
//添加 AgoraChatCallKit 通话过程中的事件监听器。
addCallkitListener();
```

在该方法中，您需要设置 `EaseCallKitConfig` 类。其中一些配置如下：

```java
/**
 * `EaseCallKitConfig` 类中相关的用户配置选项： 
 * @param defaultHeadImage 用户默认头像。该参数的值为本地文件绝对路径或者 URL。 
 * @param userInfoMap      用户信息字典。该信息为 key-value 格式，key 为用户的即时通讯 IM 用户 ID, value 为 `EaseCallUserInfo`。
 * @param callTimeOut      呼叫超时时间，单位为毫秒，默认为 30 秒。 
 * @param agoraAppId       声网 App ID。 
 * @param ringFile         振铃文件。该参数的值为本地文件的绝对路径。  
 * @param enableRTCToken   是否开启 RTC 验证。该功能通过声网后台控制，默认为关闭。 
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

### 主叫发起通话邀请

主叫方调用 `startSingleCall` 或 `startInviteMultipleCall` 方法发起一对一通话或多人通话的邀请。你需要在调用方法中指定通话类型。

#### 一对一音视频通话

一对一通话可分为视频通话和语音通话，示例代码如下：

调用 `startSingleCall` 开始一对一通话。你需要在该方法中指定通话类型为音频通话或视频通话。

```java
/**
     * \~chinese
     * 开始一对一通话。
     * 
     * @param type 通话类型：
     * - SINGLE_VOICE_CALL：音频通话；
     * - SINGLE_VIDEO_CALL：视频通话。
     * @param user 被叫方的用户 ID，即即时通讯 IM 用户 ID。该参数必填。
     * @param ext  通话邀请中的扩展信息。若不需要，可传入 `null`。
     */
    public void startSingleCall(final EaseCallType type, final String user, final Map<String, Object> ext){}
```

下图展示发起一对一语音通话后的 UI 界面：

<img src="https://web-cdn.agora.io/docs-files/1655258438574" style="zoom:50%;" />

#### 多人音视频通话

调用 `startInviteMultipleCall` 方法发起多人通话。将通话类型设置为音频通话或视频通话。你可以设置要邀请的群组或联系人列表中的用户。参考 `ConferenceInviteActivity` 示例项目中的实现。

```java
/**
     * \~chinese
     * 邀请用户加入多人通话。
     * 
     * @param type 通话类型：
     * - CONFERENCE_VIDEO_CALL：视频通话；
     * - CONFERENCE_VOICE_CALL：音频通话。
     * @param users 受邀用户的用户 ID 列表，即即时通讯 IM 用户 ID 列表。
     * @param ext  通话邀请中的扩展信息。若不需要，可传入 `null`。
     */
    public void startInviteMultipleCall(final EaseCallType type, final String[] users, final Map<String, Object> ext) {}
```

### 被叫方收到通话邀请

主叫方发起邀请后，被叫振铃的同时会触发 `EaseCallKitListener` 中的 `onReceivedCall` 回调：

```java
 /**
     * \~chinese
     * 接收到通话邀请。
     * @param callType  通话类型。
     * @param fromUserId  邀请人的用户 ID，即即时通讯 IM 用户 ID。
     * @param ext   呼叫邀请中的扩展信息，JSONObject 类型。
     */
    void onReceivedCall(EaseCallType callType, String fromUserId, JSONObject ext);  
```

如果被叫方在线且当前不在通话中，会弹出邀请通话界面，被叫可以选择接听或者拒绝。被叫振铃的界面如下：

<img src="https://web-cdn.agora.io/docs-files/1655258456953" style="zoom:50%;" />

### 多人通话过程中发起邀请

多人通话中，当前用户可以向其他用户发起邀请。发出邀请后，SDK 会在主叫方的客户端触发 `EaseCallKitListener` 中的 `onInviteUsers` 回调：

```java
/**
     * \~chinese
     * 多人通话过程中邀请新用户加入通话时触发的回调。
     * @param callType     通话类型。
     * @param existMembers 通话中的现有用户，不包括当前用户。
     * @param ext          呼叫邀请中的扩展信息，JSONObject 类型。若不添加，可设置为 `null`。
     */
    void onInviteUsers(EaseCallType callType, String[] existMembers, JSONObject ext);
```

通话邀请界面的实现，可以参考 Demo 中的 `io.agora.chatdemo.group.fragments.MultiplyVideoSelectMemberChildFragment` 实现。

### 监听回调事件

对端用户加入通话后，当前用户及通话中其他用户会收到 `EaseCallKitListener` 中的 `onRemoteUserJoinChannel` 回调。

用户应先通过传入的参数在自己的 App Server 中查询声网 UID 对应的即时通讯 IM 用户 ID：

- 若查询成功，则将即时通讯 IM 用户 ID 封装成 {@link EaseUserAccount} 对象，并通过 `onRemoteUserJoinChannel` 中的 `callback` 参数将其返回给应用。对于 `callback` 参数，在 `EaseCallGetUserAccountCallback` 中实现 `onUserAccount`。

- 若查询失败，则调用 `EaseCallGetUserAccountCallback` 类中的 `onSetUserAccountError` 回调，传递错误码和错误描述。

```java
/**
     * \~chinese
     * 对端用户成功加入频道时的回调。
     * 
     * @param channelName 频道名称。
     * @param userName 即时通讯 IM 的用户 ID。
     * @param uid 声网 UID。
     * @param callback 回调对象。
     */
    void onRemoteUserJoinChannel(String channelName, String userName, int uid, EaseCallGetUserAccountCallback callback);
```

### 通话结束

在一对一音视频通话中，若其中一方挂断，双方的通话会自动结束。多人音视频通话场景中，用户主动挂断才能结束通话。通话结束后，SDK 会在本地触发 `onEndCallWithReason` 回调：

```java
/**
     * \~chinese
     * 通话结束回调。
     * @param callType    通话类型。
     * @param channelName 频道名称。
     * @param reason      通话结束原因。
     * @param callTime    通话时长。
     */
    void onEndCallWithReason(EaseCallType callType, String channelName, EaseCallEndReason reason, long callTime);

//通话结束原因如下：  
public enum EaseCallEndReason {
    EaseCallEndReasonHangup(0), //通话中的一方挂断。
    EaseCallEndReasonCancel(1), //本地用户已取消通话。 
    EaseCallEndReasonRemoteCancel(2), //对方取消通话。
    EaseCallEndReasonRefuse(3),//对方拒绝接听。
    EaseCallEndReasonBusy(4), //对方忙线中。 
    EaseCallEndReasonNoResponse(5), //对方未接听。
    EaseCallEndReasonRemoteNoResponse(6), //对方无响应。
    EaseCallEndReasonHandleOnOtherDeviceRefused(7),//在其他设备拒绝接听。
    EaseCallEndReasonHandleOnOtherDeviceAgreed; //在其他设备上接听。
   ....
}
```

## 后续操作

实现基础的音视频通话后，你还可以参考本节内容，在项目中实现进阶功能。

### 通话异常回调

通话过程中如果有异常或者错误发生，SDK 会触发 `EaseCallKitListener` 类中的 `onCallError` 回调。你可以通过返回的 `AgoraChatCallError` 了解具体报错的原因。

```java
/**
     * \~chinese
     * 通话异常回调。
     * @param type        错误类型，详见 {@link EaseCallError}。
     * @param errorCode   错误码，详见 {@link io.agora.chat.callkit.general.EaseCallProcessError}
     * @param description 错误描述。
     */
    void onCallError(EaseCallError type, int errorCode, String description);
    
```

`EaseCallError` 异常包括业务逻辑异常、音视频异常以及即时通讯 IM 异常。

```java
/**
 * 通话异常。
 */
public enum EaseCallError {
    PROCESS_ERROR, //业务逻辑异常。
    RTC_ERROR, //音视频异常。
    IM_ERROR  //即时通讯 IM 异常。
}
```

### 修改配置

AgoraChatCallKit 库初始化之后，可修改有关配置，示例代码如下:

```java
/**
     * \~chinese
     * 获取当前 AgoraChatCallKit 的配置。
     *
     * @return 当前 AgoraChatCallKit 配置，详见 {@link EaseCallKitConfig}。
     */
    public EaseCallKitConfig getCallKitConfig();

//设置默认头像。
 EaseCallKitConfig config = EaseCallKit.getInstance().getCallKitConfig();
	if(config != null){
     String Image = EaseFileUtils.getModelFilePath(context,"bryant.png"……);
     callKitConfig.setDefaultHeadImage(Image);
}
```

### 修改头像或昵称

当 AgoraChatCallKit 内部发生 UI 变化或者收到频道中的变化事件时，例如，有新用户加入频道时，会触发 `onUserInfoUpdate` 回调通知用户可以更新对应用户信息，使得 UI 页面最终展示用户更新后的图像或昵称。用户若没有修改需求，无需实现该方法。

用户信息修改完毕，需调用 `io.agora.chat.callkit.general.EaseCallKitConfig#setUserInfo` 将修改的用户信息进行设置。注意更新过程放在同步方法里，才能实现及时刷新页面。

```java
/**
     * \~chinese
     * 通知用户更新用户信息。

     * @param userName 用户的即时通讯 IM 的用户 ID。
     */
     void onUserInfoUpdate(String userName){
    	//示例
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

### 使用 RTC Token 鉴权

为保证通信安全，我们建议你使用声网 RTC Token 对加入音视频通话的用户进行鉴权。你需要在声网控制台[启用主要证书](https://docs.agora.io/cn/All/faq/appid_to_token)，并将并 AgoraChatCallKit 中的 `setEnableRTCToken` 设置为 `true` 启用 RTC token 验证。

下面是启用 token 验证的示例代码：

```java
EaseCallKitConfig callKitConfig = new EaseCallKitConfig();
 ……
 callKitConfig.setEnableRTCToken(true);
 ……
 EaseCallKit.getInstance().init(context, callKitConfig);

```

开启 Token 鉴权后，SDK 会触发 `onGenerateRTCToken` 回调。你需要在该回调中获取 RTC Token，具体过程如下：

1. 从自己的 App Server 中获取声网 RTC token 和 UID。

2. 触发 `onSetToken` 方法将该 token 和 UID 回调给 callback 对象。

3. AgoraChatCallKit 获得 RTC token 和 UID，加入对应的频道。

Token 是利用 Agora 提供的 Token 生成器在你自己的 App Server 上生成。关于如何在服务器生成 Token 以及在客户端获取及更新 Token，详见[使用 User Token 鉴权](https://docs.agora.io/cn/Video/token_server?platform=Android)。

下面是 `onGenerateRTCToken` 回调的示例代码：

```java
/**
     * \~chinese
     * 启用 RTC Token 验证的回调。
     * 
     * @param userId       当前用户的即时通讯 IM 的用户 ID。
     * @param channelName  频道名称。
     * @param callback     回调对象。
     */
    default void onGenerateRTCToken(String userId, String channelName, EaseCallKitTokenCallback callback) {
     //获取到 token 及 用户 ID 后，回调给 callback 对象即可。 
      //callback.onSetToken(token, uid);
    }
```

### 离线推送

当 App 在后台运行或离线时，通过推送通知确保被叫方收到通话邀请。关于开启离线推送，请参见 [开启 Android 推送](./agora_chat_push_android)。开启离线推送后，用户在离线情况下收到呼叫邀请时，其手机通知页面会弹出一条通知消息，用户可点击该消查询呼叫邀请。

## 参考

本节提供在实现音视频通话过程中，可以参考的其他内容。

### API 列表

AgoraChatCallKit 提供的 API 列表如下：

| 方法                       | 说明                           |
| :------------------------- | :----------------------------- |
| init                       | 初始化 AgoraChatCallKit。        |
| setCallKitListener         | 设置事件监听器。                     |
| startSingleCall            | 发起一对一通话。                 |
| startInviteMultipleCall    | 邀请用户加入多人通话。         |
| getCallKitConfig           | 获取 AgoraChatCallKit 相关配置。 |
| registerVideoCallClass     | 注册一对一音视频通话实现类。   |
| registerMultipleVideoClass | 注册多人音视频通话实现类。    |

回调模块 `EaseCallKitListener` 的 API 列表如下：

| 事件                    | 说明                                                         |
| :---------------------- | :----------------------------------------------------------- |
| onEndCallWithReason     | 通话结束回调。                                       |
| onInviteUsers           | 多人通话中邀请其他用户加入时触发的回调。                           |
| onReceivedCall          | 振铃时触发的回调。                                           |
| onGenerateToken         | 获取声网 token 回调。用户将获取到的 Token 回调到 AgoraChatCallKit。 |
| onCallError             | 通话异常时触发的回调。                                       |
| onInViteCallMessageSent | 发送通话邀请后触发的回调。                                           |
| onRemoteUserJoinChannel | 用户加入通话时触发该回调。                                         |
| onUserInfoUpdate        | 用户信息更新回调。当 AgoraChatCallKit 内部发生 UI 变化或者接收到频道中的一些变化事件时触发该回调。|

`EaseCallGetUserAccountCallback` 的 API 列表如下：

| 事件                  | 说明                                        |
| :-------------------- | :------------------------------------------ |
| onUserAccount         | 通过声网 UID 获得对应的即时通讯 IM 的用户 ID 后的回调。 |
| onSetUserAccountError | 获取用户信息失败的回调。                      |

`EaseCallKitTokenCallback` 的 API 列表如下：

| 事件            | 说明                               |
| :-------------- | :--------------------------------- |
| onSetToken      | app 将获取到的 RTC token 传递给 AgoraChatCallKit 时触发的回调。 |
| onGetTokenError | 获取 RTC token 失败的错误回调。        |

### 示例项目

为方便快速体验，我们在 GitHub 上提供了一个开源的 [即时通讯 IM](https://github.com/AgoraIO-Usecase/AgoraChat-android) 示例项目，你可以下载体验或查看源代码。

示例项目使用即时通讯 IM 的用户 ID 加入频道，可以在通话视图中显示用户 ID。如果使用 Agora RTC SDK 的方法发起通话，也可以使用整型 UID 加入频道。







