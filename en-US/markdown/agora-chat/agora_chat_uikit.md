# Get Started with Agora Chat UIKit

Instant messaging connects people wherever they are and allows them to communicate with others in real time. The Agora Chat SDK enables you to embed real-time messaging in any app, on any device, anywhere.

This page shows a sample code to add peer-to-peer messaging into your app by using the Agora Chat UIKit.

## Understand the tech

The workflow of peer-to-peer messaging is as follows:

- The clients retrieve a token from your app server.
- Client A and Client B sign in to Agora Chat.
- Client A sends a message to Client B.
- The message is sent to the Agora Chat server and the server delivers the message to Client B.
- When Client B receives the message, the SDK triggers an event. Client B listens for the event and gets the message.

## Prerequisites

In order to follow the procedure in this page, you must have:

- Xcode 9.0 or later.
- A valid Agora account.
- A valid Agora project with the [Agora Chat service enabled](). Get the App Key of this project.
- A token: In a test or production environment, your app client retrieves tokens from your server.

## Project setup

Follow the steps to create the environment necessary to add Agora Chat UIKit into your app.

### Create an iOS project

For new projects, in **XCode**, [create a **Single View App**](https://developer.apple.com/documentation/xcode/creating-an-xcode-project-for-an-app) with the following configurations:

- Product Name: EaseChatKitExample.
- Organization Identifier: agorachat.
- User Interface: Storyboard.
- Language: Objective-C.

### Integrate Agora Chat UIKit

Before proceeding, ensure that you have [installed Cocoapods](https://guides.cocoapods.org/using/getting-started.html#getting-started).

1. Download the [souce code for Agora Chat UIKit](https://github.com/AgoraIO-Usecase/AgoraChat-UIKit-ios.git). 

2. Go to the root directory of your Xcode project and run the following command to create a `Podfile`.

   ```shell
   pod init
   ```
3. Add dependencies to the UIKit in the `Podfile`. Open `Podfile` and replace the content with the following:

   > The path of `chat-uikit` is the relative path of the downloaded UIkit to the podfile, and you need to modify the path accordingly.

   ```xml
   platform :ios, '11.0'
   target 'EaseChatKitExample' do

     # Pods for EaseChatKitExample
     pod 'chat-uikit', :path => "../AgoraChat-UIKit-ios-main"
     pod 'Masonry'

   end
   ```
   

4. In the root directory of your project, run the following command to install the UIKit.

   ```shell
   pod install
   ```

### Add project permissions

In **Xcode**, open `info.plist`, and the following permissions:

```xml
Privacy - Photo Library Usage Description // For photo library access
Privacy - Microphone Usage Description // For microphone access
Privacy - Camera Usage Description // For camera access
App Transport Security Settings > Allow Arbitrary Loads - YES // For network access
```

## Implement peer-to-peer messaging

This section shows how to use Agora Chat UIKit to implement peer-to-peer messaging in your app.

### Initialize UIKit

In **Xcode**, open `SceneDelegate.m` file and add the following lines to import the header file:

```Objective-C
#import <chat-uikit/EaseChatKit.h>
#import "AgoraLoginViewController.h"
#import <AgoraChat/AgoraChat.h>
```

Replace the `scene` function with the following code:

```Objective-C
- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    AgoraChatOptions *options = [AgoraChatOptions optionsWithAppkey:@"41117440#383391"];
    options.enableConsoleLog = YES;
    options.usingHttpsOnly = YES;
    options.enableDeliveryAck = YES;
    options.isAutoLogin = NO;
  	// Initialize chat-uikit
    [EaseChatKitManager initWithAgoraChatOptions:options];
    
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    self.window.frame = windowScene.coordinateSpace.bounds;
    // Go to the login view
    self.window.rootViewController = [[AgoraLoginViewController alloc]init];
        [self.window makeKeyAndVisible];
}
```

### Log into Agora Chat

Take the following steps to log into Agora Chat.

1. In **Xcode**, go to **File** > **New** > **File**, and create a **Cocoa Touch Class** named `AgoraChatHttpRequest` with the subclass of `NSObject`.

2. Open `AgoraChatHttpRequest.h` and replace the file with the following code:

    ```Objective-C
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
    
    Open `AgoraChatHttpRequest.m` and replace the file with the following code:

    ```Objective-C
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
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){//服务器信任证书
                NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];//服务器信任证书
                if(completionHandler)
                    completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
            }
    }

    @end
    ```

3. Go to **File** > **New** > **File** and create a **Cocoa Touch Class** file named `AgoraLoginViewController` with the subclass of **UIViewController**.

4. In `AgoraLoginViewController.m`, add the following lines to import the header file:

    ```Objective-C
    #import "AgoraChatHttpRequest.h" // To send request to the Appserver
    #import <AgoraChat/AgoraChat.h> //Agora Chat SDK
    #import "ViewController.h"
    ```

   Add the following lines after `@implementation AgoraLoginViewController`:

    ```Objective-C
    // Register to the AppServer
    - (void)doSignUp {
    [[AgoraChatHttpRequest sharedManager] registerToApperServer:@"vvv" pwd:@"1" completion:^(NSInteger statusCode, NSString * _Nonnull response) {
            dispatch_async(dispatch_get_main_queue(),^{
                if (response != nil) {
                    NSData *responseData = [response dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary *responsedict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                    if (responsedict != nil) {
                        NSString *result = [responsedict objectForKey:@"code"];
                        if ([result isEqualToString:@"RES_OK"]) {
                            // Sign in Agora Chat if registration succeeds
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
                        // Log into Agora Chat SDK
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

    Replace the `viewDidLoad` function with the following code:

    ```Objective-C
    - (void)viewDidLoad {
        [super viewDidLoad];
        [self doSignIn];
        // Do any additional setup after loading the view.
    }
    ```

### Launch the chat storyboard

In this section, add input box for getting the chat ID, and a **Chat** button that loads the chat storyboard.

In `ViewController.m`, and add the following code:

```Objective-C
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

In `ViewController.m`, load the storyboard in the `viewDidLoad` function by adding the following code:

```Objective-C
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


Add the following code in `ViewController.m` to create the input box and **Chat** button:

```Objective-C
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

## Test your app

In **Xcode**, select a simulator and click **Build and run**, and you will see the following user interface:

![](../chat_uikit.png)

Input a Chat ID, and you can now send a peer-to-peer message.


## Next steps

