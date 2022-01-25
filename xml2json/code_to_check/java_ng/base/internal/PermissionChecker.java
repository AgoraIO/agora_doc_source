package io.agora.base.internal;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;

public class PermissionChecker {
  static boolean forceCheckPermissionFail = false;

  @CalledByNative
  public static boolean hasRecordAudioPermission() {
    return hasPermission(Manifest.permission.RECORD_AUDIO);
  }

  @CalledByNative
  public static boolean hasCameraPermission() {
    return hasPermission(Manifest.permission.CAMERA);
  }

  // for test
  static void setForceCheckPermissionFail(boolean forceCheckPermissionFail) {
    PermissionChecker.forceCheckPermissionFail = forceCheckPermissionFail;
  }

  public static boolean hasPermission(String perm) {
    Context context = ContextUtils.getApplicationContext();
    if (context == null || forceCheckPermissionFail) {
      return false;
    }
    return context.checkCallingOrSelfPermission(perm) == PackageManager.PERMISSION_GRANTED;
  }
}
