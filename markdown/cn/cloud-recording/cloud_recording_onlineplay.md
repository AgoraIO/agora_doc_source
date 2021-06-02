---
title: 在线播放录制文件
platform: All Platforms
updatedAt: 2020-05-11 11:05:33
---
## 功能描述

使用 Agora 云端录制服务完成录制后，录制的内容会以 TS 文件形式上传到你设定的第三方云存储中，同时生成一个 M3U8 文件用于索引所有的 TS 文件。你可以在你的第三方云存储中获得该 M3U8 文件的链接，直接在线播放录制文件。

## 实现方法

在开始前，请确保录制文件已全部上传完成（`OnRecordingUploaded` 回调）。下面分别介绍[阿里云](https://www.aliyun.com/product/ossJ)、[七牛云](https://www.qiniu.com/)和 [AWS S3](https://aws.amazon.com/cn/s3/?nc=sn&loc=0) 如何在线播放录制文件。

### 阿里云
1. 登录阿里云控制台，进入你设定的录制存储空间（bucket），在**文件管理**页面可以看到 M3U8 和 TS 文件。
2. 在**基础设置**页面将**读写权限**设置为**公共读**或**公共读写**，点击**保存**。

	![](https://web-cdn.agora.io/docs-files/1556438995486)
	
4. 在**文件管理**页面，M3U8 文件右侧点击**更多**，选择**复制文件 URL**，如下图所示：

	![](https://web-cdn.agora.io/docs-files/1556440791342)
	
6. 在浏览器上输入复制的外链地址即可开始在线播放。

### 七牛云

1. 进入你设定的录制存储空间（bucket），可以看到 M3U8 和 TS 文件都已经上传至云存储。

2. 将**空间设置**的**访问控制**设为公开空间。如果没有绑定域名，请先绑定一个域名。

3. 复制 M3U8 文件的外链，如下图所示：

	![](https://web-cdn.agora.io/docs-files/1556165027848)

4. 在浏览器上输入复制的外链地址即可开始在线播放。

更多信息请参考[在七牛云存储上播放 HLS](<https://developer.qiniu.com/kodo/kb/1339/in-seven-niuyun-stored-in-hls>)。

### AWS S3

1. 登录 AWS S3 控制台，进入云端录制使用的存储桶（bucket），将文件属性分别设置成如下：
   1. 选中 M3U8 文件，点击**操作** ，选择**更改元数据**。
	 
	 ![](https://web-cdn.agora.io/docs-files/1556165143077)
	 
   2. 将 **Content-Type** 键值设为 **application/x-mpegURL** （需手动输入）。
	 
	 ![](https://web-cdn.agora.io/docs-files/1556165160391)
	 
   3. 选中所有的 TS 文件，将 **Content-Type** 设为 **video/MP2T**。

2. 配置存储桶策略使 bucket 能被公开访问。在**权限**页面点击**存储桶策略**，填入以下代码 （将 `<YourBucketName>` 修改为你的 bucket）：
![](https://web-cdn.agora.io/docs-files/1556165186768)
   ```json
   {
    "Version": "2012-10-17",
    "Id": "Policy1553255976836",
    "Statement": [
        {
            "Sid": "Stmt1553255974279",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::<YourBucketName>"
        }
    ]
   }
   ```
3. 选中 M3U8 文件查看 URL 地址。

	![](https://web-cdn.agora.io/docs-files/1556165198691)

4. 在浏览器上输入 M3U8 文件的 URL 即可开始在线播放。

## 开发注意事项

- Safari 浏览器可以直接播放 M3U8 文件，其他浏览器可能需要安装 HLS 播放插件。
- 支持 HLS 协议的播放器也可以播放 M3U8 文件，如 VLC media player。
- 如果录制结束后收到的回调是 `OnRecordingBackedUp`，说明有部分录制内容上传到了备份云，必须等备份云将这部分文件上传到云存储之后才可以播放 M3U8 文件。