## 功能概述

在教学场景中，教师通常会借助于一些课件，以文字、图形和动画的方式将自己想要表达的内容直观、形象地展示给学生。灵动课堂支持在上课过程中展示课件，支持的资源格式包括 PPT、PPTX、DOC、DOCX、PDF、MP3、MP4、PNG，JPG，GIF。 

课件可分为以下两类：

- 公共资源：公共资源一般指教育机构上传和管理公共的课件资源，以供老师上课使用，个人无法编辑修改。
- 个人资源：个人资源一般指老师在客户端自行上传和管理个人的课件资源。

课件必须经过转换才能在灵动课堂的白板上使用。灵动课堂不保存客户的课件资源，所有课件均保存在客户自己的第三方云存储中。

## 课前上传课件

如果你想在课前将课件上传至第三方云存储或者你自己的服务器，然后在灵动课堂内以公共资源显示该课件，可参考以下步骤：

1. 在 Agora 控制台配置灵动课堂中的互动白板功能，用于存储在课堂中上传的资源。详见[配置白板功能文档](./agora_class_configure?platform=RESTful#%E9%85%8D%E7%BD%AE%E7%99%BD%E6%9D%BF%E5%8A%9F%E8%83%BD)。
2. 在 Agora 控制台开启互动白板文档转换服务并添加存储配置，用于存储转换后的资源。详见[开启互动白板配套服务文档](https://docs.agora.io/cn/whiteboard/file_conversion_overview?platform=Web#%E5%BC%80%E5%90%AF%E6%96%87%E6%A1%A3%E8%BD%AC%E6%8D%A2%E6%9C%8D%E5%8A%A1)。
3. 在你的 app 服务端调用 [RESTful API](/cn/whiteboard/whiteboard_file_conversion?platform=RESTful#发起文档转换（post）) 向 Agora 互动白板服务发起文档转换请求。Agora 互动白板服务会将转换后的文件上传至你在 Agora 控制台中配置的第三方云存储。
4. 在你的 app 服务端轮询 [RESTful API](/cn/whiteboard/whiteboard_file_conversion?platform=RESTful#查询转换任务的进度（get）) 向 Agora 互动白板服务获取转换任务进度。其中，你需要关注返回结果中的 `convertedFileList` 字段，代表已完成转换的课件列表。每个 `convertedFileList` 对象包含以下字段：
   - `width`：Number 类型，图片宽度，单位为像素。
   - `height`：Number 类型，图片高度，单位为像素。
   - `conversionFileUrl`：String 类型，转换图片的 URL。
   - `preview`：String 类型，预览图地址。当发起转换时请求包体中 `preview` 设为 `true` 且 `type` 为 `dynamic` 时，才会返回该字段。
5. 在你的客户端调用 [launch](/cn/agora-class/agora_class_api_ref_web?platform=Web#launch) 时通过 [courseWareList](/cn/agora-class/agora_class_api_ref_web?platform=Web#coursewarelist) 参数传入课件列表，就可以在课堂内看到课件了。

    ```typescript
    courseWareList:
    [
            {
                resourceName: xxxxxxx,
                resourceUuid: xxxxxxxxx,
                ext: 'pptx',
                url: 'https://xxxxxxxxxxxxxx',
                size: 0,
                updateTime: xxxxxxxx
                taskUuid: 'xxxxxxxxx',
                conversion: {
                            type: 'dynamic',
                            preview: true,
                            scale: 2,
                            outputFormat: 'png',
                            },
                taskProgress: {
                    totalPageSize: 3,
                    convertedPageSize: 3,
                    convertedPercentage: 100,
                    convertedFileList: [
                            {
                                    name: '1',
                                    ppt: {
                                            src: 'pptx://convertcdn.netless.link/dynamicConvert/3bxxxxxxx/1.slide',
                                            width: 1280,
                                            height: 720,
                                            preview:'dddddddddddddddurl'
                                    },
                            },
                            ...
                    ] as any,
                    currentStep: '',
                    },
            },
    ],
    ```

## 课中上传课件

对于课中上传课件，你只需进行以下操作：

如下图所示，老师登录灵动课堂，进入教室，点击工具栏中的**云盘**，点击**上传资源**即可上传资源。

![](https://web-cdn.agora.io/docs-files/1663238905768)

如下图所示，你可以删除已上传的资源。

![](https://web-cdn.agora.io/docs-files/1663238920126)


## 注意事项

~4c2dbcc0-d2a7-11ec-8e95-1b7dfd4b7cb0~