This page introduces how to add Flexible Classroom into your iOS app.

## Understand the tech

### 模块介绍

灵动课堂代码包含以下模块：

- `app`: 包括课堂登录界面、Token 生成等，展示了如何调用灵动课堂 API 进入教室房间。 此模块开源，仅供参考，一般情况下不建议开发者直接使用。

<div class="alert note"><li>登录界面的某些规范（比如用户名、房间名的长度和字符限制）不适用于所有 app，开发者要根据自己的应用需求自行定义。</li><li>Agora 提供的客户端临时 Token 生成器仅适用于运行 app 模块快速测试。 。 但是在正式环境中，为确保安全，你必须在参考<a href="/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms">使用 Token 鉴权文档</a>，在服务端部署并生成 Token。</li></div>

- `AgoraEduUIKit`: 教室 UI 实现，并展示了如何根据灵动课堂的 API 和数据回调进行 UI 数据的聚合和更新。 此模块开源，可选，但通常开发者可以基于这个模块开发自己的课堂 UI。
- `AgoraClassSDK`: 提供一些常用的方法，如配置 SDK、启动教室、注册 ext app 等功能，同时提供各场景的 Activity 实现。 此模块开源，可选，但开发者可能用到其中的某些功能，建议保留。
- `AgoraEduCore`: 灵动课堂的核心模块，必须引入。 自 2.0.0 版起，此模块闭源，开发者使用远程依赖引入。
- `hyphenate`: 环信聊天 IM 的 UI 和逻辑实现。 一般情况下需要引入。 如果开发者自己实现 IM 模块并替换掉 `AgoraEduUIkit` 模块中对应环信的部分，则无需引入。

### 模块依赖关系

- `AgoraEduCore` 为必须引入的模块，其它模块均依赖它。
- `AgoraEduUIKit` 和 `AgoraClassSDK` 均依赖 `AgoraEduCore`，它们之间无依赖关系。
- `AgoraEduUIKit` 依赖 `hyphenate`。
- `hyphenate` 依赖 `AgoraEduCore`。
- `app` 依赖其它所有模块。

## 集成方式

根据你的实际需求选择以下任意一种集成方式。

<a name="default_ui"></a>

### Use the default UI of Flexible Classroom

如果你使用灵动课堂的默认 UI，无需修改灵动课堂的代码，则可参考以下步骤添加远程依赖集成灵动课堂：

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

2. 在项目的 `build.gradle` 文件中添加以下依赖，引入 `AgoraEduUIKit`、`AgoraClassSDK`、`AgoraEduCore` 和 `hyphenate` 四个模块：

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

1. 运行以下命令将 [CloudClass-Android](https://github.com/AgoraIO-Community/CloudClass-Android) 项目克隆至本地，并切换至最新发版分支。

   ```
   git clone https://github.com/AgoraIO-Community/CloudClass-Android.git
   ```

   ```
   git checkout release/apaas/x.y.z
   ```

<div class="alert info">x.y.z 请替换为版本号。 你可在<a href="/cn/agora-class/release_agora_class_android?platform=Android">发版说明</a>中获取最新版本号。</div>

2. 成功拉取代码后，各模块之间的依赖关系已默认配置好。 如果你的应用不需要引入全部的模块，则根据需求删除对应的模块，并保持以上的依赖关系。 默认情况下, `app` 模块通过 `implementation` 将所有的模块导入编译，其它模块之间的依赖关系均由 `compileOnly` 引入。 如果你删除 `app` 模块，则需要自行改写引入方式。

3. 如需自定义课堂 UI，你只需修改 `AgoraEduUIKit` 模块中的代码。

## See also

### 第三方库说明

不管以何种方式集成灵动课堂，灵动课堂使用的第三方库可能和你自己的工程所依赖的第三方库产生版本冲突。 这种情况下，你可通过 `exclude` 的方式或者是修改自己工程所依赖的版本解决冲突。