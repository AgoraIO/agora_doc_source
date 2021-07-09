---
title: 集成常见问题
platform: Linux
updatedAt: 2019-06-06 18:55:04
---
## Java 集成问题

### Java SDK 集成中常见的错误及解决方法

- java.land.UnsatisfiedLinkError: no agora-cloud-recording-java in java.library.path

  报错原因：系统找不到库文件 `libagora-cloud-recording-java.so`。

  解决方法：

  1. 打印  `java.library.path`，查看 Linux 环境变量 `LD_LIBRARY_PATH` 是否配置了该库文件：
  
	```bash
System.out.println(System.getProperty("java.library.path"))
  ```

 2. 建议在 Linux 系统变量 `LD_LIBRARY_PATH` 中添加 `java.library.path`，可以在 **/etc/profile** 里面添加 `LD_LIBRARY_PATH` 或者把 `libagora-cloud-recording-java.so` 直接放在Linux 系统目录 **/usr/lib** 下面。

- java.land.NoClassDefFoundError: Could not initialize class io.agora.cloud_recording.CloudRecorder

  报错原因：`classpath` 里面没有加载 `agora-cloud-recording-sdk.jar`。集成 Java SDK 时，需要加载 `agora-cloud-recording-sdk.jar` 和  `libagora-cloud-recording-java.so` ，jar 文件放在 Linux 环境变量 `classpath` 下，库文件放在 Linux 环境变量 `LD_LIBRARY_PATH` 下。

  解决方法：

  1. 打印 `classpath` ，查看是否加载了`agora-cloud-recording-sdk.jar`。

     ```bash
     System.out.println("类所在的路径：" + System.getProperty("java.class.path"));
     ```

  2.  如果没有，就在 `classpath` 环境变量中添加 jar 路径。


## 上传到第三方云存储失败

请检查你的云存储配置是否填写正确。

- bucket：云存储空间名称， 由你自己在云账户下创建。
- accessKey：在云存储个人账户下面密钥管理里。
- secretKey ：在云存储个人账户下面密钥管理里。

## 如何获取 M3U8 文件地址

完整的 M3U8 文件地址由云存储空间外链域名和 M3U8 文件名组成，一般在你的第三方云存储里可以直接复制。

 ![img](https://confluence.agora.io/download/attachments/632306307/image2019-3-27_1-38-3.png?version=1&modificationDate=1553621886116&api=v2)

以下回调中均包含 M3U8 文件名信息：

- C++

  - [`OnRecordingUploadingProgress`](./cloud-recording/cloud_recording_api#OnRecordingUploadingProgress)
  - [`OnRecordingUploaded`](./cloud-recording/cloud_recording_api#OnRecordingUploaded)
  - [`OnRecordingBackedUp`](./cloud-recording/cloud_recording_api/#OnRecordingBackedUp)

- Java

  - [`onRecordingUploadingProgress`](./cloud-recording/cloud_recording_api_java#onRecordingUploadingProgress)
  - [`onRecordingUploaded`](./cloud-recording/cloud_recording_api_java#onRecordingUploaded)
  - [`onRecordingBackedUp`](./cloud-recording/cloud_recording_api_java/#onRecordingBackedUp)

## 101 错误

日志文件中报错 `"ErrorUint32":101`，一般为 Token 错误引起，可能有以下几种原因：

- Token 填写错误
- Token 过期
- Native/Web SDK 使用了 Token，云端录制未使用
- 云端录制使用了 Token，Native/Web SDK 未使用