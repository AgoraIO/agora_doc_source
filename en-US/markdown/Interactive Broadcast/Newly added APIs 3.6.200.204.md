### selectSubtitleById

```objective-c
- (int)selectSubtitleById:(int64_t)sId;
```

Chooses the subtitle that you want to display in the video currently being played.

If the video has embedded subtitle tracks, the first subtitle track is displayed by default.

If you want to display other subtitle tracks, call the `selectSubtitleById` method and pass in the ID of the subtitle track you want to display. If you want to display an external subtitle, you need to call the `addExternalSubtitleWithUrl` to add the external subtitle to the video before you call this method.

**Note：**

Ensure you have called the `open` method before calling the `selectSubtitleById` method.

If you call this method before `open`, the SDK returns the error code `-9(AgoraMediaPlayerErrorInvalidState)` ; if you pass in invalid subtitle ID, the SDK returns the error code `-2(AgoraMediaPlayerErrorInternal)`.

**Parameter**：

- `sId`：Input parameters; the ID of the subtitle that you want to display in the video currently being played. If you want to turn off the subtitle, pass in `-1`.

**Returns**：

- 0: Success.
- < 0: Failsure. See `AgoraMediaPlayerError` for details.

### addExternalSubtitleWithUrl

```objective-c
- (int64_t)addExternalSubtitleWithUrl:(NSString *)url; 
```

Adds external subtitles.

Agora supports external subtitles in ass and srt format.

If you call this method to add external subtitles in formats other than ass and srt, the subtitle can still be added. However, when you call the `selectSubtitleById` method and choose such subtitles to display in the video, the `onSubtitleLoadState` callback is triggered to report the failure of loading the subtitles.

**Parameter：**

- `url`：The bsolute path of the external subtitle.

**Returns**：

- 0: Success.
- < 0: Failure. See `AgoraMediaPlayerError` for details.

### removeExternalSubtitleById

```objective-c
- (int)removeExternalSubtitleById:(int64_t)sId;
```

Removes external subtitles.

When the external subtitle currently used is removed, if the video being played has embedded subtitles, the first subtitle track is displayed by default. If you want to choose other subtitles to display, call the `selectSubtitleById` method.

**Parameter**：

`sId`：Input parameters; the ID of the external subtitle that you want to remove.

**Returns**：

- 0: Success.
- < 0: Failure. See `AgoraMediaPlayerError` for details.

### getSubtitleCount 

```objective-c
- (int64_t)getSubtitleCount;
```

Gets the total number of the embedded and external subtitles.

**Returns**：

- &ge; 0: The call succeeds and returns the total number of the embedded and external subtitles. //TODO
- < 0: Failure. See `AgoraMediaPlayerError` for details.

### getAllSubtitleInfo

```objective-c
- (NSArray <AgoraMediaPlayerSubtitleInfo*> *)getAllSubtitleInfo;
```

Gets the information of all subtitles.

Returns：

- The call succeeds and returns the information of all subtitles. See `AgoraMediaPlayerSubtitleInfo` for details.
- < 0: Failure. See `AgoraMediaPlayerError` for details.

### getCurrentSubtitleInfo

```
- (AgoraMediaPlayerSubtitleInfo * _Nullable)getCurrentSubtitleInfo;
```

Gets the information of the subtitle being displayed in the video.

Returns：

- The call succeeds and returns the information of the subtitle being displayed in the video. See `AgoraMediaPlayerSubtitleInfo` for details.
- < 0: Failure. See `AgoraMediaPlayerError` for details.



### AgoraMediaPlayerSubtitleInfo

**OC：**

`__attribute__((visibility("default"))) @interface AgoraMediaPlayerSubtitleInfo : NSObject`
/**
\* The subtitle ID.
*/
@property (nonatomic, assign) int64_t sId;
/**
/* Whether it is an external subtitle:

- `YES`: It is an external subtitle.
-  `NO`：It is an embedded subtitle.

*/
@property (nonatomic, assign) BOOL external;
/**
\* The absolute path of the external subtitle.
*/
@property (nonatomic, copy) NSString *_Nonnull externalPath;

### subtitleLoadStateChanged

```objective-c
(void)AgoraRtcMediaPlayer:(id<AgoraRtcMediaPlayerProtocol> _Nonnull)playerKit subtitleLoadStateChanged:(BOOL)succeed subtitleInfo:(AgoraMediaPlayerSubtitleInfo *_Nonnull)info;
```

Reports whether the subtitle is loaded.

This callback is triggered when you call the `selectSubtitleById` method to choose the subtitle you want to display.

**Note:**

This callback is not triggered when you call the `addExternalSubtitleWithUrl` method to add external subtitles in formats other than ass and srt. However, when you call the `selectSubtitleById` method and choose such subtitles to display in the video, the `onSubtitleLoadState` callback is triggered to report the failure of loading the subtitles.

**Parameters**：

`succeed`：The loading state of the subtitle:

- `YES`: The loading of the subtitle succeeds.
- `NO`：The loading of the subtitle fails.

`info`: The information of the successfully loaded subtitle. See `AgoraMediaPlayerSubtitleInfo` for details.


### openWithMediaSource

```objective-c
- (int)openWithMediaSource:(AgoraMediaSource *)source;
```

Opens the media resource.

**API comparison：**

Compared with `open` and `openWithAgoraCDNSrc` , this method supports caching part of the media file to be played. Once the media file is cached, you can play the media file offline.

**Parameter**：

`source`：Input parameter, See `AgoraMediaSource` for details.

**Returns：**

- 0: Success.
- < 0: Failure. See  `AgoraMediaPlayerError` for details.

### removeAllCaches

```objective-c
- (int)removeAllCaches;
```

Removes all cached media files in the media player.

**Note：**The cached media file currently being played cannot be removed.

**Returns:**

- 0: Success.
- < 0: Failure. See `AgoraMediaPlayerError` for details.

### removeOldCache

```objective-c
- (int)removeOldCache;
```

Removes the least recently used cache files.

You can call this method to manage the storage space for your cached media files. 

**Note：**The cached media file currently being played cannot be removed.

**Returns**：

- 0: Success.
- < 0: Failure. See `AgoraMediaPlayerError` for details.

### removeCacheByUri

```objective-c
- (int)removeCacheByUri:(NSString *)uri;
```

Removes a cached media file.

**Note：**The cached media file currently being played cannot be removed.

**Parameters：**

- `uri`：The URI of the cached media file you want to delete, a unique identifier of a cached file.

**Returns**：

- 0: Success.
- < 0: Failure. See `AgoraMediaPlayerError` for details.

### setCacheDir

```objective-c
- (int)setCacheDir:(NSString *)cacheDir;
```

Sets the storage path for the media files that you want to cache.

**Note:** Ensure the media player is initialized before calling this method.

**Parameter：**

- `cacheDir`：The absolute path of the cached media files.

**Returns**：

- 0: Success.
- < 0: Failure. See `AgoraMediaPlayerError` for details.

### setMaxCacheFileCount

```objective-c
- (int)setMaxCacheFileCount:(NSInteger)fileCount;
```

Sets the maximum number of media files that can be cached.

**Parameter**：

- `fileCount`：The maximum number of media files that can be cached. The default value is 1,000.

**Returns**：

- 0: Success.
- < 0: Failure. See `AgoraMediaPlayerError` for details.

### setMaxCacheFileSize

```objective-c
- (int)setMaxCacheFileSize:(NSInteger)fileSize;
```

Sets the maximum size of the aggregate storage space for cached media files.

**Parameter**：

- fileSize：the maximum size (in bytes) of the aggregate storage space for cached media files. The default value is 1 GB.

**Returns**：

- 0: Success.
- < 0: Failure. See `AgoraMediaPlayerError` for details.

### enableAutoRemoveCache

```objective-c
- (int)enableAutoRemoveCache:(BOOL)enable;
```

Sets whether to remove cached media files automatically.

If you enable the media player to remove cached media files automatically, when the cached media files reach the limit in number or size you set, the SDK automatically removes the least recently used cache files.

**Parameters：**

`enable`：Whether to enable the media player to remove cached media files automatically:

- `YES`：Remove cached media files automatically.
- `NO`：Do not remove cached media files automatically.

**Returns**：

- 0: Success.
- < 0: Failure. See `AgoraMediaPlayerError` for details.

### cacheDir 

```objective-c
- (NSString *)cacheDir;
```

Gets the storage path of the cached media files.

If you haved not called the `setCacheDir` method to choose the storage path of cached media files before calling this method, you get the default storage path.

**Returns**：

- The call succeeds and returns the storage path of the cached media files.
- < 0: Failure. See `AgoraMediaPlayerError` for details.

### maxCacheFileCount 

```objective-c
- (NSInteger)maxCacheFileCount;
```

Gets the maximum number of media files that can be cached.

By default, the maximum number of media files that can be cached is 1,000. You can call the `setMaxCacheFileCount` method to set the limit according to your scenarios.

**Returns**：

- The call succeeds and returns the maximum number of media files that can be cached.
- < 0: Failure. See `AgoraMediaPlayerError` for details.

### maxCacheFileSize

```objective-c
- (NSInteger)maxCacheFileSize;
```

Gets the maximum size of the aggregate storage space for cached media files.

By default, the maximum size of the aggregate storage space for cached media files is 1 GB. You can call the  `setMaxCacheFileSize` method to set the limit according to your scenarios.

**Returns：**

- The call succeeds and returns maximum size (in bytes) of the aggregate storage space for cached media files.
- < 0: Failure. See `AgoraMediaPlayerError` for details.

### cacheFileCount

```objective-c
- (NSInteger)cacheFileCount;
```

Gets the number of media files that are cached.

**Returns：**

- The call succeeds and returns the number of media files that are cached.
- < 0: Failure. See `AgoraMediaPlayerError` for details.

### AgoraMediaPlayerEvent 

```objective-c
AgoraMediaPlayerEventReachCacheFileMaxCount = 15,
```

The cached media files reach the limit in number.

```objective-c
AgoraMediaPlayerEventReachCacheFileMaxSize = 16,
```

The cached media files reach the limit in aggregate storage space.

### AgoraMediaSource/MediaPlayerSource

```objective-c
@property(copy, nonatomic) NSString *_Nullable url;
```

The URL of the media file you want to play.

```objective-c
@property(copy, nonatomic) NSString *_Nullable uri;
```

The URI of the media file, a unique identifier of a cached media.

```objective-c
@property(assign, nonatomic) NSUInteger startPos;
```

The starting position (ms) for playback. Default value is 0.


/**
\* 此次播放是否需要预先缓存媒体文件。

- YES：开启预先缓存。
- NO：（默认）关闭预先缓存。

```objective-c
@property(assign, nonatomic) BOOL enableCache;
```

Whether to cache the media file to be played:

- `YES`：Cache the media file.
- `NO`：(Default) Do not cache the media file.

### AgoraMediaPlayerUpdatedInfo 

```objective-c
@property(strong, nonatomic) AgoraMediaPlayerCacheStatistics *_Nullable cacheStatistics;
```

The statistics of the media file currently being cached.

When you call the `openWithMediaSource` method to open a media file and enable caching, this statistic is updated every second after the file is played. See `AgoraMediaPlayerCacheStatistics` for details.

### AgoraMediaPlayerCacheStatistics

```objective-c
@property(assign, nonatomic) NSInteger fileSize;
```
The size (in bytes) of the media file being played.
```objective-c
@property(assign, nonatomic) NSInteger cacheSize;
```
The size (in bytes) of the media file that you want to cache.
```objective-c
@property(assign, nonatomic) NSInteger downloadSize;
```
The size (in bytes) of the media file that has been downloaded.

### createMediaPlayerCacheManager

```objective-c
- (id<AgoraRtcMediaPlayerCacheManagerProtocol> _Nullable)createMediaPlayerCacheManager;
```

Create an `AgoraRtcMediaPlayerCacheManagerProtocol ` instance.

**Returns：**

- The `AgoraRtcMediaPlayerCacheManagerProtocol` instance.

