---
title: 发送和接收图片或文件消息
platform: Android
updatedAt: 2020-10-19 14:56:30
---
## 功能描述

你可以使用 Agora RTM SDK 发送和接收图片或文件消息。

Agora RTM SDK 支持上传下载大小不超过 30 MB 的任意文件格式的非空图片或文件。每份上传到 Agora 服务器的图片或文件都对应一个 media ID，在服务端保存 7 天。你可以通过 media ID 在 7 天有效期内从 Agora 服务器下载对应的图片或文件。

Agora RTM SDK 引入了 `RtmImageMessage` 类和 `RtmFileMessage` 类用于保存和传递系统生成的 media ID。`RtmImageMessage` 类和 `RtmFileMessage` 类继承自 `RtmMessage` 类，所以你可以通过已有的点对点消息或频道消息发送方法传递 `RtmImageMessage` 实例和 `RtmFileMessage` 实例，从而实现图片或文件消息的发送和接收。

你可以通过 `RtmImageMessage` 对象对图片进行以下操作：

- 设置相应的上传图片的显示文件名和显示缩略图。
- 获取相应的上传图片的大小。
- 获取由 SDK 计算的 JPEG、JPG、BMP、PNG 这四种格式的图片的宽高数据。
- 自行设置图片的宽和高。你自行设置的宽高数据会覆盖 SDK 计算的宽高数据。

你可以通过 `RtmFileMessage` 对象对文件进行以下操作：

- 设置相应的上传文件的显示文件名和显示缩略图。
- 获取相应的上传文件的大小。

## 实现方法

### 发送和接收图片消息

<div class="alert note">开始前请确保你已集成最新版的 Agora RTM SDK 到你的项目中，而且已实现点对点消息和频道消息功能。</div>

一般情况下的发送和接收图片消息流程如下：

1. 上传图片到 Agora 服务器。图片上传成功时，SDK 会通过回调返回一个 `RtmImageMessage` 实例。

   上传图片到 Agora 服务器：

    ```java
    RtmRequestId requestId = new RtmRequestId();
    mRtmClient.createImageMessageByUploading(fileName, requestId, new ResultCallback<RtmImageMessage>() {
        @Override
        public void onSuccess(RtmImageMessage rtmImageMessage) {
            
        }
    
        @Override
        public void onFailure(ErrorInfo errorInfo) {
    
        }
    });
    ```

   如果你存有一个已上传图片对应的 media ID 且 media ID 仍然处于 7 天有效期内，可通过如下代码直接创建一个 `RtmImageMessage` 实例:
    
    ```java
    RtmImageMessage rtmImageMessage = mRtmClient.createImageMessageByMediaId(mediaId);
    ```


2. （可选）通过获取的实例设置图片的长宽或缩略图。

   设置图片长宽：

    ```java
    rtmImageMessage.setWidth(width);
    rtmImageMessage.setHeight(height);
    ```

   设置图片缩略图：
    ```java
    rtmImageMessage.setThumbnail(byteArray);
    ```
  
3. 将 `RtmImageMessage` 实例通过点对点消息或频道消息的方式发送给指定用户或指定频道。

    发送图片点对点消息示例代码：

   ```java
    mRtmClient.sendMessageToPeer(peerId, rtmImageMessage, new SendMessageOptions(), new ResultCallback<Void>() {
        @Override
        public void onSuccess(Void aVoid) {
            
        }
    
        @Override
        public void onFailure(ErrorInfo errorInfo) {
            
        }
    });
   ```

    发送图片频道消息：

   ```java
    mRtmChannel.sendMessage(rtmImageMessage, new ResultCallback<Void>() {
        @Override
        public void onSuccess(Void aVoid) {
    
        }
    
        @Override
        public void onFailure(ErrorInfo errorInfo) {
            
        }
    });
   ```


4. 收到图片消息的用户会收到相应回调，你可以通过获取 `RtmImageMessage` 实例携带的 media ID 信息并通过 media ID 将相应图片保存至本地。

    接收图片点对点消息：

  ```java
    @Override
    public void onImageMessageReceivedFromPeer(RtmImageMessage rtmImageMessage, String peerId) {
        
    }
    ```

   接收图片频道消息：

    ```java
    @Override
    public void onImageMessageReceived(RtmImageMessage rtmImageMessage, RtmChannelMember rtmChannelMember) {
        
    }
    ```
   
   一般情况下，你可以通过 media ID 直接将图片下载至本地存储：

   ```java
    RtmRequestId requestId = new RtmRequestId();
    mRtmClient.downloadMediaToFile(
            rtmImageMessage.getMediaId(),
            filePath,
            requestId,
            new ResultCallback<Void>() {
                @Override
                public void onSuccess(Void aVoid) {
                    
                }
    
                @Override
                public void onFailure(ErrorInfo errorInfo) {
    
                }
            }
    );
   ```

    对于需要快速存取已下载图片的场景，你可以将图片下载至本地内存：

   ```java
    RtmRequestId requestId = new RtmRequestId();
    mRtmClient.downloadMediaToMemory(
            rtmImageMessage.getMediaId(),
            requestId,
            new ResultCallback<byte[]>() {
                @Override
                public void onSuccess(byte[] bytes) {
                    
                }
    
                @Override
                public void onFailure(ErrorInfo errorInfo) {
    
                }
            }
    );
   ```

   如果你要取消上传或下载图片，参考以下示例代码：

   ```java
    mRtmClient.cancelMediaUpload(requestId, new ResultCallback<Void>() {
        @Override
        public void onSuccess(Void aVoid) {
    
        }
    
        @Override
        public void onFailure(ErrorInfo errorInfo) {
    
        }
    });
   ```
   ```java
    mRtmClient.cancelMediaDownload(requestId, new ResultCallback<Void>() {
        @Override
        public void onSuccess(Void aVoid) {
            
        }
    
        @Override
        public void onFailure(ErrorInfo errorInfo) {
    
        }
    });
   ```
### 发送和接收文件消息

<div class="alert note">开始前请确保你已集成最新版的 Agora RTM SDK 到你的项目中，而且已实现点对点消息和频道消息功能。</div>

一般情况下的发送和接收文件消息流程如下：

1. 上传文件到 Agora 服务器。文件上传成功时，SDK 会通过回调返回一个 `RtmFileMessage` 实例。
   
   上传文件到 Agora 服务器：

    ```java
    RtmRequestId requestId = new RtmRequestId();
    mRtmClient.createFileMessageByUploading(filePath, requestId, new ResultCallback<RtmFileMessage>() {
        @Override
        public void onSuccess(RtmFileMessage rtmFileMessage) {
            
        }
    
        @Override
        public void onFailure(ErrorInfo errorInfo) {
    
        }
    });
    ```

   如果你存有一个已上传文件对应的 media ID 且 media ID 仍然处于 7 天有效期内，可通过如下代码直接创建一个 `RtmFileMessage` 实例:

    ```java
    RtmFileMessage rtmFileMessage = mRtmClient.createFileMessageByMediaId(mediaId);
    ```


2. （可选）通过获取的实例设置文件的缩略图。
   
    ```java
    rtmFileMessage.setThumbnail(byteArray);
    ```


3. 将 `RtmFileMessage` 实例通过点对点消息或频道消息的方式发送给指定用户或指定频道。

   发送文件点对点消息：

    ```java
    mRtmClient.sendMessageToPeer(peerId, rtmFileMessage, new SendMessageOptions(), new ResultCallback<Void>() {
        @Override
        public void onSuccess(Void aVoid) {
            
        }
    
        @Override
        public void onFailure(ErrorInfo errorInfo) {
            
        }
    });
    ```
   发送文件频道消息：

    ```java
    mRtmChannel.sendMessage(rtmFileMessage, new ResultCallback<Void>() {
        @Override
        public void onSuccess(Void aVoid) {
    
        }
    
        @Override
        public void onFailure(ErrorInfo errorInfo) {
            
        }
    });
    ```

4. 收到文件消息的用户会收到相应回调，通过获取 `RtmFileMessage` 实例携带的 media ID 信息并通过 media ID 将相应文件保存至本地。
   
   接收文件点对点消息：

    ```java
    @Override
    public void onFileMessageReceivedFromPeer(RtmFileMessage rtmFileMessage, String peerId) {
        
    }
    ```

   接收文件频道消息：

    ```java
    @Override
    public void onFileMessageReceived(RtmFileMessage rtmFileMessage, RtmChannelMember rtmChannelMember) {
        
    }
    ```
   
   一般情况下，你可以通过 media ID 直接将文件下载至本地存储：
    ```java
    RtmRequestId requestId = new RtmRequestId();
    mRtmClient.downloadMediaToFile(
            rtmFileMessage.getMediaId(),
            filePath,
            requestId,
            new ResultCallback<Void>() {
                @Override
                public void onSuccess(Void aVoid) {
                    
                }
    
                @Override
                public void onFailure(ErrorInfo errorInfo) {
    
                }
            }
    );
   ```

   对于需要快速存取已下载文件的场景，你可以将文件下载至本地内存：

   ```java
    RtmRequestId requestId = new RtmRequestId();
    mRtmClient.downloadMediaToMemory(
            rtmFileMessage.getMediaId(),
            requestId,
            new ResultCallback<byte[]>() {
                @Override
                public void onSuccess(byte[] bytes) {
                    
                }
    
                @Override
                public void onFailure(ErrorInfo errorInfo) {
    
                }
            }
    );
   ```

   如果你要取消上传或下载文件，参考以下示例代码：

   ```java
    mRtmClient.cancelMediaUpload(requestId, new ResultCallback<Void>() {
        @Override
        public void onSuccess(Void aVoid) {
    
        }
    
        @Override
        public void onFailure(ErrorInfo errorInfo) {
    
        }
    });
   ```
   ```java
    mRtmClient.cancelMediaDownload(requestId, new ResultCallback<Void>() {
        @Override
        public void onSuccess(Void aVoid) {
            
        }
    
        @Override
        public void onFailure(ErrorInfo errorInfo) {
    
        }
    });
   ```

	 


## 注意事项

- 你必须在成功登录 Agora RTM 系统后才能调用本功能相关的方法。
- 请确保每个消息实例的消息内容、显示文件名和显示缩略图的总大小不得超过 32 KB。
- 上传下载相关所有方法涉及的 `filePath` 参数必须是 UTF-8 编码格式字符串，而且必须是绝对路径。
- 你只能取消正在进行中的上传或下载任务。上传或下载任务结束后，对应的 request ID 将不再有效。
- 如需将下载文件或图片存储至本地内存，你必须在收到 `onSuccess` 回调后再访问相应内存地址。
- 每个客户端实例支持同时进行最多 9 个上传或下载任务（上传和下载任务一并计算）。
- 你可以通过 `RtmImageMessage` 自行设置上传图片的宽和高。设置内容只作为上传图片的附加属性存在，不影响上传图片本身内容。SDK 也不会对上传图片进行裁剪或缩放。
- SDK 会自动为 JPEG、JPG、BMP、PNG 四种格式的图片计算宽高。你自行设置的宽高数据将覆盖 SDK 计算的图片宽高。

## API 参考

- [`createFileMessageByMediaId`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ae4104179072ed6ebcf050d12250c7a1b)
- [`createImageMessageByMediaId`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#aaa3e2556fc93af882fd2758419c682af)
- [`createFileMessageByUploading`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a1b08207278d611e5e4b87e6d9712e0c7)
- [`createImageMessageByUploading`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#afc93fad7700593a803ddbc87482c0ac0)
- [`downloadMediaToMemory`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a3d2568cc940dfd8c8110e70dcc4fb85d)
- [`downloadMediaToFile`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a34e0bd19fb0bbd1d91dec0a1af100038)
- [`cancelMediaUpload`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a17467b5b336a39bc0d29058244aa7c0c)
- [`cancelMediaDownload`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a21af4c790dcb6547253ffd43114696a5)
- [`onImageMessageReceived`](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html#aa5e74313bc9c7a47e2e877690bbd5b8d)
- [`onFileMessageReceived`](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html#a0d6889ad993ae6e99edaa1d05e67ba77)
- [`onImageMessageReceivedFromPeer`](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#a9cdc9016e7b3349d8340318411852ccf)
- [`onFileMessageReceivedFromPeer`](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#a812843550667e2e13068d4715d2fa98b)
- [`onMediaUploadingProgress`](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#ad54b344caf11bcbfb086a15e96fbb9f2)
- [`onMediaDownloadingProgress`](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#a1f774858444cc9b36369cbee4770df9c)

