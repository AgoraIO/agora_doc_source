Agora 即时通讯支持集成第三方厂商的消息推送服务，为 Android 开发者提供低延时、高送达、高并发、不侵犯用户个人数据的离线消息推送服务。

当客户端应用进程被关闭等原因导致用户离线，Agora 即时通讯服务会通过第三方厂商的消息推送服务向该离线用户的设备推送消息通知。当用户再次上线时，会收到离线期间所有消息。

本文以集成小米、华为的消息推送服务为例，介绍如何在客户端应用中实现消息推送。

## 技术原理

![](https://web-cdn.agora.io/docs-files/1642565386008)

## 前提条件

已开启 Agora 即时通讯服务，详见[开启和配置即时通讯服务](./enable_agora_chat?platform=Android)。

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

1. 在[华为开发者后台](https://developer.huawei.com/)创建 Android 应用，开启消息推送服务，并获取 APPID 和 SecretKey，参考文档详见[华为推送服务](https://developer.huawei.com/consumer/cn/hms/huawei-pushkit)。

2. 按照如下步骤，将消息推送证书等信息上传到 Agora 控制台：
3. 登录[控制台](https://sso2.agora.io/cn/)，点击左侧导航栏**项目管理**。
4. 选择需要开通即时通讯服务的项目，点击**配置**。
   ![](https://web-cdn.agora.io/docs-files/1642565777918)
5. 找到**实时互动拓展能力**模块的**即时通讯 IM**，点击**配置**。
   ![](https://web-cdn.agora.io/docs-files/1642565827058)
6. 在消息推送模块，点击**添加推送证书**。在弹窗中选择**华为**，并配置如下字段：
    - 证书名称：消息推送证书名称。填写创建 Android 应用时获取的 APPID。
    - 证书密钥：消息推送证书密钥。填写创建 Android 应用时获取的 SecretKey。
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

9. 获取消息推送 Token，详见[获取和注销 Push Token](https://developer.huawei.com/consumer/cn/doc/development/HMSCore-Guides/android-client-dev-0000001050042041)，并参考如下代码，将推送 Token上传到 Agora 即时通讯服务器。
```java
public class HMSPushService extends HmsMessageService {
  @Override
  public void onNewToken(String token) {
    if(token != null && !token.equals("")){
      //没有失败回调，假定token失败时token为null
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
// Set pushconfig to ChatOptions
options.setPushConfig(builder.build());
// To initialize Agora Chat SDK
ChatClient.getInstance().init(this, options);
```

### 集成小米推送服务

1. 在[小米开发者平台](http://developer.xiaomi.com/)创建 Android 应用，开启消息推送服务，并获取 APPID 和 SecretKey，参考文档详见[推送服务接入指南](https://dev.mi.com/console/doc/detail?pId=68)。
2. 按照如下步骤，将消息推送证书等信息上传到 Agora 控制台：
 1. 登录[控制台](https://sso2.agora.io/cn/)，点击左侧导航栏**项目管理**。
 2. 选择需要开通即时通讯服务的项目，点击**配置**。
   ![](https://web-cdn.agora.io/docs-files/1642565777918)
 3. 找到**实时互动拓展能力**模块的**即时通讯 IM**，点击**配置**。
   ![](https://web-cdn.agora.io/docs-files/1642565827058)
 4. 在消息推送模块，点击**添加推送证书**。在弹窗中选择**小米**，并配置如下字段：

    - 证书名称：消息推送证书名称。填写创建 Android 应用时获取的 APPID。
    - 证书密钥：消息推送证书密钥。填写创建 Android 应用时获取的 SecretKey。
    - 应用包名：Android 应用的包名。填写创建 Android 应用时设置的应用包名。

3. 下载[小米推送 SDK](http://dev.xiaomi.com/mipush/downpage/) ，并集成到你的项目中。
4. 配置 `AndroidManifest.xml` 文件。
 1. 添加如下权限：
    ```xml
    <!--注：以下三个权限在4.8.0及以上版本不再依赖-->
    <!-- <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />-->
    <!-- <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />-->
    <!-- <uses-permission android:name="android.permission.READ_PHONE_STATE" />-->
    
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.VIBRATE"/>
    <permission android:name="com.xiaomi.mipushdemo.permission.MIPUSH_RECEIVE"
    android:protectionLevel="signature" /> <!--这里com.xiaomi.mipushdemo改成app的包名-->
    <uses-permission android:name="com.xiaomi.mipushdemo.permission.MIPUSH_RECEIVE" /><!--这里com.xiaomi.mipushdemo改成app的包名-->
    ```
 2. 配置推送的的 `service` 和 `receiver`：
    ```xml
    <service
        android:name="com.xiaomi.push.service.XMPushService"
        android:enabled="true"
        android:process=":pushservice" />
    
    <!--注：此service必须在3.0.1版本以后（包括3.0.1版本）加入-->
    <service
        android:name="com.xiaomi.push.service.XMJobService"
        android:enabled="true"
        android:exported="false"
        android:permission="android.permission.BIND_JOB_SERVICE"
        android:process=":pushservice" />
    
    <!--注：com.xiaomi.xmsf.permission.MIPUSH_RECEIVE这里的包名不能改为app的包名-->
    <service
        android:name="com.xiaomi.mipush.sdk.PushMessageHandler"
        android:enabled="true"
        android:exported="true"
        android:permission="com.xiaomi.xmsf.permission.MIPUSH_RECEIVE" />
    
    <!--注：此service必须在2.2.5版本以后（包括2.2.5版本）加入-->
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
// Set pushconfig to ChatOptions
options.setPushConfig(builder.build());
// To initialize Agora Chat SDK
ChatClient.getInstance().init(this, options);
```

## 配置推送属性

配置推送属性，包括推送显示昵称、推送样式、群组是否接收推送以及推送免打扰等。

### 设置推送显示昵称

参考如下代码设置推送显示昵称：

```java
// Asynchronous processing is required.
ChatClient.getInstance().pushManager().updatePushNickname("pushNickname");
```

### 设置推送显示样式

参考如下代码设置是否显示推送消息内容：

```java
// 设置为简单样式
PushManager.DisplayStyle displayStyle = PushManager.DisplayStyle.SimpleBanner;
// Asynchronous processing is required.
ChatClient.getInstance().pushManager().updatePushDisplayStyle(displayStyle);
```

| 参数           | 描述                                                                            |
| :------------- | :------------------------------------------------------------------------------ |
| `displayStyle` | <li>`SimpleBanner`：显示 "您有一条新消息"。<li>`MessageSummary`：显示消息内容。 |

### 设置群组免打扰

群组免打扰指不接收指定群组的消息推送，设置群组免打扰后，当用户与服务器断开连接时不会收到该群组的消息推送。

```java
List<String> groupIds = new ArrayList<>();
// 添加要设置免打扰的群id
groupIds.add("groupId01");
// Asynchronous processing is required.
ChatClient.getInstance().pushManager().updatePushServiceForGroup(groupIds, true);
```

| 参数       | 描述           |
| :--------- | :------------- |
| `groupIds` | 群组 ID 列表。 |

### 获取免打扰群组列表

```java
List<String> noPushGroups = ChatClient.getInstance().pushManager().getNoPushGroups();
```

| 参数       | 描述                   |
| :--------- | :--------------------- |
| `groupIds` | 免打扰的群组 ID 列表。 |

### 设置单人免打扰

单人免打扰主指不接收指定用户的消息推送，设置单人免打扰后，当用户与服务器断开连接时不会收到该用户的消息推送。

```json
// Asynchronous processing is required.
ChatClient.getInstance().pushManager().updatePushServiceForUsers(userIds, true);
```

| 参数    | 描述         |
| :------ | :----------- |
| userIds | 用户名列表。 |

### 获取单人免打扰列表

参考如下代码获取免打扰的用户列表：

```json
List<String> noPushUsers = ChatClient.getInstance().pushManager().getNoPushUsers();
```

| 参数        | 描述                 |
| :---------- | :------------------- |
| noPushUsers | 免打扰的用户名列表。 |

### 设置消息推送免打扰

参考如下代码，设置消息推送免打扰时间段：

```java
// Asynchronous processing is required.
ChatClient.getInstance().pushManager().disableOfflinePush(start, end);
```

| 参数    | 描述                                          |
| :------ | :-------------------------------------------- |
| `start` | Int 类型。免打扰的起始时间。取值范围 [0,24]。 |
| `end`   | Int 类型。免打扰的结束时间。取值范围 [0,24]。 |

### 开启消息推送

参考如下代码，开启消息推送：

```java
// Asynchronous processing is required.
ChatClient.getInstance().pushManager().enableOfflinePush();
```

### 获取推送属性

参考如下代码，获取消息推送属性：

```java
// Asynchronous processing is required.
PushConfigs pushConfigs = ChatClient.getInstance().pushManager().getPushConfigsFromServer();
```

`PushConfigs` 包含如下方法：

| 方法名               | 描述                                                                       |
| :------------------- | :------------------------------------------------------------------------- |
| getDisplayNickname() | 获取对方收到推送时发送方展示的名称。                                       |
| getDisplayStyle()    | 推送显示类型。                                                             |
| getSilentModeStart() | 不接收推送的开始时间。                                                     |
| getSilentModeEnd()   | 不接收推送的结束时间。                                                     |
| silentModeEnabled()  | 是否开启了不接收推送，只要设置了免打扰时间，不论是什么时间段都会返回 YES。 |

## 解析推送字段

在收到推送消息时，解析推送字段。

#### 字段说明
| 参数    | 描述           |
| ------- | -------------- |
| `t`  | 消息推送接收方用户名 。     |
| `f` | 消息推送发送方用户名 。     |
| `m`  |消息 ID。消息唯一标识符。     |
| `g`  | 群组 ID ，仅当消息为群组消息时，该字段存在。     |
| `e`  | 用户自定义扩展字段。     |

#### 示例代码
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
// 本示例以 TXT 消息为例，IMAGE、FILE 等消息类型的设置方法相同
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.TXT);
TextMessageBody txtBody = new TextMessageBody("message content");
// 设置要发送用户的agora id
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
| `toChatUsername` | 消息接收方用户名。 |
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
// 本示例以 TXT 消息为例，IMAGE、FILE 等消息类型的设置方法相同
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.TXT);
TextMessageBody txtBody = new TextMessageBody("message content");
// 设置要发送用户的agora id
message.setTo("toChatUsername");
// 设置自定义推送提示
JSONObject extObject = new JSONObject();
try {
    extObject.put("em_push_title", "costom push title");
    extObject.put("em_push_content", "costom push content");
    extObject.put("push_title", "costom push title");
    extObject.put("push_content", "costom push content");
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
| `toChatUsername`  | 消息接收方用户名。 |
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
            "push_title": "costom push title",
            "push_content": "costom push content"
        }
    }
}
```

| 参数           | 描述                                                              |
| -------------- | ----------------------------------------------------------------- |
| `data`         | 推送内容中的自定义数据。                                          |
| `alert`        | 推送通知内容。 根据设置 `DisplayStyle` 不同，返回不同的数据样式。 |
| `push_title`   | 自定义推送标题。                                                  |
| `push_content` | 自定义推送内容。                                                  |

### 强制推送

设置强制推送后，用户发送消息时会忽略接收方的免打扰设置，不论是否处于免打扰时间段都会正常向接收方推送消息。

```java
// 本示例以 TXT 消息为例，IMAGE、FILE 等消息类型的设置方法相同
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
| `toChatUsername`        | 消息接收方用户名。                                          |
| `em_force_notification` | 是否为强制推送：<li>`true`：强制推送<li>`false`：非强制推送 |