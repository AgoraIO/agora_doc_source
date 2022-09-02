Instant messaging connects people wherever they are and allows them to communicate with others in real time. The Agora Chat SDK enables you to embed real-time messaging in any app, on any device, anywhere.

This page shows a sample code to add peer-to-peer messaging into your app by using the Agora Chat SDK for Android.

## Understand the tech

~338e0e30-e568-11ec-8e95-1b7dfd4b7cb0~

## Prerequisites

In order to follow the procedure in this page, you must have:

- An Android simulator or a physical Android device.
- Android Studio 3.6 or higher.
- Java Development Kit (JDK). You can refer to the [User Guide of Android](https://developer.android.com/studio/write/java8-support) for applicable versions.

## Project setup

Follow the steps to create the environment necessary to integrate Agora Chat into your app.

1. For new projects, in **Android Studio**, create a **Phone and Tablet** [Android project](https://developer.android.com/studio/projects/create-project) with an **Empty Activity**.
   <div class="alert note">After creating the project, <b>Android Studio</b> automatically starts gradle sync. Ensure that the sync succeeds before you continue.</div>

2. Integrate the Agora Chat SDK into your project with Maven Central. 

    a. In `/Gradle Scripts/build.gradle(Project: <projectname>)`, add the following lines to add the Maven Central dependency:

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
	 
	 <div class="alert note">The way to add the Maven Central dependency can be different if you set  <a href="https://docs.gradle.org/current/userguide/declaring_repositories.html#sub:centralized-repository-declaration">dependencyResolutionManagement</a> in your Android project.</div>
		
	b. In `/Gradle Scripts/build.gradle(Module: <projectname>.app)`, add the following lines to integrate the Agora Chat SDK into your Android project:

   ```java
   android {
       defaultConfig {
               // The Android OS version should be 21 or higher.
               minSdkVersion 21
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

   <div class="alert note"><ul><li><code>minSdkVersion</code> must be 21 or higher for the build process to succeed.</li><li>For the latest SDK version, go to <a href="https://search.maven.org/search?q=a:chat-sdk">Sonatype</a>.</li></ul></div>

3. Add permissions for network and device access.

   In `/app/Manifests/AndroidManifest.xml`, add the following permissions after `</application>`:
	 
   ```xml
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
   <uses-permission android:name="android.permission.WAKE_LOCK"/>
   <!—- Need to add after Android 12, apply for alarm clock timing permission -—> 
   <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
   ```
	
	These are the minimum permissions you need to add to start Agora Chat. You can also add other permissions according to your use case.

4. Prevent code obfuscation.

   In `/Gradle Scripts/proguard-rules.pro`, add the following line:

   ```java
   -keep class io.agora.** {*;}
   -dontwarn  io.agora.**
   ```


## Implement peer-to-peer messaging

This section shows how to use the Agora Chat SDK to implement peer-to-peer messaging in your app step by step.

### Create the UI

1. To add the text strings used by the UI, open `app/res/values/strings.xml ` and  replace the content with the following codes:

   ```xml
   <resources>
       <string name="app_name">AgoraChatQuickstart</string>

       <string name="app_key">41117440#383391</string>
       <string name="login_url">https://a41.chat.agora.io/app/chat/user/login</string>
       <string name="register_url">https://a41.chat.agora.io/app/chat/user/register</string>
   </resources>
   ``` 

2. To add the UI framework, open  `app/res/layout/activity_main.xml` and replace the content with the following codes:

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
       xmlns:app="http://schemas.android.com/apk/res-auto"
       xmlns:tools="http://schemas.android.com/tools"
       android:layout_width="match_parent"
       android:layout_height="match_parent"
       android:orientation="vertical"
       tools:context="io.agora.agorachatquickstart.MainActivity">

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
                   android:hint="Enter username"
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
                   android:hint="Enter password"
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
                   android:text="Sign in"
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
                   android:text="Sign out"
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
                   android:text="Sign up"
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
                   android:hint="Enter another username"
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
                   android:hint="Enter content"
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
                   android:text="Send message"
                   android:onClick="sendFirstMessage"
                   app:layout_constraintLeft_toLeftOf="parent"
                   app:layout_constraintRight_toRightOf="parent"
                   app:layout_constraintTop_toBottomOf="@id/et_msg_content"
                   android:layout_marginStart="10dp"
                   android:layout_marginEnd="20dp"
                   android:layout_marginTop="20dp"/>

           </androidx.constraintlayout.widget.ConstraintLayout>

       </ScrollView>

       <TextView
           android:id="@+id/tv_log"
           android:layout_width="match_parent"
           android:layout_height="200dp"
           android:hint="Show log area..."
           android:scrollbars="vertical"
           android:padding="10dp"/>

   </LinearLayout>
   ```

### Implement the sending and receiving of messages

To enable your app to send and receive messages between individual users, do the following:

1. Import classes. In  `app/java/io.agora.agorachatquickstart/MainActivity`, add the following lines after `import android.os.Bundle;` :

   ```java
   import static io.agora.cloud.HttpClientManager.Method_POST;
   import android.text.TextUtils;
   import android.text.method.ScrollingMovementMethod;
   import android.view.View;
   import android.widget.EditText;
   import android.widget.TextView;
   import android.widget.Toast;
   import androidx.annotation.NonNull;
   import androidx.appcompat.app.AppCompatActivity;
   import org.json.JSONException;
   import org.json.JSONObject;
   import java.text.SimpleDateFormat;
   import java.util.Date;
   import java.util.HashMap;
   import java.util.Locale;
   import java.util.Map;
   import io.agora.CallBack;
   import io.agora.ConnectionListener;
   import io.agora.Error;
   import io.agora.ValueCallBack;
   import io.agora.chat.ChatClient;
   import io.agora.chat.ChatMessage;
   import io.agora.chat.ChatOptions;
   import io.agora.chat.TextMessageBody;
   import io.agora.cloud.HttpClientManager;
   import io.agora.cloud.HttpResponse;
   ```
   
2. Define global variables. In `app/java/io.agora.agorachatquickstart/MainActivity`,  before adding the following lines after `AppCompatActivity {`, ensure you delete the `onCreate` funtion created by default.

   ```java
   private EditText et_username;
   
   @Override
   protected void onCreate(Bundle savedInstanceState) {
       super.onCreate(savedInstanceState);
       setContentView(R.layout.activity_main);
       initView();
       initSDK();
       initListener();
   }
   ```
   
3. Initialize the view and the app. In `app/java/io.agora.agorachatquickstart/MainActivity`, add the following lines after the `onCreate` function: 

   ```java
   // Initialize the view.
   private void initView() {
       et_username = findViewById(R.id.et_username);
       ((TextView)findViewById(R.id.tv_log)).setMovementMethod(new ScrollingMovementMethod());
   }
   // Initialize the SDK.
   private void initSDK() {
       ChatOptions options = new ChatOptions();
       // Set your appkey applied from Agora Console
       String sdkAppkey = getString(R.string.app_key);
       if(TextUtils.isEmpty(sdkAppkey)) {
           Toast.makeText(MainActivity.this, "You should set your AppKey first!", Toast.LENGTH_SHORT).show();
           return;
       }
       // Set your appkey to options
       options.setAppKey(sdkAppkey);
       // To initialize Agora Chat SDK
       ChatClient.getInstance().init(this, options);
       // Make Agora Chat SDK debuggable
       ChatClient.getInstance().setDebugMode(true);
   }
   ```

4. Retrieve a token. To get a token from the app server, add the following lines after the `initSDK` function:

   ```java
   
   private void getTokenFromAppServer(boolean isRenewToken) {
       if(ChatClient.getInstance().isLoggedInBefore()) {
           showLog("An account has been signed in, please sign out first and then sign in", false);
           return;
       }
       String username = et_username.getText().toString().trim();
       String pwd = ((EditText) findViewById(R.id.et_pwd)).getText().toString().trim();
       getAgoraTokenFromAppServer(username, pwd, new ValueCallBack<String>() {
           @Override
           public void onSuccess(String token) {
               if(isRenewToken) {
                   ChatClient.getInstance().renewToken(token);
               }else {
                   login(username,token);
               }
           }

           @Override
           public void onError(int error, String errorMsg) {
               showLog(errorMsg, true);
           }
       });
   }
   // Retrieve a token from the app server.
   private void getAgoraTokenFromAppServer(String username, String pwd, @NonNull ValueCallBack<String> callBack) {
       showLog("begin to getTokenFromAppServer ...", false);
       executeRequest(getString(R.string.login_url), username, pwd, new ValueCallBack<String>() {
           @Override
           public void onSuccess(String response) {
               try {
                   JSONObject object = new JSONObject(response);
                   String token = object.getString("accessToken");
                   callBack.onSuccess(token);
               } catch (JSONException e) {
                   callBack.onError(Error.GENERAL_ERROR, e.getMessage());
               }
           }

           @Override
           public void onError(int error, String errorMsg) {
               callBack.onError(error, errorMsg);
           }
       });
   }

   private void executeRequest(String url, String username, String password, @NonNull ValueCallBack<String> callBack) {
       if(TextUtils.isEmpty(url)) {
           callBack.onError(Error.INVALID_PARAM, "Request url should not be null");
           return;
       }
       if(TextUtils.isEmpty(username) || TextUtils.isEmpty(password)) {
           callBack.onError(Error.INVALID_PARAM, "Username or password is empty");
           return;
       }
       Map<String, String> headers = new HashMap<>();
       headers.put("Content-Type", "application/json");

       JSONObject request = new JSONObject();
       try {
           request.putOpt("userAccount", username);
           request.putOpt("userPassword", password);
       } catch (JSONException e) {
           callBack.onError(Error.GENERAL_ERROR, e.getMessage());
           return;
       }
       execute(()-> {
           try {
               HttpResponse response = HttpClientManager.httpExecute(url, headers, request.toString(), Method_POST);
               int code = response.code;
               String responseInfo = response.content;
               if (code == 200) {
                   if (responseInfo != null && responseInfo.length() > 0) {
                       callBack.onSuccess(responseInfo);
                   } else {
                       callBack.onError(Error.SERVER_UNKNOWN_ERROR, responseInfo);
                   }
               } else {
                   callBack.onError(code, responseInfo);
               }
           } catch (Exception e) {
               callBack.onError(Error.GENERAL_ERROR, e.getMessage());
           }
       });
   }

   private void execute(Runnable runnable) {
       new Thread(runnable).start();
   }
   ```

5. Add event callbacks. In `app/java/io.agora.agorachatquickstart/MainActivity`, add the following lines after the `execute` function:

   ```java
   private void initListener() {
       // Add message events callbacks.
       ChatClient.getInstance().chatManager().addMessageListener(messages -> {
           for(ChatMessage message : messages) {
               StringBuilder builder = new StringBuilder();
               builder.append("Receive a ").append(message.getType().name())
                       .append(" message from: ").append(message.getFrom());
               if(message.getType() == ChatMessage.Type.TXT) {
                   builder.append(" content:")
                           .append(((TextMessageBody)message.getBody()).getMessage());
               }
               showLog(builder.toString(), false);
           }
       });
       // Add connection events callbacks.
       ChatClient.getInstance().addConnectionListener(new ConnectionListener() {
           @Override
           public void onConnected() {
               showLog("onConnected",false);
           }

          @Override
          public void onDisconnected(int error) {
              showLog("onDisconnected: "+error,false);
          }

          @Override
          public void onLogout(int errorCode) {
              showLog("User needs to log out: "+errorCode, false);
              ChatClient.getInstance().logout(false, null);
          }
          // This callback occurs when the token expires. When the callback is triggered, the app client must get a new token from the app server and logs in to the app again.
          @Override
          public void onTokenExpired() {
              showLog("ConnectionListener onTokenExpired", true);
              signInWithToken(null);
          }
          // This callback occurs when the token is to expire. 
          @Override
          public void onTokenWillExpire() {
              showLog("ConnectionListener onTokenWillExpire", true);
              getTokenFromAppServer(true);
          }
      });
   }
   
   ```

6. Create a user account, log in to the app. To implement this logic, in `app/java/io.agora.agorachatquickstart/MainActivity`, add the following lines after the `initListener` function:

   ```java
   // Sign up with a username and password.
   public void signUp(View view) {
       String username = et_username.getText().toString().trim();
       String pwd = ((EditText) findViewById(R.id.et_pwd)).getText().toString().trim();
       register(username, pwd, new CallBack() {
           @Override
           public void onSuccess() {
               showLog("Sign up success!", true);
           }

           @Override
           public void onError(int code, String error) {
               showLog(error, true);
           }
       });
   }
   
   // Log in with Token.
   public void signInWithToken(View view) {
       getTokenFromAppServer(false);
   }
   
   // Sign out.
   public void signOut(View view) {
       if(ChatClient.getInstance().isLoggedInBefore()) {
           ChatClient.getInstance().logout(true, new CallBack() {
               @Override
               public void onSuccess() {
                   showLog("Sign out success!", true);
               }

               @Override
               public void onError(int code, String error) {
                   showLog(error, true);
               }
           });
       }
   }
   private void register(String username, String pwd, @NonNull CallBack callBack) {
       showLog("begin to sign up...",false);
       executeRequest(getString(R.string.register_url), username, pwd, new ValueCallBack<String>() {
           @Override
           public void onSuccess(String response) {
               String resultCode = null;
               try {
                   JSONObject object = new JSONObject(response);
                   resultCode = object.getString("code");
                   if(resultCode.equals("RES_OK")) {
                       callBack.onSuccess();
                   }else{
                       callBack.onError(Error.GENERAL_ERROR, "Sign up failed!");
                   }
               } catch (JSONException e) {
                   callBack.onError(Error.GENERAL_ERROR, e.getMessage());
               }
           }

           @Override
           public void onError(int error, String errorMsg) {
               callBack.onError(error, errorMsg);
           }
       });
   }
   ```

7. Start a chat. To enable the function of sending messages, add the following lines after the `register` function:

   ```java
   // Send your first message.
   public void sendFirstMessage(View view) {
       String toSendName = ((TextView)findViewById(R.id.et_to_chat_name)).getText().toString().trim();
       String content = ((TextView)findViewById(R.id.et_msg_content)).getText().toString().trim();
       // Create a text message
       ChatMessage message = ChatMessage.createTextSendMessage(content, toSendName);
       // Set the message callback before sending the message
       message.setMessageStatusCallback(new CallBack() {
           @Override
           public void onSuccess() {
               showLog("Send message success!", true);
           }

           @Override
           public void onError(int code, String error) {
               showLog(error, true);
           }
       });
       // Send the message
       ChatClient.getInstance().chatManager().sendMessage(message);
   }
   ```

8. Click `Sync Project with Gradle Files` to sync your project. Now you are ready to test your app.

## Test your app

To validate the peer-to-peer messaging you have just integrated into your app using Agora Chat:

1. In Android Studio, click `Run 'app'`.

   You see the following interface on your simulator or physical device: 
   <img src="https://web-cdn.agora.io/docs-files/1637661621212" style="zoom:50%;" />

2. Create a user account and click **SIGN UP**. 

3. Sign in with the user account you just created and send a message.
   <img src="https://web-cdn.agora.io/docs-files/1637562675862" style="zoom:50%;" />

4. Run the app on another Android device or simulator and create another user account. Ensure that the usernames you created are unique.

5. Send messages between the users.
   <img src="https://web-cdn.agora.io/docs-files/1637562770527" style="zoom:50%;" />

## Next Steps

For demonstration purposes, Agora Chat provides an app server that enables you to quickly retrieve a token using the App Key given in this guide. In a production context, the best practice is for you to deploy your own token server, use your own [App Key](./enable_agora_chat?platform=Android#get-the-information-of-the-agora-chat-project) to generate a token, and retrieve the token on the client side to log in to Agora. To see how to implement a server that generates and serves tokens on request, see [Generate a User Token](./generate_user_tokens?platform=All%20Platforms).

## See also

In addition to integrating the Agora Chat SDK into your project with mavenCentral, you can also manually download the [Agora Chat SDK for Android](https://download.agora.io/sdk/release/Agora_Chat_SDK_for_Android_v1.0.0.zip). 

1. Download the latest version of the Agora Chat SDK for Android, and extract the files from the downloaded SDK package.

2. Copy the following files or subfolders from the **libs** folder of the downloaded SDK to the corresponding directory of your project.

   | File or subfolder                                      | Path of your project                  |
   | ------------------------------------------------------ | ------------------------------------- |
   | `agorachat_X.Y.Z.jar`                                  | `~/app/libs/`                         |
   | `/arm64-v8a/libagora-chat-sdk.so` and `libsqlite.so`   | `~/app/src/main/jniLibs/arm64-v8a/`   |
   | `/armeabi-v7a/libagora-chat-sdk.so` and `libsqlite.so` | `~/app/src/main/jniLibs/armeabi-v7a/` |
   | `/x86/libagora-chat-sdk.so` and `libsqlite.so`         | `~/app/src/main/jniLibs/x86/`         |
   | `/x86_64/libagora-chat-sdk.so` and `libsqlite.so`      | `~/app/src/main/jniLibs/x86_64/`      |

   <div class="alert info"> X.Y.Z refers to the version number of the Agora Chat SDK you downloaded.<div>