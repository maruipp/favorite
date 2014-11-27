//
//  SearchTableViewCell.h
//  Favorite
//
//  Created by 马 瑞鹏 on 14/11/26.
//  Copyright (c) 2014年 FourEye Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEItem.h"
@interface SearchTableViewCell : UITableViewCell
//- (void)fillData:(FEItem *)item;
@property (strong, nonatomic) IBOutlet UIButton *appButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *versionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *appIconMask;
- (void)changeMaskToGray:(BOOL)toChange;
@end
