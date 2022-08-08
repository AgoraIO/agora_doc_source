## 功能概述

在教学场景中，教师通常会借助于一些课件，以文字、图形和动画的方式将自己想要表达的内容直观、形象地展示给学生。这些课件通常是以 ppt、pptx、word、pdf 等格式存在的文件。

灵动课堂支持在上课过程中展示课件。课件可分为以下两类：

- 课堂的公共课件。一个课堂内的所有用户都可以看到该课堂的公共课件。对于这种课件，开发者需要自行管理课堂和课件的映射关系。
- 老师的个人课件。老师所在课堂内的所有用户都可以看到该老师的个人课件。对于这种课件，开发者需要自行管理老师和课件的映射关系。

课件必须经过转换才能在灵动课堂的白板上使用。灵动课堂不保存客户的课件资源，所有课件均保存在客户自己的第三方云存储中。

## 课前上传课件

如果你想在课前将课件上传至第三方云存储或者你自己的服务器，然后在灵动课堂内显示该课件，可参考以下步骤：

1. 自行将课件上传至第三方云存储或者你自己的服务器后，生成一个可访问的 URL 地址，确保 Agora 互动白板服务可通过该 URL 地址访问该课件。
2. 在 Agora 控制台开启互动白板文档转换服务并添加存储配置，用于储存转换后的课件。详见[开启文档转换服务文档](/cn/whiteboard/file_conversion_overview?platform=Web#开启文档转换服务)。
3. 在你的 app 服务端调用 [RESTful API](/cn/whiteboard/whiteboard_file_conversion?platform=RESTful#发起文档转换（post）) 向 Agora 互动白板服务发起文档转换请求。Agora 互动白板服务会将转换后的文件上传至你在 Agora 控制台中配置的第三方云存储。
4. 在你的 app 服务端轮询 [RESTful API](/cn/whiteboard/whiteboard_file_conversion?platform=RESTful#查询转换任务的进度（get）) 向 Agora 互动白板服务获取转换任务进度。其中，你需要关注返回结果中的 `convertedFileList` 字段，代表已完成转换的课件列表。每个 `convertedFileList` 对象包含以下字段：
   - `width`：Number 类型，图片宽度，单位为像素。
   - `height`：Number 类型，图片高度，单位为像素。
   - `conversionFileUrl`：String 类型，转换图片的 URL。
   - `preview`: String 类型，预览图地址。当发起转换时请求包体中 `preview` 设为 `true` 且 `type` 为 `dynamic` 时，才会返回该字段。
5. 在你的客户端调用 [launch](/cn/agora-class/agora_class_api_ref_web?platform=Web#launch) 时通过 [courseWareList](/cn/agora-class/agora_class_api_ref_web?platform=Web#coursewarelist) 参数传入课件列表，就可以在课堂内看到课件了。

## 课中上传课件

对于课中上传课件，你只需进行以下操作：

1. 在 Agora 控制台配置灵动课堂中的互动白板功能，用于存储在课堂中上传的课件。详见[配置白板功能文档](/cn/agora-class/agora_class_configure?platform=RESTful#配置白板功能)。
2. 在 Agora 控制台开启互动白板文档转换服务并添加存储配置，用于存储转换后的课件。详见[开启互动白板配套服务文档](/cn/whiteboard/enable_whiteboard#开启互动白板配套服务)。

## 注意事项

~4c2dbcc0-d2a7-11ec-8e95-1b7dfd4b7cb0~

- Bucket policy
  ```json
  {
      "Version": "2012-10-17",
      "Id": "Policy1622700880591",
      "Statement": [
          {
              "Sid": "Stmt1622700872941",
              "Effect": "Allow",
              "Principal": "*",
              "Action": "s3:GetObject",
              "Resource": "arn:aws-cn:s3:::agora-adc-artifacts/*"
          }
      ]
  }
  ```

- Cross-origin resource sharing

```json
[
    {
        "AllowedHeaders": [
            "*"
        ],
        "AllowedMethods": [
            "PUT",
            "GET"
        ],
        "AllowedOrigins": [
            "*"
        ],
        "ExposeHeaders": []
    }
]
```