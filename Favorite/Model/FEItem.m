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
    FEItem *aItem = object;
    return [self.trackId isEqualToString:aItem.trackId];
}
@end
