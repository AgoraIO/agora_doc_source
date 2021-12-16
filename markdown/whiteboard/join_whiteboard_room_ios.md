---
title: 加入实时房间
platform: iOS
updatedAt: 2021-03-31 09:04:35
---
本文详细介绍如何建立一个简单的项目并使用 Agora 互动白板 SDK 实现基础的白板功能。

## 前提条件

- Xcode 10.10+
- iOS 9.0+
- CocoaPods [最新版本](https://cocoapods.org/)。
- 有效的 Agora [开发者账号](https://docs.agora.io/cn/Agora Platform/sign_in_and_sign_up)。
- 已在 Agora 控制台[开启互动白板服务](https://confluence.agoralab.co/pages/viewpage.action?pageId=724799345#id-5.6开启并配置白板服务-开通互动白板服务)并获取项目的 [App Identifer](https://confluence.agoralab.co/pages/viewpage.action?pageId=724799345#id-5.6开启并配置白板服务-获取AppIdentifier) 和 [SDK Token](https://confluence.agoralab.co/pages/viewpage.action?pageId=724799345#id-5.6开启并配置白板服务-获取SDKToken)。

## 创建 Xcode 项目

在 Xcode 中创建一个 Single View App。项目设置如下：

- **Product Name** 设为 `Whiteboard`。
- **Organization Identifier** 设为 `agora`。
- **Language** 选择 `Objective-C`。

## 获取 SDK

1. 在 Terminal 里进入项目所在路径。运行以下命令创建 `Podfile` 文件。项目路径下会出现一个 `Podfile` 文本文件。

   `pod init`

2. 在生成的 `Podfile` 文件中添加如下内容。

   `platform :ios, ``'9.0'` `target ``'Whiteboard'` `do``  ``pod ``'Whiteboard'``end`

3. 运行以下命令安装 SDK。

   `pod install`

   安装完成后，你可以点击打开项目的 `Whiteboard.xcworkspace` 文件，对项目进行后续编辑。

   > 对于中国大陆用户，如果在执行 pod install 命令时由于网络原因失败，可以使用 [TUNA 镜像源](https://mirrors.tuna.tsinghua.edu.cn/help/CocoaPods/)。

## 基本流程

现在，我们已经将 Agora 互动白板 SDK 集成到项目中了。接下来我们要调用 Agora 互动白板 SDK 提供的核心 API 实现基础的白板功能。


### 1. 创建房间

在 app 客户端加入互动白板房间前，你需要在 app 服务端调用互动白板服务端 RESTful API 创建一个房间。详见[创建房间（POST） ](https://confluence.agoralab.co/pages/viewpage.action?pageId=711052694#id-4.1互动白板服务端RESTfulAPI-房间管理)。

**请求示例**

你可以使用以下 Node.js 脚本发送请求：

> 使用 Node.js 发送 HTTP 请求前安装 `request` 模块。你可以运行 `npm install request` 安装。

```
var request = require("request");
var options = {
  "method": "POST",
  "url": "https://api.netless.link/v5/rooms",
  "headers": {
    "token": "你的 SDK Token",
    "Content-Type": "application/json"
  }
};
request(options, function (error, response) {
  if (error) throw new Error(error);
  console.log(response.body);
});
```

如果方法调用成功，Agora 互动白板服务端将返回新建房间的信息，其中的 `uuid` 是房间的唯一标识，app 客户端加入房间时需要传入该参数。

**响应示例**

```
{
    "uuid": "4a50xxxxxx796b",
    "name": "",
    "teamUUID": "RMmLxxxxxx15aw",
    "appUUID": "i54xxxxxx1AQ",
    "isRecord": true,
    "isBan": false,
    "createdAt": "2021-01-18T06:56:29.432Z",
    "limit": 0
}
```

###  2. 生成 Room Token

创建房间并获取新建房间的 `uuid` 后，你需要在 app 服务端生成 `Room Token` 并下发给 app 客户端。当 app 客户端加入房间时，Agora 互动白板服务端会使用该 Token 对其鉴权。

你可以通过以下方式在 app 服务端生成 `Room Token`：

- 使用代码生成 `Room Token`，详见[服务端生成 Token](https://confluence.agoralab.co/pages/viewpage.action?pageId=713688237)。（推荐）
- 调用互动白板服务端 RESTful API 生成 Room Token，详见[生成 Room Token（POST）](https://confluence.agoralab.co/pages/viewpage.action?pageId=711052694#id-4.1互动白板服务端RESTfulAPI-生成RoomToken（POST）postroomtken)。

下面以调用 RESTful API 的方式为例介绍如何生成 `Room Token`。

**请求示例**

你可以使用以下 Node.js 脚本发送请求：

> 使用 Node.js 发送 HTTP 请求前安装 `request` 模块。你可以运行 `npm install request` 安装。

```
var request = require('request');
var options = {
  "method": "POST",
  "url": "https://api.netless.link/v5/tokens/rooms/4a50xxxxxx796b",
  "headers": {
    "token": "你的 SDK Token",
    "Content-Type": "application/json"
  },
  body: JSON.stringify({"lifespan":60,"role":"admin"})
  
};
request(options, function (error, response) {
  if (error) throw new Error(error);
  console.log(response.body);
});
如果方法调用成功
```

如果方法调用成功，Agora 互动白板服务端将返回生成的 `Room Token`。

**响应示例**

```
"NETLESSROOM_YWs9XXXXXXXXXXXZWNhNjk"
```


### 3. 初始化 SDK 并加入房间

编辑 `ViewController.m`，实现从添加 View、初始化 SDK 到加入房间的基本操作。你需要传入之前生成的 `App Identifier`、`uuid` 和 `Room token`。

```
//
//  ViewController.m
//  WhiteBoard
//
//  Created by macoscatalina on 2021/3/16.
//  Copyright © 2021 macoscatalina. All rights reserved.
//
 
 
#import "ViewController.h"
#import <Whiteboard/Whiteboard.h>
 
@interface ViewController ()
@property (nonatomic, strong) WKWebViewConfiguration *config;
@property (nonatomic, strong) WhiteBoardView *boardView;
@property (nonatomic, strong) WhiteSDK *sdk;
@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, strong) WhiteMemberState *memberState;
@property (nonatomic, strong) WhiteRoomConfig *roomConfig;
@property (nonatomic, strong) WhiteSdkConfiguration *sdkConfig;
 
@property (nonatomic, weak, nullable) id<WhiteCommonCallbackDelegate> commonDelegate;
@property (nonatomic, weak, nullable) id<WhiteRoomCallbackDelegate> roomCallbackDelegate;
@end
 
@implementation ViewController
 
// 添加 View
- (void)setupViews
 
{
    self.config = [[WKWebViewConfiguration alloc] init];
    // 在此项目中将白板 View 设为全屏
    self.boardView = [[WhiteBoardView alloc] initWithFrame:(CGRectMake(0.0f,0.0f,self.view.bounds.size.width,self.view.bounds.size.height)) configuration:(self.config)];
    [self.view addSubview:(self.boardView)];
     
}
// 初始化 SDK
- (void)initSDK
{   // 设置 App Identifier
    self.sdkConfig = [[WhiteSdkConfiguration alloc] initWithApp:@"Your App ID"];
    // 初始化 SDK
    self.sdk = [[WhiteSDK alloc] initWithWhiteBoardView:self.boardView config:self.sdkConfig commonCallbackDelegate:self.commonDelegate];
}
// 加入房间
- (void)joinRoom
{   // 设置 uuid 和 room token
    self.roomConfig = [[WhiteRoomConfig alloc] initWithUuid:@"Your UUID" roomToken:@"Your room token"];
    // 设置教具
    self.memberState = [[WhiteMemberState alloc] init];
    self.memberState.currentApplianceName = AppliancePencil;
    self.memberState.strokeColor = @[@255, @0, @0];
    // 加入房间
    [self.sdk joinRoomWithConfig:self.roomConfig callbacks:self.roomCallbackDelegate completionHandler:^(BOOL success, WhiteRoom * _Nonnull room, NSError * _Nonnull error) {
           if (success) {
               self.room = room;
               [self.room cleanScene:(NO)];
               [self.room setMemberState:(self.memberState)];
               NSLog(@"Successfully joined the room");
                
           } else {
               NSLog(@"Errors when joining room");
           }
       }];
     
}
// 在 viewDidLoad 方法中依次进行 View 添加，SDK 初始化，加入房间操作
- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupViews];
    [self initSDK];
    [self joinRoom];
    }
 
 
@end
```

## 编译并运行项目

在 Xcode 中编译并在模拟器或真机上运行项目。如果应用成功运行，你可以用鼠标在生成的页面上写写画画并看到笔迹。