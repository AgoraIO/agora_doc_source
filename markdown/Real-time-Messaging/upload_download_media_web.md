---
title: 发送和接收图片或文件消息
platform: Web
updatedAt: 2021-03-03 06:32:40
---
## 功能描述

你可以通过 `createMediaMessageByUploading` 方法将不超过 30 MB 的文件或图片上传到 Agora 服务器。每个上传成功的文件或图片保存七天，SDK 会返回一个 media ID 作为此文件或图片的唯一标识。你可以使用 `RtmFileMessage` 接口和 `RtmImageMessage` 接口用于保存和传递 SDK 返回的 media ID。`RtmFileMessage` 接口和 `RtmImageMessage` 接口都属于 `RtmMessage` 接口的类型别名，因此你可以通过这两个接口发送和接收文件或图片消息。你可以使用 `downloadMedia` 方法下载接收到的文件或图片。

## 实现方法

### 发送和接收图片消息

请确保你已集成最新版的 Agora RTM SDK 到你的项目中，而且已实现点对点消息和频道消息功能。

你可以按照以下步骤发送和接收图片消息：

1. 将本地图片或网络图片转换为 Blob 对象。

   将本地图片转换为 Blob 对象：

    ```JavaScript
	//将本地图片转换为blob 对象

    // html 文件中加入上传 input 的标签
    <input type="file" class="file-input" />

    // JavaScript 中获取该标签中选择的文件 blob 对象
    const fileBlob = document.querySelector('.file-input').files[0]
    const fileName = fileBlob.name
	```

   将网络图片转换为 Blob 对象：

   ```JavaScript
   //将图片 URL 转换为blob 对象

    function canvasToDataURL (canvas, format, quality) {
    return canvas.toDataURL(format||'image/jpeg', quality||1.0)
    }

    function dataURLToBlob(dataurl){
    var arr = dataurl.split(',')
    var mime = arr[0].match(/:(.*?);/)[1]
    var bstr = atob(arr[1])
    var n = bstr.length
    var u8arr = new Uint8Array(n)
    while(n--){
        u8arr[n] = bstr.charCodeAt(n)
    }
    return new Blob([u8arr], {type:mime})
    }

    function imageToCanvas(src, cb){
    var canvas = document.createElement('CANVAS')
    var ctx = canvas.getContext('2d')
    var img = new Image()
    img.src = src
    img.onload = function (){
        canvas.width = img.width
        canvas.height = img.height
        ctx.drawImage(img, 0, 0)
        cb(canvas)
    }
    }

    function imageToBlob(src, cb){
    imageToCanvas(src, function (canvas){
        cb(dataURLToBlob(canvasToDataURL(canvas)))
    })
    }
   ```

2. 上传 Blob 对象到 Agora 服务器。上传成功时，SDK 会通过 Promise 返回一个 `RtmImageMessage` 实例。

   上传 Blob 对象到 Agora 服务器：

   ```JavaScript
   //上传 Blob 对象到 Agora 服务器
    const mediaMessage = await this.client.createMediaMessageByUploading(blob, {
        messageType: 'IMAGE',
        fileName: 'agora.jpg',
        description: 'send image',
        thumbnail: blob,
        width: 100,
        height: 200,
        thumbnailWidth: 50,
        thumbnailHeight: 200,
        })
   ```

   如果你存有一个已上传图片对应的 media ID 且 media ID 仍然处于 7 天有效期内，可通过如下代码直接创建一个 `RtmImageMessage` 实例:

   ```JavaScript
    //直接创建 RtmImageMessage 实例
    const imageMessage = this.client.createMessage({
        mediaId: <mediaId>, // 保存的 mediaId
        messageType: 'IMAGE',
        fileName: 'example.jpg',
        description: 'send image',
        thumbnail: blob,
        width: 100,
        height: 200,
        thumbnailWidth: 50,
        thumbnailHeight: 200,
    })
   ```

3. 将 `RtmImageMessage` 实例通过点对点消息或频道消息的方式发送给指定用户或指定频道。

   发送点对点图片消息示例代码：

   ```JavaScript
   //发送点对点图片消息
   this.client.sendMessageToPeer(mediaMessage, peerId)
   ```

   发送频道图片消息：

   ```JavaScript
    //发送频道图片消息
    this.channels[channelName].channel.sendMessage(mediaMessage)
   ```

4. 收到图片消息的用户会收到相应回调，你可以通过获取 `RtmImageMessage` 实例携带的 media ID 信息下载 Blob 对象并将其转换为图片文件。

   接收图片点对点消息：

   ```JavaScript
   //接收图片点对点消息
    client.on('MessageFromPeer', async message => {
    if (message.messageType === 'IMAGE') {
        const thumbnail = message.thumbnailData
        // 获得了 thumbnail 的 Blob 对象，进行其他操作
        const blob = await client.downloadMedia(message.mediaId)
        // 获得了 Blob 对象，进行其他操作
    }
    })
   ```

   接收图片频道消息：

   ```JavaScript
    //接收图片频道消息
    client.on('ChannelMessage', async message => {
    if (message.messageType === 'IMAGE') {
        const blob = await client.downloadMedia(smessage.mediaId)
        // 获得了 Blob 对象，进行其他操作
    }
    })
   ```

   下载 Blob 对象并将 Blob 对象转换为图片：

   ```JavaScript
    //下载 Blob 对象并将其转换为图片
    function fileOrBlobToDataURL(obj, cb){
    var a = new FileReader()
    a.readAsDataURL(obj)
    a.onload = function (e){
        cb(e.target.result)
    }
    }

    function blobToImage (blob, cb) {
    fileOrBlobToDataURL(blob, function (dataurl){
        var img = new Image()
        img.src = dataurl
        cb(img)
    })
    }
   ```

### 发送和接收文件消息

请确保你已集成最新版的 Agora RTM SDK 到你的项目中，而且已实现点对点消息和频道消息功能。

你可以按照以下步骤发送和接收文件消息：

1. 将本地文件转换为 Blob 对象。

   ```JavaScript
    //将本地文件转换为blob 对象
    // html 文件中加入上传 input 的标签
    <input type="file" class="file-input" />

    // JavaScript 中获取该标签中选择的文件 blob 对象
    const fileBlob = document.querySelector('.file-input').files[0]
    const fileName = fileBlob.name
   ```

2. 上传 Blob 对象到 Agora 服务器。文件上传成功时，SDK 会通过 Promise 返回一个 `RtmFileMessage` 实例。

   上传 Blob 对象到 Agora 服务器：

   ```JavaScript
    //上传blob 对象到 Agora 服务器
    const mediaMessage = await this.client.createMediaMessageByUploading(blob, {
        messageType: 'FILE',
        fileName: 'example.jpg',
        description: 'send file',
        thumbnail: blob,
        width: 100,
        height: 200,
        thumbnailWidth: 50,
        thumbnailHeight: 200,
        })
   ```

   如果你存有一个已上传文件对应的 media ID 且 media ID 仍然处于 7 天有效期内，可通过如下代码直接创建一个 `RtmFileMessage` 实例:

   ```JavaScript
    //直接通过 media ID 创建 RtmFileMessage 实例
    const fileMessage = this.client.createMessage({
        mediaId: <mediaId>, // 保存的 mediaId
        messageType: 'FILE',
        fileName: 'example.ppt',
        description: 'send file'
    })
   ```

3. 将 `RtmFileMessage` 实例通过点对点消息或频道消息的方式发送给指定用户或指定频道。

   发送文件点对点消息：

   ```JavaScript
    //发送文件点对点消息
    this.client.sendMessageToPeer(mediaMessage, peerId)
   ```

   发送文件频道消息：

   ```JavaScript
    //发送文件频道消息
    this.channels[channelName].channel.sendMessage(mediaMessage)
   ```

4. 收到文件消息的用户会收到相应回调。你可以通过 media ID 下载 blob 对象并将其转换为文件。

   接收文件点对点消息：

   ```JavaScript
    //接收文件点对点消息
    client.on('MessageFromPeer', async message => {
    if (message.messageType === 'FILE') {
        const thumbnail = message.thumbnailData
        // 获得了thumbnail 的 Blob 对象，进行其他操作
        const blob = await client.downloadMedia(message.mediaId)
        // 获得了 Blob 对象，进行其他操作
    }
    })
   ```

   接收文件频道消息：

   ```JavaScript
    //接收文件频道消息
    client.on('ChannelMessage', async message => {
    if (message.messageType === 'FILE') {
        const blob = await client.downloadMedia(smessage.mediaId)
        // 获得了Blob对象，进行其他操作
    }
    })
   ```


   下载 blob 对象并将其转换为文件：

   ```JavaScript
    //下载 Blob 对象并将其转换为文件
    function fileOrBlobToDataURL(obj, cb){
    var a = new FileReader()
    a.readAsDataURL(obj)
    a.onload = function (e){
        cb(e.target.result)
    }
    }

    function blobToFile (blob, cb) {
    fileOrBlobToDataURL(blob, function (dataurl){
        var file = new File()
        file.src = dataurl
        cb(file)
    })
    }
   ```

### 管理上传或下载任务

你可以取消上传或下载任务，也可以获取上传或下载的进度。

取消上传任务：

   ```JavaScript
    //取消上传任务

    // 使用 AbortController 接口。IE 浏览器需要 polyfill 才能使用 AbortController 接口。
    const controller = new AbortController()

    // 上传超时触发取消操作
    setTimeout(() => controller.abort(), 1000)

    await client.createMediaMessageByUploading(blob, {
    cancelSignal: controller.signal,
    onOperationProgress: ({currentSize, totalSize}) => {
        console.log(currentSize, totalSize)
    },
    })
   ```

取消下载任务：

   ```JavaScript
    //取消下载任务

    // 使用 AbortController 接口。IE 浏览器需要 polyfill 才能使用 AbortController 接口。
    const controller = new AbortController()

    // 下载超时触发取消操作
    setTimeout(() => controller.abort(), 1000)

    await client.downloadMedia(message.mediaId, {
    cancelSignal: controller.signal,
    onOperationProgress: ({currentSize, totalSize}) => {
        console.log(currentSize, totalSize)
    },
    })
   ```


## 注意事项

- 你必须在成功登录 Agora RTM 系统后才能调用本功能相关的方法。
- 每个消息实例的消息内容、文件名和缩略图的总大小不得超过 32 KB。
- SDK 不会自动生成缩略图，因此你需要自行生成。缩略图格式为二进制格式数据。
- 每个客户端实例支持同时进行最多 9 个上传或下载任务（上传和下载任务一并计算）。
- 你可以通过 `RtmImageMessage` 设置上传图片的宽和高。SDK 不会对上传图片进行裁剪或缩放。

## API 参考

- [`createMediaMessageByUploading`](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/classes/rtmclient.html#createmediamessagebyuploading) 方法
- [`downloadMedia`](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/classes/rtmclient.html#downloadmedia) 方法
- [`createMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/classes/rtmclient.html#createmessage) 方法
- [`RtmImageMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/interfaces/rtmimagemessage.html) 接口
- [`RtmFileMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/interfaces/rtmfilemessage.html) 接口
- [`mediaTransferHandler`](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/interfaces/mediatransferhandler.html) 接口
- [`mediaOperationProgress`](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/interfaces/mediaoperationprogress.html) 接口