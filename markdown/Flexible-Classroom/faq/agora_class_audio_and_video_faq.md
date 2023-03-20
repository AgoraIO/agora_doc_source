web端打不开摄像头和麦克风怎么办？
1、请确认浏览器摄像头的权限是否打开
（插入几张图片）
如果权限已经开启了，请采用下面几个步骤刷新一下
2、清理一下浏览器的缓存
3、关闭重启一下浏览器
4、升级一下chrome浏览器的版本


2、如何修改课程中视频分辨率？
web端的launch接口可以通过修改launchOption.MediaOptions参数来调整分辨率。
launchOption.MediaOptions.lowStreamCameraEncoderConfiguration 改小流的分辨率
launchOption.mediaOptions.cameraEncoderConfiguration 改大流的分辨率
launchOption.mediaOptions.screenShareEncoderConfiguration修改屏幕共享的分辨率
eg:
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

修改录制的分辨率：
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


3、使用屏幕共享报错，如何开启屏幕录制功能权限?
屏幕共享开启的时候报如下错误：
<img src="./images/screen_share_error.png" style="zoom: 33%;" />


需要开启系统屏幕录制权限。系统设置-》隐私与安全性-》屏幕录制开启相关的开关
<img src="./images/screen_share_setting.png" style="zoom: 33%;" />

<img src="./images/screenshare_turn_on.png" style="zoom: 33%;" />


4、直播对网络带宽的要求
1)  老师端带宽及速率：10Mbps以上独享宽带，上行速率大于4Mbps
2)  学生端带宽及速率：最低4Mbps以上独享宽带.


5、用户在上课的时候频繁卡顿，听不清楚老师上课内容、进教室的时候白屏、视频窗口黑屏、白板模块加载课件失败等怎么办?
解决方案：
1)   重启下路由器，网络重连后刷新试下
2)   靠近路由器，不要隔墙
3)   断开其他占网速的程序、设备，比如下载类、在线 播放器类、云盘类软件、电视网络机顶盒等
4)   切换网络试下，比如切成4G热点网络重进加入房间。
5)   重启下设备
6)   关闭VPN或代理



6、学生听不到老师声音怎么办？
1)   检查下自己的网络是否正常；
2)   检查下学生的电脑扬声器/浏览器是否静音（播放音乐试试）；
3)   检查下老师是否开启了麦克风；
4)   学生退出重进直播间或重启一下设备；
5)   学生先检测教室内的扬声器设备是否选择正确
6)   学生检查下系统的扬声器音量是否正常打开（包括音量合成器）
7)   学生检查下软件的音量是否打开；
8）   重启电脑


7、上课老师反馈听不到学生声音怎么办？
1)   查看学生是否上台并打开麦克风；
2)   老师的扬声器是否选择正确并打开；


