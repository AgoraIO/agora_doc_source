---
title: Send and Receive Image or File Messages
platform: Linux Java
updatedAt: 2020-10-19 15:18:14
---
## Introduction

You can use Agora RTM SDK to send and receive image or file messages. 

The RTM SDK supports sending non-empty images and files that do not exceed 30 MB in size. Each image or file you upload to the Agora server stays for seven days and has a corresponding media ID. You can download the image or file from the Agora server with the media ID. 

The RTM SDK adds the `RtmImageMessage` class and the `RtmFileMessage` class to save and transfer media ID. Because the `RtmImageMessage` class and the `RtmFileMessage` class inherit from the `RtmMessage` class, you can use existing peer-to-peer or channel messaging to transfer the `RtmImageMessage` instance and the `RtmFileMessage` instance. Thus, you can send and receive image or file messages.

You can use the `RtmImageMessage` class to perform the following image operations:

- Set the filename and thumbnail of the uploaded image.
- Get the size of the uploaded image.
- Get the SDK-calculated width and height of images in JPEG, JPG, BMP, and PNG format.
- Set the width and height of images. The width or height you set overwrites SDK-calculated width or height.

You can use the `RtmFileMessage` class to perform the following file operations:

- Set the name and thumbnail of the uploaded file.
- Get the size of the uploaded file.

## Implementation

### Send and receive image messages

<div class="alert note">Before you start, ensure that you have integrated the latest SDK into your project. You must also enable peer-to-peer and channel messages.</div>

The following steps show the general process of sending and receiving an image message:

1. Upload an image to the Agora server. When the image is successfully uploaded, the SDK returns an `RtmImageMessage` instance by callback.

   Sample code for uploading an image to the Agora server:

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

    If you have a corresponding media ID for an image that is still on the Agora server, you can create an `RtmImageMessage` instance with the following code:

    ```java
    RtmImageMessage rtmImageMessage = mRtmClient.createImageMessageByMediaId(mediaId);
    ```

2. (Optional) Set the width, height, or thumbnail of the image by the `RtmImageMessage` instance.

    Sample code for setting the width and height of the image:

    ```java
    rtmImageMessage.setWidth(width);
    rtmImageMessage.setHeight(height);
    ```

    Sample code for setting the thumbnail of the image:

    ```java
    rtmImageMessage.setThumbnail(byteArray);
    ```
  
3. Send the `RtmImageMessage` instance via peer-to-peer or channel messaging to a user or channel. The `RtmImageMessage` class inherits from the `RtmMessage` class, enabling you to use peer-to-peer or channel messaging to send the `RtmImageMessage` instance.

   Sample code for sending a peer-to-peer image message:

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

   Sample code for sending a channel image message:

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

4. The user who receives the image message can receive the corresponding callback. You can get the media ID from the `RtmImageMessage` instance and save the image by media ID.

    Sample code for receiving a peer-to-peer image message:

    ```java
    @Override
    public void onImageMessageReceivedFromPeer(RtmImageMessage rtmImageMessage, String peerId) {
        
    }
    ```

   Sample code for receiving a channel image message:

    ```java
    @Override
    public void onImageMessageReceived(RtmImageMessage rtmImageMessage, RtmChannelMember rtmChannelMember) {
        
    }
    ```
   
   Typically, you can download an image to local storage via media ID.

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

   For scenarios that require quick save operations, you can download the image to memory:

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

   If you need to cancel uploading or downloading an image, refer to the following example code:

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

### Send and receive file messages

<div class="alert note">Before you start, ensure that you have integrated the latest SDK into your project. You must also enable peer-to-peer and channel messages.</div>

The following steps show the general process of sending and receiving a file message:

1. Upload a file to the Agora server. When the file is successfully uploaded, the SDK returns an `RtmFileMessage` instance by callback.
   
   Sample code for uploading a file to the Agora server:

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

    If you have a corresponding media ID for a file that is still in the Agora server, you can create an `RtmFileMessage` instance with the following code:

    ```java
    RtmFileMessage rtmFileMessage = mRtmClient.createFileMessageByMediaId(mediaId);
    ```

2. (Optional) Set the thumbnail of the file by the `RtmFileMessage` instance.

    ```java
    rtmFileMessage.setThumbnail(byteArray);
    ```

3. Send the `RtmFileMessage` instance via peer-to-peer or channel messaging to a user or channel. The `RtmFileMessage` class inherits from the `RtmMessage` class, enabling you to use peer-to-peer or channel messaging to send the `RtmFileMessage` instance.

   Sample code for sending a peer-to-peer file message:

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

   Sample code for sending a channel file message:

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

4. The user who receives the file message can receive the corresponding callback. You can get the media ID from the `RtmFileMessage` instance and save the file by media ID.

    Sample code for receiving a peer-to-peer file message:

    ```java
    @Override
    public void onFileMessageReceivedFromPeer(RtmFileMessage rtmFileMessage, String peerId) {
        
    }
    ```

   Sample code for receiving a channel file message:

    ```java
    @Override
    public void onFileMessageReceived(RtmFileMessage rtmFileMessage, RtmChannelMember rtmChannelMember) {
        
    }
    ```
   
   Typically, you can download a file to local storage via media ID.

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

   For scenarios that require quick save operations, you can download the file to memory:

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

   If you need to cancel uploading or downloading a file, refer to the following example code:

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


## Considerations

- You must log in to the Agora RTM system before calling the methods.
- Ensure that the total size of message content, filename, and thumbnail does not exceed 32 KB for each message instance.
- The `filePath` parameter for uploading and downloading methods can only accept strings with UTF-8 format. The path must be an absolute path.
- You can only cancel an ongoing upload or download task. The request ID is no longer valid when the corresponding task completes.
- To save the downloaded file or image to local memory, you must access the corresponding memory location when the `onSuccess` callback completes.
- For each client, do not exceed a total of nine upload tasks and download tasks.
- You can set the width and height of the uploaded image by `RtmImageMessage`. The settings only exist as additional attributes and does not affect the uploaded image. The uploaded image is not resized or cropped.
- The SDK automatically sets width and height for images in JPEG, JPG, BMP, and PNG. The width or height you set overwrites the SDK-calculated width or height.

## API reference

- [`createFileMessageByMediaId`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ae4104179072ed6ebcf050d12250c7a1b)
- [`createImageMessageByMediaId`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#aaa3e2556fc93af882fd2758419c682af)
- [`createFileMessageByUploading`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a1b08207278d611e5e4b87e6d9712e0c7)
- [`createImageMessageByUploading`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#afc93fad7700593a803ddbc87482c0ac0)
- [`downloadMediaToMemory`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a3d2568cc940dfd8c8110e70dcc4fb85d)
- [`downloadMediaToFile`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a34e0bd19fb0bbd1d91dec0a1af100038)
- [`cancelMediaUpload`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a17467b5b336a39bc0d29058244aa7c0c)
- [`cancelMediaDownload`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a21af4c790dcb6547253ffd43114696a5)
- [`onImageMessageReceived`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html#aa5e74313bc9c7a47e2e877690bbd5b8d)
- [`onFileMessageReceived`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html#a0d6889ad993ae6e99edaa1d05e67ba77)
- [`onImageMessageReceivedFromPeer`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#a9cdc9016e7b3349d8340318411852ccf)
- [`onFileMessageReceivedFromPeer`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#a812843550667e2e13068d4715d2fa98b)
- [`onMediaUploadingProgress`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#ad54b344caf11bcbfb086a15e96fbb9f2)
- [`onMediaDownloadingProgress`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#a1f774858444cc9b36369cbee4770df9c)