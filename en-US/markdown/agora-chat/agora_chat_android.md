# Get Started with Agora Chat

Instant messaging connects people wherever they are and allows them to communicate with others in real time. The Agora Chat SDK enables you to embed real-time messaging in any app, on any device, anywhere.

This page shows the minimum code you need to add peer-to-peer messaging into your app by using the Agora Chat SDK for Android.

## Understand the tech

The following figure shows the workflow of how clients send and receive peer-to-peer messages.

![](https://web-cdn.agora.io/docs-files/1636443945728)

As shown in the figure, the workflow of peer-to-peer messaging is as follows:

1. The clients retrieve a token from your app server.
2. Client A and Client B sign in to Agora Chat.
3. Client A and Client B send messages to each other through the Agora Chat server.

## Prerequisites

In order to follow the procedure in this page, you must have:

- A valid [Agora account](https://docs.agora.io/cn/AgoraPlatform/sign_in_and_sign_up). 
- A valid Agora project with an AppKey.
- A token: In a test or production environment, your app client retrieves tokens from your server.
- A simulator or a physical mobile device.
- Android Studio 3.2 or higher.

## Project setup

Follow the steps to create the environment necessary to add peer-to-peer messaging into your app.

### 1. Create an Android project

Use Android Studio to create a new project.

- Select **Empty Activity** as the Project Template.
- Name the project as `AgoraChatQuickstart`.
- Set the **Package name** as `io.agora.agorachatquickstart`.
- Select **Language** as **Java**.

### 2. Integrate the SDK

Integrate the Agora Chat SDK into your project with mavenCentral. 

a. In the `build.gradle` file in the project's root directory, add the following lines to add the mavenCentral dependency:

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

b. In `/app/build.gradle` file, add the following lines to integrate the Agora Chat SDK into your Android project. For X.Y.Z, please fill in the current SDK version number; you can visit [Sonatype](https://search.maven.org) to see the latest version number.

```java
android {
    defaultConfig {
            // The Android OS version should be 19 or higher.
            minSdkVersion 19
    }
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
}
dependencies {
    ...
    implementation 'io.hyphenate:chat-sdk:X.Y.Z'
}
```

> Caution: The minSdkVersion should be 19 or higher. Otherwise, the project fails during the build process.

### 3. Prevent code obfuscation

In the `app/proguard-rules.pro` file, add the following lines to prevent code obfuscation:

```java
-keep class io.agora.** {*;}
-dontwarn  io.agora.**
```

### 4. Add permissions

In the `AndroidManifest.xml` file, add the following permissions:

```java
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.WAKE_LOCK"/>
```

> Note: These are the minimum permissions necessary for building the app. You can add other permissions according to your scenarios.

## Implement peer-to-peer messaging

This section shows how to use the Agora Chat SDK to implement peer-to-peer messaging in your app step by step.

### Create the UI

To implement te UI:

1. Open the  `app/res/layout/activity_main.xml` file and replace the content with the following codes:

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

2. Open `app/res/values/strings.xml ` file, replace the content with the following codes. You should also replace "<Your app key>" with the AppKey of your Agora project. You can use  `"41351358#427351"` as AppKey for test.

   ```xml
   <resources>
       <string name="app_name">Chat-Android</string>
   
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
   
       <string name="app_key">"Your App Key"</string>
   </resources>
   ```

### Implement the sending and receiving of messages

To enable your app to send and receive messages between individual users, do the following:

1. Open the `app/java/io.agora.agorachatquickstart/MainActivity.java` file and replace the content with the following codes:

   ```java
   package io.agora.agorachatquickstart;
   
   import static io.agora.cloud.HttpClientManager.Method_POST;
   
   import androidx.appcompat.app.AppCompatActivity;
   
   import android.os.Bundle;
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
   
   import io.agora.CallBack;
   import io.agora.ConnectionListener;
   import io.agora.Error;
   import io.agora.MessageListener;
   import io.agora.agorachatquickstart.utils.LogUtils;
   import io.agora.cloud.HttpClientManager;
   import io.agora.cloud.HttpResponse;
   import io.agora.util.EMLog;
   
   
   public class MainActivity extends AppCompatActivity {
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
   
       private void initView() {
           et_username = findViewById(R.id.et_username);
           tv_log = findViewById(R.id.tv_log);
           tv_log.setMovementMethod(new ScrollingMovementMethod());
           et_to_chat_name = findViewById(R.id.et_to_chat_name);
           et_group_id = findViewById(R.id.et_group_id);
       }
   
   //=================== init SDK start ========================
       private void initSDK() {
           ChatOptions options = new ChatOptions();
           // Set your appkey obtained from Agora Console
           String sdkAppkey = getString(R.string.app_key);
           if(TextUtils.isEmpty(sdkAppkey)) {
               Toast.makeText(MainActivity.this, "You should set your AppKey first!", Toast.LENGTH_SHORT).show();
               return;
           }
           // Set your appkey to options
           options.setAppKey(sdkAppkey);
           // Set you to use HTTPS only
           options.setUsingHttpsOnly(true);
           // To initialize Agora Chat SDK
           ChatClient.getInstance().init(this, options);
           // Make Agora Chat SDK debuggable
           ChatClient.getInstance().setDebugMode(true);
       }
   //=================== init SDK end ========================
   //================= SDK listener start ====================
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
       private void addConnectionListener() {
           ChatClient.getInstance().addConnectionListener(new ConnectionListener(){
               @Override
               public void onConnected() {
               }
   
               @Override
               public void onDisconnected(int error) {
                   //This callback occurs when there is a connection error.
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
   
               @Override
               public void onTokenExpired() {
                   //login again
                   signInWithToken(null);
                   LogUtils.showLog(tv_log,"ConnectionListener onTokenExpired");
               }
   
               @Override
               public void onTokenWillExpire() {
                   getTokenFromAppServer(RENEW_TOKEN);
                   LogUtils.showLog(tv_log, "ConnectionListener onTokenWillExpire");
               }
           });
       }
   
   //================= SDK listener end ====================
   //=================== click event start ========================
   
       /**
        * Sign up with username and password
        */
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
   
       /**
        * Login with token
        */
       public void signInWithToken(View view) {
           getTokenFromAppServer(NEW_LOGIN);
       }
   
       /**
        * Sign out
        */
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
   
       /**
        * Send your first message
        */
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
   
           // Create a text message
           ChatMessage message = ChatMessage.createTxtSendMessage(content, toSendName);
           sendMessage(message);
       }
   
   //=================== click event end ========================
   //=================== get token from server start ========================
   
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
   //=================== get token from server end ========================
   
       private void sendMessage(ChatMessage message) {
           // Check if the message is null
           if(message == null) {
               LogUtils.showErrorToast(this, tv_log, getString(R.string.message_is_null));
               return;
           }
           // Set the message callback before sending the message
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
           // Send the message
           ChatClient.getInstance().chatManager().sendMessage(message);
       }
   
       /**
        * user met some exception: conflict, removed or forbidden, go to login activity
        */
       protected void onUserException(String exception) {
           EMLog.e(TAG, "onUserException: " + exception);
           ChatClient.getInstance().logout(false, null);
       }
   
       public void execute(Runnable runnable) {
           new Thread(runnable).start();
       }
   }
   ```
   
2. Navigate to `app/java/io.agora.agorachatquickstart/`, create a folder named `utils`. In this new folder, create a `.java` file, name it `LogUtils`, and copy the following codes into the file.

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

## Test your app

To test your app, take the following steps:

1. Build the project in Android Studio, and run it on a simulator or a physical mobile device.

You should be able to see the following interface on your simulator or mobile device.

<img src="https://web-cdn.agora.io/docs-files/1636535753562" style="zoom:50%;" />

2. To start a chat, do the following:

   a. Create a user and click **SIGN UP**.

   b. Sign in with the user account you just created.

   c. Run the app on another Android device and create another user. Ensure that the usernames you created are unique.

   d. Send messages between the users.

   <img src="https://web-cdn.agora.io/docs-files/1636536858960" style="zoom:50%;" />
   
   <img src="https://web-cdn.agora.io/docs-files/1636536917482" style="zoom:50%;" />

## Next Step

In a production context, your app server generates tokens requested by your app clients to enable secure access to Agora Platform. For how to implement generating tokens on your app server, see [Token]().

## See also

In addition to integrating the Agora Chat SDK into your project with mavenCentral, you can also manually download the [Agora Chat SDK for Android](). 

1. Download the latest version of the Agora Chat SDK for Android, and extract the files from the downloaded SDK package.

2. Copy the following files or subfolders from the **libs** folder of the downloaded SDK to the corresponding directory of your project.

   | File or subfolder                                      | Path of your project                  |
   | ------------------------------------------------------ | ------------------------------------- |
   | `agorachat_X.Y.Z.jar`                                  | `~/app/libs/`                         |
   | `/arm64-v8a/libagora-chat-sdk.so` and `libsqlite.so`   | `~/app/src/main/jniLibs/arm64-v8a/`   |
   | `/armeabi-v7a/libagora-chat-sdk.so` and `libsqlite.so` | `~/app/src/main/jniLibs/armeabi-v7a/` |
   | `/x86/libagora-chat-sdk.so` and `libsqlite.so`         | `~/app/src/main/jniLibs/x86/`         |
   | `/x86_64/libagora-chat-sdk.so` and `libsqlite.so`      | `~/app/src/main/jniLibs/x86_64/`      |

> Note: X.Y.Z refers to the version number of the Agora Chat SDK you downloaded.