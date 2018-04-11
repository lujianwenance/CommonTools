//
//  LUWeakTimer.m
//  NavigationBar_OC
//
//  Created by lujianwen on 10/04/2018.
//  Copyright © 2018 LU. All rights reserved.
//

#import "LUWeakTimer.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation LUWeakTimer

- (void)fire:(NSTimer *)timer {
    if (self.target) {
        [self.target performSelector:self.selector withObject:timer.userInfo];
    } else {
        [self.timer invalidate];
    }
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                     target:(nonnull id)aTarget
                                   selector:(nonnull SEL)aSelector
                                   userInfo:(nullable id)userInfo
                                    repeats:(BOOL)repeats {
    LUWeakTimer *weakTimer = [[LUWeakTimer alloc] init];
    weakTimer.target = aTarget;
    weakTimer.selector = aSelector;
    weakTimer.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                       target:weakTimer
                                                     selector:@selector(fire:)
                                                     userInfo:userInfo
                                                      repeats:repeats];
    return weakTimer.timer;
}

@end
