---
title: Run the Sample Project
platform: Flutter
updatedAt: 2021-03-12 03:57:37
---
## Prerequisites

### Development environment

If your target platform is iOS, your development environment must meet the following requirements:

- Flutter 2.0.0 or later
- macOS
- Xcode (Latest version recommended)

If your target platform is Android, your development environment must meet the following requirements:

- Flutter 2.0.0 or later
- macOS or Windows 
- Android Studio (Latest version recommended)

### Deployment environment

- If your target platform is iOS, you need a real iOS device.
- If your target platform is Android, you need an Android simulator or a real Android device.

<div class="alert note">You need to run <code>flutter doctor</code> to check whether the development environment and the deployment environment are correct.</div>

### Other

A valid Agora [developer account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up).

## Steps to run

### Step 1. Create an Agora project

Take the following steps to create an Agora project in Agora Console.

1. Log in to Agora [Console](https://console.agora.io/) and click ![img](https://web-cdn.agora.io/docs-files/1551254998344) in the left navigation menu to enter the [Project Management](https://console.agora.io/projects) page.

2. Click **Create**.

   ![img](https://web-cdn.agora.io/docs-files/1574924327108)

3. Enter your project name, set the App ID authentication mechanism as **APP ID** in the dialog box, and click **Submit**.

4. When the project is created successfully, you can see the newly created project in the project list. Agora assigns an App ID to each project as the only identifier.

### Step 2. Get App ID

Click ![img](https://web-cdn.agora.io/docs-files/1592488399929) to view and copy the App ID.

![img](https://web-cdn.agora.io/docs-files/1574924570426)

### Step 3. Generate a temporary token 

To facilitate authentication at the test stage, Agora Console provides temporary tokens. Take the following steps to generate a temporary token:

1.  Project Management page, find the project for which you want to generate a temporary token, and click ![](https://web-cdn.agora.io/docs-files/1602841076825).![](https://web-cdn.agora.io/docs-files/1602841103054)
2. On the Token page, enter the name of the channel that you want to join, and click Generate Temp Token to get a temporary token.![](https://web-cdn.agora.io/docs-files/1602841110522)

When in a production environment, Agora recommends generating a token at your server by calling `buildTokenWithUid`. See [Generate a token](/en/Audio%20Broadcast/token_server).


### Step 4. Run the project

1. Download the [Agora-Flutter-Quickstart](https://github.com/AgoraIO-Community/Agora-Flutter-Quickstart) repository. Open `settings.dart` (`lib/src/utils/settings.dart`). Add App ID and Token.

	```
const APP_ID = Your_App_ID;
const Token = Your_Token;
	```

2. Run the following command to install dependencies.

	 ```bash
   flutter packages get
	 ```

3. Run the project.

   ```bash
   flutter run
   ```

## Project demonstration

![](https://web-cdn.agora.io/docs-files/1605159358492)

![](https://web-cdn.agora.io/docs-files/1605159364250)

## Common issues

If the deployment environment is Android, users in mainland China may get stuck in `Running Gradle task 'assembleDebug'...` or see the following error:

```
Running Gradle task 'assembleDebug'...
Exception in thread "main" java.net.ConnectException: Connection timed out: connect
```

Take the following steps to resolve this issue:

1. In the `build.gradle` file of the Android project, use mirrors in China for `google` and `jcenter.`

```
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

2. In the `gradle-wrapper.properties` file, set `distributionUrl` to a local file. For example, for gradle 5.6.4, you can copy `gradle-5.6.4-all.zip` to `gradle/wrapper` and set `distributionUrl` to:

```
distributionUrl=gradle-5.6.4-all.zip
```
