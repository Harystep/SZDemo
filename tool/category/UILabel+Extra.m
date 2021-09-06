//
//  UILabel+Extra.m
//  CashierChoke
//
//  Created by warmStep on 2020/8/11.
//  Copyright © 2020 zjs. All rights reserved.
//

#import "UILabel+Extra.h"

@implementation UILabel (Extra)

- (void)setLabelTextColor:(UIColor *)color text:(NSString *)text withFont:(CGFloat)font {
    self.font = AUTO_SYSTEM_FONT_SIZE(font);
    self.textColor = color;
    if (text != nil) {
        self.text = text;
    }
}

@end
