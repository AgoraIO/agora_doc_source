---
title: 如何选择云存储 bucket 区域及处理跨区上传问题？
platform: ["RESTful"]
updatedAt: 2021-01-08 06:46:37
Products: ["cloud-recording"]
---

目前云端录制支持以下云存储厂商：

- 七牛云
- Amazon S3
- 阿里云
- 腾讯云

发起云端录制前，请先确保你已经开通了以上厂商中至少一家的云存储服务，并且创建了 bucket。然后，在[开始云端录制的 API](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=All%20Platforms#a-namestarta%E5%BC%80%E5%A7%8B%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6%E7%9A%84-api) 请求中把云存储的相关信息填入 `storageConfig` 参数。其中，关于 `bucket` 的 `region` 选择，建议选择距离发起云端录制请求的服务器较近的区域。具体的厂商区域对照表见[云端录制 RESTful API](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=All%20Platforms#storageConfig).

### 跨区上传可能产生的问题

目前云端录制的实际待上传文件都位于距离发起云端录制请求的服务器较近的机器上，所以如果云存储出现跨区的现象，例如发起云端录制请求的服务器在美国，选择的 bucket 的区域在北京，就会出现上传较慢甚至上传失败的情况。虽然 Agora 备份云可以备份一部分上传失败的文件，但由于云端录制在录制结束后只会等待一定的时间，如果超时还没有完成全部的上传，就会结束任务并最终导致丢失录制文件，因此跨区上传会严重影响上传时延和上传结果。
