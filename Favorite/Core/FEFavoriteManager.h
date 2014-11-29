//
//  FEFavoriteManager.h
//  Favorite
//
//  Created by 马 瑞鹏 on 14/11/29.
//  Copyright (c) 2014年 FourEye Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FEFavoriteManager : NSObject
@property (nonatomic,strong,readonly) NSMutableArray *items;
+ (instancetype)sharedManager;

- (void)push:(id)anItem;
- (void)pop:(id)anItem;

- (NSString *)filePath;

- (void)saveToDisk;
- (NSArray *)itemsInDisk;
@end
