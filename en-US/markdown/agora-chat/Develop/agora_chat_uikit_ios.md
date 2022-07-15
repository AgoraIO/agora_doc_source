Instant messaging connects people wherever they are and allows them to communicate with others in real time. With built-in user interfaces (UI) for the conversation list and contact list, the [Agora Chat UIKit](https://github.com/AgoraIO-Usecase/AgoraChat-UIKit-ios) enables you to quickly embed real-time messaging into your app without requiring extra effort on the UI.

This page shows a sample code to add peer-to-peer messaging into your app by using the Agora Chat UIKit.

## Understand the tech

The following figure shows the workflow of how clients send and receive peer-to-peer messages:

![](https://web-cdn.agora.io/docs-files/1643335864426)

1. Clients retrieve a token from your app server.
2. Client A and Client B log in to Agora Chat.
3. Client A sends a message to Client B. The message is sent to the Agora Chat server, and the server delivers the message to Client B. When Client B receives the message, the SDK triggers an event. Client B listens for the event and gets the message.

## Prerequisites

In order to follow the procedure in this page, you must have:

- Xcode, preferrably the latest version.
- A simulator or a physical mobile device running iOS 11.0 or later.
- CocoaPods. Refer to [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) if you have not installed CocoaPods.

## Project setup

In order to create the environment necessary to integrate Agora Chat UIKit into your app, do the following:

1. [Create a new project](https://help.apple.com/xcode/mac/current/#/dev07db0e578) for an iOS app. Make sure you select **Storyboard** as the **Interface**.

   If you have added any team information, you see the **Add account...** button. Click it, input your Apple ID, and click Next. Your team information is added to the project.

2. [Enable automatic signing](https://help.apple.com/xcode/mac/current/#/dev23aab79b4) for your project.

3. [Set the target devices](https://help.apple.com/xcode/mac/current/#/deve69552ee5) to deploy your iOS app.

4. Add project permissions for microphone and camera usage.
  
   Open **info** in the project navigation panel, and add the following properties to the [Property List](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6):

   | Key | Type | Value |
   | --- | --- | --- |
   | `Privacy - Photo Library Usage Description` | String | For photo library access |
   | `Privacy - Microphone Usage Description` | String | For microphone access |
   | `Privacy - Camera Usage Description` | String | For camera access |
   | `App Transport Security Settings > Allow Arbitrary Loads` | Boolean | YES |

5. Integrate the UIKit into your project.

   1. Create a Podfile for your project.

      In the Terminal, navigate to the root directory of your Xcode project and run the following command:

      ```shell
      pod init
      ```
   2. Add dependencies to the UIKit in the Podfile.

      Open Podfile and replace the content with the following:

      ```shell
      platform :ios, '11.0'
      target 'EaseChatKitExample' do

      # Pods for EaseChatKitExample
      pod 'chat-uikit'
      pod 'Masonry'

      end
      ```
    
  3. Install the UIKit.

      In the Terminal, navigate to the root directory of your Xcode project and run the following command:

       ```shell
       pod install
       ```

  The Agora Chat UIKit is now added into your project.


## Implement peer-to-peer messaging

This section shows how to use Agora Chat UIKit to rapidly implement peer-to-peer messaging in your app.

### Initialize UIKit

Follow the steps to initialize the UIKit.

1. To import the header file, open `SceneDelegate.m` in **Xcode** and add the following lines to import the header file:

    ```objective-c
    #import <chat-uikit/EaseChatKit.h>
    #import "AgoraLoginViewController.h"
    #import <AgoraChat/AgoraChat.h>
    ```

2. Initialize the UIKit by calling the `initWithAgoraChatOptions` method. In `SceneDelegate.m`, replace the `willConnectToSession` method with the following code:

    ```objective-c
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

1. In **Xcode**, go to **File** > **New** > **File**, and create a **Cocoa Touch Class** file named `AgoraChatHttpRequest`. Make sure to set **Subclass of** as `NSObject`. Save the file under **AgoraChatUIKit**.

   ![](https://web-cdn.agora.io/docs-files/1643335917066)

2. Open `AgoraChatHttpRequest.h` and replace the code with the following:

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
    
    To register to the Agora Chat app server, open `AgoraChatHttpRequest.m` and replace the code with the following:

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
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
                NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                if(completionHandler)
                    completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
            }
    }

    @end
    ```

3. Go to **File** > **New** > **File** and create a **Cocoa Touch Class** file named `AgoraLoginViewController`. Make sure to set **Subclass of** as `UIViewController`.

4. To import the header file, open `AgoraLoginViewController.m` and add the following lines:

    ```objective-c
    #import "AgoraChatHttpRequest.h" // To send request to the Appserver
    #import <AgoraChat/AgoraChat.h> //Agora Chat SDK
    #import "ViewController.h"
    ```

   To sign up, add the following lines after `@implementation AgoraLoginViewController`:

    ```objective-c
    // Register to the AppServer
    - (void)doSignUp {
    // Set the chat ID as vvv
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

    ```objective-c
    - (void)viewDidLoad {
        [super viewDidLoad];
        [self doSignIn];
        // Do any additional setup after loading the view.
    }
    ```

### Launch the chat storyboard

In this section, add an input box for getting username of the peer user, and a **Chat** button that loads the chat storyboard.

In `ViewController.m`, add the following code:

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

In `ViewController.m`, replace the `viewDidLoad` method with the following code:

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

Add the following code in `ViewController.m` to create the input box and **Chat** button:

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

### Build the project

In **Xcode**, select an iPhone simulator and click **Start**. If the project builds successfully, you will see the user interface.

If the project build fails, and **Xcode** reports **Library not found for -IMasonry**, close the project and open **EaseChatKitExample.xcworkspace** (instead of **EaseChatKitExample.xcodeproj**) in **Xcode**, selector an iPhone simulator and click **Start**. 


## Test your app

When the app launches, you see the following interface and are logged into Agora Chat.

![](https://web-cdn.agora.io/docs-files/1643336848167)

To test the app, take the following steps:
1. Enter the **single chat ID**. A single chat ID is the user ID of a peer user and for testing purposes, you can simply input `abc`. 
2. Click **chat**. An edit box pops up. 
3. Enter the message in the edit box and click **Enter**, the message is sent and displayed in the UI.
4. You can also click **+** on the right of the edit box and try sending attachment messages.

## Reference

Agora provides the fully featured [AgoraChat-ios](https://github.com/AgoraIO-Usecase/AgoraChat-ios) demo app as an implementation reference. 
