//
//  AgoraExtObjects.h
//  Agora SDK
//
//  Created by LLF on 21-3-9.
//  Copyright (c) 2021 Agora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>

/**
 * Bytes per sample
 */
typedef NS_ENUM(NSInteger, BytesPerSampleType) {
  /**
   * two bytes per sample
   */
  TwoBytesPerSample = 2,
};

/**
 * The class of AgoraAudioPcmFrame.
 */
__attribute__((visibility("default"))) @interface AgoraAudioPcmFrame: NSObject
 @property (assign, nonatomic) uint32_t captureTimestamp;
 @property (assign, nonatomic) size_t samplesPerChannel;
 @property (assign, nonatomic) int sampleRateHz;
 @property (assign, nonatomic) size_t channelNumbers;
 @property (strong, nonatomic) NSData* __nonnull pcmBuffer;
 @property (assign, nonatomic) BytesPerSampleType bytesPerSample;
@end

typedef NS_ENUM(NSInteger, AgoraVideoFilterFrameType) {
  /**
   * Raw Memory Type
   */
  AgoraVideoFilterFrameTypeMemPixels = 0,
  /**
   * CVPixelBuffer type
   */
  AgoraVideoFilterFrameTypeCVPixelBuffer = 2,
};

typedef NS_ENUM(NSInteger, AgoraMemPixelBufferFormatType) {
  AgoraMemPixelBufferFormatTypeUnknown = 0,
  AgoraMemPixelBufferFormatTypeI420 = 1,
  AgoraMemPixelBufferFormatTypeI422 = 2,
  AgoraMemPixelBufferFormatTypeNV12 = 3,
  AgoraMemPixelBufferFormatTypeNV21 = 4,
  AgoraMemPixelBufferFormatTypeRGBA = 5,
  AgoraMemPixelBufferFormatTypeARGB = 6,
  AgoraMemPixelBufferFormatTypeBGRA = 7,
};

/** The class of AgoraMemPixelBuffer.
 */
__attribute__((visibility("default"))) @interface AgoraMemPixelBuffer : NSObject
@property (nonatomic, assign) AgoraMemPixelBufferFormatType type;
@property (nonatomic, assign) uint8_t* _Nullable data;
@property (nonatomic, assign) int size;

@end

/** The class of AgoraExtVideoFrame.
 */
__attribute__((visibility("default"))) @interface AgoraVideoFilterFrame : NSObject

@property (nonatomic, assign) AgoraVideoFilterFrameType type;
/**
 * The width of the Video frame.
 */
@property (nonatomic, assign) int width;
/**
 * The height of the video frame.
 */
@property (nonatomic, assign) int height;

/**
 * The clockwise rotation information of this frame. You can set it as 0, 90, 180 or 270.
 */
@property (nonatomic, assign) int rotation;
/**
 * The timestamp to render the video stream. Use this parameter for audio-video synchronization when
 * rendering the video.
 *
 * @note This parameter is for rendering the video, not capturing the video.
 */
@property (nonatomic, assign) int64_t renderTimeMs;

/**
 * AgoraVideoFilterFrameType is AgoraVideoFilterFrameTypeCVPixelBuffer, shoud use pixelBuffer
 */
@property (assign, nonatomic) CVPixelBufferRef _Nullable pixelBuffer;

/**
 * AgoraVideoFilterFrameType is AgoraVideoFilterFrameTypeMemPixels, shoud use memPixelBuffer
 */
@property (strong, nonatomic) AgoraMemPixelBuffer * _Nullable memPixelBuffer;

@end

/** The class of AgoraExtVideoFrame.
 */
__attribute__((visibility("default"))) @interface AgoraExtVideoFrame : NSObject
/** Video format:
 * - 1: I420
 * - 2: BGRA
 * - 3: NV21
 * - 4: RGBA
 * - 5: IMC2
 * - 7: ARGB
 * - 8: NV12
 * - 12: iOS texture (CVPixelBufferRef)
 */
@property (nonatomic, assign) NSInteger type;
/**
 * The width of the Video frame.
 */
@property (nonatomic, assign) int width;
/**
 * The height of the video frame.
 */
@property (nonatomic, assign) int height;
/**
 * The line span of Y buffer in the YUV data.
 */
@property (nonatomic, assign) int yStride;
/**
 * The line span of U buffer in the YUV data.
 */
@property (nonatomic, assign) int uStride;
/**
 * The line span of V buffer in the YUV data.
 */
@property (nonatomic, assign) int vStride;
/**
 * The pointer to the Y buffer in the YUV data.
 */
@property (nonatomic, assign) uint8_t* _Nullable yBuffer;
/**
 * The pointer to the U buffer in the YUV data.
 */
@property (nonatomic, assign) uint8_t* _Nullable uBuffer;
/**
 * The pointer to the V buffer in the YUV data.
 */
@property (nonatomic, assign) uint8_t* _Nullable vBuffer;
/**
 * The clockwise rotation information of this frame. You can set it as 0, 90, 180 or 270.
 */
@property (nonatomic, assign) int rotation;
/**
 * The timestamp to render the video stream. Use this parameter for audio-video synchronization when
 * rendering the video.
 *
 * @note This parameter is for rendering the video, not capturing the video.
 */
@property (nonatomic, assign) int64_t renderTimeMs;
/**
 * The type of audio-video synchronization.
 */
@property (nonatomic, assign) int avSyncType;

/** CVPixelBuffer
 */
@property(assign, nonatomic) CVPixelBufferRef _Nullable pixelBuffer;
@end

typedef NS_ENUM(NSInteger, AgoraExtensionType) {
  AgoraExtensionTypeAudioFilter = 0,
  AgoraExtensionTypeVideoPreProcessingFilter = 1,
  AgoraExtensionTypeVideoPostProcessingFilter = 2,
  AgoraExtensionTypeAudioSink = 3,
  AgoraExtensionTypeVideoSink = 4,
};

/** The class of AgoraExtVideoFrame.
 */
__attribute__((visibility("default"))) @interface AgoraExtensionMetaInfo : NSObject
@property (nonatomic, assign) AgoraExtensionType type;
@property (nonatomic, strong) NSString * __nonnull extensionName;
@end
