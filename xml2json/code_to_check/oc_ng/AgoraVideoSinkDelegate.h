//
//  AgoraVideoSinkDelegate.h
//  Agora SDK
//
//  Created by LLF on 2021-3-9.
//  Copyright (c) 2021 Agora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AgoraExtObjects.h"

/**
 * The `AgoraVideoSinkDelegate` protocol is the base class for the custom video sink.
 */
@protocol AgoraVideoSinkDelegate <NSObject>

/**
 * Occurs when the `AgoraVideoSinkDelegate` object receives the video frame.
 * @param videoFrame The pointer to the video frame.
 */
- (BOOL)onFrame:(AgoraExtVideoFrame * __nonnull)videoFrame;

/**
 * Sets a private property in the `AgoraVideoSinkDelegate` class.
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
 * This function is invoked right before data stream starts.
 * Custom filter can override this function for initialization.
 * @return
 * - `YES`: The initialization succeeds.
 * - `NO`: The initialization fails.
 */
- (BOOL)didDataStreamWillStart;
 /**
 * This function is invoked right before data stream stops.
 * Custom filter can override this function for deinitialization.
 */
- (void)didDataStreamWillStop;

@end
