//
//  UIScrollView+CloseKeyboard.m
//  youche
//
//  Created by 马 瑞鹏 on 14-7-25.
//  Copyright (c) 2014年 YintaiYouChe. All rights reserved.
//

#import "UIScrollView+CloseKeyboard.h"

@implementation UIScrollView (CloseKeyboard)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}
@end
