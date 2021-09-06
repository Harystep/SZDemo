//
//  UIImage+Extra.h
//  CashierChoke
//
//  Created by zjs on 2019/12/2.
//  Copyright © 2019 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extra)

- (UIImage *)dn_mosaicImage;

+ (instancetype)stretchableImageWithLocalName:(NSString *)imageName;


@end

NS_ASSUME_NONNULL_END
