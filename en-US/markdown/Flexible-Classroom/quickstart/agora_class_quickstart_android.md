This page introduces how to quickly launch a flexible classroom.

## Understand the tech

~96d9aaf0-eb84-11eb-b768-51ffcd29c763~

<a name="prerequisites"></a>

## Prerequisites

- An Agora project with an<a href="/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-id" target="_blank">Agora App ID</a>, <a href="/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-%E8%AF%81%E4%B9%A6" target="_blank">App Certificate</a>, and <a href="/cn/agora-class/agora_class_enable?platform=Android" target="_blank">enable the Flexible Classroom service</a>.
- [Java Development Kit ](https://www.oracle.com/java/technologies/javase-downloads.html).
- Android Studio 4.0 or later.
- Android 5.0 or later.
- An Android device. You may encounter unexpected issues on simulators, so Agora recommends using a real device.

## Launch a flexible classroom

Follow these steps to launch a flexible classroom:

1. Run the following command to clone the [CloudClass-Android](https://github.com/AgoraIO-Community/CloudClass-Android) project and check out the latest release branch.

   ```
   git clone https://github.com/AgoraIO-Community/CloudClass-Android.git
   ```

   ```
   git checkout release/apaas/x.y.z
   ```

<div class="alert info">Replace x.y.z with the version number. To get the latest version number, see the <a href="/cn/agora-class/release_agora_class_android?platform=Android">release notes</a>.</div>

2. Open the CloudClass-Android project in Android Studio.

3. Replace the `Agora App ID` and `Agora App Certificate` in the `app/src/normal/res/values/string_config.xml` file with [your App ID and App Certificate](#prerequisites). Leave `Agora API Host` and `Report API Host` do not need to be replaced, just use the default configuration.

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <resources>
           <string name="agora_app_id" translatable="false">Agora App ID</string>
           <string name="agora_app_cert" translatable="false">Agora App Certificate</string>
           <string name="agora_api_host" translatable="false">Agora API Host</string>
           <string name="agora_report_host" translatable="false">Report API Host</string>
   </resources>
   ```

   To facilitate your quick testing, the CloudClass-Android project has included a temporary RTM Token generator, which will generate a temporary RTM Token with the App ID and App Certificate you passed in. But in a formal environment, to ensure security, RTM Token must be generated on the server side.

4. 在 Android Studio 中编译并运行 CloudClass-Android 项目。 运行成功后，你可以在 Android 设备上看到以下画面：

   ![](https://web-cdn.agora.io/docs-files/1624525202089)

5. Enter the room name and user name, select a class type, and then click **Join **to enter the Flexible Classroom, and you will see the following screen:

   ![](https://web-cdn.agora.io/docs-files/1624525202089)

## Next steps

现在你已经初步体验了灵动课堂的功能，接下来可将[灵动课堂集成到你自己的项目中](/cn/agora-class/agora_class_integrate_android?platform=Android)。