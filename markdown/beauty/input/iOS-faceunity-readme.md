# 相芯美颜场景化API


## 前提条件
- 项目里已经集成了Agora RTC SDK
- 联系相芯客户拿到美颜资源以及证书

## 快速集成
1.配置美颜资源/证书

相芯SDK文件/目录         | 项目路径                                                  |
|----------------------|-------------------------------------------------------|
| FaceUnity/Lib/Resources | iOS/FULib         |
| 证书authpack.h      | iOS/BeautyAPi/FUBeauty/authpack.h  |

2.配置依赖库
```podfile
	pod 'fuLib', :path => 'fu.podspec'
```

3.复制以下场景化接口及实现到项目里

```
BeautyAPI
    ├── BeautyAPI.{h,m}
    └── Render/FURender
```

4.初始化

```swift
private lazy var beautyAPI = BeautyAPI()
private lazy var fuRender = FUBeautyRender()

let config = BeautyConfig()
config.rtcEngine = rtcEngine
config.captureMode = .agora
config.beautyRender = fuRender
config.statsEnable = false
config.statsDuration = 1
config.eventCallback = { stats in
    print("min == \(stats.minCostMs)")
    print("max == \(stats.maxCostMs)")
    print("averageCostMs == \(stats.averageCostMs)")
}
let result = beautyAPI.initialize(config)
if result != 0 {
    print("initialize error == \(result)")
}
```

5.美颜开关(默认关)

```swift
beautyAPI.enable(true)
```

6.本地渲染

```swift
beautyAPI.setupLocalVideo(localView, renderMode: .hidden)
rtcEngine.startPreview()
```

7.设置推荐美颜参数
```swift
beautyAPI.setBeautyPreset(.default) // BeautyPreset.CUSTOM：自己实现美颜参数
```

8.销毁美颜

```swift
rtcEngine.leaveChannel()
beautyAPI.destory()
AgoraRtcEngineKit.destroy()
```

## 自定义采集模式
美颜场景API除了能够内部直接使用RTC 祼数据接口进行美颜处理，也支持由外部传入视频帧进行处理，实现步骤如下：

1.初始化时配置captureMode为CaptureMode.Custom

```swift
let config = BeautyConfig()
config.rtcEngine = rtcEngine
config.captureMode = .custom
config.beautyRender = fuRender
config.statsEnable = false
config.statsDuration = 1
config.eventCallback = { stats in
    print("min == \(stats.minCostMs)")
    print("max == \(stats.maxCostMs)")
    print("averageCostMs == \(stats.averageCostMs)")
}
let result = beautyAPI.initialize(config)
if result != 0 {
    print("initialize error == \(result)")
}
```
2.将外部数据帧通过onFrame接口传入，处理成功会替换VideoFrame的buffer数据，即videoFrame参数既为输入也为输出

```swift
beautyAPI.onFrame(pixelBuffer) { pixelBuffer in
    videoFrame.pixelBuffer = pixelBuffer
}
```
