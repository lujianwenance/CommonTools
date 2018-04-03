//
//  LUblockExecutor.h
//  NavigationBar_OC
//
//  Created by lujianwen on 14/03/2018.
//  Copyright © 2018 LU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LUBlockExecutor : NSObject

- (id)initWithBlock:(dispatch_block_t)block;

@end


@interface NSObject (LURunAtDealloc)

- (void)lu_runAtDealloc:(dispatch_block_t)block;

@end


