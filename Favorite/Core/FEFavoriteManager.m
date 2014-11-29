//
//  FEFavoriteManager.m
//  Favorite
//
//  Created by 马 瑞鹏 on 14/11/29.
//  Copyright (c) 2014年 FourEye Mobile. All rights reserved.
//

#import "FEFavoriteManager.h"
#import "FEItem.h"
#import <UIKit/UIKit.h>
#define kFavoriteStoreFileName @"kFavoriteStoreFile"
@implementation FEFavoriteManager
@synthesize items = _items;

+ (instancetype)sharedManager {
    static FEFavoriteManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[FEFavoriteManager alloc] init];
    });
    
    return _sharedManager;
}

- (id)init
{
    if (self = [super init]) {
        _items = [[self itemsInDisk] mutableCopy];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveToDisk) name:UIApplicationWillTerminateNotification object:nil];
    }
    return self;
}
#pragma mark - manage
- (void)push:(id)anItem
{
    
    if (!anItem) {
        return;
    }
    
//    NSAssert([anItem isKindOfClass:[FEItem class]], @"anObject shoud be FEItem class");
    
    [self.items addObject:anItem];
}

- (void)pop:(id)anItem
{
    
    if (!anItem) {
        return;
    }
    
//    NSAssert([anItem isKindOfClass:[FEItem class]], @"anObject shoud be FEItem class");
    
    [self.items removeObject:anItem];
}

#pragma mark - save
- (void)saveToDisk
{
//    [self.items writeToFile:[self filePath] atomically:YES];
    [NSKeyedArchiver archiveRootObject:self.items toFile:[self filePath]];
}
- (NSArray *)itemsInDisk
{
    NSArray *result = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    return result;
}
- (NSString *)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths firstObject];
    path = [path stringByAppendingPathComponent:kFavoriteStoreFileName];
    return path;
}
#pragma mark - lazy init
- (NSMutableArray *)items
{
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}
@end
