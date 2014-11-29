//
//  FEItem.h
//  Favorite
//
//  Created by 马 瑞鹏 on 14/11/26.
//  Copyright (c) 2014年 FourEye Mobile. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface FEItem : MTLModel<MTLJSONSerializing>
@property (nonatomic,copy) NSString *artworkUrl60;//缩略图
@property (nonatomic,copy) NSString *version;
@property (nonatomic,copy) NSString *trackName;//app name
@property (nonatomic,copy) NSString *fileSizeBytes;//size
@property (nonatomic,copy) NSString *trackViewUrl;//商店url
@property (nonatomic,copy) NSNumber *trackId;//id

@end
