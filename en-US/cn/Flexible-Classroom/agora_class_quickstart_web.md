Use this guide to integrate the Agora Classroom SDK into your Web project and call APIs to launch a flexible classroom.

<div class="alert note"><li>Before proceeding, ensure that you make the preparations required for using Flexible Classroom<a href="./agora_class_prep"></a>.<li>On the Web client, a user can join a classroom as teachers and students.</div>

## Sample project

Agora provides an open-source [sample project](https://github.com/AgoraIO-Community/CloudClass-Desktop) on GitHub, which demonstrates how to integrate the Agora Classroom SDK and call APIs to launch a flexible classroom. You can download and read the source code.

## Set up the development environment

- The latest version of[ Google Chrome](https://www.google.cn/chrome/) on desktop.
- Physical media input devices, such as a built-in camera and a built-in microphone.

## Integrate the Agora Classroom SDK

### Use npm to get the SDK

This method requires npm. See Install npm for details[](https://www.npmjs.com.cn/getting-started/installing-node/).

1. Run the following command to install the SDK.

   ```bash
   npm install agora-classroom-sdk
   ```

2. Import the SDK in the index.js`` file:

   ```javascript
   import {AgoraEduSDK} from 'agora-classroom-sdk'
   ```


## Global configuration

Call the `AgoraEduSDK.config` method to configure the SDK globally. Set the following parameters when calling this method:

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

You need to create a classroom instance, mount the instance on a Dom element and call the launch`` method to enter the classroom. When calling `launch`, you need to pass in a JSON object containing the following parameters:

| Parameter | Category | Description |
| :--------- | :------ | :----------------------------------------------------------- |
| `rtmToken` | String | The RTM token used for authentication, see[ Generate an RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep?platform=Web#5-生成-rtm-token). |
| `userUuid` | String | User ID. This is the globally unique identifier of a user.** Must be the same as the User ID that you use for generating an RTM token**. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `userName` | String | The user name for display in the classroom. The string length must be less than 64 bytes. |
| `roomUuid` | String | The room ID. This is the globally unique identifier of a classroom. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomName` | String | The room name for display in the classroom. The string length must be less than 64 bytes. |
| `roleType` | EduRoleTypeEnum | The role of the user in the classroom:<li>`0`: Audience, only used for page recording.</li> <li>`1`: Teacher.</li><li>`2`: Student.</li><li>`3`: Teaching assistant.</li> |
| `roomType` | EduRoomTypeEnum | The room type:<li>`0`: One-to-one Classroom. An online teacher gives an exclusive lesson to only one student.<li>`2`: Lecture Hall. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. There is no upper limit on the number of students. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher.<li>`4`: Small Classroom. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. The maximum number of users in a classroom is 500. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher. |
| `listener` | ListenerCallback | The state of classroom launching. |
| `pretest` | boolean | Whether to enable the pre-class device test:<li>`true`: Enable the pre-class device test. After this function is enabled, end users can see a page for the device test before entering the classroom. They need to test whether their camera, microphone, and speaker can work properly.<li>`false`: Disable the pre-class device test. |
| `language` | LanguageEnum | The UI language:<li>`zh`: zh-CN.<li>`en`: en-US. |
| `startTime` | Number | The start time (ms) of the class, determined by the first user joining the classroom. |
| `duration` | Number | The duration (ms) of the class, determined by the first user joining the classroom. |
| `recordUrl` | String | (Optional) URL address to be recorded. Developers need to pass in the URL of the web page deployed by themselves for page recording, such as `https://cn.bing.com/recordUrl`. |
| `courseWareList` | CourseWareList | (Optional) The courseware configuration object for downloading the courseware assigned by the educational institution. This courseware cannot be added or deleted. After passing this object, the SDK downloads the courseware from the Agora cloud storage component to the local when launching the classroom. |
| `personalCourseWareList` | CourseWareList | (Optional) The courseware configuration object for downloading the courseware uploaded by a teacher. After passing this object, the SDK downloads the courseware from the Agora cloud storage component to the local when launching the classroom. |

The following sample code demonstrates how to enter a small classroom as a teacher.

```js
// Configure courseware
let resourceUuid = "xxxxx"
let resourceName = "my ppt slide"
let sceneInfos = []
let sceneInfo = {
    name: "1",
    ppt: {
        src: "pptx://....",
        width: 480,
        "height": 360
    }
}
sceneInfos.push(sceneInfo)

let courseWareList = [{
    resourceUuid,
    resourceName,
    size: 10000,
    updateTime: new Date().getTime(),
    ext: "pptx",
    url:null,
    scenes: sceneInfos,
    taskUuid: "xxxx",
    taskToken: "xxx",
    taskProgress: NetlessTaskProgress
}]

// Launch a classroom
AgoraEduSDK.launch(document.querySelector(`#${this.elem.id}`), {
    rtmToken: "<your rtm token>",
    userUuid: "test",
    userName: "teacher",
    roomUuid: "4321",
    roleType: 1,
    roomType: 4,
    roomName: "demo-class",
    pretest: false,
    language: "en",
    startTime: new Date().getTime(),
    duration: 60 * 30,
    courseWareList: [],
    listener: (evt) => {
        console.log("evt", evt)
    }
})
```

After successful launching a classroom, you can see the following page:

