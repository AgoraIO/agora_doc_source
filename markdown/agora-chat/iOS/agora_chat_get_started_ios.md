# Agora Chat 快速入门

本页展示了如何使用 Agora Chat iOS SDK 在你的 app 中实现发送和接收单聊文本消息。

## 技术原理

~7aac3300-785d-11ec-bcb4-b56a01c83d2e~

## 前提条件

开始前，请确保你的开发环境满足以下条件：

- Xcode。本文以 Xcode 12.3 为例进行介绍。
- 一台运行 iOS 10 或以上版本的设备。

## 项目设置

在本节中，我们准备了将 Agora 即时通讯集成到你的 app 中所需的开发环境。

### 创建 iOS 项目

在 Xcode 中，参考以下步骤创建一个 iOS 应用项目。

- 打开 Xcode，单击 **Create a new Xcode project**。
- 平台类型选择 **iOS**，项目类型选择 **App**，然后单击 **Next**。
- 设置以下项目参数：
  - **Product Name**：输入 **AgoraChatExample**。
  - **Organization Identifier**：输入 **agorachat**。
  - **User Interface**：选择 **Storyboard**。
  - **Language**：选择 **Objective-C**。
  - **Team**：如果你已添加团队，请从弹出菜单中选择。如果没有，点击 **添加帐户** 按钮，输入你的 Apple ID，然后单击 **Next** 添加你的团队。
  - 选择项目存储路径，点击 **Create**。

### 集成 Agora Chat SDK

使用 CocoaPods 将 Agora 即时通讯 SDK 集成到你的项目中。

1. 安装 CocoaPods。有关详细信息，请参阅 [CocoaPods 入门](https://guides.cocoapods.org/using/getting-started.html#getting-started)。

2. 在终端中，访问项目根目录并运行 `pod init` 命令在项目文件夹中创建文本文件 `Podfile`。

3. 打开 `Podfile` 文件并添加 Agora Chat SDK。注意将 `AgoraChatExample` 替换为你的目标名称。

   ```
   platform :ios, '11.0'
   
   # Import CocoaPods sources
   source 'https://github.com/CocoaPods/Specs.git'
   
   target 'AgoraChatExample' do
       pod 'Agora_Chat_iOS'
       pod 'Masonry'
   end
   ```

4. 在项目根目录下，执行以下命令集成 SDK。SDK 安装成功后，终端中显示 `Pod installation complete!` 消息，而且项目文件夹中生成 `xcworkspace` 文件。

   ```
   pod install
   ```

5. 在 Xcode 中打开 `xcworkspace` 文件。

### 添加权限

打开 `info.plist` 文件，添加以下权限：

1. 添加 `App Transport Security Settings`。
2. 在 `App Transport Security Settings` 中，添加 `Allow Arbitrary Loads` 并将其设置为 `YES` 启用网络权限。

## 实现单聊聊天客户端

### 获得 Token

为了快速实现单聊文本消息的发送和接收，声网部署了一个 app server 生成 token。你可以参考以下步骤在客户端上获取 token。

1. 在 `AgoraChatExample` 目录中创建 `ChatHttpRequest.h` 文件，将以下代码复制到文件中。

   ```objectivec
   #import <Foundation/Foundation.h>
   
   NS_ASSUME_NONNULL_BEGIN
   
   @interface ChatHttpRequest : NSObject
   
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

2. 在 `AgoraChatExample` 目录中创建 `ChatHttpRequest.m` 文件，将以下代码复制到文件中。

   ```objectivec
   #import "ChatHttpRequest.h"
   
   @interface ChatHttpRequest() <NSURLSessionDelegate>
   @property (readonly, nonatomic, strong) NSURLSession *session;
   @end
   @implementation ChatHttpRequest
   
   + (instancetype)sharedManager
   {
       static dispatch_once_t onceToken;
       static ChatHttpRequest *sharedInstance;
       dispatch_once(&onceToken, ^{
           sharedInstance = [[ChatHttpRequest alloc] init];
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

### 实现聊天逻辑

本节展示了创建用户、登录 Agora Chat 以及发送单聊文本消息的逻辑。在 `ViewController.m` 中，将代码替换为以下内容。

```objectivec
//
//  ViewController.h
//  AgoraChatExample
//
//  Created by Agora on 2022/1/11.
// 
// 导入头文件。
#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "ChatHttpRequest.h"
#import <AgoraChat/AgoraChat.h>
#import <AgoraChat/AgoraChatOptions+PrivateDeploy.h>
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
// 实现相关代理，声明属性。
// 实现 AgoraChatClientDelegate 和 AgoraChatManagerDelegate，监听聊天事件。
@interface ViewController ()<UITextFieldDelegate, UIScrollViewDelegate, AgoraChatClientDelegate, AgoraChatManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *pswdField;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *logoutBtn;
@property (nonatomic, strong) UITextField *conversationIdField;
@property (nonatomic, strong) UITextView *msgField;
@property (nonatomic, strong) UIButton *chatBtn;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UITextView *resultView;
@property (nonatomic, strong) NSDateFormatter *formatter;
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapTableViewAction:)];
    [self.view addGestureRecognizer:tap];
    [self initSdk];
    [self _setupSubviews];
    // 加载视图后，可进行任何其他配置。
}
// 初始化 SDK。
// 该项目利用为演示目的预置的 App Key 进行 SDK 初始化。
- (void)initSdk
{
    AgoraChatOptions *options = [AgoraChatOptions optionsWithAppkey:@"41117440#383391"];
    options.enableConsoleLog = YES;
    [[AgoraChatClient sharedClient] initializeSDKWithOptions:options];
    [[AgoraChatClient sharedClient] addDelegate:self delegateQueue:nil];
    [[AgoraChatClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}
// Loads page elements.  
- (void)handleTapTableViewAction:(UITapGestureRecognizer *)aTap
{
    if (aTap.state == UIGestureRecognizerStateEnded) {
        [self.view endEditing:YES];
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
// Sets the UI.
- (void)_setupSubviews
{
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.accessibilityActivationPoint = CGPointMake(0, 0);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.scrollsToTop = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(@(self.view.bounds.size.height / 3 * 2));
    }];
    self.bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = [UIColor blackColor];
    _bottomLine.alpha = 0.1;
    [self.view addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@3);
    }];
    self.resultView = [[UITextView alloc]init];
    self.resultView.backgroundColor = [UIColor whiteColor];
    self.resultView.textColor = [UIColor blackColor];
    self.resultView.font = [UIFont systemFontOfSize:14.0];
    self.resultView.editable = NO;
    self.resultView.scrollEnabled = YES;
    self.resultView.textAlignment = NSTextAlignmentLeft;
    self.resultView.layoutManager.allowsNonContiguousLayout = NO;
    [self.view addSubview:self.resultView];
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLine.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    self.nameField = [[UITextField alloc] init];
    self.nameField.backgroundColor = [UIColor systemGrayColor];
    self.nameField.delegate = self;
    self.nameField.borderStyle = UITextBorderStyleNone;
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.nameField.attributedPlaceholder = attrStr;
    self.nameField.returnKeyType = UIReturnKeyDone;
    self.nameField.font = [UIFont systemFontOfSize:17];
    self.nameField.textColor = [UIColor whiteColor];
    self.nameField.layer.cornerRadius = 5;
    self.nameField.layer.borderWidth = 1;
    self.nameField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.scrollView addSubview:self.nameField];
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(30);
        make.top.equalTo(self.scrollView).offset(50);
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(@150);
    }];
    self.pswdField = [[UITextField alloc] init];
    self.pswdField.backgroundColor = [UIColor systemGrayColor];
    self.pswdField.delegate = self;
    self.pswdField.borderStyle = UITextBorderStyleNone;
    NSAttributedString *psdAttrStr = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.pswdField.attributedPlaceholder = psdAttrStr;
    self.pswdField.font = [UIFont systemFontOfSize:17];
    self.pswdField.textColor = [UIColor whiteColor];
    self.pswdField.returnKeyType = UIReturnKeyDone;
    self.pswdField.layer.cornerRadius = 5;
    self.pswdField.layer.borderWidth = 1;
    self.pswdField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.scrollView addSubview:self.pswdField];
    [self.pswdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameField.mas_right).offset(15);
        make.top.equalTo(self.nameField);
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(@150);
    }];
    self.registerBtn = [[UIButton alloc] init];
    self.registerBtn.clipsToBounds = YES;
    self.registerBtn.layer.cornerRadius = 5;
    self.registerBtn.backgroundColor = [UIColor colorWithRed:((float) 78 / 255.0f) green:0 blue:((float) 234 / 255.0f) alpha:1];
    self.registerBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.registerBtn setTitle:@"Create user" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.registerBtn];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameField);
        make.top.equalTo(self.nameField.mas_bottom).offset(20);
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(@150);
    }];
    self.loginBtn = [[UIButton alloc] init];
    self.loginBtn.clipsToBounds = YES;
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.backgroundColor = [UIColor colorWithRed:((float) 78 / 255.0f) green:0 blue:((float) 234 / 255.0f) alpha:1];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.loginBtn setTitle:@"Log in" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.registerBtn);
        make.top.equalTo(self.registerBtn.mas_bottom).offset(20);
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(@150);
    }];
    self.logoutBtn = [[UIButton alloc] init];
    self.logoutBtn.clipsToBounds = YES;
    self.logoutBtn.layer.cornerRadius = 5;
    self.logoutBtn.backgroundColor = [UIColor colorWithRed:((float) 78 / 255.0f) green:0 blue:((float) 234 / 255.0f) alpha:1];
    self.logoutBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.logoutBtn setTitle:@"Log out" forState:UIControlStateNormal];
    [self.logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.logoutBtn addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.logoutBtn];
    [self.logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginBtn.mas_right).offset(15);
        make.top.equalTo(self.loginBtn);
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(@150);
    }];
    self.conversationIdField = [[UITextField alloc] init];
    self.conversationIdField.backgroundColor = [UIColor systemGrayColor];
    self.conversationIdField.delegate = self;
    self.conversationIdField.borderStyle = UITextBorderStyleNone;
    NSAttributedString *convAttrStr = [[NSAttributedString alloc] initWithString:@"Peer username" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.conversationIdField.attributedPlaceholder = convAttrStr;
    self.conversationIdField.font = [UIFont systemFontOfSize:17];
    self.conversationIdField.textColor = [UIColor whiteColor];
    self.conversationIdField.returnKeyType = UIReturnKeyDone;
    self.conversationIdField.layer.cornerRadius = 5;
    self.conversationIdField.layer.borderWidth = 1;
    self.conversationIdField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.scrollView addSubview:self.conversationIdField];
    [self.conversationIdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(30);
        make.top.equalTo(self.logoutBtn.mas_bottom).offset(20);
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(@320);
    }];
    self.msgField = [[UITextView alloc] init];
    //self.msgField.backgroundColor = [UIColor colorWithRed:((float) 78 / 255.0f) green:0 blue:((float) 234 / 255.0f) alpha:1];
    self.msgField.backgroundColor = [UIColor systemGrayColor];
    self.msgField.text = @"Message content";
    self.msgField.textColor = [UIColor whiteColor];
    self.msgField.font = [UIFont systemFontOfSize:17];
    self.msgField.returnKeyType = UIReturnKeyDone;
    self.msgField.layer.cornerRadius = 5;
    self.msgField.layer.borderWidth = 1;
    self.msgField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.msgField.scrollEnabled = YES;
    self.msgField.textAlignment = NSTextAlignmentLeft;
    [self.scrollView addSubview:self.msgField];
    [self.msgField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(30);
        make.top.equalTo(self.conversationIdField.mas_bottom).offset(20);
        make.height.mas_equalTo(@150);
        make.width.mas_equalTo(@320);
    }];
    self.chatBtn = [[UIButton alloc] init];
    self.chatBtn.clipsToBounds = YES;
    self.chatBtn.layer.cornerRadius = 5;
    self.chatBtn.backgroundColor = [UIColor colorWithRed:((float) 78 / 255.0f) green:0 blue:((float) 234 / 255.0f) alpha:1];
    self.chatBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.chatBtn setTitle:@"Send" forState:UIControlStateNormal];
    [self.chatBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.chatBtn addTarget:self action:@selector(chatAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.chatBtn];
    [self.chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(30);
        make.top.equalTo(self.msgField.mas_bottom).offset(20);
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(@150);
    }];
}
// 注册用户账户（用户 ID 和密码）。
- (void)registerAction
{
    [self.view endEditing:YES];
    NSString *name = [self.nameField.text lowercaseString];
    NSString *pswd = [self.pswdField.text lowercaseString];
    if ([name length] == 0 || [pswd length] == 0) {
        [self printLog:@"username or password is null"];
        return;
    }
    __weak typeof(self) weakself = self;
    // 发送 HTTP 请求从 App Server 中获取 token。
    [[ChatHttpRequest sharedManager] registerToApperServer:name pwd:pswd completion:^(NSInteger statusCode, NSString * _Nonnull response) {
        dispatch_async(dispatch_get_main_queue(),^{
            NSString *alertStr = @"login.signup.fail";
            if (response != nil) {
                NSData *responseData = [response dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *responsedict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                if (responsedict != nil) {
                    NSString *result = [responsedict objectForKey:@"code"];
                    if ([result isEqualToString:@"RES_OK"]) {
                        alertStr = NSLocalizedString(@"login.signup.success", @"create user success");
                    }
                } else {
                    alertStr = NSLocalizedString(@"login.signup.failure", @"create user failure");
                }
            } else {
                alertStr = NSLocalizedString(@"login.signup.failure", @"create user failure");
            }
            [weakself printLog:alertStr];
        });
    }];
}
// 登录 Agora 即时通讯系统。
- (void)loginAction
{
    if (AgoraChatClient.sharedClient.isLoggedIn) {
        [self logoutAction];
    }
    [self.view endEditing:YES];
    NSString *name = [self.nameField.text lowercaseString];
    NSString *pswd = [self.pswdField.text lowercaseString];
    if (name.length == 0 || pswd.length == 0) {
        [self printLog:@"username or password is null"];
        return;
    }
    __weak typeof(self) weakself = self;
    void (^finishBlock) (NSString *aName, AgoraChatError *aError) = ^(NSString *aName, AgoraChatError *aError) {
        if (!aError) {
            [weakself printLog:[NSString stringWithFormat:@"login success ! name : %@",aName]];
            return ;
        }
        [weakself printLog:[NSString stringWithFormat:@"login fail ! errorDes : %@",aError.errorDescription]];
    };
    [[ChatHttpRequest sharedManager] loginToApperServer:name pwd:pswd completion:^(NSInteger statusCode, NSString * _Nonnull response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (response && response.length > 0) {
                NSData *responseData = [response dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *responsedict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                NSString *token = [responsedict objectForKey:@"accessToken"];
                NSString *loginName = [responsedict objectForKey:@"chatUserName"];
                if (token && token.length > 0) {
                    [weakself printLog:@"login appserver success !"];
                    [[AgoraChatClient sharedClient] loginWithUsername:loginName agoraToken:token completion:finishBlock];
                } else {
                    [weakself printLog:@"parsing token fail !"];
                }
            } else {
                [weakself printLog:@"login appserver fail !"];
            }
        });
    }];
}
// 登出 Agora 即时通讯系统。
- (void)logoutAction
{
    AgoraChatError *error = [[AgoraChatClient sharedClient] logout:YES];
    [self printLog:[NSString stringWithFormat:@"logout result : %@",!error ? @"success !" : error.errorDescription]];
}
// 发送文本消息。
- (void)_sendMessageWithBody:(AgoraChatMessageBody *)body
                        ext:(NSDictionary * __nullable)aExt
{
    NSString *from = [[AgoraChatClient sharedClient] currentUsername];
    NSString *to = self.conversationIdField.text;
    if (to.length == 0) {
        [self printLog:@"Peer username is null!"];
        return;
    }
    AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:to from:from to:to body:body ext:nil];
    message.chatType = AgoraChatTypeChat;
    __weak typeof(self) weakself = self;
    [[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:^(AgoraChatMessage *message, AgoraChatError *error) {
        if (!error) {
            if (message.body.type == AgoraChatMessageBodyTypeText) {
                AgoraChatTextMessageBody *body = (AgoraChatTextMessageBody *)message.body;
                [weakself printLog:[NSString stringWithFormat:@"send message success：%@",body.text]];
            } else {
                [weakself printLog:[NSString stringWithFormat:@"send message success ! messageType : %@",[weakself getBodyType:message.body.type]]];
            }
        } else {
            [weakself printLog:[NSString stringWithFormat:@"send message fail ! errDesc : %@",error.errorDescription]];
        }
    }];
}
- (void)chatAction
{
    [self.view endEditing:YES];
    if (!AgoraChatClient.sharedClient.isLoggedIn) {
        [self printLog:@"not loggin"];
        return;
    }
    AgoraChatMessageBody *body = [[AgoraChatTextMessageBody alloc] initWithText:self.msgField.text];
    [self _sendMessageWithBody:body ext:nil];
}
// 接收消息触发的回调。
- (void)messagesDidReceive:(NSArray *)aMessages
{
    __weak typeof(self) weakself = self;
    for (int i = 0; i < [aMessages count]; i++) {
        AgoraChatMessage *msg = aMessages[i];
        if(msg.body.type == AgoraChatMessageBodyTypeText) {
            AgoraChatTextMessageBody *body = (AgoraChatTextMessageBody*)msg.body;
            [weakself printLog:[NSString stringWithFormat:@"receive a AgoraChatMessageBodyTypeText message :%@, from : %@",body.text,msg.from]];
        } else {
            [weakself printLog:[NSString stringWithFormat:@"receive a %@ message, from : %@",[weakself getBodyType:msg.body.type],msg.from]];
        }
    }
}
- (NSString *)getBodyType:(AgoraChatMessageBodyType)bodyType
{
    NSString *type = @"";
    switch (bodyType) {
        case AgoraChatMessageBodyTypeImage:
            type = @"AgoraChatMessageBodyTypeImage";
            break;
        case AgoraChatMessageBodyTypeVideo:
            type = @"AgoraChatMessageBodyTypeVideo";
            break;
        case AgoraChatMessageBodyTypeLocation:
            type = @"AgoraChatMessageBodyTypeLocation";
            break;
        case AgoraChatMessageBodyTypeVoice:
            type = @"AgoraChatMessageBodyTypeVoice";
            break;
        case AgoraChatMessageBodyTypeFile:
            type = @"AgoraChatMessageBodyTypeFile";
            break;
        case AgoraChatMessageBodyTypeCmd:
            type = @"AgoraChatMessageBodyTypeCmd";
            break;
        case AgoraChatMessageBodyTypeCustom:
            type = @"AgoraChatMessageBodyTypeCustom";
            break;
        default:
            break;
    }
    return type;
}
// Token 即将过期触发的回调。
- (void)tokenWillExpire:(int)aErrorCode
{
    [self printLog:[NSString stringWithFormat:@"token %@", aErrorCode == AgoraChatErrorTokeWillExpire ? @"TokeWillExpire" : @"TokeExpire"]];
    if (aErrorCode == AgoraChatErrorTokeWillExpire) {
        [self printLog:[NSString stringWithFormat:@"========= token expire rennew token ! code : %d",aErrorCode]];
        NSString *name = [self.nameField.text lowercaseString];
        NSString *pswd = [self.pswdField.text lowercaseString];
        [[ChatHttpRequest sharedManager] loginToApperServer:name pwd:pswd completion:^(NSInteger statusCode, NSString * _Nonnull response) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (response && response.length > 0) {
                    NSData *responseData = [response dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary *responsedict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                    NSString *token = [responsedict objectForKey:@"accessToken"];
                    if (token && token.length > 0) {
                        if (aErrorCode == AgoraChatErrorTokeWillExpire) {
                            AgoraChatError *error = [[AgoraChatClient sharedClient] renewToken:token];
                            if (error) {
                                [self printLog:[NSString stringWithFormat:@"renew token fail ！ errDesc : %@",error.errorDescription]];
                            } else {
                                [self printLog:@"renew token success ！"];
                            }
                        }
                    } else {
                        [self printLog:@"parsing token fail !"];
                    }
                } else {
                    [self printLog:@"login appserver fail !"];
                }
            });
        }];
    }
}
// Token 过期时触发的回调。
// 你需要从你的 App Server 中获取新的 token，然后重新登录 Agora 即时通讯系统。
- (void)tokenDidExpire:(int)aErrorCode
{
      [[AgoraChatClient sharedClient] logout:NO];
    [self printLog:[NSString stringWithFormat:@"token %@", aErrorCode == AgoraChatErrorTokeWillExpire ? @"TokeWillExpire" : @"TokeExpire"]];
    if (aErrorCode == AgoraChatErrorTokenExpire || aErrorCode == 401) {
        [self loginAction];
        return;
    }
}
// 打印日志。
- (void)printLog:(NSString *)log
{
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakself.resultView.text.length > 0) {
            weakself.resultView.text = [weakself.resultView.text stringByAppendingString:@"\r\n"];
        }
        NSString *currentTS = [weakself.formatter stringFromDate:[NSDate date]];
        NSString *logPrefix = [NSString stringWithFormat:@"[%@]: ",currentTS];
        NSString *logStr = [NSString stringWithFormat:@"%@%@",logPrefix,log];
        weakself.resultView.text = [weakself.resultView.text stringByAppendingString:logStr];
        long allStrCount = self.resultView.text.length;
        [weakself.resultView scrollRangeToVisible:NSMakeRange(0, allStrCount)];
    });
}
- (NSDateFormatter *)formatter
{
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc]init];
        [_formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss.SSS"];
    }
    return _formatter;
}
@end
```

## 运行并测试项目

使用 Xcode 在 iOS 真机或模拟机上编译和运行项目。你可以看到以下界面：

![](https://web-cdn.agora.io/docs-files/1641976387226)

参考以下步骤发送和接收文本消息：

1. 输入任意的用户名（如 `Localuser` 和 `Remoteuser`）和密码（如 `123456`），点击 `Create user` 创建两个用户用于互通。
2. 以 `Localuser` 的身份登录 Agora Chat，将 `Peer username` 填为 `Remoteuser`，发送文本消息。
   ![](https://web-cdn.agora.io/docs-files/1641976375607)
3. 以 `Remoteuser` 的身份登录 Agora 即时通讯系统，查看 log 信息确认是否收到消息。
   ![](https://web-cdn.agora.io/docs-files/1641976362744)

## 后续步骤

出于演示目的，Agora Chat 提供一个 App Server，可使你利用本文中提供的 App Key 快速获得 token。在生产环境中，最好自行部署 token 服务器，使用自己的 [App Key](./enable_agora_chat) 生成 token，并在客户端获取 token 登录 Agora 即时通讯服务。要了解如何实现服务器按需生成和提供 token，请参阅[生成用户 Token](./generate_user_tokens)。

## 参考

### 集成 SDK 的其他方式

除上文介绍的使用 CocoaPods 集成 Agora 即时通讯 SDK，你还可以按照以下步骤手动集成 SDK：

1. 下载最新版的 [Agora 即时通讯 iOS SDK](./downloads?platform=iOS) 并解压。
2. 将 SDK 包内的 `AgoraChat.framework` 复制到项目文件夹中。`AgoraChat.framework` 包含 arm64、armv7 和 x86_64 指令集。
3. 打开 Xcode，进入 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content**。
4. 点击 **+ > Add Other... > Add Files** 添加 AgoraChat.framework 并将 **Embed** 属性设置为 **Embed & Sign**。添加完成后，项目会自动链接所需系统库。