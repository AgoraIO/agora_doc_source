package io.agora.rtc2;

import io.agora.base.internal.CalledByNative;

public class UserInfo {
  /** The user ID. */
  public int uid;
  /** The user account. */
  public String userAccount;

  @CalledByNative
  public UserInfo(int uid, String userAccount) {
    this.uid = uid;
    this.userAccount = userAccount;
  }
}
