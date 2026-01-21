声网在 GitHub 上提供开源 [BeautyAPI](https://github.com/AgoraIO-Community/BeautyAPI/tree/main) 示例项目供你参考。本文介绍如何快速跑通该示例项目，体验字节火山美颜效果。

## 前提条件

- [Git](https://git-scm.com/downloads)
- [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html) 11
- [Android Studio](https://developer.android.com/studio/) 3.5 及以上
- Android 手机，版本 Android 5.0（API Level 21）及以上
- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)

<div class="alert note">声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。</div>

<a name = "create"></a>
## 创建声网项目

~f42d44d0-2ac7-11ee-b391-19a59cc2656e~

跑通示例项目时，你需要将**鉴权机制**设置为**调试模式：APP ID**。从头搭建 Android 项目集成美颜功能时，声网推荐你将**鉴权机制**设置为**安全模式：APP ID + Token**，以保障安全性。

## 克隆仓库

运行以下命令克隆仓库到本地：

```shell
git clone git@github.com:AgoraIO-Community/BeautyAPI.git
```

## 集成第三方美颜 SDK

1. 联系字节技术支持获取最新的美颜 SDK、美颜资源、美颜证书。

2. 下载并解压美颜 SDK，然后将 SDK 中如下文件添加到美颜示例项目对应的文件路径下：

    <table>
      <tr>
        <th>SDK 文件</th>
        <th>项目路径</th>
      </tr>
      <tr>
        <td>resource/LicenseBag.bundle</td>
        <td rowspan="5">app/src/main/assets/beauty_bytedance</td>
      </tr>
      <tr>
        <td>resource/ModelResource.bundle</td>
      </tr>
      <tr>
        <td>resource/ComposeMakeup.bundle</td>
      </tr>
      <tr>
        <td>resource/StickerResource.bundle</td>
      </tr>
      <tr>
        <td>resource/StickerResource.bundle</td>
      </tr>
    </table>

3. 在 `app/src/main/java/io/agora/beautyapi/demo/ByteDanceActivity.kt` 文件中，将 `LICENSE_NAME` 设置为申请到的证书文件名。

    ```kotlin
    // 这里的证书文件名只用于声网示例项目测试
    // 请替换成你的证书文件名
    private val LICENSE_NAME = "agora_test_20220805_20230815_io.agora.entfull_4.2.3.licbag"
    ```

4. 在 `app/build.gradle` 文件中，将 `applicationId` 修改为你的包名，例如 `com.example.app`。包名用于在设备上唯一标识应用程序。在开发应用时，你需要设置包名。在此处设置的包名需要与你申请美颜 SDK 时提供的包名一致。

    ```java
    android {
        defaultConfig {
            applicationId "io.agora.entfull"
            ...
        }
    }
    ```

## 配置示例项目

运行美颜项目前，你需要在 `local.properties` 文件中添加并设置如下参数：

```shell
AGORA_APP_ID = "YOUR_APP_ID"
```

你可以在[创建声网项目](#create)后，从控制台获取参数的值，详情如下：

| 参数 | 描述   | 获取方式 |
|----|----|----|
| `AGORA_APP_ID`    | 声网项目的 App ID     | [获取 App ID](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id)  |


## 编译并运行示例项目

1. 开启 Android 设备的开发者选项，打开 USB 调试，通过 USB 连接线将 Android 设备接入电脑。

2. 用 Android Studio 打开 `BeautyAPI/Android` 文件夹。

3. 在 Android Studio 中，点击 **Sync Project with Gradle Files** 按钮，让项目与 Gradle 文件同步。

4. 待同步成功后，点击 `Run 'app'`。片刻后，美颜应用便会安装到你的 Android 设备上。

5. 打开美颜应用，进行体验。
