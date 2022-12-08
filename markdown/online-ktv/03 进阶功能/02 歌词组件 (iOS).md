Agora 歌词组件支持在歌曲播放时同步显示 LRC 或 XML 格式的歌词，同时支持将演唱者和歌曲原唱的音调进行对比，并实时将匹配度以动画和分数的方式呈现在界面上。

本文介绍如何在项目中集成并使用 Agora 歌词组件。

<img src="https://web-cdn.agora.io/docs-files/1652180655314" style="zoom:80%;" />

## 功能描述

### 歌词展示与同步

- 歌曲播放时，根据当前播放进度显示对应的歌词，当手势拖动到指定时间的歌词，歌曲进度随之改变。
- 自定义歌词视图和歌词背景图。

### 歌唱音准和评分

- 歌曲播放时，根据当前播放进度展示对应的原唱音准线。
- 实时展示演唱者和原唱音准线的匹配效果，以及演唱者的分数。
- 自定义评分视图的部分元素。

<div class="alert note">仅 XML 格式的歌词支持歌唱音准和评分功能。 </div>

## 前提条件

在使用歌词组件前，请确保你已在项目中集成 Agora 视频 SDK v4.x，并实现在线 K 歌功能，详见[客户端实现](https://docs.agora.io/cn/online-ktv/chorus_client_ios?platform=iOS)。

## 实现方法

![](https://web-cdn.agora.io/docs-files/1668754460096)

### 集成歌词组件

请按照如下步骤，使用 CocoaPods 自动集成歌词组件：

1. 开始前请确保你已安装 Cocoapods。参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。

2. 在终端里进入项目根目录，并运行 pod init 命令。项目文件夹下会生成一个 **Podfile** 文本文件。

3. 打开 **Podfile** 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称，并将 `version` 替换为你需集成的歌词组件版本。

   ```
    target 'Your App' do
		    // version 请填写具体的版本号，最新版本为 1.0.8.3。
        pod 'AgoraLyricsScore', '~> version'
    end
   ```

4. 运行 `pod install` 命令安装歌词组件。成功安装后，**Terminal** 中会显示 `Pod installation complete!`，此时项目文件夹下会生成一个 `xcworkspace` 文件。

5. 打开新生成的 `xcworkspace` 文件。

**初始化歌词组件对象**

声明并初始化歌词组件对象。示例代码如下：

```swift
private lazy var lrcScoreView: AgoraLrcScoreView = {
    let lrcScoreView = AgoraLrcScoreView(delegate: self)
    let config = AgoraLrcScoreConfigModel()
    // config.isHiddenScoreView = true
    let scoreConfig = AgoraScoreItemConfigModel()
    scoreConfig.tailAnimateColor = .yellow
    scoreConfig.scoreViewHeight = 100
    scoreConfig.emitterColors = [.systemPink]
    config.scoreConfig = scoreConfig
    let lrcConfig = AgoraLrcConfigModel()
    lrcConfig.lrcFontSize = .systemFont(ofSize: 15)
    lrcConfig.isHiddenWatitingView = false
    lrcConfig.isHiddenBottomMask = true
    lrcConfig.lrcHighlightFontSize = .systemFont(ofSize: 18)
    lrcConfig.lrcTopAndBottomMargin = 10
    lrcConfig.tipsColor = .white
    config.lrcConfig = lrcConfig
    lrcScoreView.config = config
    return lrcScoreView
}()lrcConfig
```

### 开始、停止播放歌词

设置你需要播放的歌词 URL 地址，并开始、停止滚动播放歌词，示例代码如下：

```swift
// 设置歌词地址。歌词下载完成后会收到 downloadLrcFinished 回调。
lrcScoreView.setLrcUrl(url: "https://example.com")
// 开始滚动歌词 （需在收到 downloadLrcFinished 回调后调用）。
lrcScoreView.start()
// 停止滚动歌词。
lrcScoreView.stop()
// 重置歌词界面。
lrcScoreView.reset()
// 重置歌词时间。
lrcScoreView.resetTime()
```

下载歌词到本地会导致 app 体积不断增加，为保证 app 运行性能，Agora 建议你定期清理歌词组件的缓存，示例代码如下：

```swift
AgoraLrcScoreView.cleanCache()
```

### 设置代理事件回调监听器

#### 歌词回调

在 `AgoraLrcViewDelegate` 中设置歌词相关方法，实现歌词与歌曲播放同步。示例代码如下：

```swift
weak var delegate: AgoraLrcViewDelegate?
 
protocol AgoraLrcViewDelegate {
    // 获取当前歌曲播放进度（毫秒）
    func getPlayerCurrentTime() -> TimeInterval
    // 获取歌曲总时长（毫秒）
    func getTotalTime() -> TimeInterval
    // 定位到指定播放位置（毫秒）
    @objc
    optional func seekToTime(time: TimeInterval)
    // 获取当前播放的歌词和进度
    @objc
    optional func currentPlayerLrc(lrc: String, progress: CGFloat)
    // 获取歌词对应的原唱标准音调
    @objc
    optional func agoraWordPitch(pitch: Int, totalCount: Int)
}
```

| API                  | 实现功能                                                     | 是否必须 |
| :------------------- | :----------------------------------------------------------- | :------- |
| `getPlayerCurrentTime` | 获取当前歌曲播放进度（毫秒）。<br>你需要自定实现如下逻辑：通过 `AgoraRtcMediaPlayerProtocol` 类的 [`getPosition`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/ios_ng/API/class_imediaplayer.html#api_imediaplayer_getplayposition) 获取当前播放进度，并将返回值传入歌词组件。 | 是       |
| `getTotalTime`         | 获取歌曲总时长（毫秒）。<br>你需要自定实现如下逻辑：通过 `AgoraRtcMediaPlayerProtocol` 的 [`getDuration`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/class_imediaplayer.html?platform=iOS#api_imediaplayer_getduration) 获取歌曲总时长，并将返回值传入歌词组件。</br> | 是       |
| `seekToTime`         | 定位到指定的播放位置（毫秒）。                                     | 否       |
| `currentPlayerLrc`   | 获取当前播放的歌词和进度。                                 | 否       |
| `agoraWordPitch`     | 获取每个歌词文字的标准 `pitch`。                             | 否       |



#### 歌词下载回调

在 `AgoraLrcDownloadDelegate` 中设置歌词下载状态回调，实现歌词下载进度通知。示例代码如下：

```swift
weak var downloadDelegate: AgoraLrcDownloadDelegate?
 
protocol AgoraLrcDownloadDelegate {
    // 下载开始
    @objc
    optional func beginDownloadLrc(url: String)
    // 下载完成
    @objc
    optional func downloadLrcFinished(url: String)
    // 下载进度
    @objc
    optional func downloadLrcProgress(url: String, progress: Double)
    // 下载失败
    @objc
    optional func downloadLrcError(url: String, error: Error?)
    // 下载取消
    @objc
    optional func downloadLrcCanceld(url: String)
    // 开始解析歌词
    @objc
    optional func beginParseLrc()
    // 解析歌词结束
    @objc
    optional func parseLrcFinished()
}
```

#### 歌唱评分回调

在 `AgoraKaraokeScoreDelegate` 中设置分数计算方法，实现歌唱评分实时显示。示例代码如下：

```swift
weak var scoreDelegate: AgoraKaraokeScoreDelegate?
protocol AgoraKaraokeScoreDelegate {
    @objc optional func agoraKaraokeScore(score: Double, cumulativeScore: Double, totalScore: Double)
}
```

| 参数              | 描述             |
| :---------------- | :--------------- |
| `score`           | 当前行得分    |
| `cumulativeScore` | 当前累计得分 |
| `totalScore`      | 当前歌曲总分数 |

## 自定义歌词组件界面

Agora 歌词组件提供默认配置（参考示例代码），你也可以根据自身业务场景需求自定义歌词组件界面元素。

### 组件基础配置

```swift
// 评分模块配置
public var scoreConfig: AgoraScoreItemConfigModel = .init()
// 歌词模块配置
public var lrcConfig: AgoraLrcConfigModel = .init()
// 是否隐藏评分模块
public var isHiddenScoreView: Bool = false
// 歌词背景图
public var backgroundImageView: UIImageView?
// 评分模块和歌词模块之间的间距，默认为 0
public var spacing: CGFloat = 0
```

### 歌词视图配置

```swift
// 无歌词提示文案
public var tipsString: String = "纯音乐，无歌词"
// 提示文字颜色
public var tipsColor: UIColor = .orange
// 提示文字大小
public var tipsFont: UIFont = .systemFont(ofSize: 17)
// 歌词进度分割线颜色
public var separatorLineColor: UIColor = .lightGray
// 是否隐藏歌词进度分割线
public var isHiddenSeparator: Bool = false
// 默认歌词背景色
public var lrcNormalColor: UIColor = .gray
// 高亮歌词背景色
public var lrcHighlightColor: UIColor = .white
// 实时绘制的歌词颜色
public var lrcDrawingColor: UIColor = .orange
// 歌词文字大小
public var lrcFontSize: UIFont = .systemFont(ofSize: 15)
// 歌词高亮文字大小
public var lrcHighlightFontSize: UIFont = .systemFont(ofSize: 18)
// 歌词视图最大宽度
public var maxWidth: CGFloat = UIScreen.main.bounds.width - 30
// 歌词行间距
public var lrcTopAndBottomMargin: CGFloat = 10
// 是否隐藏等待开始圆点
public var isHiddenWatitingView: Bool = false
// 等待开始圆点背景色
public var waitingViewBgColor: UIColor? = .gray
// 等待开始圆点大小 默认: 10
public var waitingViewSize: CGFloat = 10
// 等待开始圆点底部间距
public var waitingViewBottomMargin: CGFloat = 0
// 是否可以拖动歌词，默认为 true。如果开启评分功能，则需要设置为 false。
public var isDrag: Bool = true
// 底部蒙层颜色
public var bottomMaskColors: [UIColor] = [UIColor(white: 0, alpha: 0.05),
                                          UIColor(white: 0, alpha: 0.8)]
// 底部蒙层位置
public var bottomMaskLocations: [NSNumber] = [0.7, 1.0]
// 底部蒙层高度，默认为歌词视图的高度
public var bottomMaskHeight: CGFloat = 0
// 是否隐藏底部蒙层
public var isHiddenBottomMask: Bool = false
```

### 评分视图配置

```swift
// 评分视图高度
public var scoreViewHeight: CGFloat = 100
// 音准匹配圆点的起始位置
public var innerMargin: CGFloat = 100
// 音准线的高度
public var lineHeight: CGFloat = 10
// 音准线的宽度
public var lineWidht: CGFloat = 120
// 音准线颜色
public var normalColor: UIColor = .gray
// 音准匹配后，音准线的颜色
public var highlightColor: UIColor = .orange
// 垂直和上下分割线的颜色
public var separatorLineColor: UIColor = .systemPink
// 是否隐藏垂直分割线
public var isHiddenVerticalSeparatorLine: Bool = false
// 是否隐藏上下分割线
public var isHiddenSeparatorLine: Bool = false
// 游标背景色
public var cursorColor: UIColor = .systemPink
// 游标的宽
public var cursorWidth: CGFloat = 20
// 游标的高
public var cursorHeight: CGFloat = 20
// 是否隐藏粒子动画效果
public var isHiddenEmitterView: Bool = false
// 使用图片创建粒子动画，如果设置为空，则默认使用 emitterColors 创建粒子动画
public var emitterImages: [UIImage]?
// 使用颜色创建粒子动画
public var emitterColors: [UIColor] = [.red]
// 尾部动画图片
public var tailAnimateImage: UIImage?
// 尾部动画颜色
public var tailAnimateColor: UIColor? = .yellow
// 每行歌词默认分数
public var defaultScore: Double = 50
// 每行歌词分制，默认为百分制
public var lineCalcuScore: Double = 100
// 每行歌词最低分，低于该值则不计入最后分数
public var minCalcuScore: Double = 40
```

## 相关信息

### 示例项目

Agora 在 GitHub 上提供歌词组件开源的[示例项目](https://github.com/AgoraIO-Community/LrcView-iOS)供你参考。