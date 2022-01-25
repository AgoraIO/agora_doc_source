package io.agora.rtc2.video;

import io.agora.base.VideoFrame;
import io.agora.base.internal.CalledByNative;
import io.agora.rtc2.RtcConnection;

public interface IVideoFrameObserver {
  /**
   * Observer works as a pure renderer and will not modify the original frame.
   */
  int PROCESS_MODE_READ_ONLY = 0;

  /**
   * Observer works as a filter that will process the video frame and affect the following frame
   * processing in SDK.
   */
  int PROCESS_MODE_READ_WRITE = 1;

  /**
   * Occurs each time the SDK receives a video frame captured by the local camera.
   *
   * After you successfully register the video frame observer, the SDK triggers this callback each
   * time a video frame is received. In this callback, you can get the video data captured by the
   * local camera. You can then pre-process the data according to your scenarios.
   *
   * After pre-processing, you can send the processed video data back to the SDK by setting the
   * `videoFrame` parameter in this callback.
   *
   * @note
   * This callback does not support sending processed RGBA video data back to the SDK.
   *
   * @param videoFrame A pointer to the video frame.
   * @return
   * Determines whether to ignore the current video frame if the pre-processing fails:
   * - true: Do not ignore.
   * - false: Ignore, in which case this method does not send the current video frame to the SDK.
   */
  @CalledByNative boolean onCaptureVideoFrame(VideoFrame videoFrame);

  /**
   * Occurs each time the SDK receives a video frame captured by the screen.
   *
   * After you successfully register the video frame observer, the SDK triggers this callback each
   * time a video frame is received. In this callback, you can get the video data captured by the
   * screen. You can then pre-process the data according to your scenarios.
   *
   * After pre-processing, you can send the processed video data back to the SDK by setting the
   * `videoFrame` parameter in this callback.
   *
   * @param videoFrame A pointer to the video frame: VideoFrame
   * @return Determines whether to ignore the current video frame if the pre-processing fails:
   * - true: Do not ignore.
   * - false: Ignore, in which case this method does not sent the current video frame to the SDK.
   */
  @CalledByNative boolean onScreenCaptureVideoFrame(VideoFrame videoFrame);

  /**
   * Occurs each time the SDK receives a video frame decoded by the MediaPlayer.
   *
   * After you successfully register the video frame observer, the SDK triggers this callback each
   * time a video frame is decoded. In this callback, you can get the video data decoded by the
   * MediaPlayer. You can then pre-process the data according to your scenarios.
   *
   * After pre-processing, you can send the processed video data back to the SDK by setting the
   * `videoFrame` parameter in this callback.
   *
   * @param videoFrame A pointer to the video frame: VideoFrame
   * @param mediaPlayerId of the mediaPlayer.
   * @return Determines whether to ignore the current video frame if the pre-processing fails:
   * - true: Do not ignore.
   * - false: Ignore, in which case this method does not sent the current video frame to the SDK.
   */
  @CalledByNative boolean onMediaPlayerVideoFrame(VideoFrame videoFrame, int mediaPlayerId);

  /**
   * Occurs each time the SDK receives a video frame sent by the remote user.
   *
   * After you successfully register the video frame observer, the SDK triggers this callback each
   * time a video frame is received. In this callback, you can get the video data sent by the remote
   * user. You can then post-process the data according to your scenarios.
   *
   * After post-processing, you can send the processed data back to the SDK by setting the
   * `videoFrame` parameter in this callback.
   *
   * @note
   * This callback does not support sending processed RGBA video data back to the SDK.
   *
   * @param channelId Channel name.
   * @param uid ID of the remote user who sends the current video frame.
   * @param videoFrame A pointer to the video frame.
   * @return
   * Determines whether to ignore the current video frame if the post-processing fails:
   * - true: Do not ignore.
   * - false: Ignore, in which case this method does not send the current video frame to the SDK.
   */
  @CalledByNative boolean onRenderVideoFrame(String channelId, int uid, VideoFrame videoFrame);

  /**
   * Indicate the video frame mode of the observer.
   * @return {@link #PROCESS_MODE_READ_ONLY} or {@link #PROCESS_MODE_READ_WRITE}
   */
  @CalledByNative int getVideoFrameProcessMode();

  /*
   * Occurs each time needs to get preference video frame type.
   *
   * @return preference video pixel format.
   */
  @CalledByNative int getVideoFormatPreference();

  /**
   * Occurs each time needs to get rotation angle.
   *
   * @return rotation angle.
   */
  @CalledByNative boolean getRotationApplied();

  /**
   * Occurs each time needs to get whether mirror is applied or not.
   *
   * @return Determines whether to mirror.
   * - true: need to mirror.
   * - false: no mirror.
   */
  @CalledByNative boolean getMirrorApplied();
}
