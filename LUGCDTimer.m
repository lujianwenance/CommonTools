//
//  LUGCDTimer.m
//  NavigationBar_OC
//
//  Created by lujianwen on 07/03/2018.
//  Copyright © 2018 LU. All rights reserved.
//

#import "LUGCDTimer.h"

@interface LUGCDTimer ()

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation LUGCDTimer

+ (instancetype)startTimerWithTimeInterval:(NSTimeInterval)interval timeout:(NSTimeInterval)timeout eventBlock:(void (^)(void))eventBlock endBlock:(void (^)(void))endBlock {
   return [self createTimerWithTimeInterval:interval timeout:timeout repeats:NO handleRepeatsBlock:nil eventBlock:eventBlock endBlock:endBlock];
}

+ (instancetype)startTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats eventBlock:(void (^)(void))eventBlock {
    
    void (^block)(dispatch_source_t timer) = ^ (dispatch_source_t timer) {
        if (repeats == YES) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (eventBlock) {
                    eventBlock();
                }
            });
        } else {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (eventBlock) {
                    eventBlock();
                }
            });
        }
    };
    
  return [self createTimerWithTimeInterval:interval timeout:DISPATCH_TIME_FOREVER repeats:repeats handleRepeatsBlock:block eventBlock:eventBlock endBlock:nil];
}

+ (instancetype)createTimerWithTimeInterval:(NSTimeInterval)interval timeout:(NSTimeInterval)timeout repeats:(BOOL)repeats handleRepeatsBlock:(void (^)(dispatch_source_t timer))handleRepeatsBlock eventBlock:(void (^)(void))eventBlock endBlock:(void (^)(void))endBlock {
    
    __block NSTimeInterval tempTimeout = timeout;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    LUGCDTimer *timer = [[self alloc] init];
    timer.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer.timer, interval * NSEC_PER_SEC, interval * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer.timer, ^{
        if (timeout == DISPATCH_TIME_FOREVER) {
            if (handleRepeatsBlock) {
                handleRepeatsBlock(timer.timer);
            }
            return;
        }
        
        if (tempTimeout <= 0) {
            dispatch_source_cancel(timer.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (endBlock) {
                    endBlock();
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (eventBlock) {
                    eventBlock();
                }
            });
            
            tempTimeout -= interval;
        }
    });
    dispatch_resume(timer.timer);
    
    return timer;
}

- (void)invalidate {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

- (void)dealloc {
    [self invalidate];
}

@end
