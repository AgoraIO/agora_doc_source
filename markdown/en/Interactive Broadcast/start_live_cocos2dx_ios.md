---
title: Start Interactive Live Video Streaming
platform: Cocos2d-x
updatedAt: 2020-12-11 12:12:43
---
This article describes how to create a simple Cocos2d-x project and integrate the Agora Video SDK to implement basic interactive live video streaming.

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
 

## Integrate the Agora Video SDK

1. Go to [SDK Downloads](./downloads?platform=Cocos2d-x), download the latest version of the Agora Video SDK for iOS, and extract the files from the downloaded SDK package.
2. Create an `sdk` folder in your project root directory for the Agora Video SDK. You can create the folder and add subfolders in the following structure:
  ```
	└─sdk
    ├─android
    │  ├─agora
    │  └─lib
    └─ios
        └─agora
	```
 <div class="alert info"> You can also place the Agora Video SDK in other paths of your project, but then you need to replace the <code>./sdk/ios/agora</code> path with your path for the Agora Video SDK.</div>
 
2. Copy the `AgoraRtcKit.framework` and `AgoraRtcCryptoLoader.framework` folders from the `libs` folder of the downloaded SDK package to `Cocos2d-x/sdk/ios/agora` of your project.

  <div class="alert note">If you need to support a simulator, then copy the <code>AgoraRtcKit.framework</code> and <code>AgoraRtcCryptoLoader.framework</code> folders from the <code>ALL_ARCHITECTURE</code> folder to <code>Cocos2d-x/sdk/ios/agora</code> of your project instead. </br>The dynamic libraries under this path contains the x86_64 architecture, which affects the distribution of your app in the App Store. Therefore, you need to remove the x86_64 architecture in the libraries before uploading the app to the App Store.</div> 


## Add project permissions
Add the following permissions in the `./proj.ios_mac/ios/info.plist` file for device access according to your needs:

```
<key>NSMicrophoneUsageDescription</key>
<string>Microphone</string>
<key>NSCameraUsageDescription</key>
<string>Camera</string>
```


## Implement live video streaming
Now you can call the core APIs provided by the Agora Video SDK to implement interactive live video streaming.

In the project, you can create files for the live video streaming function in the following structure:

```
├─Classes
│ ...
│  │  HelloWorldScene.cpp
│  │  HelloWorldScene.h
│  │  VideoFrameObserver.cpp
│  │  VideoFrameObserver.h
│  │
```

The `VideoFrameObserver.cpp` and `VideoFrameObserver.h` files include the code that implements the raw video data function; the `HelloWorldScene.h` and `HelloWorldScene.cpp` files include the code that implements the live video streaming function in the `HelloWorld` scene.

### 1. Import classes and add declarations

Add the following code in `HelloWorldScene.h` to import classes and add declarations of variables and functions:

1. Import the following files:

 ```c++
 // Import the AgoraRtcKit and IAgoraRtcEngine classes.
#ifdef __APPLE__
#include "AgoraRtcKit.h"
#elif __ANDROID__
#include "IAgoraRtcEngine.h"
#endif
// Import the following header files and map container.
#include "VideoFrameObserver.h"
#include "ui/CocosGUI.h"
#include <map>
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
  // Define the update() method, which will be called by the scheduleUpdate() method.
  void update(float delta) override;  
  ... 
public:
  // Create and initialize the video view of a specified user.
  void addTextureRender(uid_t uid, int width, int height);
  // Remove the video view of a specified user.
  void removeTextureRender(uid_t uid);
  // Remove the video views of all users.
  void removeAllTextureRenders();
private:
  // Occur when a user clicks the join-channel button.
  void onJoinChannelClicked();
  // Occur when a user clicks the leave-channel button.
  void onLeaveChannelClicked();
private:
  cocos2d::ui::EditBox *editBox;
  agora::rtc::IRtcEngine *engine;
  agora::rtc::IRtcEngineEventHandler *eventHandler;
  agora::cocos::VideoFrameObserver *videoFrameObserver;
  std::map<uid_t, bool> users;
};
   ```

### 2. Create the UI 


 Create the user interface (UI) for live video streaming.

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
  // Create a join-channel button. Clicking this button triggers the onLeaveChannelClicked() function.
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
  void onJoinChannelSuccess(const char *channel, uid_t uid,
                            int elapsed) override {
  }
  
  // Listen for the onLeaveChannel callback.
  // This callback occurs when the local user leaves the channel.
  void onLeaveChannel(const agora::rtc::RtcStats &stats) override {
  }
 
  // Listen for the onFirstRemoteVideoDecoded callback.
  // This callback occurs when the first remote video frame is received and decoded.
  void onFirstRemoteVideoDecoded(uid_t uid, int width, int height,
                                 int elapsed) override {
  }
   
  // Listen for the onUserOffline callback.
  // This callback occurs when a remote user leaves the channel.
  void onUserOffline(uid_t uid,
                     agora::rtc::USER_OFFLINE_REASON_TYPE reason) override {
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




 
### 4. Set the channel profile

After initializing the `IRtcEngine` object, call `setChannelProfile` to set the channel profile as `LIVE_BROADCASTING`.

One `IRtcEngine` object uses one profile only. If you want to switch to another profile, release the current `IRtcEngine` object with the `release` method and create a new one before calling the `setChannelProfile` method.

```c++
void HelloWorld::onJoinChannelClicked() {
  if (editBox == nullptr || strlen(editBox->getText()) == 0) {
    return;
  }
  // Set the channel profile as live streaming.
  engine->setChannelProfile(agora::rtc::CHANNEL_PROFILE_LIVE_BROADCASTING);
  ...
}
```

### 5. Set the client role

An interactive streaming channel has two client roles: `BROADCASTER` and `AUDIENCE`; and the default role is `AUDIENCE`. After setting the channel profile to `LIVE_BROADCASTING`, your app may use the following steps to set the client role:

- Allow the user to set the role as `BROADCASTER` or `AUDIENCE`.
- Call `setClientRole` and pass in the client role set by the user.

Note that during the interactive live audio streaming, only the host can be heard. If you want to switch the client role after joining the channel, call the `setClientRole` method.

```c++
void HelloWorld::onJoinChannelClicked() {
  if (editBox == nullptr || strlen(editBox->getText()) == 0) {
    return;
  }
  ...
  // Set the usr role as host.
  engine->setClientRole(agora::rtc::CLIENT_ROLE_BROADCASTER);
  ...
}
```

### 6. Join a channel

After setting the client role, you can call `joinChannel`, pass in a token, channel name, and user ID to join a channel.

```c++
void HelloWorld::onJoinChannelClicked() {
  if (editBox == nullptr || strlen(editBox->getText()) == 0) {
    return;
  }
  ...
  // Pass in your token and channel name to join the channel. 
  // Set uid as 0, and the SDK assigns a user ID for the local user.
  engine->joinChannel(AGORA_TOKEN, editBox->getText(), "Cocos2d", 0);
}
```


<div class="alert note">Once the user joins the channel, the user subscribes to the audio streams of all the other users in the channel by default, giving rise to usage and billing calculation. If you do not want to subscribe to a specified stream or all remote streams, call the `mute` methods accordingly.</div>

### 7. Get and render raw video data

In the Cocos2d-x project, to display the local and remote video views, you need to use the raw video data function provided by the Agora SDK to get and cache the raw video data, and then send the video data to the Cocos2d-x engine for rendering.

![](https://web-cdn.agora.io/docs-files/1607569666655)

#### Get raw video data

1. Create a `VideoFrameObserver.h` file, and declare the methods to be called in this file.

   ```c++
   #pragma once
    
   #include <map>
   #include <mutex>
   #include <vector>
    
   #ifdef __APPLE__
   #include <AgoraRtcKit/IAgoraMediaEngine.h>
   #include <AgoraRtcKit/IAgoraRtcEngine.h>
   #elif __ANDROID__
   #include "IAgoraMediaEngine.h"
   #include "IAgoraRtcEngine.h"
   #endif
    
   namespace agora {
   namespace cocos {
   // Define a CacheVideoFrame class, which caches the raw video data.
   class CacheVideoFrame {
   public:
     void resetVideoFrame(media::IVideoFrameObserver::VideoFrame &videoFrame);
    
   public:
     int width;
     int height;
     uint8_t *data;
   };
    
   // Define an IVideoFrameObserver class and register the callbacks of this class.
   class VideoFrameObserver : public media::IVideoFrameObserver {
   public:
     // Set the video format in the return value of the getVideoFormatPreference callback.
     VIDEO_FRAME_TYPE getVideoFormatPreference() override;
     // Set whether to rotate the video frame in the return value of the getRotationApplied callback.
     bool getRotationApplied() override;
     // Get the video data captured by the local camera in the onCaptureVideoFrame callback.
     bool onCaptureVideoFrame(VideoFrame &videoFrame) override;
     // Get the video data sent by the remote user in the onRenderVideoFrame callback.
     bool onRenderVideoFrame(unsigned int uid, VideoFrame &videoFrame) override;
    
   public:
     // Associate the uid with the textureId.
     void bindTextureId(unsigned int textureId, unsigned int uid);
    
   private:
     // Cache the video frame.
     void cacheVideoFrame(unsigned int uid,
                          media::IVideoFrameObserver::VideoFrame &videoFrame);
     // Render the cached video frame into a 2D texture image.                
     void renderTexture(unsigned int textureId, const CacheVideoFrame &frame);
    
   private:
     std::map<unsigned int, CacheVideoFrame> _map;
     std::mutex mtx;
   };
   } // namespace cocos
   } // namespace agora
   ```

2. Create a `VideoFrameObserver.cpp` file, and implement an `IVideoFrameObserver` class to get and cache the raw video data output by the Agora SDK.

   ```c++
   #include "VideoFrameObserver.h"
    
   #if defined(__ANDROID__)
   #include <GLES/gl.h>
   #include <GLES2/gl2.h>
   #include <GLES2/gl2ext.h>
   #elif defined(__APPLE__)
   #include <OpenGLES/ES2/gl.h>
   #endif
    
   namespace agora {
   namespace cocos {
   void CacheVideoFrame::resetVideoFrame(
       media::IVideoFrameObserver::VideoFrame &videoFrame) {
     auto size = videoFrame.width * videoFrame.height * 4;
     if (size != width * height * 4) {
       if (data) {
         delete[] data;
         data = new uint8_t[size];
       } else {
         data = new uint8_t[size];
       }
     }
     memcpy(data, videoFrame.yBuffer, size);
     width = videoFrame.width;
     height = videoFrame.height;
   }
    
   // Set the video frame type as RGBA.
   media::IVideoFrameObserver::VIDEO_FRAME_TYPE
   VideoFrameObserver::getVideoFormatPreference() {
     return FRAME_TYPE_RGBA;
   }
    
   // Set the SDK to rotate the captured video frame.
   bool VideoFrameObserver::getRotationApplied() { return true; }
    
   // Get and cache the video data captured by the local camera.
   bool VideoFrameObserver::onCaptureVideoFrame(
       media::IVideoFrameObserver::VideoFrame &videoFrame) {
     cacheVideoFrame(0, videoFrame);
     return true;
   }
    
   // Get and cache the video data sent by the remote user.
   bool VideoFrameObserver::onRenderVideoFrame(
       unsigned int uid, media::IVideoFrameObserver::VideoFrame &videoFrame) {
     cacheVideoFrame(uid, videoFrame);
     return true;
   }
    
   // Bind the user ID with the texture ID.
   // If the specified uid is in the map, then the renderTexture() method will be called
// to render the video frame of the user to a 2D texture image with the specified textureId.
   void VideoFrameObserver::bindTextureId(unsigned int textureId,
                                          unsigned int uid) {
     if (_map.find(uid) != _map.end()) {
       renderTexture(textureId, _map[uid]);
     }
   }
    
   // Cache the video frame output by the Agora SDK, and record the mapping relationship
// between the video frame and user ID.
   void VideoFrameObserver::cacheVideoFrame(
       unsigned int uid, media::IVideoFrameObserver::VideoFrame &videoFrame) {
     if (_map.find(uid) == _map.end()) {
       _map[uid] = CacheVideoFrame();
     }
     mtx.lock();
     _map[uid].resetVideoFrame(videoFrame);
     mtx.unlock();
   }
    
   // Render the cached video frame into a 2D texture image. 
   void VideoFrameObserver::renderTexture(unsigned int textureId,
                                          const CacheVideoFrame &frame) {
     mtx.lock();
     glBindTexture(GL_TEXTURE_2D, textureId);
     glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, frame.width, frame.height, 0, GL_RGBA,
                  GL_UNSIGNED_BYTE, frame.data);
     glBindTexture(GL_TEXTURE_2D, 0);
     mtx.unlock();
   }
   } // namespace cocos
   } // namespace agora
   ```

#### Render raw video data

After implementing the `IVideoFrameObserver` class, you need to call the methods of the Agora SDK and the Cocos2d-x engine to display the local and remote video views.

Add the following code to the `HelloWorldScene.cpp` file:

1. In the `onEnter` callback, call the `registerVideoFrameObserver` method to register the video observer.

   ```c++
   void HelloWorld::onEnter() {
     ...
    
     // Register a video frame observer object.
     agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
     mediaEngine.queryInterface(engine, agora::AGORA_IID_MEDIA_ENGINE);
     if (mediaEngine) {
       videoFrameObserver = new agora::cocos::VideoFrameObserver;
       mediaEngine->registerVideoFrameObserver(videoFrameObserver);
     }
   }
   ```

2. Define an `addTextureRender` method to create and initialize the video views of local and remote users.
   This method creates a 2D texture image according to the specified parameters, uses the 2D texture image to create a sprite object, and then adds the sprite object to the node to display the image in the scene.
   You can use this method to initialize the video views of the local and remote users and add the video views into the `HelloWorld` scene.

   ```c++
   void HelloWorld::addTextureRender(uid_t uid, int width, int height) {
     Director::getInstance()->getScheduler()->performFunctionInCocosThread([=] {
       if (users.find(uid) == users.end()) {
         users[uid] = true;
       }
       // Create a 2D texture image.
       auto texture = new cocos2d::Texture2D;
       MipmapInfo info;
       texture->initWithMipmaps(&info, 1, Texture2D::PixelFormat::RGBA4444,
                                width / 2, height / 2);
       // Use the 2D texture image to create a sprite object.
       auto sprite = Sprite::createWithTexture(texture);
       if (sprite != nullptr) {
         auto visibleSize = Director::getInstance()->getVisibleSize();
         Vec2 origin = Director::getInstance()->getVisibleOrigin();
    
         // Set the position of the sprite object in the scene.
         sprite->setPosition(Vec2(
             origin.x + visibleSize.width - sprite->getContentSize().width / 2,
             origin.y + visibleSize.height + sprite->getContentSize().height / 2 -
                 sprite->getContentSize().height * users.size()));
    
         // Add the sprite object as a child node to the scene.
         this->addChild(sprite, 0, "uid:" + std::to_string(uid));
       }
     });
   }
   ```

3. Set the local video view so that you can see yourself in the call. Follow these steps to configure the local video view:

   - Call the `enableVideo` method to enable the video module.
   - Call the `addTextureRender` method to configure the local video display settings.

   ```c++
   void HelloWorld::onJoinChannelClicked() {
     if (editBox == nullptr || strlen(editBox->getText()) == 0) {
       return;
     }
     // Enable the video.
     engine->enableVideo();
     ...
   }
    
   // In the onJoinChannelSuccess callback, call the addTextureRender() method to set the local video view.
   void onJoinChannelSuccess(const char *channel, uid_t uid,
                               int elapsed) override {
        
       mUi->addTextureRender(0, 640, 480);
     }
   ```

4. Set the remote video views so that you can see other users as well.

   Shortly after a remote user joins the channel, the SDK gets the remote user's ID in the `onFirstRemoteVideoDecoded` callback. Call the `addTextureRender` method in the callback, and pass in the uid to set the video view of the remote user.

   ```c++
   void onFirstRemoteVideoDecoded(uid_t uid, int width, int height,
                                    int elapsed) override {
       mUi->addTextureRender(uid, width, height);
     }
   ```

5. Call the `update()` method every frame to display each user's video frames as one continuous video.

   ```c++
   void HelloWorld::update(float delta) {
     Node::update(delta);
     for (auto user : users) {
       auto sprite =
           this->getChildByName<Sprite *>("uid:" + std::to_string(user.first));
       if (sprite) {
         auto texture = sprite->getSpriteFrame()->getTexture();
    
         int textureId = texture->getName();
         videoFrameObserver->bindTextureId(textureId, user.first);
       }
     }
   }
   ```

   

### 8. Leave the channel



 Call the `leaveChannel` method to leave the current live streaming according to your scenario.

```c++
void HelloWorld::onLeaveChannelClicked() { engine->leaveChannel(); }
```

After leaving the channel, if you want to release the memory of the Cocos2d-x engine, call `removeAllTextureRenders` to remove the video views of all users.

```c++
void onLeaveChannel(const agora::rtc::RtcStats &stats) override {
    mUi->removeAllTextureRenders();
  }
```

### 9. Release IRtcEngine

if you want to release the memory of the Agora engine when exiting the HelloWorld scene, call `release` to destroy the Agora engine.

```c++
void HelloWorld::onExit() {
  Node::onExit();
  agora::rtc::IRtcEngine::release(true);
  engine = nullptr;
  delete eventHandler;
  eventHandler = nullptr;
  delete videoFrameObserver;
  videoFrameObserver = nullptr;
}
```
## Run the project



 
1. Open `Cocos2d-x/proj.ios_mac/Hello-Cocos2d-Agora.xcodeproj` with Xcode.
2. Connect your iOS device to your computer using a USB cable.
3. Click the **Build and run** button in Xcode.



When the interactive live video streaming starts successfully, hosts can see they own video, and audience members can see the video of hosts in the app.