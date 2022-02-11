//
//  AgoraVideoFilterDelegate.h
//  Agora SDK
//
//  Created by LLF on 2021-3-9.
//  Copyright (c) 2021 Agora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AgoraExtObjects.h"

typedef NS_ENUM(NSInteger, AgoraVideoFilterProcessMode) {
  AgoraVideoFilterProcessModeSync = 0,
  AgoraVideoFilterProcessModeAsync = 1,
};

typedef NS_ENUM(NSInteger, AgoraVideoFilterProcessResult) {
  AgoraVideoFilterProcessResultSuccess = 0,
  AgoraVideoFilterProcessResultBypass = 1,
  AgoraVideoFilterProcessResultDrop = 2,
};

@protocol AgoraVideoFilterControlDelegate <NSObject>

/**
 * Adapts the video frame.
 * @param dstFrame The pointer to the adapted video frame
 * @return AgoraVideoFilterProcessResult
 */
- (AgoraVideoFilterProcessResult)deliverVideoFrame:(AgoraVideoFilterFrame * __nonnull)dstFrame;

- (int)postEvent:(NSString * __nonnull)key value:(NSString * __nonnull)value;
- (void)disableMe:(int)error value:(NSString * __nonnull)message;

@end

/**
 * The AgoraVideoFilterDelegate protocol.
 * This protocol is the intermediate node for video, which contains both the video source and the video
 * sink. It reads video frames from the underlying video pipeline and writes video frames back after
 * adaptation.
 */
@protocol AgoraVideoFilterDelegate <NSObject>

/**
 * This function is invoked right before data stream starts.
 * Custom filter can override this function for initialization.
 */
- (void)startExtensionControl:(id<AgoraVideoFilterControlDelegate> __nullable)control;

/**
 * This function is invoked right before data stream stops.
 * Custom filter can override this function for deinitialization.
 */
- (int)stopVideoFilter;

/**
 * Get Process Mode
 * If getProcessMode:(AgoraVideoFilterProcessMode *)mode isolated:(BOOL *)isolated,
 * mode is AgoraVideoFilterProcessModeSync you MUST implement adaptVideoFrame:dstFrame:
 * else getProcessMode:(AgoraVideoFilterProcessMode *)mode isolated:(BOOL *)isolated,
 * mode is AgoraVideoFilterProcessModeAsync you MUST implement pendVideoFrame
 * @param mode AgoraVideoFilterProcessMode, inout param
 * @param isolated BOOL, inout param
 */
- (void)getProcessMode:(AgoraVideoFilterProcessMode * _Nullable)mode isolated:(BOOL * _Nullable)isolated;

/**
 * Get Video Format
 * If getProcessMode:(AgoraVideoFilterProcessMode *)mode isolated:(BOOL *)isolated,
 * mode is AgoraVideoFilterProcessModeSync you MUST implement adaptVideoFrame:dstFrame:
 * else getProcessMode:(AgoraVideoFilterProcessMode *)mode isolated:(BOOL *)isolated,
 * mode is AgoraVideoFilterProcessModeAsync you MUST implement pendVideoFrame
 * @param type AgoraVideoFilterFrameType, inout param
 * @param format AgoraMemPixelBufferFormatType, inout param
 */
- (void)getVideoFormatWanted:(AgoraVideoFilterFrameType * _Nullable)type pixelBufferFormat:(AgoraMemPixelBufferFormatType * _Nullable)format;

/**
 * Enables or disables the video filter.
 * @param enable Whether to enable the video filter:
 * - `YES`: (Default) Enable the video filter.
 * - `NO`: Do not enable the video filter. If the filter is disabled, frames will be passed without
 * adaption.
 */
- (void)setEnabled:(BOOL)enabled;

/**
 * Checks whether the video filter is enabled.
 * @return
 * - `YES`: The video filter is enabled.
 * - `NO`: The video filter is not enabled.
 */
- (BOOL)isEnabled;

/**
 * Sets a private property in the `IVideoFilter` class.
 *
 * @param key The pointer to the property name.
 * @param value The pointer to the buffer of this private property.
 * @return
 * - The actual size of the private property, if the method call succeeds.
 * - -1, if the method call fails.
 */
- (NSInteger)setPropertyWithKey:(NSString * __nonnull)key value:(NSData * __nonnull)value;

/**
 * Gets a private property in the IVideoFilter class.
 *
 * @param key The pointer to the property name.
 * @param(in/out) value The pointer to the buffer of this private property.
 * @return
 * - The actual size of the private property, if the method call succeeds.
 * - -1, if the method call fails.
 */
- (NSInteger)getPropertyWithKey:(NSString * __nonnull)key value:(NSData *_Nullable* _Nullable)value;

@optional

/**
 * Adapts the video frame.
 * @param srcFrame The pointer to the captured video frame that you want to adapt.
 * @return AgoraVideoFilterProcessResult
 */
- (AgoraVideoFilterProcessResult)pendVideoFrame:(AgoraVideoFilterFrame * __nonnull)srcFrame;

/**
 * Adapts the video frame.
 *
 * @param srcFrame The pointer to the captured video frame that you want to adapt.
 * @param dstFrame The in/out pointer to the adapted video frame.
 *
 * @return AgoraVideoFilterProcessResult
 */
- (AgoraVideoFilterProcessResult)adaptVideoFrame:(AgoraVideoFilterFrame * __nonnull)srcFrame
               dstFrame:(AgoraVideoFilterFrame *_Nullable* _Nullable)dstFrame;

@end
