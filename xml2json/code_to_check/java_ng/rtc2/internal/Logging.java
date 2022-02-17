/*
 *  Copyright (c) 2014 Agora.io. All Rights Reserved.
 */

package io.agora.rtc2.internal;

import java.io.PrintWriter;
import java.io.StringWriter;

/**
 * Java wrapper for Agora logging.
 */
public class Logging {
  private static final int LOG_DEBUG = 0x0800;
  private static final int LOG_INFO = 0x0001;
  private static final int LOG_WARN = 0x0002;
  private static final int LOG_ERROR = 0x0004;

  public static void log(int level, String tag, String message) {
    RtcEngineImpl.nativeLog(level, "[" + tag + "] " + message);
  }

  public static void d(String message) {
    RtcEngineImpl.nativeLog(LOG_DEBUG, message);
  }

  public static void i(String message) {
    RtcEngineImpl.nativeLog(LOG_INFO, message);
  }

  public static void e(String message) {
    RtcEngineImpl.nativeLog(LOG_ERROR, message);
  }

  public static void w(String message) {
    RtcEngineImpl.nativeLog(LOG_WARN, message);
  }

  public static void d(String tag, String message) {
    log(LOG_DEBUG, tag, message);
  }

  public static void i(String tag, String message) {
    log(LOG_INFO, tag, message);
  }

  public static void e(String tag, String message) {
    log(LOG_ERROR, tag, message);
  }

  public static void w(String tag, String message) {
    log(LOG_WARN, tag, message);
  }

  public static void d(String tag, String message, Throwable e) {
    log(LOG_DEBUG, tag, message);
    log(LOG_DEBUG, tag, e.toString());
    log(LOG_DEBUG, tag, getStackTraceString(e));
  }

  public static void w(String tag, String message, Throwable e) {
    log(LOG_WARN, tag, message);
    log(LOG_WARN, tag, e.toString());
    log(LOG_WARN, tag, getStackTraceString(e));
  }

  public static void e(String tag, String message, Throwable e) {
    log(LOG_ERROR, tag, message);
    log(LOG_ERROR, tag, e.toString());
    log(LOG_ERROR, tag, getStackTraceString(e));
  }

  static String getStackTraceString(Throwable e) {
    if (e == null) {
      return "";
    }

    StringWriter sw = new StringWriter();
    PrintWriter pw = new PrintWriter(sw);

    // https://issuetracker.google.com/issues/64527520
    // MS-14571, java.lang.NoClassDefFoundError
    // in case "Lcom/google/devtools/build/android/desugar/runtime/ThrowableExtension;"
    try {
      e.printStackTrace(pw);
      return sw.toString();
    } catch (Throwable t) {
      String message = e.getMessage();
      return (message == null) ? "" : message;
    }
  }
}
