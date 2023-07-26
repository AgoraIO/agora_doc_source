声网在 GitHub 上提供一个开源的秀场直播示例项目 [agora-ent-scenarios](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/v3.0.0.1-all-Android/Android/scenes/show)。本文介绍如何快速跑通该示例项目，体验直播效果。

## 前提条件

- [Git](https://git-scm.com/downloads)
- [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html)
- [Android Studio](https://developer.android.com/studio/) 4.1 及以上
- Android 手机，版本 Android 5.0（API Level 21）及以上
- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)

<div class="alert note">声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。</div>

<a name = "create"></a>
## 创建声网项目

~4c028930-19e2-11eb-b0e2-eb6c69fefbc6~

## 克隆仓库

运行以下命令克隆仓库到本地：

```shell
git clone git@github.com:AgoraIO-Usecase/agora-ent-scenarios.git
```


## 集成商汤美颜 SDK

1. 联系商汤技术支持获取最新的美颜 SDK 和测试证书。美颜 SDK 中包含 Android 和 iOS SDK。

2. 下载并解压美颜 SDK，然后将 SDK 中如下文件添加到秀场直播示例项目对应的文件路径下：

    | 用途|SDK 文件    |  项目路径   |
    |---|-----|-----|
    | 基础美颜| Android/aar/STMobileJNI-release.aar   | Android/scenes/show/aars/STMobileJNI/    |
    | 基础美颜| Android/smaple/SenseMeEffects/app/libs/SenseArSourceManager-release.aar   | Android/scenes/show/aars/SenseArSourceManager    |
    | 基础美颜| Android/models   | Android/scenes/show/src/main/assets/    |
    | 贴纸| Android/smaple/SenseMeEffects/app/src/main/assets/sticker_face_shape   |Android/scenes/show/src/main/assets/     |
    |风格妆| Android/smaple/SenseMeEffects/app/src/main/assets/style_lightly   | Android/scenes/show/src/main/assets/    |
    |证书 | 商汤证书SenseME.lic   |Android/scenes/show/src/main/assets/license/SenseME.lic     |

3. 在项目的 `build.gradle` 文件中，将 `applicationId` 修改为你的包名，例如 `com.example.app`。包名用于在设备上唯一标识应用程序。在开发应用时，你需要设置包名。在此处设置的包名需要与你申请 SDK 时提供的包名一致。

    ```java
    android {
        defaultConfig {
            applicationId "io.agora.entfull"
            ndk.abiFilters 'arm64-v8a', 'armeabi-v7a'//, 'arm64-v8a'//, 'x86', 'x86-64'
        }
    }
    ```

## 配置示例项目

1. 运行秀场直播项目前，你需要在 `gradle.properties` 文件中设置如下参数：

    ```shell
    AGORA_APP_ID=
    AGORA_APP_CERTIFICATE=
    CLOUD_PLAYER_KEY=
    CLOUD_PLAYER_SECRET=
    ```

    你可以在[创建声网项目](#create)后，从控制台获取这些参数的值，详情如下：

    | 参数 | 描述   | 获取方式 |
    |----|----|----|
    | AGORA_APP_ID    | 声网项目的 App ID     | [获取 App ID](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id)  |
    | AGORA_APP_CERTIFICATE | 声网项目的 App 证书 |[获取 App 证书](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-证书)   |
    | CLOUD_PLAYER_KEY | 声网输入在线媒体流 RESTful 服务所需的客户 ID       | [生成客户 ID 和密钥](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#生成客户-id-和密钥)    |
    | CLOUD_PLAYER_SECRET | 声网输入在线媒体流 RESTful 服务所需的客户密钥   | [生成客户 ID 和密钥](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#生成客户-id-和密钥)   |


2. `agora-ent-scenarios` 项目中包含在线 K 歌房、语聊房、语聊房（空间音频版）、秀场直播等模块，因此，运行秀场直播时，你可以在 `setting.gradle` 文件中注释掉其他模块。

    ```java
    // 注释掉与秀场直播无关的 module
    // if (!isKTVEmpty) {
    //     include ':scenes:ktv'
    // }
    // if (!isVoiceEmpty) {
    //     include ':scenes:voice'
    //     include ':scenes:voice:common'
    // }
    // if (!isSpatialVoiceEmpty) {
    //     include ':scenes:voice_spatial'
    //     include ':scenes:voice_spatial:common'
    // }

    if(!isShowEmpty){
        include ':scenes:show'
        include ':scenes:show:aars:SenseArSourceManager'
        include ':scenes:show:aars:STMobileJNI'
    }
    ```


## 编译并运行示例项目

1. 开启 Android 设备的开发者选项，打开 USB 调试，通过 USB 连接线将 Android 设备接入电脑。

2. 用 Android Studio 打开 `agora-ent-scenarios/Android` 文件夹。

3. 在 Android Studio 中，点击 **Sync Project with Gradle Files** 按钮，以让项目与 Gradle 文件同步。

4. 待同步成功后，点击 `Run 'app'`。片刻后，**声动互娱**应用便会安装到你的 Android 设备上。

5. 打开**声动互娱**应用，点击**秀场直播**，即可进行体验。主播可以创建房间；观众可以加入房间。

![](https://web-cdn.agora.io/docs-files/1684826793571)
