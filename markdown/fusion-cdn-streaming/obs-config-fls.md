Agora 推荐使用以下任意一种推流软件推流到融合 CDN 直播：
- [OBS](https://obsproject.com) (Open Broadcaster Software)，支持 macOS、Windows 及 Linux 平台。
- [XSplit Broadcaster](https://www.xsplit.com/broadcaster)，支持 Windows 平台。

本文以使用 OBS 推流为例，介绍推流软件的相关配置。

## 前提条件

- 已安装 OBS。
- 推流域名和播流域名已配置完成。
  域名配置功能处于内测阶段，具体请联系 sales@agora.io。

## 设置推流服务

参考以下步骤设置推流服务：

1. 获取推流 URL，详见[拼接直播 URL](https://docs.agora.io/cn/fusion-cdn-streaming/streaming-url-fls?platform=RESTful)。
2. 打开 OBS，在右下角的控件菜单中点击**设置**，打开设置窗口。
   ![open obs setting](https://web-cdn.agora.io/docs-files/1637227546202)
3. 在设置窗口的左侧导航栏点击**推流**，服务类型选择**自定义...**。
3. 根据推流 URL 填写服务器和串流密钥，规则如下图所示：
   ![obs url rule](https://web-cdn.agora.io/docs-files/1637227436146)
   假设推流 URL 为 rtmp://push.agora.io/live/test?ts=1635004800&sign=95b0a9970c593819，则设置如下：
   - 服务器：rtmp://push.agora.io/live
   - 串流密钥：test?ts=1635004800&sign=95b0a9970c593819
   ![obs example setting](https://web-cdn.agora.io/docs-files/1637227399558)
5. 点击**确定**，保存设置。

## 推流编码参数配置

下表列出 Agora 推荐的推流编码参数配置供你参考：

| 编码参数       | 推荐配置                                                     |
| :------------- | :----------------------------------------------------------- |
| 视频编码格式   | H.264，编码器 x264                                           |
| 音频编码格式   | AAC                                                          |
| 码率（比特率） | 根据视频的分辨率和帧率进行设置，可以参考 Agora 视频码率参考表中的[直播码率](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a4b090cd0e9f6d98bcf89cb1c4c2066e8) |
| 关键帧间隔     | 2 秒                                                         |

其他编码参数建议使用默认值，或者咨询 Agora 技术支持。
