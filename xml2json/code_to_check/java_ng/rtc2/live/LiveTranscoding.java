package io.agora.rtc2.live;

import io.agora.rtc2.Constants;
import io.agora.rtc2.video.AgoraImage;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class LiveTranscoding {
  public enum AudioSampleRateType {
    TYPE_32000(32000),
    TYPE_44100(44100),
    TYPE_48000(48000);

    private int value;

    private AudioSampleRateType(int v) {
      value = v;
    }

    public static int getValue(AudioSampleRateType type) {
      return type.value;
    }
  }

  public enum VideoCodecProfileType {
    BASELINE(66),
    MAIN(77),
    HIGH(100);

    private int value;

    private VideoCodecProfileType(int v) {
      value = v;
    }

    public static int getValue(VideoCodecProfileType type) {
      return type.value;
    }
  }

  /**
   * Self-defined audio codec profile.
   */
  public enum AudioCodecProfileType {
    /**
     * 0: LC-AAC, which is the low-complexity audio codec type.
     */
    LC_AAC(0),
    /**
     * 1: HE-AAC, which is the high-effeciency audio codec type.
     */
    HE_AAC(1);

    private int value;

    private AudioCodecProfileType(int v) {
      value = v;
    }

    public static int getValue(AudioCodecProfileType type) {
      return type.value;
    }
  }

  public int width;
  public int height;
  public int videoBitrate;
  public int videoFramerate;
  public boolean lowLatency;

  public int videoGop;

  public AgoraImage watermark;
  private ArrayList<AgoraImage> watermarkList;
  /**
   * add watermark to list
   *
   * @param watermark you want to add watermark.
   */
  public void addWatermark(AgoraImage watermark) {
    if (watermarkList == null) {
      watermarkList = new ArrayList<AgoraImage>();
    }
    watermarkList.add(watermark);
  }
  /**
   * remove watermark from list
   *
   * @param watermark you want to remove object.
   * @return if success, will return true. Otherwise, will return false.
   */
  public boolean removeWatermark(AgoraImage watermark) {
    if (watermarkList == null) {
      return false;
    }
    return watermarkList.remove(watermark);
  }
  /**
   * get object attribute of watermarkList
   *
   * @return watermark list
   */
  public ArrayList<AgoraImage> getWatermarkList() {
    return watermarkList;
  }

  public AgoraImage backgroundImage;
  private ArrayList<AgoraImage> backgroundImageList;
  /**
   * add background image to backgroundImageList
   *
   * @param backgroundImage you want to add background to list.
   */
  public void addBackgroundImage(AgoraImage backgroundImage) {
    if (backgroundImageList == null) {
      backgroundImageList = new ArrayList<AgoraImage>();
    }
    backgroundImageList.add(backgroundImage);
  }
  /**
   * remove background from background image list
   *
   * @param backgroundImage you want to remove background image
   * @return if success to remove, will return true. Otherwise, will return false.
   */
  public boolean removeBackgroundImage(AgoraImage backgroundImage) {
    if (backgroundImageList == null) {
      return false;
    }
    return backgroundImageList.remove(backgroundImage);
  }
  /**
   * get object attribute of backgroundImageList
   *
   * @return backgroundImage list
   */
  public ArrayList<AgoraImage> getBackgroundImageList() {
    return backgroundImageList;
  }

  /*
    AUDIO_SAMPLE_RATE_TYPE_32000
    AUDIO_SAMPLE_RATE_TYPE_44100
    AUDIO_SAMPLE_RATE_TYPE_48000
  */
  public AudioSampleRateType audioSampleRate;

  public int audioBitrate;

  public int audioChannels;

  /**
   * Audio codec profile type: {@link AudioCodecProfileType AudioCodecProfileType}. Set it as LC-AAC
   * or HE-AAC. The default value is LC-AAC.
   */
  public AudioCodecProfileType audioCodecProfile;

  /*
   VIDEO_CODEC_PROFILE_TYPE_BASELINE
   VIDEO_CODEC_PROFILE_TYPE_MAIN
   VIDEO_CODEC_PROFILE_TYPE_HIGH
  */
  public VideoCodecProfileType videoCodecProfile;

  @Deprecated public int userCount;

  /*
   It will changed to private in future
   */
  @Deprecated public int backgroundColor;

  public String userConfigExtraInfo;
  public String metadata;

  private Map<Integer, TranscodingUser> transcodingUsers;

  public static class TranscodingUser {
    public int uid;
    public String userId;

    public int x;
    public int y;
    public int width;
    public int height;

    public int zOrder;
    public float alpha;
    public int audioChannel;

    public TranscodingUser() {
      alpha = 1;
    }
  }

  public LiveTranscoding() {
    width = 360;
    height = 640;
    videoBitrate = 400;
    videoCodecProfile = VideoCodecProfileType.HIGH;
    videoGop = 30;
    videoFramerate = 15;
    watermark = new AgoraImage();
    backgroundImage = new AgoraImage();

    lowLatency = false;
    audioSampleRate = AudioSampleRateType.TYPE_44100;
    audioBitrate = 48;
    audioChannels = 1;
    audioCodecProfile = AudioCodecProfileType.LC_AAC;
    transcodingUsers = new HashMap<>();
    backgroundColor = 0xFF000000;
    userConfigExtraInfo = null;
    metadata = null;
  }

  public int addUser(TranscodingUser user) {
    if (user == null || user.uid == 0) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }

    transcodingUsers.put(user.uid, user);
    userCount = transcodingUsers.size();
    return Constants.ERR_OK;
  }

  public final ArrayList<TranscodingUser> getUsers() {
    Collection<TranscodingUser> values = transcodingUsers.values();
    return new ArrayList<>(values);
  }

  public void setUsers(ArrayList<TranscodingUser> users) {
    transcodingUsers.clear();
    if (users != null) {
      for (TranscodingUser user : users) {
        transcodingUsers.put(user.uid, user);
      }
    }
    userCount = transcodingUsers.size();
  }

  public void setUsers(Map<Integer, TranscodingUser> users) {
    transcodingUsers.clear();
    if (users != null) {
      transcodingUsers.putAll(users);
    }

    userCount = transcodingUsers.size();
  }

  public int removeUser(int uid) {
    if (!transcodingUsers.containsKey(uid))
      return -Constants.ERR_INVALID_ARGUMENT;

    transcodingUsers.remove(uid);
    userCount = transcodingUsers.size();
    return Constants.ERR_OK;
  }

  public int getUserCount() {
    return transcodingUsers.size();
  }

  public int getBackgroundColor() {
    return this.backgroundColor;
  }

  public void setBackgroundColor(int color) {
    this.backgroundColor = color;
  }

  public void setBackgroundColor(int red, int green, int blue) {
    this.backgroundColor = (red << 16) | (green << 8) | (blue << 0);
  }

  @Deprecated
  public int getRed() {
    return (backgroundColor >> 16) & 0x0ff;
  }

  @Deprecated
  public int getGreen() {
    return (backgroundColor >> 8) & 0x0ff;
  }

  @Deprecated
  public int getBlue() {
    return backgroundColor & 0x0ff;
  }

  @Deprecated
  public void setRed(int red) {
    int green = getGreen();
    int blue = getBlue();
    this.backgroundColor = (red << 16) | (green << 8) | (blue << 0);
  }

  @Deprecated
  public void setGreen(int green) {
    int red = getRed();
    int blue = getBlue();
    this.backgroundColor = (red << 16) | (green << 8) | (blue << 0);
  }

  @Deprecated
  public void setBlue(int blue) {
    int red = getRed();
    int green = getGreen();
    this.backgroundColor = (red << 16) | (green << 8) | (blue << 0);
  }
}
