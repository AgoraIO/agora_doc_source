本文介绍如何获取灵动课堂 Android 端 GitHub 源码并运行项目，快速启动并体验灵动课堂。

## 技术原理

~96d9aaf0-eb84-11eb-b768-51ffcd29c763~

<a name="prerequisites"></a>

## 前提条件

-   在 Agora 控制台[开通灵动课堂服务](/cn/agora-class/agora_class_enable?platform=Web)。
-   在 Agora 控制台获取 [Agora App ID](/cn/Agora%20Platform/get_appid_token#获取-app-id) 和 [App 证书](/cn/Agora%20Platform/get_appid_token#获取-app-证书)。
-   一台 Android 设备。模拟机可能出现功能缺失或者性能问题，所以 Agora 推荐使用真机。此外，灵动课堂 Android 端要求运行在 Android 5.0 或以上版本。

## 准备开发环境

在你的设备上运行灵动课堂依赖于 Git（用于下载源码）、Android Studio、Java Development Kit。

你可参考以下步骤准备开发环境：

1. 点击[链接](https://git-scm.com/downloads)前往下载 Git。
2. 点击[链接](https://developer.android.com/studio)前往下载 Android Studio。要求 Android Studio 4.1 以上版本，建议使用最新版本。
3. 点击[链接](https://www.oracle.com/java/technologies/javase-downloads.html)前往下载 Java Development Kit。

## 获取源码

灵动课堂 Android 端的源码位于 GitHub [CloudClass-Android](https://github.com/AgoraIO-Community/CloudClass-Android) 仓库，你可参考以下步骤获取源码：

1. 运行以下命令克隆仓库到本地：

    ```bash
    git clone https://github.com/AgoraIO-Community/CloudClass-Android.git
    ```

2. 运行以下命令切换分支至指定版本，将 {VERSION} 替换为要切换的版本号：

    ```bash
    git checkout release/apaas/{VERSION}
    ```

    例如要切换到 2.1.0 版本分支，执行以下命令：

    ```bash
    git checkout release/apaas/2.1.0
    ```

    Agora 建议你切换到最新发版分支。参考下图在 GitHub 仓库中查看最新发版分支：

    ![](https://web-cdn.agora.io/docs-files/1648636502733)

## 启动灵动课堂

参照以下步骤启动灵动课堂：

1. 在 Android Studio 中导入 CloudClass-Android 项目。

    ![](https://web-cdn.agora.io/docs-files/1648635239823)

2. （可选）修改 `app/res/values/string_config.xml` 文件中的 `appId`、 `apiHost`、`reportHost` 参数值。如果没有配置，则使用灵动课堂的测试 App ID 运行项目。如果是正式的项目，一定要替换成你自己的 App ID。

    ![](https://web-cdn.agora.io/docs-files/1648635527460)

3. 在 Android Studio 中编译并运行 CloudClass-Android 项目。运行成功后，你可以在 Android 设备上看到以下画面：

    ![](https://web-cdn.agora.io/docs-files/1648635613438)

4. 输入房间名、用户名，选择一种班型，然后点击**加入**，即可进入灵动课堂，看到以下画面：

    ![](https://web-cdn.agora.io/docs-files/1648635720196)

## 后续步骤

现在你已经初步体验了灵动课堂的功能，接下来可将[灵动课堂集成到你自己的项目中](/cn/agora-class/agora_class_integrate_android?platform=Android)。
