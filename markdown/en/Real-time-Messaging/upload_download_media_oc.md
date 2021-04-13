---
title: Send and Receive Image or File Messages
platform: iOS
updatedAt: 2020-10-19 15:16:40
---
## Introduction

You can use Agora RTM SDK to send and receive image or file messages. 

Agora RTM SDK supports uploading and downloading non-empty images and files that do not exceed 30 MB in size. Each image or file you upload to the Agora server stays for 7 days and has a corresponding media ID. You can download the image or file from the Agora server with the media ID. 

Agora RTM SDK adds the `AgoraRtmImageMessage` interface and the `AgoraRtmFileMessage` interface to save and transfer media ID. Because the `AgoraRtmImageMessage` interface and the `AgoraRtmFileMessage` interface inherit from the `AgoraRtmMessage` interface, you can use existing peer-to-peer or channel messaging to transfer the `AgoraRtmImageMessage` instance and the `AgoraRtmFileMessage` instance. Thus, you can send and receive image or file messages.

You can use the `AgoraRtmImageMessage` interface to perform the following image operations:

- Set the filename and thumbnail of the uploaded image.
- Get the size of the uploaded image.
- Get the SDK-calculated width and height of images in JPEG, JPG, BMP, and PNG format.
- Set the width and height of images. The width and height you set overwrite SDK calculated width and height.

You can use the `AgoraRtmFileMessage` interface to perform the following file operations:

- Set the name and thumbnail of the uploaded file.
- Get the size of the uploaded file.

## Implementation

### Send and receive image messages

<div class="alert note">Before you begin, make sure that you have integrated the latest SDK to your project. You must also enable peer-to-peer and channel messaging.</div>

The following steps show the general process of sending and receiving an image message:

1. Upload an image to the Agora server. When you successfully upload the image, SDK returns an `AgoraRtmImageMessage` instance by callback.

   Sample code for uploading an image to the Agora server:

   ```objectivec
    [AgoraRtm.kit createImageMessageByUploading:imagePath withRequest:&requestId completion:^(long long requestId, AgoraRtmImageMessage *message, AgoraRtmUploadMediaErrorCode errorCode) {
        //deal with message
    }];
   ```

    If you have a corresponding media ID for a image that is still in the Agora server, you can create an `AgoraRtmImageMessage` instance with the following code:

   ```objectiveC
   [AgoraRtm.kit createImageMessageByMediaId:mediaId];
   ```

2. (Optional) Set the width, height, or thumbnail of the image by the `AgoraRtmImageMessage` instance.

    Sample code for setting the width and height of the image:

   ```objectivec
   [message setWidth:imageWidth];
   [message setHeight:imageHeight];
   ```

    Sample code for setting the thumbnail of the image:

   ```objectivec
   message.thumbnailWidth = thumbnailImage.size.width;
   message.thumbnailHeight = thumbnailImage.size.height;
   ```
  
3. Send the `AgoraRtmImageMessage` instance via peer-to-peer or channel messaging to a user or channel. The `AgoraRtmImageMessage` class interface inherits from the `AgoraRtmMessage` class interface, so you can use peer-to-peer or channel messaging to send the `AgoraRtmImageMessage` instance.

   Sample code for sending peer-to-peer image message:

   ```objectivec
   [AgoraRtm.kit sendMessage:rtmMessage toPeer:self.mode.name sendMessageOptions:option completion:^(AgoraRtmSendPeerMessageErrorCode errorCode) {}];
   ```

   Sample code for sending channel image message:

   ```objectivec
   [self.rtmChannel sendMessage:rtmMessage completion:^(AgoraRtmSendChannelMessageErrorCode errorCode) {}];
   ```

4. The user who receives the image message can receive the corresponding callback. You can get the media ID from the `AgoraRtmImageMessage` instance and save the image by media ID.

    Sample code for receiving peer-to-peer image message:

   ```objectivec
   - (void)rtmKit:(AgoraRtmKit *)kit imageMessageReceived:(AgoraRtmImageMessage *)message fromPeer:(NSString *)peerId {
    //deal with message
    }
   ```

   Sample code for receiving channel image message:

   ```objectivec
   - (void)channel:(AgoraRtmChannel *)channel imageMessageReceived:(AgoraRtmImageMessage *)message fromMember:(AgoraRtmMember *)member {
    //deal with message
    }
   ```
   
   Generally, you can download an image to local storage via media ID.

   ```objectivec
   [AgoraRtm.kit downloadMedia:message.mediaId toFile:filePath withRequest:&requestId completion:^(long long requestId, AgoraRtmDownloadMediaErrorCode errorCode) {}];
   ```

   For scenarios that require quick save operations, you can download the image to memory:

   ```objectivec
   [AgoraRtm.kit downloadMediaToMemory:message.mediaId withRequest:&requestId completion:^(long long requestId, NSData *data, AgoraRtmDownloadMediaErrorCode errorCode) {}];
   ```

   If you need to cancel uploading or downloading an image, refer to the following example code:

   ```objectivec
   [AgoraRtm.kit cancelMediaUpload:&requestId completion:^(long long requestId, AgoraRtmCancelMediaErrorCode errorCode) {}];
   ```

   ```objectivec
   [AgoraRtm.kit cancelMediaDownload:&requestId completion:^(long long requestId, AgoraRtmCancelMediaErrorCode errorCode) {}];
   ```


### Send and receive file messages

<div class="alert note">Before you begin, make sure that you have integrated the latest SDK to your project. You must also enable peer-to-peer and channel messaging.</div>

The following steps show the general process of sending and receiving a file message:

1. Upload a file to the Agora server. When you successfully upload the file, SDK returns an `AgoraRtmFileMessage` instance by callback.
   
   Sample code for uploading a file to the Agora server:

   ```objectivec
    [AgoraRtm.kit createFileMessageByUploading:filePath withRequest:&requestId completion:^(long long requestId, AgoraRtmFileMessage *message, AgoraRtmUploadMediaErrorCode errorCode) {
        //deal with message
    }];
   ```

    If you have a corresponding media ID for a file that is still in the Agora server, you can create an `AgoraRtmFileMessage` instance with the following code:

   ```objectivec
   [AgoraRtm.kit createFileMessageByMediaId:mediaId];
   ```

2. (Optional) Set the thumbnail of the file by the `AgoraRtmFileMessage` instance.

   ```objectivec
   UIImage *thumbnailImage = [weakSelf generateThumbnail:imagePath toByte:5 * 1024];
   if(thumbnailImage != nil) {
   message.thumbnail = imageData;
   }
   ```

3. Send the `AgoraRtmFileMessage` instance via peer-to-peer or channel messaging to a user or channel. The `AgoraRtmFileMessage` class interface inherits from the `AgoraRtmMessage` class interface, so you can use peer-to-peer or channel messaging to send the `AgoraRtmFileMessage` instance.

   Sample code for sending peer-to-peer file message:

   ```objectivec
   [AgoraRtm.kit sendMessage:rtmMessage toPeer:self.mode.name sendMessageOptions:option completion:^(AgoraRtmSendPeerMessageErrorCode errorCode) {}];
   ```

   Sample code for sending channel file message:

   ```objectivec
   [self.rtmChannel sendMessage:rtmMessage completion:^(AgoraRtmSendChannelMessageErrorCode errorCode) {}];
   ```

4. The user who receives the file message can receive the corresponding callback. You can get the media ID from the `AgoraRtmFileMessage` instance and save the file by media ID.

   Sample code for receiving peer-to-peer file message:

   ```objectivec
   - (void)rtmKit:(AgoraRtmKit *)kit fileMessageReceived:(AgoraRtmFileMessage *)message fromPeer:(NSString *)peerId {
    //deal with message
    }
   ```

   Sample code for receiving channel file message:

   ```objectivec
   - (void)channel:(AgoraRtmChannel *)channel fileMessageReceived:(AgoraRtmFileMessage *)message fromMember:(AgoraRtmMember *)member {
    //deal with message
    }
   ```
   
   Generally, you can download a file to local storage via media ID.

   ```objectivec
   [AgoraRtm.kit downloadMedia:message.mediaId toFile:filePath withRequest:&requestId completion:^(long long requestId, AgoraRtmDownloadMediaErrorCode errorCode) {}];
   ```

   For scenarios that require quick save operations, you can download the file to memory:

   ```objectivec
   [AgoraRtm.kit downloadMediaToMemory:message.mediaId withRequest:&requestId completion:^(long long requestId, NSData *data, AgoraRtmDownloadMediaErrorCode errorCode) {}];
   ```

   If you need to cancel uploading or downloading a file, refer to the following example code:

   ```objectivec
   [AgoraRtm.kit cancelMediaUpload:&requestId completion:^(long long requestId, AgoraRtmCancelMediaErrorCode errorCode) {}];
   ```
	 
   ```objectivec
   [AgoraRtm.kit cancelMediaDownload:&requestId completion:^(long long requestId, AgoraRtmCancelMediaErrorCode errorCode) {}];
   ```


## Considerations

- You must log in the Agora RTM system before calling the methods.
- Make sure that the total size of message content, filename, and thumbnail must not exceed 32 KB for each message instance.
- The `filePath` parameter for uploading and downloading methods can only accept strings with UTF-8 format. The path must be absolute path.
- You can only cancel an ongoing upload or download task. The request ID is no longer valid when the corresponding task completes.
- To save the downloaded file or image to local memory, you must access the corresponding memory location when the `AgoraRtmDownloadMediaToMemoryBlock` callback completes.
- For each client, the sum total of upload tasks and download tasks must not exceed 9.
- You can set the width and height of the uploaded image by `AgoraRtmImageMessage`. The settings only exist as additional attributes and does not affect the uploaded image. The uploaded image does not resize or crop.
- The SDK automatically sets width and height for images in JPEG, JPG, BMP, and PNG. The width and height you set overwrite the SDK-calculated width and height.

## API reference

- [`createFileMessageByUploading:withRequest:completion:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/createFileMessageByUploading:withRequest:completion:)
- [`createImageMessageByUploading:withRequest:completion:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/createImageMessageByUploading:withRequest:completion:)
- [`cancelMediaUpload:completion:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/cancelMediaUpload:completion:)
- [`cancelMediaDownload:completion:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/cancelMediaDownload:completion:)
- [`createFileMessageByMediaId:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/createFileMessageByMediaId:)
- [`createImageMessageByMediaId:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/createImageMessageByMediaId:)
- [`downloadMediaToMemory:withRequest:completion:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/downloadMediaToMemory:withRequest:completion:)
- [`downloadMedia:toFile:withRequest:completion:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/downloadMedia:toFile:withRequest:completion:)
- [`rtmKit:media:uploadingProgress:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmDelegate.html#//api/name/rtmKit:media:uploadingProgress:)
- [`rtmKit:media:downloadingProgress:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmDelegate.html#//api/name/rtmKit:media:downloadingProgress:)
- [`AgoraRtmUploadFileMediaBlock`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Blocks/AgoraRtmUploadFileMediaBlock.html)
- [`AgoraRtmUploadImageMediaBlock`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Blocks/AgoraRtmUploadImageMediaBlock.html)
- [`AgoraRtmCancelMediaBlock`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Blocks/AgoraRtmCancelMediaBlock.html)
- [`AgoraRtmDownloadMediaToMemoryBlock`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Blocks/AgoraRtmDownloadMediaToMemoryBlock.html)
- [`AgoraRtmDownloadMediaToFileBlock`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Blocks/AgoraRtmDownloadMediaToFileBlock.html)
- [`rtmKit:fileMessageReceived:fromPeer:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmDelegate.html#//api/name/rtmKit:fileMessageReceived:fromPeer:)
- [`rtmKit:imageMessageReceived:fromPeer:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmDelegate.html#//api/name/rtmKit:imageMessageReceived:fromPeer:)
- [`channel:fileMessageReceived:fromMember:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmChannelDelegate.html#//api/name/channel:fileMessageReceived:fromMember:)
- [`channel:imageMessageReceived:fromMember:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmChannelDelegate.html#//api/name/channel:imageMessageReceived:fromMember:)