//
//  LUStoreDataHandler.m
//  NavigationBar_OC
//
//  Created by lujianwen on 03/04/2018.
//  Copyright © 2018 LU. All rights reserved.
//

#import "LUStoreDataHandler.h"

@implementation LUStoreDataHandler

+(NSOperationQueue*)sharedInstanceQueue {
    static NSOperationQueue *_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _queue = [[NSOperationQueue alloc]init];
        [_queue setMaxConcurrentOperationCount:15];
    });
    return _queue;
}

+ (void)asyncArchiveObject:(id)obj toPath:(NSString *)path completion:(void (^)(BOOL))completion {
    if (obj == nil || path.length == 0) {
        return;
    }
    NSBlockOperation *archiveOperation = [NSBlockOperation blockOperationWithBlock:^{
        BOOL succeed = [self syncArchiveObject:obj toPath:path];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(succeed);
            });
        }
    }];
    [[self sharedInstanceQueue] addOperation:archiveOperation];
}

+ (BOOL)syncArchiveObject:(id)obj toPath:(NSString *)path {
    id beArchivedObject = nil;
    
    if ([obj respondsToSelector:@selector(copyWithZone:)]) {
        beArchivedObject = [obj copy];
    } else {
        beArchivedObject = obj;
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:beArchivedObject];
    NSError *error = nil;
    [data writeToFile:path options:NSDataWritingAtomic error:&error];
    
    if (error) {
        NSLog(@"archived %@ to file %@, error: %@", [obj class], path, error);
        return NO;
    }
    
    return YES;
}

+ (id)syncUnarchiveObjectAtPath:(NSString *)path {
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        return nil;
    }
    
    id object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return object;
}

+ (void)asyncUnarchiveObjectAtPath:(NSString *)path withCompletion:(void (^)(id))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id object = [self syncUnarchiveObjectAtPath:path];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(object);
            });
        }
    });
}
@end
