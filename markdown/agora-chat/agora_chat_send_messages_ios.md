# 发送和接收文字消息

本文介绍如何通过少量代码集成 Agora Chat SDK，在你的 iOS 应用中实现发送和接收文字消息。

## 技术原理

（插 fragment）

## 前提条件

开始前，请确保满足以下条件：

- Xcode。本文 Xcode 的界面描述以 12.3 为例。
- iOS 10 或以上版本。

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
> 如果你没有添加过开发团队信息，会看到 Add account… 按钮。点击该按钮并按照屏幕提示登入 Apple ID，完成后即可选择你的 Apple 账户作为开发团队。
- 选择项目存储路径，并点击 Create。

### 集成 Agora Chat SDK

按照以下步骤使用 CocoaPods 将 Agora chat SDK 集成到你的项目中。

1. 开始前确保你已安装 CocoaPods。参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。
2. 在终端里进入项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。
3. 在 `Podfile` 文件里添加 Agora Chat SDK。注意将 `AgoraChatAPIExample` 替换为你的 Target 名称。

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

为帮助你快速体验发送和接收文字消息功能，Agora 已部署了一个 App Server 用于生成 Token。你需要参考以下步骤在客户端实现获取 Token：
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

## 实现发送和接收文字消息

在项目的 `ViewController.m` 文件里添加以下代码实现创建用户、登录和登出、发送和接收文字消息等逻辑：

```objective-c

```

## 运行项目

使用 Xcode 在 iOS 真机或模拟机上编译和运行项目。你可以看到以下界面：



参考以下步骤发送文字消息：
1. 输入任意的用户名（如 `Localuser` 和 `Remoteuser`）和密码，点击 `Create user` 创建两个用户用于互通。
2. 点击 `Log in` 登录 Agora Chat。
3. 输入 `Peer username` 后发送文字消息。

## 后续步骤

为保障通信安全，在正式生产环境中，你需要在自己的 app 服务端生成 Token。详见[使用 Token 鉴权](/cn/live-streaming/token_server)。

## 更多信息

### 集成 SDK 的其他方式

除上文介绍的使用 CocoaPods 集成 Agora Chat SDK，你还可以按照以下步骤手动集成 SDK：

1. 下载最新版的 [Agora Chat SDK for iOS]() 并解压。
2. 将 SDK 包内的 `AgoraChat.framework` 复制到项目文件夹中。`AgoraChat.framework` 包含 arm64，armv7，x86_64 指令集。
3. 打开 Xcode，进入 TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content 菜单。
4. 点击 + > Add Other… > Add Files 添加 AgoraChat.framework，并将Embed 属性设为 Embed & Sign。添加完成后，项目会自动链接所需系统库。