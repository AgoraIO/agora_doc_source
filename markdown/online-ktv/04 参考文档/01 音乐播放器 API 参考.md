## IAgoraMusicContentCenter

`IAgoraMusicContentCenter` 接口类，该类实现音乐内容中心的主要功能。

### initialize

初始化 `IAgoraMusicContentCenter` 。

```java
public abstract int initialize(AgoraMusicContentCenterConfiguration configuration);
```

**注意**

在调用 `IAgoraMusicContentCenter` 类下的其他方法前，你需要先调用该方法初始化 `IAgoraMusicContentCenter`。

**参数**

- `configuration`：`IAgoraMusicContentCenter` 的配置，详见 `AgoraMusicContentCenterConfiguration`。

**返回值**

- 0: 方法调用成功。
- < 0: 方法调用失败。

### createMusicPlayer

创建音乐播放器。

```java
public abstract IAgoraMusicPlayer createMusicPlayer();
```

如果你需要播放音乐内容中心的音乐资源，你需要先调用该方法来创建一个音乐播放器。

**返回值**

- 方法调用成功：返回 `IAgoraMusicPlayer` 对象。
- 方法调用失败：返回空指针。

### registerEventHandler

注册音乐内容中心回调事件。

```java
public abstract int registerEventHandler(IMusicContentCenterEventHandler eventHandler);
```

**参数**

- `eventHandler`：待注册的回调事件，详见`IMusicContentCenterEventHandler`。

**返回值**

- 0: 方法调用成功。
- < 0: 方法调用失败。

### unregisterEventHandler

取消注册事件回调。

```java
public abstract int unregisterEventHandler();
```

**返回值**

- 0: 方法调用成功。
- < 0: 方法调用失败。

### preload

预加载音乐资源。

```java
public abstract int preload(long songCode, String jsonOption);
```

你可以调用该方法预先加载需要播放的音乐资源。成功调用该方法后，SDK 会触发 `onPreloadEvent` 回调报告预加载音乐资源的事件。

在调用该方法来预加载音乐资源之前，你需要调用 `getMusicCollectionByMusicChartId` 或 `searchMusic` 方法来获取你需要播放的音乐资源，并通过由此触发的 `onMusicCollectionResult` 回调获取音乐资源的编号（`songCode`）。

**参数**

- `songCode`：输入参数；音乐资源的编号，用于标识一个音乐资源。
- `jsonOption`：扩展 json 字段，默认为 `null`。

**返回值**

- 0: 方法调用成功。
- < 0: 方法调用失败。

### isPreloaded

检测音乐资源是否已被预加载。

```java
public abstract int isPreloaded(long songCode);
```

该方法为同步调用。调用 `preload` 方法之后你可以调用该方法来检测音乐资源是否已被预加载。

**参数**

- `songCode`：音乐资源的编号，用于标识一个音乐资源。

返回值

- 0: 该音乐资源已被预加载。
- < 0: 方法调用失败。

### getMusicCharts

获取曲库中全部的音乐榜单。

```java
public abstract String getMusicCharts();
```

当你调用该方法后，SDK 会触发 `onMusicChartsResult` 回调报告音乐榜单的详细信息。

**返回值**

- 一个 `requestId`，为本次请求的唯一标识。

### getMusicCollectionByMusicChartId[1/2]

通过音乐榜单的 ID 获取指定榜单的音乐资源列表。

```java
public String getMusicCollectionByMusicChartId(int musicChartId, int page, int pageSize) {
return getMusicCollectionByMusicChartId(musicChartId, page, pageSize, null);
}
```

成功调用该方法后，SDK 会触发 `onMusicCollectionResult` 回调报告榜单中音乐资源列表的详细信息。

**参数** 

- `musicChartId`：音乐榜单的 ID，可以通过 `getMusicCharts` 方法获取。你也可以通过 RESTful API 来[获取曲库所有歌曲列表](https://docs.agora.io/cn/online-ktv/ktv_song_rest?platform=Android#a-namegeta获取曲库所有歌曲列表)或[增量歌曲列表](https://docs.agora.io/cn/online-ktv/ktv_song_rest?platform=Android#获取增量歌曲列表)。

- `page`：想要获取的音乐资源列表的目标页编号。

- `pageSize`：每页所展示的音乐资源的最大数量，最大值为 50。

**返回值**

- 一个 `requestId`，为本次请求的唯一标识。

### getMusicCollectionByMusicChartId[2/2]

通过音乐榜单的 ID 获取指定榜单的音乐资源列表。

```java
public abstract String getMusicCollectionByMusicChartId( int musicChartId, int page, int pageSize, String jsonOption);
```

你可以调用该方法获取指定榜单的音乐资源列表并自定义 json 参数。

成功调用该方法后，SDK 会触发 `onMusicCollectionResult` 回调报告榜单中音乐资源列表的详细信息。

**参数**

- `musicChartId`：音乐榜单的 ID，可以通过 `getMusicCharts` 方法获取。你也可以通过 RESTful API 来[获取曲库所有歌曲列表](https://docs.agora.io/cn/online-ktv/ktv_song_rest?platform=Android#a-namegeta获取曲库所有歌曲列表)或[增量歌曲列表](https://docs.agora.io/cn/online-ktv/ktv_song_rest?platform=Android#获取增量歌曲列表)。

- `page`：想要获取的音乐资源列表的目标页编号。

- `pageSize`：每页所展示的音乐资源的最大数量，最大值为 50。

- `jsonOption`：扩展 json 字段，默认为 `null`。

**返回值**

- 一个 `requestId`，为本次请求的唯一标识。

### searchMusic [1/2]

搜索音乐资源。

```java
public String searchMusic(String keyword, int page, int pageSize) {
return searchMusic(keyword, page, pageSize, null);
}
```

成功调用该方法后，SDK 会触发 `onMusicCollectionResult` 回调，报告检索到的音乐资源列表。

**参数**

- `keyword`：搜索关键词。

- `page`：想要获取的音乐资源列表的目标页编号。

- `pageSize`：每页所展示的音乐资源的最大数量，最大值为 50。

**返回值**

- 一个 `requestId`，为本次请求的唯一标识。

### searchMusic [2/2]

搜索音乐资源。

```java
public abstract String searchMusic(String keyword, int page, int pageSize, String jsonOption);
```

你可以调用该方法来通过关键词搜索音乐资源并自定义 json 参数。

成功调用该方法后，SDK 会触发 `onMusicCollectionResult` 回调，报告检索到的音乐资源列表。

**参数**

- `keyword`：搜索关键词。

- `page`：想要获取的音乐资源列表的目标页编号。

- `pageSize`：每页所展示的音乐资源的最大数量。

- `jsonOption`：扩展 json 字段，默认为 `null`。

**返回值**

- 一个 `requestId`，为本次请求的唯一标识。

### getLyric

获取音乐资源的歌词下载地址。

```java
public abstract String getLyric(long songCode, int lyricType);
```

成功调用该方法后，SDK 会触发 `onLyricResult` 回调。

**参数**

- `songCode`：输入参数；音乐资源的编号，用于标识一个音乐资源。

- `lyricType`：歌词类型：
  - 0：xml 格式。
  - 1：lrc 格式。

**返回值**

- 一个 `requestId`，为本次请求的唯一标识。

### release

释放音乐内容中心所占用的所有资源。

```java
protected abstract void release();
```

<div class="alert info">该方法需要在 <code>RtcEngine</code> 的 <code>destroy</code> 方法前调用。</div>

## IAgoraMusicPlayer

`IAgoraMusicPlayer` 接口类，提供音乐播放器的相关方法。

### open

打开音乐内容中心的音乐资源。

```java
int open(long songCode, long startPos);
```

在调用此方法之前，请确保需要播放的音乐资源已加载完成。你可以调用 `isPreloaded` 方法或通过 `onPreLoadEvent` 回调来检测音乐资源是否已被预加载。


<div class="alert note">如果你需要播放音乐资源，请确保收到 <code>onPlayerStateChanged</code> 回调报告状态为 <code>PLAYER_STATE_OPEN_COMPLETED(2)</code> 再调用 <code>play</code> 来进行播放。</div>

**参数**

- `songCode`：输入参数；音乐资源的编号，用于标识一个音乐资源。

- `startPos`：设置起始播放位置（毫秒），默认值为 0。

**返回值**

- 0: 方法调用成功。
- < 0: 方法调用失败。

### destroy

销毁音乐播放器。

```java
int destroy();
```

**返回值**

- 0: 方法调用成功。
< 0: 方法调用失败。


## IAgoraMusicContentCenterEventHandler

`IAgoraMusicContentCenterEventHandler` 接口类，用于 SDK 向客户端发送音乐内容中心事件通知。

### onPreLoadEvent

报告预加载音乐资源的事件。

```java
void onPreLoadEvent(long songCode, int percent, int status, String msg, String lyricUrl);
```

当你调用 `preload` 方法后，SDK 会触发该回调。

**参数**

- `songCode`：音乐资源的编号，用于标识一个音乐资源。

- `percent`：音乐资源当前的加载进度，取值范围为 [0,100]。

- `status`：当前音乐资源的加载状态：
 - `0`：音乐资源加载完成。
 - `1`：音乐资源加载失败。
 - `2`：音乐资源正在加载中。

- `msg`：字符串类型的事件信息。

- `lyricUrl`：歌词下载地址。

### onMusicCollectionResult

音乐资源列表回调。

```java
void onMusicCollectionResult( String requestId, int status, int page, int pageSize, int total, Music[] list);
```

当你调 `getMusicCollectionByMusicChartId` 方法来通过音乐榜单的 ID 获取指定榜单的音乐资源列表，SDK 会触发 `onMusicCollectionResult` 回调报告榜单中音乐资源列表的详细信息。

**参数**

- `requestId`：请求 ID。本次请求的唯一标识。

- `status`：获取音乐资源列表的请求状态：
 - `0`：请求成功。
 - `1`：请求失败。

- `page`：当前页面编号。

- `pageSize`：当前音乐资源列表的总页面数量。

- `total`：列表内音乐资源的总数量。

- `list`：当前页面列表中音乐资源的详细信息，详见 `Music`。

### onMusicChartsResult

音乐榜单回调。

```java
void onMusicChartsResult(String requestId, int status, MusicChartInfo[] list);
```

当你调用 `getMusicCharts` 方法获取全部音乐榜单之后，SDK 会触发该回调。

**参数**

- `requestId`：请求 ID。本次请求的唯一标识。

- `status`：获取音乐榜单的请求状态：
 - `0`：请求成功。
 - `1`：请求失败。

- `list`：当前可播放的音乐榜单列表，详见 `MusicChartInfo`。

### onLyricResult

歌词下载地址回调。

```java
 void onLyricResult(String requestId, String lyricUrl);
```

当你调用 `getLyric` 获取指定歌曲的歌词下载地址后，SDK 会触发该回调。

**参数**

- `requestId`：请求 ID。本次请求的唯一标识。

- `lyricUrl`：歌词的下载地址。

## Music 

音乐资源的详细信息。

```java
public class Music {
  public long songCode;
  public String name;
  public String singer;
  public String poster;
  public String releaseTime;
  public int type;
	public int pitchType;
  public int durationS;
  public int[] lyricType;
  public MvProperty[] mv;
  public ClimaxSegment[] climaxSegments;
}
```

**songCode**

音乐资源的编号，用于标识一个音乐资源。

**name**

音乐资源名称。

**singer**

歌手名。

**poster**

音乐资源海报的地址。

**releaseTime**

音乐资源发布的时间。

**type**

音乐资源类型：

- `1`：左声道伴奏，右声道原唱的单音轨纯音频音源。
- `2`：只有伴唱的单音轨纯音频音源。
- `3`：只有原唱的单音轨纯音频音源。
- `4`：既有多音轨纯音频又有多音轨 MV 资源的音源。
- `5`：只有多音轨 MV 资源的音源。
- `6`：既有多音轨纯音频又有多音轨 MV 资源的音源（该音源受数字版权保护）。

**pitchTypes**

歌曲是否支持演唱评分功能：

- `1`：歌曲支持演唱评分功能。
- `2`：歌曲不支持演唱评分功能。

**durationS**

音乐资源总时长 （秒）。

**lyricTypes**

支持的歌词类型：

- `0`：xml 格式。
- `1`：lrc 格式。

**mvProperties**

需播放的 MV 的属性，详见 `MvProperty`。

**climaxSegments**

音乐高潮片段列表，详见 `ClimaxSegment`。

## AgoraMusicContentCenterConfiguration

音乐内容中心的配置。

```java
public class MusicContentCenterConfiguration {
public String appId;
public String rtmToken;
public long mccUid;
public IMusicContentCenterEventHandler eventHandler
 }
```

**appId**

已启用内容中心的项目的 App ID。

**rtmToken**

使用音乐内容中心时，用于鉴权的 RTM Token，详见[使用 RTM Token 鉴权](https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm?platform=AllPlatforms)。

**mccUid**

使用音乐内容中心的用户 ID，该 ID 由用户自行设置。

**eventHandler**

待接收的事件回调，详见 `IAgoraMusicContentCenterEventHandler`。

## MvProperty

MV 的属性。

```java
public class MvProperty {
public String bandwidth;
public String resolution;
}
```

**bandwidth**

该 MV 的视频带宽。

**resolution**

该 MV 的分辨率。

## MusicChartInfo

音乐榜单的详细信息。

```java
public class MusicChartInfo {
public String name;
public int type;  
}
```

**name**

榜单名。

**type**

音乐榜单的 ID。

## ClimaxSegment

音乐高潮片段设置。

```java
public class ClimaxSegment {
public int startTimeMs; 
public int endTimeMs;
}
```

**startTimeMs**

音乐高潮片段的开始时间点，单位毫秒。

**endTimeMs**

音乐高潮片段的结束时间点，单位毫秒。
