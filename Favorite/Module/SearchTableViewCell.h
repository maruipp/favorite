//
//  SearchTableViewCell.h
//  Favorite
//
//  Created by 马 瑞鹏 on 14/11/26.
//  Copyright (c) 2014年 FourEye Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEItem.h"
typedef void (^FavoriteTappedBlock)();
@interface SearchTableViewCell : UITableViewCell
//- (void)fillData:(FEItem *)item;
@property (strong, nonatomic) IBOutlet UIButton *appButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *versionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *appIconMask;
@property (nonatomic,assign) BOOL isFavorite;
@property (nonatomic,copy) FavoriteTappedBlock favoriteBlock;
//- (void)favoriteBtnTapped:(NSIndexPath *)indexPath;
- (void)changeMaskToGray:(BOOL)toChange;
@end
