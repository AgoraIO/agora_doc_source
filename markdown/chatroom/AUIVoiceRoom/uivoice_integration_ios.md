本文介绍如何集成语聊 UIKit 来实现房间的创建、进入、和销毁。

## 示例项目

声网提供 [API-Examples-AUIKit/iOS/VoiceChatApp](https://github.com/AgoraIO-Community/API-Examples-AUIKit/tree/dev/ios/iOS/VoiceChatApp) 示例项目供你参考。


## 准备开发环境

### 前提条件

- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 14.0 及以上。
- iOS 设备，版本 13.0 及以上。
- 有效的苹果开发者账号。
- 可以访问互联网的计算机。确保你的网络环境没有部署防火墙，否则无法正常使用声网服务。
- 参考[开始使用声网平台](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)//TODO创建声网开发者账号和声网项目。

### 创建项目

本节介绍如何在 Xcode 创建项目：

1. [创建一个新的项目](https://help.apple.com/xcode/mac/current/#/dev07db0e578)，**Application** 选择 **App**，**Interface** 选择 **Storyboard**，**Language** 选择 **Swift**。

    <div class="alert note">如果你没有添加过开发团队信息，会看到 <b>Add account…</b> 按钮。点击该按钮并按照屏幕提示登入 Apple ID，点击 <b>Next</b>，完成后即可选择你的 Apple 账户作为开发团队。</div>

2. 为你的项目设置[自动签名](https://help.apple.com/xcode/mac/current/#/dev23aab79b4)。

3. 设置部署你的 app 的[目标设备](https://help.apple.com/xcode/mac/current/#/deve69552ee5)。

4. 设置 **Minimum Deployments** 为 iOS 13。

    ![](https://web-cdn.agora.io/docs-files/1697686309702)


5. 添加项目的设备权限。在项目导航栏中打开 `info.plist` 文件，编辑[属性列表](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6)，添加以下属性：

    | key                                    | type   | value                                                        |
    | -------------------------------------- | ------ | ------------------------------------------------------------ |
    | Privacy - Microphone Usage Description | String | 使用麦克风的目的，例如 for a live interactive streaming |

### （可选）部署后端




### 集成依赖

本节介绍如何集成语聊项目所需的 AScenesKit 和 AUIKit 依赖：

1. 开始前请确保你已安装 CocoaPods，如尚未安装 CocoaPods，参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。

2. 下载声网提供的 [AUIVoiceRoom/iOS/AScenesKit](https://github.com/AgoraIO-Community/AUIVoiceRoom/tree/dev/0.3.2/iOS/AScenesKit) 文件夹，并将该文件夹复制到与你的 `*.xcodeproj` 文件所在的同一级目录下。

3. 在终端里进入 `*.xcodeproj` 文件的上一级目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。

5. 打开 `Podfile` 文件，修改文件为如下内容。注意 target 和 path 的填写。

    ```shell
    source 'https://github.com/CocoaPods/Specs.git'
    platform :ios, '13.0'

    # target 需改为你的项目中实际的 Target 名称
    target 'AUIKitDemo' do
      use_frameworks!

      # path 需为 AScenesKit 依赖库的实际路径
      pod 'AScenesKit', :path => './AScenesKit'
    end

    post_install do |installer|
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
      end
    end
    ```

6. 在终端里进入 `*.xcodeproj` 文件的上一级目录，运行如下命令安装 AUIKit 依赖：

    ```shell
    pod update --verbose
    ```

    安装成功后，与 `*.xcodeproj` 文件所在的同一级目录下会出现一个 `*.xcworkspace` 文件。打开该文件即可体验安装了 AScenesKit 和 AUIKit 依赖的项目。

集成后，项目文件结构应如下：//TODO

![](https://web-cdn.agora.io/docs-files/1697685865359)


## 实现语聊房 //TODO



## 注意事项

### 问题排查

如果在 Xcode 15 编译项目时遇到 `Sandbox: rsync.samba(47334) deny(1) file-write-create...` 报错信息，你可以依次进行如下操作：

1. 在 Xcode 中选中 **PROJECT**，点击 **Build Settings**，在 Filter 搜索框中搜索 User Script Sandboxing，将该选项设为 **No**。
2. 选中 **TARGETS**，检查并确保 User Script Sandboxing 的设置为 **No**。

![](https://web-cdn.agora.io/docs-files/1697685882007)

### 后端部署

为方便你快速集成语聊房，声网已经帮你部署好后端，无需你进行操作。

声网在示例项目中提供的后端服务主机地址 `https://service.agora.io/uikit-voiceroom` 仅用于测试体验，请你不要商用。

如需将项目商用，请参考[配置示例项目](//TODO)部署后端并在项目中配置你的后端服务主机地址。

## 下一步

在创建、进入房间后，你可以参考如下业务流程图开发后续的麦位管理、聊天、礼物等功能模块。

![](https://web-cdn.agora.io/docs-files/1697095578162)