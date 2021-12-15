---
title: 实现视频通话
platform: Cocos2d-x
updatedAt: 2020-12-11 12:11:22
---

本文介绍如何建立一个简单的 Cocos2d-x 项目并集成 Agora 视频 SDK 实现基础的视频通话。

## 前提条件

### 开发环境要求

- Cocos2d-x 3.0 或以上。
- Python 2.7.5 或以上 (Cocos2d-x 不支持 Python 3 或以上）。
- Xcode 9.0 或以上版本。

<div class="alert info">本文以 Cocos2d-x 3.17.2 为例。关于搭建开发环境的更多信息，详见 <a href="https://docs.cocos.com/cocos2d-x/v4/manual/zh/installation/">Cocos2d-x 环境搭建要求</a >。如果你使用 Cocos2d-x 4.0 或以上版本，请参考 <a href="https://docs.cocos.com/cocos2d-x/v4/manual/zh/upgradeGuide/migration.html">Cocos 官方指南从 v3 升级至 v4</a >。</div>

### 运行环境要求

安装了 iOS 8.0 或以上版本的设备。部分模拟机可能存在功能缺失或者性能问题，所以推荐使用真机。

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

 <div class="alert info">关于使用 <code>cocos</code> 命令工具创建项目的更多信息，详见 <a href="https://docs.cocos.com/cocos2d-x/v4/manual/zh/editors_and_tools/cocosCLTool.html">cocos 命令</a >。</div>

## 集成 Agora SDK

1. 前往[下载页面](./downloads?Cocos2d-x)，下载最新版的 Agora 视频 SDK 并解压。
2. 在项目根目录下创建 `sdk` 文件夹，用于存放 Agora 视频 SDK。你可以按照如下结构创建文件夹：

```
└─sdk
    ├─android
    │  ├─agora
    │  └─lib
    └─ios
        └─agora
```

 <div class="alert info">你也可以将 Agora SDK 文件放置到项目的其他路径中，但需要注意将下文中的 <code>./sdk/ios/agora</code> 路径替换成你的 Agora SDK 存放路径。</div>

3. 将 `libs` 文件夹下的 `AgoraRtcKit.framework` 和 `AgoraRtcCryptoLoader.framework` 文件夹复制到 `./sdk/ios/agora` 文件夹下。

<div class="alert note">如果你需要支持模拟器，则需要将 <code>libs/ALL_ARCHITECTURE</code> 文件夹下的 <code>AgoraRtcKit.framework</code> 和 <code>AgoraRtcCryptoLoader.framework</code> 文件夹复制到 <code>./sdk/ios/agora</code> 文件夹下。</br>该路径下的动态库包含 x86_64 架构，会影响 app 在 App Store 的发布，你需要在将 app 发布至 App Store 前移除 x86_64 架构。</div>

## 添加项目权限

根据场景需要，在 `./proj.ios_mac/ios/info.plist`文件中，添加如下内容，获取相应的设备权限：

```
<key>NSMicrophoneUsageDescription</key>
<string>Microphone</string>
<key>NSCameraUsageDescription</key>
<string>Camera</string>
```

## 实现视频通话基本流程

现在，你可以在调用 Agora 视频 SDK 提供的核心 API 实现基础的视频通话。
在项目中，你可以按照以下结构为视频通话功能创建文件：

```
├─Classes
│ ...
│  │  HelloWorldScene.cpp
│  │  HelloWorldScene.h
│  │  VideoFrameObserver.cpp
│  │  VideoFrameObserver.h
│  │
```

其中，`VideoFrameObserver.cpp` 和 `VideoFrameObserver.h` 文件包含实现原始视频数据功能的代码；`HelloWorldScene.h` 和 `HelloWorldScene.cpp` 文件包含在 HelloWorld 场景中实现视频通话功能的代码。

### 1. 导入类和添加声明

在 `HelloWorldScene.h` 文件中导入类，并添加变量与函数的声明。

1. 导入以下文件：

   ```c++
   // 导入 AgoraRtcKit 和 IAgoraRtcEngine 类。
   #ifdef __APPLE__
   #include "AgoraRtcKit.h"
   #elif __ANDROID__
   #include "IAgoraRtcEngine.h"
   #endif
   // 导入以下头文件和 map 关联容器。
   #include "VideoFrameObserver.h"
   #include "ui/CocosGUI.h"
   #include <map>
   ```

2. 定义 App ID 和 Token。

   在创建并初始化 `IRtcEngine` 对象时，你需要传入你的 Agora 项目的 App ID。详见[获取 App ID](./token?platform=All%20Platforms#a-name--appida使用-app-id-鉴权)。

   为提高项目的安全性，你需要使用 Token（动态密钥）对即将加入频道的用户进行鉴权。

   - 在测试阶段，你可以直接在控制台[生成临时 Token](./token?platform=All%20Platforms#get-a-temporary-token)。
   - 在生产环境，Agora 推荐你在自己的服务端生成 Token，详见[在服务端生成 Token](./token_server?platform=All%20Platforms)。

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
 // 定义 scheduleUpdate() 函数的执行目标。
 void update(float delta) override;
 ...
public:
 // 创建并初始化指定用户的视图。
 void addTextureRender(uid_t uid, int width, int height);
 // 删除指定用户的视图。
 void removeTextureRender(uid_t uid);
 // 删除所有用户的视图。
 void removeAllTextureRenders();
private:
 // 点击加入频道按钮的回调。
 void onJoinChannelClicked();
 // 点击离开频道按钮的回调。
 void onLeaveChannelClicked();
private:
 cocos2d::ui::EditBox *editBox;
 agora::rtc::IRtcEngine *engine;
 agora::rtc::IRtcEngineEventHandler *eventHandler;
 agora::cocos::VideoFrameObserver *videoFrameObserver;
 std::map<uid_t, bool> users;
};
```

### 2. 创建用户界面

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
  void onJoinChannelSuccess(const char *channel, uid_t uid,
                            int elapsed) override {
  }

  // 注册 onLeaveChannel 回调。
  // 本地用户成功离开频道时，会触发该回调。
  void onLeaveChannel(const agora::rtc::RtcStats &stats) override {
  }

  // 注册 onFirstRemoteVideoDecoded 回调。
  // SDK 接收到第一帧远端视频并成功解码时，会触发该回调。
  void onFirstRemoteVideoDecoded(uid_t uid, int width, int height,
                                 int elapsed) override {
  }

  // 注册 onUserOffline 回调。
  // 远端用户离开频道或掉线时，会触发该回调。
  void onUserOffline(uid_t uid,
                     agora::rtc::USER_OFFLINE_REASON_TYPE reason) override {
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

### 4. 加入频道

完成初始化后，你就可以调用 `joinChannel` 方法加入频道。

```c++
void HelloWorld::onJoinChannelClicked() {
  if (editBox == nullptr || strlen(editBox->getText()) == 0) {
    return;
  }
  // 传入你的 Token 和频道名，加入频道。
  // 将 uid 设为 0 表示由 SDK 自动分配一个 uid。
  engine->joinChannel(AGORA_TOKEN, editBox->getText(), "Cocos2d", 0);
}
```

<div class="alert note">用户成功加入频道后，会默认订阅频道内其他所有用户的音频流和视频流，因此产生用量并影响计费。如果想取消订阅，可以通过调用相应的 <code>mute</code> 方法实现。</div>

### 5. 获取原始视频数据并渲染

在 Cocos2d-x 项目中，你需要使用 Agora SDK 提供的原始视频数据功能，获取并缓存原始视频数据，然后将视频数据发送给 Cocos2d-x 引擎进行渲染，从而在视频通话中显示本地和远端用户的视图。

![](https://web-cdn.agora.io/docs-files/1607521137759)

#### 获取原始视频数据

你需要使用 Agora SDK 提供的 `IVideoFrameObserver` 类，获取并缓存原始视频数据。

1. 创建 `VideoFrameObserver.h` 文件，声明需要调用的方法。

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
   // 定义 CacheVideoFrame 类，用于缓存获取的原始视频数据。
   class CacheVideoFrame {
   public:
     void resetVideoFrame(media::IVideoFrameObserver::VideoFrame &videoFrame);

   public:
     int width;
     int height;
     uint8_t *data;
   };

   // 定义一个 IVideoFrameObserver 类，并注册该类的回调。
   class VideoFrameObserver : public media::IVideoFrameObserver {
   public:
     // 在 getVideoFormatPreference 回调的返回值中设置 SDK 输出的原始数据格式。
     VIDEO_FRAME_TYPE getVideoFormatPreference() override;
     // 在 getRotationApplied 回调的返回值中设置 SDK 输出视频数据时是否作旋转处理。
     bool getRotationApplied() override;
     // 通过 onCaptureVideoFrame 获取本地摄像头采集到的视频数据。
     bool onCaptureVideoFrame(VideoFrame &videoFrame) override;
     // 通过 onRenderVideoFrame 获取远端发送的视频数据。
     bool onRenderVideoFrame(unsigned int uid, VideoFrame &videoFrame) override;

   public:
     // 将用户 ID 和 textureId 关联。
     void bindTextureId(unsigned int textureId, unsigned int uid);

   private:
     // 缓存视频数据。
     void cacheVideoFrame(unsigned int uid,
                          media::IVideoFrameObserver::VideoFrame &videoFrame);
     // 将用户的视频帧绘制成一个 2D Texture。
     void renderTexture(unsigned int textureId, const CacheVideoFrame &frame);

   private:
     std::map<unsigned int, CacheVideoFrame> _map;
     std::mutex mtx;
   };
   } // namespace cocos
   } // namespace agora
   ```

2. 创建 `VideoFrameObserver.cpp` 文件， 实现一个 `IVideoFrameObserver` 类，获取并缓存 SDK 输出的原始视频数据。

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

   // 设置 SDK 输出的原始数据格式为 RGBA。
   media::IVideoFrameObserver::VIDEO_FRAME_TYPE
   VideoFrameObserver::getVideoFormatPreference() {
     return FRAME_TYPE_RGBA;
   }

   // 设置 SDK 输出视频数据时进行旋转处理。
   bool VideoFrameObserver::getRotationApplied() { return true; }

   // 获取并缓存本地摄像头采集到的视频数据。
   bool VideoFrameObserver::onCaptureVideoFrame(
       media::IVideoFrameObserver::VideoFrame &videoFrame) {
     cacheVideoFrame(0, videoFrame);
     return true;
   }

   // 获取并缓存远端发送的视频数据。
   bool VideoFrameObserver::onRenderVideoFrame(
       unsigned int uid, media::IVideoFrameObserver::VideoFrame &videoFrame) {
     cacheVideoFrame(uid, videoFrame);
     return true;
   }

   // 将 UID 和 textureId 绑定。
   // 如果指定的 UID 在 map 表里，则调用 renderTexture() 方法将该 UID 对应的视频帧绘制成 2D Texture，并与指定的 textureID 绑定。
   void VideoFrameObserver::bindTextureId(unsigned int textureId,
                                          unsigned int uid) {
     if (_map.find(uid) != _map.end()) {
       renderTexture(textureId, _map[uid]);
     }
   }

   // 缓存视频帧，并将视频帧和用户 ID 的映射关系记录在 map 表里。
   void VideoFrameObserver::cacheVideoFrame(
       unsigned int uid, media::IVideoFrameObserver::VideoFrame &videoFrame) {
     if (_map.find(uid) == _map.end()) {
       _map[uid] = CacheVideoFrame();
     }
     mtx.lock();
     _map[uid].resetVideoFrame(videoFrame);
     mtx.unlock();
   }

   // 将缓存的视频帧绘制成一个 2D Texture，并与 GL_TEXTURE_2D 纹理目标绑定。
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

#### 渲染视频数据

实现 `IVideoFrameObserver` 类后，你需要调用 Agora SDK 和 Cocos2d-x 引擎的方法，显示本地视图和远端视图。

在 `HelloWorldScene.cpp` 文件中添加如下代码：

1. 在 `onEnter` 回调中，调用 `registerVideoFrameObserver` 方法注册视频观测器。

   ```c++
   void HelloWorld::onEnter() {
     ...

     // 注册视频观测器。
     agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
     mediaEngine.queryInterface(engine, agora::AGORA_IID_MEDIA_ENGINE);
     if (mediaEngine) {
       videoFrameObserver = new agora::cocos::VideoFrameObserver;
       mediaEngine->registerVideoFrameObserver(videoFrameObserver);
     }
   }
   ```

2. 定义一个 `addTextureRender` 方法，创建并初始化用户视图。

   该方法根据指定的参数创建一个 2D Texture，并使用该 2D Texture 创建一个精灵对象，然后将该精灵对象添加到节点，从而在场景中显示图像。

   你可以调用该方法，初始化本地用户视图和远端用户视图，并添加到 `HelloWorld` 场景中。

   ```c++
   void HelloWorld::addTextureRender(uid_t uid, int width, int height) {
     Director::getInstance()->getScheduler()->performFunctionInCocosThread([=] {
       if (users.find(uid) == users.end()) {
         users[uid] = true;
       }
       // 创建一个 2D Texture 对象。
       auto texture = new cocos2d::Texture2D;
       MipmapInfo info;
       texture->initWithMipmaps(&info, 1, Texture2D::PixelFormat::RGBA4444,
                                width / 2, height / 2);
       // 使用 2D Texture 对象创建一个精灵对象。
       auto sprite = Sprite::createWithTexture(texture);
       if (sprite != nullptr) {
         auto visibleSize = Director::getInstance()->getVisibleSize();
         Vec2 origin = Director::getInstance()->getVisibleOrigin();

         // 设置精灵对象在场景中的位置。
         sprite->setPosition(Vec2(
             origin.x + visibleSize.width - sprite->getContentSize().width / 2,
             origin.y + visibleSize.height + sprite->getContentSize().height / 2 -
                 sprite->getContentSize().height * users.size()));

         // 将精灵对象作为子节点添加到场景中。
         this->addChild(sprite, 0, "uid:" + std::to_string(uid));
       }
     });
   }
   ```

3. 为使用户在通话前看到本地图像，你需要设置本地视图。参考以下步骤设置本地视图：

   - 调用 `enableVideo` 方法启用视频模块。
   - 调用 `addTextureRender` 方法设置本地视图。

   ```c++
   void HelloWorld::onJoinChannelClicked() {
     if (editBox == nullptr || strlen(editBox->getText()) == 0) {
       return;
     }
     // 启用视频模块。
     engine->enableVideo();
     ...
   }

   // 在onJoinChannelSuccess 回调中，调用 addTextureRender() 方法，设置本地视图。
   void onJoinChannelSuccess(const char *channel, uid_t uid,
                               int elapsed) override {

       mUi->addTextureRender(0, 640, 480);
     }
   ```

4. 视频通话中，通常你也需要看到其他用户。

   远端用户成功加入频道后，SDK 会触发 `onFirstRemoteVideoDecoded` 回调，该回调中会包含这个远端用户的 UID 信息。在该回调中调用 `addTextureRender` 方法，传入获取到的 UID 和视频数据，设置远端用户的视图。

   ```c++
   void onFirstRemoteVideoDecoded(uid_t uid, int width, int height,
                                 int elapsed) override {
    mUi->addTextureRender(uid, width, height);
    }
   ```

5. 每帧执行一次 `update()` 方法以显示连续的用户视频画面。

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

### 6. 离开频道

根据场景需要，调用 `leaveChannel` 离开当前频道。

```c++
void HelloWorld::onLeaveChannelClicked() { engine->leaveChannel(); }
```

离开频道后，如果你想释放 Cocos2d-x 引擎的内存，可以在 `onLeaveChannel` 回调中调用 `removeAllTextureRenders` 方法删除所有用户的视图。

```c++
void onLeaveChannel(const agora::rtc::RtcStats &stats) override {
    mUi->removeAllTextureRenders();
  }
```

### 7. 释放 IRtcEngine

如果你想在退出 HelloWorld 场景时释放 Agora 引擎的内存，需调用 `release` 方法销毁 Agora 引擎。

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

## 运行项目

1. 使用 Xcode 打开 `Cocos2d-x/proj.ios_mac/Hello-Cocos2d-Agora.xcodeproj` 文件。
2. 通过 USB 线将 iOS 设备接入你的电脑。
3. 在 Xcode 中，点击 **Build and run** 按钮。

当成功开始视频通话时，你可以同时看到本地和远端的视图。
