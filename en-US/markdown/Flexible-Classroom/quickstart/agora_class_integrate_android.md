This page introduces how to add Flexible Classroom into your Android app.

## Understand the tech

### Module introduction

Flexible Classroom contains the following modules:

- `app`: This module contains code for the classroom login interface and a client-side token generator, showing how to call APIs to join a flexible classroom. This module is an open-source project available on GitHub and for reference only.

<div class="alert note"><li>Specifications defined for the login interface (such as the length requirement of the user name and the room name and character restrictions) do not apply to all apps. You need to define them according to your own business requirements.</li><li>The client-side token generator provided by Agora is only for rapid testing. When your app goes live, to ensure security, you must<a href="/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms"> deploy a server-side token generator and generate tokens</a> on your server. For details, see Authenticate Your Users with Tokens. .</li></div>

- `AgoraEduUIKit`: This module contains code for the classroom UI, showing how to call APIs to aggregate and update UI data. 此模块在 GitHub 上开源。 一般情况下开发者可以基于这个模块开发自己的课堂 UI。
- `AgoraClassSDK`:（可选）提供一些常用的方法，如配置 SDK、启动教室、注册 ext app 等功能，同时提供各场景的 Activity 实现。 此模块在 GitHub 上开源。 开发者可能用到其中的某些功能，建议保留。
- `AgoraEduCore`:（必需）灵动课堂的核心模块。 Since version 2.0.0, this module is closed source, and developers use remote dependencies to introduce it.
- `hyphenate`:（可选）环信聊天 IM 的 UI 和逻辑实现。 If the developer implements the IM module and replaces the part corresponding to the ring letter in the` AgoraEduUIkit` module, there is no need to introduce it.

### Module dependencies

- `AgoraEduCore` is a must-import module, and all other modules depend on it.
- Both `AgoraEduUIKit` and `AgoraClassSDK` depend on `AgoraEduCore`, and there is no dependency between them.
- `AgoraEduUIKit` relies on `hyphenate`.
- `hyphenate` relies on `AgoraEduCore`.
- `app` depends on all other modules.

## Integration methods

Choose any of the following integration methods according to your needs.

<a name="default_ui"></a>

### Use the default UI of Flexible Classroom

If you use the default UI of Flexible Classroom and do not need to modify the code of Flexible Classroom, you can refer to the following steps to add remote dependency and integrated Flexible Classroom:

1. Add the following library to your project's `build.gradle` file:

   ```
   buildscript {
       repositories {
           maven { url 'https://jitpack.io' }
           google()
           mavenCentral()
           }
      }

   allprojects {
       repositories {
           maven { url 'https://jitpack.io' }
           google()
           mavenCentral()
           }
       }
   ```

2. Add the following dependencies to the project's `build.gradle` file, and introduce four modules`: AgoraEduUIKit`, `AgoraClassSDK`, `AgoraEduCore`, and `hyphenate`:

   ```
   dependencies {
         ...
         implementation "io.github.agoraio-community:hyphenate:2.0.0"
         implementation "io.github.agoraio-community:AgoraEduCore:2.0.0"
         implementation "io.github.agoraio-community:AgoraEduUIKit:2.0.0"
         implementation "io.github.agoraio-community:AgoraClassSDK:2.0.0"
   }
   ```

<a name="change_default_ui"></a>

### Customize the default UI of Flexible Classroom

If you want to customize the default UI of Flexible Classroom, integrate Flexible Classroom as follows:

1. Run the following command to clone the [CloudClass-Android](https://github.com/AgoraIO-Community/CloudClass-Android) project and check out the latest release branch.

   ```
   git clone https://github.com/AgoraIO-Community/CloudClass-Android.git
   ```

   ```
   git checkout release/apaas/x.y.z
   ```

<div class="alert info">Replace x.y.z with the version number. To get the latest version number, see the <a href="/cn/agora-class/release_agora_class_android?platform=Android">release notes</a>.</div>

2. After successfully pulling the code, the dependencies between the modules have been configured by default. If your application does not need to import all the modules, delete the corresponding modules according to your needs and keep the above dependencies. By default, the `app` module imports and` compiles` all modules through `implementation`, and the dependencies between other modules are introduced by `compileOnly`. If you delete the `app` module, you need to rewrite the import method yourself.

3. To customize the classroom UI, you only need to modify the code in the` AgoraEduUIKit` module.

## See also

### Third-party libraries

No matter which method you choose, the third-party libraries used by Flexible Classroom may conflict with the third-party libraries on which your own project depends. You can use `exclude` to resolve this conflict or change the version that your project depends on.