//
//  LuKeyChain.h
//  NavigationBar_OC
//
//  Created by lujianwen on 01/03/2018.
//  Copyright © 2018 LU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LuKeyChain : NSObject

+ (BOOL)save:(NSString*)key data:(id)data;
+ (id)load:(NSString*)key;
+ (void)remove:(NSString*)key;

@end
