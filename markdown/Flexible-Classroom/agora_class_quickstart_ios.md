

根据本文指导快速在 iOS 设备上通过 Agora Classroom SDK 启动灵动课堂。

## 技术原理
下图展示了启动灵动课堂的基本流程。



当你的 app 客户端请求加入灵动课堂时：

1. 你的 app 服务端向你的 app 服务端请求获取 RTM Token 用于鉴权。
2. 你的 app 服务端使用 Agora App ID、App 证书和用户 ID 生成 RTM Token，返回给 app 客户端。详见[生成 RTM Token]()。
3. 你的 app 客户端调用 API 并传入以下参数加入灵动课堂：
   - 用户 ID：字符串，用户的唯一标识符，必须与你生成 RTM Token 时使用的用户 ID 保持一致。
   - 课堂 ID：字符串，课堂的唯一标识符。第一个用户加入课堂时，Agora 云服务会自动创建一个课堂。
   - RTM Token：用户在使用 Agora 服务，Agora 使用 Token 对其鉴权。

## 前提条件

- 在 Agora 控制台创建 Agora 项目，获取 [Agora App ID](/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-id)、[App 证书](/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-%E8%AF%81%E4%B9%A6)并[配置 aPaaS 服务](/cn/agora-class/agora_class_prep?platform=Web)。
- 灵动课堂使用 RTM Token 进行鉴权。在测试阶段，你可以使用 Agora 提供的[临时 RTM Token 生成器](https://webdemo.agora.io/token-builder/)，传入你获取到的 App ID 和 App 证书，然后自行填入一个用户 ID，快速生成一个临时 RTM Token，有效期为 24 小时。
- Xcode 10.0 或以上版本。
- CocoaPods 1.10 或以上版本。参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。
- iOS 10 或以上版本。
- 如果你使用 Swift 开发，请确保使用 Swift 5.3.2 或以上版本。
- 一台 iOS 真机（iPhone 或 iPad），配备物理音视频采集设备，如内置摄像头和麦克风。

## 启动灵动课堂

参考以下步骤启动灵动课堂：

1. 运行以下命令将 Agora 提供的灵动课堂 iOS 示例项目克隆至本地：

   ```
   git clone https://github.com/AgoraIO-Community/CloudClass-iOS
   ```

2. 

   

### 2. 加入课堂

参考以下步骤启动



参考以下步骤，通过 CocoaPods 在你的项目中集成 Agora Classroom SDK。

1. 在终端里进入你的项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。

2. 打开 `Podfile` 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称。

   ```
   # platform :ios, '10.0' use_frameworks!
   target 'Your App' do
       pod 'AgoraClassroomSDK'
   end
   ```

 <div class="alert info">1.0.0 版本请使用 <code>pod 'AgoraEduSDK'</code>。</div>

3. 在终端内运行 `pod install` 命令安装 SDK。成功安装后，Terminal 中会显示 `Pod installation complete!`，此时项目文件夹下会生成一个 `xcworkspace` 文件。
4. 打开新生成的 `xcworkspace` 文件。



自 v1.1.0 起，灵动课堂 iOS 端基于 Swift 语言进行开发。如果开发者基于 Object-C 语言开发，需要参考以下步骤在项目中创建一个 Swift 文件，生成 Swift 环境。

1. 在 Xcode 中打开 `ios/ProjectName.xcworkspace` 文件夹。
2. 点击 **File > New > File**， 选择 **iOS** > **Swift File**，点击 **Next** > **Create**，新建一个空的 `File.swift` 文件。

## 进行全局配置

首先，创建 `AgoraEduSDKConfig` 实例进行全局配置，然后调用 `setConfig` 方法传入该实例。`AgoraEduSDKConfig` 包含以下参数：

| 参数      | 描述                                                         |
| :-------- | :----------------------------------------------------------- |
| `appId`   | Agora App ID，详见[前提条件中获取 Agora App ID](./agora_class_prep#step1)。 |
| `eyeCare` | 是否开启护眼模式：<li>NO:（默认）关闭护眼模式。<li>YES: 开启护眼模式。 |

示例代码：
```swift
/** 全局配置 **/
@interface AgoraEduSDKConfig : NSObject
// Agora App ID
@property (nonatomic, copy) NSString *appId;
// 是否开启护眼模式
@property (nonatomic, assign) BOOL eyeCare;
@end
AgoraEduSDKConfig *defaultConfig = [[AgoraEduSDKConfig alloc] initWithAppId:appId eyeCare:eyeCare];
[AgoraEduSDK setConfig:defaultConfig];
```

## 启动课堂

初始化完成后，创建 `AgoraEduLaunchConfig` 实例进行课堂启动配置，然后调用 `launch` 方法传入该实例。`AgoraEduLaunchConfig` 包含以下参数：

| 参数        | 描述                                                         |
| :---------- | :----------------------------------------------------------- |
| `userName`  | 用户名，用于课堂内显示，长度在 64 字节以内。                 |
| `userUuid`  | 用户 ID。这是用户的全局唯一标识，**需要与你生成 RTM Token 时使用的 UID 一致**。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roleType`  | 用户在课堂中的角色，可设为：<li>`AgoraEduRoleTypeStudent`: 学生 |
| `roomName`  | 课堂名，用于课堂内显示，长度在 64 字节以内。                 |
| `roomUuid`  | 课堂 ID。这是课堂的全局唯一标识。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomType`  | 课堂类型，可设为：<li>`AgoraEduRoomType1V1`: 1 对 1 互动教学。1 位老师对 1 名学生进行专属在线辅导教学。<li>`AgoraEduRoomTypeSmall`: 在线互动小班课。1 位老师进行在线教学，多名学生实时观看和收听。课堂人数上限为 500。上课过程中，老师可邀请学生“上台”发言，与老师进行实时音视频互动。<li>`AgoraEduRoomTypeBig`: 互动直播大班课。1 位老师进行在线教学，多名学生实时观看和收听。学生人数无上限。上课过程中，学生可“举手”请求发言，与老师进行实时音视频互动。 |
| `rtmToken`  | 用于鉴权的 RTM Token，详见[前提条件中生成 RTM Token](./agora_class_prep#step5)。 |
| `startTime` | 课堂开始时间，单位为毫秒，以第一个进入课堂的用户传入的参数为准。 |
| `duration`  | 课堂持续时间，单位为秒，以第一个进入课堂的用户传入的参数为准。 |

```swift
/** 课堂启动配置 */
// 用户名
NSString *userName = @"XXX";
// 用户 ID，需要与你生成 RTM Token 时使用的用户 ID 一致
NSString *userUUid = @"XXX";
// 教室名称
NSString *roomName = @"XXX";
// 教室 ID
NSString *roomUuid = @"XXX";
// 用户角色
AgoraEduRoleType roleType = AgoraEduRoleTypeStudent;
// 课堂类型
AgoraEduRoomType roomType = AgoraEduRoomType1V1;
// RTM Token
NSString *rtmToken = "";
// 课堂开始时间，单位为毫秒，以第一个进入教室的用户传入的参数为准
NSNumber *startTime = @(XXX);
// 课堂持续时间，单位为秒，以第一个进入教室的用户传入的参数为准
NSNumber *duration = @(1800);

AgoraEduLaunchConfig *config = [[AgoraEduLaunchConfig alloc] initWithUserName:userName userUuid:userUuid roleType:roleType roomName:roomName roomUuid:roomUuid roomType:roomType token:rtmToken startTime:startTime duration:duration];
[AgoraEduSDK launch:config delegate:self];
```

成功启动课堂后，你可以看到如下画面：
![](https://web-cdn.agora.io/docs-files/1619164553801)