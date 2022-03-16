package io.agora.rtc2.video;

import io.agora.rtc2.Constants;
import io.agora.rtc2.video.ChannelMediaInfo;
import java.util.HashMap;
import java.util.Map;

/**
 * The ChannelMediaRelayConfiguration class.
 */
public class ChannelMediaRelayConfiguration {
  private ChannelMediaInfo srcInfo = null;
  private Map<String, ChannelMediaInfo> destInfos = null;

  /**
   * The configuration of the channel media relay.
   */
  public ChannelMediaRelayConfiguration() {
    destInfos = new HashMap<String, ChannelMediaInfo>();
    srcInfo = new ChannelMediaInfo(null, null, 0);
  }

  /**
   * Sets the information of the source channel.
   * @param srcInfo The information of the source channel: {@link ChannelMediaInfo
   *     ChannelMediaInfo}. It contains the following members:
   * - `channelName`: The name of the source channel. The default value is NULL, which means the SDK
   * applies the name of the current channel.
   * - `uid`: ID of the host whose media stream you want to relay. The default value is 0, which
   * means the SDK generates a random UID. You must set it as 0.
   * - `token`: The token for joining the source channel. It is generated with the `channelName` and
   * `uid` you set in `srcInfo`.
   *   - If you have not enabled the App Certificate, set this parameter as the default value NULL,
   * which means the SDK applies the App ID.
   *   - If you have enabled the App Certificate, you must use the token generated with the
   * `channelName` and `uid`, and the `uid` must be set as 0.
   */
  public void setSrcChannelInfo(ChannelMediaInfo srcInfo) {
    this.srcInfo = srcInfo;
  }

  /**
   * Sets the information of the destination channel.
   *
   * If you want to relay the media stream to multiple channels, call this method as many times (at
   * most four).
   * @param channelName The name of the destination channel. Ensure that the value of this parameter
   *     is the same as that of the `channelName` member in `destInfo`.
   * @param destInfo The information of the destination channel: {@link ChannelMediaInfo
   *     ChannelMediaInfo}. It contains the following members:
   * - `channelName`: The name of the destination channel.
   * - `uid`: ID of the host in the destination channel. The value ranges from 0 to
   * (2<sup>32</sup>-1). To avoid UID conflicts, this uid must be different from any other UIDs in
   * the destination channel. The default value is 0, which means the SDK generates a random UID.
   * - `token`: The token for joining the destination channel. It is generated with the
   * `channelName` and `uid` you set in `destInfo`.
   *   - If you have not enabled the App Certificate, set this parameter as the default value NULL,
   * which means the SDK applies the App ID.
   *   - If you have enabled the App Certificate, you must use the token generated with the
   * `channelName` and `uid`.
   */
  public void setDestChannelInfo(String channelName, ChannelMediaInfo destInfo) {
    if (destInfos.size() < Constants.MAX_CROSS_DEST_CHANNEL_SIZE) {
      destInfos.put(channelName, destInfo);
    }
  }

  /**
   * Removes the destination channel.
   *
   * @param channelName The name of the destination channel.
   */
  public void removeDestChannelInfo(String channelName) {
    destInfos.remove(channelName);
  }

  public ChannelMediaInfo getSrcChannelMediaInfo() {
    return srcInfo;
  }

  public Map<String, ChannelMediaInfo> getDestChannelMediaInfos() {
    return destInfos;
  }
}
