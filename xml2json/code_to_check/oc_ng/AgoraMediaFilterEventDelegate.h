//
//  AgoraMediaFilterEventDelegate.h
//  Agora SDK
//
//  Created by LLF on 2020-9-21.
//  Copyright (c) 2020 Agora. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AgoraMediaFilterEventDelegate <NSObject>
@optional
/* Meida filter(audio filter or video filter) event callback
 */
- (void)onEvent:(NSString * __nullable)provider
      extension:(NSString * __nullable)extension
            key:(NSString * __nullable)key
          value:(NSString * __nullable)value;

- (void)onExtensionStopped:(NSString * __nullable)provider
                 extension:(NSString * __nullable)extension;

- (void)onExtensionStarted:(NSString * __nullable)provider
                 extension:(NSString * __nullable)extension;

- (void)onExtensionErrored:(NSString * __nullable)provider
                 extension:(NSString * __nullable)extension
                     error:(int)error
                   message:(NSString * __nullable)message;
@end
