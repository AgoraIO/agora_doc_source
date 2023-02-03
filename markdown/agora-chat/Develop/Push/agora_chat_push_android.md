# 离线推送

即时通讯 IM 支持集成第三方厂商的消息推送服务，为 Android 开发者提供低延时、高送达、高并发、不侵犯用户个人数据的离线消息推送服务。

当客户端应用进程被关闭等原因导致用户离线，即时通讯 IM 会通过第三方厂商的消息推送服务向该离线用户的设备推送消息通知。当用户再次上线时，会收到离线期间所有消息。

本文介绍如何在客户端应用中实现各厂商的推送服务。

## 技术原理

![](https://web-cdn.agora.io/docs-files/1642565386008)

消息推送流程如下：

1. 用户 B（消息接收者）检查设备支持哪种推送渠道，即 app 配置了哪种第三方推送服务且满足该推送的使用条件。
2. 用户 B 根据配置的第三方推送 SDK 从第三方推送服务器获取推送 token。
3. 第三方推送服务器向用户 B 返回推送 token。
4. 用户 B 向 Agora 即时通讯服务器上传推送证书名称和推送 token。
5. 用户 A 向 用户 B 发送消息。
6. Agora 即时通讯服务器检查用户 B 是否在线。若在线，Agora 即时通讯服务器直接将消息发送给用户 B。
7. 若用户 B 离线，Agora 即时通讯服务器判断该用户的设备使用的推送服务类型。
8. Agora 即时通讯服务器将将消息发送给第三方推送服务器。
9. 第三方推送服务器将消息发送给用户 B。

<div class="alert info"><p>开发者通过 Agora 控制台配置 App 的推送证书，需填写证书名称及推送密钥等信息。该步骤须在登录即时通讯 IM SDK 成功后进行。</p><p>证书名称是 Agora 即时通讯服务器用于判断目标设备使用哪种推送通道的唯一条件，因此必须确保与 Android 终端设备上传的证书名称一致。</p></div>

## 前提条件

- 已开启即时通讯 IM ，详见 [开启和配置即时通讯服务](./enable_agora_chat)。
- 了解即时通讯 IM 套餐包中的 API 调用频率限制，详见 [使用限制](./agora_chat_limitation)。
- 你已在 [Agora 控制台](https://console.agora.io/)中激活推送高级功能。高级功能激活后，你可以设置推送通知方式、免打扰模式和自定义推送模板。

<div class="alert note">关闭推送高级功能必须联系 <a href="mailto:support@agora.io">support@agora.io</a>，因为该操作会删除所有相关配置。</div>

各厂商推送服务的使用条件如下：

- Google FCM：需要 Google Play Service 和能连接 Google 服务器的网络；
- 小米推送：在小米系统上可用；
- 华为推送：在华为系统上可用；
- 魅族推送：在魅族系统上可用；
- OPPO 推送：在 OPPO 系统上可用；
- VIVO 推送：在 VIVO 系统上可用。

SDK 内部会按照这个顺序检测设备的推送支持情况。

如果未设置第三方推送或者不满足使用第三方推送的条件，即时通讯 IM SDK 会通过一些保活手段尽可能的保持与环信服务器的长连接，以确保消息及时送达。

<div class="alert info">
如果你的 App 有海外使用场景，建议开启 FCM 推送；由于各推送使用条件不同，建议尽可能同时支持各家推送。</div>

此外，使用消息推送前，需要你在对应的手机厂商推送服务上注册项目，并将设备的推送证书上传到 Agora 云控制台。

## 项目配置  

为防止代码混淆，在你的混淆规则中添加如下代码：

```java
-dontwarn io.agora.push.***
-keep class io.agora.push.*** {*;}
```

除此之外，你还需要添加第三方推送的混淆规则，详见各厂商的开发者平台文档。

## 集成第三方厂商推送服务 

### 集成 Google FCM

#### 1. 在 Firebase 控制台添加 Firebase

在 [Firebase 控制台](https://console.firebase.google.com/)添加 Firebase，详见 [FCM 的官网介绍](https://firebase.google.com/docs/android/setup?hl=zh-cn#console)。

将 Firebase SDK 添加到你的应用后，在 Firebase 控制台的 `Project settings` 页面，选择 `Cloud Messaging` 标签，查看 `Server ID` 和 `Server Key`。

#### 2. 上传推送证书

注册完成后，在 [Agora 控制台](https://console.agora.io/)上传推送证书，选择你的应用 > **即时推送** > **配置证书** > **添加推送证书** > **谷歌**，然后输入 Firebase 项目设置里的 `Server ID` 和 `Server Key`。

#### 3. 集成 FCM 推送

1. 在项目根目录下的 `build.gradle` 中添加 FCM 服务插件。

   ```gradle
   dependencies {
       // FCM 推送
       classpath 'com.google.gms:google-services:4.3.8'
   }
   ```

2. 在项目的 module 的 gradle 文件中（通常为 /app/build.gradle ）配置 FCM 库的依赖。

   ```gradle
   dependencies {
       // ...
   
       // FCM：导入 Firebase BoM
       implementation platform('com.google.firebase:firebase-bom:28.4.1')
       // FCM：声明 FCM 的依赖项
       // 使用 BoM 时，不要在 Firebase 库依赖中指定版本
       implementation 'com.google.firebase:firebase-messaging'
   
   }
   // 添加下行代码：
   apply plugin: 'com.google.gms.google-services'  // Google 服务插件
   ```

3. 同步应用后，继承 `FirebaseMessagingService` 的服务，并将其在 `AndroidManifest.xml` 中注册。

   ```xml
   <service
       android:name=".java.MyFirebaseMessagingService"
       android:exported="false">
       <intent-filter>
           <action android:name="com.google.firebase.MESSAGING_EVENT" />
       </intent-filter>
   </service>
   ```

4. 在即时通讯 IM SDK 中启用 FCM。

   ```java
   ChatOptions options = new ChatOptions();
   ...
   PushConfig.Builder builder = new PushConfig.Builder(this);
   // 替换为你的 FCM 发送方的用户 ID
   builder.enableFCM("Your FCM sender id");
   // 将 pushconfig 设置到 ChatOptions 中
   options.setPushConfig(builder.build());
   // 初始化即时通讯 IM SDK
   ChatClient.getInstance().init(this, options);
   // 即时通讯 IM SDK 初始化后
   PushHelper.getInstance().setPushListener(new PushListener() {
       @Override
       public void onError(PushType pushType, long errorCode) {
           EMLog.e("PushClient", "Push client occur a error: " + pushType + " - " + errorCode);
       }
       @Override
       public boolean isSupportPush(PushType pushType, PushConfig pushConfig) {
           // 设置是否支持 FCM
           if(pushType == PushType.FCM) {
               return GoogleApiAvailabilityLight.getInstance().isGooglePlayServicesAvailable(MainActivity.this)
                           == ConnectionResult.SUCCESS;
           }
           return super.isSupportPush(pushType, pushConfig);
       }
   });
   ```

5. 即时通讯 IM SDK 登录成功后，上传 FCM 的 device token。

   ```java
   // 查看是否支持 FCM
   if(GoogleApiAvailabilityLight.getInstance().isGooglePlayServicesAvailable(MainActivity.this) != ConnectionResult.SUCCESS) {
       return;
   }
   FirebaseMessaging.getInstance().getToken().addOnCompleteListener(new OnCompleteListener<String>() {
       @Override
       public void onComplete(@NonNull Task<String> task) {
           if (!task.isSuccessful()) {
               EMLog.d("PushClient", "Fetching FCM registration token failed:"+task.getException());
               return;
           }
           // 获取新的 FCM 注册 token
           String token = task.getResult();
           ChatClient.getInstance().sendFCMTokenToServer(token);
       }
   });
   ```

6. 监控 device token 生成。

重写 `FirebaseMessagingService` 中的 `onNewToken` 方法，device token 更新后及时更新到即时通讯 IM SDK。

   ```java
   public class FCMMSGService extends FirebaseMessagingService {
       private static final String TAG = "FCMMSGService";
   
       @Override
       public void onMessageReceived(RemoteMessage remoteMessage) {
           super.onMessageReceived(remoteMessage);
           if (remoteMessage.getData().size() > 0) {
               String message = remoteMessage.getData().get("alert");
               Log.d(TAG, "onMessageReceived: " + message);
           }
       }
   
       @Override
       public void onNewToken(@NonNull String token) {
           Log.i("MessagingService", "onNewToken: " + token);
           // 若要对该应用实例发送消息或管理服务端的应用订阅，将 FCM 注册 token 发送至你的应用服务器。
           if(ChatClient.getInstance().isSdkInited()) {
               ChatClient.getInstance().sendFCMTokenToServer(token);
           }
       }
   }
   ```

### 集成华为 HMS 推送

#### 1. 在华为开发者后台创建应用并开启推送

在 [华为开发者后台](https://developer.huawei.com/)创建 Android 应用，开启消息推送服务，并获取 App ID 和 Secret Key。参考文档详见 [华为推送服务](https://developer.huawei.com/consumer/cn/doc/development/HMSCore-Guides/android-config-agc-0000001050170137#section19884105518498)。

#### 2. 将推送证书等信息上传 Agora 控制台

1. 登录 [Agora 控制台](https://console.agora.io/)，点击左侧导航栏的**项目管理**。

2. 选择需要开通即时通讯服务的项目，点击**配置**。
   ![](https://web-cdn.agora.io/docs-files/1642565777918)

3. 找到**实时互动拓展能力**模块的**即时通讯 IM**，点击**配置**。

   ![](https://web-cdn.agora.io/docs-files/1642565827058)

4. 在消息推送模块，点击**添加推送证书**。在弹窗中选择**华为**，并配置如下字段：

    - 证书名称：消息推送证书名称。填写创建 Android 应用时获取的 app ID。
    - 证书密钥：消息推送证书密钥。填写创建 Android 应用时获取的 Secret Key。
    - 应用包名：Android 应用的包名。填写创建 Android 应用时设置的应用包名。

#### 3. 集成 HMS Core SDK

1. 集成 HMS Core SDK，详见[华为官方集成文档](https://developer.huawei.com/consumer/cn/doc/development/HMSCore-Guides/android-integrating-sdk-0000001050040084)。

2. 在 `AndroidManifest.xml` 文件中注册 `HmsMessageService` 服务。

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

3. 获取消息推送 Token。

获取消息推送 Token，详见[获取和注销推送 Token](https://developer.huawei.com/consumer/cn/doc/development/HMSCore-Guides/android-client-dev-0000001050042041)，并参考如下代码，将推送 Token 上传到即时通讯 IM 服务器。

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

4. 在 SDK 初始化时启用华为推送

```java
ChatOptions options = new ChatOptions();
...
PushConfig.Builder builder = new PushConfig.Builder(this);
builder..enableHWPush();
// 将 pushconfig 设置为 ChatOptions。
options.setPushConfig(builder.build());
// 初始化即时通讯 IM SDK。
ChatClient.getInstance().init(this, options);
```

### 集成小米推送服务

#### 1. 在小米开发者平台开启消息推送服务

在 [小米开放平台](https://dev.mi.com/platform)创建 Android 应用，开启消息推送服务，并获取 app ID 和 Secret Key。详见 [推送服务接入指南](https://dev.mi.com/console/doc/detail?pId=68)。

#### 2. 将消息推送证书等信息上传到 Agora 控制台

 1. 登录 [Agora 控制台](https://console.agora.io/)，点击左侧导航栏**项目管理**。

 2. 选择需要开通即时通讯服务的项目，点击**配置**。

   ![](https://web-cdn.agora.io/docs-files/1642565777918)

 3. 找到**实时互动拓展能力**模块的**即时通讯 IM**，点击**配置**。

   ![](https://web-cdn.agora.io/docs-files/1642565827058)

 4. 在消息推送模块，点击**添加推送证书**。在弹窗中选择**小米**，并配置如下字段：

    - 证书名称：消息推送证书名称。填写创建 Android 应用时获取的 app ID。
    - 证书密钥：消息推送证书密钥。填写创建 Android 应用时获取的 Secret Key。
    - 应用包名：Android 应用的包名。填写创建 Android 应用时设置的应用包名。

#### 3. 集成小米推送

 1. 下载[小米推送 SDK](https://admin.xmpush.xiaomi.com/zh_CN/mipush/downpage)并集成到你的项目。

 2. 按照以下步骤配置 `AndroidManifest.xml`。详见 [官方文档](https://dev.mi.com/console/doc/detail?pId=41#_0_0)。

 - 添加如下权限：

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

 - 配置推送的 `service` 和 `receiver`：

    ```xml
    <service
        android:name="com.xiaomi.push.service.XMPushService"
        android:enabled="true"
        android:process=":pushservice" />
    
    <!--注：此服务必须在 3.0.1 版本以后（包括 3.0.1 版本）加入-->
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
    
    <!--注：此服务必须在 2.2.5 版本以后（包括 2.2.5 版本）加入-->
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

 3. 自定义一个继承自即时通讯 IM SDK 中 `EMMiMsgReceiver` 类的 `BroadcastReceiver` 并注册到 `AndroidManifest.xml` 文件中。

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

 4. 在 SDK 初始化时配置启用小米推送。

```java
ChatOptions options = new ChatOptions();
...
PushConfig.Builder builder = new PushConfig.Builder(this);
builder..enableMiPush(String appId, String appKey);
//将 pushconfig 设置为 ChatOptions。
options.setPushConfig(builder.build());
// 初始化即时通讯 IM SDK。
ChatClient.getInstance().init(this, options);
```

### OPPO 推送集成

即时通讯 IM SDK 中已经集成了 OPPO 推送相关逻辑，你还需要完成以下步骤：

#### 1. 在 OPPO 开发者后台创建应用

在 OPPO 开发者后台创建应用，开启 push 服务，并上传对应的证书指纹。详见 OPPO 官方介绍：[ OPPO 推送服务集成](https://open.oppomobile.com/new/developmentDoc/info?id=10195)

#### 2. 上传推送证书

注册完成后，需要在环信即时通讯云控制台上传推送证书，选择你的应用 —> **即时推送** —> **配置证书** —> **添加推送证书** —> **OPPO**，然后输入你在 [OPPO 开发者后台](https://open.oppomobile.com/service/oms?service_id=1000004&app_type=app&app_id=30004346)创建的应用的 `appkey` 和 `mastersecret` 以及程序的 `包名`，MasterSecret 需要到 [OPPO 推送平台](https://open.oppomobile.com/) > **配置管理** > **应用配置** 页面查看。

#### 3. 集成 OPPO 推送

1. 配置 OPPO 推送 jar 包。

在 OPPO 推送官网下载推送 SDK 包，将 jar 包放到 libs 目录下并 sync。也可以直接使用环信 Android IM Demo 中集成的 OPPO 推送的 jar 包。

2. 配置 `AndroidManifest.xml`。

  <div class="alert info">OPPO 推送在 2.1.0 适配了 Android Q，在 Android Q上接收 OPPO 推送需要升级环信 SDK 到 3.7.1 以及之后的版本，并使用 OPPO 推送 2.1.0 的包。从 1.0.3 版本开始，升级 OPPO 推送版本到 3.0.0<div>

 - 推送服务需要的权限列表：

 ```xml
 <!-- OPPO 推送配置 start -->
 <uses-permission android:name="com.coloros.mcs.permission.RECIEVE_MCS_MESSAGE"/>
 <uses-permission android:name="com.heytap.mcs.permission.RECIEVE_MCS_MESSAGE"/>
 <!-- OPPO 推送配置 end -->
 ```

 - 推送服务需要的服务：

 ```xml
 <!-- OPPO 推送配置 start -->
 <service
 android:name="com.heytap.msp.push.service.CompatibleDataMessageCallbackService"
 android:permission="com.coloros.mcs.permission.SEND_MCS_MESSAGE">
 <intent-filter>
     <action android:name="com.coloros.mcs.action.RECEIVE_MCS_MESSAGE"/>
 </intent-filter>
 </service> <!--兼容 Q 以下版本-->

 <service
 android:name="com.heytap.msp.push.service.DataMessageCallbackService"
 android:permission="com.heytap.mcs.permission.SEND_PUSH_MESSAGE">
 <intent-filter>
     <action android:name="com.heytap.mcs.action.RECEIVE_MCS_MESSAGE"/>
     <action android:name="com.heytap.msp.push.RECEIVE_MCS_MESSAGE"/>
 </intent-filter>
 </service> <!--兼容 Q 版本-->
 <!-- OPPO 推送配置 end -->
 ```

3. 在 SDK 初始化时，配置启用 OPPO 推送。

```java
ChatOptions options = new ChatOptions();
...
PushConfig.Builder builder = new PushConfig.Builder(this);
builder.enableOppoPush(String appKey,String appSecret);
// 将 pushconfig 设置为 ChatOptions
options.setPushConfig(builder.build());
// 初始化 IM SDK
ChatClient.getInstance().init(this, options);
```

4. 初始化 OPPO 推送。

```java
HeytapPushManager.init(context, true);
```

### VIVO 推送集成

环信即时通讯 IM SDK 中已经集成了 VIVO 推送（基于 `vivo_push_v2.3.1.jar`）相关逻辑，你还需要完成以下步骤：

#### 1. 在 VIVO 开发者后台创建应用

在 VIVO 开发者后台创建应用，开启推送服务，并上传对应的证书指纹。详见 VIVO 官方介绍：[ VIVO 推送服务集成](https://dev.vivo.com.cn/documentCenter/doc/281)。

#### 2. 上传推送证书

注册完成后，需要在环信即时通讯云控制台上传推送证书，选择你的应用 —> **即时推送** —> **配置证书** —> **添加推送证书** —> **VIVO**，然后输入你在 [VIVO 开发者后台](https://vpush.vivo.com.cn/#/appdetail)创建的应用的 `APP ID`，`APP KEY` 和 `APP SECRET` 以及程序的 `包名`。

#### 3. VIVO 推送集成

1. 配置 VIVO 推送 jar 包： 去 VIVO 推送官网下载推送 SDK 包，把 jar 包放到 libs 目录下并 sync 。也可以直接使用环信 Android IM Demo 中集成的 VIVO 推送的 jar 包。

2. 配置 `AndroidManifest.xml` 。

 - 推送服务需要的 service 和 receiver，并且需要配置 VIVO 的 app_id 和 app_key：

     ```xml
     <!-- VIVO 推送配置 start -->
     <!--VIVO Push SDK 的版本信息-->
     <meta-data
         android:name="sdk_version_vivo"
         android:value="484"/>
     <meta-data
         android:name="local_iv"
         android:value="MzMsMzQsMzUsMzYsMzcsMzgsMzksNDAsNDEsMzIsMzgsMzcsMzYsMzUsMzQsMzMsI0AzNCwzMiwzMywzNywzMywzNCwzMiwzMywzMywzMywzNCw0MSwzNSwzNSwzMiwzMiwjQDMzLDM0LDM1LDM2LDM3LDM4LDM5LDQwLDQxLDMyLDM4LDM3LDMzLDM1LDM0LDMzLCNAMzQsMzIsMzMsMzcsMzMsMzQsMzIsMzMsMzMsMzMsMzQsNDEsMzUsMzIsMzIsMzI" />
     <service
         android:name="com.vivo.push.sdk.service.CommandClientService"
         android:permission="com.push.permission.UPSTAGESERVICE"
         android:exported="true" />
     <activity
         android:name="com.vivo.push.sdk.LinkProxyClientActivity"
         android:exported="false"
         android:screenOrientation="portrait"
         android:theme="@android:style/Theme.Translucent.NoTitleBar" />
     <!--推送配置项-->
     <meta-data
         android:name="com.vivo.push.api_key"
         android:value="开发者自己申请的 appKey" />
     <meta-data
         android:name="com.vivo.push.app_id"
         android:value="开发者自己申请的 appId" />

     <receiver android:name="io.agora.push.platform.vivo.VivoMsgReceiver" >
         <intent-filter>
             <!-- 接收推送消息 -->
             <action android:name="com.vivo.pushclient.action.RECEIVE" />
         </intent-filter>
     </receiver>
     <!-- VIVO 推送配置 end -->
     ```

3. 在 SDK 初始化的时候，配置启用 VIVO 推送。

   ```java
   ChatOptions options = new ChatOptions();
   ...
   PushConfig.Builder builder = new PushConfig.Builder(this);
   builder.enableVivoPush();
   // 将 pushconfig 设置为 ChatOptions
   options.setPushConfig(builder.build());
   // 初始化 IM SDK
   ChatClient.getInstance().init(this, options);
   ```

4. VIVO 设备安装应用后默认没有打开允许通知权限，测试前需首先在设置中打开该应用的允许通知权限。

[VIVO 推送官方文档](https://dev.vivo.com.cn/documentCenter/doc/363)

### 魅族推送集成

#### 1. 在魅族开发者后台创建应用

在魅族开发者后台创建应用，开启推送服务，并上传对应的证书指纹。详见魅族官方介绍：[Flyme 推送服务集成](https://open.flyme.cn/docs?id=129)。

#### 2. 上传推送证书

注册完成后，需要在 Agora 控制台上传推送证书，选择你的应用 —> **即时推送** —> **配置证书** —> **添加推送证书** —> **魅族**，然后输入你在[ flyme 推送平台](http://push.meizu.com/#/config/app?appId=8843&_k=dnrz9k)创建的应用的 `APP ID` 和 `APP SECRET` 以及程序的 `包名`。

#### 3. 集成魅族推送

 1. 配置魅族推送 jar 包：

    在 app level/build.gradle 中添加依赖。

   ```gradle
   dependencies{
       // 该 aar 托管在 jcenter 中，请确保当前项目已配置 jcenter 仓库。
       implementation 'com.meizu.flyme.internet:push-internal:3.7.0@aar'
   }
   ```

 2. 配置 `AndroidManifest.xml`。

 - 推送服务需要的权限列表：

 ```xml
 <!-- 魅族推送配置 start-->
 <!-- 兼容 flyme5.0 以下版本，魅族内部集成 pushSDK 必填，不然无法收到消息-->
 <uses-permission android:name="com.meizu.flyme.push.permission.RECEIVE" />
 <permission
     android:name="${applicationId}.push.permission.MESSAGE"
     android:protectionLevel="signature" />
 <uses-permission android:name="${applicationId}.push.permission.MESSAGE" />
 <!-- 兼容 flyme3.0 配置权限-->
 <uses-permission android:name="com.meizu.c2dm.permission.RECEIVE" />
 <permission
     android:name="${applicationId}.permission.C2D_MESSAGE"
     android:protectionLevel="signature" />
 <uses-permission android:name="${applicationId}.permission.C2D_MESSAGE" />
 <!-- 魅族推送配置 end-->
 ```

 - 推送服务需要的 receiver：

```xml
 <!-- MEIZU 推送配置 start -->
 <receiver android:name="io.agora.push.platform.meizu.MzMsgReceiver">
     <intent-filter>
         <!-- 接收 push 消息 -->
         <action android:name="com.meizu.flyme.push.intent.MESSAGE"
             />
         <!-- 接收 register 消息 -->
         <action
             android:name="com.meizu.flyme.push.intent.REGISTER.FEEDBACK" />
         <!-- 接收 unregister 消息-->
         <action
             android:name="com.meizu.flyme.push.intent.UNREGISTER.FEEDBACK"/>
         <!-- 兼容低版本 Flyme3 推送服务配置 -->
         <action android:name="com.meizu.c2dm.intent.REGISTRATION"
             />
         <action android:name="com.meizu.c2dm.intent.RECEIVE" />
         <category android:name="${applicationId}"></category>
     <	/intent-filter>
 </receiver>
 <!-- MEIZU 推送配置 end -->
```

3. 在 SDK 初始化时配置启用魅族推送。

```java
ChatOptions options = new ChatOptions();
...
PushConfig.Builder builder = new PushConfig.Builder(this);
builder.enableMeiZuPush(String appId,String appKey);
// 将 pushconfig 设置为 ChatOptions
options.setPushConfig(builder.build());
// 初始化 IM SDK
ChatClient.getInstance().init(this, options);
```

## 设置推送通知 

为优化用户在处理大量推送通知时的体验，即时通讯 IM 在 app 和会话层面提供了推送通知和免打扰模式的细粒度选项。 

**推送通知方式**

<table>
<tbody>
<tr>
<td width="184">
<p><strong>推送通知方式参数</strong></p>
</td>
<td width="420">
<p><strong>描述</strong></p>
</td>
<td width="321">
<p><strong>应用范围</strong></p>
</td>
</tr>
<tr>
<td width="184">
<p>`ALL`</p>
</td>
<td width="420">
<p>接收所有离线消息的推送通知。</p>
</td>
<td rowspan="3" width="321">
<p>&nbsp;</p>
<p>App 或单聊/群聊会话</p>
</td>
</tr>
<tr>
<td width="184">
<p>`MENTION_ONLY`</p>
</td>
<td width="420">
<p>仅接收提及消息的推送通知。</p>
<p>该参数推荐在群聊中使用。若提及一个或多个用户，需在创建消息时对 `ext` 字段传 "em_at_list":["user1", "user2" ...]；若提及所有人，对该字段传 "em_at_list":"all"。</p>
</td>
</tr>
<tr>
<td width="184">
<p>`NONE`</p>
</td>
<td width="420">
<p>不接收离线消息的推送通知。</p>
</td>
</tr>
</tbody>
</table>
<p>&nbsp;</p>

会话级别的推送通知方式设置优先于 app 级别的设置，未设置推送通知方式的会话默认采用 app 的设置。

例如，假设 app 的推送方式设置为 `MENTION_ONLY`，而指定会话的推送方式设置为 `ALL`。你会收到来自该会话的所有推送通知，而对于其他会话来说，你只会收到提及你的消息的推送通知。

**免打扰模式**

你可以在 app 级别指定免打扰时间段和免打扰时长，环信 IM 在这两个时间段内不发送离线推送通知。若既设置了免打扰时间段，又设置了免打扰时长，免打扰模式的生效时间为这两个时间段的累加。

免打扰时间参数的说明如下表所示：

| 免打扰时间参数     |  描述   |   应用范围 |
| :--------| :----- | :----------------------------------------------------------- |
| `SILENT_MODE_INTERVAL` | 免打扰时间段，精确到分钟，格式为 HH:MM-HH:MM，例如 08:30-10:00。该时间为 24 小时制，免打扰时间段的开始时间和结束时间中的小时数和分钟数的取值范围分别为 [00,23] 和 [00,59]。免打扰时间段的设置说明如下：<ul><li>开始时间和结束时间的设置立即生效，免打扰模式每天定时触发。例如，开始时间为 `08:00`，结束时间为 `10:00`，免打扰模式在每天的 8:00-10:00 内生效。若你在 11:00 设置开始时间为 `08:00`，结束时间为 `12:00`，则免打扰模式在当天的 11:00-12:00 生效，以后每天均在 8:00-12:00 生效。</li><li>若开始时间和结束时间相同，免打扰模式则全天生效。</li><li>若结束时间早于开始时间，则免打扰模式在每天的开始时间到次日的结束时间内生效。例如，开始时间为 `10:00`，结束时间为 `08:00`，则免打扰模式的在当天的 10:00 到次日的 8:00 生效。</li><li>目前仅支持在每天的一个指定时间段内开启免打扰模式，不支持多个免打扰时间段，新的设置会覆盖之前的设置。</li><li>若不设置该参数，传空字符串。</li></ul> | 仅用于 app 级别，对单聊或群聊会话不生效。 |
| `SILENT_MODE_DURATION`|  免打扰时长，单位为毫秒。免打扰时长的取值范围为 [0,604800000]，`0` 表示该参数无效，`604800000` 表示免打扰模式持续 7 天。<br/> 与免打扰时间段的设置长久有效不同，该参数为一次有效。    | App 或单聊/群聊会话。  |

若在免打扰时段或时长生效期间需要对指定用户推送消息，需设置[强制推送](#forced)。

**推送通知方式与免打扰时间设置之间的关系**

对于 app 和 app 中的所有会话，免打扰模式的设置优先于推送通知方式的设置。例如，假设在 app 级别指定了免打扰时间段，并将指定会话的推送通知方式设置为 `ALL`。免打扰模式与推送通知方式的设置无关，即在指定的免打扰时间段内，你不会收到任何推送通知。

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
//设置离线推送的免打扰时间段为 8:30 至 15:00。
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

你可以调用 `getSilentModeForConversation` 方法获取指定会话的推送通知设置，如以下代码示例所示：

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

你可以调用 `getSilentModeForConversations` 方法获取多个会话的推送通知设置，如以下示例代码所示：

```java
ChatClient.getInstance().pushManager().getSilentModeForConversations(conversationList, new ValueCallBack<Map<String, SilentModeResult>>(){
    @Override
    public void onSuccess(Map<String, SilentModeResult> value) {}
    @Override
    public void onError(int error, String errorMsg) {}
});
```

### 清除单个会话的推送通知方式的设置

你可以调用 `clearRemindTypeForConversation` 方法清除指定会话的推送通知方式的设置。清除后，默认情况下，该会话会继承 app 的设置。

以下代码示例显示了如何清除会话的推送通知方式：

```java
ChatClient.getInstance().pushManager().clearRemindTypeForConversation(conversationId, conversationType, new CallBack(){});
```

## 设置显示属性

### 设置推送通知的显示属性

你可以调用 `updatePushNickname` 方法设置推送通知中显示的昵称，如以下代码示例所示：

```java
// 需要异步处理。
ChatClient.getInstance().pushManager().updatePushNickname("pushNickname");
```

你也可以调用 `updatePushDisplayStyle` 方法设置推送通知的显示样式，如下代码示例所示：

```java
// `DisplayStyle` 设置为简单样式 `SimpleBanner`，只显示 "你有一条新消息"。若要显示消息内容，需设置为 `MessageSummary`。
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

以下示例代码显示如何设置和获取推送通知的首选语言：

```java
// 设置离线推送的首选语言。
ChatClient.getInstance().pushManager().setPreferredNotificationLanguage("en", new CallBack(){});

// 获取设置的离线推送的首选语言。
ChatClient.getInstance().pushManager().getPreferredNotificationLanguage(new ValueCallBack<String>(){});
```

## 设置推送模板

即时通讯 IM 支持自定义推送通知模板。使用前，你可以参考以下步骤为用户创建和提供推送模板：

1. 登录 Agora 控制台，点击左侧导航栏中的**项目管理**。

2. 在**项目管理** 页面，找到开启即时通讯 IM 的项目，点击**配置**。

3. 在**服务配置**页面，点击 **即时通讯IM** 框的**配置**。

4. 在左侧导航栏，选择**功能配置 > 推送模板**并单击**添加推送模板**，在弹出的对话框中配置字段，如下图所示。

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
| `m`  | 消息 ID。消息唯一标识符。     |
| `g`  | 群组 ID，仅当消息为群组消息时，该字段存在。     |
| `e`  | 用户自定义扩展字段。     |

其中 e 为用户自定义扩展，而数据来源为 `em_apns_ext` 或 `em_apns_ext.extern`。

规则如下：

- 当 `extern` 不存在时，`e` 内容为 `em_apns_ext` 下推送服务未使用字段，即除 `em_push_title`，`em_push_content`，`em_push_name`，`em_push_channel_id`，`em_huawei_push_badge_class` 之外的其他字段。
- 当 `extern` 存在时，使用 `extern` 下字段。


### 示例代码

#### 解析 FCM 推送字段

重写 `FirebaseMessagingService.onMessageReceived` 方法可以在 `RemoteMessage` 对象中获取自定义扩展：

```java
public class FCMMSGService extends FirebaseMessagingService {
    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        super.onMessageReceived(remoteMessage);
        if (remoteMessage.getData().size() > 0) {
            String f = remoteMessage.getData().get("f");
            String t = remoteMessage.getData().get("t");
            String m = remoteMessage.getData().get("m");
            String g = remoteMessage.getData().get("g");
            Object e = remoteMessage.getData().get("e");
        }
    }
}
```

#### 解析华为推送字段

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

#### 解析小米推送字段

重写 `EMMiMsgReceiver.onNotificationMessageClicked` 方法可以在 `MiPushMessage` 对象中获取自定义扩展：

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

#### 解析 VIVO 推送字段

重写 `VivoMsgReceiver.onNotificationMessageClicked` 方法可以在 `UPSNotificationMessage` 对象中获取自定义扩展：

```java
public class MyVivoMsgReceiver extends VivoMsgReceiver {
    @Override
    public void onNotificationMessageClicked(Context context, UPSNotificationMessage upsNotificationMessage) {
        Map<String, String> map = upsNotificationMessage.getParams();
        if(!map.isEmpty()) {
            String t = map.get("t");
            String f = map.get("f");
            String m = map.get("m");
            String g = map.get("g");
            Object e = map.get("e");
        }
    }
}
```

#### 解析 OPPO 推送字段

解析方式同华为。

#### 解析魅族推送字段

解析方式同华为。

## 更多功能

### 自定义字段

参考如下代码，向推送中添加你自己的业务字段以满足业务需求，比如通过这条推送跳转到应用的某个页面（需要应用在前台运行时）。

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
| `em_apns_ext`    | 消息扩展字段。该字段名固定，不可修改。     |
| `test1`          | 用户添加的自定义 key。  |

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
| `em_apns_ext`     | 消息扩展字段。该字段名固定，不可修改。     |
| `em_push_title`   | 自定义推送消息标题。该字段名固定，不可修改。     |
| `em_push_content` | 自定义推送消息内容。该字段名固定，不可修改。     |

### 强制推送<a name="forced"></a>

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
| `em_force_notification` | 是否为强制推送：<ul><li>`true`：强制推送</li><li>`false`：</li></ul><br/>非强制推送该字段名固定，不可修改。 |