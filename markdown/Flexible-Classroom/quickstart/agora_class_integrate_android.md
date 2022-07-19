本文详细介绍如何将灵动课堂集成到你自己的 Android 项目中。

## 技术原理

### 模块介绍

灵动课堂代码包含以下模块：

-   `app`:（可选）包括课堂登录界面、Token 生成等，展示了如何调用灵动课堂 API 进入教室房间。此模块在 GitHub 上开源，仅供参考，一般情况下不建议开发者直接使用。

<div class="alert note"><li>登录界面的某些规范（比如用户名、房间名的长度和字符限制）不适用于所有 app，开发者要根据自己的应用需求自行定义。</li><li>Agora 提供的客户端临时 Token 生成器仅适用于运行 app 模块快速测试。在正式环境中，为确保安全，你必须在参考<a href="/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms">使用 Token 鉴权文档</a>，在服务端部署并生成 Token。</li></div>

-   `AgoraEduUIKit`:（可选）教室 UI 实现，并展示了如何根据灵动课堂的 API 和数据回调进行 UI 数据的聚合和更新。此模块在 GitHub 上开源。一般情况下开发者可以基于这个模块开发自己的课堂 UI。
-   `AgoraClassSDK`:（可选）提供一些常用的方法，如配置 SDK、启动教室、注册 ext app 等功能，同时提供各场景的 Activity 实现。此模块在 GitHub 上开源。开发者可能用到其中的某些功能，建议保留。
-   `AgoraEduCore`:（必需）灵动课堂的核心模块。自 2.0.0 版起，此模块闭源，开发者使用远程依赖引入。
-   `hyphenate`:（可选）课堂消息聊天功能的 UI 和逻辑，通过环信 IM SDK 实现。如果你自行实现课堂消息聊天功能并改写 `AgoraEduUIkit` 模块中课堂消息聊天功能相关的代码，则无需引入此模块。

### 模块依赖关系

-   `AgoraEduCore` 为必须引入的模块，其它模块均依赖它。
-   `AgoraEduUIKit` 和 `AgoraClassSDK` 均依赖 `AgoraEduCore`，它们之间无依赖关系。
-   `AgoraEduUIKit` 依赖 `hyphenate`。
-   `hyphenate` 依赖 `AgoraEduCore`。
-   `app` 依赖其它所有模块。

## 通过 Maven 集成灵动课堂

如果你使用灵动课堂的默认 UI，无需修改灵动课堂的代码，则可参考以下步骤通过 Maven 添加远程依赖集成完整的灵动课堂：

1. 在项目根目录的 `build.gradle` 文件中添加以下库：

    ```
    repositories {
        maven { url 'https://jitpack.io' }
        google()
        mavenCentral()
        maven { url 'https://s01.oss.sonatype.org/content/repositories/snapshots/' }
    }
    ```

2. 在项目根目录的 `build.gradle` 文件中添加以下依赖，引入 `AgoraEduUIKit`、`AgoraClassSDK`、`AgoraEduCore` 和 `hyphenate` 四个模块：

    ```
    dependencies {
          ...
        implementation "io.github.agoraio-community:hyphenate:版本号"
        implementation "io.github.agoraio-community:AgoraEduCore:版本号"
        implementation "io.github.agoraio-community:AgoraEduUIKit:版本号"
        implementation "io.github.agoraio-community:AgoraClassSDK:版本号"
    }
    ```

    假设你想获取 2.2.0 的版本，可以这样写：

    ```
    dependencies {
     implementation "io.github.agoraio-community:hyphenate:2.2.0"
     implementation "io.github.agoraio-community:AgoraEduCore:2.2.0"
     implementation "io.github.agoraio-community:AgoraEduUIKit:2.2.0"
     implementation "io.github.agoraio-community:AgoraClassSDK:2.2.0"
    }
    ```

    <div class="alert info">点击<a href="https://search.maven.org/search?q=io.github.agoraio-community" target="_blank">此处</a>查看灵动课堂最新版本。</div>

3. 调用 [AgoraClassroomSDK.setConfig](/cn/agora-class/agora_class_api_ref_android?platform=Android#setconfig) 和 [AgoraClassroomSDK.launch](/cn/agora-class/agora_class_api_ref_android?platform=Android#launch) 方法启动课堂。示例代码如下：

    ```kotlin
    fun startClassRoom() {
        val appId = "" // 填入你的 App ID。
        val rtmToken = "" // 填入你的 RTM Token。
        val streamState = AgoraEduStreamState(videoState = 1, audioState = 1)

        val config = AgoraEduLaunchConfig(
            "xiaoming", // 用户名。
            "xiaoming2", // 用户 ID。
            "agoraclass", // 房间名。
            "agoraclass4", // 房间 ID。
            2,  // 用户角色：1 为老师，2 为学生。
            4,  // 房间类型：0 为一对一，2 为大班课，4 为小班课。
            rtmToken,
            System.currentTimeMillis(), // 默认上课开始时间。
            1800L, // 上课持续时长。
            AgoraEduRegion.cn, // 默认区域。
            null,
            null,
            streamState, // 用户上台默认是否发流： 1 为是，0 为 否
            AgoraEduLatencyLevel.AgoraEduLatencyLevelUltraLow, // 默认延时等级
            null,
            null
        )

        config.appId = appId
        AgoraClassroomSDK.setConfig(AgoraClassSdkConfig(appId))
        AgoraClassroomSDK.launch(this, config, AgoraEduLaunchCallback { event ->
            Log.e(TAG, ":launch-课堂状态:" + event.name)
        }
    }
    ```

4. 为防止代码混淆，在 `/Gradle Scripts/proguard-rules.pro` 文件中添加以下代码：

    ```
    -keep class io.agora.**{*;}
    -keep class com.agora.**{*;}
    -keep class com.hyphenate.**{*;}
    ```

## 更多信息

### 第三方库说明

不管以何种方式集成灵动课堂，灵动课堂使用的第三方库可能和你自己的工程所依赖的第三方库产生版本冲突。这种情况下，你可通过 `exclude` 的方式或者是修改自己工程所依赖的版本解决冲突。
