---
title: 发送和接收图片或文件消息
platform: iOS
updatedAt: 2020-10-19 14:57:07
---

## 功能描述

你可以使用 Agora RTM SDK 发送和接收图片或文件消息。Agora RTM SDK 支持上传下载大小不超过 30 MB 的任意文件格式的非空图片或文件。每份上传到 Agora 服务器的图片或文件都对应一个 media ID，在服务端保存 7 天。你可以通过 media ID 在 7 天有效期内从 Agora 服务器下载对应的图片或文件。Agora RTM SDK 引入了 `AgoraRtmImageMessage` 接口类和 `AgoraRtmFileMessage` 接口类用于保存和传递系统生成的 media ID。`AgoraRtmImageMessage` 接口类和 `AgoraRtmFileMessage` 接口类继承自 `AgoraRtmMessage` 接口类，所以你可以通过已有的点对点消息或频道消息发送方法传递 `AgoraRtmImageMessage` 实例和 `AgoraRtmFileMessage` 实例，从而实现图片或文件消息的发送和接收。

你可以通过 `AgoraRtmImageMessage` 对象对图片进行以下操作：

- 设置相应的上传图片的显示文件名和显示缩略图。
- 获取相应的上传图片的大小。
- 获取 SDK 为 JPEG、JPG、BMP，以及 PNG 这四种格式的图片计算的宽高数据。
- 自行设置图片的宽和高。你自行设置的宽高数据会覆盖 SDK 计算的宽高数据。

你可以通过 `AgoraRtmFileMessage` 对象对文件进行以下操作：

- 设置相应的上传文件的显示文件名和显示缩略图。
- 获取相应的上传文件的大小。

## 实现方法

### 发送和接收图片消息

<div class="alert note">开始前请确保你已集成最新版的 Agora RTM SDK 到你的项目中，已实现点对点消息和频道消息功能。</div>

一般情况下的图片上传下载流程如下：

1. 上传图片到文件服务器。图片上传成功时，SDK 会通过回调返回一个 `AgoraRtmImageMessage` 实例。

   上传图片到文件服务器示例代码：

   ```objectivec
    [AgoraRtm.kit createImageMessageByUploading:imagePath withRequest:&requestId completion:^(long long requestId, AgoraRtmImageMessage *message, AgoraRtmUploadMediaErrorCode errorCode) {
        //deal with message
    }];
   ```

   如果你存有一个已上传图片对应的 media ID 且 media ID 仍然处于 7 天有效期内，可通过如下代码直接创建一个 `AgoraRtmImageMessage` 实例:

   ```objectiveC
   [AgoraRtm.kit createImageMessageByMediaId:mediaId];
   ```

2. (可选)通过获取的实例设置图片的长宽或缩略图。

   设置图片长宽示例代码：

   ```objectivec
   [message setWidth:imageWidth];
   [message setHeight:imageHeight];
   ```

   设置图片缩略图示例代码：

   ```objectivec
   message.thumbnailWidth = thumbnailImage.size.width;
   message.thumbnailHeight = thumbnailImage.size.height;
   ```

3. 将 `IImageMessage` 实例通过点对点消息或频道消息的方式发送给指定用户或指定频道。`AgoraRtmImageMessage` 继承自 `AgoraRtmMessage` 接口类，所以你可以使用已有的点对点消息或频道消息方法发送 `AgoraRtmImageMessage` 实例。

   发送图片点对点消息示例代码：

   ```objectivec
   [AgoraRtm.kit sendMessage:rtmMessage toPeer:self.mode.name sendMessageOptions:option completion:^(AgoraRtmSendPeerMessageErrorCode errorCode) {}];
   ```

   发送图片频道消息示例代码：

   ```objectivec
   [self.rtmChannel sendMessage:rtmMessage completion:^(AgoraRtmSendChannelMessageErrorCode errorCode) {}];
   ```

4. 收到图片消息的用户会收到相应回调，你可以通过获取 `AgoraRtmImageMessage` 实例携带的 media ID 信息并通过 media ID 将相应图片保存至本地。

   接收图片点对点消息示例代码：

   ```objectivec
   - (void)rtmKit:(AgoraRtmKit *)kit imageMessageReceived:(AgoraRtmImageMessage *)message fromPeer:(NSString *)peerId {
    //deal with message
    }
   ```

   接收图片频道消息示例代码：

   ```objectivec
   - (void)channel:(AgoraRtmChannel *)channel imageMessageReceived:(AgoraRtmImageMessage *)message fromMember:(AgoraRtmMember *)member {
    //deal with message
    }
   ```

   一般情况下，你可以通过 media ID 直接将图片下载至本地存储：

   ```objectivec
   [AgoraRtm.kit downloadMedia:message.mediaId toFile:filePath withRequest:&requestId completion:^(long long requestId, AgoraRtmDownloadMediaErrorCode errorCode) {}];
   ```

   对于需要快速存取已下载图片的场景，你可以将图片下载至本地内存：

   ```objectivec
   [AgoraRtm.kit downloadMediaToMemory:message.mediaId withRequest:&requestId completion:^(long long requestId, NSData *data, AgoraRtmDownloadMediaErrorCode errorCode) {}];
   ```

   如果你要取消上传或下载图片，参考以下示例代码：

   ```objectivec
   [AgoraRtm.kit cancelMediaUpload:&requestId completion:^(long long requestId, AgoraRtmCancelMediaErrorCode errorCode) {}];
   ```

如果你存有一个已上传图片对应的 media ID 且 media ID 仍然处于 7 天有效期内，则无需再次上传图片至服务端。流程如下：

1. 通过 media ID 在本地创建一个图片消息实例。创建成功时，SDK 会立刻返回一个 `AgoraRtmImageMessage` 实例。

2. (可选)通过获取的实例设置图片的长宽或缩略图。

3. 将 `AgoraRtmImageMessage` 实例通过点对点消息或频道消息的方式发送给指定用户或指定频道。收到图片消息的用户会收到相应回调，通过获取 `AgoraRtmImageMessage` 实例携带的 media ID 信息并通过 media ID 将相应图片保存至本地。

### 发送和接收文件消息

<div class="alert note">开始前请确保你已集成最新版的 Agora RTM SDK 到你的项目中，已实现点对点消息和频道消息功能。</div>

一般情况下的文件上传下载流程如下：

1. 上传文件到文件服务器。文件上传成功时，SDK 会通过回调返回一个 `AgoraRtmFileMessage` 实例。

   上传文件到文件服务器示例代码：

   ```objectivec
    [AgoraRtm.kit createFileMessageByUploading:filePath withRequest:&requestId completion:^(long long requestId, AgoraRtmFileMessage *message, AgoraRtmUploadMediaErrorCode errorCode) {
        //deal with message
    }];
   ```

   如果你存有一个已上传文件对应的 media ID 且 media ID 仍然处于 7 天有效期内，可通过如下代码直接创建一个 `AgoraRtmFileMessage` 实例:

   ```objectivec
   [AgoraRtm.kit createFileMessageByMediaId:mediaId];
   ```

2. (可选)通过获取的实例设置文件的缩略图。

   ```objectivec
   UIImage *thumbnailImage = [weakSelf generateThumbnail:imagePath toByte:5 * 1024];
   if(thumbnailImage != nil) {
   message.thumbnail = imageData;
   }
   ```

3. 将 `AgoraRtmFileMessage` 实例通过点对点消息或频道消息的方式发送给指定用户或指定频道。

   `AgoraRtmFileMessage` 继承自 `AgoraRtmMessage` 接口类，所以你可以使用已有的点对点消息或频道消息方法发送 `AgoraRtmFileMessage` 实例。

   发送文件点对点消息示例代码：

   ```objectivec
   [AgoraRtm.kit sendMessage:rtmMessage toPeer:self.mode.name sendMessageOptions:option completion:^(AgoraRtmSendPeerMessageErrorCode errorCode) {}];
   ```

   发送文件频道消息示例代码：

   ```objectivec
   [self.rtmChannel sendMessage:rtmMessage completion:^(AgoraRtmSendChannelMessageErrorCode errorCode) {}];
   ```

4. 收到文件消息的用户会收到相应回调，你可以通过获取 `AgoraRtmFileMessage` 实例携带的 media ID 信息并通过 media ID 将相应文件保存至本地。

   接收文件点对点消息示例代码：

   ```objectivec
   - (void)rtmKit:(AgoraRtmKit *)kit fileMessageReceived:(AgoraRtmFileMessage *)message fromPeer:(NSString *)peerId {
    //deal with message
    }
   ```

   接收文件频道消息示例代码：

   ```objectivec
   - (void)channel:(AgoraRtmChannel *)channel fileMessageReceived:(AgoraRtmFileMessage *)message fromMember:(AgoraRtmMember *)member {
    //deal with message
    }
   ```

   一般情况下，你可以通过 media ID 直接将文件下载至本地存储：

   ```objectivec
   [AgoraRtm.kit downloadMedia:message.mediaId toFile:filePath withRequest:&requestId completion:^(long long requestId, AgoraRtmDownloadMediaErrorCode errorCode) {}];
   ```

   对于需要快速存取已下载文件的场景，你可以将文件下载至本地内存：

   ```objectivec
   [AgoraRtm.kit downloadMediaToMemory:message.mediaId withRequest:&requestId completion:^(long long requestId, NSData *data, AgoraRtmDownloadMediaErrorCode errorCode) {}];
   ```

   如果你要取消上传或下载文件，参考以下示例代码：

   ```objectivec
   [AgoraRtm.kit cancelMediaUpload:&requestId completion:^(long long requestId, AgoraRtmCancelMediaErrorCode errorCode) {}];
   ```

如果你存有一个已上传文件对应的 media ID 且 media ID 仍然处于 7 天有效期内，则无需再次上传文件至服务端。流程如下：

1. 通过 media ID 在本地创建一个文件消息实例。创建成功时，SDK 会立刻返回一个 `AgoraRtmFileMessage` 实例。

2. (可选)通过获取的实例设置文件的缩略图。

3. 将 `AgoraRtmFileMessage` 实例通过点对点消息或频道消息的方式发送给指定用户或指定频道。收到文件消息的用户会收到相应回调，通过获取 `AgoraRtmFileMessage` 实例携带的 media ID 信息并通过 media ID 将相应文件保存至本地。

## 注意事项

- 本功能涉及所有方法都应该在成功登录 Agora RTM 系统后才能调用。
- 请确保每个消息实例的消息内容、显示文件名和显示缩略图的总大小不得超过 32 KB。
- SDK 不会自动设置缩略图。如需使用缩略图，你需要自行设置。缩略图格式为二进制格式数据。
- 上传下载相关所有方法涉及的 `filePath` 参数必须是 UTF-8 编码格式字符串，必须是完整文件路径。
- 你只能取消正在进行中的上传或下载任务。上传或下载任务结束后，对应的 request ID 将不再有效。
- 如需将下载文件或图片存储至本地内存，你应该在 `AgoraRtmDownloadMediaToMemoryBlock` 回调结束后访问相应内存地址。
- 每个客户端实例支持同时进行最多 9 个上传或下载任务(上传和下载任务一并计算)。
- 你可以通过 `AgoraRtmImageMessage` 自行设置的上传图片的宽和高。设置内容只作为上传图片的附加属性存在，不影响上传图片本身内容，不会对上传图片进行裁剪或缩放。
- SDK 会自动为 JPEG、JPG、BMP、PNG 四种格式的图片计算宽高。你自行设置的宽高数据将覆盖 SDK 计算的图片宽高。

## API 参考

- [createFileMessageByUploading:withRequest:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html#//api/name/createFileMessageByUploading:withRequest:completion:): 上传一份文件到 Agora 服务器以获取一个相应的 [AgoraRtmFileMessage](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmFileMessage.html) 文件消息实例。
- [createImageMessageByUploading:withRequest:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html#//api/name/createImageMessageByUploading:withRequest:completion:): 上传一份图片到 Agora 服务器以获取一个相应的 [AgoraRtmImageMessage](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmImageMessage.html) 图片消息实例。
- [cancelMediaUpload:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html#//api/name/cancelMediaUpload:completion:): 通过 request ID 取消一个正在进行中的文件或图片上传任务。
- [cancelMediaDownload:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html#//api/name/cancelMediaDownload:completion:): 通过 request ID 取消一个正在进行中的文件或图片下载任务。
- [createFileMessageByMediaId:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html#//api/name/createFileMessageByMediaId:): 通过已有的 media ID 创建一个 [AgoraRtmFileMessage](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmFileMessage.html) 实例。
- [createImageMessageByMediaId:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html#//api/name/createImageMessageByMediaId:): 通过已有的 media ID 创建一个 [AgoraRtmImageMessage](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmImageMessage.html) 实例。
- [downloadMediaToMemory:withRequest:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html#//api/name/downloadMediaToMemory:withRequest:completion:): 通过 media ID 从 Agora 服务器下载文件或图片至本地内存。
- [downloadMedia:toFile:withRequest:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html#//api/name/downloadMedia:toFile:withRequest:completion:): 通过 media ID 从 Agora 服务器下载文件或图片至本地指定地址。
- [rtmKit:media:uploadingProgress:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Protocols/AgoraRtmDelegate.html#//api/name/rtmKit:media:uploadingProgress:): 主动回调：上传任务的上传进度回调。
- [rtmKit:media:downloadingProgress:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Protocols/AgoraRtmDelegate.html#//api/name/rtmKit:media:downloadingProgress:): 主动回调：下载任务的下载进度回调。
- [AgoraRtmUploadFileMediaBlock](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Blocks/AgoraRtmUploadFileMediaBlock.html): 返回 [createFileMessageByUploading:withRequest:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html#//api/name/createFileMessageByUploading:withRequest:completion:) 方法的调用结果。
- [AgoraRtmUploadImageMediaBlock](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Blocks/AgoraRtmUploadImageMediaBlock.html): 返回 [createImageMessageByUploading:withRequest:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html#//api/name/createImageMessageByUploading:withRequest:completion:) 方法的调用结果。
- [AgoraRtmCancelMediaBlock](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Blocks/AgoraRtmCancelMediaBlock.html): 返回 [cancelMediaUpload:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html#//api/name/cancelMediaUpload:completion:) 或 [cancelMediaDownload:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html#//api/name/cancelMediaDownload:completion:) 方法的调用结果。
- [AgoraRtmDownloadMediaToMemoryBlock](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Blocks/AgoraRtmDownloadMediaToMemoryBlock.html): 返回 [downloadMediaToMemory:withRequest:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html#//api/name/downloadMediaToMemory:withRequest:completion:) 方法的调用结果。
- [AgoraRtmDownloadMediaToFileBlock](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Blocks/AgoraRtmDownloadMediaToFileBlock.html): 返回 [downloadMedia:toFile:withRequest:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html#//api/name/downloadMedia:toFile:withRequest:completion:) 方法的调用结果。
- [rtmKit:fileMessageReceived:fromPeer:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Protocols/AgoraRtmDelegate.html#//api/name/rtmKit:fileMessageReceived:fromPeer:): 收到点对点文件消息回调。
- [rtmKit:imageMessageReceived:fromPeer:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Protocols/AgoraRtmDelegate.html#//api/name/rtmKit:imageMessageReceived:fromPeer:): 收到点对点图片消息回调。
- [channel:fileMessageReceived:fromMember:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Protocols/AgoraRtmChannelDelegate.html#//api/name/channel:fileMessageReceived:fromMember:): 收到频道文件消息回调。
- [channel:imageMessageReceived:fromMember:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Protocols/AgoraRtmChannelDelegate.html#//api/name/channel:imageMessageReceived:fromMember:): 收到频道图片消息回调。
