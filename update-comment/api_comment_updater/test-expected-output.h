//
//  Agora SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//
#pragma once // NOLINT(build/header_guard)

namespace agora {
namespace rtc {


/** Image enhancement options.
 */
struct BeautyOptions {
  /** The contrast level.
   */
  enum LIGHTENING_CONTRAST_LEVEL {
    /** Low contrast level. */
    LIGHTENING_CONTRAST_LOW = 0,
    /** (Default) Normal contrast level. */
    LIGHTENING_CONTRAST_NORMAL = 1,
    /** High contrast level. */
    LIGHTENING_CONTRAST_HIGH = 2,
  };

  /** The contrast level, used with the `lighteningLevel` parameter. The larger the value, the
   * greater the contrast between light and dark. See #LIGHTENING_CONTRAST_LEVEL.
   */
  LIGHTENING_CONTRAST_LEVEL lighteningContrastLevel;

  /** The brightness level. The value ranges from 0.0 (original) to 1.0. The default value is 0.0.
   * The greater the value, the greater the degree of whitening. */
  float lighteningLevel;

  /** The value ranges from 0.0 (original) to 1.0. The default value is 0.0. The greater the value,
   * the greater the degree of skin grinding.
   */
  float smoothnessLevel;

  /** The redness level. The value ranges from 0.0 (original) to 1.0. The default value is 0.0. The
   * larger the value, the greater the rosy degree.
   */
  float rednessLevel;

  /** The sharpness level. The value ranges from 0.0 (original) to 1.0. The default value is 0.0.
   * The larger the value, the greater the sharpening degree.
   */
  float sharpnessLevel;

  BeautyOptions(LIGHTENING_CONTRAST_LEVEL contrastLevel, float lightening, float smoothness,
                float redness, float sharpness)
      : lighteningContrastLevel(contrastLevel),
        lighteningLevel(lightening),
        smoothnessLevel(smoothness),
        rednessLevel(redness),
        sharpnessLevel(sharpness) {}

  BeautyOptions()
      : lighteningContrastLevel(LIGHTENING_CONTRAST_NORMAL),
        lighteningLevel(0),
        smoothnessLevel(0),
        rednessLevel(0),
        sharpnessLevel(0) {}
};


/*
 * Comments here
 */
struct DeviceInfo {
  /*
   * Comments here
   */
  bool isLowLatencyAudioSupported;

  DeviceInfo() : isLowLatencyAudioSupported(false) {}
};

}  // namespace commons
}  // namespace agora

#undef OPTIONAL_LOG_LEVEL_SPECIFIER