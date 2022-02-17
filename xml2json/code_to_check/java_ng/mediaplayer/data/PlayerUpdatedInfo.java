package io.agora.mediaplayer.data;

import io.agora.base.internal.CalledByNative;

/**
 * Call back PlayerUpdatedInfo to the user, when some information of the media player is updated.
 */
public class PlayerUpdatedInfo {
  /**
   * player_id has value when user trigger interface of opening
   */
  public String player_id;
  /**
   * device_id has value when user trigger interface of opening
   */
  public String device_id;

  public PlayerUpdatedInfo() {
    player_id = null;
    device_id = null;
  }

  @CalledByNative
  public PlayerUpdatedInfo(String player_id, String device_id) {
    this.player_id = player_id;
    this.device_id = device_id;
  }

  @CalledByNative
  public void setPlayerId(String player_id) {
    this.player_id = player_id;
  }

  @CalledByNative
  public void setDeviceId(String device_id) {
    this.device_id = device_id;
  }

  @CalledByNative
  public String getPlayerId() {
    return this.player_id;
  }

  @CalledByNative
  public String getDeviceId() {
    return this.device_id;
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("player_id=").append(player_id);
    sb.append(" device_id=").append(device_id);

    return sb.toString();
  }
}
