根据本文指导在你的 iOS 项目中快速集成 Agora Classroom SDK 并调用 API 启动灵动课堂。

<div class="alert note"><li>开始前请确保满足接入灵动课堂的<a href="./agora_class_prep">前提条件</a>。<li>iOS 仅支持学生。</div>

## 示例项目
Agora 在 GitHub 提供一个开源的[示例项目](https://github.com/AgoraIO-Community/CloudClass-iOS)，演示了如何集成 Agora Classroom SDK 并调用 API 启动灵动课堂。你可以下载并查看源代码。

## 准备开发环境

- Xcode 10.0 及以上。
- CocoaPods。参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。
- 一台 iOS 真机（iPhone 或 iPad）。
- iOS 10 或以上版本。
- 物理音视频采集设备，如内置摄像头和麦克风。

## 集成 Agora Classroom SDK

你可以参考以下步骤，通过 CocoaPods 获取 Agora Classroom SDK。

1. 在终端里进入你的项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。

2. 打开 `Podfile` 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称。

 ```
# platform :ios, '10.0' use_frameworks!
target 'Your App' do
    pod 'AgoraEduSDK'
end
 ```

3. 在终端内运行 `pod install` 命令安装 SDK。成功安装后，Terminal 中会显示 `Pod installation complete!`，此时项目文件夹下会生成一个 `xcworkspace` 文件。

4. 打开新生成的 `xcworkspace` 文件。

## 进行全局配置

首先，创建 `AgoraEduSDKConfig` 实例进行全局配置，然后调用 `setConfig` 方法传入该实例。`AgoraEduSDKConfig` 包含以下参数：

| 参数      | 描述                                                         |
| :-------- | :----------------------------------------------------------- |
| `appId`   | Agora App ID，详见[前提条件中获取 Agora App ID](./agora_class_prep#step1)。 |
| `eyeCare` | 是否开启护眼模式：<li>NO:（默认）关闭护眼模式。<li>YES: 开启护眼模式。 |

示例代码：
```
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
| `roomType`  | 课堂类型，可设为：<li>`AgoraEduRoomType1V1`: 1 对 1 互动教学。1 位老师对 1 名学生进行专属在线辅导教学。<li>`AgoraEduRoomTypeSmall`: 1 对 N 在线小班课。1 位教师对 N 名学生（2 ≤ N ≤ 16）进行在线辅导教学。<li>`AgoraEduRoomTypeBig`: 互动直播大班课。一名老师进行教学，多名学生实时观看和收听，学生人数无上限。与此同时，学生可以“举手”请求发言，与老师进行实时音视频互动。 |
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
// 课堂开始时间，以第一个进入教室的用户传入的参数为准
NSNumber *startTime = @(XXX);
// 课堂持续时间，单位为秒，以第一个进入教室的用户传入的参数为准
NSNumber *duration = @(1800);
 
AgoraEduLaunchConfig *config = [[AgoraEduLaunchConfig alloc] initWithUserName:userName userUuid:userUuid roleType:roleType roomName:roomName roomUuid:roomUuid roomType:roomType token:rtmToken startTime:startTime duration:duration];
[AgoraEduSDK launch:config delegate:self];
```

成功启动课堂后，你可以看到如下画面：
![](https://web-cdn.agora.io/docs-files/1619164553801)