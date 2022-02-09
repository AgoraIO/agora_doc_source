//
//  Agora RTC/MEDIA SDK
//
//  Created by LLF in 2021-01.
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#import <Foundation/Foundation.h>

__attribute__((visibility("default"))) @interface AgoraRtcIntOptional : NSObject

/**
 * Checks if no value
 */
@property (nonatomic, readonly) BOOL isEmpty;
/**
 * Checks if has value
 */
@property (nonatomic, readonly) BOOL hasValue;

/**
 * Extracts data from optional. Will assert if it's nil!
 */
@property (nonatomic, readonly) int value;

/**
 * Returns empty optional
 * @return AgoraRtcIntOptional.empty
 */
+ (nonnull instancetype)empty;
/**
 * Creates optional with value
 
 * @param aValue
 * @return guaranteed nonnull optional
 */
+ (nonnull instancetype)of:(int)aValue;

+ (nonnull instancetype)new NS_UNAVAILABLE;
- (nonnull instancetype)init NS_UNAVAILABLE;

@end

__attribute__((visibility("default"))) @interface AgoraRtcUIntOptional: NSObject

/**
 * Checks if no value
 */
@property (nonatomic, readonly) BOOL isEmpty;
/**
 * Checks if has value
 */
@property (nonatomic, readonly) BOOL hasValue;
/**
 * Extracts data from optional. Will assert if it's nil!
 */
@property (nonatomic, readonly) unsigned int value;

/**
 * Returns empty optional
 * @return AgoraRtcUIntOptional.empty
 */
+ (nonnull instancetype)empty;
/**
 * Creates optional with value
 
 * @param aValue
 * @return guaranteed nonnull optional
 */
+ (nonnull instancetype)of:(unsigned int)aValue;

+ (nonnull instancetype)new NS_UNAVAILABLE;
- (nonnull instancetype)init NS_UNAVAILABLE;

@end

__attribute__((visibility("default"))) @interface AgoraRtcBoolOptional: NSObject

/**
 * Checks if no value
 */
@property (nonatomic, readonly) BOOL isEmpty;
/**
 * Checks if has value
 */
@property (nonatomic, readonly) BOOL hasValue;
/**
 * Extracts data from optional. Will assert if it's nil!
 */
@property (nonatomic, readonly) BOOL value;

/**
 * Returns empty optional
 * @return AgoraRtcBoolOptional.empty
 */
+ (nonnull instancetype)empty;
/**
 * Creates optional with value
 
 * @param aValue
 * @return guaranteed nonnull optional
 */
+ (nonnull instancetype)of:(BOOL)aValue;

+ (nonnull instancetype)new NS_UNAVAILABLE;
- (nonnull instancetype)init NS_UNAVAILABLE;

@end
