# 即时通讯 IM 快速入门

即时通讯将各地人们连接在一起，实现实时通信。利用即时通讯 IM SDK，你可以在任何地方的任何设备上的任何应用中嵌入实时通讯。

本文介绍如何通过示例代码集成即时通讯 IM SDK，在你的 Android app 中实现发送和接收单聊文本消息。

## 技术原理

~7aac3300-785d-11ec-bcb4-b56a01c83d2e~

## 前提条件

开始前，请确保你的开发环境满足以下条件：

- 有效的 [Agora 账号](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#创建-agora-账号)。
- 拥有[开启了即时通讯 IM 服务](./enable_agora_chat)的 [App Key](./enable_agora_chat#获取即时通讯项目信息) 的 Agora [项目](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#创建-agora-项目)。
- Android 模拟器或 Android 设备。
- Android Studio 3.6 或以上版本。
- Java 开发工具包（JDK）。适用版本请参考 [Android 用户指南](https://developer.android.com/studio/write/java8-support)。

## 生成 Token

### 注册用户

参考以下步骤注册用户：

1. 在**项目管理**页面，点击你要使用的项目的**操作**一栏中的**配置**按钮。

![](https://web-cdn.agora.io/docs-files/1670827574193)

![](./images/quickstart/config_project.png)

2. 在**服务配置**页面，点击**即时通讯**中的**配置**链接。

![](https://web-cdn.agora.io/docs-files/1670827609516)

![](./images/quickstart/config_chat.png)

3. 在左侧导航栏，选择**运营管理** > **用户**，点击**创建IM用户**。

![](https://web-cdn.agora.io/docs-files/1670827634437)

![](./images/quickstart/user_mgmt.png)

4. 在**创建IM用户**对话框中，填写用户信息并点击保存，创建用户。

![](https://web-cdn.agora.io/docs-files/1670827653548)

![](./images/quickstart/create_user.png)


### 生成 Token

为了保证通信安全，Agora 推荐使用 token 对登录即时通讯 IM 的用户进行认证。

出于测试目的，Agora 控制台支持为即时通讯 IM 生成临时 Token。要生成用户令牌，请执行以下操作：

1. 在**项目管理**页面，点击你要使用的项目的**操作**一栏中的**配置**按钮。

![](https://web-cdn.agora.io/docs-files/1670827574193)

![](./images/quickstart/config_project.png)

2. 在**服务配置**页面，点击**即时通讯**中的**配置**链接。

![](https://web-cdn.agora.io/docs-files/1670827609516)

![](./images/quickstart/config_chat.png)

3. 在**应用信息**页面的**Data Center**区域，在 **Chat User Temp Token** 框中输入用户 ID，点击 **Generate** 生成一个具有用户权限的 Token。

![](https://web-cdn.agora.io/docs-files/1670827712260)

![](./images/quickstart/generate_token.png)

<div class="alert note">为了在该 Demo 中测试使用，需注册两个用户，即发送方和接收方，并且分别为其生成 Token。</div>

## 项目设置

参考以下步骤创建环境，将即时通讯 IM 添加到你的应用程序中。

1. 若为新项目，在 **Android Studio** 中，创建一个带有 **Empty Activity** 的 **Phone and Tablet** [Android 项目](https://developer.android.com/studio/projects/create-project)。

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

   <div class="alert note">如果你在 Android 项目中设置 [dependencyResolutionManagement](https://docs.gradle.org/current/userguide/declaring_repositories.html#sub:centralized-repository-declaration)，则添加 Maven Central 依赖项的方式可能会有所不同。</div>

   b.在 `/Gradle Scripts/build.gradle(Module: <projectname>.app)` 中，添加以下代码将即时通讯 IM SDK 集成到你的 Android 项目中：

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
    <div class="alert note"><li>minSdkVersion 必须为 21 或以上版本才能成功构建。<li>如需最新 SDK 版本，请前往 <a href="https://search.maven.org/search?q=a:chat-sdk">Sonatype</a>。</div>
   
3. 添加网络和设备访问权限。

   在 `/app/Manifests/AndroidManifest.xml` 中，在 `</application>` 后面添加以下权限：

   ```xml
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
   <uses-permission android:name="android.permission.WAKE_LOCK"/>
   <!—- 对于 Android 12，需添加下行代码申请闹铃定时权限 -—> 
   <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
   ```

   以上为启动即时通讯 IM 所需的最低权限。你还可以根据使用情况添加其他权限。

4. 防止代码混淆。

   在 `/Gradle Scripts/proguard-rules.pro` 中，添加以下代码：

   ```java
   -keep class io.agora.** {*;}
   -dontwarn  io.agora.**
   ```

## 实现单聊消息发送和接收

本节介绍如何使用即时通讯 IM SDK 在你的应用中实现单聊消息的发送与接收。

### 创建用户界面

1. 添加 UI 使用的文本字符串。打开 `app/res/values/strings.xml`，将内容并替换为以下代码：

  ```xml
  <resources>
      <string name="app_name">AgoraChatQuickstart</string>
  </resources>
  ```

2. 添加 UI 框架。打开 `app/res/layout/activity_main.xml`，将内容并替换为以下代码：

   ```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical">

    <ScrollView
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1">

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="vertical"
            android:gravity="center_horizontal"
            android:layout_marginStart="20dp"
            android:layout_marginEnd="20dp">

            <TextView
                android:id="@+id/tv_username"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:hint="Username"
                android:layout_marginTop="20dp"/>

            <Button
                android:id="@+id/btn_sign_in"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:text="Sign in"
                android:onClick="signInWithToken"
                android:layout_marginTop="10dp"/>

            <Button
                android:id="@+id/btn_sign_out"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:text="Sign out"
                android:onClick="signOut"
                android:layout_marginTop="10dp"/>

            <EditText
                android:id="@+id/et_to_chat_name"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:hint="Enter another username"
                android:layout_marginTop="20dp"/>

            <EditText
                android:id="@+id/et_msg_content"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:hint="Enter content"
                android:layout_marginTop="10dp"/>

            <Button
                android:id="@+id/btn_send_message"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:text="Send message"
                android:onClick="sendFirstMessage"
                android:layout_marginTop="20dp"/>

        </LinearLayout>

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

### 实现消息的发送和接收

要使你的应用实现在用户之间发送和接收消息，需执行以下操作：

1. 导入类。<br/> 在 `app/java/io.agora.agorachatquickstart/MainActivity` 中，在 `import android.os.Bundle;` 之后添加以下代码：

   ```java
   import android.text.TextUtils;
   import android.text.method.ScrollingMovementMethod;
   import android.view.View;
   import android.widget.EditText;
   import android.widget.TextView;
   import android.widget.Toast;
   import java.text.SimpleDateFormat;
   import java.util.Date;
   import java.util.Locale;
   import io.agora.CallBack;
   import io.agora.ConnectionListener;
   import io.agora.chat.ChatClient;
   import io.agora.chat.ChatMessage;
   import io.agora.chat.ChatOptions;
   import io.agora.chat.TextMessageBody;

   ```

2. 定义全局变量。<br/>在 `app/java/io.agora.agorachatquickstart/MainActivity` 中，在 `AppCompatActivity {` 后面添加以下代码之前，需确保删除默认创建的 `onCreate` 函数。

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
       // 添加初始化方法，监听消息和连接事件。
       initView();
       initSDK();
       addMessageListener();
       addConnectionListener();
   }
   ```

3. 初始化视图和应用程序。<br/>在 `app/java/io.agora.agorachatquickstart/MainActivity` 中，在 `onCreate` 方法后添加如下代码：

   ```java
    // 初始化视图。
    private void initView() {
       ((TextView)findViewById(R.id.tv_log)).setMovementMethod(new ScrollingMovementMethod());
    }
    // 初始化 SDK。
    private void initSDK() {
        ChatOptions options = new ChatOptions();
        // 设置你从声网的控制台获取的 App Key。
        if(TextUtils.isEmpty(APP_KEY)) {
           Toast.makeText(MainActivity.this, "You should set your AppKey first!", Toast.LENGTH_SHORT).show();
           return;
        }
        // 将 App Key 设置到选项中。
        options.setAppKey(APP_KEY);
        // 初始化即时通讯 IM SDK。
        ChatClient.getInstance().init(this, options);
        // 设置即时通讯 IM SDK 为可调试。
        ChatClient.getInstance().setDebugMode(true);
        // 显示当前用户。
        ((TextView)findViewById(R.id.tv_username)).setText("Current user: "+USERNAME);
    }
   ```

4. 添加事件回调。<br/>在 `app/java/io.agora.agorachatquickstart/MainActivity` 中，在 `initSDK` 方法后添加以下代码：

   ```java
    private void initListener() {
    // 添加消息事件回调。
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
        // 添加连接事件回调。
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
            // Token 过期时会触发该回调。该回调触发时，你需要从你的 App Server 中获取新的 token，然后重新登录即时通讯 IM。
            @Override
            public void onTokenExpired() {
                 showLog("ConnectionListener onTokenExpired", true);
            }
            // Token 即将过期时会触发该回调。
            @Override
            public void onTokenWillExpire() {
                 showLog("ConnectionListener onTokenWillExpire", true);
            }
        });
    }
   ```

5. 创建用户帐户，登录 app。<br/>要实现该逻辑，需在 `app/java/io.agora.agorachatquickstart/MainActivity` 中的 `initListener` 方法后面添加以下代码：

   ```java
   // 利用 Token 登录。
   public void signInWithToken(View view) {
        loginToAgora();
   }

   private void loginToAgora() {
        if(TextUtils.isEmpty(USERNAME) || TextUtils.isEmpty(TOKEN)) {
             showLog("Username or token is empty!", true);
             return;
    }
        ChatClient.getInstance().loginWithAgoraToken(USERNAME, TOKEN, new CallBack() {
             @Override
             public void onSuccess() {
                 showLog("Sign in success!", true);
            }

            @Override
            public void onError(int code, String error) {
                showLog(error, true);
            }
        });
    }

    // 登出。
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
        }else {
             showLog("You were not logged in", false);
        }
    }
   ```

6. 开始聊天。<br/>要实现发送消息的功能，请在 `signOut` 方法后面添加以下代码：

   ```java
   // 发送首条消息。
   public void sendFirstMessage(View view) {
        String toSendName = ((EditText)findViewById(R.id.et_to_chat_name)).getText().toString().trim();
        String content = ((EditText)findViewById(R.id.et_msg_content)).getText().toString().trim();
        // 创建文本消息
        ChatMessage message = ChatMessage.createTextSendMessage(content, toSendName);
        // 发送消息前设置消息回调。
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

        // 发送消息。
        ChatClient.getInstance().chatManager().sendMessage(message);
    }
    ```

7. 要查看日志，在 `sendFirstMessage` 方法中添加以下代码：

   ```java
   // 显示日志。
   private void showLog(String content, boolean showToast) {
        if(TextUtils.isEmpty(content)) {
           return;
        }
        runOnUiThread(()-> {
           if(showToast) {
               Toast.makeText(this, content, Toast.LENGTH_SHORT).show();
            }
            TextView tv_log = findViewById(R.id.tv_log);
            String preContent = tv_log.getText().toString().trim();
            StringBuilder builder = new StringBuilder();
            builder.append(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new Date()))
                .append(" ").append(content).append("\n").append(preContent);
            tv_log.setText(builder);
        });
    }
   ```

8. 单击 `Sync Project with Gradle Files` 同步你的项目。现在可测试你的应用。

## 测试你的应用

参考以下步骤验证你刚刚使用即时通讯 IM 服务集成到 app 中的单聊功能：

1. 登录即时通讯 IM。<br/>
   a. 在 `MainActivity` 文件中，将 `USERNAME`、`TOKEN` 和 `APP_KEY` 占位符替换为发送方（`Som`）的用户 ID、Agora Token 和 App Key。
   b. 在 Android Studio 中，选择要运行项目的设备，然后单击 **Run 'app'**。
   c. 在您的模拟器或物理设备上，单击 **SIGN IN** 使用发送方的帐户登录。
   ![](https://web-cdn.agora.io/docs-files/1670828329040)
   ![](./images/quickstart/android_login.png)

2. 发送消息。<br/>
   在 **Enter another username** 框中输入接收方的用户 ID，在 **Enter content** 框中输入要发送的消息（"How are you doing?"），然后单击 **SEND MESSAGE** 发送消息。

   ![](https://web-cdn.agora.io/docs-files/1670828391688)

   ![](./images/quickstart/android_send_msg.png)

3. 登出即时通讯 IM。<br/>
   单击 **SIGN OUT** 登出即时通讯服务。

4. 接收消息。<br/>
a. 登出即时通讯 IM 后，在 `MainActivity` 文件中，将 `USERNAME`、`TOKEN` 和 `APP_KEY` 占位符替换为发送方（`Neil`）的用户 ID、Agora Token 和 App Key。
b. 利用接收方的账号在另一台 Android 设备或模拟器上运行该 app，接收步骤 2 中发送的 "How are you doing?" 消息。

![](https://web-cdn.agora.io/docs-files/1670828405472)

![](./images/quickstart/android_receive_msg.png)

## 后续操作

出于演示目的，即时通讯 IM 提供一个 App Server，可使你利用本文中提供的 App Key 快速获得 token。在生产环境中，最好自行部署 token 服务器，使用自己的 [App Key](./enable_agora_chat) 生成 token，并在客户端获取 token 登录即时通讯 IM。要了解如何实现服务器按需生成和提供 token，请参阅[生成用户 Token](./generate_user_tokens)。

## 参考

除了使用 mavenCentral 将即时通讯 IM SDK 集成到你项目中外，你还可以手动下载 [即时通讯 IM Android SDK](https://download.agora.io/sdk/release/Agora_Chat_SDK_for_Android_v1.0.0.zip)。

1. 下载最新版本的即时通讯 IM Android SDK，并从下载的 SDK 包中解压文件。

2. 将下载的 SDK 的 **libs** 文件夹中的以下文件或子文件夹复制到你的项目的对应目录中。

   | 文件或子文件夹                                      | 你的项目路径                          |
   | :-------------------------------------------------- | :------------------------------------ |
   | `agorachat_X.Y.Z.jar`                                  | `~/app/libs/`                         |
   | `/arm64-v8a/libagora-chat-sdk.so` 和 `libsqlite.so`   | `~/app/src/main/jniLibs/arm64-v8a/`   |
   | `/armeabi-v7a/libagora-chat-sdk.so` 和 `libsqlite.so` | `~/app/src/main/jniLibs/armeabi-v7a/` |
   | `/x86/libagora-chat-sdk.so` 和 `libsqlite.so`         | `~/app/src/main/jniLibs/x86/`         |
   | `/x86_64/libagora-chat-sdk.so` 和 `libsqlite.so`      | `~/app/src/main/jniLibs/x86_64/`      |

   <div class="alert note">XYZ 指是你下载的即时通讯 IM SDK 的版本号。</div>