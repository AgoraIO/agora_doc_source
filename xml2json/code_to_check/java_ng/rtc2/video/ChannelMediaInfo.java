package io.agora.rtc2.video;

import io.agora.base.internal.CalledByNative;

/**
 * The ChannelMediaInfo class, which defines the media information of the channel.
 */
public class ChannelMediaInfo {
  /**
   * The channel name.
   */
  public String channelName = null;
  /**
   * The token that enables the user to join the channel.
   */
  public String token = null;
  /**
   * The user ID.
   */
  public int uid = 0;

  public ChannelMediaInfo(String channelName, String token, int uid) {
    this.channelName = channelName;
    this.token = token;
    this.uid = uid;
  }

  @CalledByNative
  public String getChannelName() {
    return channelName;
  }

  @CalledByNative
  public String getToken() {
    return token;
  }

  @CalledByNative
  public int getUid() {
    return uid;
  }
}
