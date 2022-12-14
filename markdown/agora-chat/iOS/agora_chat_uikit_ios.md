# 即时通讯 IM UIKit 快速开始

即时通讯将各地人们连接在一起，实现实时通信。[即时通讯 IM UIKit](https://github.com/AgoraIO-Usecase/AgoraChat-UIKit-ios) 内置了用户界面（UI）提供会话列表和联系人列表，使你可将实时通讯嵌入到你的应用程序，而无需在 UI 上进行额外操作。

本页通过示例代码介绍如何利用 iOS 版本的即时通讯 IM UIKit 将单聊消息发送和接收的逻辑添加到你的应用程序中。

## 技术原理

下图显示了客户如何发送和接收单聊消息的工作流程：

![img](https://web-cdn.agora.io/docs-files/1643335864426)

1. 客户端从你的应用服务器获取 token。
2. 客户 A 和客户 B 登录即时通讯 IM。
3. 客户端 A 向客户端 B 发送消息，消息被发送到即时通讯 IM 服务器，服务器将消息传递给客户端 B。客户端 B 收到消息后，SDK 触发事件。客户端 B 监听事件并获取消息。

## 前提条件

- Xcode，最好是最新版本；
- iOS 11 及以上版本；
- 有效的 [Agora 账号](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#%E5%88%9B%E5%BB%BA-agora-%E8%B4%A6%E5%8F%B7);
- 安装 CocoaPods 工具。详见 [CocoaPods 安装指南](https://guides.cocoapods.org/using/getting-started.html#getting-started)。

## 操作步骤

### 1.创建 chat-uikit 项目

参考以下步骤在 Xcode 中创建一个 iOS 平台下的 Single View App，项目设置如下：

1. `Product Name` 设为 `chatuikitquickstart`。
2. `Organization Identifier` 设为 `agorachat`。
3. `User Interface` 选择 `Storyboard`。
4. `Language` 选择 `Objective-C`。

### 2.集成 chat-uikit

选择以下任意一种方式将 `chat-uikit` 集成到你的项目中。本文使用方式 1 进行集成。

#### 方式 1：使用 pod 方式集成 chat-uikit

1. 开始前确保你已安装 Cocoapods。参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。
2. 在终端里进入项目根目录，并运行 `pod init` 命令。项目文件夹下会生成 `Podfile` 文本文件。
3. 打开 `Podfile` 文件，在 `podfile` 文件里添加相关 SDK。注意将 `chatuikitquickstart` 替换为你的 Target 名称。

```objective-c
platform :ios, '11.0'

# Import CocoaPods sources
source 'https://github.com/CocoaPods/Specs.git'

target 'chatuikitquickstart' do
    pod 'chat-uikit'
  	pod 'Masonry'
end
```

4. 在终端 Terminal cd 到 `podfile` 文件所在目录，执行如下命令集成 SDK。

```objective-c
pod install
```

5. 成功安装后，终端中会显示 `Pod installation complete!`，此时项目文件夹下会生成 `xcworkspace` 文件，打开新生成的 `xcworkspace` 文件运行项目。

#### 方式 2：源码集成 chat-uikit

1. 从 [源码仓库](https://github.com/AgoraIO-Usecase/AgoraChat-UIKit-ios.git) 下载最新版的 `chat-uikit` 源码；

2. 在项目的 `Podfile` 文件中添加 `chat-uikit` 依赖，路径指向 `chat-uikit.podspec` 文件所在目录；

   ```objective-c
   pod 'chat-uikit',  :path => "../AgoraChat-UIKit-ios"
   ```

path 指向本地 `chat-uikit.podspec` 文件所在目录。

3. 在终端 Terminal cd 到 `podfile` 文件所在目录，执行如下命令本地集成 `chat-uikit` 源码。

   ```objective-c
   pod install
   ```

   现在，项目中成功添加了即时通讯 IM Uikit。

### 3.添加权限

在项目 `info.plist` 中添加相关权限：

```xml
Privacy - Photo Library Usage Description //相册权限。
Privacy - Microphone Usage Description //麦克风权限。
Privacy - Camera Usage Description //相机权限。
App Transport Security Settings -> Allow Arbitrary Loads //开启网络服务。
```

### 4.实现聊天界面

为了帮助你快速实现并理解相关功能，本文通过最简方式，在项目的聊天页面 `ChatViewController` 里集成 `chat-uikit` 的聊天页面，并实现如下功能：

- 自动加载并展示历史消息；
- 会话页面接收消息并展示；
- 发送文本消息、图片消息、文件消息、视频消息和语音消息等。

#### 4.1 初始化 UIKIT

在项目的 `SceneDelegate.m` 文件里添加如下相关代码初始化 `chat-uikit` 的相关功能：

```objective-c
//导入头文件。
#import <chat-uikit/EaseChatKit.h>
#import "AgoraLoginViewController.h" //登录页面。
#import <AgoraChat/AgoraChat.h> //即时通讯 IM SDK。
```

在本示例中，你可以使用默认 App Key（41117440#383391）进行体验，正式开发环境需注册和使用你的 [App Key](https://docs.agora.io/cn/AgoraPlatform/sign_in_and_sign_up)。

```objective-c
//chat-uikit 初始化。
- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // 使用此方法可选择配置 UIWindow `window` 并将其附加到提供的 UIWindowScene `scene`。
    // 如果使用 storyboard，`window` 属性将自动初始化并附加到场景中。
    // 该代理不一定代表连接场景或会话是新的 (请参阅 `application:configurationForConnectingSceneSession`)。

    AgoraChatOptions *options = [AgoraChatOptions optionsWithAppkey:@"41117440#383391"];
    options.enableConsoleLog = YES;
    options.usingHttpsOnly = YES;
    options.enableDeliveryAck = YES;
    options.isAutoLogin = NO;
  	//初始化 chat-uikit。
    [EaseChatKitManager initWithAgoraChatOptions:options];

    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    self.window.frame = windowScene.coordinateSpace.bounds;
    //登录页面。
    self.window.rootViewController = [[AgoraLoginViewController alloc]init];
    [self.window makeKeyAndVisible];
}
```

#### 4.2 登录即时通讯 IM SDK

加载会话页面之前须先登录到即时通讯 IM SDK。登录页面实现可自行实现或参考 `chatuikitquickstart` 工程 -> `AgoraLoginViewController.m` 文件登录页面实现。

`chatuikitquickstart` 工程地址：[quickStart](https://github.com/easemob/chat-api-examples/tree/main/Chat-iOS)

若自行实现登录逻辑，请参考如下步骤：

1. 项目中创建名为 `AgoraChatHttpRequest` 的 `Cocoa Touch Class` 文件

2. 在 `AgoraChatHttpRequest.h` 文件中添加方法定义（需复制全部内容）：[AgoraChatHttpRequest.h](https://github.com/easemob/chat-api-examples/blob/main/Chat-iOS/chatuikitquickstart/chatuikitquickstart/AgoraChatHttpRequest.h)

3. 在 `AgoraChatHttpRequest.m` 文件中添加方法实现（需复制全部内容）：[AgoraChatHttpRequest.m](https://github.com/easemob/chat-api-examples/blob/main/Chat-iOS/chatuikitquickstart/chatuikitquickstart/AgoraChatHttpRequest.m)

4. 项目中创建名为 `AgoraLoginViewController` 的 `Cocoa Touch Class` 文件，然后在 `AgoraLoginViewController.m` 文件中导入请求 AppServer 的头文件 ：

   ```objective-c
   #import "AgoraChatHttpRequest.h" //请求 Appserver 的工具类。
   #import <AgoraChat/AgoraChat.h> //即时通讯 IM SDK。
   ```

5. 在 `AgoraLoginViewController.m` 文件中按需调用如下注册代码逻辑进行注册：

   ```objective-c
   //注册到 AppServer。
   - (void)doSignUp {
   [[AgoraChatHttpRequest sharedManager] registerToApperServer:@"Register ID" pwd:@"Register Password" completion:^(NSInteger statusCode, NSString * _Nonnull response) {
           dispatch_async(dispatch_get_main_queue(),^{
               if (response != nil) {
                   NSData *responseData = [response dataUsingEncoding:NSUTF8StringEncoding];
                   NSDictionary *responsedict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                   if (responsedict != nil) {
                       NSString *result = [responsedict objectForKey:@"code"];
                       if ([result isEqualToString:@"RES_OK"]) {
                           //注册成功，可进行登录。
                       }
                   }
               }
           });
       }];
   }
   ```

6. 在 `AgoraLoginViewController.m` 文件中按需调用如下登录代码逻辑进行登录，登录成功后可跳转到会话页面 `ViewController`，关于 `ViewController` 会话页面逻辑，请参见 <a href="#jump">4.3 加载会话页面</a>

   导入会话页面头文件：

   ```objective-c
   #import "ViewController.h"
   ```

   登录逻辑：

   ```objective-c
   - (void)doSignIn {
       //登录 AppServer。
   [[AgoraChatHttpRequest sharedManager] loginToApperServer:@"ID" pwd:@"Password" completion:^(NSInteger statusCode, NSString * _Nonnull response) {
           dispatch_async(dispatch_get_main_queue(), ^{
               if (response && response.length > 0 && statusCode) {
                   NSData *responseData = [response dataUsingEncoding:NSUTF8StringEncoding];
                   NSDictionary *responsedict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                   NSString *token = [responsedict objectForKey:@"accessToken"];
                   NSString *loginName = [responsedict objectForKey:@"chatUserName"];
                   if (token && token.length > 0) {
                       // 登录即时通讯 IM SDK。
                       [[AgoraChatClient sharedClient] loginWithUsername:[loginName lowercaseString] agoraToken:token completion:^(NSString *aUsername, AgoraChatError *aError) {
                           if (!aError) {
                             //登录即时通讯 IM SDK Success，跳转到会话页面 ViewController。
                             ViewController *chatsVC = [[ViewController alloc] init];
       											chatsVC.modalPresentationStyle = 0;
       											[self.navigationController pushViewController:chatsVC animated:YES];
                           }
                       }];
                   }
               }
       		});
       }];
   }
   ```

#### <span id="jump"> 4.3 加载会话页面</span>

以下为 `ViewController.m` 文件的属性定义：

```objective-c
#define kIsBangsScreen ({\
    BOOL isBangsScreen = NO; \
    if (@available(iOS 11.0, *)) { \
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject]; \
    isBangsScreen = window.safeAreaInsets.bottom > 0; \
    } \
    isBangsScreen; \
})

#define AgoraChatVIEWTOPMARGIN (kIsBangsScreen ? 34.f : 0.f)

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import <AgoraChat/AgoraChat.h>
#import <chat-uikit/EaseChatKit.h>

@interface ViewController ()<EaseChatViewControllerDelegate, UITextFieldDelegate>
@property (nonatomic, strong) EaseConversationModel *conversationModel;
@property (nonatomic, strong) AgoraChatConversation *conversation;
@property (nonatomic, strong) EaseChatViewController *chatController;
@property (nonatomic, strong) UITextField *conversationIdField;
@property (nonatomic, strong) UIButton *chatBtn;
@property (nonatomic, strong) UIButton *logoutBtn;

@end
```

在 `ViewController.m` 的 `viewDidLoad` 方法里加载页面元素：

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupChatSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)_setupChatSubviews
{
    self.conversationIdField = [[UITextField alloc] init];
    self.conversationIdField.backgroundColor = [UIColor systemGrayColor];
    self.conversationIdField.delegate = self;
    self.conversationIdField.borderStyle = UITextBorderStyleNone;
    NSAttributedString *convAttrStr = [[NSAttributedString alloc] initWithString:@"single chat ID" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.conversationIdField.attributedPlaceholder = convAttrStr;
    self.conversationIdField.font = [UIFont systemFontOfSize:17];
    self.conversationIdField.textColor = [UIColor whiteColor];
    self.conversationIdField.returnKeyType = UIReturnKeyDone;
    self.conversationIdField.layer.cornerRadius = 5;
    self.conversationIdField.layer.borderWidth = 1;
    self.conversationIdField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:self.conversationIdField];
    [self.conversationIdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.top.equalTo(self.view).offset(30 + AgoraChatVIEWTOPMARGIN);
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(@320);
    }];

    self.chatBtn = [[UIButton alloc] init];
    self.chatBtn.clipsToBounds = YES;
    self.chatBtn.layer.cornerRadius = 5;
    self.chatBtn.backgroundColor = [UIColor colorWithRed:((float) 78 / 255.0f) green:0 blue:((float) 234 / 255.0f) alpha:1];
    self.chatBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.chatBtn setTitle:@"chat" forState:UIControlStateNormal];
    [self.chatBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.chatBtn addTarget:self action:@selector(chatAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chatBtn];
    [self.chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.top.equalTo(self.conversationIdField.mas_bottom).offset(20);
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(@150);
    }];

    self.logoutBtn = [[UIButton alloc]init];
    self.logoutBtn.backgroundColor = [UIColor redColor];
    [self.logoutBtn setTitle:@"Log out" forState:UIControlStateNormal];
    [self.logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logoutBtn];
    [self.logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@50);
    }];

    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
}
```

在会话页面 `ViewController.m` 的输入框输入会话 ID，点击 `Chat` 按钮显示 `EaseChatViewController` 会话页面：

```objective-c
- (void)chatAction
{
    [self.view endEditing:YES];
    if (self.conversationIdField.text.length <= 0) {
        self.conversationIdField.placeholder = @"input single chat ID !";
        return;
    }

    [_chatController.view removeFromSuperview];
    [self.view endEditing:YES];

    if (!AgoraChatClient.sharedClient.isLoggedIn) {
        return;
    }

    _conversation = [AgoraChatClient.sharedClient.chatManager getConversation:self.conversationIdField.text type:AgoraChatConversationTypeChat createIfNotExist:YES];
    _conversationModel = [[EaseConversationModel alloc]initWithConversation:_conversation];

    EaseChatViewModel *viewModel = [[EaseChatViewModel alloc]init];
    _chatController = [EaseChatViewController initWithConversationId:self.conversationIdField.text
                                                conversationType:AgoraChatConversationTypeChat
                                                    chatViewModel:viewModel];

    _chatController.view.layer.borderWidth = 1;
    _chatController.view.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:_chatController.view];
    [_chatController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chatBtn.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.logoutBtn.mas_top);
    }];
}
```

会话页面 `ViewController.m` 的 `==Log out==` 按钮可退出到登录页面更换登录 ID：

```objective-c
- (void)logout
{
    [AgoraChatClient.sharedClient logout:YES completion:^(AgoraChatError *aError) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginStateChange" object:@NO];
    }];
}
```

### 5.编译并运行项目

使用 Xcode 在模拟器或真机上编译并运行项目。运行成功之后，你可以进行以下操作：

- 会话页面展示历史消息；
- 会话页面接收消息并展示；
- 会话页面发送消息，包含文本，图片，视频，附件，相机，语音和表情等消息。

### 6.运行 `chatuikitquickstart` 项目

`chatuikitquickstart` 是对 UIKIT 的简单集成示例，只包含 UIKIT 的会话页面。

从 [chatuikitquickstart 代码下载地址](https://github.com/easemob/chat-api-examples/tree/main/Chat-iOS) 下载代码。

运行 `chatuikitquickstart`：

1. 在终端 Terminal cd 到 `Chat-iOS` 目录，执行如下命令集成 SDK。

   ```objective-c
   pod install
   ```

2. 成功安装后，终端中会显示 `Pod installation complete!`，打开 `Chat-iOS.xcworkspace` 文件即可选择运行 `chatuikitquickstart` 项目。

### 7.自定义 UI 配置

chat-uikit 使用默认 UI 样式，以下是对 `chat-uikit` 的样式进行自定义配置示例：

- 默认样式示例：

只需创建 `EaseChatViewModel` 实例，并作为参数传入聊天页面 `EaseChatViewController` 的构造方法。

```objective-c
EaseChatViewModel *viewModel = [[EaseChatViewModel alloc]init]; //默认样式。
EaseChatViewController *chatController = [EaseChatViewController initWithConversationId:@"会话 ID" conversationType:AgoraChatConversationTypeChat chatViewModel:viewModel];
```

- 默认样式的聊天页面示例图：

![defaultStyle](https://github.com/easemob/chat-api-examples/blob/main/Chat-iOS/chatuikitquickstart/defaultStyle.jpeg)

- 自定义样式配置示例：

创建 `EaseChatViewModel` 实例，修改该实例的可配置样式参数，将实例传入聊天页面 `EaseChatViewController` 的构造方法。

```objective-c
EaseChatViewModel *viewModel = [[EaseChatViewModel alloc]init];
viewModel.chatViewBgColor = [UIColor systemGrayColor];  //聊天页面的背景颜色。
viewModel.inputMenuBgColor = [UIColor systemPinkColor]; //输入区的背景色。
viewModel.sentFontColor = [UIColor redColor];           //发送方的文本颜色。
viewModel.inputMenuStyle = EaseInputMenuStyleNoAudio;   //输入区的菜单样式。
viewModel.msgTimeItemFontColor = [UIColor blackColor];  //消息时间的字体颜色。
viewModel.msgTimeItemBgColor = [UIColor greenColor];    //消息时间区域的背景色。
EaseChatViewController *chatController = [EaseChatViewController initWithConversationId:@"会话 ID" conversationType:AgoraChatConversationTypeChat chatViewModel:viewModel];
```

部分自定义样式配置示例图：

![customStyle](https://github.com/easemob/chat-api-examples/blob/main/Chat-iOS/chatuikitquickstart/customStyle.jpeg)

关于更多 API 介绍请参考 `EaseChatViewController` 提供的 API，以及 `EaseChatViewControllerDelegate` 协议中的回调方法 API。