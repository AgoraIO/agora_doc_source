# 消息管理–发送和接收消息

登录即时通讯 IM 后，用户可以在单聊、群聊、聊天室中发送如下类型的消息：

- 文字消息，包含超链接和表情；
- 附件消息，包含图片、语音、视频及文件消息；
- 位置消息；
- 透传消息；
- 自定义消息。

本文介绍如何使用即时通讯 IM Web SDK 实现发送和接收这些类型的消息。

## 技术原理

即时通讯 IM Web SDK 可以实现消息的发送、接收与撤回。

发送和接收消息：

- 消息发送方调用 `create` 方法创建文本、文件或附件消息。
- 消息发送方调用 `send` 方法发送消息。
- 消息接收方调用 `addEventHandler` 监听消息事件，并在相应回调中接收消息。

消息收发流程如下：

1. 用户 A 发送一条消息到环信的消息服务器。
2. 单聊时消息服务器发消息给用户 B，群聊时发消息给群内其他每个成员。
3. 用户收到消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Agora Chat 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_web?platform=Web)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Web)。

## 实现方法

### 发送文本消息

使用 `Message` 类创建并发送文本消息。示例代码如下：

```javascript
// 发送文本消息。
function sendPrivateText() {

    let option = {
        // 设置消息类型。
        type: "txt",
        // 设置消息内容。
        msg: "message content",
        // 设置消息接收方的用户 ID。
        to: "username",
        // 设置会话类型。
        chatType: "singleChat",
    };
    // 创建文本消息。
    let msg = WebIM.message.create(opt);
    // 调用 `send` 方法发送该文本消息。
    conn.send(msg).then(()=>{
        console.log("send private text Success");
    }).catch((e)=>{
        console.log("Send private text error");
    });
}
```

**注意**

群组消息和聊天室消息只需修改 option 对象下的其中 2 个参数：`to` 和 `chatType`。

- 群聊：`to` 为群组 ID；`chatType` 为 `groupChat`；
- 聊天室：`to` 为聊天室 ID`；`chatType` 为 `chatRoom`。

### 接收消息

你可以通过 `addEventHandler` 注册监听器监听消息事件。你可以添加多个事件。当不再监听事件时，请确保删除监听器。

当消息到达时，接收方会收到 `onXXXMessage` 回调。每个回调包含一条或多条消息。你可以遍历消息列表，并可以解析和展示回调中的消息。

```javascript
// 使用 `addEventHandler` 监听回调事件
conn.addEventHandler("eventName",{
    // SDK 与环信服务器连接成功。
    onConnected: function (message) {},
    // SDK 与环信服务器断开连接。
    onDisconnected: function (message) {},
    // 当前用户收到文本消息。
    onTextMessage: function (message) {},
    // 当前用户收到图片消息。
    onImageMessage: function (message) {},
    // 当前用户收到透传消息。
    onCmdMessage: function (message) {},
    // 当前用户收到语音消息。
    onAudioMessage: function (message) {},
    // 当前用户收到位置消息。
    onLocationMessage: function (message) {},
    // 当前用户收到文件消息。
    onFileMessage: function (message) {},
    // 当前用户收到自定义消息。
    onCustomMessage: function (message) {},
    // 当前用户收到视频消息。
    onVideoMessage: function (message) {},
    // 当前用户订阅的其他用户的在线状态更新。
    onPresence: function (message) {},
    // 当前用户收到好友邀请。
    onContactInvited: function(msg){},
    // 联系人被删除。
    onContactDeleted: function(msg){},
    // 新增联系人。
    onContactAdded: function(msg){},
    // 当前用户发送的好友请求被拒绝。
    onContactRefuse: function(msg){},
    // 当前用户发送的好友请求被同意。
    onContactAgreed: function(msg){},
    // 当前用户收到群组邀请。
    onGroupEvent: function (message) {},
    // 本机网络连接成功。
    onOnline: function () {},
    // 本机网络掉线。
    onOffline: function () {},
    // 调用过程中出现错误。
    onError: function (message) {},
    // 当前用户收到的消息被消息发送方撤回。
    onRecallMessage: function (message) {},
    // 当前用户发送的消息被接收方收到。
    onReceivedMessage: function (message) {},
    // 当前用户收到消息送达回执。
    onDeliveredMessage: function (message) {},
    // 当前用户收到消息已读回执。
    onReadMessage: function (message) {},
    // 当前用户收到会话已读回执。
    onChannelMessage: function (message) {},
});
```

### 撤回消息

用户发送消息 2 分钟以内可以撤回消息。如需调整时间限制，请联系 [support@agora.io](mailto:support@agora.io)。

```javascript
/**
 * @param {Object} option.mid - 要撤回消息的 ID。
 * @param {Object} option.to - 消息接收方。
 * @param {Object} option.type - 消息类型：chat (单聊)、groupchat (群聊)和 chatroom (聊天室)。
 */
let option = {
    mid: 'msgId',
    to: 'userID',
    chatType: 'singleChat'
};
conn.recallMessage(option).then((res) => {
    console.log('success', res)
}).catch((error) => {
    // 消息撤回失败，原因可能是超过了撤销时限(超过 2 分钟)。
    console.log('fail', error)
```

你还可以使用 `onRecallMessage` 监听消息撤回状态：

```javascript
conn.addEventHandler('MESSAGES',{
   onRecallMessage: (msg) => {
      // 这里需要在本地删除对应的消息，也可以插入一条消息：“XXX撤回一条消息”。
      console.log('Recalling the message success'，msg)
   }
})
```

### 发送附件消息

语音、图片、视频和文件消息本质上是附件消息。

SDK在发送附件消息时，采取以下步骤：

1. 上传附件到服务器，获取服务器上附件文件的信息
2. 发送附件消息，其中包含消息的基本信息，以及服务器上附件文件的路径。

对于图片和视频消息，SDK 还会自动生成缩略图。

SDK 接收到附件消息时，会执行以下步骤：

- 对于语音消息，SDK 会自动下载语音文件。
- 对于图片和视频消息，SDK 会自动下载图片或视频的缩略图。要下载文件，你需要调用该 `download`  方法。
- 对于文件消息，你需要调用 `download` 方法下载文件。

#### 发送语音消息

在发送语音消息之前，你应该在 app 级别实现录音，提供录制的语音文件的 URI 和时长。

参考以下代码示例来创建和发送语音消息：

```javascript
function sendPrivateAudio() {
  // 获取语音文件。
  let input = document.getElementById('audio');
  let file = WebIM.utils.getFileUrl(input);
  let allowType = {
      'mp3': true,
      'amr': true,
      'wmv': true
  };
  if (file.filetype.toLowerCase() in allowType) {
    let option = {
      // 设置消息类型。
      type: 'audio',
      file: file,
      // 设置语音文件长度，单位为秒。
      length: '3',
      // 设置消息接收方的用户 ID。
      to: 'username',
      // 设置会话类型。
      chatType: 'singleChat',
      // 语音文件上传失败。
      onFileUploadError: function () {
          console.log('onFileUploadError');
      },
      // 语音文件上传进度。
      onFileUploadProgress: function (e) {
          console.log(e)
      },
      // 语音文件上传成功。
              onFileUploadComplete: function () {
                  console.log('onFileUploadComplete');
              },
              ext: {file_length: file.data.size}
          };
    // 创建一条语音消息。
    let msg = WebIM.message.create(option);
    // 调用 `send` 方法发送该语音消息。
    conn.send(msg).then((res)=>{
      // 语音文件成功发送。
      console.log('Success');
    }).catch((e)=>{
      // 语音文件发送失败。
              console.log("Fail");
          });
      }
  };
```

#### 发送图片消息

请参考以下代码示例来创建和发送图片消息：

```javascript
function sendPrivateImg() {
  // 选择本地图片文件。
  let input = document.getElementById("image");
  let file = WebIM.utils.getFileUrl(input);
  let allowType = {
    jpg: true,
    gif: true,
    png: true,
    bmp: true,
  };
  if (file.filetype.toLowerCase() in allowType) {
    let option = {
      // 设置消息类型。
      type: 'img',
      file: file,
      ext: {
          // 设置图片文件长度，单位为字节。
          file_length: file.data.size,
      },
      // 设置消息接收方的用户 ID。
      to: "username",
      // 设置会话类型。
      chatType: "singleChat",
      // 图片文件上传失败。
      onFileUploadError: function () {
          console.log("onFileUploadError");
      },
      // 图片文件上传进度。
      onFileUploadProgress: function (e) {
          console.log(e);
      },
      // 图片文件上传成功。
      onFileUploadComplete: function () {
          console.log("onFileUploadComplete");
      },
    };
    // 创建一条图片消息。
    let msg = WebIM.message.create(option);
    // 调用 `send` 方法发送该图片消息。
    conn.send(msg).then((res)=>{
      // 图片文件成功发送。
      console.log('Success');
    }).catch((e)=>{
      // 图片文件发送失败。
      console.log("Fail");
          });
      }
  };
```

#### 发送 URL 图片消息

发送 URL 图片消息之前，确保将 `useOwnUploadFun` 设置为 `true`。

```javascript
function sendPrivateUrlImg() {
  let option = {
      chatType: 'singleChat',
      // 设置消息类型。
      type: "img",
      // 设置图片文件的 URL　地址。
      url: "img url",
      // 设置消息接收方的用户 ID。
      to: "username",
  };
  // 创建一条图片消息。
  let msg = WebIM.message.create(option);
  //  调用 `send` 方法发送该图片消息。
  conn.send(msg);
};
```

#### 发送视频消息

在发送视频消息之前，应在 app 级别实现视频捕获，获得捕获的视频文件的时长。

参考以下代码示例创建和发送视频消息：

```javascript
function sendPrivateVideo() {
  // 选择本地视频文件。
  let input = document.getElementById("video");
  let file = WebIM.utils.getFileUrl(input);
  let allowType = {
      mp4: true,
      wmv: true,
      avi: true,
      rmvb: true,
      mkv: true,
  };
  if (file.filetype.toLowerCase() in allowType) {
    let option = {
      // 设置消息类型。
      type: 'video',
      file: file,
      // 设置消息接收方的用户 ID。
      to: "username",
      // 设置会话类型。
      chatType: "singleChat",
      onFileUploadError: function () {
        // 视频文件上传失败。
        console.log("onFileUploadError");
      },
      onFileUploadProgress: function (e) {
        // 视频文件上传进度。
        console.log(e);
      },
      onFileUploadComplete: function () {
        // 视频文件上传成功。
        console.log("onFileUploadComplete");
      },
      ext: {file_length: file.data.size},
    };
    // 创建一条视频消息。
    let msg = WebIM.message.create(option);
    // 调用 `send` 方法发送该视频消息。
    conn.send(msg).then((res)=>{
      // 视频文件成功发送。
      console.log('Success')
    }).catch((e)=>{
      // 视频文件发送失败。例如，本地用户被禁言或封禁。
      console.log("Fail");
          });
      }
  };
```

#### 发送文件消息

参考以下代码示例创建、发送和接收文件消息：

```javascript
function sendPrivateFile() {
  // 选择本地文件。
  let input = document.getElementById("file");
  let file = WebIM.utils.getFileUrl(input);
  let allowType = {
      jpg: true,
      gif: true,
      png: true,
      bmp: true,
      zip: true,
      txt: true,
      doc: true,
      pdf: true,
  };
  if (file.filetype.toLowerCase() in allowType) {
    let option = {
      // 设置消息类型。
      type: 'file',
      file: file,
      // 设置消息接收方的用户 ID。
      to: "username",
      // 设置会话类型。
      chatType: "singleChat",
      // 文件上传失败。
      onFileUploadError: function () {
        console.log("onFileUploadError");
      },
      // 文件上传进度。
      onFileUploadProgress: function (e) {
        console.log(e);
      },
      // 文件上传成功。
      onFileUploadComplete: function () {
        console.log("onFileUploadComplete");
      },
      ext: {file_length: file.data.size},
    };
      // 创建一条文件消息。
    let msg = WebIM.message.create(option);
      // 调用 `send` 方法发送该文件消息。
    conn.send(msg).then((res) => {
      // 文件消息成功发送。
      console.log("Success");
    }).catch((e)=>{
      // 文件消息发送失败。
      console.log("Fail");
    });
  }
};
```

### 发送透传消息

透传消息是通知指定用户采取特定操作的命令消息。接收方自己处理透传消息。

参考以下代码示例发送和接收透传消息：

```javascript
function sendCMDMessage(){
  let option = {
    // 设置消息类型。
    type: 'cmd',
    // 设置会话类型。
    chatType: 'singleChat',
    // 设置消息接收方的用户 ID。
    to: 'username',
    // 设置自定义动作。对于透传消息，该字段必填。
    action : 'action',
    // 设置消息扩展信息。
    ext: {key: 'extends messages'}
  }
  // 创建一条透传消息。
  let msg = WebIM.message.create(option);
  // 调用 `send` 方法发送该透传消息。
  conn.send(msg).then((res)=>{
      // 消息成功发送回调。
      console.log("Success")
  }).catch((e)=>{
      // 消息发送失败回调。
      console.log("Fail");
  });
}
```

### 发送自定义消息

自定义消息为用户自定义的键值对，包括消息类型和消息内容。

参考以下示例代码创建和发送自定义消息：

```javascript
function sendCustomMsg() {
  // 设置自定义事件。
  let customEvent = "customEvent";
  // 通过键值对设置自定义消息内容。
  let customExts = {};
  let option = {
      // 设置消息类型。
      type: "custom",
      // 设置消息接收方的用户 ID。
      to: "username",
      // 设置会话类型。
      chatType: "singleChat",
      customEvent,
      customExts,
      // 消息扩展字段，不能设置为空，即设置为 "ext:null" 这种形式会出错。
      ext: {},
  }
  // 创建一条自定义消息。
  let msg = WebIM.message.create(option);
  // 调用 `send` 方法发送该自定义消息。
  conn.send(msg).then((res)=>{
      // 消息成功发送回调。
      console.log("Success")
  }).catch((e)=>{
      // 消息发送失败回调。
      console.log("Fail");
  });
};
```

### 使用消息扩展

如果上述消息类型无法满足要求，你可以使用消息扩展为消息添加属性。这种情况可用于更复杂的消息传递场景，例如消息中需要携带被回复的消息内容或者是图文消息等场景。

```javascript
function sendTextMessage() {
    let option = {
        type: "txt",
        msg: "message content",
        to: "username",
        chatType: "singleChat",
        // 设置消息扩展信息。扩展字段为可选，若带有该字段，值不能为空，即 "ext:null" 会出错。
        ext: {
            key1: "Self-defined value1",
            key2: {
                key3: "Self-defined value3",
            },
        }
    }
    let msg = WebIM.message.create(option);
    //  调用 `send` 方法发送该扩展消息。
    conn.send(msg).then((res)=>{
        console.log("send private text Success");
    }).catch((e)=>{
        console.log("Send private text error");
    });
}
```

## 下一步

实现消息发送和接收后，可以参考以下文档为应用添加更多消息功能：

- [从服务器获取会话和消息](https://docs.agora.io/en/agora-chat/agora_chat_retrieve_message_web?platform=Web)
- [消息回执](https://docs.agora.io/en/agora-chat/agora_chat_message_receipt_web?platform=Web)