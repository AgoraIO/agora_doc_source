# 即时通讯 IM UIKit 快速开始

即时通讯将各地人们连接在一起，实现实时通信。[即时通讯 IM UIKit](https://github.com/AgoraIO-Usecase/AgoraChat-UIKit-ios) 内置了用户界面（UI）提供会话列表和联系人列表，使你可将实时通讯嵌入到你的应用程序，而无需在 UI 上进行额外操作。

本页通过示例代码介绍如何利用 iOS 版本的即时通讯 IM UIKit 将单聊消息发送和接收的逻辑添加到你的应用程序中。

## 技术原理

~7aac3300-785d-11ec-bcb4-b56a01c83d2e~

## 前提条件

- Xcode，推荐最新版本。
- 运行 iOS 11.0 及以上版本的设备或模拟器。
- 有效的[声网账号](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#%E5%88%9B%E5%BB%BA-agora-%E8%B4%A6%E5%8F%B7);
- [开启了即时通讯 IM 服务](./enable_agora_chat)。
- 安装 CocoaPods 工具。详见 [CocoaPods 安装指南](https://guides.cocoapods.org/using/getting-started.html#getting-started)。

## 项目设置

 参考以下步骤在你的应用中搭建 Chat UIKit 集成环境：

1. [创建项目](https://help.apple.com/xcode/mac/current/#/dev07db0e578)，将 **Interface** 设置为 **Storyboard**。

   若添加团队信息，单击 **Add account...** 按钮，输入你的 App ID，然后单击 **Next**。

2. [开启自动签名](https://help.apple.com/xcode/mac/current/#/dev23aab79b4)。

3. [设置部署你的 iOS 应用的目标设备](https://help.apple.com/xcode/mac/current/#/deve69552ee5)。

4. 添加麦克风和相机使用权限。

   在项目导航窗格中打开 **info**，在 [Property List](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6) 中添加以下属性:

   | 键      | 类型   | 值         |
   | :----------- | :----- | :------- |
   | `Privacy - Photo Library Usage Description`               | String  | 相册权限。 |
   | `Privacy - Microphone Usage Description`                  | String  | 麦克风权限。|
   | `Privacy - Camera Usage Description`                      | String  | 相机权限。|

5. 在项目中集成 Chat UIKit。

   i. 创建 `Podfile` 文件。

      在 Terminal 中打开项目根目录，运行以下命令。项目文件夹下会生成 `Podfile` 文本文件。

      ```shell
      pod init
      ```

   ii. 在 `Podfile` 文件中添加 Chat UIKit 的依赖。

       打开 `Podfile` 文件，将文件中的内容替换为以下内容：

      ```shell
      platform :ios, '11.0'
      target 'EaseChatKitExample' do

      # Pods for EaseChatKitExample
      pod 'chat-uikit'
      pod 'Masonry'

      end
      ```

6. 安装 Chat UIKit。

   在 Terminal 中，打开你的项目的根目录，运行以下命令：

   ```shell
       pod install
   ```

现在，Chat UIKit 添加到了你的项目中。

## 实现单聊

本节介绍如何使用 Chat UIKit 在你的应用中快速实现单聊。

### 初始化 Chat UIKit 

参考以下步骤初始化 Chat UIKit：

1. 在 **Xcode** 中打开 `SceneDelegate.m`，将下列代码导入请求头文件：

   ```objective-c
    #import <chat-uikit/EaseChatKit.h>
    #import "AgoraLoginViewController.h"
    #import <AgoraChat/AgoraChat.h>
    ```

2. 调用 `initWithAgoraChatOptions` 方法，初始化 Chat UIKit。在 `SceneDelegate.m` 中，用下列代码替换 `willConnectToSession` 方法：

   ```objective-c
    - (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
        //（可选）利用该方法配置 UIWindow `window` 并将其附加到提供的 UIWindowScene `scene` 中。
        // 若使用故事板，`window` 属性会自动初始化并附加到场景中。
        // 该代理并不表示新的连接场景或会话（参考 `application:configurationForConnectingSceneSession`）。   
        AgoraChatOptions *options = [AgoraChatOptions optionsWithAppkey:@"41117440#383391"];
        options.enableConsoleLog = YES;
        options.usingHttpsOnly = YES;
        options.enableDeliveryAck = YES;
        options.isAutoLogin = NO;
        // 初始化即时通讯 UIKit。
        [EaseChatKitManager initWithAgoraChatOptions:options];
        
        UIWindowScene *windowScene = (UIWindowScene *)scene;
        self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
        self.window.frame = windowScene.coordinateSpace.bounds;
        // 打开登录视图。
        self.window.rootViewController = [[AgoraLoginViewController alloc]init];
            [self.window makeKeyAndVisible];
    }
    ```

### 登录即时通讯 IM

参考以下步骤登录即时通讯 IM：

1. 在 **Xcode** 中，选择 **File** > **New** > **File**，创建名为 `AgoraChatHttpRequest` 的 **Cocoa Touch Class** 文件，将 **Subclass of** 设置为 `NSObject`，将文件保存在 **AgoraChatUIKit** 中。

   ![1643335917066](https://web-cdn.agora.io/docs-files/1643335917066)

2. 打开 `AgoraChatHttpRequest.h`，将文件中的代码替换为以下代码：

  ```objective-c
    #import <Foundation/Foundation.h>

    NS_ASSUME_NONNULL_BEGIN

    @interface AgoraChatHttpRequest : NSObject

    + (instancetype)sharedManager;

    - (void)registerToApperServer:(NSString *)uName
                            pwd:(NSString *)pwd
                    completion:(void (^)(NSInteger statusCode, NSString *response))aCompletionBlock;

    - (void)loginToApperServer:(NSString *)uName
                        pwd:(NSString *)pwd
                    completion:(void (^)(NSInteger statusCode, NSString *response))aCompletionBlock;

    @end

    NS_ASSUME_NONNULL_END
    ```

   在即时通讯 app 服务器上注册：打开 `AgoraChatHttpRequest.m`，将文件中的代码替换为以下代码：

   ```objective-c
    #import "AgoraChatHttpRequest.h"

    @interface AgoraChatHttpRequest() <NSURLSessionDelegate>
    @property (readonly, nonatomic, strong) NSURLSession *session;
    @end
    @implementation AgoraChatHttpRequest

    + (instancetype)sharedManager
    {
        static dispatch_once_t onceToken;
        static AgoraChatHttpRequest *sharedInstance;
        dispatch_once(&onceToken, ^{
            sharedInstance = [[AgoraChatHttpRequest alloc] init];
        });

        return sharedInstance;
    }

    - (instancetype)init
    {
        if (self = [super init]) {
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            configuration.timeoutIntervalForRequest = 120;
            _session = [NSURLSession sessionWithConfiguration:configuration
                                                    delegate:self
                                                delegateQueue:[NSOperationQueue mainQueue]];
        }
        return self;
    }

    - (void)registerToApperServer:(NSString *)uName
                            pwd:(NSString *)pwd
                    completion:(void (^)(NSInteger statusCode, NSString *aUsername))aCompletionBlock
    {
        NSURL *url = [NSURL URLWithString:@"https://a41.chat.agora.io/app/chat/user/register"];
        NSMutableURLRequest *request = [NSMutableURLRequest
                                                    requestWithURL:url];
        request.HTTPMethod = @"POST";

        NSMutableDictionary *headerDict = [[NSMutableDictionary alloc]init];
        [headerDict setObject:@"application/json" forKey:@"Content-Type"];
        request.allHTTPHeaderFields = headerDict;

        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:uName forKey:@"userAccount"];
        [dict setObject:pwd forKey:@"userPassword"];
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSString *responseData = data ? [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] : nil;
            if (aCompletionBlock) {
                aCompletionBlock(((NSHTTPURLResponse*)response).statusCode, responseData);
            }
        }];
        [task resume];
    }

    - (void)loginToApperServer:(NSString *)uName
                        pwd:(NSString *)pwd
                    completion:(void (^)(NSInteger statusCode, NSString *response))aCompletionBlock
    {
        NSURL *url = [NSURL URLWithString:@"https://a41.chat.agora.io/app/chat/user/login"];
        NSMutableURLRequest *request = [NSMutableURLRequest
                                                    requestWithURL:url];
        request.HTTPMethod = @"POST";

        NSMutableDictionary *headerDict = [[NSMutableDictionary alloc]init];
        [headerDict setObject:@"application/json" forKey:@"Content-Type"];
        request.allHTTPHeaderFields = headerDict;

        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:uName forKey:@"userAccount"];
        [dict setObject:pwd forKey:@"userPassword"];
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSString *responseData = data ? [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] : nil;
            if (aCompletionBlock) {
                aCompletionBlock(((NSHTTPURLResponse*)response).statusCode, responseData);
            }
        }];
        [task resume];
    }

    - (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler
    {
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
                NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                if(completionHandler)
                    completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
            }
    }

    @end
    ```

3. 选择 **File** > **New** > **File**，创建名为 `AgoraLoginViewController` 的 **Cocoa Touch Class** 文件，将 **Subclass of** 设置为 `UIViewController`。

4. 打开 `AgoraLoginViewController.m`，添加以下代码，导入头文件。

    ```objective-c
    #import "AgoraChatHttpRequest.h" // 将请求发送到 App Server
    #import <AgoraChat/AgoraChat.h> //即时通讯服务 SDK
    #import "ViewController.h"
    ```

   在 `@implementation AgoraLoginViewController` 中添加以下代码登录即时通讯服务：

    ```objective-c
    // 在 App Server 上注册。
    - (void)doSignUp {
    // 将即时通讯服务的用户 ID 设置为 vvv。
    [[AgoraChatHttpRequest sharedManager] registerToApperServer:@"vvv" pwd:@"1" completion:^(NSInteger statusCode, NSString * _Nonnull response) {
            dispatch_async(dispatch_get_main_queue(),^{
                if (response != nil) {
                    NSData *responseData = [response dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary *responsedict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                    if (responsedict != nil) {
                        NSString *result = [responsedict objectForKey:@"code"];
                        if ([result isEqualToString:@"RES_OK"]) {
                            // 若注册成功，登录即时通讯服务。
                            [self doSignIn];
                        }
                    }
                }
            });
        }];
    }

    - (void)doSignIn {
    // Sign in AppServer
    [[AgoraChatHttpRequest sharedManager] loginToApperServer:@"vvv" pwd:@"1" completion:^(NSInteger statusCode, NSString * _Nonnull response) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (response && response.length > 0 && statusCode) {
                    NSData *responseData = [response dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary *responsedict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                    NSString *token = [responsedict objectForKey:@"accessToken"];
                    NSString *loginName = [responsedict objectForKey:@"chatUserName"];
                    if (token && token.length > 0) {
                        // 登录即时通讯服务 SDK。
                        [[AgoraChatClient sharedClient] loginWithUsername:[loginName lowercaseString] agoraToken:token completion:^(NSString *aUsername, AgoraChatError *aError) {
                            if (!aError) {
                                ViewController *chatsVC = [[ViewController alloc] init];
                                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:chatsVC];
                                navigationController.navigationBarHidden = YES;
                                UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
                                window.rootViewController = navigationController;
                        
        }
    }];
    }
    }
    });
    }];
    }
    ```

   使用以下代码替换 `viewDidLoad` 方法：

    ```objective-c
    - (void)viewDidLoad {
        [super viewDidLoad];
        [self doSignIn];
        // 加载视图后，进行其他配置。
    }
    ```

### 启动即时通讯服务的故事板

在本节中，添加获取对端用户 ID 的输入框，并添加 **Chat** 按钮加载即时通讯服务的故事板。

在 `ViewController.m` 中添加下列代码：

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

在 `ViewController.m` 中，将 `viewDidLoad` 方法替换为下列代码：

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

在 `ViewController.m` 中添加以下代码，创建输入框以及 **Chat** 按钮：

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

- (void)logout
{
    [AgoraChatClient.sharedClient logout:YES completion:^(AgoraChatError *aError) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginStateChange" object:@NO];
    }];
}
```

### 编译项目

在 Xcode 中，选择 iPhone 模拟器，然后单击 **Start**。若项目编译成功，你会看到用户界面。

若项目编译失败，Xcode 上报 **Library not found for -IMasonry**，关闭项目，然后在 Xcode 中打开 **EaseChatKitExample.xcworkspace** （而非 **EaseChatKitExample.xcodeproj**），选择 iPhone 模拟器并单击 **Start**。

## 测试你的应用

应用启动时，你可以看到以下界面，并已登录了即时通讯 IM。

![](https://web-cdn.agora.io/docs-files/1643336848167)

参考以下步骤测试你的应用：
1. 输入 **single chat ID**，即输入对端用户 ID 进行测试，在这里可输入 `abc`。
2. 点击 **chat**。弹出编辑框。
3. 在编辑框中输入消息，然后单击 **Enter**，消息会发送并显示在界面上。
4. 你可以单击编辑框右侧的 **+**，尝试发送附件消息。

## 参考

声网提供了功能完善的[即时通讯 IM iOS UIKit](https://github.com/AgoraIO-Usecase/AgoraChat-ios) Demo 作为实现参考。