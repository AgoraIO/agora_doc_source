## 为什么 Web 端无法打开摄像头或麦克风？

请确认浏览器摄像头或麦克风的权限是否打开，步骤参考以下截图：

![](https://web-cdn.agora.io/docs-files/1679997920685)

![](https://web-cdn.agora.io/docs-files/1679998051320)

![](https://web-cdn.agora.io/docs-files/1679998062617)

如果已经开启权限依然不能打开摄像头或麦克风，请按以下步骤刷新：
1. 清理浏览器缓存
2. 重启浏览器
3. 升级浏览器版本


## 如何调整视频分辨率？
### 课堂中视频分辨率

Web 端可以通过改变 [`launch`](agora_class_api_ref_web?platform=Web#launch) 方法中的 `launchOption.MediaOptions` 参数来调整课堂中的分辨率：

- `launchOption.MediaOptions.lowStreamCameraEncoderConfiguration` 用于调整小流的分辨率
- `launchOption.mediaOptions.cameraEncoderConfiguration` 用于调整大流的分辨率
- `launchOption.mediaOptions.screenShareEncoderConfiguration` 用于调整屏幕共享的分辨率

以下示例代码说明了如何修改大小流的分辨率：

```js
    AgoraEduSDK.launch(appRef.current, {
        ...launchOption,
        recordUrl,
        courseWareList,
        uiMode: homeStore.theme,
        virtualBackgroundImages,
        virtualBackgroundVideos,
        mediaOptions: {
        cameraEncoderConfiguration: {
            width: 1280,
            height: 720,
            frameRate: 30,
            bitrate: 1710,
        },
        lowStreamCameraEncoderConfiguration:{
            width: 1280,
            height: 720,
            frameRate: 30,
            bitrate: 1710,
        }
        },
        listener: (evt: AgoraEduClassroomEvent, type) => {
        ,
    });
   
```

### 录制视频分辨率

Web 端可以通过改变 RESTful API [设置录制状态](agora_class_restful_api?platform=RESTful#%E8%AE%BE%E7%BD%AE%E5%BD%95%E5%88%B6%E7%8A%B6%E6%80%81)中的 `webRecordConfig` 参数来调整课堂录制视频的分辨率，参照以下示例代码：

```js
get recordArgs() {
const { recordUrl, rteEngineConfig, recordRetryTimeout } = EduClassroomConfig.shared;
const args = {
    webRecordConfig: {
    rootUrl: `${recordUrl}?language=${rteEngineConfig.language}`,
        videoBitrate: 3000,
        videoWidth：1280,
        videoHeight:720,
        videoFps:15
    },
    mode: RecordMode.Web,
    retryTimeout: recordRetryTimeout,
};
```

## 使用屏幕共享报错时“请先打开屏幕录制权限”?

如果你在开启屏幕共享时遇到如下错误，说明你还未开启系统屏幕录制权限。
![](https://web-cdn.agora.io/docs-files/1679998107736)


以 macOS 系统为例，你可以在**系统设置** > **隐私与安全性** > **屏幕录制**开启相应的权限，参考以下截图：
![](https://web-cdn.agora.io/docs-files/1679998119366)

![](https://web-cdn.agora.io/docs-files/1679998128665)


## 直播是否有网络带宽的要求？

- 老师端带宽及速率：10 Mbps以上独享宽带，上行速率大于 4 Mbps。
- 学生端带宽及速率：最低 4 Mbps 以上独享宽带。


## 上课时频繁卡顿，听不清音频，出现白屏或黑屏，加载课件失败等怎么办?

如果你出现以上网络问题，可参考以下步骤检查你的网络：

- 重启路由器，重连网络。
- 设备靠近路由器，不要隔墙。
- 断开其他占用网速的程序或设备，例如下载程序、在线播放程序、云盘类软件、电视网络机顶盒等。
- 切换网络，例如从 WiFi 切换成 4G 热点网络重进课堂。
- 重启设备。
- 关闭 VPN 或网络代理。



## 学生听不到老师声音怎么办？

- 检查老师端是否开启麦克风。
- 检查学生端网络情况。
- 检查学生端扬声器（包括音量合成器）和浏览器是否静音。
- 检查学生端课堂中使用的扬声器设备是否选择正确。
- 学生端退出重进课堂或重启设备。


## 老师听不到学生声音怎么办？

- 检查学生是否上台并打开麦克风。
- 检查老师端扬声器（包括音量合成器）和浏览器是否静音。
- 检查老师端课堂中使用的扬声器设备是否选择正确。
- 老师端退出重进课堂或重启设备。


