本文提供在线 K 歌房歌词打分组件相关 API。

<div class="alert note">本文仅适用于歌词打分组件 v1.1.1。</div>

## KaraokeView

歌词打分组件的基础接口类，实现歌词同步、演唱评分的主要功能。请确保在主线程中调用该类下的 API。

### init

初始化 `KaraokeView` 。

```objectivec
public convenience init(frame: CGRect, loggers: [ILogger] = [FileLogger(), ConsoleLogger()])
```

在调用 `KaraokeView` 接口类下的其他 API 前，你需要先调用此方法进行初始化。

**参数**

- `frame`：`KaraokeView` 视图的位置和大小。
- `loggers`：日志记录器。SDK 使用 `ILogger` 对象的数组来记录日志。 `ILogger` 数组默认包含一个 `FileLogger` 对象和一个 `ConsoleLogger` 对象。

**返回值**

- 一个 `KaraokeView` 实例。

### parseLyricData

解析歌词文件数据。

```objective-c
public static func parseLyricData(data: Data) -> LyricModel?
```

**参数**

- `data`：需要解析的歌词文件对象。

**返回值**

- 方法调用成功时返回一个对应的歌词数据模型对象，包含歌词文本等信息。
- 方法调用失败时返回 `nil`。

### setLyricData

设置歌词数据模型。

```objectivec
public func setLyricData(data: LyricModel?)
```

该方法用于设置歌词数据模型，在调用该方法前，你需要先调用 `parseLyricData` 方法解析歌词数据并获取相应的歌词数据模型对象以便于歌词显示。

请在主线程调用该方法。

**参数**

- `data`：[LyricModel](#LyricModel) 对象，表示歌词数据模型，包含歌曲的基本信息、歌词信息等。如果为 `nil`，表示当前歌曲为纯音乐，没有对应的歌词信息。

### reset

重置歌词及打分设置。

```objectivec
public func reset()
```

当一首歌曲播放完毕后或是播放过程中切到另外一首歌曲时，需要调用该方法来重置歌词、打分设置。

### setProgress

把歌曲当前的播放进度同步给歌词、打分组件。

```objectivec
public func setProgress(progress: Int)
```

在实现歌词和歌曲播放同步时，你需要调用该方法来将歌曲当前的播放进度设置给 `KaraokeView` 以便 `KaraokeView` 根据当前歌曲的播放位置显示对相应的歌词。

调用该方法前你需要先通过内置媒体播放器的 [getPosition](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/ios_ng/API/toc_mediaplayer.html#api_imediaplayer_getplayposition) 方法获取歌曲当前的播放进度。声网建议你每 20 毫秒调用一次该方法来把歌曲的播放进度同步给歌词打分组件。

**参数**

- `progress`：歌曲的播放进度，单位为毫秒。

### setPitch[1/2]

把获取的实时人声音调同步给打分组件。

```objectivec
public func setPitch(pitch: Double)
```

当你通过 `AgoraRtcEngineDelegate` 下的 [reportAudioVolumeIndicationOfSpeakers](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/ios_ng/API/toc_audio_process.html?platform=iOS#callback_irtcengineeventhandler_onaudiovolumeindication) 获取本地用户的人声音调后，你需要调用该方法把获取到的实时人声音调同步给打分组件用于演唱评分。

**参数**

- `pitch`：用户的实时人声音调。

### setPitch[2/2]

把获取的实时人声音调和当前歌曲的播放进度同步给打分组件。

```objectivec
 public func setPitch(pitch: Double, progress: Int)
```

当你通过 `AgoraRtcEngineDelegate` 下的 [reportAudioVolumeIndicationOfSpeakers](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/ios_ng/API/toc_audio_process.html?platform=iOS#callback_irtcengineeventhandler_onaudiovolumeindication) 获取本地用户的人声音调、通过内置媒体播放器的 [getPosition](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/ios_ng/API/toc_mediaplayer.html#api_imediaplayer_getplayposition) 方法获取歌曲当前的播放进度后，你需要调用该方法把获取到的实时人声音调和歌曲的播放进度同步给打分组件。

<div class="alert info">声网推荐 K 歌角色为观众的用户调用该方法。</div>

**参数**

- `pitch`：获取到的实时人声音调。
- `progress`：歌曲当前的播放进度，单位为毫秒。

### setScoreLevel

设置得分的难易程度。

```objectivec
public func setScoreLevel(level: Int)
```

你可以通过该方法来设置演唱者得分的难易程度。

**参数**

- `level`：难度等级，取值范围为 [0, 100]，默认值为 10。值越小表示难度等级越低，演唱者越容易得分。
<a name="table"></a>
你可以参考下表来设置不同难度：

| 难度     | 推荐取值 |
| :------- | :------- |
| 低难度   | 3        |
| 中低难度 | 10       |
| 中等难度 | 17       |
| 中高难度 | 25       |
| 高难度   | 35       |

### setScoreCompensationOffset

调整演唱评分分数结果。

```objectivec
public func setScoreCompensationOffset(offset: Int)
```

如果你的业务场景对演唱分数有特殊要求，你可以调用此方法来调整演唱评分的分数结果。

**参数**

- `offset`：额外增加或减少的分数，取值范围为 [-100, 100]，默认值为 0。

声网不建议你同时使用 `setScoreLevel` 和 `setScoreCompensationOffset` 来调整打分机制。

### setScoreAlgorithm

设置 `IScoreAlgorithm` 对象。

```objectivec
public func setScoreAlgorithm(algorithm: IScoreAlgorithm) 
```

如果你不想使用打分组件默认的打分算法，你可以通过该方法来自定义打分算法。你自定义的打分算法应遵循 `IScoreAlgorithm` 协议。 

**参数**

- `algorithm`：实现了`IScoreAlgorithm` 协议的对象。

## KaraokeDelegate

`KaraokeView` 的核心事件回调。

### onKaraokeView[1/2]

歌词拖动结束的回调。

```objectivec
optional func onKaraokeView(view: KaraokeView, didDragTo position: Int)
```

如果你设置允许歌词拖动（将 `LyricsView` 类下的`draggable` 设为 `true`），当歌词拖动结束后会触发此回调。你可以通过该回调获取歌词拖动后对应的播放位置。

**参数**

- `view`：KaraokeView 实例。
- `position`：歌词拖动后对应的歌曲播放位置，单位为毫秒。

### onKaraokeView[2/2]

一行歌词播放完毕回调。

```objectivec
optional func onKaraokeView(view: KaraokeView,
                            didFinishLineWith model: LyricLineModel,
                            score: Int,
                            cumulativeScore: Int,
                            lineIndex: Int,
                            lineCount: Int)
```

当一行歌词播放完毕后，会触发该回调报告当前行的歌词的得分、累计得分等信息。

**参数**

- `view`：`KaraokeView` 实例。
- `model`：当前歌词行的信息，详见 `LyricLineModel`。
- `score`：当前歌曲行的得分，取值范围 [0, 100]。
- `cumulativeScore`：当前累计得分。
- `lineIndex`：歌词行数的索引号，最小值为 0。
- `lineCount`：歌词的总行数。

## IScoreAlgorithm

该协议中提供演唱打分相关的 API。

### getLineScore

获取当前歌词行的演唱得分。

```objectivec
func getLineScore(with toneScores: [ToneScoreModel]) -> Int
```

当用户唱完一句歌词后，你可以调用该方法来自定该行歌词的分数计算。

**参数**

- `toneScores`：当前歌词行中每一个字得分的集合，详见 [ToneScoreModel](#ToneScoreModel)。

## ILogger

该协议提供日志相关的 API。

### onLog

`KaraokeView` 的日志回调。

```objectivec
onLog(content: String, tag: String?, time: String, level: LoggerLevel)
```

你可以通过该回调来了解日志的相关内容，可用于排查问题。

<div class="alert info">此回调将会在子线程被调用。</div>

**参数**

- `content`：要记录的日志内容。
- `tag`：日志标签（可选参数），用于进一步分类或标识日志。
- `time`：日志记录的时间。
- `level`：日志的级别，详见 [LoggerLevel](#LoggerLevel)。

## Class

### LyricsView

```objectivec
public class LyricsView: UIView {
    public var noLyricTipsText: String = "无歌词"
    public var noLyricTipsColor: UIColor = .orange
    public var noLyricTipsFont: UIFont = .systemFont(ofSize: 17)
    public var waitingViewHidden: Bool = false
    public var inactiveLineTextColor: UIColor = .white
    public var activeLineUpcomingTextColor: UIColor = .white
    public var activeLinePlayedTextColor: UIColor = .colorWithHex(hexStr: "#FF8AB4")
    public var inactiveLineFontSize = UIFont(name: "PingFangSC-Semibold", size: 15)!
    public var activeLineUpcomingFontSize = UIFont(name: "PingFangSC-Semibold", size: 18)!
    public var maxWidth: CGFloat = UIScreen.main.bounds.width - 30
    public var lyricLineSpacing: CGFloat = 10
    public let firstToneHintViewStyle: FirstToneHintViewStyle = .init()
    public var draggable: Bool = false
}
```

歌词组件界面设置。

- `noLyricTipsText`：无歌词时显示的提示文字。

- `noLyricTipsColor`：无歌词时显示的提示文字的颜色。

- `noLyricTipsFont`：无歌词时显示的提示文字的大小。

- `waitingViewHidden`：在播放歌曲前奏时是否显示等待圆点。

- `inactiveLineTextColor`：未在当前播放的歌词的颜色。

- `activeLineUpcomingTextColor`：当前歌词行中，即将播放的歌词的颜色。

- `activeLinePlayedTextColor`：当前歌词行中，已播放的歌词的颜色。

- `inactiveLineFontSize`：未在当前播放的歌词文字大小。

- `activeLineUpcomingFontSize`：即将播放的歌词文字大小。

- `maxWidth`：歌词视图的最大宽度（pt）。

- `lyricLineSpacing`：歌词行间距。

- `FirstToneHintViewStyle`：等待圆点的风格，详见 [FirstToneHintViewStyle](#FirstToneHintViewStyle)。

- `draggable`：是否允许歌词拖动：

  - `true`：允许歌词拖动。

  - `false`：（默认）不允许歌词拖动。

### ScoringView

打分组件界面设置。

```objectivec
public class ScoringView: UIView {
    public var viewHeight: CGFloat = 120
    public var topSpaces: CGFloat = 0
    public var defaultPitchCursorX: CGFloat = 100
    public var standardPitchStickViewHeight: CGFloat = 3
    public var movingSpeedFactor: CGFloat = 120
    public var standardPitchStickViewColor: UIColor = .gray
    public var standardPitchStickViewHighlightColor: UIColor = .colorWithHex(hexStr: "#FF8AB4")
    public var localPitchCursorOffsetX: CGFloat = -3
    public var localPitchCursorImage: UIImage? = nil
    public var particleEffectHidden: Bool = false
    public var emitterImages: [UIImage]?
    public var hitScoreThreshold: Float = 0.7
}
```

- `viewHeight`：打分视图的高度。

- `topSpaces`：打分视图和 `KaraokeView` 顶部的距离。

- `defaultPitchCursorX`：游标出现的起始位置。

- `standardPitchStickViewHeight`：标准音高线的高度。

- `movingSpeedFactor`：标准音高线的移动速度。

- `standardPitchStickViewColor`：标准音高线默认的颜色。

- `standardPitchStickViewHighlightColor`：击中标准音高线时的颜色。

- `localPitchCursorOffsetX`：游标在 X 轴上的偏移量，游标的中心到竖线的 `centerX` 的距离。

  - 0：游标中心点和竖线中心点重合。
  - < 0：游标向左偏移。
 -  &gt; 0：游标向右偏移。

- `localPitchCursorImage`：自定义音高显示器样式。

- `particleEffectHidden`：是否隐藏粒子动画效果：

  - `true`：隐藏粒子动画效果。
  - `false`：（默认）不隐藏粒子动画效果。

- `emitterImages`：自定义粒子动画样式。

- `hitScoreThreshold`：动画效果阈值，取值范围为为 (0, 1]。例如，如果你将该值设为 0.1，则一行歌词得分超过 10 分，就会触发音高线着色和粒子动画效果。

### LyricToneModel

<a name="LyricToneModel"></a>

```objectivec
public class LyricToneModel: NSObject {
    @objc public let beginTime: Int
    @objc public let duration: Int
    @objc public var word: String
    @objc public let pitch: Double
}
```

一行歌词中，每一个词的音高数据。

- `beginTime`：歌词开始的时间，单位为毫秒。
- `duration`：歌词的总时长，单位为毫秒。
- `word`：歌词内容。
- `pitch`：该词的音高。

### ToneScoreModel

<a name="ToneScoreModel"></a>

```objectivec
public class ToneScoreModel: NSObject {
    @objc public let tone: LyricToneModel
    @objc public var score: Float
    var scores = [Float]()
}
```

歌词中每一个字的得分信息。

- `tone`：每一个字对应的音高信息，详见 [LyricToneModel](#LyricToneModel)。
- `score`：每一个字的得分，取值范围 [0, 100]。

### LyricModel
<a name="LyricModel"></a>

```objectivec
public class LyricModel: NSObject {
    @objc public var name: String
    @objc public var singer: String
    @objc public var lines: [LyricLineModel]
    @objc public var preludeEndPosition: Int
    @objc public var duration: Int
    @objc public var hasPitch: Bool
}
```

歌词数据模型。

- `name`：歌曲名称。

- `singer`：歌手。

- `lines`：歌词行数信息，详见 [LyricLineModel](#LyricLineModel)。

- `preludeEndPosition`：前奏结束的时间，单位为毫秒。

- `duration`：歌词总演唱时长，单位为毫秒。

- `hasPitch` ：该歌曲是否有标准音高线数据：

  - `true`：有标准音高线数据。

  - `false`：没有标准音高线数据。

### LyricLineModel

<a name="LyricLineModel"></a>

```objectivec
public class LyricLineModel: NSObject {
    @objc public var beginTime: Int
    @objc public var duration: Int
    @objc public var content: String
    @objc public var tones: [LyricToneModel]
}
```

歌词行的相关信息。

- `beginTime`：该行歌词开始的时间，单位为毫秒。
- `duration`：该行歌词的总时长，单位为毫秒。
- `content`：该行歌词的内容。
- `tones`：每一个词的音高信息，详见 [LyricToneModel](#LyricToneModel)。

### FirstToneHintViewStyle
<a name="FirstToneHintViewStyle"></a>

```objectivec
public class FirstToneHintViewStyle: NSObject {
    public var backgroundColor: UIColor = .gray
    public var size: CGFloat = 10
    public var bottomMargin: CGFloat = 0
}
```

等待圆点的风格设置。

- `backgroundColor`：等待圆点的颜色。
- `size`：等待圆点的半径（pt）。
- `bottomMargin`：等待圆点和歌词之间的间距。


### ConsoleLogger

```objective-c
public class ConsoleLogger: NSObject, ILogger {
    @objc public func onLog(content: String,
                            tag: String?,
                            time: String,
                            level: LoggerLevel)
}
```

实现 `ILogger` 协议的日志记录器，用于将消息打印到控制台。

**参数**

- `content`：要记录的日志内容。
- `tag`：日志标签（可选参数），用于进一步分类或标识日志。
- `time`：日志记录的时间。
- `level`：日志的级别，详见 [LoggerLevel](#LoggerLevel)。

### FileLogger

```objective-c
public class FileLogger: NSObject, ILogger {
    @objc public func onLog(content: String,
                            tag: String?,
                            time: String,
                            level: LoggerLevel) {
    }
}
```
实现 `ILogger` 协议的日志记录器，用于将日志信息写入日志文件。

- `onLog`：日志文件的回调。
  - `content`：要记录的日志内容。
  - `tag`：日志标签（可选参数），用于进一步分类或标识日志。
  - `time`：日志记录的时间。
  - `level`：日志的级别，详见 [LoggerLevel](#LoggerLevel)。

## Enum

### LoggerLevel

<a name="LoggerLevel"></a>

```objectivec
public enum LoggerLevel: UInt8, CustomStringConvertible {case debug, info, warning, error}
```

日志等级。

- `debug`：调试级别。
- `info`: 信息级别。
- `warning`: 警告级别。
- `error`: 错误级别。