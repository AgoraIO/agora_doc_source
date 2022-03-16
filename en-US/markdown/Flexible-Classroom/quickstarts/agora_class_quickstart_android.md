根据本文指导通过 Agora Classroom SDK 快速启动并体验灵动课堂。

## Understand the tech

~96d9aaf0-eb84-11eb-b768-51ffcd29c763~

<a name="prerequisites"></a>
## Prerequisites

- 已在 Agora 控制台创建 Agora 项目，获取 [Agora App ID](/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-id)、[App 证书](/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-%E8%AF%81%E4%B9%A6)并[配置 aPaaS 服务](/cn/agora-class/agora_class_prep?platform=Web)。
- [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html)。
- Android Studio 4.0 or later.
- Android 5.0 or later.
- An Android device. A physical Android device.

## Launches a flexible classroom.

参照以下步骤启动灵动课堂：

1. 运行以下命令将 Agora 提供的灵动课堂项目 CloudClass-Android 克隆至本地：

   ```
   git clone https://github.com/AgoraIO-Community/CloudClass-Android.git
   ```

2. 在 Android Studio 中打开 CloudClass-Android。

3. 将 `app/src/normal/res/values/string_config.xml` 文件中的 `Agora App ID` 和 `Agora App Certificate` 替换成[你的 App ID 和 App 证书](#prerequisites)。

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   resources
           <string name="agora_app_id" translatable="false">Agora App ID</string>
           <string name="agora_app_cert" translatable="false">Agora App Certificate</string>
           <string name="agora_api_host" translatable="false">Agora API Host</string>
           <string name="agora_report_host" translatable="false">Report API Host</string>
   resources
   ```

   为方便你快速测试，CloudClass-Android 项目中已包含一个临时 RTM Token 生成器，会用你传入的 App ID 和 App 证书生成一个临时 RTM Token。 但是在正式环境中，为确保安全，RTM Token 必须在服务端生成。

   你可在 `app/src/normal/java/io/agora/education/MainActivity2.kt` 文件中查看启动课堂的具体逻辑：

   1. 调用 [AgoraEduSDK.setConfig](/cn/agora-class/agora_class_api_ref_android?platform=Android#setconfig) 方法全局配置 SDK。
   2. 调用 [AgoraEduSDK.launch](/cn/agora-class/agora_class_api_ref_android?platform=Android#launch) 方法启动灵动课堂。

4. Build the project in Android Studio, and run it on a simulator or a physical mobile device. 你可以在 Android 设备上看到以下画面：

   ![](https://web-cdn.agora.io/docs-files/1624525158077)

5. 输入房间名、用户名，选择一种班型，然后点击**加入**，即可进入灵动课堂，看到以下画面：

   ![](https://web-cdn.agora.io/docs-files/1624525158077)

## Next steps

如果 Agora Classroom SDK 中默认的 UI 无法满足你的需求，你可以参考[自定义课堂 UI 文档](/cn/agora-class/agora_class_custom_ui_android?platform=Android)，获取 Agora Classroom SDK 的源码，自行修改灵动课堂的 UI，如更换颜色、调整布局。

## Additional

<a name="sdk"></a>
### Integrate the Agora Classroom SDK

你可以参考以下步骤，通过 [JitPack](https://jitpack.io/#AgoraIO-Community/CloudClass-Android) 将 Agora Classroom SDK 集成到你自己的 Android 项目中：

1. Add the following library to your project's **build.gradle** file:

   ```
   allprojects {
   	repositories {
   			...
   		  maven { url'http://maven.aliyun.com/nexus/content/groups/public' }
   		maven { url 'https://jitpack.io' }
   	}
   }
   ```

2. Add the following dependency to your project's **build.gradle** file:

   ```
   dependencies {
           ...
   			// 请访问 https://jitpack.io/#AgoraIO-Community/CloudClass-Android 获取最新 Tag
   		 implementation 'com.github.AgoraIO-Community:CloudClass-Android:v1.0.0'
   }
   ```
