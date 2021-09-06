//
//  UIImageView+Extra.h
//  CashierChoke
//
//  Created by zjs on 2019/12/2.
//  Copyright © 2019 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Extra)

- (void)dn_waterMarkNet:(NSString *)url mark:(NSString *)mark textFont:(CGFloat)textFont textColor:(UIColor *)textColor;
@end

NS_ASSUME_NONNULL_END
