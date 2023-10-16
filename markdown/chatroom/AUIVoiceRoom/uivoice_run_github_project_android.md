本文介绍如何快速跑通 [AUIVoiceRoom/iOS](https://github.com/AgoraIO-Community/AUIVoiceRoom/tree/main/iOS) 示例项目，体验在线语聊房。

如需更深入了解项目代码，请参考 [AUIScenesKit](https://github.com/AgoraIO-Community/AUIVoiceRoom/tree/main/iOS/AScenesKit) 和 [AUIKit](https://github.com/AgoraIO-Community/AUIKit/blob/main/iOS/README_zh.md)。

## 项目架构

//TODO


//TODO
```
┌─ Example                    	// Demo代码集成目录
│  ├─ VoiceRoomListActivity			// 主要提供 VoiceRoom 的房间列表页面
│  └─ VoiceRoomSettingActivity  	// 主要提供 VoiceRoom 的房间设置页面
├─ AUIScenesKit               	// 场景业务组装模块，目前只包含VoiceRoom
│  ├─ AUIVoiceRoomView       		// VoiceRoom房间容器View，用于拼接各个基础组件以及基础组件与Service的绑定
│  ├─ AUIVoiceRoomService    		// VoiceRoom房间Service，用于创建各个基础Service以及RTC/RTM/IM等的初始化
│  └─ Binder                 		// 把UI Components和Service关联起来的业务绑定模块
└─ AUiKit                     	// 包含基础组件和基础服务
   ├─ Service                   	// 相关基础组件服务类，包括麦位以及申请邀请上麦、点歌器、聊天服务、送礼服务、用户管理、合唱等
   ├─ UI Widgets                	// 基础UI组件，支持通过配置文件进行一键换肤
   └─ UI Components             	// 相关基础业务UI模块，包括麦位、申请邀请、聊天、送礼等，这些UI模块不包含任何业务逻辑，是纯UI模块
```


## 前提条件

- [Git](https://git-scm.com/downloads)
- [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html)
- [Android Studio](https://developer.android.com/studio/) 4.1 及以上
- Android 手机，版本 Android 5.0（API Level 21）及以上
- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)

<div class="alert note">声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。</div>


## 克隆仓库

1. 在根目录下运行以下命令克隆 `AUIVoiceRoom` 仓库到本地：

    ```shell
    git clone git@github.com:AgoraIO-Community/AUIVoiceRoom.git
    ```

2. 在 `AUIVoiceRoom` 目录下将 `AUIVoiceRoom` 所依赖的 `AUIKit` 拉取到本地：//TODO yf待删除 submodule，全局搜索；补充 maven

    ```shell
    cd ./AUIVoiceRoom
    git submodule init
    git submodule update
    ```

## 配置示例项目

1. 参考[使用语聊后端服务](//TODO)进行部署。

2. 创建 `AUIVoiceRoom/Android/local.properties` 文件并在该文件中设置你的后端服务主机地址：

    ```text
    SERVER_HOST= "Your_Host_Url"
    ```

    如果你暂时无意部署后端服务，可以使用 `https://service.agora.io/uikit-voiceroom`。这是声网为测试体验提供的地址，请你不要商用。


## 编译并运行示例项目

1. 开启 Android 设备的开发者选项，打开 USB 调试，通过 USB 连接线将 Android 设备接入电脑。

2. 用 Android Studio 打开 `AUIVoiceRoom/Android` 文件夹。

3. 在 Android Studio 中，点击 **Sync Project with Gradle Files** 按钮，以让项目与 Gradle 文件同步。

4. 待同步成功后，点击 `Run 'app'`。片刻后，语聊应用便会安装到你的 Android 设备上。

5. 打开应用，即可进行体验。房主可以创建语聊房；观众可以加入语聊房。

