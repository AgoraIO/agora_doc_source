---
title: Send and Receive Image or File Messages 
platform: Web
updatedAt: 2021-03-03 06:43:57
---
## Introduction

You can call `createMediaMessageByUploading` to upload non-empty files or image files no greater than 30 MB. Each uploaded file or image stays in the Agora server for seven days. The SDK returns a media ID as the unique indentifier of the file or image file. You can use the `RtmFileMessage` interface or the `RtmImageMessage` interface to save the media ID. The `RtmFileMessage` interface and the `RtmImageMessage` interface are type aliases of the `RtmMessage` interface, so you can send and receive file or image messages via peer-to-peer or channel message methods. You can call `downloadMedia` to download the received file or image file.

## Implementation

### Send and receive image messages

Before you start, ensure that you have integrated the latest SDK into your project. You must also enable peer-to-peer and channel messages.

Complete the following steps to send and receive image messages:

1. Convert a local or internet image to a Blob.

   Convert a local image to a Blob:

    ```JavaScript
    // Convert a local image file to a Blob

    // Add input tag in the HTML file
    <input type="file" class="file-input" />

    // Get the Blob object via the input tag
    const fileBlob = document.querySelector('.file-input').files[0]
    const fileName = fileBlob.name
    ```

   Convert an internet image to a Blob:

   ```JavaScript
   //Convert an internet image to a Blob. The following sample code does not support Internet Explorer.

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

2. Upload an blob to the Agora server. When the upload is successful, the SDK returns an `RtmImageMessage` instance via Promise.

   Upload an blob to the Agora server:

   ```JavaScript
   // Upload a Blob to the Agora server:
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

   If a corresponding valid media ID is available, you can create an RtmImageMessage instance with the following code:

   ```JavaScript
    //Create an RtmImageMessage instance
    const imageMessage = this.client.createMessage({
        mediaId: <mediaId>, // Your mediaId
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

3. Send the `RtmImageMessage` instance to a user or channel via peer-to-peer or channel messages.

   Send a peer-to-peer image message:

   ```JavaScript
   // Send a peer-to-peer image message
   this.client.sendMessageToPeer(mediaMessage, peerId)
   ```

   Send a channel image message:

   ```JavaScript
    // Send a channel image message
    this.channels[channelName].channel.sendMessage(mediaMessage)
   ```

4. Send the `RtmImageMessage` instance to a user or channel via peer-to-peer or channel messages.

   Receive a peer-to-peer image message:

   ```JavaScript
   // Receive a peer-to-peer image message
    client.on('MessageFromPeer', async message => {
    if (message.messageType === 'IMAGE') {
        const thumbnail = message.thumbnailData
        // Gets the Blob object of the thumbnail
        const blob = await client.downloadMedia(message.mediaId)
        // Gets the Blob object
    }
    })
   ```

   Receive a channel image message:

   ```JavaScript
    //Receive a channel image message
    client.on('ChannelMessage', async message => {
    if (message.messageType === 'IMAGE') {
        const blob = await client.downloadMedia(message.mediaId)
        // Gets the Blob object
    }
    })
   ```

   Download the blob and convert the blob to an image file:

   ```JavaScript
    // Convert the Blob to an image file
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

### Send and receive file messages

Before you start, ensure that you have integrated the latest SDK into your project. You must also enable peer-to-peer and channel messages.

Complete the following steps to send and receive file messages:

1. Convert the local file to a blob.

    ```JavaScript
	  // Convert a local file to an blob:

    // Add input tag in the HTML file
    <input type="file" class="file-input" />

    // Get the Blob object via the input tag
    const fileBlob = document.querySelector('.file-input').files[0]
    const fileName = fileBlob.name
	```

2. Upload an blob to the Agora server. When the upload is successful, the SDK returns an `RtmFileMessage` instance via Promise.

   Upload an blob to the Agora server:

   ```JavaScript
    // Upload a Blob to the Agora server
    const mediaMessage = await this.client.createMediaMessageByUploading(blob, {
        messageType: 'FILE',
        fileName: 'example.ppt',
        description: 'send file'
        })
   ```

   If a corresponding valid media ID is available, you can create an `RtmFileMessage` instance with the following code:

   ```JavaScript
    // Create an RtmFileMessage instance
    const fileMessage = this.client.createMessage({
        mediaId: <mediaId>, // Your mediaId
        messageType: 'FILE',
        fileName: 'example.ppt',
        description: 'send file'
    })
   ```

3. Send the `RtmFileMessage` instance to a user or channel via peer-to-peer or channel messages.

  Send a peer-to-peer file message:

   ```JavaScript
    // Send a peer-to-peer file message
    this.client.sendMessageToPeer(mediaMessage, peerId)
   ```

   Send a channel file message:

   ```JavaScript
    // Send a channel file message
    this.channels[channelName].channel.sendMessage(mediaMessage)
   ```

4. The receiver of the file message receives the corresponding callback. You can download the blob with the media ID in the `RtmFileMessage` instance. You can then convert the blob to a file.

   Receive a peer-to-peer file message:

   ```JavaScript
    //Receive a peer-to-peer file message:
    client.on('MessageFromPeer', async message => {
    if (message.messageType === 'FILE') {
        const thumbnail = message.thumbnailData
        // Gets the Blob object of a thumbnail
        const blob = await client.downloadMedia(message.mediaId)
        // Gets a Blob object
    }
    })
   ```

   Receive a channel file message:

   ```JavaScript
    // Receive a channel file message:
    client.on('ChannelMessage', async message => {
    if (message.messageType === 'FILE') {
        const blob = await client.downloadMedia(smessage.mediaId)
        // Gets a blob object
    }
    })
   ```

  Convert the blob to a file.

   ```JavaScript
    // Convert the Blob to a file
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

### Manage upload and download tasks

You can cancel or get the progress of an upload or download task.

Cancel an upload task:

   ```JavaScript
    // Cancel an upload task

    // Uses the AbortController interface. You need polyfill to use AbortController for Internet Explorer.
    const controller = new AbortController()

    // Abort operation triggered by timeout
    setTimeout(() => controller.abort(), 1000)

    await client.createMediaMessageByUploading(blob, {
    cancelSignal: controller.signal,
    onOperationProgress: ({currentSize, totalSize}) => {
        console.log(currentSize, totalSize)
    },
    })
   ```

Cancel a download task

   ```JavaScript
    // Cancel a download task

    // Uses the AbortController interface. You need polyfill to use AbortController for Internet Explorer.
    const controller = new AbortController()

    // Abort operation triggered by timeout
    setTimeout(() => controller.abort(), 1000)

    await client.downloadMedia(message.mediaId, {
    cancelSignal: controller.signal,
    onOperationProgress: ({currentSize, totalSize}) => {
        console.log(currentSize, totalSize)
    },
    })
   ```


## Considerations

- You must log in to the Agora RTM system before calling the methods.
- Ensure that the total size of message content, filename, and thumbnail does not exceed 32 KB for each message instance.
- For each client, do not exceed a total of nine upload tasks and download tasks.
- You can set the width and height of the uploaded image by RtmImageMessage. The settings only exist as additional attributes and does not affect the uploaded image. The uploaded image is not resized or cropped.
- The SDK automatically sets width and height for images in JPEG, JPG, BMP, and PNG. The width or height you set overwrites the SDK-calculated width or height.

## API reference

- [`createMediaMessageByUploading`](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#createmediamessagebyuploading) 
- [`downloadMedia`](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#downloadmedia) 
- [`createMessage`](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#createmessage) 
- [`RtmImageMessage`](/en/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmimagemessage.html) 
- [`RtmFileMessage`](/en/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmfilemessage.html) 
- [`mediaTransferHandler`](/en/Real-time-Messaging/API%20Reference/RTM_web/interfaces/mediatransferhandler.html) 
- [`mediaOperationProgress`](/en/Real-time-Messaging/API%20Reference/RTM_web/interfaces/mediaoperationprogress.html) 