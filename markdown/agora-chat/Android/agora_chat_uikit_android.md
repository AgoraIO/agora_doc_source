# 即时通讯 IM UIKit 快速开始

即时通讯将各地人们连接在一起，实现实时通信。[即时通讯 IM UIKit]() 内置了用户界面（UI）提供会话列表和联系人列表，使你可将实时通讯嵌入到你的应用程序，而无需在 UI 上进行额外操作。

本页通过示例代码介绍如何利用 Android 版本的即时通讯 IM UIKit 将单聊消息发送和接收的逻辑添加到你的应用程序中。

## 技术原理

下图显示了客户如何发送和接收单聊消息的工作流程：

![img](https://web-cdn.agora.io/docs-files/1643335864426)

1. 客户端从你的应用服务器获取 token。
2. 客户 A 和客户 B 登录即时通讯 IM。
3. 客户端 A 向客户端 B 发送消息，消息被发送到即时通讯 IM 服务器，服务器将消息传递给客户端 B。客户端 B 收到消息后，SDK 触发事件。客户端 B 监听事件并获取消息。

## 前提条件

开始前，请确保已经具备以下要素：

- Android 模拟器或 Android 设备。
- Android Studio 3.2 或以上版本。
- Java 开发工具包 (JDK)。适用版本请参考[Android 用户指南](https://developer.android.com/studio/write/java8-support)。
- 有效的 [Agora 账号](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#%E5%88%9B%E5%BB%BA-agora-%E8%B4%A6%E5%8F%B7)。

## 项目设置

参考以下步骤创建环境，将视频通话添加到你的应用程序中。

1. 若为新项目，在 **Android Studio** 中，创建一个带有 **Empty Activity** 的 [Android 项目](https://developer.android.com/studio/projects/create-project) **Phone and Tablet** 。

<div class="alert note">创建项目后，Android Studio 会自动启动 gradle 同步。确保同步成功后再进行后续操作。</div>

2. 使用 Maven Central 将即时通讯 IM SDK 集成到你的项目中。

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

   <div class="alert note">如果你在 Android 项目中设置 <a href="https://docs.gradle.org/current/userguide/declaring_repositories.html#sub:centralized-repository-declaration">dependencyResolutionManagement</a>，添加 Maven Central 依赖项的方式可能会有所不同。</div>

   b.在 `/Gradle Scripts/build.gradle(Module: <projectname>.app)` 中，添加以下代码将即时通讯 IM UIKit 集成到你的 Android 项目中：

   ```java
   android {
       defaultConfig {
               // Android 19 或以上系统版本。
               minSdkVersion 19
       }
       compileOptions {
           sourceCompatibility JavaVersion.VERSION_1_8
           targetCompatibility JavaVersion.VERSION_1_8
       }
   }
   dependencies {
       ...
       // 将 X.Y.Z 替换为 Chat UIKit 的最新版本。
       // 最新版本请参见 https://search.maven.org/。
       implementation 'io.agora.rtc:chat-uikit:X.Y.Z'
   }
   ```

3. 添加网络和设备的访问权限。

   在 `/app/Manifests/AndroidManifest.xml` 中，在 `</application>` 后面添加以下权限：

   ```xml
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <uses-permission android:name="android.permission.WAKE_LOCK"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.RECORD_AUDIO"/>
   ```

   以上为启动即时通讯 IM 所需的最低权限。你还可以根据使用情况添加其他权限。

4. 防止代码混淆。

   在 `/Gradle Scripts/proguard-rules.pro` 中，添加以下代码：

   ```java
    -keep class io.agora.** {*;}
    -dontwarn  io.agora.**
   ```

## 实现单聊消息发送与接收

本节介绍如何使用即时通讯 IM UIKit 在你的应用中实现单聊消息的发送与接收。

### 创建用户界面

1. 要添加 UI 使用的文本字符串，需打开 `app/res/values/strings.xml`，将内容并替换为以下代码：

```xml
<resources>
    <string name="app_name">AgoraChatUIKitQuickstart</string>

    <string name="username_or_pwd_miss">用户名或密码为空</string>
    <string name="sign_up_success">注册成功</string>
    <string name="sign_in_success">登录成功</string>
    <string name="sign_out_success">登出成功</string>
    <string name="send_message_success">消息成功发出</string>
    <string name="enter_username">输入用户 ID</string>
    <string name="enter_password">输入密码</string>
    <string name="sign_in">登录</string>
    <string name="sign_out">登出</string>
    <string name="sign_up">注册</string>
    <string name="enter_to_username">输入用户 ID</string>
    <string name="start_chat">开始聊天</string>
    <string name="enter_content">输入内容</string>
    <string name="log_hint">显示日志区域...</string>
    <string name="has_login_before">该账户已登录，请先登出再重新登录</string>
    <string name="sign_in_first">请先登录</string>
    <string name="not_find_send_name">请输入接收人的用户 ID</string>

    <string name="app_key">41117440#383391</string>
</resources>
```

1. 要添加 UI 框架，需打开 `app/res/layout/activity_main.xml`，将内容并替换为以下代码：

   ```xml
    <?xml version="1.0" encoding="utf-8"?>
    <LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:app="http://schemas.android.com/apk/res-auto"
        xmlns:tools="http://schemas.android.com/tools"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical"
        tools:context=".MainActivity">
   
        <androidx.constraintlayout.widget.ConstraintLayout
            android:layout_width="match_parent"
            android:layout_height="0dp"
            android:layout_weight="1">
   
            <EditText
                android:id="@+id/et_username"
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:hint="@string/enter_username"
                app:layout_constraintLeft_toLeftOf="parent"
                app:layout_constraintRight_toLeftOf="@id/et_pwd"
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
                app:layout_constraintLeft_toRightOf="@id/et_username"
                app:layout_constraintRight_toRightOf="parent"
                app:layout_constraintTop_toTopOf="@id/et_username"
                android:layout_marginEnd="20dp"/>
   
            <Button
                android:id="@+id/btn_sign_in"
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:textSize="12sp"
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
                android:textSize="12sp"
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
                android:textSize="12sp"
                android:onClick="signUp"
                app:layout_constraintLeft_toRightOf="@id/btn_sign_out"
                app:layout_constraintRight_toRightOf="parent"
                app:layout_constraintTop_toBottomOf="@id/et_pwd"
                app:layout_constraintTop_toTopOf="@id/btn_sign_in"
                android:layout_marginStart="5dp"
                android:layout_marginEnd="10dp"/>
   
            <EditText
                android:id="@+id/et_to_username"
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:hint="@string/enter_to_username"
                app:layout_constraintLeft_toLeftOf="parent"
                app:layout_constraintRight_toLeftOf="@id/btn_start_chat"
                app:layout_constraintTop_toBottomOf="@id/btn_sign_up"
                app:layout_constraintHorizontal_weight="2"
                android:layout_marginStart="20dp"
                android:layout_marginEnd="20dp"
                android:layout_marginTop="10dp"
                android:layout_marginBottom="10dp"/>
   
            <Button
                android:id="@+id/btn_start_chat"
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:text="@string/start_chat"
                android:onClick="startChat"
                android:textSize="12sp"
                app:layout_constraintLeft_toRightOf="@id/et_to_username"
                app:layout_constraintRight_toRightOf="parent"
                app:layout_constraintBottom_toBottomOf="@id/et_to_username"
                app:layout_constraintHorizontal_weight="1"
                android:layout_marginEnd="10dp"/>
   
            <FrameLayout
                android:id="@+id/fl_fragment"
                android:layout_width="match_parent"
                android:layout_height="0dp"
                app:layout_constraintLeft_toLeftOf="parent"
                app:layout_constraintRight_toRightOf="parent"
                app:layout_constraintTop_toBottomOf="@id/btn_start_chat"
                app:layout_constraintBottom_toBottomOf="parent"/>
   
        </androidx.constraintlayout.widget.ConstraintLayout>
   
        <TextView
            android:id="@+id/tv_log"
            android:layout_width="match_parent"
            android:layout_height="100dp"
            android:hint="@string/log_hint"
            android:scrollbars="vertical"
            android:padding="10dp"/>
   
    </LinearLayout>
   ```

### 实现方法

要使你的应用实现在用户之间发送和接收消息，需执行以下操作：

1. 实现消息发送和接收。

   在 `app/java/io.agora.agorachatquickstart/MainActivity`中，将代码替换为以下内容：

   ```java
    package io.agora.chatuikitquickstart;
   
    import android.Manifest;
    import android.os.Bundle;
    import android.text.TextUtils;
    import android.text.method.ScrollingMovementMethod;
    import android.view.MotionEvent;
    import android.view.View;
    import android.widget.EditText;
    import android.widget.TextView;
    import android.widget.Toast;
   
    import androidx.appcompat.app.AppCompatActivity;
    import androidx.core.content.ContextCompat;
   
    import org.json.JSONObject;
   
    import java.util.HashMap;
    import java.util.Map;
   
    import io.agora.CallBack;
    import io.agora.ConnectionListener;
    import io.agora.Error;
    import io.agora.chat.ChatClient;
    import io.agora.chat.ChatMessage;
    import io.agora.chat.ChatOptions;
    import io.agora.chat.uikit.EaseUIKit;
    import io.agora.chat.uikit.chat.EaseChatFragment;
    import io.agora.chat.uikit.chat.interfaces.OnChatExtendMenuItemClickListener;
    import io.agora.chat.uikit.chat.interfaces.OnChatInputChangeListener;
    import io.agora.chat.uikit.chat.interfaces.OnChatRecordTouchListener;
    import io.agora.chat.uikit.chat.interfaces.OnMessageSendCallBack;
    import io.agora.chatuikitquickstart.utils.LogUtils;
    import io.agora.chatuikitquickstart.utils.PermissionsManager;
    import io.agora.cloud.HttpClientManager;
    import io.agora.cloud.HttpResponse;
    import io.agora.util.EMLog;
   
    import static io.agora.cloud.HttpClientManager.Method_POST;
   
    public class MainActivity extends AppCompatActivity {
        private static final String NEW_LOGIN = "NEW_LOGIN";
        private static final String RENEW_TOKEN = "RENEW_TOKEN";
        private static final String LOGIN_URL = "https://a41.chat.agora.io/app/chat/user/login";
        private static final String REGISTER_URL = "https://a41.chat.agora.io/app/chat/user/register";
        private EditText et_username;
        private TextView tv_log;
        private ConnectionListener connectionListener;
   
        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main);
            initView();
            requestPermissions();
            initSDK();
            addConnectionListener();
        }
   
        private void initView() {
            et_username = findViewById(R.id.et_username);
            tv_log = findViewById(R.id.tv_log);
            tv_log.setMovementMethod(new ScrollingMovementMethod());
        }
   
        private void requestPermissions() {
            checkPermissions(Manifest.permission.WRITE_EXTERNAL_STORAGE, 110);
        }
   
    //=================== init SDK start ========================
        private void initSDK() {
            ChatOptions options = new ChatOptions();
            // 设置从 Agora 控制台应用的 App Key
            String sdkAppkey = getString(R.string.app_key);
            if(TextUtils.isEmpty(sdkAppkey)) {
                Toast.makeText(MainActivity.this, "You should set your AppKey first!", Toast.LENGTH_SHORT).show();
                return;
            }
            // 将 App Key 应用到选项中
            options.setAppKey(sdkAppkey);
            // 设置是否需要送达回执。默认为 `false`，即不需要。
            options.setRequireDeliveryAck(true);
            // 设置为非自动登录
            options.setAutoLogin(false);
            // 利用 UIKit 初始化即时通讯 IM SDK
            EaseUIKit.getInstance().init(this, options);
            // 设置即时通讯 IM SDK 为可调试
            ChatClient.getInstance().setDebugMode(true);
        }
    //=================== init SDK end ========================
    //================= SDK listener start ====================
        private void addConnectionListener() {
            connectionListener = new ConnectionListener() {
                @Override
                public void onConnected() {
                }
   
                @Override
                public void onDisconnected(int error) {
                    if (error == Error.USER_REMOVED) {
                        onUserException("account_removed");
                    } else if (error == Error.USER_LOGIN_ANOTHER_DEVICE) {
                        onUserException("account_conflict");
                    } else if (error == Error.SERVER_SERVICE_RESTRICTED) {
                        onUserException("account_forbidden");
                    } else if (error == Error.USER_KICKED_BY_CHANGE_PASSWORD) {
                        onUserException("account_kicked_by_change_password");
                    } else if (error == Error.USER_KICKED_BY_OTHER_DEVICE) {
                        onUserException("account_kicked_by_other_device");
                    } else if(error == Error.USER_BIND_ANOTHER_DEVICE) {
                        onUserException("user_bind_another_device");
                    } else if(error == Error.USER_DEVICE_CHANGED) {
                        onUserException("user_device_changed");
                    } else if(error == Error.USER_LOGIN_TOO_MANY_DEVICES) {
                        onUserException("user_login_too_many_devices");
                    }
                }
   
                @Override
                public void onTokenExpired() {
                    //重新登录
                    signInWithToken(null);
                    LogUtils.showLog(tv_log,"ConnectionListener onTokenExpired");
                }
   
                @Override
                public void onTokenWillExpire() {
                    getTokenFromAppServer(RENEW_TOKEN);
                    LogUtils.showLog(tv_log, "ConnectionListener onTokenWillExpire");
                }
            };
            // 活动销毁时，调用 removeConnectionListener(connectionListener)
            ChatClient.getInstance().addConnectionListener(connectionListener);
        }
   
    //================= SDK listener end ====================
    //=================== click event start ========================
   
        /**
        * 注册即时通讯 IM 账号。
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
        * 通过 token 登录。
        */
        public void signInWithToken(View view) {
            getTokenFromAppServer(NEW_LOGIN);
        }
   
        /**
        * 登出。
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
   
        public void startChat(View view) {
            EditText et_to_username = findViewById(R.id.et_to_username);
            String toChatUsername = et_to_username.getText().toString().trim();
            // 检查用户 ID。
            if(TextUtils.isEmpty(toChatUsername)) {
                LogUtils.showErrorToast(this, tv_log, getString(R.string.not_find_send_name));
                return;
            }
            // 1：单聊；2：群聊；3：聊天室
            EaseChatFragment fragment = new EaseChatFragment.Builder(toChatUsername, 1)
                    .useHeader(false)
                    .setOnChatExtendMenuItemClickListener(new OnChatExtendMenuItemClickListener() {
                        @Override
                        public boolean onChatExtendMenuItemClick(View view, int itemId) {
                            if(itemId == io.agora.chat.uikit.R.id.extend_item_take_picture) {
                                return !checkPermissions(Manifest.permission.CAMERA, 111);
                            }else if(itemId == io.agora.chat.uikit.R.id.extend_item_picture || itemId == io.agora.chat.uikit.R.id.extend_item_file || itemId == io.agora.chat.uikit.R.id.extend_item_video) {
                                return !checkPermissions(Manifest.permission.READ_EXTERNAL_STORAGE, 112);
                            }
                            return false;
                        }
                    })
                    .setOnChatRecordTouchListener(new OnChatRecordTouchListener() {
                        @Override
                        public boolean onRecordTouch(View v, MotionEvent event) {
                            return !checkPermissions(Manifest.permission.RECORD_AUDIO, 113);
                        }
                    })
                    .setOnMessageSendCallBack(new OnMessageSendCallBack() {
                        @Override
                        public void onSuccess(ChatMessage message) {
                            LogUtils.showLog(tv_log, "Send success: message type: " + message.getType().name());
                        }
   
                        @Override
                        public void onError(int code, String errorMsg) {
                            LogUtils.showErrorLog(tv_log, "Send failed: error code: "+code + " errorMsg: "+errorMsg);
                        }
                    })
                    .build();
            getSupportFragmentManager().beginTransaction().replace(R.id.fl_fragment, fragment).commit();
        }
    //=================== click event end ========================
    //=================== get token from server start ========================
   
        private void getTokenFromAppServer(String requestType) {
            if(ChatClient.getInstance().getOptions().getAutoLogin() && ChatClient.getInstance().isLoggedInBefore()) {
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
   
        /**
        * 检查并申请权限。
        * @param permission：权限
        * @param requestCode：请求码
        * @return
        */
        private boolean checkPermissions(String permission, int requestCode) {
            if(!PermissionsManager.getInstance().hasPermission(this, permission)) {
                PermissionsManager.getInstance().requestPermissions(this, new String[]{permission}, requestCode);
                return false;
            }
            return true;
        }
        /**
        * 用户会遇到异常，如冲突、被移除或禁用，转到登录活动。
        */
        protected void onUserException(String exception) {
            LogUtils.showLog(tv_log, "onUserException: " + exception);
            ChatClient.getInstance().logout(false, null);
        }
   
        public void execute(Runnable runnable) {
            new Thread(runnable).start();
        }
   
        @Override
        protected void onDestroy() {
            super.onDestroy();
            if(connectionListener != null) {
                ChatClient.getInstance().removeConnectionListener(connectionListener);
            }
        }
    }
   ```

2. 添加日志类 LogUtils 和权限管理器 PermissionsManager。

   为了更快速地进行故障排除，本文使用 `LogUtils` 日志类。在 `app/java/io.agora.agorachatquickstart/` 中，创建 `utils` 文件夹。在该文件夹中，创建一个名为 `LogUtils` 的 `.java`文件，然后将以下代码复制到该文件中。

   ```java
    package io.agora.chatuikitquickstart.utils;
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

   当你的应用启动时，检查是否已授予将实时聊天插入应用所需的权限。在该 `utils` 文件中，创建名为 `PermissionsManager` 的 `.java` 文件，并将以下代码复制到该文件中。

   ```java
    package io.agora.chatuikitquickstart.utils;
   
    import android.app.Activity;
    import android.content.Context;
    import android.content.pm.PackageManager;
   
    import androidx.annotation.NonNull;
    import androidx.annotation.Nullable;
    import androidx.core.app.ActivityCompat;
   
    public class PermissionsManager {
        private static PermissionsManager mInstance = null;
   
        public static PermissionsManager getInstance() {
            if (mInstance == null) {
                mInstance = new PermissionsManager();
            }
            return mInstance;
        }
   
        private PermissionsManager() {}
   
        /**
        * 检查是否有权限。
        * @param context：环境
        * @param permission：权限
        * @return
        */
        @SuppressWarnings("unused")
        public synchronized boolean hasPermission(@Nullable Context context, @NonNull String permission) {
            return context != null && ActivityCompat.checkSelfPermission(context, permission)
                    == PackageManager.PERMISSION_GRANTED;
        }
   
        /**
        * 申请权限。
        * @param activity：活动
        * @param permissions：权限
        * @param requestCode：请求码
        */
        public synchronized void requestPermissions(Activity activity, String[] permissions, int requestCode) {
            ActivityCompat.requestPermissions(activity, permissions, requestCode);
        }
    }
   ```

3. 要发送图片和文件消息，实现以下配置：

   在 `/app/src/main/res/` 中，创建名为 `xml` 的文件夹，然后在该文件夹中创建 xml 文件 `file_paths.xml`。打开 `file_paths.xml`，将代码替换为以下内容:

   ```xml
    <?xml version="1.0" encoding="utf-8"?>
    <paths>
        <external-path path="Android/data/io/agora/chatuikitquickstart/" name="files_root" />
        <external-path path="." name="external_storage_root" />
    </paths>
   ```

   在 `/app/Manifests/AndroidManifest.xml` 中，在 `</application>` 之前添加以下代码：

   ```xml
    <!-- Android 7.0 以上版本，应添加以下代码 -->
    <provider
        android:name="androidx.core.content.FileProvider"
        android:authorities="${applicationId}.fileProvider"
        android:grantUriPermissions="true"
        android:exported="false">
        <meta-data
            android:name="android.support.FILE_PROVIDER_PATHS"
            android:resource="@xml/file_paths" />
    </provider>
   ```

4. 单击 `Sync Project with Gradle Files` 同步你的项目。现在可测试你的应用。

## 测试你的应用

要验证你刚刚使用即时通讯 IM 集成到应用中的单聊功能：

1. 在 Android Studio 中，单击 `Run 'app'`。

   你会在模拟器或物理设备上看到以下界面：

   <img src="https://web-cdn.agora.io/docs-files/1652232540196" style="zoom:50%;" />

2. 创建一个用户帐户并单击 **SIGN UP**。单击 **SIGN IN**，你将看到一个显示登录成功的日志。

3. 在其他 Android 设备或模拟器上运行应用程序并创建另一个用户帐户。确保你创建的用户 ID 唯一。

4. 在第一台设备或模拟器上，输入你刚刚创建的用户 ID，然后单击 **START CHAT**。现在，你可以开始在两个客户端之间聊天。

## 后续操作

出于演示目的，即时通讯 IM 提供一个 App Server，可使你利用本文中提供的 App Key 快速获得 token。在生产环境中，最好是自行部署 token 服务器，使用自己的 [App Key](./enable_agora_chat)生成 token，并在客户端获取 token 登录即时通讯 IM。要了解如何实现服务器按需生成和提供 token，请参阅[使用 Token 鉴权](./agora_chat_token)。

## 参考

Agora 提供了功能完善的 [即时通讯 IM Android UIKit](https://github.com/AgoraIO-Usecase/AgoraChat-UIKit-android) demo 作为实现参考。