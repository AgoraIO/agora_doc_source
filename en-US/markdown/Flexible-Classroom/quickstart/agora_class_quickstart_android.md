This document introduces how to get the source code of Agora Flexible Classroom (Android) from GitHub and run the project, so as to quickly launch a flexible classroom and experience the features.

## Understand the tech

~b89350c0-c9c3-11eb-9521-2d3265d0c546~

<a name="prerequisites"></a>

## Prerequisites

- Enable the [Flexible Classroom service](/en/agora-class/agora_class_enable?platform=Android) in Agora console.
- Get the [Agora App ID](/en/Agora%20Platform/get_appid_token#Get-app-id) and [App Certificate](/en/Agora%20Platform/get_appid_token#Get-app-certificate) in Agora console.
- An Android device. You may encounter unexpected issues on simulators, so Agora recommends using a physical device. In addition, the Android client of Flexible Classroom must be run on Android 5.0 or later.

## Set up the development environment

Running the web client of Flexible Classroom depends on Git, Android Studio, and Java Development Kit.

To prepare your development environment, refer to the following steps:

1. To download Git, click this [link](https://git-scm.com/downloads).
2. To download Android Studio, click the [link](https://developer.android.com/studio). Use Android Studio 4.1 or later. Agora recommends using the latest version.
3. To download the Java Development Kit, click the [link](https://www.oracle.com/java/technologies/javase-downloads.html).

## Get the source code

The source code of Flexible Classroom (Android) is in the [CloudClass-Android ](https://github.com/AgoraIO-Community/CloudClass-Android) repository. To download the source code to your local device, refer to the following steps:

1. To clone the repository, run the following command:

   ```bash
   git clone https://github.com/AgoraIO-Community/CloudClass-Android.git
   ```

2. To switch the branch, run the following command. Remember to replace {VERSION} with a specified version number:

   ```bash
   git checkout release/apaas/{VERSION}
   ```

   For example, if you want to switch to the branch of v2.1.0, just run the following command:

   ```bash
   git checkout release/apaas/2.1.0
   ```

   Agora recommends switching the branch of the latest release. The following image shows how to see the latest release branch in the GitHub repository:

   ![](https://web-cdn.agora.io/docs-files/1648636502733)

## Launch a flexible classroom

Follow these steps to launch a flexible classroom:

1. Import the CloudClass-Android project in Android Studio.

   ![](https://web-cdn.agora.io/docs-files/1648635239823)

2. (Optional) Configure the `appId`, `apiHost`, and `reportHost` parameters values in `app/res/values/string_config.xml`. If you do not configure these parameters, this project is run with a test App ID embedded by Agora. Before your project goes online, ensure that you replace the test App ID with your own valid App ID.

   ![](https://web-cdn.agora.io/docs-files/1648635527460)

3. Open the CloudClass-Android project in Android Studio, and run it on a physical mobile device. You can see the following page:

   ![](https://web-cdn.agora.io/docs-files/1623315354864)

4. To join a classroom, pass in a room name and user name, select a room type, and click **Enter**. You can see the following page:

   ![](https://web-cdn.agora.io/docs-files/1648635720196)

## Next steps

Satisfied with the features of Flexible Classroom and want to explore more? Next, you can [integrate Flexible Classroom into your own project](/en/agora-class/agora_class_integrate_android?platform=Android).
