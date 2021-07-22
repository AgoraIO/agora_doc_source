The file conversion feature provided by Agora Interactive Whiteboard can convert PPT, PPTX, DOC, DOCX, and PDF files into static images, and PPTX files into dynamic HTML web pages. The generated images and web pages can be presented on the whiteboard.

## Feature list

The file conversion feature includes:

- Static file conversion
- Dynamic file conversion

### Static file conversion

Static file conversion refers to converting PPT, PPTX, DOC, DOCX, and PDF files to static images in PNG, JPG/JPEG or WEBP format. The generated file does not preserve animations in the source file.

When using static file conversion, you should pay attention to the following things:

- Preferably, the source file is less than 50 pages. If the source file has more than 100 pages, there might be a conversion timeout.
- The higher the image resolution in the source file, the slower the conversion.
- Agora recommends PNG and JPG/JPEG for the image format.
- Conversion of PDF files is the most accurate compared to source files in other formats. If the generated image differs a lot from the source file in terms of formatting, you can convert the source file to PDF and try again.
- This feature is implemented with support from [Aspose](https://www.aspose.app/), so Agora may not timely respond to your customization demand for now. Agora recommends that you run sufficient tests of the file conversion feature. If the test result does not meet your expectation, you can use a third-party service.
- If a font is missing in the generated image, you can either use the SDK to add a custom font or contact support@agora.io.

### Dynamic file conversion

Dynamic file conversion refers to converting PPTX files edited with Microsoft Office to HTML web pages. The generated file preserves animations in the source file. 
Currently, dynamic file conversion **does not support**:

- Converting WPS files or PPTX files converted from WPS files.
- Gradient colors.
- WordArt.
- Graphs and charts such as column charts.
- SmartArt graphics.
- Transition effects between slides.
- Animated text or words that appear one line at a time.
- 大多数动画特效，例如，溶解、棋盘等。 目前仅支持淡入淡出特效。
- Vertical text.
- Trimming videos.
- Converting hidden pages.

<div class="alert info">If a font is missing in the generated web page, you can either use the SDK to add a custom font or contact support@agora.io.</div>

## Prerequisites

Before using the file conversion feature, ensure that you have completed the following preparatory steps:

### Create a third-party cloud storage account

Agora 互动白板使用第三方云存储服务存储转换后的文件。 因此，使用 Agora 互动白板文档转换服务前，请确保你已开通第三方云存储服务。 Available options include [AliCloud](https://www.aliyun.com/product/oss), [Qiniu Cloud](https://www.qiniu.com/products/kodo), and [Amazon S3](https://aws.amazon.com/cn/s3/?nc2=h_m1).

### Enable the file conversion feature

Refer to the following steps:

1. Go to the [Project Management](https://console.agora.io/projects) page in Agora Console, find the whiteboard project, and click **Edit**.

2. On the **Edit Project** page, find **Whiteboard**, and click **Config**.****

3. Under **Services**, select **Enabled** for **Docs to Picture**, **Docs to web**, or **Screenshot**.![](https://web-cdn.agora.io/docs-files/1616656791539)


4. Click the arrowhead to the right of **Storage**, and select a storage space in the drop-down list:

   - **default - white-cn-doc-convert**: The default storage space provided by the whiteboard service.
   - **A previously configured third-party storage service**: If you have added and configured a third-party storage space, you can see its name in the list.
   - **New Storage Config**: If you do not want to use the default storage space and have not yet added a third-party storage space, select this option. See Step 5.

![](https://web-cdn.agora.io/docs-files/1616656819276)

5. Click **New Storage Config**, and follow the on-screen instructions to fill in the following information:
   - **Vendor**: (Required) Third-party service providers, including [AliCloud](https://www.aliyun.com/product/oss) (recommended), [Qiniu Cloud](https://www.qiniu.com/products/kodo), and [Amazon S3](https://aws.amazon.com/cn/s3/?nc2=h_m1) Object Storage Service (OSS).
   - **Region**: (Required) The location of the data center you specified when creating a bucket.
   - **accessKey**: (Required) The Access Key provided by the OSS provider, which is used by the OSS provider to identify visitors.
   - **secretKey**: (Required) The Secret Key provided by the OSS provider, which is used to authenticate signatures.
   - **bucket**: (Required) The name of the storage space.
   - **Storage path**: The path used to save the resources in the storage space. The default is the root directory.
   - **Domain**: The domain name used to access the OSS service. This field is required if you use Qiniu Cloud. Otherwise, Agora cannot access the storage service.
   <div class="alert note">
	<ul>
	 <li>To get the above information about a third-party storage service, see the documentation of the OSS provider you are using.</li>
		<li>You should enable <b>public access</b> or higher permission for third-party storage spaces so that your app clients can access files saved in the space.</li>
	</ul>
</div>

6. Click **Save**, read the pop-up prompt carefully, and click **Confirm**.

### Upload the source file

Upload the source file to a third-party cloud storage space or your Nginx server, and you should get an URL address. Ensure that the file can be accessed via the URL address.

## Start file conversion

The file conversion feature is implemented by Agora's server for the whiteboard service. When an app client requests to convert a file, your app server needs to call the interactive whiteboard RESTful API to send the request to the Agora server. The full process is illustrated in the following diagram:![](https://web-cdn.agora.io/docs-files/1616746976402)


> - To call the RESTful API to start a file conversion task, pass in the URL address of the source file, the task type, and other parameters. See [Start file conversion (POST)](/cn/whiteboard/whiteboard_file_conversion?platform=RESTful#发起文档转换（post）).
> - To query the progress of a conversion task, pass in the corresponding Task UUID and Task Token. See [Query file conversion progress (GET)](/cn/whiteboard/whiteboard_file_conversion?platform=RESTful#查询转换任务的进度（get）).
> - Agora recommends that you design an algorithm to regularly query the conversion progress so that your data is up to date.