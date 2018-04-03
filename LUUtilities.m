//
//  LUUtilities.m
//  NavigationBar_OC
//
//  Created by lujianwen on 07/03/2018.
//  Copyright © 2018 LU. All rights reserved.
//

#import "LUUtilities.h"



@implementation LUUtilities

+ (id)stringOrNilOfData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@", data];
    }
    if ([data isKindOfClass:[NSString class]]) {
        return data;
    }
    return nil;
}

+ (id)arrayOrNilOfData:(id)data {
    if ([data isKindOfClass:[NSArray class]]) {
        return data;
    }
    return nil;
}

+ (id)dictionaryOrNilOfData:(id)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        return data;
    }
    return nil;
}

+ (id)numberOrNilOfData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        return data;
    }
    return nil;
}
@end

@implementation NSMutableArray (Extensions)

- (void)addObjectsFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key withInitBlock:(id (^)(id, NSUInteger, BOOL *))initBlock {
    if (![key isKindOfClass:[NSString class]]) {
        key = @"";
    }
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        dictionary = nil;
    }
    
    NSArray *values = [LUUtilities arrayOrNilOfData:dictionary[key]];
    if (values) {
        NSMutableArray *objects = [NSMutableArray array];
        
        [values enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            id object = obj;
            
            if (initBlock) {
                object = initBlock(obj, idx, stop);
            }
            
            if (object) {
                [objects addObject:object];
            }
        }];
        
        [self addObjectsFromArray:objects];
    }
}

- (void)addObjectsFromArray:(NSArray *)otherArray withInitBlock:(id (^)(id, NSUInteger, BOOL *))initBlock {
    otherArray = [LUUtilities arrayOrNilOfData:otherArray];
    if (otherArray) {
        NSMutableArray *objects = [NSMutableArray array];
        
        [otherArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            id object = obj;
            
            if (initBlock) {
                object = initBlock(obj, idx, stop);
            }
            
            if (object) {
                [objects addObject:object];
            }
        }];
        
        [self addObjectsFromArray:objects];
    }
}

@end
