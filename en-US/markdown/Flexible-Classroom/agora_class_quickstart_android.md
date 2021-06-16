$$ 36a3a780-c9c4-11eb-9521-2d3265d0c546
{
  "platform": "Android"
}
$$

## Understand the tech

~b89350c0-c9c3-11eb-9521-2d3265d0c546~

## Prerequsites

Before proceeding, you must have the following:

- An Agora project with an [Agora App ID](./Agora%20Platform/get_appid_token?platform=All%20Platforms#get-the-app-id) and the aPaaS service configured. See [Configure Flexible Classroom](./agora_class_prep).
- [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html).
- Android Studio 2.0 or later.
- Android 4.4 or later.
- An Android device.

## Launch a flexible classroom

This section shows how to launch a flexible classroom using the Agora Classroom SDK.

### 1. Get the Android project provided by Agora

To clone the Android project provided by Agora, run the following command:

```bash
git clone https://github.com/AgoraIO-Community/CloudClass-Android.git
```

### 2. Launch a flexible classroom

To launch a flexible classroom, do the following:

1. Open the CloudClass-Android project in Android Studio.

2. In `app/src/normal/res/values/string_config.xml`, replace `Agora App ID` and `Agora App Certificate` with [values from your Agora project](https://docs.agora.io/en/Agora%20Platform/get_appid_token).

   > For rapid testing, Agora provides an RTM Token Generator in the CloudClass-Android project to generate an RTM token with the Agora [App ID](./Agora%20Platform/get_appid_token?platform=All%20Platforms#get-the-app-id), [App Certificate](./Agora%20Platform/get_appid_token?platform=All%20Platforms#get-the-app-certificate), and a user ID.

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <resources>
           <string name="agora_app_id" translatable="false">Agora App ID</string>
           <string name="agora_app_cert" translatable="false">Agora App Certificate</string>
           <string name="agora_api_host" translatable="false">Agora API Host</string>
           <string name="agora_report_host" translatable="false">Report API Host</string>
   </resources>
   ```

3. Build the project in Android Studio, and run it on a simulator or a physical mobile device. You can see the following page:

   ![](https://web-cdn.agora.io/docs-files/1623315354864)

4. After passing in your room name and user name and selecting a classroom type, you join a classroom and see the following page:

   ![](https://web-cdn.agora.io/docs-files/1622431132516)


## See also

- You can intergrate the Agora Classroom SDK into your project through Gradle, as follows:

  1. Add the following library to your project's **build.gradle**:

     ```
     allprojects {
     		 repositories {
     			  ...
     			  maven { url 'https://jitpack.io' }
     		 }
     }
     ```

  2. Add the following dependency to your main module's **build.gradle**:

     ```
     dependencies {
          ...
     		 implementation project(path:':agoraui')
          implementation('com.github.AgoraIO-Community:CloudClass-Android:v1.1.0_region') {
              exclude group: 'com.github.AgoraIO-Community.CloudClass-Android', module: 'agoraui'
              exclude group: 'com.github.AgoraIO-Community.CloudClass-Android', module: 'educontext'
              exclude group: 'com.github.AgoraIO-Community.CloudClass-Android', module: 'extapp'
              }
     }	
     ```

