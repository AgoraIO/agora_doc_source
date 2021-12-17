## Overview

Agora Content Moderation is an intelligent video-content moderation service. When you use Agora Content Moderation, you can perform diversified scene moderation to help you control video content and effectively reduce the risk of content violations. At this stage, Agora Content Moderation provides a **client-side screenshot-capture  plus cloud-moderation** solution.![](https://web-cdn.agora.io/docs-files/1626084828189)


## Introduction

Agora Content Moderation currently supports the identification of pornographic content in video screenshots. The main functions are as follows:

- Take screenshots on the client side. The interval between screenshots can be set from 1 to 3,600 seconds." ][
-  Upload the screenshots to the content-moderation server for content moderation.
- Return results in real time rating the content as neutral  ("`neutral`"), sexy ("`sexy`"), or porn ("`porn`").
- Assign these ratings based on a floating point value. You can modify the threshold range of the value according to your own strategy. For example, the result is "porn" if `porn`> 0.99.``````
- Save video screenshots in a third-party cloud storage platform, and customize the storage path.

## Prerequisites

Before you start using the Agora Content Moderation function, ensure that the following requirements are met:

- Get the XXX version of the RTC SDK according to your device platform, and complete the integration.

- Contact [sales@agora.io](mailto:sales@agora.io) to enable Agora Content Moderation service. The following elements should be provided in accordance with the following format:

```
"AppId": {
    "desc ":" Description ",
    "callback_url ":" URL address of the server to receive the result of content moderation",
    "aliyun_oss_access_key_id ":" Alibaba Cloud OSS AccessKeyId",
    "aliyun_oss_access_key_secret ":" Alibaba Cloud OSS AccessKeysecret ",
    "aliyun_oss_bucket_name ":" Alibaba Cloud OSS bucket name ",
    "aliyun_oss_endpoint ":" Alibaba Cloud OSS Endpoint",
    "aliyun_oss_fileName_prefix ":" File prefix"
}
```

**Configuration sample**

```
"970CA35de60c44645bbae8a215061b33": {
    "Desc ":" sound net - test ",
    "callback_url": "http://test.com",
    "aliyun_oss_access_key_id": "12345678",
    "aliyun_oss_access_key_secret": "abcd123",
    "aliyun_oss_bucket_name": "test-artifacts",
    "aliyun_oss_endpoint": "oss-accelerate.aliyuncs.com",
    "aliyun_oss_fileName_prefix": "test"
}
```

## Implementation

To moderate content in real time of videos that are being streamed  in the channel, you first need to take a screenshot of the video through the SDK and upload it, then moderate the screenshot through the Agora Content Moderation service, and output the result: porn, sexy, or neutral. The Agora Content Moderation service sends the moderation results to the server you specify in the form of an HTTP request.

### Client-side screenshot capture

#### 1. Enable the function of uploading video screenshots.

Call the `enableContentInspect` method to` enable` the function of uploading video screenshots. Set the related information of uploading screenshots, including the purpose of uploading the screenshots (Content Moderation/Class supervision), the upload frequency, and any additional information.

```C++
void CMainFrame::OnBtnEnableContentInspect()
{
    if (CAgoraObject::GetEngine() == NULL) {
        return;
    }

        ContentInspectConfig config;
    ContentInspectModule module1;
    module1.type = kContentInspectModeration; //Content moderation
    module1.frequency = 2;                    //Frequency is 2 second every time
    ContentInspectModule module2;
    module2.type = kContentInspectSupervise;  //Class supervision
    module1.frequency = 5;

    config.moduleCount = 2;
    config.modules[0] = module1;
    config.modules[1] = module2;

        CAgoraObject::GetEngine()->enableContentInspect(true, config);
}
```



#### 2. Capture the video screenshots.

Call the `takeSnapshot` method to take a video`screenshot`. After a successful screenshot, the SDK triggers the `onSnapshotTaken` callback, which contains information such as the width and height of the screenshot and the path to save the screenshot.

```C++
class CSnapshotCallback : public ISnapshotCallback
{
    void onSnapshotTaken(const char* channel, uid_t uid, const char* filePath, int width, int height, int errCode) {};
};

CSnapshotCallback m_SnapshotCallback;



void CMainFrame::OnBtnSnapshot()
{
    if (CAgoraObject::GetEngine() == NULL) {
        return;
    }

        std::string strPath = "D:\\img.jpg";
    CAgoraObject::GetEngine()->takeSnapshot(m_strChannelName.c_str(), 0, strPath.c_str(), &m_SnapshotCallback);
}
```



#### 3. Upload the screenshots.

Every time a screenshot is successful, the SDK uploads the screenshot to the Agora Content Moderation server.

### Content moderation

After receiving a screenshot uploaded by the client SDK, the Agora Content Moderation service moderates  it and assigns a rating: neutral (`"neutral"`), sexy (`"sexy"`), or porn (`"porn"`). The Agora Content Moderation service sends the moderation results to the server address you specify in the form of an HTTP request, and saves any screenshots identified as sexy (`"sexy"`) or porn (`"porn"`) on a third-party cloud storage platform.

## API reference

**Taking C++ language as an example:**

```C++
// Enable the function of uploading screenshots
//@param enabled Whether to enable screenshots uploading (true: Enable; False: Disable)
//@param config Configuration for screenshots uploading See ContentInspectConfig.
virtual int enableContentInspect(bool enabled, const ContentInspectConfig& config);


// Callback notification class
class ISnapshotCallback {
    public:
        // Screenshot callback
                //@param channel Channel name
        //@param uid User ID
        //@param File path of screenshots
        //@param width  Width of the screenshot (pixel)
        //@param height  Height of the screenshot (pixel)
        //@param errorCode The error code:
        // - 0: Screenshot succeeded
        // - <0: Screenshot failed
        virtual void onSnapshotTaken(const char* channel, uid_t uid, const char* filePath, int width, int height, int errCode) = 0;
        virtual ~ISnapshotCallback() {};
};
// Screenshots
//@param channel Channel name
//@param uid User ID
//@param File path of screenshots
//@param width  Width of the screenshot (pixel)
//@param height  Height of the screenshot (pixel)
//@param errCode (0: Screenshot succeeded; <0: Screenshot failed)
virtual int takeSnapshot(const char* channel, uid_t uid, const char* filePath, ISnapshotCallback* callback);


// Purpose for uploading screenshots
typedef int ContentInspectType;
// Screenshot upload is invalid
const ContentInspectType kContentInspectInvalid = 0;
// Screenshots are uploaded for content moderation
const ContentInspectType kContentInspectModeration = 1;
// Screenshots are uploaded to supervise a class
const ContentInspectType kContentInspectSupervise  = 2;

// Maximum number of purposes for uploading screenshots
enum MAX_CONTENT_INSPECT_MODULE_TYPE {
    // Uploaded screenshots can be used for up to 32 different functions; currently, the only functions available are content moderation and class supervision.
    MAX_CONTENT_INSPECT_MODULE_COUNT = 32
};

// Purpose and frequency of uploading screenshots
struct ContentInspectModule {
    // Purpose for uploading screenshots, the default value is kContentInspectInvalid
    ContentInspectType type;
    // Frequency of uploading screenshots uploading, in seconds. The default value is 0. The value range is [1,3600].
    int frequency;
    }
};

// Configuration of screenshot uploads
struct ContentInspectConfig {
    // Additional information Every time a screenshot is uploaded, the Agora Content Moderation service transparently transmits the information to the server you specify.
        const char* extraInfo;
    // An array of purposes for uploading screenshots, which supports up to 32 different purposes.
        ContentInspectModule modules[MAX_CONTENT_INSPECT_MODULE_COUNT];
    // The number of purposes for uploading screenshots
    int moduleCount;

        ContentInspectConfig() : extraInfo(NULL), moduleCount(0) {}
};
```

## RESTful API callback service

### Content moderation

In a content-moderation scenario, Agora Content Moderation sends the results of content moderation to the specified server address in the form of an HTTP request.

After receiving notification of the content-moderation result, your server needs to respond, and the body format of the response is JSON. In any of the following cases, Agora Content Moderation considers the notification a failure:

- After sending the message notification, it does not receive a response from your server within 5 seconds.
- The response HTTP status code is not `200`, or the response body format is not JSON.

Agora Content Moderation retries immediately after the first notification fails, and sends a message notification again. A total of three notification attempts are made.

#### Content moderation callback example

```
{
  "requestId": "38f8e3cfdc474cd56fc1ceba380d7e1a_1652693284_b5813fe2ae4fa5cdfe5abd8fef82526f",
  "callbackParam": {
    "cname": "httpClient463224"
  },
  "callbackData": "XXXXXXXXX", //String data of the callbackData transparently transmitted by the SDK
  "checksum": "75ee9884XXXXXXXX2aef58f178fd8",
  "object": "test/20201216/38f8e3cfdc474cd56fc1ceba380d7e1a_httpClient463224__uid_s_91__uid_e_video_20200413081128672.jpg",
  "code": 200,
  "msg": "Moderation complete",
  "channelName":"httpClient463224",
  "userId":"91",
  "results": {
    "porn": {
      "outputs": {
        "Neutral" : 0.915607393,
        "porn": 0.082511887,
        "sexy": 0.00188077823
      },
      "scene": "neutral"
    }
  },
  "suggestion": "pass",
  "timestamp": 20190611073246073
}
```

- `requestId`: String, the ID of this callback notification, which is generated by the SDK. An ID corresponds to a moderated file, such as a video screenshot.

- `callbackParam`: JSON, callback transparent transmission field.

- `checksum`: String, MD5 value calculated from the four parameter values of `callbackAddr`, `code`, `object`, and `requestId`, which is used to verify whether this callback notification comes from the Agora Content Moderation service.

- `object `：String, the file name of the file moderated in this callback. The naming rules for this file: `<OSS prefix>/<year month day>/<sid>_<cname>__uid_s_<uid>__uid_e_<type>_utc.jpg`。 The meaning of each field in the file name is as follows:
   - `<sid>`: ID of the content-moderation process
   - `<cname>`: Channel name
   - `<uid>`: User ID
   - `<type>`: File type, only supports `video`.
   - `<utc>`: The UTC time at the beginning of the slice file, the time zone is UTC+0, and it consists of year, month, day, hour, minute, second, and millisecond. For example, when `utc` is `20190611073246073`, this indicates that the slice file starts at 07:32:46.073 a.m., June 11, 2019.

- `code`: Number. The status code of this content moderation. `200` means that the content moderation is complete.

- `msg`：String, the status of the content moderation. `"Moderation complete"` means that the content moderation is completed.

- `channelName`: String, the channel name of the channel in this callback.

- `userId`: String type, the user ID of the user moderated in this callback.

- `result`: JSON, the result of this content-moderation process. The parameters are as follows:

   - `porn`: JSON. Content-moderation results of pornographic content.

   - `outputs`: JSON. The possibility that the screenshot is neutral, sexy, or porn.

      - `Neutral`: Float. The possibility that the screenshot is a neutral image. A "neutral" result means that there is no bad content in the image, and there may be normal and moderate body nudity and body curves.
      - `porn`: Float. The possibility that the image is pornographic. A "porn" result refers to images containing nudity that includes genitals, sexual behavior and cues, and excessive emphasis on sexual characteristics.
      - `sexy`: Float, the possibility that the image is sexy. A "sexy" image is an image that contains substantial nudity or the outline of the male and female sexual features, but no genital exposure.

      - `scene`: String, content-moderation result. The content-moderation result is based on the three floating-point values in `outputs` to determine the attributes of the image. `scene` return the following values:
         - `"neutral"`: Neutral image
         - `"porn"`: Pornographic image
         - `"sexy"`: Sexy image
- `suggestion`: String, image-processing recommendations. .
   - `"Pass"`: Neutral image, no processing needed.
   - `"Block"`: Pornographic image  that failed to pass the content moderation process, block the image.
   - `"review"`: Sexy image, process according to your criteria.  You can consider the image to be neutral according to your own scenarios, with no processing needed, or prompt a manual review.  For example, for social applications with a higher tolerance for sexiness, the images can be considered neutral ; while for education applications with a low tolerance for sexiness, the images need be manually reviewed.

- `timestamp`: Int, callback timestamp, which is equal to `Object.utc`.

### Class supervision

In a class-supervision scenario, after receiving notification of a content-moderation result, your server needs to respond, and the response body format is JSON. In any of the following cases, Agora Content Moderation considers the notification to be a failure:

- After sending the message notification, it does not receive a response from your server within 5 seconds.
- The response HTTP status code is not `200`, or the response body format is not JSON.

Agora Content Moderation retries immediately after the first notification fails, and sends a message notification again. A total of three notification attempts are made.

#### Class supervision callback example

```
{
  "requestId": "38f8e3cfdc474cd56fc1ceba380d7e1a_1652693284_b5813fe2ae4fa5cdfe5abd8fef82526f",
  "callbackParam": {
    "cname": "httpClient463224"
  },
  "callbackData": "XXXXXXXXX", //String data of the callbackData transparently transmitted by the SDK
  "checksum": "75ee9884XXXXXXXX2aef58f178fd8",
  "object": "xiaozuke/20201216/38f8e3cfdc474cd56fc1ceba380d7e1a_httpClient463224__uid_s_91__uid_e_video_20200413081128672.jpg",
  "code": 200,
  "msg": "Supervise complete",
  "channelName":"httpClient463224",
  "userId":"91",
  "timestamp": 20190611073246073
}
```
- `requestId`: String, the ID of this callback notification, which is generated by the SDK. An ID corresponds to a moderated file, such as a video screenshot.

- `callbackParam`: JSON, callback transparent transmission field.

- `checksum`: String, MD5 value calculated from the four parameter values of `callbackAddr`, `code`, `object`, and `requestId`, which is used to verify whether this callback notification comes from the Agora Content Moderation service.

- `object`: String, the file name of the moderated file. The naming rules for this file: `<OSS prefix>/<year month day>/<sid>_<cname>__uid_s_<uid>__uid_e_<type>_utc.jpg`。 The meaning of each field in the file name is as follows:
   - `<sid>`: ID of content moderation process
   - `<cname>`: Channel name
   - `<uid>`: User ID
   - `<type>`: File type, only supports `video`.
   - `<utc>`: The UTC time at the beginning of the slice file, the time zone is UTC+0, and it consists of year, month, day, hour, minute, second, and millisecond. For example, when `utc` is `20190611073246073`, this indicates that the slice file starts at 07:32:46.073 a.m., June 11, 2019.

- `code`: Number. The status code of this content moderation. 200 indicates completion of content moderation.

- `msg`：String, the status of the content moderation. `"Moderation complete"` means that the content moderation is completed.

- `channelName`: String, the channel name of the channel in this callback.

- `userId`: String type, the user ID of the user moderated in this callback.

- `timestamp`: Int, callback timestamp, which is equal to `Object.utc`.