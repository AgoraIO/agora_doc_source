声网在 GitHub 上提供一个开源的 [MetaWorld](https://github.com/AgoraIO-Community/Agora-MetaWorld/tree/dev_metasdk1.0) 示例项目供你参考。

本文介绍如何快速跑通该示例项目，体验效果。

## 前提条件

- [Git](https://git-scm.com/downloads)
- [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html)
- [Android Studio](https://developer.android.com/studio/) 4.1 及以上
- Android API 级别 22 及以上
- Android 设备，版本 Android 5.1 及以上
    <div class="alert note">声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。</div>
- 有效的[声网账号](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#%E5%88%9B%E5%BB%BA%E5%A3%B0%E7%BD%91%E8%B4%A6%E5%8F%B7)

## 创建声网项目

1. 进入声网控制台的[项目管理](https://console.agora.io/projects)页面。

2. 在项目管理页面，点击**创建**按钮。

3. 在弹出的对话框内输入项目名称、使用场景，然后选择**安全模式：** **APP ID + Token**。

4. 点击**提交**按钮。新建的项目会显示在项目管理页中。

## 获取示例项目

1. 运行以下命令克隆仓库到本地：

```shell
git clone git@github.com:AgoraIO-Community/Agora-MetaWorld.git
```

2. 运行以下命令切换到 `dev_metasdk1.0` 分支：

```shell
git checkout dev_metasdk1.0
```

## 配置示例项目

### 集成 SDK 及依赖库

1. 联系 [sales@agora.io](mailto:sales@agora.io) 获取 Meta SDK，下载并解压。

2. 打开解压的 SDK，将以下文件或子文件夹复制到你的项目路径中。

  | 文件或子文件夹             | 项目路径     |
  |:-------------------------|:-----------|
  | `agora-rtc-sdk.jar` 文件	| `/app/libs/` |
  | `AgoraMetaKit.aar` 文件 	| `/app/libs/` |
  | `face_capture.jar` 文件   | `/app/libs/` |
  | `FaceCapture.aar` 文件    | `/app/libs/` |
  | `metakit.jar` 文件        | `/app/libs/` |
  | `arm64-v8a` 文件夹      	| `/app/src/main/jniLibs/` |
  | `armeabi-v7a` 文件夹	    | `/app/src/main/jniLibs/` |
  | `x86_64` 文件夹           | `/app/src/main/jniLibs/` |
  | `x86` 文件夹	            | `/app/src/main/jniLibs/` |

### 设置 ID 和证书

运行示例项目前，你需要在 `./Agora-MetaWorld/Android/local.properties` 文件中添加并设置如下参数：

```java
APP_CERTIFICATE="<#Certificate#>"
APP_ID="<#AppId#>"
FACE_CAP_APP_ID="<#Face Capture App Id#>"
FACE_CAP_APP_KEY="<#Face Capture Certificate#>"
```

在创建声网项目后，从控制台获取这些参數的值，详情如下：

| 参数  |  描述  | 获取方式 |
| ---- | ------ | ------ |
| Certificate | 声网项目的 App 证书 | [获取 App 证书](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-证书)   |
| AppId    | 声网项目的 App ID     | [获取 App ID](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id)  |
| Face Capture App Id<br>Face Capture Certificate | 声网面部捕捉插件 | 联系 [sales@agora.io](mailto:sales@agora.io) 获取 |

## 编译并运行示例项目

![](https://web-cdn.agora.io/docs-files/1687670439946)

1. 用 Android Studio 打开 `Agora-MetaWorld/Android` 文件夹。

2. 开启 Android 设备的开发者选项，打开 USB 调试，通过 USB 连接线将 Android 设备接入电脑，并在 Android 设备选项中勾选你的 Android 设备。

3. 在 Android Studio 中，点击 **Sync Project with Gradle Files** 按钮，以让项目与 Gradle 文件同步。

4. 待同步成功后，点击 <img src="https://web-cdn.agora.io/docs-files/1687670569781" width="25"/> 开始编译。

5. 编译成功后，你的 Android 设备上会出现 **AgoraMetaExample** 应用。

6. 打开应用，体验 MetaWorld 场景。登录后默认进入融合元语聊和元直播的场景，点击右上角的 <img src="https://web-cdn.agora.io/docs-files/1687670859690" width="25"/> 即可切换至元直播场景。

<div class="alert info">MetaWorld 包含元语聊和元直播场景：<ul><li>在元语聊场景中，用户可以在 3D 场景中自由走动，与其他用户或 NPC 进行语音聊天，开始 K 歌等。</li><li>在元直播场景中，用户可以在 3D 场景中直播。声网面部捕捉插件使用户可以通过模拟脸部表情的 Avatar 形象进行直播，增加直播趣味性。</li><li>在融合元语聊和元直播的场景中，用户可以进行在元语聊和元直播场景中支持的所有操作。</li></ul></div>