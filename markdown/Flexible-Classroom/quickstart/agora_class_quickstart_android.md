根据本文指导快速启动并体验灵动课堂。

## 技术原理

~96d9aaf0-eb84-11eb-b768-51ffcd29c763~

<a name="prerequisites"></a>

## 前提条件

-   已在 Agora 控制台创建 Agora 项目，获取 <a href="/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-id" target="_blank">Agora App ID</a>、<a href="/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-%E8%AF%81%E4%B9%A6" target="_blank">App 证书</a>并<a href="/cn/agora-class/agora_class_enable?platform=Android" target="_blank">开通灵动课堂服务</a>。
-   [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html)。
-   Android Studio 4.0 及以上。
-   Android 5.0 或以上版本。
-   一台 Android 设备。模拟机可能出现功能缺失或者性能问题，所以 Agora 推荐使用真机。

## 启动灵动课堂

参照以下步骤启动灵动课堂：

1. 运行以下命令将 [CloudClass-Android](https://github.com/AgoraIO-Community/CloudClass-Android) 项目克隆至本地，并切换至最新发版分支。

    ```
    git clone https://github.com/AgoraIO-Community/CloudClass-Android.git
    ```

    ```
    git checkout release/apaas/x.y.z
    ```

    <div class="alert info">x.y.z 请替换为版本号。你可在<a href="/cn/agora-class/release_agora_class_android?platform=Android">发版说明</a>中获取最新版本号。</div>

2. 在 Android Studio 中打开 CloudClass-Android 项目。

3. 将 `app/src/normal/res/values/string_config.xml` 文件中的 `Agora App ID` 和 `Agora App Certificate` 替换成[你的 App ID 和 App 证书](#prerequisites)。`Agora API Host` 和 `Report API Host` 无需替换，使用默认配置即可。

    ```xml
    <?xml version="1.0" encoding="utf-8"?>
    <resources>
        <string name="agora_app_id" translatable="false">Agora App ID</string>
        <string name="agora_app_cert" translatable="false">Agora App Certificate</string>
        <string name="agora_api_host" translatable="false">Agora API Host</string>
        <string name="agora_report_host" translatable="false">Report API Host</string>
    </resources>
    ```

    <div class="alert info">为方便你快速测试，CloudClass-Android 项目中已包含一个临时 RTM Token 生成器，会用你传入的 App ID 和 App 证书生成一个临时 RTM Token。在正式环境中，为确保安全，RTM Token 必须在服务端生成。</div>

4. 在 Android Studio 中编译并运行 CloudClass-Android 项目。运行成功后，你可以在 Android 设备上看到以下画面：

    ![](https://web-cdn.agora.io/docs-files/1640783000891)

5. 输入房间名、用户名，选择一种班型，然后点击**加入**，即可进入灵动课堂，看到以下画面：

    ![](https://web-cdn.agora.io/docs-files/1640783012588)

## 后续步骤

现在你已经初步体验了灵动课堂的功能，接下来可将[灵动课堂集成到你自己的项目中](/cn/agora-class/agora_class_integrate_android?platform=Android)。
