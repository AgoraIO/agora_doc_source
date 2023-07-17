本文提供在线 K 歌房歌词评分组件相关 API。

<div class="alert note">本文仅适用于歌词评分组件 v1.1.1。</div>

## KaraokeView

歌词评分组件的基础接口类，实现歌词同步、演唱评分的主要功能。

<div class="alert note">请确保在主线程中调用该类下的 API。</div>

### KaraokeView

创建 `KaraokeView` 实例。

```java
public KaraokeView(LyricsView lyricsView, ScoringView scoringView);
```

**参数**

- `lyricsView`：用于显示歌词的 `LyricsView` 对象。
- `scoringView`：用于显示评分的 `ScoringView` 对象。


### parseLyricsData

解析歌词文件数据。

```java
public static LyricsModel parseLyricsData(File file);
```

**参数**

- `file`：要解析的歌词文件，如 XML 文件、LRC 文件的二进制数据。

**返回值**

- 方法调用成功时返回一个 `LyricModel` 对象，包含解析后的歌词数据模型。
- 方法调用失败时返回 `null`。

### setLyricsData

设置歌词数据模型。

```java
public void setLyricsData(LyricsModel model);
```

该方法用于设置歌词数据模型，在调用该方法前，你需要先调用 `parseLyricsData` 方法解析歌词数据并获取相应的歌词数据模型对象以便于歌词显示。

**参数**

- `model`：[LyricsModel](#LyricsModel) 对象，表示歌词数据模型，包含歌曲的基本信息、歌词信息等。如果传入 `null`，表示当前歌曲为纯音乐，没有对应的歌词信息。

### reset

重置歌词及评分设置。

```java
public void reset();
```

当一首歌曲播放完毕，或在播放过程中切到另外一首歌曲时，需要调用该方法来重置歌词、评分设置。


**参数**

- `lyrics`：要添加的 `LyricsView` 对象，用于显示歌词。若传入 `null`，表示不添加歌词视图。
- `scoring`：要添加的 `ScoringView` 对象，用于显示评分。若传入 `null`，表示不添加评分视图。


### setProgress

把歌曲当前的播放进度同步给歌词、评分组件。

```java
public void setProgress(long progress);
```

在实现歌词和歌曲播放同步时，你需要调用该方法来将歌曲当前的播放进度设置给 `KaraokeView`，以便 `KaraokeView` 根据当前歌曲的播放位置显示对相应的歌词。

调用该方法前你需要先通过内置媒体播放器的 [getPlayPosition](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/java_ng/API/toc_mediaplayer.html#api_imediaplayer_getplayposition) 方法获取歌曲当前的播放进度。声网建议你每 20 ms 调用一次该方法来把歌曲的播放进度同步给歌词评分组件。

**参数**

- `progress`：歌曲的播放进度，单位为 ms。

### setPitch

把获取的实时人声音调同步给评分组件。

```java
public void setPitch(float pitch);
```

当你通过 `IRtcEngineEventHandler` 下的 [onAudioVolumeIndication](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/java_ng/API/toc_audio_process.html?platform=Android#callback_irtcengineeventhandler_onaudiovolumeindication) 获取本地用户的人声音调后，你需要调用该方法把获取到的实时人声音调同步给评分组件用于演唱评分。

**参数**

- `pitch`：用户的实时人声音调。

### setKaraokeEvent

设置歌词评分组件事件回调。

```java
public void setKaraokeEvent(KaraokeEvent event);
```

在调用该方法前，请确保已初始化 `KaraokeView` 对象。

**参数**

- `event`：歌词评分组件事件，详见 [KaraokeEvent](#KaraokeEvent)。

### setScoreAlgorithm

自定义评分算法。

```java
public void setScoringAlgorithm(IScoringAlgorithm algorithm);
```

如果你不想使用评分组件默认的评分算法，你可以通过该方法来自定义评分算法。你自定义的评分算法对象应实现 `IScoringAlgorithm` 接口。

**参数**

- `algorithm`：实现了 [IScoringAlgorithm](#IScoringAlgorithm) 接口的评分算法对象。

### setScoringLevel

设置得分的难易等级。

```java
public void setScoringLevel(int level);
```

你可以通过该方法来设置演唱者得分的难易等级。

**参数**

- `level`：难度等级，取值范围为 [0,100]，默认值为 10。值越小表示难度等级越低，演唱者越容易得分。

你可以参考下表来设置不同难度：

| 难度     | 推荐取值 |
| :------- | :------- |
| 低难度   | 3        |
| 中低难度 | 10       |
| 中等难度 | 17       |
| 中高难度 | 25       |
| 高难度   | 35       |

### getScoringLevel

获取得分的难易等级。

```java
public int getScoringLevel();
```

当你调用 `setScoringLevel` 设置得分的难易程度后，可以调用该方法来获取当前你设置的得分难易程度。

**返回值**

- *≥* 0：方法调用成功，返回当前设置的得难易值。
- < 0：方法调用失败。

### setScoringCompensationOffset

调整演唱评分结果。

```java
public void setScoringCompensationOffset(int offset);
```

如果你的业务场景对演唱分数有特殊要求，你可以调用此方法来调整演唱评分的结果。

**参数**

- `offset`：额外增加或减少的分数，取值范围为 [-100, 100]，默认值为 0。

声网不建议你同时使用 `setScoringLevel` 和 `setScoreCompensationOffset` 来调整评分机制。

### getScoringCompensationOffset

获取调整后的分数结果。

```java
public int getScoringCompensationOffset();
```

当你调用 `setScoringCompensationOffset` 方法调整演唱评分的结果后，你可以调用过该方法来获取调整后的分数结果。

**返回值**

- 调整后的分数结果。

## KaraokeEvent

<a name="KaraokeEvent"></a>

`KaraokeView` 的核心事件回调。

### onDragTo

歌词拖动结束的回调。

```java
public void onDragTo(KaraokeView view, long position);
```

如果你设置允许歌词拖动（将 `enableDragging` 设为 `true`），当歌词拖动结束后会触发此回调。你可以通过该回调获取歌词拖动后对应的播放位置。

**参数**

- `view`：`KaraokeView` 实例。
- `position`：歌词拖动后对应的歌曲播放位置，单位为毫秒。

### onLineFinished

一行歌词播放完毕回调。

```java
public void onLineFinished(KaraokeView view, LyricsLineModel line, int score, int cumulativeScore, int index, int total);
```

当一行歌词播放完毕后，会触发该回调报告当前行的歌词的得分、累计得分等信息。

**参数**

- `view`：`KaraokeView` 实例。
- `line`：当前歌词行的信息，详见 [LyricsLineModel](#LyricsLineModel)。
- `score`：当前歌曲行的得分，取值范围 [0, 100]。
- `cumulativeScore`：当前累计得分。
- `Index`：歌词行数的索引号，最小值为 0。
- `total`：歌词的总行数。

### onRefPitchUpdate

歌词标准音高值回调。

```java
public void onRefPitchUpdate(float refPitch, int numberOfRefPitches);
```

歌词中每一个字都有自己的音符（tone），代表一个单独的音高值。SDK 会在播放到歌词的每一个字时触发该回调，报告当前音符的音高值，以及整首歌歌词中音符的个数。


**参数**

- `refPitch`：当前音符的音高值。
- `numberOfRefPitches`：整首歌歌词中音符的个数。如果你是想要自定义评分算法，你可以通过该参数来在 app 层计算一首歌演唱的平均分。

## ScoringView

该类提供评分组件的核心 API。

### setRefPitchStickDefaultColor

设置标准音高线的颜色。

```java
public void setRefPitchStickDefaultColor(int color);
```

**参数**

- `color`：标准音高线的颜色。

### setRefPitchStickHighlightedColor

设置人声音调与标准音高线匹配后，音高线的颜色。

```java
public void setRefPitchStickHighlightedColor(int color);
```

**参数**

- `color`：标准音高线的颜色。

### setRefPitchStickHeight

设置标准音高线的高度。

```java
public void setRefPitchStickHeight(float height);
```

**参数**

- `height`：标准音高线的高度，默认值为 6 dp。

### enableParticleEffect

设置是否开启粒子动画效果。

```java
public void enableParticleEffect(boolean enable);
```

粒子动画可以在歌词或背景等区域中播放，以呈现各种漂亮、流畅且动感的效果，与歌声的节奏和音调进行同步。

**参数**

- `enable`：
  - `true`：（默认）开启粒子动画效果。
  - `false`：关闭粒子动画效果。

<div class="alert info">该方法可能会消耗较多系统性能，声网建议不要频繁调用该方法。</div>

### setParticles

自定义粒子动画样式。

```java
public void setParticles(Drawable[] particles);
```

如果你不想使用声网默认的粒子动画样式，你可以调用该方法来自定义粒子动画样式。在调用该方法前，请确保你已经开启粒子动画效果，即 `enableParticleEffect` 设为 `true`。

**参数**

- `particles`：自定义粒子动画样式的对象。

<div class="alert info">该方法可能会消耗较多系统性能，声网建议不要频繁调用该方法。</div>

### setLocalPitchIndicator

设置本地音高指示器的样式。

```java
public void setLocalPitchIndicator(Bitmap bitmap);
```

该方法用于设置本地音高指示器的样式，以可视化地表示当前音高值，并显示实时的音高的变化，帮助演唱者对自己的声音进行调准和校正。

**参数**

- `bitmap`：音高指示器的位图图像。如果你不想显示音高指示器，传入 `null`。

### reset

重置评分组件。

```java
public void reset();
```

当一首歌曲播放完毕后或是播放过程中切到另外一首歌曲时，需要调用该方法来重置评分设置。

## LyricsView

该类提供歌词组件的核心 API。

### enableDragging

设置是否允许歌词拖动。

```java
public void enableDragging(boolean enable);
```

**参数**

- `enable`：是否允许拖动歌词：
  - `true`：允许拖动歌词。
  - `false`：不允许拖动歌词。

### setInactiveLineTextColor

设置未在当前播放的歌词的颜色。

```java
public void setInactiveLineTextColor(@ColorInt int color) {}
```

**参数**

- `color`：未在当前播放的歌词的颜色。

### setTextSize

设置未在当前播放的歌词文字大小。

```java
public void setTextSize(float size) {}
```

**参数**

- `size`：歌词文字大小，单位为 pixel。

### setActiveLinePlayedTextColor

设置当前歌词行中，已播放的歌词的颜色。

```java
public void setActiveLinePlayedTextColor(@ColorInt int color) {}
```

**参数**

- `color`：歌词的颜色。

### setActiveLineUpcomingTextColor

设置当前歌词行中，待播放的歌词的颜色。

```java
public void setActiveLineUpcomingTextColor(@ColorInt int color) {}
```

**参数**

- `color`：歌词的颜色。

### setCurrentLineTextSize

设置当前播放的歌词行的文字大小。

```java
public void setCurrentLineTextSize(float size) {}
```

**参数**

- `size`：歌词文字大小，单位为 pixel。

### setLabelShownWhenNoLyrics

设置无歌词时显示的提示文字。

```java
public void setLabelShownWhenNoLyrics(String label);
```

**参数**

- `label`：提示文字的内容。

### setLabelShownWhenNoLyricsTextSize

设置无歌词显示时，提示文字的大小。

```java
public void setLabelShownWhenNoLyricsTextSize(float size);
```

**参数**

- `size`：歌词文字大小，单位为 pixel。

### setLabelShownWhenNoLyricsTextColor

设置无歌词显示时，提示文字的颜色。

```java
public void setLabelShownWhenNoLyricsTextColor(@ColorInt int color);
```

**参数**

- `color`：文字的颜色。

### enableStartOfVerseIndicator

在播放歌曲前奏时是否显示等待圆点。

```java
public void enableStartOfVerseIndicator(boolean enable);
```

等待圆点是在播放器播放前奏时，歌词视图中显示一个提示，让用户知道何时应该开始唱歌。

**参数**

- `enable`：是否显示等待圆点：
  - `true`：（默认）显示等待圆点。
  - `false`：不显示等待圆点。

### setStartOfVerseIndicatorPaddingTop

设置等待圆点和歌词组件顶部之间的距离。

```java
public void setStartOfVerseIndicatorPaddingTop(float paddingTop);
```

调用该方法前，请确保 `enableStartOfVerseIndicator` 为 `true`。

**参数**

- `paddingTop`：等待圆点和歌词组件顶部之间的距离，默认为 8 dp。

### setStartOfVerseIndicatorRadius

设置等待圆点的半径大小。

```java
public void setStartOfVerseIndicatorRadius(float radius);
```

调用该方法前，请确保 `enableStartOfVerseIndicator` 为 `true`。

**参数**

- `radius`：等待圆点的半径，默认值 6 dp。

### setStartOfVerseIndicatorColor

设置等待圆点的颜色。

```java
public void setStartOfVerseIndicatorColor(int color);
```

调用该方法前，请确保 `enableStartOfVerseIndicator` 为 `true`。

**参数**

- `color`：等待圆点的颜色。

### reset

重置歌词组件。

```java
public void reset();
```

当一首歌曲播放完毕后或是播放过程中切到另外一首歌曲时，需要调用该方法来重置歌词设置。

## IScoringAlgorithm
<a name="IScoringAlgorithm"></a>

该类提供自定义评分相关的 API。

### getLineScore

获取当前行歌词的演唱得分。

```java
int getLineScore(LinkedHashMap<Long, Float> pitchesForLine, final int indexOfLineJustFinished, final LyricsLineModel lineJustFinished);
```

当用户唱完一句歌词后，你可以调用该方法来自定义计算该行歌词的得分。

**参数**

- `pitchesForLine`：标准音高值。
- `indexOfLineJustFinished`：歌词行的索引号。
- `lineJustFinished`：当前歌词行的相关信息，详见 [LyricsLineModel](#LyricsLineModel)。

## Logger

该接口类提供日志相关的 API。

### onLog

`KaraokeView` 的日志回调。

```java
void onLog(int level, String tag, String message);
```

你可以通过该回调来了解日志的相关内容，可用于排查问题。

**参数**

- `level`：日志的级别：
  -`2`：详细的日志信息。
   -`3`：调试级别的日志信息。
   -`4`：一般信息级别的日志信息。
   -`5`：警告级别的日志信息，表示可能存在的问题或潜在的错误。
   -`6`：错误级别的日志信息，表示出现了错误或异常情况。
   -`7`：中断级别的日志，表示出现了不可恢复的错误。

- `tag`：日志标签，用于进一步分类或标识日志。
- `message`：日志的具体内容，包含了要输出的信息。


## 普通类

### LyricsLineModel

<a name="LyricsLineModel"></a>

```java
public class LyricsLineModel {
    public static class Tone {
    public long begin;
    public long end;
    public String word;
    public int pitch = 0;

    public long getDuration() {
        return end - begin;
    }
    }

    public List<Tone> tones;
    public long getStartTime() {}
    public long getEndTime() {}
}
```

当前行的歌词的相关信息。

- `Tone`：当前音符的信息。
  - `begin`：音符开始的时间，单位为毫秒。
  - `end`：音符结束的时间，单位为毫秒。
  - `word`：音符对应的文字。
  -  `pitch`：音符对应的音高值。
  - `getDuration`：获取当前音符从开始到结束的时间。
    - 返回值：当前音符从开始到结束的时间，单位为毫秒。


- `tones`：一行歌词里面包含的音符（tone）的个数。
- `getStartTime`：获取一行歌词开始的时间。
  - 返回值：当前行歌词开始的时间，单位为毫秒。
- `getEndTime`：获取一行歌词结束的时间。
  - 返回值：当前行歌词结束的时间，单位为毫秒。

### LyricsModel

<a name="LyricsModel"></a>

```java
public class LyricsModel {
    public List<LyricsLineModel> lines;
    public long duration;
    public long startOfVerse;
    public String title;
    public String artist;
}
```

歌词的数据模型。

- `lines`：当前行的歌词的相关信息，详见 [LyricsLineModel](#LyricsLineModel)。
- `duration`：歌词总演唱时长，单位为毫秒。
- `startOfVerse`：前奏结束的时间，单位为毫秒。
- `title`：歌曲名称。
- `artist`：歌手。