package io.agora.rtc2.internal;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.media.AudioManager;
import android.text.TextUtils;

public class VolumeChangeReceiver extends BroadcastReceiver {
  private static final String TAG = VolumeChangeReceiver.class.getSimpleName();
  static final String ACTION_VOLUME_CHANGED = "android.media.VOLUME_CHANGED_ACTION";

  @Override
  public void onReceive(Context context, Intent intent) {
    if (!TextUtils.equals(intent.getAction(), ACTION_VOLUME_CHANGED)) {
      Logging.w(TAG, "not volume change action");
      return;
    }
    AudioManager audioManager = (AudioManager) context.getSystemService(Context.AUDIO_SERVICE);
    int audioMode = audioManager.getMode();
    Logging.d(TAG, "current audio mode is: " + audioMode);
    int streamType;
    if (audioMode == AudioManager.MODE_IN_COMMUNICATION) {
      streamType = AudioManager.STREAM_VOICE_CALL;
    } else if (audioMode == AudioManager.MODE_NORMAL) {
      streamType = AudioManager.STREAM_MUSIC;
    } else {
      Logging.w(TAG, "invalid audio mode");
      return;
    }
    int currentVolume = audioManager.getStreamVolume(streamType);
    Logging.d(TAG, "current volume is: " + currentVolume);
    // 15 level of physical volume change event
    int volume = currentVolume * 100 / 15;
    HardwareEarMonitorController.getInstance().setHardwareEarMonitorVolume(volume);
  }
}