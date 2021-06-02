---
title: Start a Voice Call
platform: Cocos2d-x
updatedAt: 2020-12-11 12:15:02
---
This article describes how to create a simple Cocos2d-x project and integrate the Agora Voice SDK to implement basic voice calls.

## Prerequisites

 
### Development environment
- Cocos2d-x 3.0 or later. 
- Python 2.7.5 or later. (Cocos2d-x does not support Python 3 or later.)
- Android Studio 3.0 or later.
- A mobile device running Android 4.1 or later. Agora recommends you run this sample project on a physical mobile device, as some simulators may not support the full features of this project.
- NDK r18b or later.
- cmake.
 




<div class="alert info">This article uses Cocos2d-x 3.17.2 as an example. For more information about the environment requirements, see <a href="https://docs.cocos.com/cocos2d-x/v4/manual/en/installation/prerequisites.html">Cococ2d-x installation prerequisites</a >. If you use Cocos2d-x 4.0 or later, please refer to the <a href="https://docs.cocos.com/cocos2d-x/v4/manual/en/upgradeGuide/migration.html">Cocos documentation to upgrade from v3 to v4</a >.</div>

### Other Prerequisites

A valid Agora [account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up?platform=All%20Platforms).

<div class="alert note">If your network has a firewall, follow the instructions in <a href="https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a > to access Agora services.</div>

## Create a Cocos2d-x project

This section describes how to use the Cocos2d-x command line tool to create a new project.

1. Go to the [Cocos2d-x download](https://www.cocos.com/en/cocos2dx/download) page, select a version of Cocos2d-x, and then download it. 

2. Extract the files from the downloaded package, and run the `setup.py` script in the root directory to set the environmental variables.

   You can run `cocos -v` in the terminal to check whether the Cocos2d-x command line tool is set up correctly. You should see the following output if the setup is correct:
   
   ```
   cocos2d-x-3.17.2
   Cocos Console 2.3
   ```

3. Use the `cocos new` command to create a new project:
   ```
   cocos new <game name> -p <package identifier> -l <language> -d <location>
   ```

   Where:

   - `<game name>`: Sets the project name.

   - `-p <package identifier>`: Sets the package name of the project. The package name should be in the format of `com.MyCompany.MyGame`, for example, `io.agora.gaming.cocos2d`.

   - `-l <language>`: Sets the programming language used by the project. Optional values include `cpp`, `lua`, and `js`. 

     To integrate the Agora Voice SDK, the `<language>` parameter must be set as `cpp`.

   - `-d <location>`: Sets the directory of the project. 
   
 <div class="alert note">Agora recommends that you set the directory as the root directory of your working disk to shorten the project path; otherwise, the build of Android project may fail because the project path is too long.</div> 

 <div class="alert info">For more information about creating a new project using the <code>cocos new</code> command, see <a href="https://docs.cocos.com/cocos2d-x/v4/manual/en/editors_and_tools/cocosCLTool.html">the documentation for the Cocos command line tool</a >.</div>
 

## Integrate the Agora Voice SDK

Follow these steps to integrate the Agora SDK into your project:

1. Go to [SDK Downloads](./downloads?platform=Android), download the latest version of the Agora Voice SDK for Android, and extract the files from the downloaded SDK package.

2. Create an `sdk` folder in your project root directory for the Agora Voice SDK. You can create the folder and add subfolders in the following structure:
 ```
 └─sdk
    ├─android
    │  ├─agora
    │  └─lib
    └─ios
        └─agora
 ```
 <div class="alert info"> You can also place the Agora Voice SDK in other paths of your project, but then you need to replace the <code>./sdk/android/agora</code> path in all configuration files with your path for the Agora Voice SDK.</div>
4. Copy the following files or subfolders from the `libs` folder of the downloaded SDK package to the path of your project:

   | File or subfolder        | Path of your project  |
   | :----------------------- | :-------------------- |
   | `agora-rtc-sdk.jar` file | `./sdk/android/lib`   |
   | `arm-v8a` folder         | `./sdk/android/agora` |
   | `armeabi-v7a` folder     | `./sdk/android/agora` |
   | `include` folder         | `./sdk/android/agora` |
   | `x86_64` folder          | `./sdk/android/agora` |
   | `x86` folder             | `./sdk/android/agora` |

3. Add the configuration of the `.so` libraries to the build files. You can choose any of the following methods:

 - **Method one**: If you use cmake as the build tool, that is, you set `PROP_BUILD_TYPE=cmake` in the `./proj.android/gradle.properties` file, do the following:
    
    a. Add the following code to the `CMakeLists.txt` file in the project root directory:
    
    ```
    else()
        add_library(${APP_NAME} SHARED ${all_code_files})
        add_subdirectory(${COCOS2DX_ROOT_PATH}/cocos/platform/android ${ENGINE_BINARY_PATH}/cocos/platform)
        target_link_libraries(${APP_NAME} -Wl,--whole-archive cpp_android_spec -Wl,--no-whole-archive)
        // Add the following four lines:
        add_library(agora-rtc-sdk SHARED IMPORTED)
        set_target_properties(agora-rtc-sdk PROPERTIES IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/sdk/android/agora/${ANDROID_ABI}/libagora-rtc-sdk.so)
        include_directories(${CMAKE_CURRENT_SOURCE_DIR}/sdk/android/agora/include/)
        target_link_libraries(${APP_NAME} agora-rtc-sdk)
    endif()
    ```
    
    b. Add the following code after `assets.srcDir "../../Resources"` in the `proj.android/app/build.gradle` file to include the `.so` libraries:
    
    ```groovy
    sourceSets.main {
            java.srcDir "src"
            res.srcDir "res"
            manifest.srcFile "AndroidManifest.xml"
            assets.srcDir "../../Resources"
            // Add the following two lines to include the .so libraries:
            if (PROP_BUILD_TYPE == 'cmake') {
                jniLibs.srcDirs "../../sdk/android/agora"
            }
        }
    ```
    
   - **Method two**: If you use ndk-build as the build tool, that is, you set `PROP_BUILD_TYPE=ndk-build` in the `./proj.android/gradle.properties` file, then add the following code to the `./proj.android/app/jni/Android.mk` file:

    ```makefile
LOCAL_PATH := $(call my-dir)		 
 // Add the following four lines to specify the source files for the shared libraries.
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
                      $(LOCAL_PATH)/../../../Classes/TextBox/TextBox.cpp \
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../../Classes \
                       // Add the following line to add ./sdk/android/agora/include to the include search path.
                       $(LOCAL_PATH)/../../../sdk/android/agora/include
	# _COCOS_HEADER_ANDROID_BEGIN
	# _COCOS_HEADER_ANDROID_END
LOCAL_STATIC_LIBRARIES := cc_static
// Add the following line to link agora-rtc-sdk.
LOCAL_SHARED_LIBRARIES := agora-rtc-sdk
    # _COCOS_LIB_ANDROID_BEGIN	
	# _COCOS_LIB_ANDROID_END  
include $(BUILD_SHARED_LIBRARY)
$(call import-module, cocos)
    # _COCOS_LIB_IMPORT_ANDROID_BEGIN
    # _COCOS_LIB_IMPORT_ANDROID_END
   ```

      <div class="alert note">If you choose ndk-build, you do not need to set <code>jniLibs.srcDirs</code>, as ndk-build will automatically include the <code>.so</code> libraries.</div>

## Add project permissions

Add the following permissions in the `./proj.android/app/AndroidManifest.xml` file for device access according to your needs:

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
    // Add the following permission if your scenario involves reading the external storage:
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    // For devices running Android 10.0 or later, you also need to add the following permission:
    <uses-permission android:name="android.permission.READ_PRIVILEGED_PHONE_STATE" />
  
...
</manifest>
```

## Get the device permission

Add the following code in `./proj.android/app/src/org/cocos2dx/cpp/AppActivity.java` to access the microphone of the Android device when launching the activity:

```java
public class AppActivity extends Cocos2dxActivity {
    // Load the agora-rtc-sdk .so library.
    static {
        System.loadLibrary("agora-rtc-sdk");
    }

    private final static int REQUEST_CODE = 200;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.setEnableVirtualButton(false);
        super.onCreate(savedInstanceState);
        
        // Ask for Android device permissions at runtime.
        String[] needPermissions = {Manifest.permission.RECORD_AUDIO};
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

## Implement interactive live audio streaming
Now you can call the core APIs provided by the Agora Voice SDK to implement the basic voice call function.

### 1. Import classes and add declarations

Add the following code in `HelloWorldScene.h` to import classes and add declarations of variables and functions:

1. Import `AgoraRtcKit` and `IAgoraRtcEngine` classes.

 ```c++
 #ifdef __APPLE__
 #include <AgoraRtcKit/IAgoraRtcEngine.h>
 #elif __ANDROID__
 #include "IAgoraRtcEngine.h"
 #endif
 ```

2. Define App ID and token.
   To create and initialize an `IRtcEngine` object, you need to pass in the App ID of your Agora project. See [Get an App ID](./token?platform=All%20Platforms#a-name--appidause-an-app-id-for-authentication) for details.
	 To ensure communication security, you need to use tokens (dynamic keys) to authenticate users joining a channel.	 
   - For testing, you can [generate a temporary token](./token?platform=All%20Platforms#get-a-temporary-token) in Agora Console.
   - For production, Agora recommends using a token generated at your server. See [Generate a Token](./token_server).

 ```c++
// Replace <#YOUR APP ID#> with the App ID of your Agora project and add quotation marks, such as "xxxxxx".
#define AGORA_APP_ID <#YOUR APP ID#>
// Replace <#YOUR TOKEN#> with your token and add quotation marks, such as "xxxxxxx".
#define AGORA_TOKEN <#YOUR TOKEN#>
```

3. Add function declarations.

   ```c++
   class HelloWorld : public cocos2d::Scene {
   public:
     static cocos2d::Scene *createScene();
    
     bool init() override;
     // Occurs when a user enters the HelloWorld scene.
     void onEnter() override;
     // Occurs when a user exits the HelloWorld scene.
     void onExit() override;
     ...
      
   public:
     void updateMsgContent(const std::string &msg);
    
   private:
     // Occurs when a user clicks the join-channel button.
     void onJoinChannelClicked();
     // Occurs when a user clicks the leave-channel button.
     void onLeaveChannelClicked();
    
   private:
     TextBox *textBox;
     cocos2d::ui::EditBox *editBox;
     agora::rtc::IRtcEngine *engine;
     agora::rtc::IRtcEngineEventHandler *eventHandler;
     std::map<uid_t, bool> users;
   };
   ```

### 2. Create the UI 

 Create the user interface (UI) for the voice call.


We recommend adding the following elements into the UI:

- A channel name edit box 
- A join-channel button 
- A leave-channel button 

In the Agora sample project [Cocos2d-x](https://github.com/AgoraIO-Community/Agora-Cocos-Quickstart/tree/master/Cocos2d-x), the code for creating the UI elements and handling the button click events is as follows:

- **The channel name edit box**

  ```c++
  // Create an edit box to get the channel name entered by the user.
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

- **The join-channel button**

  ```c++
  // Create a join-channel button. Clicking this button triggers the onJoinChannelClicked() function.
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

- **The leave-channel button**

  ```c++
  // Create a leave-channel button. Clicking this button triggers the onJoinChannelClicked() function.
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
  
### 3. Initialize IRtcEngine

Create and initialize the `IRtcEngine` object before calling any other Agora APIs. Call the `createAgoraRtcEngine` and `initialize` methods, and pass in your App ID to initialize the `IRtcEngine` object.

```c++
class MyIGamingRtcEngineEventHandler : public agora::rtc::IRtcEngineEventHandler {
private:
  HelloWorld *mUi;
  
public:
  explicit MyIGamingRtcEngineEventHandler(HelloWorld *ui) : mUi(ui) {}
  // Listen for the onJoinChannelSuccess callback.
  // This callback occurs when the local user successfully joins the channel.
  void onJoinChannelSuccess(const char *channel, uid_t uid, int elapsed) override {
    CCLOG("[General C++]:onJoinChannelSuccess %s, %d, %d", channel, uid, elapsed);
    std::stringstream rawMsg;
    rawMsg << "onJoinChannelSuccess " << channel << " " << uid << " " << elapsed;
    mUi->updateMsgContent(rawMsg.str());
  }
  // Listen for the onLeaveChannel callback.
  // This callback occurs when the local user leaves the channel.
  void onLeaveChannel(const agora::rtc::RtcStats &stats) override {
    CCLOG("[General C++]:onLeaveChannel %d, %d, %d", stats.duration, stats.txBytes, stats.rxBytes);
    std::stringstream rawMsg;
    rawMsg << "onLeaveChannel " << stats.duration << " " << stats.txBytes << " " << stats.rxBytes;
    mUi->updateMsgContent(rawMsg.str());
  }
};
  
...
  
void HelloWorld::onEnter() {
  cocos2d::Scene::onEnter();
  eventHandler = new MyIGamingRtcEngineEventHandler(this);
  // Create an IRtcEngine object.
  engine = createAgoraRtcEngine();
  // Define RtcEngineContext.
  agora::rtc::RtcEngineContext context;
  context.appId = AGORA_APP_ID;
  context.eventHandler = eventHandler;
  // Initialize the IRtcEngine object.
  engine->initialize(context);
}
```


### 4. Join a channel

 
After initializing the `IRtcEngine` object, you can call `joinChannel` to join a channel.

```
void HelloWorld::onJoinChannelClicked() {
  if (editBox == nullptr || strlen(editBox->getText()) == 0) {
    return;
  }
    // Pass in your token and channelId to join the channel.
	engine->joinChannel(AGORA_TOKEN, editBox->getText(), "Cocos2d", 0);
}
```




<div class="alert note">Once the user joins the channel, the user subscribes to the audio streams of all the other users in the channel by default, giving rise to usage and billing calculation. If you do not want to subscribe to a specified stream or all remote streams, call the `mute` methods accordingly.</div>

### 5. Leave the channel

 Call the `leaveChannel` method to leave the current call according to your scenario, for example, when the call ends, when you need to close the app, or when your app runs in the background.



```
void HelloWorld::onLeaveChannelClicked() { engine->leaveChannel(); }
```

## Run the project

 
1. Enable **Developer options** and **USB Debugging** on your Android device, and then connect it to your computer using a USB cable.
2. Open the `Cocos2d-x/proj.android` folder with Android Studio.
3. Select **File > Project Structure > SDK Location**, fill in the local path of your NDK under **Android NDK Location**, and then click **Apply > OK**. 
4. Click **Sync Project with Gradle Files**.
5. After the Gradle synchronization finishes, click **Build and run**.





You can hear the remote users when you successfully start a voice call in the app.