本文介绍如何通过声网场景化 API 集成商汤美颜到实时音视频中。

## 示例项目

声网在 GitHub 上提供开源 [BeautyAPI](https://github.com/AgoraIO-Community/BeautyAPI/tree/main) 示例项目供你参考。

## 准备开发环境

### 前提条件

- [Git](https://git-scm.com/downloads)
- [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started)
- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 12.0 及以上。
- iOS 设备，版本 13.0 及以上。
- 有效的苹果开发者账号。
- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)
- 已联系商汤技术获取最新的美颜 SDK、美颜资源、美颜证书


## 创建声网项目

~f42d44d0-2ac7-11ee-b391-19a59cc2656e~

跑通示例项目时，你需要将**鉴权机制**设置为**调试模式：APP ID**。从头搭建 Android 项目集成美颜功能时，声网推荐你将**鉴权机制**设置为**安全模式：APP ID + Token**，以保障安全性。


### 创建 iOS 项目

在 Xcode 中进行以下操作，在你的 app 中实现秀场直播功能：

1. [创建一个新的项目](https://help.apple.com/xcode/mac/current/#/dev07db0e578)，**Application** 选择 **App**，**Interface** 选择 **Storyboard**，**Language** 选择 **Swift**。

    <div class="alert note">如果你没有添加过开发团队信息，会看到 <b>Add account…</b> 按钮。点击该按钮并按照屏幕提示登入 Apple ID，点击 <b>Next</b>，完成后即可选择你的 Apple 账户作为开发团队。</div>

2. 为你的项目设置[自动签名](https://help.apple.com/xcode/mac/current/#/dev23aab79b4)。

3. 设置部署你的 app 的[目标设备](https://help.apple.com/xcode/mac/current/#/deve69552ee5)。

4. 添加项目的设备权限。在项目导航栏中打开 `info.plist` 文件，编辑[属性列表](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6)，添加以下属性：

    | key                                    | type   | value                                                        |
    | -------------------------------------- | ------ | ------------------------------------------------------------ |
    | Privacy - Microphone Usage Description | String | 使用麦克风的目的，例如 for a live interactive streaming |
    | Privacy - Camera Usage Description       | String | 使用摄像头的目的，例如 for a live interactive streaming |

    <div class="alert note"><ul><li>如果你的项目中需要添加第三方插件或库（例如第三方摄像头），且该插件或库的签名与项目的签名不一致，你还需勾选 <b>Hardened Runtime</b> > <b>Runtime Exceptions</b> 中的 <b>Disable Library Validation</b>。</li><li>更多注意事项，可以参考 <a href="https://developer.apple.com/documentation/xcode/preparing_your_app_for_distribution">Preparing Your App for Distribution</a >。</li></ul></div>

5. 将声网 RTC SDK 和商汤美颜依赖库集成到你的项目。开始前请确保你已安装 CocoaPods，如尚未安装 CocoaPods，参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。

    1. 在终端里进入项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。
    2. 打开 `Podfile` 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称。

    ```shell
    platform :ios, '9.0'
    target 'Your App' do
    # x.y.z 请填写具体的 SDK 版本号，如 4.0.1 或 4.0.0.4
    # 可通过互动直播发版说明获取最新版本号
    pod 'AgoraRtcEngine_iOS', 'x.y.z'
    # 配置商汤美颜的依赖库
    pod 'SenseLib', :path => 'sense.podspec'
    end
    ```
6. 将商汤美颜 SDK 集成到你的项目中。请联系商汤技术支持获取美颜 SDK、美颜资源、证书等文件。下载并解压文件，然后添加到美颜项目对应的文件路径下：

    | 文件   | 项目路径      |
    |------------------|----------------|
    | SenseMe/remoteSourcesLib    | iOS/SenseLib/remoteSourcesLib              |
    | SenseMe/st_mobil_sdk | iOS/SenseLib/st_mobile_sdk  |
    |SenseMe/st_mobil_sdk/license/SENSEME.lic   | iOS/SenseLib/SENSEME.lic |

7. 将声网场景化 API 集成到你的项目中。添加 [iOS/BeautyAPi/BeautyAPI](https://github.com/AgoraIO-Community/BeautyAPI/tree/1.0.1.1/iOS/BeautyAPi/BeautyAPI) 目录下的文件到项目中，具体文件如下：

    - `Render/FURender` 文件
    - `BeautyAPI.h` 文件
    - `BeautyAPI.m` 文件
    - `BeautyConfig.h` 文件
    - `BeautyConfig.m` 文件

    为方便后续代码升级，请不要修改你添加的这些文件的名称。


7. 在终端内运行 <code>pod install</code> 命令安装声网 RTC SDK 和商汤美颜依赖。成功安装后，Terminal 中会显示 <code>Pod installation complete!</code>。

8. 成功安装后，项目文件夹下会生成一个后缀为 <code>.xcworkspace</code> 的文件，通过 Xcode 打开该文件进行后续操作。