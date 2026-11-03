视频审核功能支持对秀场直播的视频进行内容审核，精准高效过滤违规视频，提高审核效率，降低人工审核成本。

## 技术原理

集成声网 RTC SDK 后，你可以对声网频道内的视频流使用第三方[图普视频审核](https://shenhe.tuputech.com/video_moderation)服务。当频道内有用户发送视频流时，审核结果会由第三方图普服务器直接返回到你的服务器。具体流程如下：

![](https://web-cdn.agora.io/docs-files/1673867371709)

1. 声网 RTC SDK 从频道内的视频流中截取内容，加密传输至声网服务器。
2. 声网服务器对视频流信息进行封装，然后加密传输至第三方审核服务商。
3. 第三方审核服务商将声网视频流信息和审核结果返回到你的回调服务器。
4. 根据审核结果添加业务逻辑。

<div class="alert note">你需要自行准备接收审核结果回调的业务服务器。</div>

## 前提条件

实现该进阶功能前，请确保你已经实现基础的秀场直播功能，如创建房间、加入房间、设置本地视图等。详见[基础功能](./showroom_integration_android?platform=All%20Platforms)。

## 实现步骤

### 1. 检查 Token 取值

为了保障视频审核过程中，直播间视频的安全性，声网需要你使用最新的 Token 加入频道。因此，开启视频审核时，你需要先检查在实现[基础功能](./showroom_integration_android?platform=All%20Platforms)时，调用 `joinChannel` 或 `joinChannelEx` 时是否将声网 RTC AccessToken2 传入 `token` 参数中。具体步骤如下：

1. 在[项目管理](https://console.shengwang.cn/projects)页面找到你为秀场直播创建的声网项目，检查**鉴权机制**是否为安全模式：
    - 如果为安全模式，进行第 2 步检查。
    - 如果不为安全模式，则点击**配置**。在**项目配置**页面，启用主要证书并删除无证书：

        ![](https://web-cdn.agora.io/docs-files/1692774894211)
        ![](https://web-cdn.agora.io/docs-files/1692774903338)
        ![](https://web-cdn.agora.io/docs-files/1692774910579)
        ![](https://web-cdn.agora.io/docs-files/1692774917077)

2. 检查你传入的 `token` 参数是否为你在服务端生成 RTC AccessToken2。如果你对 `token` 参数未传值，或者传入在项目管理页面生成的临时 Token，或者传入 RTC AccessToken，那么你需要生成 RTC AccessToken2 并重新传参。生成步骤详见[使用 Token 鉴权](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/token_server_android_ng?platform=Android)。

### 2. 开通视频审核服务

联系[声网技术支持](https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms)，申请开通视频审核服务。你需要声明你开通的视频审核用于秀场直播场景，并填写视频审核服务的相关信息。部分配置项的说明如下：

| 配置项       | 说明                                                         |
| ------------ | ------------------------------------------------------------ |
| <div style="width: 50pt">检测间隔</div>   | 从视频流中截取内容并送审的时间间隔。截取的内容会先加密传输到声网服务器，封装必要的视频流信息，然后加密传输到第三方审核服务商。 |
| 内容保存     | 你可以选择是否存储所有送审内容，以便后期人工复核。默认保存 7 天。     |
| 回调地址     |  你用于接收审核结果的服务器地址，需要支持 HTTPS。<div class="alert info">视频审核在第一个用户加入频道后自动开始，在所有用户都离开频道后自动停止。声网推荐你接收全部审核结果，你也可以联系声网调整为仅接收违规的审核结果。</div>                       |

### 3. 接收视频审核结果回调

审核结果中的 `tag` 字段中包含公共字段和其他字段。

#### 公共字段

| 字段    | 数据类型   | 字段解释                                                         |
| :------ | :----- | :----------------------------------------------------------- |
| `source`         | String | 固定为 `"agora"`，代表审核内容是来自声网频道内的视频流。     |
| `cname`         | String | 审核结果对应的频道名。         |
| `uid`           | Int | 审核结果对应的用户 ID。 |
| `sid`         | String | 审核结果对应的用户会话。用户从加入到退出当前频道视为一次会话。    |
| `requestId`         | String | 请求 ID，用于标识声网向第三方服务商发送的审核请求。         |
| `timestamp` | Int | 审核结果对应片段的起始时间点。格式为 UTC 时间，时区为 UTC+0，由年、月、日、小时、分钟、秒和毫秒组成。例如：`20230110080616876` 代表 2023 年 1 月 10 日 8 点 6 分 16 秒 876 毫秒。|

#### 其他字段

其它字段详见[图普异步图片识别](http://cloud.doc.tuputech.com/zh/API/image/asyncImage.html)的《4. 识别结果回调请求》小节。

#### 回调示例

完整的回调示例如下：

```json
{
    "json": "{\"54bcfc6c329af61034f7c2fc\":{\"fileList\":[{\"label\":1,\"name\":\"http://cos.ap-guangzhou.myqcloud.com/7-1252177232//cloud-api/storage-0831/2023-01-10/18-1/1673346487085260/276271.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256\\u0026X-Amz-Credential=AKIDvc3E8l8D1g4AzXpqZ1TgcHfmcBSTDgso%2F20230110%2Fap-guangzhou%2Fs3%2Faws4_request\\u0026X-Amz-Date=20230110T102807Z\\u0026X-Amz-Expires=86400\\u0026X-Amz-SignedHeaders=host\\u0026X-Amz-Signature=70194025378b808e007b312d49e09f79aec724b6c75f66926c3899808310d2e0\",\"rate\":0.8984967729559958,\"review\":false,\"subLabel\":{\"label\":18,\"rate\":0.21453628821023063,\"review\":false},\"tag\":\"{\\\"callbackData\\\":\\\"test-callbackData\\\",\\\"cname\\\":\\\"test-tupu\\\",\\\"requestId\\\":\\\"B05EE55820AF449EBC007EB1E17A45QQ\\\",\\\"sid\\\":\\\"B05EE55820AF449EBC007EB1E17A4511\\\",\\\"source\\\":\\\"agora\\\",\\\"timestamp\\\":20230110102806386,\\\"uid\\\":123456}\"}],\"reviewCount\":0,\"statistic\":[0,1,0]},\"5b7be1f59b0c77a8c2afb351\":{\"fileList\":[{\"faceId\":\"非政治人物\",\"facePosition\":[[0.30214843,0.1875],[0.50045574,0.1875],[0.50045574,0.36953124],[0.30214843,0.36953124]],\"label\":2,\"name\":\"http://cos.ap-guangzhou.myqcloud.com/7-1252177232//cloud-api/storage-0831/2023-01-10/18-1/1673346487085260/276271.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256\\u0026X-Amz-Credential=AKIDvc3E8l8D1g4AzXpqZ1TgcHfmcBSTDgso%2F20230110%2Fap-guangzhou%2Fs3%2Faws4_request\\u0026X-Amz-Date=20230110T102807Z\\u0026X-Amz-Expires=86400\\u0026X-Amz-SignedHeaders=host\\u0026X-Amz-Signature=70194025378b808e007b312d49e09f79aec724b6c75f66926c3899808310d2e0\",\"objects\":[{\"faceId\":\"非政治人物\",\"facePosition\":[[0.30214843,0.1875],[0.50045574,0.1875],[0.50045574,0.36953124],[0.30214843,0.36953124]],\"faceUrl\":\"\",\"label\":2,\"review\":false,\"similarity\":0,\"typeName\":\"非政治人物\"}],\"review\":false,\"similarity\":0,\"tag\":\"{\\\"callbackData\\\":\\\"test-callbackData\\\",\\\"cname\\\":\\\"test-tupu\\\",\\\"requestId\\\":\\\"B05EE55820AF449EBC007EB1E17A45QQ\\\",\\\"sid\\\":\\\"B05EE55820AF449EBC007EB1E17A4511\\\",\\\"source\\\":\\\"agora\\\",\\\"timestamp\\\":20230110102806386,\\\"uid\\\":123456}\",\"typeName\":\"非政治人物\"}]},\"5e1d634d2809c24f6d909bd3\":{\"fileList\":[{\"label\":0,\"name\":\"http://cos.ap-guangzhou.myqcloud.com/7-1252177232//cloud-api/storage-0831/2023-01-10/18-1/1673346487085260/276271.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256\\u0026X-Amz-Credential=AKIDvc3E8l8D1g4AzXpqZ1TgcHfmcBSTDgso%2F20230110%2Fap-guangzhou%2Fs3%2Faws4_request\\u0026X-Amz-Date=20230110T102807Z\\u0026X-Amz-Expires=86400\\u0026X-Amz-SignedHeaders=host\\u0026X-Amz-Signature=70194025378b808e007b312d49e09f79aec724b6c75f66926c3899808310d2e0\",\"objects\":[],\"rate\":1,\"review\":false,\"tag\":\"{\\\"callbackData\\\":\\\"test-callbackData\\\",\\\"cname\\\":\\\"test-tupu\\\",\\\"requestId\\\":\\\"B05EE55820AF449EBC007EB1E17A45QQ\\\",\\\"sid\\\":\\\"B05EE55820AF449EBC007EB1E17A4511\\\",\\\"source\\\":\\\"agora\\\",\\\"timestamp\\\":20230110102806386,\\\"uid\\\":123456}\"}]},\"5e1d70adeec2874f7318dc52\":{\"fileList\":[{\"label\":0,\"labels\":[0,10,25,8,13],\"name\":\"http://cos.ap-guangzhou.myqcloud.com/7-1252177232//cloud-api/storage-0831/2023-01-10/18-1/1673346487085260/276271.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256\\u0026X-Amz-Credential=AKIDvc3E8l8D1g4AzXpqZ1TgcHfmcBSTDgso%2F20230110%2Fap-guangzhou%2Fs3%2Faws4_request\\u0026X-Amz-Date=20230110T102807Z\\u0026X-Amz-Expires=86400\\u0026X-Amz-SignedHeaders=host\\u0026X-Amz-Signature=70194025378b808e007b312d49e09f79aec724b6c75f66926c3899808310d2e0\",\"rate\":0.9991529339260514,\"rates\":[0.9991529339260514,0.00021821152005362592,0.00014480834910299872,0.00011480319755559418,0.00010425450257236194],\"review\":false,\"tag\":\"{\\\"callbackData\\\":\\\"test-callbackData\\\",\\\"cname\\\":\\\"test-tupu\\\",\\\"requestId\\\":\\\"B05EE55820AF449EBC007EB1E17A45QQ\\\",\\\"sid\\\":\\\"B05EE55820AF449EBC007EB1E17A4511\\\",\\\"source\\\":\\\"agora\\\",\\\"timestamp\\\":20230110102806386,\\\"uid\\\":123456}\"}],\"reviewCount\":0,\"topNStatistic\":[{\"count\":1,\"label\":0}]},\"code\":0,\"message\":\"success\",\"nonce\":0.265046801,\"requestId\":\"73346487-e19a-49ac-944c-cd50081a2e61\",\"summary\":[{\"code\":0,\"name\":\"http://cos.ap-guangzhou.myqcloud.com/7-1252177232//cloud-api/storage-0831/2023-01-10/18-1/1673346487085260/276271.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256\\u0026X-Amz-Credential=AKIDvc3E8l8D1g4AzXpqZ1TgcHfmcBSTDgso%2F20230110%2Fap-guangzhou%2Fs3%2Faws4_request\\u0026X-Amz-Date=20230110T102807Z\\u0026X-Amz-Expires=86400\\u0026X-Amz-SignedHeaders=host\\u0026X-Amz-Signature=70194025378b808e007b312d49e09f79aec724b6c75f66926c3899808310d2e0\",\"riskTask\":\"54bcfc6c329af61034f7c2fc\",\"riskType\":2,\"suggestion\":2,\"tag\":\"{\\\"callbackData\\\":\\\"test-callbackData\\\",\\\"cname\\\":\\\"test-tupu\\\",\\\"requestId\\\":\\\"B05EE55820AF449EBC007EB1E17A45QQ\\\",\\\"sid\\\":\\\"B05EE55820AF449EBC007EB1E17A4511\\\",\\\"source\\\":\\\"agora\\\",\\\"timestamp\\\":20230110102806386,\\\"uid\\\":123456}\"}],\"timestamp\":1673346488265}",
    "signature": "r1xBiauHLkKdYu/7raB+lro7rlAOAEGYG2yLj/Tq2faGE7A++D1BYepUilknPAh0n8XrSfghS15tYSIdsaEsG8sOj5FQ2FrzbaK7zQmRyKuLDazSJTJdAacUvjIwqVULjEUHMIcGtdJhNeeLgxDovQ5mLG3+DQqxbitonDOnfVc="
}
```

~5d39adb0-964e-11ed-98c1-83ef730c7692~