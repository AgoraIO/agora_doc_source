本文件介绍如何集成声网 Meta SDK。

## 前提条件

- [Git](https://git-scm.com/downloads)
- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 12.0 及以上
- iOS 设备，版本 11.0 及以上
- 有效的苹果开发者账号
- 有效的[声网账号](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#%E5%88%9B%E5%BB%BA%E5%A3%B0%E7%BD%91%E8%B4%A6%E5%8F%B7)

<div class="alert note">声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。</div>

## 创建声网项目

1. 进入声网控制台的[项目管理](https://console.agora.io/projects)页面。
2. 在项目管理页面，点击**创建**按钮。
3. 在弹出的对话框内输入项目名称、使用场景，然后选择**安全模式：APP ID + Token**。
4. 点击**提交**按钮。新建的项目会显示在项目管理页中。

## 开通服务

1. 创建项目后，从控制台获取以下信息：
  - App ID：声网项目的 App ID。详见[获取 App ID](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id)。
  - App Certificate：声网项目的 App 证书。详见[获取 App 证书](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-证书)。
  - 频道名称：用于标识直播频道的字符串。
2. 联系 [sales@agora.io](mailto:sales@agora.io) 并供你的声网项目 App ID，以开通声网内容中心的权限并获取声网面部捕捉插件的 App ID 和 Certificate。

## 创建项目并集成 SDK

### 1. 创建项目

1. 如果你没项目文件，你需要创建新项目。参考[创建一个新的项目](https://help.apple.com/xcode/mac/current/#/dev07db0e578)文档创建，**Application** 选择 **App**，**Interface** 选择 **Storyboard**，**Language** 选择 **Swift**。

    <div class="alert note">如果你没有添加过开发团队信息，会看到 <b>Add account…</b> 按钮。点击该按钮并按照屏幕提示登入 Apple ID，点击 <b>Next</b>，完成后即可选择你的 Apple 账户作为开发团队。</div>

2. 为你的项目设置[自动签名](https://help.apple.com/xcode/mac/current/#/dev23aab79b4)。

3. 设置部署你的 app 的[目标设备](https://help.apple.com/xcode/mac/current/#/deve69552ee5)。

4. 添加项目的设备权限。在项目导航栏中打开 `info.plist` 文件，编辑[属性列表](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6)，添加以下属性：

    | key   | type   | value   |
    | ------------------- | ------ | ------------------------------------------------------------ |
    | Privacy - Microphone Usage Description | String | 使用麦克风的目的，例如 for a live interactive streaming |
    | Privacy - Camera Usage Description       | String | 使用摄像头的目的，例如 for a live interactive streaming |

<div class="alert note"><ul><li>如果你的项目中需要添加第三方插件或库（例如第三方摄像头），且该插件或库的签名与项目的签名不一致，你还需勾选 <b>Hardened Runtime</b> > <b>Runtime Exceptions</b> 中的 <b>Disable Library Validation</b>。</li><li>更多注意事项，可以参考 <a href="https://developer.apple.com/documentation/xcode/preparing_your_app_for_distribution">Preparing Your App for Distribution</a >。</li></ul></div>

### 2. 集成 SDK

声网 Meta SDK 是基于声网 RTC SDK 4.0.1 版开发的元系列特殊版 SDK。

1. 联系销售获取该 SDK，下载并解压。
2. 将 SDK 包内 `libs` 及路径下的文件，拷贝到你的项目路径下。
3. 打开 Xcode，[添加对应动态库](https://help.apple.com/xcode/mac/current/#/dev51a648b07)，确保添加的动态库 **Embed** 属性设置为 **Embed & Sign**。


<div class="alert note"><li>根据 Apple 官方要求，app 的 Extension 中不允许包含动态库。如果项目中的 Extension 需要集成 SDK，则添加动态库时需将文件状态改为 <b>Do Not Embed</b>。</li><li>声网 SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 <a href="mailto:sales@agora.io">sales@agora.io</a>。SDK 提供的库是 FAT Image，包含 32/64 位模拟器、32/64 位真机版本。</li></div>

### 3. 添加第三方依赖

参考[添加依赖库](https://help.apple.com/xcode/mac/current/#/dev51a648b07)文档添加如下依赖库，并将状态修改为 **Embed & Sign**：

- `libcrypto.a`
- `libssl.a`
- `libz.tbd`


## 下一步

集成后，你可以参考下一篇文档实现元语聊、元直播。