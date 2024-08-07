This page introduces how to configure the whiteboard and recording features in Flexible Classroom in Agora Console.

<div class="alert info">Before reading this page, ensure sure that you have <a href="/en/agora-class/agora_class_enable" target="_blank">enabled the Flexible Classroom service</a> in Agora Console.</div>

## Configure the whiteboard feature

If you want to upload PPT, Word, or PDF files to a flexible classroom and display these files on the whiteboard, you need to configure the whiteboard feature in Agora Console.

### Prerequisites

The whiteboard feature in Flexible Classroom requires a third-party cloud storage service for storing files uploaded in a classroom. Before configuring the whiteboard feature, ensure that you have enabled a third-party cloud storage service. Temporarily, Agora only supports <a href="https://aws.amazon.com/s3/?nc1=h_ls" target="_blank">Amazon S3</a>.

### Procedure

On the **Flexible Classroom configuration** page, find the whiteboard module, as shown in the following figure:

![](https://web-cdn.agora.io/docs-files/1641366278596)

You need to do the following:

1. Enable the advanced services. See <a href="/en/whiteboard/enable_whiteboard#enable-whiteboard-server-side-features" target="_blank">Enable whiteboard server-side features</a>.

2. Configure a third-party cloud storage service for storing files uploaded in a classroom. Fill in the following information:
      - `region`: The location of the data center you specified when creating a bucket in Amazon S3.
      - `endpoint`: The domain name used to access the Amazon S3 service, such as `s3.us-east-2.amazonaws.com`.
      - `Bucket`: The bucket name in Amazon S3.
      - `folder`: The domain name used to access the Amazon S3 service, such as `whiteboard`.
      - `accessKey`: The Access Key provided by Amazon S3, which is used to identify visitors.
      - `secretKey`: The Secret Key provided by Amazon S3, which is used to authenticate signatures.

   <div class="alert info">For how to get these information, see the <a href="https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html" target="_blank">document of Amazon S3</a>.</div>

## Configure the recording feature

The default recording behavior in Flexible Classroom is: Record the audio and video of teachers in a classroom in <a href="/en/cloud-recording/cloud_recording_composite_mode?platform=RESTful" target="_blank">composite recording mode</a>. Your recorded files are be stored in Agora's Amazon S3 account.

To change the default behavior, find the cloud recording module on the **Flexible Classroom configuration** page in Agora Console, and pass in JSON objects:

![](https://web-cdn.agora.io/docs-files/1641368314262)

### Recording configuration

Pass in the `recordingConfig` JSON object. For parameter descriptions, see <a href="/en/cloud-recording/cloud_recording_api_start?platform=RESTful#recordingConfig" target="_blank">recordingConfig</a>.

An example of the `recordingConfig` JSON object:

```json
{
    "maxIdleTime": 30,
    "streamTypes": 2,
    "channelType": 0
}
```

### Storage configuration

Pass in the `storageConfig` JSON object for storing recorded files. For parameter descriptions, see <a href="/en/cloud-recording/cloud_recording_api_start?platform=RESTful#storageConfig" target="_blank">storageConfig</a>.

An example of the `storageConfig` JSON object:

```json
{
    "vendor": 2,
    "region": 3,
    "bucket": "xxxxx",
    "accessKey": "xxxxxxf",
    "secretKey": "xxxxx",
    "endpoint": "https://agora-recording.oss-cn-shanghai.aliyuncs.com",
    "fileNamePrefix": [
        "scenario",
        "recording"
    ]
}
```

## Considerations

~8a061720-080f-11ed-a46a-e58831549a58~