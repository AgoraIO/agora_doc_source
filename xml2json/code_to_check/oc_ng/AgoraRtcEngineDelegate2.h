//
//  AgoraRtcEngineKit2.h
//  AgoraRtcEngineKit
//
//  Created by Sting Feng on 2015-8-11.
//  Copyright (c) 2015 Agora. All rights reserved.
//

#import "AgoraBaseDelegate.h"
#import "AgoraEnumerates.h"

@class AgoraRtcEngineKit;

@protocol AgoraRtcEngineDelegate2 <NSObject, AgoraBaseDelegate>
@optional

#pragma mark Local user common delegates
/**
 *  Event of the user joined the channel.
 *
 *  @param engine  The engine kit
 *  @param channel The channel name
 *  @param userId  The remote user id
 *  @param elapsed The elapsed time (ms) from session beginning
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didJoinChannel:(NSString * _Nonnull)channelId withUid:(NSString * _Nonnull)userId elapsed:(NSInteger) elapsed;

/**
 *  Event of the user rejoined the channel
 *
 *  @param engine  The engine kit
 *  @param channel The channel name
 *  @param userId  The user id
 *  @param elapsed The elapsed time (ms) from session beginning
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didRejoinChannel:(NSString * _Nonnull)channelId withUid:(NSString * _Nonnull)userId elapsed:(NSInteger) elapsed;

/**
 *  The network quality of local user.
 *
 *  @param engine  The engine kit
 *  @param userId     The id of user
 *  @param txQuality The sending network quality
 *  @param rxQuality The receiving network quality
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine networkQuality:(NSString * _Nonnull)userId txQuality:(AgoraNetworkQuality)txQuality rxQuality:(AgoraNetworkQuality)rxQuality;

#pragma mark Remote user common delegates
/**
 *  Event of remote user joined
 *
 *  @param engine  The engine kit
 *  @param userId  The remote user id
 *  @param elapsed The elapsed time(ms) from the beginning of the session.
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didJoinedOfUid:(NSString * _Nonnull)userId elapsed:(NSInteger)elapsed;

/**
 *  Event of remote user offlined
 *
 *  @param engine The engine kit
 *  @param userId The remote user id
 *  @param reason Reason of user offline, quit, drop or became audience
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didOfflineOfUid:(NSString * _Nonnull)userId reason:(AgoraUserOfflineReason)reason;

/**
 *  receive custom data from remote user
 *
 *  @param engine The engine kit
 *  @param userId The remote user id
 *  @param streamId The stream id
 *  @param data   The user defined data
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine receiveStreamMessageFromUid:(NSString * _Nonnull)userId streamId:(NSInteger)streamId data:(NSData * _Nonnull)data;

/**
 *  the local user has not received the data stream from the other user within 5 seconds.
 *
 *  @param engine The engine kit
 *  @param userId The remote user id
 *  @param streamId The stream id
 *  @param error    The error code
 *  @param missed   The number of lost messages
 *  @param cached   The number of incoming cached messages when the data stream is interrupted
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didOccurStreamMessageErrorFromUid:(NSString * _Nonnull)userId streamId:(NSInteger)streamId error:(NSInteger)error missed:(NSInteger)missed cached:(NSInteger)cached;

#pragma mark Local user audio delegates

/**
 *  This callback indicates local audio stream state has changed.
 *
 *  @param engine  The engine kit
 *  @param state   Stopped: The initial state
 *                 Recording: The capturer starts successfully 
 *                 Encoding: The first video frame is successfully encoded
 *                 Failed: The local video fails to start
 *  @param error   OK: The local audio is normal
 *                 Failure: No specified reason for the local audio failure.
 *                 DeviceNoPermission: No permission to use the local audio device
 *                 DeviceBusy: The microphone is in use
 *                 RecordFailure: The local audio recording fails. Check whether the recording device is working properly
 *                 EncodeFailure: The local audio encoding fails
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine localAudioStateChanged:(AgoraAudioLocalState)state error:(AgoraAudioLocalError)error;

#pragma mark Remote user audio delegates

/** The first audio frame received and decoded from the remote user.

 @param engine  The AgoraRtcEngineKit object.
 @param uid     Remote user ID.
 @param elapsed Time elapsed (ms) from calling `joinChannelByToken` until this callback is triggered.
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine firstRemoteAudioFrameOfUid:(NSString * _Nonnull)userId elapsed:(NSInteger)elapsed;

/** Occurs when the SDK decodes the first remote audio frame for playback.

 **Deprecated** . Use `AgoraAudioRemoteStateDecoding(2)` in the [remoteAudioStateChangedOfUid]([AgoraRtcEngineDelegate rtcEngine:remoteAudioStateChangedOfUid:state:reason:elapsed:]) callback instead.

 This callback is triggered in either of the following scenarios:

 - The remote user joins the channel and sends the audio stream.
 - The remote user stops sending the audio stream and re-sends it after 15 seconds. Reasons for such an interruption include:

     - The remote user leaves channel.
     - The remote user drops offline.
     - The remote user calls the [muteLocalAudioStream]([AgoraRtcEngineKit muteLocalAudioStream:]) method to stop sending the local audio stream.
     - The remote user calls the [disableAudio]([AgoraRtcEngineKit disableAudio]) method to disable audio.

 @param engine AgoraRtcEngineKit object.
 @param uid User ID of the remote user sending the audio stream.
 @param elapsed The time elapsed (ms) from the local user calling the joinChannel method until the SDK triggers this callback.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine firstRemoteAudioFrameDecodedOfUid:(NSString * _Nonnull)uid elapsed:(NSInteger)elapsed;


/**
 *  This callback indicates remote audio stream state has changed.
 *
 *  @param engine  The engine kit
 *  @param userId  The user id
 *  @param state   Stopped // The remote audio stopped, default state, audio is started or remote user disabled/muted audio stream.
 *                 Starting // The first remote audio packet is received.
 *                 Decoding  // The remote audio stream is decoded and plays normally.
 *                 Frozen // The remote audio is frozen.
 *                 Failed // The remote audio fails to start.
 *  @param reason  Interal // Internal reasons.
 *                 NetworkCongestion // Network congestion.
 *                 NetworkRecovery  // Network recovery.
 *                 LocalMuted // The local user stops receiving the remote audio stream or disables the audio module.
 *                 LocalUnmuted // The local user resumes receiving the remote audio stream or enables the audio module.
 *                 RemoteMuted // The remote user stops sending the audio stream or disables the audio module.
 *                 RemoteUnmuted // The remote user resumes sending the audio stream or enables the audio module.
 *                 Offline // The remote user leaves the channel.
 *  @param elapsed The elapsed time(ms) from the beginning of the session.
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine remoteAudioStateChangedOfUid:(NSString * _Nonnull)userId state:(AgoraAudioRemoteState)state reason:(AgoraAudioRemoteReason)reason elapsed:(NSInteger)elapsed;

/** A remote user's audio was muted or unmuted.

 @param engine AgoraRtcEngineKit object
 @param muted  Mute or unmute
 @param uid    Remote user ID
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didAudioMuted:(BOOL)muted byUid:(NSString * _Nonnull)uid;

/**
 *  The sdk reports who is active speaker in the channel
 *
 *  @param engine      The engine kit
 *  @param speakerUid  The speaker who is talking
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine activeSpeaker:(NSString * _Nonnull)speakerUid;

/**
 *  The audio quality of the user. updated every two seconds.
 *
 *  @param engine  The engine kit
 *  @param userId  The id of user
 *  @param quality The audio quality
 *  @param delay   The delay from the remote user
 *  @param lost    The percentage of lost packets
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine audioQualityOfUid:(NSString * _Nonnull)userId quality:(AgoraNetworkQuality)quality delay:(NSUInteger)delay lost:(NSUInteger)lost;

/**
  * Occurs when the audio subscribe state changed.
  *
  * @param channel The channel name of user joined.
  * @param uid The remote user ID that is subscribed to.
  * @param oldState The old state of the audio stream subscribe : #AgoraStreamSubscribeState.
  * @param newState The new state of the audio stream subscribe : #AgoraStreamSubscribeState.
  * @param elapseSinceLastState The time elapsed (ms) from the old state to the new state.
  */
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine didAudioSubscribeStateChange:(NSString * _Nonnull)channelId
              uid:(unsigned int)uid
         oldState:(AgoraStreamSubscribeState)oldState
         newState:(AgoraStreamSubscribeState)newState
elapseSinceLastState:(int)elapseSinceLastState;

/**
 * Occurs when the audio publish state changed.
 *
 * @param channel The channel name of user joined.
 * @param oldState The old state of the audio stream publish : #AgoraStreamPublishState.
 * @param newState The new state of the audio stream publish : #AgoraStreamPublishState.
 * @param elapseSinceLastState The time elapsed (ms) from the old state to the new state.
 */
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine didAudioPublishStateChange:(NSString * _Nonnull)channelId
         oldState:(AgoraStreamPublishState)oldState
         newState:(AgoraStreamPublishState)newState
elapseSinceLastState:(int)elapseSinceLastState;

#pragma mark Remote user video delegates
/**
 *  Event of the first frame of remote user is decoded successfully.
 *
 *  @param engine  The engine kit
 *  @param userId  The remote user id
 *  @param size    The size of video stream
 *  @param elapsed The elapsed time(ms) from the beginning of the session.
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine firstRemoteVideoDecodedOfUid:(NSString * _Nonnull)userId size:(CGSize)size elapsed:(NSInteger)elapsed;

/**
 *  Event of the first frame of remote user is rendering on the screen.
 *
 *  @param engine  The engine kit
 *  @param userId  The remote user id
 *  @param size    The size of video stream
 *  @param elapsed The elapsed time(ms) from the beginning of the session.
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine firstRemoteVideoFrameOfUid:(NSString * _Nonnull)userId size:(CGSize)size elapsed:(NSInteger)elapsed;

/**
 *  Event of video size changed for local or remote user
 *
 *  @param engine  The engine kit
 *  @param userId  The user id
 *  @param size    The new size of video
 *  @param rotation  The new rotate of video
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine videoSizeChangedOfUid:(NSString * _Nonnull)userId size:(CGSize)size rotation:(NSInteger)rotation;
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine contentInspectResult:(AgoraContentInspectResult)result;
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine snapshotTaken:(NSString* _Nonnull)channel uid:(NSUInteger)uid filePath:(NSString* _Nonnull)filePath width:(NSInteger)width height:(NSInteger)height errCode:(NSInteger)errCode;
/** Occurs when the local video stream state changes
 *
 * This callback indicates the state of the local video stream, including camera capturing and video encoding,
 * and allows you to troubleshoot issues when exceptions occur.
 *
 * @note For some device models, the SDK will not trigger this callback when the state of the local video changes
 * while the local video capturing device is in use, so you have to make your own timeout judgment.
 * @param engine AgoraRtcEngineKit object
 * @param state State type #AgoraVideoLocalState. When the state is AgoraVideoLocalStateFailed (3), see the `error` parameter for details.
 * @param error The detailed error information: #AgoraLocalVideoStreamError.
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine localVideoStateChangedOfState:(AgoraVideoLocalState)state
           error:(AgoraLocalVideoStreamError)error;

/**
 *  This callback indicates remote video stream state has changed.
 *
 *  @param engine  The engine kit
 *  @param userId  The user id
 *  @param state   Stopped // Default state, video is started or remote user disabled/muted video stream
                   Running // Running state, remote video can be displayed normally
                   Frozen  // Remote video is frozen, probably due to network issue.
 *  @param reason   Interal // Internal reasons.
 *                 NetworkCongestion // Network congestion.
 *                 NetworkRecovery  // Network recovery.
 *                 LocalMuted // The local user stops receiving the remote audio stream or disables the audio module.
 *                 LocalUnmuted // The local user resumes receiving the remote audio stream or enables the audio module.
 *                 RemoteMuted // The remote user stops sending the audio stream or disables the audio module.
 *                 RemoteUnmuted // The remote user resumes sending the audio stream or enables the audio module.
 *                 Offline // The remote user leaves the channel.
 *                 AudioFallback //The remote media stream falls back to the audio-only stream due to poor network conditions.
 *                 AudioFallbackRecovery  // The remote media stream switches back to the video stream after the network conditions improve.
 * @param elapsed The time elapsed (ms) from the local user calling `joinChannel` until this callback is triggered.
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine remoteVideoStateChangedOfUid:(NSString * _Nonnull)userId state:(AgoraVideoRemoteState)state reason:(AgoraVideoRemoteReason)reason elapsed:(NSInteger)elapsed;

/**
 *  Event of remote user video muted or unmuted
 *
 *  @param engine The engine kit
 *  @param muted  Muted or unmuted
 *  @param userId The remote user id
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didVideoMuted:(BOOL)muted byUid:(NSString * _Nonnull)userId;

/**
 *  Event of remote user video enabled or disabled
 *
 *  @param engine The engine kit
 *  @param enabled  Enabled or disabled
 *  @param userId   The remote user id
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didVideoEnabled:(BOOL)enabled byUid:(NSString * _Nonnull)userId;

/**
 *  Event of remote user local video enabled or disabled
 *
 *  @param engine The engine kit
 *  @param enabled  Enabled or disabled
 *  @param userId   The remote user id
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didLocalVideoEnabled:(BOOL)enabled byUid:(NSString * _Nonnull)userId;

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine publishingRequestReceivedFromUid:(NSString * _Nonnull)userId;
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine publishingRequestAnsweredByOwner:(NSString * _Nonnull)userId accepted:(BOOL)accepted error:(AgoraErrorCode)error;
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine unpublishingRequestReceivedFromOwner:(NSString * _Nonnull)userId;
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine streamInjectedStatusOfUrl:(NSString * _Nonnull)url uid:(NSString * _Nonnull)userId status:(AgoraInjectStreamStatus)status;

/** Intra request received.
 * @param engine  The AgoraRtcEngineKit object.
*/
- (void)rtcEngineIntraRequestReceived:(AgoraRtcEngineKit *_Nonnull)engine;

/** Target bitrate updated.
 * @param engine       The AgoraRtcEngineKit object.
 * @param networkInfo  The uplink network info, including target bitrate bps.
*/
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine uplinkNetworkInfoUpdate:(AgoraUplinkNetworkInfo *_Nonnull)bweInfo;

/** Downlink network info updated.
 * @param engine       The AgoraRtcEngineKit object.
 * @param networkInfo  The downlink network info.
*/
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine downlinkNetworkInfoUpdate:(AgoraDownlinkNetworkInfo *_Nonnull)networkInfo;

#pragma mark Connection state delegates

/** Occurs when the connection state of the SDK to the server is changed.
 *
 * @param state See #AgoraConnectionState.
 * @param reason See #AgoraConnectionChangedReason.
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine connectionStateChanged:(AgoraConnectionState)state reason:(AgoraConnectionChangedReason)reason;

/**
 * Occurs when the connection state of the SDK to the server is changed.
 *
 * @param engine    The AgoraRtcEngineKit object.
 * @param type See {@link AgoraNetworkType}.
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine networkTypeChanged:(AgoraNetworkType)type;

/**
 * Occurs when permission error
 *
 * @param engine    The AgoraRtcEngineKit object.
 * @param type See {@link AgoraPermissionType}.
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine permissionError:(AgoraPermissionType)type;

/** Occurs when the state of the media stream relay changes.

 The SDK reports the state of the current media relay and possible error messages in this callback.
 
 @param engine AgoraRtcEngineKit object.
 @param state The state code in [AgoraChannelMediaRelayState](AgoraChannelMediaRelayState).
 @param error The error code in [AgoraChannelMediaRelayError](AgoraChannelMediaRelayError).
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine
channelMediaRelayStateDidChange:(AgoraChannelMediaRelayState)state
            error:(AgoraChannelMediaRelayError)error;

/** Reports events during the media stream relay.
 
 @param engine AgoraRtcEngineKit object.
 @param event The event code in [AgoraChannelMediaRelayEvent](AgoraChannelMediaRelayEvent).
 */
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine
didReceiveChannelMediaRelayEvent:(AgoraChannelMediaRelayEvent)event;

/** Occurs when the video subscribe state changed.
 *
 * @param channel The channel name of user joined.
 * @param uid The remote user ID that is subscribed to.
 * @param oldState The old state of the video stream subscribe : #AgoraStreamSubscribeState.
 * @param newState The new state of the video stream subscribe : #AgoraStreamSubscribeState.
 * @param elapseSinceLastState The time elapsed (ms) from the old state to the new state.
 */
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine didVideoSubscribeStateChange:(NSString * _Nonnull)channelId
              uid:(unsigned int)uid
         oldState:(AgoraStreamSubscribeState)oldState
         newState:(AgoraStreamSubscribeState)newState
elapseSinceLastState:(int)elapseSinceLastState;

/**
 * Occurs when the video publish state changed.
 *
 * @param channel The channel name of user joined.
 * @param oldState The old state of the video stream publish : #AgoraStreamPublishState.
 * @param newState The new state of the video stream publish : #AgoraStreamPublishState.
 * @param elapseSinceLastState The time elapsed (ms) from the old state to the new state.
 */
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine didVideoPublishStateChange:(NSString * _Nonnull)channelId
         oldState:(AgoraStreamPublishState)oldState
         newState:(AgoraStreamPublishState)newState
elapseSinceLastState:(int)elapseSinceLastState;

#pragma mark Rhythm Player Delegates Methods

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didRhythmPlayerStateChanged:(AgoraRhythmPlayerState)state
        errorCode:(AgoraRhythmPlayerError)errorCode;
@end
