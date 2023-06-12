声网歌词打分组件（KaraokeView）包含歌词组件（LyricView）和打分组件（ScoringView）。在 K 歌房场景中，你可以通过歌词组件实现歌曲播放时歌词同步展示以及自定义歌词界面，通过打分组件实现根据当前播放进度展示对应的原唱音准线、展示演唱者和原唱音准线的匹配效果、演唱者的分数、自定义打分逻辑以及评分组件界面。

本文介绍如何在项目中集成并使用声网歌词组件。

## 功能描述

- 歌曲播放时，根据当前播放进度显示对应的歌词，支持显示逐字（XML）或逐句（LRC）的歌词；当拖动到指定时间的歌词时，歌曲进度随之改变。
- 自定义歌词界面，包括歌词颜色、行间距、字体大小等界面元素。
 <img src="https://web-cdn.agora.io/docs-files/1652093851887" style="zoom:50%;" />

## 前提条件

在使用歌词组件前，请确保你已在项目中集成声网视频 SDK v4.x，并实现在线 K 歌功能，详见[客户端实现](https://docs.agora.io/cn/online-ktv/chorus_client_android?platform=Android)。

## 实现方法

本节介绍如何实现歌词组件的基础及进阶功能。

### 集成歌词组件

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
       implementation 'com.github.AgoraIO-Community:LyricsView:1.1.1-beta.7'
   }
   ```

### 基础功能

#### 歌词显示及同步

参考如下歌词组件 API 使用时序图，实现歌词显示及同步功能：

【时序图】

<div class="alert note"> 由于 Android UI 系统限制，以上 API 的调用顺序必须严格按照 API 时序图顺序，且必须在 UI 线程中调用，否则会导致 App 崩溃。</div>

1. **声明和初始化歌词组件对象**

   在项目的 Activity 中，声明和初始化歌词组件对象。示例代码如下：
   
   ```java
   public class LiveActivity extends RtcBaseActivity {
       private LyricsView mLyricsView;
       //private ScoringView mScoringView;
   
       private KaraokeView mKaraokeView;
   
       private MockRtcEngineWithPlayer mMockRtcWithPlayer;
   
       @Override
       protected void onCreate(Bundle savedInstanceState) {
           ...
           mLyricsView = findViewById(R.id.lyrics_view);
           //mScoringView = findViewById(R.id.scoring_view);
       }
   }
   ```

2. **创建 `KaraokeView` 对象**

   在调用 `KaraokeView` 类下的 API 前，你需要确保已创建一个 `KaraokeView` 对象。

   ```java
   mKaraokeView = new KaraokeView(mLyricsView, //mScoringView);
   // 添加日志记录器来记录 KaraokeView 的运行状态以及相关的调试信息。
   LogManager.instance().addLogger(new YourLogger() {
   });
   ```

3. **设置歌词事件回调**

   通过 `setKaraokeEvent` 方法来设置歌词事件回调，当拖动歌词视图时会触发 `onDragTo` 回调报告拖动之后歌词的位置。

   ```java
   mKaraokeView.setKaraokeEvent(new KaraokeEvent() {
               @Override
               public void onDragTo(KaraokeView view, long position) {
                   // 把拖动后歌曲的播放进度设置给歌词组件，用于歌词同步显示。
                   mKaraokeView.setProgress(position);
               }
   
               // @Override
               // public void onRefPitchUpdate(float refPitch, int numberOfRefPitches) {
               //    ...
               //}
   
               //@Override
               //public void onLineFinished(KaraokeView view, LyricsLineModel line, int score, int cumulatedScore, int index, int total) {
                   //...
               //}
           });
   ```

4. **解析歌词**

   调用 `parseLyricData` 方法解析歌词，然后通过 `setLyricsData` 方法将解析后的歌词数据模型设置给 `KaraokeView` 对象以便后续的歌词展示。歌词数据模型中包含了歌曲类型、歌词类型、歌曲时长、前奏时长、歌曲名和演唱者等信息。

   ```java
   // java
   mLyricsModel = KaraokeView.parseLyricsData(file);
   if (mLyricsModel != null) {
   mKaraokeView.setLyricsData(mLyricsModel);
   }
   ```


5. **歌词同步**

   当播放器开始播放歌曲后，你可以通过 `getPosition` 获取歌曲当前的播放进度，然后通过 `setProgress` 来把歌词的播放进度设置给歌词组件，从而实现歌词同步。

   声网歌词组件还支持歌词拖动，当拖动到指定时间的歌词时，歌曲进度随之改变。当你设置允许歌词拖动后（即 `enableDragging` 设为 `true`），SDK 会触发 `onDragTo` 回调报告歌词拖动后的位置，然后你需要调用 `setProgress` 方法同步此时歌曲的播放位置给歌词组件，从而实现歌词同步。【sample code needs to be provided】

   ```java
   mMockRtcWithPlayer = new MockRtcEngineWithPlayer(new PlayerEvent() {
               @Override
               public void onPlayPosition(long position) {
                   // This will drive KaraokeView running, must be stable and smooth
                   // Usually use a standalone thread
                   mKaraokeView.setProgress(position);
               }
   
               // @Override
               // public void onLocalPitch(int pitch) {
                   // This will drive the scoring and display of all effects 
                   // mKaraokeView.setPitch(pitch);
               }
           });
   ```

6. **重置**

   当一首歌结束播放或需要中途切换为另外一首歌曲播放时，需要调用 `reset` 方法来重新设置歌词。

   ```java
   // java
   mKaraokeView.reset();
   ```

### 进阶功能

#### 自定义歌词组件界面

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
    // 当前歌词行的文字颜色
    app:currentTextColor="@color/ktv_lrc_current"
    // 当前歌词行的字体大小
    app:currentTextSize="26sp"
    // 当前行歌词高亮颜色
    app:currentHighlightedTextColor="@color/ktv_lrc_highlight"
    // 歌词行间距
    app:lineSpacing="20dp"
    // 设置无歌词时显示的提示文字
    app:labelWhenNoLyrics="暂无歌词"
    // 已播放的歌词文字颜色
    app:pastTextColor="@color/ktv_lrc_nomal"
    // 即将播放的歌词文字颜色【是指下一行还是所有未播放的歌词】
    app:upcomingTextColor="@color/ktv_lrc_nomal"
    // 歌词字体大小
    app:normalTextSize="16sp"
    // 歌词文字对齐方式
    app:textGravity="center"/>
```

## 相关信息

本节提供其他相关信息供参考。

### 集成歌词组件的其他方法

**手动集成歌词组件**

1. [下载]()最新版本的歌词组件。

2. 打开下载文件，将 `lrcview` 文件夹拷贝至你的项目文件夹下。

3. 在你的项目中引入 `lrcview` 控件。

   a. 打开你项目的 `settings.gradle` 文件，在该文件中添加如下代码：

   ```java
   include ':lrcview'
   ```

   b. 打开你项目的 `app/build.gradle` 文件，在该文件中添加如下代码以添加 `karaoke_view` 控件的依赖项：

   ```java
   dependencies {
       ...
       implementation project(':lrcview')
   }
   ```

### 示例项目

声网在 GitHub 上提供歌词组件开源的[示例项目](https://github.com/AgoraIO-Community/LyricsView)供你参考。

### 参考文档

- [歌词组件 API 文档]()
- 评分组件