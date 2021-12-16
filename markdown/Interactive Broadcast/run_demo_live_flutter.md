---
title: 跑通示例项目
platform: Flutter
updatedAt: 2021-03-12 03:56:57
---

## 前提条件

### 开发环境要求

如果你的目标平台为 iOS，你的开发环境需要满足以下需求：

- Flutter 1.0.0 或更高版本（暂不支持 Flutter 2.x）
- macOS 操作系统
- 最新版本的 Xcode

如果你的目标平台为 Android，你的开发环境需要满足以下需求：

- Flutter 1.0.0 或更高版本（暂不支持 Flutter 2.x）
- macOS 或 Windows 操作系统
- 最新版本的 Android Studio

### 运行环境要求

- 如果你的目标平台为 iOS，你需要有一台 iOS 的真机。
- 如果你的目标平台为 Android，你需要有一台 Android 真机或模拟器。

<div class="alert note">你需要运行 <code>flutter doctor</code> 命令检查开发环境和运行环境是否满足要求。</div>

### 其他要求

一个有效的 Agora [开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)。

## 操作步骤

### 1. 创建 Agora 项目 

按照以下步骤，在控制台创建一个 Agora 项目。

1. 登录 [Agora 控制台](https://console.agora.io/)，点击左侧导航栏 ![img](https://web-cdn.agora.io/docs-files/1594283671161) **项目管理**按钮进入**[项目管理](https://console.agora.io/projects)**页面**。**

2. 在**项目管理**页面，点击**创建**按钮。

 ![创建项目](https://web-cdn.agora.io/docs-files/1594287028966)

3. 在弹出的对话框内输入**项目名称**，选择**鉴权机制**为 **APP ID + Token。**

4. 点击**提交**，新建的项目就会显示在**项目管理**页中。

### 2. 获取 Agora 项目的 App ID

Agora 会给每个项目自动分配一个 App ID 作为项目唯一标识。

在 [Agora 控制台](https://console.agora.io/)的**项目管理**页面，找到你的项目，点击 App ID 右侧的眼睛图标就可以直接复制项目的 App ID。

![获取appid](https://web-cdn.agora.io/docs-files/1603974707121)
<div class="alert info">你需要在运行示例项目时填写 App ID。</div>

### 3. 生成临时 Token

为提高项目的安全性，Agora 使用 Token（动态密钥）对即将加入频道的用户进行鉴权。

为了方便测试，Agora 控制台提供生成临时 Token 的功能，具体步骤如下：

1. 在控制台的[项目管理](https://console.agora.io/projects)页面，点击已创建项目的 ![](https://web-cdn.agora.io/docs-files/1574923151660) 图标，打开 **Token** 页面。

	![](https://web-cdn.agora.io/docs-files/1574922827899)

2. 输入一个频道名，例如 test，然后点击**生成临时Token**。临时 Token 的有效期为 24 小时。加入频道时，请确保填入的频道名与生成临时 Token 时填入的频道名一致。

	![](https://web-cdn.agora.io/docs-files/1574928082984)

<div class="alert note">临时 Token 仅作为演示和测试用途。在生产环境中，你需要自行部署服务器签发 Token，详见<a href="token_server">生成 Token</a >。</div>

<div class="alert info">你需要在运行示例项目时填写临时 Token。</div>


### 4. 运行示例项目

1. 下载 [Agora-Flutter-Quickstart](https://github.com/AgoraIO-Community/Agora-Flutter-Quickstart) 仓库。打开 `settings.dart` (`lib/src/utils/settings.dart`)文件并添加 App ID 和 Token。

	```
const APP_ID = Your_App_ID;
const Token = Your_Token;
	```

2. 在仓库根目录运行以下命令安装依赖项。
   
	 ```bash
   flutter packages get
	 ```

3. 启动示例项目。

   ```bash
   flutter run
   ```

4. 在界面上输入频道名（必须是生成 Token 时使用的频道名）并选择角色，点击 Join 即可加入频道。

![](https://web-cdn.agora.io/docs-files/1605154454031)

## 运行效果

![](https://web-cdn.agora.io/docs-files/1605154751667)

## 常见问题

如果运行环境为 Android，对于中国大陆用户，运行 `flutter run` 时可能会卡在 `Running Gradle task 'assembleDebug'...` 或出现以下错误：

```dart
Running Gradle task 'assembleDebug'...
Exception in thread "main" java.net.ConnectException: Connection timed out: connect
```


解决方案如下：

1. 在相应 Android 项目的 `build.gradle` 文件中，对于 `google` 和 `jcenter` 使用国内镜像源。下面的示例代码使用了阿里镜像源。

```java
buildscript {
    ext.kotlin_version = '1.3.50'
    repositories {
        // google()
        // jcenter()
        maven { url 'https://maven.aliyun.com/repository/google' }
        maven { url 'https://maven.aliyun.com/repository/public' }
    }
 
...
 
allprojects {
    repositories {
        // google()
        // jcenter()
        maven { url 'https://maven.aliyun.com/repository/google' }
        maven { url 'https://maven.aliyun.com/repository/public' }
    }
}
```

2. 在相应 Android 项目的 `gradle-wrapper.properties` 文件中，将 `distributionUrl` 设为本地路径。以 gradle 5.6.4 为例，你可以将 `gradle-5.6.4-all.zip` 文件复制到 `gradle/wrapper` 目录，然后 `distributionUrl` 设置为：

```
distributionUrl=gradle-5.6.4-all.zip
```