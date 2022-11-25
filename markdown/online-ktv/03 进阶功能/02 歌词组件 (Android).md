Agora 歌词组件支持在歌曲播放时同步显示 LRC 或 XML 格式的歌词，同时支持将演唱者和歌曲原唱的音调进行对比，并实时将匹配度以动画和分数的方式呈现在界面上。

本文介绍如何在项目中集成并使用 Agora 歌词组件。

<img src="https://web-cdn.agora.io/docs-files/1652093851887" style="zoom:80%;" />

## 功能描述

### 歌词展示与同步

- 歌曲播放时，根据当前播放进度显示对应的歌词，当手势拖动到指定时间的歌词，歌曲进度随之改变。
- 自定义歌词视图和歌词背景图。

### 歌唱音准和评分

- 歌曲播放时，根据当前播放进度展示对应的原唱音准线。
- 实时展示演唱者和原唱音准线的匹配效果，以及演唱者的分数。
- 自定义评分视图的部分元素。

<div class="alert note">仅 XML 格式的歌词支持歌唱音准和评分功能。</div>

## 前提条件

在使用歌词组件前，请确保你已在项目中集成 Agora 视频 SDK v4.x，并实现在线 K 歌功能，详见[客户端实现](https://docs.agora.io/cn/online-ktv/chorus_client_android?platform=Android)。

## 实现方法

### 使用 JitPack 自动集成歌词组件

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
        implementation 'com.github.AgoraIO-Community:lrcview-android:1.0.13'
}
```

### 声明和初始化歌词组件对象

在项目的 Activity 中，声明和初始化歌词组件对象。示例代码如下：

```java
public class LiveActivity extends RtcBaseActivity {
    private LrcView mLrcView;
  
  
      
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        ...
        mLrcView = findViewById(R.id.lrc_view);
        ...
    }
}
```

### 实现歌词显示及同步

参考如下歌词组件 API 使用时序见，实现歌词显示及同步功能：

![](https://web-cdn.agora.io/docs-files/1630054208808)

<div class="alert note"> 由于 Android UI 系统限制，以上 API 的调用顺序必须严格按照 API 时序图顺序，且必须在 UI 线程中调用，否则会导致 App 崩溃。</div>

## 进阶功能

### 实现评分功能

按照如下步骤，实现歌词组件评分功能：

1. 调用 Agora SDK 的 `enableAudioVolumeIndication` 方法开启歌唱评分功能，通过监听 `onAudioVolumeIndication` 回调获取本地用户的人声音调（`voicePitch`），并传入歌词组件。详见[评分功能](https://docs.agora.io/cn/online-ktv/ktv_score_android?platform=Android)。

2. 设置歌词组件的评分相关的回调监听。

```java
public interface OnActionListener {
// 原唱标准音调回调，详见 API 参考
void onOriginalPitch(double pitch, int totalCount);
// 评分回调，详见 API 参考
void onScore(double score, double cumulativeScore, double totalScore);
}
```

### 自定义歌词组件界面

在项目的 Activity 中，自定义歌词组件的界面元素。示例代码如下：

```java
<io.agora.lrcview.LrcView
android:id="@+id/lrcView"
android:layout_width="match_parent"
android:layout_height="match_parent"
android:paddingStart="10dp"
android:paddingTop="20dp"
android:paddingEnd="10dp"
android:paddingBottom="20dp"
// 当前行歌词颜色
app:lrcCurrentTextColor="@color/ktv_lrc_highligh"
// 歌词行间距
app:lrcDividerHeight="20dp"
// 无歌词情况下的默认文字
app:lrcLabel="暂无歌词"
// 非当前行歌词颜色
app:lrcNormalTextColor="@color/ktv_lrc_nomal"
// 非当前行歌词字体大小
app:lrcNormalTextSize="16sp"
// 歌词对齐方式
app:lrcTextGravity="center"
// 当前行歌词字体大小
app:lrcTextSize="26sp"
// 评分初始分数，默认为 0
app:lrcDefaultScore="0"
// 歌词是否支持拖动
app:lrcEnableDrag="true"
// 是否显示歌唱分数
app:lrcScore="true"
/>
```

## 相关信息

### API 参考

歌词组件的核心 API 如下：

| API                                   | 实现功能                                                     |
| :------------------------------------ | :----------------------------------------------------------- |
| `setActionListener`                   | 订阅 `OnActionListener` 回调事件。`OnActionListener` 为 lrcview 控件回调类，包括：歌词加载完成回调、进度改变回调、开始拖动歌词回调、结束拖动歌词回调。 |
| `setTotalDuration`                    | 设置歌词总时长，单位毫秒。必须与歌曲时长一致。               |
| `loadLrc(mainLrcText, secondLrcText)` | 加载本地歌词文件。<li>支持加载 LRC 格式的双语歌词，`mainLrcText` 是中文歌词对象，`secondLrcText` 是英文歌词对象。<li>对于非双语歌词， 将 `mainLrcText` 或 `secondLrcText` 设置为 null。 |
| `onLoadLrcCompleted`                  | 歌词文件加载完成回调。                                       |
| `setEnableDrag`                       | 设置是否允许上下拖动歌词。                                   |
| `updateTime`                          | 根据当前歌曲播放进度更新歌词进度，单位为毫秒。               |
| `hasLrc`                              | 获取歌词文件状态。<li>true：歌词有效<li>false：歌词无效，无法播放    |
| `reset`                               | 重置内部状态，清空已经加载的歌词。                           |
| `onOriginalPitch`                     | 原唱标准音调回调。你可以通过该回调自行实现评分逻辑。包含如下参数：<li>`pitch`：当前歌词音调对应的 pitch 值，每个音调回调一次。<li>`totalCount`：整个 XML 歌词的 pitch 个数，用于计算平均分。 |
| `onScore`                             | 评分回调。每句歌词（sentence）结束时触发该回调。你可以通过该回调自行实现分数计算。包含如下参数：<li>`score`：当前句分数，范围为 [40,100]。<li>`cumulativeScore`：当前累计分数。<li>`totalScore`：歌曲总分数 = 初始分数（默认为 0 分) + 歌词句段数量 * 100<div class="alert note"> 当开启评分回调后, 歌词可拖动功能默认失效。</div> |

### 示例项目

Agora 在 GitHub 上提供歌词组件开源的[示例项目](https://github.com/AgoraIO-Community/LrcView-Android)供你参考。