# 离线推送

Agora 即时通讯支持集成第三方厂商的消息推送服务，为 Android 开发者提供低延时、高送达、高并发、不侵犯用户个人数据的离线消息推送服务。

当客户端应用进程被关闭等原因导致用户离线，Agora 即时通讯服务会通过第三方厂商的消息推送服务向该离线用户的设备推送消息通知。当用户再次上线时，会收到离线期间所有消息。

本文以集成小米、华为的消息推送服务为例，介绍如何在客户端应用中实现消息推送。

## 技术原理

![](https://web-cdn.agora.io/docs-files/1642565386008)

## 前提条件

- 已开启 Agora 即时通讯服务，详见[开启和配置即时通讯服务](./enable_agora_chat?platform=Android)。
- 了解 Agora Chat 套餐包中的 API 调用频率限制，详见 [使用限制](./agora_chat_limitation)；
- 你已在 [Agora 控制台](https://console.agora.io/)中激活推送高级功能。高级功能激活后，你可以设置推送通知方式、免打扰模式和自定义推送模板。

<div class="alert note">关闭推送高级功能必须联系 support@agora.io，因为该操作会删除所有相关配置。</div>

## 项目配置

为防止代码混淆，在你的混淆规则中添加如下代码：

```java
-dontwarn io.agora.push.***
-keep class io.agora.push.*** {*;}
```

你还需要添加第三方推送的混淆规则，详见各厂商的开发者平台文档。

## 集成第三方厂商推送服务

以华为和小米为例，参考以下步骤集成第三方厂家的推送服务：

### 集成华为推送服务

1. 在[华为开发者后台](https://developer.huawei.com/)创建 Android 应用，开启消息推送服务，并获取 App ID 和 Secret Key，参考文档详见[华为推送服务](https://developer.huawei.com/consumer/cn/hms/huawei-pushkit)。
2. 按照如下步骤，将消息推送证书等信息上传到 Agora 控制台：
3. 登录[控制台](https://sso2.agora.io/cn/)，点击左侧导航栏**项目管理**。
4. 选择需要开通即时通讯服务的项目，点击**配置**。
   ![](https://web-cdn.agora.io/docs-files/1642565777918)
5. 找到**实时互动拓展能力**模块的**即时通讯 IM**，点击**配置**。
   ![](https://web-cdn.agora.io/docs-files/1642565827058)
6. 在消息推送模块，点击**添加推送证书**。在弹窗中选择**华为**，并配置如下字段：
    - 证书名称：消息推送证书名称。填写创建 Android 应用时获取的 app ID。
    - 证书密钥：消息推送证书密钥。填写创建 Android 应用时获取的 Secret Key。
    - 应用包名：Android 应用的包名。填写创建 Android 应用时设置的应用包名。
7. 集成 HMS Core SDK，参考文档详见[华为官方集成文档](https://developer.huawei.com/consumer/cn/doc/development/HMSCore-Guides/android-integrating-sdk-0000001050040084)。
8. 参考如下代码，在 `AndroidManifest.xml` 文件中注册 `HmsMessageService` 服务。

```xml
<!--华为 HMS Config-->
<service android:name=".service.HMSPushService"
    android:exported="false">
    <intent-filter>
        <action android:name="com.huawei.push.action.MESSAGING_EVENT" />
    </intent-filter>
</service>
<!-- huawei push end -->
```

9. 获取消息推送 Token，详见[获取和注销 Push Token](https://developer.huawei.com/consumer/cn/doc/development/HMSCore-Guides/android-client-dev-0000001050042041)，并参考如下代码，将推送 Token 上传到 Agora 即时通讯服务器。

```java
public class HMSPushService extends HmsMessageService {
  @Override
  public void onNewToken(String token) {
    if(token != null && !token.equals("")){
      //没有失败回调，假定 token 失败时 token 为 null
      EMLog.d("HWHMSPush", "service register huawei hms push token success token:" + token);
      ChatClient.getInstance().sendHMSPushTokenToServer(token);
    }else{
      EMLog.e("HWHMSPush", "service register huawei hms push token fail!");
    }
  }
}
```

10. 在 SDK 初始化时，启用华为推送。

```java
ChatOptions options = new ChatOptions();
...
PushConfig.Builder builder = new PushConfig.Builder(this);
builder..enableHWPush();
// 将 pushconfig 设置为 ChatOptions。
options.setPushConfig(builder.build());
// 初始化 Agora Chat SDK。
ChatClient.getInstance().init(this, options);
```

### 集成小米推送服务

1. 在[小米开发者平台](http://developer.xiaomi.com/)创建 Android 应用，开启消息推送服务，并获取 app ID 和 Secret Key，参考文档详见[推送服务接入指南](https://dev.mi.com/console/doc/detail?pId=68)。
2. 按照如下步骤，将消息推送证书等信息上传到 Agora 控制台：
 1. 登录[控制台](https://sso2.agora.io/cn/)，点击左侧导航栏**项目管理**。
 2. 选择需要开通即时通讯服务的项目，点击**配置**。
   ![](https://web-cdn.agora.io/docs-files/1642565777918)
 3. 找到**实时互动拓展能力**模块的**即时通讯 IM**，点击**配置**。
   ![](https://web-cdn.agora.io/docs-files/1642565827058)
 4. 在消息推送模块，点击**添加推送证书**。在弹窗中选择**小米**，并配置如下字段：

    - 证书名称：消息推送证书名称。填写创建 Android 应用时获取的 app ID。
    - 证书密钥：消息推送证书密钥。填写创建 Android 应用时获取的 Secret Key。
    - 应用包名：Android 应用的包名。填写创建 Android 应用时设置的应用包名。

3. 下载[小米推送 SDK](http://dev.xiaomi.com/mipush/downpage/)，并集成到你的项目中。
4. 配置 `AndroidManifest.xml` 文件。
 1. 添加如下权限：
    ```xml
    <!--注：以下三个权限在 4.8.0 及以上版本不再依赖-->
    <!-- <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />-->
    <!-- <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />-->
    <!-- <uses-permission android:name="android.permission.READ_PHONE_STATE" />-->
    
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.VIBRATE"/>
    <permission android:name="com.xiaomi.mipushdemo.permission.MIPUSH_RECEIVE"
    android:protectionLevel="signature" /> <!--这里 com.xiaomi.mipushdemo 改成 app 的包名-->
    <uses-permission android:name="com.xiaomi.mipushdemo.permission.MIPUSH_RECEIVE" /><!--这里 com.xiaomi.mipushdemo 改成 app 的包名-->
    ```
 2. 配置推送的 `service` 和 `receiver`：
    ```xml
    <service
        android:name="com.xiaomi.push.service.XMPushService"
        android:enabled="true"
        android:process=":pushservice" />
    
    <!--注：此 service 必须在 3.0.1 版本以后（包括 3.0.1 版本）加入-->
    <service
        android:name="com.xiaomi.push.service.XMJobService"
        android:enabled="true"
        android:exported="false"
        android:permission="android.permission.BIND_JOB_SERVICE"
        android:process=":pushservice" />
    
    <!--注：com.xiaomi.xmsf.permission.MIPUSH_RECEIVE 这里的包名不能改为 app 的包名-->
    <service
        android:name="com.xiaomi.mipush.sdk.PushMessageHandler"
        android:enabled="true"
        android:exported="true"
        android:permission="com.xiaomi.xmsf.permission.MIPUSH_RECEIVE" />
    
    <!--注：此 service 必须在 2.2.5 版本以后（包括 2.2.5 版本）加入-->
    <service
        android:name="com.xiaomi.mipush.sdk.MessageHandleService"
        android:enabled="true" />
    
    <receiver
        android:name="com.xiaomi.push.service.receivers.NetworkStatusReceiver"
        android:exported="true">
        <intent-filter>
            <action android:name="android.net.conn.CONNECTIVITY_CHANGE" />
            <category android:name="android.intent.category.DEFAULT" />
        </intent-filter>
    </receiver>
    
    <receiver
        android:name="com.xiaomi.push.service.receivers.PingReceiver"
        android:exported="false"
        android:process=":pushservice">
        <intent-filter>
            <action android:name="com.xiaomi.push.PING_TIMER" />
        </intent-filter>
    </receiver>
    ```

    3. 自定义一个继承自 Agora Chat SDK 中 `EMMiMsgReceiver` 类的 `BroadcastReceiver`，并注册到 `AndroidManifest.xml` 文件中：
    ```xml
    <receiver android:name=".common.receiver.MiMsgReceiver">
        <intent-filter>
            <action android:name="com.xiaomi.mipush.RECEIVE_MESSAGE" />
        </intent-filter>
        <intent-filter>
            <action android:name="com.xiaomi.mipush.MESSAGE_ARRIVED" />
        </intent-filter>
        <intent-filter>
            <action android:name="com.xiaomi.mipush.ERROR" />
        </intent-filter>
    </receiver>
    ```

5. 在 SDK 初始化时，启用小米推送。
```java
ChatOptions options = new ChatOptions();
...
PushConfig.Builder builder = new PushConfig.Builder(this);
builder..enableMiPush(String appId, String appKey);
//将 pushconfig 设置为 ChatOptions。
options.setPushConfig(builder.build());
// 初始化 Agora Chat SDK。
ChatClient.getInstance().init(this, options);
```

## 设置推送通知 

为优化用户在处理大量推送通知时的体验，Agora Chat 在 app 和会话层面提供了推送通知和免打扰模式的细粒度选项，如下表所示：

<table>
  <tr>
    <th>模式</th>
    <th>选项</th>
    <th>App</th>
    <th>会话</th>
  </tr>
  <tr>
    <td rowspan="3">推送通知方式</td>
    <td>ALL：接收所有离线消息的推送通知。</td>
    <td>✓</td>
    <td>✓</td>
  <tr>
    <td>MENTION_ONLY：仅接收提及消息的推送通知。</td>
    <td>✓</td>
    <td>✓</td>
  </tr>
  <tr>
     <td>NONE：不接收离线消息的推送通知。</td>
    <td>✓</td>
    <td>✓</td>
  </tr>
  <tr>
    <tr>
    <td rowspan="2">免打扰模式</td>
    <td>SILENT_MODE_DURATION：在指定时长内不接收推送通知。</td>
    <td>✓</td>
    <td>✓</td>
  <tr>
    <td>SILENT_MODE_INTERVAL：在指定的时间段内不接收推送通知。</td>
    <td>✓</td>
    <td>✗</td>
  </tr>
  </tr>
</table>

**推送通知方式**

会话级别的推送通知方式设置优先于 app 级别的设置，未设置推送通知方式的会话默认采用 app 的设置。

例如，假设 app 的推送方式设置为 `MENTION_ONLY`，而指定会话的推送方式设置为 `ALL`。你会收到来自该会话的所有推送通知，而对于其他会话来说，你只会收到提及你的消息的推送通知。

**免打扰模式**

1. 你可以在 app 级别指定免打扰时长和免打扰时间段。这两个时间段内你不会收到任何离线推送通知。

2. 会话仅支持免打扰时长设置；免打扰时间段的设置不生效。

对于 app 和 app 中的所有会话，免打扰模式的设置优先于推送通知方式的设置。

例如，假设在 app 级别指定了免打扰时间段，并将指定会话的推送通知方式设置为 `ALL`。免打扰模式与推送通知方式的设置无关，即在指定的免打扰时间段内，你不会收到任何推送通知。

或者，假设为会话指定了免打扰时间段，而 app 没有任何免打扰设置，并且其推送通知方式设置为 `ALL`。在指定的免打扰时间段内，你不会收到来自该会话的任何推送通知，而所有其他会话的推送保持不变。

### 设置 app 的推送通知

你可以调用 `setSilentModeForAll` 设置 app 级别的推送通知，并通过指定 `SilentModeParam` 字段设置推送通知方式和免打扰模式，如下代码示例所示：

```java
//设置推送通知方式为 `MENTION_ONLY`。
SilentModeParam param = new SilentModeParam(SilentModeParam.SilentModeParamType.REMIND_TYPE)
                                .setRemindType(PushManager.PushRemindType.MENTION_ONLY);
//设置离线推送免打扰时长为 15 分钟。
SilentModeParam param = new SilentModeParam(SilentModeParam.SilentModeParamType.SILENT_MODE_DURATION)
                                .setSilentModeDuration(15);
//设置离线推送的免打扰时间段为 8:30 到 15:00。
SilentModeParam param = new SilentModeParam(SilentModeParam.SilentModeParamType.SILENT_MODE_INTERVAL)
                                .setSilentModeInterval(new SilentModeTime(8, 30), new SilentModeTime(15, 0));
//设置 app 的离线推送通知。
ChatClient.getInstance().pushManager().setSilentModeForAll(param, new ValueCallBack<SilentModeResult>(){});
```

### 获取 app 的推送通知设置

你可以调用 `getSilentModeForAll` 获取 app 级别的推送通知设置，如以下代码示例所示：

```java
ChatClient.getInstance().pushManager().getSilentModeForAll(new ValueCallBack<SilentModeResult>(){
    @Override
    public void onSuccess(SilentModeResult result) {
        // 获取 app 的推送通知方式的设置。
        PushManager.PushRemindType remindType = result.getRemindType();
        // 获取 app 的离线推送免打扰过期的 Unix 时间戳。
        long timestamp = result.getExpireTimestamp();
        // 获取 app 的离线推送免打扰时间段的开始时间。
        SilentModeTime startTime = result.getSilentModeStartTime();
        startTime.getHour(); // 免打扰时间段的开始时间中的小时数。
        startTime.getMinute(); // 免打扰时间段的开始时间中的分钟数。
        // 获取 app 的离线推送免打扰时间段的结束时间。
        SilentModeTime endTime = result.getSilentModeEndTime();
        endTime.getHour(); // 免打扰时间段的结束时间中的小时数。
        endTime.getMinute(); // 免打扰时间段的结束时间中的分钟数。
    }
    @Override
    public void onError(int error, String errorMsg) {}
});
```

### 设置单个会话的推送通知

你可以调用 `setSilentModeForConversation` 方法设置指定会话的推送通知，并通过指定 `SilentModeParam` 字段设置推送通知方式和免打扰模式，如以下代码示例所示：

```java
//设置推送通知方式为 `MENTION_ONLY`。
SilentModeParam param = new SilentModeParam(SilentModeParam.SilentModeParamType.REMIND_TYPE)
                                .setRemindType(PushManager.PushRemindType.MENTION_ONLY);

//设置离线推送免打扰时长为 15 分钟。
SilentModeParam param = new SilentModeParam(SilentModeParam.SilentModeParamType.SILENT_MODE_DURATION)
                                .setSilentDuration(15);
//设置会话的离线推送免打扰模式。目前，暂不支持设置会话免打扰时间段。
ChatClient.getInstance().pushManager().setSilentModeForConversation(conversationId, conversationType, param, new ValueCallBack<SilentModeResult>(){});
```

### 获取单个会话的推送通知设置

你可以调用 `getSilentModeForConversation` 获取指定会话的推送通知设置，如以下代码示例所示：

```java
ChatClient.getInstance().pushManager().getSilentModeForConversation(conversationId, conversationType, new ValueCallBack<SilentModeResult>(){
    @Override
    public void onSuccess(SilentModeResult result) {
        // 获取指定会话是否设置了推送通知方式。
        boolean enable = result.isConversationRemindTypeEnabled();
        // 检查会话是否设置了推送通知方式。
        if(enable){
            //获取会话的推送通知方式。
            PushManager.PushRemindType remindType = result.getRemindType();
        }
        // 获取会话的离线推送免打扰过期 Unix 时间戳。
        long timestamp = result.getExpireTimestamp();
    }
    @Override
    public void onError(int error, String errorMsg) {}
});
```

### 获取多个会话的推送通知设置

1. 你可以在每次调用中最多获取 20 个会话的推送通知设置。

2. 如果会话继承了 app 设置或其推送通知设置已过期，则返回的字典不包含此会话。

你可以调用 `getSilentModeForConversations` 获取多个会话的推送通知设置，如以下代码示例所示：

```java
ChatClient.getInstance().pushManager().getSilentModeForConversations(conversationList, new ValueCallBack<Map<String, SilentModeResult>>(){
    @Override
    public void onSuccess(Map<String, SilentModeResult> value) {}
    @Override
    public void onError(int error, String errorMsg) {}
});
```

### 清除单个会话的推送通知方式的设置

你可以调用 `clearRemindTypeForConversation` 方法清除指定会话的推送通知方式的设置。清除后，默认情况下，此会话会继承 app 的设置。

以下代码示例显示了如何清除会话的推送通知方式：

```java
ChatClient.getInstance().pushManager().clearRemindTypeForConversation(conversationId, conversationType, new CallBack(){});
```

## 设置显示属性

### 设置推送通知的显示属性

你可以调用 `updatePushNickname` 设置推送通知中显示的昵称，如以下代码示例所示：

```java
ChatClient.getInstance().pushManager().updatePushNickname("pushNickname");
```

你也可以调用 `updatePushDisplayStyle` 设置推送通知的显示样式，如下代码示例所示：

```java
// 设置为简单样式，即只显示 "你有一条新消息"。
// 若要显示消息内容，需将 `DisplayStyle` 设置为 `MessageSummary`。
PushManager.DisplayStyle displayStyle = PushManager.DisplayStyle.SimpleBanner;
// 需要异步处理。
ChatClient.getInstance().pushManager().updatePushDisplayStyle(displayStyle);
```

### 获取推送通知的显示属性

你可以调用 `getPushConfigsFromServer` 方法获取推送通知中的显示属性，如以下代码示例所示：

```java
PushConfigs pushConfigs = ChatClient.getInstance().pushManager().getPushConfigsFromServer();
// 获取推送显示昵称。
String nickname = pushConfigs.getDisplayNickname();
// 获取推送通知的显示样式。
PushManager.DisplayStyle style = pushConfigs.getDisplayStyle();
```

## 设置推送翻译

如果用户启用[自动翻译](./agora_chat_translation_android)功能并发送消息，SDK 会同时发送原始消息和翻译后的消息。

推送通知与翻译功能协同工作。作为接收方，你可以设置你在离线时希望接收的推送通知的首选语言。如果翻译消息的语言符合你的设置，则翻译消息显示在推送通知中；否则，将显示原始消息。

以下代码示例显示了如何设置和获取推送通知的首选语言：

```java
// 设置离线推送的首选语言。
ChatClient.getInstance().pushManager().setPreferredNotificationLanguage("en", new CallBack(){});

// 获取设置的离线推送的首选语言。
ChatClient.getInstance().pushManager().getPreferredNotificationLanguage(new ValueCallBack<String>(){});
```

## 设置推送模板

Agora Chat 支持自定义推送通知模板。使用前，你可以参考以下步骤为用户创建和提供推送模板：

1. 登录 Agora 控制台，点击左侧导航栏中的**项目管理**。

2. 在**项目管理**页面，找到开启聊天功能的项目，点击**配置**。

3. 在项目编辑页面，点击**Chat**旁边的**配置**。

4. 在项目配置页面，选择**特性 > 推送模板**并单击**添加推送模板**，在弹出的对话框中配置字段，如下图所示。

   ![image](../doc_cn_easemob/images/push_android/push_android_template_mgmt.png)

5. 创建推送模板后，用户可以在发送消息时选择使用此模板，代码示例如下所示。

```java
// 下面以文本消息为例，其他类型的消息设置方法相同。
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.TXT);
TextMessageBody txtBody = new TextMessageBody("message content");
message.setTo("6006");
// 将在 Agora 控制台上创建的推送模板设置为默认推送模板。
                    JSONObject pushObject = new JSONObject();
                    JSONArray titleArgs = new JSONArray();
                    JSONArray contentArgs = new JSONArray();
                    try {
                        // 设置推送模板名称。
                        pushObject.put("name", "test7");
                        // 设置填写模板标题的 value 数组。
                        titleArgs.put("value1");
                        //...
                        pushObject.put("title_args", titleArgs);
                        // 设置填写模板内容的 value 数组。
                        contentArgs.put("value1");
                        //...
                        pushObject.put("content_args", contentArgs);
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                    // 将推送模板添加到消息中。
                    message.setAttribute("em_push_template", pushObject);
// 设置消息状态回调。
message.setMessageStatusCallback(new CallBack() {...});
// 发送消息。
ChatClient.getInstance().chatManager().sendMessage(message);
```

## 解析推送字段

在收到推送消息时，解析推送字段。

### 字段说明

| 参数    | 描述           |
| ------- | -------------- |
| `t`  | 消息推送接收方的用户 ID。     |
| `f` | 消息推送发送方的用户 ID。     |
| `m`  |消息 ID。消息唯一标识符。     |
| `g`  | 群组 ID，仅当消息为群组消息时，该字段存在。     |
| `e`  | 用户自定义扩展字段。     |

### 示例代码

**解析华为推送字段**

```java
public class SplashActivity extends BaseActivity {
	@Override
	protected void onCreate(Bundle savedInstanceState) {		
		Bundle extras = getIntent().getExtras();
		if (extras != null) {
			String t = extras.getString("t");
			String f = extras.getString("f");
			String m = extras.getString("m");
			String g = extras.getString("g");
			Object e = extras.get("e");
			//handle
		}
	}
}
```
**解析小米推送字段**

```java
public class MiMsgReceiver extends EMMiMsgReceiver {
    @Override
    public void onNotificationMessageClicked(Context context, MiPushMessage miPushMessage) {
        String extStr = miPushMessage.getContent();
      	JSONObject extras = new JSONObject(extStr);
        if (extras !=null ){
          String t = extras.getString("t");
          String f = extras.getString("f");
          String m = extras.getString("m");
          String g = extras.getString("g");
          Object e = extras.get("e");
          //handle
        }
    }
}
```
## 更多功能

### 自定义字段

参考如下代码，向推送中添加你自己的业务字段以满足业务需求，比如通过这条推送跳转到某个活动页面。

```java
// 本示例以文本消息为例，图片和文件等消息类型的设置方法相同
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.TXT);
TextMessageBody txtBody = new TextMessageBody("message content");
// 设置要发送用户的 agora ID
message.setTo("toChatUsername");
// 设置自定义推送提示
JSONObject extObject = new JSONObject();
try {
    extObject.put("test1", "test 01");
} catch (JSONException e) {
    e.printStackTrace();
}
// 将推送扩展设置到消息中
message.setAttribute("em_apns_ext", extObject);
// 设置消息体
message.addBody(txtBody);
// 设置消息回调
message.setMessageStatusCallback(new CallBack() {...});
// 发送消息
ChatClient.getInstance().chatManager().sendMessage(message);
```

| 参数             | 描述               |
| :--------------- | :----------------- |
| `txtBody`        | 推送消息内容。     |
| `toChatUsername` | 消息接收方的用户 ID。 |
| `em_apns_ext`    | 消息扩展字段。     |

RemoteMessage 消息格式如下：

```json
{
    "message": {
        "token": "bk3RNwTe3H0:CI2k_HHwgIpoDKCIZvvDMExUdFQ3P1...",
        "data": {
            "alert": "message content",
            "test1": "test 01"
        }
    }
}
```

| 参数    | 描述                                                                                   |
| ------- | -------------------------------------------------------------------------------------- |
| `data`  | 推送内容中的自定义数据。                                                               |
| `alert` | 通知内容，一般指文本消息对应的内容。根据设置 `DisplayStyle` 不同，返回不同的数据样式。 |
| `test1` | 自定义字段。                                                                           |

### 自定义显示

参考如下代码，自定义推送消息显示内容：

```java
// 本示例以文本消息为例，图片和文件等消息类型的设置方法相同
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.TXT);
TextMessageBody txtBody = new TextMessageBody("message content");
// 设置要发送用户的 Agora ID
message.setTo("toChatUsername");
// 设置自定义推送提示
JSONObject extObject = new JSONObject();
try {
    extObject.put("em_push_title", "custom push title");
    extObject.put("em_push_content", "custom push content");
} catch (JSONException e) {
    e.printStackTrace();
}
// 将推送扩展设置到消息中
message.setAttribute("em_apns_ext", extObject);
// 设置消息体
message.addBody(txtBody);
// 设置消息回调
message.setMessageStatusCallback(new CallBack() {...});
// 发送消息
ChatClient.getInstance().chatManager().sendMessage(message);
```

| 参数              | 描述               |
| :---------------- | :----------------- |
| `toChatUsername`  | 消息接收方的用户 ID。 |
| `em_apns_ext`     | 消息扩展字段。     |
| `em_push_title`   | 推送消息标题。     |
| `em_push_content` | 推送消息内容。     |

RemoteMessage 消息格式如下：

```json
{
    "message": {
        "token": "bk3RNwTe3H0:CI2k_HHwgIpoDKCIZvvDMExUdFQ3P1...",
        "data": {
            "alert": "push content",
            "push_title": "custom push title",
            "push_content": "custom push content"
        }
    }
}
```

| 参数           | 描述                                                              |
| -------------- | ----------------------------------------------------------------- |
| `data`         | 推送内容中的自定义数据。                                          |
| `alert`        | 推送通知内容。根据设置 `DisplayStyle` 不同，返回不同的数据样式。 |
| `push_title`   | 自定义推送标题。                                                  |
| `push_content` | 自定义推送内容。                                                  |

### 强制推送

设置强制推送后，用户发送消息时会忽略接收方的免打扰设置，不论是否处于免打扰时间段都会正常向接收方推送消息。

```java
// 本示例以文本消息为例，图片和文件等消息类型的设置方法相同
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.TXT);
TextMessageBody txtBody = new TextMessageBody("test");
// 设置要发送用户的 Agora ID
message.setTo("toChatUsername");
// 设置自定义扩展字段
message.setAttribute("em_force_notification", true);
// 设置消息回调
message.setMessageStatusCallback(new CallBack() {...});
// 发送消息
ChatClient.getInstance().chatManager().sendMessage(message);
```

| 参数                    | 描述                                                        |
| :---------------------- | :---------------------------------------------------------- |
| `txtBody`               | 推送消息内容。                                              |
| `toChatUsername`        | 消息接收方的用户 ID。                                          |
| `em_force_notification` | 是否为强制推送：<br/>`true`：强制推送；<br/>`false`：非强制推送。 |