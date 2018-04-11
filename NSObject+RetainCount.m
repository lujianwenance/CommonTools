//
//  NSObject+RetainCount.m
//  NavigationBar_OC
//
//  Created by lujianwen on 11/04/2018.
//  Copyright © 2018 LU. All rights reserved.
//

#import "NSObject+RetainCount.h"

@implementation NSObject (RetainCount)

- (void)objc_retainCount {
    NSLog(@"retain  count = %ld\n",CFGetRetainCount((__bridge  CFTypeRef)(self)));
}

@end
