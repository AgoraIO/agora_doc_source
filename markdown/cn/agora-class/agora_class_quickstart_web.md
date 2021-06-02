---
title: 快速启动灵动课堂
platform: Web
updatedAt: 2021-03-12 06:15:43
---
根据本文指导在你的 Web 项目中快速集成 Agora Edu SDK 并调用 API 接入声网灵动课堂。

<div class="alert note"><li>开始前请确保满足接入声网灵动课堂的<a href="./agora_class_prep">前提条件</a>。<li>Web 既支持老师也支持学生。</div>

## 示例项目

Agora 在 GitHub 提供一个开源的[示例项目](https://github.com/AgoraIO-Community/CloudClass-Desktop)，演示了如何集成 Agora Edu SDK 并调用 API 接入声网灵动课堂。你可以下载并查看源代码。

Agora 还提供一个 [CodePen 示例项目](https://codepen.io/agoratechwriter/pen/OJRrOxg)。你可以在该示例项目中设置参数并运行，即刻体验声网灵动课堂。

## 准备开发环境

- 安装最新稳定版桌面端 [Google Chrome 浏览器](https://www.google.cn/chrome/)。
- 物理音视频采集设备，如内置摄像头和麦克风。

## 集成 Agora Edu SDK

你可以通过 CDN 获取 Agora Edu SDK。在你的项目的 HTML 文件中，添加如下代码：
```
<script src="https://download.agora.io/edu-apaas/edu_sdk_1.0.js"></script>
```

## 进行全局配置

首先，你需要进行 SDK 全局配置，包含以下参数：

| 参数    | 描述                                                         |
| :------ | :----------------------------------------------------------- |
| `appId` | Agora App ID，详见[前提条件中获取 Agora App ID](/agora_class_prep#step1)。 |

示例代码
```
AgoraEduSDK.config({
  // Agora App ID
  appId: '<YOUR AGORA APPID>',
})
```

## 启动课堂

你需要创建一个课堂实例，将该实例挂载在 Dom 元素上后调用 `launch` 方法即可进入教室。调用 `launch` 方法时，你需要传入一个 JSON 配置，包含以下参数：

| 参数       | 类型    | 描述                                                         |
| :--------- | :------ | :----------------------------------------------------------- |
| `rtmToken` | string  | 用于鉴权的 RTM Token，详见[前提条件中生成 RTM Token](./agora_class_prep#step5)。 |
| `userUuid` | string  | 用户 ID。这是用户的全局唯一标识，**需要与你生成 RTM Token 时使用的 UID 一致**。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `userName` | string  | 用户名，用于课堂内显示，长度在 64 字节以内。                 |
| `roomUuid` | string  | 课堂 ID。这是课堂的全局唯一标识。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomName` | string  | 课堂名，用于课堂内显示，长度在 64 字节以内。                 |
| `roleType` | number  | 用户在课堂中的角色，可设为：<li>`1`: 老师<li>`2`: 学生                 |
| `roomType` | number  | 课堂类型，可设为：<li>`0`: 1 对 1 互动教学。1 位老师对 1 名学生进行专属在线辅导教学。<li>`1`: 1 对 N 在线小班课。1 位教师对 N 名学生（2 ≤ N ≤ 16）进行在线辅导教学。<li>`2`: 互动直播大班课。一名老师进行教学，多名学生实时观看和收听，学生人数无上限。与此同时，学生可以“举手”请求发言，与老师进行实时音视频互动。 |
| `pretest`  | boolean | 是否开启课前设备检测：<li>`true`: 开启课前设备检测。开启后，在加入课堂前会弹出如下设备检测页面，测试终端用户的摄像头、麦克风和扬声器是否能正常工作。<img src="https://web-cdn.agora.io/docs-files/1611126581493" /> <li>`false`: 不开启课前设备检测。 |
| `language`  | string | 界面语言：<li>`zh`: 中文 <li>`en`: 英文 |

以下示例代码演示了如何以老师角色进入一个一对一互动教学的课堂。

```
AgoraEduSDK.launch(
  // 放置教育应用的 DOM 节点
  document.querySelector("#root1"),
  {
    rtmToken: "<YOUR AGORA RTM TOKEN>",
    userUuid: "userUuid",
    userName: "userName",
    roomUuid: "roomUuid",
    roomName: "roomName",
    roleType: 1,
    roomType: 0,
    pretest: true,
	  language: "en",
    listener: (evt) => {
       console.log("evt", evt)
    }
  }
).then(e => window.room$ = e)
```

成功运行后，你可以看到如下界面：

![](https://web-cdn.agora.io/docs-files/1611126476035)

