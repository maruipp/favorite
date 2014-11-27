//
//  SearchTableViewCell.m
//  Favorite
//
//  Created by 马 瑞鹏 on 14/11/26.
//  Copyright (c) 2014年 FourEye Mobile. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)changeMaskToGray:(BOOL)toChange
{
    if (toChange) {
        [_appIconMask setImage:[UIImage imageNamed:@"app_icon_mask_gray"]];
    }else{
        [_appIconMask setImage:[UIImage imageNamed:@"app_icon_mask_white"]];
    }
}

@end
