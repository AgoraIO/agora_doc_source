package io.agora.rtc2;

/**
 * The RtcConnection class.
 */
public class RtcConnection {
  /**
   * Connection state types.
   */
  public enum CONNECTION_STATE_TYPE {
    /**
     * 0: The SDK has not been initialized.
     */
    CONNECTION_STATE_NOT_INITIALIZED(0),
    /**
     * 1: The SDK is disconnected from Agora's edge server.
     */
    CONNECTION_STATE_DISCONNECTED(1),
    /**
     * 2: The SDK is connecting to Agora's edge server.
     */
    CONNECTION_STATE_CONNECTING(2),
    /**
     * 3: The SDK is connected to Agora's edge server and has joined a channel.
     *  You can now publish or subscribe to a media stream in the channel.
     */
    CONNECTION_STATE_CONNECTED(3),
    /**
     * 4: The SDK keeps rejoining the channel after being disconnected from a
     *  joined channel because of network issues.
     */
    CONNECTION_STATE_RECONNECTING(4),
    /**
     * 5: The SDK fails to connect to Agora's edge server or join the channel.
     */
    CONNECTION_STATE_FAILED(5);

    private int value;
    private CONNECTION_STATE_TYPE(int v) {
      value = v;
    }

    public static int getValue(CONNECTION_STATE_TYPE type) {
      return type.value;
    }
  }

  /**
   * The unique channel name for the AgoraRTC session in the string format. The
   * string length must be less than 64 bytes. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%",
   * "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}",
   * "|", "~", ",".
   */
  public String channelId;

  /**
   * The user ID. A 32-bit unsigned integer with a value ranging from 1 to (2^32-1)
   */
  public int localUid;

  public RtcConnection() {
    channelId = null;
    localUid = Constants.DEFAULT_CONNECTION_ID;
  }

  public RtcConnection(String channelId, int uid) {
    this.channelId = channelId;
    this.localUid = uid;
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("channelId=").append(channelId);
    sb.append("localUid=").append(localUid);
    return sb.toString();
  }
}
