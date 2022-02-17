//
//  AgoraRtcEngineKit.h
//  AgoraRtcEngineKit
//
//  Created by Sting Feng on 2015-8-11.
//  Copyright (c) 2015 Agora. All rights reserved.
//

@class AgoraRtcEngineKit;
#import "AgoraObjects.h"

@protocol AgoraBaseDelegate <NSObject>
@optional
#pragma mark SDK common delegates

#pragma mark String UID

/** Occurs when the local user successfully registers a user account by calling the
 * This callback reports the user ID and user account of the local user.
 * @param uid The ID of the local user.
 * @param userAccount The user account of the local user.
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didLocalUserRegisteredWithUserId:(NSUInteger)uid userAccount:(NSString * _Nonnull)userAccount;

/** Occurs when the SDK gets the user ID and user account of the remote user.
 
 * After a remote user joins the channel, the SDK gets the UID and user account of the remote user,
 * caches them in a mapping table object (`userInfo`), and triggers this callback on the local client.
 
 * @param uid The ID of the remote user.
 * @param info The `AgoraUserInfo` object that contains the user ID and user account of the remote user.
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didUserInfoUpdatedWithUserId:(NSUInteger)uid userInfo:(AgoraUserInfo* _Nonnull)userInfo;

/**
 *  The warning occurred in SDK. The APP could igonre the warning, and the SDK could try to resume automically.
 *
 *  @param engine      The engine kit
 *  @param warningCode The warning code
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didOccurWarning:(AgoraWarningCode)warningCode;

/**
 *  The error occurred in SDK. The SDK couldn't resume to normal state, and the app need to handle it.
 *
 *  @param engine    The engine kit
 *  @param errorCode The error code
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didOccurError:(AgoraErrorCode)errorCode;

/**
 *  Event of load media engine success
 *
 *  @param engine The engine kit
 */
- (void)rtcEngineMediaEngineDidLoaded:(AgoraRtcEngineKit * _Nonnull)engine;

/**
 *  Event of media engine start call success
 *
 *  @param engine The engine kit
 */
- (void)rtcEngineMediaEngineDidStartCall:(AgoraRtcEngineKit * _Nonnull)engine;

/**
 * when token is enabled, and specified token is invalid or expired, this function will be called.
 * APP should generate a new token and call renewToken() to refresh the token.
 * NOTE: to be compatible with previous version, ERR_TOKEN_EXPIRED and ERR_INVALID_TOKEN are also reported via onError() callback.
 * You should move renew of token logic into this callback.
 *  @param engine The engine kit
 */
- (void)rtcEngineRequestToken:(AgoraRtcEngineKit * _Nonnull)engine;

/**
 *  Event of disconnected with server. This event is reported at the moment SDK loses connection with server.
 *  In the mean time SDK automatically tries to reconnect with the server until APP calls leaveChannel.
 *
 *  @param engine The engine kit
 */
- (void)rtcEngineConnectionDidInterrupted:(AgoraRtcEngineKit * _Nonnull)engine;

/**
 *  Event of loss connection with server. This event is reported after the connection is interrupted and exceed the retry period (10 seconds by default).
 *  In the mean time SDK automatically tries to reconnect with the server until APP calls leaveChannel.
 *
 *  @param engine The engine kit
 */
- (void)rtcEngineConnectionDidLost:(AgoraRtcEngineKit * _Nonnull)engine;

/**
 *  Event of connection banned by server. This event is reported after the connection is banned by server.
 *  In the mean time SDK will not try to reconnect the server.
 */
- (void)rtcEngineConnectionDidBanned:(AgoraRtcEngineKit * _Nonnull)engine;

/**
 *  Statistics of rtc engine status. Updated every two seconds.
 *
 *  @param engine The engine kit
 *  @param stats  The statistics of rtc status, including duration, sent bytes and received bytes
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine reportRtcStats:(AgoraChannelStats * _Nonnull)stats;

/**
 *  The network quality of lastmile test.
 *
 *  @param engine  The engine kit
 *  @param quality The network quality
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine lastmileQuality:(AgoraNetworkQuality)quality;

/**
 * Reports the last-mile network probe result.
 *
 * The SDK triggers this callback within 30 seconds after the app calls the [startLastmileProbeTest]([AgoraRtcEngineKit startLastmileProbeTest:]) method.
 *
 * @param engine AgoraRtcEngineKit object.
 * @param result The uplink and downlink last-mile network probe test result, see [AgoraLastmileProbeResult](AgoraLastmileProbeResult).
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine lastmileProbeTestResult:(AgoraLastmileProbeResult * _Nonnull)result;

/**
 *  Event of API call executed
 *
 *  @param engine The engine kit
 *  @param api    The API description
 *  @param error  The error code
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didApiCallExecute:(NSInteger)error api:(NSString * _Nonnull)api result:(NSString * _Nonnull)result;

/**
 *  This callback returns the status code after executing the refreshRecordingServiceStatus method successfully.
 *
 *  @param engine The engine kit
 *  @param status 0：Recording is stopped. 1：Recording is ongoing.
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didRefreshRecordingServiceStatus:(NSInteger)status;

#if (!(TARGET_OS_IPHONE) && (TARGET_OS_MAC))
/**
 *  the notificaitoin of device added removed
 *
 *  @param engine The engine kit
 *  @param deviceId   the identification of device
 *  @param deviceType type of device: -1: audio unknown; 0: audio recording ; 1: audio playout ; 2: render; 4: capture
 *  @param state      state of device: 0: added; 1: removed
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine device:(NSString * _Nonnull) deviceId type:(AgoraMediaDeviceType) deviceType stateChanged:(NSInteger) state;

#endif

/**
 *  An error of encryption occurred during SDK runtime.
 *
 *  @param errorType AgoraEncryptionErrorType
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didOccurEncryptionError:(AgoraEncryptionErrorType)errorType;
/**
   * Reports the user log upload result
   * @param requestId RequestId of the upload
   * @param success Is upload success
   * @param reason Reason of the upload, 0: OK, 1 Network Error, 2 Server Error.
   */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine uploadLogResultRequestId:(NSString * _Nonnull)requestId success:(BOOL)success reason:(AgoraUploadErrorReason)reason;

#pragma mark Local user common delegates

/**
 *  Event of cient role change. only take effect under broadcasting mode
 *
 *  @param engine The engine kit
 *  @param oldRole the previous role
 *  @param newRole the new role
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didClientRoleChanged:(AgoraClientRole)oldRole newRole:(AgoraClientRole)newRole;

/**
 *  The statistics of the call when leave channel
 *
 *  @param engine The engine kit
 *  @param stats  The statistics of the call, including duration, sent bytes and received bytes
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didLeaveChannelWithStats:(AgoraChannelStats * _Nonnull)stats;

#pragma mark Local user audio delegates
/**
 *  Event of the first audio frame is sent.
 *
 *  @param engine  The engine kit
 *  @param elapsed The elapsed time(ms) from the beginning of the session.
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine firstLocalAudioFramePublished:(NSInteger)elapsed;

/** The statistics of the local audio stream.

 Same as [localAudioStatBlock]([AgoraRtcEngineKit localAudioStatBlock:]). The SDK updates the application on the statistics of the local audio stream once every two seconds.

 * @param engine The AgoraRtcEngineKit object.
 * @param stats  AgoraRtcLocalAudioStats
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine localAudioStats:(AgoraRtcLocalAudioStats * _Nonnull)stats;

/**
 *  Event of local audio route changed
 *
 *  @param engine The engine kit
 *  @param routing the current audio output routing
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didAudioRouteChanged:(AgoraAudioOutputRouting)routing;

/**
 *  Event of finish audio mixing.
 *
 *  @param engine The engine kit
 */
- (void)rtcEngineLocalAudioMixingDidFinish:(AgoraRtcEngineKit * _Nonnull)engine;

/** Audio mixing state changed.

 * @param engine  The AgoraRtcEngineKit object.
 * @param state  AgoraAudioMixingStateType
 * @param errorCode  AgoraAudioMixingErrorType
 */
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine audioMixingStateChanged:(AgoraAudioMixingStateType)state
                                                                    errorCode:(AgoraAudioMixingErrorType)errorCode;

/**
 *  Event of finish audio effect.
 *
 *  @param engine The engine kit
 */
- (void)rtcEngineDidAudioEffectFinish:(AgoraRtcEngineKit * _Nonnull)engine soundId:(int)soundId;


#pragma mark Local user video delegates
/**
 *  Event of camera opened
 *
 *  @param engine The engine kit
 */
- (void)rtcEngineCameraDidReady:(AgoraRtcEngineKit * _Nonnull)engine;

#if TARGET_OS_IPHONE
/**
 *  Event of camera focus position changed
 *
 *  @param engine The engine kit
 *  @param rect   The focus rect in local preview
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine cameraFocusDidChangedToRect:(CGRect)rect;

/** A camera exposure position changed.

 @param engine AgoraRtcEngineKit object
 @param rect   Exposure rectangle in the local preview
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine cameraExposureDidChangedToRect:(CGRect)rect;

#endif

/**
 *  Event of camera stopped
 *
 *  @param engine The engine kit
 */
- (void)rtcEngineVideoDidStop:(AgoraRtcEngineKit * _Nonnull)engine;

/** Event of the first local video frame is published.
 *  @param engine  The engine kit
 *  @param elapsed The elapsed time(ms) from the beginning of the session.
 *
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine firstLocalVideoFramePublishedWithElapsed:(NSInteger)elapsed;

/**
 *  Event of the first local frame starts rendering on the screen.
 *
 *  @param engine  The engine kit
 *  @param size    The size of local video stream
 *  @param elapsed The elapsed time(ms) from the beginning of the session.
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine firstLocalVideoFrameWithSize:(CGSize)size elapsed:(NSInteger)elapsed;

/**
 *  The statistics of local video stream. Update every two seconds.
 *
 *  @param engine        The engine kit
 *  @param stats         The statistics of local video, including sent bitrate, sent framerate
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine localVideoStats:(AgoraRtcLocalVideoStats * _Nonnull)stats;

#pragma mark Remote user audio delegates

/**
 *  The sdk reports the volume of a speaker. The interface is disable by default, and it could be enable by API "enableAudioVolumeIndication"
 *
 *  @param engine      The engine kit
 *  @param speakers    AgoraRtcAudioVolumeInfo array
 *  @param totalVolume The total volume of speakers
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine reportAudioVolumeIndicationOfSpeakers:(NSArray<AgoraRtcAudioVolumeInfo *> * _Nonnull)speakers totalVolume:(NSInteger)totalVolume;

/**
 *  Event of remote start audio mixing.
 *
 *  @param engine The engine kit
 */
- (void)rtcEngineRemoteAudioMixingDidStart:(AgoraRtcEngineKit * _Nonnull)engine;

/**
 *  Event of remote finish audio mixing.
 *
 *  @param engine The engine kit
 */
- (void)rtcEngineRemoteAudioMixingDidFinish:(AgoraRtcEngineKit * _Nonnull)engine;

/**
 *  The statistics of remote audio stream. Update every two seconds.
 *
 *  @param engine            The engine kit
 *  @param stats             The statistics of audio video, including user id, delay, resolution, received bitrate, received framerate, audio stream type
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine remoteAudioStats:(AgoraRtcRemoteAudioStats * _Nonnull)stats;

#pragma mark Remote user video delegates

/**
 *  The statistics of remote video stream. Update every two seconds.
 *
 *  @param engine            The engine kit
 *  @param stats             The statistics of remote video, including user id, delay, resolution, received bitrate, received framerate, video stream type
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine remoteVideoStats:(AgoraRtcRemoteVideoStats * _Nonnull)stats;

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine rtmpStreamingChangedToState:(NSString * _Nonnull)url
                                                                    state:(AgoraRtmpStreamPublishState)state
                                                                  errCode:(AgoraRtmpStreamPublishError)errCode;

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine streamPublishedWithUrl:(NSString * _Nonnull)url errorCode:(AgoraErrorCode)errorCode;

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine streamUnpublishedWithUrl:(NSString * _Nonnull)url;

- (void)rtcEngineTranscodingUpdated:(AgoraRtcEngineKit * _Nonnull)engine;

@end

/*

- (int)joinChannelByToken:(NSString * _Nullable)token
         channelId:(NSString * _Nonnull)channelId
        info:(NSString * _Nullable)info
     userId:(NSString * _Nullable)userId;
 
- (int)setRemoteRenderModeWithUid:(NSString * _Nonnull)userId
              mode:(AgoraVideoRenderMode) mode;
 
- (int)switchView:(NSString * _Nonnull)userId1
       andAnother:(NSString * _Nonnull)userId2 __deprecated;

- (int)muteRemoteAudioStream:(NSString * _Nonnull)userId mute:(BOOL)mute;

- (int)setRemoteVideoStream:(NSString * _Nonnull)userId
                       type:(AgoraVideoStreamType)streamType;
- (int)muteRemoteVideoStream:(NSString * _Nonnull)userId
                        mute:(BOOL)mute;

- (void)setRemoteVideoRenderer:(id<AgoraVideoSinkProtocol> _Nullable)videoRenderer withUserId:(NSString * _Nonnull)userId;

- (int)sendPublishingRequestToOwner:(NSString * _Nonnull) userId;
- (int)answerPublishingRequestOfUid:(NSString * _Nonnull) userId accepted:(bool)accepted;
- (int)sendUnpublishingRequestToUid:(NSString * _Nonnull) userId;

- (id<AgoraVideoSinkProtocol> _Nullable)remoteVideoRendererOfUserId:(NSString * _Nonnull)userId;
*/
