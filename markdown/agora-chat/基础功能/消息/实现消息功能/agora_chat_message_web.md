本文主要介绍如何通过 Agora Chat SDK 实现消息发送和接收，以及其他消息功能。

## 技术原理

Agora Chat SDK 提供 `ChatManager` 和 `Message` 类，用于发送、接收消息，实现消息已读回执，以及管理本地消息。包含的核心方法如下：

-   `send`：发送消息给指定用户、群组或聊天室。
-   `recallMessage`：撤回已发送的消息。
-   `listen` ：添加收到消息事件监听。

下图展示在客户端发送和接收消息的工作流程：

![](https://web-cdn.agora.io/docs-files/1643082196337)

如上图所示，实现消息发送和接收的步骤如下：

1. 用户向你的应用服务器请求 Token，你的应用服务器返回 Token。
2. 用户 A 和用户 B 使用获得的 Token 登录 Agora Chat。
3. 用户 A 发送消息到 Agora Chat 服务器。
4. 单聊时，Agora Chat 服务器将消息给用户 B；群聊时，Agora Chat 服务器将消息投递给群内其他成员。

## 前提条件

开始前，请确保满足以下条件：

-   已[集成 Agora Chat SDK](./agora_chat_get_started_web?platform=Web#集成-agora-chat-sdk)。
-   了解消息相关限制和 Agora Chat API 的调用频率限制，详见[限制条件](./agora_chat_limitation_web?platform=Web)。

## 实现方法

### 发送文本消息

参考如下代码，实现文本消息发送：

```javascript
// 发送文本消息。
function sendPrivateText() {
    // 创建文本消息。
    let msg = new WebIM.message("txt");
    let option = {
        // 消息内容
        msg: "message content",
        // 接收方用户名
        to: "username",
        // 设置聊天类型为单聊
        chatType: "singleChat",
        success: function (id, serverMsgId) {
            console.log("send private text Success");
        },
        fail: function (e) {
            console.log("Send private text error");
        },
    };
    msg.set(option);
    conn.send(msg.body);
}
```

### 接收文本消息

参考如下代码，添加收到消息事件监听 `listen`。

当收到消息时，SDK 会触发以下回调。

```js
WebIM.conn.listen({
    onOpened: function (message) {
        //连接成功回调
    },
    onClosed: function (message) {}, //连接关闭回调
    onTextMessage: function (message) {}, //收到文本消息
    onEmojiMessage: function (message) {}, //收到表情消息
    onPictureMessage: function (message) {}, //收到图片消息
    onCmdMessage: function (message) {}, //收到命令消息
    onAudioMessage: function (message) {}, //收到音频消息
    onLocationMessage: function (message) {}, //收到位置消息
    onFileMessage: function (message) {}, //收到文件消息
    onCustomMessage: function (message) {}, //收到自定义消息
    onVideoMessage: function (message) {}, //收到视频消息
    onPresence: function (message) {}, //处理“广播”或“发布-订阅”消息，如联系人订阅请求、处理群组、聊天室被踢解散等消息
    onRoster: function (message) {}, //处理好友申请
    onInviteMessage: function (message) {}, //处理群组邀请
    onOnline: function () {}, //本机网络连接成功
    onOffline: function () {}, //本机网络掉线
    onError: function (message) {}, //失败回调
    onBlacklistUpdate: function (list) {
        //黑名单变动
        // 查询黑名单，将好友拉黑，将好友从黑名单移除都会回调这个函数，list 则是黑名单现有的所有好友信息
    },
    onRecallMessage: function (message) {}, //收到消息撤回回执
    onReceivedMessage: function (message) {}, //收到消息送达服务器回执
    onDeliveredMessage: function (message) {}, //收到消息送达客户端回执
    onReadMessage: function (message) {}, //收到消息已读回执
    onCreateGroup: function (message) {}, //创建群组成功回执（需调用 createGroupNew）
    onMutedMessage: function (message) {}, //如果用户在 A 群组被禁言，在 A 群发消息会走这个回调并且消息不会传递给群其它成员
    onChannelMessage: function (message) {}, //收到整个会话已读的回执，在对方发送 channel ack 时会在这个回调里收到消息
});
```

### 发送附件消息

除文本消息外，你还可以发送附件类型的消息，包括语音、图片、视频、文件。实现步骤如下：

1. 上传消息附件到 Agora Chat 服务器，并获得 Agora Chat 服务返回的附件信息。
2. 发送附件消息，消息体包含**第 1 步**获得的附件信息。

#### 发送语音消息

参考如下代码，实现语音消息发送：

```js
/var sendPrivateAudio = function () {
     // 创建语音消息。
    var msg = new WebIM.message('audio');
		// 选择语音文件。
    var input = document.getElementById('audio');
		// 将语音文件转化为二进制文件。
    var file = WebIM.utils.getFileUrl(input);
    var allowType = {
        'mp3': true,
        'amr': true,
        'wmv': true
    };
    if (file.filetype.toLowerCase() in allowType) {
        var option = {
            file: file,
						// 语音文件时长（秒）
            length: '3',
						// 接收方用户名。
            to: 'username',
						// 设置聊天类型为单聊。
            chatType: 'singleChat',
						// 语音文件上传失败。
            onFileUploadError: function () {
                console.log('onFileUploadError');
            },
						// 上传语音文件进度回调。
            onFileUploadProgress: function (e) {
                console.log(e)
            },
						// 语音文件上传成功。
            onFileUploadComplete: function () {
                console.log('onFileUploadComplete');
            },
						// 语音消息发送成功。
            success: function () {
                console.log('Success');
            },
            fail: function(e){
						    // 语音消息发送失败。
                console.log("Fail");
            },
            flashUpload: WebIM.flashUpload,
            ext: {file_length: file.data.size}
        };
        msg.set(option);
        conn.send(msg.body);
    }
};
```

#### 发送图片消息

参考如下代码，实现图片消息发送：

```js
var sendPrivateImg = function () {
    // 创建图片消息。
    var msg = new WebIM.message("img");
    // 选择图片文件。
    var input = document.getElementById("image");
    // 将图片文件转化为二进制文件。
    var file = WebIM.utils.getFileUrl(input);
    var allowType = {
        jpg: true,
        gif: true,
        png: true,
        bmp: true,
    };
    if (file.filetype.toLowerCase() in allowType) {
        var option = {
            file: file,
            ext: {
                // 文件大小。
                file_length: file.data.size,
            },
            // 消息接收方用户名。
            to: "username",
            // 设置聊天类型为单聊。
            chatType: "singleChat",
            // 图片文件上传失败。
            onFileUploadError: function () {
                console.log("onFileUploadError");
            },
            // 图片文件上传进度回调。
            onFileUploadProgress: function (e) {
                console.log(e);
            },
            // 图片文件上传成功。
            onFileUploadComplete: function () {
                console.log("onFileUploadComplete");
            },
            // 图片消息发送成功。
            success: function () {
                console.log("Success");
            },
            fail: function (e) {
                // 图片消息发送失败。
                console.log("Fail");
            },
            flashUpload: WebIM.flashUpload,
        };
        msg.set(option);
        conn.send(msg.body);
    }
};
```

#### 发送 URL 图片消息

发送 URL 图片消息前，你需要在 `WebIMConfig.js` 文件中将 `useOwnUploadFun` 设置为 `true`。

参考如下代码，实现 URL 图片消息发送：

```js
var sendPrivateUrlImg = function () {
    // 创建图片消息。
    var msg = new WebIM.message("img");
    var option = {
        body: {
            type: "file",
            // 图片 URL 地址。
            url: url,
            size: {
                width: msg.width,
                height: msg.height,
            },
            length: msg.length,
            filename: msg.file.filename,
            filetype: msg.filetype,
        },
        // 消息接收方用户名。
        to: "username",
    };
    msg.set(option);
    conn.send(msg.body);
};
```

#### 发送视频消息

当发送视频消息时，SDK 默认生成缩略图。当接收方收到视频消息时，SDK 默认下载缩略图。

```js
var sendPrivateVideo = function () {
    var msg = new WebIM.message("video"); // 创建视频消息
    var input = document.getElementById("video"); // 选择视频的 input
    var file = WebIM.utils.getFileUrl(input); // 将视频转化为二进制文件
    var allowType = {
        mp4: true,
        wmv: true,
        avi: true,
        rmvb: true,
        mkv: true,
    };
    if (file.filetype.toLowerCase() in allowType) {
        var option = {
            file: file,
            to: "username", // 接收消息对象
            chatType: "singleChat", // 设置为单聊
            onFileUploadError: function () {
                // 消息上传失败
                console.log("onFileUploadError");
            },
            onFileUploadProgress: function (e) {
                // 上传进度的回调
                console.log(e);
            },
            onFileUploadComplete: function () {
                // 消息上传成功
                console.log("onFileUploadComplete");
            },
            success: function () {
                // 消息发送成功
                console.log("Success");
            },
            fail: function (e) {
                console.log("Fail"); // 如禁言、拉黑后发送消息会失败
            },
            flashUpload: WebIM.flashUpload,
            ext: {file_length: file.data.size},
        };
        msg.set(option);
        conn.send(msg.body);
    }
};
```

-   消息接收方收到视频消息后，默认自动下载视频缩略图。
-   如需取消自动下载，调用 `AgoraChatClient sharedClient.options.isAutoDownloadThumbnail(false)`，并在收到消息后主动调用 `AgoraChatClient sharedClient.chatManager downloadMessageThumbnail:message progress:nil completion:nil` 下载视频缩略图。

#### 发送文件消息

参考如下代码，实现文件消息发送：

```js
var sendPrivateFile = function () {
    // 创建文件消息。
    var msg = new WebIM.message("file");
    // 选择文件。
    var input = document.getElementById("file");
    // 将文件转化为二进制文件。
    var file = WebIM.utils.getFileUrl(input);
    var allowType = {
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
        var option = {
            file: file,
            // 消息接收方用户名。
            to: "username",
            // 设置聊天类型为单聊。
            chatType: "singleChat",
            // 文件上传失败。
            onFileUploadError: function () {
                console.log("onFileUploadError");
            },
            // 上传文件进度回调。
            onFileUploadProgress: function (e) {
                console.log(e);
            },
            // 文件上传成功。
            onFileUploadComplete: function () {
                console.log("onFileUploadComplete");
            },
            // 文件消息发送成功。
            success: function () {
                console.log("Success");
            },
            fail: function (e) {
                // 文件消息发送失败。
                console.log("Fail");
            },
            flashUpload: WebIM.flashUpload,
            ext: {file_length: file.data.size},
        };
        msg.set(option);
        conn.send(msg.body);
    }
};
```

#### 发送贴图消息

参考以下代码，实现粘贴图片至消息输入框后发送贴图消息：

```js
document.addEventListener("paste", function (e) {
    if (e.clipboardData && e.clipboardData.types) {
        if (e.clipboardData.items.length > 0) {
            if (/^image\/\w+$/.test(e.clipboardData.items[0].type)) {
                var blob = e.clipboardData.items[0].getAsFile();
                var url = window.URL.createObjectURL(blob);
                // 创建图片消息。
                var msg = new WebIM.message("img");
                msg.set({
                    file: {data: blob, url: url},
                    // 消息接收方用户名。
                    to: "username",
                    // 设置聊天类型为单聊。
                    chatType: "singleChat",
                    // 图片文件上传失败。
                    onFileUploadError: function (error) {
                        console.log("Error");
                    },
                    // 图片文件上传成功。
                    onFileUploadComplete: function (data) {
                        console.log("Complete");
                    },
                    success: function (id) {
                        // 贴图消息发送成功。
                        console.log("Success");
                    },
                    fail: function (e) {
                        // 贴图消息发送失败。
                        console.log("Fail");
                    },
                });
                conn.send(msg.body);
            }
        }
    }
});
```

### 发送透传消息

透传消息相当于一条指令，通过发送指令给消息接收方，指定对方要做的行为，例如更新头像、昵称。接收消息方可以根据业务需求自行处理该消息。

参考以下代码，实现透传消息发送：

```js
// 创建透传消息。
var msg = new WebIM.message('cmd');

msg.set({
  // 消息接收方用户名。
  to: 'username',
	// 自定义行为。
  action : 'action',
	// 自定义扩展消息内容。
  ext :{'extmsg':'extends messages'},    ）
	// 消息发送成功。
  success: function ( id,serverMsgId ) {},
  fail: function(e){
	    // 消息发送失败。
      console.log("Fail");
  }
});
conn.send(msg.body);
```

### 发送自定义类型消息

除以上消息类型外，你还可以通过键值对的形式自定义消息类型和消息内容。

```js
var sendCustomMsg = function () {
    // 创建自定义消息。
    var msg = new WebIM.message("custom");
    // 创建自定义事件。
    var customEvent = "customEvent";
    // 自定义消息内容，自行设置 key 和 value。
    var customExts = {};
    msg.set({
        // 消息接收方用户名。
        to: "username",
        customEvent,
        customExts,
        // 扩展消息字段，不能设置为 null。
        ext: {},
        roomType: false,
        success: function (id, serverMsgId) {},
        fail: function (e) {},
    });
    conn.send(msg.body);
};
```

### 使用消息的扩展字段

当消息类型不满足需求时，你可以通过消息扩展字段来传递自定义的消息内容。

```js
function sendPrivateText() {
    let msg = new WebIM.message("txt");
    msg.set({
        msg: "message content",
        to: "username",
        chatType: "singleChat",
        // 消息扩展字段。
        ext: {
            key1: "自定义 value1",
            key2: {
                key3: "自定义 value3",
            },
        },
        success: function () {
            console.log("send private text Success");
        },
        fail: function () {
            console.log("Send private text error");
        },
    });
    conn.send(msg.body);
}
```

### 撤回消息

1. 参考如下代码，实现消息发出后一定时间内的消息撤回。默认消息撤回时限为 2 分钟，如需调整请联系 [Agora 商务](mailto:sales@agora.io)。

```js
/**
 * 发送撤回消息
 * @param {Object} option
 * @param {Object} option.mid 消息 ID
 * @param {Object} option.to 消息接收方
 * @param {Object} option.type chat(单聊)、groupchat(群组)、chatroom(聊天室)
 */
let option = {
    mid: 'msgId',
    to: 'userID',
    chatType: 'singleChat'
};
connection.recallMessage(option).then((res) => {
    // 消息撤回成功
    console.log('success', res)
}).catch((error) => {
    // 消息撤回失败 (超过 2 分钟)
    console.log('fail', error)
```

2. 参考如下代码，监听消息撤回事件：

```js
WebIM.conn.addEventHandler('MESSAGES',{
   onRecallMessage: => (msg) {
       // 在本地删除对应的消息，并插入一条消息：“XXX撤回一条消息”。
   	   console.log('撤回成功'，msg) 
   }, 
})
```

## 获取服务器端历史消息

Agora Chat SDK 将历史消息存储在消息服务器中，支持以会话为单位获取历史消息。包含以下核心方法：

-   `getSessionList`：获取在服务器中的会话列表。
-   `fetchHistoryMessages`：获取服务器中指定会话中的消息。

> Agora 建议仅在首次安装应用或本地中没有会话时调用以上方法。

### 获取会话列表

参考如下代码获取服务器中的会话列表：

```js
WebIM.conn.getSessionList().then(res => {
    console.log(res);
    /**
    返回参数说明
    channel_infos - 所有会话
    channel_id - 会话 ID
    meta - 最后一条消息
    unread_num - 当前会话的未读消息数
    */
});
```

<div class="alert note"> 登陆时用户名必须为全大写或全小写，否则获取的会话列表可能为空。</div>

### 分页获取指定会话的历史消息

参考如下代码，从服务器中分页获取指定会话的历史消息。

```js
/**
 * 获取对话历史消息
 * @param {Object} options
 * @param {String} options.queue   - 对方用户 ID（如果用户 ID 内含有大写字母请改成小写字母）/群组 ID/聊天室 ID
 * @param {String} options.count   - 每次拉取条数
 * @param {Boolean} options.isGroup - 是否是群聊，默认为 false
 * @param {String} options.start - （非必需）起始位置的消息 ID，默认从最新的一条开始
 * @param {Function} options.success
 * @param {Funciton} options.fail
 */
var options = {
    // queue 的值必须为小写，否则获取的历史消息可能为空。
    queue: "test1",
    isGroup: false,
    count: 10,
    // 历史消息获取成功。
    success: function (res) {
        console.log(res);
    },
    fail: function () {},
};
WebIM.conn.fetchHistoryMessages(options);
```

> 你可以通过 `WebIM.conn.mr_cache` 方法重置分页游标。

## 实现消息的已读回执和送达回执

### 实现消息送达回执

在创建 `connection` 对象时，设置 `options` 参数的 `delivery` 为 `true` 开启送达回执功能。当消息到达接收方设备时，SDK 会自动发送送达回执，消息发送方收到 `onDeliveredMessage` 回调。

参考如下代码，添加收到消息送达回执时，消息送达状态的事件监听。

```js
WebIM.conn.listen({
    // 收到消息送达服务器回执时消息送达状态回调。
    onReceivedMessage: function (message) {},
    // 收到消息送达客户端回执时消息送达状态回调。
    onDeliveredMessage: function (message) {},
});
```

### 实现消息已读回执

消息被接收方阅读后，SDK 会发送已读回执到消息发送方。

#### 实现会话已读回执

参考如下步骤，实现指定会话中所有消息的已读回执。

1. 实现会话消息已读回执。

```js
// 单聊
var msg = new WebIM.message('channel');
msg.set({
    to: 'username'
});
WebIM.conn.send(msg.body);

// 群聊
var msg = new WebIM.message('channel');
msg.set({
    to: 'groupid'，
    chatType: 'groupChat'
});
WebIM.conn.send(msg.body);
```

2. 监听会话消息已读回执事件。

```js
WebIM.conn.listen({
  onChannelMessage:function(message){
    ...
  }
})
```

#### 实现单条消息的已读回执

参考如下步骤，实现指定消息的已读回执：

1. 实现指定消息的已读回执。进入会话时，发送会话已读回执 `conversation ack`：

```js
// 需要已读回执的消息 ID
var bodyId = message.id;
var msg = new WebIM.message("read");
msg.set({
    id: bodyId,
    to: message.from,
});
conn.send(msg.body);
```

2. 监听指定消息已读事件。

```js
WebIM.conn.listen({
  onReadMessage:function(message){
    ...
  }
})
```

#### 实现群组消息已读回执

当消息为群消息时，消息发送方（仅管理员和群主）可以设置此消息是否需要已读回执。

> 目前群聊已读回执功能为增值服务，如需使用请联系 [Agora 商务](mailto:sales@agora.io)。

1. 实现群组消息的已读回执。

```js
sendGroupReadMsg = () => {
    // 创建文本消息。
    let msg = new WebIM.message("txt");
    msg.set({
        // 消息内容。
        msg: "message content",
        // 消息接收方用户名。
        to: "username",
        // 设置聊天类型为群聊。
        chatType: "groupChat",
        success: function (id, serverMsgId) {
            console.log("send private text Success");
        },
        fail: function (e) {
            console.log("Send private text error");
        },
    });
    // 设置该消息需要已读回执。
    msg.body.msgConfig = {allowGroupAck: true};
    conn.send(msg.body);
};
```

2. 监听群组消息已读事件。

-   当在线时收到群组消息回执，通过 `onReadMessage` 回调监听消息已读状态。
-   当离线时收到群组消息回执，登录后通过 `onStatisticMessage` 回调监听消息已读状态。

```js
// 在线时可以在 onReadMessage 里监听
onReadMessage: message => {
    const {mid} = message;
    const msg = {
        id: mid,
    };
    if (message.groupReadCount) {
        // 消息阅读数
        msg.groupReadCount = message.groupReadCount[message.mid];
    }
};

// 离线时收到回执，登录后会在这里监听到
onStatisticMessage: message => {
    let statisticMsg = message.location && JSON.parse(message.location);
    let groupAck = statisticMsg.group_ack || [];
};
```

4. 收到回执消息后发送回执。

```js
sendReadMsg = () => {
  let msg = new WebIM.message("read");
  msg.set({
	     // 需要已读消息回执的消息 ID。
      id：message.id,
      to: 'groupId',
      msgConfig: { allowGroupAck: true },
			// 回执内容。
      ackContent: JSON.stringify({})
  })
  msg.setChatType('groupChat')
  WebIM.conn.send(msg.body);
}
```

5. 获取已读消息的用户。

```js
WebIM.conn
    .getGroupMsgReadUser({
        // 消息 ID
        msgId,
        // 群组 ID
        groupId,
    })
    .then(res => {
        console.log(res);
    });
```