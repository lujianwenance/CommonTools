//
//  LUblockExecutor.m
//  NavigationBar_OC
//
//  Created by lujianwen on 14/03/2018.
//  Copyright © 2018 LU. All rights reserved.
//

#import "LUBlockExecutor.h"
#import <objc/runtime.h>

const void *runAtDeallocBlockKey = &runAtDeallocBlockKey;

@implementation LUBlockExecutor {
    dispatch_block_t _block;
}

- (id)initWithBlock:(dispatch_block_t)block {
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)dealloc {
    _block ? _block() : nil;
}
@end



@implementation NSObject (LURunAtDealloc)

- (void)lu_runAtDealloc:(dispatch_block_t)block {
    if (block) {
        LUBlockExecutor *executor = [[LUBlockExecutor alloc] initWithBlock:block
                                     ];
        objc_setAssociatedObject(self, runAtDeallocBlockKey, executor, OBJC_ASSOCIATION_RETAIN);
    }
}

@end
