//
//  FEUtil.h
//  Favorite
//
//  Created by 马 瑞鹏 on 14/11/30.
//  Copyright (c) 2014年 FourEye Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FEUtil : NSObject
/**
 关闭键盘
 */
+ (void)closeKeyboard;

/**
 拨打电话
 */
+ (void)callTelphone:(NSString *)phone;

+ (UIImage *)schechImage:(NSString *)imgName;

+ (void)vibrate;
+ (void)playSound;

@end
