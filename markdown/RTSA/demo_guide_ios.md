---
title: 快速跑通示例项目
platform: iOS
updatedAt: 2020-11-24 07:38:26
---

本文指导开发者在将 RTSA SDK 集成到项目中之前，编译并运行模拟数据 Demo 进行初步了解。

## 前提条件

确保开发环境满足以下要求:

- Xcode 9.0 及以上。
- iOS 8.0 及以上真机（iPhone 或 iPad）。

获取以下文件：

- 最新版本的 Agora RTSA SDK for iOS。
- 模拟数据 Demo。

## 创建 Agora 账号并获取 App ID

1. 进入[控制台](https://console.agora.io/)，并按照屏幕提示注册账号并登录控制台。详见[创建新账号](sign_in_and_sign_up)。

2. 点击左侧导航栏的 ![](https://web-cdn.agora.io/docs-files/1551254998344) 图标进入[项目管理](https://console.agora.io/projects)页面，点击**创建**按钮。

![](https://web-cdn.agora.io/docs-files/1574156100068)

3. 在弹出的对话框内输入**项目名称**，选择 App ID 作为**鉴权机制**，再点击“提交”。

![](https://web-cdn.agora.io/docs-files/1574921599254)

4. 项目创建成功后，你会在**项目列表**下看到刚刚创建的项目，并找到对应的 App ID。

![](https://web-cdn.agora.io/docs-files/1574921811175)

## 编译运行模拟数据 Demo

步骤如下：

1. 配置 SDK。
   解压 RTSA SDK 包，将 SDK 包中的 AgoraRtcSDK.framework 放置于模拟数据 Demo 的 iOS/AgoraRtcServiceDemo 目录下。

2. 配置 App ID。
   在 AgoraRtcServiceDemo/KeyCenter.m 中填写你的 App ID。

```
(NSString *)appId {
    return <#MyAppId#>;
}
```

3. 在 Xcode 中打开 AgoraRtcServiceDemo.xcodeproj，设置有效的开发者签名。

4. 连接两台 iOS 设备，运行 Demo。在 Demo 中，你可以：

   1). 点击 Demo 下方按钮，进入频道并自动收发数据。

   2). 再次点击该按钮，退出频道，停止收发数据，并打印简略统计信息。
