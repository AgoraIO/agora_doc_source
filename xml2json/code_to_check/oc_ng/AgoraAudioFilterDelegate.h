//
//  AgoraAudioFilterDelegate.h
//  Agora SDK
//
//  Created by LLF on 2021-3-9.
//  Copyright (c) 2021 Agora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AgoraExtObjects.h"

/**
 * The `AgoraAudioFilterDelegate` protocol.
 *
 * This protocol is the intermediate node for audio, which reads audio frames from the underlying
 * pipeline and writes audio frames back after adaptation.
 */
@protocol AgoraAudioFilterDelegate <NSObject>

// Return NO if filter decide to drop the frame.
// Implementation should not change samples_per_channel_/sample_rate_hz_/num_channels_
// Implementation should just adapt data of audio frame.
/**
 * Adapts the audio frame.
 * @param srcFrame The pointer to the audio frame that you want to adapt.
 * @param dstFrame The in/out pointer to the adapted audio frame.
 * @return
 * - `YES`: Success.
 * - `NO`: Failure. For example, the IAudiofilter object drops the audio frame.
 */
- (BOOL)adaptAudioFrame:(AgoraAudioPcmFrame * __nonnull)srcFrame
               dstFrame:(AgoraAudioPcmFrame *_Nullable* _Nullable)dstFrame;

/**
 * Enables or disables the audio filter.
 * @param enable Whether to enable the audio filter:
 * - `YES`: Enable the audio filter.
 * - `NO`: Do not enable the audio filter.
 */
- (void)setEnabled:(BOOL)enabled;

/**
 * Checks whether the audio filter is enabled.
 * @return
 * - `YES`: The audio filter is enabled.
 * - `NO`: The audio filter is not enabled.
 */
- (BOOL)isEnabled;

/**
 * Sets a private property in the `IAudioFilter` class.
 *
 * @param key The pointer to the property name.
 * @param value The pointer to the buffer of this private property.
 * @return
 * - The actual size of the private property, if the method call succeeds.
 * - -1, if the method call fails.
 */
- (NSInteger)setPropertyWithKey:(NSString * __nonnull)key value:(NSData * __nonnull)value;

/**
 * Gets a private property in the `IAudioFilter` class.
 *
 * @param key The pointer to the property name.
 * @param(in/out) value The pointer to the buffer of this private property.
 * @return
 * - The actual size of the private property, if the method call succeeds.
 * - -1, if the method call fails.
 */
- (NSInteger)getPropertyWithKey:(NSString * __nonnull)key value:(NSData *_Nullable* _Nullable)value;

/**
 * Gets the name of the `AgoraAudioFilterDelegate` class.
 *
 * @return
 * - The name of the audio filter, if the method call succeeds.
 * - An empty string, if the method call fails.
 */
- (NSString * __nonnull)getName;

@end
