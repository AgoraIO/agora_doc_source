This page shows how to add one-to-one messaging into your app by using the Agora Chat SDK for iOS.  


## Understand the tech

~338e0e30-e568-11ec-8e95-1b7dfd4b7cb0~

## Prerequisites

Before proceeding, ensure that your development environment meets the following requirements: 

- Xcode. This page uses Xcode 12.3 as an example.
- A device running iOS 10 or later.

## Project setup

In this section, we prepare the development environment necessary to integrate Agora Chat into your app.

### Create an iOS project

In Xcode, follow the steps to create an iOS app project. 

- Open Xcode and click **Create a new Xcode project**.

- Select **iOS** for the platform type and **App** for the project type and click **Next**.

- Set the following project parameters:

  - **Product Name**: Enter **AgoraChatExample**.

  - **Organization Identifier**: Enter **agorachat**.

  - **User Interface**: Choose **Storyboard**.

  - **Language**: Choose **Objective-C**.

  - **Team**: If you have added a team, choose it from the pop-up menu. If not, you can see the **Add account** button. Click it, enter your Apple ID, and click **Next** to add your team.

  - Select the project storage path and click **Create**.

### Integrate the Agora Chat SDK

Use CocoaPods to integrate the Agora Chat SDK into your project.

1. Install CocoaPods if you have not. For details, see [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started).

2. In the Terminal, navigate to the project root directory and run the `pod init` command to create a text file `Podfile` in the project folder.

3. Open the `Podfile` file and add the Agora Chat SDK. Remember to replace `AgoraChatExample` with the target name of your project.

   ```
   platform :ios, '11.0'
   
   # Import CocoaPods sources
   source 'https://github.com/CocoaPods/Specs.git'
   
   target 'AgoraChatExample' do
       pod 'AgoraChat'
       pod 'Masonry'
   end
   ```

4. In the project root directory, run the following command to integrate the SDK. When the SDK is installed successfully, you can see `Pod installation complete!` in the Terminal and an `xcworkspace` file in the project folder. 

   ```
   pod install
   ```

5. Open the `xcworkspace` file in Xcode.

### Add permissions

Open the `info.plist` file and add the following permissions:

1. Add `App Transport Security Settings`.

2. Under `App Transport Security Settings`, add `Allow Arbitrary Loads` and set it as `YES` to enable network permissions.

## Implement a one-to-one chat client
### Retrieve a token

To enable one-to-one text messaging quickly, Agora has deployed an app server to generate tokens. You can take the following steps to get a token on your client. 

1. Create the `ChatHttpRequest.h` file in the `AgoraChatExample` directory and copy the following code to the file.

   ```objective-c
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

2. Create the `ChatHttpRequest.m` file in the `AgoraChatExample` directory and copy the following code to the file.

   ```objective-c
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

### Implement the chat logic

This section shows the logic of creating a user, logging in to Agora Chat, and sending a one-to-one text message. In `ViewController.m`, replace the code with the following. 

```objective-c
//
//  ViewController.h
//  AgoraChatExample
//
//  Created by Agora on 2022/1/11.
// 
// Imports header files.
#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "ChatHttpRequest.h"
#import <AgoraChat/AgoraChat.h>
#import <AgoraChat/AgoraChatOptions+PrivateDeploy.h>
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
// Implements related delegates and declares properties.
// Implements AgoraChatClientDelegate and AgoraChatManagerDelegate to listen for chat events.
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
// Initializes the SDK. 
// This project uses a pre-defined app key for SDK initialization for demonstration purposes.
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
// Creates a user with a username and password combination.
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
    // Sends an HTTP request to get the token from the app server.
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
// Logs into Agora Chat.
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
                    [weakself printLog:@"parseing token fail !"];
                }
            } else {
                [weakself printLog:@"login appserver fail !"];
            }
        });
    }];
}
// Logs out of Agora Chat.
- (void)logoutAction
{
    AgoraChatError *error = [[AgoraChatClient sharedClient] logout:YES];
    [self printLog:[NSString stringWithFormat:@"logout result : %@",!error ? @"success !" : error.errorDescription]];
}
// Sends a text message.
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
// Occurs when a message is received.
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
// Occurs when the token is about to expire.
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
                        [self printLog:@"parseing token fail !"];
                    }
                } else {
                    [self printLog:@"login appserver fail !"];
                }
            });
        }];
    }
}
// Occurs when the token has expired.
// You need to get a new token from the app server and log in again.
- (void)tokenDidExpire:(int)aErrorCode
{
      [[AgoraChatClient sharedClient] logout:NO];
    [self printLog:[NSString stringWithFormat:@"token %@", aErrorCode == AgoraChatErrorTokeWillExpire ? @"TokeWillExpire" : @"TokeExpire"]];
    if (aErrorCode == AgoraChatErrorTokenExpire || aErrorCode == 401) {
        [self loginAction];
        return;
    }
}
// Prints logs.
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

## Run and test the project

Use Xcode to compile and run the project on an iOS device or emulator. The following user interface appears.

![img](https://web-cdn.agora.io/docs-files/1641976387226)

To try sending and receiving text messages, follow the steps on two clients:

1. Enter a username (such as `Localuser` and `Remoteuser`) and a password (such as `123456`) and click `Create user` on each client to create two Agora Chat users.

2. Log into Agora Chat as `Localuser`, type `Remoteuser` for `Peer username`, and send a text message.

   ![img](https://web-cdn.agora.io/docs-files/1641976375607)

3. Log into Agora Chat as `Remoteuser` and check logs to see whether this message is received.

   ![img](https://web-cdn.agora.io/docs-files/1641976362744)

## Next Steps

For demonstration purposes, Agora Chat provides an app server that enables you to quickly retrieve a token using the App Key given in this guide. In a production context, the best practice is for you to deploy your own token server, use your own [App Key](./enable_agora_chat?platform=Android#get-the-information-of-the-agora-chat-project) to generate a token, and retrieve the token on the client side to log in to Agora. To see how to implement a server that generates and serves tokens on request, see [Generate a User Token](./generate_user_tokens?platform=All%20Platforms).


## Reference

### Other approaches to integrate the SDK

In addition to integrating the Agora Chat SDK with CocoaPods, you can also take the following steps to integrate the SDK manually:

1. Download the latest Agora Chat SDK and decompress it.

2. Copy `AgoraChat.framework` in the SDK package to the project folder. `AgoraChat.framework` contains arm64, armv7, and x86_64 instruction sets.

3. Open Xcode and navigate to **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content**.

4. Click **+ > Add Other… > Add Files** to add AgoraChat.framework and set the **Embed** property to **Embed & Sign**. Then the project automatically links to the required system library. 