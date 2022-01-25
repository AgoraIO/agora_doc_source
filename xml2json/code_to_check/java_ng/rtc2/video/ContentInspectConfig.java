package io.agora.rtc2.video;
/**
 * The ContentInspectConfig class.
 * @since v3.4.2.
 */
public class ContentInspectConfig {
  public final static int CONTENT_INSPECT_TYPE_INVALID = 0;

  public final static int CONTENT_INSPECT_TYPE_MODERATION = 1;

  public final static int CONTENT_INSPECT_TYPE_SUPERVISE = 2;

  public final static int CONTENT_INSPECT_DEVICE_INVALID = 0;
  public final static int CONTENT_INSPECT_DEVICE_AGORA = 1;
  public final static int CONTENT_INSPECT_DEVICE_HIVE = 2;
  public final static int CONTENT_INSPECT_DEVICE_TUPU = 3;
  public static final int MAX_CONTENT_INSPECT_MODULE_COUNT = 32;
  /**
   * The extra information, max lenght of extraInfo is 1024.
   */
  public String extraInfo;
  public int DeviceWork;
  public int CloudWork;
  public int DeviceworkType;
  /**
   * The content inspect module array, max lenght of the array is 32.
   */
  public ContentInspectModule[] modules;
  /**
   * The actual content inspect count, defalut value is 0.
   */
  public int moduleCount;

  /**
   *  Inner class definition of ContentInspectModule
   */
  public static class ContentInspectModule {
    /**
     *  The content inspect module ype
     */
    public int type;
    /**
     *  The content inspect module's upload image frequency
     *  The frequency unit is second.
     */
    public int frequency;

    public ContentInspectModule() {
      /**
       * Default content inspect type is invalid.
       */
      type = CONTENT_INSPECT_TYPE_INVALID;
      /**
       * Default content inspect frequency is 0 seconds.
       */
      frequency = 0;
    }
  }

  public ContentInspectConfig() {
    modules = new ContentInspectModule[MAX_CONTENT_INSPECT_MODULE_COUNT];
    for (int i = 0; i < MAX_CONTENT_INSPECT_MODULE_COUNT; i++) {
      modules[i] = new ContentInspectModule();
    }
    moduleCount = 0;
  }
}