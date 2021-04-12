Use this guide to integrate the Agora Edu SDK into your Web project and call API to implement Agora Flexible Classroom.

<div class="alert note"><li>Before proceeding, ensure that you make the preparations required for Agora Flexible Classroom<a href="./agora_class_prep"></a>.<li>The Web client supports both teachers and students.</div>

## Sample project

Agora provides an open source [sample project](https://github.com/AgoraIO-Community/CloudClass-Desktop) on GitHub, which demonstrates how to integrate the Agora Edu SDK and call APIs to implement Agora Flexible Classroom. You can download and read the source code.

Agora also provides a[ sample project on CodePen](https://codepen.io/agoratechwriter/pen/OJRrOxg). 在完成[前提条件](https://docs.agora.io/cn/agora-class/agora_class_prep?platform=Web)的基础上，你只需在示例项目中传入 [Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep?platform=Web#1-创建-agora-项目并获取-app-id-和-app-证书)、[RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep?platform=Web#5-生成-rtm-token) 和用户 ID（需要与你生成 RTM Token 时使用的 UID 一致），即可运行示例项目体验灵动课堂。

## Set up the development environment

- The latest version of[ Google Chrome](https://www.google.cn/chrome/) on desktop.
- Physical media input devices, such as a built-in camera and a built-in microphone.

## 集成 Agora Classroom SDK

You can integrate the Agora Edu SDK into your project through the CDN. Add the following code to the line before <style> in your project.

```html
<script src="https://download.agora.io/edu-apaas/edu_sdk_1.0.js"></script>
```

## Global configuration

First, you need to configure the SDK globally, including the following parameters:

| Parameter | Description |
| :------ | :----------------------------------------------------------- |
| `appId` | The Agora App ID, see[ Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep?platform=Web#1-创建-agora-项目并获取-app-id-和-app-证书). |

```js
AgoraEduSDK.config({
   // Agora App ID
   appId: '<YOUR AGORA APPID>',
})
```

## Launch a classroom

You need to create a classroom instance, mount the instance on the Dom element and call the launch`` method to enter the classroom. When calling `launch`, you need to pass in a JSON object containing the following parameters:

| Parameter | Type | Description |
| :--------- | :------ | :----------------------------------------------------------- |
| `rtmToken` | string | The RTM token used for authentication, see[ Generate an RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep?platform=Web#5-生成-rtm-token). |
| `userUuid` | string | The user ID. This is the globally unique identifier of a user.**  Must be the same as the UID that you use for generating an RTM token**. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters: <li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `userName` | string | The user name for display in the classroom. The string length must be less than 64 bytes. |
| `roomUuid` | string | The room ID. This is the globally unique identifier of a classroom. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters: <li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomName` | string | The room name for display in the classroom. The string length must be less than 64 bytes. |
| `roleType` | number | The role of the user in the classroom:<li>`1`: Teacher.<li>`2`: Student. |
| `roomType` | number | The room type:<li>`0`: One-to-one Classroom. An online teacher gives an exclusive lesson to only one student.<li>`1`: Small Classroom. A teacher gives an online lesson to multiple students. The number of students in a small classroom should not exceed 16.<li>`2`: Lecture Hall. Thousands of students watch an online lecture. Students can "raise their hands" to interact with the teacher. |
| `pretest` | boolean | Whether to enable the pre-class device test:<li>`true`: Enable the pre-class device test. After this function is enabled, end users can see the following page before entering the classroom. They need to test whether their camera, microphone, and speaker can work properly.<li>`false`: Disable the pre-class device test. |
| `language` | string | The UI language:<li>`zh`: zh-CN.<li>`en`: en-US. |

The following sample code demonstrates how to enter a one-to-one classroom as a teacher.

```js
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

After successful launching a classroom, you can see the following page:

![](https://web-cdn.agora.io/docs-files/1611126476035)