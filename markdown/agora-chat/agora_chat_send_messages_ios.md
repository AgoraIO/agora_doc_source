# 发送和接收一对一文本消息

本文介绍如何通过少量代码集成 Agora Chat SDK，在你的 iOS 应用中实现发送和接收一对一文本消息。

## 技术原理

（插 fragment）

## 前提条件

开始前，请确保满足以下条件：

- Xcode。本文 Xcode 的界面描述以 12.3 为例。
- 一台 iOS 设备，安装 iOS 10 或以上版本。

## 准备开发环境

按照以下步骤准备开发环境：

### 创建 iOS 项目

按照以下步骤创建在 Xcode 中创建一个 iOS 平台的 App，项目设置如下：

- 打开 Xcode 并点击 Create a new Xcode project。
- 选择平台类型为 iOS、项目类型为 App，并点击 Next。
- 设置以下项目信息：
  - 项目名称（Product Name）设为 AgoraChatExample。
  - 组织名称（Organization Identifier）设为 agorachat。
  - User Interface 选择 Storyboard。
  - 语言（Language）选择 Objective-C。
  <div class="alert info">如果你没有添加过开发团队信息，会看到 Add account… 按钮。点击该按钮并按照屏幕提示登入 Apple ID，完成后即可选择你的 Apple 账户作为开发团队。</div>
- 选择项目存储路径，并点击 Create。

### 集成 Agora Chat SDK

按照以下步骤使用 CocoaPods 将 Agora Chat SDK 集成到你的项目中。

1. 开始前确保你已安装 CocoaPods。参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。
2. 在终端里进入项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。
3. 在 `Podfile` 文件里添加 Agora Chat SDK。注意将 `AgoraChatAPIExample` 替换为你实际的 Target 名称。

   ```
   platform :ios, '11.0'

   # Import CocoaPods sources
   source 'https://github.com/CocoaPods/Specs.git'

   target 'AgoraChatExample' do
       pod 'AgoraChat'
       pod 'Masonry'
   end
   ```

4. 在项目根目录执行如下命令集成 SDK。

   ```
   pod install
   ```

5. 成功安装后，终端会显示 `Pod installation complete!`，此时项目文件夹下会生成一个 `xcworkspace` 文件，打开新生成的 `xcworkspace` 文件即可。

### 添加权限

参考以下步骤在 `info.plist` 文件中添加相关权限：
1. 新增 `App Transport Security Settings` 条目。
2. 在 `App Transport Security Settings` 下新增 `Allow Arbitrary Loads` 条目，并将值设为 `YES`，开启网络权限。

## 实现获取 Token

为帮助你快速体验发送和接收一对一文本消息功能，Agora 已部署了一个 App Server 用于生成 Token。你需要参考以下步骤在客户端实现获取 Token：
1. 在 `AgoraChatExample` 目录下创建 `EMHttpRequest.h` 文件，并将以下代码拷贝到 `EMHttpRequest.h` 文件中：

   ```objective-c
   #import <Foundation/Foundation.h>

   NS_ASSUME_NONNULL_BEGIN

   @interface EMHttpRequest : NSObject

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
2. 在 `AgoraChatExample` 目录下创建 `EMHttpRequest.m` 文件，并将以下代码拷贝到 `EMHttpRequest.m` 文件中：

   ```objective-c
   #import "EMHttpRequest.h"

   @interface EMHttpRequest() <NSURLSessionDelegate>
   @property (readonly, nonatomic, strong) NSURLSession *session;
   @end
   @implementation EMHttpRequest

   + (instancetype)sharedManager
   {
       static dispatch_once_t onceToken;
       static EMHttpRequest *sharedInstance;
       dispatch_once(&onceToken, ^{
           sharedInstance = [[EMHttpRequest alloc] init];
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
       //NSString *hkURl = @"https://hk-test.easemob.com/app/chat/user/register";
       NSURL *url = [NSURL URLWithString:@"https://a41.easemob.com/app/chat/user/register"];
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
       //NSString *hkURl = @"https://hk-test.easemob.com/app/chat/user/login";
       NSURL *url = [NSURL URLWithString:@"https://a41.easemob.com/app/chat/user/login"];
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

## 实现发送和接收消息

在项目的 `ViewController.m` 文件里添加以下代码实现创建用户、登录和登出、发送和接收一对一文本消息等逻辑：

```objective-c
//
//  ViewController.h
//  AgoraChatExample
//
//  Created by Agora on 2022/1/11.
//
// 导入头文件
#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "EMHttpRequest.h"
#import <AgoraChat/AgoraChat.h>
#import <AgoraChat/AgoraChatOptions+PrivateDeploy.h>
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>

// 实现相关代理并声明属性
// 实现 AgoraChatClientDelegate 和 AgoraChatManagerDelegate 代理用于监听回调
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
    // Do any additional setup after loading the view.
}

// 初始化 SDK
// 本项目使用 Agora 预埋的 AppKey 进行初始化，无需替换成你自己的 AppKey
- (void)initSdk
{
    AgoraChatOptions *options = [AgoraChatOptions optionsWithAppkey:@"41117440#383391"];
    options.enableConsoleLog = YES;
    [[AgoraChatClient sharedClient] initializeSDKWithOptions:options];
    [[AgoraChatClient sharedClient] addDelegate:self delegateQueue:nil];
    [[AgoraChatClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}

// 加载页面元素
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

// 设置 UI
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

// 使用用户名和密码创建用户
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
    // 发送 HTTP 请求向 Agora 部署的 App Server 获取 Token
    [[EMHttpRequest sharedManager] registerToApperServer:name pwd:pswd completion:^(NSInteger statusCode, NSString * _Nonnull response) {
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

// 登录
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

    [[EMHttpRequest sharedManager] loginToApperServer:name pwd:pswd completion:^(NSInteger statusCode, NSString * _Nonnull response) {
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
                    [weakself printLog:@"parseing token fail !"];
                }
            } else {
                [weakself printLog:@"login appserver fail !"];
            }
        });
    }];
}

// 登出
- (void)logoutAction
{
    AgoraChatError *error = [[AgoraChatClient sharedClient] logout:YES];
    [self printLog:[NSString stringWithFormat:@"logout result : %@",!error ? @"success !" : error.errorDescription]];
}

// 发送文本消息
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

// 收到消息回调
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

// Token 即将过期回调
- (void)tokenWillExpire:(int)aErrorCode
{
    [self printLog:[NSString stringWithFormat:@"token %@", aErrorCode == AgoraChatErrorTokeWillExpire ? @"TokeWillExpire" : @"TokeExpire"]];
    if (aErrorCode == AgoraChatErrorTokeWillExpire) {
        [self printLog:[NSString stringWithFormat:@"========= token expire rennew token ! code : %d",aErrorCode]];
        NSString *name = [self.nameField.text lowercaseString];
        NSString *pswd = [self.pswdField.text lowercaseString];
        [[EMHttpRequest sharedManager] loginToApperServer:name pwd:pswd completion:^(NSInteger statusCode, NSString * _Nonnull response) {
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
                        [self printLog:@"parseing token fail !"];
                    }
                } else {
                    [self printLog:@"login appserver fail !"];
                }
            });
        }];
    }
}

// Token 已过期回调
// 需要从 App Server 获取新的 Token 并重新登录
- (void)tokenDidExpire:(int)aErrorCode
{
      [[AgoraChatClient sharedClient] logout:NO];
    [self printLog:[NSString stringWithFormat:@"token %@", aErrorCode == AgoraChatErrorTokeWillExpire ? @"TokeWillExpire" : @"TokeExpire"]];
    if (aErrorCode == AgoraChatErrorTokenExpire || aErrorCode == 401) {
        [self loginAction];
        return;
    }
}

// 打印日志信息
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

## 运行和测试项目

使用 Xcode 在 iOS 真机或模拟机上编译和运行项目。你可以看到以下界面：

![](https://web-cdn.agora.io/docs-files/1641976387226)

参考以下步骤发送和接收文本消息：
1. 输入任意的用户名（如 `Localuser` 和 `Remoteuser`）和密码（如 `123456`），点击 `Create user` 创建两个用户用于互通。
2. 以 `Localuser` 的身份登录 Agora Chat，将 `Peer username` 填为 `Remoteuser`，发送文本消息。
   ![](https://web-cdn.agora.io/docs-files/1641976375607)
3. 以 `Remoteuser` 的身份登录 Agora Chat，查看 log 信息确认是否收到消息。
   ![](https://web-cdn.agora.io/docs-files/1641976362744)

## 后续步骤

为保障通信安全，在正式生产环境中，你需要在自己的 app 服务端生成 Token。详见[使用 Token 鉴权](/cn/live-streaming/token_server)。

## 更多信息

### 集成 SDK 的其他方式

除上文介绍的使用 CocoaPods 集成 Agora Chat SDK，你还可以按照以下步骤手动集成 SDK：

1. 下载最新版的 [Agora Chat SDK for iOS]() 并解压。
2. 将 SDK 包内的 `AgoraChat.framework` 复制到项目文件夹中。`AgoraChat.framework` 包含 arm64，armv7，x86_64 指令集。
3. 打开 Xcode，进入 TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content 菜单。
4. 点击 + > Add Other… > Add Files 添加 AgoraChat.framework，并将Embed 属性设为 Embed & Sign。添加完成后，项目会自动链接所需系统库。