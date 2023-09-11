本文介绍如何通过 [AUIKitKaraoke 组件](#link-to-description)快速搭建一个含 UI 界面的在线 K 歌房。

下图展示搭建 K 歌房间的完整流程：

<img src="/Users/admin/Library/Application Support/typora-user-images/image-20230830103826589.png" alt="image-20230830103826589" style="zoom:50%;" />

## 准备开发环境

### 前提条件

- [Git](https://git-scm.com/downloads)
- [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 1.12.1 及以上

- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 13.0 及以上

- iOS 设备，版本 13.0 及以上

  <Admonition type="info" title="信息">

  声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。

  </Admonition>

- 有效的苹果开发者账号

- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora Platform/sign_in_and_sign_up)和声网项目，请参考[开始使用声网平台](https://docs.agora.io/cn/Agora Platform/get_appid_token?platform=All Platforms)，从声网控制台获取以下信息：

  - App ID：声网随机生成的字符串，用于识别你的 app。
  - 临时 Token：你的 app 客户端加入频道时会使用 Token 对用户进行鉴权。临时 Token 的有效期为 24 小时。
  - rtm Token：

### 创建项目

按照以下步骤来准备开发环境：

1. 

