声网歌词打分组件（KaraokeView）包含歌词组件（LyricsView）和打分组件（ScoringView）。在 K 歌房场景中，你可以通过歌词组件实现歌曲播放时歌词同步展示以及自定义歌词界面，通过打分组件实现根据当前播放进度展示对应的原唱音准线、展示演唱者和原唱音准线的匹配效果、演唱者的分数、自定义打分逻辑以及评分组件界面。

本文介绍如何在项目中集成并使用声网歌词组件。

<div class="alert note">本文仅适用于歌词打分组件 v1.1.1。</div>

## 功能描述

歌词组件：

- 歌曲播放时，根据当前播放进度显示对应的歌词，支持显示逐字（XML）或逐句（LRC）的歌词；当拖动到指定时间的歌词时，歌曲进度随之改变。
- 自定义歌词界面，包括歌词颜色、行间距、字体大小等界面元素。

打分组件：

- 将演唱者和歌曲原唱的音调进行对比，并实时将匹配度以动画和分数的方式呈现在界面上。
- 自定义打分逻辑和界面显示，如音准线的颜色、粒子动画效果、游标样式等。

<img src="https://web-cdn.agora.io/docs-files/1687162089264" style="zoom:60%;" />

## 前提条件

在使用歌词组件前，请确保你已在项目中集成声网视频 SDK v4.x，并实现在线 K 歌功能，详见[客户端实现](https://docs.agora.io/cn/online-ktv/chorus_client_android?platform=Android)。

参考以下步骤来使用 JitPack 自动集成歌词组件。

1. 如果未添加 JitPack，请在 `/Gradle Scripts/build.gradle(Project: <projectname>)` 中添加如下代码，将 JitPack 添加到仓库列表中：

   ```java
   all projects {
           repositories {
           ...
           maven { url 'https://www.jitpack.io' }
           }
   }
   ```

2. 在 `/Gradle Scripts/build.gradle(Module: <projectname>.app)` 中，添加如下代码，将歌词组件集成到你的项目中：

   ```java
   ...
   dependencies {
       ...
       implementation 'com.github.AgoraIO-Community:LyricsView:1.1.1'
   }
   ```

## 实现歌词组件

本节介绍如何实现歌词组件。

参考如下歌词打分组件的 API 调用时序图：

![](https://web-cdn.agora.io/docs-files/1687164357039)

### 声明和初始化

在项目的 Activity 中，声明和初始化歌词、打分组件对象。示例代码如下：

```java
public class LiveActivity extends RtcBaseActivity {
    private LyricsView mLyricsView;
    private ScoringView mScoringView;

    private KaraokeView mKaraokeView;

    private MockRtcEngineWithPlayer mMockRtcWithPlayer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        ...
        mLyricsView = findViewById(R.id.lyrics_view);
        mScoringView = findViewById(R.id.scoring_view);
    }
}
```

### 创建 `KaraokeView` 对象

在调用 `KaraokeView` 类下的 API 前，你需要创建一个 `KaraokeView` 对象。

```java
mKaraokeView = new KaraokeView(mLyricsView, mScoringView);
// 添加日志记录器来记录 KaraokeView 的运行状态以及相关的调试信息。
LogManager.instance().addLogger(new YourLogger() {
});
```

### 实现歌词事件回调

通过 `setKaraokeEvent` 方法来设置歌词事件回调，当拖动歌词视图时会触发 `onDragTo` 回调报告拖动之后歌词的位置。

```java
mKaraokeView.setKaraokeEvent(new KaraokeEvent() {
    @Override
    public void onDragTo(KaraokeView view, long position) {
        // 把拖动后歌曲的播放进度同步给歌词组件，用于歌词同步显示。
        mKaraokeView.setProgress(position);
        // 调整播放器的播进度至相应的播放位置。
        mMockRtcWithPlayer.seekTo(position);
    }
});
```

### 歌词显示及同步

1. **解析歌词**

   调用 `parseLyricsData` 方法解析歌词，然后通过 `setLyricsData` 方法将解析后的歌词数据模型设置给 `KaraokeView` 对象以便后续的歌词展示。歌词数据模型中包含了歌曲类型、歌词类型、歌曲时长、前奏时长、歌曲名和演唱者等信息。

   ```java
   mLyricsModel = KaraokeView.parseLyricsData(file);
   if (mLyricsModel != null) {
       mKaraokeView.setLyricsData(mLyricsModel);
   }
   ```


2. **歌词同步**

   当播放器开始播放歌曲后，你可以通过内置媒体播放器的 [getPlayPosition](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/java_ng/API/toc_mediaplayer.html?platform=Android#api_imediaplayer_getplayposition) 获取歌曲当前的播放进度，然后通过 `setProgress` 来把歌词的播放进度设置给歌词组件，从而实现歌词同步。

   声网歌词组件还支持歌词拖动，当拖动到指定时间的歌词时，歌曲进度随之改变。当你设置允许歌词拖动后（即 `enableDragging` 设为 `true`），SDK 会触发 `onDragTo` 回调报告歌词拖动后的位置，然后你需要调用 `setProgress` 方法同步此时歌曲的播放位置给歌词组件，从而实现歌词同步。

    <div class="alert info">为保证歌词 UI 界面的流畅性，声网建议调用 <code>setProgress</code> 方法的时间间隔不超过 20 ms。</div>

   ```java
   mMockRtcWithPlayer = new MockRtcEngineWithPlayer(new PlayerEvent() {
       @Override
       public void onPlayPosition(long position) {
           mKaraokeView.setProgress(position);
       }
   });
   ```

3. **重置**

   当一首歌结束播放或需要中途切换为另外一首歌曲播放时，需要调用 `reset` 方法来重新设置歌词。

   ```java
   mKaraokeView.reset();
   ```

### 自定义歌词组件界面

如果对歌词组件的用户界面有更高要求，你可以自定义歌词组件的歌词颜色、行间距、字体大小等界面元素。你可以参考如下示例代码，在你项目的 Activity 中，自定义歌词组件的界面元素：

```java
<io.agora.karaoke_view.v11.LyricsView
    android:id="@+id/lyrics_view"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:paddingStart="10dp"
    android:paddingTop="20dp"
    android:paddingEnd="10dp"
    android:paddingBottom="20dp"
    // 歌词行间距
    app:lineSpacing="20dp"
    // 设置无歌词时显示的提示文字
    app:labelWhenNoLyrics="暂无歌词"
    // 歌词文字对齐方式
    app:textGravity="center"/>
```

<div class="alert info">你还可以通过 <a href="https://docportal.shengwang.cn/cn/online-ktv/lyrics_scores_android?platform=Android#lyricsview">LyricsView</a> 类下的 API 来自定义更多界面元素。</div>

## 实现打分组件

### 同步人声音调

当演唱者开始唱歌，你可以通过 `RtcEngine` 下的 [onAudioVolumeIndication](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/java_ng/API/toc_audio_process.html?platform=Android#callback_irtcengineeventhandler_onaudiovolumeindication) 来获取本地用户的人声音调，然后通过 `setPitch` 来将用户实时的人声音调同步给打分组件。

```java
mKaraokeView.setPitch(pitch);
```

### 实现打分事件回调

实现 `KaraokeEvent` 并设置打分事件回调。设置回调后，SDK 会在播放到歌词的每一个字时触发 `onRefPitchUpdate` 回调，报告当前音符的音高值，以及整首歌歌词中音符的个数。当前行歌词播放完后会触发 `onLineFinished` 回调报告当前行歌词的演唱得分和累计得分。

```java
mKaraokeView.setKaraokeEvent(new KaraokeEvent() {
    @Override
    public void onRefPitchUpdate(float refPitch, int numberOfRefPitches) {
    }

    @Override
    public void onLineFinished(KaraokeView view, LyricsLineModel line, int score, int cumulatedScore, int index, int total) {
    }
});
```

### 自定义打分偏好

如果默认的打分算法无法满足你的需求，声网还支持自定义打分偏好。

**设置得分难易程度**

调用 `setScoringLevel` 来设置演唱者得分的难易程度。你可以通过 `level` 参数来调节难易程度，取值范围为 [0,100]，默认值为 10。值越小难度越低，演唱者越容易得分。你也可以参考[不同难度的推荐取值](https://docportal.shengwang.cn/cn/online-ktv/lyrics_scores_android?platform=Android#setscorelevel)来进行设置。

```java
mKaraokeView.setScoringLevel(10);
```

**调整分数**

如果你的业务场景对演唱分数有特殊要求，你还可以调用 `setScoreCompensationOffset` 调整分数结果。取值范围为 [-100, 100]，默认值为 0。

例如，如果你将 `offset` 参数设为 `10`，则每一句歌词演唱完后，SDK 会在原有得分基础上增加 10 分，如果设为 `-10`，则会在原有基础上减 10 分。

```java
mKaraokeView.setScoringCompensationOffset(0);
```

<div class="alert info">声网不建议你同时使用 <code>setScoreLevel</code> 和 <code>setScoreCompensationOffset</code> 来调整打分逻辑。</div>

**设置动画效果阈值**

动画效果阈值决定了何时触发音高线着色和粒子动画的显示并对 UI 界面产生影响。你可以通过 `hitScoreThreshold` 来调整动画效果阈值，值越小越容易触发音高线着色和粒子动画。取值范围为 (0, 1]，默认值为 0.7。例如，如果你将该值设为 0.1，则一行歌词得分超过 10 分，就会触发音高线着色和粒子动画。

```java
<io.agora.karaoke_view.v11.ScoringView
    android:id="@+id/scoring_view"
    app:hitScoreThreshold="0.7"
/>
```

**自定义打分算法**

你还可以根据你的业务需求自定义打分算法。你需要实现 `IScoreAlgorithm` 接口类并创建一个新的 `ScoreAlgorithm` 分数计算实例。

```java
public class MyScoringAlgorithm implements IScoringAlgorithm {
    // 每一行歌词的最高得分
    private final int mMaximumScoreForLine = 100;

    private ScoringMachine.OnScoringListener mListener;

    // 得分的难易程度
    private int mScoringLevel = 10; 
    // 调整得分结果
    private int mScoringCompensationOffset = 0; 

    public MyScoringAlgorithm() {
    }
    // 获取歌词行的评分
    @Override
    public int getLineScore(final LinkedHashMap<Long, Float> pitchesForLine, final int indexOfLineJustFinished, final LyricsLineModel lineJustFinished) {
        ...
    }
}
```

### 自定义打分组件界面

你可以自定义打分组件的游标样式、标准音高线的颜色、粒子动画效果等界面元素。

**自定义标准音高线**

```java
<io.agora.karaoke_view.v11.ScoringView
    android:id="@+id/scoring_view"
    // 设置标准音高线的高度
    app:pitchStickHeight="4dp"
    // 设置标准音高线匹配后的颜色
    app:pitchStickHighlightedColor="@color/pink_b4"
  />
```

**自定义粒子动画效果**

粒子动画可以在歌词或背景等区域中播放，以呈现各种漂亮、流畅且动感的效果，与歌声的节奏和音调进行同步。

你可以根据自己的需求自定义粒子动画的样式，或者重写 `initParticleSystem` 来控制粒子动画行为：

```java
// 自定义粒子动画效果
mScoringView.setParticles(Drawable[] ...);
```

```java
public class MyScoringView extends ScoringView {

    @Override
    public void initParticleSystem(Drawable[] particles) {
        // 导入 Leonids 库，该库提供了丰富的配置选项，你可以轻松创建各种粒子效果，包括粒子的形状、颜色、运动轨迹等。
        mParticlesPerSecond = 16;
        particles = {..., ..., ...}

        mParticleSystem = new ParticleSystem((ViewGroup) this.getParent(), particles.length * 6, particles, 900);
        mParticleSystem.setRotationSpeedRange(90, 180)
                .setScaleRange(0.7f, 1.6f)
                .setSpeedModuleAndAngleRange(0.10f, 0.20f, 120, 240)
                .setFadeOut(300, new AccelerateInterpolator());
    }

}
```

你也可以调用 `enableParticleEffect` 并将 `enable` 设为 `false` 来关闭组件默认的粒子动画效果，然后实现你自己的动画效果：

```java
mScoringView.enableParticleEffect(false);
```

<div class="alert info">你还可以通过 <a href="https://docportal.shengwang.cn/cn/online-ktv/lyrics_scores_android?platform=Android#scoringview">ScoringView</a> 类下的 API 来自定义更多界面元素。 </div>

## 相关信息

本节提供其他相关信息供参考。

### 集成歌词组件的其他方法

**手动集成歌词组件**

1. [下载](https://github.com/AgoraIO-Community/LyricsView/tree/main)最新版本的歌词组件。

2. 打开下载文件，将 `karaoke_view` 文件夹拷贝至你的项目文件夹下。

3. 在你的项目中引入 `karaoke_view` 控件。

   a. 打开你项目的 `settings.gradle` 文件，在该文件中添加如下代码：

   ```java
   include ':karaoke_view'
   ```

   b. 打开你项目的 `app/build.gradle` 文件，在该文件中添加如下代码以添加 `karaoke_view` 控件的依赖项：

   ```java
   dependencies {
       ...
       implementation project(':karaoke_view')
   }
   ```

### 示例项目

声网在 GitHub 上提供歌词组件开源的[示例项目](https://github.com/AgoraIO-Community/LyricsView/tree/main)供你参考。

### 参考文档

[歌词打分组件 API 文档](/cn/online-ktv/lyrics_scores_android?platform=Android)