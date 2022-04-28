本文介绍如何通过少量代码集成 Agora 即时通讯 SDK，在你的 Android app 中实现发送和接收一对一文本消息。

## 技术原理
~7aac3300-785d-11ec-bcb4-b56a01c83d2e~

## 前提条件
- Android 模拟器或移动设备。
- Android Studio 3.2 或以上版本。
- [Java Development Kit](https://www.oracle.com/java/technologies/downloads/)
- Android API 级别 19 或以上。

## 项目设置

实现发送和接收一对一文本消息之前，参考以下步骤设置你的项目：

### 创建一个 Android 项目

如需创建新项目，在 **Android Studio** 里，依次选择 **Phone and Tablet > Empty Activity**，创建 [Android 项目](https://developer.android.com/studio/projects/create-project)。

### 集成 Agora 即时通讯 SDK 
为方便集成，Agora 将 Agora 即时通讯 Android SDK 发布至 Maven Central，你可以参考以下步骤来集成 SDK：
1. 在 `/Gradle Scripts/build.gradle(Project: <projectname>)` 文件中添加如下代码：
   ```java
   buildscript {
       repositories {
           ...
           mavenCentral()
       }
   }
   allprojects {
       repositories {
           ...
           mavenCentral()
       }
   }
   ```

2. 在 `/Gradle Scripts/build.gradle(Module: app)` 文件中添加如下代码；请将 X.Y.Z 替换为你所集成的 SDK 版本号，点击[此处](https://search.maven.org/search?q=a:chat-sdk)查看最新版本号。

   ```java
   android {
       defaultConfig {
               // Android API 级别需为 19 或以上。
               minSdkVersion 19
       }
       compileOptions {
           sourceCompatibility JavaVersion.VERSION_1_8
           targetCompatibility JavaVersion.VERSION_1_8
       }
   }
   dependencies {
       ...
       implementation 'io.agora.rtc:chat-sdk:X.Y.Z'
   }
   ```

   <div class="alert note"><code>minSdkVersion</code> 必需为19 或以上。</div>

### 防止代码混淆

在 `/Gradle Scripts/proguard-rules.pro` 文件中添加如下代码，防止混淆 SDK 的代码混淆。

```java
-keep class io.agora.** {*;}
-dontwarn  io.agora.**
```

### 添加网络及设备权限

在 `/app/Manifests/AndroidManifest.xml` 文件中，在 `</application>` 后面添加如下权限：

```java
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.WAKE_LOCK"/>
```

以上为实现发送和接收一对一消息所需的基本权限，你还可以根据自己的需求添加其他权限。

## 实现发送和接收一对一消息

本节介绍如何使用 Agora 即时通讯 SDK 在你的 app 中实现发送和接收一对一文本消息。

### 创建 UI

1. 在  `app/res/values/strings.xml` 文件中，用如下代码进行替换：

   ```xml
   <resources>
       <string name="app_name">AgoraChatQuickstart</string>
   
       <string name="username_or_pwd_miss">Username or password is empty</string>
       <string name="sign_up_success">Sign up success!</string>
       <string name="sign_in_success">Sign in success!</string>
       <string name="sign_out_success">Sign out success!</string>
       <string name="send_message_success">Send message success!</string>
       <string name="enter_username">Enter username</string>
       <string name="enter_password">Enter password</string>
       <string name="sign_in">Sign in</string>
       <string name="sign_out">Sign out</string>
       <string name="sign_up">Sign up</string>
       <string name="enter_content">Enter content</string>
       <string name="enter_to_send_name">Enter the username you want to send</string>
       <string name="send_message">Send text</string>
       <string name="send_image_message">Send image</string>
       <string name="log_hint">Show log area...</string>
       <string name="has_login_before">An account has been signed in, please sign out first and then sign in</string>
       <string name="sign_in_first">Please sign in first</string>
       <string name="not_find_send_name">Please enter the username who you want to send first!</string>
       <string name="message_is_null">Message is null!</string>
   
       <string name="app_key">41117440#383391</string>
   </resources>
   ``` 
	 <div class="alert note"> 在生产环境中，你需要将 <code>app_key</code> 替换为你的 Agora 项目的 AppKey。</div>

2. 打开 `app/res/layout/activity_main.xml` 文件，用如下代码进行替换来创建一个简单的用户界面：

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
       xmlns:app="http://schemas.android.com/apk/res-auto"
       xmlns:tools="http://schemas.android.com/tools"
       android:layout_width="match_parent"
       android:layout_height="match_parent"
       android:orientation="vertical"
       tools:context=".MainActivity">
   
       <ScrollView
           android:layout_width="match_parent"
           android:layout_height="0dp"
           android:layout_weight="1">
   
           <androidx.constraintlayout.widget.ConstraintLayout
               android:layout_width="match_parent"
               android:layout_height="wrap_content">
   
               <EditText
                   android:id="@+id/et_username"
                   android:layout_width="0dp"
                   android:layout_height="wrap_content"
                   android:hint="@string/enter_username"
                   app:layout_constraintLeft_toLeftOf="parent"
                   app:layout_constraintRight_toRightOf="parent"
                   app:layout_constraintTop_toTopOf="parent"
                   android:layout_marginStart="20dp"
                   android:layout_marginEnd="20dp"
                   android:layout_marginTop="20dp"/>
   
               <EditText
                   android:id="@+id/et_pwd"
                   android:layout_width="0dp"
                   android:layout_height="wrap_content"
                   android:hint="@string/enter_password"
                   android:inputType="textPassword"
                   app:layout_constraintLeft_toLeftOf="parent"
                   app:layout_constraintRight_toRightOf="parent"
                   app:layout_constraintTop_toBottomOf="@id/et_username"
                   android:layout_marginStart="20dp"
                   android:layout_marginEnd="20dp"
                   android:layout_marginTop="10dp"/>
   
               <Button
                   android:id="@+id/btn_sign_in"
                   android:layout_width="0dp"
                   android:layout_height="wrap_content"
                   android:text="@string/sign_in"
                   android:onClick="signInWithToken"
                   app:layout_constraintLeft_toLeftOf="parent"
                   app:layout_constraintTop_toBottomOf="@id/et_pwd"
                   app:layout_constraintRight_toLeftOf="@id/btn_sign_out"
                   android:layout_marginStart="10dp"
                   android:layout_marginEnd="5dp"
                   android:layout_marginTop="10dp"/>
   
               <Button
                   android:id="@+id/btn_sign_out"
                   android:layout_width="0dp"
                   android:layout_height="wrap_content"
                   android:text="@string/sign_out"
                   android:onClick="signOut"
                   app:layout_constraintLeft_toRightOf="@id/btn_sign_in"
                   app:layout_constraintTop_toBottomOf="@id/et_pwd"
                   app:layout_constraintRight_toLeftOf="@id/btn_sign_up"
                   android:layout_marginStart="5dp"
                   android:layout_marginEnd="5dp"
                   android:layout_marginTop="10dp"/>
   
               <Button
                   android:id="@+id/btn_sign_up"
                   android:layout_width="0dp"
                   android:layout_height="wrap_content"
                   android:text="@string/sign_up"
                   android:onClick="signUp"
                   app:layout_constraintLeft_toRightOf="@id/btn_sign_out"
                   app:layout_constraintRight_toRightOf="parent"
                   app:layout_constraintTop_toBottomOf="@id/et_pwd"
                   app:layout_constraintTop_toTopOf="@id/btn_sign_in"
                   android:layout_marginStart="5dp"
                   android:layout_marginEnd="10dp"/>
   
               <EditText
                   android:id="@+id/et_to_chat_name"
                   android:layout_width="0dp"
                   android:layout_height="wrap_content"
                   android:hint="@string/enter_to_send_name"
                   app:layout_constraintLeft_toLeftOf="parent"
                   app:layout_constraintRight_toRightOf="parent"
                   app:layout_constraintTop_toBottomOf="@id/btn_sign_in"
                   android:layout_marginStart="20dp"
                   android:layout_marginEnd="20dp"
                   android:layout_marginTop="20dp"/>
   
               <EditText
                   android:id="@+id/et_msg_content"
                   android:layout_width="0dp"
                   android:layout_height="wrap_content"
                   android:hint="@string/enter_content"
                   app:layout_constraintLeft_toLeftOf="parent"
                   app:layout_constraintRight_toRightOf="parent"
                   app:layout_constraintTop_toBottomOf="@id/et_to_chat_name"
                   android:layout_marginStart="20dp"
                   android:layout_marginEnd="20dp"
                   android:layout_marginTop="10dp"/>
   
               <Button
                   android:id="@+id/btn_send_message"
                   android:layout_width="0dp"
                   android:layout_height="wrap_content"
                   android:text="@string/send_message"
                   android:onClick="sendFirstMessage"
                   app:layout_constraintLeft_toLeftOf="parent"
                   app:layout_constraintRight_toRightOf="parent"
                   app:layout_constraintTop_toBottomOf="@id/et_msg_content"
                   android:layout_marginStart="10dp"
                   android:layout_marginEnd="10dp"
                   android:layout_marginTop="20dp"/>
   
           </androidx.constraintlayout.widget.ConstraintLayout>
   
       </ScrollView>
   
       <TextView
           android:id="@+id/tv_log"
           android:layout_width="match_parent"
           android:layout_height="200dp"
           android:hint="@string/log_hint"
           android:scrollbars="vertical"
           android:padding="10dp"/>
   
   </LinearLayout>
   ```

### 实现发送和接收消息

参考以下步骤实现发送和接收消息的逻辑：

1. 导入类。在 `app/java/io.agora.agorachatquickstart/MainActivity` 文件中，在 `import android.os.Bundle;` 下面添加如下代码：

   ```java
   import android.text.TextUtils;
   import android.text.method.ScrollingMovementMethod;
   import android.view.View;
   import android.widget.EditText;
   import android.widget.TextView;
   import android.widget.Toast;
   
   import org.json.JSONObject;
   
   import java.util.HashMap;
   import java.util.List;
   import java.util.Map;
   
   import static io.agora.cloud.HttpClientManager.Method_POST;
   import io.agora.CallBack;
   import io.agora.ConnectionListener;
   import io.agora.Error;
   import io.agora.MessageListener;
   import io.agora.agorachatquickstart.utils.LogUtils;
   import io.agora.chat.ChatClient;
   import io.agora.chat.ChatMessage;
   import io.agora.chat.ChatOptions;
   import io.agora.chat.TextMessageBody;
   import io.agora.cloud.HttpClientManager;
   import io.agora.cloud.HttpResponse;
   import io.agora.util.EMLog;
   ```
   
2. 定义变量。在 `app/java/io.agora.agorachatquickstart/MainActivity` 文件中，先将文件中自动生成的 `OnCreate` 函数删除，再在 `AppCompatActivity {` 后面添加如下代码：

   ```java
   private final String TAG = getClass().getSimpleName();
   private static final String NEW_LOGIN = "NEW_LOGIN";
   private static final String RENEW_TOKEN = "RENEW_TOKEN";
   private static final String ACCOUNT_REMOVED = "account_removed";
   private static final String ACCOUNT_CONFLICT = "conflict";
   private static final String ACCOUNT_FORBIDDEN = "user_forbidden";
   private static final String ACCOUNT_KICKED_BY_CHANGE_PASSWORD = "kicked_by_change_password";
   private static final String ACCOUNT_KICKED_BY_OTHER_DEVICE = "kicked_by_another_device";
   private static final String LOGIN_URL = "https://a41.easemob.com/app/chat/user/login";
   private static final String REGISTER_URL = "https://a41.easemob.com/app/chat/user/register";
   private EditText et_username;
   private TextView tv_log;
   private EditText et_to_chat_name;
   
   @Override
   protected void onCreate(Bundle savedInstanceState) {
       super.onCreate(savedInstanceState);
       setContentView(R.layout.activity_main);
       initView();
       initSDK();
       addMessageListener();
       addConnectionListener();
   }
   ```
   
3.在 `app/java/io.agora.agorachatquickstart/MainActivity` 文件中，在 `onCreate` 函数后添加以下代码：

   ```java
   // 初始化视图。
   private void initView() {
           et_username = findViewById(R.id.et_username);
           tv_log = findViewById(R.id.tv_log);
           tv_log.setMovementMethod(new ScrollingMovementMethod());
           et_to_chat_name = findViewById(R.id.et_to_chat_name);
       }
       // 初始化 SDK.
       private void initSDK() {
           ChatOptions options = new ChatOptions();
           // Set the appkey you obtained from Agora Console.
           String sdkAppkey = getString(R.string.app_key);
           if(TextUtils.isEmpty(sdkAppkey)) {
               Toast.makeText(MainActivity.this, "You should set your AppKey first!", Toast.LENGTH_SHORT).show();
               return;
           }
           // app key 设置。
           options.setAppKey(sdkAppkey);
           // 设置仅使用 HTTPS。
           options.setUsingHttpsOnly(true);
           ChatClient.getInstance().init(this, options);
           ChatClient.getInstance().setDebugMode(true);
       }
   ```

4. 获取 Token。在 `app/java/io.agora.agorachatquickstart/MainActivity` 文件中，在 `initSDK` 函数后面添加以下代码来从 app 服务端获取 Token：

   ```java
   // 从 app 服务器 获取 Token。
   private void getTokenFromAppServer(String requestType) {
       if(ChatClient.getInstance().isLoggedInBefore()) {
           LogUtils.showErrorLog(tv_log, getString(R.string.has_login_before));
           return;
       }
       String username = et_username.getText().toString().trim();
       String pwd = ((EditText) findViewById(R.id.et_pwd)).getText().toString().trim();
       if(TextUtils.isEmpty(username) || TextUtils.isEmpty(pwd)) {
           LogUtils.showErrorToast(MainActivity.this, tv_log, getString(R.string.username_or_pwd_miss));
           return;
       }
       execute(()-> {
           try {
               Map<String, String> headers = new HashMap<>();
               headers.put("Content-Type", "application/json");
   
               JSONObject request = new JSONObject();
               request.putOpt("userAccount", username);
               request.putOpt("userPassword", pwd);
   
               LogUtils.showErrorLog(tv_log,"begin to getTokenFromAppServer ...");
   
               HttpResponse response = HttpClientManager.httpExecute(LOGIN_URL, headers, request.toString(), Method_POST);
               int code = response.code;
               String responseInfo = response.content;
               if (code == 200) {
                   if (responseInfo != null && responseInfo.length() > 0) {
                       JSONObject object = new JSONObject(responseInfo);
                       String token = object.getString("accessToken");
                       if(TextUtils.equals(requestType, NEW_LOGIN)) {
                           ChatClient.getInstance().loginWithAgoraToken(username, token, new CallBack() {
                               @Override
                               public void onSuccess() {
                                   LogUtils.showToast(MainActivity.this, tv_log, getString(R.string.sign_in_success));
                               }
   
                               @Override
                               public void onError(int code, String error) {
                                   LogUtils.showErrorToast(MainActivity.this, tv_log, "Login failed! code: " + code + " error: " + error);
                               }
   
                               @Override
                               public void onProgress(int progress, String status) {
   
                               }
                           });
                       }else if(TextUtils.equals(requestType, RENEW_TOKEN)) {
                           ChatClient.getInstance().renewToken(token);
                       }
   
                   } else {
                       LogUtils.showErrorToast(MainActivity.this, tv_log, "getTokenFromAppServer failed! code: " + code + " error: " + responseInfo);
                   }
               } else {
                   LogUtils.showErrorToast(MainActivity.this, tv_log, "getTokenFromAppServer failed! code: " + code + " error: " + responseInfo);
               }
           } catch (Exception e) {
               e.printStackTrace();
               LogUtils.showErrorToast(MainActivity.this, tv_log, "getTokenFromAppServer failed! code: " + 0 + " error: " + e.getMessage());
   
           }
       });
   }
   ```

5. 添加消息事件回调。在 `app/java/io.agora.agorachatquickstart/MainActivity` 文件中，在 `getTokenFromAppServer` 函数后面添加以下代码：

   ```java
   // 添加消息事件回调。  
   private void addMessageListener() {
       ChatClient.getInstance().chatManager().addMessageListener(new MessageListener() {
           @Override
           public void onMessageReceived(List<ChatMessage> messages) {
               parseMessage(messages);
           }
   
           @Override
           public void onCmdMessageReceived(List<ChatMessage> messages) {
               LogUtils.showLog(tv_log, "onCmdMessageReceived");
           }
   
           @Override
           public void onMessageRead(List<ChatMessage> messages) {
               LogUtils.showLog(tv_log, "onMessageRead");
           }
   
           @Override
           public void onMessageDelivered(List<ChatMessage> messages) {
               LogUtils.showLog(tv_log, "onMessageDelivered");
           }
   
           @Override
           public void onMessageRecalled(List<ChatMessage> messages) {
               LogUtils.showLog(tv_log, "onMessageRecalled");
           }
   
           @Override
           public void onMessageChanged(ChatMessage message, Object change) {
               LogUtils.showLog(tv_log, "onMessageChanged");
           }
       });
   }
   // 消息日志
   private void parseMessage(List<ChatMessage> messages) {
           if(messages != null && !messages.isEmpty()) {
               for(ChatMessage message : messages) {
                   ChatMessage.Type type = message.getType();
                   String from = message.getFrom();
                   StringBuilder builder = new StringBuilder();
                   builder.append("Receive a ")
                           .append(type.name())
                           .append(" message from: ")
                           .append(from);
                   if(type == ChatMessage.Type.TXT) {
                       builder.append(" content:")
                               .append(((TextMessageBody)message.getBody()).getMessage());
                   }
                   LogUtils.showLog(tv_log, builder.toString());
               }
           }
       }
   // 添加连接状态事件回调。
   private void addConnectionListener() {
           ChatClient.getInstance().addConnectionListener(new ConnectionListener(){
               @Override
               public void onConnected() {
               }
   
               @Override
               public void onDisconnected(int error) {
                   if (error == Error.USER_REMOVED) {
                       onUserException(ACCOUNT_REMOVED);
                   } else if (error == Error.USER_LOGIN_ANOTHER_DEVICE) {
                       onUserException(ACCOUNT_CONFLICT);
                   } else if (error == Error.SERVER_SERVICE_RESTRICTED) {
                       onUserException(ACCOUNT_FORBIDDEN);
                   } else if (error == Error.USER_KICKED_BY_CHANGE_PASSWORD) {
                       onUserException(ACCOUNT_KICKED_BY_CHANGE_PASSWORD);
                   } else if (error == Error.USER_KICKED_BY_OTHER_DEVICE) {
                       onUserException(ACCOUNT_KICKED_BY_OTHER_DEVICE);
                   }
               }
             
               protected void onUserException(String exception) {
                   EMLog.e(TAG, "onUserException: " + exception);
                   ChatClient.getInstance().logout(false, null);
               }
             
               // Token 已过期，你需要获取一个新的 Token 并重新登录 app。
               @Override
               public void onTokenExpired() {
                   //使用新 Token 重新登录。
                   signInWithToken(null);
                   LogUtils.showLog(tv_log,"ConnectionListener onTokenExpired");
               }
               // Token 即将过期回调。 
               @Override
               public void onTokenWillExpire() {
                   getTokenFromAppServer(RENEW_TOKEN);
                   LogUtils.showLog(tv_log, "ConnectionListener onTokenWillExpire");
               }
             
           });
       }
   
   ```

6. 注册一个新用户并登录 Agora 即时通讯系统。在 `app/java/io.agora.agorachatquickstart/MainActivity` 文件中，在 `addConnectionListener` 函数后面添加以下代码：

   ```java
   // 注册一个新用户。
   public void signUp(View view) {
       String username = et_username.getText().toString().trim();
       String pwd = ((EditText) findViewById(R.id.et_pwd)).getText().toString().trim();
       if(TextUtils.isEmpty(username) || TextUtils.isEmpty(pwd)) {
           LogUtils.showErrorToast(this, tv_log, getString(R.string.username_or_pwd_miss));
           return;
       }
       execute(()-> {
           try {
               Map<String, String> headers = new HashMap<>();
               headers.put("Content-Type", "application/json");
               JSONObject request = new JSONObject();
               request.putOpt("userAccount", username);
               request.putOpt("userPassword", pwd);
   
               LogUtils.showErrorLog(tv_log,"begin to signUp...");
   
               HttpResponse response = HttpClientManager.httpExecute(REGISTER_URL, headers, request.toString(), Method_POST);
               int code=  response.code;
               String responseInfo = response.content;
               if (code == 200) {
                   if (responseInfo != null && responseInfo.length() > 0) {
                       JSONObject object = new JSONObject(responseInfo);
                       String resultCode = object.getString("code");
                       if(resultCode.equals("RES_OK")) {
                           LogUtils.showToast(MainActivity.this, tv_log, getString(R.string.sign_up_success));
                       }else{
                           String errorInfo = object.getString("errorInfo");
                           LogUtils.showErrorLog(tv_log,errorInfo);
                       }
                   } else {
                       LogUtils.showErrorLog(tv_log,responseInfo);
                   }
               } else {
                   LogUtils.showErrorLog(tv_log,responseInfo);
               }
           } catch (Exception e) {
               e.printStackTrace();
               LogUtils.showErrorLog(tv_log, e.getMessage());
           }
       });
   }
   
   // 使用 Token 登录。
   public void signInWithToken(View view) {
       getTokenFromAppServer(NEW_LOGIN);
   }
   
   // 登出。
   public void signOut(View view) {
       if(ChatClient.getInstance().isLoggedInBefore()) {
           ChatClient.getInstance().logout(true, new CallBack() {
               @Override
               public void onSuccess() {
                   LogUtils.showToast(MainActivity.this, tv_log, getString(R.string.sign_out_success));
               }
               
               @Override
               public void onError(int code, String error) {
                   LogUtils.showErrorToast(MainActivity.this, tv_log, "Sign out failed! code: "+code + " error: "+error);
               }
               
               @Override
               public void onProgress(int progress, String status) {
   
               }
           });
       }
   }
   ```

7. 发送消息。在 `app/java/io.agora.agorachatquickstart/MainActivity` 文件中，在 `signOut` 函数后面添加以下代码：

   ```java
   // 发送一条消息。
   public void sendFirstMessage(View view) {
       if(!ChatClient.getInstance().isLoggedInBefore()) {
           LogUtils.showErrorLog(tv_log, getString(R.string.sign_in_first));
           return;
       }
       String toSendName = et_to_chat_name.getText().toString().trim();
       if(TextUtils.isEmpty(toSendName)) {
           LogUtils.showErrorToast(this, tv_log, getString(R.string.not_find_send_name));
           return;
       }
       EditText et_msg_content = findViewById(R.id.et_msg_content);
       String content = et_msg_content.getText().toString().trim();
   
       ChatMessage message = ChatMessage.createTxtSendMessage(content, toSendName);
       sendMessage(message);
   
   }
   private void sendMessage(ChatMessage message) {
       if(message == null) {
           LogUtils.showErrorToast(this, tv_log, getString(R.string.message_is_null));
           return;
       }
       message.setMessageStatusCallback(new CallBack() {
           @Override
           public void onSuccess() {
               LogUtils.showToast(MainActivity.this, tv_log, getString(R.string.send_message_success));
           }
   
           @Override
           public void onError(int code, String error) {
               LogUtils.showErrorToast(MainActivity.this, tv_log, "Send message failed! code: "+code + " error: " + error );
           }
   
           @Override
           public void onProgress(int progress, String status) {
   
           }
       });
       ChatClient.getInstance().chatManager().sendMessage(message);
   }
   
       public void execute(Runnable runnable) {
           new Thread(runnable).start();
       }
   }
   ```

8. 为了快速排查问题，你还可以添加 LgoUtils 工具类：在 `app/java/io.agora.agorachatquickstart/` 路径下创建一个名为 `utils` 的文件夹；在此文件夹中创建一个 `LogUtils.java` 文件并将以下代码复制到该文件中：

   ```java
   package io.agora.agorachatquickstart.utils;
   
   import android.app.Activity;
   import android.text.TextUtils;
   import android.util.Log;
   import android.widget.TextView;
   import android.widget.Toast;
   
   import java.text.SimpleDateFormat;
   import java.util.Date;
   import java.util.Locale;
   
   public class LogUtils {
       private static final String TAG = LogUtils.class.getSimpleName();
   
       public static void showErrorLog(TextView tvLog, String content) {
           showLog(tvLog, content);
       }
   
       public static void showNormalLog(TextView tvLog, String content) {
           showLog(tvLog, content);
       }
   
       public static void showLog(TextView tvLog, String content) {
           if(TextUtils.isEmpty(content) || tvLog == null) {
               return;
           }
           String preContent = tvLog.getText().toString().trim();
           StringBuilder builder = new StringBuilder();
           builder.append(formatCurrentTime())
                   .append(" ")
                   .append(content)
                   .append("\n")
                   .append(preContent);
           tvLog.post(()-> {
               tvLog.setText(builder);
           });
       }
   
       public static void showErrorToast(Activity activity, TextView tvLog, String content) {
           if(activity == null || activity.isFinishing()) {
               Log.e(TAG, "Context is null...");
               return;
           }
           if(TextUtils.isEmpty(content)) {
               return;
           }
           activity.runOnUiThread(()-> {
               Toast.makeText(activity, content, Toast.LENGTH_SHORT).show();
               showErrorLog(tvLog,content);
           });
       }
   
       public static void showToast(Activity activity, TextView tvLog, String content) {
           if(TextUtils.isEmpty(content) || activity == null || activity.isFinishing()) {
               return;
           }
           activity.runOnUiThread(()-> {
               Toast.makeText(activity, content, Toast.LENGTH_SHORT).show();
               showNormalLog(tvLog, content);
           });
       }
   
       private static String formatCurrentTime() {
           SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault());
           return sdf.format(new Date());
       }
   
   }
   ```

9. 点击 `Sync Project with Gradle Files` 来同步 gradle，同步成功后即可开始测试你的 app 。

## 测试你的 app

现在你已经成功将一对一通信功能添加到你的 app 中，参考以下步骤来测试你的 app：

1. 点击 Run 'app'，以下界面会自动在你用于测试的模拟器或真机上弹出：
   <img src="https://web-cdn.agora.io/docs-files/1637661621212" style="zoom:50%;" />

2. 注册一个新用户。输入你想注册的用户名和密码，点击 **SIGN UP** 注册。

3. 使用注册好的新用户登录并发送一条消息给另一个用户。
   <img src="https://web-cdn.agora.io/docs-files/1637562675862" style="zoom:50%;" />

4. 在另一设备上运行你的 app，注册另一新用户并登录，请确保注册的新用户名没有重名。

5. 在两个用户之间发送消息。
   <img src="https://web-cdn.agora.io/docs-files/1637562770527" style="zoom:50%;" />

## 后续步骤

为保障通信安全，在正式生产环境中，你需要在自己的 app 服务端生成 Token。详见[使用 User Token 鉴权](https://docs-preprod.agora.io/cn/agora-chat/generate_user_tokens%20?platform=Android)。

## 更多信息

除了通过 mavenCentral 集成 Agora 即时通讯 SDK 外，你也可以手动复制 SDK 文件，将 SDK 导入你的项目。

1. 下载最新版本的 [Agora 即时通讯 SDK](./downloads?platform=Android) 并解压。

2. 打开 SDK 包 `libs` 文件夹，将以下文件或子文件夹复制到你的项目路径中。X.Y.Z 指你下载的 SDK 的版本号。

   | 文件或子文件夹                                    | 项目路径                 |
   | ------------------------------------------------------ | ------------------------------------- |
   | `agorachat_X.Y.Z.jar`                                  | `~/app/libs/`                         |
   | `/arm64-v8a/libagora-chat-sdk.so` 和 `libsqlite.so`   | `~/app/src/main/jniLibs/arm64-v8a/`   |
   | `/armeabi-v7a/libagora-chat-sdk.so` 和 `libsqlite.so` | `~/app/src/main/jniLibs/armeabi-v7a/` |
   | `/x86/libagora-chat-sdk.so` 和 `libsqlite.so`         | `~/app/src/main/jniLibs/x86/`         |
   | `/x86_64/libagora-chat-sdk.so` 和 `libsqlite.so`      | `~/app/src/main/jniLibs/x86_64/`      |