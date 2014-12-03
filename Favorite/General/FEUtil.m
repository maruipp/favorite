//
//  FEUtil.m
//  Favorite
//
//  Created by 马 瑞鹏 on 14/11/30.
//  Copyright (c) 2014年 FourEye Mobile. All rights reserved.
//

#import "FEUtil.h"
#import <AudioToolbox/AudioToolbox.h>
@implementation FEUtil
+ (void)closeKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

+ (void)callTelphone:(NSString *)phone
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
    [[UIApplication sharedApplication] openURL:url];
}

+ (UIImage *)schechImage:(NSString *)imgName
{
    UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
    UIImage *selectImage = [UIImage imageNamed:imgName];
    UIImage *stretchableImage = [selectImage resizableImageWithCapInsets:insets];
    return stretchableImage;
}

+ (void)vibrate
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
+ (void)playSound
{
    SystemSoundID myAlertSound;
    NSURL *url = [NSURL URLWithString:@"/System/Library/Audio/UISounds/ReceivedMessage.caf"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &myAlertSound);
    AudioServicesPlaySystemSound(myAlertSound);
}

@end
