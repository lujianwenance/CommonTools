//
//  LUUtilities.h
//  NavigationBar_OC
//
//  Created by lujianwen on 07/03/2018.
//  Copyright © 2018 LU. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LU_DEBUG(string, ...)   printf("\n func: %s\n line: %d\n file: %s\n\n---- ADDITIONAL ----\n%s\n\n",\
__func__, __LINE__, __FILE__, [[NSString stringWithFormat:(string), ##__VA_ARGS__] UTF8String])
#define LU_ERROR(error)         LU_DEBUG(@"%@", (error)?:@"nil")



@interface LUUtilities : NSObject

+ (id)stringOrNilOfData:(id)data;
+ (id)arrayOrNilOfData:(id)data;
+ (id)dictionaryOrNilOfData:(id)data;
+ (id)numberOrNilOfData:(id)data;

@end



@interface NSMutableArray (Extensions)

/**
 @param dictionary 包含数据的字典
 @param key 从字典中取数据对应的键
 @param initBlock 如果对取出的值有特殊处理，在这个处理后返回
 */
- (void)addObjectsFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key withInitBlock:(id(^)(id obj, NSUInteger idx, BOOL *stop))initBlock;
- (void)addObjectsFromArray:(NSArray *)otherArray withInitBlock:(id(^)(id obj, NSUInteger idx, BOOL *stop))initBlock;

@end
