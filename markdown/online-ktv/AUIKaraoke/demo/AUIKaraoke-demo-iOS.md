声网在 GitHub 上提供一个开源的 [AUIKaraoke 示例项目](https://github.com/AgoraIO-Community/AUIKitKaraoke/tree/main)。本文介绍如何快速跑通该示例项目，体验在线 K 歌场景。//TODO 和生动互娱的demo的描述之间的差异

## 前提条件

- [Git](https://git-scm.com/downloads)
- [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 1.12.1 及以上

  <Admonition type="info" title="信息">

如果你的 CocoaPods 版本低于 1.12.1，在运行 <code>pod install</code> 命令时可能会报错，详见<a href="#reference">常见问题</a>。

 </Admonition>

- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 13.0 及以上
- iOS 设备，版本 13.0 及以上
- 有效的苹果开发者账号
- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora Platform/sign_in_and_sign_up)

<Admonition type="info" title="信息">

声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。

</Admonition>

## 操作步骤

### 获取示例项目

运行以下命令克隆仓库到本地：

```shell
git clone git@github.com:AgoraIO-Community/AUIKitKaraoke.git
```

### 配置示例项目

1. 配置业务服务器域名。

   在 `AUIKitKaraoke/KeyCenter.swift` 文件中添加你的业务服务器域名，你也可以直接使用声网测试域名来进行体验：https://service.agora.io/uikit-karaoke。

   ```swift
   static var HostUrl: String = "填入你的业务服务器域名"
   ```

2. 打开 `AUIKitKaraoke.xcodeproj` 文件，确保 **Minimum Deployments** 设为 **13.0**，**Project Document** 下的 **Project Format** 设为 **Xcode 13.0-compatible**。

   ![image-20230822110050483](/Users/admin/Library/Application Support/typora-user-images/image-20230822110050483.png)

3. 打开终端，在 `AUIKitKaraoke/iOS/Example` 目录下运行 `pod install` 命令来安装 SDK 和相关依赖。安装完成后，终端会显示 `Pod installation complete!`。使用 Xcode 打开项目文件夹下新生成的 `AUIKitKaraoke.xcworkspace` 文件。

### 编译并运行示例项目

1. 将 iOS 设备连接至电脑，在设备上打开 **设备 > 隐私与安全性 > 安全性**，打开**开发者模式**。

2. 在 Xcode 界面顶部的 **iOS Device** 选项中勾选你的 iOS 设备。

3. 在项目 **TARGETS** 下的 **Signing & Capabilities** 界面勾选 **Automatically manage signing**，然后在每一个 Target 下配置你的苹果开发者账号和 **Bundle Identifier**。

   ![image-20230821164918829](/Users/admin/Library/Application Support/typora-user-images/image-20230821164918829.png)

4. 点击 **Start the active scheme** 开始编译。

5. 编译成功后，你的 iOS 设备上会安装好 AUIKitKaraoke app。

6. 打开 app，点击创建房间即可开始体验在线 K 歌。

   <img src="/Users/admin/Library/Application Support/typora-user-images/image-20230821174535425.png" alt="image-20230821174535425" style="zoom:33%;" />

   <img src="/Users/admin/Library/Application Support/typora-user-images/image-20230821174751911.png" alt="image-20230821174751911" style="zoom:50%;" />

   

## 常见问题

本节提供跑通示例项目时可能遇到的常见问题及解决方案。

### CocoaPods 版本过低

如果你的 CocoaPods 版本低于 1.12.1，在跑通本示例项目时可能遇到如下报错：

```sh
can't modify frozen string: "[Xcodeproject] unknown object version (56).
```

### 解决方案

1. 升级 CocoaPods 版本。你可以通过运行下列命令来安装特定版本的 CocoaPods：

   ```shell
   # 指定你需要升级的 CocoaPods 版本，下列命令以 1.12.1 为例。
   gem install cocoapods -v 1.12.1
   ```

2. 重置 CocoaPods 缓存。有时候 CocoaPods 缓存可能导致问题，你可以通过运行以下命令来清除缓存。

   ```shell
   pod cache clean --all
   ```

3. 在 `AUIKitKaraoke/iOS/Example` 目录下运行 `pod install` 命令来安装 SDK 和相关依赖。安装完成后，终端会显示 `Pod installation complete!`。