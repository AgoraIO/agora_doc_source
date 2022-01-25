package io.agora.rtc2.internal;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothClass;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothHeadset;
import android.bluetooth.BluetoothProfile;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.media.AudioManager;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.text.TextUtils;
import androidx.annotation.NonNull;
import androidx.annotation.VisibleForTesting;
import io.agora.base.internal.CalledByNative;
import io.agora.base.internal.ThreadUtils;
import io.agora.rtc2.Constants;
import java.lang.ref.WeakReference;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

public class AudioRoutingController {
  private static final String TAG = "AudioRoute";

  // kinds states(refer to RtcEngine's state).
  private static final int UNINIT = 0;
  private static final int START = 1;
  private static final int STOP = 2;
  private static final int ERROR = 4;

  // speaker phone state.
  public static final int UNSET = -1;
  public static final int OFF = 0;
  public static final int ON = 1;

  // bluetooth sco connection state.
  private final static int BT_SCO_STATE_CONNECTING = 0;
  private final static int BT_SCO_STATE_CONNECTED = 1;
  private final static int BT_SCO_STATE_DISCONNECTING = 2;
  private final static int BT_SCO_STATE_DISCONNECTED = 3;

  // Hold the weakRef of Android context.
  private final WeakReference<Context> mContext;
  // Native C++ pointer.
  private long mNativeHandle;
  // Thread checker.
  @NonNull private final ThreadUtils.ThreadChecker mThreadChecker;
  // Current event handler, mapping to kinds states.
  private EventHandler mEventHandler;

  // state machine
  private ControllerState mState;

  // wired headset plug state.
  private boolean mIsWiredHeadsetPlugged = false;
  // current headset type.
  private int mHeadsetType = -1;
  // bluetooth plug state.
  private boolean mIsBTHeadsetPlugged = false;

  // current audio routing.
  private int mCurrentRouting = Constants.AUDIO_ROUTE_DEFAULT;
  // the default audio routing.
  private int mDefaultRouting = Constants.AUDIO_ROUTE_DEFAULT;
  // RtcEngine's channel profile.
  private int mChannelProfile = -1;
  // whether video disabled.
  private boolean mVideoDisabled = true;
  // whether local audio muted.
  private boolean mMuteLocal = false;
  // whether remote audio muted.
  private boolean mMuteRemotes = false;
  // current RtcEngine user's role, (broadcaster/audience).
  private int mEngineRole = -1;
  // whether in phone call.
  private boolean mPhoneInCall = false;
  // current speaker volume.
  private int mSpeakerCommVolume = -1;
  // whether force use a2dp
  private boolean mForceUseA2dp = true;

  // current sco connection state.
  private int mBtScoState = BT_SCO_STATE_DISCONNECTED;
  // whether sco connect started.
  private boolean mIsBTScoStarted = false;
  // Due to some special device (mi6 lg etc) HW, need more time to connect BT SCO.
  private static final int BLUETOOTH_SCO_TIMEOUT_MS = 4000;
  // threshold for sco connect.
  private static final int MAX_SCO_CONNECT_ATTEMPS = 5;
  // sco connect timeout.
  private int dynamic_timeout = BLUETOOTH_SCO_TIMEOUT_MS;
  // current sco connect counter.
  private int mScoConnectionAttemps;

  private ControllerStopState mStopState = null;
  private ControllerStartState mStartState = null;
  private ControllerErrorState mErrorState = null;

  private static AudioManager mockedAudioManager = null;

  @VisibleForTesting
  public static void setMockedAudioManager(AudioManager mockedAudioManager) {
    AudioRoutingController.mockedAudioManager = mockedAudioManager;
  }

  public interface MockedBroadcaseter {
    void registerReceiver(BroadcastReceiver receiver, IntentFilter filter);
    void unRegisterReceiver(BroadcastReceiver receiver);
  }

  private static MockedBroadcaseter mockedBroadcaster = null;

  @VisibleForTesting
  public static void setMockedBroadcaster(MockedBroadcaseter mockedBroadcaster) {
    AudioRoutingController.mockedBroadcaster = mockedBroadcaster;
  }

  private static boolean mockBlueToothEnable = false;

  @VisibleForTesting
  public static void setMockBlueToothEnable(boolean mockBlueToothEnable) {
    AudioRoutingController.mockBlueToothEnable = mockBlueToothEnable;
  }

  private final Runnable bluetoothTimeoutRunnable = new Runnable() {
    @Override
    public void run() {
      bluetoothTimeout();
    }
  };

  private void startTimer() {
    dynamic_timeout = dynamic_timeout + (BLUETOOTH_SCO_TIMEOUT_MS * mScoConnectionAttemps);
    Logging.d(TAG, "start bluetooth timer " + dynamic_timeout);
    mEventHandler.postDelayed(bluetoothTimeoutRunnable, BLUETOOTH_SCO_TIMEOUT_MS);
  }

  private void cancelTimer() {
    mScoConnectionAttemps = 0;
    Logging.d(TAG, "cancel bluetooth timer");
    mEventHandler.removeCallbacks(bluetoothTimeoutRunnable);
  }

  private HeadsetBroadcastReceiver mHeadsetReceiver;
  private BTHeadsetBroadcastReceiver mBTHeadsetReceiver;

  private BluetoothAdapter mBTAdapter;
  private BluetoothHeadset mBTHeadset;
  private BluetoothProfile.ServiceListener mBTHeadsetListener;

  // Flag, whether disposed. used check whether ref in native c++ released.
  private boolean mDisposed = false;

  // AUDIO EVENT
  private static final int EVT_HEADSET = 1;
  private static final int EVT_BT_HEADSET = 2;
  private static final int EVT_BT_SCO = 3;
  public static final int CMD_SET_DEFAULT_ROUTING = 10;
  public static final int CMD_FORCE_TO_SPEAKER = 11;
  public static final int CMD_MUTE_VIDEO_LOCAL = 12;
  public static final int CMD_MUTE_VIDEO_REMOTES = 13;
  public static final int CMD_MUTE_VIDEO_ALL = 14;
  public static final int CMD_START_BT_SCO = 15;
  public static final int CMD_FORCE_TO_A2DP = 16;
  public static final int EVT_CHANNEL_PROFILE = 20;
  public static final int EVT_ENGINE_ROLE_CHANGED = 21;
  public static final int EVT_PHONE_STATE_CHANGED = 22;

  private class HeadsetBroadcastReceiver extends BroadcastReceiver {
    private boolean isRegistered = false;

    public boolean getRegistered() {
      return isRegistered;
    }

    public void setRegistered(boolean isReg) {
      this.isRegistered = isReg;
    }

    @Override
    public void onReceive(Context context, Intent intent) {
      if (intent.getAction().equalsIgnoreCase(Intent.ACTION_HEADSET_PLUG)) {
        if (intent.hasExtra("state")) {
          int plugged = intent.getIntExtra("state", -1);
          if (plugged == 1) {
            int microphone = intent.getIntExtra("microphone", -1);
            if (microphone == 1) {
              Logging.i(TAG, "Headset w/ mic connected");
              sendEvent(EVT_HEADSET, Constants.AUDIO_ROUTE_HEADSET);
            } else {
              Logging.i(TAG, "Headset w/o mic connected");
              sendEvent(EVT_HEADSET, Constants.AUDIO_ROUTE_HEADSETNOMIC);
            }
          } else if (plugged == 0) {
            Logging.i(TAG, "Headset disconnected");
            sendEvent(EVT_HEADSET, -1);
          } else {
            Logging.i(TAG, "Headset unknown event detected, state=" + plugged);
          }
        }
      }
    }
  }

  private class BTHeadsetBroadcastReceiver extends BroadcastReceiver {
    private boolean isRegistered = false;

    public boolean getRegistered() {
      return isRegistered;
    }

    public void setRegistered(boolean isReg) {
      this.isRegistered = isReg;
    }

    @Override
    public void onReceive(Context context, Intent intent) {
      String action = intent.getAction();
      int state;
      int previousState;
      try {
        // Bluetooth connection state changed
        if (action.equals(BluetoothHeadset.ACTION_CONNECTION_STATE_CHANGED)) {
          state = intent.getIntExtra(BluetoothHeadset.EXTRA_STATE, -99);
          previousState = intent.getIntExtra(BluetoothHeadset.EXTRA_PREVIOUS_STATE, -99);
          Logging.d(TAG, "BT ACTION_CONNECTION_STATE_CHANGED prev " + previousState + ", " + state);
          BluetoothDevice device = intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE);
          switch (state) {
            case BluetoothHeadset.STATE_CONNECTED:
              if ((mockedBroadcaster != null)
                  || (device != null
                      && (device.getBluetoothClass().hasService(BluetoothClass.Service.AUDIO)
                          || device.getBluetoothClass().hasService(
                              BluetoothClass.Service.TELEPHONY)))) {
                //                if (mBTAdapter.getProfileConnectionState(BluetoothProfile.A2DP)
                //                        == BluetoothProfile.STATE_CONNECTED
                //                    ||
                //                    mBTAdapter.getProfileConnectionState(BluetoothProfile.HEADSET)
                //                        == BluetoothProfile.STATE_CONNECTED) {
                Logging.i(TAG, "Bluetooth device " + device + " connected");
                sendEvent(EVT_BT_HEADSET, ON);
                //                }
              }
              break;
            case BluetoothHeadset.STATE_CONNECTING:
              Logging.i(TAG, "Bluetooth device " + device + " connecting");
              break;
            case BluetoothHeadset.STATE_DISCONNECTING:
              Logging.i(TAG, "Bluetooth device " + device + " disconnecting");
              break;
            case BluetoothHeadset.STATE_DISCONNECTED:
              Logging.i(TAG, "Bluetooth device " + device + " disconnected");
              if (getBtConnectedDevicesSize() == 0) {
                sendEvent(EVT_BT_HEADSET, OFF);
              }
              break;
            default:
              Logging.i(TAG, "Bluetooth device " + device + " unknown event, state=" + state);
              break;
          }
          // Bluetooth profile
        } else if (action.equals(BluetoothHeadset.ACTION_AUDIO_STATE_CHANGED)) {
          state = intent.getIntExtra(BluetoothHeadset.EXTRA_STATE, -99);
          previousState = intent.getIntExtra(BluetoothHeadset.EXTRA_PREVIOUS_STATE, -99);
          Logging.d(TAG, "BT ACTION_AUDIO_STATE_CHANGED prev " + previousState + ", " + state);
          BluetoothDevice device = intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE);
          switch (state) {
            case BluetoothHeadset.STATE_AUDIO_CONNECTED:
              Logging.i(TAG, "Bluetooth audio device " + device + " connected");
              break;
            case BluetoothHeadset.STATE_AUDIO_CONNECTING:
              Logging.i(TAG, "Bluetooth audio device " + device + " connecting");
              break;
            case BluetoothHeadset.STATE_AUDIO_DISCONNECTED:
              Logging.i(TAG, "Bluetooth audio device " + device + " disconnected");
              break;
            default:
              Logging.i(TAG, "Bluetooth audio device " + device + " event, state=" + state);
          }
          // Bluetooth SCO
        } else if (action.equals(AudioManager.ACTION_SCO_AUDIO_STATE_UPDATED)) {
          state = intent.getIntExtra(AudioManager.EXTRA_SCO_AUDIO_STATE, -99);
          previousState = intent.getIntExtra(AudioManager.EXTRA_SCO_AUDIO_PREVIOUS_STATE, -99);
          Logging.d(TAG, "BT ACTION_SCO_AUDIO_STATE_UPDATED prev " + previousState + ", " + state);
          switch (state) {
            case AudioManager.SCO_AUDIO_STATE_CONNECTED:
              if ((mockedBroadcaster != null)
                  || (mBTAdapter.getProfileConnectionState(BluetoothProfile.HEADSET)
                      == BluetoothProfile.STATE_CONNECTED)) {
                Logging.i(TAG, "Bluetooth SCO device connected");
                sendEvent(EVT_BT_SCO, ON);
              }
              break;
            case AudioManager.SCO_AUDIO_STATE_CONNECTING:
              Logging.i(TAG, "Bluetooth SCO device connecting");
              break;
            case AudioManager.SCO_AUDIO_STATE_ERROR:
              Logging.i(TAG, "Bluetooth SCO device error");
              break;
            case AudioManager.SCO_AUDIO_STATE_DISCONNECTED:
              Logging.i(TAG, "Bluetooth SCO device disconnected");
              sendEvent(EVT_BT_SCO, OFF);
              break;
            default:
              Logging.i(TAG, "Bluetooth SCO device unknown event, state=" + state);
              break;
          }
        } else if (action.equals(BluetoothAdapter.ACTION_STATE_CHANGED)) {
          state = intent.getIntExtra(BluetoothAdapter.EXTRA_STATE, -99);
          previousState = intent.getIntExtra(BluetoothAdapter.EXTRA_PREVIOUS_STATE, -99);
          Logging.d(
              TAG, "BluetoothAdapter.ACTION_STATE_CHANGED prev " + previousState + ", " + state);
          switch (state) {
            case BluetoothAdapter.STATE_OFF:
              if (getBtConnectedDevicesSize() == 0) {
                sendEvent(EVT_BT_HEADSET, OFF);
              }
              break;
            case BluetoothAdapter.STATE_ON:
              sendEvent(EVT_BT_HEADSET, ON);
              break;
            default:
              break;
          }
        }
      } catch (Exception e) {
        Logging.e(TAG, "BT broadcast receiver onReceive fail ", e);
      }
    }
  }

  private class EventHandler extends Handler {
    public EventHandler(Looper looper) {
      super(looper);
    }

    @Override
    public void handleMessage(Message msg) {
      mState.onEvent(msg.what, msg.arg1);
    }
  }

  // state machine
  private interface ControllerState {
    void setState(int state);
    int getState();
    void onEvent(int event, int info);
    void reset();
  }

  private ControllerState changeState(int state) {
    if (state == STOP) {
      if (mStopState == null) {
        mStopState = new ControllerStopState();
      } else {
        mStopState.reset();
      }
      return mStopState;
    } else if (state == START) {
      if (mStartState == null) {
        mStartState = new ControllerStartState();
      } else {
        mStartState.reset();
      }
      return mStartState;
    } else {
      if (mErrorState == null) {
        mErrorState = new ControllerErrorState();
      } else {
        mErrorState.reset();
      }
      return mErrorState;
    }
  }

  private abstract class ControllerBaseState implements ControllerState {
    @Override
    public void setState(int state) {
      if (state == getState()) {
        Logging.i(TAG, "setState: state not changed!");
        return;
      }
      mState = changeState(state);
    }

    @Override
    public void reset() {
      resetAudioRouting();
    }

    @Override
    public int getState() {
      return UNINIT;
    }

    @Override
    public void onEvent(int event, int info) {
      switch (event) {
        case EVT_HEADSET:
          mHeadsetType = info;
          mIsWiredHeadsetPlugged = (info >= 0);
          notifyAudioRoutingChanged(mIsWiredHeadsetPlugged ? info : queryCurrentAudioRouting());
          break;
        case EVT_CHANNEL_PROFILE:
          mChannelProfile = info;
          break;
        case EVT_BT_HEADSET:
          mIsBTHeadsetPlugged = (info == ON);
          notifyAudioRoutingChanged(mIsBTHeadsetPlugged ? Constants.AUDIO_ROUTE_HEADSETBLUETOOTH
                                                        : queryCurrentAudioRouting());
          break;
        case CMD_FORCE_TO_A2DP:
          mForceUseA2dp = (info == ON);
          Logging.w(TAG, "bluetooth protocol to: " + (mForceUseA2dp ? "a2dp" : "hfp"));
          if (!mPhoneInCall) {
            updateBluetoothSco(mCurrentRouting);
          }
          break;
        case CMD_MUTE_VIDEO_ALL:
          mVideoDisabled = (info > 0);
          break;
        case CMD_MUTE_VIDEO_LOCAL:
          mMuteLocal = (info > 0);
          break;
        case CMD_MUTE_VIDEO_REMOTES:
          mMuteRemotes = (info > 0);
          break;
        case EVT_ENGINE_ROLE_CHANGED:
          mEngineRole = info;
          break;
        case CMD_SET_DEFAULT_ROUTING:
          mDefaultRouting = info;
          Logging.i(TAG, "User set default routing to:" + getAudioRouteDesc(mDefaultRouting));
          break;
        case EVT_PHONE_STATE_CHANGED:
          mPhoneInCall = (info > 0);
          break;
        default:
          break;
      }
    }
  }

  private class ControllerStopState extends ControllerBaseState {
    public ControllerStopState() {
      Logging.i(TAG, "Monitor stopped");
      resetImpl();
    }

    @Override
    public int getState() {
      return STOP;
    }

    private void resetImpl() {
      cancelTimer();
      if (mIsBTScoStarted || getAudioManager().isBluetoothScoOn()) {
        mIsBTScoStarted = false;
        stopBtSco(); // Fix jira/AE-1139  stop in_call mode while leaveChannel
      }
      mCurrentRouting = Constants.AUDIO_ROUTE_DEFAULT;
    }

    @Override
    public void reset() {
      Logging.i(TAG, "Monitor stop state, reset");
      resetImpl();
    }

    @Override
    public void onEvent(int evt, int info) {
      Logging.d(TAG, "StopState: onEvent: " + evt + ", info: " + info);
      try {
        AudioManager am = getAudioManager();
        switch (evt) {
          case CMD_FORCE_TO_SPEAKER:
            am.setSpeakerphoneOn(info == ON);
            // TBD: do we need set mCurrentRouting here?
            mCurrentRouting =
                (info == ON) ? Constants.AUDIO_ROUTE_SPEAKERPHONE : Constants.AUDIO_ROUTE_DEFAULT;
            notifyAudioRoutingChanged(queryCurrentAudioRouting());
            break;

          default:
            super.onEvent(evt, info);
        }
      } catch (Exception e) {
        Logging.e(TAG, "onEvent: Exception ", e);
      }
    }
  }

  private class ControllerStartState extends ControllerBaseState {
    public ControllerStartState() {
      resetImpl();
      Logging.i(TAG,
          "Monitor start: default routing: " + getAudioRouteDesc(mDefaultRouting)
              + ", current routing: " + getAudioRouteDesc(mCurrentRouting));
    }

    private void resetImpl() {
      // default audio routing
      if (mDefaultRouting == Constants.AUDIO_ROUTE_DEFAULT) {
        if (mChannelProfile == Constants.CHANNEL_PROFILE_LIVE_BROADCASTING
            || mChannelProfile == Constants.CHANNEL_PROFILE_LIVE_BROADCASTING_2) {
          // only in CHANNEL_PROFILE_LIVE_BROADCASTING, routing to speakerphone
          mDefaultRouting = Constants.AUDIO_ROUTE_SPEAKERPHONE;
        } else {
          // default, routing to earpiece
          mDefaultRouting = Constants.AUDIO_ROUTE_EARPIECE;
        }
      }
      mCurrentRouting = Constants.AUDIO_ROUTE_DEFAULT;
      // take over audio routing
      resetAudioRouting();
    }

    @Override
    public void reset() {
      resetImpl();
      Logging.i(TAG,
          "Monitor reset: default routing: " + getAudioRouteDesc(mDefaultRouting)
              + ", current routing: " + getAudioRouteDesc(mCurrentRouting));
    }

    @Override
    public int getState() {
      return START;
    }

    @Override
    public void onEvent(int event, int info) {
      Logging.d(TAG, "StartState: onEvent: " + event + ", info: " + info);
      switch (event) {
        case EVT_HEADSET:
          mHeadsetType = info;
          mIsWiredHeadsetPlugged = (info >= 0);
          if (mPhoneInCall) {
            return;
          }
          if (mIsWiredHeadsetPlugged && mCurrentRouting != info) {
            // headset plugged: set audio output routing to headset
            doSetAudioOutputRouting(info);
          } else {
            // headset unplugged:
            // if app force speakerphone on, reset audio routing to speakerphone, actually do
            // nothing if app force speakerphone off, reset audio output routing to earpiece if
            // force speakerphone unset, reset speakerphone to default routing
            resetAudioRouting();
          }
          break;
        case CMD_FORCE_TO_SPEAKER:
          if (!mPhoneInCall) {
            if (info == ON) {
              doSetAudioOutputRouting(Constants.AUDIO_ROUTE_SPEAKERPHONE);
            } else {
              resetAudioRouting();
            }
          }
          break;
        case EVT_ENGINE_ROLE_CHANGED:
          mEngineRole = info;
          if (!mPhoneInCall) {
            updateBluetoothSco(mCurrentRouting);
          }
          break;
        case EVT_BT_HEADSET:
          if (info == OFF && !mIsBTHeadsetPlugged) {
            return; // no state changed
          }
          mIsBTHeadsetPlugged = (info == ON);
          if (mPhoneInCall) {
            return;
          }
          if (mIsBTHeadsetPlugged) {
            doSetAudioOutputRouting(Constants.AUDIO_ROUTE_HEADSETBLUETOOTH);
          } else {
            // BT headset unplugged:
            // if app force speakerphone on, reset to speakerphone, actually do nothing
            // if app force speakerphone off, reset to headset/earpiece
            // if force speakerphone unset, reset to headset/default
            resetAudioRouting();
          }
          break;
        case EVT_BT_SCO:
          mBtScoState = (info == ON) ? BT_SCO_STATE_CONNECTED : BT_SCO_STATE_DISCONNECTING;
          if (mPhoneInCall) {
            return;
          }
          if (info == ON) {
            mScoConnectionAttemps = 0;
          } else if (info == OFF && mCurrentRouting == Constants.AUDIO_ROUTE_HEADSETBLUETOOTH) {
            resetAudioRouting();
          }
          break;
        case CMD_SET_DEFAULT_ROUTING:
          mDefaultRouting = info;
          Logging.i(TAG, "User set default routing to:" + getAudioRouteDesc(mDefaultRouting));
          // record the config and apply immediately
          if (!mPhoneInCall && mCurrentRouting != info) {
            if (info == Constants.AUDIO_ROUTE_SPEAKERPHONE) {
              doSetAudioOutputRouting(info);
            } else {
              // Earpiece
              resetAudioRouting();
            }
          }
          break;
        case EVT_PHONE_STATE_CHANGED:
          Logging.i(TAG, "phone state changed: " + info);
          mPhoneInCall = (info > 0);
          if (info == 0) {
            // phone hung up:
            // if app force speakerphone on, reset to speakerphone
            // if app force speakerphone off, reset to BT/headset/earpiece
            // if force speakerphone unset, reset to BT/headset/default
            resetAudioRouting();
          } else {
            mCurrentRouting = Constants.AUDIO_ROUTE_DEFAULT;
          }
          break;
        default:
          super.onEvent(event, info);
      }
    }
  }

  private class ControllerErrorState extends ControllerBaseState {
    @Override
    public int getState() {
      return ERROR;
    }
  }

  @CalledByNative
  public AudioRoutingController(Context context, long handle) {
    mContext = new WeakReference<Context>(context);
    mNativeHandle = handle;
    mThreadChecker = new ThreadUtils.ThreadChecker();
  }

  @CalledByNative
  public long getNativeHandle() {
    mThreadChecker.checkIsOnValidThread();
    return mNativeHandle;
  }

  @CalledByNative
  public int initialize() {
    Logging.i(TAG, "initialize +");

    Context context = mContext.get();
    if (context == null) {
      Logging.e(TAG, "context has been GCed");
      return -1;
    }

    AudioManager am = getAudioManager();
    if (am == null) {
      Logging.e(TAG, "invalid context: can't get AudioManager");
      return -1;
    }

    mEventHandler = new EventHandler(Looper.getMainLooper());
    if (mHeadsetReceiver == null) {
      mHeadsetReceiver = new HeadsetBroadcastReceiver();
    }
    // get wired headset default state
    mIsWiredHeadsetPlugged = am.isWiredHeadsetOn();

    // start monitoring headset
    mState = changeState(STOP);
    Logging.i(TAG, "Headset setup: Plugged = " + mIsWiredHeadsetPlugged);
    if (!mHeadsetReceiver.getRegistered()) {
      IntentFilter hs = new IntentFilter(Intent.ACTION_HEADSET_PLUG);
      context.registerReceiver(mHeadsetReceiver, hs);
      if (mockedBroadcaster != null) {
        mockedBroadcaster.registerReceiver(mHeadsetReceiver, hs);
      }
      mHeadsetReceiver.setRegistered(true);
    }

    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.HONEYCOMB
        && PackageManager.PERMISSION_GRANTED
            != context.checkCallingOrSelfPermission("android.permission.BLUETOOTH")) {
      Logging.w(TAG, "do not support BT monitoring on this device");
      return 0;
    }

    if (mBTHeadsetListener != null) {
      Logging.w(TAG, "Bluetooth service Listener already been initialized");
    } else {
      try {
        mBTHeadsetListener = new BluetoothProfile.ServiceListener() {
          @Override
          public void onServiceConnected(int profile, BluetoothProfile proxy) {
            Logging.i(TAG,
                "onServiceConnected " + profile + " =? headset(" + BluetoothProfile.HEADSET + ")");
            if (profile == BluetoothProfile.HEADSET) {
              Logging.i(TAG, "on BT service connected: " + profile + " " + proxy);
              mBTHeadset = (BluetoothHeadset) proxy;
            }
          }

          @Override
          public void onServiceDisconnected(int profile) {
            Logging.i(TAG,
                "onServiceDisconnected " + profile + " =? headset(" + BluetoothProfile.HEADSET
                    + ")");
            if (profile == BluetoothProfile.HEADSET) {
              Logging.i(TAG, "on BT service disconnected: " + profile);
              cancelTimer();
              mBTHeadset = null;
            }
          }
        };
      } catch (Exception e) {
        // TBD: not fatal error, but we should clear BT releated objects
        Logging.e(TAG,
            "initialize failed: unable to create BluetoothProfile.ServiceListener, err="
                + e.getMessage());
      }
    }

    // check bluetooth permission
    if (!hasPermission(context, android.Manifest.permission.BLUETOOTH)) {
      Logging.w(TAG, "lacks BLUETOOTH permission");
      return 0;
    }

    try {
      if (mBTHeadsetReceiver == null) {
        mBTHeadsetReceiver = new BTHeadsetBroadcastReceiver();
      }

      // start monitoring bluetooth headset
      mBTAdapter = BluetoothAdapter.getDefaultAdapter();

      if (mBTAdapter != null) {
        mBTAdapter.getProfileProxy(context, mBTHeadsetListener, BluetoothProfile.HEADSET);
      } else {
        Logging.e(TAG, "initialize: failed to get bluetooth adapter!!");
        return 0;
      }
      if (BluetoothProfile.STATE_CONNECTED
          == mBTAdapter.getProfileConnectionState(BluetoothProfile.HEADSET)) {
        mIsBTHeadsetPlugged = true;
      }
      Logging.i(
          TAG, "BT headset setup: BTHeadsetPlugged = " + mIsBTHeadsetPlugged + " " + mBTHeadset);

      IntentFilter bt = new IntentFilter(BluetoothHeadset.ACTION_CONNECTION_STATE_CHANGED);
      bt.addAction(BluetoothHeadset.ACTION_AUDIO_STATE_CHANGED);
      bt.addAction(AudioManager.ACTION_SCO_AUDIO_STATE_UPDATED);
      bt.addAction(BluetoothAdapter.ACTION_STATE_CHANGED);
      if (!mBTHeadsetReceiver.getRegistered()) {
        Intent intent = context.registerReceiver(mBTHeadsetReceiver, bt);
        if (mockedBroadcaster != null) {
          mockedBroadcaster.registerReceiver(mBTHeadsetReceiver, bt);
        }
        mBTHeadsetReceiver.setRegistered(true);
        if (intent != null
            && TextUtils.equals(intent.getAction(), AudioManager.ACTION_SCO_AUDIO_STATE_UPDATED)) {
          int state = intent.getIntExtra(
              AudioManager.EXTRA_SCO_AUDIO_STATE, AudioManager.SCO_AUDIO_STATE_DISCONNECTED);
          switch (state) {
            case AudioManager.SCO_AUDIO_STATE_CONNECTED:
              Logging.i(TAG, "initial Bluetooth SCO device connected");
              mBtScoState = BT_SCO_STATE_CONNECTED;
              break;
            default:
              Logging.i(TAG, "initial Bluetooth SCO device unconnected");
              mBtScoState = BT_SCO_STATE_DISCONNECTED;
              break;
          }
        }
      }
    } catch (Exception e) {
      // TBD: not fatal error, but we should clear BT releated objects
      Logging.e(TAG, "unable to create BluetoothHeadsetBroadcastReceiver, err:" + e.getMessage());
    }
    Logging.i(TAG, "initialize -");

    return 0;
  }

  private void clearBTResource() {
    if (mBTAdapter != null) {
      mBTAdapter.closeProfileProxy(BluetoothProfile.HEADSET, mBTHeadset);
      mBTAdapter = null;
    }
    if (mBTHeadsetListener != null) {
      mBTHeadsetListener = null;
    }
  }

  @CalledByNative
  public void dispose() {
    mThreadChecker.checkIsOnValidThread();
    if (mDisposed) {
      return;
    }
    mDisposed = true;
    mNativeHandle = 0;
    Logging.d(TAG, "dispose");
    try {
      clearBTResource();
      Context context = mContext.get();
      if (context != null) {
        if (mHeadsetReceiver != null && mHeadsetReceiver.getRegistered()) {
          context.unregisterReceiver(mHeadsetReceiver);
          if (mockedBroadcaster != null) {
            mockedBroadcaster.unRegisterReceiver(mHeadsetReceiver);
          }
          mHeadsetReceiver.setRegistered(false);
        }
        if (mBTHeadsetReceiver != null && mBTHeadsetReceiver.getRegistered()) {
          context.unregisterReceiver(mBTHeadsetReceiver);
          if (mockedBroadcaster != null) {
            mockedBroadcaster.unRegisterReceiver(mBTHeadsetReceiver);
          }
          mBTHeadsetReceiver.setRegistered(false);
        }
      }
      mHeadsetReceiver = null;
      mBTHeadsetReceiver = null;
    } catch (Exception e) {
      Logging.e(TAG, "AudioRoutingController dispose fail: ", e);
    }
  }

  @CalledByNative
  public void startMonitoring() {
    Logging.d(TAG, "startMonitoring()");
    // TODO(HaiyangWu): MS-10927
    //  1. move state related into native c++ code
    //  2. add thread check to avoid 'init' and 'startMonitoring' from different which leads to bug
    //  like MS-10694
    // As this function is called when prepare joinChannel, set communication mode here
    mEventHandler.post(new Runnable() {
      @Override
      public void run() {
        mState.setState(START);
      }
    });
  }

  @CalledByNative
  public void stopMonitoring() {
    Logging.d(TAG, "stopMonitoring()");
    // TODO(HaiyangWu): MS-10927
    //  1. move state related into native c++ code
    //  2. add thread check to avoid 'init' and 'stopMonitoring' from different which leads to bug
    //  like MS-10694
    mEventHandler.post(new Runnable() {
      @Override
      public void run() {
        mState.setState(STOP);
      }
    });
  }

  @CalledByNative
  public void sendEvent(int event, int arg) {
    Logging.d(TAG, "sendEvent: [" + event + "], extra arg: " + arg + "... " + mEventHandler);
    if (mEventHandler != null) {
      Message m = mEventHandler.obtainMessage(event, arg, 0);
      mEventHandler.sendMessage(m);
    }
  }

  private int getBtConnectedDevicesSize() {
    if (mBTHeadset == null)
      return 0;
    for (BluetoothDevice device : mBTHeadset.getConnectedDevices()) {
      Logging.i(TAG, "connected device name: " + device.getName());
    }
    return mBTHeadset.getConnectedDevices().size();
  }

  private boolean isAudioOnly() {
    return mVideoDisabled || (mMuteLocal && mMuteRemotes);
  }

  private AudioManager getAudioManager() {
    if (mockedAudioManager != null) {
      return mockedAudioManager;
    }
    Context context = mContext.get();
    if (context == null) {
      return null;
    }
    return (AudioManager) context.getSystemService(Context.AUDIO_SERVICE);
  }

  private void notifyAudioRoutingChanged(final int routing) {
    if (mDisposed) {
      return;
    }
    nativeAudioRoutingChanged(routing);
  }

  private int doSetAudioOutputRouting(int routing) {
    Logging.i(TAG,
        "set audio output routing from " + getAudioRouteDesc(mCurrentRouting) + " to "
            + getAudioRouteDesc(routing));
    try {
      AudioManager am = getAudioManager();
      if (routing != Constants.AUDIO_ROUTE_HEADSETBLUETOOTH) {
        am.setSpeakerphoneOn(routing == Constants.AUDIO_ROUTE_SPEAKERPHONE);
      } else {
        // bluetooth will be handled at startBtSco
      }

      if (queryCurrentAudioRouting() != routing) {
        int current = queryCurrentAudioRouting();
        Logging.i(TAG,
            "different audio routing from target " + routing + ", actual routing: " + current + "["
                + getAudioRouteDesc(current) + "]");
      }
      updateBluetoothSco(routing);
      if (routing == mCurrentRouting) {
        Logging.i(TAG, "audio routing not changed, ignore");
        return 0;
      }
      mCurrentRouting = routing;
      notifyAudioRoutingChanged(routing);
      Logging.i(TAG, "audio routing changed to " + getAudioRouteDesc(mCurrentRouting));
    } catch (Exception e) {
      Logging.e(TAG, "set audio output routing failed:", e);
    }
    return 0;
  }

  private int updateBluetoothSco(int targetRouting) {
    Logging.d(TAG,
        "updateBluetoothSco sco started: " + mIsBTScoStarted
            + ", audio route target: " + targetRouting + "[" + getAudioRouteDesc(targetRouting)
            + "] current: " + mCurrentRouting + "[" + getAudioRouteDesc(mCurrentRouting)
            + "], engine role: " + mEngineRole);
    if (targetRouting == Constants.AUDIO_ROUTE_HEADSETBLUETOOTH) {
      if (!mForceUseA2dp) {
        Logging.w(TAG, "enable hfp");
        mIsBTScoStarted = true;
        startTimer();
        startBtSco();
      } else if (mIsBTScoStarted) {
        Logging.w(TAG, "enable a2dp");
        mIsBTScoStarted = false;
        cancelTimer();
        stopBtSco();
      }
    } else if (mCurrentRouting == Constants.AUDIO_ROUTE_HEADSETBLUETOOTH) {
      // routing switch from bluetooth to others
      if (mIsBTScoStarted) {
        mIsBTScoStarted = false;
        cancelTimer();
        stopBtSco();
      }
    }
    return 0;
  }

  private void startBtSco() {
    AudioManager am = getAudioManager();

    int mode = am.getMode();
    Logging.i(TAG,
        "try to opening bt sco " + mScoConnectionAttemps + " " + mode + "[" + modeAsString(mode)
            + "] " + mBtScoState + "[" + btStateAsString(mBtScoState)
            + "] sco on: " + am.isBluetoothScoOn());
    Logging.d(TAG, "Off call sco support = " + am.isBluetoothScoAvailableOffCall());
    mBtScoState = BT_SCO_STATE_CONNECTING;
    doStartBTSco(am);
  }

  private String modeAsString(int mode) {
    String modeAsString;
    switch (mode) {
      case AudioManager.MODE_NORMAL:
        modeAsString = "MODE_NORMAL";
        break;
      case AudioManager.MODE_RINGTONE:
        modeAsString = "MODE_RINGTONE";
        break;
      case AudioManager.MODE_IN_CALL:
        modeAsString = "MODE_IN_CALL";
        break;
      case AudioManager.MODE_IN_COMMUNICATION:
        modeAsString = "MODE_IN_COMMUNICATION";
        break;
      default:
        modeAsString = "Unknown " + mode;
        break;
    }
    return modeAsString;
  }

  private String btStateAsString(int state) {
    String btStateAsString;
    switch (state) {
      case BT_SCO_STATE_CONNECTING:
        btStateAsString = "SCO_CONNECTING";
        break;
      case BT_SCO_STATE_CONNECTED:
        btStateAsString = "SCO_CONNECTED";
        break;
      case BT_SCO_STATE_DISCONNECTING:
        btStateAsString = "SCO_DISCONNECTING";
        break;
      case BT_SCO_STATE_DISCONNECTED:
        btStateAsString = "SCO_DISCONNECTED";
        break;
      default:
        btStateAsString = "Unknown " + state;
        break;
    }
    return btStateAsString;
  }

  private void doStartBTSco(AudioManager am) {
    try {
      int mode = am.getMode();
      Logging.i(TAG,
          "doStartBTSco " + Build.VERSION.SDK_INT + " sco on: " + am.isBluetoothScoOn() + " " + mode
              + "[" + modeAsString(mode) + "]");

      if (Build.VERSION.SDK_INT < Build.VERSION_CODES.LOLLIPOP_MR1) {
        am.setStreamMute(AudioManager.STREAM_VOICE_CALL, true);
      } else {
        am.setStreamVolume(AudioManager.STREAM_VOICE_CALL, 1, 0);
      }

      am.setBluetoothScoOn(false);
      am.stopBluetoothSco();
      am.startBluetoothSco();
      am.setBluetoothScoOn(true);

      if (mBTHeadset != null) {
        Method connectAudio = null;
        Object retVal = null;
        try {
          connectAudio = mBTHeadset.getClass().getMethod("connectAudio");
          retVal = connectAudio.invoke(mBTHeadset);
        } catch (NoSuchMethodException e) {
          e.printStackTrace();
        } catch (IllegalAccessException e) {
          e.printStackTrace();
        } catch (InvocationTargetException e) {
          e.printStackTrace();
        }
      }

      //      am.setMode(mode);
    } catch (Exception e) {
      Logging.e(TAG, "doStartBTSco fail ", e);
    }
    Logging.d(TAG,
        "doStartBTSco done sco on: " + am.isBluetoothScoOn() + " " + am.getMode() + "["
            + modeAsString(am.getMode()) + "]");
  }

  private void doStopBTSco(AudioManager am) {
    Logging.i(TAG, "doStopBTSco " + Build.VERSION.SDK_INT + " sco on: " + am.isBluetoothScoOn());

    am.setBluetoothScoOn(false);
    am.stopBluetoothSco();

    if (mBTHeadset != null) {
      Method disconnectAudio = null;
      Object retVal = null;
      try {
        disconnectAudio = mBTHeadset.getClass().getMethod("disconnectAudio");
        retVal = disconnectAudio.invoke(mBTHeadset);
      } catch (NoSuchMethodException e) {
        e.printStackTrace();
      } catch (IllegalAccessException e) {
        e.printStackTrace();
      } catch (InvocationTargetException e) {
        e.printStackTrace();
      }
    }

    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.LOLLIPOP_MR1) {
      // am.setStreamMute(AudioManager.STREAM_VOICE_CALL, false);
    } else {
      // am.setStreamVolume(AudioManager.STREAM_VOICE_CALL, mSpeakerCommVolume , 0);
    }
  }

  private void stopBtSco() {
    AudioManager am = getAudioManager();
    int mode = am.getMode();
    Logging.i(TAG,
        "try to stopping bt sco " + mode + "[" + modeAsString(mode) + "] " + mBtScoState + "["
            + btStateAsString(mBtScoState) + "] sco on: " + am.isBluetoothScoOn());

    if (!am.isBluetoothScoOn()) {
      mBtScoState = BT_SCO_STATE_DISCONNECTED;
    } else {
      mBtScoState = BT_SCO_STATE_DISCONNECTING;
    }

    doStopBTSco(am);
  }

  private void bluetoothTimeout() {
    AudioManager am = getAudioManager();
    // Bluetooth SCO should be connecting; check the latest result.
    boolean scoConnected = false;
    if (mBTHeadset == null) {
      Logging.w(TAG, "no bluetooth profile connected");
      return;
    }
    List<BluetoothDevice> devices = mBTHeadset.getConnectedDevices();
    if (devices.size() > 0) {
      BluetoothDevice bluetoothDevice = devices.get(0);

      // workaround for Bluetooth
      Method isAudioOn = null;
      Object retVal = null;
      if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.O) {
        try {
          isAudioOn = mBTHeadset.getClass().getMethod("isAudioOn");
          retVal = isAudioOn.invoke(mBTHeadset);
        } catch (NoSuchMethodException e) {
          e.printStackTrace();
        } catch (IllegalAccessException e) {
          e.printStackTrace();
        } catch (InvocationTargetException e) {
          e.printStackTrace();
        }
      }

      if (mBTHeadset.isAudioConnected(bluetoothDevice) || (retVal != null && (Boolean) retVal)) {
        Logging.d(TAG, "SCO connected with " + bluetoothDevice.getName());
        scoConnected = true;
      } else {
        Logging.d(TAG, "SCO is not connected with " + bluetoothDevice.getName());
      }
    } else {
      Logging.w(TAG, "no bluetooth device connected.");
    }

    if (mScoConnectionAttemps < MAX_SCO_CONNECT_ATTEMPS) {
      Logging.d(TAG,
          "attemps trying, bt sco started: " + mIsBTScoStarted + " sco connected: " + scoConnected
              + " " + mScoConnectionAttemps + " times " + mBtScoState + "["
              + btStateAsString(mBtScoState) + "]");
      if (!scoConnected) {
        startTimer();
        mScoConnectionAttemps++;
        stopBtSco(); // As google offical illustration , if we got fail, clear previously
        am.stopBluetoothSco();
        doStartBTSco(am);
      } else {
        Logging.d(TAG, "soc connected");
        cancelTimer();
      }
    } else {
      Logging.e(TAG, "start bluetooth sco timeout, actual routing: " + queryCurrentAudioRouting());
      cancelTimer();
      nativeAudioRoutingError(Constants.ERR_AUDIO_BT_SCO_FAILED);
      resetAudioRouting();
    }
  }

  private void resetAudioRouting() {
    int targetRouting;
    if (mIsBTHeadsetPlugged) {
      targetRouting = Constants.AUDIO_ROUTE_HEADSETBLUETOOTH;
    } else if (mIsWiredHeadsetPlugged) {
      targetRouting = mHeadsetType;
    } else {
      targetRouting = mDefaultRouting;
    }
    Logging.i(TAG,
        "reset audio routing, default routing: " + getAudioRouteDesc(mDefaultRouting)
            + ", current routing: " + getAudioRouteDesc(mCurrentRouting)
            + ", target routing: " + getAudioRouteDesc(targetRouting)
            + ", actual system routing: " + getAudioRouteDesc(queryCurrentAudioRouting()));
    if (mCurrentRouting != targetRouting || queryCurrentAudioRouting() != mCurrentRouting) {
      doSetAudioOutputRouting(targetRouting);
    }
  }

  private String getAudioRouteDesc(int route) {
    switch (route) {
      case Constants.AUDIO_ROUTE_EARPIECE:
        return "Earpiece";
      case Constants.AUDIO_ROUTE_SPEAKERPHONE:
        return "Speakerphone";
      case Constants.AUDIO_ROUTE_LOUDSPEAKER:
        return "Loudspeaker";
      case Constants.AUDIO_ROUTE_HEADSET:
        return "Headset";
      case Constants.AUDIO_ROUTE_HEADSETNOMIC:
        return "HeadsetOnly";
      case Constants.AUDIO_ROUTE_HEADSETBLUETOOTH:
        return "HeadsetBluetooth";
      case Constants.AUDIO_ROUTE_DEFAULT:
        return "Default";
      default:
        return "Unknown";
    }
  }

  @CalledByNative
  public int queryCurrentAudioRouting() {
    AudioManager am = getAudioManager();
    if (mBTAdapter == null) {
      mBTAdapter = BluetoothAdapter.getDefaultAdapter();
    }
    try {
      if (am.isSpeakerphoneOn()) {
        return Constants.AUDIO_ROUTE_SPEAKERPHONE;
      } else if ((am.isBluetoothScoOn() || am.isBluetoothA2dpOn())
          && (mockBlueToothEnable || mBTAdapter.isEnabled())) {
        return Constants.AUDIO_ROUTE_HEADSETBLUETOOTH;
      } else if (am.isWiredHeadsetOn()) {
        return Constants.AUDIO_ROUTE_HEADSET;
      } else {
        return Constants.AUDIO_ROUTE_EARPIECE;
      }
    } catch (Exception e) {
      Logging.e(TAG, "fatal error @queryCurrentAudioRouting", e);
      return -1;
    }
  }

  protected boolean hasPermission(Context context, String permission) {
    return context.checkCallingOrSelfPermission(permission) == PackageManager.PERMISSION_GRANTED;
  }

  private native void nativeAudioRoutingChanged(int routing);

  private native void nativeAudioRoutingError(int errCode);
}
