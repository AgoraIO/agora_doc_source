本文详细介绍如何将灵动课堂集成到你自己的 Android 项目中。

## 模块说明

灵动课堂代码包含以下模块：

-   `app`:（可选）包括课堂登录界面、Token 生成等，展示了如何调用灵动课堂 API 进入教室房间。此模块在 GitHub 上开源，仅供参考，一般情况下不建议开发者直接使用。

<div class="alert note"><li>登录界面的某些规范（比如用户名、房间名的长度和字符限制）不适用于所有 app，开发者要根据自己的应用需求自行定义。</li><li>声网提供的客户端临时 Token 生成器仅适用于运行 app 模块快速测试。在正式环境中，为确保安全，你必须参考<a href="/cn/Real-time-Messaging/token_upgrade_rtm?platform=All%20Platforms">使用 Token 鉴权文档</a>，在服务端部署并生成 Token。生成的 token 传入的 <code>userId</code> 需要和 <code>launch</code> 方法中传入的参数 <code>userUuid</code> 保持一致，否则生成的 token 无效。</li></div>

- `AgoraEduUIKit`:（可选）教室 UI 实现，并展示了如何根据灵动课堂的 API 和数据回调进行 UI 数据的聚合和更新。此模块在 GitHub 上开源。一般情况下开发者可以基于这个模块开发自己的课堂 UI。

- `AgoraClassSDK`:（可选）提供一些常用的方法，如配置 SDK、启动教室、注册 ext app 等功能，同时提供各场景的 Activity 实现。此模块在 GitHub 上开源。开发者可能用到其中的某些功能，建议保留。

- `AgoraEduCore`:（必需）灵动课堂的核心模块。自 2.0.0 版起，此模块闭源，开发者使用远程依赖引入。


模块依赖关系：

- App
	- AgoraClassSDK（教室模板）
	- AgoraEduUIKit（UI 组件）
	- AgoraEduCore（教室相关的能力）

其中 AgoraEduCore 为核心功能，AgoraEduUIKit 依赖 AgoraEduCore 模块。

## Maven 依赖集成

如果你使用灵动课堂的默认 UI，无需修改灵动课堂的代码，参考以下步骤通过 Maven 添加远程依赖集成完整的灵动课堂：

1. 在项目根目录的 `build.gradle` 文件中添加以下代码：

    ```
    repositories {
        maven { url 'https://jitpack.io' }
        google()
        mavenCentral()
        maven { url 'https://s01.oss.sonatype.org/content/repositories/snapshots/' }
    }
    ```

2. 在项目根目录的 `build.gradle` 文件中添加以下依赖，引入 `AgoraEduUIKit`、`AgoraClassSDK`、`AgoraEduCore` 模块：

    ```
    dependencies {
        implementation "io.github.agoraio-community:AgoraEduCore:版本号"
        implementation "io.github.agoraio-community:AgoraEduUIKit:版本号"
        implementation "io.github.agoraio-community:AgoraClassSDK:版本号"
    }
    ```

	例如，你想获取 2.8.20 的版本：

    ```
    dependencies {
        implementation "io.github.agoraio-community:AgoraEduCore:2.8.20"
        implementation "io.github.agoraio-community:AgoraEduUIKit:2.8.20"
        implementation "io.github.agoraio-community:AgoraClassSDK:2.8.20"
     }
    ```

	如果你想使用 2.7.0 及以下版本，还需要添加以下代码依赖 hyphenate 模块：

    ```
    implementation "io.github.agoraio-community:hyphenate:版本号"
    ```

    <div class="alert info">点击<a href="https://search.maven.org/search?q=io.github.agoraio-community" target="_blank">此处</a>查看灵动课堂最新版本。</div>

3. 调用 [AgoraClassroomSDK.launch](/cn/agora-class/agora_class_api_ref_android?platform=Android#launch) 方法启动课堂。示例代码如下：

    ```kotlin
    // 启动教室前，需要动态申请 `Manifest.permission.RECORD_AUDIO` 和 `Manifest.permission.CAMERA` 权限
    fun startClassRoom() {
        val appId = ""           // 填入你的 App ID
        val rtmToken = ""        // 填入你的 RTM Token
        val userName = "Tom"   	 // 填入你的用户名
        val roomName = "MyRoom"  // 填入你的房间名
        val roomType = RoomType.SMALL_CLASS.value                     // 班型： 0 一对一 2大班课 4小班课
        val roleType = AgoraEduRoleType.AgoraEduRoleTypeStudent.value // 角色：1:老师角色 2:学生角色
        val roomUuid = HashUtil.md5(roomName).plus(roomType).lowercase()
        val userUuid = HashUtil.md5(userName).plus(roleType).lowercase()
        val roomRegion = AgoraEduRegion.cn  // 区域
        val duration = 1800L                // 课程时长
    
        val config = AgoraEduLaunchConfig(
            userName,
            userUuid,
            roomName,
            roomUuid,
            roleType,
            roomType,
            rtmToken,
            null,
            duration
        )
    
        config.appId = appId
        config.region = roomRegion
        // 设置大窗视频区域参数（大流）
        config.videoEncoderConfig = EduContextVideoEncoderConfig(
            FcrStreamParameters.HeightStream.width,
	        FcrStreamParameters.HeightStream.height,
            FcrStreamParameters.HeightStream.frameRate,
            FcrStreamParameters.HeightStream.bitRate
        )
    
        AgoraClassroomSDK.setConfig(AgoraClassSdkConfig(appId))
        AgoraClassroomSDK.launch(this, config, AgoraEduLaunchCallback { event ->
            Log.e("agora", ":launch-课堂状态:" + event.name)
        })
    }
    ```

    可以通过设置 `FcrStreamParameters` 设置大小窗的视频参数，其中

    - 小流模式：在讲台区的时候，会切换到小流模式，该参数表示讲台区的视频窗的参数
    - 大流模式：在大窗区域的时候，会切换到大流模式，该参数表示大窗上的视频窗的参数

    ```kotlin
    public class FcrStreamParameters {
        // 小流
        public static class LowStream {
            public static int width = 320;
            public static int height = 240;
            public static int frameRate = 15;
            public static int bitRate = 200;
        }

        // 大流
        public static class HeightStream {
            public static int width = 640;
            public static int height = 480;
            public static int frameRate = 15;
            public static int bitRate = 600;
        }
    }
    ```

4. 设置暗黑模式

    因为切换至暗黑模式需要重启 Activity，为了兼容所有手机型号，建议直接在 `Application#onCreate` 中设置主题，参考以下示例代码

    ```
    void setDarkMode() {  
        // 在这里添加是否开启暗黑模式的逻辑
        boolean isDarkMode = ""  
        if (isDarkMode) {  
            SkinUtils.INSTANCE.setNightMode(true);  
        }  
    }
    ```

5. 为防止代码混淆，在 `/Gradle Scripts/proguard-rules.pro` 文件中添加以下代码：

    ```
    -keep class io.agora.**{*;}
    -keep class com.agora.**{*;}
    -keep class com.hyphenate.**{*;} 
    ```

## 集成注意事项

#### 第三方库说明

不管以何种方式集成灵动课堂，灵动课堂使用的第三方库可能和你自己的工程所依赖的第三方库产生版本冲突。这种情况下，你可通过 `exclude` 的方式或者是修改自己工程所依赖的版本解决冲突。