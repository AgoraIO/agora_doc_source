## 上传课件报错怎么办？

如果在上传课件时收到报错 `403 Forbidden`，请检查是否已正确[配置白板功能](agora_class_configure#%E9%85%8D%E7%BD%AE%E7%99%BD%E6%9D%BF%E5%8A%9F%E8%83%BD)，并确保声网可以访问你的云存储空间，详见[注意事项](agora_class_configure#%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9)。

如果收到错误码 `600005` 或者类似于 `100004 "service not enable", "messages": "region":"sg"` 的错误，说明你没有在该服务区域内开启相应的白板配套服务。如果你需要在课堂里使用 PPT、DOC、PDF 等格式的课件，你需要[开启互动白板配套服务](https://docs.agora.io/cn/whiteboard/enable_whiteboard#%E5%BC%80%E5%90%AF%E4%BA%92%E5%8A%A8%E7%99%BD%E6%9D%BF%E9%85%8D%E5%A5%97%E6%9C%8D%E5%8A%A1)，来为灵动课堂开启并配置文档转网页、文档转图片、截图服务。

## 如果以上配置均正确，上传课件至阿里云时报 403 错误怎么办？

![](https://web-cdn.agora.io/docs-files/1680084185700)

该错误是因为你没有在阿里云存储账号中开通相应权限，导致阿里云不允许上传。请在你的阿里云存储账号中增加 **oss:PutObject** 授权操作，参考以下截图。更多信息详见[阿里云文档 Bucket Policy](https://help.aliyun.com/document_detail/430203.html)。
![](https://web-cdn.agora.io/docs-files/1680084220648)

## 课件上传大小有什么限制？

- 课件大小不能超过 100 M。
- 实际转码时长受课件大小、课件尺寸、课件包含动画数量、可见包含图片分辨率、课件页数、转码队列等影响。包含的图片分辨率越高，转换速度越慢。页数最好在 50 页以内，超过 100 页可能会出现转换超时。

## 课件上传失败的原因有哪些？

- 支持的文件格式包含：PPT、PPTX、DOC、DOCX、PDF、MP3、MP4、PNG、JPG、GIF。
- 使用 WPS 软件编辑过的课件可能会出现上传或转码失败，声网建议你把这类课件另存为 PPTX 或 PDF 格式后再尝试上传。

