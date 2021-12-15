---
title: 实现音频直播
platform: Cocos2d-x
updatedAt: 2020-12-11 12:11:40
---

本文介绍如何建立一个简单的 Cocos2d-x 项目并集成 Agora 音频 SDK，搭建一个具备基础音频直播功能的 Android 应用。

## 前提条件

### 开发环境要求

- Cocos2d-x 3.0 或以上。
- Python 2.7.5 或以上 (Cocos2d-x 不支持 Python 3 或以上）。
- Android Studio 3.0 或以上。
- NDK r18b 或以上。
- cmake。

<div class="alert info">本文以 Cocos2d-x 3.17.2 为例。关于搭建开发环境的更多信息，详见 <a href="https://docs.cocos.com/cocos2d-x/v4/manual/zh/installation/">Cocos2d-x 环境搭建要求</a >。如果你使用 Cocos2d-x 4.0 或以上版本，请参考 <a href="https://docs.cocos.com/cocos2d-x/v4/manual/zh/upgradeGuide/migration.html">Cocos 官方指南从 v3 升级至 v4</a >。</div>

### 运行环境要求

安装了 Android 4.1 或以上设备。部分模拟机可能存在功能缺失或者性能问题，所以推荐使用真机。

### 其他要求

有效的 Agora [开发者账号](/cn/Agora%20Platform/sign_in_and_sign_up?platform=All%20Platforms)。

<div class="alert note">如果你的网络环境部署了防火墙，请参考<a href="/cn/Agora%20Platform/firewall?platform=All%20Platforms">应用企业防火墙限制</a >以正常使用 Agora 服务。</div>

## 创建 Cocos2d-x 项目

本节介绍如何使用 Cocos2d-x 命令行工具创建一个新项目。

 <div class="alert info">本文以 Cocos2d-x 3.17.2 为例。</div>

1. 前往 [Cocos2d-x 下载页面](https://www.cocos.com/cocos2dx)，选择任意版本的 Cocos2d-x 引擎，下载并解压。

2. 解压后，运行根目录下的 `setup.py` 脚本文件，将 `cocos` 命令添加到环境变量。

   你可以在终端运行 `cocos -v`，检查 `cocos` 命令行工具是否已经成功添加到环境变量。若配置成功，会出现如下输出：

   ```
   cocos2d-x-3.17.2
   Cocos Console 2.3
   ```

3. 使用 `cocos new` 命令创建新项目，命令格式如下：

   ```
   cocos new <game name> -p <package identifier> -l <language> -d <location>
   ```

   其中：

   - `<game name>`：设置项目名称。

   - `-p <package identifier>`：设置项目的包名，格式为 `com.MyCompany.MyGame`，例如 `io.agora.gaming.cocos2d`。

   - `-l <language>`：设置项目使用的编程语言，可选值包括 `cpp`，`lua` 和 `js`。要集成 Agora SDK，`<language>` 必须设为 `cpp`。

   - `-d <location>`：设置项目存放路径。

   <div class="alert note">在 Windows 平台，建议你将项目存放路径设置为工作磁盘的根目录，以缩短项目路径。否则，编译 Android 项目时可能会因项目路径过长而失败。</div>

 <div class="alert info">关于使用 <code>cocos</code> 命令工具创建项目的更多信息，详见 <a href="https://docs.cocos.com/cocos2d-x/v4/manual/zh/editors_and_tools/cocosCLTool.html">cocos 命令</a >。</div>

## 集成 Agora SDK

1. 前往[下载页面](./downloads?platform=Cocos2d-x)，下载最新版的 Agora 音频 SDK 并解压。

2. 在项目根目录下创建 `sdk` 文件夹，用于存放 Agora 音频 SDK。你可以按照如下结构创建文件夹：

```
└─sdk
    ├─android
    │  ├─agora
    │  └─lib
    └─ios
        └─agora
```

<div class="alert info">你也可以将 Agora SDK 文件放置到项目的其他路径中，但需要注意将所有配置文件中 <code>./sdk/android/agora</code> 路径替换成你的 Agora SDK 存放路径。</div>

3.  将 SDK 包中 `libs` 文件夹下如下文件拷贝到你的项目文件夹中：

    | 文件或文件夹             | 项目路径              |
    | :----------------------- | :-------------------- |
    | `agora-rtc-sdk.jar` 文件 | `./sdk/android/lib`   |
    | `arm-v8a` 文件夹         | `./sdk/android/agora` |
    | `armeabi-v7a` 文件夹     | `./sdk/android/agora` |
    | `include` 文件夹         | `./sdk/android/agora` |
    | `x86 文件夹`             | `./sdk/android/agora` |
    | `x86_64` 文件夹          | `./sdk/android/agora` |

4.  在构建文件中添加 `.so` 库的配置。你可以选择以下任意一种方式：

    - 方法一：如果你使用的构建工具是 cmake, 即 `./proj.android/gradle.properties` 中设置 `PROP_BUILD_TYPE=cmake`，你需要进行如下操作：
      a. 在项目根目录下的 `CMakeLists.txt` 文件中添加如下代码：

            ```

      else()
      add_library(${APP_NAME} SHARED ${all_code_files})
         add_subdirectory(${COCOS2DX_ROOT_PATH}/cocos/platform/android ${ENGINE_BINARY_PATH}/cocos/platform)
         target_link_libraries(${APP_NAME} -Wl,--whole-archive cpp_android_spec -Wl,--no-whole-archive)
      // 添加如下四行代码：
      add_library(agora-rtc-sdk SHARED IMPORTED)
      set_target_properties(agora-rtc-sdk PROPERTIES IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/sdk/android/agora/${ANDROID_ABI}/libagora-rtc-sdk.so)
      include_directories(${CMAKE_CURRENT_SOURCE_DIR}/sdk/android/agora/include/)
         target_link_libraries(${APP_NAME} agora-rtc-sdk)
      endif()

      ````

      b. 在 `proj.android/app/build.gradle` 文件 `assets.srcDir "../../Resources"` 后增加如下代码， 添加 `.so` 库的引用：


      ```groovy
      ````

    sourceSets.main {
    java.srcDir "src"
    res.srcDir "res"
    manifest.srcFile "AndroidManifest.xml"
    assets.srcDir "../../Resources"
    // 添加如下两行代码，引用 so 库。
    if (PROP_BUILD_TYPE == 'cmake') {
    jniLibs.srcDirs "../../sdk/android/agora"
    }
    }
    ...
    dependencies {
    // 添加以下依赖：
    implementation fileTree(dir: '../../sdk/android/lib', include: ['*.jar'])
    implementation project(':libcocos2dx')
    implementation 'androidx.annotation:annotation:1.1.0'
    implementation 'androidx.appcompat:appcompat:1.2.0'
    }

````

   - 方法二：如果你使用的构建工具是 ndk-build，即 `./proj.android/gradle.properties` 中设置 `PROP_BUILD_TYPE=ndk-build`，在 `./proj.android/app/jni/Android.mk` 文件中添加如下代码：

    ```	makefile
    LOCAL_PATH := $(call my-dir)
// 添加如下 4 行代码，指定将 ./sdk/android/agora 路径下的源文件编译为动态库。
include $(CLEAR_VARS)
LOCAL_MODULE := agora-rtc-sdk
LOCAL_SRC_FILES := $(LOCAL_PATH)/../../../sdk/android/agora/$(TARGET_ARCH_ABI)/libagora-rtc-sdk.so
include $(PREBUILT_SHARED_LIBRARY)
include $(CLEAR_VARS)
LOCAL_MODULE := MyGame_shared
LOCAL_MODULE_FILENAME := libMyGame
LOCAL_SRC_FILES := $(LOCAL_PATH)/hellocpp/main.cpp \
                   $(LOCAL_PATH)/../../../Classes/AppDelegate.cpp \
                   $(LOCAL_PATH)/../../../Classes/HelloWorldScene.cpp \
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../../Classes \
                    // 添加如下行，将 ./sdk/android/agora/include 添加到 include 搜索路径中。
                    $(LOCAL_PATH)/../../../sdk/android/agora/include
	# _COCOS_HEADER_ANDROID_BEGIN
	# _COCOS_HEADER_ANDROID_END
LOCAL_STATIC_LIBRARIES := cc_static
// 添加如下行，链接 agora-rtc-sdk 动态库。
LOCAL_SHARED_LIBRARIES := agora-rtc-sdk
	# _COCOS_LIB_ANDROID_BEGIN
	# _COCOS_LIB_ANDROID_END
	include $(BUILD_SHARED_LIBRARY)
	$(call import-module, cocos)
	# _COCOS_LIB_IMPORT_ANDROID_BEGIN
	# _COCOS_LIB_IMPORT_ANDROID_END
		```

    <div class="alert note">如果使用 ndk-build 作为构建工具，不需要配置 <code>jniLibs.srcDirs</code>，ndk-build 会自动引用 <code>.so</code> 库。</div>








## 添加项目权限

根据场景需要，在 `./proj.android/app/AndroidManifest.xml` 文件中添加如下行，获取相应的设备权限：
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="io.agora.gaming.cocos2d"
    android:installLocation="auto">


    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.BLUETOOTH" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <!--如果你的场景中涉及读取外部存储，需添加如下权限：-->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <!--如果你使用的是 Android 10.0 及以上设备，还需要添加如下权限：-->
    <uses-permission android:name="android.permission.READ_PRIVILEGED_PHONE_STATE" />

...
</manifest>
````

## 获取设备权限

在 `./proj.android/app/src/org/cocos2dx/cpp/AppActivity.java` 文件添加如下代码，在开启 Activity 时检查并获取 Android 移动设备的麦克风使用权限。

```java
// 添加以下文件的导入：
import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.widget.Toast;
import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;
import java.util.ArrayList;
import java.util.List;

public class AppActivity extends Cocos2dxActivity {
    // 加载 agora-rtc-sdk .so 库。
    static {
        System.loadLibrary("agora-rtc-sdk");
    }

    private final static int REQUEST_CODE = 200;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.setEnableVirtualButton(false);
        super.onCreate(savedInstanceState);

        // App 运行时确认麦克风的使用权限。
        String[] needPermissions = {Manifest.permission.RECORD_AUDIO, Manifest.permission.CAMERA};
        checkAndRequestAppPermission(this, needPermissions);
    }

    private void checkAndRequestAppPermission(@NonNull Activity activity, String[] permissions) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) return;
        List<String> permissionList = new ArrayList<>();
        for (String permission : permissions) {
            if (ContextCompat.checkSelfPermission(activity, permission) != PackageManager.PERMISSION_GRANTED)
                permissionList.add(permission);
        }
        if (permissionList.size() == 0) return;
        String[] requestPermissions = permissionList.toArray(new String[0]);
        activity.requestPermissions(requestPermissions, AppActivity.REQUEST_CODE);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        if (requestCode == REQUEST_CODE) {
            StringBuilder builder = new StringBuilder();
            for (int i = 0; i < grantResults.length; i++) {
                if (grantResults[i] != PackageManager.PERMISSION_GRANTED) {
                    builder.append(permissions[i]);
                    builder.append(" ");
                }
            }
            if (builder.length() > 0) {
                builder.append("not permitted!");
                Toast.makeText(this, builder.toString(), Toast.LENGTH_SHORT).show();
            }
        } else {
            super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        }
    }
}
```

## 实现音频直播的基本流程

现在，你可以在调用 Agora 音频 SDK 提供的核心 API 实现基础的音频直播。

### 1. 导入类和添加声明

在 `HelloWorldScene.h` 文件中导入类，并添加变量与函数的声明。

1. 导入 `AgoraRtcKit` 和 `IAgoraRtcEngine` 类。

   ```c++
   #ifdef __APPLE__
   #include <AgoraRtcKit/IAgoraRtcEngine.h>
   #elif __ANDROID__
   #include "IAgoraRtcEngine.h"
   #endif
   ```

2. 定义 App ID 和 Token。

   在创建并初始化 `IRtcEngine` 对象时，你需要传入你的 Agora 项目的 App ID。详见[获取 App ID](./token?platform=All%20Platforms#a-name--appida使用-app-id-鉴权)。

   为提高项目的安全性，你需要使用 Token（动态密钥）对即将加入频道的用户进行鉴权。

   - 在测试阶段，你可以直接在控制台[生成临时 Token](./token?platform=All%20Platforms#get-a-temporary-token)。
   - 在生产环境，Agora 推荐你在自己的服务端生成 Token，详见[在服务端生成 Token](./token_server?platform=All%20Platforms)

```c++
// 将 <#YOUR APP ID#> 替换成你的 Agora 项目的 App ID，并加引号，如 "xxxxx"。
#define AGORA_APP_ID <#YOUR APP ID#>
// 将 <#YOUR TOKEN#> 替换成你自己生成的 Token，并加引号，如 "xxxxx"。
#define AGORA_TOKEN <#YOUR TOKEN#>
```

3. 添加函数声明。

```c++
  class HelloWorld : public cocos2d::Scene {
  public:
 static cocos2d::Scene *createScene();

   bool init() override;
   // 进入 HelloWorld 场景的回调。
   void onEnter() override;
   // 离开 HelloWorld 场景的回调。
   void onExit() override;

   ...

 private:
   // 点击加入频道按钮的回调。
   void onJoinChannelClicked();
   // 点击离开频道按钮的回调。
   void onLeaveChannelClicked();

 private:
   cocos2d::ui::EditBox *editBox;
   agora::rtc::IRtcEngine *engine;
   agora::rtc::IRtcEngineEventHandler *eventHandler;
   std::map<uid_t, bool> users;
 };
```

### 2. 创建用户界面

根据场景需要，为你的项目创建音频直播的用户界面。

Agora 推荐你添加如下用户界面元素：

- 频道名输入框
- 加入频道按钮
- 离开频道按钮

你可以参考 Agora 示例项目 [Cocos2d-x](https://github.com/AgoraIO-Community/Agora-Cocos-Quickstart/tree/master/Cocos2d-x), 在 `HelloWorldScene.cpp` 中添加如下代码，创建用户界面元素并定义点击事件处理函数：

- 频道名输入框

  ```c++
  // 创建一个输入框，用于获取用户输入的频道名，并在加入频道时调用。
  // 你需要自行将 TextBox.png 图片添加到 ./Resources 文件夹中。
  auto editBox = cocos2d::ui::EditBox::create(Size(120, 30), "TextBox.png");
  if (editBox==nullptr) {
      problemLoading("'TextBox.png'");
  } else {
    editBox->setPlaceHolder("Channel ID");
    editBox->setPosition(Vec2(origin.x + leftPadding + editBox->getContentSize().width/2,
                              origin.y + visibleSize.height
                                  - editBox->getContentSize().height*1.5f));
      this->addChild(editBox, 0);
  }
  ```

- 加入频道按钮

  ```c++
  // 创建加入频道按钮。当按钮被点击时，会触发 onJoinChannelClicked() 函数。
  // 你需要自行将 Button.png 和 ButtonPressed.png 图片添加到 ./Resources 文件夹中。
  auto joinButton =
        cocos2d::ui::Button::create("Button.png", "ButtonPressed.png", "ButtonPressed.png");
    if (joinButton==nullptr) {
      problemLoading("'Button.png' and 'ButtonPressed.png'");
    } else {
      joinButton->setTitleText("Join Channel");

      joinButton->setPosition(Vec2(origin.x + leftPadding + joinButton->getContentSize().width/2,
                                   origin.y + visibleSize.height
                                       - 1*joinButton->getContentSize().height
                                       - 2*editBox->getContentSize().height));

      joinButton->addTouchEventListener([&](cocos2d::Ref *sender, ui::Widget::TouchEventType type) {
        switch (type) {
        case ui::Widget::TouchEventType::BEGAN:break;
        case ui::Widget::TouchEventType::ENDED:onJoinChannelClicked();
          break;
        default:break;
        }
      });

      this->addChild(joinButton, 0);
    }
  ```

- 离开频道按钮

  ```c++
  // 创建离开频道按钮。当按钮被点击时，会触发 onLeaveChannelClicked() 函数。
  auto leaveButton = ui::Button::create("Button.png", "ButtonPressed.png", "ButtonPressed.png");
    if (leaveButton==nullptr) {
      problemLoading("'Button.png' and 'ButtonPressed.png'");
    } else {
      leaveButton->setTitleText("Leave Channel");

      leaveButton->setPosition(Vec2(origin.x + leftPadding + leaveButton->getContentSize().width/2,
                                    origin.y + visibleSize.height
                                        - 2*leaveButton->getContentSize().height
                                        - 2*editBox->getContentSize().height));

      leaveButton->addTouchEventListener([&](cocos2d::Ref *sender, ui::Widget::TouchEventType type) {
        switch (type) {
        case ui::Widget::TouchEventType::BEGAN:break;
        case ui::Widget::TouchEventType::ENDED:onLeaveChannelClicked();
          break;
        default:break;
        }
      });

      this->addChild(leaveButton, 0);
    }
  ```

### 3. 初始化 IRtcEngine

在调用其他 Agora API 前，需要创建并初始化 `IRtcEngine` 对象。调用 `createAgoraRtcEngine` 和 `initialize` 方法，传入获取到的 App ID，即可初始化 `IRtcEngine`。

```c++
class MyIGamingRtcEngineEventHandler : public agora::rtc::IRtcEngineEventHandler {
private:
  HelloWorld *mUi;


public:
  explicit MyIGamingRtcEngineEventHandler(HelloWorld *ui) : mUi(ui) {}
  // 注册 onJoinChannelSuccess 回调。
  // 本地用户成功加入频道时，会触发该回调。
  void onJoinChannelSuccess(const char *channel, uid_t uid, int elapsed) override {
  }

  // 注册 onLeaveChannel 回调。
  // 本地用户成功离开频道时，会触发该回调。
  void onLeaveChannel(const agora::rtc::RtcStats &stats) override {
  }
};

...

void HelloWorld::onEnter() {
  cocos2d::Scene::onEnter();
  eventHandler = new MyIGamingRtcEngineEventHandler(this);
  // 创建 IRtcEngine 对象。
  engine = createAgoraRtcEngine();
  // 定义 RtcEngineContext。
  agora::rtc::RtcEngineContext context;
  context.appId = AGORA_APP_ID;
  context.eventHandler = eventHandler;
  // 初始化 IRtcEngine 对象。
  engine->initialize(context);
}
```

### 5. 设置频道场景

完成初始化后，调用 `setChannelProfile`，将频道场景设为互动直播。

一个 `IRtcEngine` 只能使用一种频道场景。如果想切换为其他模式，需要先调用 `release` 方法释放当前的 `IRtcEngine` 实例，然后调用 `createAgoraRtcEngine` 和 `initialize` 方法创建一个新实例，再调用 setChannelProfile 设置新的频道场景。

```c++
void HelloWorld::onJoinChannelClicked() {
  if (editBox == nullptr || strlen(editBox->getText()) == 0) {
    return;
  }
  // 将频道场景设置为直播场景。
  engine->setChannelProfile(agora::rtc::CHANNEL_PROFILE_LIVE_BROADCASTING);
 ...
}
```

### 6. 设置用户角色

互动直播频道有两种用户角色：主播和观众，其中默认的角色为观众。设置频道场景为互动直播后，你可以在 app 中参考如下步骤设置用户角色：

- 让用户选择自己的角色是主播还是观众。
- 调用 `setClientRole`，然后使用用户选择的角色进行传参。

注意，互动直播频道内的用户只能听到主播的声音。加入频道后，如果你想切换用户角色，也可以调用 `setClientRole`。

```c++
void HelloWorld::onJoinChannelClicked() {
  if (editBox == nullptr || strlen(editBox->getText()) == 0) {
    return;
  }
  ...
  // 将用户角色设置为主播。
  engine->setClientRole(agora::rtc::CLIENT_ROLE_BROADCASTER);
  ...
}
```

### 7. 加入频道

完成设置角色后，你可以调用 `joinChannel` 方法，填入 Token、频道名称和用户 ID，加入频道。

```c++
void HelloWorld::onJoinChannelClicked() {
  if (editBox == nullptr || strlen(editBox->getText()) == 0) {
    return;
  }
  ...
  // 传入 Token 和频道名，加入频道。
  // 将 uid 设为 0 表示由 SDK 自动分配一个 uid。
  engine->joinChannel(AGORA_TOKEN, editBox->getText(), "Cocos2d", 0);
}
```

<div class="alert note">用户成功加入频道后，会默认订阅频道内其他所有用户的音频流，因此产生用量并影响计费。如果想取消订阅，可以通过调用相应的 <code>mute</code> 方法实现。</div>

### 8. 离开频道

根据场景需要，调用 `leaveChannel` 离开当前音频直播。

```c++
void HelloWorld::onLeaveChannelClicked() { engine->leaveChannel(); }
```

### 9. 释放 IRtcEngine

如果你想在退出 `HelloWorld` 场景时释放 Agora 引擎的内存，需调用 release 方法销毁 Agora 引擎。

```c++
void HelloWorld::onExit() {
  Node::onExit();
  agora::rtc::IRtcEngine::release(true);
  engine = nullptr;
  delete eventHandler;
  eventHandler = nullptr;
}
```

## 运行项目

1. 开启 Android 设备的开发者选项，打开 USB 调试，通过 USB 连接线将 Android 设备接入电脑。
2. 用 Android Studio 打开 `Cocos2d-x/proj.android` 文件夹。
3. 选择 **File > Project Structure > SDK Location**, 在 **Android NDK Location** 下填入你的 NDK 本地存储路径，点击 **Apply > OK**。
4. 点击 **Sync Project with Gradle Files** 按钮，同步项目。
5. 点击 **Run app** 按钮。

当成功开始音频互动直播时，观众可以听到主播的声音。

## 相关链接

Agora 在 GitHub 上提供一个开源的音视频通话示例项目 [Agora-Cocos-Quickstart/Cocos2d-x](https://github.com/AgoraIO-Community/Agora-Cocos-Quickstart/tree/master/Cocos2d-x)，你可以结合该示例项目与本文示例代码实现音频互动直播。
