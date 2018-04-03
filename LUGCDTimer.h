//
//  LUGCDTimer.h
//  NavigationBar_OC
//
//  Created by lujianwen on 07/03/2018.
//  Copyright © 2018 LU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LUGCDTimer : NSObject

+ (instancetype)startTimerWithTimeInterval:(NSTimeInterval)interval timeout:(NSTimeInterval)timeout eventBlock:(void (^)(void))eventBlock endBlock:(void (^)(void))endBlock;

+ (instancetype)startTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats eventBlock:(void (^)(void))eventBlock;

- (void)invalidate;

@end
