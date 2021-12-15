---
title: 发送和接收图片或文件消息
platform: Windows
updatedAt: 2020-10-19 14:58:33
---

v1.3.0 支持上传下载大小不超过 30 MB 的任意文件格式的非空图片或文件，支持随时取消正在进行中的上传或下载任务。每份上传到 Agora 服务器的图片都对应一个 media ID，在服务端默认保存 7 天。你可以通过 media ID 在 7 天有效期内从 Agora 服务器下载对应的图片或文件。

v1.3.0 引入了 `IImageMessage` 类和 `IFileMessage` 类用于保存和传递系统生成的 media ID。`IImageMessage` 类和 `IFileMessage` 类继承自 `IMessage` 类，所以你可以通过已有的点对点消息或频道消息发送方法传递 `IImageMessage` 实例和 `IFileMessage` 实例。

你可以通过 `IImageMessage` 对象对图片进行以下操作：

- 设置相应的上传图片的显示文件名和显示缩略图。
- 获取相应的上传图片的大小。
- 获取 SDK 为 JPEG、JPG、BMP，以及 PNG 这四种格式的图片计算的宽高数据。
- 自行设置图片的宽和高。你自行设置的宽高数据会覆盖 SDK 计算的宽高数据。

你可以通过 `IFileMessage` 对象对文件进行以下操作：

- 设置相应的上传文件的显示文件名和显示缩略图。
- 获取相应的上传文件的大小。

### 发送和接收图片消息

<div class="alert note">开始前请确保你已集成最新版的 Agora RTM SDK 到你的项目中，已实现点对点消息和频道消息功能。</div>

一般情况下的图片上传下载流程如下：

1. 上传图片到文件服务器。图片上传成功时，SDK 会通过回调返回一个 `IImageMessage` 实例。

   上传图片到文件服务器示例代码：

   ```cpp
   m_rtmService->createImageMessageByUploading(filePath.c_str(), requestId);
   ```

   如果你存有一个已上传图片对应的 media ID 且 media ID 仍然处于 7 天有效期内，可通过如下代码直接创建一个 `IImageMessage` 实例:

   ```cpp
   m_rtmService->createImageMessageByMediaId(mediaId.c_str());
   ```

2. (可选)通过获取的实例设置图片的长宽或缩略图。

   设置图片长宽示例代码：

   ```cpp
   imageMessage->setWidth(imageWidth);
   imageMessage->setWidth(imageHeight);
   ```

   设置图片缩略图示例代码：

   ```cpp
   imageMessage->setThumbnailWidth(thumbWidth);
   imageMessage->setThumbnailHeight(thumbHeight);
   ```

3. 将 `IImageMessage` 实例通过点对点消息或频道消息的方式将消息发送给指定用户或指定频道。

   `IImageMessage` 继承自 `IMessage` 类，所以你可以使用已有的点对点消息或频道消息方法发送 `IImageMessage` 实例。

   发送图片频道消息示例代码：

   ```cpp
   m_Channel->sendMessage(imageMessage, options);
   ```

   发送图片点对点消息示例代码：

   ```cpp
   m_rtmService->sendMessageToPeer(account.c_str(), imageMessage, options);
   ```

4. 收到图片消息的用户会收到相应回调，你可以通过获取 `IImageMessage` 实例携带的 media ID 信息并通过 media ID 将相应图片保存至本地。

   接收图片频道消息示例代码：

   ```cpp
   // CRTMCallBack extend from IChannelEventHandler
   void CRTMCallBack::onImageMessageReceived(const char *userId, const IImageMessage* message)
   {
       if(message){
           //deal with message
       }
   }
   ```

   接收图片点对点消息示例代码：

   ```cpp
   // CRTMCallBack extend from IRtmServiceEventHandler
   void CRTMCallBack::onImageMessageReceivedFromPeer(const char *peerId, const IImageMessage* message)
   {
       if(message){
           //deal with message
       }
   }
   ```

   一般情况下，你可以通过 media ID 直接将图片下载至本地存储：

   ```cpp
   m_rtmService->downloadMediaToFile(mediaId.c_str(), filePath.c_str(), requestId);
   ```

   对于需要快速存取已下载图片的场景，你可以将图片下载至本地内存：

   ```cpp
   m_rtmService->downloadMediaToMemory(mediaId.c_str(), long long &requestId);
   ```

   如果你要取消上传或下载图片，参考以下示例代码：

   ```cpp
   m_rtmService->cancelMediaUpload(requestId);
   ```

如果你存有一个已上传图片对应的 media ID 且 media ID 仍然处于 7 天有效期内，则无需再次上传图片至服务端。流程如下：

1. 通过 media ID 在本地创建一个图片消息实例。创建成功时，SDK 会立刻返回一个 `IImageMessage` 实例。

2. (可选)通过获取的实例设置图片的长宽或缩略图。

3. 将 `IImageMessage` 实例通过点对点消息或频道消息的方式将消息发送给指定用户或指定频道。收到图片消息的用户会收到相应回调，通过获取 `IImageMessage` 实例携带的 media ID 信息并通过 media ID 将相应图片保存至本地。

### 发送和接收文件消息

<div class="alert note">开始前请确保你已集成最新版的 Agora RTM SDK 到你的项目中，已实现点对点消息和频道消息功能。</div>

一般情况下的文件上传下载流程如下：

1. 上传文件到文件服务器。文件上传成功时，SDK 会通过回调返回一个 `IFileMessage` 实例。

   上传文件到文件服务器示例代码：

   ```cpp
   m_rtmService->createFileMessageByUploading(filePath.c_str(), requestId);
   ```

   如果你存有一个已上传文件对应的 media ID 且 media ID 仍然处于 7 天有效期内，可通过如下代码直接创建一个 `IFileMessage` 实例:

   ```cpp
   m_rtmService->createFileMessageByMediaId(mediaId.c_str());
   ```

2. (可选)通过获取的实例设置文件的缩略图。

   ```cpp
   imageMessage->setThumbnail(imageData, imageSize);
   ```

3. 将 `IFileMessage` 实例通过点对点消息或频道消息的方式将消息发送给指定用户或指定频道。

   `IFileMessage` 继承自 `IMessage` 类，所以你可以使用已有的点对点消息或频道消息方法发送 `IFileMessage` 实例。

   发送文件频道消息示例代码：

   ```cpp
   m_Channel->sendMessage(fileMessage, options);
   ```

   发送文件点对点消息示例代码：

   ```cpp
   m_rtmService->sendMessageToPeer(account.c_str(), fileMessage, options);
   ```

4. 收到文件消息的用户会收到相应回调，通过获取 `IFileMessage` 实例携带的 media ID 信息并通过 media ID 将相应文件保存至本地。

   接收文件频道消息示例代码：

   ```cpp
   // CRTMCallBack extend from IChannelEventHandler
   void CRTMCallBack::onFileMessageReceived(const char *userId, const IFileMessage* message)
   {
       if(message){
           //deal with message
       }
   }
   ```

   接收文件点对点消息示例代码：

   ```cpp
   // CRTMCallBack extend from IRtmServiceEventHandler
   void CRTMCallBack::onFileMessageReceivedFromPeer(const char *peerId, const IFileMessage* message)
   {
       if(message){
           //deal with message
       }
   }
   ```

   一般情况下，你可以通过 media ID 直接将文件下载至本地存储：

   ```cpp
   m_rtmService->downloadMediaToFile(mediaId.c_str(), filePath.c_str(), requestId);
   ```

   对于需要快速存取已下载文件的场景，你可以将文件下载至本地内存：

   ```cpp
   m_rtmService->downloadMediaToMemory(mediaId.c_str(), long long &requestId);
   ```

   如果你要取消上传或下载文件，参考以下示例代码：

   ```cpp
   m_rtmService->cancelMediaUpload(requestId);
   ```

如果你存有一个已上传文件对应的 media ID 且 media ID 仍然处于 7 天有效期内，则无需再次上传文件至服务端。流程如下：

1. 通过 media ID 在本地创建一个文件消息实例。创建成功时，SDK 会立刻返回一个 `IFileMessage` 实例。

2. (可选)通过获取的实例设置文件的缩略图。

3. 将 `IFileMessage` 实例通过点对点消息或频道消息的方式将消息发送给指定用户或指定频道。收到文件消息的用户会收到相应回调，通过获取 `IFileMessage` 实例携带的 media ID 信息并通过 media ID 将相应文件保存至本地。

## 注意事项

- 本功能涉及所有方法都应该在成功登录 Agora RTM 系统后才能调用。
- 请确保每个消息实例的消息内容、显示文件名和显示缩略图的总大小不得超过 32 KB。
- SDK 不会自动设置缩略图。如需使用缩略图，你需要自行设置。缩略图格式为二进制格式数据。
- 上传下载相关所有方法涉及的 `filePath` 参数必须是 UTF-8 编码格式字符串，必须是完整文件路径。
- 你只能取消正在进行中的上传或下载任务。上传或下载任务结束后，对应的 request ID 将不再有效。
- 如需将下载文件或图片存储至本地内存，你应该在 `onDownloadMediaToMemoryResult` 回调结束后访问相应内存地址。
- 每个客户端实例支持同时进行最多 9 个上传或下载任务(上传和下载任务一并计算)。
- 你可以通过 `IImageMessage` 自行设置的上传图片的宽和高。设置内容只作为上传图片的附加属性存在，不影响上传图片本身内容，不会对上传图片进行裁剪或缩放。
- SDK 会自动为 JPEG、JPG、BMP、PNG 四种格式的图片计算宽高。你自行设置的宽高数据将覆盖 SDK 计算的图片宽高。
- 消息发送方在不需要 `IImageMessage` 实例时需要调用该实例的 `release` 方法将其销毁。

## API 参考

- [createFileMessageByUploading](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a99f2137ec43be135b369b7d6927b6138): 上传一份文件到 Agora 服务器以获取一个相应的 [IFileMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_file_message.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a0090bbb72e250ffbaedc84d9041b64b1) 文件消息实例。
- [createImageMessageByUploading](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a7192d93f365c28e2d0b91547716fb5a9): 上传一份图片到 Agora 服务器以获取一个相应的 [IImageMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_image_message.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a0090bbb72e250ffbaedc84d9041b64b1) 图片消息实例。
- [cancelMediaUpload](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a0090bbb72e250ffbaedc84d9041b64b1): 通过 request ID 取消一个正在进行中的文件或图片上传任务。
- [cancelMediaDownload](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#adc34b7acad8b845fe1242efd127d82b9): 通过 request ID 取消一个正在进行中的文件或图片下载任务。
- [createFileMessageByMediaId](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a6e4b13011388ec45e8a02377b240506f): 通过已有的 media ID 创建一个 [IFileMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_file_message.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a0090bbb72e250ffbaedc84d9041b64b1) 实例。
- [createImageMessageByMediaId](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a97bfb847ff876ab216cf219f4b4f856d): 通过已有的 media ID 创建一个 [IImageMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_image_message.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a0090bbb72e250ffbaedc84d9041b64b1) 实例。
- [downloadMediaToMemory](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#ade134da2be907a8078ce693849e0cc37): 通过 media ID 从 Agora 服务器下载文件或图片至本地内存。
- [downloadMediaToFile](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a70584eb57e97476b1da072f737d88c95): 通过 media ID 从 Agora 服务器下载文件或图片至本地指定地址。
- [onMediaUploadingProgress](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a56d5464c3b5e53c44039190a3ac4dfe9): 主动回调：上传任务的上传进度回调。
- [onMediaDownloadingProgress](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a9c4dfbb224f69b73f64dc1bf34f28567): 主动回调：下载任务的下载进度回调。
- [onMediaCancelResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a64cac4d387e2bf6a419bb478358570f6): 返回 [cancelMediaDownload](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#adc34b7acad8b845fe1242efd127d82b9) 或 [cancelMediaUpload](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a0090bbb72e250ffbaedc84d9041b64b1) 方法的调用结果。
- [onFileMediaUploadResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#aadaa8cd5309e4e70ab2cbdfc1ef21241): 返回 [createFileMessageByUploading](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a99f2137ec43be135b369b7d6927b6138) 方法的调用结果。
- [onImageMediaUploadResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#abaeeaeb6d69b98510d6c3b012849251e): 返回 [createImageMessageByUploading](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a7192d93f365c28e2d0b91547716fb5a9) 方法的调用结果。
- [onFileMessageReceivedFromPeer](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a4642bb3a8ddf026617fff47d1c9f3e3a): 收到点对点文件消息回调。
- [onImageMessageReceivedFromPeer](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a2682e64be745cf7af816a12f9895ce07): 收到点对点图片消息回调。
- [onFileMessageReceived](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_channel_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a416dd103c84387a5147e962398eff8d1): 收到频道文件消息回调。
- [onImageMessageReceived](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_channel_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a6d710170df9b3c1f0ef092012af2e317): 收到频道图片消息回调。
- [onMediaDownloadToMemoryResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#ad0de249a8f0b79973f34f295cabe4904): 返回 [downloadMediaToMemory](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#ade134da2be907a8078ce693849e0cc37) 方法的调用结果。
- [onMediaDownloadToFileResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a0b6edc7b944eab02d545bb2d2d1bfe2f): 返回 [downloadMediaToFile](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a70584eb57e97476b1da072f737d88c95) 方法的调用结果。
