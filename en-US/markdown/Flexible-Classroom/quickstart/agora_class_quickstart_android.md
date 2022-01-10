This page introduces how to quickly launch a flexible classroom.

## Understand the tech

~b89350c0-c9c3-11eb-9521-2d3265d0c546~

<a name="prerequisites"></a>

## Prerequisites

- An Agora project with an<a href="/en/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-id" target="_blank">Agora App ID</a>, <a href="/en/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-%E8%AF%81%E4%B9%A6" target="_blank">App Certificate</a>, and <a href="/en/agora-class/agora_class_enable?platform=Android" target="_blank">enable the Flexible Classroom service</a>.
- [Java Development Kit ](https://www.oracle.com/java/technologies/javase-downloads.html).
- Android Studio 4.0 or later.
- Android 5.0 or later.
- An Android device. You may encounter unexpected issues on simulators, so Agora recommends using a physical device.

## Launch a flexible classroom

Follow these steps to launch a flexible classroom:

1. Run the following command to clone the [CloudClass-Android](https://github.com/AgoraIO-Community/CloudClass-Android) project and check out the latest release branch.

   ```
   git clone https://github.com/AgoraIO-Community/CloudClass-Android.git
   ```

   ```
   git checkout release/apaas/x.y.z
   ```

   <div class="alert info">Replace x.y.z with the version number. To get the latest version number, see the <a href="/en/agora-class/release_agora_class_android?platform=Android">release notes</a>.</div>

2. Open the CloudClass-Android project in Android Studio.

3. Replace the `Agora App ID` and `Agora App Certificate` in the `app/src/normal/res/values/string_config.xml` file with [your App ID and App Certificate](#prerequisites). Leave `Agora API Host` and `Report API Host` as is.

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <resources>
           <string name="agora_app_id" translatable="false">Agora App ID</string>
           <string name="agora_app_cert" translatable="false">Agora App Certificate</string>
           <string name="agora_api_host" translatable="false">Agora API Host</string>
           <string name="agora_report_host" translatable="false">Report API Host</string>
   </resources>
   ```

   <div class="alert info">To facilitate your testing, the CloudClass-Android project contains an RTM Token generator, which can generate a temporary RTM Token with the App ID and App Certificate you pass in. When your project goes live, to ensure security, you must deploy the RTM Token generator on your server.</div>

4. Open the CloudClass-Android project in Android Studio, and run it on a physical mobile device. You can see the following page:

   ![](https://web-cdn.agora.io/docs-files/1623315354864)

5. To join a classroom, pass in a room name and user name, select a room type, and click **Enter**. You can see the following page:

   ![](https://web-cdn.agora.io/docs-files/1622431132516)

## Next steps

Satisfied with the features of Flexible Classroom and want to explore more? Next, you can [integrate Flexible Classroom into your own project](/en/agora-class/agora_class_integrate_android?platform=Android).