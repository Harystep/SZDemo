//
//  UIImageView+Extra.m
//  CashierChoke
//
//  Created by zjs on 2019/12/2.
//  Copyright © 2019 zjs. All rights reserved.
//

#import "UIImageView+Extra.h"

@implementation UIImageView (Extra)

- (void)dn_waterMarkNet:(NSString *)url mark:(NSString *)mark textFont:(CGFloat)textFont textColor:(UIColor *)textColor {
    
    NSData  *data  = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [UIImage sd_imageWithData:data];
    
    UIGraphicsBeginImageContextWithOptions(self.dn_size, NO, 0.0);
    //绘制目标图片
    [self drawRect:CGRectMake(0, 0, self.dn_size.width, self.dn_size.height)];
    //绘制水印图片
    [image drawInRect:CGRectMake(0, 0, self.dn_size.width, self.dn_size.height)];

    //设置字体、字体颜色
    NSDictionary *attr = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:textFont],
                           NSForegroundColorAttributeName : textColor
    };
    //绘制水印文字
    [mark drawInRect:CGRectMake(0, 0, self.dn_size.width, self.dn_size.height) withAttributes:attr];
    //获取绘制后的图片
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图片上下文
    UIGraphicsEndPDFContext();
}
@end
