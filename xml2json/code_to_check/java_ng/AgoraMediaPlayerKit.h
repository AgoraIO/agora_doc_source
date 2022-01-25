//
//  AgoraMediaPlayerKit.h
//  AgoraMediaPlayer
//
//  Copyright © 2019 agora. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import <Foundation/Foundation.h>
#import <VideoToolbox/VideoToolbox.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
typedef UIView View;
#elif TARGET_OS_MAC
#import <AppKit/AppKit.h>
typedef NSView View;
#endif
NS_ASSUME_NONNULL_BEGIN
// external key
/**
 * set analyze duration for real time stream
 * @example "setPlayerOption(kMediaPlayerRealTimeStreamAnalyzeDuration,1000000)"
 */
#define kMediaPlayerRealTimeStreamAnalyzeDuration    @"analyzeduration"

/**
 * set the player disable to play audio
 * @example  "setPlayerOption(kMediaPlayerDisableAudio,0)"
 */
#define kMediaPlayerDisableAudio                 @"audio_disable"

/**
 * set the player disable to play video
 * @example  "setPlayerOption(kMediaPlayerDisableVideo,0)"
 */
#define kMediaPlayerDisableVideo                  @"video_disable"

/** AgoraMediaPlayerState, reporting the playback state. */
typedef NS_ENUM(NSInteger, AgoraMediaPlayerState) {
  /** `0`: Default state. */
  AgoraMediaPlayerStateIdle = 0,
  /** `1`: Opening the media resource. */
  AgoraMediaPlayerStateOpening = 1,
  /** `2`: Opens the media resource successfully. */
  AgoraMediaPlayerStateOpenCompleted = 2,
  /** `3`: Playing the media resource. */
  AgoraMediaPlayerStatePlaying = 3,
  /** `4`: Pauses the playback. */
  AgoraMediaPlayerStatePaused = 4,
  /** `5`: The playback is completed. */
  AgoraMediaPlayerStatePlayBackCompleted = 5,
  /** `6`: The loop playback is completed. */
  AgoraMediaPlayerStatePlayBackAllLoopsCompleted = 6,
  /** `7`: Stops the playback. */
  AgoraMediaPlayerStateStopped = 7,
  /** `8`: Player pausing (internal).  */
  AgoraMediaPlayerStatePausingInternal = 50,
  /** `9`: Player stopping (internal).  */
  AgoraMediaPlayerStateStoppingInternal = 51,
  /** `10`: Player seeking state (internal). */
  AgoraMediaPlayerStateSeekingInternal = 52,
  /** `11`: Player getting state (internal). */
  AgoraMediaPlayerStateGettingInternal = 53,
  /** `12`: None state for state machine (internal).  */
  AgoraMediaPlayerStateNoneInternal = 54,
  /** `13`: Do nothing state for state machine (internal).  */
  AgoraMediaPlayerStateDoNothingInternal = 55,

  /** `100`: Fails to play the media resource. */
  AgoraMediaPlayerStateFailed = 100,
};
/** AgoraMediaPlayerError, reporting the player's error code. */
typedef NS_ENUM(NSInteger, AgoraMediaPlayerError) {
  /** `0`: No error. */
  AgoraMediaPlayerErrorNone = 0,
  /** `-1`: Invalid arguments. */
  AgoraMediaPlayerErrorInvalidArguments = -1,
  /** `-2`: Internal error. */
  AgoraMediaPlayerErrorInternal = -2,
  /** `-3`: No resource. */
  AgoraMediaPlayerErrorNoSource = -3,
  /** `-4`: Invalid media resource. */
  AgoraMediaPlayerErrorInvalidMediaSource = -4,
  /** `-5`: The type of the media stream is unknown. */
  AgoraMediaPlayerErrorUnknowStreamType = -5,
  /** `-6`: The object is not initialized. */
  AgoraMediaPlayerErrorObjNotInitialized = -6,
  /** `-7`: The codec is not supported. */
  AgoraMediaPlayerErrorCodecNotSupported = -7,
  /** `-8`: Invalid renderer. */
  AgoraMediaPlayerErrorVideoRenderFailed = -8,
  /** `-9`: Error occurs in the internal state of the player. */
  AgoraMediaPlayerErrorInvalidState = -9,
  /** `-10`: The URL of the media resource can not be found. */
  AgoraMediaPlayerErrorUrlNotFound = -10,
  /** `-11`: Invalid connection between the player and Agora's Server. */
  AgoraMediaPlayerErrorInvalidConnectState = -11,
  /** `-12`: The playback buffer is insufficient. */
  AgoraMediaPlayerErrorSrcBufferUnderflow = -12,
};
/** AgoraMediaPlayerEvent, reporting the result of the seek operation to the new
 playback position.
 */
typedef NS_ENUM(NSInteger, AgoraMediaPlayerEvent) {
  /** `0`: Begins to seek to the new playback position. */
  AgoraMediaPlayerEventSeekBegin = 0,
  /** `1`: Seeks to the new playback position. */
  AgoraMediaPlayerEventSeekComplete = 1,
  /** `2`: Error occurs when seeking to the new playback position. */
  AgoraMediaPlayerEventSeekError = 2,
  /** `5`: The audio track used by the player has been chanaged. */
  AgoraMediaPlayerEventAudioTrackChanged = 5,
  /** `6`: The currently buffered data is not enough to support playback. */
  AgoraMediaPlayerEventBufferLow = 6,
  /** `7`: The currently buffered data is just enough to support playback. */
  AgoraMediaPlayerEventBufferRecover = 7,


};

/**
 * AgoraMediaPlayerMetaDataType, reporting the type of the media metadata.
 */
typedef NS_ENUM(NSUInteger, AgoraMediaPlayerMetaDataType) {
  /** `0`: The type is unknown. */
  AgoraMediaPlayerMetaDataTypeUnknown = 0,
  /** `1`: The type is SEI. */
  AgoraMediaPlayerMetaDataTypeSEI = 1,
};

/** AgoraMediaPixelFormat, reporting the pixel format of the video stream. */
typedef NS_ENUM(NSInteger, AgoraMediaPixelFormat) {
  /** `0`: The format is known.
   */
  AgoraMediaPixelFormatUnknown = 0,
  /** `1`: The format is I420.
   */
  AgoraMediaPixelFormatI420 = 1,
  /** `2`: The format is BGRA.
   */
  AgoraMediaPixelFormatBGRA = 2,
  /** `3`: The format is Planar YUV422.
   */
  AgoraMediaPixelFormatI422 = 3,
  /** `8`: The format is NV12.
   */
  AgoraMediaPixelFormatNV12 = 8,
};
/** AgoraMediaStreamType, reporting the type of the media stream. */
typedef NS_ENUM(NSInteger, AgoraMediaStreamType) {
  /** `0`: The type is unknown. */
  AgoraMediaStreamTypeUnknow = 0,
  /** `1`: The video stream.  */
  AgoraMediaStreamTypeVideo = 1,
  /** `2`: The audio stream. */
  AgoraMediaStreamTypeAudio = 2,
  /** `3`: The subtitle stream. */
  AgoraMediaStreamTypeSubtitle = 3,
};
/** AgoraMediaPlayerRenderMode, reporting the render mode of the player. */
typedef NS_ENUM(NSUInteger, AgoraMediaPlayerRenderMode) {
    /** `1`: Uniformly scale the video until it fills the visible boundaries
     (cropped). One dimension of the video may have clipped contents.
     */
    AgoraMediaPlayerRenderModeHidden = 1,

    /** `2`: Uniformly scale the video until one of its dimension fits the
     boundary (zoomed to fit). Areas that are not filled due to disparity in
     the aspect ratio are filled with black.
     */
    AgoraMediaPlayerRenderModeFit = 2,
};
@class AgoraMediaPlayer;

@class AgoraMediaStreamInfo;
/** The AgoraMediaPlayerDelegate protocol, reporting the event callbacks. */
@protocol AgoraMediaPlayerDelegate <NSObject>

@optional

/** Reports the playback state change.

 @param playerKit AgoraMediaPlayer

 @param state The new playback state after change. See AgoraMediaPlayerState.

 @param error The player's error code. See AgoraMediaPlayerError.
 */
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
       didChangedToState:(AgoraMediaPlayerState)state
                   error:(AgoraMediaPlayerError)error;

/** Reports current playback progress.

 The callback occurs once every one second during the playback and reports
 current playback progress.

 @param playerKit AgoraMediaPlayer

 @param position Current playback progress (s).
 */
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
    didChangedToPosition:(NSInteger)position;

/** Reports the result of the seek operation.

 @param playerKit AgoraMediaPlayer

 @param event The result of the seek operation. See AgoraMediaPlayerEvent.
 */
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
          didOccurEvent:(AgoraMediaPlayerEvent)event;

/** Reports the reception of the media metadata.

 The callback occurs when the player receives the media metadata and reports
 the detailed information of the media metadata.

 @param playerKit AgoraMediaPlayer

 @param type The type of the media metadata. See AgoraMediaPlayerMetaDataType.

 @param data The detailed data of the media metadata.

 @param length The length (byte) of the data.
 */
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
            metaDataType:(AgoraMediaPlayerMetaDataType) type
          didReceiveData:(NSString *)data
                  length:(NSInteger)length;
/** Occurs when each time the player receives a video frame.

 After registering the video frame observer, the callback occurs when each
 time the player receives a video frame, reporting the detailed
 information of the video frame.

 @param playerKit AgoraMediaPlayer

 @param pixelBuffer The detailed information of the video frame.
 */
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
    didReceiveVideoFrame:(CVPixelBufferRef)pixelBuffer;
/** Occurs when each time the player receives an audio frame.

 After registering the audio frame observer, the callback occurs when each
 time the player receives an audio frame, reporting the detailed
 information of the audio frame.

 @param playerKit AgoraMediaPlayer

 @param audioFrame The detailed information of the audio frame.
 */
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
    didReceiveAudioFrame:(CMSampleBufferRef)audioFrame;

/**
 Reports the playback duration that the buffered data can support.

 In the process of playing online media resources, the mediaplayer kit triggers
 this callback every one second to report the playback duration that the currently
 buffered data can support.

 - When the playback duration supported by the buffered data is less than the threshold (0 by default),
 the mediaplayer kit returns `AgoraMediaPlayerEventBufferLow(6)`.
 - When the playback duration supported by the buffered data is greater than the threshold (0 by default),
 the mediaplayer kit returns `AgoraMediaPlayerEventBufferRecover(7)`.

 @param playerKit AgoraMediaPlayer
 @param playCachedBuffer The playback duration (ms) that the buffered data can support.
 */
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
    didPlayBufferUpdated:(NSInteger)playCachedBuffer;

@end

/** The AgoraMediaStreamInfo class, reporting the whole detailed information of
 the media stream.
 */
__attribute__((visibility("default"))) @interface AgoraMediaStreamInfo : NSObject
/** The index of the media stream. */
@property(nonatomic, assign) NSInteger streamIndex;
/** The type of the media stream. See AgoraMediaStreamType for details. */
@property(nonatomic, assign) AgoraMediaStreamType streamType;
/** The codec of the media stream. */
@property(nonatomic, copy) NSString *_Nonnull codecName;
/** The language of the media stream. */
@property(nonatomic, copy) NSString *_Nullable language;
/** For video stream, gets the frame rate (fps). */
@property(nonatomic, assign) NSInteger videoFrameRate;
/** For video stream, gets the bitrate (bps). */
@property(nonatomic, assign) NSInteger videoBitRate;
/** For video stream, gets the width (pixel) of the video. */
@property(nonatomic, assign) NSInteger videoWidth;
/** For video stream, gets the height (pixel) of the video. */
@property(nonatomic, assign) NSInteger videoHeight;
/** For the audio stream, gets the sample rate (Hz). */
@property(nonatomic, assign) NSInteger audioSampleRate;
/** For the audio stream, gets the channel number. */
@property(nonatomic, assign) NSInteger audioChannels;
/** The total duration (s) of the media stream. */
@property(nonatomic, assign) NSInteger duration;
/** For video stream, gets the rotation angle of the video. */
@property(nonatomic, assign) NSInteger rotation;

@end

/** The AgoraMediaPlayer interface. */
__attribute__((visibility("default"))) @interface AgoraMediaPlayer : NSObject
/** Sets whether to mute the media resource:

* YES: Mute the media resource.
* NO: Unmute the media resource.
*/
@property(nonatomic, assign) BOOL mute;
/** The local playback volume, which ranges from 0 to 100. 0: Mute. 100: (default) The original volume. */
@property(nonatomic, assign) NSInteger volume;
/** The playback state. See AgoraMediaPlayerState */
@property(nonatomic, readonly) AgoraMediaPlayerState state;
@property(nonatomic, weak) id<AgoraMediaPlayerDelegate> _Nullable delegate;
/** Creates an AgoraMediaPlayer instance.

 @param delegate AgoraMediaPlayerDelegate

 @return The AgoraMediaPlayer instance.
 */
- (instancetype)initWithDelegate:(id<AgoraMediaPlayerDelegate>)delegate;
/** Creates an AgoraMediaPlayer instance.

 **Note**:

 - When you use the Agora RTC Native SDK and MediaPlayer Kit at the same time, if the audio scenario of the Native SDK
 is `GameStreaming(3)`, Agora recommends that you set the MediaPlayer Kit to use Remote IO and integrate the helper at the same time.
 - When you use the Agora RTC Native SDK and MediaPlayer Kit at the same time, if the audio scenario of the Native SDK
 is not `GameStreaming(3)`, Agora recommends that you set the MediaPlayer Kit to use VPIO.

 @param delegate AgoraMediaPlayerDelegate

 @param voiceChatMode Whether to enable the mode for voice chat:

 - YES: Enable the mode for voice chat. The mediaplayer kit uses VPIO.
 - NO: (Default) Disable the mode for voice chat. The mediaplayer kit uses Remote IO.

 @return The AgoraMediaPlayer instance.
*/
- (instancetype)initWithDelegate:(id<AgoraMediaPlayerDelegate>)delegate voiceChatMode:(bool)enableVoiceChatMode;

/** Sets the player's render view.

 @param view The player's render view.
 */
- (void)setView:(View *_Nullable)view;

/** Sets the player's render view.

 @param mode The player's render view. See AgoraMediaPlayerRenderMode.
 */
- (void)setRenderMode:(AgoraMediaPlayerRenderMode)mode;

/** Opens the media resource.

 @param url The path of the media resource. Both local path and online path
 are supported.

 @param startPos The starting position (ms) for playback. Default value is 0.
 */
- (void)open:(NSString *)url startPos:(NSInteger)startPos;

/** Plays the media resource.

 After opening the media resource or pausing the playback, you can call this
 method to play the media resource.
 */
- (void)play;

/** Pauses the playback.

 To resume the playback, call the play method.
 */
- (void)pause;

/** Stops the playback.
 */
- (void)stop;

/** Seeks to a new playback position.

 After successfully calling the method, you will receive the didOccurEvent
 callback, reporting the result of the seek operation to the new playback
 position.
 @param position The new playback position (ms).
 */
- (void)seekToPosition:(NSInteger)position;

/** Sets whether to mute the media resource.
 @param isMute Sets whether to mute the media resource:

 * YES: Mute the media resource.
 * NO: (default) Unmute the media resource.

 @return * 0: Success.
 * < 0: Failure. See AgoraMediaPlayerError.
 */
- (int)mute:(bool)isMute;

/** Confirms whether the media resource is muted.
 @return * If the call succeeds, returns:
  - YES: The media resource is muted.
  - NO: (default) The media resource is not muted.
 * If the call fails, returns NO.
 */
- (bool)getMute;

/** Adjusts the local playback volume.
 @param volume The local playback volume, which ranges from 0 to 100: * 0: Mute
 * 100: (default) The original volume.
 @return * 0: Success
 * < 0: Failure. See AgoraMediaPlayerError.
 */
- (int)adjustVolume:(int)volume;

/** Gets current local playback progress.
 @return * < 0: Failure. See AgoraMediaPlayerError.
 * Others: The call succeeds and returns current playback progress (ms).
 */
- (NSInteger)getPlayPosition;

/** Gets the duration of the media resource.
 @return * < 0: Failure. See AgoraMediaPlayerError.
 * Others: The call succeeds and returns the total duration (ms) of the media
 resource.
 */
- (NSInteger)getDuration;

/** Gets current playback state.

 @return * The call succeeds and returns current playback state. See
 AgoraMediaPlayerState.
 * The call fails and returns nil.
 */
- (AgoraMediaPlayerState)getPlayerState;

/** Gets the number of the media streams in the media resource.

 @return * < 0: Failure. See AgoraMediaPlayerError.
 * Others: The call succeeds and returns the number of the media streams in
 the media resource.
 */
- (NSInteger)getStreamCount;

/** Gets the detailed information of the media stream.

 @param index The index of the media stream.

 @return * If the call succeeds, returns the detailed information of the media stream. See AgoraMediaStreamInfo.
 * If the call fails and returns nil.
 */
- (AgoraMediaStreamInfo *_Nullable)getStreamByIndex:(int)index;

/** Specifies the output log files of the mediaplayer kit.

 **Note**:

 - The default log file path is `App Sandbox/Library/caches/agoraplayer.log`.
 - Ensure that you call this method immediately after creating AgoraMediaPlayer,
 otherwise the output logs may not be complete.

 @param filePath The absolute path of log files. Ensure that the directory for the log files
 exists and is writable.
 */
- (void)setLogFile:(NSString *)filePath;

/**
 Sets the output log level of the mediaplayer kit.

 You can use one or a combination of the filters. The log level follows the
 sequence of OFF, CRITICAL, ERROR, WARNING, INFO, and DEBUG. Choose a level
 to see the logs preceding that level. For example, if you set the log level to
 WARNING, you see the logs within levels CRITICAL, ERROR, and WARNING.

 @param filter Log filter level:

 - `AgoraLogFilterDebug(0x080f)`: Output all log information. Set your log filter as debug if you want to get the most complete log file.
 - `AgoraLogFilterInfo(0x000f)`: Output CRITICAL, ERROR, WARNING, and INFO level log information. We recommend setting your log filter as this level.
 - `AgoraLogFilterWarning(0x000e)`: Outputs CRITICAL, ERROR, and WARNING level log information.
 - `AgoraLogFilterError(0x000c)`: Outputs CRITICAL and ERROR level log information.
 - `AgoraLogFilterCritical(0x0008)`: Outputs CRITICAL level log information.
 - `AgoraLogFilterOff(0)`: Do not output any log information.
 */
- (void)setLogFilter:(NSInteger)filter;


/**
 Sets the private options for the MediaPlayer Kit.

 The MediaPlayer Kit supports setting private options by providing `key` and `value`.
 Under normal circumstances, you do not need to know the private option settings, and just use
 the default option settings.

 @note Calling this method before the [open]([AgoraMediaPlayer open:startPos:]) method.

 @param key key.
 @param value value.
 */
- (void)setPlayerOptionInt:(NSString *)key value:(NSInteger)value;

/**
 Sets the private options for the MediaPlayer Kit.

 The MediaPlayer Kit supports setting private options by providing `key` and `value`.
 Under normal circumstances, you do not need to know the private option settings, and just use
 the default option settings.

 @note Calling this method before the [open]([AgoraMediaPlayer open:startPos:]) method.

 @param key key.
 @param value value.
 */
- (void)setPlayerOptionString:(NSString *)key value:(NSString *)value;


/**
 Changes the playback speed.

 After opening the media file, you can call this method to change the playback speed.

 @param speed The playback speed. ref [50-400].
 */
- (void)setPlaybackSpeed:(NSInteger)speed;
/**
 Selects the audio track used during playback.

 After opening the media file, you can call this method to select the audio track used
 during playback.

 Before calling this method, call the [getStreamByIndex]([AgoraMediaPlayer getStreamByIndex:])
 method to get the audio track information of the current media stream. The
 [streamIndex]([AgoraMediaStreamInfo streamIndex]) value of the audio track information is
 the `index` value of this method.

 @param index The index of the audio track.
 */
- (void)selectAudioTrack:(NSInteger)index;

/**
 Gets the version number of the MediaPlayer Kit.

 @return The version number of the MediaPlayer Kit, such as `"1.2.1"`.
 */
- (NSString *)getPlayerSdkVersion;
/**
 Sets the loop playback.

 If you want to loop, call this method and set the number of the loops.

 When the loop playback ends, the mediaplayer kit returns
 `AgoraMediaPlayerStatePlayBackAllLoopsCompleted(6)`.

 @param loopCount The number of the loops.
 */
- (void)setLoopCount:(NSInteger)loopCount;
/** Destroys AgoraMediaPlayer.

 This method releases all resources used by the MediaPlayer Kit.
 After calling this method, you will no longer be able to use other APIs
 provided by the kit. To reuse the kit, call the
 [initWithDelegate]([AgoraMediaPlayer initWithDelegate:])
 method to re-create an AgoraMediaPlayer instance.


 **Note**：

 - This method is called synchronously. To avoid deadlock, Agora recommends
 that you do not call this method in the callback.
 - To create a new AgoraMediaPlayer instance after releasing the current one,
 ensure that you wait until the `destroy` completes executing.
 */
- (void)destroy;
/**
 Sets the external subtitle.

 After opening the media file, you can call this method set the mediaplayer kit
 to display the external subtitle.

 @param url The URL address of the external subtitle.
 Both local address and online address are supported.
*/
- (void)setExternalSubtitle:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
