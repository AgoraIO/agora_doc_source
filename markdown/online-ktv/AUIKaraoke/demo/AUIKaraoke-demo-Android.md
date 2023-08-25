声网在 GitHub 上提供一个开源的 [AUIKaraoke 示例项目](https://github.com/AgoraIO-Community/AUIKitKaraoke/tree/main)。本文介绍如何快速跑通该示例项目，体验在线 K 歌场景。//TODO 和生动互娱的demo的描述之间的差异

## 前提条件

- [Git](https://git-scm.com/downloads)
- Android API Level 24 及以上
- Android Studio 3.5 及以上
- Android 设备，版本 Android 7.0 及以上
- [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html) 17 及以上

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

配置业务服务器域名。用 Android studio 打开 `AUIKitKaraoke/Android` 文件夹，在 `local.peoperties` 文件里配置业务服务器域名。你也可以直接使用声网用于测试的域名进行体验：https://service.agora.io/uikit-karaoke。

![image-20230822142250570](/Users/admin/Library/Application Support/typora-user-images/image-20230822142250570.png)

### 编译并运行示例项目

1. 开启 Android 设备的开发者选项，打开 USB 调试，通过 USB 连接线将 Android 设备接入电脑，并在 Android 设备选项中勾选你的 Android 设备。

2. 在 Android Studio 中，点击 **Sync Project with Gradle Files** 按钮，以让项目与 Gradle 文件同步。

3. 待同步成功后，点击 ![img](https://web-cdn.agora.io/docs-files/1687670569781) 开始编译。

4. 编译成功后，你的 Android 设备上会出现 **AUIKitKaraoke** app。

5. 打开 app，点击**创建房间**即可开始体验在线 K 歌。

   <img src="/Users/admin/Library/Application Support/typora-user-images/image-20230822164726767.png" alt="image-20230822164726767" style="zoom:30%;" />

## 参考信息

- 如需部署 K 歌业务后端服务，可参考[后台服务部署](https://github.com/AgoraIO-Community/AUIKitKaraoke/blob/main/backend/README_zh.md)。