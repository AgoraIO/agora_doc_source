# Agora Chat 快速入门

即时通讯将各地人们连接在一起，实现实时通信。利用 Agora Chat SDK，你可以在任何地方的任何设备上的任何应用中嵌入实时通讯。

本文介绍如何通过少量代码集成 Agora 即时通讯 SDK，在你的 Android app 中实现发送和接收单聊文本消息。

## 技术原理

~7aac3300-785d-11ec-bcb4-b56a01c83d2e~

## 前提条件

开始前，请确保你的开发环境满足以下条件：

- Android 模拟器或 Android 设备。
- Android Studio 3.2 或以上版本。
- Java 开发工具包（JDK）。适用版本请参考 [Android 用户指南](https://developer.android.com/studio/write/java8-support)。

## 项目设置

参考以下步骤创建环境，将视频通话添加到你的应用程序中。

1. 若为新项目，在 **Android Studio** 中，创建一个带有 **Empty Activity** 的 **Phone and Tablet** [Android 项目](https://developer.android.com/studio/projects/create-project)。

<div class="alert note">创建项目后，Android Studio 会自动启动 gradle 同步。确保同步成功后再进行后续操作。</div>

2. 使用 Maven Central 将 Agora Chat SDK 集成到你的项目中。

   a.在`/Gradle Scripts/build.gradle(Project: <projectname>)`中，添加以下代码实现 Maven Central 依赖项：

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

   <div class="alert note">如果你在 Android 项目中设置 [dependencyResolutionManagement](https://docs.gradle.org/current/userguide/declaring_repositories.html#sub:centralized-repository-declaration)，添加 Maven Central 依赖项的方式可能会有所不同。</div>

   b.在 `/Gradle Scripts/build.gradle(Module: <projectname>.app)` 中，添加以下代码将 Agora Chat UIKit 集成到你的 Android 项目中：

   ```java
   android {
       defaultConfig {
               // Android 21 或以上系统版本。
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
    <div class="alert note">- `minSdkVersion` 必须为 21 或以上版本才能成功构建。<br/>- 如需最新 SDK 版本，请前往 [Sonatype](https://search.maven.org/search?q=a:chat-sdk)。</div>
   
3. 添加网络和设备访问权限。

   在 `/app/Manifests/AndroidManifest.xml` 中，在 `</application>` 后面添加以下权限：

   ```xml
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
   <uses-permission android:name="android.permission.WAKE_LOCK"/>
   ```

   以上为启动 Agora Chat 所需的最低权限。你还可以根据使用情况添加其他权限。

4. 防止代码混淆。

   在 `/Gradle Scripts/proguard-rules.pro` 中，添加以下代码：

   ```java
   -keep class io.agora.** {*;}
   -dontwarn  io.agora.**
   ```

## 实现单聊消息发送和接收

本节介绍如何使用 Agora 即时通讯 SDK 在你的应用中实现单聊消息的发送与接收。

### 创建用户界面

1. 要添加 UI 使用的文本字符串，需打开 `app/res/values/strings.xml`，将内容并替换为以下代码：

   ```xml
   <resources>
       <string name="app_name">AgoraChatQuickstart</string>
   
       <string name="username_or_pwd_miss">用户名或密码为空</string>
       <string name="sign_up_success">注册成功</string>
       <string name="sign_in_success">登录成功</string>
       <string name="sign_out_success">登出成功</string>
       <string name="send_message_success">消息成功发出</string>
       <string name="enter_username">输入用户 ID</string>
       <string name="enter_password">输入密码</string>
       <string name="sign_in">登录</string>
       <string name="sign_out">登出</string>
       <string name="sign_up">登出</string>
       <string name="enter_content">输入内容</string>
       <string name="enter_to_send_name">输入接收人的用户 ID</string>
       <string name="send_message">发送文本</string>
       <string name="send_image_message">发送图片</string>
       <string name="log_hint">显示日志区域...</string>
       <string name="has_login_before">该账户已登录，请先登出再重新登录</string>
       <string name="sign_in_first">请先登录</string>
       <string name="not_find_send_name">请输入接收人的用户 ID</string>
       <string name="message_is_null">消息为空</string>
   
       <string name="app_key">41117440#383391</string>
   </resources>
   ```

2. 要添加 UI 框架，需打开 `app/res/layout/activity_main.xml`，将内容并替换为以下代码：

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

### 实现消息的发送和接收

要使你的应用实现在用户之间发送和接收消息，需执行以下操作：

1. 导入类。在 `app/java/io.agora.agorachatquickstart/MainActivity` 中，在 `import android.os.Bundle;` 之后添加以下代码：

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

2. 定义全局变量。在 `app/java/io.agora.agorachatquickstart/MainActivity` 中，请确保删除默认创建的 `onCreate` 函数再在 `AppCompatActivity {` 后面添加以下代码。

   ```java
   private final String TAG = getClass().getSimpleName();
   private static final String NEW_LOGIN = "NEW_LOGIN";
   private static final String RENEW_TOKEN = "RENEW_TOKEN";
   private static final String ACCOUNT_REMOVED = "account_removed";
   private static final String ACCOUNT_CONFLICT = "conflict";
   private static final String ACCOUNT_FORBIDDEN = "user_forbidden";
   private static final String ACCOUNT_KICKED_BY_CHANGE_PASSWORD = "kicked_by_change_password";
   private static final String ACCOUNT_KICKED_BY_OTHER_DEVICE = "kicked_by_another_device";
   private static final String LOGIN_URL = "https://a41.chat.agora.io/app/chat/user/login";
   private static final String REGISTER_URL = "https://a41.chat.agora.io/app/chat/user/register";
   private EditText et_username;
   private TextView tv_log;
   private EditText et_to_chat_name;
   
   @Override
   protected void onCreate(Bundle savedInstanceState) {
       super.onCreate(savedInstanceState);
       setContentView(R.layout.activity_main);
       // Add methods for initialization and listen for message and connection events.
       initView();
       initSDK();
       addMessageListener();
       addConnectionListener();
   }
   ```

3. 初始化视图和应用程序。在 `app/java/io.agora.agorachatquickstart/MainActivity` 中，在 `onCreate` 方法后添加如下代码：

   ```java
   // 初始化视图。
   private void initView() {
           et_username = findViewById(R.id.et_username);
           tv_log = findViewById(R.id.tv_log);
           tv_log.setMovementMethod(new ScrollingMovementMethod());
           et_to_chat_name = findViewById(R.id.et_to_chat_name);
       }
       // 初始化 SDK。
       private void initSDK() {
           ChatOptions options = new ChatOptions();
           // 设置你从声网的控制台获取的 App Key。
           String sdkAppkey = getString(R.string.app_key);
           if(TextUtils.isEmpty(sdkAppkey)) {
               Toast.makeText(MainActivity.this, "You should set your AppKey first!", Toast.LENGTH_SHORT).show();
               return;
           }
           // 将 App Key 设置到选项中。
           options.setAppKey(sdkAppkey);
           // 设置仅使用 HTTPS。
           options.setUsingHttpsOnly(true);
           // 初始化 Agora Chat SDK。
           ChatClient.getInstance().init(this, options);
           // 设置 Agora Chat SDK 为可调试。
           ChatClient.getInstance().setDebugMode(true);
       }
   ```

4. 获得 token。要从 App Server 获取 token，需在 `initSDK` 方法后添加以下代码：

   ```java
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
        getAgoraTokenFromAppServer(username, pwd, new ValueCallBack<String>() {
            @Override
            public void onSuccess(String token) {
                if(TextUtils.equals(requestType, NEW_LOGIN)) {
                    login(username,token);
                }else if(TextUtils.equals(requestType, RENEW_TOKEN)) {
                    ChatClient.getInstance().renewToken(token);
                }
            }
            @Override
            public void onError(int error, String errorMsg) {
                LogUtils.showErrorToast(MainActivity.this, tv_log, "getTokenFromAppServer failed! code: " + error + " error: " + errorMsg);
            }
        });
    }
    // 从 App Server 中获取 token。
    private void getAgoraTokenFromAppServer(String username, String pwd, ValueCallBack<String> callBack) {
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
                        if(callBack != null) {
                            callBack.onSuccess(token);
                        }
                    } else {
                        if(callBack != null) {
                            callBack.onError(Error.SERVER_UNKNOWN_ERROR, responseInfo);
                        }
                    }
                } else {
                    if(callBack != null) {
                        callBack.onError(code, responseInfo);
                    }
                }
            } catch (Exception e) {
                if(callBack != null) {
                    callBack.onError(Error.GENERAL_ERROR, e.getMessage());
                }
            }
        });
    }
   ```

5. 添加事件回调。在 `app/java/io.agora.agorachatquickstart/MainActivity` 中，在 `getTokenFromAppServer` 方法后添加以下代码：

   ```java
   // 添加消息事件回调。
   private void addMessageListener() {
        ChatClient.getInstance().chatManager().addMessageListener(new MessageListener() {
            @Override
            public void onMessageReceived(List<ChatMessage> messages) {
                parseMessage(messages);
            }
        });
    }
   // 显示消息日志。
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
   // 添加连接事件回调。
   private void addConnectionListener() {
        ChatClient.getInstance().addConnectionListener(new ConnectionListener(){
            @Override
            public void onConnected() {
            }
            @Override
            public void onDisconnected(int error) {
                switch (error) {
                    case Error.USER_REMOVED:
                        onUserException("account_removed");
                        break;
                    case Error.USER_LOGIN_ANOTHER_DEVICE:
                        onUserException("account_conflict");
                        break;
                    case Error.SERVER_SERVICE_RESTRICTED:
                        onUserException("account_forbidden");
                        break;
                    case Error.USER_KICKED_BY_CHANGE_PASSWORD:
                        onUserException("account_kicked_by_change_password");
                        break;
                    case Error.USER_KICKED_BY_OTHER_DEVICE:
                        onUserException("account_kicked_by_other_device");
                        break;
                    case Error.USER_BIND_ANOTHER_DEVICE:
                        onUserException("user_bind_another_device");
                        break;
                    case Error.USER_DEVICE_CHANGED:
                        onUserException("user_device_changed");
                        break;
                    case Error.USER_LOGIN_TOO_MANY_DEVICES:
                        onUserException("user_login_too_many_devices");
                        break;
                }
            }
            protected void onUserException(String exception) {
                EMLog.e(TAG, "onUserException: " + exception);
                ChatClient.getInstance().logout(false, null);
            }
            // Token 过期时会触发该回调。该回调触发时，你需要从你的 App Server 中获取新的 token，然后重新登录 Agora 即时通讯系统。
            @Override
            public void onTokenExpired() {
                // 重新登录。
                signInWithToken(null);
                LogUtils.showLog(tv_log,"ConnectionListener onTokenExpired");
            }
            // Token 即将过期时会触发该回调。
            @Override
            public void onTokenWillExpire() {
                getTokenFromAppServer(RENEW_TOKEN);
                LogUtils.showLog(tv_log, "ConnectionListener onTokenWillExpire");
            }
        });
    }
   ```

6. 创建用户帐户，登录 app。要实现该逻辑，需在 `app/java/io.agora.agorachatquickstart/MainActivity` 中的 `addConnectionListener` 方法后面添加以下代码：

   ```java
   // 注册一个新用户。
   public void signUp(View view) {
        String username = et_username.getText().toString().trim();
        String pwd = ((EditText) findViewById(R.id.et_pwd)).getText().toString().trim();
        if(TextUtils.isEmpty(username) || TextUtils.isEmpty(pwd)) {
            LogUtils.showErrorToast(this, tv_log, getString(R.string.username_or_pwd_miss));
            return;
        }
        register(REGISTER_URL, username, pwd, new CallBack() {
            @Override
            public void onSuccess() {
                LogUtils.showToast(MainActivity.this, tv_log, getString(R.string.sign_up_success));
            }
            @Override
            public void onError(int code, String error) {
                LogUtils.showErrorLog(tv_log, error);
            }
        });
    }
   
   //使用 token 登录。
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
   private void register(String url, String username, String pwd, CallBack callBack) {
        execute(()-> {
            try {
                Map<String, String> headers = new HashMap<>();
                headers.put("Content-Type", "application/json");
                JSONObject request = new JSONObject();
                request.putOpt("userAccount", username);
                request.putOpt("userPassword", pwd);
                LogUtils.showErrorLog(tv_log,"begin to signUp...");
                HttpResponse response = HttpClientManager.httpExecute(url, headers, request.toString(), Method_POST);
                int code=  response.code;
                String responseInfo = response.content;
                if (code == 200) {
                    if (responseInfo != null && responseInfo.length() > 0) {
                        JSONObject object = new JSONObject(responseInfo);
                        String resultCode = object.getString("code");
                        if(resultCode.equals("RES_OK")) {
                            if(callBack != null) {
                                callBack.onSuccess();
                            }
                        }else{
                            if(callBack != null) {
                                callBack.onError(Error.GENERAL_ERROR, object.getString("errorInfo"));
                            }
                        }
                    } else {
                        if(callBack != null) {
                            callBack.onError(code, responseInfo);
                        }
                    }
                } else {
                    if(callBack != null) {
                        callBack.onError(code, responseInfo);
                    }
                }
            } catch (Exception e) {
                if(callBack != null) {
                    callBack.onError(Error.GENERAL_ERROR, e.getMessage());
                }
            }
        });
    }
   ```

7. 开始聊天。要实现发送消息的功能，请在 `signOut` 方法后面添加以下代码：

   ```java
   // 发送首条消息。
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
   
       // 创建文本消息。
       ChatMessage message = ChatMessage.createTxtSendMessage(content, toSendName);
       sendMessage(message);
   
   }
   private void sendMessage(ChatMessage message) {
       // 查看消息是否为空。
       if(message == null) {
           LogUtils.showErrorToast(this, tv_log, getString(R.string.message_is_null));
           return;
       }
       // 发送消息前，设置消息回调。
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
       // 发送消息。
       ChatClient.getInstance().chatManager().sendMessage(message);
   }
   
       public void execute(Runnable runnable) {
           new Thread(runnable).start();
       }
   ```

8. 为了快速排查问题，你还可以添加 `LgoUtils` 工具类：在 `app/java/io.agora.agorachatquickstart/` 路径下创建名为 `utils` 的文件夹；在该文件夹中创建 `LogUtils.java` 文件并将以下代码复制到该文件中：

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

9. 单击 `Sync Project with Gradle Files` 同步你的项目。现在可测试你的应用。

## 测试你的应用

参考以下步骤验证你刚刚使用 Agora Chat 集成到 app 中的单聊功能：

1. 在 Android Studio 中，单击 `Run 'app'`。

   你会在模拟器或物理设备上看到以下界面：

   <img src="https://web-cdn.agora.io/docs-files/1652232540196" style="zoom:50%;" />

2. 创建一个用户帐户并单击 **SIGN UP**。

3. 使用你刚刚创建的用户帐户登录并发送消息。

   <img src="https://web-cdn.agora.io/docs-files/1637562675862" style="zoom:50%;" />

4. 在其他 Android 设备或模拟器上运行应用程序并创建另一个用户帐户。确保你创建的用户 ID 唯一。

5. 在用户之间发送消息。 

## 后续操作

出于演示目的，Agora Chat 提供一个 App Server，可使你利用本文中提供的 App Key 快速获得 token。在生产环境中，最好自行部署 token 服务器，使用自己的 [App Key](./enable_agora_chat) 生成 token，并在客户端获取 token 登录 Agora 即时通讯服务。要了解如何实现服务器按需生成和提供 token，请参阅[生成用户 Token](./generate_user_tokens)。

## 参考

除了使用 Maven Central 将 Agora Chat SDK 集成到你项目中外，你还可以手动下载 [Agora Chat Android SDK](https://download.agora.io/sdk/release/Agora_Chat_SDK_for_Android_v1.0.0.zip)。

1. 下载最新版本的 Agora 即时通讯 Android SDK，并从下载的 SDK 包中解压文件。

2. 将下载的 SDK 的 **libs** 文件夹中的以下文件或子文件夹复制到你的项目的对应目录中。

   | 文件或子文件夹                                      | 你的项目路径                          |
   | :-------------------------------------------------- | :------------------------------------ |
   | `agorachat_X.Y.Z.jar`                                 | `~/app/libs/`                         |
   | `/arm64-v8a/libagora-chat-sdk.so` 和 `libsqlite.so`   | `~/app/src/main/jniLibs/arm64-v8a/`   |
   | `/armeabi-v7a/libagora-chat-sdk.so` 和 `libsqlite.so` | `~/app/src/main/jniLibs/armeabi-v7a/` |
   | `/x86/libagora-chat-sdk.so` 和 `libsqlite.so`         | `~/app/src/main/jniLibs/x86/`         |
   | `/x86_64/libagora-chat-sdk.so` 和 `libsqlite.so`      | `~/app/src/main/jniLibs/x86_64/`      |

   XYZ 指是你下载的 Agora Chat SDK 的版本号。