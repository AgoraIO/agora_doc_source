//
//  AgoraMediaFilterExtensionDelegate.h
//  Agora SDK
//
//  Created by LLF on 2020-9-21.
//  Copyright (c) 2020 Agora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AgoraAudioFilterDelegate.h"
#import "AgoraVideoFilterDelegate.h"
#import "AgoraVideoSinkDelegate.h"

typedef NS_ENUM(NSInteger, AgoraExtProviderType) {
 AgoraExtProviderTypeLocalAudioFilter = 0,
 AgoraExtProviderTypeRemoteAudioFilter = 1,
 AgoraExtProviderTypeLocalVideoFilter = 2,
 AgoraExtProviderTypeRemoteVideoFilter = 3,
 AgoraExtProviderTypeLocalVideoSink = 4,
 AgoraExtProviderTypeRemoteVideoSink = 5,
 AgoraExtProviderTypeUnknown = 6,
};

typedef NS_ENUM(NSInteger, AgoraExtLogLevel) {
  AgoraExtLogLevelNone = 0x0000,
  AgoraExtLogLevelInfo = 0x0001,
  AgoraExtLogLevelWarn = 0x0002,
  AgoraExtLogLevelError = 0x0004,
  AgoraExtLogLevelFatal = 0x0008,
};

@protocol AgoraExtControlDelegate <NSObject>
/**
 * write log into sdk.
 * @param level logging level
 * @param message logging message string
 * @return
 * - 0, if succeeds
 * - <0, if error happens
 */
- (NSInteger)log:(AgoraExtLogLevel)level
         message:(NSString * __nullable)message;

- (NSInteger)fireEvent:(NSString * __nonnull)provider
             extension:(NSString * __nullable)extension
                   key:(NSString * __nullable)key
                 value:(NSString * __nullable)value;

@end

@protocol AgoraExtProviderDelegate <NSObject>

- (NSArray<AgoraExtensionMetaInfo*> * __nonnull)getExtenionMetaInfoList;

- (void)setExtensionControl:(id<AgoraExtControlDelegate> __nullable)control;
- (id<AgoraAudioFilterDelegate> __nullable)createAudioFilter;
- (id<AgoraVideoFilterDelegate> __nullable)createVideoFilter;
- (id<AgoraVideoSinkDelegate> __nullable)createVideoSink;

@end

/*
 * If you prefer to use cpp to implement Extension Plugin, you MUST implement
 * - (NSString * __nonnull)vendor; & - (void * __nullable)mediaFilterRawProvider; interface methods
 * If you prefer to use ObjC to implement Extension Plugin, you MUST implement
 * - (NSString * __nonnull)vendor; & - (id<AgoraExtProviderDelegate> __nullable)mediaFilterProvider; interface methods
 */
@protocol AgoraMediaFilterExtensionDelegate <NSObject>
/* Media filter(audio filter or video fitler) name, shoud be unique
 *
 */
- (NSString * __nonnull)vendor;

@optional
/* Meida filter(audio filter or video filter or video sink) pointer,
 * this pointer MUST implement AgoraExtProviderDelegate interface
 */
- (id<AgoraExtProviderDelegate> __nullable)mediaFilterProvider;

/* Meida filter(audio filter or video filter) pointer,
 * this pointer MUST implement IExtensionProvider interface
 */
- (void * __nullable)mediaFilterRawProvider;

@end
