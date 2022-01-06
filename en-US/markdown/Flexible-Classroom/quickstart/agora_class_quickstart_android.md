This page introduces how to quickly launch a flexible classroom.

## Understand the tech

96d9aaf0-eb84-11eb-b768-51ffcd29c763

<a name="prerequisites"></a>

## Prerequisites

- 已在 Agora 控制台创建 Agora 项目，获取 // Agora App IDApp Certificate开通灵动课堂服务。
- Java Development Kit https://www.oracle.com/java/technologies/javase-downloads.html.
- Android Studio 4.0 or later.
- Android 5.0 or later.
- An Android device.  You may encounter unexpected issues on simulators, so Agora recommends using a real device.

## Launch a flexible classroom

Follow these steps to launch a flexible classroom:

1. Run the following command to clone the CloudClass-Androidhttps://github.com/AgoraIO-Community/CloudClass-Android project and check out the latest release branch.

   ```
   git clone https://github.com/AgoraIO-Community/CloudClass-Android.git
   ```

   ```
   git checkout release/apaas/x.y.z
   ```

<div class="alert info">Please replace x.y.z with the version number.  Get the latest version number in the release notes.</div>

2. 在 Android Studio 中打开 CloudClass-Android 项目。

3. Replace the Agora App ID and Agora App Certificate in the app/src/normal/res/values/string_config.xml file with your App ID and App certificate#prerequisites.  Agora API Host and Report API Host do not need to be replaced, just use the default configuration.

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <resources>
           <string name="agora_app_id" translatable="false">Agora App ID</string>
           <string name="agora_app_cert" translatable="false">Agora App Certificate</string>
           <string name="agora_api_host" translatable="false">Agora API Host</string>
           <string name="agora_report_host" translatable="false">Report API Host</string>
   </resources>
   ```

   To facilitate your quick testing, the CloudClass-Android project has included a temporary RTM Token generator, which will generate a temporary RTM Token with the App ID and App Certificate you passed in.  But in a formal environment, to ensure security, RTM Token must be generated on the server side.

4. 在 Android Studio 中编译并运行 CloudClass-Android 项目。  运行成功后，你可以在 Android 设备上看到以下画面：

   https://web-cdn.agora.io/docs-files/1624525202089

5. Enter the room name and user name, select a class type, and then click Join to enter the Flexible Classroom, and you will see the following screen:

   https://web-cdn.agora.io/docs-files/1624525202089

## Next steps

现在你已经初步体验了灵动课堂的功能，接下来可将灵动课堂集成到你自己的项目中/cn/agora-class/agora_class_integrate_android?platform=Android。