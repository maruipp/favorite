//
//  FEItem.m
//  Favorite
//
//  Created by 马 瑞鹏 on 14/11/26.
//  Copyright (c) 2014年 FourEye Mobile. All rights reserved.
//

#import "FEItem.h"

@implementation FEItem
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}
//+ (NSDictionary *)JSONKeyPathsByPropertyKey
//{
//    return @{};
//    return @{
//             @"artistViewUrl":@"artistViewUrl",
//             @"":@"",
//             @"":@"",
//             @"":@"",
//             @"":@"",
//             @"":@"",
//             @"":@"",
//             @"":@"",
//             @"":@"",
//             };
//}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[FEItem class]]) {
        return NO;
    }
    
    FEItem *aItem = object;
    if (![_trackId isKindOfClass:[NSNumber class]] || ![aItem.trackId isKindOfClass:[NSNumber class]]) {
        return NO;
    }
    
    return [self.trackId isEqualToNumber:aItem.trackId];
}
@end
