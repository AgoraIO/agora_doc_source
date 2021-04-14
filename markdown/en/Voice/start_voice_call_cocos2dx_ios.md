---
title: Start a Voice Call
platform: Cocos2d-x
updatedAt: 2020-12-11 12:15:07
---
This article describes how to create a simple Cocos2d-x project and integrate the Agora Voice SDK to implement interactive live audio streaming.

## Prerequisites



 
### Development environment
- Cocos2d-x 3.0 or later. 
- Python 2.7.5 or later. (Cocos2d-x does not support Python 3 or later.)
- Xcode 9.0 or later.
- A mobile device running iOS 8.0 or later. Agora recommends you run this sample project on a physical mobile device, as some simulators may not support the full features of this project.
 


<div class="alert info">This article uses Cocos2d-x 3.17.2 as an example. For more information about the environment requirements, see <a href="https://docs.cocos.com/cocos2d-x/v4/manual/en/installation/prerequisites.html">Cococ2d-x installation prerequisites</a >. If you use Cocos2d-x 4.0 or later, please refer to the <a href="https://docs.cocos.com/cocos2d-x/v4/manual/en/upgradeGuide/migration.html">Cocos documentation to upgrade from v3 to v4</a >.</div>

### Other Prerequisites

A valid Agora [account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up?platform=All%20Platforms).

<div class="alert note">If your network has a firewall, follow the instructions in <a href="https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a > to access Agora services.</div>
## Create a Cocos2d-x project

This section describes how to use the Cocos2d-x command line tool to create a new project.

 <div class="alert info">This article uses Cocos2d-x 3.17.2 as an example.</div>

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

     To integrate the Agora SDK, the `<language>` parameter must be set as `cpp`.

   - `-d <location>`: Sets the directory of the project. 
   


 <div class="alert info">For more information about creating a new project using the <code>cocos new</code> command, see <a href="https://docs.cocos.com/cocos2d-x/v4/manual/en/editors_and_tools/cocosCLTool.html">the documentation for the Cocos command line tool</a >.</div>
 

## Integrate the Agora Voice SDK

1. Go to [SDK Downloads](./downloads?platform=Cocos2d-x), download the latest version of the Agora Voice SDK for iOS, and extract the files from the downloaded SDK package.
2. Create an `sdk` folder in your project root directory for the Agora Voice SDK. You can create the folder and add subfolders in the following structure:
  ```
	└─sdk
    ├─android
    │  ├─agora
    │  └─lib
    └─ios
        └─agora
	```
 <div class="alert info"> You can also place the Agora Voice SDK in other paths of your project, but then you need to replace the <code>./sdk/ios/agora</code> path with your path for the Agora Voice SDK.</div>
 
2. Copy the `AgoraRtcKit.framework` and `AgoraRtcCryptoLoader.framework` folders from the `libs` folder of the downloaded SDK package to `Cocos2d-x/sdk/ios/agora` of your project.

  <div class="alert note">If you need to support a simulator, then copy the <code>AgoraRtcKit.framework</code> and <code>AgoraRtcCryptoLoader.framework</code> folders from the <code>ALL_ARCHITECTURE</code> folder to <code>Cocos2d-x/sdk/ios/agora</code> of your project instead. </br>The dynamic libraries under this path contains the x86_64 architecture, which affects the distribution of your app in the App Store. Therefore, you need to remove the x86_64 architecture in the libraries before uploading the app to the App Store.</div> 


## Add project permissions

Add the following permissions in the `./proj.ios_mac/ios/info.plist` file for device access according to your needs:

```
<key>NSMicrophoneUsageDescription</key>
<string>Microphone</string>
```


## Implement a basic voice call
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
     // Occur when a user enters the HelloWorld scene.
     void onEnter() override;
     // Occur when a user exits the HelloWorld scene.
     void onExit() override;
     
		 ...
    
   private:
     // Occur when a user clicks the join-channel button.
     void onJoinChannelClicked();
     // Occur when a user clicks the leave-channel button.
     void onLeaveChannelClicked();
    
   private:
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
// You need to add the TextBox.png image to the ./Resources folder.
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
// You need to add the Button.png and ButtonPressed.png images to the ./Resources folder.
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
  }
	
  // Listen for the onLeaveChannel callback.
  // This callback occurs when the local user leaves the channel.
  void onLeaveChannel(const agora::rtc::RtcStats &stats) override {
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
    // Pass in your token and channel name to join the channel.
	// Set uid as 0, and the SDK assigns a user ID for the local user.
	engine->joinChannel(AGORA_TOKEN, editBox->getText(), "Cocos2d", 0);
}
```




<div class="alert note">Once the user joins the channel, the user subscribes to the audio streams of all the other users in the channel by default, giving rise to usage and billing calculation. If you do not want to subscribe to a specified stream or all remote streams, call the `mute` methods accordingly.</div>

### 5. Leave the channel

 Call the `leaveChannel` method to leave the current call according to your scenario.



```
void HelloWorld::onLeaveChannelClicked() { engine->leaveChannel(); }
```

### 6. Release IRtcEngine

if you want to release the memory of the Agora engine when exiting the `HelloWorld` scene, call `release` to destroy the Agora engine.

```c++
void HelloWorld::onExit() {
  Node::onExit();
  agora::rtc::IRtcEngine::release(true);
  engine = nullptr;
  delete eventHandler;
  eventHandler = nullptr;
}
```
## Run the project


 
1. Open `Cocos2d-x/proj.ios_mac/Hello-Cocos2d-Agora.xcodeproj` with Xcode.
2. Connect your iOS device to your computer using a USB cable.
3. Click the **Build and run** button in Xcode.

