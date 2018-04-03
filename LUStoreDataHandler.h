//
//  LUStoreDataHandler.h
//  NavigationBar_OC
//
//  Created by lujianwen on 03/04/2018.
//  Copyright © 2018 LU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LUStoreDataHandler : NSObject

+(NSOperationQueue*)sharedInstanceQueue;

+ (void)asyncArchiveObject:(id)obj toPath:(NSString *)path completion:(void (^)(BOOL))completion;
+ (BOOL)syncArchiveObject:(id)obj toPath:(NSString *)path;
+ (id)syncUnarchiveObjectAtPath:(NSString *)path;
+ (void)asyncUnarchiveObjectAtPath:(NSString *)path withCompletion:(void (^)(id))completion;

@end
