---
title: Offline-云端录制集成常见问题
platform: ["All Platforms","Linux","Linux C++","Linux Java"]
updatedAt: 2020-07-09 21:26:19
Products: ["cloud-recording"]
---
## 如何获取 M3U8 文件地址

完整的 M3U8 文件地址由云存储空间外链域名和 M3U8 文件名组成，一般在你的第三方云存储里可以直接复制。

![](https://web-cdn.agora.io/docs-files/1561621201492)

你可以通过以下方式获得 M3U8 文件名信息：

- RESTful API
  - [`query`](/cn/cloud-recording/cloud_recording_api_rest#query) 和 [`stop`](/cn/cloud-recording/cloud_recording_api_rest#stop) 的响应中 `fileList` 字段
  - 回调事件 [`cloud_recording_file_infos`](/cn/cloud-recording/cloud_recording_callback_rest?platform=All%20Platforms#a-name4acloud_recording_file_infos) 的 `fileList` 字段
- C++
  - [`OnRecordingUploadingProgress`](/cn/cloud-recording/cloud_recording_api#OnRecordingUploadingProgress) 中的 `recording_playlist_filename` 参数
  - [`OnRecordingUploaded`](/cn/cloud-recording/cloud_recording_api#OnRecordingUploaded) 中的 `file_name` 参数
  - [`OnRecordingBackedUp`](/cn/cloud-recording/cloud_recording_api/#OnRecordingBackedUp) 中的 `file_name` 参数
- Java
  - [`onRecordingUploadingProgress`](/cn/cloud-recording/cloud_recording_api_java#onRecordingUploadingProgress) 中的 `recording_playlist_filename` 参数
  - [`onRecordingUploaded`](/cn/cloud-recording/cloud_recording_api_java#onRecordingUploaded) 中的 `file_name` 参数
  - [`onRecordingBackedUp`](/cn/cloud-recording/cloud_recording_api_java/#onRecordingBackedUp) 中的 `file_name` 参数

## 如何停止云端录制

你可以调用  [`stop`](./cloud_recording_api_rest?platform=All%20Platforms#stop) 方法离开频道，停止录制。

当频道空闲（无用户）超过预设的时间（默认 30 秒）后，云端录制也会自动退出频道停止录制。你可以在开始录制的时候设置 `maxIdleTime` 参数来控制超时退出的时间。

## 上传到第三方云存储失败

上传到第三方云存储失败，可能有以下几种原因：
  - 没有发流端加入频道，录制超时。
  - Token 过期或 Token 认证失败。
  - 在调用[获取云端录制资源的 API](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=All%20Platforms#a-nameacquirea%E8%8E%B7%E5%8F%96%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6%E8%B5%84%E6%BA%90%E7%9A%84-api) 时，传入的 `uid` 参数与频道内现有的用户 ID 重复。举例来说，频道内有三个用户，UID 分别为 `123`，`234`，和 `345`，如果你传入的 `uid` 为 `123`， 则会导致录制失败。
  - 在调用[开始云端录制的 API](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=All%20Platforms#a-namestarta开始云端录制的-api) 时，传入的 `transcodingConfig` 参数值不合理，导致录制失败。请参考[如何设置录制视频的分辨率](https://docs.agora.io/cn/faq/recording_video_profile)设置该参数。
  - 你的云存储配置出错。请确保你的云存储配置填写正确：
    - bucket：云存储空间名称， 由你自己在云账户下创建。
    - accessKey：在云存储个人账户下面密钥管理里。
    - secretKey ：在云存储个人账户下面密钥管理里。

## 云存储 bucket 区域选择及跨区解决方案

目前云端录制支持以下云存储厂商：

- 七牛云
- Amazon S3
- 阿里云
- 腾讯云

发起云端录制前，请先确保你已经开通了以上厂商中至少一家的云存储服务，并且创建了 bucket。然后，在[开始云端录制的 API](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=All%20Platforms#a-namestarta%E5%BC%80%E5%A7%8B%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6%E7%9A%84-api) 请求中把云存储的相关信息填入 `storageConfig` 参数。其中，关于 `bucket` 的 `region` 选择，建议选择距离发起云端录制请求的服务器较近的区域。具体的厂商区域对照表见[云端录制 RESTful API](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=All%20Platforms#storageConfig).

### 跨区上传可能产生的问题
目前云端录制的实际待上传文件都位于距离发起云端录制请求的服务器较近的机器上，所以如果云存储出现跨区的现象，例如发起云端录制请求的服务器在美国，选择的 bucket 的区域在北京，就会出现上传较慢甚至上传失败的情况。虽然 Agora 备份云可以备份一部分上传失败的文件，但由于云端录制在录制结束后只会等待一定的时间，如果超时还没有完成全部的上传，就会结束任务并最终导致丢失录制文件，因此跨区上传会严重影响上传时延和上传结果。


### 解决方案
针对跨区上传的问题，首先应该尽量避免选择跨区的 bucket。如果必须要选择跨区的 bucket，那么在发送云录制的 RESTful API 请求时，可以将请求发送给跟这个 bucket 同区的域名。例如，如果 bucket 选择在中国，可以将域名从 api.agora.io 改为 api.agoraio.cn。


## 101 错误

日志文件中报错 `"ErrorUint32":101`，一般为 Token 错误引起，可能有以下几种原因：

- Token 填写错误
- Token 过期
- Native/Web SDK 使用了 Token，云端录制未使用
- 云端录制使用了 Token，Native/Web SDK 未使用

## 录制异常退出

录制异常退出意味着集成云端录制 SDK 的 App 崩溃，但是只要通话或直播还在继续，Agora 云端录制服务仍会继续保持录制和上传。这时使用和之前录制相同的 App ID、频道名以及 UID 重新开始录制，就可以继续控制原来的录制实例。


## 为什么无法通过浏览器调用云端录制 RESTful API
要使用云端录制 RESTful API，Web API 需要发送跨域请求。根据 CORS 规范，浏览器针对跨域请求会先发送一个 OPTIONS 请求，查询服务器是否允许跨域请求，然后才有可能发起真正的 POST 请求。但是由于云端录制 RESTful API 不支持 OPTIONS 方法，所以无法支持 Web API 调用的方式。

## Java 集成报错

### Java SDK 集成中常见的错误及解决方法

#### java.land.UnsatisfiedLinkError: no agora-cloud-recording-java in java.library.path

##### **报错原因**

系统找不到库文件 `libagora-cloud-recording-java.so`。

##### **解决方法**

1. 打印  `java.library.path`，查看 Linux 环境变量 `LD_LIBRARY_PATH` 是否配置了该库文件：

   ```bash
   System.out.println(System.getProperty("java.library.path"))
   ```

2. 建议在 Linux 系统变量 `LD_LIBRARY_PATH` 中添加 `java.library.path`，可以在 **/etc/profile** 里面添加 `LD_LIBRARY_PATH` 或者把 `libagora-cloud-recording-java.so` 直接放在Linux 系统目录 **/usr/lib** 下面。

#### java.land.NoClassDefFoundError: Could not initialize class io.agora.cloud_recording.CloudRecorder

##### **报错原因**

`classpath` 里面没有加载 `agora-cloud-recording-sdk.jar`。集成 Java SDK 时，需要加载 `agora-cloud-recording-sdk.jar` 和  `libagora-cloud-recording-java.so` ，jar 文件放在 Linux 环境变量 `classpath` 下，库文件放在 Linux 环境变量 `LD_LIBRARY_PATH` 下。

##### **解决方法**

1. 打印 `classpath` ，查看是否加载了`agora-cloud-recording-sdk.jar`。

```bash
System.out.println("类所在的路径：" + System.getProperty("java.class.path"));
```

2. 如果没有，就在 `classpath` 环境变量中添加 jar 路径。