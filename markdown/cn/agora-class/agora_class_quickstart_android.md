---
title: 快速启动灵动课堂
platform: Android
updatedAt: 2021-03-12 06:14:40
---
根据本文指导在你的 Android 项目中快速集成 Agora Edu SDK 并调用 API 接入声网灵动课堂。

<div class="alert note"><li>开始前请确保满足接入声网灵动课堂的<a href="./agora_class_prep">前提条件</a>。<li>Android 仅支持学生。</div>

## 示例项目
Agora 在 GitHub 提供一个开源的[示例项目](https://github.com/AgoraIO-Community/CloudClass-Android)，演示了如何集成 Agora Edu SDK 并调用 API 接入声网灵动课堂。你可以下载并查看源代码。

## 准备开发环境

- [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html)。
- Android Studio 2.0 及以上。
- 一台 Android 设备。部分模拟机可能存在功能缺失或者性能问题，所以推荐使用真机。
- Android 4.4 或以上版本。
- 物理音视频采集设备，如内置摄像头和麦克风。

## 集成 Agora Edu SDK

你可以参考以下步骤，通过 Gradle 获取 Agora Edu SDK。

1. 在项目的 **build.gradle** 文件中添加以下库：
 ```
	allprojects {
		repositories {
			...
			maven { url 'https://jitpack.io' }
		}
	}
```

2. 在项目的 **build.gradle** 文件中添加以下依赖：

 ```
 	dependencies {
        ...
		// 请查看发版说明获取最新版本号
		implementation 'com.github.AgoraIO-Community:CloudClass-Android:v1.0.0'
	}
```
   

## 进行全局配置

首先，创建 `AgoraEduSDKConfig` 实例进行全局配置，然后调用 `setConfig` 方法传入该实例。`AgoraEduSDKConfig` 包含以下参数：

| 参数      | 描述                                                         |
| :-------- | :----------------------------------------------------------- |
| `appId`   | Agora App ID，详见[前提条件中获取 Agora App ID](./agora_class_prep#step1)。 |
| `eyeCare` | 是否开启护眼模式：<li>`false`:（默认）关闭护眼模式。<li>`true`: 开启护眼模式。 |

```
/**进行全局配置*/
//Agora App ID
String appId = "XXX";
//是否开启护眼模式
boolean eyeCare = false;
AgoraEduSDK.setConfig(new AgoraEduSDKConfig(appId, eyeCare));
```

## 启动课堂

初始化完成后，创建 `AgoraEduLaunchConfig` 实例进行课堂启动配置，然后调用 `launch` 方法传入该实例。`AgoraEduLaunchConfig` 包含以下参数：

| 参数       | 描述                                                         |
| :--------- | :----------------------------------------------------------- |
| `userName` | 用户名，用于课堂内显示，长度在 64 字节以内。                 |
| `userUuid` | 用户 ID。这是用户的全局唯一标识，**需要与你生成 RTM Token 时使用的 UID 一致**。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roleType` | 用户在课堂中的角色，可设为：<li>`AgoraEduRoleTypeStudent`: 学生 |
| `roomName` | 课堂名，用于课堂内显示，长度在 64 字节以内。                 |
| `roomUuid` | 课堂 ID。这是课堂的全局唯一标识。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomType` | 课堂类型，可设为：<li>`AgoraEduRoomType1V1`: 1 对 1 互动教学。1 位老师对 1 名学生进行专属在线辅导教学。<li>`AgoraEduRoomTypeSmall`: 1 对 N 在线小班课。1 位教师对 N 名学生（2 ≤ N ≤ 16）进行在线辅导教学。<li>`AgoraEduRoomTypeBig`: 互动直播大班课。一名老师进行教学，多名学生实时观看和收听，学生人数无上限。与此同时，学生可以“举手”请求发言，与老师进行实时音视频互动。 |
| `rtmToken` | 用于鉴权的 RTM Token，详见[前提条件中生成 RTM Token](./agora_class_prep#step5)。 |

```
/**教室启动配置*/
//用户名
String userName = "XXX";
//用户 ID，需要与你生成 RTM Token 时使用的 uid 一致
String userUUid = "XXX";
//教室名称
String roomName = "XXX";
//教室 ID
String roomUuid = "XXX";
//角色类型
int roleType = AgoraEduRoleType.AgoraEduRoleTypeStudent.getValue();
//教室类型
int roomType = AgoraEduRoomType.AgoraEduRoomType1V1.getValue()/AgoraEduRoomType.AgoraEduRoomTypeSmall.getValue()/AgoraEduRoomType.AgoraEduRoomTypeBig.getValue();
//RTM Token
String rtmToken = "";
AgoraEduLaunchConfig agoraEduLaunchConfig = new AgoraEduLaunchConfig(
        userName, userUuid, roomName, roomUuid, roleType, roomType, rtmToken);
AgoraEduClassRoom classRoom = AgoraEduSDK.launch(getApplicationContext(), agoraEduLaunchConfig, (state) -> {
    Log.e(TAG, "launch-课堂状态:" + state.name());
});
```

成功启动课堂后，你可以看到如下画面：
	
![](https://web-cdn.agora.io/docs-files/1611124997720)