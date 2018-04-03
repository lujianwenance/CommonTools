//
//  LuKeyChain.m
//  NavigationBar_OC
//
//  Created by lujianwen on 01/03/2018.
//  Copyright © 2018 LU. All rights reserved.
//

#import "LuKeyChain.h"

@implementation LuKeyChain

+ (NSMutableDictionary*)getKeychainQuery: (NSString*)key {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword, (id)kSecClass,
            key, (id)kSecAttrService,
            key, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock, (id)kSecAttrAccessible,
            nil];
}

+ (BOOL)save:(NSString*)key data:(id)data {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    SecItemDelete((CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    return SecItemAdd((CFDictionaryRef)keychainQuery, NULL) == noErr;
}

+ (id)load:(NSString*)key {
    id ret = NULL;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    NSData *keyData = NULL;
    if(SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef*)(void*)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:keyData];
        }
        @catch (NSException *exception) {
            NSLog(@"Unarchive of %@ failed: %@", key, exception);
        }
        @finally {
        }
    }
    return ret;
}

+ (void)remove:(NSString *)key {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}
@end
