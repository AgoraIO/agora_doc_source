## 产品概述

Agora 视频鉴黄是一款视频内容智能审核服务，在你使用 Agora 视频鉴黄时，可对视频内容进行多样化场景检测，帮助你对视频内容进行管控，有效降低内容违规风险。现阶段，Agora 视频鉴黄提供**客户端截图+云端鉴黄**的方案。
![](https://web-cdn.agora.io/docs-files/1626084828189)

## 功能描述

Agora 视频鉴黄目前支持识别视频截图中的色情内容，主要功能如下：

- 可设置客户端截图的时间间隔 [1,3600s]
- 客户端截图完后，上传至云端鉴黄服务器进行鉴黄
- 实时返回鉴黄结果，包括正常（"`neutral`"）、性感（"`sexy`"）和色情（"`porn`"）
- 实时返回正常（`"neutral"`）、性感（`"sexy"`）和色情（`"porn"`）三个维度的浮点数值，您可以根据自己的策略来修改数值的阈值判断范围，如 `porn`> 0.99 时为色情
- 支持将视频截图保存在第三方云存储平台，并自定义存储路径

## 前提条件

开启 Agora 视频鉴黄功能前，请确保满足以下要求：

- 请根据你的设备平台获取 XXX 版本的 RTC SDK，并完成集成。

- 联系 [sales@agora.io](mailto:sales@agora.io) 开通 Agora 视频鉴黄服务，需按照格式提供以下要素：

```
"AppId": {
    "desc": "描述",
    "callback_url": "接收鉴黄结果服务器地址",
    "aliyun_oss_access_key_id": "阿里云OSS-AccessKeyId",
    "aliyun_oss_access_key_secret": "阿里云OSS-AccessKeySecret",
    "aliyun_oss_bucket_name": "阿里云OSS-BucketName",
    "aliyun_oss_endpoint": "阿里云OSS-Endpoint",
    "aliyun_oss_fileName_prefix": "文件前缀"
}
```

**配置示例**

```
"970CA35de60c44645bbae8a215061b33": {
    "desc": "声网-测试",
    "callback_url": "http://test.com",
    "aliyun_oss_access_key_id": "12345678",
    "aliyun_oss_access_key_secret": "abcd123",
    "aliyun_oss_bucket_name": "test-artifacts",
    "aliyun_oss_endpoint": "oss-accelerate.aliyuncs.com",
    "aliyun_oss_fileName_prefix": "test"
}
```

## 实现方法

对频道内正在推流的视频进行实时鉴黄，首先需要通过 SDK 对视频进行截图并上传，然后通过 Agora 视频鉴黄服务对图片进行审核，输出审核结果——色情/性感/正常。Agora 视频鉴黄服务会将审核结果以 HTTP 请求的形式发送到你指定的服务器地址。

### 客户端截图

#### 1.开启视频截图上传功能

调用 `enableContentInspect` 方法开启截图上传功能。自定义设置截图上传相关信息，包括截图上传用途（鉴黄/监课），截图上传频率，附属信息等。

```C++
void CMainFrame::OnBtnEnableContentInspect()
{
    if (CAgoraObject::GetEngine() == NULL) {
        return;
    }
 
    ContentInspectConfig config;
    ContentInspectModule module1;
    module1.type = kContentInspectModeration; //鉴黄
    module1.frequency = 2;                    //频率为 2s 每次
    ContentInspectModule module2;
    module2.type = kContentInspectSupervise;  //监课
    module1.frequency = 5;
 
    config.moduleCount = 2;
    config.modules[0] = module1;
    config.modules[1] = module2;
 
    CAgoraObject::GetEngine()->enableContentInspect(true, config);
}
```



#### 2.视频截图

调用 `takeSnapshot` 方法进行视频截图。截图成功后，SDK 会触发 `onSnapshotTaken` 回调，该回调中包含图片宽高，图片保存路径等信息。

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



#### 3.图片上传

每一次截图成功时，SDK 自动将图片上传到 Agora 鉴黄服务器。

### 视频鉴黄

收到客户端 SDK 上传的图片后， Agora 视频鉴黄服务对图片进行鉴黄，输出鉴黄结果：正常（`"neutral"`）、性感（`"sexy"`）和色情（`"porn"`）。Agora 视频鉴黄服务会将鉴黄结果以 HTTP 请求的形式发送到你指定的服务器地址，同时将鉴定为性感（`"sexy"`）和色情（`"porn"`）的图片保存在第三方云存储平台（阿里云 OSS）。

## API 参考

**以 C++为例：**

```C++
//开启截图上传功能。
//@param enabled 是否开启截图上传（true：开启；false：不开启）
//@param config 截图上传配置。详见 ContentInspectConfig。
virtual int enableContentInspect(bool enabled, const ContentInspectConfig& config);
 
 
// 回调通知类
class ISnapshotCallback {
    public:
        //截图回调。
        //@param channel 频道名称
        //@param uid 用户 ID
        //@param filePath 图片保存路径
        //@param width 图片宽（像素）
        //@param height 图片高（像素）
        //@param errCode 错误码：
        //  - 0：截图成功
        //  - <0：截图失败
        virtual void onSnapshotTaken(const char* channel, uid_t uid, const char* filePath, int width, int height, int errCode) = 0;
        virtual ~ISnapshotCallback() {};
};
//截图。
//@param channel 频道名称
//@param uid 用户 ID
//@param filePath 图片保存路径
//@param width 图片宽（像素）
//@param height 图片高（像素）
//@param errCode 错误码（0：截图成功；<0：截图失败）
virtual int takeSnapshot(const char* channel, uid_t uid, const char* filePath, ISnapshotCallback* callback);
 
 
// 截图上传用途
typedef int ContentInspectType;
// 截图上传无效
const ContentInspectType kContentInspectInvalid = 0;
// 截图上传用于鉴黄
const ContentInspectType kContentInspectModeration = 1;
// 截图上传用于监课
const ContentInspectType kContentInspectSupervise  = 2;
 
//截图上传用途最大数量
enum MAX_CONTENT_INSPECT_MODULE_TYPE {
    // 截图上传最多可用于32个不同功能，目前可用于鉴黄和监课
    MAX_CONTENT_INSPECT_MODULE_COUNT = 32
};
 
//截图上传用途和频率
struct ContentInspectModule {
    // 截图上传的用途，默认为 kContentInspectInvalid
    ContentInspectType type;
    // 截图上传的频率, 单位: 秒, 默认值为 0，取值范围为 [1,3600]
    int frequency;
    }
};
 
//截图上传配置
struct ContentInspectConfig {
    // 附加信息。每次截图上传，Agora 鉴黄服务将该信息透传给你指定的服务器。
    const char* extraInfo;
    // 截图上传用途的数组, 最多支持 32 个不同用途。
    ContentInspectModule modules[MAX_CONTENT_INSPECT_MODULE_COUNT];
    // 实际开启截图上传用途的数量
    int moduleCount;
 
    ContentInspectConfig() : extraInfo(NULL), moduleCount(0) {}
};
```

## 回调通知

### 视频鉴黄

鉴黄场景下，Agora 视频鉴黄服务会将鉴黄结果以 HTTP 请求的形式发送到你指定的服务器地址。

收到鉴黄结果的通知后，你的服务器需要进行响应，响应的包体格式为 JSON。在以下任意一种情况下，视频鉴黄服务都会认为通知失败：

- 发送消息通知后，5 秒内没有收到你的服务器的响应。
- 响应的 HTTP 状态码不是 `200`，或响应包体格式不是 JSON。

视频鉴黄服务会在第一次通知失败后立即重试，再次发送消息通知，一共会尝试三次通知。

#### 回调示例

```
{
  "requestId": "38f8e3cfdc474cd56fc1ceba380d7e1a_1652693284_b5813fe2ae4fa5cdfe5abd8fef82526f",
  "callbackParam": {
    "cname": "httpClient463224"
  },
  "callbackData": "SDK 透传的 callbackData 字符串数据",
  "checksum": "75ee98849119c2ad4ec2aef58f178fd8",
  "object": "test/20201216/38f8e3cfdc474cd56fc1ceba380d7e1a_httpClient463224__uid_s_91__uid_e_video_20200413081128672.jpg",
  "code": 200,
  "msg": "Moderation complete",
  "channelName":"httpClient463224",
  "userId":"91",
  "results": {
    "porn": {
      "outputs": {
        "neutral": 0.915607393,
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

- `requestId`：String 类型，此次回调通知的 ID，由 SDK生成。一个 ID 对应一个被鉴黄的文件，如一张视频截图。

- `callbackParam`：JSON 类型，回调透传字段。

- `checksum`：String 类型，由 `callbackAddr`、`code`、`object` 和 `requestId` 四个参数值计算出的 MD5 值，用于校验此次回调通知是否来自鉴黄服务。

- `object `：String 类型，此次回调所鉴别文件的文件名。该文件的命名规则为：`<OSS前缀>/<年月日>/<sid>_<cname>__uid_s_<uid>__uid_e_<type>_utc.jpg`。文件名中各字段含义如下：
  - `<sid>`：鉴黄 ID
  - `<cname>`：频道名
  - `<uid>`：用户 ID
  - `<type>`: 文件类型，只支持 `video`。
  - `<utc>`：该切片文件开始时的 UTC 时间，时区为 UTC+0，由年、月、日、小时、分钟、秒和毫秒组成。例如，`utc` 等于 `20190611073246073`，表示该切片文件的开始时间为 UTC 2019 年 6 月 11 日 7 点 32 分 46 秒 73 毫秒。

- `code`：Number 类型，此次鉴黄的状态码。`200` 表示鉴黄完成。

- `msg`：String 类型，此次鉴黄的状态。`"Moderation complete"` 表示此次鉴黄完成。

- `channelName`：String 类型，此次回调所鉴别频道的频道名。

- `userId`：String 类型，此次回调所鉴别用户的 UID。

- `result`：JSON 类型，此次鉴黄的结果。包含以下参数：

  - `porn`：JSON 类型。色情内容的鉴黄结果。

  - `outputs`：JSON 类型。该图片为正常、色情或性感图片的可能性。

      - `neutral`：Float 类型。该图片为正常图片的可能性。正常指图片中无不良内容，可能存在正常且适度的肢体裸露和身体曲线。
      - `porn`：Float 类型。该图片为色情图片的可能性。色情指图片包含生殖器官的裸露、性行为与性暗示、性征的过分强调等。
      - `sexy`：Float 类型，该图片为性感图片的可能性。性感指图片包含较大尺度的裸露或男女性征的轻微轮廓，但无生殖器官的裸露。

    - `scene`：String 类型，鉴黄结果。该鉴黄结果基于 `outputs` 中的三个浮点数值对图片属性进行的判定。`scene` 可返回以下值：
      - `"neutral"`：正常。
      - `"porn"`：色情。
      - `"sexy"`：性感。
- `suggestion`：String 类型，图片处理意见。
  - `"Pass"`：正常图片，不做处理。
  - `"Block"`：色情图片，鉴黄不通过。
  - `"review"`：性感图片。可以根据自己的业务场景，直接将图片认定为正常，不做处理，或进行人工复审。例如，对性感容忍度较高的社交类应用，可以认定图片为正常；而对性感容忍度较低的教育类应用，可以对图片进行人工复审。

- `timestamp`: Int 类型，回调时间戳，等于 `object.utc`。

### 监课

监课场景下，收到审核结果的通知后，你的服务器需要进行响应，响应的包体格式为 JSON。在以下任意一种情况下，鉴黄服务会认为通知失败：

- 发送消息通知后，5 秒内没有收到你的服务器的响应。
- 响应的 HTTP 状态码不是 `200`，或响应包体格式不是 JSON。

视频鉴黄服务会在第一次通知失败后立即重试，再次发送消息通知，一共会尝试三次通知。

#### 监课的回调示例

```
{
  "requestId": "38f8e3cfdc474cd56fc1ceba380d7e1a_1652693284_b5813fe2ae4fa5cdfe5abd8fef82526f",
  "callbackParam": {
    "cname": "httpClient463224"
  },
  "callbackData": "SDK透传的callbackData字符串数据",
  "checksum": "75ee98849119c2ad4ec2aef58f178fd8",
  "object": "xiaozuke/20201216/38f8e3cfdc474cd56fc1ceba380d7e1a_httpClient463224__uid_s_91__uid_e_video_20200413081128672.jpg",
  "code": 200,
  "msg": "Supervise complete",
  "channelName":"httpClient463224",
  "userId":"91",
  "timestamp": 20190611073246073
}
```
- `requestId`：String 类型，此次回调通知的 ID，由 SDK生成。一个 ID 对应一个被审核的文件，如一张视频截图。

- `callbackParam`：JSON 类型，回调透传字段。

- `checksum`：String 类型，由 `callbackAddr`、`code`、`object` 和 `requestId` 四个参数值计算出的 MD5 值，用于校验此次回调通知是否来自鉴黄服务。

- `object`：String 类型，此次回调所审核文件的文件名。该文件的命名规则为：`<OSS前缀>/<年月日>/<sid>_<cname>__uid_s_<uid>__uid_e_<type>_utc.jpg`。文件名中各字段含义如下：
  - `<sid>`：审核 ID
  - `<cname>`：频道名
  - `<uid>`：用户 ID
  - `<type>`: 文件类型，只支持 `video`。
  - `<utc>`：该切片文件开始时的 UTC 时间，时区为 UTC+0，由年、月、日、小时、分钟、秒和毫秒组成。例如，`utc` 等于 `20190611073246073`，表示该切片文件的开始时间为 UTC 2019 年 6 月 11 日 7 点 32 分 46 秒 73 毫秒。

- `code`：Number 类型，此次审核的状态码。200 表示审核完成。

- `msg`：String 类型，此次审核的状态。`"Moderation complete"` 表示此次审核完成。

- `channelName`：String 类型，此次回调所审核频道的频道名。

- `userId`：String 类型，此次回调所审核用户的 UID。

-  `timestamp`：Int 类型，回调时间戳，等于 `object.utc`。