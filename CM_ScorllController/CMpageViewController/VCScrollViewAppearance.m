//
//  VCScrollViewAppearance.m
//  CM_ScorllController
//
//  Created by shawn on 2017/5/19.
//  Copyright © 2017年 shawn. All rights reserved.
//

#import "VCScrollViewAppearance.h"

@implementation VCScrollViewAppearance



//设定默认值
- (NSInteger)titleAppearCount{
    if (_titleAppearCount <= 0) {
        _titleAppearCount = 4;
    }
    return _titleAppearCount;
}


- (float)titleHeight{
    if (_titleHeight <= 0) {
        _titleHeight = 40;
    }
    return _titleHeight;
}

- (UIColor *)buttonBackgroundColor{
    if (!_buttonBackgroundColor) {
    return [UIColor whiteColor];
    }
    return _buttonBackgroundColor;
}



@end
