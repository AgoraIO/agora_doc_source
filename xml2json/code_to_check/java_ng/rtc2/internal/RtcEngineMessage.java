package io.agora.rtc2.internal;

import android.text.TextUtils;
import io.agora.base.internal.CalledByNative;
import io.agora.rtc2.ChannelMediaOptions;
import io.agora.rtc2.IRtcEngineEventHandler;
import io.agora.rtc2.live.LiveInjectStreamConfig;
import io.agora.rtc2.live.LiveTranscoding;
import io.agora.rtc2.video.AgoraImage;
import io.agora.rtc2.video.ContentInspectConfig;
import io.agora.rtc2.video.EncodedVideoFrameInfo;
import io.agora.rtc2.video.VideoCompositingLayout;
import java.util.ArrayList;

public class RtcEngineMessage {
  public static class PMediaResAudioQuality extends Marshallable {
    int uid;
    int quality;
    short delay;
    short lost;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
      quality = popInt();
      delay = popShort();
      lost = popShort();
    }
  }

  public static class PMediaResTransportQuality extends Marshallable {
    public boolean isAudio;
    public int uid;
    public int bitrate;
    public short delay;
    public short lost;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      isAudio = popBool();
      uid = popInt();
      bitrate = popInt();
      delay = popShort();
      lost = popShort();
    }
  }

  public static class PMediaResRtcStats extends Marshallable {
    int totalDuration;
    int totalTxBytes;
    int totalRxBytes;
    int txKBitRate;
    int rxKBitRate;
    int txAudioBytes;
    int rxAudioBytes;
    int txVideoBytes;
    int rxVideoBytes;
    int txAudioKBitRate;
    int rxAudioKBitRate;
    int txVideoKBitRate;
    int rxVideoKBitRate;
    int lastmileDelay;
    int txPacketLossRate;
    int rxPacketLossRate;
    int cpuTotalUsage;
    int gatewayRtt;
    int cpuAppUsage;
    double memoryAppUsageRatio;
    double memoryTotalUsageRatio;
    int memoryAppUsageInKbytes;
    int users;
    int connectTimeMs;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      totalDuration = popInt();
      totalTxBytes = popInt();
      totalRxBytes = popInt();
      txAudioBytes = popInt();
      rxAudioBytes = popInt();
      txVideoBytes = popInt();
      rxVideoBytes = popInt();
      txKBitRate = popShort();
      rxKBitRate = popShort();
      txAudioKBitRate = popShort();
      rxAudioKBitRate = popShort();
      txVideoKBitRate = popShort();
      rxVideoKBitRate = popShort();
      lastmileDelay = popShort();
      txPacketLossRate = popInt();
      rxPacketLossRate = popInt();
      cpuTotalUsage = popInt();
      gatewayRtt = popInt();
      cpuAppUsage = popInt();
      memoryAppUsageRatio = popDouble();
      memoryTotalUsageRatio = popDouble();
      memoryAppUsageInKbytes = popInt();
      users = popInt();
      connectTimeMs = popInt();
    }
  }

  public static class PMediaResJoinMedia extends Marshallable {
    public String channel;
    public int uid;
    public int elapsed;
    public boolean firstSuccess;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      channel = popString16UTF8();
      uid = popInt();
      elapsed = popInt();
      firstSuccess = popBool();
    }
  }

  public static class PMediaResUserJoinedEvent extends Marshallable {
    int uid;
    int elapsed;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
      elapsed = popInt();
    }
  }

  public static class PMediaResUserOfflineEvent extends Marshallable {
    int uid;
    int reason;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
      reason = popInt();
    }
  }
  public static class PMediaResUserState extends Marshallable {
    int uid;
    boolean state;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
      state = popBool();
    }
  }

  public static class PMediaResNetworkQuality extends Marshallable {
    int uid;
    int txQuality;
    int rxQuality;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
      txQuality = popInt();
      rxQuality = popInt();
    }
  }

  public static class PMediaResLastmileQuality extends Marshallable {
    int quality;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      quality = popInt();
    }
  }

  public static class PMediaResLastmileProbeResult extends Marshallable {
    public static class LastmileProbeOneWayResult {
      public int packetLossRate;
      public int jitter;
      public int availableBandwidth;
    }

    short state;
    int rtt;
    LastmileProbeOneWayResult uplinkReport;
    LastmileProbeOneWayResult downlinkReport;

    public byte[] marshall() {
      pushShort(state);
      pushInt(uplinkReport.packetLossRate);
      pushInt(uplinkReport.jitter);
      pushInt(uplinkReport.availableBandwidth);
      pushInt(downlinkReport.packetLossRate);
      pushInt(downlinkReport.jitter);
      pushInt(downlinkReport.availableBandwidth);
      pushInt(rtt);
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      state = popShort();
      uplinkReport = new LastmileProbeOneWayResult();
      downlinkReport = new LastmileProbeOneWayResult();
      uplinkReport.packetLossRate = popInt();
      uplinkReport.jitter = popInt();
      uplinkReport.availableBandwidth = popInt();
      downlinkReport.packetLossRate = popInt();
      downlinkReport.jitter = popInt();
      downlinkReport.availableBandwidth = popInt();
      rtt = popInt();
    }
  }

  public static class PMediaResAudioEffectFinished extends Marshallable {
    int soundId;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      soundId = popInt();
    }
  }

  public static class PMediaResSpeakersReport extends Marshallable {
    public static class Speaker {
      public int uid;
      public int volume;
      public int vad;
      public double voicePitch;
    }

    int mixVolume;
    Speaker[] speakers;

    public byte[] marshall() {
      pushInt(mixVolume);
      int len = speakers.length;
      pushShort((short) len);
      for (int i = 0; i < len; i++) {
        pushInt(speakers[i].uid);
        pushInt(speakers[i].volume);
        pushInt(speakers[i].vad);
        pushDouble(speakers[i].voicePitch);
      }
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      mixVolume = popInt();
      int len = popShort();
      if (len > 0) {
        speakers = new Speaker[len];
        for (int i = 0; i < len; i++) {
          speakers[i] = new Speaker();
          speakers[i].uid = popInt();
          speakers[i].volume = popInt();
          speakers[i].vad = popInt();
          speakers[i].voicePitch = popDouble();
        }
      }
    }
  }

  public static class PVideoNetOptions extends Marshallable {
    short width;
    short height;
    short frameRate;
    short bitrate;

    public void marshall(Marshallable m) {
      m.pushShort(width);
      m.pushShort(height);
      m.pushShort(frameRate);
      m.pushShort(bitrate);
    }

    public byte[] marshall() {
      marshall(this);
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      width = popShort();
      height = popShort();
      frameRate = popShort();
      bitrate = popShort();
    }
  }
  public static class PRemoteVideoStat extends Marshallable {
    public IRtcEngineEventHandler.RemoteVideoStats stats =
        new IRtcEngineEventHandler.RemoteVideoStats();

    @Override
    public byte[] marshall() {
      pushInt(stats.uid);
      pushInt(stats.delay);
      pushInt(stats.width);
      pushInt(stats.height);
      pushInt(stats.receivedBitrate);
      pushInt(stats.decoderOutputFrameRate);
      pushInt(stats.rendererOutputFrameRate);
      pushInt(stats.frameLossRate);
      pushInt(stats.packetLossRate);
      pushInt(stats.rxStreamType);
      pushInt(stats.totalFrozenTime);
      pushInt(stats.frozenRate);
      pushInt(stats.avSyncTimeMs);
      pushInt64(stats.totalActiveTime);
      pushInt64(stats.publishDuration);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      stats.uid = popInt();
      stats.delay = popInt();
      stats.width = popInt();
      stats.height = popInt();
      stats.receivedBitrate = popInt();
      stats.decoderOutputFrameRate = popInt();
      stats.rendererOutputFrameRate = popInt();
      stats.frameLossRate = popInt();
      stats.packetLossRate = popInt();
      stats.rxStreamType = popInt();
      stats.totalFrozenTime = popInt();
      stats.frozenRate = popInt();
      stats.avSyncTimeMs = popInt();
      stats.totalActiveTime = popInt64();
      stats.publishDuration = popInt64();
    }
  }

  public static class PLocalVideoStat extends Marshallable {
    public IRtcEngineEventHandler.LocalVideoStats stats =
        new IRtcEngineEventHandler.LocalVideoStats();

    @Override
    public byte[] marshall() {
      pushInt(stats.uid);
      pushInt(stats.sentBitrate);
      pushInt(stats.sentFrameRate);
      pushInt(stats.encoderOutputFrameRate);
      pushInt(stats.rendererOutputFrameRate);
      pushInt(stats.targetBitrate);
      pushInt(stats.targetFrameRate);
      pushInt(stats.encodedBitrate);
      pushInt(stats.encodedFrameWidth);
      pushInt(stats.encodedFrameHeight);
      pushInt(stats.encodedFrameCount);
      pushInt(stats.codecType);
      pushInt(stats.qualityAdaptIndication);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      stats.uid = popInt();
      stats.sentBitrate = popInt();
      stats.sentFrameRate = popInt();
      stats.encoderOutputFrameRate = popInt();
      stats.rendererOutputFrameRate = popInt();
      stats.targetBitrate = popInt();
      stats.targetFrameRate = popInt();
      stats.encodedBitrate = popInt();
      stats.encodedFrameWidth = popInt();
      stats.encodedFrameHeight = popInt();
      stats.encodedFrameCount = popInt();
      stats.codecType = popInt();
      stats.qualityAdaptIndication = popInt();
    }
  }

  public static class PRemoteAudioStat extends Marshallable {
    public IRtcEngineEventHandler.RemoteAudioStats stats =
        new IRtcEngineEventHandler.RemoteAudioStats();

    @Override
    public byte[] marshall() {
      pushInt(stats.uid);
      pushInt(stats.quality);
      pushInt(stats.networkTransportDelay);
      pushInt(stats.jitterBufferDelay);
      pushInt(stats.audioLossRate);
      pushInt(stats.numChannels);
      pushInt(stats.receivedSampleRate);
      pushInt(stats.receivedBitrate);
      pushInt(stats.totalFrozenTime);
      pushInt(stats.frozenRate);
      pushInt(stats.mosValue);
      pushInt64(stats.totalActiveTime);
      pushInt64(stats.publishDuration);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      stats.uid = popInt();
      stats.quality = popInt();
      stats.networkTransportDelay = popInt();
      stats.jitterBufferDelay = popInt();
      stats.audioLossRate = popInt();
      stats.numChannels = popInt();
      stats.receivedSampleRate = popInt();
      stats.receivedBitrate = popInt();
      stats.totalFrozenTime = popInt();
      stats.frozenRate = popInt();
      stats.mosValue = popInt();
      stats.totalActiveTime = popInt64();
      stats.publishDuration = popInt64();
    }
  }
  public static class PContentInspectResult extends Marshallable {
    public int result;

    @Override
    public byte[] marshall() {
      pushInt(result);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      result = popInt();
    }
  }
  public static class PSnapshotTaken extends Marshallable {
    public String channel;
    public int uid;
    public String filepath;
    public int width;
    public int height;
    public int errCode;

    @Override
    public byte[] marshall() {
      pushBytes(channel.getBytes());
      pushInt(uid);
      pushBytes(filepath.getBytes());
      pushInt(width);
      pushInt(height);
      pushInt(errCode);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      channel = popString16UTF8();
      uid = popInt();
      filepath = popString16UTF8();
      width = popInt();
      height = popInt();
      errCode = popInt();
    }
  }
  public static class PLocalAudioStat extends Marshallable {
    public IRtcEngineEventHandler.LocalAudioStats stats =
        new IRtcEngineEventHandler.LocalAudioStats();

    @Override
    public byte[] marshall() {
      pushInt(stats.numChannels);
      pushInt(stats.sentSampleRate);
      pushInt(stats.sentBitrate);
      pushInt(stats.internalCodec);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      stats.numChannels = popInt();
      stats.sentSampleRate = popInt();
      stats.sentBitrate = popInt();
      stats.internalCodec = popInt();
    }
  }

  public static class PFirstRemoteAudioFrame extends Marshallable {
    public int uid;
    public int elapsed;

    @Override
    public byte[] marshall() {
      pushInt(uid);
      pushInt(elapsed);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
      elapsed = popInt();
    }
  }

  public static class PFirstRemoteAudioDecoded extends Marshallable {
    public int uid;
    public int elapsed;

    @Override
    public byte[] marshall() {
      pushInt(uid);
      pushInt(elapsed);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
      elapsed = popInt();
    }
  }

  public static class PFirstRemoteVideoFrame extends Marshallable {
    public int uid;
    public int width;
    public int height;
    public int elapsed;

    @Override
    public byte[] marshall() {
      pushInt(uid);
      pushInt(width);
      pushInt(height);
      pushInt(elapsed);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
      width = popInt();
      height = popInt();
      elapsed = popInt();
    }
  }

  public static class PFirstLocalVideoFrame extends Marshallable {
    // DECLARE_MARSHALLABLE_3(MediaLocalFirstVideoFrame, int,width, int,height, int,elapsed)
    public int width;
    public int height;
    public int elapsed;

    @Override
    public byte[] marshall() {
      pushInt(width);
      pushInt(height);
      pushInt(elapsed);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      width = popInt();
      height = popInt();
      elapsed = popInt();
    }
  }

  public static class PFirstRemoteVideoDecoded extends Marshallable {
    public int uid;
    public int width;
    public int height;
    public int elapsed;

    @Override
    public byte[] marshall() {
      pushInt(uid);
      pushInt(width);
      pushInt(height);
      pushInt(elapsed);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
      width = popInt();
      height = popInt();
      elapsed = popInt();
    }
  }

  public static class PCameraFocusAreaChanged extends Marshallable {
    public int x;
    public int y;
    public int width;
    public int height;

    @Override
    public byte[] marshall() {
      pushInt(x);
      pushInt(y);
      pushInt(width);
      pushInt(height);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      x = popInt();
      y = popInt();
      width = popInt();
      height = popInt();
    }
  }

  public static class PCameraExposureAreaChanged extends Marshallable {
    public int x;
    public int y;
    public int width;
    public int height;

    @Override
    public byte[] marshall() {
      pushInt(x);
      pushInt(y);
      pushInt(width);
      pushInt(height);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      x = popInt();
      y = popInt();
      width = popInt();
      height = popInt();
    }
  }

  public static class PFacePositionChanged extends Marshallable {
    public static class FaceRect {
      public int x;
      public int y;
      public int width;
      public int height;
    }

    public int imageWidth;
    public int imageHeight;
    FaceRect[] rectArr = null;
    int[] disArr = null;
    public int num;

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);

      imageWidth = popInt();
      imageHeight = popInt();

      int lenRect = popShort();
      if (lenRect > 0) {
        rectArr = new FaceRect[lenRect];

        for (int i = 0; i < lenRect; i++) {
          rectArr[i] = new FaceRect();
          rectArr[i].x = popInt();
          rectArr[i].y = popInt();
          rectArr[i].width = popInt();
          rectArr[i].height = popInt();
        }
      }

      int lenDistance = popShort();
      if (lenDistance > 0) {
        disArr = new int[lenDistance];

        for (int i = 0; i < lenDistance; i++) {
          disArr[i] = popInt();
        }
      }
    }
  }

  public static class PVideoSizeChanged extends Marshallable {
    public int uid;
    public int width;
    public int height;
    public int rotation;

    @Override
    public byte[] marshall() {
      pushInt(uid);
      pushInt(width);
      pushInt(height);
      pushInt(rotation);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
      width = popInt();
      height = popInt();
      rotation = popInt();
    }
  }
  public static class PMediaEngineEvent extends Marshallable {
    int code;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      code = popInt();
    }
  }

  public static class PError extends Marshallable {
    public int err;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      err = popInt();
    }
  }

  public static class PApiCallExecuted extends Marshallable {
    public int error;
    public String api;
    public String result;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      error = popInt();
      api = popString16UTF8();
      result = popString16UTF8();
    }
  }

  public static class PStreamMessage extends Marshallable {
    int uid;
    int streamId;
    long sentTs;
    byte[] payload;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
      streamId = popInt();
      sentTs = popInt64();
      payload = popBytes();
    }
  }
  public static class PStreamMessageError extends Marshallable {
    int uid;
    int streamId;
    int error;
    int missed;
    int cached;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
      streamId = popInt();
      error = popInt();
      missed = popInt();
      cached = popInt();
    }
  }
  public static class PRecordingServiceStatus extends Marshallable {
    public int status;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      status = popInt();
    }
  }
  public static long toIntegerUserId(int uid) {
    return uid & 0xffffffffL;
  }
  public static String toStringUserId(int uid) {
    return String.valueOf(toIntegerUserId(uid));
  }
  public static int toIntegerUserId(String userId) {
    try {
      if (userId != null)
        return (int) Long.parseLong(userId);
    } catch (Exception e) {
    }
    return 0;
  }

  public static class PVideoCompositingLayout extends Marshallable {
    private static final short SERVER_TYPE = 0;
    private static final short URI = 20;
    private void marshallRegion(Marshallable m, VideoCompositingLayout.Region region) {
      m.pushInt(region.uid);
      if (!TextUtils.isEmpty(region.userId)) {
        m.pushBytes(region.userId.getBytes());
      } else {
        m.pushBytes("".getBytes());
      }
      // m.pushBytes(toStringUserId(region.uid).getBytes());
      m.pushDouble(region.x);
      m.pushDouble(region.y);
      m.pushDouble(region.width);
      m.pushDouble(region.height);
      m.pushInt(region.zOrder);
      m.pushDouble(region.alpha);
      m.pushInt(region.renderMode);
    }
    private void marshall(Marshallable m, VideoCompositingLayout layout) {
      m.pushShort(SERVER_TYPE);
      m.pushShort(URI);
      m.pushInt(layout.canvasWidth);
      m.pushInt(layout.canvasHeight);
      // background color
      if (layout.backgroundColor != null)
        m.pushBytes(layout.backgroundColor.getBytes());
      else
        m.pushBytes("".getBytes());
      // app data
      if (layout.appData != null)
        m.pushBytes(layout.appData);
      else
        m.pushBytes("".getBytes());

      // users
      m.pushShort((short) layout.regions.length);
      for (int i = 0; i < layout.regions.length; i++) {
        marshallRegion(m, layout.regions[i]);
      }
    }

    public byte[] marshall(VideoCompositingLayout layout) {
      marshall(this, layout);
      return super.marshall();
    }
  }

  public static class PFirstLocalAudioFrame extends Marshallable {
    public int elapsed;

    @Override
    public byte[] marshall() {
      pushInt(elapsed);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      elapsed = popInt();
    }
  }
  public static class PActiveSpeaker extends Marshallable {
    public int uid;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
    }
  }
  public static class PClientRoleChanged extends Marshallable {
    int oldRole;
    int newRole;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      oldRole = popInt();
      newRole = popInt();
    }
  }

  public static class PStreamPublishState extends Marshallable {
    public String url;
    public int state;
    public int error;

    public byte[] marshall() {
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      url = popString16UTF8();
      state = popInt();
      error = popInt();
    }
  }

  public static class PStreamPublished extends Marshallable {
    public String url;
    public int error;

    public byte[] marshall() {
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      url = popString16UTF8();
      error = popInt();
    }
  }

  public static class PStreamUnPublished extends Marshallable {
    public String url;

    public byte[] marshall() {
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      url = popString16UTF8();
    }
  }

  public static class PLiveTranscoding extends Marshallable {
    private static final short SERVER_TYPE = 0;
    private static final short URI = 23;

    private void marshallUserConfig(Marshallable m, LiveTranscoding.TranscodingUser user) {
      m.pushInt(user.uid);
      String userId = user.userId;
      if (userId == null)
        userId = "";
      pushBytes(userId.getBytes());
      m.pushInt(user.x);
      m.pushInt(user.y);
      m.pushInt(user.width);
      m.pushInt(user.height);
      m.pushInt(user.zOrder);
      m.pushDouble(user.alpha);
      m.pushInt(user.audioChannel);
    }

    private void marshallImage(Marshallable m, AgoraImage image) {
      m.pushString16(image.url);
      m.pushInt(image.x);
      m.pushInt(image.y);
      m.pushInt(image.width);
      m.pushInt(image.height);
      m.pushInt(image.zOrder);
    }

    private void marshallWatermark(Marshallable m, LiveTranscoding transcoding) {
      // add original attribute: watermark
      ArrayList<AgoraImage> watermarkList = new ArrayList<AgoraImage>();
      if (transcoding.watermark != null && transcoding.watermark.url != null) {
        watermarkList.add(transcoding.watermark);
      }
      // watermarkCount will calculate all watermark, contains watermark and watermarkList
      if (transcoding.getWatermarkList() != null && !transcoding.getWatermarkList().isEmpty()) {
        watermarkList.addAll(transcoding.getWatermarkList());
      }

      pushShort((short) watermarkList.size());
      for (AgoraImage watermark : watermarkList) {
        marshallImage(m, watermark);
      }
    }

    private void marshallBackgroundImage(Marshallable m, LiveTranscoding transcoding) {
      // add original attribute: backgroundImage
      ArrayList<AgoraImage> backgroundImageList = new ArrayList<AgoraImage>();
      if (transcoding.backgroundImage != null && transcoding.backgroundImage.url != null) {
        backgroundImageList.add(transcoding.backgroundImage);
      }
      // backgroundImageCount will calculate all backgroundImage, contains backgroundImage and
      // backgroundImageList
      if (transcoding.getBackgroundImageList() != null
          && !transcoding.getBackgroundImageList().isEmpty()) {
        backgroundImageList.addAll(transcoding.getBackgroundImageList());
      }

      pushShort((short) backgroundImageList.size());
      for (AgoraImage backgroundImage : backgroundImageList) {
        marshallImage(m, backgroundImage);
      }
    }

    private void marshall(Marshallable m, LiveTranscoding transcoding) {
      m.pushShort(SERVER_TYPE);
      m.pushShort(URI);
      m.pushInt(transcoding.width);
      m.pushInt(transcoding.height);
      m.pushInt(transcoding.videoGop);
      m.pushInt(transcoding.videoFramerate);
      m.pushInt(LiveTranscoding.VideoCodecProfileType.getValue(transcoding.videoCodecProfile));
      m.pushInt(transcoding.videoBitrate);

      marshallWatermark(m, transcoding);
      marshallBackgroundImage(m, transcoding);

      m.pushBool(transcoding.lowLatency);
      m.pushInt(LiveTranscoding.AudioSampleRateType.getValue(transcoding.audioSampleRate));
      m.pushInt(transcoding.audioBitrate);
      m.pushInt(transcoding.audioChannels);
      m.pushInt(LiveTranscoding.AudioCodecProfileType.getValue(transcoding.audioCodecProfile));

      m.pushInt(transcoding.backgroundColor & 0x00ffffff);

      if (TextUtils.isEmpty(transcoding.userConfigExtraInfo)) {
        transcoding.userConfigExtraInfo = "";
      }
      m.pushString16(transcoding.userConfigExtraInfo);

      if (TextUtils.isEmpty(transcoding.metadata)) {
        transcoding.metadata = "";
      }
      m.pushString16(transcoding.metadata);

      // users
      int count = 0;
      if (transcoding.getUsers() != null && transcoding.getUsers().size() > 0) {
        count = transcoding.getUserCount();
        pushShort((short) count);
        for (LiveTranscoding.TranscodingUser user : transcoding.getUsers()) {
          marshallUserConfig(m, user);
        }
      } else {
        pushShort((short) count);
      }
    }

    public byte[] marshall(LiveTranscoding transcoding) {
      marshall(this, transcoding);
      return super.marshall();
    }
  }

  public static class PInjectStreamConfig extends Marshallable {
    private static final short SERVER_TYPE = 0;
    private static final short URI = 25;

    private void marshall(Marshallable m, LiveInjectStreamConfig config) {
      m.pushShort(SERVER_TYPE);
      m.pushShort(URI);
      m.pushInt(config.width);
      m.pushInt(config.height);
      m.pushInt(config.videoGop);
      m.pushInt(config.videoFramerate);
      m.pushInt(config.videoBitrate);
      m.pushInt(LiveInjectStreamConfig.AudioSampleRateType.getValue(config.audioSampleRate));
      m.pushInt(config.audioBitrate);
      m.pushInt(config.audioChannels);
    }

    public byte[] marshall(LiveInjectStreamConfig config) {
      marshall(this, config);
      return super.marshall();
    }
  }

  public static class PHostInResponse extends Marshallable {
    public int uid;
    public boolean accepted;
    public int error;

    public byte[] marshall() {
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
      accepted = popBool();
      error = popInt();
    }
  }

  public static class PHostInRequest extends Marshallable {
    public int uid;

    public byte[] marshall() {
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
    }
  }

  public static class PHostInStopped extends Marshallable {
    public int uid;

    public byte[] marshall() {
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
    }
  }

  public static class PStreamInjectedStatus extends Marshallable {
    public String url;
    public int userId;
    public int status;

    @Override
    public byte[] marshall() {
      pushBytes(url.getBytes());
      pushInt(userId);
      pushInt(status);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      url = popString16UTF8();
      userId = popInt();
      status = popInt();
    }
  }

  public static class PPrivilegeWillExpire extends Marshallable {
    public String token;

    @Override
    public byte[] marshall() {
      pushBytes(token.getBytes());
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      token = popString16UTF8();
    }
  }

  public static class PLocalVideoState extends Marshallable {
    public int state;
    public int errorCode;

    @Override
    public byte[] marshall() {
      pushByte((byte) state);
      pushByte((byte) errorCode);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      state = popByte();
      errorCode = popByte();
    }
  }

  public static class PUserInfoState extends Marshallable {
    public int uid;
    public String userAccount;

    @Override
    public byte[] marshall() {
      pushInt(uid);
      pushBytes(userAccount.getBytes());
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
      userAccount = popString16UTF8();
    }
  }

  public static class PRemoteVideoState extends Marshallable {
    public int uid;
    public int state;
    public int reason;
    public int elapsed;

    @Override
    public byte[] marshall() {
      pushInt(uid);
      pushInt(state);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
      state = popByte();
      reason = popByte();
      elapsed = popInt();
    }
  }

  public static class PLocalAudioState extends Marshallable {
    public int state;
    public int errorCode;

    @Override
    public byte[] marshall() {
      pushByte((byte) state);
      pushByte((byte) errorCode);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      state = popByte();
      errorCode = popByte();
    }
  }

  public static class PRemoteAudioState extends Marshallable {
    public int uid;
    public int state;
    public int reason;
    public int elapsed;

    @Override
    public byte[] marshall() {
      pushInt(uid);
      pushByte((byte) state);
      pushByte((byte) reason);
      pushByte((byte) elapsed);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      uid = popInt();
      state = popByte();
      reason = popByte();
      elapsed = popInt();
    }
  }

  public static class PCrossChannelState extends Marshallable {
    public int state;
    public int code;

    @Override
    public byte[] marshall() {
      pushInt(state);
      pushInt(code);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      state = popInt();
      code = popInt();
    }
  }

  public static class PCrossChannelEvent extends Marshallable {
    public int code;

    @Override
    public byte[] marshall() {
      pushInt(code);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      code = popInt();
    }
  }

  public static class PUserTransportStat extends Marshallable {
    public boolean isAudio;
    public int peer_uid;
    public short delay;
    public short lost;
    public short rxKBitRate;

    public byte[] marshall() {
      return super.marshall();
    }
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      isAudio = popBool();
      peer_uid = popInt();
      delay = popShort();
      lost = popShort();
      rxKBitRate = popShort();
    }
  }

  public static class PConnectionState extends Marshallable {
    public int state;
    public int reason;

    @Override
    public byte[] marshall() {
      pushInt(state);
      pushInt(reason);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      state = popInt();
      reason = popInt();
    }
  }

  public static class PNetworkTypeChanged extends Marshallable {
    public int type;

    @Override
    public byte[] marshall() {
      pushInt(type);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      type = popInt();
    }
  }

  public static class PLocalFallbackStatus extends Marshallable {
    boolean state;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      state = popBool();
    }
  }

  public static class PAudioRoutingChanged extends Marshallable {
    int routing;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      routing = popInt();
    }
  }

  public static class PAudioMixingStateChanged extends Marshallable {
    int state;
    int errorCode;

    public byte[] marshall() {
      return super.marshall();
    }

    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      state = popInt();
      errorCode = popInt();
    }
  }

  public static class PRhythmPlayerStateChanged extends Marshallable {
    int state;
    int errorCode;

    @Override
    public byte[] marshall() {
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      state = popInt();
      errorCode = popInt();
    }
  }

  public static class PUplinkNetworkInfoUpdated extends Marshallable {
    int videoEncoderTargetBitrateBps;
    @Override
    public byte[] marshall() {
      return super.marshall();
    }
    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      videoEncoderTargetBitrateBps = popInt();
    }
  }

  public static class PDownlinkNetworkInfoUpdated extends Marshallable {
    int lastmile_buffer_delay_time_ms;
    int bandwidth_estimation_bps;

    @Override
    public byte[] marshall() {
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      lastmile_buffer_delay_time_ms = popInt();
      bandwidth_estimation_bps = popInt();
    }
  }

  public static class PEncryptionError extends Marshallable {
    int errorType;

    @Override
    public byte[] marshall() {
      pushInt(errorType);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      errorType = popInt();
    }
  }

  public static class PPermissionError extends Marshallable {
    int permission;

    @Override
    public byte[] marshall() {
      pushInt(permission);
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      permission = popInt();
    }
  }

  public static class PSubscribeAudioStateChanged extends Marshallable {
    String channelId;
    int uid;
    short oldState;
    short newState;
    int elapseSinceLastState;

    @Override
    public byte[] marshall() {
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      channelId = popString16UTF8();
      uid = popInt();
      oldState = popShort();
      newState = popShort();
      elapseSinceLastState = popInt();
    }
  }

  public static class PSubscribeVideoStateChanged extends Marshallable {
    String channelId;
    int uid;
    short oldState;
    short newState;
    int elapseSinceLastState;

    @Override
    public byte[] marshall() {
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      channelId = popString16UTF8();
      uid = popInt();
      oldState = popShort();
      newState = popShort();
      elapseSinceLastState = popInt();
    }
  }

  public static class PPublishAudioStateChanged extends Marshallable {
    String channelId;
    short oldState;
    short newState;
    int elapseSinceLastState;

    @Override
    public byte[] marshall() {
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      channelId = popString16UTF8();
      oldState = popShort();
      newState = popShort();
      elapseSinceLastState = popInt();
    }
  }

  public static class PPublishVideoStateChanged extends Marshallable {
    String channelId;
    short oldState;
    short newState;
    int elapseSinceLastState;

    @Override
    public byte[] marshall() {
      return super.marshall();
    }

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      channelId = popString16UTF8();
      oldState = popShort();
      newState = popShort();
      elapseSinceLastState = popInt();
    }
  }

  public static class PUploadLogResult extends Marshallable {
    public String requestId;
    public boolean success;
    public int reason;

    @Override
    public void unmarshall(byte[] buf) {
      super.unmarshall(buf);
      requestId = popString16();
      success = popBool();
      reason = popInt();
    }
  }

  public static class PContentInspectConfig extends Marshallable {
    private void marshall(Marshallable m, ContentInspectConfig config) {
      if (config == null || config.moduleCount <= 0
          || config.moduleCount > ContentInspectConfig.MAX_CONTENT_INSPECT_MODULE_COUNT) {
        return;
      }
      m.pushString16(config.extraInfo);
      m.pushInt(config.DeviceWork);
      m.pushInt(config.CloudWork);
      m.pushInt(config.DeviceworkType);
      pushShort((short) config.moduleCount);
      for (int i = 0; i < config.moduleCount; i++) {
        m.pushInt(config.modules[i].type);
        m.pushInt(config.modules[i].frequency);
      }
    }

    public byte[] marshall(ContentInspectConfig config) {
      marshall(this, config);
      return super.marshall();
    }
  }
}
