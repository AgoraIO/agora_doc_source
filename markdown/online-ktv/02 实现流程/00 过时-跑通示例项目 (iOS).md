Agora 在 GitHub 上提供如下开源的在线 K 歌房示例项目，你可以选择其一进行体验：

- [独唱示例项目](https://github.com/AgoraIO-Usecase/Online-KTV)
- [合唱示例项目](https://github.com/AgoraIO-Usecase/Online-KTV/tree/chorus/Agora-Online-KTV-iOS)


## 前提条件

- Xcode 12.0 或以上版本。
- 已安装 [Cocoapods](https://guides.cocoapods.org/using/getting-started.html#getting-started)。
- iOS 11.0 或以上版本的设备。部分模拟机可能无法支持本项目的全部功能，所以推荐使用真机。
- [Python](https://www.python.org/) 3.X。
- 第三方云服务[命令行工具](https://leancloud.cn/docs/leanengine_cli.html)。
- 有效的 Agora 开发者账号，并生成客户 ID 和密钥。获取详情请参考[开始使用 Agora 平台](https://docs.agora.io/cn/AgoraPlatform/get_appid_token?platform=AllPlatforms#生成客户-id-和密钥)。
- 有效的 Agora 项目，获取项目的 App ID，并生成一个临时 Token。详情请参考[开始使用 Agora 平台](https://docs.agora.io/cn/AgoraPlatform/get_appid_token?platform=AllPlatforms)。
- 如果你的网络环境部署了防火墙，请参考[应用企业防火墙限制](https://docs.agora.io/cn/AgoraPlatform/firewall?platform=iOS)以正常使用 Agora 服务。

## 操作步骤

### 1. 获取和配置第三方云存储服务信息

<div class="alert note"> 如果你想跳过以下步骤快速体验示例项目，可以联系 Agora 技术支持获取第三方云服务测试信息。</div>

Agora 提供的在线 K 歌房示例项目使用了第三方云服务，因此你还需要获取该云服务的有关信息。具体步骤如下：

1. 前往[第三方云服务控制台](https://console.leancloud.cn/)注册账号，创建一个新的应用。
2. 应用创建成功后，点击左侧菜单栏的 **设置 > 应用凭证**，你可以点击右侧的复制按钮获取该应用的 AppID、AppKey 和 REST API 服务器地址。

 **![img](https://web-cdn.agora.io/docs-files/1623232859967)**

3. 点击 **设置 > 数据存储 > 服务设置**，勾选启用 **LiveQuery**。

4. 在终端中运行以下命令：    

 ```shell
   pip3 install leancloud
  ```

### 2. 配置示例项目

按照以下步骤配置示例项目：

1. 克隆在线 K 歌房合唱或独唱示例项目到本地，进入 `Agora-Online-KTV-iOS` 文件夹。
2. 打开 `Agora-Online-KTV-iOS/Core` 路径下的 `Config.swift` 文件，修改以下信息：
   - 将从 Agora 控制台获取的 Agora App ID 和临时 Token 分别填入 `AppId` 和 `Token`。
   - 将从[第 1 步](#1-获取和配置第三方云存储服务信息)获取的 AppID、AppKey、REST API 服务器地址分别填入 `LeanCloudAppId`、`LeanCloudAppKey` 和 `LeanCloudServerUrl`。
3. 打开 Online-KTV 文件夹下的 `LeanCloudHelp.py` 文件，将[第 1 步](#1-获取和配置第三方云存储服务信息)获取的 AppID 和 AppKey 填入 `appid` 和 `appkey`。
将在 Agora 控制台获取的客户 ID、密钥及 Agora App ID 分别填入 `customer_key`、`customer_secret` 及 `agora_app_id`。

### 3. 集成 Agora SDK

按照以下步骤将 Agora iOS SDK 集成到示例项目中。
1. 下载 [Agora 音频 SDK](https://download.agora.io/sdk/release/Agora_Native_SDK_for_iOS_v3.3.4.201_VOICE_20210706_6263_92788.zip) 并解压。
2. 将 SDK 包中 `libs` 目录下的 `.framework` 文件复制到 `Agora-Online-KTV-iOS/AgoraSDK/libs` 目录下。

### 4. 集成内容中心 

Agora 内容中心提供在线 K 歌房场景所需歌曲及歌曲配套信息，请按照如下步骤开通内容中心，并将内容中心集成到示例项目中：

1. 在[控制台](https://sso2.agora.io/cn/)开通内容中心权限并完成相关配置。详见[内容中心开通](/cn/online-ktv/ktv_song_rest?platform=All%20Platforms#开通服务)。

2. 将内容中心的歌曲数据导入至第三方云数据库。
   打开终端，运行以下命令：

   ```shell
	 python3 ./LeanCloudHelp.py
	 ```
<div class="alert note">请将运行 <code>LeanCloudHelp.py</code> 文件的机器外网地址添加到白名单中。 </div>

3. 部署第三方云函数。详见[第三方云服务命令行参考文档](https://leancloud.cn/docs/leanengine_cli.html)。
   打开第三方云服务的命令行工具，进入 `Online-KTV/Backend/testproject` 目录下，运行如下命令：

  ```shell
# 登录云服务
  lean login 
# 切换到你的云服务项目
   lean switch
# 部署云函数
   lean deploy --prod 1 
	 ```

### 5. 运行示例项目

按照以下步骤运行示例项目，体验在线 K 歌房：

1. 在终端里进入`Agora-Online-KTV-iOS` 文件夹，运行 `pod install` 命令链接所需的依赖库。链接成功后，终端会显示 `Pod installation complete!`，此时项目文件夹下会生成一个 `xcworkspace` 文件。
2. 在 Xcode 中打开刚刚生成的 `xcworkspace` 文件，连接 iOS 设备，设置开发者签名。
3. 点击 **Build** 按钮运行项目。运行成功后，你会在设备上看到安装好的在线 K 歌房应用。
4. 打开应用即可体验在线 K 歌房。