声网歌词打分组件（KaraokeView）包含歌词组件（LyricsView）和打分组件（ScoringView）。在 K 歌房场景中，你可以通过歌词组件实现歌曲播放时歌词同步展示以及自定义歌词界面，通过打分组件实现根据当前播放进度展示对应的原唱音准线、展示演唱者和原唱音准线的匹配效果、演唱者的分数、自定义打分逻辑以及打分组件界面。

本文介绍如何在项目中集成并使用声网歌词和打分组件。

<div class="alert note">本文仅适用于歌词打分组件 v1.1.1。</div>

## 功能描述

歌词组件：

- 歌曲播放时，根据当前播放进度显示对应的歌词，支持显示逐字（XML）或逐句（LRC）的歌词；当拖动到指定时间的歌词时，歌曲进度随之改变。
- 自定义歌词界面，包括歌词颜色、行间距、字体大小等界面元素。

打分组件：

- 将演唱者和歌曲原唱的音调进行对比，并实时将匹配度以动画和分数的方式呈现在界面上。
- 自定义打分逻辑和界面显示，如音准线的颜色、粒子动画效果、游标样式等。

<img src="https://web-cdn.agora.io/docs-files/1687162089264" style="zoom:60%;" />

下图展示歌词打分组件 API 的调用时序：

![](https://web-cdn.agora.io/docs-files/1687165804719)

## 前提条件

在使用歌词组件前，请确保你已在项目中集成声网视频 SDK v4.x，并实现在线 K 歌功能，详见[客户端实现](https://docs.agora.io/cn/online-ktv/chorus_client_android?platform=iOS)。

请按照如下步骤，使用 CocoaPods 自动集成歌词组件：

1. 开始前请确保你已安装 Cocoapods。参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。

2. 在终端里进入项目根目录，并运行 pod init 命令。项目文件夹下会生成一个 **Podfile** 文本文件。

3. 打开 **Podfile** 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称，并将 `version` 替换为你需集成的歌词组件版本。

   ```ruby
    target 'Your App' do
            # version 请填写具体的版本号，最新版本为 1.1.1。
        pod 'AgoraLyricsScore', '~> version'
    end
   ```

4. 运行 `pod install` 命令安装歌词组件。成功安装后，**Terminal** 中会显示 `Pod installation complete!`，此时项目文件夹下会生成一个 `xcworkspace` 文件。

5. 打开新生成的 `xcworkspace` 文件。

## 实现歌词组件

本节介绍如何实现歌词组件。

### 创建 `KaraokeView` 对象并初始化

创建 `KaraokeView` 对象。在调用 `KaraokeView` 类下的其他 API 前，你需要确保已创建并初始化 `KaraokeView` 对象。示例代码如下：

```swift
// 创建 KaraokeView 对象并设置日志记录器。
let karaokeView = KaraokeView(frame: .zero, loggers: [FileLogger(), ConsoleLogger()])
karaokeView.frame = ....
view.addSubview(karaokeView)
karaokeView.delegate = self
```

### 实现歌词事件回调

实现 `KaraokeDelegate` 并设置歌词事件回调。设置回调后，当拖动歌词视图时会触发 `onKaraokeView`[1/2] 回调报告拖动之后歌词的位置。

```swift
func onKaraokeView(view: KaraokeView, didDragTo position: Int)
```

### 歌词显示及同步

1. **解析歌词**

   调用 `parseLyricData` 方法解析歌词，然后通过 `setLyricData` 方法将解析后的歌词数据模型设置给 `KaraokeView` 对象以便后续的歌词展示。歌词数据模型中包含了歌曲类型、歌词类型、歌曲时长、前奏时长、歌曲名和演唱者等信息。

   ```swift
   let url = URL(fileURLWithPath: filePath)
   let data = try! Data(contentsOf: url)
   let model = KaraokeView.parseLyricData(data: data)
   karaokeView.setLyricData(data: model)
   ```


2. **歌词同步**

   当播放器开始播放歌曲后，你可以通过内置媒体播放器的 [getPosition](https://docportal.shengwang.cn/cn/extension_customer/API%20Reference/ios_ng/API/toc_mediaplayer.html?platform=iOS#api_imediaplayer_getplayposition) 获取歌曲当前的播放进度，然后通过 `setProgress` 来把歌词的播放进度设置给歌词组件，从而实现歌词同步。

   声网歌词组件还支持歌词拖动，当拖动到指定时间的歌词时，歌曲进度随之改变。当你设置允许歌词拖动后（把 `LyricsView` 类下的 `draggable` 设为 `true`），SDK 会触发 `onKaraokeView`[1/2] 回调报告歌词拖动后的位置，然后你需要调用 `setProgress` 方法同步此时歌曲的播放位置给歌词组件，从而实现歌词同步。

   <div class="alert info">为保证歌词 UI 界面的流畅性，声网建议调用 <code>setProgress</code> 方法的时间间隔不超过 20 ms。</div>

   ```swift
   // 拖拽回调处理
   func onKaraokeView(view: KaraokeView, didDragTo position: Int) {
       mpk.seek(toPosition: position)
       // 拖动歌曲后会导致累计的演唱分数变化，此处为拖动后的累计分数
       cumulativeScore = view.scoringView.getCumulativeScore()
   }
   // 把根据歌曲拖动后的进度设置给歌词组件，用于同步显示对应的歌词
   karaokeView.setProgress(progress: progress)
   ```

3. **重置**

   当一首歌结束播放或需要中途切换为另外一首歌曲播放时，需要调用 `reset` 方法来重新设置歌词。

   ```swift
   karaokeView.reset()
   ```

### 自定义歌词组件界面

你可以自定义歌词组件的歌词颜色、行间距、字体大小等界面元素。参考如下示例代码来自定义歌词组件的界面元素：

```swift
public class LyricsView: UIView {
    // 设置无歌词时显示的提示文字
    @objc public var noLyricTipsText: String = "无歌词"
    // 设置提示文字的颜色
    @objc public var noLyricTipsColor: UIColor = .orange
    // 设置提示文字的大小
    @objc public var noLyricTipsFont: UIFont = .systemFont(ofSize: 17)
    // 设置在播放歌曲前奏时是否显示等待圆点
    @objc public var waitingViewHidden: Bool = false
    // 设置未在播放中的歌词颜色
    @objc public var inactiveLineTextColor: UIColor = .white
    // 设置当前播放的歌词行中，即将播放的歌词颜色
    @objc public var activeLineUpcomingTextColor: UIColor = .white
    // 设置当前播放的歌词行中，已播放的歌词颜色
    @objc public var activeLinePlayedTextColor: UIColor = .colorWithHex(hexStr: "#FF8AB4")
    // 设置未在播放中的歌词文字大小
    @objc public var inactiveLineFontSize = UIFont(name: "PingFangSC-Semibold", size: 15)!
    // 设置当前播放的歌词文字大小
    @objc public var activeLineUpcomingFontSize = UIFont(name: "PingFangSC-Semibold", size: 18)!
    // 设置歌词界面的最大宽度
    @objc public var maxWidth: CGFloat = UIScreen.main.bounds.width - 30
    // 设置歌词行间距
    @objc public var lyricLineSpacing: CGFloat = 10
    // 设置等待圆点的风格，包括背景色、大小、间距
    @objc public let firstToneHintViewStyle: FirstToneHintViewStyle = .init()
    // 是否允许歌词拖动
    @objc public var draggable: Bool = false
```

## 实现打分组件

### 同步人声音调

当演唱者开始唱歌，你可以通过 `AgoraRtcEngineDelegate` 下的 [reportAudioVolumeIndicationOfSpeakers](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/ios_ng/API/toc_audio_process.html?platform=iOS#callback_irtcengineeventhandler_onaudiovolumeindication) 来获取本地用户的人声音调，然后通过 `setPitch` 来将用户实时的人声音调同步给打分组件。

```swift
karaokeView.setPitch(pitch: pitch)
```

### 实现打分事件回调

实现 `KaraokeDelegate` 并设置歌词事件回调。设置回调后，当前行歌词播放完后会触发 `onKaraokeView`[2/2] 回调报告当前行歌词的演唱得分和累计得分。

```swift
func onKaraokeView(view: KaraokeView,
                       didFinishLineWith model: LyricLineModel,
                       score: Int,
                       cumulativeScore: Int,
                       lineIndex: Int,
                       lineCount: Int) 
```

### 自定义打分偏好

如果默认的打分算法无法满足你的需求，声网还支持自定义打分偏好。

**设置得分难易程度**

调用 `setScoreLevel` 来设置演唱者得分的难易程度。你可以通过 `level` 参数来调节难易程度，取值范围为 [0,100]，默认值为 10。值越小难度越低，演唱者越容易得分。你也可以参考[不同难度的推荐取值](/cn/online-ktv/lyrics_scores_ios?platform=iOS#table)来进行设置。

```swift
// 设置打分难易程度
karaokeView.setScoreLevel(level: 10)
```

**调整分数**

如果你的业务场景对演唱分数有特殊要求，你还可以调用 `setScoreCompensationOffset` 调整分数结果。取值范围为 [-100, 100]，默认值为 0。

例如，如果你将 `offset` 参数设为 `10`，则每一句歌词演唱完后，SDK 会在原有得分基础上增加 10 分，如果设为 `-10`，则会在原有基础上减 10 分。

```swift
karaokeView.setScoreCompensationOffset(offset: 0)
```

<div class="alert info">声网不建议你同时使用 <code>setScoreLevel</code> 和 <code>setScoreCompensationOffset</code> 来调整打分逻辑。</div>

**设置动画效果阈值**

动画效果阈值决定了何时触发音高线着色和粒子动画的显示并对 UI 界面产生影响。你可以调用 `hitScoreThreshold` 方法来调整音高阈值，取值范围为 [0, 1]，默认值为 0.7，取值越小越容易触发音高线着色和粒子动画。例如，如果你将该值设为 0.1，则一行歌词得分超过 10 分，就会触发音高线着色和粒子动画。

```swift
karaokeView.scoringView.hitScoreThreshold = 0.7
```

**自定义打分算法**

如果你对打分有更高的要求，还可以根据你的业务需求重写打分算法。你需要实现 `IScoreAlgorithm` 接口类并创建一个新的 `ScoreAlgorithm` 分数计算实例。

```swift
// 实现 IScoreAlgorithm 接口类
class ScoreAlgorithm: IScoreAlgorithm {
    func getLineScore(with toneScores: [ToneScoreModel]) -> Int {
        if toneScores.isEmpty { return 0 }
        let ret = toneScores.map({ $0.score }).reduce(0.0, +) / Float(toneScores.count)
        return Int(ret)
    }
}
 
// 设置分数计算实例
let algorithm = ScoreAlgorithm()
karaokeView.setScoreAlgorithm(algorithm: algorithm)
```

### 自定义打分组件界面

你可以自定义打分组件的游标样式、标准音高线的颜色、粒子动画效果等界面元素。参考如下示例代码来自定义歌词组件的界面元素：

```swift
public class ScoringView: UIView {
    // 打分组件视图的高度
    @objc public var viewHeight: CGFloat = 120
    // 打分组件视图和顶部的间距
    @objc public var topSpaces: CGFloat = 0
    // 游标起始的位置
    @objc public var defaultPitchCursorX: CGFloat = 100
    // 标准音高线的高度
    @objc public var standardPitchStickViewHeight: CGFloat = 3
    // 标准音高线的移动速度
    @objc public var movingSpeedFactor: CGFloat = 120
    // 标准音高线默认的颜色
    @objc public var standardPitchStickViewColor: UIColor = .gray
    // 标准音高线匹配后的颜色
    @objc public var standardPitchStickViewHighlightColor: UIColor = .colorWithHex(hexStr: "#FF8AB4")
    /** 游标偏移量(X轴) 游标的中心到竖线的 centerX 的距离
     - 等于0：游标中心点和竖线中心点重合
     - 小于0: 游标向左偏移
     - 大于0：游标向向偏移 **/
    @objc public var localPitchCursorOffsetX: CGFloat = -3
    // 自定义游标的样式
    @objc public var localPitchCursorImage: UIImage? = nil
    // 是否隐藏粒子动画效果
    @objc public var particleEffectHidden: Bool = false
    // 使用图片创建粒子动画
    @objc public var emitterImages: [UIImage]?
    // 设置动画效果阈值
    @objc public var hitScoreThreshold: Float = 0.7
}
```

## 相关信息

本节提供其他相关信息供参考。

### 示例项目

声网在 GitHub 上提供歌词组件开源的[示例项目](https://github.com/AgoraIO-Community/LrcView-iOS/tree/feature/1.1.1)供你参考。

### 参考文档

[歌词组件 API 文档](/cn/online-ktv/lyrics_scores_ios?platform=iOS)