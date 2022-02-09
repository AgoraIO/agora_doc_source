package io.agora.rtc2.internal;

import android.os.Build;
import androidx.annotation.NonNull;
import io.agora.base.internal.video.HardwareVideoEncoderFactory;
import io.agora.rtc2.Constants;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/** Created by robert on 16/6/29. */
public class DeviceUtils {
  private static final String TAG = "DeviceUtils";

  public static String getDeviceId() {
    String deviceId = android.os.Build.MANUFACTURER + "/" + android.os.Build.MODEL + "/"
        + android.os.Build.PRODUCT + "/" + android.os.Build.DEVICE + "/"
        + android.os.Build.VERSION.SDK_INT + "/" + System.getProperty("os.version");
    deviceId = deviceId.toLowerCase();
    String bid = Build.ID;
    Pattern pattern =
        Pattern.compile(".*[A-Z][A-M][0-9]$"); // check if match SAMSUNG binary id rules or not
    Matcher matcher = pattern.matcher(bid);
    if (Build.BRAND.toLowerCase().equals("samsung") && Build.DEVICE.toLowerCase().startsWith("cs02")
        && !matcher.find() && Build.VERSION.SDK_INT == 19) {
      deviceId = getYeShenDeviceId();
    }
    return deviceId;
  }

  static String getYeShenDeviceId() {
    return "yeshen/simulator"
        + "/" + android.os.Build.MODEL + "/" + android.os.Build.PRODUCT + "/"
        + android.os.Build.DEVICE + "/" + android.os.Build.VERSION.SDK_INT + "/"
        + System.getProperty("os.version");
  }

  public static String getDeviceInfo() {
    String deviceInfo = android.os.Build.MANUFACTURER + "/" + android.os.Build.MODEL;
    return deviceInfo.toLowerCase();
  }

  public static String getSystemInfo() {
    return "Android/" + android.os.Build.VERSION.RELEASE;
  }

  public static int getRecommendedEncoderType() {
    return getRecommendedEncoderTypeImpl(Build.MODEL, Build.VERSION.SDK_INT);
  }

  static int getRecommendedEncoderTypeImpl(String model, int version) {
    if (HardwareVideoEncoderFactory.H264_HW_EXCEPTION_MODELS.contains(model)) {
      Logging.w(TAG, "Model: " + Build.MODEL + " has black listed H.264 encoder.");
      return Constants.SOFTWARE_ENCODER;
    }
    if (version <= Build.VERSION_CODES.JELLY_BEAN_MR2) {
      // For android version less than android 4.3,
      // we must use software encoder
      return Constants.SOFTWARE_ENCODER;
    } else {
      return Constants.HARDWARE_ENCODER;
    }
  }

  private static double TMPERATURE_LOW_THR = -30.0D;
  private static double TMPERATURE_HIGH_THR = 250.0D;
  private static double INVALIED_TMPERATURE = -100 * 1000D;
  private static final List<String> CPU_TEMP_FILE_PATHS = Arrays.asList(
      "/sys/devices/system/cpu/cpu0/cpufreq/cpu_temp",
      "/sys/devices/system/cpu/cpu0/cpufreq/FakeShmoo_cpu_temp",
      "/sys/class/thermal/thermal_zone0/temp", "/sys/class/i2c-adapter/i2c-4/4-004c/temperature",
      "/sys/devices/platform/tegra-i2c.3/i2c-4/4-004c/temperature",
      "/sys/devices/platform/omap/omap_temp_sensor.0/temperature",
      "/sys/devices/platform/tegra_tmon/temp1_input", "/sys/kernel/debug/tegra_thermal/temp_tj",
      "/sys/devices/platform/s5p-tmu/temperature", "/sys/class/thermal/thermal_zone1/temp",
      "/sys/class/hwmon/hwmon0/device/temp1_input",
      "/sys/devices/virtual/thermal/thermal_zone1/temp",
      "/sys/devices/virtual/thermal/thermal_zone0/temp", "/sys/class/thermal/thermal_zone3/temp",
      "/sys/class/thermal/thermal_zone4/temp", "/sys/class/hwmon/hwmonX/temp1_input",
      "/sys/devices/platform/s5p-tmu/curr_temp");

  static int getCpuTemperature() {
    return getCpuTemperature(CPU_TEMP_FILE_PATHS);
  }

  static int getCpuTemperature(@NonNull List<String> fileList) {
    double currentTemp = 0.0D;
    for (String path : fileList) {
      double temp = readDoubleValueFromFileFirstLine(path, INVALIED_TMPERATURE);
      try {
        currentTemp = getValidateTemperature(temp);
        Logging.i(TAG, "getCpuTemperature from file: " + path);
        break;
      } catch (IllegalArgumentException e) {
        Logging.d(TAG, "can't getCpuTemperature from file: " + path);
      }
    }
    return (int) (currentTemp * 1000);
  }

  static double readDoubleValueFromFileFirstLine(String path, double defaultValue) {
    File file = new File(path);
    if (!file.exists()) {
      return defaultValue;
    }
    try (BufferedReader bufferedReader = new BufferedReader(new FileReader(file))) {
      return parseDouble(bufferedReader.readLine(), defaultValue);
    } catch (IOException e) {
      Logging.d(TAG, "failed to read from file", e);
      return defaultValue;
    }
  }

  static double parseDouble(String s, double defaultValue) {
    double result = defaultValue;
    try {
      result = Double.parseDouble(s);
    } catch (Exception e) {
      Logging.d(TAG, "failed to conver string to double ", e);
    }
    return result;
  }

  static double getValidateTemperature(double temp) throws IllegalArgumentException {
    if (Math.abs(temp) <= 1000) {
      if (isTemperatureValid(temp)) {
        return temp;
      }
    } else {
      if (isTemperatureValid(temp / (double) 1000)) {
        return (temp / (double) 1000);
      }
    }
    throw new IllegalArgumentException("not a validate temperature value");
  }

  static boolean isTemperatureValid(double temp) {
    return temp >= TMPERATURE_LOW_THR && temp <= TMPERATURE_HIGH_THR;
  }
}
